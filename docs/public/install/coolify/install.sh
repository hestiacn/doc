#!/bin/bash
## Do not modify this file. You will lose the ability to install and auto-update!

set -e # Exit immediately if a command exits with a non-zero status
## $1 could be empty, so we need to disable this check
#set -u # Treat unset variables as an error and exit
set -o pipefail # Cause a pipeline to return the status of the last command that exited with a non-zero status
CDN="https://cdn.coollabs.io/coolify"
DATE=$(date +"%Y%m%d-%H%M%S")

VERSION="1.6"
DOCKER_VERSION="27.0"
# TODO: Ask for a user
CURRENT_USER=$USER

if [ $EUID != 0 ]; then
    echo "请以 root 身份或使用 sudo 运行此脚本"
    exit
fi

TOTAL_SPACE=$(df -BG / | awk 'NR==2 {print $2}' | sed 's/G//')
AVAILABLE_SPACE=$(df -BG / | awk 'NR==2 {print $4}' | sed 's/G//')
REQUIRED_TOTAL_SPACE=30
REQUIRED_AVAILABLE_SPACE=20
WARNING_SPACE=false

if [ "$TOTAL_SPACE" -lt "$REQUIRED_TOTAL_SPACE" ]; then
    WARNING_SPACE=true
    cat << 'EOF'
WARNING: Insufficient total disk space!

Total disk space:     ${TOTAL_SPACE}GB
Required disk space:  ${REQUIRED_TOTAL_SPACE}GB

==================
EOF
fi

if [ "$AVAILABLE_SPACE" -lt "$REQUIRED_AVAILABLE_SPACE" ]; then
    cat << 'EOF'
WARNING: Insufficient available disk space!

Available disk space:   ${AVAILABLE_SPACE}GB
Required available space: ${REQUIRED_AVAILABLE_SPACE}GB

==================
EOF
    WARNING_SPACE=true
fi

if [ "$WARNING_SPACE" = true ]; then
    echo "休息5分钟."
    sleep 5
fi

mkdir -p /data/coolify/{source,ssh,applications,databases,backups,services,proxy,webhooks-during-maintenance,sentinel}
mkdir -p /data/coolify/ssh/{keys,mux}
mkdir -p /data/coolify/proxy/dynamic

chown -R 9999:root /data/coolify
chmod -R 700 /data/coolify

INSTALLATION_LOG_WITH_DATE="/data/coolify/source/installation-${DATE}.log"

exec > >(tee -a $INSTALLATION_LOG_WITH_DATE) 2>&1

getAJoke() {
    JOKES=$(curl -s --max-time 2 "https://v2.jokeapi.dev/joke/Programming?blacklistFlags=nsfw,religious,political,racist,sexist,explicit&format=txt&type=single" || true)
    if [ "$JOKES" != "" ]; then
        echo -e " - 在安装完之前，这里有一个笑话要给你:\n"
        echo -e "$JOKES\n"
        echo -e " - 请稍后！正在安装Docker程序:\n"
    fi
}
OS_TYPE=$(grep -w "ID" /etc/os-release | cut -d "=" -f 2 | tr -d '"')
ENV_FILE="/data/coolify/source/.env"

# Check if the OS is manjaro, if so, change it to arch
if [ "$OS_TYPE" = "manjaro" ] || [ "$OS_TYPE" = "manjaro-arm" ]; then
    OS_TYPE="arch"
fi

# Check if the OS is Asahi Linux, if so, change it to fedora
if [ "$OS_TYPE" = "fedora-asahi-remix" ]; then
    OS_TYPE="fedora"
fi

# Check if the OS is popOS, if so, change it to ubuntu
if [ "$OS_TYPE" = "pop" ]; then
    OS_TYPE="ubuntu"
fi

# Check if the OS is linuxmint, if so, change it to ubuntu
if [ "$OS_TYPE" = "linuxmint" ]; then
    OS_TYPE="ubuntu"
fi

#Check if the OS is zorin, if so, change it to ubuntu
if [ "$OS_TYPE" = "zorin" ]; then
    OS_TYPE="ubuntu"
fi

if [ "$OS_TYPE" = "arch" ] || [ "$OS_TYPE" = "archarm" ]; then
    OS_VERSION="rolling"
else
    OS_VERSION=$(grep -w "VERSION_ID" /etc/os-release | cut -d "=" -f 2 | tr -d '"')
fi

# Install xargs on Amazon Linux 2023 - lol
if [ "$OS_TYPE" = 'amzn' ]; then
    dnf install -y findutils >/dev/null
fi

LATEST_VERSION=$(curl --silent $CDN/versions.json | grep -i version | xargs | awk '{print $2}' | tr -d ',')
LATEST_HELPER_VERSION=$(curl --silent $CDN/versions.json | grep -i version | xargs | awk '{print $6}' | tr -d ',')
LATEST_REALTIME_VERSION=$(curl --silent $CDN/versions.json | grep -i version | xargs | awk '{print $8}' | tr -d ',')

if [ -z "$LATEST_HELPER_VERSION" ]; then
    LATEST_HELPER_VERSION=latest
fi

if [ -z "$LATEST_REALTIME_VERSION" ]; then
    LATEST_REALTIME_VERSION=latest
fi


case "$OS_TYPE" in
arch | ubuntu | debian | raspbian | centos | fedora | rhel | ol | rocky | sles | opensuse-leap | opensuse-tumbleweed | almalinux | amzn | alpine) ;;
*)
    echo "此脚本目前仅支持基于 Debian、Redhat、Arch Linux、Alpine Linux 或 SLES 的操作系统."
    exit
    ;;
esac

# Overwrite LATEST_VERSION if user pass a version number
if [ "$1" != "" ]; then
    LATEST_VERSION=$1
    LATEST_VERSION="${LATEST_VERSION,,}"
    LATEST_VERSION="${LATEST_VERSION#v}"
fi



echo -e "---------------------------------------------"
echo -e "欢迎使用 Coolify 安装程序!"
echo -e "这个脚本会帮你安装所有相关程序.坐下来放松一下."
echo -e "源代码: https://github.com/coollabsio/coolify/blob/main/scripts/install.sh\n"

echo -e "\033[0;35m
   ____                   _   _    __         
  / ___|   ___     ___   | | (_)  / _|  _   _ 
 | |      / _ \   / _ \  | | | | | |_  | | | |
 | |___  | (_) | | (_) | | | | | |  _| | |_| |
  \____|  \___/   \___/  |_| |_| |_|    \__, |
                                        |___/ 
\033[0m"
echo "| 操作系统          | $OS_TYPE $OS_VERSION"
echo "| Docker            | $DOCKER_VERSION"
echo "| Coolify           | $LATEST_VERSION"
echo "| Helper            | $LATEST_HELPER_VERSION"
echo "| Realtime          | $LATEST_REALTIME_VERSION"
echo -e "---------------------------------------------\n"
echo -e "1.安装所需的软件包 (curl, wget, git, jq, openssl). "

case "$OS_TYPE" in
arch)
    pacman -Sy --noconfirm --needed curl wget git jq openssl >/dev/null || true
    ;;
alpine)
    sed -i '/^#.*\/community/s/^#//' /etc/apk/repositories
    apk update >/dev/null
    apk add curl wget git jq openssl >/dev/null
    ;;
ubuntu | debian | raspbian)
    apt-get update -y >/dev/null
    apt-get install -y curl wget git jq openssl >/dev/null
    ;;
centos | fedora | rhel | ol | rocky | almalinux | amzn)
    if [ "$OS_TYPE" = "amzn" ]; then
        dnf install -y wget git jq openssl >/dev/null
    else
        if ! command -v dnf >/dev/null; then
            yum install -y dnf >/dev/null
        fi
        if ! command -v curl >/dev/null; then
            dnf install -y curl >/dev/null
        fi
        dnf install -y wget git jq openssl >/dev/null
    fi
    ;;
sles | opensuse-leap | opensuse-tumbleweed)
    zypper refresh >/dev/null
    zypper install -y curl wget git jq openssl >/dev/null
    ;;
*)
    echo "此脚本目前仅支持基于 Debian、Redhat、Arch Linux 或 SLES 的操作系统."
    exit
    ;;
esac


echo -e "2. 检查 OpenSSH 服务器配置. "

# Detect OpenSSH server
SSH_DETECTED=false
if [ -x "$(command -v systemctl)" ]; then
    if systemctl status sshd >/dev/null 2>&1; then
        echo " - 已安装 OpenSSH 服务器."
        SSH_DETECTED=true
    elif systemctl status ssh >/dev/null 2>&1; then
        echo " - 已安装 OpenSSH 服务器."
        SSH_DETECTED=true
    fi
elif [ -x "$(command -v service)" ]; then
    if service sshd status >/dev/null 2>&1; then
        echo " - 已安装 OpenSSH 服务器."
        SSH_DETECTED=true
    elif service ssh status >/dev/null 2>&1; then
        echo " - 已安装 OpenSSH 服务器."
        SSH_DETECTED=true
    fi
fi


if [ "$SSH_DETECTED" = "false" ]; then
    echo " - 未检测到 OpenSSH 服务器。安装 OpenSSH 服务器."
    case "$OS_TYPE" in
    arch)
        pacman -Sy --noconfirm openssh >/dev/null
        systemctl enable sshd >/dev/null 2>&1
        systemctl start sshd >/dev/null 2>&1
        ;;
    alpine)
        apk add openssh >/dev/null
        rc-update add sshd default >/dev/null 2>&1
        service sshd start >/dev/null 2>&1
        ;;
    ubuntu | debian | raspbian)
        apt-get update -y >/dev/null
        apt-get install -y openssh-server >/dev/null
        systemctl enable ssh >/dev/null 2>&1
        systemctl start ssh >/dev/null 2>&1
        ;;
    centos | fedora | rhel | ol | rocky | almalinux | amzn)
        if [ "$OS_TYPE" = "amzn" ]; then
            dnf install -y openssh-server >/dev/null
        else
            dnf install -y openssh-server >/dev/null
        fi
        systemctl enable sshd >/dev/null 2>&1
        systemctl start sshd >/dev/null 2>&1
        ;;
    sles | opensuse-leap | opensuse-tumbleweed)
        zypper install -y openssh >/dev/null
        systemctl enable sshd >/dev/null 2>&1
        systemctl start sshd >/dev/null 2>&1
        ;;
    *)
        echo "###############################################################################"
        echo "警告：无法检测和安装 OpenSSH 服务器 - 这并不意味着它未安装或未运行，只是我们无法检测到它."
        echo -e "请确保它已安装并正在运行，否则 Coolify 无法连接到主机系统。 \n"
        echo "###############################################################################"
        exit 1
        ;;
    esac
    echo " - OpenSSH 服务器安装成功."
    SSH_DETECTED=true
fi

# Detect SSH PermitRootLogin
SSH_PERMIT_ROOT_LOGIN=$(sshd -T | grep -i "permitrootlogin" | awk '{print $2}') || true
if [ "$SSH_PERMIT_ROOT_LOGIN" = "yes" ] || [ "$SSH_PERMIT_ROOT_LOGIN" = "without-password" ] || [ "$SSH_PERMIT_ROOT_LOGIN" = "prohibit-password" ]; then
    echo " - SSH PermitRootLogin 已启用."
else
    echo " - SSH PermitRootLogin 已禁用."
    echo "   如果您对 SSH 有问题，请阅读此内容: https://coolify.io/docs/knowledge-base/server/openssh"
fi

# Detect if docker is installed via snap
if [ -x "$(command -v snap)" ]; then
    SNAP_DOCKER_INSTALLED=$(snap list docker >/dev/null 2>&1 && echo "true" || echo "false")
    if [ "$SNAP_DOCKER_INSTALLED" = "true" ]; then
        echo " - Docker 是通过 snap 安装的."
        echo "   请注意，Coolify 不支持通过 snap 安装 Docker."
        echo "   请使用 snap 删除 Docker （snap remove docker） 并重新执行此脚本."
        exit 1
    fi
fi

echo -e "3. 检查 Docker 安装. "
if ! [ -x "$(command -v docker)" ]; then
    echo " - 未安装 Docker。安装 Docker。这可能需要一段时间."
    getAJoke
    case "$OS_TYPE" in
        "almalinux")
            dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo >/dev/null 2>&1
            dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin >/dev/null 2>&1
            if ! [ -x "$(command -v docker)" ]; then
                echo " - 无法自动安装 Docker。请访问 https://docs.docker.com/engine/install/ 并手动安装 Docker 以继续."
                exit 1
            fi
            systemctl start docker >/dev/null 2>&1
            systemctl enable docker >/dev/null 2>&1
            ;;
        "alpine")
            apk add docker docker-cli-compose >/dev/null 2>&1
            rc-update add docker default >/dev/null 2>&1
            service docker start >/dev/null 2>&1
            if ! [ -x "$(command -v docker)" ]; then
                echo " - 无法使用 apk 安装 Docker。尝试手动安装."
                echo "   请访问 https://wiki.alpinelinux.org/wiki/Docker 了解更多信息."
                exit 1
            fi
            ;;
        "arch")
            pacman -Sy docker docker-compose --noconfirm >/dev/null 2>&1
            systemctl enable docker.service >/dev/null 2>&1
            if ! [ -x "$(command -v docker)" ]; then
                echo " - 无法使用 pacman 安装 Docker。尝试手动安装."
                echo "   请访问 https://wiki.archlinux.org/title/docker 了解更多信息."
                exit 1
            fi
            ;;
        "amzn")
            dnf install docker -y >/dev/null 2>&1
            DOCKER_CONFIG=${DOCKER_CONFIG:-/usr/local/lib/docker}
            mkdir -p $DOCKER_CONFIG/cli-plugins >/dev/null 2>&1
            curl -sL https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o $DOCKER_CONFIG/cli-plugins/docker-compose >/dev/null 2>&1
            chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose >/dev/null 2>&1
            systemctl start docker >/dev/null 2>&1
            systemctl enable docker >/dev/null 2>&1
            if ! [ -x "$(command -v docker)" ]; then
                echo " - 无法使用 dnf 安装 Docker。尝试手动安装."
                echo "   请访问 https://www.cyberciti.biz/faq/how-to-install-docker-on-amazon-linux-2/ 了解更多信息."
                exit 1
            fi
            ;;
        "fedora")
            if [ -x "$(command -v dnf5)" ]; then
                # dnf5 is available
                dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo --overwrite >/dev/null 2>&1
            else
                # dnf5 is not available, use dnf
                dnf config-manager --add-repo=https://download.docker.com/linux/fedora/docker-ce.repo >/dev/null 2>&1
            fi
            dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin >/dev/null 2>&1
            if ! [ -x "$(command -v docker)" ]; then
                echo " - 无法自动安装 Docker。请访问 https://docs.docker.com/engine/install/ 并手动安装 Docker 以继续."
                exit 1
            fi
            systemctl start docker >/dev/null 2>&1
            systemctl enable docker >/dev/null 2>&1
            ;;
        *)
            if [ "$OS_TYPE" = "ubuntu" ] && [ "$OS_VERSION" = "24.10" ]; then
                echo "Ubuntu 24.10（非 LTS 版本）不支持 Docker 自动安装."
                    echo "请手动安装 Docker."
                exit 1
            fi
            curl -s https://hestiamb.org/install/coolify/${DOCKER_VERSION}.sh | sh 2>&1
            if ! [ -x "$(command -v docker)" ]; then
                curl -s https://get.docker.com | sh -s -- --version ${DOCKER_VERSION} 2>&1
                if ! [ -x "$(command -v docker)" ]; then
                    echo " - Docker 安装失败."
                    echo "   也许您的操作系统不受支持?"
                    echo " - 请访问 https://docs.docker.com/engine/install/ 并手动安装 Docker 以继续."
                    exit 1
                fi
            fi
    esac
    echo " - Docker 安装成功."
else
    echo " - 已安装 Docker."
fi

echo -e "4. 检查 Docker 配置. "
mkdir -p /etc/docker
# shellcheck disable=SC2015
test -s /etc/docker/daemon.json && cp /etc/docker/daemon.json /etc/docker/daemon.json.original-"$DATE" || cat >/etc/docker/daemon.json <<EOL
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  },
  "default-address-pools": [
    {"base":"10.0.0.0/8","size":24}
  ]
}
EOL
cat >/etc/docker/daemon.json.coolify <<EOL
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  },
  "default-address-pools": [
    {"base":"10.0.0.0/8","size":24}
  ]
}
EOL
TEMP_FILE=$(mktemp)
if ! jq -s '.[0] * .[1]' /etc/docker/daemon.json /etc/docker/daemon.json.coolify >"$TEMP_FILE"; then
    echo "合并 JSON 文件时出错"
    exit 1
fi
mv "$TEMP_FILE" /etc/docker/daemon.json

restart_docker_service() {
    # Check if systemctl is available
    if command -v systemctl >/dev/null 2>&1; then
        echo " - 使用 systemctl 重启 Docker."
        systemctl restart docker

        if [ $? -eq 0 ]; then
            echo " - Docker 使用 systemctl 成功重启."
        else
            echo " - 无法使用 systemctl 重新启动 Docker."
            return 1
        fi

    # Check if service command is available
    elif command -v service >/dev/null 2>&1; then
        echo " - 使用 service 命令重启 Docker."
        service docker restart

        if [ $? -eq 0 ]; then
            echo " - Docker 使用 service 成功重启."
        else
            echo " - 无法使用 Service 重新启动 Docker."
            return 1
        fi

    # If neither systemctl nor service is available
    else
        echo " - systemctl 和 service command 在此系统上均不可用."
        return 1
    fi
}

if [ -s /etc/docker/daemon.json.original-"$DATE" ]; then
    DIFF=$(diff <(jq --sort-keys . /etc/docker/daemon.json) <(jq --sort-keys . /etc/docker/daemon.json.original-"$DATE"))
    if [ "$DIFF" != "" ]; then
        echo " - Docker 配置已更新，请重新启动 docker 守护程序..."
        restart_docker_service
    else
        echo " - Docker 配置是最新的."
    fi
else
    echo " - Docker 配置已更新，请重新启动 docker 守护程序..."
    restart_docker_service
fi

echo -e "5. 从 CDN 下载所需文件. "
curl -fsSL $CDN/docker-compose.yml -o /data/coolify/source/docker-compose.yml
curl -fsSL $CDN/docker-compose.prod.yml -o /data/coolify/source/docker-compose.prod.yml
curl -fsSL $CDN/.env.production -o /data/coolify/source/.env.production
curl -fsSL $CDN/upgrade.sh -o /data/coolify/source/upgrade.sh

echo -e "6. 将 .env 备份到 .env-$DATE"

# Copy .env.example if .env does not exist
if [ -f $ENV_FILE ]; then
    cp $ENV_FILE $ENV_FILE-$DATE
else
    echo " - .env文件不存在: $ENV_FILE"
    echo " - 将 .env.production 复制到 .env-$DATE"
    cp /data/coolify/source/.env.production $ENV_FILE-$DATE
    # Generate a secure APP_ID and APP_KEY
    sed -i "s|^APP_ID=.*|APP_ID=$(openssl rand -hex 16)|" "$ENV_FILE-$DATE"
    sed -i "s|^APP_KEY=.*|APP_KEY=base64:$(openssl rand -base64 32)|" "$ENV_FILE-$DATE"

    # Generate a secure Postgres DB username and password
    # Causes issues: database "random-user" does not exist
    # sed -i "s|^DB_USERNAME=.*|DB_USERNAME=$(openssl rand -hex 16)|" "$ENV_FILE-$DATE"
    sed -i "s|^DB_PASSWORD=.*|DB_PASSWORD=$(openssl rand -base64 32)|" "$ENV_FILE-$DATE"

    # Generate a secure Redis password
    sed -i "s|^REDIS_PASSWORD=.*|REDIS_PASSWORD=$(openssl rand -base64 32)|" "$ENV_FILE-$DATE"

    # Generate secure Pusher credentials
    sed -i "s|^PUSHER_APP_ID=.*|PUSHER_APP_ID=$(openssl rand -hex 32)|" "$ENV_FILE-$DATE"
    sed -i "s|^PUSHER_APP_KEY=.*|PUSHER_APP_KEY=$(openssl rand -hex 32)|" "$ENV_FILE-$DATE"
    sed -i "s|^PUSHER_APP_SECRET=.*|PUSHER_APP_SECRET=$(openssl rand -hex 32)|" "$ENV_FILE-$DATE"
fi

# Merge .env and .env.production. New values will be added to .env
echo -e "7. 使用新值传播 .env - 如有必要."
awk -F '=' '!seen[$1]++' "$ENV_FILE-$DATE" /data/coolify/source/.env.production > $ENV_FILE

if [ "$AUTOUPDATE" = "false" ]; then
    if ! grep -q "AUTOUPDATE=" /data/coolify/source/.env; then
        echo "AUTOUPDATE=false" >>/data/coolify/source/.env
    else
        sed -i "s|AUTOUPDATE=.*|AUTOUPDATE=false|g" /data/coolify/source/.env
    fi
fi
echo -e "8. 检查 SSH 密钥以进行 localhost 访问."
if [ ! -f ~/.ssh/authorized_keys ]; then
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    touch ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys
fi

set +e
IS_COOLIFY_VOLUME_EXISTS=$(docker volume ls | grep coolify-db | wc -l)
set -e

if [ "$IS_COOLIFY_VOLUME_EXISTS" -eq 0 ]; then
    echo " - 生成 SSH 密钥."
    ssh-keygen -t ed25519 -a 100 -f /data/coolify/ssh/keys/id.$CURRENT_USER@host.docker.internal -q -N "" -C coolify
    chown 9999 /data/coolify/ssh/keys/id.$CURRENT_USER@host.docker.internal
    sed -i "/coolify/d" ~/.ssh/authorized_keys
    cat /data/coolify/ssh/keys/id.$CURRENT_USER@host.docker.internal.pub >> ~/.ssh/authorized_keys
    rm -f /data/coolify/ssh/keys/id.$CURRENT_USER@host.docker.internal.pub
fi

chown -R 9999:root /data/coolify
chmod -R 700 /data/coolify

echo -e "9. 安装 Coolify ($LATEST_VERSION)"
echo -e " - 根据您的服务器性能、网络速度等，这可能需要一段时间."
echo -e " - 请稍候."
getAJoke

bash /data/coolify/source/upgrade.sh "${LATEST_VERSION:-latest}" "${LATEST_HELPER_VERSION:-latest}"
echo " - Coolify 安装成功."
rm -f $ENV_FILE-$DATE

echo " - 等待 20 秒，以便 Coolify（数据库迁移）准备就绪."
getAJoke

sleep 20
echo -e "\033[0;35m
   ____                   _   _    __         
  / ___|   ___     ___   | | (_)  / _|  _   _ 
 | |      / _ \   / _ \  | | | | | |_  | | | |
 | |___  | (_) | | (_) | | | | | |  _| | |_| |
  \____|  \___/   \___/  |_| |_| |_|    \__, |
                                        |___/ 
\033[0m"
echo -e "\n恭喜你!Coolify程序安装完成！\n"
echo -e "\n您的服务器程序已准备就绪，可供使用!\n"
echo -e "您可以通过您的公共IP: http://$(curl -4s https://ifconfig.io):8000"

set +e
DEFAULT_PRIVATE_IP=$(ip route get 1 | sed -n 's/^.*src \([0-9.]*\) .*$/\1/p')
PRIVATE_IPS=$(hostname -I)
set -e

if [ -n "$PRIVATE_IPS" ]; then
    echo -e "\n如果您的公网 IP 无法访问，您可以使用以下私网 IP:\n"
    for IP in $PRIVATE_IPS; do
        if [ "$IP" != "$DEFAULT_PRIVATE_IP" ]; then
            echo -e "http://$IP:8000"
        fi
    done
fi
echo -e "\n警告：强烈建议将环境变量文件 （/data/coolify/source/.env） 备份到此服务器之外的安全位置（例如，备份到密码管理器中）.\n"
cp /data/coolify/source/.env /data/coolify/source/.env.backup

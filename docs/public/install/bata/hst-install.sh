#!/bin/bash

# ======================================================== #
#
# Hestia Control Panel Installation Routine
# Automatic OS detection wrapper
# https://www.hestiacp.com/
#
# Currently Supported Operating Systems:
#
# Debian 11, 12
# Ubuntu 20.04, 22.04, 24.04 LTS
#
# ======================================================== #

# 检查是否以root用户身份执行脚本
if [ "x$(id -u)" != 'x0' ]; then
    echo '错误：此脚本只能由root用户执行'
    exit 1
fi

# 检查是否存在admin用户账户
if [ ! -z "$(grep ^admin: /etc/passwd)" ] && [ -z "$1" ]; then
    echo "错误：存在admin用户"
    echo
    echo '请先删除admin用户再继续。'
    echo '如果您想自动执行此操作，请使用-f选项运行安装程序：'
    echo "示例：bash $0 --force"
    exit 1
fi

# 检查是否存在admin用户组
if [ ! -z "$(grep ^admin: /etc/group)" ] && [ -z "$1" ]; then
    echo "错误：存在admin用户组"
    echo
    echo '请先删除admin用户组再继续。'
    echo '如果您想自动执行此操作，请使用-f选项运行安装程序：'
    echo "示例：bash $0 --force"
    exit 1
fi

# 检测操作系统
if [ -e "/etc/os-release" ] && [ ! -e "/etc/redhat-release" ]; then
    type=$(grep "^ID=" /etc/os-release | cut -f 2 -d '=')
    if [ "$type" = "ubuntu" ]; then
        # 检查lsb_release是否已安装
        if [ -e '/usr/bin/lsb_release' ]; then
            release="$(lsb_release -s -r)"
            VERSION='ubuntu'
        else
            echo "lsb_release当前未安装，请安装它："
            echo "apt-get update && apt-get install lsb-release"
            exit 1
        fi
    elif [ "$type" = "debian" ]; then
        release=$(cat /etc/debian_version | grep -o "[0-9]\{1,2\}" | head -n1)
        VERSION='debian'
    else
		type="NoSupport"
	fi
# elif [ -e "/etc/os-release" ] && [ -e "/etc/redhat-release" ]; then
# 	type=$(grep "^ID=" /etc/os-release | cut -f 2 -d '"')
# 	if [ "$type" = "rhel" ]; then
# 		release=$(cat /etc/redhat-release | cut -f 1 -d '.' | awk '{print $3}')
# 		VERSION='rhel'
# 	elif [ "$type" = "almalinux" ]; then
# 		release=$(cat /etc/redhat-release | cut -f 1 -d '.' | awk '{print $3}')
# 		VERSION='almalinux'
# 	elif [ "$type" = "eurolinux" ]; then
# 		release=$(cat /etc/redhat-release | cut -f 1 -d '.' | awk '{print $3}')
# 		VERSION='eurolinux'
# 	elif [ "$type" = "rocky" ]; then
# 		release=$(cat /etc/redhat-release | cut -f 1 -d '.' | awk '{print $3}')
# 		VERSION='rockylinux'
# 	fi
else
	type="NoSupport"
fi

no_support_message() {
	echo "****************************************************"
	echo "您的操作系统 (OS) 不受支持"
	echo "Hestia 控制面板。官方支持的版本:"
	echo "****************************************************"
	echo "  Debian 11, 12"
	echo "  Ubuntu 20.04, 22.04, 24.04 LTS"
	# Commenting this out for now
	# echo "  AlmaLinux, EuroLinux, Red Hat EnterPrise Linux, Rocky Linux 8,9"
	echo ""
	exit 1
}

if [ "$type" = "NoSupport" ]; then
	no_support_message
fi

check_wget_curl() {
	# Check wget
	if [ -e '/usr/bin/wget' ]; then
		# if [ -e '/etc/redhat-release' ]; then
		# 	wget -q https://hestiamb.org/install/hst-install-rhel.sh -O hst-install-rhel.sh
		# 	if [ "$?" -eq '0' ]; then
		# 		bash hst-install-rhel.sh $*
		# 		exit
		# 	else
		# 		echo "错误：hst-install-rhel.sh 下载失败."
		# 		exit 1
		# 	fi
		# else
		wget -q https://hestiamb.org/install/bata/hst-install-$type.sh -O hst-install-$type.sh
		if [ "$?" -eq '0' ]; then
			bash hst-install-$type.sh $*
			exit
		else
			echo "错误：hst-install-$type.sh 下载失败."
			exit 1
		fi
		# fi
	fi

	# Check curl
	if [ -e '/usr/bin/curl' ]; then
		# if [ -e '/etc/redhat-release' ]; then
		# 	curl -s -O https://hestiamb.org/install/hst-install-rhel.sh
		# 	if [ "$?" -eq '0' ]; then
		# 		bash hst-install-rhel.sh $*
		# 		exit
		# 	else
		# 		echo "错误：hst-install-rhel.sh 下载失败."
		# 		exit 1
		# 	fi
		# else
		curl -s -O https://hestiamb.org/install/install/bata/hst-install-$type.sh
		if [ "$?" -eq '0' ]; then
			bash hst-install-$type.sh $*
			exit
		else
			echo "错误：hst-install-$type.sh 下载失败."
			exit 1
		fi
		# fi
	fi
}

# 在继续下载之前，请检查支持的操作系统
# 如果检测到不支持的操作系统，则抛出错误消息。
if [[ "$release" =~ ^(11|12|20.04|22.04|24.04)$ ]]; then
	check_wget_curl $*
# elif [[ -e "/etc/redhat-release" ]] && [[ "$release" =~ ^(8|9)$ ]]; then
# 	check_wget_curl $*
else
	no_support_message
fi

exit

# 入门

本部分将帮助您在服务器上安装 `Hestia`。 如果您已经安装了 `Hestia` 并且只是寻找选项，则可以跳过此页面。
::: danger 警告
安装程序需要以 `ROOT` 身份运行，可以直接从终端运行，也可以使用 `SSH` 远程运行。 如果您不这样做，安装程序将不会继续。
:::

## 要求

::: danger 警告
`Hestia` 必须安装在全新操作系统安装之上，以确保正常功能。
如果在 `VPS/KVM` 上，并且已有管理员帐户， 请删除该默认管理员 `ID`，或使用`--force`继续安装。(如:`Ubuntu`) 有关更多详细信息，请参阅下面的自定义安装。
:::

| 名称 | 最低配置 | 推荐 |
| :--: | :--: | :--: |
| **CPU**              | 1 核 64 位                                     | 4 核 64 位                            |
| **内存**             | 1 GB (不安装SpamAssassin 和 ClamAV)             | 4 GB                                 |
| **硬盘**             | 10 GB HDD                                      | 40 GB SSD                            |
| **操作系统**         | Debian 11 or 12或者Ubuntu 20.04, 22.04 24.04 LTS | Debian 12 或者 Ubuntu LTS |

::: danger 警告
`Hestia` 仅运行在 `AMD64` / `x86_64` 和 `ARM64` / `aarch64` 处理器上。 它还需要`64`位操作系统！我们目前不支持基于 `i386` 或 `ARM7` 的处理器。
:::

### 支持的操作系统

- `Debian 10`、`11` 或 `12`
- `Ubuntu 20.04` 或 `22.04`

::: danger 警告
`Hestia` 不支持非 `LTS` 操作系统。 例如，如果您将其安装在 `Ubuntu 21.10` 上，您将不会获得我们的支持。
:::

## 安装前需要对服务器进行软件包更新(建议执行！)

::: details 查看
使用以下命令对服务器终端进行语言切换

```bash
localectl set-locale LANG=zh_CN.UTF-8
```

如切换重启后显示还是英文字符请参考[设置系统环境变量](locale)进行设置更新后即可显示中文

```bash
reboot
```

然后使用`reboot`对服务器进行重启后使用以下命令进行软件源更新替换

使用一键交互更换源命令对服务器进行换源(可选:推荐中国科学技术大学)

```bash
bash <(curl -sSL https://linuxmirrors.cn/main.sh)
```

以下是交互式更换源需进行选择的项(注: `14` 是中国科学技术大学源)

1.请选择并输入你想使用的软件源 [ `1-15` ]：`14`

2.软件源是否使用 `HTTP` 协议? [`Y/n`] `n`

3.是否跳过更新软件包? [`Y/n`] `n`

4.是否清理已下载的软件包缓存? [`Y/n`] `y`

完毕后使用以下命令对服务器终端进行最后更新后即可安装 `Hestia` 服务器管理面板

```bash
apt update -y &&  apt upgrade -y
```

推荐去[面板安装配置](/install)进行配置后快速安装！免去在终端输入需要的信息！

`Ubuntu`系统请勾选 `强制安装` 选项！
:::

## 快速安装

::: details 快速安装查看

以下配置生成地址为[面板安装配置](/install)

配置好以上配置 `复制` 后在服务器终端 `粘贴` 即可一键自动安装！

```bash
wget https://hestiamb.org/install/hst-install.sh
```

以下是配置的一键安装软件选项

```bash
bash hst-install.sh --lang zh-cn --hostname debian.hestiamb.org --email manmail@gmail.com --password SxG8rMP94jFMRN8 --postgresql yes --sieve yes --quota yes
```

::: details 配置选项查看

除 `默认配置` (安装配置界面默认✅的选项)另外分别配置了以下选项

--您的服务器如果配置较低建议不安装自建邮箱组件具体请查看[安装要求](getting-started#要求)

WEB端口为`8083`

语言界面为`中文`

主机名称为`debian.hestiamb.org`

电子邮箱为`manmail@gmail.com`

面板WEB登录密码为`SxG8rMP94jFMRN8`

数据库为`PostgreSQL`

邮件过滤为`Sieve`

硬盘限制为 `硬盘配额` 选项
:::

## 常规安装

::: details 常规安装查看
交互式安装程序将安装默认的 `Hestia` 软件配置。

### 第 1 步：下载

下载最新版本的安装脚本：也可以点这里配置我们为你开发的[一键自动化安装命令脚本](/install)。

```bash
wget https://hestiamb.org/install/hst-install.sh
```

如果由于 `SSL` 验证错误而导致下载失败，请确保您已在系统上安装了 `ca-certificates` 证书包 - 您可以使用以下命令执行此操作：

````bash
apt-get update && apt-get install ca-certificates -y
````

### 第 2 步：运行

要开始安装过程，只需运行脚本并按照屏幕上的提示操作即可：

````bash
bash hst-install.sh
````

您将在安装期间指定的地址（如果适用）收到一封欢迎电子邮件，并在安装完成后收到屏幕上的安装数据，用于登录和访问您的服务器。
:::

## 自定义安装

::: details 自定义安装查看
如果您想要自定义安装哪些软件，或者想要运行无人值守安装，则需要运行自定义安装。

要查看可用选项的列表，请运行以下命令

````bash
bash hst-install.sh -h
````

### 安装选项列表

::: warning 温馨提示
选择安装选项的一种更简单的方法是使用我们为你开发的[一键自动化安装命令脚本](/install)。
:::

要选择安装哪些软件，你可以勾选安装脚本的选项，选择你需要安装的模块。 您可以查看下面的完整选项列表。
::: details 查看完整选项列表

```bash
-a, --apache 安装 Apache [是 | 否] 默认: 是  
-w, --phpfpm 安装 PHP-FPM [是 | 否] 默认: 是  
-o, --multiphp 安装 MultiPHP [是 | 否] 默认: 否  
-v, --vsftpd 安装 VSFTPD [是 | 否] 默认: 是  
-j, --proftpd 安装 ProFTPD [是 | 否] 默认: 否  
-k, --named 安装 BIND [是 | 否] 默认: 是  
-m, --mysql 安装 MariaDB [是 | 否] 默认: 是  
-M, --mysql8 安装 Mysql8 [是 | 否] 默认: 否  
-g, --postgresql 安装 PostgreSQL [是 | 否] 默认: 否  
-x, --exim 安装 Exim [是 | 否] 默认: 是  
-z, --dovecot 安装 Dovecot [是 | 否] 默认: 是  
-Z, --sieve 安装 Sieve [是 | 否] 默认: 否  
-c, --clamav 安装 ClamAV [是 | 否] 默认: 是  
-t, --spamassassin 安装 SpamAssassin [是 | 否] 默认: 是  
-i, --iptables 安装 Iptables [是 | 否] 默认: 是  
-b, --fail2ban 安装 Fail2ban [是 | 否] 默认: 是  
-q, --quota 文件系统配额 [是 | 否] 默认: 否  
-d, --api 激活 API [是 | 否] 默认: 是  
-r, --port 更改后端端口 默认: 8083  
-l, --lang 默认语言 默认: en  
-y, --interactive 交互式安装 [是 | 否] 默认: 是  
-s, --hostname 设置主机名  
-e, --email 设置管理员邮箱  
-p, --password 设置管理员密码  
-D, --with-debs Hestia debs 的路径  
-f, --force 强制安装  
-h, --help 打印此帮助信息
```

:::

### 示例

::: details 示例内容查看
此命令将使用以下软件安装法语版的最新`Hestia`版本，分别选择安装了以下模块。

- `Nginx` 网络服务器
- `PHP-FPM` 应用服务器
- `MariaDB` 数据库服务器
- `IPtables` 防火墙 + `Fail2Ban` 入侵防御软件
- `Vsftpd FTP` 服务器
- `Exim` 邮件服务器
- `Dovecot POP3`/`IMAP` 服务器

```bash
bash hst-install.sh \
--interactive no \
--hostname host.domain.tld \
--email email@domain.tld \
--password p4ssw0rd \
--lang fr \
--apache no \
--named no \
--clamav no \
--spamassassin no
```

输入相关的信息后程序开始下载安装，等待约`5-15`分钟即可安装完成。安装完成后提示你按回车键重启。等待约`1-3`分钟即可重启完毕。

重新连接你的服务器即可登录`Hestia`的控制面板啦！安装完成后默认账户名为 `admin` 密码为你设置的密码！

如你没有设置请查看在根目录下`/root/hst_install`的文件夹默认安装配置文件名称为 `hst_install-安装日期和随机编码.log`的文件或者浏览ssh窗口里面有显示默认生成的密码。
:::

## 下一步做什么?

到目前为止，您的服务器上应该已经安装了 `Hestia`。 您已准备好添加新用户，以便您（或他们）可以在您的服务器上添加新网站或部署应用。

要访问您的控制面板，请导航至浏览器输入域名： `https://host.Example.com:8083` 或者 IP： `1.2.3.4:8083`

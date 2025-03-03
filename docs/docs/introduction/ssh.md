# 常见错误和帮助

## 文件管理器错误

打开WEB文件管理器出现如下错误![Alt text](/images/error.png)
通常是SSH的默认端口不是22的错误或者是配置没有开启文件夹权限！可用如下命令进行查看！

::: code-group

```bash
grep -riE 'sftp|AllowUsers|Authentication|UsePAM|Port' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/
```

:::

会有以下输出(第17行)

::: details 查看

```ts:line-numbers {17}
/etc/ssh/sshd_config:Port 2974
/etc/ssh/sshd_config:# Authentication:
/etc/ssh/sshd_config:#HostbasedAuthentication no
/etc/ssh/sshd_config:# HostbasedAuthentication
/etc/ssh/sshd_config:ChallengeResponseAuthentication no
/etc/ssh/sshd_config:#KerberosAuthentication no
/etc/ssh/sshd_config:#GSSAPIAuthentication no
/etc/ssh/sshd_config:# Set this to 'yes' to enable PAM authentication, account processing,
/etc/ssh/sshd_config:# and session processing. If this is enabled, PAM authentication will
/etc/ssh/sshd_config:# be allowed through the ChallengeResponseAuthentication and
/etc/ssh/sshd_config:# PAM authentication via ChallengeResponseAuthentication may bypass
/etc/ssh/sshd_config:# and ChallengeResponseAuthentication to 'no'.
/etc/ssh/sshd_config:UsePAM yes
/etc/ssh/sshd_config:GatewayPorts no
/etc/ssh/sshd_config:Subsystem sftp internal-sftp
/etc/ssh/sshd_config:PasswordAuthentication yes
/etc/ssh/sshd_config:PubkeyAuthentication no
/etc/ssh/sshd_config:# Hestia SFTP Chroot
/etc/ssh/sshd_config:Match User sftp_dummy99,admin,www
/etc/ssh/sshd_config:    ForceCommand internal-sftp
```

:::

如`PubkeyAuthentication` 字段为`no`可编辑`sshd`配置文件

::: code-group

```bash
nano /etc/ssh/sshd_config
```

:::

配置文件里的`PubkeyAuthentication no`字段为`PubkeyAuthentication yes`然后保存！

也可使用 `sed` 命令一键修改

```bash
sed -i 's/^PubkeyAuthentication no/PubkeyAuthentication yes/' /etc/ssh/sshd_config
```

查看是否修改成功

```bash
grep -riE 'sftp|AllowUsers|Authentication|UsePAM|Port' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/
```

会有以下输出(第17行)
::: details 查看

```ts:line-numbers {17}
/etc/ssh/sshd_config:Port 2974
/etc/ssh/sshd_config:# Authentication:
/etc/ssh/sshd_config:#HostbasedAuthentication no
/etc/ssh/sshd_config:# HostbasedAuthentication
/etc/ssh/sshd_config:ChallengeResponseAuthentication no
/etc/ssh/sshd_config:#KerberosAuthentication no
/etc/ssh/sshd_config:#GSSAPIAuthentication no
/etc/ssh/sshd_config:# Set this to 'yes' to enable PAM authentication, account processing,
/etc/ssh/sshd_config:# and session processing. If this is enabled, PAM authentication will
/etc/ssh/sshd_config:# be allowed through the ChallengeResponseAuthentication and
/etc/ssh/sshd_config:# PAM authentication via ChallengeResponseAuthentication may bypass
/etc/ssh/sshd_config:# and ChallengeResponseAuthentication to 'no'.
/etc/ssh/sshd_config:UsePAM yes
/etc/ssh/sshd_config:GatewayPorts no
/etc/ssh/sshd_config:Subsystem sftp internal-sftp
/etc/ssh/sshd_config:PasswordAuthentication yes
/etc/ssh/sshd_config:PubkeyAuthentication yes
/etc/ssh/sshd_config:# Hestia SFTP Chroot
/etc/ssh/sshd_config:Match User sftp_dummy99,admin,www
/etc/ssh/sshd_config:    ForceCommand internal-sftp
```

:::

使用这个命令重启`sshd`配置

```bash
systemctl restart sshd
```

然后登录 `Hestia` 面板的 `WEB` 界面进入文件管理器你会惊奇的发现没有错误显示了！

## php不存在文件错误

![Alt text](/images/Filenotfound.png)

`php`错误`File not found.`

访问网站不存在的`php`文件显示`File not found.`错误，请替换后分开运行以下三条命令给`apache`处理`php`的错误
::: danger 警告！
注：示例中用户为`test`，域为`example.com`请更换为实际用户和域名！
:::

::: code-group

``` 1
echo 'ProxyErrorOverride On' > /home/test/conf/web/example.com/apache2.conf_ProxyOverride
```

``` 2
ln -rs /home/test/conf/web/example.com/apache2.conf_ProxyOverride /home/test/conf/web/example.com/apache2.ssl.conf_ProxyOverride
```

``` 3
systemctl restart apache2
```

:::

或者可以使用本站使用的一键命令替换所有域名的php错误配置

```bash
curl -fsSL https://dns.hestiamb.org/phpcwgx.sh | bash
```

## 重置密码

如果你忘记了用户`密码`或者需要重置 `Hestia` `密码`请使用以下命令`密码重置`即可！

```bash
v-change-user-password USER PASSWORD
```

`USER`: 要更改密码的用户的`用户名`。

`PASSWORD`: 用户的`新密码`。

## 查找文件命令

假设你想查找网站目录内的一段文本需要修改，但你不知道具体修改哪个文件！可使用下面这个命令试试

```bash
grep -rn '查找文件内的内容' /home/www/sites/xxx.com/这是在哪个目录查找
```

## 删除常用命令

此命令用于删除root目录下的所有文件(不含文件夹)

```bash
find /root/ -maxdepth 1 -type f -exec rm {} \;
```

## debian12安装不成功或安装无法使用

由于主机提供商不太关注此部分错误！以下是解决方案参考！

在 `Debian12` 版本中安装 `Hestia` 后无法登录或其它错误请使用 `Debian11` 镜像。

可手动替换以下源地址从 `11` 升级到 `12` 后再次进行安装即可正常使用！

```bash
nano /etc/apt/sources.list
```

```bash
## 默认禁用源码镜像以提高速度，如需启用请自行取消注释
deb https://mirrors.ustc.edu.cn/debian bookworm main contrib non-free non-free-firmware
# deb-src https://mirrors.ustc.edu.cn/debian bookworm main contrib non-free non-free-firmware
deb https://mirrors.ustc.edu.cn/debian bookworm-updates main contrib non-free non-free-firmware
# deb-src https://mirrors.ustc.edu.cn/debian bookworm-updates main contrib non-free non-free-firmware
deb https://mirrors.ustc.edu.cn/debian bookworm-backports main contrib non-free non-free-firmware
# deb-src https://mirrors.ustc.edu.cn/debian bookworm-backports main contrib non-free non-free-firmware
deb https://mirrors.ustc.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware
# deb-src https://mirrors.ustc.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware
```

替换完成后使用以下命令进行更新升级服务器版本！

```bash
apt update -y &&  apt upgrade -y
```

更新系统到 `12` 版本后安装 `Hestia` 即可！

验证是否成功升级请使用以下命令验证

```bash
lsb_release -a
```

## (服务器安装软件程序意外断开)

::: details 查看Screen命令使用手册

### Screen 命令使用手册

Linux服务器最怕的就是`SSH`远程登录 `Linux` 服务器编译安装程序时（比如安装或者编译程序）网络突然断开，或者其他情况导致不得不与远程SSH服务器链接断开，远程执行的命令也被迫停止，只能重新连接，重新运行。相信现在很多服务器维护员也遇到过这个问题，今天就给各位推荐一款远程会话管理工具 - `screen`命令

### 一、screen命令简介

Screen是一个全屏窗口管理器，它允许用户在一个物理终端上启动多个虚拟终端（窗口），并在这些窗口中运行不同的程序。`Screen`特别适用于在远程会话中保持任务持续运行，即使连接被意外断开。通过使用`Screen`，用户可以在断开连接后重新连接到会话，继续之前的工作，而不会丢失任何进程或数据。

### 二、安装screen命令

### 2.1 Debian/Ubuntu系统

在Debian和Ubuntu系统上，你可以使用以下命令来安装Screen：

更新系统缓存和软件数据包！

```bash
apt update -y &&  apt upgrade -y
```

安装Screen

```bash
apt install screen -y
```

### 三、screen命令使用方法

### 3.1 创建screen会话窗口

使用 `screen -S Hestia` 命令来新建一个名为 `Hestia` 的 `screen` 会话窗口。

```bash
screen -S Hestia
```

下载安装 `Hestia` 面板程序

```bash
wget https://hestiamb.org/install/hst-install.sh
```

以下是配置的一键安装软件选项

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

```bash
bash hst-install.sh --lang zh-cn --hostname debian.hestiamb.org --email manmail@gmail.com --password SxG8rMP94jFMRN8 --postgresql yes --sieve yes --quota yes
```

以上配置生成地址为[面板安装配置](/install)

设置好以上配置复制后在服务器终端粘贴即可一键自动安装！

如在安装过程中服务器意外断开了连接，不要慌！重新连接后使用 `screen -r Hestia` 即可再次看见安装程序在继续运行！

### 3.2 暂时离开，保留screen会话中的任务或程序

按下 `Ctrl + a` 然后按 `d` 来分离当前screen会话。此时，会话中的任务会继续运行，而你可以断开连接。

### 3.3 恢复screen会话（意外断开后恢复到当前项目）

使用 `screen -r Hestia` 或 `screen -r Hestia_id` 来重新连接到指定的screen会话。

```bash
screen -r Hestia
```

如果你忘记了会话名或ID，可以使用 `screen -ls` 命令来列出所有screen会话，并选择要恢复的会话。

### 3.4 关闭screen的会话

在screen会话中，直接输入 `exit` 或使用快捷键 `Ctrl + d`（如果这是该会话中唯一的活动窗口）来关闭会话。

### 3.5 远程演示

使用 `screen -x Hestia` 命令可以让其他用户连接到已经存在的screen会话，从而实现远程协作和演示。

### 3.6 常用快捷键

`Ctrl + a c`：在当前screen会话中创建一个新的窗口。
`Ctrl + a w`：显示当前screen会话中所有窗口的列表。
`Ctrl + a n`：切换到下一个窗口。
`Ctrl + a p`：切换到上一个窗口。
`Ctrl + a 0-9`：切换到编号为0-9的窗口。

请注意，上述快捷键中的 `Ctrl + a` 是一个前缀，用于激活screen命令模式，然后你可以按下相应的键来执行不同的操作。

如果你发现 `Ctrl + a` 与你的编辑器或其他应用程序的快捷键冲突，你可以通过在screen的配置文件（通常是 `~/.screenrc`）中设置不同的前缀来解决这个问题。

### 四、screen配置文件

Screen的配置文件是 `~/.screenrc`，你可以在这个文件中自定义screen的行为和外观。例如，你可以设置默认的窗口数量、滚动条的行为、终端类型等等。具体的配置选项可以参考Screen的官方文档或手册页（通过 `man screen` 命令查看）。

### 五、总结

Screen是一个强大的全屏窗口管理器，它可以帮助你更好地管理你的终端会话。通过使用Screen，你可以轻松地在多个窗口之间切换，保持任务的持续运行，并在需要时重新连接到会话。掌握Screen的基本用法和快捷键，将大大提高你的工作效率。
:::

## 附件管理器(推荐)

如您在建立网站时需要为站点部署`图片/音乐/视频`的附件储存！推荐使用[附件管理器](https://fm.hestiamb.org)对文件进行管理！比`nginx`部署文件管理更方便快捷！(有手就会)

### 部署方式

建立一个附件网站，如：`ftp.example.com`或`dns.example.com`或`img.example.com`建立后将`index.php`和`translation.json`放在网站根目录即可！建立相关文件夹对文件进行分类。即可使用！

下载相关文件和资料请去这里查看[附件管理器](https://fm.hestiamb.org)

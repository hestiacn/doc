# 操作系统升级

::: danger 警告
在升级操作系统之前，请务必进行备份！ 我们不为损坏的操作系统安装提供支持。 我们仅提供此页面来提供有关升级过程中可能出现的 Hestia 问题的信息。
:::

## debian & ubautu

::: warning 温馨提示
确保验证 MariaDB 是否在新操作系统支持的版本上运行。 如果不是这种情况，请在升级操作系统之前将 MariaDB 版本更新到支持的版本！
:::

完成备份后，将 Hestia 更新到最新支持的版本：

```bash
apt update && apt upgrade -y
```

按照系统说明升级您的操作系统。 完成后，请确保检查`/etc/apt/sources.list.d`中的更新源配置是否正确。 如果是，请保存退出并再次运行`apt update && apt Upgrade -y`

## Debian 10 Buster 到 Debian 11 Bullseye

### SHA512 密码加密

```bash
sed -i "s/obscure yescrypt/obscure sha512/g" /etc/pam.d/common-password
```

### Exim4 配置

```bash
rm -f /etc/exim4/exim4.conf.template
cp -f /usr/local/hestia/install/deb/exim/exim4.conf.4.94.template /etc/exim4/exim4.conf.template
```

### ProFTPD

注释掉 `/etc/proftpd/proftpd.conf` 文件中注释掉[第29行](https://gitee.com/mirrors_hestiacp/hestiacp/blob/main/install/deb/proftpd/proftpd.conf#L29),参考如下:
::: details 查看代码

```ts:line-numbers {29}
ServerName                      "FTP"
ServerIdent                     on "FTP Server ready."
ServerAdmin                     root@localhost
DefaultServer                   on
DefaultRoot                  ~ !adm

Include /etc/proftpd/tls.conf

<IfModule mod_vroot.c>
    VRootEngine                 on
    VRootAlias                  /etc/security/pam_env.conf etc/security/pam_env.conf
</IfModule>

AuthPAMConfig                   proftpd
AuthOrder                       mod_auth_pam.c* mod_auth_unix.c
UseReverseDNS                   off
User                            proftpd
Group                           nogroup
MaxInstances                    20
UseSendfile                     off
LogFormat                       default "%h %l %u %t \"%r\" %s %b"
LogFormat                       auth    "%v [%P] %h %t \"%r\" %s"
ListOptions                     -a
RequireValidShell               off
PassivePorts                    12000 12100

<Global>
  Umask                         002
  // IdentLookups                  off
  AllowOverwrite                yes
  <Limit ALL SITE_CHMOD>
    AllowAll
  </Limit>
</Global>
```

:::

## Debian 9 升级到 Debian 10 Buster

过去没有发现任何问题。

（注意：模板版本号可能需要根据实际情况调整）

## Ubuntu 22.04 Jammy 到 Ubuntu 24.04 Noble

::: warning 温馨提示
请验证MariaDB至少运行在11.4版本。如果不是，请先在当前操作系统中升级到该版本！之后，注释掉`/etc/apt/sources.list.d/mariadb.list`中的相关行，然后升级操作系统。
:::

### Exim4配置

```bash
rm -f /etc/exim4/exim4.conf.template
cp -f /usr/local/hestia/install/deb/exim/exim4.conf.4.95.template /etc/exim4/exim4.conf.template
```

（注意：模板版本号可能需要根据实际情况调整）

## Ubuntu 20.04 Focal 到 Ubuntu 22.04 Jammy

::: tip
请验证MariaDB至少运行在10.6版本。如果不是，请先在当前操作系统中升级到该版本！之后，注释掉`/etc/apt/sources.list.d/mariadb.list`中的相关行，然后升级操作系统。
:::

### SHA512密码加密

```bash
sed -i "s/obscure yescrypt/obscure sha512/g" /etc/pam.d/common-password
```

### Exim4配置

```bash
rm -f /etc/exim4/exim4.conf.template
cp -f /usr/local/hestia/install/deb/exim/exim4.conf.4.94.template /etc/exim4/exim4.conf.template
```

### ProFTPD

注释掉 `/etc/proftpd/proftpd.conf` 文件中注释掉[第29行](https://gitee.com/mirrors_hestiacp/hestiacp/blob/main/install/deb/proftpd/proftpd.conf#L29),参考如下:
::: details 查看代码

```ts:line-numbers {29}
ServerName                      "FTP"
ServerIdent                     on "FTP Server ready."
ServerAdmin                     root@localhost
DefaultServer                   on
DefaultRoot                  ~ !adm

Include /etc/proftpd/tls.conf

<IfModule mod_vroot.c>
    VRootEngine                 on
    VRootAlias                  /etc/security/pam_env.conf etc/security/pam_env.conf
</IfModule>

AuthPAMConfig                   proftpd
AuthOrder                       mod_auth_pam.c* mod_auth_unix.c
UseReverseDNS                   off
User                            proftpd
Group                           nogroup
MaxInstances                    20
UseSendfile                     off
LogFormat                       default "%h %l %u %t \"%r\" %s %b"
LogFormat                       auth    "%v [%P] %h %t \"%r\" %s"
ListOptions                     -a
RequireValidShell               off
PassivePorts                    12000 12100

<Global>
  Umask                         002
  // IdentLookups                  off
  AllowOverwrite                yes
  <Limit ALL SITE_CHMOD>
    AllowAll
  </Limit>
</Global>
```

:::

## Ubuntu 18.04 Bionic 升级到 Ubuntu 20.04 Focal

过去没有发现任何问题。

## 旧版本

我们尚未测试从 Ubuntu 16.04 到 Ubuntu 20.04 或 Debian 8 Jessy 到 Debian 10 的升级路径

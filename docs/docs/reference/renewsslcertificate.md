# ssl证书系列命令介绍

## v-add-letsencrypt-host

[命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-letsencrypt-host)

`v-add-letsencrypt-host` 是 HestiaCP（一个流行的 web 主机控制面板）中的一个 CLI（命令行接口）命令，用于为指定的主机名（域名）添加 Let's Encrypt SSL 证书。这个命令能够自动化证书的申请、验证和安装过程，使得管理员能够轻松地为他们的网站启用 HTTPS。

下面是 `v-add-letsencrypt-host` 命令的一些基本解释和用法：

### 命令格式

```bash
v-add-letsencrypt-host <hostname> [options]
```

### 参数

- `<hostname>`: 要为其添加 Let's Encrypt SSL 证书的主机名或域名。可以包括通配符域名（例如 `*.example.com`）和子域名（例如 `www.example.com`）。

### 选项（options）

- `--email <email>`: 提供用于接收 Let's Encrypt 证书到期通知的电子邮件地址。这是非常重要的，因为 Let's Encrypt 证书有有效期限制，并且需要在到期前续订。
- `--auto-renew`: 设置证书自动续订。启用这个选项后，系统会自动监控证书的到期日期，并在证书即将到期时自动重新申请新的证书，无需人工干预。
- `--force`: 强制重新生成证书，即使当前证书仍然有效。
- `--webroot <path>`: 指定用于 HTTP-01 挑战的 webroot 路径。这是 Let's Encrypt 用于验证域名的所有权的一种方式。
- `--dns`: 使用 DNS-01 挑战来验证域名的所有权，而不是 HTTP-01。这通常用于没有运行 web 服务器的域名，或者需要更高级别的自动化。
- `--dns-plugin <plugin>`: 当使用 DNS-01 挑战时，指定用于与 DNS 提供商交互的插件。
- `--agree`: 同意 Let's Encrypt 的服务条款。在某些版本的 HestiaCP 或 Let's Encrypt 客户端中，这是必须的。
- 以及其他可能的选项，具体取决于 HestiaCP 的版本和配置。

### 示例

```bash
# 为 example.com 添加 Let's Encrypt SSL 证书，并设置自动续订
v-add-letsencrypt-host example.com --email admin@example.com --auto-renew

# 为 example.com 和它的子域名 www.example.com 添加证书
v-add-letsencrypt-host example.com www.example.com --email admin@example.com --auto-renew

# 强制为 example.com 重新生成证书
v-add-letsencrypt-host example.com --email admin@example.com --auto-renew --force
```

### 注意事项

- 在运行 `v-add-letsencrypt-host` 命令之前，确保你的服务器已经配置好了正确的 DNS 记录，并且你的域名可以解析到服务器的 IP 地址。
- 确保服务器的防火墙和网络设置允许 Let's Encrypt 的验证服务器（通常是 `acme-v02.api.letsencrypt.org`）能够访问你的服务器以进行验证。
- 如果你选择使用 DNS-01 挑战，你需要确保你的 DNS 提供商支持 ACME 协议的 DNS 验证，并且你有权限修改相应的 DNS 记录。
- 在某些情况下，你可能需要安装或更新特定的依赖项（如 `certbot` 或其他 Let's Encrypt 客户端）以支持 `v-add-letsencrypt-host` 命令。

## v-add-letsencrypt-domain

* [命令行Bash 脚本查看](https://gitee.com/mirrors_hestiacp/hestiacp/raw/main/bin/v-add-letsencrypt-domain)

检查 LetsEncrypt 网站

**选项**: `USER` `DOMAIN` `[ALIASES]` `[MAIL]`

**示例**:

```bash
v-add-letsencrypt-domain admin wonderland.com www.wonderland.com,demo.wonderland.com
example: v-add-letsencrypt-domain admin wonderland.com '' yes
```

此函数使用 Let's Encrypt 检查并验证网站

## v-add-letsencrypt-host

* [命令行Bash 脚本查看](https://gitee.com/mirrors_hestiacp/hestiacp/raw/main/bin/v-add-letsencrypt-host)

为主机和后端添加letencrypt

**选项**: –

此函数检查并验证后端证书并生成新的让我们的加密证书。

## v-add-letsencrypt-user

* [命令行Bash 脚本查看](https://gitee.com/mirrors_hestiacp/hestiacp/raw/main/bin/v-add-letsencrypt-user)

注册LetsEncrypt用户帐户

**选项**: `USER`

**示例**:

```bash
v-add-letsencrypt-user bob
```

该函数创建并注册LetsEncryptSLL证书账户

## v-delete-letsencrypt-domain

* [命令行Bash 脚本查看](https://gitee.com/mirrors_hestiacp/hestiacp/raw/main/bin/v-delete-letsencrypt-domain)

删除域的 LetsEncrypt SSL 证书

**选项**: `USER` `DOMAIN` `[RESTART]` `[MAIL]`

**示例**:

```bash
v-delete-letsencrypt-domain admin acme.com yes
```

此函数关闭对域的 LetsEncrypt SSL 支持。

## v-change-mail-domain-sslcert

* [命令行Bash 脚本查看](https://gitee.com/mirrors_hestiacp/hestiacp/raw/main/bin/v-change-mail-domain-sslcert)

更改网站名ssl证书

**选项**: `USER` `DOMAIN` `SSL_DIR` `[RESTART]`

此功能更改 SSL 网站证书和密钥。 如果存在 ca 文件它也将被替换。

## v-list-letsencrypt-user

* [命令行Bash 脚本查看](https://gitee.com/mirrors_hestiacp/hestiacp/raw/main/bin/v-list-letsencrypt-user)

查看加密密钥

**选项**: `USER` `[FORMAT]`

**示例**:

```bash
v-list-letsencrypt-user admin
```

此函数用于获取 LetsEncrypt 密钥指纹

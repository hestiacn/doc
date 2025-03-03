# 应用程序接口示例

::: warning 温馨提示
这是官方团队成员创建的一个示例，
:::

## 示例

示例可以在单独的[repo](https://github.com/hestiacp/hestiacp-api-examples)中找到。

## 从用户名/密码身份验证升级到访问/密钥身份验证

替换以下代码:

```php
// Prepare POST query
$postvars = [
"user" => $hst_username,
"password" => $hst_password,
"returncode" => $hst_returncode,
"cmd" => $hst_command,
"arg1" => $username,
];
```

具有以下内容:

```php
// Prepare POST query
$postvars = [
"hash" => "access_code:secret_code",
"returncode" => $hst_returncode,
"cmd" => $hst_command,
"arg1" => $username,
];
```

## v-wrapper-hestia-api

::: warning 温馨提示
这是官方团队成员创建的一个示例，
:::

* [命令行Bash 脚本查看](https://gitee.com/linboxs/hestiamb/raw/master/v-wrapper-hestia-api)

这是一个与 Hestia API 交互的实用程序。 它是一个使用curl 执行API 调用的bash 脚本，您只需添加要使用的命令及其参数作为参数即可。

### 安装：

**使用 git 克隆**

```bash
cd ~
git clone https://gitee.com/linboxs/hestiamb.git
sudo cp v-wrapper-hestia-api/v-wrapper-hestia-api /usr/local/bin/
```

**使用 curl**

```bash
sudo curl -s https://gitee.com/linboxs/hestiamb/raw/master/v-wrapper-hestia-api -o /usr/local/bin/v-wrapper-hestia-api
sudo chmod 755 /usr/local/bin/v-wrapper-hestia-api
```

**使用 wget**

```bash
sudo wget https://gitee.com/linboxs/hestiamb/raw/master/v-wrapper-hestia-api -O /usr/local/bin/v-wrapper-hestia-api
sudo chmod 755 /usr/local/bin/v-wrapper-hestia-api
```

### 配置脚本使用的选项（主机、端口和凭证）：

创建并编辑文件 `~/.v-wrapper-hestia-api.conf`

对于**新 API** 添加以下变量并使用您自己的数据：

```bash
host='hestiacp.example.com'
port='8083'
access_key='HereYourAccessKey'
secret_key='HereYourSecretKey'
```

对于 **旧版 API（用户/密码）** 使用您自己的数据添加以下变量（用户将始终是管理员）：

```bash
host='hestiacp.example.com'
port='8083'
user='admin'
password='HereYourPassword'
```

对于 **旧版 API（哈希值）** 使用您自己的数据添加以下变量：

```bash
host='hestiacp.example.com'
port='8083'
hash='HereYourHash'
```

对于**所有 API 模式**，您可以添加所有变量，脚本将根据已使用的选项使用正确的变量：

```bash
host='hestiacp.example.com'
port='8083'
access_key='HereYourAccessKey'
secret_key='HereYourSecretKey'
user='admin'
password='HereYourPassword'
hash='HereYourHash'
```

### 用法:

`v-wrapper-hestia-api [-l|--list] [-u|--user-password] [-h|--hash] HESTIA_COMMAND [ARG1] [ARG2] [...] [ARG13]`

### 列出Hestia命令:

使用此选项您可以列出 Hestia 使用的命令、描述和选项。

`v-wrapper-hestia-api [-l|--list] [search pattern]`

示例：

```bash
v-wrapper-hestia-api -l
v-wrapper-hestia-api -l v-change
v-wrapper-hestia-api --list v-list
v-wrapper-hestia-api -l '.*mail'
v-wrapper-hestia-api --list 'v-.*web'
```

输出示例：

```bash
$ v-wrapper-hestia-api -l v-change-mail                                                                                   
HESTIA COMMAND                    DESCRIPTION                        OPTIONS
--------------                    -----------                        -------
v-change-mail-account-password    change mail account password       USER DOMAIN ACCOUNT PASSWORD
v-change-mail-account-quota       change mail account quota          USER DOMAIN ACCOUNT QUOTA
v-change-mail-account-rate-limit  change mail account rate limit     USER DOMAIN ACCOUNT RATE
v-change-mail-domain-catchall     change mail domain catchall email  USER DOMAIN EMAIL
v-change-mail-domain-rate-limit   change mail domain rate limit      USER DOMAIN RATE
v-change-mail-domain-sslcert      change domain ssl certificate      USER DOMAIN SSL_DIR [RESTART]
```

### 新 API：

`v-wrapper-hestia-api hestia_command [arg1] [arg2] [...] [arg13]`

### 旧 API（用户名/密码）：

`v-wrapper-hestia-api [-u|--user-password] hestia_command [arg1] [arg2] [...] [arg13]`

### 遗留 API（哈希）：

`v-wrapper-hestia-api [-h|--hash] hestia_command [arg1] [arg2] [...] [arg13]`

示例:

```bash
v-wrapper-hestia-api v-list-users
v-wrapper-hestia-api v-list-web-domain user domain
v-wrapper-hestia-api -h v-list-web-domain user domain
v-wrapper-hestia-api --user-password v-list-users
```

### 编辑连接参数：

您可以在脚本中编辑以下变量：

```bash
v_host=''
v_port=''
v_access_key=''
v_secret_key=''
v_user=''
v_password=''
v_hash=''
```

或者您可以在 `$HOME` 中创建一个配置文件 `.v-wrapper-hestia-api.conf` 或在当前目录中创建一个文件 `.v-wrapper-hestia-api.conf` （该文件优先于 其他选项）。

如果使用conf文件，要使用的变量是（请记住conf文件中不使用“v-”前缀）：

```bash
host=''
port=''
access_key=''
secret_key=''
user=''
password=''
hash=''
```

**注意**：默认情况下，脚本（在本例中为curl）需要在您的Hestia服务器中安装有效的证书，如果您的证书已过期、自签名等，您可以忽略证书验证编辑脚本并更改 将“curl_ignore_cert=0”变量更改为“curl_ignore_cert=1”或将“curl_ignore_cert=1”添加到您的conf文件中。

## 如何在 Hestia 控制面板中创建访问 API 的凭据

### 新的 API

您可以使用 Web UI 创建访问密钥。

`用户管理配置文件` -> `访问密钥` -> `添加访问密钥` -> `选择您要使用的权限并添加注释（使用空格）` -> `保存`

您将看到新的“访问密钥”和“秘密密钥”（将两者保存在安全的地方）。

使用命令行，您可以使用命令“v-add-access-key”创建访问密钥和秘密密钥。

`用法：v-add-access-key USER [权限] [注释] [格式]`

例如：

```bash
# v-add-access-key admin billing AdminBill
ACCESS_KEY_ID:      InNqgp01kO3v0W22eg6Z
SECRET_ACCESS_KEY:  lcp45pvgZh0f_33veMB2P6HDVUYpYeHjTatZ=hDu
USER:               admin
PERMISSIONS:        billing
COMMENT:            AdminBill
TIME:               01:35:44
DATE:               2023-09-10
```

如果您想查看可用的 api 以及可以在每个 api 中使用的命令，请使用命令“v-list-apis”。

```bash
# v-list-apis
API                 ROLE   COMMANDS
---                 ----   --------
billing             admin  v-add-user,v-delete-user,v-suspend-user,v-unsuspend-user,v-change-user-shell,v-list-user,v-list-users,v-make-tmp-file,v-add-domain,v-change-user-package,v-make-tmp-file,v-change-user-password
mail-accounts       user   v-list-mail-domains,v-list-mail-domain,v-list-mail-account,v-list-mail-accounts,v-list-mail-account-autoreply,v-delete-mail-account,v-delete-mail-account-alias,v-delete-mail-account-autoreply,v-delete-mail-account-forward,v-delete-mail-account-fwd-only,v-add-mail-account,v-add-mail-account-alias,v-add-mail-account-autoreply,v-add-mail-account-forward,v-add-mail-account-fwd-only,v-change-mail-account-password,v-change-mail-account-quota,v-suspend-mail-account,v-suspend-mail-accounts,v-unsuspend-mail-account,v-unsuspend-mail-accounts
phpmyadmin-sso      admin  v-add-database-temp-user,v-delete-database-temp-user
purge-nginx-cache   user   v-purge-nginx-cache,v-list-web-domains,v-list-web-domain
sync-dns-cluster    admin  v-list-users,v-list-sys-config,v-list-user,v-add-cron-restart-job,v-delete-dns-domains-src,v-insert-dns-domain,v-insert-dns-record,v-insert-dns-records,v-rebuild-dns-domains,v-rebuild-dns-domain,v-delete-dns-record,v-make-tmp-file,v-insert-dns-domain,v-delete-dns-domain
update-dns-records  user   v-list-dns-records,v-change-dns-record
```

您可以修改现有 api 或在 `/usr/local/hestia/data/api/` 中创建您自己的编辑文件，或者使用您要使用的命令列表添加文件。

如果由于某种原因你需要能够使用所有可用的命令，你可以使用此命令向管理员用户授予所有权限（GodMode 只是一个有趣的注释），这里，重要的部分是`''`。

```bash
# v-add-access-key admin '' GodMode
ACCESS_KEY_ID:      ss7zCZQ5HasP3FeZyhYW
SECRET_ACCESS_KEY:  ircw1YhKzPlGufaNrQnutN8UOo3JkHqXvWKxCa3J
USER:               admin
PERMISSIONS:
COMMENT:            GodMode
TIME:               01:52:16
DATE:               2023-09-10
```

### 旧 API（用户/密码）

::: danger 警告！
不建议使用旧版 API，并且可能会在未来版本中从 Hestia 中删除。
:::
您不需要创建任何内容，只需使用您的用户 admin（是唯一允许的用户）及其密码。 使用此方法，您将能够使用所有 Hestia 命令。

### 遗留 API（哈希）

::: danger 警告！
不建议使用旧版 API，并且可能会在未来版本中从 Hestia 中删除。
:::
要创建哈希，您必须使用命令行和命令“v-generate-api-key”

示例：

```bash
# v-generate-api-key
zIafmk4i6opgjto7x3U_t8sVKj3JT6-P
```

复制它，您就可以使用它了。 使用此方法，您将能够使用所有 Hestia 命令。

### 添加你的客户端ip到允许访问API的ip

默认情况下，Hestia 不允许任何 ip 连接到 API，因此如果您想从外部客户端连接，则必须将客户端 ip 添加到 API_ALLOWED_IP。

使用网络用户界面：
`服务器设置` -> `配置` -> `安全` -> `系统` -> `API 允许的 IP 地址` -> `在新行中添加您的客户端 IP` -> `保存`

使用命令行：参考[IP系列命令介绍](ip.html#v-add-sys-api-ip)

**我不推荐这样做**，但是，如果由于某种原因您想要允许所有外部 ip 使用您的 Hestia API，您可以通过 Web UI 或通过命令行添加 ip `0.0.0.0`。 **使用风险自负**
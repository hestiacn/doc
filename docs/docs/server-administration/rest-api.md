# API 系统介绍

Hestia REST API 可用于执行控制面板的核心功能。 例如，我们在内部使用它来同步 DNS 集群并集成 WHMCS 计费系统。 该 API 还可用于创建新的用户帐户、域、数据库，甚至构建替代的 Web 界面。

[API 参考](../reference/api) 提供 PHP 代码示例，演示如何将 API 集成到应用程序或脚本中。 但是，您也可以使用任何其他语言与 API 进行通信。

随着 Hestia v1.6.0 的发布，我们引入了更先进的 API 系统，它将允许非管理员用户使用特定命令。

## 无法连接到API

随着Hestia v1.4.0版本的发布，我们决定加强安全性。如果您想从远程服务器连接到API，首先需要将其IP地址加入白名单。如果要添加多个地址，请用新行分隔它们。要绕过IP过滤，请删除所有现有的IP地址并输入`allow-all`。

## 可以禁用API吗？

是的，您可以通过服务器设置禁用API。该文件将从服务器上删除，并且所有连接都将被忽略。请注意，禁用API后，某些功能可能无法正常工作。

## 密码 vs API密钥 vs 访问密钥

### 访问密钥

- 用户特定。
- 可以限制权限。例如，仅允许`v-purge-nginx-cache`命令。
- 可以在禁用其他登录方法的同时仍然允许使用API密钥。
- 可以仅限制为管理员用户使用，或允许所有用户使用。

### 密码

:::danger
此方法已弃用
:::

- 仅应由管理员用户使用。
- 更改管理员密码需要在所有使用该密码的地方进行更新。
- 允许执行所有命令。

### API密钥

:::danger
此方法已弃用
:::

- 仅应由管理员用户使用。
- 更改管理员密码对此无影响。
- 允许执行所有命令。

## 设置访问/密钥认证

要创建访问密钥，请遵循[我们文档中的指南](../user-guide/account#api-access-keys)。

:::tip
或者，可以使用以下命令创建。要创建一个需要管理员权限的访问密钥，请通过初始管理员用户创建API密钥！
:::

```bash
v-add-access-key 'admin' 'profile' test json
```

如果您想使用API密钥执行所有支持的命令，请使用

```bash
v-add-access-key 'admin' '*' test json
```

### 创建自定义API密钥配置文件

在`/usr/local/hestia/data/api/`中创建一个新文件，内容如下

```bash
ROLE='admin'
COMMANDS='v-list-web-domains,v-add-web-domain,v-list-web-domain'
```

- Role（角色）：user（用户）或admin（管理员）。
- Commands（命令）：逗号分隔的列表，包含您需要的所有命令。

如果您使用的软件已经支持哈希格式，请使用`ACCESS_KEY:SECRET_KEY`代替旧的API密钥。

## 返回代码

| 值 | 名称 | 注释 |
| :--: | :--: | :--: |
| 0 | OK | 命令已成功执行 |
| 1 | E_ARGS | 提供的参数不足 |
| 2 | E_INVALID | 对象或参数无效 |
| 3 | E_NOTEXIST | 对象不存在 |
| 4 | E_EXISTS | 对象已存在 |
| 5 | E_SUSPENDED | 对象已挂起 |
| 6 | E_UNSUSPENDED | 对象已恢复 |
| 7 | E_INUSE | 对象正在被其他对象使用，无法删除 |
| 8 | E_LIMIT | 由于主机包限制，无法创建对象 |
| 9 | E_PASSWORD | 密码错误/无效 |
| 10 | E_FORBIDEN | 此用户无法访问该对象 |
| 11 | E_DISABLED | 子系统已禁用 |
| 12 | E_PARSING | 配置已损坏 |
| 13 | E_DISK | 磁盘空间不足，无法完成操作 |
| 14 | E_LA | 服务器太忙，无法完成操作 |
| 15 | E_CONNECT | 连接失败，主机不可达 |
| 16 | E_FTP | FTP服务器未响应 |
| 17 | E_DB | 数据库服务器未响应 |
| 18 | E_RDD | RRDtool无法更新数据库 |
| 19 | E_UPDATE | 更新操作失败 |
| 20 | E_RESTART | 服务重启失败 |

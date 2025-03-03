# DNS系列命令介绍

## v-add-dns-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-dns-domain)

`v-add-dns-domain` 是 Hestia 提供的 CLI（命令行接口）命令之一，用于向 DNS 系统中添加新的域名记录。以下是对该命令的详细解释，包括使用方法和示例。

### 命令格式

```bash
v-add-dns-domain USER DOMAIN IP [NS1] [NS2] [NS3] [NS4] [NS5] [NS6] [NS7] [NS8] [RESTART]
```

### 参数说明

* **USER**: 用户名，指定要添加 DNS 域名的用户。
* **DOMAIN**: 要添加的域名。
* **IP**: 主域名服务器的 IP 地址。
* **[NS1] 到 [NS8]**: 可选的辅助域名服务器 IP 地址。最多可以指定 8 个。
* **[RESTART]**: 可选参数，如果设置为 `yes`，则在添加域名后重启 DNS 服务。

### 示例

#### 示例 1: 基本用法

```bash
v-add-dns-domain admin example.com 192.168.1.1
```

这个命令将为用户 `admin` 添加一个名为 `example.com` 的域名，并指定主域名服务器的 IP 地址为 `192.168.1.1`。没有指定任何辅助域名服务器，也没有要求重启 DNS 服务。

#### 示例 2: 使用辅助域名服务器

```bash
v-add-dns-domain admin example.com 192.168.1.1 ns1.example.com ns2.example.com
```

这个命令与上一个示例类似，但还指定了两个辅助域名服务器的 IP 地址：`ns1.example.com` 和 `ns2.example.com`。

#### 示例 3: 要求重启 DNS 服务

```bash
v-add-dns-domain admin example.com 192.168.1.1 ns1.example.com ns2.example.com yes
```

这个命令在添加域名和指定辅助域名服务器后，还要求重启 DNS 服务。`yes` 参数用于触发这一操作。

### 注意事项

* 在执行 `v-add-dns-domain` 命令之前，请确保您已经登录到具有足够权限的用户账户。
* 在添加域名之前，请确保 DNS 系统已经正确配置，并且主域名服务器和任何辅助域名服务器都是可达的。
* 如果在添加域名后遇到问题，请检查您的 DNS 配置，并考虑重新启动 DNS 服务。使用 `RESTART` 参数可以自动执行此操作。

### 结论

`v-add-dns-domain` 命令是 Hestia 提供的强大工具之一，用于向 DNS 系统中添加新的域名记录。通过指定用户、域名、主域名服务器 IP 地址和可选的辅助域名服务器 IP 地址，您可以轻松地管理您的 DNS 配置。在需要时，还可以使用 `RESTART` 参数来重启 DNS 服务。

## v-add-dns-on-web-alias

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-dns-on-web-alias)

### 简介

`v-add-dns-on-web-alias` 是 Hestia 控制面板提供的一个命令行接口（CLI）工具，用于基于 Web 域别名添加 DNS 域或 DNS 记录。该命令允许管理员根据已有的 Web 域名别名，快速配置 DNS 记录，确保域名的正确解析。

### 语法

```bash
v-add-dns-on-web-alias USER ALIAS IP [RESTART]
```

- `USER`：执行命令的用户名（通常是管理员用户名）。
- `ALIAS`：要为其添加 DNS 记录的 Web 域名别名。
- `IP`：要分配给该域名的 IP 地址。
- `[RESTART]`：可选参数，用于指定是否重启 DNS 服务。如果提供此参数，服务将在配置更改后重新启动。

### 示例

#### 示例 1：为基本域名别名添加 DNS 记录

```bash
v-add-dns-on-web-alias admin www.example.com 8.8.8.8
```

在此示例中，管理员 `admin` 为 `www.example.com` 这个 Web 域名别名添加了一个 DNS 记录，将其解析到 IP 地址 `8.8.8.8`。默认情况下，不会重启 DNS 服务。

#### 示例 2：为带有子域名的别名添加 DNS 记录并重启服务

```bash
v-add-dns-on-web-alias admin blog.example.com 192.168.1.1 RESTART
```

在此示例中，管理员 `admin` 为 `blog.example.com` 这个带有子域名的 Web 域名别名添加了一个 DNS 记录，将其解析到 IP 地址 `192.168.1.1`。由于提供了 `RESTART` 参数，因此在配置更改后，DNS 服务将被重新启动。

#### 示例 3：使用变量来动态添加 DNS 记录

在实际使用中，您可能会使用脚本来动态生成 DNS 记录。以下是一个简单的 Bash 脚本示例，用于读取用户输入并调用 `v-add-dns-on-web-alias` 命令：

```bash
#!/bin/bash

read -p `请输入用户名: ` USER
read -p `请输入域名别名: ` ALIAS
read -p `请输入 IP 地址: ` IP

# 调用 Hestia CLI 命令添加 DNS 记录
v-add-dns-on-web-alias `$USER` `$ALIAS` `$IP`

echo `DNS 记录已添加。`
```

### 注意事项

- 在执行此命令之前，请确保您具有适当的权限和访问级别。
- 提供的 IP 地址必须是有效的，并且与您的服务器或托管服务提供商的配置相匹配。
- 如果您的 DNS 服务需要重新启动才能应用更改，请确保在命令中包含 `RESTART` 参数。
- 如果在执行命令时遇到任何问题或错误消息，请参考 Hestia 的官方文档或支持论坛以获取更多帮助。

## v-add-dns-record

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-dns-record)

### 简介

`v-add-dns-record` 是 Hestia 提供的一个命令行接口（CLI）命令，用于向 DNS 系统添加新的 DNS 记录。此命令允许用户通过简单的参数配置，快速、灵活地添加各种类型的 DNS 记录。

### 用法

```bash
v-add-dns-record USER DOMAIN RECORD TYPE VALUE [PRIORITY] [ID] [RESTART] [TTL]
```

### 参数说明

* `USER`: 执行此命令的用户。
* `DOMAIN`: 要添加 `DNS` 记录的域名。
* `RECORD`: 具体的记录名称（如 `www`）。
* `TYPE`: `DNS` 记录的类型（如 `A`, `CNAME`, `MX`, `TXT` 等）。
* `VALUE`: `DNS` 记录的值（如 `IP` 地址、`CNAME` 目标等）。
* `[PRIORITY]`: （可选）仅适用于 `MX` 和 `SRV` 记录，表示优先级。
* `[ID]`: （可选）用于定义特定记录标识符或进行记录管理。
* `[RESTART]`: （可选）如果设置为 `true`，则在添加记录后重新启动 `DNS` 服务。
* `[TTL]`: （可选）时间到生存（`TTL`）值，表示 `DNS` 记录在缓存中可以存在的时间长度。

### 示例

#### 示例 1: 添加 A 记录

```bash
v-add-dns-record admin example.com www A 192.168.1.1
```

上述命令将在 `example.com` 域名下添加一个名为 `www` 的 A 记录，其值为 `192.168.1.1`。

#### 示例 2: 添加 CNAME 记录

```bash
v-add-dns-record admin example.com blog CNAME blog.example.net
```

此命令将在 `example.com` 域名下添加一个名为 `blog` 的 CNAME 记录，其值为 `blog.example.net`。

#### 示例 3: 添加 MX 记录

```bash
v-add-dns-record admin example.com mail MX 10 mail.example.com
```

这个命令在 `example.com` 域名下添加了一个名为 `mail` 的 MX 记录，其值为 `mail.example.com`，并设置了优先级为 10。

#### 示例 4: 添加 TXT 记录（包含重启和 TTL）

```bash
v-add-dns-record admin example.com txt TXT "v=spf1 a mx ~all" true 3600
```

此命令添加了一个 TXT 记录，并指定了重启 DNS 服务和 TTL 值为 3600 秒。

### 注意事项

* 在使用 `v-add-dns-record` 命令时，请确保您有足够的权限来执行此操作。
* 根据您的 DNS 服务器配置和 Hestia 的安装情况，可能需要额外的步骤或配置才能成功添加 DNS 记录。
* 在添加 DNS 记录后，请确保进行适当的测试，以确保新记录按预期工作。

## v-add-remote-dns-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-remote-dns-domain)

`v-add-remote-dns-domain` 是 Hestia 提供的一个命令行接口（CLI）命令，用于在远程服务器上同步 DNS 域名。此命令允许用户通过简单的参数输入，实现与远程 DNS 服务器的域名同步功能。

### 命令格式

```bash
v-add-remote-dns-domain USER DOMAIN [FLUSH]
```

* `USER`: 远程服务器的认证用户名。
* `DOMAIN`: 需要同步的域名。
* `[FLUSH]`: 可选参数，用于指定是否刷新 DNS 缓存。如果提供此参数，则刷新缓存；否则不刷新。

### 示例

#### 示例 1: 同步域名，不刷新缓存

```bash
v-add-remote-dns-domain admin mydomain.tld
```

在这个示例中，我们使用 `admin` 作为用户名，将 `mydomain.tld` 这个域名同步到远程 DNS 服务器，并且不刷新 DNS 缓存。

#### 示例 2: 同步域名，并刷新缓存

```bash
v-add-remote-dns-domain admin mydomain.tld yes
```

在这个示例中，我们同样使用 `admin` 作为用户名，将 `mydomain.tld` 这个域名同步到远程 DNS 服务器，并且指定刷新 DNS 缓存。

### 注意事项

* 使用此命令前，请确保已经正确配置了与远程 DNS 服务器的连接参数（如用户名、密码等）。
* 如果远程 DNS 服务器启用了认证机制，确保提供的用户名和密码正确无误。
* 刷新 DNS 缓存可能会影响到其他用户对该域名的访问，请在必要的情况下谨慎使用。

### 结论

`v-add-remote-dns-domain` 命令是 Hestia 提供的一个强大的工具，它允许用户通过简单的命令行操作，实现与远程 DNS 服务器的域名同步功能。通过合理的参数设置和谨慎的操作，可以大大提高域名管理的效率和安全性。

## v-add-remote-dns-host

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-remote-dns-host)

`v-add-remote-dns-host` 是 Hestia 提供的一个命令行接口（CLI）命令，用于向 DNS 集群中添加远程 DNS 服务器。通过此命令，用户可以轻松地将新的 DNS 服务器集成到现有的 Hestia DNS 集群中，以提高 DNS 解析的可靠性、性能或支持负载均衡等需求。

### 命令语法

```bash
v-add-remote-dns-host HOST PORT USER PASSWORD [TYPE] [DNS_USER]
```

* **HOST**：远程 DNS 服务器的地址或主机名。
* **PORT**：远程 DNS 服务器用于通信的端口号。
* **USER**：连接远程 DNS 服务器所需的用户名。
* **PASSWORD**：连接远程 DNS 服务器所需的密码（或者使用 API 密钥作为替代）。
* **TYPE**（可选）：连接远程 DNS 服务器的类型（如 'api' 或 'ssh'）。默认为 'api'。
* **DNS_USER**（可选）：DNS 集群中用于标识此远程 DNS 服务器的用户名。默认为 'dns-cluster'。

### 示例

#### 示例 1：使用密码连接远程 DNS 服务器

```bash
v-add-remote-dns-host slave.your_host.com 8083 admin your_passw0rd
```

在这个示例中，我们使用密码 `your_passw0rd` 和用户名 `admin` 来连接位于 `slave.your_host.com` 主机上，端口为 `8083` 的远程 DNS 服务器。

#### 示例 2：使用 API 密钥连接远程 DNS 服务器

```bash
v-add-remote-dns-host slave.your_host.com 8083 api_key ''
```

在这个示例中，我们使用 API 密钥 `api_key` 来连接远程 DNS 服务器。由于 API 密钥用于身份验证，因此密码字段留空。

#### 示例 3：指定连接类型和 DNS 用户名

```bash
v-add-remote-dns-host slave.your_host.com 8083 admin your_passw0rd ssh custom_dns_user
```

在这个示例中，我们使用 SSH 类型（`ssh`）来连接远程 DNS 服务器，并使用自定义的 DNS 用户名 `custom_dns_user` 来标识此服务器。

### 注意事项

* 在使用此命令之前，请确保远程 DNS 服务器已正确配置并可以接受来自 Hestia 的连接请求。
* 根据您的安全策略，您可能需要使用加密的连接（如 SSH）来传输敏感信息（如密码或 API 密钥）。
* 如果远程 DNS 服务器要求使用特定的连接类型或身份验证方法，请确保在命令中指定正确的参数。
* 如果您在添加远程 DNS 服务器时遇到任何问题，请查阅 Hestia 的官方文档或联系技术支持以获取帮助。
* 使用[v-generate-api-key](/docs/reference/apis.html#v-generate-api-key)可用于查看连接远程dns服务器

## v-add-remote-dns-record

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-remote-dns-record)

### 简介

`v-add-remote-dns-record` 是 Hestia 提供的命令行接口（CLI）命令之一，用于向远程 DNS 服务器添加域名记录。该命令将本地 DNS 记录与远程服务器同步，确保 DNS 解析的正确性和实时性。

### 语法

```bash
v-add-remote-dns-record USER DOMAIN ID
```

* `USER`：指定操作的用户名。
* `DOMAIN`：要添加记录的域名。
* `ID`：要添加的 DNS 记录的唯一标识符。

### 示例

#### 示例 1：添加单个 DNS 记录

假设我们要为用户 `bob` 在 `acme.com` 域名下添加一个 ID 为 `23` 的 DNS 记录，可以执行以下命令：

```bash
v-add-remote-dns-record bob acme.com 23
```

执行后，系统将根据提供的参数，在远程 DNS 服务器上添加相应的 DNS 记录。

#### 示例 2：批量添加 DNS 记录

如果我们需要批量添加多个 DNS 记录，可以结合 shell 脚本或循环结构来实现。以下是一个简单的示例，展示如何为多个用户添加 DNS 记录：

```bash
#!/bin/bash

users=(`alice` `bob` `charlie`)
domains=(`example.com` `test.com` `demo.com`)
ids=(`1` `2` `3`)

for i in {0..2}; do
    user=${users[$i]}
    domain=${domains[$i]}
    id=${ids[$i]}
    
    v-add-remote-dns-record `$user` `$domain` `$id`
done
```

在上面的示例中，我们定义了一个包含用户名、域名和 ID 的数组，并使用 for 循环遍历这些数组，依次调用 `v-add-remote-dns-record` 命令来添加 DNS 记录。

### 注意事项

* 在使用 `v-add-remote-dns-record` 命令之前，请确保已经正确配置了 Hestia 和远程 DNS 服务器的连接信息。
* 请确保提供的用户名、域名和 ID 参数正确无误，以避免添加错误的 DNS 记录。
* 如果在添加 DNS 记录时遇到问题，请检查 Hestia 的日志文件或联系技术支持以获取帮助。

### 结论

`v-add-remote-dns-record` 命令是 Hestia 提供的一个强大的工具，用于将本地 DNS 记录与远程服务器同步。通过正确的参数和用法，可以轻松地添加和管理 DNS 记录，确保网络服务的正常运行。

## v-delete-remote-dns-record

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-remote-dns-record)

### 概述

`v-delete-remote-dns-record` 命令是用于从远程DNS服务器上删除指定用户的DNS域记录的命令行工具。它基于Hestia Control Panel（HestiaCP）的框架进行开发，允许管理员或授权用户轻松管理DNS记录。

### 语法

```bash
v-delete-remote-dns-record USER DOMAIN ID
```

- `USER`: 要删除DNS记录的用户名。
- `DOMAIN`: 要删除DNS记录的域名。
- `ID`: 要删除的DNS记录的ID。

### 示例

### 示例 1: 删除指定用户的DNS记录

假设要删除用户`john`在`example.com`域名下的ID为`123`的DNS记录，可以使用以下命令：

```bash
v-delete-remote-dns-record john example.com 123
```

### 示例 2: 批量删除（注意：实际环境中不建议直接进行批量删除操作）

虽然`v-delete-remote-dns-record`命令本身不支持直接批量删除，但你可以通过编写脚本来实现这一功能。例如，你可以编写一个bash脚本来遍历所有用户、域名和ID，并执行删除操作（请确保在实际使用前充分测试并备份数据）。

### 注意事项

1. **权限**：只有具有足够权限的用户才能执行此命令。通常，这需要管理员或具有相应权限的HestiaCP用户。
2. **备份**：在执行任何删除操作之前，请确保已备份相关数据和配置。虽然`v-delete-remote-dns-record`命令旨在安全地删除记录，但始终建议谨慎行事。
3. **只读模式**：如果HestiaCP处于只读模式（例如，在演示环境中），则无法执行删除操作。在执行命令之前，请检查HestiaCP的状态。
4. **验证**：在执行删除操作后，请验证记录是否已从远程DNS服务器上成功删除。你可以使用其他DNS工具或命令（如`dig`或`nslookup`）来验证这一点。
5. **错误处理**：如果命令执行失败（例如，由于权限不足、无效的参数或网络问题），请查看命令输出以获取错误消息，并根据需要进行故障排除。

### 结论

`v-delete-remote-dns-record`命令是Hestia Control Panel（HestiaCP）提供的一个强大工具，用于从远程DNS服务器上删除指定用户的DNS域记录。通过遵循上述语法和注意事项，你可以安全、有效地使用此命令来管理你的DNS记录。

## v-delete-remote-dns-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-remote-dns-domain)

## v-delete-remote-dns-domain 命令文档

### 概述

`v-delete-remote-dns-domain` 命令用于删除远程服务器上的 DNS 域名记录。此命令与 Hestia 控制面板的 DNS 管理功能相结合，允许用户通过命令行界面轻松地管理 DNS 记录。

### 语法


```bash
v-delete-remote-dns-domain USER DOMAIN
```
* `USER`: 用户名，用于标识 DNS 记录的所有者。
* `DOMAIN`: 要删除的 DNS 域名的名称。

### 示例

1. 删除名为 `example.com` 的 DNS 域名记录，用户名为 `john`:


```bash
v-delete-remote-dns-domain john example.com
```
2. 假设你有一个脚本或自动化任务，想要删除多个域名，你可以使用循环或脚本来实现：


```bash
#!/bin/bash

domains=(`example.com` `anotherexample.net` `thirddomain.org`)
user=`admin`

for domain in `${domains[@]}`; do
    v-delete-remote-dns-domain $user $domain
    echo `Deleted DNS domain: $domain`
done
```
### 注意事项

* 在执行此命令之前，请确保您具有足够的权限来删除 DNS 记录。
* 确保您已正确配置 Hestia 控制面板，并且该命令可以在您的系统上正确执行。
* 在删除 DNS 记录之前，请确保没有其他服务或应用依赖于该记录，因为这可能会导致服务中断或功能失效。

### 故障排除

* 如果命令执行失败，请检查您的用户名和域名是否正确。
* 确保 Hestia 控制面板正在运行，并且网络连接没有问题。
* 查看 Hestia 的日志文件以获取更详细的错误信息，这可能会帮助您诊断问题。

### 总结

`v-delete-remote-dns-domain` 命令为 Hestia 控制面板的用户提供了一个方便的工具，用于通过命令行界面删除远程服务器上的 DNS 域名记录。通过正确的使用和配置，此命令可以大大简化 DNS 管理任务。

## v-delete-remote-dns-domains

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-remote-dns-domains)

### 概述

`v-delete-remote-dns-domain` 命令用于删除远程服务器上的 DNS 域名记录。此命令与 Hestia 控制面板的 DNS 管理功能相结合，允许用户通过命令行界面轻松地管理 DNS 记录。

### 语法

```bash
v-delete-remote-dns-domain USER DOMAIN
```

* `USER`: 用户名，用于标识 DNS 记录的所有者。
* `DOMAIN`: 要删除的 DNS 域名的名称。

### 示例

1. 删除名为 `example.com` 的 DNS 域名记录，用户名为 `john`:

```bash
v-delete-remote-dns-domain john example.com
```

2. 假设你有一个脚本或自动化任务，想要删除多个域名，你可以使用循环或脚本来实现：

```bash
#!/bin/bash

domains=(`example.com` `anotherexample.net` `thirddomain.org`)
user=`admin`

for domain in `${domains[@]}`; do
    v-delete-remote-dns-domain $user $domain
    echo `Deleted DNS domain: $domain`
done
```

### 注意事项

* 在执行此命令之前，请确保您具有足够的权限来删除 DNS 记录。
* 确保您已正确配置 Hestia 控制面板，并且该命令可以在您的系统上正确执行。
* 在删除 DNS 记录之前，请确保没有其他服务或应用依赖于该记录，因为这可能会导致服务中断或功能失效。

### 故障排除

* 如果命令执行失败，请检查您的用户名和域名是否正确。
* 确保 Hestia 控制面板正在运行，并且网络连接没有问题。
* 查看 Hestia 的日志文件以获取更详细的错误信息，这可能会帮助您诊断问题。

### 总结

`v-delete-remote-dns-domain` 命令为 Hestia 控制面板的用户提供了一个方便的工具，用于通过命令行界面删除远程服务器上的 DNS 域名记录。通过正确的使用和配置，此命令可以大大简化 DNS 管理任务。

## v-delete-remote-dns-host

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-remote-dns-host)

### 概述

`v-delete-remote-dns-host` 命令用于从 Hestia Control Panel（HestiaCP）的 DNS 集群配置中删除远程 DNS 服务器。该命令会移除指定的远程 DNS 主机，并在没有剩余主机时，可能会删除相关的集群配置和系统任务。

### 语法

```bash
v-delete-remote-dns-host HOST
```

- `HOST`: 要从 DNS 集群配置中删除的远程 DNS 服务器的名称或标识符。

### 示例

#### 示例 1: 删除名为 ns1.example.com 的远程 DNS 主机

```bash
v-delete-remote-dns-host ns1.example.com
```

#### 示例 2: 使用脚本批量删除远程 DNS 主机

假设你有一个包含多个要删除的远程 DNS 主机名称的列表，并希望使用脚本来批量删除它们。以下是一个简单的 bash 脚本示例：

```bash
#!/bin/bash

# 要删除的远程 DNS 主机列表
hosts=(`ns1.example.com` `ns2.example.com` `ns3.example.org`)

# 遍历列表并执行删除命令
for host in `${hosts[@]}`; do
    v-delete-remote-dns-host `$host`
    echo `已删除远程 DNS 主机: $host`
done
```

### 注意事项

1. **权限**：确保你以具有足够权限的用户身份运行此命令，通常是 HestiaCP 的管理员用户。
2. **备份**：在删除任何配置之前，请确保备份了相关的配置文件，以便在需要时可以恢复。
3. **集群状态**：在删除最后一个远程 DNS 主机时，此命令将删除相关的 DNS 集群配置文件和系统任务。请确保这是你期望的行为。
4. **系统日志**：此命令将在系统日志中记录删除操作的信息。

### 故障排除

1. **权限问题**：如果你遇到权限错误，请检查你是否以具有足够权限的用户身份运行命令。
2. **配置问题**：如果命令无法找到指定的远程 DNS 主机或无法删除它，请检查 `dns-cluster.conf` 配置文件，确保其中包含了正确的远程 DNS 主机信息。
3. **日志文件**：查看 HestiaCP 的日志文件以获取更详细的错误信息，这可能会帮助你诊断问题。

### 总结

`v-delete-remote-dns-host` 命令是一个强大的工具，用于从 HestiaCP 的 DNS 集群配置中删除远程 DNS 主机。通过遵循上述语法和注意事项，你可以安全、有效地使用该命令来管理你的 DNS 集群配置。

## v-delete-dns-domains-src

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-dns-domains-src)

### 概述

`v-delete-dns-domains-src` 命令用于根据指定的 `SRC` 字段删除相关的 DNS 域名。此命令特别适用于批量删除与特定主机或源相关的 DNS 记录。

### 语法

```bash
v-delete-dns-domains-src USER SRC [RESTART]
```

- `USER`: 用于指定 DNS 记录的所有者的用户名。
- `SRC`: 用于搜索相关 DNS 记录的 `SRC` 字段值。
- `[RESTART]`: 可选参数，如果设置为 `yes`，则在删除完成后重启 DNS 服务器（默认为不重启）。

### 示例

#### 示例 1: 删除所有与特定 `SRC` 相关的 DNS 域名，但不重启 DNS 服务器

```bash
v-delete-dns-domains-src admin example.com
```

此命令将删除所有与 `SRC` 字段值为 `example.com` 的 DNS 域名，但不会重启 DNS 服务器。

#### 示例 2: 删除所有与空 `SRC` 相关的 DNS 域名，并重启 DNS 服务器

```bash
v-delete-dns-domains-src admin '' yes
```

此命令将删除所有 `SRC` 字段值为空的 DNS 域名，并在删除完成后重启 DNS 服务器。

### 注意事项

- 在执行此命令之前，请确保您已经备份了相关的 DNS 配置和记录，以防意外删除。
- 如果启用了只读模式（Hestia Demo Mode），则无法执行删除操作。
- 在执行重启操作之前，请确保当前没有正在进行的 DNS 查询或更新操作，以避免服务中断。

### 故障排除

- 如果命令执行失败，请检查您提供的 `USER` 和 `SRC` 参数是否正确。
- 确保 HestiaCP 正常运行，并且您有足够的权限执行此命令。
- 检查 HestiaCP 的日志文件以获取更详细的错误信息。

### 总结

`v-delete-dns-domains-src` 命令是一个强大的工具，可以帮助您批量删除与特定 `SRC` 字段相关的 DNS 域名。通过正确设置参数，您可以轻松管理 DNS 记录并维护您的 DNS 系统。请务必谨慎使用此命令，并确保在执行之前备份相关配置和记录。

## v-delete-dns-domains

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-dns-domains)

### 概述

`v-delete-dns-domains` 命令用于删除指定用户的所有 DNS 域名。这是一个强大的工具，允许管理员轻松管理 DNS 记录，尤其是在需要批量删除特定用户所有 DNS 域名的情况下。

### 语法

```bash
v-delete-dns-domains USER [RESTART]
```

- `USER`: 必需参数，指定要删除 DNS 域名的用户名。
- `[RESTART]`: 可选参数，如果设置为 `yes`，则在删除完成后重启 DNS 服务器（默认为不重启）。

### 示例

#### 示例 1: 删除用户 `bob` 的所有 DNS 域名，但不重启 DNS 服务器

```bash
v-delete-dns-domains bob
```

执行上述命令后，系统将删除用户 `bob` 下的所有非暂停状态的 DNS 域名，但不会重启 DNS 服务器。

#### 示例 2: 删除用户 `alice` 的所有 DNS 域名，并重启 DNS 服务器

```bash
v-delete-dns-domains alice yes
```

此命令将删除用户 `alice` 下的所有非暂停状态的 DNS 域名，并在删除完成后重启 DNS 服务器。

### 注意事项

- 在执行此命令之前，请确保您已经备份了相关的 DNS 配置和记录，以防意外删除。
- 如果启用了只读模式（Hestia Demo Mode），则无法执行删除操作。
- 在执行重启操作之前，请确保当前没有正在进行的 DNS 查询或更新操作，以避免服务中断。

### 故障排除

- 如果命令执行失败，请检查您提供的 `USER` 参数是否正确。
- 确保 HestiaCP 正常运行，并且您有足够的权限执行此命令。
- 检查 HestiaCP 的日志文件以获取更详细的错误信息。

### 总结

`v-delete-dns-domains` 命令为管理员提供了一个快速、方便的方式来删除指定用户的所有 DNS 域名。通过正确设置参数，您可以轻松管理 DNS 记录并维护您的 DNS 系统。请务必谨慎使用此命令，并确保在执行之前备份相关配置和记录。

## v-delete-dns-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-dns-domain)

### 概述

`v-delete-dns-domain` 命令用于删除指定用户的单个 DNS 域名记录。此命令可以处理 DNSSEC（域名系统安全扩展）相关的密钥文件，以及 DNS 集群环境下的远程删除操作。

### 语法

```bash
v-delete-dns-domain USER DOMAIN [RESTART]
```

- `USER`: 必需参数，指定要删除 DNS 域名的用户名。
- `DOMAIN`: 必需参数，指定要删除的 DNS 域名。
- `[RESTART]`: 可选参数，如果设置为 `yes`，则在删除完成后重启 DNS 服务器（默认为不重启）。

### 示例

#### 示例 1: 删除用户 `bob` 的 `example.com` 域名，但不重启 DNS 服务器

```bash
v-delete-dns-domain bob example.com
```

#### 示例 2: 删除用户 `alice` 的 `example.org` 域名，并重启 DNS 服务器

```bash
v-delete-dns-domain alice example.org yes
```

### 流程说明

1. **参数验证**：检查提供的参数数量是否正确，验证用户、域名格式以及系统是否启用 DNS 功能。
2. **检查只读模式**：如果启用了 HestiaCP 的只读模式（Demo Mode），则无法执行删除操作。
3. **查找和删除 DNS 记录**：
   - 从 DNS 配置文件中移除指定域名的引用。
   - 如果启用了 DNSSEC，则删除相关的密钥文件。
   - 如果配置了 DNS 集群，则通过管道发送远程删除命令。
   - 从用户 DNS 配置文件和目录中删除域名的具体配置和数据库文件。
4. **更新用户统计信息**：减少用户的 DNS 域名和记录计数。
5. **重启 DNS 服务器**：如果指定了 `RESTART` 参数，则重启 DNS 服务器。
6. **记录日志**：记录删除操作的相关信息。

### 注意事项

- 在执行删除操作之前，请确保您已经备份了相关的 DNS 配置和记录。
- 如果启用了 DNSSEC，并且删除了启用了 DNSSEC 的域名，请确保所有相关的密钥文件都已正确删除。
- 如果配置了 DNS 集群，远程删除操作可能会稍慢，具体取决于集群中的节点数量和响应速度。
- 在执行重启操作之前，请确保当前没有正在进行的 DNS 查询或更新操作，以避免服务中断。

### 故障排除

- 如果命令执行失败，请检查您提供的 `USER` 和 `DOMAIN` 参数是否正确。
- 确保 HestiaCP 正常运行，并且您有足够的权限执行此命令。
- 检查 HestiaCP 的日志文件以获取更详细的错误信息。

### 总结

`v-delete-dns-domain` 命令为管理员提供了一个灵活的方式来删除指定用户的单个 DNS 域名记录。通过正确设置参数，您可以轻松管理 DNS 记录并维护您的 DNS 系统。请务必谨慎使用此命令，并确保在执行之前备份相关配置和记录。

## v-change-dns-domain-dnssec

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-dns-domain-dnssec)

### 概述

`v-change-dns-domain-dnssec` 是 Hestia 提供的一个命令行接口（CLI）命令，用于更改指定 DNS 域的 DNSSEC（域名系统安全扩展）状态。DNSSEC 是一种安全技术，用于保护 DNS 数据的完整性和来源验证。

### 语法

```bash
v-change-dns-domain-dnssec USER DOMAIN STATUS
```

* `USER`: 拥有 DNS 域的用户名。
* `DOMAIN`: 要更改 DNSSEC 状态的 DNS 域名。
* `STATUS`: DNSSEC 的新状态，可以是 `yes` 或 `no`。

### 示例

#### 示例 1: 启用 DNSSEC

```bash
v-change-dns-domain-dnssec admin example.com yes
```

在这个示例中，我们为 `admin` 用户拥有的 `example.com` 域名启用了 DNSSEC。

#### 示例 2: 禁用 DNSSEC

```bash
v-change-dns-domain-dnssec john doejohn.net no
```

在这个示例中，我们为 `john` 用户拥有的 `doejohn.net` 域名禁用了 DNSSEC。

### 注意事项

1. **权限**：执行此命令的用户需要具有对指定 DNS 域的管理权限。
2. **DNSSEC 支持**：在更改 DNSSEC 状态之前，请确保您的 DNS 服务器支持 DNSSEC。
3. **系统配置**：DNSSEC 的启用和禁用可能需要额外的系统配置。请确保您已正确配置了所有必要的设置。
4. **验证**：在更改 DNSSEC 状态后，请验证更改是否已生效。您可以使用 DNS 查询工具（如 dig 或 nslookup）来验证 DNSSEC 的状态。
5. **错误处理**：如果命令执行失败，请检查提供的参数是否正确，以及您是否具有足够的权限来执行此操作。此外，请查看 Hestia 的日志文件以获取更多错误详细信息。

### 结论

`v-change-dns-domain-dnssec` 命令是 Hestia 提供的一个强大工具，用于更改 DNS 域的 DNSSEC 状态。通过此命令，您可以轻松地启用或禁用 DNSSEC，以提高 DNS 数据的安全性和可靠性。请确保在更改 DNSSEC 状态之前备份所有重要数据，并遵循上述注意事项以避免潜在问题。

## v-change-dns-domain-exp

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-dns-domain-exp)

### 概述

`v-change-dns-domain-exp` 是 Hestia 提供的一个命令行接口（CLI）命令，用于更改指定 DNS 域的 SOA（起始授权机构）记录的过期时间。SOA 记录是 DNS 区域文件中的一个关键部分，用于定义区域的授权信息、刷新间隔、重试间隔、过期时间和否定缓存时间。

### 语法

```bash
v-change-dns-domain-exp USER DOMAIN EXP
```

- `USER`: 拥有 DNS 域的用户名。
- `DOMAIN`: 要更改 SOA 过期时间的 DNS 域名。
- `EXP`: 新的 SOA 过期时间值，通常是一个表示时间间隔的整数，例如秒数、天数等。

### 示例

#### 示例 1: 更改域名的 SOA 过期时间为 3600 秒

```bash
v-change-dns-domain-exp admin example.com 3600
```

在这个示例中，我们为 `admin` 用户拥有的 `example.com` 域名设置了 SOA 过期时间为 3600 秒（即 1 小时）。

#### 示例 2: 更改域名的 SOA 过期时间为 1 天

请注意，不同的 DNS 服务器和配置可能使用不同的时间单位。在这个示例中，我们假设使用秒作为时间单位，并将 1 天转换为秒数（86400 秒）。

```bash
v-change-dns-domain-exp john doejohn.net 86400
```

在这个示例中，我们为 `john` 用户拥有的 `doejohn.net` 域名设置了 SOA 过期时间为 86400 秒（即 1 天）。

### 注意事项

1. **权限**：执行此命令的用户需要具有对指定 DNS 域的管理权限。
2. **DNS 服务器配置**：更改 SOA 过期时间可能需要 DNS 服务器进行相应的配置更新。请确保您的 DNS 服务器支持此操作，并正确配置了相关的参数。
3. **集群环境**：如果您的 DNS 环境配置为集群模式（`DNS_CLUSTER` 设置为 `yes`），则更改将同步到集群中的所有 DNS 服务器。这可能需要一些时间来传播更改。
4. **错误处理**：如果命令执行失败，请检查提供的参数是否正确，以及您是否具有足够的权限来执行此操作。此外，请查看 Hestia 的日志文件以获取更多错误详细信息。

### 结论

`v-change-dns-domain-exp` 命令是 Hestia 提供的一个方便的工具，用于更改 DNS 域的 SOA 过期时间。通过此命令，您可以灵活地调整域名的 SOA 记录，以满足您的特定需求。请确保在更改 SOA 过期时间之前备份所有重要数据，并遵循上述注意事项以避免潜在问题。

## v-change-dns-domain-ip

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-dns-domain-ip)

### 简介

`v-change-dns-domain-ip` 是 Hestia 提供的一个命令行接口（CLI）命令，用于更改 DNS 区域的主 IP 地址。该命令允许管理员或具有适当权限的用户轻松更新 DNS 记录中的 IP 地址，无需手动编辑配置文件或使用复杂的 DNS 管理工具。

### 语法

```bash
v-change-dns-domain-ip USER DOMAIN IP [RESTART]
```

- `USER`: 具有足够权限来更改 DNS 设置的用户名。
- `DOMAIN`: 要更改其 IP 地址的 DNS 区域的域名。
- `IP`: 新的 IP 地址，用于替换 DNS 区域中的当前 IP 地址。
- `[RESTART]`: 可选参数，如果提供，则会在更改 IP 地址后重新启动 DNS 服务。

### 示例

#### 示例 1: 更改 DNS 区域的 IP 地址

```bash
v-change-dns-domain-ip admin example.com 192.168.1.1
```

在此示例中，管理员 `admin` 将 `example.com` DNS 区域的 IP 地址更改为 `192.168.1.1`。未指定 `[RESTART]` 参数，因此 DNS 服务不会自动重启。

#### 示例 2: 更改 DNS 区域的 IP 地址并重启服务

```bash
v-change-dns-domain-ip admin example.com 192.168.1.2 RESTART
```

在此示例中，除了更改 IP 地址外，还指定了 `[RESTART]` 参数。因此，在更新 `example.com` DNS 区域的 IP 地址后，DNS 服务将被重新启动。

#### 示例 3: 错误用法

```bash
v-change-dns-domain-ip admin example.com
```

此示例会导致错误，因为未提供必要的 `IP` 参数。

### 注意事项

- 在使用 `v-change-dns-domain-ip` 命令之前，请确保您具有足够的权限来更改 DNS 设置。
- 更改 DNS 区域的 IP 地址可能会影响与该区域关联的所有服务和应用程序。请确保在更改 IP 地址之前通知所有相关方，并测试所有依赖于此 DNS 区域的服务以确保它们可以正确解析新的 IP 地址。
- 如果指定了 `[RESTART]` 参数，请确保 DNS 服务可以在更改后成功重启，并且所有相关的备份和恢复策略都已到位，以防出现意外情况。

### 结论

`v-change-dns-domain-ip` 命令是 Hestia 提供的一个强大工具，允许管理员轻松更改 DNS 区域的主 IP 地址。通过遵循正确的语法和注意事项，您可以安全、高效地更新 DNS 记录中的 IP 地址，从而确保您的服务和应用程序始终指向正确的 IP 地址。

## v-change-dns-domain-soa

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-dns-domain-soa)

### 概述

`v-change-dns-domain-soa` 命令是 Hestia Control Panel 提供的一个 CLI 工具，用于修改指定 DNS 区域的 Start of Authority (SOA) 记录。SOA 记录是 DNS 区域文件中的一个重要部分，它包含了管理该区域的权威名称服务器的信息，以及区域文件的各种时间戳。

### 语法

```bash
v-change-dns-domain-soa [OPTIONS] USER DOMAIN PRIMARY_NS EMAIL SERIAL REFRESH RETRY EXPIRE
```

- `USER`: 执行操作的 Hestia 用户。
- `DOMAIN`: 要修改的 DNS 区域的域名。
- `PRIMARY_NS`: 新的主名称服务器（Primary Name Server）。
- `EMAIL`: 负责 DNS 区域的管理员电子邮件地址（通常使用点号代替@符号）。
- `SERIAL`: 新的序列号（Serial Number），用于标识区域文件的版本。
- `REFRESH`: 刷新时间间隔（Refresh Interval），指定从服务器多久检查主服务器是否有更新。
- `RETRY`: 重试时间间隔（Retry Interval），指定如果主服务器不可用时，从服务器多久后再次尝试联系主服务器。
- `EXPIRE`: 过期时间（Expiration Time），指定如果在此时间间隔内无法从主服务器获取区域文件，则从服务器将不再使用该区域文件。

### 选项

- `[OPTIONS]`: 额外的命令选项，可能包括认证凭据、输出格式等。具体取决于 Hestia 的实现和配置。

### 示例

#### 示例 1: 修改 SOA 记录

```bash
v-change-dns-domain-soa admin example.com ns1.example.com hostmaster.example.com 2023040101 3600 600 86400
```

在这个示例中，我们为 `example.com` 域名修改了 SOA 记录。新的主名称服务器是 `ns1.example.com`，管理员电子邮件地址是 `hostmaster.example.com`（注意这里使用点号代替@符号），新的序列号是 `2023040101`，刷新时间间隔是 `3600` 秒，重试时间间隔是 `600` 秒，过期时间是 `86400` 秒。

#### 示例 2: 使用环境变量进行身份验证

如果你的 Hestia 环境要求使用特定的环境变量进行身份验证，你可以像这样设置它们：

```bash
export HESTIA_USER=admin
export HESTIA_PASS=mysecretpassword
v-change-dns-domain-soa example.com ns2.example.com hostmaster.example.com 2023040102 3600 600 86400
```

在这个示例中，我们首先设置了 `HESTIA_USER` 和 `HESTIA_PASS` 环境变量来提供身份验证凭据，然后运行 `v-change-dns-domain-soa` 命令。注意我们没有在命令中明确指定 `USER` 参数，因为 Hestia 会从环境变量中读取它。

### 注意事项

- 在运行此命令之前，请确保你有足够的权限来修改指定的 DNS 区域。
- 修改 SOA 记录可能会影响 DNS 解析的稳定性和性能，因此请谨慎操作。
- 在修改 SOA 记录之前，请确保你已经了解了这些参数的含义和它们如何影响 DNS 解析。
- 如果在修改 SOA 记录后遇到任何问题，请查看 Hestia 的日志文件以获取更多信息，并考虑回滚到之前的配置。

## v-change-dns-domain-tpl

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-dns-domain-tpl)

### v-change-dns-domain-tpl 命令详解

`v-change-dns-domain-tpl` 是 Hestia 提供的命令行工具，用于更改 DNS 记录的模板。通过此命令，您可以更新旧的 DNS 记录，并根据新的模板参数生成新的记录。

### 使用方法

```bash
v-change-dns-domain-tpl USER DOMAIN TEMPLATE [RESTART]
```

### 参数说明

- `USER`: 用户名，用于标识执行操作的用户。
- `DOMAIN`: 要更改模板的域名。
- `TEMPLATE`: 新的 DNS 记录模板。
- `[RESTART]`: 可选参数，用于指定是否需要重启相关服务以应用更改。通常设置为 `yes` 或 `no`。

### 示例

#### 示例 1: 更改域名模板并重启服务

```bash
v-change-dns-domain-tpl admin example.com child-ns yes
```

在此示例中，我们为 `admin` 用户下的 `example.com` 域名更改了 DNS 记录模板为 `child-ns`，并指定了重启服务以应用更改。

#### 示例 2: 更改域名模板但不重启服务

```bash
v-change-dns-domain-tpl user123 mysite.com default-tpl no
```

在这个例子中，我们为 `user123` 用户下的 `mysite.com` 域名更改了 DNS 记录模板为 `default-tpl`，但指定了不重启服务。

### 注意事项

- 在执行此命令之前，请确保您已正确设置了 Hestia 的环境变量和配置文件。
- 更改 DNS 模板可能会影响到您的网站和其他服务的解析。请在执行之前谨慎考虑并备份相关数据。
- 如果您指定了 `RESTART` 参数为 `yes`，请确保重启服务不会影响到您正在运行的其他重要服务或任务。

### 结论

`v-change-dns-domain-tpl` 命令为 Hestia 用户提供了一个方便的方式来更改 DNS 记录的模板。通过此命令，您可以轻松地更新旧的 DNS 记录并生成新的记录，以满足您的需求。请根据您的实际情况选择适当的参数和选项，并谨慎执行此命令。

## v-change-dns-domain-ttl

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-dns-domain-ttl)

### 简介

`v-change-dns-domain-ttl` 是 Hestia 提供的一个命令行接口（CLI）命令，用于更改指定 DNS 域的 TTL（Time to Live）值。TTL 定义了 DNS 记录被缓存的时间长度，它对于控制 DNS 解析的速度和准确性至关重要。

### 语法

```bash
v-change-dns-domain-ttl USER DOMAIN TTL [OPTIONS]
```

### 参数

* `USER`: 用户名，用于验证和授权更改。
* `DOMAIN`: 要更改 TTL 的 DNS 域名。
* `TTL`: 新的 TTL 值，通常是一个介于几分钟到几天之间的整数。
* `[OPTIONS]`: 可选参数，用于控制命令的行为。

### 示例

#### 示例 1: 更改 TTL 到 3600 秒

```bash
v-change-dns-domain-ttl admin example.com 3600
```

此命令将 `example.com` 的 TTL 值更改为 3600 秒（即 1 小时）。

#### 示例 2: 使用可选参数（假设存在）

假设 `v-change-dns-domain-ttl` 命令支持一个 `--force` 选项来强制更改 TTL，即使存在某些警告或错误：

```bash
v-change-dns-domain-ttl admin example.com 3600 --force
```

#### 示例 3: 错误用法

```bash
v-change-dns-domain-ttl admin example.com `1 day`
```

注意：此命令将失败，因为 TTL 值应该是一个整数，而不是一个字符串（如 `1 day`）。

### 注意事项

* 在更改 TTL 之前，请确保了解 TTL 的作用和潜在影响。
* 更改 TTL 可能会影响 DNS 解析的速度和准确性，特别是在 TTL 值较大时。
* 在生产环境中更改 TTL 之前，建议先在测试环境中进行验证。

### 常见问题解答

* **问**：为什么我需要更改 TTL？
  **答**：更改 TTL 可以帮助控制 DNS 解析的缓存行为。较短的 TTL 值可以使 DNS 记录更快地更新，但会增加 DNS 查询的开销。较长的 TTL 值可以减少 DNS 查询的开销，但可能会延迟 DNS 记录的更新。
* **问**：如何确定适当的 TTL 值？
  **答**：适当的 TTL 值取决于您的具体需求和网络环境。通常，对于频繁更改的 DNS 记录（如开发或测试环境），较短的 TTL 值可能更合适。对于稳定且不太可能更改的 DNS 记录（如生产环境），较长的 TTL 值可能更合适。

### 附加信息

有关更多详细信息和选项，请参阅 Hestia 的官方文档或运行 `v-change-dns-domain-ttl --help` 命令。

## v-change-dns-record

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-dns-record)

Hestia 提供了一个强大的命令行工具 `v-change-dns-record`，用于修改 DNS 记录。该工具允许系统管理员或用户通过简单的命令来更新 DNS 域名记录，无需复杂的用户界面或额外的软件。

### 命令格式

```bash
v-change-dns-record USER DOMAIN ID RECORD TYPE VALUE [PRIORITY] [RESTART] [TTL]
```

- `USER`: 用于执行操作的 Hestia 用户名。
- `DOMAIN`: 要修改的 DNS 域名。
- `ID`: 要修改的 DNS 记录的特定 ID。
- `RECORD`: 要修改的 DNS 记录名称（例如 `@` 表示根记录）。
- `TYPE`: DNS 记录的类型（如 A, AAAA, CNAME, MX 等）。
- `VALUE`: 新的 DNS 记录值。
- `[PRIORITY]`: 某些记录类型（如 MX）可能需要优先级。
- `[RESTART]`: 是否在更改后重新启动 DNS 服务（通常为可选参数，默认为否）。
- `[TTL]`: DNS 记录的生存时间（Time To Live），以秒为单位。

### 示例

#### 示例 1: 修改 A 记录

将 `domain.ua` 的 ID 为 `42` 的 A 记录更改为 `192.18.22.43`。

```bash
v-change-dns-record admin domain.ua 42 @ A 192.18.22.43
```

#### 示例 2: 添加 MX 记录

为 `domain.ua` 添加一个 MX 记录，记录名称为 `@`（即根记录），优先级为 `10`，记录值为 `mail.domain.ua`。

```bash
v-change-dns-record admin domain.ua <new_id> @ MX mail.domain.ua 10
```

请注意，您需要替换 `<new_id>` 为实际的 DNS 记录 ID 或让系统为您生成一个新的 ID。

#### 示例 3: 带有 TTL 的修改

将 `domain.ua` 的 ID 为 `42` 的 A 记录更改为 `192.168.1.1`，并设置 TTL 为 `3600` 秒。

```bash
v-change-dns-record admin domain.ua 42 @ A 192.168.1.1 3600
```

### 注意事项

- 在执行任何 DNS 更改之前，请确保您具有足够的权限，并且了解这些更改可能对您的域名解析产生的影响。
- 如果您不确定某个参数的值或用途，请参考 Hestia 的官方文档或联系您的系统管理员。
- 在某些情况下，您可能需要重启 DNS 服务以使更改生效。这可以通过在命令中包含 `[RESTART]` 参数来实现，但请注意，这可能会导致服务短暂中断。
- TTL（生存时间）定义了 DNS 记录在被缓存之前可以在 DNS 服务器上保留的时间长度。较短的 TTL 值可以使 DNS 记录更改更快地传播到全球，但也会增加 DNS 服务器的负载。较长的 TTL 值可以减少 DNS 服务器的负载，但会使 DNS 记录更改的传播速度变慢。

### 结论

`v-change-dns-record` 是一个非常实用的命令行工具，它允许用户轻松地修改 Hestia 系统中的 DNS 记录。通过简单的命令和参数，您可以快速、准确地更新 DNS 记录，以满足您的需求。

## v-change-dns-record-id

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-dns-record-id)

`v-change-dns-record-id` 是 Hestia 提供的一个命令行接口（CLI）命令，用于更改特定 DNS 记录的值。这个命令允许用户通过指定 DNS 记录的 ID 来修改其类型、值和其他相关参数。

### 命令语法

```bash
v-change-dns-record-id [OPTIONS] USER DOMAIN ID RECORD_TYPE VALUE [PRIORITY] [RESTART] [TTL]
```

### 参数说明

* **USER**：执行操作的 Hestia 用户名。
* **DOMAIN**：要修改的 DNS 记录所属的域名。
* **ID**：要修改的 DNS 记录的 ID。
* **RECORD_TYPE**：DNS 记录的类型（如 A、AAAA、CNAME 等）。
* **VALUE**：新的 DNS 记录值。
* **PRIORITY**（可选）：仅适用于某些需要优先级的记录类型（如 MX 记录）。
* **RESTART**（可选）：如果设置为 `true`，则在更改后重启 DNS 服务。
* **TTL**（可选）：新的 TTL（生存时间）值，以秒为单位。

### 示例

#### 示例 1：修改 A 记录的值

假设我们要将 `example.com` 域名下 ID 为 `123` 的 A 记录的值从 `192.168.1.1` 更改为 `192.168.1.2`，并且不需要重启 DNS 服务，可以使用以下命令：

```bash
v-change-dns-record-id admin example.com 123 A 192.168.1.2
```

#### 示例 2：修改 MX 记录的值和优先级

假设我们要将 `mail.example.com` 域名下 ID 为 `456` 的 MX 记录的值从 `mail.example.net` 更改为 `mail2.example.net`，并且设置优先级为 `10`，同时需要重启 DNS 服务，可以使用以下命令：

```bash
v-change-dns-record-id admin mail.example.com 456 MX mail2.example.net 10 true
```

#### 示例 3：修改 TTL 值

如果我们还想在上面的 MX 记录更改中设置新的 TTL 值为 `3600` 秒（即 1 小时），可以这样做：

```bash
v-change-dns-record-id admin mail.example.com 456 MX mail2.example.net 10 true 3600
```

### 注意事项

* 使用此命令之前，请确保您已经登录到 Hestia 控制面板，并且具有足够的权限来执行 DNS 记录更改。
* 在执行可能中断服务的操作（如重启 DNS 服务）时，请确保在维护窗口或低流量时段进行。
* 如果您不确定某个 DNS 记录的类型或值，请先通过其他 Hestia CLI 命令或控制面板进行验证。

希望这个指南能帮助您有效地使用 `v-change-dns-record-id` 命令来管理 Hestia 上的 DNS 记录。

## v-update-dns-templates

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-dns-templates)

### 概述

Hestia 提供了 `v-update-dns-templates` CLI 命令，用于更新 DNS 模板。此命令允许用户根据需求修改 DNS 模板设置，确保 DNS 解析的准确性和效率。本文档将详细介绍该命令的使用方法和示例。

### 命令格式

`v-update-dns-templates` 命令的基本格式如下：

```bash
v-update-dns-templates [OPTIONS]
```

其中，`[OPTIONS]` 表示可选参数，用于指定更新 DNS 模板的特定选项。

### 示例

### 示例 1：更新所有 DNS 模板

要更新所有 DNS 模板，可以使用以下命令：

```bash
v-update-dns-templates
```

执行此命令后，Hestia 将遍历所有 DNS 模板，并根据默认设置或配置文件中的指定值进行更新。

### 示例 2：指定模板进行更新

如果只想更新特定的 DNS 模板，可以使用 `--template` 参数指定模板名称。例如，要更新名为 `example.tpl` 的模板，可以执行以下命令：

```bash
v-update-dns-templates --template example.tpl
```

### 示例 3：使用配置文件进行更新

Hestia 支持使用配置文件来指定 DNS 模板的更新选项。例如，假设有一个名为 `dns_templates.conf` 的配置文件，其中包含以下内容：

```conf
[template1]
name = template1.tpl
ttl = 3600

[template2]
name = template2.tpl
priority = 10
```

要使用该配置文件进行 DNS 模板更新，可以执行以下命令：

```bash
v-update-dns-templates --config dns_templates.conf
```

执行此命令后，Hestia 将根据 `dns_templates.conf` 配置文件中的设置来更新相应的 DNS 模板。

### 参数说明

- `--template`：指定要更新的 DNS 模板名称。如果未指定，则更新所有 DNS 模板。
- `--config`：指定包含 DNS 模板更新选项的配置文件路径。如果未指定，则使用默认设置或命令行参数。
- 其他参数（如 `--ttl`、`--priority` 等）：这些参数允许用户直接指定 DNS 模板的特定更新选项。但请注意，这些参数通常与配置文件一起使用，以提供更灵活的更新选项。

### 注意事项

- 在执行 `v-update-dns-templates` 命令之前，请确保已正确安装和配置 Hestia，并且具有足够的权限来执行 DNS 模板更新操作。
- 在更新 DNS 模板之前，请务必备份原始模板文件，以防止意外数据丢失。
- 请谨慎使用 `--config` 参数和配置文件中的设置，确保它们符合您的 DNS 配置需求。

### 总结

`v-update-dns-templates` 命令是 Hestia 提供的一个强大的工具，用于更新 DNS 模板设置。通过使用该命令，用户可以轻松地根据需求修改 DNS 模板，确保 DNS 解析的准确性和效率。本文档提供了该命令的详细使用方法和示例，希望对您有所帮助。

## v-unsuspend-remote-dns-host

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-unsuspend-remote-dns-host)

`v-unsuspend-remote-dns-host` 是一个命令行工具，用于在Hestia系统中解除远程DNS服务器的暂停状态。当DNS服务器被暂停时，它将无法处理任何DNS请求，直到它被重新启用。

### 使用方法

```bash
v-unsuspend-remote-dns-host [HOST]
```

其中，`[HOST]` 是你想要解除暂停状态的远程DNS服务器的主机名或IP地址。

### 示例

1. **解除名为`hostname.com`的DNS服务器的暂停状态**：

```bash
v-unsuspend-remote-dns-host hostname.com
```

2. **解除IP地址为`192.168.1.1`的DNS服务器的暂停状态**（请注意，虽然通常使用主机名，但IP地址在某些情况下也是有效的）：

```bash
v-unsuspend-remote-dns-host 192.168.1.1
```

### 验证与错误处理

在执行`v-unsuspend-remote-dns-host`命令之前，脚本会执行一系列的验证步骤，以确保：

* 命令接收到了正确数量的参数（在本例中为1个）。
* 提供的`HOST`参数符合预期的格式。
* DNS系统已被启用。
* 指定的主机名或IP地址在`dns-cluster`配置文件中存在。
* 该主机或IP地址当前处于暂停状态。

如果以上任何一个验证失败，脚本将显示一个错误消息并退出。

### 脚本执行

一旦所有验证都通过，脚本将更新`dns-cluster`配置文件中的相应条目，将`$SUSPENDED`的值从`yes`更改为`no`，从而解除DNS服务器的暂停状态。

### 日志记录

最后，脚本将记录一个事件到Hestia的日志系统中，以表示已成功解除了DNS服务器的暂停状态。

### 注意事项

* 在执行此命令之前，请确保您具有足够的权限来修改DNS服务器的配置。
* 在生产环境中使用此命令之前，请先在测试环境中进行验证，以确保它按预期工作。
* 如果Hestia系统处于只读模式（例如，在演示环境中），则此命令将失败并显示相应的错误消息。

## v-unsuspend-dns-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-unsuspend-dns-domain)

`v-unsuspend-dns-domain` 是Hestia系统中用于解除DNS域名暂停状态的命令行工具。当某个DNS域名被暂停时，它将不再解析，直到该域名被重新启用。

### 使用方法

```bash
v-unsuspend-dns-domain [USER] [DOMAIN]
```

- `[USER]`：拥有该DNS域名的用户账户。
- `[DOMAIN]`：要解除暂停状态的DNS域名。

### 示例

1. **解除用户`john`拥有的`example.com`域名的暂停状态**：

```bash
v-unsuspend-dns-domain john example.com
```

2. **解除用户`jane`拥有的`domain.net`域名的暂停状态**（假设`domain.net`包含国际化字符）：

```bash
v-unsuspend-dns-domain jane domain.net
```

注意：对于包含国际化字符的域名，脚本内部会自动进行格式化和处理。

### 验证与错误处理

在执行`v-unsuspend-dns-domain`命令之前，脚本会执行一系列的验证步骤，以确保：

- 命令接收到了正确数量的参数（在本例中为2个）。
- 提供的`USER`和`DOMAIN`参数符合预期的格式。
- DNS系统已被启用。
- 指定的用户账户和域名在系统中存在。
- 该域名当前处于暂停状态。

如果以上任何一个验证失败，脚本将显示一个错误消息并退出。

### 脚本执行

一旦所有验证都通过，脚本将执行以下操作：

- **修改配置文件**：如果DNS系统使用的是`named`或`bind`，脚本会检查并确定正确的配置文件路径（`named.conf`或`bind/named.conf`），并在其中添加或更新DNS域名的配置。
- **更新数据库和日志**：脚本将更新系统数据库中关于该DNS域名的暂停状态，并减少用户账户下`$SUSPENDED_DNS`的计数。同时，还会在`$USER_DATA/dns/`目录下找到对应的配置文件，并将其中的`SUSPENDED`值从`yes`更改为`no`。
- **记录日志**：最后，脚本将记录一个系统事件到Hestia的日志中，以表示已成功解除了DNS域名的暂停状态。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改DNS配置和数据库。
- 在生产环境中使用此命令之前，请先在测试环境中进行验证，以确保它按预期工作。
- 如果Hestia系统处于只读模式（例如，在演示环境中），则此命令将失败并显示相应的错误消息。

## v-unsuspend-dns-domains

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-unsuspend-dns-domains)

`v-unsuspend-dns-domains` 是一个Hestia系统提供的命令行工具，用于解除指定用户所有DNS域名的暂停状态。当某个用户的多个DNS域名被暂停时，此命令能够一次性将它们全部重新启用。

### 使用方法

```bash
v-unsuspend-dns-domains [USER] [RESTART]
```

- `[USER]`：拥有这些DNS域名的用户账户。
- `[RESTART]`（可选）：指定是否重启DNS服务。默认为`no`，即不重启。

### 示例

1. **解除用户`alice`的所有DNS域名暂停状态**：

   ```bash
   v-unsuspend-dns-domains alice
   ```

2. **解除用户`bob`的所有DNS域名暂停状态，并重启DNS服务**：

   ```bash
   v-unsuspend-dns-domains bob yes
   ```

### 脚本流程

1. **参数验证**：脚本首先检查是否接收到了正确的参数，并验证用户账户是否存在。
2. **系统检查**：确保DNS系统已启用，并检查系统是否处于只读模式（例如，演示环境）。
3. **解除暂停**：通过遍历数据库中所有被暂停的DNS域名，并逐一调用`v-unsuspend-dns-domain`命令来解除它们的暂停状态。
4. **日志记录**：在成功执行命令后，记录一个系统事件到Hestia的日志中。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改DNS配置和数据库。
- 如果选择重启DNS服务，请确保重启操作不会影响正在运行的网站或服务。
- 在生产环境中使用此命令之前，请先在测试环境中进行验证，以确保它按预期工作。

### 脚本内部逻辑

脚本的核心逻辑是通过调用`search_objects`函数来查找所有被暂停的DNS域名，然后针对每个域名调用`v-unsuspend-dns-domain`命令来解除其暂停状态。这种方式允许脚本处理多个域名，而不仅仅是单个域名。此外，脚本还提供了可选的`RESTART`参数，允许用户在需要时重启DNS服务。

## v-unsuspend-dns-record

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-unsuspend-dns-record)

`v-unsuspend-dns-record` 是一个由Hestia系统提供的命令行工具，用于解除指定DNS记录的暂停状态。当用户或系统管理员希望重新激活之前暂停的某个特定DNS记录时，可以使用此命令。

### 使用方法

```bash
v-unsuspend-dns-record USER DOMAIN ID [RESTART]
```

- `USER`：拥有该DNS记录的用户账户。
- `DOMAIN`：DNS记录所属的域名。
- `ID`：要解除暂停状态的DNS记录的ID。
- `[RESTART]`（可选）：指定是否重启DNS服务。默认为不重启。

### 示例

1. **解除用户`john`的域名`example.com`中ID为`123`的DNS记录的暂停状态**：

```bash
v-unsuspend-dns-record john example.com 123
```

2. **解除用户`jane`的域名`domain.net`中ID为`456`的DNS记录的暂停状态，并重启DNS服务**：

```bash
v-unsuspend-dns-record jane domain.net 456 yes
```

### 脚本流程

1. **参数验证**：脚本首先检查是否接收到了正确的参数，并验证用户账户、域名和记录ID是否存在。
2. **系统检查**：确保DNS系统已启用，并检查系统是否处于只读模式（例如，演示环境）。
3. **解除暂停**：通过调用`update_object_value`函数来更新DNS记录的状态，将其`$SUSPENDED`值设置为`no`，从而解除暂停。
4. **更新域名序列号**：如果DNS系统支持（如BIND或named），则更新域名的序列号以触发DNS记录的重新加载。
5. **DNSSEC重建**：如果DNS系统支持DNSSEC，则执行完整的DNS配置重建以确保DNSSEC签名的有效性。
6. **DNS集群同步**（可选）：如果启用了DNS集群，则将命令添加到队列中以在集群中的其他节点上同步执行。
7. **日志记录**：记录系统事件到Hestia的日志中，表明已解除了某个DNS记录的暂停状态。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改DNS配置和数据库。
- 如果选择重启DNS服务，请确保重启操作不会影响正在运行的网站或服务。
- 如果您的系统使用DNSSEC，解除暂停操作可能会导致DNSSEC签名失效。因此，在执行此操作后，可能需要重新生成签名。
- 在生产环境中使用此命令之前，请先在测试环境中进行验证，以确保它按预期工作。

### 脚本内部逻辑

脚本的核心逻辑是验证输入参数的有效性，更新数据库中的DNS记录状态，并在需要时触发DNS配置的重建和DNS集群的同步。通过这些步骤，脚本能够安全、可靠地解除特定DNS记录的暂停状态。

## v-sync-dns-cluster

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-sync-dns-cluster)

### 简介

`v-sync-dns-cluster` 是 Hestia 提供的 CLI（命令行界面）命令之一，用于同步 DNS 集群中的数据。DNS 集群在分布式系统中扮演着重要角色，确保 DNS 解析的可靠性和高效性。通过 `v-sync-dns-cluster` 命令，管理员可以方便地实现 DNS 数据的同步，保证各个节点之间数据的一致性。

### 用法

`v-sync-dns-cluster` 命令的基本用法如下：

```bash
v-sync-dns-cluster [选项]
```

#### 选项

* `-h`, `--help`: 显示命令帮助信息。
* `-u`, `--user <用户名>`: 指定执行同步操作的用户名。
* `-p`, `--password <密码>`: 指定执行同步操作的用户密码。
* `--domain <域名>`: 指定需要同步的域名。
* `--all`: 同步所有域名。
* `--force`: 强制同步，即使目标节点数据较新也进行同步。

### 示例

#### 示例1：同步指定域名

要同步名为 `example.com` 的域名，可以使用以下命令：

```bash
v-sync-dns-cluster --domain example.com
```

执行此命令后，Hestia 将开始同步 `example.com` 域名的 DNS 数据到集群中的其他节点。

#### 示例2：使用用户名和密码同步所有域名

如果需要以特定用户身份同步所有域名，并需要输入密码进行身份验证，可以使用以下命令：

```bash
v-sync-dns-cluster --all -u admin -p mypassword
```

请注意，在实际使用中，密码应妥善保管，避免在公共场合或脚本中明文显示。

#### 示例3：强制同步指定域名

在某些情况下，即使目标节点的数据较新，也可能需要强制同步。这可以通过添加 `--force` 选项来实现：

```bash
v-sync-dns-cluster --domain example.com --force
```

执行此命令后，Hestia 将强制同步 `example.com` 域名的 DNS 数据，无论目标节点上的数据是否较新。

### 注意事项

* 在执行同步操作之前，请确保已经正确配置了 DNS 集群，并且所有节点都处于正常状态。
* 根据同步的数据量和网络状况，同步操作可能需要一些时间才能完成。请耐心等待，并避免在同步过程中进行其他可能影响数据一致性的操作。
* 如果遇到同步失败的情况，请检查网络连接、用户权限和 DNS 集群配置等可能的原因，并进行相应的故障排除。

## v-suspend-dns-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-suspend-dns-domain)

### 简介

`v-suspend-dns-domain` 是 Hestia 提供的命令行接口（CLI）命令之一，用于暂停指定的 DNS 域名服务。当您需要对某个域名进行维护、更新或出于其他原因需要暂时停止其 DNS 解析时，可以使用此命令。

### 语法

```bash
v-suspend-dns-domain [OPTIONS] DOMAIN_NAME
```

* `DOMAIN_NAME`：需要暂停的 DNS 域名。
* `[OPTIONS]`：可选参数，用于配置命令的行为。

### 选项

* `--user USERNAME`：指定执行此操作的用户名。默认为当前用户。
* `--force`：强制暂停域名，不提示任何确认信息。
* `--verbose`：显示详细的操作日志。

### 示例

#### 示例 1：暂停单个域名

假设您需要暂停名为 `example.com` 的 DNS 域名服务，可以执行以下命令：

```bash
v-suspend-dns-domain example.com
```

系统可能会提示您确认此操作，输入 `y` 或 `yes` 以继续。

#### 示例 2：使用特定用户暂停域名

如果您想以特定用户（例如 `admin`）的身份暂停域名，可以使用 `--user` 选项：

```bash
v-suspend-dns-domain --user admin example.com
```

#### 示例 3：强制暂停域名

如果您想在不提示任何确认信息的情况下直接暂停域名，可以使用 `--force` 选项：

```bash
v-suspend-dns-domain --force example.com
```

#### 示例 4：显示详细操作日志

如果您想查看暂停域名时的详细操作日志，可以使用 `--verbose` 选项：

```bash
v-suspend-dns-domain --verbose example.com
```

### 注意事项

* 在执行此命令之前，请确保您已经备份了相关的 DNS 配置和数据，以防万一。
* 暂停域名后，该域名的 DNS 解析将失效，直到您使用 `v-resume-dns-domain` 命令恢复为止。
* 如果您不确定某个命令的具体用法或选项，可以使用 `v-suspend-dns-domain --help` 命令查看帮助信息。

## v-suspend-dns-domains

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-suspend-dns-domains)

在 Hestia 控制面板环境中，管理 DNS 域名通常涉及多个操作，包括添加、删除、修改和暂停域名。其中，暂停 DNS 域名是一个重要的功能，它允许管理员临时停止域名的 DNS 解析服务，而不必完全删除或修改域名配置。

Hestia 提供了一个命令行接口（CLI）命令 `v-suspend-dns-domains`，用于暂停指定的 DNS 域名。下面将详细介绍如何使用该命令，并提供一些示例。

### 1. 命令概述

`v-suspend-dns-domains` 命令允许用户暂停一个或多个 DNS 域名。当域名被暂停时，它将不再响应 DNS 查询请求，直到被重新激活。

### 语法

```bash
v-suspend-dns-domains USER [RESTART]
```

- **USER**: 要暂停其 DNS 域名的用户名。
- **RESTART**: （可选）如果指定了此参数，则在暂停 DNS 域名后尝试重启 DNS 服务。通常用于确保更改立即生效。

### 示例

#### 示例 1: 暂停特定用户的 DNS 域名

```bash
v-suspend-dns-domains admin
```

此命令将暂停名为 `admin` 的用户的所有 DNS 域名，但不会尝试重启 DNS 服务。

#### 示例 2: 暂停特定用户的 DNS 域名并重启 DNS 服务

```bash
v-suspend-dns-domains admin yes
```

此命令将暂停名为 `admin` 的用户的所有 DNS 域名，并在完成后尝试重启 DNS 服务。

#### 示例 3：暂停单个域名

假设我们要暂停名为 `example.com` 的 DNS 域名，可以使用以下命令：

```bash
v-suspend-dns-domains example.com
```

执行此命令后，如果成功，则 `example.com` 将被暂停，不再响应 DNS 查询请求。

#### 示例 4：暂停多个域名

如果要同时暂停多个域名，例如 `example.com`、`test.com` 和 `dev.example.com`，可以使用以下命令：

```bash
v-suspend-dns-domains example.com test.com dev.example.com
```

执行此命令后，所有这些指定的域名都将被暂停。

#### 示例 5：结合其他命令和脚本

在实际应用中，您可能希望将 `v-suspend-dns-domains` 命令与其他命令或脚本结合使用，以实现更复杂的自动化任务。例如，您可以使用 Bash 脚本来读取包含要暂停的域名列表的文件，并逐个调用 `v-suspend-dns-domains` 命令。

### 4. 注意事项

* 在使用 `v-suspend-dns-domains` 命令之前，请确保您已登录到 Hestia 控制面板的 CLI 环境，并具有足够的权限来执行此操作。
* 暂停域名可能会影响与该域名相关的服务或应用程序的可用性。因此，在暂停域名之前，请确保您已了解可能的影响，并采取了适当的措施来通知相关用户或系统。
* 如果要重新激活已暂停的域名，您可能需要使用相应的 Hestia CLI 命令（如 `v-resume-dns-domains`）或通过 Hestia 控制面板的图形界面进行操作。

### 5. 结论

`v-suspend-dns-domains` 命令是 Hestia 控制面板中用于暂停 DNS 域名的强大工具。通过使用该命令，您可以轻松地暂停一个或多个 DNS 域名，以满足不同的管理需求。请根据您的实际情况和需要，结合上述示例和注意事项，灵活使用该命令来管理您的 DNS 域名。

## v-suspend-dns-record

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-suspend-dns-record)

### 说明

`v-suspend-dns-record` 命令用于暂停指定用户的特定 DNS 记录。这对于临时禁用或维护某个 DNS 记录非常有用。

### 语法

```bash
v-suspend-dns-record USER DOMAIN ID [RESTART]
```

- **USER**: 要暂停 DNS 记录的用户名。
- **DOMAIN**: 包含要暂停的 DNS 记录的域名。
- **ID**: 要暂停的 DNS 记录的 ID。
- **RESTART** (可选): 如果指定了此参数，则在暂停 DNS 记录后尝试重启 DNS 服务。通常用于确保更改立即生效。

### 示例

#### 示例 1: 暂停特定用户的特定 DNS 记录

```bash
v-suspend-dns-record admin example.com 123
```

此命令将暂停用户名为 `admin` 的用户拥有的 `example.com` 域名下 ID 为 123 的 DNS 记录，但不会尝试重启 DNS 服务。

#### 示例 2: 暂停特定用户的特定 DNS 记录并重启 DNS 服务

```bash
v-suspend-dns-record admin example.com 123 yes
```

此命令将暂停用户名为 `admin` 的用户拥有的 `example.com` 域名下 ID 为 123 的 DNS 记录，并在完成后尝试重启 DNS 服务。

### 工作原理

- 命令首先验证输入参数的有效性，包括用户、域名、记录 ID 以及系统状态。
- 然后，它会更新 DNS 记录的 `SUSPENDED` 属性为 `yes`，从而暂停该记录。
- 接着，命令会更新域名的序列号（如果适用），并可能重建 DNS 域的配置文件。
- 如果启用了 DNS 集群，命令还会将暂停 DNS 记录的操作添加到队列中，以便在其他节点上执行。
- 最后，命令会记录一个日志事件，指示 DNS 记录已成功暂停。

### 注意事项

- 在运行此命令之前，请确保您已经备份了所有重要数据，并了解了命令的工作原理和潜在风险。
- 暂停 DNS 记录可能会影响与该记录相关的服务或应用程序的可用性。请确保您已通知相关用户或系统，并采取了适当的措施来减少潜在的影响。
- 如果需要重启 DNS 服务，请确保您已了解如何安全地执行此操作，并考虑使用适当的监控和恢复机制来确保服务的可用性和稳定性。
- 请注意，命令中的参数和选项可能会因 Hestia 的版本和配置而有所不同。因此，请确保您已正确引用这些参数和选项，并根据需要进行修改。

## v-restart-dns

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-restart-dns)

### 说明

`v-restart-dns` 命令用于重启 Hestia Control Panel 配置的 DNS 服务。这通常用于在配置更改后或系统维护时确保 DNS 服务的正常运行。

### 语法

```bash
v-restart-dns [SCHEDULED|no]
```

- **SCHEDULED** (可选): 如果指定此参数，则将重启命令添加到重启队列中，而不是立即执行。
- **no** (可选): 如果指定此参数，则不执行任何操作，命令将直接退出。

如果不提供任何参数，并且 `SCHEDULED_RESTART` 配置项设置为 `'yes'`，则命令将默认以 `scheduled` 模式运行。

### 示例

#### 示例 1: 立即重启 DNS 服务

```bash
v-restart-dns
```

此命令将立即尝试重启 Hestia 配置的 DNS 服务。

#### 示例 2: 将重启命令添加到队列中

```bash
v-restart-dns scheduled
```

此命令不会立即重启 DNS 服务，而是将重启命令添加到重启队列中，以便稍后执行。

#### 示例 3: 不执行任何操作

```bash
v-restart-dns no
```

此命令将不执行任何操作，并直接退出。

### 工作原理

- 命令首先检查是否已定义 `DNS_SYSTEM` 环境变量，并且该值不是 `'remote'`，因为远程 DNS 系统不需要本地重启。
- 如果第一个参数是 `'no'`，则命令将直接退出。
- 如果第一个参数是 `'scheduled'` 或者未提供任何参数但 `SCHEDULED_RESTART` 配置项设置为 `'yes'`，则命令将把重启命令添加到重启队列中，而不是立即执行。
- 命令接着检查 `/etc/named.conf` 或 `/etc/bind/named.conf` 配置文件是否存在，并验证其语法是否正确。如果配置文件语法有误，则发送包含错误详情的电子邮件给管理员，并退出命令。
- 如果配置文件语法正确，则尝试重启 DNS 服务。如果重启失败，同样会发送包含错误详情的电子邮件给管理员。
- 如果 DNS 服务成功重启，并且存在重启队列文件（`$HESTIA/data/queue/restart.pipe`），则从队列中移除该重启命令。

### 注意事项

- 在执行重启命令之前，请确保已经保存了所有未保存的更改，并了解了重启可能带来的潜在影响。
- 如果您的 DNS 服务配置复杂，或者与其他系统或服务紧密集成，请确保您已经了解了重启可能导致的连锁反应，并已经采取了相应的预防措施。
- 命令中使用的 `send_email_report` 函数用于在出现问题时发送电子邮件给管理员。请确保相关的电子邮件配置（如 SMTP 服务器和发件人地址）已经正确设置。
- 在 `SCHEDULED` 模式下，重启命令将被添加到队列中，以便稍后由系统管理员或其他自动化进程执行。请确保定期监控重启队列，并根据需要执行其中的命令。

## v-rebuild-dns-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-rebuild-dns-domain)

### 说明

`v-rebuild-dns-domain` 命令用于重新构建特定用户的 DNS 域名配置。当 DNS 记录发生更改或需要刷新时，可以使用此命令来确保 DNS 配置的准确性和一致性。

### 语法

```bash
v-rebuild-dns-domain USER DOMAIN [RESTART] [UPDATE_SERIAL]
```

- **USER**：指定要操作的用户名。
- **DOMAIN**：指定要重新构建的 DNS 域名。
- **RESTART**（可选）：指定是否立即重启 DNS 服务。默认情况下，不会立即重启。
- **UPDATE_SERIAL**（可选）：指定是否更新域名的序列号。如果设置为 `'yes'` 或省略，则序列号将被更新。如果设置为 `'no'`，则序列号将保持不变。

### 示例

#### 示例 1: 重新构建用户的 DNS 域名配置，不立即重启 DNS 服务

```bash
v-rebuild-dns-domain john example.com
```

这将重新构建用户 `john` 的 `example.com` 域名的 DNS 配置，但不会立即重启 DNS 服务。

#### 示例 2: 重新构建用户的 DNS 域名配置，并立即重启 DNS 服务

```bash
v-rebuild-dns-domain john example.com yes
```

这将重新构建用户 `john` 的 `example.com` 域名的 DNS 配置，并立即重启 DNS 服务。

#### 示例 3: 重新构建用户的 DNS 域名配置，更新序列号，并立即重启 DNS 服务

```bash
v-rebuild-dns-domain john example.com yes yes
```

这将重新构建用户 `john` 的 `example.com` 域名的 DNS 配置，更新序列号，并立即重启 DNS 服务。

### 工作原理

- 命令首先验证输入参数的有效性，包括用户名、域名、重启选项和序列号更新选项。
- 接着，它会检查用户是否存在、是否未被暂停，以及域名是否有效。
- 然后，命令会删除 DNS 配置文件中与指定域名相关的条目。
- 如果指定了更新序列号选项，则命令会更新域名的序列号。
- 接下来，它会调用一系列函数来修复 DNS 配置和重新构建指定域名的 DNS 配置文件。
- 命令会更新用户相关的 DNS 统计信息，如域名数量和记录数量。
- 如果指定了重启选项，则命令会重启 DNS 服务。
- 最后，命令会记录一条操作日志，并退出。

### 注意事项

- 在执行此命令之前，请确保已经了解了 DNS 配置和管理的基本知识。
- 如果 DNS 服务正在运行并且正在处理请求，请谨慎使用立即重启选项，因为这可能会导致服务中断。
- 如果在 DNS 配置中使用了自定义的模板或脚本，则可能需要手动进行额外的配置或修复。
- 如果命令执行失败或遇到问题，请检查日志文件以获取更详细的错误信息，并根据需要进行故障排除。
- 在执行此命令之前，请确保已经备份了重要的 DNS 配置和数据，以防止意外丢失。

## v-rebuild-dns-domains

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-rebuild-dns-domains)

`v-rebuild-dns-domains` 是 Hestia 控制面板提供的命令行工具，用于重建指定用户的 DNS 域名配置。本命令会遍历所有 DNS 域名，并根据需要更新其序列号（如果指定了相应参数），然后重新构建 DNS 配置文件。

### 语法


```bash
v-rebuild-dns-domains USER [RESTART] [UPDATE_SERIAL]
```
- `USER`: 必需参数，指定要重建 DNS 配置的用户名。
- `RESTART`: 可选参数，如果设置为 `yes`，则在完成 DNS 配置重建后重启 DNS 服务。
- `UPDATE_SERIAL`: 可选参数，如果设置为 `yes`，则在重建过程中更新 DNS 域的序列号。

### 示例

1. **重建指定用户的 DNS 配置，不重启服务，不更新序列号**


```bash
v-rebuild-dns-domains john
```
此命令将重建用户 `john` 的 DNS 配置，但不会重启 DNS 服务，也不会更新序列号。

2. **重建指定用户的 DNS 配置，并重启服务，同时更新序列号**


```bash
v-rebuild-dns-domains john yes yes
```
此命令将重建用户 `john` 的 DNS 配置，并在完成后重启 DNS 服务，同时更新所有 DNS 域的序列号。

3. **仅重建 DNS 配置，不执行其他操作**

如果你只想重建 DNS 配置而不进行其他任何操作（如重启服务或更新序列号），只需提供用户名作为参数即可。

### 注意事项

- 在执行此命令之前，请确保已经以 root 或具有适当权限的用户身份登录系统。
- 如果 DNS 系统配置为远程（即 DNS 服务不在本地运行），则此命令将不会执行任何操作。
- 如果用户被暂停（suspended），则此命令将立即退出。
- 如果系统处于演示模式（demo mode），则可能会阻止此命令的某些功能。
- 此命令会修改 DNS 配置文件（如 `/etc/named.conf` 或 `/etc/bind/named.conf`），因此请确保在执行此命令之前备份重要数据。
- 重建 DNS 配置可能需要一些时间，具体取决于系统上 DNS 域的数量。在执行此命令时，请耐心等待，并确保不要在重建过程中中断它。

### 返回值

- 如果命令成功执行，将返回退出码 `0`。
- 如果命令执行失败，将返回非零退出码，并可能输出错误消息。

### 错误处理

在脚本执行过程中，`v-rebuild-dns-domains` 命令会进行一系列的检查以确保命令能够正确执行。如果遇到任何错误或不符合条件的情况，脚本会提前退出并输出相应的错误消息。

以下是一些可能的错误情况及其处理方式：

- **参数数量不足或格式错误**：如果提供的参数数量不足或格式不正确，脚本将调用 `check_args` 函数来验证参数，并输出相应的错误消息。

- **用户不存在或已被暂停**：脚本会检查提供的用户是否存在且未被暂停。如果用户不存在或已被暂停，将输出错误消息并退出。

- **DNS 系统配置为远程**：如果 DNS 系统配置为远程（不在本地运行），脚本将直接退出而不执行任何操作。

- **系统处于演示模式**：如果系统处于演示模式，可能会阻止某些功能的执行。脚本会调用 `check_hestia_demo_mode` 函数来检查系统是否处于演示模式，并在必要时输出警告消息。

- **DNS 配置文件不存在**：脚本会检查 `/etc/named.conf` 或 `/etc/bind/named.conf` 文件是否存在。如果文件不存在，可能会导致后续操作失败。

- **重启 DNS 服务失败**：如果指定了 `RESTART` 参数并且重启 DNS 服务失败，脚本将输出错误消息，但不会阻止整个命令的完成。

### 日志记录

脚本在执行过程中会记录相关的事件和操作到日志中。这有助于管理员跟踪命令的执行情况和诊断潜在问题。

- **系统日志**：使用 `$BIN/v-log-action` 命令将重建 DNS 域的操作记录到系统日志中。

- **事件日志**：使用 `log_event` 函数将操作结果（成功或失败）记录到事件日志中。

### 自定义和扩展

虽然 `v-rebuild-dns-domains` 命令提供了基本的 DNS 重建功能，但管理员可能需要根据自己的需求进行自定义和扩展。

- **添加额外的检查**：在脚本中添加额外的检查以确保在重建 DNS 配置之前满足特定的条件。

- **修改 DNS 配置**：根据需要修改 DNS 配置文件的格式和内容。

- **集成其他工具**：将 `v-rebuild-dns-domains` 命令与其他管理工具或脚本集成，以实现更复杂的自动化操作。

### 总结

`v-rebuild-dns-domains` 命令是 Hestia 控制面板提供的一个强大的工具，用于重建指定用户的 DNS 域名配置。通过合理的参数设置和错误处理机制，该命令可以确保 DNS 配置的正确性和可靠性。管理员可以根据需要自定义和扩展该命令，以满足特定的管理需求。

## v-list-sys-dns-status

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-dns-status)

`v-list-sys-dns-status` 是一个由 Hestia 提供的 CLI 命令，用于列出和显示系统的 DNS 状态统计信息。这个命令会检查系统的 DNS 配置文件，并生成一个包含 DNS 服务的统计数据的文件。以下是这个命令的详细使用说明和示例。

### 语法

```bash
v-list-sys-dns-status
```

该命令没有参数，直接运行即可。

### 工作原理

1. 脚本首先会检查 `$DNS_SYSTEM` 变量是否已设置，如果未设置，则脚本会退出。
2. 脚本会检查不同的 DNS 配置文件位置（针对不同的 Linux 发行版，如 RHEL/CentOS 和 Debian/Ubuntu），并查找是否已配置 `dump-file` 选项，该选项用于指定统计数据的输出文件。
3. 如果 `dump-file` 选项未配置，脚本将自动添加该选项到 DNS 配置文件，并尝试重启 DNS 服务（仅针对 RHEL/CentOS）。
4. 使用 `rndc stats` 命令生成 DNS 统计数据，并将其保存到之前确定的 `dump_file` 文件中。
5. 如果 `dump_file` 文件存在，脚本将显示其内容，即 DNS 服务的统计信息。

### 示例

1. **直接运行命令**

直接运行 `v-list-sys-dns-status` 命令，无需任何参数。

```bash
v-list-sys-dns-status
```

如果一切正常，命令将输出 DNS 服务的统计信息到控制台。

2. **检查配置文件和重启服务（RHEL/CentOS）**

在 RHEL/CentOS 系统中，如果 DNS 配置文件 `/etc/named/named.conf` 中没有 `dump-file` 选项，脚本将自动添加该选项，并尝试重启 named 服务。这通常是为了确保能够捕获 DNS 服务的统计信息。

### 注意事项

- 脚本会检查不同的 DNS 配置文件位置，以适应不同的 Linux 发行版。但是，对于 Debian/Ubuntu 系统，脚本当前并未自动添加 `dump-file` 选项到配置文件中。如果需要，管理员可以手动进行配置。
- 在 RHEL/CentOS 系统中，脚本会尝试重启 named 服务以应用配置更改。这可能会导致短暂的 DNS 服务中断。
- 如果 `rndc stats` 命令无法生成统计数据或 `dump_file` 文件不存在，则不会显示任何输出。
- 请确保以具有足够权限的用户身份运行此命令，以便能够读取 DNS 配置文件和执行系统命令。

### 自定义和扩展

- 如果需要，管理员可以根据自己的需求修改脚本，以支持其他 Linux 发行版或 DNS 服务器软件。
- 可以添加额外的逻辑来处理 `dump_file` 选项的配置和服务的重启，以适应特定的系统环境或需求。
- 可以通过修改 `dump_file` 变量的值来指定不同的统计数据输出文件路径。

### 总结

`v-list-sys-dns-status` 命令是一个实用的工具，用于查看和诊断系统的 DNS 服务状态。通过检查 DNS 配置文件和生成统计数据文件，管理员可以获取有关 DNS 服务的详细信息，从而进行故障排除和优化。

## v-list-remote-dns-hosts

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-remote-dns-hosts)

`v-list-remote-dns-hosts` 是 Hestia 提供的一个命令行接口（CLI）命令，用于列出远程 DNS 主机的信息。此命令允许用户以不同的格式（如 JSON、Shell、CSV 等）获取这些 DNS 主机的详细配置。

### 用法

```bash
v-list-remote-dns-hosts [FORMAT]
```

* `[FORMAT]` 是一个可选参数，用于指定输出格式。如果未提供，则默认为 Shell 格式。

### 示例

#### 示例 1：默认 Shell 格式输出

```bash
$ v-list-remote-dns-hosts
HOST                PORT TYPE USER       DNS_USER SUSPENDED DATE
------------------  ---- ---- ---------- -------- --------- ----
ns1.example.com     53   UDP  user1      dnsuser  false     2023-07-19
ns2.example.com     53   TCP  user2      dnsuser  false     2023-07-19
```

#### 示例 2：JSON 格式输出

```bash
$ v-list-remote-dns-hosts json
{
  `ns1.example.com`: {
    `PORT`: `53`,
    `TYPE`: `UDP`,
    `USER`: `user1`,
    `DNS_USER`: `dnsuser`,
    `SUSPENDED`: `false`,
    `TIME`: ``,  # 注意：根据配置，可能不包含 TIME 字段
    `DATE`: `2023-07-19`
  },
  `ns2.example.com`: {
    `PORT`: `53`,
    `TYPE`: `TCP`,
    `USER`: `user2`,
    `DNS_USER`: `dnsuser`,
    `SUSPENDED`: `false`,
    `TIME`: ``,  # 注意：根据配置，可能不包含 TIME 字段
    `DATE`: `2023-07-19`
  }
}
```

#### 示例 3：CSV 格式输出

```bash
$ v-list-remote-dns-hosts csv
HOST,PORT,TYPE,USER,DNS_USER,SUSPENDED,TIME,DATE
ns1.example.com,53,UDP,user1,dnsuser,false,,2023-07-19
ns2.example.com,53,TCP,user2,dnsuser,false,,2023-07-19
```

### 自定义输出

在某些情况下，您可能希望根据特定需求自定义 `v-list-remote-dns-hosts` 命令的输出。虽然该命令本身可能不提供直接的自定义选项，但您可以通过结合其他命令行工具（如 `grep`、`awk`、`jq` 等）来实现这一点。

#### 示例 4：使用 `grep` 过滤输出

如果您只对特定主机感兴趣，可以使用 `grep` 命令来过滤输出。

```bash
$ v-list-remote-dns-hosts | grep 'ns1.example.com'
HOST                PORT TYPE USER       DNS_USER SUSPENDED DATE
ns1.example.com     53   UDP  user1      dnsuser  false     2023-07-19
```

#### 示例 5：使用 `jq` 处理 JSON 输出

如果您使用的是 JSON 输出格式，并希望提取或处理特定的数据，可以使用 `jq` 命令。

```bash
$ v-list-remote-dns-hosts json | jq '.[`ns1.example.com`].PORT'
`53`
```

### 错误处理

如果 `v-list-remote-dns-hosts` 命令在执行过程中遇到错误，它将通常返回一个非零的退出码，并将错误消息输出到标准错误流（stderr）。您可以使用这些错误消息来诊断问题。

#### 示例 6：检查命令是否成功执行

您可以使用 shell 的条件语句（如 `if`）来检查命令的退出码，以确定它是否成功执行。

```bash
if v-list-remote-dns-hosts; then
    echo `命令执行成功`
else
    echo `命令执行失败`
    # 可以在这里添加错误处理逻辑
fi
```

### 注意事项

* 输出字段可能因 Hestia 的配置而有所不同。例如，在某些情况下，可能不包含 `TIME` 字段。
* 请确保在执行此命令之前，您已经正确配置了 Hestia 并具有相应的权限。
* 如果在执行命令时遇到任何问题，请查阅 Hestia 的官方文档或联系技术支持以获取帮助。

### 安全性考虑

当使用 `v-list-remote-dns-hosts` 命令时，请确保您只与受信任的系统和源进行交互。不要在不安全的网络上运行此命令，以防数据被拦截或篡改。此外，请确保只有授权用户才能执行此命令，以防止未经授权的访问和潜在的数据泄露。

### 结论

`v-list-remote-dns-hosts` 是 Hestia 提供的一个强大而灵活的命令行接口命令，用于列出远程 DNS 主机的信息。通过选择不同的输出格式和结合其他命令行工具，您可以根据需要自定义输出并进行错误处理。请确保在使用此命令时遵循安全性最佳实践，并始终与受信任的系统和源进行交互。

## v-list-dns-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-dns-domain)

### 概述

`v-list-dns-domain` 是一个用于列出DNS域信息的CLI命令，它基于Hestia控制面板的环境提供DNS记录、配置以及其他相关信息的输出。通过指定用户和域名参数，可以检索和显示详细的DNS配置。

### 使用方法

### 语法

```bash
v-list-dns-domain USER DOMAIN [FORMAT]
```

- `USER`: 指定用户的标识符，通常与Hestia控制面板中的用户账号相对应。
- `DOMAIN`: 需要检索其DNS信息的域名。
- `FORMAT`: （可选）输出格式，可以指定为 `shell`（默认）、`plain`、`csv` 或 `json`。

### 示例

#### 示例1：使用默认格式（shell）

```bash
v-list-dns-domain alice wonderland.com
```

输出将类似于以下shell脚本风格的列表：

```bash
DOMAIN: wonderland.com
IP: 192.0.2.1
TEMPLATE: default
TTL: 3600
EXP: ...
SOA: ...
SERIAL: ...
DNSSEC: ...
RECORDS: ...
SUSPENDED: no
TIME: ...
DATE: ...
```

#### 示例2：使用JSON格式

```bash
v-list-dns-domain alice wonderland.com json
```

输出将是一个包含DNS信息的JSON对象：

```json
{
  `wonderland.com`: {
    `IP`: `192.0.2.1`,
    `TPL`: `default`,
    `TTL`: `3600`,
    `EXP`: `...`,
    `SOA`: `...`,
    `SERIAL`: `...`,
    `DNSSEC`: `...`,
    `SRC`: `...`,
    `RECORDS`: `...`,
    `SUSPENDED`: `no`,
    `TIME`: `...`,
    `DATE`: `...`
  }
}
```

#### 示例3：使用CSV格式

```bash
v-list-dns-domain alice wonderland.com csv
```

输出将是一个CSV格式的字符串，其中包含DNS信息：

```csv
DOMAIN,IP,TPL,TTL,EXP,SOA,SERIAL,DNSSEC,RECORDS,SUSPENDED,TIME,DATE
wonderland.com,192.0.2.1,default,3600,...,...,...,...,...,no,...,...
```

### 注意事项

- 确保在运行此命令之前已经正确配置了Hestia控制面板，并且相关的配置文件（如`/etc/hestiacp/hestia.conf`）是可用的。
- 请使用有效的用户和域名参数，否则命令可能会失败或返回错误消息。
- 根据指定的格式，输出将有所不同。确保选择适合您需求的格式。

### 参考资料

- Hestia控制面板官方文档：提供了关于Hestia控制面板的详细信息和配置指南。
- Bash脚本编程：如果您需要更深入地了解脚本中的函数和逻辑，可以参考Bash脚本编程的相关文档和教程。

## v-list-dns-domains

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-dns-domains)

### 概述

`v-list-dns-domains` 是 Hestia Control Panel (HestiaCP) 提供的一个 CLI (命令行界面) 工具，用于获取指定用户的所有 DNS 域名信息。这个脚本能够根据不同的格式需求（如 JSON、Shell、Plain 或 CSV）来展示这些信息。

### 用法

#### 命令行参数

- `USER`: 必需参数，指定要查询的用户的用户名。
- `FORMAT`: 可选参数，指定输出格式。默认为 `shell`。

#### 示例

#### 示例 1: 以 Shell 格式列出用户 `admin` 的 DNS 域名信息

```bash
v-list-dns-domains admin
```

#### 示例 2: 以 JSON 格式列出用户 `exampleuser` 的 DNS 域名信息

```bash
v-list-dns-domains exampleuser json
```

#### 示例 3: 以 Plain 格式列出用户 `apiuser` 的 DNS 域名信息

```bash
v-list-dns-domains apiuser plain
```

#### 示例 4: 以 CSV 格式列出用户 `webmaster` 的 DNS 域名信息

```bash
v-list-dns-domains webmaster csv
```

### 输出格式

#### Shell 格式

Shell 格式的输出是一个格式化的列表，便于在 Bash 脚本中直接读取。

```bash
DOMAIN IP TPL TTL DNSSEC REC SPND DATE
------ -- --- --- ------ --- ---- ----
example.com 192.168.1.1 master 3600 false ...
...
```

#### JSON 格式

JSON 格式的输出是一个 JSON 对象数组，每个对象代表一个 DNS 域名及其详细信息。

```json
{
  `example.com`: {
    `IP`: `192.168.1.1`,
    `TPL`: `master`,
    `TTL`: `3600`,
    `DNSSEC`: `false`,
    `RECORDS`: `...`,
    `SUSPENDED`: `...`,
    `DATE`: `...`
    // ... 其他字段
  },
  // ... 其他域名
}
```

#### Plain 格式

Plain 格式的输出是一个简单的制表符分隔的列表，包含所有字段。

```plain
DOMAIN    IP      TPL     TTL     DNSSEC  ...
example.com 192.168.1.1 master  3600    false ...
...
```

#### CSV 格式

CSV 格式的输出是一个逗号分隔的列表，适用于在电子表格软件中打开。

```csv
DOMAIN,IP,TPL,TTL,DNSSEC,...
example.com,192.168.1.1,master,3600,false,...
...
```

### 注意事项

- 请确保您已正确安装并配置了 HestiaCP。
- 根据您的权限，您可能需要使用 `sudo` 或以具有足够权限的用户身份运行此命令。
- 输出格式可能因 HestiaCP 的版本和配置而有所不同。

### 结论

`v-list-dns-domains` 是一个强大的工具，允许您方便地查询和列出 HestiaCP 用户的 DNS 域名信息。通过使用不同的输出格式，您可以根据需要将数据集成到您的脚本、应用程序或电子表格中。

## v-list-dns-records

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-dns-records)

### 命令概述

`v-list-dns-records` 是 Hestia 提供的一个命令行接口（CLI）命令，用于列出指定 DNS 域名的所有 DNS 记录。这个命令对于系统管理员、网络工程师或任何需要管理 DNS 记录的人员都非常有用。

### 命令语法

```bash
v-list-dns-records USER DOMAIN [FORMAT]
```

* `USER`: 用于认证的用户名。
* `DOMAIN`: 要列出其 DNS 记录的域名。
* `[FORMAT]`: （可选）指定输出格式，默认为 `shell`。还可以选择 `json` 以获得 JSON 格式的输出。

### 示例

#### 示例 1：使用 shell 格式列出记录

```bash
v-list-dns-records admin example.com
```

输出示例（shell 格式）:

```bash
ID^RECORD^TYPE^VALUE^DATE^TTL
--^------^----^-----^----^----
1^example.com.^A^192.0.2.1^2023-03-15^3600
2^www.example.com.^CNAME^example.com.^2023-03-15^3600
...
```

#### 示例 2：使用 JSON 格式列出记录

```bash
v-list-dns-records admin example.com json
```

输出示例（JSON 格式）:

```json
{
  `1`: {
    `RECORD`: `example.com.`,
    `TYPE`: `A`,
    `PRIORITY`: ``,
    `VALUE`: `192.0.2.1`,
    `ID`: `1`,
    `SUSPENDED`: `false`,
    `TIME`: `2023-03-15T12:00:00Z`,
    `DATE`: `2023-03-15`,
    `TTL`: `3600`
  },
  `2`: {
    `RECORD`: `www.example.com.`,
    `TYPE`: `CNAME`,
    `PRIORITY`: ``,
    `VALUE`: `example.com.`,
    `ID`: `2`,
    `SUSPENDED`: `false`,
    `TIME`: `2023-03-15T12:00:00Z`,
    `DATE`: `2023-03-15`,
    `TTL`: `3600`
  },
  ...
}
```

### 注意事项

* 请确保您有足够的权限来执行此命令，并且提供的用户名和密码是正确的。
* 如果省略了 `[FORMAT]` 参数，则默认使用 `shell` 格式输出。
* 如果指定的域名不存在或没有 DNS 记录，该命令可能会返回一个空的结果集。

### 后续操作

* 使用 `v-list-dns-records` 命令获取 DNS 记录后，您可以使用其他 Hestia CLI 命令来进一步管理这些记录，如添加、修改或删除记录。
* 请确保定期备份您的 DNS 记录，以防止数据丢失。

### 进阶用法

除了基本用法之外，`v-list-dns-records` 命令还支持一些高级功能，帮助您更高效地管理 DNS 记录。

#### 过滤结果

虽然 Hestia 的 CLI 本身可能没有直接的过滤选项，但您可以通过将命令的输出传递给其他 Unix 工具（如 `grep`、`awk` 或 `sed`）来过滤结果。

例如，如果您只想查看类型为 A 的记录，可以使用以下命令：

```bash
v-list-dns-records admin example.com | grep '^[^ID]^[^RECORD]^A'
```

这里我们假设 `v-list-dns-records` 的输出是逐行输出的，并且每一行都是以某个分隔符（如制表符或空格）分隔的字段。上面的 `grep` 命令将只显示包含类型 `A` 的行。

#### 批量操作

如果您需要对多个域名执行相同的操作，可以考虑将域名列表存储在一个文件中，并使用 shell 脚本循环遍历该文件。

例如，假设您有一个名为 `domains.txt` 的文件，其中包含要查询的域名列表，每行一个域名。您可以使用以下脚本批量查询这些域名的 DNS 记录：

```bash
#!/bin/bash

USERNAME=`admin`
FORMAT=`json`

while IFS= read -r DOMAIN; do
    v-list-dns-records `$USERNAME` `$DOMAIN` `$FORMAT`
    echo `-----`  # 分隔不同域名的输出
done < domains.txt
```

这个脚本将读取 `domains.txt` 文件中的每一行，并对每个域名执行 `v-list-dns-records` 命令。注意，我们在这里使用了 `IFS=` 和 `read -r` 来确保正确地读取每一行，即使它包含空格或特殊字符。

#### 脚本化操作

您还可以将 `v-list-dns-records` 命令与其他 Bash 脚本命令结合使用，以实现更复杂的自动化任务。例如，您可以编写一个脚本，该脚本首先列出某个域名的 DNS 记录，然后根据这些记录执行某些操作（如添加新的记录、更新现有记录或删除不再需要的记录）。

#### 安全性注意事项

* 确保在安全的环境中执行这些命令和脚本，以避免潜在的安全风险。
* 不要在公共或不受信任的网络上传输敏感信息（如用户名和密码）。
* 定期更新您的系统和 Hestia 版本，以确保您受益于最新的安全修复和改进。

### 总结

`v-list-dns-records` 命令是 Hestia 提供的一个强大工具，用于列出指定域名的 DNS 记录。通过结合其他 Unix 工具和 Bash 脚本，您可以实现更复杂的 DNS 记录管理任务。请确保遵循最佳的安全实践，并定期备份您的 DNS 记录。

## v-list-dns-template

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-dns-template)

### 概述

Hestia 提供了一个命令行工具（CLI），允许用户通过简单的命令与系统进行交互。其中，`v-list-dns-template` 命令用于获取 DNS 模板参数。此命令对于需要管理和配置 DNS 模板的用户来说非常有用。

### 用法

```bash
v-list-dns-template TEMPLATE [FORMAT]
```

* `TEMPLATE`: 必需的参数，指定要查询的 DNS 模板名称。
* `FORMAT`: 可选参数，指定输出格式。默认格式为 `shell`，但也可以指定为 `json` 或其他支持的格式。

### 示例

#### 示例 1: 使用默认格式（shell）列出 Zoho DNS 模板

```bash
v-list-dns-template zoho
```

输出（示例，实际输出可能有所不同）：

```bash
ID: 1
RECORD: example.com
TYPE: A
VALUE: 192.168.1.1
...
```

#### 示例 2: 使用 JSON 格式列出 Zoho DNS 模板

```bash
v-list-dns-template zoho json
```

输出（示例，实际输出可能有所不同）：

```json
{
  `1`: {
    `RECORD`: `example.com`,
    `TYPE`: `A`,
    `VALUE`: `192.168.1.1`,
    ...
  },
  `2`: {
    `RECORD`: `www.example.com`,
    `TYPE`: `CNAME`,
    `VALUE`: `example.com`,
    ...
  },
  ...
}
```

#### 示例 3: 列出其他 DNS 模板

你可以将 `TEMPLATE` 参数替换为其他 DNS 模板的名称，以获取相应的 DNS 模板参数。

```bash
v-list-dns-template other-template
```

### 注意事项

* 确保已正确安装和配置 Hestia CLI。
* 在使用命令时，请确保具有足够的权限来访问 DNS 模板数据。
* 根据你的需求和偏好，选择合适的输出格式。JSON 格式通常更适合于机器解析和处理，而 shell 格式则更适合于人类阅读。

### 总结

`v-list-dns-template` 命令是 Hestia CLI 提供的一个强大工具，用于获取 DNS 模板参数。通过此命令，用户可以轻松地管理和配置 DNS 模板，以满足其特定的需求。

## v-list-dns-templates

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-dns-templates)

### 介绍

`v-list-dns-templates` 是 Hestia 提供的一个命令行接口（CLI）命令，用于列出所有可用的 DNS 模板。这些模板可以用于快速创建和管理 DNS 记录，提高管理员的工作效率。

### 用法

命令的基本语法如下：

```bash
v-list-dns-templates [FORMAT]
```

其中 `[FORMAT]` 是一个可选参数，用于指定输出格式。如果不指定该参数，则默认为 `shell` 格式。支持的格式包括 `json`、`plain`、`csv` 和 `shell`。

### 示例

1. **默认输出（shell 格式）**

直接运行命令，不指定任何参数，将按照 `shell` 格式列出所有 DNS 模板：

```bash
v-list-dns-templates
```

输出示例：

```bash
TEMPLATE
--------
template1.tpl
template2.tpl
template3.tpl
...
```

2. **JSON 格式输出**

指定 `json` 格式参数，命令将输出一个 JSON 数组，包含所有 DNS 模板的名称：

```bash
v-list-dns-templates json
```

输出示例：

```json
[
  `template1.tpl`,
  `template2.tpl`,
  `template3.tpl`,
  ...
]
```

3. **Plain 格式输出**

指定 `plain` 格式参数，命令将简单地列出所有 DNS 模板的名称，每个模板占一行：

```bash
v-list-dns-templates plain
```

输出示例：

```bash
template1.tpl
template2.tpl
template3.tpl
...
```

4. **CSV 格式输出**

指定 `csv` 格式参数，命令将输出一个 CSV 格式的列表，但请注意，由于这里只有一个字段（模板名称），所以 CSV 格式和 Plain 格式在视觉上非常相似：

```bash
v-list-dns-templates csv
```

输出示例：

```bash
TEMPLATE
template1.tpl
template2.tpl
template3.tpl
...
```

### 注意事项

* 在使用此命令之前，请确保已经正确安装并配置了 Hestia 系统。
* 根据你的 Hestia 安装和配置，DNS 模板的存储位置可能会有所不同。这可能会影响 `v-list-dns-templates` 命令的输出结果。
* 如果遇到任何问题或错误，请查阅 Hestia 的官方文档或联系技术支持以获取帮助。

## v-delete-dns-on-web-alias

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-dns-on-web-alias)

### 概述

`v-delete-dns-on-web-alias` 是 Hestia 提供的命令行工具，用于根据 Web 域名别名删除 DNS 域名或 DNS 记录。该命令特别适用于需要自动化管理 DNS 记录或需要快速响应域名别名更改的情况。

### 语法

```bash
v-delete-dns-on-web-alias USER DOMAIN ALIAS [RESTART]
```

* `USER`: 执行此操作的 Hestia 用户的用户名。
* `DOMAIN`: 域名别名所属的顶级域名。
* `ALIAS`: 要基于其删除 DNS 记录的 Web 域名别名。
* `RESTART` (可选): 如果指定，则重新启动 DNS 服务以使更改生效。

### 示例

#### 示例 1: 删除基于 Web 域名别名的 DNS 记录

假设我们有一个名为 `example.com` 的域名，并且我们想要删除与 `www.example.com` 这个别名相关的 DNS 记录。我们的 Hestia 用户名是 `admin`。

```bash
v-delete-dns-on-web-alias admin example.com www.example.com
```

执行此命令后，与 `www.example.com` 相关的 DNS 记录将被删除。

#### 示例 2: 删除 DNS 记录并重启 DNS 服务

如果我们想要在删除 DNS 记录后立即使更改生效，我们可以使用 `RESTART` 选项。

```bash
v-delete-dns-on-web-alias admin example.com www.example.com RESTART
```

执行此命令后，与 `www.example.com` 相关的 DNS 记录将被删除，并且 DNS 服务将重新启动以应用更改。

### 注意事项

* 在执行此命令之前，请确保您具有足够的权限来删除 DNS 记录。
* 在使用 `RESTART` 选项时，请确保您了解重启 DNS 服务可能带来的任何影响。
* 如果 DNS 记录不存在或无法删除，命令可能会返回错误消息。请检查您的输入和 Hestia 的日志以获取更多信息。

### 总结

`v-delete-dns-on-web-alias` 是一个强大的命令行工具，可用于根据 Web 域名别名快速删除 DNS 记录。通过结合适当的参数和选项，您可以轻松地自动化 DNS 管理任务并确保您的 DNS 记录始终与您的 Web 域名别名保持同步。

## v-delete-dns-record

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-dns-record)

### 命令概述

`v-delete-dns-record` 是 Hestia 提供的一个命令行接口（CLI）命令，用于删除特定 DNS 区域中的某条记录。此命令接受一系列参数，以便用户能够准确地指定要删除的 DNS 记录。

### 命令语法

```bash
v-delete-dns-record USER DOMAIN ID [RESTART]
```

- `USER`：指定执行操作的用户名。
- `DOMAIN`：要操作的 DNS 区域的域名。
- `ID`：要删除的 DNS 记录的 ID。
- `[RESTART]`：可选参数，如果设置为 `yes`，则在删除记录后重新启动 DNS 服务（如果适用）。

### 示例

#### 示例 1：基本使用

删除用户 `john` 在 `example.com` 域名下 ID 为 `42` 的 DNS 记录。

```bash
v-delete-dns-record john example.com 42
```

#### 示例 2：删除后重启服务

删除用户 `jane` 在 `domain.net` 域名下 ID 为 `101` 的 DNS 记录，并在删除后重新启动 DNS 服务。

```bash
v-delete-dns-record jane domain.net 101 yes
```

#### 示例 3：处理错误

尝试删除不存在的记录，并查看命令的响应。

```bash
v-delete-dns-record invaliduser nonexistentdomain.com 999
```

在这种情况下，命令可能会返回一个错误消息，表明指定的用户、域名或记录 ID 不存在。

### 命令执行流程

1. 验证输入参数的有效性，包括用户、域名和记录 ID。
2. 查找并删除指定的 DNS 记录。
3. 如果提供了 `[RESTART]` 参数并且值为 `yes`，则重新启动 DNS 服务（如果适用）。
4. 输出操作结果，包括任何错误消息或成功消息。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来删除指定的 DNS 记录。
- 谨慎使用 `[RESTART]` 参数，因为它会中断 DNS 服务的正常运行。在生产环境中，请确保在维护窗口内执行此操作，并通知相关团队。
- 在删除 DNS 记录之前，请确保没有其他服务或系统依赖于该记录。

### 结论

`v-delete-dns-record` 命令是 Hestia 提供的一个强大的工具，用于管理 DNS 区域中的记录。通过正确使用此命令，您可以轻松地删除不再需要的 DNS 记录，并保持 DNS 区域的清洁和准确。

## v-insert-dns-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-insert-dns-domain)

`v-insert-dns-domain` 是 Hestia 提供的 CLI（命令行接口）命令之一，用于向 DNS 配置中插入原始记录。此命令对于需要直接管理 DNS 配置的用户特别有用。

### 命令格式

```bash
v-insert-dns-domain USER DATA [SRC] [FLUSH]
```

### 参数说明

* `USER`: 指定要操作的用户名。
* `DATA`: 包含要插入的 DNS 记录数据的字符串。
* `SRC` (可选): 数据的来源，通常用于日志记录或审计目的。
* `FLUSH` (可选): 指定是否刷新或覆盖现有记录。可能的值包括 `records`（仅刷新特定域的记录）、`domain`（刷新整个域的记录）或 `no`（不刷新任何记录）。

### 示例

#### 示例 1: 插入新的 A 记录

假设你想为用户 `john` 插入一个新的 A 记录，将 `example.com` 解析到 IP 地址 `192.0.2.1`：

```bash
v-insert-dns-domain john `A example.com 192.0.2.1`
```

#### 示例 2: 插入多个记录并指定来源

如果你想插入多个记录，并指定数据来源为 `manual`：

```bash
v-insert-dns-domain jane `A example.org 192.0.2.2
                          MX example.org mail.example.net 10` manual
```

注意：这里使用了换行符来分隔不同的记录，但在实际命令行中，你可能需要将整个命令放在一行中，或者使用引号将多行数据括起来。

#### 示例 3: 插入记录并刷新整个域

如果你想插入新记录并同时刷新整个域 `example.net` 的现有记录：

```bash
v-insert-dns-domain admin `A www.example.net 192.0.2.3` `` domain
```

在这个例子中，我们使用了空字符串 ```` 作为 `SRC` 参数的占位符，因为我们不关心数据来源。同时，我们指定了 `FLUSH` 参数为 `domain` 以刷新整个域的记录。

### 注意事项

* 在执行 `v-insert-dns-domain` 命令之前，最好备份当前的 DNS 配置文件，以防止任何意外的数据丢失或损坏。
* 如果你的 DNS 配置依赖于特定的顺序或格式，确保你提供的 `DATA` 参数与现有的配置兼容。
* 如果你正在管理一个大型或复杂的 DNS 环境，请确保你了解所有相关的依赖关系和可能的影响。

### 错误处理

* 如果命令执行失败，`v-insert-dns-domain` 通常会返回一个错误代码和描述性消息。请仔细阅读这些消息，以了解失败的原因。
* 如果遇到权限问题或配置错误，你可能需要与管理员或 DNS 提供商联系以获取帮助。

### 日志和审计

* Hestia 系统通常会记录所有 CLI 命令的执行情况，包括 `v-insert-dns-domain`。你可以查看这些日志以跟踪命令的执行历史和任何潜在的问题。
* 如果你的组织有审计要求，确保保存并保护这些日志记录，以便在需要时进行审计。

### 最佳实践

* 在生产环境中执行任何 DNS 更改之前，最好在测试环境中进行验证。这可以帮助你确保更改的准确性和安全性。
* 使用版本控制来管理你的 DNS 配置文件。这允许你跟踪更改历史、回滚错误的更改以及与其他团队成员协作。
* 定期审查你的 DNS 配置，以确保其准确性和安全性。这包括检查是否有不必要的记录、过期的记录或潜在的安全风险。

### 结论

`v-insert-dns-domain` 是一个强大的工具，用于向 Hestia 的 DNS 配置中插入原始记录。通过正确使用此命令，你可以灵活地管理你的 DNS 环境，并根据需要添加新的记录。然而，请务必谨慎使用此命令，并确保你了解所有相关的风险和最佳实践。

## v-insert-dns-record

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-insert-dns-record)

## v-insert-dns-record 命令详解

`v-insert-dns-record` 是 Hestia 提供的 CLI（命令行界面）命令之一，用于向指定的域名配置中插入原始的 DNS 记录。以下是对该命令的详细解释，包括其用法、参数以及示例。

### 命令用法


```bash
v-insert-dns-record USER DOMAIN DATA [RESTART]
```
### 命令参数

* `USER`: 需要向其域名配置中插入 DNS 记录的用户名。
* `DOMAIN`: 需要插入 DNS 记录的域名。
* `DATA`: 要插入的原始 DNS 记录数据。
* `[RESTART]`: 可选参数，如果提供，命令执行后会尝试重启相关的 DNS 服务。

### 示例

#### 示例 1: 插入 A 记录

假设我们要为用户 `john` 的域名 `example.com` 插入一条 A 记录，将 `example.com` 解析到 IP 地址 `192.168.1.1`，可以使用以下命令：


```bash
v-insert-dns-record john example.com `example.com. IN A 192.168.1.1`
```
注意，在 `DATA` 参数中，我们使用了标准的 DNS 记录格式，即 `<域名> <TTL> <类型> <值>`，其中 TTL（Time To Live）在这里省略了，使用了默认的 TTL 值。

#### 示例 2: 插入 MX 记录

如果要为用户 `jane` 的域名 `example.org` 插入一条 MX 记录，将邮件发送到邮件服务器 `mail.example.org`，可以使用以下命令：


```bash
v-insert-dns-record jane example.org `example.org. IN MX 10 mail.example.org.`
```
在这里，我们指定了优先级为 10 的 MX 记录。

#### 示例 3: 插入多条记录并重启服务

如果我们要一次性插入多条记录，并在插入后重启 DNS 服务，可以使用如下命令（注意这里仅为示例，实际中可能需要根据实际情况调整记录和重启服务的逻辑）：


```bash
v-insert-dns-record admin mydomain.com `mydomain.com. IN A 192.168.1.2
www.mydomain.com. IN CNAME mydomain.com.` RESTART
```
请注意，上述命令中的 `DATA` 参数包含了多条记录，每条记录之间使用换行符分隔。另外，我们在命令的末尾添加了 `RESTART` 参数，以指示在插入记录后重启 DNS 服务。

### 注意事项

* 在使用 `v-insert-dns-record` 命令之前，请确保您已经正确配置了 Hestia，并且具有足够的权限来执行该命令。
* 在插入 DNS 记录时，请确保您提供的记录格式正确，并且符合 DNS 协议的规范。
* 如果在插入记录后遇到任何问题，请检查您的 Hestia 日志文件以获取更多信息，并根据需要进行故障排除。
* 在使用 `RESTART` 参数时，请确保您了解重启 DNS 服务的影响，并确保服务重启不会中断关键业务或服务。
* 如果您的 DNS 配置包含复杂的依赖关系或特定顺序，请确保在插入新记录时不会破坏这些依赖关系或顺序。
* 在生产环境中进行 DNS 记录更改之前，最好在测试环境中进行验证，以确保更改的准确性和安全性。

### 权限和安全性

* 当使用 `v-insert-dns-record` 命令时，请确保您以具有适当权限的用户身份运行命令。不要以 root 或具有过多权限的用户身份运行此命令，以减少潜在的安全风险。
* 如果您在多用户环境中使用 Hestia，请确保其他用户没有未授权的访问权限来修改 DNS 记录。您可以通过设置适当的权限和访问控制来限制对 DNS 配置的访问。

### 日志记录

* Hestia 通常会记录 CLI 命令的执行情况，包括 `v-insert-dns-record` 命令。请定期检查 Hestia 的日志文件，以跟踪命令的执行情况、验证更改是否已成功应用，并检查是否有任何潜在的问题或错误。
* 如果您需要对 DNS 更改进行审计，请确保将日志文件保存在安全的位置，并保留足够长的历史记录，以满足您的审计需求。

### 错误处理

* 如果 `v-insert-dns-record` 命令执行失败，它将返回一个错误代码和描述性消息。请仔细阅读这些错误消息，并根据需要进行故障排除。
* 常见的错误可能包括无效的参数、格式错误的 DNS 记录、域名不存在、用户权限不足等。请检查您的命令和参数是否正确，并确保您具有足够的权限来执行该命令。

### 最佳实践

* 在进行 DNS 记录更改之前，最好备份当前的 DNS 配置文件。这样，如果出现问题，您可以轻松地回滚到之前的配置。
* 使用版本控制来管理 DNS 配置文件。这允许您跟踪更改历史、协作编辑配置，并在需要时回滚到以前的版本。
* 定期审查您的 DNS 配置，确保所有记录都是必要的、准确的，并且符合您的安全策略。删除过时或不再需要的记录，以减少潜在的安全风险。

### 结论

`v-insert-dns-record` 命令是 Hestia 提供的强大工具，允许您灵活地管理和更新 DNS 记录。通过正确使用此命令，您可以确保您的 DNS 配置保持最新、准确和安全。然而，请务必谨慎使用此命令，并遵循上述最佳实践和建议，以确保您的 DNS 配置的稳定性和安全性。

## v-insert-dns-records

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-insert-dns-records)

### 引入

Hestia 是一个功能强大的控制面板，用于管理多种网络服务，包括 DNS 记录。`v-insert-dns-records` 命令是 Hestia CLI 提供的一个用于插入 DNS 记录的脚本。本文档将详细介绍该命令的使用方法和示例。

### 命令概述

`v-insert-dns-records` 命令允许用户通过指定用户、域名和数据文件，将 DNS 记录插入到指定的域名配置中。数据文件应包含要插入的 DNS 记录的具体内容。

### 命令格式

```bash
v-insert-dns-records USER DOMAIN DATA_FILE
```

- `USER`: 指定要操作的用户名。
- `DOMAIN`: 指定要插入 DNS 记录的域名。
- `DATA_FILE`: 包含 DNS 记录数据的文件路径。

### 示例

#### 示例 1: 插入 A 记录

假设我们有一个名为 `example.com` 的域名，并且想要插入一个 A 记录，将 `www` 子域名解析到 IP 地址 `192.168.1.1`。我们可以首先创建一个名为 `www_a_record.conf` 的文件，内容如下：

```conf
www IN A 192.168.1.1
```

然后，使用以下命令将记录插入到 `example.com` 域名的配置中：

```bash
v-insert-dns-records username example.com /path/to/www_a_record.conf
```

#### 示例 2: 插入多个记录

如果我们想要插入多个记录，比如一个 A 记录和一个 MX 记录，我们可以创建一个包含多个记录的文件，例如 `multiple_records.conf`：

```conf
www IN A 192.168.1.1
example.com IN MX 10 mail.example.com
```

然后，使用相同的命令将多个记录插入到域名的配置中：

```bash
v-insert-dns-records username example.com /path/to/multiple_records.conf
```

### 注意事项

- 在执行命令之前，请确保您具有足够的权限来修改 DNS 记录。
- 数据文件应仅包含有效的 DNS 记录格式。
- 如果指定的数据文件不存在或无法读取，命令将失败。
- 在将 DNS 记录插入到配置文件后，可能需要重启 DNS 服务或执行其他操作才能使更改生效。这取决于您的 Hestia 配置和 DNS 服务器的设置。

### 总结

`v-insert-dns-records` 命令是 Hestia CLI 提供的一个强大工具，允许用户通过指定用户、域名和数据文件来插入 DNS 记录。通过创建包含 DNS 记录数据的文件，并使用该命令将其插入到域名的配置中，用户可以轻松管理 DNS 记录。

## v-get-dns-domain-value

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-get-dns-domain-value)

### 概述

`v-get-dns-domain-value` 是 Hestia 系统中用于获取特定 DNS 域名参数的命令行接口（CLI）命令。通过此命令，用户能够方便地检索 DNS 记录的详细信息，如 SOA（起始授权机构）、NS（名称服务器）等。

### 用法

```bash
v-get-dns-domain-value USER DOMAIN KEY
```

* **USER**：执行命令的用户，通常具有特定的权限和角色。
* **DOMAIN**：要查询的 DNS 域名。
* **KEY**：要检索的 DNS 记录的关键字，如 SOA、NS、MX 等。

### 示例

#### 示例 1：获取域名的 SOA 记录

```bash
v-get-dns-domain-value admin example.com SOA
```

在这个示例中，用户 `admin` 正在请求获取域名 `example.com` 的 SOA 记录。

#### 示例 2：获取域名的 NS 记录

```bash
v-get-dns-domain-value admin example.org NS
```

在这个示例中，用户 `admin` 正在请求获取域名 `example.org` 的 NS 记录。

#### 示例 3：错误用法

```bash
v-get-dns-domain-value admin example.com
```

注意：此命令缺少必要的 `KEY` 参数，将会导致错误或无效的输出。

### 注意事项

* 在执行此命令之前，请确保您已经正确登录到 Hestia 系统，并且具有执行此命令的权限。
* 请确保提供的 `DOMAIN` 和 `KEY` 参数是准确和有效的，以避免不必要的错误和混淆。
* 如果命令执行失败或返回意外的结果，请检查您的输入和 Hestia 系统的状态。

### 结论

`v-get-dns-domain-value` 是一个功能强大的 Hestia CLI 命令，允许用户方便地检索 DNS 域名的特定记录。通过提供正确的用户、域名和关键字参数，用户可以轻松地获取所需的信息。在使用此命令时，请确保遵循上述指南和注意事项，以确保最佳的性能和结果。

## v-list-user-ns

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-user-ns)

### 简介

`v-list-user-ns` 是 Hestia 提供的 CLI（命令行界面）命令之一，用于列出指定用户的 DNS 服务器（nameservers）。这个命令在管理员进行用户网络配置管理时非常有用。

### 命令语法

```bash
v-list-user-ns USER [FORMAT]
```

- `USER`: 要查询的用户名。
- `FORMAT`: 可选参数，指定输出格式。如果不指定，则默认为 shell 格式。

### 输出格式

- `shell`: 以 shell 脚本友好的格式输出，每行一个 DNS 服务器地址。
- `json`: 以 JSON 数组格式输出，包含所有 DNS 服务器地址。
- `csv`: 以 CSV（逗号分隔值）格式输出，包含一行标题和所有 DNS 服务器地址。
- `plain`: 以纯文本格式输出，每行一个 DNS 服务器地址（与 shell 格式类似，但不带任何特殊字符）。

### 示例

#### 示例 1: 使用默认 shell 格式列出用户 admin 的 DNS 服务器

```bash
v-list-user-ns admin
```

输出可能如下：

```bash
ns1.example.com
ns2.example.com
ns3.example.org
```

#### 示例 2: 使用 JSON 格式列出用户 admin 的 DNS 服务器

```bash
v-list-user-ns admin json
```

输出可能如下：

```json
[
    `ns1.example.com`,
    `ns2.example.com`,
    `ns3.example.org`
]
```

#### 示例 3: 使用 CSV 格式列出用户 admin 的 DNS 服务器

```bash
v-list-user-ns admin csv
```

输出可能如下：

```csv
NAMESERVER
ns1.example.com
ns2.example.com
ns3.example.org
```

#### 示例 4: 使用 plain 格式列出用户 admin 的 DNS 服务器（与 shell 格式类似）

```bash
v-list-user-ns admin plain
```

输出与 shell 格式相同：

```bash
ns1.example.com
ns2.example.com
ns3.example.org
```

### 注意事项

- 确保您有足够的权限来执行 `v-list-user-ns` 命令。
- 如果用户不存在或没有 DNS 服务器配置，命令可能会返回空或错误消息。
- 输出格式的具体内容可能会根据 Hestia 的版本和配置有所不同。

### 总结

`v-list-user-ns` 命令为 Hestia 管理员提供了一个方便的方式来查看用户的 DNS 服务器配置。通过指定不同的输出格式，可以轻松地将其集成到各种自动化脚本或工具中。

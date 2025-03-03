# 密钥系列命令介绍

## v-list-dnssec-public-key

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-dnssec-public-key)

### 概述

`v-list-dnssec-public-key` 是一个基于 Bash 脚本的命令行工具，用于列出与 DNSSEC（域名系统安全扩展）相关的公钥。该命令适用于在 Hestia 控制面板环境中运行的服务器，并允许用户获取指定域名的 DNSSEC 公钥信息。

### 使用方法

#### 语法

```bash
v-list-dnssec-public-key USER DOMAIN [FORMAT]
```

- `USER`: 用户名，通常是 Hestia 控制面板的认证用户。
- `DOMAIN`: 需要查询 DNSSEC 公钥的域名。
- `[FORMAT]`: 可选参数，用于指定输出格式（如 JSON、SHELL、PLAIN 等）。

#### 示例

1. **获取域名 acme.com 的 DNSSEC 公钥信息（默认格式）**

```bash
v-list-dnssec-public-key admin acme.com
```

2. **以 JSON 格式获取域名 example.org 的 DNSSEC 公钥信息**

```bash
v-list-dnssec-public-key admin example.org JSON
```

   输出可能类似于：

```json
{
"example.org": {
"RECORD": "example.org. IN DNSKEY ...",
"KEYTAG": "12345",
"FLAG": "257",
"ALGORITHM": "3",
"KEY": "...Base64 encoded key...",
"DS": "...DS record..."
}
}
```

3. **以纯文本格式仅获取 DS 记录**

```bash
v-list-dnssec-public-key admin example.org PLAIN DS
```

   输出可能类似于：

```bash
example.org. 3600 IN DS ...
```

### 细节分析

- 脚本首先定义了必要的变量和函数，如 `json_list`、`shell_list` 和 `plain_list`，这些函数根据提供的 `FORMAT` 参数来格式化输出。
- 脚本使用 `grep` 命令从 `dns.conf` 文件中查找指定的域名，并解析相关的 DNSSEC 键值对。
- 如果找到有效的 `KEY` 值，脚本会进一步从 `/var/cache/bind/` 目录中读取对应的 DNSKEY 文件，并使用 `dnssec-dsfromkey` 工具生成 DS 记录。
- 脚本的输出格式由 `FORMAT` 参数控制，允许用户以 JSON、SHELL 或 PLAIN 格式获取结果。

### 注意事项

- 用户需要具有适当的权限才能运行此命令，通常是以 Hestia 控制面板的管理员身份。
- 脚本依赖于 `/etc/hestiacp/hestia.conf` 和其他相关配置文件，因此确保这些文件存在且可访问。
- 如果服务器未安装 `dnssec-dsfromkey` 工具或 BIND 缓存目录不存在，则命令可能会失败。

### 总结

`v-list-dnssec-public-key` 命令是一个用于获取 DNSSEC 公钥信息的实用工具，特别适用于 Hestia 控制面板环境。通过指定用户名、域名和输出格式，用户可以轻松地获取和格式化 DNSSEC 相关的公钥和 DS 记录。该命令为管理员和开发者提供了方便的接口，以集成 DNSSEC 功能到其他系统或应用中。

## v-add-access-key

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-access-key)

### 命令简介

`v-add-access-key` 是 Hestia 提供的 CLI 命令，用于生成和管理访问密钥。通过此命令，系统管理员可以为指定用户生成访问密钥对，以便用户可以使用这些密钥进行 API 访问或其他认证操作。

### 命令语法

```bash
v-add-access-key USER [PERMISSIONS] [COMMENT] [FORMAT]
```

* **USER**：必需参数，指定要为其生成访问密钥的用户名。
* **PERMISSIONS**：可选参数（仅对 admin 用户），指定与该密钥关联的权限列表，多个权限之间使用逗号分隔。
* **COMMENT**：可选参数，为密钥添加描述性注释。
* **FORMAT**：可选参数，指定输出格式的类型（默认为 shell），例如 json、yaml 等。

### 示例

#### 示例 1：为 admin 用户生成访问密钥

```bash
v-add-access-key admin
```

**输出**：

* 系统将生成一个包含 `access_key_id` 和 `secret_access_key` 的密钥对，并以默认的 shell 格式显示。

#### 示例 2：为 admin 用户生成带有特定权限的访问密钥

```bash
v-add-access-key admin v-purge-nginx-cache,v-list-mail-accounts
```

**注意**：此示例中的 `PERMISSIONS` 参数仅对 admin 用户有效。

**输出**：

* 系统将生成一个包含指定权限的密钥对，并以默认的 shell 格式显示。

#### 示例 3：为普通用户生成带有注释的访问密钥，并以 JSON 格式输出

```bash
v-add-access-key username comment json
```

**输出**：

* 系统将生成一个为普通用户 `username` 的密钥对，并附带一个注释 "comment"。输出将以 JSON 格式显示，包含 `access_key_id`、`secret_access_key` 和注释信息。

### 注意事项

* 请确保为密钥选择强密码，并定期更换以提高安全性。
* 不要在公共或不受信任的地方共享或存储密钥。
* 密钥的 `PERMISSIONS` 参数仅对 admin 用户有效，对于普通用户，此参数将被忽略。
* 在使用 CLI 命令时，请确保您具有足够的权限来执行该操作。

### 总结

`v-add-access-key` 命令是 Hestia 中用于生成和管理访问密钥的重要工具。通过该命令，系统管理员可以方便地为用户生成密钥对，并指定相关的权限和注释信息。请务必注意密钥的安全性和保密性，以确保系统的稳定运行和数据安全。

## v-check-access-key

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-check-access-key)

### 概述

`v-check-access-key` 是 Hestia 提供的一个命令行接口（CLI）工具，用于验证给定的访问密钥（Access Key ID 和 Secret Access Key）是否有权限执行特定的命令。此命令在执行前会检查密钥是否存在、密钥对是否匹配、用户是否被暂停以及用户是否有权限执行指定的命令。

### 语法


```bash
v-check-access-key ACCESS_KEY_ID SECRET_ACCESS_KEY COMMAND [IP] [FORMAT]
```
### 参数说明

* `ACCESS_KEY_ID`: 访问密钥 ID。
* `SECRET_ACCESS_KEY`: 访问密钥的密文。
* `COMMAND`: 要验证的命令。
* `IP` (可选): 发起请求的 IP 地址，默认为 `127.0.0.1`。
* `FORMAT` (可选): 输出格式，可以是 `json` 或 `shell`，默认为 `shell`。

### 示例

#### 示例 1: 验证访问密钥是否有权限执行 `v-purge-nginx-cache` 命令

```bash
v-check-access-key key_id_example secret_key_example v-purge-nginx-cache
```

如果验证成功，将输出类似以下信息（默认为 shell 格式）：

```shell
Access key validated successfully.
User has permission to execute the command.
```

#### 示例 2: 验证访问密钥并指定 IP 地址和 JSON 输出格式

```bash
v-check-access-key key_id_example secret_key_example v-purge-nginx-cache 192.168.1.1 json
```

如果验证成功，将输出类似以下 JSON 格式的信息：

```json
{
  "status": "success",
  "message": "Access key validated successfully. User has permission to execute the command."
}
```

#### 示例 3: 访问密钥无效或权限不足

如果提供的访问密钥无效或用户没有执行指定命令的权限，将输出相应的错误信息。

```bash
v-check-access-key invalid_key_id invalid_secret_key v-purge-nginx-cache
```

可能的错误输出（shell 格式）：

```shell
Access key validation failed. Please check your credentials.
```

### 注意事项

* 请确保提供的访问密钥 ID 和密文正确无误。
* 验证过程可能受到 Hestia 系统策略、用户状态和其他因素的影响。
* 如果在验证过程中遇到任何问题，请检查 Hestia 的日志文件或联系系统管理员以获取更多帮助。

## v-update-sys-defaults

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-sys-defaults)

### 简介

`v-update-sys-defaults` 是 Hestia 系统中用于更新默认键值对数据库的 CLI 命令。此命令旨在帮助管理员和系统维护者快速、高效地更新系统配置，确保系统的稳定和安全。

### 用法

#### 基本用法

直接运行 `v-update-sys-defaults` 命令将更新所有默认的系统配置。

```bash
v-update-sys-defaults
```

### 特定系统更新

如果需要仅更新特定系统的配置，可以在命令后附加系统名称作为参数。例如，要更新用户系统的配置，可以运行：

```bash
v-update-sys-defaults user
```

#### 示例

1. **更新所有系统默认配置**：

```bash
v-update-sys-defaults
```

运行此命令后，Hestia 将按照预定的流程更新所有系统的默认配置。

2. **更新用户系统默认配置**：

```bash
v-update-sys-defaults user
```

运行此命令后，Hestia 将仅更新与用户系统相关的默认配置。

#### 实现原理

`v-update-sys-defaults` 命令通过读取配置文件和调用相关函数来实现配置更新。该命令首先确定是否传递了系统参数（如 "user"），然后调用相应的更新函数。如果没有传递系统参数，则默认更新所有系统的配置。

#### 配置文件

Hestia 使用多个配置文件来存储系统配置信息。这些配置文件通常位于 `/etc/hestiacp/` 和 `/usr/local/hestia/conf/` 目录下。`v-update-sys-defaults` 命令通过读取这些配置文件来获取配置信息，并据此执行更新操作。

#### 函数调用

命令脚本中定义了一系列函数（如 `syshealth_update_${system}_config_format`），用于处理不同系统的配置更新。根据传递的系统参数，命令将调用相应的函数来执行更新操作。

### 日志记录

`v-update-sys-defaults` 命令在执行过程中会记录日志信息。通过调用 `log_event` 函数，命令可以将执行结果（成功或失败）以及相关参数记录到日志文件中，以便后续查看和分析。

### 注意事项

* 在执行 `v-update-sys-defaults` 命令之前，请确保已备份重要数据，以防意外情况导致数据丢失。
* 如果在更新过程中遇到问题或错误，请检查日志文件以获取更多信息，并根据需要进行故障排除。
* 请勿在未经授权的情况下修改系统配置文件或执行更新操作，以免对系统造成不必要的损害。

## v-delete-access-key

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-access-key)

### 概述

`v-delete-access-key` 是 Hestia 提供的命令行工具之一，用于删除存储在 Hestia 系统中的访问密钥。这些密钥通常用于 API 访问、远程认证等场景。本指南将详细介绍该命令的使用方法和注意事项。

### 使用方法

基本语法：

```bash
v-delete-access-key ACCESS_KEY_ID
```

其中，`ACCESS_KEY_ID` 是要删除的访问密钥的唯一标识符。

### 示例

**示例 1：删除指定访问密钥**

假设要删除名为 `mykey` 的访问密钥，可以执行以下命令：

```bash
v-delete-access-key mykey
```

执行成功后，Hestia 将从系统中删除该访问密钥，并返回相应的成功消息。

**示例 2：检查访问密钥是否存在**

在删除访问密钥之前，你可能想要确认它是否存在于系统中。虽然 `v-delete-access-key` 命令本身不提供直接检查密钥存在的功能，但你可以结合其他命令或脚本来实现。例如，你可以编写一个脚本来查询 Hestia 的访问密钥列表，并检查指定的密钥是否在其中。

**示例 3：批量删除访问密钥**

如果你需要批量删除多个访问密钥，可以编写一个循环或脚本来自动执行 `v-delete-access-key` 命令。请确保在批量删除之前仔细检查密钥列表，以避免误删重要的访问密钥。

### 注意事项

* 在执行 `v-delete-access-key` 命令之前，请确保你具有足够的权限来删除访问密钥。
* 删除访问密钥后，与该密钥关联的所有 API 调用和远程认证请求都将失败。请确保在删除之前通知所有相关方。
* 请谨慎使用此命令，以避免误删重要的访问密钥。

### 常见问题

* **Q：** 我如何获取访问密钥的列表以确认要删除的密钥？
* **A：** Hestia 可能提供了其他 CLI 命令或 Web 界面来查看访问密钥列表。请查阅 Hestia 的官方文档以获取更多信息。
* **Q：** 我可以恢复已删除的访问密钥吗？
* **A：** 一旦删除访问密钥，通常无法恢复。请确保在删除之前仔细考虑并备份重要的访问密钥（如果需要）。

### 总结

`v-delete-access-key` 是 Hestia 提供的一个强大的命令行工具，用于删除系统中的访问密钥。通过本指南，你应该能够了解该命令的使用方法、示例、注意事项和常见问题。如有更多疑问，请查阅 Hestia 的官方文档或联系技术支持团队。
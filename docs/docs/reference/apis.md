# API系列命令介绍

## v-run-cli-cmd

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-run-cli-cmd)

### 概述

`v-wrapper-hestia-api` 是一个为 Hestia 环境设计的命令行接口（CLI）包装器脚本。该脚本旨在提供一个安全、可控的方式来以特定用户身份执行 CLI 命令。它允许系统管理员或用户执行各种任务，同时确保命令的执行环境受到限制和监控。

### 用法

### 语法

```bash
v-wrapper-hestia-api USER CLI_COMMAND [ARGS...]
```

- `USER`: 执行命令的目标用户名。
- `CLI_COMMAND`: 要执行的 CLI 命令。
- `[ARGS...]`: 可选的命令参数。

#### 示例

#### 示例 1: 以特定用户身份列出目录内容

```bash
v-wrapper-hestia-api john_doe ls -l /home/john_doe/documents
```

#### 示例 2: 使用 WordPress CLI 管理插件

```bash
v-wrapper-hestia-api wordpress_admin wp plugin list --status=active
```

#### 示例 3: 使用 Composer 安装 PHP 依赖

```bash
v-wrapper-hestia-api composer_user composer install --no-dev
```

### 安全性考虑

- **用户验证**：脚本首先会验证用户是否存在，并检查其家目录是否可访问。
- **命令验证**：脚本会检查请求的 CLI 命令是否存在于系统的 PATH 中，并且是否在预定义的允许命令列表中。
- **执行环境**：使用 `runuser` 命令以指定用户的身份执行命令，确保权限隔离。
- **错误处理**：如果命令执行失败，脚本会记录错误信息并退出，同时返回非零状态码。

### 功能特性

- **命令白名单**：脚本包含一个允许命令的白名单，确保只有预定义的命令可以被执行。
- **日志记录**：所有执行的命令和结果都会被记录到日志中，便于后续审计和监控。
- **参数处理**：支持将任意数量的参数传递给执行的命令。
- **用户友好性**：提供清晰的错误信息和用法说明，提高用户体验。

### 自定义配置

- **修改允许命令列表**：编辑脚本中的 `$basecmd` 检查部分，可以添加或删除允许的命令。
- **日志配置**：可以通过修改脚本中的日志记录部分来配置日志文件的存储位置、格式等。

### 注意事项

- 在使用脚本之前，请确保您已充分了解其功能和限制。
- 不要在不受信任的环境中执行此脚本，以防止潜在的安全风险。
- 定期检查脚本的日志记录，以监控命令的执行情况和潜在的安全问题。

### 结论

`v-wrapper-hestia-api` 是一个功能强大且安全的 CLI 包装器脚本，适用于 Hestia 环境中的命令执行需求。通过提供用户验证、命令验证和日志记录等功能，它能够帮助管理员和用户以安全、可控的方式执行 CLI 命令。

## v-check-api-key

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-check-api-key)

### 概述

`v-check-api-key` 是 Hestia 系统中用于检查 API 密钥是否有效的命令行工具。它检查指定的 API 密钥是否存在于 Hestia 密钥存储路径下，并验证其长度是否符合要求。此命令通常用于 API 服务的访问控制，确保只有持有有效密钥的请求者能够访问受保护的资源。

### 用法

### 语法

```bash
v-check-api-key KEY [IP]
```

- `KEY`: 要检查的 API 密钥。
- `[IP]`: 可选参数，指定请求者的 IP 地址。默认为 `127.0.0.1`。

### 示例

#### 示例 1: 检查名为 "random_key" 的密钥

```bash
v-check-api-key random_key
```

#### 示例 2: 检查名为 "secret_key" 的密钥，并指定 IP 地址为 "192.168.1.1"

```bash
v-check-api-key secret_key 192.168.1.1
```

### 功能特性

- **密钥验证**：检查指定的密钥是否存在于 Hestia 密钥存储路径下。
- **长度检查**：确保密钥长度至少为 16 个字符。
- **只读模式检查**：在只读模式下运行时会执行额外的验证（如果存在该功能）。
- **日志记录**：记录密钥验证的结果到 Hestia 的认证日志文件中。

### 安全考虑

- **密钥保护**：密钥文件存储在受限制访问的目录中，只有具有适当权限的用户才能访问。
- **IP 记录**：记录尝试验证的 IP 地址，有助于追踪潜在的恶意访问。
- **错误处理**：如果密钥验证失败，将记录错误消息并退出脚本，同时返回错误代码。

### 自定义配置

- **密钥存储路径**：密钥文件默认存储在 `${HESTIA}/data/keys/` 目录下，可以通过修改 Hestia 配置文件来更改此路径。
- **日志记录**：认证日志默认记录到 `${HESTIA}/log/auth.log` 文件中，可以根据需要配置日志记录级别和格式。

### 注意事项

- 使用该命令时，请确保只有受信任的用户具有执行权限，以避免未经授权的密钥验证尝试。
- 定期检查和审核认证日志文件，以发现任何潜在的异常或未经授权的访问尝试。
- 如果密钥被泄露或认为不再安全，请立即从密钥存储中删除该密钥，并更新所有使用该密钥的服务和应用程序。

### 结论

`v-check-api-key` 命令是 Hestia 系统中一个重要的安全工具，用于验证 API 密钥的有效性。通过结合密钥存储、长度检查、只读模式验证和日志记录等功能，该命令为 API 服务的访问控制提供了强大的支持。使用此命令时，请确保遵循最佳的安全实践，并定期监控和审核相关日志以维护系统的安全性。

## v-change-sys-api

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-sys-api)

### 概述

`v-change-sys-api` 是 Hestia 系统中用于更改系统 API 状态的命令行工具。它允许管理员启用、禁用或完全移除系统 API，并通过参数指定要操作的 API 版本（legacy、api 或 all）。

### 用法

### 语法

```bash
v-change-sys-api STATUS VERSION
```

- `STATUS`: 指定 API 的状态，可选值包括 `enable`、`disable` 和 `remove`。
- `VERSION`: 指定要操作的 API 版本，可选值包括 `legacy`、`api` 和 `all`。

### 示例

#### 示例 1: 启用所有版本的 API

```bash
v-change-sys-api enable all
```

#### 示例 2: 禁用 legacy 版本的 API

```bash
v-change-sys-api disable legacy
```

#### 示例 3: 移除所有 API 版本

```bash
v-change-sys-api remove all
```

### 功能特性

- **启用/禁用 API**：根据提供的 `STATUS` 参数，启用或禁用系统 API。
- **版本控制**：通过 `VERSION` 参数指定要操作的 API 版本。
- **配置文件更新**：使用 `v-change-sys-config-value` 命令更新系统配置文件中的 API 相关设置。
- **API 文件管理**：根据 API 的状态，下载、修改或删除 API 入口文件（`index.php`）。
- **日志记录**：记录 API 状态更改的操作到系统日志中。

### 注意事项

- **权限**：执行此命令需要具有相应的系统权限。
- **文件完整性**：在启用 API 时，如果 API 入口文件不存在，将从指定的 GitHub 仓库下载。请确保网络连接正常且仓库路径正确。
- **版本兼容性**：在启用或禁用特定版本的 API 时，请确保您的系统与该版本 API 兼容。
- **日志审核**：定期查看系统日志，以验证 API 状态更改的操作是否成功执行。

### 自定义配置

- **API 入口文件路径**：API 入口文件默认存储在 `$HESTIA/web/api/index.php`。您可以通过修改 Hestia 配置文件来更改此路径。
- **系统配置文件**：API 相关设置存储在 Hestia 的系统配置文件中。您可以使用 `v-change-sys-config-value` 命令或编辑配置文件来更改这些设置。

### 结论

`v-change-sys-api` 命令是 Hestia 系统中用于管理系统 API 状态的重要工具。通过它，您可以轻松地启用、禁用或移除 API，并根据需要指定要操作的 API 版本。在使用此命令时，请确保遵循最佳的安全实践，并定期检查系统日志以验证操作的成功执行。

## v-change-remote-dns-domain-exp

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-remote-dns-domain-exp)

### 概述

`v-change-remote-dns-domain-exp` 是 Hestia 系统中的一个命令行工具，用于更改远程 DNS 集群中特定用户的指定域名的 DNS 条目，通常用于域名到期或续期的自动化处理。此命令会遍历所有激活的 DNS 集群，并根据域名的当前设置进行必要的更改。

### 用法

### 语法

```bash
v-change-remote-dns-domain-exp USER DOMAIN
```

- `USER`: 要更改 DNS 条目的用户的用户名。
- `DOMAIN`: 要更改的域名。

### 示例

#### 示例 1: 更改用户 `john` 的域名 `example.com` 的 DNS 条目

```bash
v-change-remote-dns-domain-exp john example.com
```

### 功能特性

- **远程 DNS 集群操作**：该命令能够遍历所有激活的 DNS 集群，并对指定用户的域名进行更改。
- **自动检测与更新**：命令会检查 DNS 集群的健康状况，并自动更新域名的 DNS 记录（如果适用）。
- **Hestia 集群支持**：如果 DNS 集群使用的是 Hestia 自带的 `hestia-zone` 系统，则会自动设置 SLAVE 和 MASTER IP。
- **错误处理与日志记录**：命令会检查每一步操作的结果，并在出现错误时记录相应的错误消息。

### 注意事项

- **权限**：执行此命令的用户需要具有相应的权限，以便能够访问和修改 DNS 集群中的 DNS 记录。
- **DNS 集群配置**：确保 `dns-cluster.conf` 文件中包含了所有要操作的 DNS 集群的配置信息，并且这些集群都处于激活状态（`SUSPENDED='no'`）。
- **DNS 集群健康检查**：命令会执行远程 DNS 集群的健康检查，确保集群能够正常响应命令。
- **Hestia 集群系统**：如果 DNS 集群使用的是 Hestia 自带的 `hestia-zone` 系统，则需要注意 MASTER IP 的设置，并确保该 IP 地址是可用的。

### 自定义配置

- **DNS 集群配置文件**：`dns-cluster.conf` 文件包含了所有 DNS 集群的配置信息，可以通过修改该文件来添加、删除或修改 DNS 集群的配置。
- **用户数据目录**：用户数据目录（默认为 `$USER_DATA`）存储了用户的 DNS 配置信息，包括域名、IP 地址等。可以根据需要自定义该目录的位置和结构。
- **队列管道文件**：`dns-cluster.pipe` 文件用于存储待处理的 DNS 集群命令队列。如果需要自定义队列处理逻辑，可以修改该文件或相关的脚本文件。

### 结论

`v-change-remote-dns-domain-exp` 命令是 Hestia 系统中一个功能强大的工具，用于自动化处理远程 DNS 集群中特定用户的域名到期或续期操作。通过遍历所有激活的 DNS 集群并自动更新域名的 DNS 记录，该命令能够显著提高域名管理的效率和准确性。在使用此命令时，请确保遵循相关的最佳实践和注意事项，以确保命令能够正确执行并达到预期的效果。

## v-change-remote-dns-domain-soa

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-remote-dns-domain-soa)

### 概述

`v-change-remote-dns-domain-soa` 是 Hestia 系统中用于更新远程 DNS 集群中特定用户的指定域名的起始授权机构（SOA）记录的命令行工具。此命令会遍历所有激活的 DNS 集群，并根据域名的当前设置进行必要的更改，包括设置 SLAVE 和 MASTER IP（如果适用），并重建 DNS 域的 SOA 记录。

### 用法

### 语法

```bash
v-change-remote-dns-domain-soa USER DOMAIN
```

- `USER`: 要更改 DNS SOA 记录的用户的用户名。
- `DOMAIN`: 要更改的域名。

### 示例

#### 示例 1: 更改用户 `john` 的域名 `example.com` 的 DNS SOA 记录

```bash
v-change-remote-dns-domain-soa john example.com
```

### 功能特性

- **远程 DNS 集群操作**：该命令能够遍历所有激活的 DNS 集群，并对指定用户的域名进行 SOA 记录的更新。
- **Hestia 集群支持**：如果 DNS 集群使用的是 Hestia 自带的 `hestia-zone` 系统，则会自动设置 SLAVE 和 MASTER IP。
- **自动重建 DNS 域**：命令会触发 DNS 域的重建过程，以确保新的 SOA 记录生效。
- **错误处理与日志记录**：命令会检查每一步操作的结果，并在出现错误时记录相应的错误消息。

### 注意事项

- **权限**：执行此命令的用户需要具有相应的权限，以便能够访问和修改 DNS 集群中的 DNS 记录。
- **DNS 集群配置**：确保 `dns-cluster.conf` 文件中包含了所有要操作的 DNS 集群的配置信息，并且这些集群都处于激活状态（`SUSPENDED='no'`）。
- **DNS 集群健康检查**：命令会执行远程 DNS 集群的健康检查，确保集群能够正常响应命令。
- **Hestia 集群系统**：如果 DNS 集群使用的是 Hestia 自带的 `hestia-zone` 系统，则需要注意 MASTER IP 的设置，并确保该 IP 地址是可用的。

### 自定义配置

- **DNS 集群配置文件**：`dns-cluster.conf` 文件包含了所有 DNS 集群的配置信息，可以通过修改该文件来添加、删除或修改 DNS 集群的配置。
- **用户数据目录**：用户数据目录（默认为 `$USER_DATA`）存储了用户的 DNS 配置信息，包括域名、IP 地址等。可以根据需要自定义该目录的位置和结构。
- **队列管道文件**：`dns-cluster.pipe` 文件用于存储待处理的 DNS 集群命令队列。如果需要自定义队列处理逻辑，可以修改该文件或相关的脚本文件。

### 结论

`v-change-remote-dns-domain-soa` 命令是 Hestia 系统中一个用于自动化更新远程 DNS 集群中特定用户的域名 SOA 记录的工具。通过遍历所有激活的 DNS 集群并自动更新域名的 SOA 记录，该命令能够确保 DNS 记录的准确性和一致性。在使用此命令时，请确保遵循相关的最佳实践和注意事项，以确保命令能够正确执行并达到预期的效果。

## v-change-remote-dns-domain-ttl

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-remote-dns-domain-ttl)

### 概述

`v-change-remote-dns-domain-ttl` 是 Hestia 系统中用于更改远程 DNS 集群中特定用户的指定域名的 TTL（生存时间）设置的命令行工具。TTL 决定了 DNS 记录在被缓存之前可以被缓存多久，这对于控制 DNS 记录的更新速度非常重要。此命令会遍历所有激活的 DNS 集群，并更新指定域名的 TTL 设置。

**注意**：尽管脚本名为 `v-change-remote-dns-domain-ttl`，但根据提供的脚本内容，它实际上并没有直接更改 TTL 的值。它似乎是一个更通用的脚本，用于重新插入和重建 DNS 域名记录，而不仅仅是更改 TTL。为了保持文档的一致性，我们将假设此脚本是一个用于管理 DNS 记录的通用工具，并专注于描述其功能。

### 用法

### 语法

```bash
v-change-remote-dns-domain-ttl USER DOMAIN
```

- `USER`: 要更改 DNS 记录的用户的用户名。
- `DOMAIN`: 要更改的域名。

### 示例

#### 示例 1: 更改用户 `john` 的域名 `example.com` 的 DNS 记录（包括可能的 TTL）

```bash
v-change-remote-dns-domain-ttl john example.com
```

**注意**：由于脚本本身不直接提供更改 TTL 的功能，上述命令实际上会触发域名的 DNS 记录的重新插入和重建过程。如果您需要更改 TTL，您可能需要手动编辑 DNS 记录或使用其他工具/命令。

### 功能特性

- **远程 DNS 集群操作**：该命令能够遍历所有激活的 DNS 集群，并对指定用户的域名进行 DNS 记录的重新插入和重建。
- **Hestia 集群支持**：如果 DNS 集群使用的是 Hestia 自带的 `hestia-zone` 系统，则会自动设置 SLAVE 和 MASTER IP（如果适用）。
- **自动重建 DNS 域**：命令会触发 DNS 域的重建过程，以确保 DNS 记录的准确性和一致性。
- **错误处理与日志记录**：命令会检查每一步操作的结果，并在出现错误时记录相应的错误消息。

### 注意事项

- **权限**：执行此命令的用户需要具有相应的权限，以便能够访问和修改 DNS 集群中的 DNS 记录。
- **DNS 集群配置**：确保 `dns-cluster.conf` 文件中包含了所有要操作的 DNS 集群的配置信息，并且这些集群都处于激活状态（`SUSPENDED='no'`）。
- **DNS 集群健康检查**：命令会执行远程 DNS 集群的健康检查，确保集群能够正常响应命令。
- **Hestia 集群系统**：如果 DNS 集群使用的是 Hestia 自带的 `hestia-zone` 系统，则需要注意 MASTER IP 的设置，并确保该 IP 地址是可用的。

### 自定义配置

- **DNS 集群配置文件**：`dns-cluster.conf` 文件包含了所有 DNS 集群的配置信息，可以通过修改该文件来添加、删除或修改 DNS 集群的配置。
- **用户数据目录**：用户数据目录（默认为 `$USER_DATA`）存储了用户的 DNS 配置信息，包括域名、IP 地址等。可以根据需要自定义该目录的位置和结构。
- **队列管道文件**：`dns-cluster.pipe` 文件用于存储待处理的 DNS 集群命令队列。如果需要自定义队列处理逻辑，可以修改该文件或相关的脚本文件。

### 结论

尽管 `v-change-remote-dns-domain-ttl` 命令的名称暗示它可以更改 TTL 设置，但根据提供的脚本内容，它实际上是一个用于重新插入和重建 DNS 记录的通用工具。不过，这仍然是一个强大的工具，可以帮助管理员管理远程 DNS 集群中的 DNS 记录。在使用此命令时，请确保遵循相关的最佳实践和注意事项，以确保命令能够正确执行并达到预期的效果。

## v-revoke-api-key

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-revoke-api-key)

### 概述

`v-revoke-api-key` 是一个 Hestia 提供的命令行工具，用于撤销特定的 API 密钥。API 密钥是访问 Hestia 系统 API 的重要凭证，撤销密钥可以确保不再使用该密钥进行 API 访问，从而提高系统的安全性。

### 用法

### 语法

```bash
v-revoke-api-key HASH
```

- `HASH`: 要撤销的 API 密钥的哈希值。

### 示例

#### 示例 1: 撤销 API 密钥

假设你有一个 API 密钥的哈希值为 `abcdef1234567890`，你可以使用以下命令来撤销它：

```bash
v-revoke-api-key abcdef1234567890
```

执行成功后，该 API 密钥将不再有效，任何使用该密钥的 API 请求都将被拒绝。

### 功能特性

- **撤销 API 密钥**：通过提供 API 密钥的哈希值，可以撤销指定的 API 密钥，确保密钥不再被用于 API 访问。
- **验证参数**：命令会验证是否提供了必要的参数（即 API 密钥的哈希值），以及参数的格式是否正确。
- **检查只读模式**：如果 Hestia 系统处于只读模式（demo 模式），则命令会进行验证并阻止撤销操作。
- **日志记录**：撤销 API 密钥的操作会被记录在系统的日志中，以便后续审计和追踪。

### 注意事项

- **权限**：执行 `v-revoke-api-key` 命令的用户需要具备相应的权限，以便能够访问和修改密钥文件。
- **密钥文件位置**：命令会查找位于 `$HESTIA/data/keys/` 目录下的密钥文件。请确保该目录存在且包含要撤销的密钥文件。
- **密钥文件存在性**：命令会检查指定的密钥文件是否存在。如果密钥文件不存在，则命令将返回错误代码并退出。
- **撤销结果验证**：在撤销密钥后，建议验证撤销结果，确保密钥已被成功撤销且不再有效。

### 自定义配置

- **密钥文件目录**：可以通过修改 `$HESTIA/data/keys/` 路径来更改密钥文件的存储位置。请确保在修改后更新相关的配置文件和脚本。
- **日志记录**：可以根据需要自定义日志记录的行为，例如更改日志级别、添加额外的日志信息等。

### 结论

`v-revoke-api-key` 命令是一个用于撤销 Hestia 系统 API 密钥的实用工具。通过提供 API 密钥的哈希值，可以轻松地撤销指定的密钥，提高系统的安全性。在使用该命令时，请确保遵循相关的最佳实践和注意事项，以确保命令能够正确执行并达到预期的效果。

## v-list-access-key

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-access-key)

### 概述

`v-list-access-key` 是 Hestia 提供的一个命令行工具，用于检索和显示指定访问密钥的详细信息。该命令支持多种输出格式，如 JSON、Shell 和纯文本格式。

### 用法

### 语法

```bash
v-list-access-key ACCESS_KEY_ID [FORMAT]
```

- `ACCESS_KEY_ID`: 要检索的访问密钥的 ID。
- `FORMAT`: 可选参数，指定输出格式。默认为 `shell` 格式。可选值包括 `json`、`shell` 和 `plain`。

### 示例

#### 示例 1: 使用默认 Shell 格式检索访问密钥

```bash
v-list-access-key AKIAIOSFODNN7EXAMPLE
```

输出可能类似于：

```bash
ACCESS_KEY_ID:      AKIAIOSFODNN7EXAMPLE
SECRET_ACCESS_KEY:  wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
USER:               john_doe
PERMISSIONS:        read,write
COMMENT:            Example access key for John Doe
TIME:               16:47:24
DATE:               2023-10-23
```

#### 示例 2: 使用 JSON 格式检索访问密钥

```bash
v-list-access-key AKIAIOSFODNN7EXAMPLE json
```

输出可能类似于：

```json
{
  "ACCESS_KEY_ID": "AKIAIOSFODNN7EXAMPLE",
  "SECRET_ACCESS_KEY": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
  "USER": "john_doe",
  "PERMISSIONS": ["read", "write"],
  "COMMENT": "Example access key for John Doe",
  "TIME": "16:47:24",
  "DATE": "2023-10-23"
}
```

#### 示例 3: 使用纯文本格式检索访问密钥

```bash
v-list-access-key AKIAIOSFODNN7EXAMPLE plain
```

输出可能类似于：

```bash
AKIAIOSFODNN7EXAMPLE:wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

### 功能特性

- **多格式输出**：支持 JSON、Shell 和纯文本格式，以满足不同场景下的需求。
- **密钥详细信息**：提供访问密钥的 ID、密钥、所属用户、权限、备注、时间和日期等详细信息。
- **验证参数**：对输入的访问密钥 ID 进行验证，确保格式正确且对象存在。

### 注意事项

- **权限**：执行 `v-list-access-key` 命令的用户需要具备相应的权限，以便能够访问和读取密钥信息。
- **密钥文件位置**：命令会查找位于 `${HESTIA}/data/access-keys/` 目录下的密钥文件。请确保该目录存在且包含要检索的密钥文件。
- **输出格式选择**：根据实际需要选择合适的输出格式。JSON 格式适合需要机器解析的场景，Shell 和纯文本格式适合直接查看和使用。

### 结论

`v-list-access-key` 命令是一个功能强大的工具，用于检索和显示 Hestia 系统中指定访问密钥的详细信息。通过支持多种输出格式和提供详细的密钥信息，该命令能够满足不同场景下的需求，提高系统的安全性和可管理性。

## v-list-access-keys

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-access-keys)

### 概述

`v-list-access-keys` 是 Hestia 提供的一个命令行工具，用于检索和显示系统中所有访问密钥或特定用户的访问密钥的详细信息。该命令支持多种输出格式，如 JSON 和 Shell 格式，方便用户根据需要进行查看和管理。

### 用法

### 语法

```bash
v-list-access-keys [USER] [FORMAT]
```

- `USER` (可选参数)：指定要检索的用户的访问密钥。如果未提供此参数，则列出所有用户的访问密钥。
- `FORMAT` (可选参数)：指定输出格式。默认为 `shell` 格式。可选值包括 `json` 和 `shell`。

### 示例

#### 示例 1: 列出所有访问密钥（默认Shell格式）

```bash
v-list-access-keys
```

输出可能类似于：

```bash
ID              USER        PERMISSIONS   COMMENT         TIME        DATE
--------------  ----------  ------------  --------------  ----------  ----------
AKIAIOSFODNN7   john_doe    read,write    John's key      16:47:24    2023-10-23
AKIAJKSXRVELZ   admin       *             Admin's key     14:30:00    2023-10-22
...
```

#### 示例 2: 列出指定用户的访问密钥（Shell格式）

```bash
v-list-access-keys john_doe
```

输出将仅包含 `john_doe` 用户的访问密钥信息。

#### 示例 3: 列出所有访问密钥（JSON格式）

```bash
v-list-access-keys json
```

输出可能类似于：

```json
{
  "AKIAIOSFODNN7": {
    "ACCESS_KEY_ID": "AKIAIOSFODNN7",
    "USER": "john_doe",
    "PERMISSIONS": ["read", "write"],
    "COMMENT": "John's key",
    "TIME": "16:47:24",
    "DATE": "2023-10-23"
  },
  "AKIAJKSXRVELZ": {
    "ACCESS_KEY_ID": "AKIAJKSXRVELZ",
    "USER": "admin",
    "PERMISSIONS": ["*"],
    "COMMENT": "Admin's key",
    "TIME": "14:30:00",
    "DATE": "2023-10-22"
  },
  ...
}
```

### 功能特性

- **多用户支持**：可以列出指定用户的访问密钥或所有用户的访问密钥。
- **多格式输出**：支持 JSON 和 Shell 格式，方便用户根据需要进行查看和管理。
- **详细信息**：提供访问密钥的 ID、用户、权限、备注、时间和日期等详细信息。

### 注意事项

- **权限**：执行 `v-list-access-keys` 命令的用户需要具备相应的权限，以便能够访问和读取密钥信息。
- **密钥文件位置**：命令会查找位于 `$HESTIA/data/access-keys/` 目录下的密钥文件。请确保该目录存在且包含有效的密钥文件。
- **用户匹配**：如果指定了用户参数，则仅列出该用户的访问密钥。如果未指定用户参数，则列出所有用户的访问密钥。

## v-list-api

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-api)

### 概述

`v-list-api` 是 Hestia 提供的一个命令行工具，用于列出和检索系统中特定 API 接口的详细信息。该命令允许用户指定 API 名称和输出格式（默认为 shell 格式），以便按需获取相关信息。

### 用法

### 语法

```bash
v-list-api API [FORMAT]
```

- `API`：指定要检索的 API 接口的名称。
- `FORMAT`（可选）：指定输出格式。默认为 `shell` 格式。可选值包括 `json` 和 `shell`。

### 示例

#### 示例 1: 列出 mail-accounts API 的详细信息（默认 Shell 格式）

```bash
v-list-api mail-accounts
```

输出可能类似于：

```bash
API:           mail-accounts
ROLE:          mail_admin
COMMANDS:      list,add,edit,delete
```

#### 示例 2: 列出 mail-accounts API 的详细信息（JSON 格式）

```bash
v-list-api mail-accounts json
```

输出可能类似于：

```json
{
    "API": "mail-accounts",
    "ROLE": "mail_admin",
    "COMMANDS": ["list", "add", "edit", "delete"]
}
```

### 功能特性

- **API 检索**：允许用户通过 API 名称检索特定的 API 接口信息。
- **多格式输出**：支持 JSON 和 Shell 格式，方便用户根据需要进行查看和管理。
- **详细信息**：提供 API 的名称、角色和可用命令等详细信息。

### 注意事项

- **API 存在性**：在执行命令之前，请确保指定的 API 名称存在，并且相应的配置文件位于 `$HESTIA/data/api/` 目录下。
- **权限**：执行 `v-list-api` 命令的用户需要具备相应的权限，以便能够访问和读取 API 接口信息。

### 结论

`v-list-api` 命令是一个实用的工具，用于检索和显示 Hestia 系统中特定 API 接口的详细信息。通过支持多格式输出和提供详细的 API 信息，该命令能够帮助用户更好地理解和管理系统中的 API 接口，提高系统的安全性和可维护性。

## v-list-apis

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-apis)

### 概述

`v-list-apis` 是 Hestia 提供的一个命令行工具，用于列出系统中所有可用的 API 接口及其相关信息。该命令允许用户指定输出格式（默认为 shell 格式），以便按需获取 API 列表的详细信息。

### 用法

### 语法

```bash
v-list-apis [FORMAT]
```

- `FORMAT`（可选）：指定输出格式。默认为 `shell` 格式。可选值包括 `json` 和 `shell`。

### 示例

#### 示例 1: 列出所有 API 接口的详细信息（默认 Shell 格式）

```bash
v-list-apis
```

输出可能类似于：

```bash
API       ROLE        COMMANDS
-----     ----        --------
api1      role1       cmd1,cmd2
api2      role2       cmd3,cmd4
...
```

#### 示例 2: 列出所有 API 接口的详细信息（JSON 格式）

```bash
v-list-apis json
```

输出可能类似于：

```json
{
    "api1": {
        "COMMANDS": ["cmd1", "cmd2"],
        "ROLE": "role1"
    },
    "api2": {
        "COMMANDS": ["cmd3", "cmd4"],
        "ROLE": "role2"
    },
    ...
}
```

### 功能特性

- **API 列表**：列出系统中所有可用的 API 接口。
- **多格式输出**：支持 JSON 和 Shell 格式，方便用户根据需要进行查看和管理。
- **详细信息**：对于每个 API 接口，提供其名称、角色和可用命令等详细信息。

### 注意事项

- **权限**：执行 `v-list-apis` 命令的用户需要具备相应的权限，以便能够访问和读取 API 接口信息。
- **路径**：该命令假定 API 接口的配置文件位于 `$HESTIA/data/api/` 目录下，并且每个 API 接口的配置文件以 API 名称命名。

### 结论

`v-list-apis` 命令是一个强大的工具，用于检索和显示 Hestia 系统中所有可用的 API 接口的详细信息。通过支持多格式输出和提供详细的 API 信息，该命令能够帮助用户更好地了解系统中的 API 接口，提高系统的可管理性和安全性。

## v-generate-api-key

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-generate-api-key)

### 概述

`v-generate-api-key` 是 Hestia 提供的一个命令行工具，用于生成新的 API 密钥。这个密钥将被保存在 `$HESTIA/data/keys/` 目录下，并可以用于身份验证和访问 Hestia 提供的 API 服务。

### 用法

### 语法

```bash
v-generate-api-key
```

该命令没有额外的选项或参数。

### 示例

#### 示例 1: 生成一个新的 API 密钥

```bash
v-generate-api-key
```

执行该命令后，系统会生成一个新的 API 密钥，并将其打印到标准输出。同时，该密钥也会被保存到 `$HESTIA/data/keys/` 目录下的一个以密钥值命名的文件中。

### 功能特性

- **自动生成**：该命令使用安全的随机数生成器生成 API 密钥，确保每次生成的密钥都是唯一的。
- **持久化存储**：生成的 API 密钥会被保存到 `$HESTIA/data/keys/` 目录下，方便后续使用和管理。
- **权限控制**：密钥文件所在的目录具有适当的权限设置，以确保只有授权用户能够访问这些密钥。
- **日志记录**：系统会在生成新的 API 密钥时记录一条日志，以便管理员跟踪和审计密钥的生成情况。

### 注意事项

- **密钥安全性**：生成的 API 密钥应该被视为敏感信息，需要妥善保管。不要将其泄露给未经授权的用户或第三方。
- **权限管理**：确保只有具有适当权限的用户才能执行 `v-generate-api-key` 命令，以防止未经授权的密钥生成。
- **密钥更新**：定期生成新的 API 密钥并更新旧的密钥是一种良好的安全实践，可以降低密钥泄露的风险。

### 结论

`v-generate-api-key` 命令为 Hestia 系统提供了一种简单而安全的方式来生成和管理 API 密钥。通过自动生成、持久化存储和权限控制等功能，该命令可以帮助管理员确保 API 密钥的安全性和可用性。同时，结合日志记录和定期更新等安全措施，可以进一步提高系统的安全性和可靠性。
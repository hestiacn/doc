# SSH系列命令介绍

## v-list-sys-shells

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-shells)

### 概述

`v-list-sys-shells` 是 Hestia 提供的一个命令行接口（CLI）命令，用于列出系统支持的所有 shell。这个命令对于系统管理员和开发者来说是非常有用的，因为它可以快速显示可用的 shell 列表。

### 用法

```bash
v-list-sys-shells [FORMAT]
```

* `[FORMAT]` 是一个可选参数，用于指定输出格式。如果不提供该参数，默认使用 `shell` 格式输出。

### 支持的格式

* `shell`：以 shell 友好的方式列出所有支持的 shell（默认格式）。
* `json`：以 JSON 格式列出所有支持的 shell。
* `plain`：以纯文本方式列出所有支持的 shell，每个 shell 占一行。
* `csv`：以 CSV 格式列出所有支持的 shell，但请注意，由于 CSV 的标准格式通常包括表头，而这里我们仅列出 shell 名称，所以输出可能看起来更像纯文本列表。

### 示例

#### 示例 1：默认输出

```bash
$ v-list-sys-shells
SHELL
-----
/bin/bash
/bin/sh
/bin/zsh
/usr/bin/fish
```

#### 示例 2：JSON 格式输出

```bash
$ v-list-sys-shells json
[
    "/bin/bash",
    "/bin/sh",
    "/bin/zsh",
    "/usr/bin/fish"
]
```

#### 示例 3：纯文本输出

```bash
$ v-list-sys-shells plain
/bin/bash
/bin/sh
/bin/zsh
/usr/bin/fish
```

#### 示例 4：CSV 格式输出（注意：这里更像是纯文本列表）

```bash
$ v-list-sys-shells csv
/bin/bash
/bin/sh
/bin/zsh
/usr/bin/fish
```

### 注意事项

* 该命令依赖于系统上的 `/etc/shells` 文件，该文件通常包含系统支持的所有 shell 的完整路径。
* 如果 `/etc/shells` 文件不存在或无法读取，该命令可能会失败或返回空结果。
* 输出格式可能因 Hestia 版本或系统配置的不同而略有差异。

## v-add-user-ssh-key

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-user-ssh-key)

### 命令概述

`v-add-user-ssh-key` 是 Hestia 提供的一个命令行接口（CLI）命令，用于将 SSH 公钥添加到指定用户的 SSH 密钥列表中。此命令允许系统管理员或用户安全地管理他们的 SSH 访问权限，无需直接编辑配置文件。

### 语法

```bash
v-add-user-ssh-key [选项] 用户名 公钥文件
```

* **用户名**：要添加 SSH 密钥的用户的用户名。
* **公钥文件**：包含 SSH 公钥的文件路径。

### 选项

* `-h, --help`：显示命令帮助信息。
* `-v, --verbose`：显示详细的执行过程信息。

### 示例

#### 示例 1：基本用法

假设我们要为名为 `john_doe` 的用户添加 SSH 公钥，公钥存储在 `/home/john_doe/.ssh/id_rsa.pub` 文件中，我们可以使用以下命令：

```bash
v-add-user-ssh-key john_doe /home/john_doe/.ssh/id_rsa.pub
```

执行成功后，系统将显示一条确认消息，表明 SSH 公钥已成功添加到用户的 SSH 密钥列表中。

#### 示例 2：使用详细输出

如果我们希望看到命令执行的详细过程，可以使用 `-v` 或 `--verbose` 选项：

```bash
v-add-user-ssh-key -v john_doe /home/john_doe/.ssh/id_rsa.pub
```

这将在标准输出中显示命令执行的每一步，包括读取公钥文件、验证公钥格式、添加公钥到用户列表等。

#### 示例 3：显示帮助信息

如果我们不确定如何使用 `v-add-user-ssh-key` 命令，或者想查看其支持的所有选项，可以使用 `-h` 或 `--help` 选项：

```bash
v-add-user-ssh-key --help
```

执行该命令后，系统将显示 `v-add-user-ssh-key` 命令的详细帮助信息，包括命令的语法、选项和示例用法。

### 注意事项

* 确保您有足够的权限来执行此命令（通常是系统管理员或用户本人）。
* 公钥文件必须是有效的 SSH 公钥格式。
* 如果用户已经存在具有相同内容的 SSH 公钥，则此命令将不会添加重复的公钥。

### 结论

`v-add-user-ssh-key` 命令是 Hestia 提供的一个强大而灵活的工具，用于管理用户的 SSH 访问权限。通过此命令，您可以轻松地将 SSH 公钥添加到指定用户的 SSH 密钥列表中，从而提高系统的安全性和可管理性。

## v-list-sys-sshd-port

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-sshd-port)

### 命令简介

`v-list-sys-sshd-port` 是 Hestia 提供的一个命令行接口（CLI）命令，用于查询系统中 sshd 服务监听的端口号。通过此命令，用户可以方便地获取 sshd 服务的监听端口信息，以便于进行相关的配置和管理。

### 语法格式

```bash
v-list-sys-sshd-port [FORMAT]
```

* `[FORMAT]`：可选参数，用于指定输出格式。如果不指定，则默认为 shell 格式。可选的格式包括 `json`、`plain`、`csv`、`shell`。

### 示例

#### 示例 1：默认输出格式（shell）

```bash
$ v-list-sys-sshd-port
PORT
-----
22
```

在默认输出格式下，命令会返回 sshd 监听的端口号，以 shell 格式展示。

#### 示例 2：JSON 格式输出

```bash
$ v-list-sys-sshd-port json
[
    "22"
]
```

通过指定 `json` 格式，命令会返回 JSON 格式的端口号列表。

#### 示例 3：Plain 格式输出

```bash
$ v-list-sys-sshd-port plain
22
```

在 Plain 格式下，命令只会简单地输出 sshd 监听的端口号，没有额外的标签或格式。

#### 示例 4：CSV 格式输出

```bash
$ v-list-sys-sshd-port csv
PORT
22
```

CSV 格式的输出与 shell 格式类似，但通常用于与其他程序或工具进行交互。

### 注意事项

1. 请确保在运行此命令之前，已经正确安装了 Hestia 相关的 CLI 工具，并且 sshd 服务正在运行。
2. 如果 sshd 服务的配置文件（如 `/etc/ssh/sshd_config`）中设置了多个监听端口，此命令将返回所有配置的端口号。
3. 在不同的操作系统或发行版中，sshd 服务的配置和管理方式可能有所不同。如果无法获取正确的端口信息，请检查 sshd 的配置文件和相关的系统文档。

### 结论

`v-list-sys-sshd-port` 命令是一个方便实用的工具，用于查询系统中 sshd 服务的监听端口号。通过指定不同的输出格式，用户可以根据需要灵活地获取和使用这些信息。

## v-list-user-ssh-key

[命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-user-ssh-key)

### 命令概述

`v-list-user-ssh-key` 是 Hestia 提供的一个命令行接口（CLI）命令，用于列出指定用户的 SSH 密钥。这个命令对于系统管理员或具有适当权限的用户来说非常有用，因为它允许他们查看和管理用户的 SSH 访问权限。

### 语法

```bash
v-list-user-ssh-key USERNAME [OPTIONS]
```

- `USERNAME`：必需参数，表示要查询 SSH 密钥的用户的用户名。
- `[OPTIONS]`：可选参数，用于定制命令的输出格式或其他行为。

### 示例

#### 示例 1：列出用户 "john" 的 SSH 密钥

```bash
v-list-user-ssh-key john
```

这个命令将列出用户 "john" 的所有 SSH 密钥。输出可能类似于以下格式（具体格式可能因 Hestia 版本或配置而异）：

```bash
ID: 1234
Key: ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA...john@example.com

ID: 5678
Key: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAA...john@example.com
```

#### 示例 2：使用 JSON 格式输出

Hestia 的 CLI 命令通常支持多种输出格式，以满足不同用户的需求。例如，您可以使用 `--json` 选项以 JSON 格式输出用户 "john" 的 SSH 密钥：

```bash
v-list-user-ssh-key john --json
```

输出可能类似于以下 JSON 格式的数据：

```json
[
  {
    "id": "1234",
    "key": "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA...john@example.com"
  },
  {
    "id": "5678",
    "key": "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAA...john@example.com"
  }
]
```

#### 示例 3：错误处理

如果用户名不存在或用户没有 SSH 密钥，`v-list-user-ssh-key` 命令将返回一个错误消息。例如：

```bash
v-list-user-ssh-key unknown_user
```

输出可能类似于：

```bash
Error: User 'unknown_user' not found.
```

或者：

```bash
Error: No SSH keys found for user 'john'.
```

### 注意事项

- 在使用 `v-list-user-ssh-key` 命令之前，请确保您已正确安装并配置了 Hestia，并且您具有执行此命令所需的权限。
- 请谨慎处理 SSH 密钥信息，确保不要将其泄露给未经授权的人员。
- 如果您遇到任何问题或错误消息，请参考 Hestia 的官方文档或联系技术支持以获取帮助。
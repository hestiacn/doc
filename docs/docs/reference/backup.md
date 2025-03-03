# 备份和恢复备份系列命令介绍

## v-update-user-backup-exclusions

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-user-backup-exclusions)

`v-update-user-backup-exclusions` 是 Hestia 控制面板提供的 CLI 命令，用于更新指定用户的备份排除列表。该命令允许管理员通过提供一个文件，其中包含需要排除的文件或目录列表，来定制用户的备份策略。

### 使用方法

```bash
v-update-user-backup-exclusions USERNAME EXCLUSION_FILE
```

- `USERNAME`：需要更新备份排除列表的用户的用户名。
- `EXCLUSION_FILE`：包含排除列表的文件路径。

### 示例

1. 更新用户 `john` 的备份排除列表，使用文件 `/path/to/exclusions.conf`：

    ```bash
    v-update-user-backup-exclusions john /path/to/exclusions.conf
    ```

2. 如果 `exclusions.conf` 文件不存在或包含无效字符，命令将返回错误。

### 脚本流程

1. **参数验证**：
   - 检查是否提供了两个参数（用户名和排除文件路径）。
   - 验证用户名的格式是否有效。
   - 验证用户名是否对应一个有效的用户对象。
   - 检查排除文件是否存在。
   - 检查排除文件是否包含无效字符（如特殊字符）。

2. **只读模式检查**：
   - 如果 Hestia 控制面板处于只读模式（如演示模式），则不进行任何更改并返回相应的错误。

3. **处理排除列表**：
   - 从提供的排除文件中读取排除列表。
   - 将读取到的排除列表写入用户的备份排除配置文件（通常位于 `$USER_DATA/backup-excludes.conf`）。
   - 设置备份排除配置文件的权限为 660，确保只有用户和管理员可以访问。

4. **日志记录**：
   - 记录用户更新备份排除列表的操作到日志文件。

### 注意事项

- 确保提供的排除文件不包含任何无效字符，否则命令将失败。
- 排除文件应该只包含需要排除的文件或目录的路径，每行一个。
- 命令需要适当的权限来执行，通常只有具有管理员权限的用户才能使用。

### 扩展功能

- 可以考虑添加更复杂的验证逻辑，以确保排除文件内容的正确性和完整性。
- 可以支持从标准输入读取排除列表，而不是仅从文件中读取。
- 可以添加选项来覆盖现有的排除列表，而不是追加到现有列表中。
- 可以添加日志记录选项，以便管理员可以跟踪和监控备份排除列表的更改。

## v-dump-site

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-dump-site)

### 概述

`v-dump-site` 是 Hestia 系统中用于备份网站文件的 CLI 命令。通过此命令，管理员可以轻松地根据提供的用户名、域名和备份类型参数，创建包含网站文件的 ZIP 压缩包，并保存在指定的备份目录中。压缩包通常命名为 `/backup/user.domain.timestamp.zip` 的格式，其中 `user` 是用户名，`domain` 是域名，`timestamp` 是备份时的时间戳。

### 使用方法

### 语法

```bash
v-dump-site USER DOMAIN [TYPE]
```

- `USER`: 要备份网站的用户名。
- `DOMAIN`: 要备份的域名。
- `TYPE` (可选): 备份类型，可以是 `full`（备份整个网站目录）或省略（默认为仅备份 `public_html` 目录）。

### 示例

#### 示例 1: 备份整个网站目录

```bash
v-dump-site john example.com full
```

这个命令会备份用户 `john` 的 `example.com` 网站的整个目录（包括所有子目录和文件），并将压缩包保存在类似 `/backup/john.example.com.2023-10-23T14-30-00Z.zip` 的路径下（其中 `2023-10-23T14-30-00Z` 是一个示例时间戳）。

#### 示例 2: 仅备份 public_html 目录（默认）

```bash
v-dump-site jane mysite.net
```

这个命令会仅备份用户 `jane` 的 `mysite.net` 网站的 `public_html` 目录（不包含其他子目录和文件），并将压缩包保存在类似 `/backup/jane.mysite.net.2023-10-23T14-30-00Z.zip` 的路径下（其中 `2023-10-23T14-30-00Z` 是一个示例时间戳）。

### 功能特性

- **参数验证**：命令会对提供的用户名、域名和备份类型进行验证，确保输入的有效性。
- **只读模式检查**：在执行备份操作之前，命令会检查系统是否处于只读模式，以防止在只读模式下执行备份操作。
- **自定义备份路径**：虽然默认备份路径是 `/backup/`，但管理员可以通过修改配置文件来指定其他备份路径。
- **ZIP 压缩**：使用 `zip` 命令将网站文件压缩为 ZIP 格式，以节省存储空间和方便传输。
- **命名规范**：备份文件采用 `user.domain.timestamp.zip` 的命名规范，方便管理员识别和管理。
- **日志记录**：备份过程会被记录到日志中，方便后续查看和分析。
- **自动清理**：备份完成后，命令会安排一个计划在指定的时间后自动删除旧的备份文件，以释放存储空间。

### 注意事项

- **用户权限**：执行 `v-dump-site` 命令的用户需要具有足够的权限来访问和备份指定的网站目录。
- **磁盘空间**：在执行备份操作之前，请确保系统上有足够的磁盘空间来存储备份文件。
- **备份频率**：根据实际需求，可以定期执行 `v-dump-site` 命令来备份网站文件，以确保数据的完整性和可恢复性。
- **自定义配置**：通过修改 Hestia 的配置文件，可以自定义备份路径、压缩算法等参数，以满足特定的需求。

### 结论

`v-dump-site` 命令为 Hestia 系统提供了一种高效、灵活的网站文件备份解决方案。通过简单的命令行操作，管理员可以轻松地备份整个网站目录或仅备份 `public_html` 目录，并将备份文件保存在指定的 `/backup/` 目录下，文件命名遵循 `user.domain.timestamp.zip` 的规范。该命令的日志记录和自动清理功能确保了备份过程的完整性和安全性，为管理员提供了便利和可靠性。

## v-add-fs-archive

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-fs-archive)

### 概述

`v-add-fs-archive` 是 Hestia 系统中用于创建和管理文件系统归档文件的 CLI 命令。通过此命令，管理员可以指定用户、归档文件名和一系列源文件，从而创建一个包含这些源文件的归档文件（默认为 tar.gz 格式）。该命令确保只有指定的用户有权访问这些文件，并且源文件必须位于用户的家目录或 `/tmp` 目录下。

### 使用方法

### 语法

```bash
v-add-fs-archive USER ARCHIVE FILE [FILE_2] [FILE_3] [FILE ...]
```

- `USER`: 用户的用户名，用于确定源文件的访问权限。
- `ARCHIVE`: 要创建的归档文件名（可包含路径），默认为 gzip 压缩格式（`.gz` 后缀）。
- `FILE [FILE_2] [FILE_3] [FILE ...]`: 要包含在归档文件中的源文件列表。

### 示例

#### 示例 1: 创建单个文件的归档

```bash
v-add-fs-archive john /backup/john_archive.tar.gz /home/john/public_html/index.html
```

此命令将用户 `john` 的 `public_html` 目录下的 `index.html` 文件打包为一个名为 `john_archive.tar.gz` 的 gzip 压缩归档文件，并保存在 `/backup/` 目录下。

#### 示例 2: 创建多个文件的归档

```bash
v-add-fs-archive alice /backup/alice_archive.tar.gz /home/alice/images/logo.png /tmp/temp_file.txt
```

此命令将用户 `alice` 的 `images` 目录下的 `logo.png` 文件和 `/tmp/` 目录下的 `temp_file.txt` 文件打包为一个名为 `alice_archive.tar.gz` 的 gzip 压缩归档文件，并保存在 `/backup/` 目录下。

#### 示例 3: 创建目录的归档

```bash
v-add-fs-archive bob /backup/bob_archive.tar.gz /home/bob/public_html/
```

注意：当指定目录作为源文件时，该目录及其下的所有文件和子目录都将被包含在归档文件中。

此命令将用户 `bob` 的 `public_html` 目录及其所有内容打包为一个名为 `bob_archive.tar.gz` 的 gzip 压缩归档文件，并保存在 `/backup/` 目录下。

### 功能特性

- **参数验证**：命令会对提供的用户名、归档文件名和源文件列表进行验证，确保输入的有效性。
- **权限控制**：命令确保只有指定的用户有权访问和包含源文件在归档文件中。
- **源文件位置限制**：源文件必须位于用户的家目录（`/home/USER/`）或 `/tmp` 目录下。
- **gzip 压缩**：归档文件默认为 gzip 压缩格式（`.gz` 后缀），以节省存储空间和方便传输。
- **错误处理**：命令会检查各种错误情况，如用户家目录不存在、归档文件已存在、源文件路径无效等，并输出相应的错误信息。

### 注意事项

- **用户权限**：执行 `v-add-fs-archive` 命令的用户需要具有足够的权限来访问和包含指定的源文件。
- **磁盘空间**：在执行命令之前，请确保系统上有足够的磁盘空间来创建和保存归档文件。
- **源文件路径**：确保提供的源文件路径是正确的，并且源文件是可访问的。
- **备份策略**：根据实际需求，可以定期执行 `v-add-fs-archive` 命令来创建归档文件，以备份重要的文件和目录。

### 结论

`v-add-fs-archive` 命令为 Hestia 系统提供了一种高效、灵活的文件系统归档解决方案。通过简单的命令行操作，管理员可以轻松地创建和管理包含指定源文件的归档文件，并确保只有指定的用户有权访问这些文件。该命令的权限控制、源文件位置限制和 gzip 压缩功能确保了归档过程的安全性和效率。

## v-add-backup-host

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-backup-host)

### 概述

`v-add-backup-host` 是 Hestia 提供的一个 CLI 命令，用于向备份系统添加新的备份主机。此命令支持多种备份方式，包括但不限于 FTP、SFTP 和 Backblaze B2。以下将详细解释如何使用此命令及其各种选项。

### 用法


```bash
v-add-backup-host <type> <host> <user> <raw_password> [<path>] [<port>]
```
### 参数说明

- `type`: 备份类型（如 `ftp`, `sftp`, `b2` 等）。
- `host`: 备份主机的地址或域名。
- `user`: 备份主机的用户名。
- `raw_password`: 备份主机的密码（注意：在脚本中密码会被转义处理）。
- `path`: （可选）备份路径，默认为 `/backup`。
- `port`: （可选）备份主机的端口号。

### 示例

#### 示例 1: 使用 FTP 添加备份主机


```bash
v-add-backup-host ftp ftp.example.com backupuser mysecretpassword /my/backup/path 21
```
在这个示例中，我们使用 FTP 备份类型，将 `ftp.example.com` 作为备份主机，使用 `backupuser` 和 `mysecretpassword` 作为登录凭据，备份路径为 `/my/backup/path`，端口号为默认的 FTP 端口 21。

#### 示例 2: 使用 SFTP 添加备份主机


```bash
v-add-backup-host sftp sftp.example.net sftpuser myothersecretpassword /remote/backup/folder 22
```
在这个示例中，我们使用 SFTP 备份类型，将 `sftp.example.net` 作为备份主机，使用 `sftpuser` 和 `myothersecretpassword` 作为登录凭据，备份路径为 `/remote/backup/folder`，端口号为默认的 SSH/SFTP 端口 22。

#### 示例 3: 使用 Backblaze B2 添加备份主机

请注意，使用 Backblaze B2 需要额外的配置和认证步骤，这里仅展示命令结构。


```bash
v-add-backup-host b2 <b2_account_id> <b2_application_key> <bucket_name>
```
在这个示例中，`b2_account_id` 和 `b2_application_key` 是从 Backblaze 账户中获取的认证凭据，`bucket_name` 是要备份到的 B2 存储桶名称。注意，此命令可能需要额外的参数或配置来指定备份的具体设置。

### 注意事项

- 密码在脚本中会被转义处理，以提高安全性。
- 使用非默认端口时，请确保在命令中指定正确的端口号。
- 根据备份类型和主机要求，可能需要额外的配置或认证步骤。
- 在生产环境中使用此命令时，请确保已经充分了解其工作原理和潜在风险。
- 添加新的远程备份位置。 目前支持 SFTP、FTP 和[Backblaze](https://www.backblaze.com)作为一主在数据备份和云存储领域具有丰富经验和实力的公司，通过不断创新和优化产品，为用户提供安全、可靠、高效的数据存储和备份解决方案。无论是个人用户还是企业用户，都可以从Backblaze的服务中受益。

## v-backup-user

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-backup-user)

### 概述

`v-backup-user` 是 Hestia 提供的一个 CLI 命令，用于备份系统用户及其所有相关对象，包括域名和数据库。这个命令允许管理员或用户轻松备份他们的整个账户配置和数据，确保数据安全性和可恢复性。

### 用法


```bash
v-backup-user <USER> [<NOTIFY>]
```
### 参数说明

- `USER`: 要备份的用户名。
- `NOTIFY`: （可选）是否发送备份通知。默认值为 "no"，表示不发送通知。如果设置为 "yes"，则会在备份完成后发送通知。

### 示例

#### 示例 1: 备份用户而不发送通知


```bash
v-backup-user admin
```
在这个示例中，`admin` 是要备份的用户名。由于未指定 `NOTIFY` 参数，因此不会发送备份通知。

#### 示例 2: 备份用户并发送通知


```bash
v-backup-user john yes
```
在这个示例中，`john` 是要备份的用户名，并且指定了 `NOTIFY` 参数为 "yes"，表示在备份完成后发送通知。

### 备份内容

`v-backup-user` 命令会备份用户的以下相关对象：

- **域名**：用户所拥有的所有域名及其相关配置。
- **数据库**：用户所拥有的所有数据库及其数据。
- **用户配置**：用户的个人设置和配置文件。

### 通知功能

如果指定了 `NOTIFY` 参数为 "yes"，则 `v-backup-user` 命令会在备份完成后发送通知。通知的发送方式和接收者可以在 Hestia 的配置文件中进行设置。

### 注意事项

- 在执行备份之前，请确保用户账户和相关对象处于稳定状态，以避免备份不完整或数据不一致的问题。
- 如果在备份过程中遇到任何问题或错误，请查看 Hestia 的日志文件以获取更多详细信息。
- 备份文件将存储在 Hestia 系统指定的备份目录中，请确保该目录具有足够的磁盘空间来存储备份文件。
- 定期执行备份是保护数据和系统安全性的重要措施之一。建议根据实际需求设置定期备份计划。

## v-backup-users

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-backup-users)

### 概述

`v-backup-users` 是 Hestia 提供的一个 CLI 命令，用于备份系统上的所有用户。这个命令会自动遍历所有用户账户，并对每个账户执行备份操作，确保所有用户的数据都得到了妥善保存。

### 用法


```bash
v-backup-users
```
该命令没有额外的参数或选项，直接执行即可开始备份所有用户。

### 示例

#### 示例 1: 备份所有用户


```bash
v-backup-users
```
执行上述命令后，Hestia 将开始遍历所有用户账户，并逐个执行备份操作。备份的详细信息和进度将被记录到指定的日志文件中。

### 工作流程

1. **包含必要的文件和函数**：命令首先会包含一些必要的文件和函数，以便能够访问 Hestia 的配置信息和执行相关操作。
2. **验证只读模式**：在执行备份之前，命令会检查 Hestia 是否处于只读模式。如果处于只读模式，则不会执行备份操作。
3. **修复数据库**：在备份所有用户之前，命令会首先自动修复所有数据库，以确保数据的完整性和一致性。
4. **遍历用户账户**：使用 `$BIN/v-list-users` 命令列出所有用户账户，并对每个账户进行循环处理。
5. **检查用户状态**：对于每个用户账户，命令会检查其是否处于暂停状态（`SUSPENDED='no'`）。如果账户被暂停，则跳过备份。
6. **执行备份**：对于未被暂停的用户账户，命令将执行 `v-backup-user` 命令来备份该用户及其所有相关对象（如域名、数据库等）。备份的详细信息和进度将被记录到指定的日志文件中。
7. **记录日志**：备份过程中的所有信息和进度都会被记录到 `$HESTIA/log/backup.log` 文件中，以便后续查看和分析。
8. **退出**：当所有用户账户都备份完成后，命令将退出并返回到终端。

### 注意事项

- 在执行备份之前，请确保 Hestia 系统正常运行，并且所有用户账户和相关对象都处于稳定状态。
- 备份文件将存储在 Hestia 系统指定的备份目录中，请确保该目录具有足够的磁盘空间来存储备份文件。
- 定期执行备份是保护数据和系统安全性的重要措施之一。建议根据实际需求设置定期备份计划。
- 如果在备份过程中遇到任何问题或错误，请查看 Hestia 的日志文件以获取更多详细信息，并根据需要进行故障排除。

## v-extract-fs-archive

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-extract-fs-archive)

### 概述

`v-extract-fs-archive` 是 Hestia 提供的一个 CLI 命令，用于从文件系统归档文件中提取内容。该命令支持多种归档文件格式（如 `.tgz`, `.tar.gz`, `.tbz`, `.tar.bz`, `.tar.zst` 等），并允许用户指定目标目录和提取的目录。

### 用法


```bash
v-extract-fs-archive USER ARCHIVE_FILE DESTINATION_DIRECTORY [SELECTED_DIRECTORY] [STRIP_COMPONENTS] [TEST]
```

- **USER**: 要操作的用户名（必须）。
- **ARCHIVE_FILE**: 归档文件的路径（必须）。
- **DESTINATION_DIRECTORY**: 提取内容的目标目录（必须）。
- **SELECTED_DIRECTORY**: 可选，指定归档文件中要提取的目录。
- **STRIP_COMPONENTS**: 可选，指定从归档文件路径中去除的目录层级数。
- **TEST**: 可选，设置为 "yes" 或 "no" 来测试归档文件的完整性而不实际提取内容。

### 示例

#### 示例 1: 提取整个归档文件到目标目录


```bash
v-extract-fs-archive john /path/to/backup.tgz /home/john_backup/
```
这将从 `/path/to/backup.tgz` 归档文件中提取所有内容到 `/home/john_backup/` 目录。

#### 示例 2: 提取归档文件中的特定目录


```bash
v-extract-fs-archive john /path/to/backup.tgz /home/john_backup/ web
```
这将从 `/path/to/backup.tgz` 归档文件中提取 `web` 目录的内容到 `/home/john_backup/` 目录。

#### 示例 3: 去除归档文件路径中的目录层级


```bash
v-extract-fs-archive john /path/to/backup.tgz /home/john_backup/ 2
```
假设归档文件的内容在 `/home/john/backup/` 目录下，这个命令将会把内容提取到 `/home/john_backup/`，并去除前两个目录层级（即 `/home/john/`）。

#### 示例 4: 测试归档文件的完整性


```bash
v-extract-fs-archive john /path/to/backup.tgz /home/john_backup/ test=yes
```
这个命令将测试 `/path/to/backup.tgz` 归档文件的完整性，但不会实际提取内容到 `/home/john_backup/` 目录。

### 注意事项

- 归档文件必须位于 `/tmp`、用户家目录、备份目录（如 `$BACKUP/$user.` 或 `$BACKUP/tmp.`）内，否则命令将失败。
- 目标目录必须位于 `/tmp` 或用户家目录内，否则命令将失败。
- 如果使用 `STRIP_COMPONENTS` 选项，请确保提供的值为整数，且不会导致路径超出文件系统的限制。
- 使用 `TEST` 选项时，命令将只检查归档文件的完整性，而不执行实际的提取操作。
- 在执行命令之前，请确保有足够的磁盘空间来存储提取的内容。
- 如果遇到任何问题或错误，请检查 Hestia 的日志文件以获取更多详细信息，并根据需要进行故障排除。

## v-schedule-user-backup

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-schedule-user-backup)

### 概述

`v-schedule-user-backup` 是 Hestia 提供的一个 CLI 命令，用于调度用户备份的创建。通过此命令，系统管理员可以安排对指定用户的备份任务，并确保这些备份在预定的时间自动执行。

### 用法

```bash
v-schedule-user-backup USER
```

- **USER**: 要为其调度备份的用户名（必填）。

### 示例

#### 示例 1: 为 "admin" 用户调度备份

```bash
v-schedule-user-backup admin
```
执行上述命令后，Hestia 将为 "admin" 用户调度一个备份任务。这个任务将在 Hestia 的备份系统中排队，等待执行。

#### 示例 2: 为 "john_doe" 用户调度备份并查看日志

如果你希望检查备份任务的执行情况，可以检查 Hestia 的备份日志。在调度了 "john_doe" 用户的备份任务后，你可以使用以下命令查看日志：

```bash
cat $HESTIA/log/backup.log
```
注意：`$HESTIA` 是 Hestia 的安装目录，你需要将其替换为你系统上的实际路径。

### 注意事项

- 在执行此命令之前，请确保已经启用了 Hestia 的备份系统，并且已经为用户启用了备份功能。
- 如果 Hestia 处于只读模式（例如，在演示模式下），则无法调度新的备份任务。
- 调度备份任务后，请确保 Hestia 的备份系统正在运行，以便及时处理排队的任务。
- 如果在调度备份任务时遇到问题，请检查 Hestia 的日志文件以获取更多详细信息，并根据需要进行故障排除。
- 你可以使用其他 Hestia CLI 命令来管理备份任务，例如查看备份状态、恢复备份等。有关更多信息，请参阅 Hestia 的官方文档或 CLI 命令帮助。

## v-schedule-user-backup-download

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-schedule-user-backup-download)

### 概述

`v-schedule-user-backup-download` 是 Hestia 提供的一个 CLI 命令，用于调度特定用户备份的下载任务。通过此命令，系统管理员可以指定一个用户及其相应的备份文件，以便在后台下载该备份。

### 用法

```bash
v-schedule-user-backup-download USER BACKUP
```

- **USER**: 需要下载备份的用户名（必填）。
- **BACKUP**: 备份文件的名称（必填），通常包括日期和时间戳。

### 示例

#### 示例 1: 调度 "admin" 用户的备份下载

假设你想要下载 "admin" 用户在 2019 年 4 月 22 日创建的备份文件 `2019-04-22_01-00-00.tar`，你可以使用以下命令：

```bash
v-schedule-user-backup-download admin 2019-04-22_01-00-00.tar
```
执行此命令后，Hestia 将在后台调度一个任务来下载指定的备份文件。

#### 示例 2: 验证参数和命令执行

在执行命令之前，你可以使用 `echo` 命令来模拟命令的执行，以确保参数正确无误。例如：

```bash
echo "v-schedule-user-backup-download admin 2019-04-22_01-00-00.tar"
```
这将输出命令本身，而不会实际执行它。一旦你确认参数正确，就可以去掉 `echo` 来实际执行命令。

### 注意事项

- 在执行此命令之前，请确保 Hestia 的备份系统已经启用，并且指定的用户备份文件确实存在。
- 如果 Hestia 处于只读模式（例如，在演示模式下），则无法调度新的备份下载任务。
- 调度任务后，请确保 Hestia 的后台进程正在运行，以便及时处理排队的任务。
- 你可以通过检查 Hestia 的日志文件来获取关于备份下载任务的更多信息。通常，这些日志文件位于 Hestia 安装目录下的 `log` 文件夹中。
- 如果在调度备份下载任务时遇到问题，请检查 Hestia 的日志文件以获取更多详细信息，并根据需要进行故障排除。

### 后续操作

一旦备份下载任务被成功调度，你可以在后台任务队列中查看其状态。另外，你可能还需要设置适当的权限和存储位置，以便在备份文件下载完成后进行适当的处理和管理。这些操作可能因你的具体环境和需求而有所不同。

## v-schedule-user-restore

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-schedule-user-restore)

### 概述

`v-schedule-user-restore` 是 Hestia 提供的一个 CLI 命令，用于调度特定用户备份的恢复任务。通过此命令，系统管理员可以指定一个备份文件来恢复用户的网站、DNS、邮件、数据库、cron 任务和用户目录。

### 用法


```bash
v-schedule-user-restore USER BACKUP [WEB] [DNS] [MAIL] [DB] [CRON] [UDIR]
```

- **USER**: 需要恢复备份的用户名（必填）。如果未指定，则使用脚本中的 `$user` 变量。
- **BACKUP**: 备份文件的名称（必填），通常包括日期和时间戳。
- **[WEB]**: 指示是否恢复网站文件（可选）。默认为 "yes"。
- **[DNS]**: 指示是否恢复 DNS 配置（可选）。默认为 "yes"。
- **[MAIL]**: 指示是否恢复邮件配置（可选）。默认为 "yes"。
- **[DB]**: 指示是否恢复数据库（可选）。默认为 "yes"。
- **[CRON]**: 指示是否恢复 cron 任务（可选）。默认为 "yes"。
- **[UDIR]**: 指示是否恢复用户目录（可选）。默认为 "yes"。

### 示例

#### 示例 1: 恢复用户的完整备份

假设你想要恢复 "john_doe" 用户的完整备份文件 `2023-03-15_12-00-00.tar`，包括网站、DNS、邮件、数据库、cron 任务和用户目录，你可以使用以下命令：


```bash
v-schedule-user-restore john_doe 2023-03-15_12-00-00.tar
```
执行此命令后，Hestia 将在后台调度一个任务来恢复指定的备份文件。

#### 示例 2: 恢复用户的部分备份（仅网站和数据库）

如果你只想恢复 "jane_smith" 用户的网站和数据库，而不恢复其他内容，你可以使用以下命令：


```bash
v-schedule-user-restore jane_smith 2023-03-16_09-30-00.tar yes no no yes no no
```
在这个例子中，`yes` 表示恢复网站，`no` 表示不恢复 DNS、邮件、cron 任务和用户目录，而数据库的恢复是通过第三个 `yes` 指定的。

#### 示例 3: 验证参数和命令执行（不实际恢复）

在执行恢复命令之前，你可以使用 `echo` 命令来模拟命令的执行，以确保参数正确无误。例如：


```bash
echo "v-schedule-user-restore jane_smith 2023-03-16_09-30-00.tar yes no no yes no no"
```
这将输出命令本身，而不会实际执行它。一旦你确认参数正确，就可以去掉 `echo` 来实际执行命令。

### 注意事项

- 在执行恢复操作之前，请确保 Hestia 的备份系统已经启用，并且指定的用户备份文件确实存在。
- 如果 Hestia 处于只读模式（例如，在演示模式下），则无法调度新的恢复任务。
- 调度任务后，请确保 Hestia 的后台进程正在运行，以便及时处理排队的任务。
- 恢复操作可能会覆盖现有数据，因此请务必在执行之前进行备份或确认操作的安全性。
- 你可以通过检查 Hestia 的日志文件来获取关于恢复任务的更多信息。通常，这些日志文件位于 Hestia 安装目录下的 `log` 文件夹中。
- 如果在调度恢复任务时遇到问题，请检查 Hestia 的日志文件以获取更多详细信息，并根据需要进行故障排除。

### 后续操作

一旦恢复任务被成功调度，你可以在后台任务队列中查看其状态。另外，你可能还需要验证恢复操作的结果，并根据需要进行进一步的配置或管理。这些操作可能因你的具体环境和需求而有所不同。

## v-list-backup-host

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-backup-host)

### 概述

`v-list-backup-host` 是一个 Hestia 提供的 CLI 命令，用于列出指定类型的备份主机信息。通过此命令，系统管理员可以获取关于 SFTP、FTP、RClone 或 Backblaze B2 备份主机的详细信息。

### 用法

```bash
v-list-backup-host TYPE [FORMAT]
```

- **TYPE**: 指定备份主机的类型。支持的类型包括 `sftp`、`ftp`、`rclone` 和 `b2`。
- **[FORMAT]**: 可选参数，用于指定输出格式。默认格式为 `shell`。其他支持的格式有 `json`、`plain` 和 `csv`。

### 示例

#### 示例 1: 使用默认格式列出 SFTP 备份主机

```bash
v-list-backup-host sftp
```

输出（示例）：

```bash
HOST:           example.sftp.host
USERNAME:       sftp_user
PORT:           22
TYPE:           sftp
PATH:           /path/to/backup
TIME:           2023-04-18 12:00:00
DATE:           2023-04-18
```

#### 示例 2: 使用 JSON 格式列出 FTP 备份主机

```bash
v-list-backup-host ftp json
```

输出（示例）：

```json
{
    "ftp": {
        "HOST": "example.ftp.host",
        "USERNAME": "ftp_user",
        "PORT": "21",
        "TYPE": "ftp",
        "BPATH": "/path/to/backup",
        "TIME": "2023-04-18 12:00:00",
        "DATE": "2023-04-18"
    }
}
```

#### 示例 3: 使用 CSV 格式列出 Backblaze B2 备份主机

```bash
v-list-backup-host b2 csv
```

输出（示例）：

```csv
BUCKET,TYPE,B2_KEYID,TIME,DATE
my-backup-bucket,b2,KEY_ID_EXAMPLE,2023-04-18 12:00:00,2023-04-18
```

#### 示例 4: 列出所有备份主机（使用自定义脚本）

如果你想要列出所有类型的备份主机，你可能需要编写一个循环脚本来分别调用 `v-list-backup-host` 命令。以下是一个简单的 Bash 脚本示例：

```bash
#!/bin/bash

for type in sftp ftp rclone b2; do
    v-list-backup-host "$type"
    echo "---"  # 用于分隔不同类型的输出
done
```

### 注意事项

- 确保在执行此命令之前已经正确配置了 Hestia 的备份设置。
- 根据所选的格式，输出的信息可能有所不同。
- 如果指定了无效的备份主机类型或格式，命令可能会返回错误消息。
- 在处理输出的信息时，请注意保护敏感数据，如用户名、密码和密钥。

### 后续操作

一旦你获取了备份主机的列表信息，你可以根据需要进行进一步的操作，如修改备份设置、添加新的备份主机或删除不再需要的备份主机。这些操作通常需要使用 Hestia 的其他 CLI 命令或管理界面来完成。

## v-download-backup

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-download-backup)

### 概述

`v-download-backup` 是 Hestia 提供的一个 CLI 命令，用于从远程服务器或备份系统中下载指定的备份文件。此命令特别适用于当需要从远程位置检索备份文件以进行恢复或进一步操作时。

### 用法

```bash
v-download-backup USER BACKUP
```

- **USER**: 用户名，用于标识备份的所有者或与之相关的系统/域。
- **BACKUP**: 要下载的备份文件的名称或标识符。

### 选项

此命令没有直接的选项参数，但会根据配置文件中的设置和备份系统的类型执行不同的下载操作。

### 示例

#### 示例 1: 从默认备份位置下载备份

假设您有一个名为 `john_doe` 的用户，并且您想要下载名为 `website_backup_2023-04-18.tar.gz` 的备份文件。

```bash
v-download-backup john_doe website_backup_2023-04-18.tar.gz
```

如果成功，该命令将尝试从默认备份位置 `/backup` 下载指定的备份文件。

#### 示例 2: 下载不存在于本地备份目录的备份

如果备份文件不存在于本地备份目录中，但配置了远程备份系统（如 Google Drive、SFTP、FTP、RClone 或 Backblaze B2），`v-download-backup` 将尝试从远程位置下载该文件。

```bash
v-download-backup john_doe missing_backup.tar.gz
```

如果 `missing_backup.tar.gz` 文件不存在于本地备份目录中，但配置了 Google Drive 作为备份系统，该命令将尝试从 Google Drive 下载该文件。如果 Google Drive 中也不存在该文件，它将继续尝试其他配置的远程备份系统（如果已配置）。

#### 示例 3: 检查磁盘空间并下载备份

在尝试下载备份之前，该命令会检查备份目录的磁盘空间是否足够。如果磁盘空间不足，将发送错误消息并停止下载过程。

```bash
v-download-backup john_doe important_backup.tar.gz
```
如果备份目录的磁盘空间不足，您将看到类似以下的错误消息：

```bash
Error: Not enough disk space
```
### 注意事项

- 在执行此命令之前，请确保已正确配置了 Hestia 的备份设置，包括远程备份系统的凭据和配置。
- 根据您的系统配置和备份系统的类型，下载过程可能需要一些时间。
- 如果指定的备份文件不存在于本地或任何配置的远程备份系统中，命令将尝试发送通知（如果已配置）并记录错误。
- 请注意，下载的文件权限和所有权可能会被设置为特定的值（如示例中的 `chmod 0640` 和 `chown hestiaweb:hestiaweb`），以确保安全性和适当的访问权限。

### 后续操作

一旦备份文件被成功下载，您可以使用其他 Hestia CLI 命令或手动操作来恢复、解压或进一步处理该文件。请确保在继续之前检查文件的完整性和准确性。

## v-list-user-backup

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-user-backup)

### 概述

`v-list-user-backup` 是 Hestia 提供的一个 CLI 命令，用于列出指定用户下的指定备份文件的详细信息。此命令支持多种输出格式，如 JSON、纯文本、CSV 和 Shell 格式，以满足不同用户的需求。

### 用法

```bash
v-list-user-backup USER BACKUP [FORMAT]
```

- **USER**: 用户名，用于标识备份的所有者或与之相关的系统/域。
- **BACKUP**: 要查询的备份文件的名称或标识符。
- **[FORMAT]**: 可选参数，指定输出格式。支持 `json`、`plain`、`csv` 和 `shell`。默认为 `shell`。

### 示例

#### 示例 1: 使用默认 Shell 格式列出备份信息

假设您想要列出用户 `john_doe` 下名为 `website_backup_2023-04-18.tar.gz` 的备份文件的详细信息。

```bash
v-list-user-backup john_doe website_backup_2023-04-18.tar.gz
```

输出示例（Shell 格式）：

```bash
BACKUP:         website_backup_2023-04-18.tar.gz
TYPE:           full
SIZE:           500 mb
RUNTIME:        30 min
WEB:            www.example.com
DNS:            ns1.example.com,ns2.example.com
MAIL:           mail.example.com
DB:             example_db
CRON:           yes
UDIR:           /home/john_doe/userdata
TIME:           15:30
DATE:           2023-04-18
```

#### 示例 2: 使用 JSON 格式列出备份信息

如果您希望将备份信息以 JSON 格式输出，可以使用以下命令：

```bash
v-list-user-backup john_doe website_backup_2023-04-18.tar.gz json
```

输出示例（JSON 格式）：

```json
{
    "website_backup_2023-04-18.tar.gz": {
        "TYPE": "full",
        "SIZE": "500",
        "WEB": "www.example.com",
        "DNS": "ns1.example.com,ns2.example.com",
        "MAIL": "mail.example.com",
        "DB": "example_db",
        "CRON": "yes",
        "UDIR": "/home/john_doe/userdata",
        "RUNTIME": "30",
        "TIME": "15:30",
        "DATE": "2023-04-18"
    }
}
```

#### 示例 3: 使用 CSV 格式列出多个备份信息

假设您想要列出用户 `john_doe` 下的多个备份文件信息，并以 CSV 格式输出：

```bash
v-list-user-backup john_doe '*' csv
```

输出示例（CSV 格式）：

```csv
BACKUP,TYPE,SIZE,WEB,DNS,MAIL,DB,CRON,UDIR,RUNTIME,TIME,DATE
website_backup_2023-04-18.tar.gz,full,500,www.example.com,"ns1.example.com,ns2.example.com",mail.example.com,example_db,yes,"/home/john_doe/userdata",30,15:30,2023-04-18
another_backup_2023-04-19.tar.gz,incremental,300,www2.example.com,"ns3.example.com,ns4.example.com",mail2.example.com,another_db,no,"/home/john_doe/userdata",15,10:00,2023-04-19
```

### 注意事项

- 在执行此命令之前，请确保已正确配置了 Hestia，并且用户和用户数据是存在的。
- `BACKUP` 参数可以使用通配符 `*` 来匹配多个备份文件。但是，请注意，在 JSON 格式下，这可能会导致输出结构复杂且不易解析。
- 输出格式的选择取决于您的具体需求。Shell 格式适用于直接查看，而 JSON、CSV 和 Plain 格式则更适合于程序化处理和进一步分析。

## v-list-user-backup-exclusions

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-user-backup-exclusions)

### 概述

`v-list-user-backup-exclusions` 是 Hestia 提供的一个 CLI 命令，用于列出指定用户的备份排除规则。这些规则定义了在进行备份时哪些文件或目录将被排除在外。该命令支持多种输出格式，以满足不同用户的需求。

### 用法

```bash
v-list-user-backup-exclusions USER [FORMAT]
```

- **USER**: 用户名，用于标识要查询备份排除规则的用户。
- **[FORMAT]**: 可选参数，指定输出格式。支持 `json`、`shell` 等。默认为 `shell`。

### 示例

#### 示例 1: 使用默认 Shell 格式列出备份排除规则

假设您想要列出用户 `john_doe` 的备份排除规则。

```bash
v-list-user-backup-exclusions john_doe
```

输出示例（Shell 格式）：

```bash
WEB:
  /home/john_doe/public_html/cache
  /home/john_doe/public_html/logs
MAIL:
  /var/vmail/john_doe/cur/trash
DB:
  (无排除规则)
USER:
  /home/john_doe/.ssh
```

#### 示例 2: 使用 JSON 格式列出备份排除规则

如果您希望将备份排除规则以 JSON 格式输出，可以使用以下命令：

```bash
v-list-user-backup-exclusions john_doe json
```

输出示例（JSON 格式）：

```json
{
  "WEB": [
    "/home/john_doe/public_html/cache",
    "/home/john_doe/public_html/logs"
  ],
  "MAIL": [
    "/var/vmail/john_doe/cur/trash"
  ],
  "DB": [],
  "USER": [
    "/home/john_doe/.ssh"
  ]
}
```

### 注意事项

- 在执行此命令之前，请确保已正确配置了 Hestia，并且用户是存在的。
- 备份排除规则是定义在用户的配置文件或相关位置中，该命令负责从配置文件中提取这些规则。
- 输出格式的选择取决于您的具体需求。Shell 格式适用于直接查看，而 JSON 格式则更适合于程序化处理和进一步分析。
- 不同的用户可能有不同的备份排除规则，因此请确保您指定了正确的用户名。
- 如果某个服务（如数据库）没有定义任何排除规则，则对应的输出部分将显示为空或不存在（如示例中的 "DB" 部分）。
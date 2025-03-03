# FTPS系列命令介绍

SFTP（SSH File Transfer Protocol）是一种基于SSH（Secure Shell）协议的文件传输协议，用于安全地在本地主机和远程服务器之间传输文件。它是SSH协议的一部分，通过加密的方式保证数据传输的安全性。

SFTP与FTP（File Transfer Protocol）的主要区别在于SFTP使用SSH加密连接，而FTP通常使用明文传输。因此，SFTP提供了更高的安全性，能够防止数据在传输过程中被窃取或篡改。

使用SFTP，用户可以通过命令行或图形界面客户端连接到远程服务器，并进行文件的上传、下载、删除和重命名等操作。SFTP通常与SSH客户端集成在一起，使得用户可以使用相同的认证凭据（如用户名和密码或私钥）来访问远程服务器。

SFTP的主要优点包括：

1. **安全性高**：通过SSH加密连接，保护数据传输过程中的机密性和完整性。
2. **易用性**：与SSH客户端集成，使用统一的认证方式，无需额外配置。
3. **跨平台性**：支持多种操作系统，包括Linux、Unix、Windows和macOS等。
4. **可靠性**：能够处理网络中断和连接不稳定的情况，支持断点续传。

在使用SFTP时，用户需要确保远程服务器已经安装了SSH服务器软件，并且已经配置了正确的访问权限和认证方式。然后，用户可以使用命令行工具（如`sftp`命令）或图形界面客户端（如FileZilla、WinSCP等）来连接到远程服务器并进行文件传输操作。

## v-restart-ftp

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-restart-ftp)

### 说明

`v-restart-ftp` 命令用于重启 Hestia Control Panel 配置的 FTP 服务。当 FTP 服务需要进行更新、配置更改或故障排除时，此命令可确保服务能够正常重启。

### 语法

```bash
v-restart-ftp [SCHEDULED|no]
```

- **SCHEDULED** (可选): 如果指定此参数，则将重启命令添加到重启队列中，而不是立即执行。
- **no** (可选): 如果指定此参数，则不执行任何操作，命令将直接退出。

如果不提供任何参数，并且 `SCHEDULED_RESTART` 配置项设置为 `'yes'`，则命令将默认以 `scheduled` 模式运行。

### 示例

#### 示例 1: 立即重启 FTP 服务

```bash
v-restart-ftp
```

此命令将立即尝试重启 Hestia 配置的 FTP 服务。

#### 示例 2: 将重启命令添加到队列中

```bash
v-restart-ftp scheduled
```

此命令不会立即重启 FTP 服务，而是将重启命令添加到重启队列中，以便稍后执行。

#### 示例 3: 不执行任何操作

```bash
v-restart-ftp no
```

此命令将不执行任何操作，并直接退出。

### 工作原理

- 命令首先检查是否已定义 `FTP_SYSTEM` 环境变量，并且该值不是 `'remote'`，因为远程 FTP 系统不需要本地重启。
- 如果第一个参数是 `'no'`，则命令将直接退出。
- 如果第一个参数是 `'scheduled'` 或者未提供任何参数但 `SCHEDULED_RESTART` 配置项设置为 `'yes'`，则命令将把重启命令添加到重启队列中，而不是立即执行。
- 接下来，命令尝试重启 FTP 服务。这通常通过调用服务管理工具（如 `service` 命令）来完成，具体取决于 `FTP_SYSTEM` 的值。
- 如果 FTP 服务重启失败，命令将调用 `send_email_report` 函数来发送一封包含错误详情的电子邮件给管理员。
- 如果 FTP 服务成功重启，并且存在重启队列文件（`$HESTIA/data/queue/restart.pipe`），则从队列中移除该重启命令。

### 注意事项

- 在执行重启命令之前，请确保已经保存了所有未保存的更改，并了解了重启可能带来的潜在影响。
- 如果 FTP 服务与其他系统或服务（如数据库、邮件服务器等）有依赖关系，请确保这些依赖关系在重启前已经得到妥善处理。
- 如果您的 FTP 服务配置复杂，或者与其他系统或服务紧密集成，请确保您已经了解了重启可能导致的连锁反应，并已经采取了相应的预防措施。
- 命令中使用的 `send_email_report` 函数用于在出现问题时发送电子邮件给管理员。请确保相关的电子邮件配置（如 SMTP 服务器和发件人地址）已经正确设置。
- 在 `SCHEDULED` 模式下，重启命令将被添加到队列中，以便稍后由系统管理员或其他自动化进程执行。请确保定期监控重启队列，并根据需要执行其中的命令。

## v-add-sys-sftp-jail

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-sys-sftp-jail)

### 概述

`v-add-sys-sftp-jail` 是一个由 Hestia 提供的 CLI 命令，用于在系统级别上启用 SFTP（SSH File Transfer Protocol）的受限（Jailed）环境。通过此命令，管理员可以确保 SFTP 用户只能在特定的、受限的目录中访问和修改文件，从而提高系统的安全性。

### 语法

```bash
v-add-sys-sftp-jail [选项]
```

### 选项

* **[RESTART]**：如果指定了此选项（通常为 `yes` 或 `no`），则命令执行后可能会根据需要进行 SSH 服务的重启。

### 示例

#### 示例 1：启用 SFTP Jailed 环境并重启 SSH 服务

```bash
v-add-sys-sftp-jail yes
```

在这个示例中，`v-add-sys-sftp-jail` 命令被调用，并传递了 `yes` 作为参数。这意味着在配置 SFTP Jailed 环境后，脚本将尝试重启 SSH 服务以使更改生效。

#### 示例 2：仅启用 SFTP Jailed 环境而不重启 SSH 服务

```bash
v-add-sys-sftp-jail no
```

在这个示例中，即使启用了 SFTP Jailed 环境，但由于传递了 `no` 作为参数，脚本将不会尝试重启 SSH 服务。管理员可以稍后手动重启 SSH 服务，或者等待下一次系统重启。

### 注意事项

* 在执行此命令之前，请确保您已经备份了相关的配置文件（如 `/etc/ssh/sshd_config`），以防出现意外情况。
* 启用 SFTP Jailed 环境可能会影响现有的 SFTP 用户配置。在执行此命令之前，请确保您了解这一点，并已经做好了必要的准备工作。
* 如果在执行此命令后遇到任何问题，请查看 Hestia 的日志文件以获取更多信息。日志文件的位置可能因安装方式和操作系统而异，但通常可以在 `/var/log/hestia/` 或类似的目录下找到。

### 结论

`v-add-sys-sftp-jail` 是一个强大的工具，用于在系统级别上启用 SFTP 的受限环境。通过仔细配置和使用此命令，管理员可以提高系统的安全性，并限制 SFTP 用户对系统文件的访问。

## v-add-user-sftp-jail

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-user-sftp-jail)

### 概述

`v-add-user-sftp-jail` 命令是 Hestia 提供的一个 CLI（命令行界面）工具，用于在系统中为 SFTP（SSH 文件传输协议）用户设置受限的（或称为 jail）环境。这意味着该用户可以仅访问其指定的目录，而不能访问系统的其他部分，从而增强了安全性。

### 语法

```bash
v-add-user-sftp-jail USER [RESTART]
```

- `USER`: 需要添加到 SFTP jail 的用户名。
- `RESTART` (可选): 是否在添加用户后重启 SSH 服务。如果指定为 `no`，则不会重启服务。默认为 `yes`。

### 示例

#### 示例 1: 添加用户并重启 SSH 服务

假设您想要为名为 `admin` 的用户设置 SFTP jail 环境，并在添加后重启 SSH 服务，您可以使用以下命令：

```bash
v-add-user-sftp-jail admin
```

执行此命令后，系统将为 `admin` 用户设置 SFTP jail 环境，并自动重启 SSH 服务。

#### 示例 2: 添加用户但不重启 SSH 服务

如果您希望在添加用户后手动重启 SSH 服务，或者因为某种原因不希望立即重启服务，您可以使用以下命令：

```bash
v-add-user-sftp-jail admin no
```

执行此命令后，系统将为 `admin` 用户设置 SFTP jail 环境，但不会重启 SSH 服务。您可以在稍后手动执行 `service sshd restart` 命令来重启服务。

### 注意事项

1. **用户权限**：运行 `v-add-user-sftp-jail` 命令的用户应具有足够的权限来修改系统配置文件和用户设置。
2. **SFTP jail 目录**：在将用户添加到 SFTP jail 之前，请确保已为其创建了相应的目录，并且该目录的权限设置正确。通常，SFTP jail 目录的所有者应为 `root`，并且用户应具有适当的访问权限。
3. **SSH 服务重启**：在添加或删除 SFTP jail 用户后，建议重启 SSH 服务以确保更改生效。但是，请注意，在某些情况下，重启服务可能会导致短暂的连接中断。
4. **错误处理**：如果命令执行过程中出现错误，请检查命令语法是否正确，并确保您具有执行该命令所需的权限。您还可以查看系统的日志文件以获取更多有关错误的详细信息。

## v-add-user-sftp-key

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-user-sftp-key)

### 命令概述

`v-add-user-sftp-key` 是 Hestia 提供的 CLI 命令之一，用于为指定用户创建和更新 SFTP 密钥。此命令特别适用于需要为 File Manager 服务的用户配置 SSH 密钥的场景。

### 语法

```bash
v-add-user-sftp-key USER [TTL]
```

- `USER`：必需参数，指定要为其创建或更新 SFTP 密钥的用户名。
- `TTL`：可选参数，指定密钥的生存时间（Time To Live）。如果未指定，则使用默认值。

### 示例

#### 示例 1：为特定用户创建 SFTP 密钥

```bash
v-add-user-sftp-key john_doe
```

此命令将为用户 `john_doe` 创建一个新的 SFTP 密钥，并将其添加到用户的 `authorized_keys` 文件中。如果密钥已经存在，则此命令将更新现有的密钥。

#### 示例 2：为特定用户创建带有 TTL 的 SFTP 密钥

```bash
v-add-user-sftp-key jane_smith 30d
```

此命令将为用户 `jane_smith` 创建一个新的 SFTP 密钥，并将其设置为在 30 天后过期。这可以用于定期更新或轮换密钥。

#### 示例 3：批量创建多个用户的 SFTP 密钥

如果您需要为多个用户创建 SFTP 密钥，可以使用循环和脚本功能来自动化此过程。以下是一个简单的 bash 脚本示例，用于为多个用户创建 SFTP 密钥：

```bash
#!/bin/bash

# 定义用户列表
users=("user1" "user2" "user3")

# 循环遍历用户列表
for user in "${users[@]}"
do
    # 为每个用户调用 v-add-user-sftp-key 命令
    v-add-user-sftp-key "$user"
    
    # 检查命令执行结果，并输出相应消息
    if [ $? -eq 0 ]; then
        echo "SFTP 密钥已成功为 $user 创建或更新。"
    else
        echo "为 $user 创建或更新 SFTP 密钥时发生错误。"
    fi
done
```

将上述脚本保存为 `.sh` 文件，并通过 `bash script_name.sh` 命令执行它，即可为列表中的每个用户创建 SFTP 密钥。

### 注意事项

- 在执行此命令之前，请确保您已经登录到 Hestia 控制面板并具有相应的权限。
- 如果您正在使用 Hestia 的演示模式或只读模式，请确保这些模式不会影响 `v-add-user-sftp-key` 命令的执行。
- 请谨慎处理生成的密钥文件，确保它们的安全性和机密性。不要在不安全的网络环境中共享或传输这些文件。

### 结论

`v-add-user-sftp-key` 命令是 Hestia 提供的强大工具之一，用于为 File Manager 服务的用户配置和管理 SFTP 密钥。通过此命令，您可以轻松地为指定用户创建和更新 SFTP 密钥，从而确保安全的文件传输和访问。

## v-delete-backup-host

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-backup-host)

### 概述

`v-delete-backup-host` 是 Hestia 提供的一个 CLI（命令行接口）命令，用于删除指定的备份 FTP 服务器。该命令允许管理员轻松地从 Hestia 备份系统中移除不再需要的备份主机。

### 语法

```bash
v-delete-backup-host TYPE [HOST]
```

- `TYPE`：必填参数，指定备份类型（如 `sftp`、`rsync` 等）。
- `HOST`：可选参数，指定要删除的备份主机的地址或名称。如果省略，将删除该类型下的所有备份主机。

### 示例

#### 示例 1：删除指定类型的所有备份主机

假设你想要删除所有 `sftp` 类型的备份主机，你可以使用以下命令：

```bash
v-delete-backup-host sftp
```

执行此命令后，Hestia 将删除所有 `sftp` 类型的备份主机配置，并从备份系统中移除它们。

#### 示例 2：删除指定类型的指定备份主机

如果你只想删除某个具体的 `sftp` 备份主机（例如名为 `backup.example.com` 的主机），你可以使用以下命令：

```bash
v-delete-backup-host sftp backup.example.com
```

执行此命令后，Hestia 将仅删除名为 `backup.example.com` 的 `sftp` 类型备份主机配置。

### 注意事项

* 在执行删除操作之前，请确保你了解该命令的影响，并已经备份了重要的配置文件和数据。
* 如果你不确定要删除哪个备份主机，可以先使用其他命令（如 `v-list-backup-hosts`）来查看当前系统中的备份主机列表。
* 删除备份主机后，Hestia 将不再尝试从该主机上获取备份数据。如果你仍然需要这些数据，请在删除之前先将其导出或备份到其他位置。

### 常见问题解答

* **问**：我误删了某个重要的备份主机，能恢复吗？
  **答**：一旦备份主机被删除，Hestia 无法自动恢复其配置。但是，如果你之前已经备份了配置文件或数据，你可以手动恢复它们。
* **问**：我如何查看当前系统中的备份主机列表？
  **答**：你可以使用 `v-list-backup-hosts` 命令来查看当前系统中的备份主机列表。该命令将列出所有已配置的备份主机及其相关信息。

## v-change-web-domain-ftp-password

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-web-domain-ftp-password)

### 简介

`v-change-web-domain-ftp-password` 是 Hestia 提供的一个命令行工具，用于修改指定域名下 FTP 用户的密码。本命令允许系统管理员或具有适当权限的用户，以安全的方式更改 FTP 用户的访问凭据。

### 语法

```bash
v-change-web-domain-ftp-password USER DOMAIN FTP_USER FTP_PASSWORD
```

### 参数

* `USER`: 执行操作的 Hestia 系统用户。
* `DOMAIN`: 要修改 FTP 用户密码的域名。
* `FTP_USER`: 要更改密码的 FTP 用户名。
* `FTP_PASSWORD`: 新的 FTP 用户密码。

### 示例

#### 示例 1: 修改 FTP 用户密码

假设我们要为域名 `example.com` 下的 FTP 用户 `ftp_usr` 修改密码为 `ftp_qwerty`，并且使用 `admin` 用户执行此操作，则命令如下：


```bash
v-change-web-domain-ftp-password admin example.com ftp_usr ftp_qwerty
```
执行此命令后，如果一切正常，系统将不会输出任何信息，但 FTP 用户 `ftp_usr` 的密码已被成功修改为 `ftp_qwerty`。

#### 示例 2: 错误使用（未提供足够参数）

如果尝试在不提供所有必要参数的情况下运行命令，系统将显示错误消息：


```bash
v-change-web-domain-ftp-password admin example.com
```
执行此命令后，系统可能会输出类似以下内容的错误消息：


```bash
Error: Not enough arguments provided. Please provide USER, DOMAIN, FTP_USER, and FTP_PASSWORD.
```
### 注意事项

* 在使用此命令之前，请确保您已登录到具有适当权限的 Hestia 系统用户。
* 请确保提供的 FTP 用户名和密码是有效的，并且 FTP 用户确实存在于指定的域名下。
* 出于安全考虑，请避免在公共或不受信任的环境中泄露或共享 FTP 用户凭据。

### 常见问题解答

* **问**: 我忘记了 FTP 用户的当前密码，如何重置它？
  **答**: 您可以使用 `v-change-web-domain-ftp-password` 命令来更改 FTP 用户的密码，而无需知道其当前密码。只需提供新的密码即可。
* **问**: 我可以更改不属于我的域名的 FTP 用户密码吗？
  **答**: 不可以。您只能更改属于您管理的域名下的 FTP 用户密码。
* **问**: 如果我输入了错误的 FTP 用户名或密码，会发生什么？
  **答**: 如果输入的 FTP 用户名不存在，或者密码不符合系统的密码策略要求，系统将显示错误消息。请确保输入正确的用户名和密码，并遵循系统的密码策略。

## v-change-web-domain-ftp-path

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-web-domain-ftp-path)

### 简介

`v-change-web-domain-ftp-path` 是 Hestia 提供的一个命令行工具，它允许管理员更改特定域名下 FTP 用户的根目录（或称为工作目录）。这个命令在需要移动 FTP 用户的主目录或为其分配新的存储空间时非常有用。

### 语法

```bash
v-change-web-domain-ftp-path USER DOMAIN FTP_USER NEW_PATH
```

### 参数

- `USER`: 执行该命令的 Hestia 系统用户。
- `DOMAIN`: 要更改 FTP 用户根目录的域名。
- `FTP_USER`: 要更改根目录的 FTP 用户名。
- `NEW_PATH`: FTP 用户新的根目录路径。

### 示例

#### 示例 1: 更改 FTP 用户的根目录

假设我们想要更改 `example.com` 域名下 FTP 用户 `ftpuser` 的根目录为 `/new/ftp/path/`，并且使用 `admin` 用户执行此操作，则命令如下：

```bash
v-change-web-domain-ftp-path admin example.com ftpuser /new/ftp/path/
```

执行成功后，FTP 用户 `ftpuser` 登录后将看到 `/new/ftp/path/` 作为其根目录。

#### 示例 2: 检查命令是否正确执行

为了验证命令是否成功执行，你可以尝试使用 FTP 客户端以 `ftpuser` 用户的身份登录，并检查其根目录是否已经更改。

### 注意事项

- 在执行此命令之前，请确保 `NEW_PATH` 路径在服务器上存在且可访问。
- 更改 FTP 用户的根目录可能会影响该用户的文件访问权限和可见性。确保新的路径符合用户的预期和需要。
- 如果你不确定如何执行此操作或担心可能的影响，请先在测试环境中尝试。

### 常见问题解答

- **问**: 如果新的路径不存在怎么办？
  **答**: 如果新的路径不存在，FTP 用户可能无法访问其根目录，或者可能看到空目录。在更改 FTP 用户的根目录之前，请确保新的路径已经创建并且权限设置正确。
  
- **问**: 我可以更改不属于我的域名的 FTP 用户根目录吗？
  **答**: 不可以。你只能更改属于你管理的域名下的 FTP 用户根目录。
  
- **问**: 我可以在不登录到服务器的情况下执行此命令吗？
  **答**: 是的，你可以通过 SSH 远程登录到服务器并执行此命令，或者使用任何支持 Hestia CLI 命令的远程管理工具。但是，你需要具有适当的权限才能执行此操作。

## v-update-sys-rrd-ftp

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-sys-rrd-ftp)

### 概述

`v-update-sys-rrd-ftp` 是 Hestia 系统中用于更新 FTP 服务器相关的 RRD (Round Robin Database) 数据库和图形的 CLI 命令。这个命令通过收集 FTP 服务器的活动数据，并将其存储在 RRD 数据库中，进而用于生成各种统计图形，以便用户或管理员能够直观地查看 FTP 服务器的运行状况。

### 使用方法

#### 基本语法

```bash
v-update-sys-rrd-ftp [选项]
```

#### 选项

* **-p, --period**：指定更新数据的时间段。可选值包括 `daily`（每日）、`weekly`（每周）、`monthly`（每月）和 `yearly`（每年）。默认为 `daily`。
* **-h, --help**：显示帮助信息。

### 示例

#### 示例 1：更新每日 FTP 数据

```bash
v-update-sys-rrd-ftp
```

或者，使用 `-p` 选项明确指定时间段：

```bash
v-update-sys-rrd-ftp -p daily
```

#### 示例 2：更新每周 FTP 数据

```bash
v-update-sys-rrd-ftp -p weekly
```

#### 示例 3：查看帮助信息

```bash
v-update-sys-rrd-ftp -h
```

执行此命令后，将显示关于 `v-update-sys-rrd-ftp` 命令的详细用法和选项信息。

### 注意事项

* 在运行此命令之前，请确保 Hestia 系统已正确配置并正在运行。
* 如果系统中存在多个 FTP 服务器实例，该命令将针对所有实例进行更新。
* 生成的 RRD 数据库和图形文件将存储在 Hestia 系统指定的目录中，您可以在该目录中查看和管理这些文件。

### 常见问题

* **Q**: 如何查看 FTP 数据统计图形？
* **A**: 生成的 FTP 数据统计图形将存储在 Hestia 系统的 Web 界面中，您可以通过访问该界面来查看这些图形。
* **Q**: 如果更新过程中出现错误怎么办？
* **A**: 请检查 Hestia 系统的日志文件以获取更多关于错误的详细信息。根据错误信息进行相应的故障排除或联系支持团队以获取帮助。

## v-list-sys-vsftpd-config

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-vsftpd-config)

### 命令概述

`v-list-sys-vsftpd-config` 是一个由 Hestia 提供的 CLI（命令行接口）命令，用于获取系统中 vsftpd 配置文件的路径列表。该命令特别适用于自动化脚本和需要快速定位 vsftpd 配置文件位置的场景。

### 使用方法

`v-list-sys-vsftpd-config` 命令接受一个可选的参数，用于指定输出格式。如果没有提供参数，则默认使用 shell 格式输出。

```bash
v-list-sys-vsftpd-config [FORMAT]
```

其中，`[FORMAT]` 可以是以下值之一：

* `shell`：以 shell 脚本友好的格式输出（默认）
* `json`：以 JSON 格式输出
* `plain`：以纯文本格式输出
* `csv`：以 CSV 格式输出

### 示例

#### 示例 1：默认输出（shell 格式）

```bash
$ v-list-sys-vsftpd-config
config_path: /etc/vsftpd.conf
```

#### 示例 2：JSON 格式输出

```bash
$ v-list-sys-vsftpd-config json
{
  "CONFIG": {
    "config_path": "/etc/vsftpd.conf"
  }
}
```

#### 示例 3：纯文本格式输出

```bash
$ v-list-sys-vsftpd-config plain
/etc/vsftpd.conf
```

#### 示例 4：CSV 格式输出

```bash
$ v-list-sys-vsftpd-config csv
config_path
/etc/vsftpd.conf
```

### 注意事项

* 如果系统中存在多个 vsftpd 配置文件，该命令只会返回第一个找到的配置文件路径。
* 在使用 CSV 格式输出时，请注意字段之间使用逗号（`,`）分隔，并且在字段值中包含逗号、换行符或双引号等特殊字符时，该字段值会被双引号括起来。
* 如果命令执行失败（例如，由于权限问题无法访问配置文件），则会输出相应的错误信息。

### 脚本集成

由于 `v-list-sys-vsftpd-config` 命令的输出格式是可配置的，因此它非常适合与其他脚本和自动化工具集成。您可以将该命令的输出解析为所需的格式，并将其用于配置管理、监控或其他自动化任务中。

### 总结

`v-list-sys-vsftpd-config` 命令是一个方便易用的工具，用于获取系统中 vsftpd 配置文件的路径列表。通过指定不同的输出格式，您可以轻松地将该命令的输出集成到各种自动化脚本和工具中。

## v-list-sys-web-status

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-web-status)

### 概述

本文档介绍了如何使用Hestia CP提供的CLI命令`v-list-sys-web-status`来检查Web服务器的状态。这个命令将显示代理服务器（默认为Nginx）和Web服务器（可配置为Nginx或其他类型）的状态信息。

### 使用说明

#### 1. 命令格式

在命令行中直接输入`v-list-sys-web-status`即可执行此命令。

#### 2. 前提条件

- 确保你已经安装了Hestia CP并正确配置了相关的Web服务器和代理服务器。
- 确保你有足够的权限来执行此命令。

#### 3. 示例输出

当执行`v-list-sys-web-status`命令时，你将看到类似以下的输出：

```bash
NGINX PROXY STATUS
...(Nginx代理服务器的状态信息)...

APACHE WEB SYSTEM STATUS
...(Apache Web服务器的状态信息)...
```

请注意，实际的输出将取决于你的Web服务器和代理服务器的配置以及它们当前的状态。

### 详细说明

#### 1. 代理服务器状态

如果`PROXY_SYSTEM`被设置为'nginx'，则命令将首先显示Nginx代理服务器的状态。这通常是通过访问`http://localhost:8084/`来实现的，但具体的端口和路径可能因你的配置而异。

#### 2. Web服务器状态

接下来，命令将显示Web服务器的状态。这取决于`WEB_SYSTEM`变量的值。如果它不是'nginx'，则命令将尝试通过访问`http://localhost:8081/server-status/`来获取状态信息。如果`WEB_SYSTEM`是'nginx'，则它将再次尝试访问`http://localhost:8084/`（与代理服务器相同的端口和路径）。

#### 3. 注意事项

- 确保你的Web服务器和代理服务器都在运行，并且可以通过指定的端口和路径进行访问。
- 如果你的Web服务器或代理服务器使用了非标准的端口或路径，你可能需要修改脚本中的相关部分以匹配你的配置。
- 请注意，输出中的状态信息可能因你的Web服务器和代理服务器的具体配置而异。某些信息可能需要你具备一定的专业知识才能理解。

### 常见问题

#### 1. 为什么我看不到任何输出？

- 确保你的Web服务器和代理服务器都在运行并且可以通过指定的端口和路径进行访问。
- 检查你的`WEB_SYSTEM`和`PROXY_SYSTEM`变量是否正确设置。
- 如果你在脚本中进行了修改，请确保所有的修改都是正确的，并且没有引入任何语法错误。

#### 2. 我看到了错误消息怎么办？

- 仔细阅读错误消息，并尝试理解它的含义。
- 检查你的Web服务器和代理服务器的日志文件，以获取更详细的错误信息。
- 如果你无法解决问题，请考虑在Hestia CP的官方论坛或社区中寻求帮助。

### 结论

`v-list-sys-web-status`命令是一个有用的工具，可以帮助你快速检查Hestia CP中Web服务器和代理服务器的状态。通过仔细阅读本文档并按照说明进行操作，你应该能够成功地使用此命令来获取所需的信息。

## v-list-sys-proftpd-config

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-proftpd-config)

`v-list-sys-proftpd-config` 是 Hestia 提供的一个 CLI（命令行界面）命令，用于获取系统上的 ProFTPD（Professional FTP Daemon）配置文件参数的列表。ProFTPD 是一种常用的 FTP 服务器软件，广泛应用于各种 Linux 系统中。

### 命令选项

`v-list-sys-proftpd-config` 命令支持一个可选的参数 `[FORMAT]`，用于指定输出格式。如果不指定该参数，则默认使用 shell 格式输出。

### 使用示例

#### 示例 1：默认输出格式

```bash
v-list-sys-proftpd-config
```

执行上述命令后，将按照默认的 shell 格式输出 ProFTPD 配置文件参数的列表。输出内容可能类似于：

```bash
config_path: /etc/proftpd/proftpd.conf
```

#### 示例 2：指定 JSON 格式输出

```bash
v-list-sys-proftpd-config json
```

执行上述命令后，将按照 JSON 格式输出 ProFTPD 配置文件参数的列表。输出内容可能类似于：

```json
{
  "CONFIG": {
    "config_path": "/etc/proftpd/proftpd.conf"
  }
}
```

#### 示例 3：指定 CSV 格式输出

```bash
v-list-sys-proftpd-config csv
```

执行上述命令后，将按照 CSV 格式输出 ProFTPD 配置文件参数的列表。输出内容可能类似于：

```csv
config_path
/etc/proftpd/proftpd.conf
```

#### 示例 4：指定 PLAIN 格式输出（仅输出配置路径）

```bash
v-list-sys-proftpd-config plain
```

执行上述命令后，将仅输出 ProFTPD 配置文件的路径，而不包含任何额外的格式信息。输出内容可能类似于：

```bash
/etc/proftpd/proftpd.conf
```

### 注意事项

* 在执行 `v-list-sys-proftpd-config` 命令之前，请确保您已经正确安装了 Hestia，并且具有执行该命令的权限。
* 如果您的系统上安装了多个版本的 ProFTPD 或者使用了非标准的配置文件路径，`v-list-sys-proftpd-config` 命令可能无法找到正确的配置文件。在这种情况下，您可以尝试手动指定配置文件路径，或者检查您的系统配置以确定正确的配置文件位置。
* 该函数用于获取proftpd配置参数列表。ProFTPD是一款自由开源的FTP服务器软件，名称意为“专业的FTP守护进程”（Professional File Transfer Protocol daemon）。它是在BSD协议下发布的，支持多种平台，软件包括Linux、Unix、Windows和macOS等。ProFTPD提供了一系列的特性和功能，使得它成为一个功能强大和可定制化的FTP服务器软件

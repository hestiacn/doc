# Hetia面板系列命令介绍

## v-change-sys-release

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-sys-release)

`v-change-sys-release` 是一个由 HestiaCP 提供的 CLI 命令，用于更改 Hestia Control Panel 的发布分支。通过此命令，用户可以在稳定版本和预发布版本之间切换，如果启用了自动更新，系统将根据相应的发布计划自动更新。

### 使用说明

#### 语法

```bash
v-change-sys-release branchname [RESTART]
```

- `branchname`：指定要切换到的发布分支名称。可以是 `release`（最新的稳定版本）、`beta`（beta 和发布候选测试版本）、`main`（下一个版本的进行中代码），或者从 GitHub 仓库中指定的其他分支名称。
- `[RESTART]`：可选参数，通常此命令不需要重启服务，但在某些情况下，你可能需要手动重启服务以确保更改生效。

#### 前提条件

1. 需要有足够的权限来修改 HestiaCP 的配置文件和仓库信息。
2. 系统应该已经连接到互联网，因为命令会使用 `curl` 来检查指定的分支在 GitHub 仓库上是否存在。

#### 工作流程

1. **参数验证**：检查是否提供了有效的发布分支名称。如果没有提供，命令将显示错误消息和用法说明。
2. **只读模式检查**：如果 HestiaCP 设置为只读模式，则命令将停止执行并给出相应提示。
3. **分支存在性检查**：使用 `curl` 命令检查指定的分支在 GitHub 仓库上是否存在。如果不存在，命令将显示错误消息并退出。
4. **更新配置文件**：从 HestiaCP 的配置文件中删除旧的 `RELEASE_BRANCH` 变量，并添加新的 `RELEASE_BRANCH` 变量，其值为指定的分支名称。
5. **日志记录**：记录事件日志，表示已成功更改了系统的更新分支。

### 示例

#### 示例 1：切换到稳定版本

要将 HestiaCP 切换到稳定版本，可以运行以下命令：

```bash
v-change-sys-release release
```

执行后，HestiaCP 将从 `release` 分支获取更新（如果启用了自动更新）。

#### 示例 2：切换到 beta 版本

要切换到 beta 版本以测试新功能或修复程序，可以运行以下命令：

```bash
v-change-sys-release beta
```

执行后，HestiaCP 将从 `beta` 分支获取更新（如果启用了自动更新）。

#### 示例 3：切换到特定分支

如果你希望从 GitHub 仓库的某个特定分支获取更新，可以指定该分支的名称。例如，要切换到名为 `feature-xyz` 的分支，可以运行：

```bash
v-change-sys-release feature-xyz
```

在执行此命令之前，请确保 `feature-xyz` 分支在 GitHub 仓库上确实存在。

#### 示例 4：检查分支列表

如果你不确定要切换到哪个分支，可以运行命令但不提供分支名称参数。这将显示可用的分支列表以及有关如何使用该命令的说明：

```bash
v-change-sys-release
```

执行后，你将看到类似以下的输出：

```bash
Error: no release branch specified.
Usage: v-change-sys-release branchname

Release branches:
- release:            the latest stable release
- beta:               beta and release candidate test releases
- main:               work-in-progress code for the next release

You can also specify another branch name from the
GitHub repository to install the code from that branch.
```

### 高级用法

#### 自定义分支

`v-change-sys-release` 命令不仅限于使用预定义的分支（如 `release`、`beta`、`main`），你还可以指定任何存在于 HestiaCP GitHub 仓库中的分支。这对于测试新功能、修复程序或特定分支的更改特别有用。

#### 手动重启服务

虽然更改发布分支通常不需要手动重启服务，但在某些情况下，你可能需要重启相关服务以确保所有更改都已生效。这可以通过 HestiaCP 的其他 CLI 命令或管理工具来完成。

### 注意事项

#### 备份配置文件

在更改发布分支之前，建议备份 HestiaCP 的配置文件。这可以在出现问题时帮助你快速恢复到之前的状态。

#### 验证分支的可用性

在切换到新的发布分支之前，确保该分支在 GitHub 仓库上是可用的，并且你了解该分支的状态（如稳定性、已知问题等）。

#### 监控更新过程

在切换到新的发布分支并启用自动更新后，建议监控系统的更新过程，以确保一切按预期进行。你可以检查系统日志或 HestiaCP 的管理界面以获取有关更新状态的信息。

#### 测试环境

在生产环境中更改发布分支之前，最好在测试环境中进行尝试。这可以帮助你验证更改是否按预期工作，并避免潜在的问题影响生产环境。

### 示例（自定义分支）

假设你希望从名为 `custom-feature` 的分支获取更新，你可以运行以下命令：

```bash
v-change-sys-release custom-feature
```

在执行此命令之前，请确保 `custom-feature` 分支在 HestiaCP 的 GitHub 仓库中确实存在，并且你了解该分支的内容和状态。

### 示例（结合手动重启服务）

如果你确定需要手动重启服务以使更改生效，你可以结合使用其他 HestiaCP 的 CLI 命令或管理工具来重启相关服务。这取决于你的具体设置和所使用的服务管理工具。以下是一个假设的示例，其中 `v-restart-service` 是一个假设的命令，用于重启 HestiaCP 的相关服务：

```bash
v-change-sys-release beta
v-restart-service # 假设的命令，用于重启服务
```

请注意，`v-restart-service` 是一个假设的命令，你需要根据你的实际设置和所使用的工具来确定正确的命令或步骤来重启服务。

### 总结

`v-change-sys-release` 命令为 HestiaCP 用户提供了更改发布分支的灵活性，使用户能够根据需要切换到不同的版本或分支。通过遵循上述的高级用法和注意事项，你可以更安全、更有效地使用此命令来管理你的 HestiaCP 系统。

## v-add-sys-dependencies

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-sys-dependencies)

`v-add-sys-dependencies` 是 HestiaCP（一个开源的 Web 主机控制面板）提供的一个 CLI（命令行接口）脚本，用于添加或更新系统依赖项。这个脚本通常用于安装或更新 HestiaCP 所需的 PHP 依赖包，例如 PHPMailer。

### 脚本执行条件

1. **必须为 root 用户执行**：脚本会检查执行用户是否为 root，如果不是，则会报错并退出。
2. **环境变量必须存在**：脚本会检查 `$HESTIA` 和 `$HOMEDIR` 环境变量是否已设置，如果没有，则会报错并退出。
3. **Composer 必须已安装**：如果 Composer 没有安装在 `$HOMEDIR/$user/.composer/composer` 路径下，脚本会尝试安装它。如果 Composer 安装失败，脚本会发送一个通知给 root 用户并退出。
4. **检查 HestiaCP 是否处于演示模式**：脚本会调用 `check_hestia_demo_mode` 函数来检查 HestiaCP 是否处于演示模式。

### 脚本执行流程

1. **删除并重新创建 vendor 目录**：脚本会进入 `$PM_INSTALL_DIR`（通常是 HestiaCP 的 web/inc 目录），删除现有的 vendor 目录（如果存在），并重新创建一个空的 vendor 目录。然后，它会将 vendor 目录的所有者更改为指定的用户。
2. **检查 OpenSSL 扩展是否已安装**：使用 PHP 命令行工具检查是否已安装 OpenSSL 扩展。
3. **使用 Composer 安装 PHP 依赖项**：根据 OpenSSL 扩展的安装情况，脚本会使用 PHP 或 `$HESTIA_PHP`（HestiaCP 自带的 PHP 解释器）来执行 Composer，以安装或更新 PHP 依赖项。这些依赖项通常包括 PHPMailer 等库。
4. **检查 Composer 执行结果**：如果 Composer 执行失败，脚本会输出错误消息，并提供一个链接供用户向 HestiaCP 开发团队报告问题。此外，脚本还会发送一个通知给 root 用户。

### 示例

#### 示例 1：成功执行脚本

假设你已经以 root 用户登录，并且所有的环境变量都已正确设置。执行以下命令：

```bash
/path/to/v-add-sys-dependencies
```
如果一切顺利，脚本将成功安装或更新 PHP 依赖项，并退出。

#### 示例 2：以非 root 用户执行脚本

如果你以非 root 用户执行脚本，你将看到以下输出：

```bash
ERROR: v-add-sys-dependencies can be run executed only by root user
```
然后，脚本将退出并返回错误代码 10。

#### 示例 3：环境变量未设置

如果 `$HESTIA` 或 `$HOMEDIR` 环境变量未设置，你将看到以下输出：

```bash
ERROR: Environment variables not present, installation aborted.
```
然后，脚本将退出并返回错误代码 2。

#### 示例 4：Composer 安装失败

如果 Composer 安装失败，你将看到错误消息，并收到一个通知，指示你如何手动运行安装程序或向 HestiaCP 开发团队报告问题。

#### 示例 5：OpenSSL 扩展未安装

如果 PHP 没有安装 OpenSSL 扩展，`v-add-sys-dependencies` 脚本会使用默认的 PHP 解释器（`/usr/bin/php`）来执行 Composer，因为 `$HESTIA_PHP` 通常会包含 OpenSSL 扩展。输出可能类似于以下内容：

```bash
# 脚本输出（假设 OpenSSL 未安装）
Loading composer repositories with package information
Updating dependencies (including require-dev)
Package operations: X installs, 0 updates, 0 removals
  - Installing symfony/polyfill-mbstring (v1.23.1): Downloading (100%)
# ...（其他 Composer 安装过程的输出）
```

如果安装过程中没有因为缺少 OpenSSL 而失败（有些库可能不需要 OpenSSL），则安装过程将继续进行。但是，如果 OpenSSL 是必需的，并且没有安装，则可能会在 Composer 的某个阶段出现错误。

#### 示例 6：Composer 执行失败

如果 Composer 执行失败（例如，由于网络连接问题、依赖项冲突或其他原因），你将看到类似以下内容的错误消息：

```bash
# 脚本输出（假设 Composer 执行失败）
Loading composer repositories with package information
Updating dependencies (including require-dev)
Your requirements could not be resolved to an installable set of packages.

  Problem 1
    - The requested package some/package could not be found in any version, there may be a typo in the package name.

Potential causes:
 - A typo in the package name
 - The package is not available in a stable-enough version according to your minimum-stability setting
   see <https://getcomposer.org/doc/04-schema-version.md#minimum-stability> for more details.
 - It's a private package and you forgot to add a custom repository to find it

Read <https://getcomposer.org/doc/articles/troubleshooting.md> for further common problems.

Installation failed, reverting ./composer.json to its original content.
ERROR: PHPMailer installation failed!
Please report this to our development team:
https://github.com/hestiacp/hestiacp/issues
```

在这种情况下，脚本会回滚 `composer.json` 文件的更改，并提示你向 HestiaCP 的开发团队报告问题。

### 注意事项

* 在执行此类脚本之前，最好备份相关的配置文件和目录，以防万一出现问题。
* 如果你遇到任何问题，请查看脚本的输出和日志文件以获取更多信息。
* 确保你的系统满足 HestiaCP 的所有依赖项要求，包括 PHP 版本、数据库服务器等。
* 如果你不熟悉这些工具或命令，请务必在尝试之前先阅读相关的文档和教程。

## v-add-sys-filemanager

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-sys-filemanager)

`v-add-sys-filemanager` 是 HestiaCP 提供的一个 CLI 命令，用于在 HestiaCP 系统中添加文件管理器功能。该命令主要用于自动安装和配置文件管理器软件（例如 FileGator），使其能够在 HestiaCP 环境中顺利运行。

### 使用说明

#### 语法

```bash
v-add-sys-filemanager [MODE]
```

- `[MODE]`：可选参数，用于指定安装模式（如有多种模式）。在当前示例中，该参数未被具体使用。

#### 前提条件

1. 该命令需要由 root 用户执行。
2. 相关的环境变量（如 `HESTIA`、`HOMEDIR`、`HESTIA_INSTALL_DIR`）需要被正确设置。
3. Composer 需要被正确安装，因为 FileGator 的依赖可能需要通过 Composer 进行管理。

#### 工作流程

1. **环境检查**：检查当前用户是否为 root 用户，以及必要的环境变量是否已设置。
2. **Composer 安装**：如果 Composer 未被安装，则会自动尝试安装 Composer。
3. **Demo 模式检查**：检查 HestiaCP 是否处于 Demo 模式（如果有此功能）。
4. **OpenSSL 检查**：通过 PHP 检查 OpenSSL 扩展是否已安装。
5. **目录清理与准备**：删除并重新创建用于安装文件管理器的目录。
6. **文件下载与解压**：从指定的 URL 下载 FileGator 的压缩包，并解压到指定目录。
7. **配置与权限设置**：复制必要的配置文件到文件管理器目录，并设置正确的文件和目录权限。

### 示例

#### 示例 1：正常安装

当所有条件都满足时，你可以直接运行以下命令来安装文件管理器：

```bash
v-add-sys-filemanager
```

命令执行后，如果一切顺利，它将自动完成安装过程，并在完成后返回提示符。

#### 示例 2：非 root 用户执行

如果你尝试以非 root 用户身份运行此命令，你将收到一个错误消息，提示只有 root 用户才能执行此命令：

```bash
ERROR: v-add-sys-filemanager can be run executed only by root user
```

#### 示例 3：环境变量缺失

如果环境变量未设置，你将收到一个错误消息，提示环境变量缺失并终止安装：

```bash
ERROR: Environment variables not present, installation aborted.
```

#### 示例 4：Composer 安装失败

如果 Composer 安装失败，你将收到一个通知，说明 Composer 安装失败，并建议手动运行安装程序或在 GitHub 上报告问题：

```bash
...
<p class="u-text-bold">Theadd-sys-filemanager</code></p>
<p>If this continues, <a href="https://github.com/hestiacp/hestiacp/issues" target="_blank">open an issue on GitHub</a>.</p>
```

请注意，以上示例中的错误消息和通知是基于提供的脚本代码片段和常见情况生成的假设性输出。实际输出可能因环境、版本和配置的不同而有所变化。

## v-change-sys-hestia-ssl

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-sys-hestia-ssl)

`v-change-sys-hestia-ssl` 是一个由 HestiaCP 提供的 CLI 命令，用于更新或更改 HestiaCP 系统中的 SSL 证书。此命令用于将指定的 SSL 证书和私钥文件复制到 HestiaCP 的 SSL 目录，并在需要时重启相关的服务以应用新的证书。

### 使用说明

#### 语法

```bash
v-change-sys-hestia-ssl SSL_DIR [RESTART]
```

- `SSL_DIR`：指定包含 SSL 证书和私钥文件的目录路径。
- `[RESTART]`：可选参数，用于指定是否在更改后重启服务。如果设置为 `no`，则不会重启服务。默认为重启服务。

#### 前提条件

1. 需要有足够的权限来访问和修改 HestiaCP 的 SSL 目录和相关的配置文件。
2. 需要将新的 SSL 证书和私钥文件放置在指定的 `SSL_DIR` 目录中，且文件名分别为 `certificate.crt` 和 `certificate.key`。

#### 工作流程

1. **参数验证**：验证命令是否接收了正确的参数数量，并检查 `SSL_DIR` 参数是否有效。
2. **只读模式检查**：如果 HestiaCP 设置为只读模式，则命令将停止执行并给出相应提示。
3. **证书处理**：
   - 读取 `SSL_DIR` 下的 `certificate.crt` 文件，并检查证书内容。
   - 如果证书文件中包含多个证书（例如，包含中间证书和根证书），则将其拆分为单独的 `certificate.crt`（只包含服务器证书）和 `certificate.ca`（包含中间证书和根证书）。
   - 验证拆分后的证书是否有效。
   - 如果证书验证成功，将 `certificate.ca` 移除（在脚本中仅为临时文件），只保留 `certificate.crt`。
4. **更新证书**：
   - 将处理后的 `certificate.crt` 和 `certificate.key` 文件复制到 HestiaCP 的 SSL 目录。
   - 如果指定了 `[RESTART]` 参数且不为 `no`，则重启 Nginx 和邮件服务以应用新的证书。
5. **日志记录**：记录事件日志，表示 SSL 证书已成功更新或更改。

### 示例

#### 示例 1：更新 SSL 证书并重启服务

假设你的 SSL 证书和私钥文件位于 `/path/to/certs` 目录中，你可以使用以下命令来更新 HestiaCP 的 SSL 证书并重启服务：

```bash
v-change-sys-hestia-ssl /path/to/certs
```

#### 示例 2：更新 SSL 证书但不重启服务

如果你只想更新 SSL 证书而不重启服务，可以使用以下命令：

```bash
v-change-sys-hestia-ssl /path/to/certs no
```

请注意，在某些情况下，即使不重启服务，新的 SSL 证书也可能不会立即生效，这取决于你的服务器配置和使用的软件。因此，在某些情况下，手动重启服务可能是必要的。

#### 示例 3：处理包含多个证书的 CRT 文件

如果你的 `certificate.crt` 文件包含多个证书（例如，服务器证书、中间证书和根证书），则 `v-change-sys-hestia-ssl` 命令将自动将其拆分为单独的证书文件，并仅保留服务器证书。这确保了只有正确的证书被用于你的网站或服务。

## v-list-default-php

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-default-php)

`v-list-default-php` 是一个 CLI 命令，用于列出系统上已安装的默认 PHP 版本。它根据 `/etc/php` 目录下 FPM (FastCGI Process Manager) 的配置来确定 PHP 版本。这个命令支持多种输出格式，包括 JSON、纯文本、CSV 和 Shell 格式。

### 使用说明

#### 语法

```bash
v-list-default-php [format]
```
其中，`[format]` 是可选参数，用于指定输出格式。如果不指定，则默认为 shell 格式。

#### 支持的格式

* `json`: 输出 JSON 格式的数据
* `plain`: 输出纯文本格式的数据（每行一个版本）
* `csv`: 输出 CSV 格式的数据（目前与 plain 格式相同，但未来可能包含标题行或其他 CSV 特性）
* `shell`: 输出适合 shell 脚本处理的格式（带有标题行）

#### 示例

#### 示例 1: 使用默认格式（shell）


```bash
v-list-default-php
```
输出可能类似于：


```bash
VERSION
--------
7.4
8.0
```
#### 示例 2: 使用 JSON 格式


```bash
v-list-default-php json
```
输出可能类似于：


```json
[
    "7.4",
    "8.0"
]
```
#### 示例 3: 使用纯文本格式


```bash
v-list-default-php plain
```
输出可能类似于：


```bash
7.4
8.0
```
#### 示例 4: 使用 CSV 格式（目前与 plain 格式相同）


```bash
v-list-default-php csv
```
输出可能类似于：


```bash
7.4
8.0
```
### 注意

* 这个命令依赖于 HestiaCP（或类似的系统）的环境变量和配置文件，因此它可能只在特定的系统或环境中工作。
* 输出内容取决于 `/etc/php` 目录下 FPM 的配置文件。
* 如果 `/etc/php` 目录下没有 FPM 的配置文件，或者配置文件的命名不符合预期，那么这个命令可能无法正确列出 PHP 版本。

## v-list-sys-hestia-ssl

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-hestia-ssl)

`v-list-sys-hestia-ssl` 是 Hestia 控制面板提供的一个 CLI 命令，用于列出或导出系统上已安装的 SSL 证书的相关信息。该命令支持多种输出格式，如 JSON、Shell、Plain Text 和 CSV。

### 使用方法

```bash
v-list-sys-hestia-ssl [format]
```

其中 `[format]` 是可选参数，用于指定输出格式。如果不指定，则默认为 `shell` 格式。

### 支持的输出格式

- `json`: 输出为 JSON 格式，包含证书的所有信息。
- `shell`: 类似于 Shell 脚本的输出，方便直接查看。
- `plain`: 纯文本格式，简洁明了。
- `csv`: CSV 格式，便于导入到电子表格软件中进行处理。

### 示例

#### JSON 格式输出

```bash
v-list-sys-hestia-ssl json
```

输出示例：

```json
{
    "HESTIA": {
        "CRT": "<certificate content (Base64 encoded)>",
        "KEY": "<private key content (Base64 encoded)>",
        "CA": "<CA certificate content (Base64 encoded)>",
        "SUBJECT": "<subject>",
        "ALIASES": "<alternative DNS names>",
        "NOT_BEFORE": "<certificate validity start date>",
        "NOT_AFTER": "<certificate validity end date>",
        "SIGNATURE": "<signature>",
        "PUB_KEY": "<public key>",
        "ISSUER": "<certificate issuer>"
    }
}
```

#### Shell 格式输出

```bash
v-list-sys-hestia-ssl shell
```

输出示例：

```bash
<certificate content (escaped)>

<private key content (escaped)>

SUBJECT:        <subject>
ALIASES:        <alternative DNS names>
VALID FROM:     <certificate validity start date>
VALID TIL:      <certificate validity end date>
SIGNATURE:      <signature>
PUB_KEY:        <public key>
ISSUER:         <certificate issuer>
```

#### Plain 格式输出

```bash
v-list-sys-hestia-ssl plain
```

输出示例：

```
<certificate content>
<private key content>
<CA certificate content>
<subject>
<alternative DNS names>
<certificate validity start date>
<certificate validity end date>
<signature>
<public key>
<certificate issuer>
```

#### CSV 格式输出

```bash
v-list-sys-hestia-ssl csv
```

输出示例：

```csv
CRT,KEY,CA,SUBJECT,ALIASES,NOT_BEFORE,NOT_AFTER,SIGNATURE,PUB_KEY,ISSUER
"<certificate content (Base64 encoded)>","<private key content (Base64 encoded)>","<CA certificate content (Base64 encoded)>","<subject>","<alternative DNS names>","<certificate validity start date>","<certificate validity end date>","<signature>","<public key>","<certificate issuer>"
```

### 注意事项

- 输出中的证书和密钥内容都是经过编码或转义的，以避免特殊字符引起的问题。
- 根据需要选择合适的输出格式，以便于后续的处理或使用。
- 在使用 `csv` 格式时，如果输出中包含逗号、换行符等特殊字符，可能需要额外的处理才能正确导入到电子表格软件中。

## v-update-web-domain-disk

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-web-domain-disk)

`v-update-web-domain-disk` 是 Hestia 控制面板提供的一个 CLI 命令，用于重新计算并更新特定网站域名的磁盘使用情况。

### 使用方法

```bash
v-update-web-domain-disk USER DOMAIN
```

其中：

- `USER` 是网站所有者的用户名。
- `DOMAIN` 是要更新磁盘使用情况的网站域名。

### 示例

更新名为 `alice` 的用户下 `wonderland.com` 域名的磁盘使用情况：

```bash
v-update-web-domain-disk alice wonderland.com
```

### 脚本流程

1. **参数定义**：从命令行接收 `USER` 和 `DOMAIN` 两个参数，并存储在相应的变量中。

2. **包含文件**：加载 Hestia 控制面板的配置文件和所需的函数库。

3. **参数验证**：检查是否提供了正确的参数数量（2个），并验证 `USER` 和 `DOMAIN` 是否为有效的格式。同时检查 Web 系统是否启用以及 `USER` 和 `DOMAIN` 是否存在。

4. **定义主目录**：根据 `USER` 和 `DOMAIN` 构造出网站的主目录路径。

5. **检查主目录是否存在**：如果主目录存在，则使用 `du` 命令计算目录的磁盘使用情况（以 MB 为单位），并将结果存储在 `disk_usage` 变量中。

6. **更新磁盘值**：将计算得到的 `disk_usage` 更新到相应的配置中，并重新计算用户的总磁盘使用情况。

7. **日志记录**：记录此次操作的成功事件，包括参数信息。

8. **退出**：脚本执行完毕，退出程序。

### 注意事项

- 脚本在执行 `du` 命令时使用了 `nice` 命令，以减少磁盘 I/O 对系统性能的影响。
- 在执行更新操作之前，脚本会检查主目录是否存在，以避免对不存在的目录进行无效操作。
- 脚本中提到的 `$domain_idn` 变量并未在脚本的当前版本中使用，可能是一个待实现的功能或遗留的代码。
- 脚本使用了 Hestia 提供的函数库和配置文件，确保在正确的环境中运行。
- 脚本的日志记录功能可以帮助管理员跟踪和监控命令的执行情况。

### 扩展功能

- 可以在脚本中添加额外的验证和错误处理机制，以提高脚本的健壮性和用户体验。
- 可以考虑将脚本集成到 Hestia 控制面板的图形界面中，方便用户通过图形界面进行磁盘使用情况的更新操作。
- 可以扩展脚本的功能，支持同时更新多个域名或用户的磁盘使用情况。

## v-update-web-domain-ssl

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-web-domain-ssl)

`v-update-web-domain-ssl` 是 Hestia 控制面板提供的一个 CLI 命令，用于更新特定网站域名的 SSL 证书。

### 使用方法

```bash
v-update-web-domain-ssl USER DOMAIN SSL_DIR [RESTART]
```

其中：

- `USER` 是网站所有者的用户名。
- `DOMAIN` 是要更新 SSL 证书的域名。
- `SSL_DIR` 是包含新 SSL 证书文件（`.crt`、`.key` 和可选的 `.ca`）的目录路径。
- `RESTART`（可选）是一个标志，用于指示是否重启 Web 服务器和代理服务器。如果未提供，则默认为不重启。

### 示例

1. 更新名为 `alice` 的用户下 `wonderland.com` 域名的 SSL 证书，不重启服务：

    ```bash
    v-update-web-domain-ssl alice wonderland.com /home/www/web/wonderland.com/public_html
    ```

2. 更新 SSL 证书并重启服务：

    ```bash
    v-update-web-domain-ssl alice wonderland.com /home/www/web/wonderland.com/public_html
    ```

### 脚本流程

1. **参数定义**：从命令行接收 `USER`、`DOMAIN`、`SSL_DIR` 和可选的 `RESTART` 参数，并存储在相应的变量中。

2. **包含文件**：加载 Hestia 控制面板的配置文件和所需的函数库。

3. **参数验证**：检查是否提供了正确的参数数量，并验证 `USER`、`DOMAIN` 和 `SSL_DIR` 是否为有效的格式。同时检查 Web 系统、SSL 支持是否启用，以及 `USER` 和 `DOMAIN` 是否存在且未被暂停。

4. **删除旧证书**：删除用户目录下和全局 SSL 目录中旧有的证书文件。

5. **复制新证书**：从 `SSL_DIR` 目录复制新的 SSL 证书文件（`.crt`、`.key` 和可选的 `.ca`）到全局 SSL 目录和用户目录的相应位置。

6. **设置文件权限**：确保新复制的 SSL 证书文件具有正确的文件权限。

7. **重启服务**（可选）：如果提供了 `RESTART` 参数并且其值为 `yes`，则重启 Web 服务器和代理服务器。

8. **检查结果**：检查 Web 服务器和代理服务器的重启是否成功。

9. **日志记录**：记录更新 SSL 证书的事件，并添加到系统的日志中。

10. **退出**：脚本执行完毕，退出程序。

### 注意事项

- 在复制新证书之前，脚本会删除旧有的证书文件，以避免证书冲突。
- 脚本支持可选的重启参数，允许管理员在更新证书后选择是否重启服务。
- 脚本在复制证书文件后设置了适当的文件权限，以确保安全性。
- 脚本中的错误检查和日志记录功能可以帮助管理员跟踪和监控命令的执行情况。

### 扩展功能

- 可以在脚本中添加更多的验证逻辑，以确保新证书的有效性和兼容性。
- 可以考虑在重启服务之前添加延迟或检查服务状态的功能，以避免由于立即重启而导致的服务中断。
- 可以将脚本集成到 Hestia 控制面板的图形界面中，方便用户通过图形界面进行 SSL 证书的更新操作。

## v-update-web-domain-stat

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-web-domain-stat)

`v-update-web-domain-stat` 是 Hestia 控制面板提供的 CLI 命令，用于更新特定网站域名的统计信息。该命令通常与 AWStats 工具结合使用，用于生成网站访问统计报告。

### 使用方法

```bash
v-update-web-domain-stat USER DOMAIN
```

其中：
- `USER` 是网站所有者的用户名。
- `DOMAIN` 是要更新统计信息的域名。

### 示例

1. 更新名为 `alice` 的用户下 `example.com` 域名的统计信息：

    ```bash
    v-update-web-domain-stat alice example.com
    ```

### 脚本流程

1. **参数定义**：从命令行接收 `USER` 和 `DOMAIN` 参数，并存储在相应的变量中。

2. **包含文件**：加载 Hestia 控制面板的配置文件和所需的函数库。

3. **参数验证**：检查是否提供了正确的参数数量，并验证 `USER` 和 `DOMAIN` 是否为有效的格式。同时检查 Web 系统是否启用，以及 `USER` 和 `DOMAIN` 是否存在且未被暂停。

4. **获取统计配置**：通过调用 `get_domain_values` 函数，获取指定域名的统计配置信息。

5. **检查配置文件**：检查统计配置文件（如 `awstats.conf`）是否存在。如果不存在，则报告错误并退出。

6. **创建统计目录**：如果统计目录不存在，则创建它。统计目录通常用于存储生成的统计报告和相关文件。

7. **构建 AWStats 报告**：
   - 查找 AWStats 脚本的位置（可能因系统而异）。
   - 设置 AWStats 脚本的选项，如域名、是否更新、输出格式等。
   - 调用 AWStats 脚本生成统计报告，并使用 `sed` 命令替换报告中的域名占位符。
   - 生成的报告保存在统计目录下，并按月份进行组织。
   - 复制必要的图标和模板文件到统计目录。

8. **生成月度索引**：使用预定义的模板和当前月份信息，生成月度统计报告的索引页面。

### 注意事项

- 脚本使用 AWStats 工具生成统计报告，因此确保系统上已安装并正确配置了 AWStats。
- 脚本会尝试在统计目录下创建子目录来组织月度报告，确保脚本有足够的权限来执行这些操作。
- 脚本中的 `sed` 命令用于替换报告中的域名占位符，确保在 AWStats 配置中正确设置了域名占位符。
- 如果统计目录下不存在必要的图标或模板文件，脚本会尝试从 Hestia 控制面板的默认位置复制它们。确保这些文件在指定位置可用。

### 扩展功能

- 可以在脚本中添加更多参数选项，以支持更灵活的统计报告生成和配置。
- 可以考虑集成其他统计工具或分析库，以提供更丰富的统计数据和报告功能。
- 可以将脚本与 Hestia 控制面板的图形界面集成，使用户能够通过图形界面轻松更新和管理统计报告。

## v-update-web-domain-traff

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-web-domain-traff)

`v-update-web-domain-traff` 是 Hestia 控制面板提供的 CLI 命令，用于更新特定网站域名的流量统计信息。该命令通过分析日志文件中的字节数来计算已使用的带宽，并更新数据库中的相应值。

### 使用方法

```bash
v-update-web-domain-traff USER DOMAIN
```

其中：
- `USER` 是网站所有者的用户名。
- `DOMAIN` 是要更新流量统计信息的域名。

### 示例

1. 更新名为 `john` 的用户下 `example.com` 域名的流量统计信息：

    ```bash
    v-update-web-domain-traff john example.com
    ```

### 脚本流程

1. **参数定义**：从命令行接收 `USER` 和 `DOMAIN` 参数，并存储在相应的变量中。

2. **包含文件**：加载 Hestia 控制面板的配置文件和所需的函数库。

3. **参数验证**：检查是否提供了正确的参数数量，并验证 `USER` 和 `DOMAIN` 是否为有效的格式。同时检查 Web 系统是否启用，以及 `USER` 和 `DOMAIN` 是否存在且未被暂停。

4. **读取日志文件**：定位到存储网站流量信息的日志文件（`$log_file`），逐行读取并累加其中的字节数。

5. **计算带宽**：将累加得到的字节数转换为兆字节（MB），并存储在变量 `mb` 中。

6. **重置日志文件**：清空日志文件，以便下次记录新的流量信息。

7. **检查日期**：如果当前日期是每月的第一天（`$(date +%d)` 等于 `'01'`），则将域名的带宽使用量重置为 0。

8. **更新带宽值**：将当前计算得到的带宽值（`mb`）与数据库中存储的已有带宽值（`$U_BANDWIDTH`）相加，得到新的总带宽值，并更新到数据库中。

9. **记录事件**：在日志中记录成功更新带宽的事件。

10. **退出**：脚本执行完成，退出。

### 注意事项

- 脚本依赖于日志文件（`$log_file`）中的格式和内容，确保日志文件是有效的，并且按照预期的方式记录流量信息。
- 脚本使用 `bc` 命令进行数学运算，确保系统上已安装 `bc`。
- 脚本在每月的第一天重置带宽使用量，这是基于日志文件通常每天累积流量的假设。如果实际情况不同，可能需要修改此逻辑。
- 脚本中使用的数据库更新函数（`update_object_value`）是 Hestia 控制面板提供的内部函数，确保这些函数在脚本的上下文中是可用的。

### 扩展功能

- 可以考虑添加参数选项，以支持更细粒度的流量统计和报告，例如按小时、按天统计等。
- 可以将脚本与 Hestia 控制面板的图形界面集成，使用户能够通过图形界面查看和管理流量统计信息。
- 可以考虑添加阈值警报功能，当带宽使用量超过预定阈值时发送通知给管理员或用户。

## v-update-web-domains-disk

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-web-domains-disk)

`v-update-web-domains-disk` 是 Hestia 控制面板提供的 CLI 命令，用于重新计算指定用户下所有网站域名的磁盘使用情况。该命令遍历用户的所有域名，计算每个域名的磁盘空间占用，并更新到数据库中。

### 使用方法

```bash
v-update-web-domains-disk USER
```

其中：
- `USER` 是网站所有者的用户名。

### 示例

1. 更新名为 `alice` 的用户下所有网站域名的磁盘使用情况：

    ```bash
    v-update-web-domains-disk alice
    ```

### 脚本流程

1. **参数定义**：从命令行接收 `USER` 参数，并存储在变量中。

2. **包含文件**：加载 Hestia 控制面板的配置文件和所需的函数库。

3. **参数验证**：检查是否提供了正确的参数数量，并验证 `USER` 是否为有效的格式。同时检查 Web 系统是否启用，以及 `USER` 是否存在。

4. **遍历域名**：通过 `$BIN/v-list-web-domains` 命令获取指定用户下的所有域名列表，并遍历每个域名。

5. **计算磁盘使用情况**：对于每个域名，确定其对应的网站目录（`$home_dir`），使用 `du` 命令计算该目录的磁盘空间占用（以 MB 为单位），并将结果存储在 `disk_usage` 变量中。

6. **更新数据库**：使用 `update_object_value` 函数将计算得到的磁盘空间占用值更新到数据库中对应域名的 `$U_DISK` 字段。

7. **重新计算用户磁盘空间**：在遍历完所有域名后，调用 `recalc_user_disk_usage` 函数重新计算用户的总磁盘空间使用情况。

8. **日志记录**：记录成功更新磁盘使用情况的日志事件。

9. **退出**：脚本执行完成，退出。

### 注意事项

- 脚本使用了 `du` 命令来计算磁盘空间占用，确保该命令在系统上可用，并且具有足够的权限来读取相关目录。
- 脚本通过 `$BIN/v-list-web-domains` 命令获取域名列表，确保该命令在脚本的上下文中是可用的。
- 脚本中使用的数据库更新函数（`update_object_value`）和重新计算用户磁盘空间函数（`recalc_user_disk_usage`）是 Hestia 控制面板提供的内部函数，确保这些函数在脚本的上下文中是可用的。

### 扩展功能

- 可以考虑添加参数选项，以支持对单个域名进行磁盘使用情况的计算和更新。
- 可以将脚本的输出格式化，以更直观地显示每个域名的磁盘空间占用情况。
- 可以添加额外的验证和错误处理逻辑，以提高脚本的健壮性和可维护性。

## v-update-web-domains-stat

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-web-domains-stat)

`v-update-web-domains-stat` 是 Hestia 控制面板提供的 CLI 命令，用于更新指定用户下所有未暂停的 Web 域名的统计信息。该命令会遍历用户拥有的所有域名，并根据配置决定是否执行日志分析来更新域名的统计数据。

### 使用方法

```bash
v-update-web-domains-stat USER
```

其中：
- `USER` 是网站所有者的用户名。

### 示例

1. 更新名为 `admin` 的用户下所有未暂停的 Web 域名的统计信息：

    ```bash
    v-update-web-domains-stat admin
    ```

### 脚本流程

1. **参数定义**：从命令行接收 `USER` 参数，并存储在变量中。

2. **包含文件**：加载 Hestia 控制面板的配置文件和所需的函数库。

3. **参数验证**：
    - 检查是否提供了正确的参数数量。
    - 验证 `USER` 是否为有效的格式。
    - 检查 Web 系统是否启用。
    - 验证 `USER` 是否存在且未暂停。

4. **遍历域名**：
    - 使用 `search_objects` 函数获取所有未暂停的 Web 域名列表。
    - 对于每个域名，使用 `get_domain_values` 函数获取域名的配置值，包括是否启用统计信息 (`STATS`)。
    - 如果 `STATS` 设置为 'yes' 或非 'no'，则调用 `v-update-web-domain-stat` 命令来更新该域名的统计信息。

5. **日志记录**：记录成功更新域名统计信息的日志事件。

6. **退出**：脚本执行完成，退出。

### 注意事项

- 脚本通过 `search_objects` 函数获取域名列表，确保该函数在脚本的上下文中是可用的。
- 脚本中的 `v-update-web-domain-stat` 命令用于更新单个域名的统计信息，确保该命令在系统中是可用的。
- 脚本依赖于 Hestia 控制面板的配置和函数库，确保这些依赖在脚本的上下文中是可用的。

### 扩展功能

- 可以考虑添加参数选项，以支持对单个域名进行统计信息的更新。
- 可以添加额外的验证和错误处理逻辑，以提高脚本的健壮性和可维护性。
- 可以根据用户或域名的配置选项，灵活决定是否更新统计信息。
- 可以考虑将脚本的输出格式化，以更直观地显示统计信息的更新结果。

## v-update-web-domains-traff

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-web-domains-traff)

`v-update-web-domains-traff` 是 Hestia 控制面板提供的 CLI 命令，用于更新指定用户下所有未暂停的 Web 域名的带宽使用统计信息。该命令会遍历用户拥有的所有域名，并读取每个域名的日志文件来计算已使用的带宽，然后更新到相应的配置中。

### 使用方法

```bash
v-update-web-domains-traff USER
```

其中：
- `USER` 是网站所有者的用户名。

### 示例

1. 更新名为 `admin` 的用户下所有未暂停的 Web 域名的带宽使用统计信息：

    ```bash
    v-update-web-domains-traff admin
    ```

### 脚本流程

1. **参数定义**：从命令行接收 `USER` 参数，并存储在变量中。

2. **包含文件**：加载 Hestia 控制面板的配置文件和所需的函数库。

3. **参数验证**：
    - 检查是否提供了正确的参数数量。
    - 验证 `USER` 是否为有效的格式。
    - 检查 Web 系统是否启用。
    - 验证 `USER` 是否存在。

4. **遍历域名**：
    - 使用 `search_objects` 函数获取所有未暂停的 Web 域名列表。
    - 对于每个域名，执行以下操作：
        - 如果当前日期是每月的第一天，则将域名的带宽计数器重置为 0。
        - 读取域名的日志文件，并计算其中的字节数总和。
        - 将字节数转换为兆字节（MB）。
        - 清空日志文件以便下次记录。
        - 获取域名的当前带宽配置值。
        - 将新的带宽使用值（当前配置值加上新计算的 MB 值）更新到配置中。

5. **重新计算用户带宽**：在所有域名带宽更新后，重新计算用户的总带宽使用情况。

6. **退出**：脚本执行完成，退出。

### 注意事项

- 脚本依赖于 Hestia 控制面板的配置和函数库，确保这些依赖在脚本的上下文中是可用的。
- 脚本中的日志文件路径、读取方式以及带宽更新逻辑可能需要根据实际的 Hestia 配置和日志文件格式进行调整。
- 脚本在执行过程中会清空日志文件，确保这是期望的行为。

### 扩展功能

- 可以考虑添加参数选项，以支持对单个域名进行带宽使用统计信息的更新。
- 可以添加额外的验证和错误处理逻辑，以提高脚本的健壮性和可维护性。
- 可以根据用户或域名的配置选项，灵活决定是否重置带宽计数器或更新带宽使用信息。
- 可以考虑将脚本的输出格式化，以更直观地显示带宽使用统计信息的更新结果。

## v-update-web-templates

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-web-templates)

`v-update-web-templates` 是 Hestia 控制面板提供的 CLI 命令，用于更新 Web 域名模板。该命令会复制和更新 Hestia 安装目录和公共模板目录中的 Web 模板到指定的模板目录，并根据需要重启 Web 服务器和代理服务器。

### 使用方法

```bash
v-update-web-templates [RESTART] [SKIP_REBUILD]
```

- `RESTART`（可选）：指定是否重启 Web 服务器和代理服务器。默认为 `no`，即不重启。如果设置为 `yes`，则会在更新模板后重启服务器。
- `SKIP_REBUILD`（可选）：指定是否跳过对所有用户的 Web 域名进行重建。默认为空，即会进行重建。如果设置为任何非空值，则跳过此步骤。

### 示例

1. 更新 Web 模板并重启服务器：

    ```bash
    v-update-web-templates yes
    ```

2. 更新 Web 模板但不重启服务器，同时跳过对所有用户的 Web 域名进行重建：

    ```bash
    v-update-web-templates no skip
    ```

### 脚本流程

1. **参数定义**：从命令行接收 `RESTART` 和 `SKIP_REBUILD` 参数（如果提供）。

2. **包含文件**：加载 Hestia 控制面板的配置文件和所需的函数库。

3. **检查并同步模板**：
    - 如果 `POLICY_SYNC_SKELETON` 不为 `no`，则删除现有的 `skel`、`suspend` 和 `unassigned` 目录，并从公共模板目录中复制相应的目录。
    - 创建或确保 `nginx` 目录存在。
    - 根据代理系统配置或后端是否为 `php-fpm`，从 Hestia 安装目录中的模板复制 `nginx` 目录。
    - 从 Hestia 安装目录中的模板复制其他 Web 模板目录（除了 `nginx` 目录）。
    - 遍历 PHP 版本目录，并为每个启用的 PHP 版本在 `php-fpm` 目录中创建相应的模板文件。

4. **恢复 AWStats 模板**：如果检测到 `awstats.tpl` 文件中有特定的 `LoadPlugin` 行被删除，则将其恢复。

5. **重建 Web 域名**（可选）：如果未设置 `SKIP_REBUILD`，则对所有用户的 Web 域名执行重建操作。

6. **重启 Web 服务器**：根据 `RESTART` 参数的值，决定是否重启 Web 服务器。

7. **重启代理服务器**：根据 `RESTART` 参数的值，决定是否重启代理服务器（例如 Nginx）。

8. **记录日志**：记录系统日志，表示默认 Web 域名模板已更新。

9. **退出**：脚本执行完成，退出。

### 注意事项

- 脚本依赖于 Hestia 控制面板的配置和函数库，确保这些依赖在脚本的上下文中是可用的。
- 脚本会删除并重新创建特定的模板目录，确保这些操作不会影响到其他重要的文件或配置。
- 脚本中的模板路径和复制逻辑可能需要根据实际的 Hestia 安装和配置进行调整。
- 重启服务器和代理服务器的操作可能会影响到正在运行的服务，确保在适当的时间执行此命令。

### 扩展功能

- 可以考虑添加更多的参数选项，以支持更细粒度的模板更新和配置。
- 可以添加更多的错误处理和验证逻辑，以确保脚本的稳定性和健壮性。
- 可以考虑将脚本的输出格式化，以更直观地显示模板更新的进度和结果。

## v-update-white-label-logo

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-white-label-logo)

`v-update-white-label-logo` 是 Hestia 控制面板提供的 CLI 命令，用于更新或恢复白标（White Label）的 Logo 图片和图标。这个命令允许你使用自定义的 Logo 替换 Hestia 控制面板默认的 Logo，或者如果自定义 Logo 不存在，可以选择从远程服务器下载默认的 Logo。

### 使用方法

```bash
v-update-white-label-logo [DOWNLOAD] [RESET]
```

- `DOWNLOAD`（可选）：如果设置为 `yes`，则当自定义 Logo 文件不存在时，将从远程服务器下载默认的 Logo 文件。默认为 `no`。
- `RESET`（可选）：如果设置为 `yes`，则会删除所有自定义的 Logo 文件，并将 Logo 恢复为默认的 Logo。默认为 `no`。

### 示例

1. 更新 Logo，如果自定义 Logo 不存在则下载默认 Logo：

    ```bash
    v-update-white-label-logo yes
    ```

2. 恢复 Logo 到默认状态：

    ```bash
    v-update-white-label-logo no yes
    ```

3. 只更新 Logo，不下载也不重置（如果自定义 Logo 不存在，则不会执行任何操作）：

    ```bash
    v-update-white-label-logo no no
    ```

### 脚本流程

1. **参数定义**：从命令行接收 `DOWNLOAD` 和 `RESET` 参数（如果提供）。

2. **包含文件**：加载 Hestia 控制面板的配置文件和所需的函数库。

3. **重置 Logo**（可选）：如果 `RESET` 参数为 `yes`，则删除 `$HESTIA/web/images/custom/` 目录下的所有文件，以恢复 Logo 到默认状态。

4. **检查并更新 Logo**：
    - 检查 `$HESTIA/web/images/custom/logo.svg` 文件是否存在，如果存在，则将其复制到 `$HESTIA/web/images/logo.svg`。
    - 如果 `$HESTIA/web/images/custom/logo.svg` 不存在且 `DOWNLOAD` 参数为 `yes`，则从远程服务器下载默认的 `logo.svg` 文件。
    - 对于 `logo.png`、`logo-header.svg`、`favicon.png` 和 `favicon.ico` 也执行相同的操作。

5. **脚本结束**：完成 Logo 更新后，脚本退出。

### 注意事项

- 脚本依赖于 Hestia 控制面板的配置和函数库，确保这些依赖在脚本的上下文中是可用的。
- 自定义 Logo 文件应放置在 `$HESTIA/web/images/custom/` 目录下。
- 如果选择从远程服务器下载默认的 Logo 文件，需要确保网络连接是可用的，并且远程服务器上的文件是可访问的。
- 脚本会覆盖现有的 Logo 文件，因此请谨慎操作，确保在更新 Logo 之前备份重要的自定义 Logo 文件。

### 扩展功能

- 可以考虑添加更多的自定义 Logo 选项，例如支持其他格式的 Logo 文件或允许用户指定远程 Logo 文件的 URL。
- 可以添加更多的错误处理和验证逻辑，以确保脚本的稳定性和健壮性。
- 可以考虑将脚本的输出格式化，以更直观地显示 Logo 更新的进度和结果。

## v-update-sys-hestia

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-sys-hestia)

`v-update-sys-hestia` 是 Hestia 控制面板提供的 CLI 命令，用于更新 Hestia 系统软件包及其配置。通过该命令，管理员可以确保 Hestia 及其相关组件（如 Nginx 和 PHP）保持最新状态，并获取最新的安全修复和功能更新。

### 使用方法

```bash
v-update-sys-hestia PACKAGE
```

- `PACKAGE`：要更新的 Hestia 软件包名称，可以是 `hestia`、`hestia-nginx` 或 `hestia-php`。

### 示例

1. 更新 Hestia 核心软件包：

    ```bash
    v-update-sys-hestia hestia
    ```

2. 更新 Hestia 的 Nginx 组件：

    ```bash
    v-update-sys-hestia hestia-nginx
    ```

3. 更新 Hestia 的 PHP 组件：

    ```bash
    v-update-sys-hestia hestia-php
    ```

### 脚本流程

1. **参数验证**：
   - 检查是否提供了正确的参数数量（一个）。
   - 验证提供的软件包名称是否属于有效的 Hestia 软件包列表（`hestia`、`hestia-nginx` 或 `hestia-php`）。
   - 如果系统处于只读模式（如演示模式），则不进行任何更新操作。

2. **更新软件包仓库**：
   - 使用 `apt-get update` 命令更新软件包仓库，指定只更新 Hestia 的软件包仓库列表（`sources.list.d/hestia.list`）。

3. **安装/更新软件包**：
   - 使用 `apt-get install` 命令安装或更新指定的 Hestia 软件包。
   - 捕获安装命令的输出并将其重定向到 `/dev/null` 以隐藏详细信息。
   - 验证软件包安装是否成功，并在失败时记录相应的错误消息。

4. **日志记录**：
   - 将更新操作的结果记录到系统日志中，以便管理员可以查看和跟踪。

### 注意事项

- 确保在运行 `v-update-sys-hestia` 命令之前已经以具有适当权限的用户身份登录。
- 在执行更新操作之前，最好备份重要的配置文件和数据，以防万一出现意外情况。
- 在执行更新之前，确保了解当前系统中安装的 Hestia 软件包的版本，以便在需要时可以回滚到以前的版本。
- 如果系统处于只读模式或演示模式，该命令将不会执行任何更新操作。请确保在系统处于可写模式时执行更新。

### 扩展功能

- 可以考虑添加选项来允许管理员选择是否要自动重启相关服务（如 Nginx 或 PHP-FPM）以应用更新后的配置更改。
- 可以添加选项来显示详细的更新日志或输出，以便管理员可以了解更新过程中的详细信息。
- 可以考虑集成版本检查功能，以便管理员可以检查是否有可用的新版本，并在需要时自动触发更新操作。

## v-update-sys-hestia-all

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-sys-hestia-all)

`v-update-sys-hestia-all` 是 Hestia 控制面板提供的 CLI 命令，用于一键更新所有 Hestia 系统软件包。通过该命令，管理员可以方便地确保 Hestia 及其所有相关组件（如 Nginx 和 PHP）都保持最新状态，从而获取最新的安全修复和功能更新。

### 使用方法

```bash
v-update-sys-hestia-all
```

此命令不接受任何参数，直接执行将更新所有 Hestia 软件包。

### 示例

要更新所有 Hestia 软件包，只需运行以下命令：

```bash
v-update-sys-hestia-all
```

### 脚本流程

1. **环境加载与验证**：
   - 加载 Hestia 的配置文件和函数库。
   - 检查系统是否处于只读模式（如演示模式），如果是，则不进行任何更新操作。

2. **更新循环**：
   - 遍历 Hestia 的主要软件包列表（`hestia`、`hestia-nginx`、`hestia-php`）。
   - 对每个软件包，调用 `v-update-sys-hestia` 命令进行更新。

3. **完成与退出**：
   - 脚本执行完成后退出，无需额外操作。

### 注意事项

- 确保在运行 `v-update-sys-hestia-all` 命令之前已经以具有适当权限的用户身份登录。
- 在执行更新操作之前，最好备份重要的配置文件和数据，以防万一出现意外情况。
- 如果系统处于只读模式或演示模式，该命令将不会执行任何更新操作。请确保在系统处于可写模式时执行更新。

### 扩展功能

- 可以考虑添加选项来允许管理员选择是否要自动重启相关服务（如 Nginx 或 PHP-FPM）以应用更新后的配置更改。
- 可以添加选项来显示详细的更新日志或输出，以便管理员可以了解更新过程中的详细信息。
- 如果更新过程中某个软件包更新失败，可以考虑添加重试逻辑或提供错误处理选项。

### 额外说明

使用 `v-update-sys-hestia-all` 命令可以简化 Hestia 软件包的更新流程，但请确保在更新之前备份重要数据，并在更新后仔细检查系统的运行状态，以确保一切正常。此外，如果更新过程中遇到任何问题，请查阅 Hestia 的官方文档或联系技术支持以获取帮助。

## v-update-sys-hestia-git

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-sys-hestia-git)

`v-update-sys-hestia-git` 是一个用于更新 Hestia 系统组件的 CLI 命令，该命令通过 Git 仓库拉取最新的 Hestia 系统代码，并自动执行必要的更新操作。以下是对该命令的详细解释和使用示例。

### 命令概述

`v-update-sys-hestia-git` 命令通过连接到指定的 Git 仓库，拉取最新的 Hestia 系统代码，并在本地执行更新操作。这包括更新配置文件、系统脚本、服务组件等，以确保 Hestia 系统保持最新状态。

### 使用方法

基本语法：

```bash
v-update-sys-hestia-git [选项]
```

### 选项参数

* `--repo <仓库地址>`: 指定要拉取的 Git 仓库地址。默认为 Hestia 官方仓库。
* `--branch <分支名>`: 指定要拉取的分支。默认为 `master` 分支。
* `--force`: 强制覆盖本地更改，直接拉取最新代码。
* `--verbose`: 显示详细的输出信息。

### 示例

1. **拉取最新代码**

默认情况下，`v-update-sys-hestia-git` 命令会拉取 Hestia 官方仓库的 `master` 分支的最新代码。

```bash
v-update-sys-hestia-git
```

2. **指定仓库和分支**

如果你想要从其他仓库或分支拉取代码，可以使用 `--repo` 和 `--branch` 选项。

```bash
v-update-sys-hestia-git --repo https://github.com/your-repo/hestia.git --branch develop
```

3. **强制覆盖本地更改**

如果你想要忽略本地更改，直接拉取最新代码，可以使用 `--force` 选项。

```bash
v-update-sys-hestia-git --force
```

**注意**：使用 `--force` 选项会覆盖本地所有的更改，请谨慎使用。
4. **显示详细输出信息**

如果你想要查看命令执行过程中的详细输出信息，可以使用 `--verbose` 选项。

```bash
v-update-sys-hestia-git --verbose
```

### 注意事项

* 在执行更新操作之前，请确保你有足够的权限来执行这些操作。
* 如果你在执行命令时遇到了任何问题，请查看详细的输出信息或联系 Hestia 支持团队以获取帮助。
* 在更新系统组件之前，请确保备份了重要的数据和配置文件，以防止意外情况发生。

## v-update-sys-ip

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-sys-ip)

### 概述

`v-update-sys-ip` 是 Hestia 提供的一个 CLI（命令行接口）命令，用于扫描和更新系统配置的 IP 地址，并将它们注册到 Hestia 的内部数据库中。这个命令特别适用于 VPS（虚拟专用服务器），其中 IP 地址由超管理器设置。

### 使用方法

基本使用语法为：

```bash
v-update-sys-ip
```

此命令没有额外的选项或参数。

### 示例

#### 示例 1：基本使用

直接运行命令以更新系统 IP 地址：

```bash
v-update-sys-ip
```

命令执行后，它将扫描系统上的网络接口，找到全局作用域（非回环）的 IPv4 地址，并将它们注册到 Hestia 的内部数据库中。

#### 示例 2：结合其他命令使用

如果你想要在系统 IP 地址更新后执行其他操作（例如，更新防火墙配置），你可以将这个命令与其他脚本或命令结合起来使用。以下是一个示例，展示了如何在更新 IP 地址后更新防火墙配置（假设你有一个 `v-update-firewall` 命令）：

```bash
#!/bin/bash

# 更新系统 IP 地址
v-update-sys-ip

# 检查是否有新的 IP 地址被添加或更改
# 这里可以添加逻辑来确定是否需要更新防火墙配置
# ...

# 如果需要更新防火墙配置，则执行以下命令
# v-update-firewall
```

请注意，上述示例中的 `v-update-firewall` 命令是假设存在的，并非 Hestia 提供的实际命令。你需要根据你的实际环境和需求来编写或调用适当的命令。

### 注意事项

* 在运行此命令之前，请确保你具有足够的权限来执行系统级操作。
* 在执行此命令时，可能会影响到系统的网络配置和安全性。因此，请确保你了解该命令的工作原理和潜在影响。
* 如果你在使用 VPS 或其他托管服务，并且 IP 地址由服务提供商管理，那么在使用此命令之前，请确保你已经与服务提供商协调好 IP 地址的更改。

### 结论

`v-update-sys-ip` 是 Hestia 提供的一个有用的 CLI 命令，用于扫描和更新系统配置的 IP 地址。通过结合其他命令和脚本，你可以实现更复杂的自动化任务，提高系统的可管理性和安全性。

## v-update-host-certificate

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-host-certificate)

### 介绍

`v-update-host-certificate` 是 Hestia 提供的一个命令行工具（CLI），用于更新指定主机上的 SSL/TLS 证书。该命令允许管理员轻松管理和更新其 Hestia 服务器上的证书，以确保网站和服务的安全性。

### 用法


```bash
v-update-host-certificate [选项] 主机名
```
### 选项

* **-h, --help**：显示帮助信息并退出。
* **-c, --cert 路径**：指定新证书的路径（默认为 `/path/to/certificate.crt`）。
* **-k, --key 路径**：指定新证书的私钥路径（默认为 `/path/to/certificate.key`）。
* **-b, --bundle 路径**：指定包含中间证书的证书链文件路径（可选）。
* **-f, --force**：强制更新证书，即使当前证书仍然有效。

### 示例

#### 示例 1：基本用法

更新名为 `example.com` 的主机的证书：

```bash
v-update-host-certificate example.com
```

系统会提示您输入新证书和私钥的路径。

#### 示例 2：指定证书和私钥路径

如果您已经知道了新证书和私钥的路径，可以直接指定它们：

```bash
v-update-host-certificate -c /path/to/new_certificate.crt -k /path/to/new_certificate.key example.com
```

#### 示例 3：包含中间证书的证书链

如果您的证书链包含中间证书，可以指定证书链文件的路径：

```bash
v-update-host-certificate -c /path/to/new_certificate.crt -k /path/to/new_certificate.key -b /path/to/certificate_chain.crt example.com
```

#### 示例 4：强制更新

即使当前证书仍然有效，您也可以强制更新它：

```bash
v-update-host-certificate -f example.com
```

### 注意事项

* 在执行 `v-update-host-certificate` 命令之前，请确保您已经备份了当前的证书和私钥。
* 替换证书后，可能需要重新启动相关的服务或应用程序才能使新证书生效。
* 如果您在更新证书时遇到任何问题，请查阅 Hestia 的官方文档或联系支持团队以获取帮助。

## v-list-sys-languages

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-languages)

### 命令简介

`v-list-sys-languages` 是 Hestia 提供的 CLI（命令行接口）命令之一，用于列出系统上已安装或支持的所有语言。这个命令对于需要管理多语言环境的系统管理员或开发者来说非常有用。

### 命令语法

```bash
v-list-sys-languages [选项]
```

### 选项

**无特定选项**：此命令通常不需要任何选项即可运行。

### 示例

#### 示例 1：直接列出系统支持的语言

```bash
v-list-sys-languages
```

运行上述命令后，可能会看到以下输出（输出内容取决于系统上实际安装或支持的语言）：

```bash
Available system languages:
- en_US (English, United States)
- zh_CN (Chinese, China)
- fr_FR (French, France)
- ...
```

#### 示例 2：结合其他命令使用

假设你想根据系统支持的语言来生成一些配置文件或执行其他操作，你可以将 `v-list-sys-languages` 的输出与其他命令结合起来。以下是一个简单的示例，将系统支持的语言列表保存到一个文本文件中：

```bash
v-list-sys-languages > languages.txt
```

然后，你可以使用文本编辑器或其他工具来查看或处理 `languages.txt` 文件。

### 注意事项

* 确保你已经正确安装了 Hestia，并且 `v-list-sys-languages` 命令在你的系统路径中可用。
* 如果命令无法运行或返回错误，请检查你的 Hestia 安装和配置是否正确。
* 输出内容可能因 Hestia 版本和系统环境的不同而有所差异。

### 结论

`v-list-sys-languages` 是一个实用的 Hestia CLI 命令，可以帮助你快速了解系统上已安装或支持的语言。通过结合其他命令和工具，你可以根据这些信息来执行各种任务，如生成配置文件、设置语言环境等。

## v-list-sys-hestia-autoupdate

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-hestia-autoupdate)

### 命令简介

`v-list-sys-hestia-autoupdate` 是 Hestia 提供的 CLI（命令行接口）命令，用于查询和显示 Hestia 系统自动更新的状态。这个命令允许管理员快速了解系统是否设置了自动更新功能。

### 命令语法

```bash
v-list-sys-hestia-autoupdate [选项]
```

**注意**：此命令没有特定的选项，但可以通过指定不同的格式（如 JSON、Shell、Plain、CSV）来格式化输出。

### 输出格式

- **JSON**：以 JSON 数组的形式返回自动更新状态（`"Enabled"` 或 `"Disabled"`）。
- **Shell**：在 Shell 环境中以易读的格式返回自动更新状态（如 `AUTOUPDATE: Enabled`）。
- **Plain**：仅返回自动更新状态（如 `Enabled`）。
- **CSV**：以 CSV 格式返回自动更新状态（如 `AUTOUPDATE,Enabled`）。

### 示例

#### 示例 1：默认 Shell 格式

```bash
v-list-sys-hestia-autoupdate
```

**输出**（如果自动更新已启用）：

```bash
AUTOUPDATE: Enabled
```

**输出**（如果自动更新已禁用）：

```bash
AUTOUPDATE: Disabled
```

#### 示例 2：JSON 格式

```bash
v-list-sys-hestia-autoupdate json
```

**输出**（如果自动更新已启用）：

```json
[
    "Enabled"
]
```

**输出**（如果自动更新已禁用）：

```json
[
    "Disabled"
]
```

#### 示例 3：Plain 格式

```bash
v-list-sys-hestia-autoupdate plain
```

**输出**（如果自动更新已启用）：

```bash
Enabled
```

**输出**（如果自动更新已禁用）：

```bash
Disabled
```

#### 示例 4：CSV 格式

```bash
v-list-sys-hestia-autoupdate csv
```

**输出**（如果自动更新已启用）：

```bash
AUTOUPDATE,Enabled
```

**输出**（如果自动更新已禁用）：

```bash
AUTOUPDATE,Disabled
```

### 注意事项

- 此命令依赖于 Hestia 系统的配置和安装，确保你正在使用正确的 Hestia 版本。
- 如果命令没有按预期工作，请检查 Hestia 的配置文件和权限设置。
- 自动更新功能可能会受到系统策略、网络设置或其他因素的影响，确保你的环境支持自动更新。

### 结论

`v-list-sys-hestia-autoupdate` 命令是一个方便的工具，用于查询 Hestia 系统自动更新的状态。通过选择适当的输出格式，你可以轻松地将这些信息集成到你的管理脚本或工作流程中。

## v-list-sys-hestia-updates

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-hestia-updates)

`v-list-sys-hestia-updates` 是 Hestia 提供的 CLI 命令之一，用于列出系统上已安装的 Hestia 及其相关组件的版本、架构、更新时间等信息。这个命令在管理和维护 Hestia 部署时非常有用，因为它可以快速给出关于已安装软件包的状态。

### 使用方法

要运行 `v-list-sys-hestia-updates` 命令，您首先需要确保您已经登录到安装了 Hestia 的系统，并且具有足够的权限来执行此命令。

通常，您可以通过在终端或命令行界面中输入以下命令来执行它：

```bash
v-list-sys-hestia-updates
```

然而，请注意，`v-list-sys-hestia-updates` 可能不是 Hestia CLI 的直接命令，而是一个假设的命令，用于演示基于提供的脚本材料文本可能实现的类似功能。实际上，您可能需要使用脚本或命令的组合来达到类似的效果。

### 脚本逻辑

基于提供的材料文本，我们可以看到脚本中包含了处理 Debian 和 Red Hat 系列系统（如 CentOS）上已安装软件包信息的函数。这些函数（如 `check_installed_deb` 和 `check_installed_rpm`）通过调用系统命令（如 `dpkg-query` 和 `rpm -qi`）来收集关于软件包的信息，并使用文本处理和切割技术提取所需的字段。

然后，脚本可能包含将收集到的信息格式化为 JSON 或纯文本列表的函数（如 `json_list` 和 `shell_list`）。这些函数可能会根据需要被调用，以便以用户友好的方式显示信息。

### 示例输出

**JSON 格式输出示例：**

```json
{
  "hestia": {
    "VERSION": "1.2.3",
    "ARCH": "amd64",
    "UPDATED": "2023-04-01",
    "DESCR": "Hestia Control Panel",
    "TIME": "12:00:00",
    "DATE": "2023-04-01"
  },
  "hestia-nginx": {
    "VERSION": "1.18.0",
    "ARCH": "amd64",
    "UPDATED": "2023-03-15",
    "DESCR": "Nginx for Hestia",
    "TIME": "10:30:00",
    "DATE": "2023-03-15"
  },
  "hestia-php": {
    "VERSION": "7.4.27",
    "ARCH": "amd64",
    "UPDATED": "2023-02-28",
    "DESCR": "PHP for Hestia",
    "TIME": "09:00:00",
    "DATE": "2023-02-28"
  }
}
```

**纯文本列表输出示例：**

```bash
PKG           VER     ARCH    UPDT    DATE
---           ---     ----    ----    ----
hestia        1.2.3   amd64   2023-04-01  2023-04-01
hestia-nginx  1.18.0  amd64   2023-03-15  2023-03-15
hestia-php    7.4.27  amd64   2023-02-28  2023-02-28
```

### 注意事项

- 请注意，上述示例输出仅用于演示目的，并不反映真实的软件包版本或日期。
- 在实际使用时，您可能需要根据您的 Hestia 部署和系统环境进行适当的修改和调整。
- 如果您发现 `v-list-sys-hestia-updates` 不是 Hestia CLI 的有效命令，您可能需要使用其他命令或脚本组合来达到类似的效果。
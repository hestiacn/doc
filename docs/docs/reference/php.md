# PHP系列命令介绍

## v-add-web-php

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-web-php)

### 简介

`v-add-web-php` 命令用于在 Hestia 控制面板环境中为指定版本安装 PHP-FPM。PHP-FPM（FastCGI Process Manager）是一个常用的 FastCGI 进程管理器，用于管理 PHP 进程。该命令允许用户轻松地为他们的 web 应用程序添加和管理不同的 PHP 版本。

### 用法

#### 命令格式

```bash
v-add-web-php VERSION
```

其中 `VERSION` 是你想要安装的 PHP 版本的标识符，例如 `7.4` 或 `8.0`。

#### 示例

#### 示例 1: 安装 PHP 8.0

```bash
v-add-web-php 8.0
```

#### 示例 2: 安装 PHP 7.4

```bash
v-add-web-php 7.4
```

### 注意事项

- 在使用 `v-add-web-php` 命令之前，请确保你已经正确配置了 Hestia 控制面板，并具备执行该命令的权限。
- 该命令会检查 PHP 版本是否已经存在，如果已经安装，则不允许重复安装。
- 该命令还会检查指定的 PHP 版本是否受支持，如果不支持或不存在，则会报错。
- 如果你的系统处于只读模式（例如演示模式），则该命令将无法执行安装操作。

### 验证 PHP-FPM 安装

安装完成后，你可以通过检查 `/etc/init.d/` 目录下是否存在相应的 PHP-FPM 启动脚本（如 `php8.0-fpm`）来验证 PHP-FPM 是否已正确安装。

### 配置 PHP-FPM

安装完成后，你可能还需要配置 PHP-FPM 以满足你的应用程序需求。这包括但不限于设置监听端口、调整进程池设置等。你可以通过编辑 PHP-FPM 的配置文件（通常位于 `/etc/php/VERSION/fpm/php.ini` 和 `/etc/php/VERSION/fpm/pool.d/www.conf`）来完成这些配置。

### 卸载 PHP-FPM

如果你需要卸载某个版本的 PHP-FPM，通常可以通过 Hestia 控制面板提供的相应命令或手动删除相关文件来完成。但是，请注意，在卸载之前请确保没有其他服务或应用程序依赖于该版本的 PHP-FPM。

### 总结

`v-add-web-php` 命令为 Hestia 控制面板用户提供了一个方便的方式来安装和管理不同版本的 PHP-FPM。通过遵循本指南中的步骤和示例，你可以轻松地为你的 web 应用程序添加所需的 PHP 版本，并进行必要的配置。

## v-delete-web-php

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-web-php)

### 简介

`v-delete-web-php` 是 Hestia 提供的一个命令行工具，用于删除指定版本的 PHP-FPM（FastCGI Process Manager）服务，前提是该版本没有被任何域名使用。这个命令在服务器管理中非常有用，特别是当你需要升级或精简 PHP 版本时。

### 使用语法

```bash
v-delete-web-php <VERSION>
```

* `<VERSION>`：要删除的 PHP 版本号，格式为 `X.Y`，其中 `X` 和 `Y` 是数字。

### 选项与参数

* **无选项**：此命令不接受任何额外的选项。
* **参数**：
  - `<VERSION>`：必需参数，指定要删除的 PHP 版本。

### 示例

#### 示例 1：删除 PHP 7.3 版本

假设你想要删除服务器上不再使用的 PHP 7.3 版本，你可以使用以下命令：

```bash
v-delete-web-php 7.3
```

如果 PHP 7.3 没有被任何网站使用，这个命令将成功执行，并且删除该版本的 PHP-FPM。

#### 示例 2：错误的版本格式

如果你尝试使用一个不符合格式的版本号，命令将会报错：

```bash
v-delete-web-php 7.3.a
```

这将会输出一个错误消息，指出 PHP 版本格式无效，应该像 `X.Y` 这样。

#### 示例 3：版本未安装

如果你尝试删除一个并未安装在服务器上的 PHP 版本，命令也会报错：

```bash
v-delete-web-php 8.9
```

如果 PHP 8.9 没有被安装，命令将输出一个错误消息，告诉你指定的 PHP 版本没有安装。

### 注意事项

* 在执行此命令之前，请确保你了解该命令的影响，并确认要删除的 PHP 版本没有被任何网站使用。
* 如果 PHP 版本正在被使用，该命令将会失败，并给出相应的错误消息。
* 在执行此命令之前，最好先备份相关配置和数据，以防意外情况发生。

通过 `v-delete-web-php` 命令，你可以轻松管理服务器上的 PHP 版本，确保系统的安全性和稳定性。

## v-change-sys-php

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-sys-php)

### 简介

`v-change-sys-php` 是 Hestia 控制面板提供的命令行工具之一，用于在系统范围内更改默认的 PHP 版本。此命令允许用户轻松地将服务器的 PHP 环境切换到已安装的指定版本。

### 语法

```bash
v-change-sys-php [VERSION]
```

* `[VERSION]`：要设置为默认版本的 PHP 版本号（例如：`7.4` 或 `8.0`）。

### 示例

#### 示例 1：设置默认 PHP 版本为 7.4

```bash
v-change-sys-php 7.4
```

执行上述命令后，系统将把默认的 PHP 版本更改为 7.4。如果 7.4 版本已安装并可用，该命令将成功执行；否则，将显示错误消息。

#### 示例 2：设置默认 PHP 版本为 8.0 并验证更改

```bash
# 设置默认 PHP 版本为 8.0
v-change-sys-php 8.0

# 验证 PHP 版本是否已更改
php -v
```

执行第一个命令后，系统将尝试将默认 PHP 版本更改为 8.0。然后，通过执行 `php -v` 命令，您可以验证 PHP 版本是否已成功更改。

### 注意事项

* 在执行 `v-change-sys-php` 命令之前，请确保您具有足够的权限（例如：root 用户或具有相应权限的用户）。
* 确保要设置的 PHP 版本已安装在服务器上，并且可用。否则，命令将失败并显示错误消息。
* 在更改 PHP 版本之前，请确保您的网站或应用程序与新版本的 PHP 兼容。某些 PHP 版本可能包含破坏性更改，这可能会影响您的网站或应用程序的功能。

### 常见错误

* 如果指定的 PHP 版本不存在或未安装，您将收到一个错误消息，指出指定的 PHP 版本无效或未安装。
* 如果您没有足够的权限来执行此命令，您可能会收到一个权限错误消息。

### 结论

`v-change-sys-php` 命令是 Hestia 控制面板提供的强大工具之一，允许用户轻松地在系统范围内更改默认的 PHP 版本。通过遵循本文档中的示例和注意事项，您可以成功地更改 PHP 版本并确保您的网站或应用程序与新的 PHP 版本兼容。

## v-change-user-php-cli

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-user-php-cli)

### 概述

`v-change-user-php-cli` 是一个在 Hestia 系统中提供的命令行接口（CLI）命令，用于修改指定用户的默认 PHP 命令行接口（CLI）版本。当系统中安装了多个 PHP 版本时，此命令允许管理员或用户轻松地在不同版本之间切换。

### 语法

```bash
v-change-user-php-cli [USER] [VERSION]
```

- `[USER]`：要修改默认 PHP CLI 版本的用户名。
- `[VERSION]`：要设置为默认的 PHP CLI 版本号（如 7.4）。

### 示例

#### 示例 1：为用户 `john` 设置默认 PHP CLI 版本为 7.4

```bash
v-change-user-php-cli john 7.4
```

执行此命令后，用户 `john` 的默认 PHP CLI 版本将被设置为 7.4。此后，当 `john` 在命令行中输入 `php` 命令时，将使用 PHP 7.4 版本的解释器。

#### 示例 2：查看当前用户的默认 PHP CLI 版本

虽然 `v-change-user-php-cli` 命令本身不直接提供查看默认版本的功能，但你可以通过其他方法（如检查 `.bash_aliases` 文件或执行 `php -v` 命令）来确认当前用户的默认 PHP CLI 版本。

#### 示例 3：为多个用户设置默认 PHP CLI 版本

你可以为系统中的多个用户分别设置不同的默认 PHP CLI 版本。例如，为 `jane` 设置 7.3 版本，为 `mike` 设置 7.2 版本：

```bash
v-change-user-php-cli jane 7.3
v-change-user-php-cli mike 7.2
```

### 注意事项

- 在执行此命令之前，请确保指定的 PHP 版本在系统上已正确安装并可用。
- 如果指定的用户不存在或指定的 PHP 版本不受支持，命令将失败并显示相应的错误消息。
- 修改默认 PHP CLI 版本可能需要用户重新登录或重新加载其 shell 配置文件（如 `.bash_aliases`）才能生效。

### 日志记录

`v-change-user-php-cli` 命令的执行将被记录在 Hestia 系统的日志中。你可以使用其他 Hestia CLI 命令或查看日志文件来跟踪和监控这些更改。

### 总结

`v-change-user-php-cli` 命令是一个强大的工具，允许你轻松地在 Hestia 系统中管理用户的默认 PHP CLI 版本。通过为不同用户设置不同的 PHP 版本，你可以确保每个用户都使用最适合其应用程序或项目的 PHP 环境。

## v-list-sys-php

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-php)

### 概述

`v-list-sys-php` 是 Hestia 提供的一个命令行接口（CLI）命令，用于列出系统上已安装的 PHP 版本。该命令可以检查 `/etc/php/` 目录下是否存在对应的 PHP 版本文件夹，并进一步确认是否包含 `fpm`（FastCGI Process Manager）或 `cli`（Command Line Interface）子目录。

### 使用方法

`v-list-sys-php` 命令可以接受一个可选参数 `[FORMAT]`，用于指定输出格式。默认情况下，如果不提供任何参数，将使用默认的 shell 格式进行输出。

### 示例

#### 示例 1：默认格式输出

执行以下命令，将列出系统上已安装的 PHP 版本，并使用默认的 shell 格式进行输出：

```bash
v-list-sys-php
```

输出可能类似于：

```bash
Available PHP versions:
- 7.2
- 7.3
- 7.4
```

#### 示例 2：JSON 格式输出

要以 JSON 格式输出已安装的 PHP 版本，可以指定 `json` 作为参数：

```bash
v-list-sys-php json
```

输出可能类似于：

```json
[
  "7.2",
  "7.3",
  "7.4"
]
```

#### 示例 3：CSV 格式输出

要以 CSV 格式输出已安装的 PHP 版本，可以指定 `csv` 作为参数：

```bash
v-list-sys-php csv
```

输出可能类似于：

```csv
VERSION
7.2
7.3
7.4
```

#### 示例 4：PLAIN 格式输出

要以 PLAIN 格式输出已安装的 PHP 版本（即每个版本占一行，没有任何额外信息），可以指定 `plain` 作为参数：

```bash
v-list-sys-php plain
```

输出可能类似于：

```bash
7.2
7.3
7.4
```

### 注意事项

* 该命令依赖于系统上已安装的 PHP 版本和相关的配置文件。如果 `/etc/php/` 目录下不存在任何 PHP 版本文件夹，或者文件夹内不包含 `fpm` 或 `cli` 子目录，则该命令可能无法正确列出所有已安装的 PHP 版本。
* 输出的 PHP 版本可能因系统配置和已安装的 PHP 版本而异。请确保您已经正确安装了所需的 PHP 版本，并且相关的配置文件已正确设置。

## v-list-sys-php-config

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-php-config)

### 概述

`v-list-sys-php-config` 是一个在 Hestia 控制面板环境中使用的 CLI 命令，用于列出 PHP 的配置参数。通过此命令，用户可以查看当前系统上 PHP 的配置详情，以便进行必要的配置调整或问题诊断。

### 使用方法

#### 基本语法

```bash
v-list-sys-php-config [FORMAT]
```

* `FORMAT`: 可选参数，指定输出格式。如果不指定，则默认为 `shell` 格式。支持的格式包括 `shell`、`json`、`plain` 和 `csv`。

#### 示例

1. **默认输出（shell 格式）**

```bash
v-list-sys-php-config
```

这将以 shell 格式输出 PHP 的配置参数。

2. **JSON 格式输出**

```bash
v-list-sys-php-config json
```

这将以 JSON 格式输出 PHP 的配置参数，方便机器解析和处理。

3. **Plain 格式输出**

```bash
v-list-sys-php-config plain
```

这将以纯文本格式输出 PHP 的配置参数，不包含任何格式标记。

4. **CSV 格式输出**

```bash
v-list-sys-php-config csv
```

这将以 CSV 格式输出 PHP 的配置参数，每行一个参数，方便导入到电子表格或其他数据处理工具中。

### 输出内容

根据指定的格式，`v-list-sys-php-config` 命令将输出以下内容：

* **memory_limit**: PHP 脚本可以使用的最大内存量。
* **max_execution_time**: PHP 脚本的最大执行时间（秒）。
* **max_input_time**: 脚本解析输入数据（如 POST 和 GET 数据）的最大时间（秒）。
* **upload_max_filesize**: 允许上传文件的最大大小。
* **post_max_size**: 通过 POST 方法发送的数据的最大允许大小。
* **display_errors**: 是否在屏幕上显示 PHP 错误。
* **error_reporting**: 报告的错误级别。
* **config_path**: PHP 配置文件（php.ini）的路径。

注意：实际输出的配置参数可能因 PHP 版本和 Hestia 控制面板的配置而有所不同。

### 注意事项

* 在使用此命令之前，请确保您已正确安装和配置了 Hestia 控制面板。
* 如果您在使用命令时遇到任何问题或错误，请检查您的 Hestia 控制面板文档或联系技术支持以获取帮助。

### 结论

`v-list-sys-php-config` 命令是一个强大的工具，用于查看和管理 PHP 配置参数。通过选择适当的输出格式，您可以轻松地将配置参数集成到您的工作流程中，并进行必要的配置调整或问题诊断。

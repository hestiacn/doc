# 用户管理系列命令介绍

## 更改系列命令

## v-rebuild-all

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-rebuild-all)

### 介绍

`v-rebuild-all` 是 Hestia 提供的 CLI（命令行接口）命令之一，用于重建指定用户的所有资产。这些资产包括但不限于：Web 域名、DNS 区域、邮件域名、数据库、Cron 任务以及用户账户配置。本文档将详细介绍 `v-rebuild-all` 命令的使用方法和示例。

### 使用方法

#### 语法

```bash
v-rebuild-all [USER] [RESTART]
```

- `[USER]`：必需参数，指定要重建资产的用户名。
- `[RESTART]`：可选参数，如果提供此参数，则在重建完成后将重新启动相关服务。

#### 示例

1. **重建用户 "john_doe" 的所有资产**：

```bash
v-rebuild-all john_doe
```

运行此命令后，Hestia 将重建 "john_doe" 用户的所有资产，但不会自动重启相关服务。

2. **重建用户 "jane_smith" 的所有资产并重启服务**：

```bash
v-rebuild-all jane_smith RESTART
```

运行此命令后，Hestia 将重建 "jane_smith" 用户的所有资产，并在完成后重启相关服务。

### 注意事项

* 在执行 `v-rebuild-all` 命令之前，请确保您已登录到具有足够权限的用户账户。
* 在生产环境中执行此命令时，请确保了解可能的影响，并在必要时进行备份。
* 如果您的系统处于只读模式或演示模式，该命令可能无法正常工作。在执行命令之前，请检查系统的当前状态。

### 结论

`v-rebuild-all` 命令是 Hestia 中一个非常有用的工具，它允许管理员轻松地重建指定用户的所有资产。通过结合示例和注意事项，您可以更好地了解如何使用此命令，并在需要时采取适当的行动。

## v-acknowledge-user-notification

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-acknowledge-user-notification)

### 简介

`v-acknowledge-user-notification` 是 Hestia 提供的 CLI (命令行接口) 命令之一，用于更新用户通知的确认状态。该命令允许用户确认或标记特定通知为已读，以便于在后续操作中忽略或隐藏这些通知。

### 语法

```bash
v-acknowledge-user-notification USER ID
```

- `USER`: 用户名或用户标识，用于指定要操作的用户。
- `ID`: 通知的唯一标识符，用于指定要确认的通知。如果要确认所有通知，可以使用 `all` 作为 ID。

### 示例

#### 示例 1: 确认单个用户通知

假设有一个用户名为 `john_doe`，并且该用户收到了一个通知，其 ID 为 `123`。要确认这个通知，可以使用以下命令：

```bash
v-acknowledge-user-notification john_doe 123
```

执行此命令后，系统将更新通知的确认状态，并将该通知标记为已读。

#### 示例 2: 确认所有用户通知

如果希望确认用户 `john_doe` 的所有通知，可以使用 `all` 作为 ID：

```bash
v-acknowledge-user-notification john_doe all
```

这将遍历并确认该用户的所有通知。

### 注意事项

- 在执行此命令之前，请确保您已经登录到 Hestia 系统，并具有相应的权限来修改用户通知。
- 如果提供的用户或 ID 不存在，命令可能会失败并显示错误消息。
- 某些情况下，即使执行了此命令，通知可能仍会在某些界面上短暂显示，直到系统刷新或重新加载。

### 返回值与错误处理

- 如果命令成功执行，它将返回一个确认消息或状态代码，指示通知已成功确认。
- 如果出现错误（例如，用户或 ID 不存在），命令将返回一个错误消息，并可能包括一个错误代码，以帮助您诊断和解决问题。

### 使用场景

- 自动化脚本：在自动化脚本中，可以使用此命令来确认在特定操作或事件后生成的通知，以减少手动干预的需要。
- 用户支持：当用户报告已接收但不需要进一步关注的通知时，支持团队可以使用此命令来确认这些通知，从而提高工作效率和用户体验。

## v-add-fs-file

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-fs-file)

### 简介

`v-add-fs-file` 是 Hestia 提供的 CLI（命令行界面）命令之一，用于在文件系统中创建新的文件。本文档将详细介绍该命令的使用方法、参数说明以及示例。

### 命令概述

`v-add-fs-file` 命令允许用户通过命令行在指定的用户目录下或临时目录下创建新的文件。这为用户提供了快速、便捷的文件创建方式，无需手动打开文件管理器或文本编辑器。

### 命令语法

```bash
v-add-fs-file USER FILE
```

* `USER`：必需参数，指定要在其目录下创建文件的用户名。
* `FILE`：必需参数，指定要创建的文件名（包括路径，如果需要在特定目录下创建文件）。

### 参数说明

* `USER`：用户名，必须是系统中已存在的用户。命令将在该用户的家目录或指定目录下创建文件。
* `FILE`：文件名（包括路径），可以是相对路径或绝对路径。如果路径不存在，命令将尝试创建它。如果文件已存在，命令将不会覆盖现有文件。

### 示例

#### 示例 1：在用户家目录下创建文件

假设我们要在用户 `admin` 的家目录下创建一个名为 `readme.md` 的 Markdown 文件，可以执行以下命令：

```bash
v-add-fs-file admin readme.md
```

执行成功后，将在 `/home/admin/`（或相应的用户家目录）下创建一个名为 `readme.md` 的空文件。

#### 示例 2：在指定目录下创建文件

如果我们想在 `/tmp` 目录下创建一个名为 `temp.txt` 的文本文件，可以执行以下命令：

```bash
v-add-fs-file admin /tmp/temp.txt
```

请注意，尽管我们指定了 `admin` 作为用户，但由于我们提供了绝对路径 `/tmp/temp.txt`，因此文件将在 `/tmp` 目录下创建，而不是在 `admin` 的家目录下。

#### 示例 3：创建带有路径的文件

假设我们想在用户 `john` 的家目录下的 `documents` 子目录中创建一个名为 `notes.md` 的 Markdown 文件，可以执行以下命令：

```bash
v-add-fs-file john documents/notes.md
```

执行成功后，将在 `/home/john/documents/`（或相应的用户家目录的 `documents` 子目录）下创建一个名为 `notes.md` 的空文件。

### 注意事项

* 请确保指定的用户名在系统中存在，否则命令将失败。
* 如果提供的文件路径中的某些目录不存在，命令将尝试创建它们（但仅限于用户家目录或 `/tmp` 目录下的子目录）。
* 如果文件已存在，命令将不会覆盖现有文件。如果需要覆盖现有文件，请使用其他方法（如 `echo` 命令配合重定向）来实现。

## v-add-user-composer

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-user-composer)

### 概述

`v-add-user-composer` 是一个用于在 Hestia 环境中为用户添加 Composer（PHP 依赖管理工具）支持的 CLI 命令。此命令允许系统管理员或具有适当权限的用户为用户安装和配置 Composer，以便他们可以轻松地管理 PHP 项目的依赖项。

### 用法

```bash
v-add-user-composer USER [VERSION] [UPDATE]
```

- `USER`: 要为其安装 Composer 的用户名（必填）。
- `VERSION`: Composer 的版本号（可选，默认为 2）。
- `UPDATE`: 如果已存在 Composer，是否执行更新（可选，默认为不执行更新）。

### 示例

#### 示例 1: 为用户 "john" 安装 Composer

```bash
v-add-user-composer john
```

这将在用户 "john" 的主目录下安装 Composer 的默认版本（通常是最新版本或指定的默认版本）。

#### 示例 2: 为用户 "jane" 安装特定版本的 Composer

```bash
v-add-user-composer jane 1.10.1
```

这将在用户 "jane" 的主目录下安装 Composer 的 1.10.1 版本。

#### 示例 3: 更新已存在的 Composer

如果 Composer 已经安装在用户 "alice" 的主目录下，并且您希望更新到最新版本，可以使用以下命令：

```bash
v-add-user-composer alice [不指定版本号] true
```

请注意，在上面的命令中，我们省略了版本号，并将 `UPDATE` 参数设置为 `true`，以指示命令更新已存在的 Composer 安装。

### 注意事项

- 该命令将 Composer 安装在用户的主目录下的 `.composer` 文件夹中。
- 如果 Composer 已经安装并且指定了 `UPDATE` 参数为 `true`，则命令将尝试执行 `composer self-update` 来更新 Composer。
- 如果指定的路径不在用户的主目录下，命令将返回错误并退出。
- 如果在只读模式下运行 Hestia，则命令将不会执行任何操作。

### 链接

- 官方网站:[Composer](https://getcomposer.org)

### 反馈与支持

如果您在使用 `v-add-user-composer` 命令时遇到任何问题或需要进一步的帮助，请通过 Hestia 的官方支持渠道或社区论坛寻求帮助。

## v-add-user-notification

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-user-notification)

### 概述

`v-add-user-notification` 是 Hestia 提供的一个命令行接口（CLI）命令，用于向特定用户添加通知。此命令允许管理员或具有适当权限的用户向面板中的用户发送自定义通知，以提醒用户关于重要更新、服务更改、维护计划等。

### 语法

```bash
v-add-user-notification USER TOPIC NOTICE [TYPE] [PRIORITY]
```

- `USER`: 需要接收通知的用户的用户名。
- `TOPIC`: 通知的主题，例如 "Maintenance Schedule"、"New Feature Update" 等。
- `NOTICE`: 通知的具体内容，可以包含任何必要的详细信息。
- `TYPE` (可选): 通知的类型，可以是 "info"、"warning"、"error" 等，用于在面板中区分通知的优先级。
- `PRIORITY` (可选): 通知的优先级，通常与类型相关，但允许进一步的自定义。

### 示例

#### 示例 1: 添加基本通知

```bash
v-add-user-notification johndoe Maintenance Scheduled "Server maintenance is scheduled for tomorrow at 2 PM."
```

这个命令将向用户 "johndoe" 发送一个关于服务器维护计划的通知，通知的主题为 "Maintenance Scheduled"，内容为 "Server maintenance is scheduled for tomorrow at 2 PM."。

#### 示例 2: 添加带有类型和优先级的通知

```bash
v-add-user-notification admin NewFeature "New feature 'X' is now available." info high
```

这个命令将向用户 "admin" 发送一个关于新功能 "X" 现已可用的通知。通知的类型被设置为 "info"，表示这是一个信息性通知，而优先级被设置为 "high"，表示这是一个高优先级的通知。

#### 示例 3: 批量添加通知

在某些情况下，您可能希望向多个用户发送相同的通知。虽然 `v-add-user-notification` 命令本身不支持直接批量操作，但您可以使用 shell 脚本和循环来实现这一目的。

例如，假设您有一个包含用户名的文本文件 `users.txt`，并且您想向这些用户发送相同的通知，您可以这样做：

```bash
#!/bin/bash

# 读取 users.txt 文件中的每个用户名
while IFS= read -r user; do
    v-add-user-notification "$user" ServerUpdate "The server has been updated to version 2.0."
done < "users.txt"
```

这个脚本将读取 `users.txt` 文件中的每个用户名，并向每个用户发送一个关于服务器已更新到版本 2.0 的通知。

### 注意事项

- 在使用此命令之前，请确保您已正确安装并配置了 Hestia。
- 确保您具有足够的权限来执行此命令。
- 如果指定了可选的 `TYPE` 或 `PRIORITY` 参数，请确保它们的值符合 Hestia 的要求。
- 如果通知内容包含特殊字符或引号，请确保使用适当的转义字符来避免解析错误。

## v-add-user-package

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-user-package)

### 概述

`v-add-user-package` 是 Hestia 控制面板提供的一个命令行接口（CLI）工具，用于在 Hestia 系统上添加新的用户包。这个命令允许系统管理员或者具备适当权限的用户，通过命令行的方式快速、灵活地创建和管理用户包。

### 语法

```bash
v-add-user-package [options] package_name [rewrite]
```

* `options`：可选参数，用于指定额外的配置或行为。
* `package_name`：必需参数，指定要添加的用户包的名称。
* `rewrite`：可选参数，如果设置为 'yes'，则更新现有用户包的限制。默认为 'no'。

### 示例

#### 示例 1：添加新用户包

```bash
v-add-user-package mypackage
```

这个命令将在 Hestia 系统上创建一个名为 `mypackage` 的新用户包。如果系统已经存在同名的用户包，并且没有指定 `rewrite` 参数，该命令将失败并显示错误信息。

#### 示例 2：更新用户包限制

```bash
v-add-user-package mypackage yes
```

这个命令将更新名为 `mypackage` 的用户包的限制。请注意，在调用此命令之前，你可能需要使用其他命令或方法来指定新的限制。`v-add-user-package` 命令本身不直接提供设置限制的功能，但它允许你通过重写现有用户包的方式来应用新的限制。

#### 示例 3：使用选项（假设存在）

假设 `v-add-user-package` 命令支持一个 `--disk-quota` 选项来指定用户包的磁盘配额，你可以这样使用它：

```bash
v-add-user-package --disk-quota 10G mypackage
```

这个命令将创建一个名为 `mypackage` 的新用户包，并为其设置 10GB 的磁盘配额。请注意，这里假设 `--disk-quota` 是一个有效的选项，并且其具体行为可能因 Hestia 的版本和配置而异。

### 注意事项

* 在使用 `v-add-user-package` 命令之前，请确保你具有适当的权限。通常，只有系统管理员或具有类似权限的用户才能执行此命令。
* 在添加或更新用户包之前，请确保你了解要设置的限制和选项，以避免意外地影响系统的稳定性和安全性。
* 如果你在使用 `v-add-user-package` 命令时遇到问题，请查阅 Hestia 的官方文档或寻求社区支持。

## v-change-user-config-value

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-user-config-value)

### 简介

`v-change-user-config-value` 是 Hestia 系统中提供的一个命令行接口（CLI）命令，用于更改指定用户的配置键值对。通过此命令，管理员可以方便地为用户定制或修改配置信息。

### 命令格式

```bash
v-change-user-config-value USER KEY VALUE
```

- `USER`：需要更改配置的用户名。
- `KEY`：需要更改的配置项的键名。
- `VALUE`：需要设置的新值。

### 示例

#### 示例 1：更改用户角色

假设需要将用户 `admin` 的角色更改为 `admin`，可以使用以下命令：

```bash
v-change-user-config-value admin ROLE admin
```

#### 示例 2：更改用户邮箱

如果需要为用户 `user1` 更改邮箱为 `user1@example.com`，可以使用以下命令：

```bash
v-change-user-config-value user1 EMAIL user1@example.com
```

#### 示例 3：启用/禁用用户功能

Hestia 系统可能允许通过特定的配置键来启用或禁用用户的某些功能。例如，假设有一个名为 `ENABLE_FEATURE_X` 的键，用于控制功能 X 的启用状态，可以使用以下命令来启用或禁用它：

启用功能 X：

```bash
v-change-user-config-value user1 ENABLE_FEATURE_X true
```

禁用功能 X：

```bash
v-change-user-config-value user1 ENABLE_FEATURE_X false
```

### 注意事项

- 在使用此命令之前，请确保您有足够的权限来更改用户配置。
- 请确保提供的用户名、键名和值都是正确的，并且符合 Hestia 系统的要求。
- 更改配置后，可能需要重新启动相关服务或重新加载配置才能使更改生效。
- 如果在更改配置时遇到任何问题，请查阅 Hestia 的官方文档或联系技术支持以获取帮助。

## v-change-user-contact

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-user-contact)

### 命令概述

`v-change-user-contact` 是 Hestia 提供的 CLI 命令，用于更改与特定用户关联的电子邮件地址。通过此命令，系统管理员可以轻松地更新用户的联系信息，确保通知和通信能够准确送达。

### 语法

```bash
v-change-user-contact [用户名] [新电子邮件地址]
```

### 参数

* **用户名**：要更改电子邮件地址的用户的用户名。
* **新电子邮件地址**：用户的新电子邮件地址。

### 示例

#### 示例 1: 更改 admin 用户的电子邮件地址

```bash
v-change-user-contact admin admin@example.com
```

此命令将把用户 `admin` 的电子邮件地址更改为 `admin@example.com`。

#### 示例 2: 更改 user123 用户的电子邮件地址

```bash
v-change-user-contact user123 user123@domain.com
```

此命令将把用户 `user123` 的电子邮件地址更改为 `user123@domain.com`。

### 注意事项

* 在执行此命令之前，请确保您有足够的权限来更改用户的电子邮件地址。
* 输入的用户名和新电子邮件地址必须是有效的，否则命令将失败。
* 更改用户的电子邮件地址可能会影响与该用户相关的通知和通信，请确保在更改之前通知用户。

### 错误处理

如果命令执行失败，将显示相应的错误消息。以下是一些可能的错误情况及其解释：

* **无效的用户名**：输入的用户名不存在于系统中。
* **无效的电子邮件地址**：输入的新电子邮件地址不符合电子邮件地址的格式要求。
* **权限不足**：当前用户没有足够的权限来更改指定用户的电子邮件地址。

在出现错误时，请检查输入的用户名和新电子邮件地址是否正确，并确保您具有执行此命令的权限。

### 日志记录

`v-change-user-contact` 命令将更改操作记录在系统的日志中。管理员可以通过检查日志文件来跟踪更改历史和执行结果。具体的日志文件位置可能因系统配置而异，请参考您的 Hestia 系统文档以获取更多信息。

## v-change-user-language

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-user-language)

### 命令简介

`v-change-user-language` 是 Hestia 提供的一个 CLI 命令，用于更改指定用户的语言设置。通过此命令，用户可以轻松地在支持的语言之间进行切换，从而得到个性化的使用体验。

### 语法格式

```bash
v-change-user-language USER LANGUAGE
```

* `USER`：需要更改语言设置的用户名（必填）。
* `LANGUAGE`：需要设置的目标语言代码（必填），如 `en`（英语）、`zh-cn`（简体中文）等。

### 示例

#### 示例 1：将管理员用户的语言设置为英语

```bash
v-change-user-language admin en
```

#### 示例 2：将用户名为 john 的用户语言设置为简体中文

```bash
v-change-user-language john zh-cn
```

### 注意事项

1. 在执行此命令之前，请确保已经正确安装并配置了 Hestia 系统。
2. 请确保提供的用户名和语言代码是系统中存在的，并且用户状态是活跃的，没有被暂停或删除。
3. 如果用户当前没有语言设置（即 `user.conf` 文件中不存在 `LANGUAGE` 这一行），系统将新增一个 `LANGUAGE` 行并设置指定的语言。如果已存在 `LANGUAGE` 行，系统将更新该行的值为指定的语言。
4. 如果系统处于只读模式（如演示环境），则可能无法执行此命令。在执行前，请检查系统状态。

### 常见错误与解决方法

* **错误**：`Error: language zh-cn is not valid`
	+ **原因**：提供的语言代码无效或系统中不存在该语言。
	+ **解决方法**：检查语言代码是否正确，并确认系统中是否支持该语言。
* **错误**：`Error: user admin does not exist`
	+ **原因**：提供的用户名不存在。
	+ **解决方法**：检查用户名是否正确，并确认该用户是否已在系统中创建。
* **错误**：`Error: user admin is suspended`
	+ **原因**：该用户已被暂停使用。
	+ **解决方法**：恢复用户状态或选择其他活跃用户进行操作。

### 总结

`v-change-user-language` 命令是 Hestia 系统中一个非常实用的功能，允许用户轻松更改其语言设置。通过遵循上述语法和示例，用户可以轻松完成操作，并获得个性化的使用体验。在执行命令时，请注意检查用户状态和系统状态，以确保命令能够成功执行。

## v-change-user-name

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-user-name)

### 命令概述

`v-change-user-name` 是一个命令行接口（CLI）工具，它允许Hestia管理员或具有相应权限的用户更改特定用户的全名。这个命令在Hestia控制面板环境中特别有用，用于维护和管理用户账户信息。

### 语法

```bash
v-change-user-name USER NAME [LAST_NAME]
```

- `USER`: 要更改全名的用户的用户名。
- `NAME`: 用户的新名字。
- `[LAST_NAME]`: （可选）用户的新姓氏。如果提供，将与新名字一起构成全名。

### 示例

#### 示例 1: 更改用户名

```bash
v-change-user-name admin John
```

这个命令将把用户名为"admin"的用户的名字更改为"John"。

#### 示例 2: 更改用户全名

```bash
v-change-user-name admin John Smith
```

这个命令将把用户名为"admin"的用户的全名更改为"John Smith"。

#### 示例 3: 带有错误处理的更改用户全名

```bash
#!/bin/bash

USER="admin"
NAME="John"
LAST_NAME="Smith"

# 使用v-change-user-name命令并检查返回值
if v-change-user-name "$USER" "$NAME" "$LAST_NAME"; then
    echo "用户 $USER 的全名已成功更改为 $NAME $LAST_NAME"
else
    echo "发生错误，无法更改用户 $USER 的全名"
    # 这里可以添加额外的错误处理逻辑
fi
```

这个脚本示例展示了如何使用`v-change-user-name`命令，并通过检查命令的返回值来处理可能出现的错误。

### 注意事项

- 在使用`v-change-user-name`命令之前，请确保您已登录到具有适当权限的Hestia账户。
- 更改用户全名可能会影响与该用户相关的其他系统或服务，因此请在执行此操作之前谨慎考虑。
- 如果在命令中省略了`[LAST_NAME]`参数，则只会更改用户的名字。

### 结论

`v-change-user-name`命令是Hestia控制面板中一个非常有用的工具，它允许管理员或具有相应权限的用户轻松更改用户的全名。通过遵循上述语法和示例，您可以有效地使用此命令来维护和管理Hestia环境中的用户账户信息。

## v-change-user-ns

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-user-ns)

### 概述

`v-change-user-ns` 是一个用于更改特定用户默认名称服务器的CLI命令。它允许用户指定一个用户名以及一个或多个名称服务器地址，以便为指定的用户配置DNS解析。

### 语法

```bash
v-change-user-ns USER NS1 NS2 [NS3] [NS4] [NS5] [NS6] [NS7] [NS8]
```

- `USER`: 需要更改名称服务器的用户名。
- `NS1`, `NS2`, ... `NS8`: 名称服务器的地址。可以指定最多八个名称服务器。

### 示例

#### 示例 1: 指定两个名称服务器

```bash
v-change-user-ns john ns1.example.com ns2.example.com
```

这个命令将为用户`john`配置两个名称服务器：`ns1.example.com`和`ns2.example.com`。

#### 示例 2: 指定四个名称服务器

```bash
v-change-user-ns alice ns1.alice.net ns2.alice.net ns3.alice.net ns4.alice.net
```

这个命令将为用户`alice`配置四个名称服务器：`ns1.alice.net`，`ns2.alice.net`，`ns3.alice.net`和`ns4.alice.net`。

#### 示例 3: 省略可选参数

如果你只想为用户指定两个名称服务器，那么可以省略其他可选参数：

```bash
v-change-user-ns bob ns1.bob.org ns2.bob.org
```

这个命令将只为用户`bob`配置两个名称服务器：`ns1.bob.org`和`ns2.bob.org`。

### 参数说明

- `USER`: 用户名，用于指定需要更改名称服务器的用户。
- `NS1`, `NS2`, ... `NS8`: 名称服务器地址，可以指定最多八个名称服务器。这些参数是可选的，但至少需要指定`NS1`和`NS2`。

### 注意事项

- 在使用此命令之前，请确保您具有足够的权限来更改用户的名称服务器设置。
- 名称服务器地址应该是有效的DNS服务器地址，并且应该能够正常解析DNS请求。
- 如果指定了多个名称服务器，请确保这些服务器都是可用的，并且按照您期望的顺序进行配置。

### 返回值和错误处理

- 如果命令执行成功，它将返回一个成功的消息。
- 如果命令执行失败，它将返回一个错误消息，并指示可能的问题。例如，如果提供的用户名无效或名称服务器地址不正确，则会返回相应的错误消息。

### 依赖和配置

此命令依赖于hestia的配置文件和相关的shell脚本。确保在运行此命令之前已经正确加载了相关的配置文件和脚本。此外，您可能需要具有对hestia配置文件的读写权限，以便能够成功更改用户的名称服务器设置。

## v-change-user-package

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-user-package)

### 概述

`v-change-user-package` 是一个在 Hestia Control Panel (HestiaCP) 环境中使用的 CLI 命令，用于更改用户的托管套餐。通过此命令，系统管理员或具有相应权限的用户可以轻松地将用户的当前套餐更改为指定的新套餐。

### 语法

```bash
v-change-user-package USER PACKAGE [FORCE]
```

- `USER`: 要更改套餐的用户的用户名。
- `PACKAGE`: 目标套餐的名称。
- `[FORCE]`: 可选参数，用于在套餐资源限制不满足当前用户使用情况时强制更改套餐。

### 示例

#### 示例 1: 正常更改用户套餐

要将用户 `admin` 的套餐更改为 `yourpackage`，可以运行以下命令：

```bash
v-change-user-package admin yourpackage
```

如果 `admin` 用户的当前资源使用情况符合 `yourpackage` 的限制，那么该命令将成功执行，用户的套餐将被更改。

#### 示例 2: 强制更改用户套餐

如果 `admin` 用户的当前资源使用情况超过了 `yourpackage` 的限制，但您仍然希望强制更改套餐，可以使用 `FORCE` 参数：

```bash
v-change-user-package admin yourpackage FORCE
```

请注意，强制更改可能会导致某些服务中断或限制，因此应谨慎使用此选项。

#### 示例 3: 错误使用

如果提供了无效的参数或用户/套餐名称，命令将失败并显示相应的错误消息。

```bash
v-change-user-package invaliduser yourpackage
# 或者
v-change-user-package admin invalidpackage
```

### 注意事项

- 在执行此命令之前，请确保您已备份所有重要数据，以防意外情况发生。
- 更改用户套餐可能会影响其网站、电子邮件和其他相关服务的正常运行。请确保在执行此操作之前通知用户，并在可能的情况下在维护窗口期间执行。
- 使用 `FORCE` 参数时应特别小心，因为它会忽略资源限制并可能导致服务中断或资源超支。

### 脚本内部逻辑

`v-change-user-package` 命令的脚本内部执行了一系列检查和验证步骤，以确保套餐更改的安全性和准确性。这些步骤包括加载配置文件、验证用户身份和套餐可用性、检查资源限制等。如果任何检查失败，命令将失败并显示相应的错误消息。

### 总结

`v-change-user-package` 是一个强大的 CLI 命令，允许系统管理员轻松更改 HestiaCP 环境中用户的托管套餐。通过正确使用该命令并遵循上述注意事项，您可以安全、有效地管理用户的套餐分配。

## v-change-user-password

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-user-password)

### 命令概述

`v-change-user-password` 是 Hestia 提供的命令行接口（CLI）命令之一，用于更改指定用户的密码。同时，该命令还可能根据系统配置更新相关的安全设置或日志记录。

### 语法

```bash
v-change-user-password USER PASSWORD
```

- `USER`: 要更改密码的用户的用户名。
- `PASSWORD`: 用户的新密码。

### 示例

#### 示例 1: 更改 admin 用户的密码

```bash
v-change-user-password admin NewPassword123
```

这个命令将把用户名为 `admin` 的用户的密码更改为 `NewPassword123`。

#### 示例 2: 交互式更改密码

如果未指定 `PASSWORD` 参数，`v-change-user-password` 命令将提示用户输入密码。

```bash
v-change-user-password admin
```

运行此命令后，系统将提示您输入新密码（密码输入时不会显示）：

```bash
Password: 
```

输入新密码后按回车键即可。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来更改用户密码。
- 密码应遵循系统的密码策略要求，包括长度、字符集和复杂度等。
- 如果系统配置了相关的安全设置或日志记录，更改用户密码可能会触发相应的安全事件或日志条目。

### 日志记录

根据 Hestia 的配置，`v-change-user-password` 命令可能会将密码更改事件记录到系统日志中。这有助于管理员跟踪和监控系统的安全状态。具体的日志记录方式和位置取决于 Hestia 的配置和部署环境。

### 安全性考虑

- 请勿在公共或不受信任的环境中明文传输或存储密码。
- 定期更改密码是保持系统安全性的重要措施之一。
- 使用强密码策略来确保密码的复杂度和安全性。

### 结论

`v-change-user-password` 是 Hestia 提供的一个功能强大的 CLI 命令，用于更改指定用户的密码。通过遵循上述示例和注意事项，您可以安全、有效地使用该命令来管理 Hestia 系统中的用户密码。

## v-change-user-php-cli

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-user-php-cli)

### 命令概述

`v-change-user-php-cli` 是 Hestia 提供的一个命令行工具，用于更改指定用户的默认 PHP CLI（命令行接口）版本。在支持多 PHP 版本的环境中，此命令允许用户轻松切换默认的 PHP CLI 版本。

### 命令语法

```bash
v-change-user-php-cli USER VERSION
```

- `USER`: 要更改默认 PHP CLI 版本的用户的用户名。
- `VERSION`: 要设置为默认 PHP CLI 版本的版本号（如 7.2、7.4 等）。

### 使用示例

#### 示例 1: 更改用户 'john' 的默认 PHP CLI 版本为 7.4

```bash
v-change-user-php-cli john 7.4
```

执行上述命令后，系统将在用户 'john' 的 `.bash_aliases` 文件中添加一行配置，设置默认的 PHP CLI 版本为 7.4。当用户 'john' 在命令行中执行 `php` 命令时，将使用 PHP 7.4 版本。


### 注意事项

- 在执行 `v-change-user-php-cli` 命令之前，请确保已安装并正确配置了 Hestia 及其相关的 PHP 版本管理工具。
- 请确保提供的 `USER` 和 `VERSION` 参数是有效的。如果指定的用户不存在或指定的 PHP 版本不受支持，命令将无法成功执行。
- 更改默认 PHP CLI 版本可能会影响用户执行的 PHP 脚本和应用程序的行为。在更改之前，请确保了解可能的影响，并在必要时进行适当的测试。
- 在使用此命令之前，请务必备份相关的配置文件和用户数据，以防意外情况发生。

### 总结

`v-change-user-php-cli` 命令是 Hestia 提供的一个实用的命令行工具，允许用户轻松更改指定用户的默认 PHP CLI 版本。通过遵循上述指南和使用示例，你可以轻松地使用该命令来管理你的 PHP CLI 版本设置。

## v-change-user-rkey

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-user-rkey)

### 命令概述

`v-change-user-rkey` 是 Hestia 提供的命令行工具，用于更改用户的随机密钥（RKEY）。这个密钥通常用于安全验证，特别是在密码忘记时用于重置密码。此命令允许管理员或具有适当权限的用户为用户生成新的 RKEY 值。

### 命令语法

```bash
v-change-user-rkey [选项] 用户名 [哈希值]
```

* **选项**：该命令可能支持一些可选参数，具体取决于 Hestia 的版本和配置。通常，这些选项可能包括设置输出格式、验证模式等。
* **用户名**：要更改 RKEY 的用户的用户名。
* **哈希值**（可选）：可选参数，如果提供，则使用此哈希值作为新的 RKEY。如果未提供，则自动生成新的 RKEY 哈希值。

### 示例

#### 示例 1：自动生成新 RKEY

```bash
v-change-user-rkey john_doe
```

在此示例中，我们为名为 `john_doe` 的用户自动生成了一个新的 RKEY。Hestia 将生成一个随机哈希值，并将其设置为该用户的 RKEY。

#### 示例 2：使用指定哈希值设置 RKEY

```bash
v-change-user-rkey jane_smith 123abc
```

在此示例中，我们为名为 `jane_smith` 的用户设置了一个特定的 RKEY 哈希值 `123abc`。请注意，这通常不是一个安全的做法，因为您应该始终使用随机生成的哈希值作为 RKEY。此示例仅用于演示目的。

### 注意事项

* 在使用此命令之前，请确保您具有适当的权限和身份验证。
* 请勿将 RKEY 暴露给未经授权的用户，因为它可以用于重置密码或执行其他敏感操作。
* 如果您选择手动设置 RKEY 哈希值（如示例 2 所示），请确保使用强密码策略生成的哈希值，以提高安全性。

### 总结

`v-change-user-rkey` 是 Hestia 提供的一个有用的命令行工具，用于更改用户的随机密钥（RKEY）。通过此命令，您可以轻松地为用户生成新的 RKEY 值，从而增强系统的安全性和可靠性。请确保在使用此命令时遵循最佳的安全实践，并始终遵循 Hestia 的文档和指南。

## v-change-user-role

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-user-role)

### 命令描述

`v-change-user-role` 是一个用于更新用户角色的 Hestia CLI 命令。通过此命令，系统管理员可以授予或撤销用户对系统账户的管理权限，从而调整用户的角色。

### 语法

```bash
v-change-user-role USER ROLE
```

* `USER`: 要更新角色的用户名。
* `ROLE`: 用户的新角色名称。

### 示例

#### 示例 1: 授予用户管理员权限

```bash
v-change-user-role username administrator
```

上述命令将授予 `username` 管理员权限，使其能够管理所有账户。

#### 示例 2: 撤销用户管理员权限

假设 `username` 当前是管理员，但您希望撤销其管理员权限：

```bash
v-change-user-role username standard_user
```

上述命令将把 `username` 的角色从管理员更改为普通用户（假设 `standard_user` 是普通用户的角色名称）。

#### 示例 3: 结合其他命令使用

您还可以将此命令与其他 Hestia CLI 命令结合使用，以在脚本中自动化用户角色管理。例如，以下是一个简单的 bash 脚本，用于检查用户是否存在，并根据条件更改其角色：

```bash
#!/bin/bash

USER="username"
TARGET_ROLE="administrator"

# 检查用户是否存在
if v-user-exists "$USER"; then
    echo "用户 $USER 存在，准备更改角色..."
    v-change-user-role "$USER" "$TARGET_ROLE"
    echo "用户 $USER 的角色已成功更改为 $TARGET_ROLE"
else
    echo "用户 $USER 不存在"
fi
```

### 注意事项

* 在执行此命令之前，请确保您具有足够的权限来更改用户角色。
* 请确保指定的用户名和角色名称在系统中是有效的。
* 如果在执行命令时遇到任何错误或问题，请检查 Hestia 的日志文件以获取更多详细信息。

### 日志记录

当使用 `v-change-user-role` 命令更改用户角色时，系统将在日志中记录此操作。这有助于跟踪和管理用户权限的更改历史。您可以使用 Hestia 提供的日志管理工具来查看和管理这些日志。

## v-change-user-shell

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-user-shell)

`v-change-user-shell` 是 Hestia 系统中提供的一个命令行接口（CLI）命令，用于更改系统用户的默认 shell。Shell 是用户与系统交互的界面，它决定了用户如何执行命令和脚本。本文档将详细介绍 `v-change-user-shell` 命令的使用方法，包括语法、选项、参数和示例。

### 语法

```bash
v-change-user-shell [选项] 用户名 新shell [是否启用Jail]
```

### 选项

* **无特定选项**：此命令直接接受参数，无需使用特定的选项标志。

### 参数

1. **用户名**：要更改 shell 的系统用户的用户名。
2. **新shell**：用户新的默认 shell。请确保此 shell 存在于 `/etc/shells` 文件中。
3. **是否启用Jail**（可选）：一个可选参数，用于指定是否对用户的 shell 启用 jail 功能。默认为不启用。

### 示例

#### 示例 1：更改用户 shell 为 bash

```bash
v-change-user-shell admin bash
```

这条命令将把 `admin` 用户的默认 shell 更改为 `bash`。

#### 示例 2：更改用户 shell 并启用 Jail 功能

```bash
v-change-user-shell john nologin yes
```

这条命令将把 `john` 用户的默认 shell 更改为 `nologin`（这通常用于禁用用户的 shell 访问），并启用 jail 功能（尽管对于 `nologin` 来说可能没有实际意义，但此示例仅用于演示）。

#### 示例 3：使用 rsync shell 并禁用 Jail 功能（默认为禁用）

```bash
v-change-user-shell backup rsync
```

这里，我们假设 `rsync` 是一个有效的 shell，并存在于 `/etc/shells` 文件中。此命令将把 `backup` 用户的默认 shell 更改为 `rsync`，并且由于我们没有指定是否启用 jail，因此将使用默认值（即不启用）。

### 注意事项

* 在更改用户的 shell 之前，请确保新的 shell 存在于 `/etc/shells` 文件中，否则更改可能不会生效。
* Jail 功能可能因系统和配置而异，具体取决于 Hestia 的实现和配置。在启用 jail 功能之前，请确保您了解其含义和潜在影响。
* 更改用户的 shell 可能会影响用户与系统交互的方式，因此请谨慎操作。在更改之前，最好先备份相关配置文件或系统状态。

## v-change-user-sort-order

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-user-sort-order)

### 命令概述

`v-change-user-sort-order` 是 Hestia 提供的 CLI 命令之一，用于修改指定用户在 Web UI 中的显示排序顺序。这对于管理员来说是一个有用的工具，可以方便地调整用户列表的显示顺序。

### 使用方法

```bash
v-change-user-sort-order <USER> <SORT_ORDER>
```

- `<USER>`：要修改排序顺序的用户的用户名。
- `<SORT_ORDER>`：新的排序顺序值。这个值通常是一个数字或特定的字符串，具体取决于 Hestia 的配置和版本。

### 示例

#### 示例 1: 修改用户排序顺序

假设我们要将用户名为 `john_doe` 的用户的排序顺序更改为 `100`，可以使用以下命令：

```bash
v-change-user-sort-order john_doe 100
```

执行上述命令后，`john_doe` 用户在 Web UI 中的显示顺序将被更改为 `100`。

#### 示例 2: 验证命令执行

为了验证命令是否成功执行，管理员可以登录到 Hestia 的 Web UI，并检查用户列表的排序顺序。如果 `john_doe` 用户现在位于或接近列表的顶部（取决于其他用户的排序顺序值），则命令已成功执行。

### 注意事项

1. **权限要求**：执行此命令需要具有相应的管理员权限。
2. **排序顺序值**：确保提供的 `<SORT_ORDER>` 值是有效的，并且符合 Hestia 的配置和版本要求。不恰当的值可能导致不可预期的行为。
3. **错误处理**：如果命令执行失败（例如，由于权限不足、用户不存在或无效的排序顺序值），则命令将返回错误消息。请仔细阅读错误消息，并根据需要进行相应的调整。
4. **日志记录**：Hestia 通常会将 CLI 命令的执行记录到日志文件中。管理员可以检查这些日志文件以获取有关命令执行情况的更多信息。

### 常见问题解答

**Q**: 我收到一个错误消息，说我的用户不存在。
**A**: 请确保您提供的 `<USER>` 值是正确的，并且该用户确实存在于 Hestia 中。

**Q**: 我尝试更改排序顺序，但似乎没有任何变化。
**A**: 请检查您提供的 `<SORT_ORDER>` 值是否有效，并考虑其他用户的排序顺序值。此外，请确保您已登录到正确的 Hestia 实例，并刷新 Web UI 以查看更改。

**Q**: 我如何查看命令的日志记录？
**A**: 您可以检查 Hestia 的日志文件以获取有关 CLI 命令执行情况的记录。日志文件的位置可能因 Hestia 的配置和版本而异，但通常可以在 Hestia 的文档或管理界面中找到相关信息。

## v-change-user-template

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-user-template)

`v-change-user-template` 是 Hestia 控制面板提供的 CLI 命令，用于更改用户的默认模板设置。此命令允许管理员或用户根据特定的类型（如 WEB、PROXY、BACKEND、DNS 等）为特定用户指定不同的模板。

### 命令语法

```bash
v-change-user-template USER TYPE TEMPLATE
```

* `USER`: 要更改模板的用户名。
* `TYPE`: 模板的类型，可选值包括 `WEB`、`PROXY`、`BACKEND`、`DNS`。
* `TEMPLATE`: 要设置的新模板名称。

### 示例

#### 示例 1: 更改管理员用户的 WEB 模板为 'wordpress'

```bash
v-change-user-template admin WEB wordpress
```

此命令将把管理员用户的 WEB 模板设置为 'wordpress'。

#### 示例 2: 更改用户 'john' 的 PROXY 模板为 'nginx'

```bash
v-change-user-template john PROXY nginx
```

此命令将把用户 'john' 的 PROXY 模板设置为 'nginx'。

#### 示例 3: 尝试使用无效类型

```bash
v-change-user-template alice INVALID wordpress
```

由于 'INVALID' 不是有效的模板类型，此命令将失败，并显示相应的错误消息。

### 注意事项

* 在执行此命令之前，请确保您已登录到 Hestia 控制面板并具有相应的权限。
* 提供的模板名称必须是 Hestia 系统中已存在的有效模板。
* 在更改模板之前，请确保了解该模板的功能和设置，以避免不必要的错误或问题。

### 错误处理

如果命令执行失败，Hestia 将显示相应的错误消息，以帮助您诊断问题。请仔细阅读错误消息，并根据需要进行相应的更正或操作。

### 日志记录

执行 `v-change-user-template` 命令时，Hestia 将记录相关的操作日志。这些日志可用于跟踪和审计更改，以及在需要时进行故障排除。

### 总结

`v-change-user-template` 命令是 Hestia 控制面板提供的强大工具，允许管理员或用户根据需要更改用户的默认模板设置。通过遵循上述语法和示例，您可以轻松地使用此命令来管理用户的模板配置。

## v-change-domain-owner

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-domain-owner)

### 1. 命令概述

`v-change-domain-owner` 是 Hestia 提供的一个命令行接口（CLI）命令，用于更改指定域名的所有者。这对于网站管理员或系统管理员来说是一个非常重要的功能，因为它允许他们根据需要进行域名所有权的转移。

### 2. 使用方法

```bash
v-change-domain-owner DOMAIN USER
```

- `DOMAIN`: 要更改所有者的域名。
- `USER`: 新的域名所有者用户名。

### 3. 示例

**示例 1:** 将 `www.example.com` 域名的所有者更改为 `bob`。

```bash
v-change-domain-owner www.example.com bob
```

如果命令执行成功，它不会输出任何内容，但您可以通过其他命令或界面验证更改是否已生效。

**示例 2:** 假设您有一个包含多个子域名的域名 `example.org`，并且您想要将其所有者更改为 `alice`。请注意，`v-change-domain-owner` 命令仅处理单个域名，而不是整个域名树。因此，对于每个子域名，您都需要单独运行此命令。

```bash
v-change-domain-owner sub1.example.org alice
v-change-domain-owner sub2.example.org alice
# ... 对于其他子域名重复此操作
```

**示例 3:** 在运行 `v-change-domain-owner` 之前，您可能想要检查当前域名的所有者。虽然 Hestia CLI 可能没有直接的命令来执行此操作，但您可以使用其他工具或界面来查找此信息。一旦您知道当前所有者，就可以安全地运行 `v-change-domain-owner` 命令。

### 4. 注意事项

* 在更改域名所有者之前，请确保新的所有者用户已经在 Hestia 系统中创建，并具有适当的权限。
* 如果域名当前已分配给某个用户，并且该用户拥有与域名相关的资源（如网站、电子邮件等），则在更改所有者之前，请确保这些资源已得到妥善处理或迁移。
* 在执行此命令之前，请务必备份相关数据和配置，以防万一出现任何问题。

### 5. 错误处理

如果 `v-change-domain-owner` 命令执行失败，它可能会返回一个错误代码或消息。以下是一些可能的错误情况和相应的处理方法：

* **域名不存在**：如果尝试更改的域名在 Hestia 系统中不存在，命令将失败。请检查您输入的域名是否正确，并确保它已添加到 Hestia 系统中。
* **用户不存在**：如果指定的新用户不存在于 Hestia 系统中，命令将失败。请确保您已创建新用户，并输入了正确的用户名。
* **权限不足**：如果您没有足够的权限来更改域名所有者，命令将失败。请确保您已登录到具有适当权限的用户帐户，或联系系统管理员以获取帮助。

## 删除系列命令

::: danger 温馨提示！  
<span style="font-size: 20px; color: red;">此系列部分命令执行后无法撤销，请谨慎使用！</span>  
:::

## v-delete-database-temp-user

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-database-temp-user)

`v-delete-database-temp-user` 是 Hestia 提供的一个命令行工具，用于撤销临时用户对数据库的访问权限并删除该用户。该命令通常在需要临时访问数据库进行某些操作后使用，以确保数据库的安全性。

### 用法

```bash
v-delete-database-temp-user USER DBUSER [TYPE] [HOST]
```

- `USER`: 执行该命令的 Hestia 系统用户。
- `DBUSER`: 需要撤销权限并删除的临时数据库用户。
- `[TYPE]`: 数据库类型，默认为 `mysql`。
- `[HOST]`: 数据库主机名，默认为本地主机。

### 示例

**示例 1**: 撤销并删除名为 `temp_user` 的临时用户对 `my_database` 的访问权限

```bash
v-delete-database-temp-user admin temp_user my_database
```

**示例 2**: 撤销并删除名为 `temp_user_2` 的临时用户对 `another_db` 的访问权限，并指定数据库类型为 `postgresql`

```bash
v-delete-database-temp-user admin temp_user_2 another_db postgresql
```

**示例 3**: 撤销并删除名为 `temp_user_3` 的临时用户对远程数据库服务器的访问权限

```bash
v-delete-database-temp-user admin temp_user_3 remote_database mysql remote_host.example.com
```

### 注意事项

1. **权限**: 执行此命令的用户必须具有足够的权限来管理数据库用户。
2. **错误处理**: 如果命令执行失败，可能是由于提供的参数无效、用户不存在、数据库不存在或其他原因。请检查命令的输出以获取更多信息。
3. **备份**: 在执行此类操作之前，请确保已对数据库进行备份，以防止意外数据丢失。
4. **安全性**: 使用临时用户进行数据库操作是一种安全实践，可以限制对数据库的长期访问。在完成所需操作后，务必及时撤销这些用户的权限并删除它们。

### 结论

`v-delete-database-temp-user` 命令为 Hestia 系统管理员提供了一个方便的工具来管理临时数据库用户。通过正确地使用此命令，您可以确保数据库的安全性并减少潜在的安全风险。

## v-delete-databases

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-databases)

### 简介

`v-delete-databases` 是 Hestia 提供的一个命令行接口（CLI）命令，用于删除指定用户的所有数据库。此命令在执行前会进行一系列验证，以确保操作的正确性和安全性。

### 用法

```bash
v-delete-databases [选项] 用户名
```

### 选项

- 无特殊选项，仅指定用户名即可。

### 示例

#### 示例 1: 删除用户 `admin` 的所有数据库

```bash
v-delete-databases admin
```

运行上述命令后，系统会要求用户确认是否删除 `admin` 用户的所有数据库。确认后，所有与 `admin` 用户相关的数据库将被删除。

#### 示例 2: 交互式删除

在某些情况下，你可能希望在执行删除操作前进行更多的确认。虽然 `v-delete-databases` 命令已经内置了基本的确认机制，但如果你希望更详细地了解将被删除的数据库列表，并手动选择要删除的数据库，可以结合其他 Hestia CLI 命令和工具来实现。

### 注意事项

- 在执行此命令之前，请务必确保你已经备份了所有重要数据，以防意外删除。
- 确保你有足够的权限来执行此命令。通常，只有具有管理员权限的用户才能删除其他用户的数据库。
- 在执行此命令时，请确保没有其他用户或进程正在使用要删除的数据库，否则可能会导致数据不一致或其他问题。

### 常见问题解答

**Q: 我如何确认哪些数据库将被删除？**
A: 在执行 `v-delete-databases` 命令之前，你可以使用其他 Hestia CLI 命令（如 `v-list-databases`）来查看与指定用户相关的所有数据库。

**Q: 如果我误删了数据库，可以恢复吗？**
A: 如果已经删除了数据库并且没有备份，那么通常无法恢复。因此，在执行删除操作之前，请务必确保你已经备份了所有重要数据。

**Q: 我可以只删除部分数据库而不是全部吗？**
A: `v-delete-databases` 命令用于删除指定用户的所有数据库。如果你只想删除部分数据库，你可以使用其他 Hestia CLI 命令（如 `v-delete-database`）来逐个删除数据库。

## v-delete-web-domains

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-web-domains)

### 概述

`v-delete-web-domains` 是 Hestia 提供的命令行工具之一，用于删除指定用户的所有网络域名。此命令在执行过程中会谨慎处理，确保不会对系统或其他用户造成不必要的影响。

### 语法

```bash
v-delete-web-domains USER [RESTART]
```

* `USER`：必填参数，指定要删除网络域名的用户名。
* `RESTART`：可选参数，指定是否在删除后重启网络服务。如果提供此参数，则会在删除完成后尝试重启 Web 服务器和代理服务器。

### 示例

#### 示例1：删除指定用户的所有网络域名（不重启服务）

```bash
v-delete-web-domains admin
```

在此示例中，命令将删除用户 `admin` 的所有网络域名，但不会尝试重启任何服务。

#### 示例2：删除指定用户的所有网络域名并重启服务

```bash
v-delete-web-domains admin RESTART
```

在此示例中，命令将删除用户 `admin` 的所有网络域名，并在删除完成后尝试重启 Web 服务器和代理服务器。

### 注意事项

* 在执行此命令之前，请确保您具有足够的权限，并且已经备份了所有重要数据。
* 删除网络域名将导致相关网站和服务不可用，请谨慎操作。
* 如果在删除过程中遇到任何问题，请检查命令的语法和参数是否正确，并查阅相关的日志文件以获取更多信息。

### 返回值和错误处理

* 如果命令执行成功，将返回 0 作为退出码。
* 如果命令执行失败，将返回非零退出码，并在标准错误输出中显示相应的错误消息。请查阅错误消息以确定问题的原因并进行相应的处理。

### 日志和调试

* 默认情况下，`v-delete-web-domains` 命令将记录相关的日志信息到 Hestia 的日志文件中。您可以通过查看这些日志文件来获取有关命令执行情况的详细信息。
* 如果需要调试命令的执行过程，您可以尝试在命令中添加适当的调试选项或参数。具体的调试选项和参数可能因 Hestia 的版本和配置而有所不同，请参考相关的文档或手册以获取更多信息。

### 兼容性

`v-delete-web-domains` 命令是 Hestia 特有的命令行工具，因此其兼容性取决于您所使用的 Hestia 版本和操作系统环境。请确保您已经安装了与您的系统兼容的 Hestia 版本，并按照相关的文档和指南进行配置和使用。

## v-delete-user

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-user)

### 简介

`v-delete-user` 是 Hestia 提供的 CLI（命令行接口）命令之一，用于删除指定用户及其相关资源，如域名、数据库、cron 作业等。这个命令在服务器管理中非常有用，尤其是在需要清理不再使用的用户账户时。

### 语法

```bash
v-delete-user [用户名] [可选参数]
```

- **用户名**：要删除的用户名，必须参数。
- **可选参数**：目前支持的可选参数包括 `RESTART`，用于在删除用户后重启相关服务。

### 示例

#### 示例 1：删除名为 "whistler" 的用户

```bash
v-delete-user whistler
```

执行此命令后，系统将会删除名为 "whistler" 的用户及其所有相关资源。

#### 示例 2：删除用户并重启相关服务

```bash
v-delete-user whistler RESTART
```

在这个例子中，除了删除 "whistler" 用户及其资源外，系统还会重启与该用户相关的服务。

### 注意事项

1. 在执行 `v-delete-user` 命令之前，请确保已经备份了所有重要数据，因为该命令会永久删除用户及其所有相关资源。
2. 如果用户是系统管理员或拥有特殊权限，执行此命令可能会导致系统不稳定或无法访问。在删除这样的用户之前，请务必谨慎考虑。
3. 如果在执行命令时遇到任何错误或问题，请查看 Hestia 的日志文件以获取更多信息。

### 常见问题

**Q**: 执行 `v-delete-user` 命令后，我可以恢复被删除的用户吗？
**A**: 不可以。`v-delete-user` 命令会永久删除用户及其所有相关资源，因此无法恢复。

**Q**: 如果我在执行命令时忘记了添加 `RESTART` 参数，但之后想重启相关服务，我应该怎么做？
**A**: 你可以手动重启相关服务，或者再次执行 `v-delete-user` 命令并添加 `RESTART` 参数。但请注意，第二次执行该命令不会再次删除用户和资源，而只会重启相关服务。

### 结论

`v-delete-user` 是 Hestia 提供的一个非常有用的 CLI 命令，它可以帮助你轻松删除不再使用的用户账户及其相关资源。但在使用此命令之前，请务必谨慎考虑，并确保已经备份了所有重要数据。

## v-delete-user-2fa

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-user-2fa)

### 概述

`v-delete-user-2fa` 是 Hestia 提供的一个 CLI 命令，用于删除指定用户的两步验证（Two-Factor Authentication, 简称 2FA）设置。此命令允许管理员或具有适当权限的用户轻松管理用户的两步验证状态。

### 语法

```bash
v-delete-user-2fa <USER>
```

- `<USER>`：要删除两步验证设置的用户名。

### 示例

#### 示例 1：删除用户 "admin" 的两步验证设置

```bash
v-delete-user-2fa admin
```

执行上述命令后，如果成功，系统将删除用户 "admin" 的两步验证设置，并可能显示相关的成功消息。

#### 示例 2：使用变量删除用户的两步验证设置

假设您有一个包含用户名的变量 `$USERNAME`，您可以这样使用它：

```bash
USERNAME="john_doe"
v-delete-user-2fa $USERNAME
```

这将删除用户名存储在 `$USERNAME` 变量中（在本例中为 "john_doe"）的用户的两步验证设置。

### 注意事项

1. **权限**：执行此命令的用户必须具有足够的权限来修改用户的两步验证设置。
2. **用户存在性**：在尝试删除两步验证设置之前，请确保指定的用户确实存在。
3. **两步验证状态**：如果用户在执行此命令之前没有启用两步验证，系统可能会返回一个错误或警告消息。
4. **日志记录**：此命令的执行通常会被记录在系统日志中，以便进行审计和跟踪。

### 返回值和错误处理

* **成功**：命令成功执行时，通常会返回一个表示成功的状态码（如 0），并可能显示相关的成功消息。
* **失败**：如果命令执行失败（例如，由于权限不足、用户不存在或系统错误），则会返回一个非零状态码，并可能显示错误消息。建议检查系统日志以获取更详细的错误信息。

### 常见问题解答

* **Q**：我如何知道两步验证是否已成功删除？
**A**：除了命令本身的输出之外，您还可以检查用户的相关配置文件或登录尝试来确定两步验证是否已禁用。
* **Q**：如果我在执行此命令时遇到问题，我应该怎么做？
**A**：首先，检查命令的语法和参数是否正确。然后，检查您是否具有执行此命令所需的权限。如果问题仍然存在，请查看系统日志以获取更详细的错误信息，并考虑联系系统管理员或支持团队以获取帮助。

## v-delete-user-auth-log

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-user-auth-log)

### 简介

`v-delete-user-auth-log` 是 Hestia 提供的一个命令行工具（CLI），用于删除指定用户的认证日志文件。此操作通常用于安全维护或用户数据清理等场景。以下是该命令的详细使用说明及示例。

### 命令语法

```bash
v-delete-user-auth-log [用户名]
```

- `[用户名]`：要删除认证日志的用户的用户名。

### 功能描述

该命令会删除指定用户的认证日志文件（通常位于 `$USER_DATA/auth.log`），并记录相关操作日志。这有助于管理员维护系统的安全性和用户数据的隐私性。

### 权限要求

执行该命令的用户需要具有相应的权限，通常只有管理员或具有特定权限的用户才能执行此操作。

### 示例

#### 示例 1：删除用户 `john` 的认证日志

```bash
v-delete-user-auth-log john
```

执行上述命令后，如果成功，将删除用户 `john` 的认证日志文件，并在系统日志中记录相关操作。

#### 示例 2：错误使用（未指定用户名）

```bash
v-delete-user-auth-log
```

执行上述命令将返回错误提示，因为未指定要删除认证日志的用户名。

#### 示例 3：结合脚本使用

你可以将 `v-delete-user-auth-log` 命令结合到脚本中，以实现自动化操作。例如，以下是一个简单的 Bash 脚本，用于删除多个用户的认证日志：

```bash
#!/bin/bash

# 定义要删除认证日志的用户列表
users=("john" "jane" "doe")

# 遍历用户列表，执行删除操作
for user in "${users[@]}"; do
    v-delete-user-auth-log "$user"
    if [ $? -eq 0 ]; then
        echo "User $user's authentication log deleted successfully."
    else
        echo "Failed to delete user $user's authentication log."
    fi
done
```

### 注意事项

- 在执行删除操作前，请确保已经备份了重要的认证日志数据，以防误操作导致数据丢失。
- 如果系统处于只读模式或特定安全策略下，可能无法执行该命令。在执行前，请确保系统处于可写状态，并且你有足够的权限来执行此操作。
- 频繁删除认证日志可能会影响系统的安全性和审计能力。在执行此操作前，请仔细考虑其潜在影响。

## v-delete-user-backup

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-user-backup)

### 命令描述

`v-delete-user-backup` 是 Hestia 提供的命令行工具，用于删除用户的备份文件。通过此命令，系统管理员可以方便地管理并释放存储空间，确保备份的完整性和有效性。

### 命令格式

```bash
v-delete-user-backup USER BACKUP
```

- `USER`：需要删除备份的用户名。
- `BACKUP`：需要删除的备份文件名或标识符。

### 示例

#### 示例1：删除指定用户的备份文件

假设需要删除用户名为 `admin` 的 `admin.2023-04-01_12-00-00.tar` 备份文件，可以使用以下命令：

```bash
v-delete-user-backup admin admin.2023-04-01_12-00-00.tar
```

执行后，系统将删除 `admin` 用户的 `admin.2023-04-01_12-00-00.tar` 备份文件，并在日志中记录操作信息。

#### 示例2：批量删除指定用户的所有备份文件

如果需要批量删除用户名为 `user1` 的所有备份文件，可以通过编写脚本或使用其他工具配合 `v-delete-user-backup` 命令来实现。以下是一个简单的示例脚本，用于删除 `user1` 的所有备份文件（假设备份文件名以 `.tar` 结尾）：

```bash
#!/bin/bash

USER="user1"
BACKUPS=$(ls /path/to/backup/directory/*.tar | grep "$USER")

for BACKUP in $BACKUPS; do
    v-delete-user-backup "$USER" "$(basename "$BACKUP")"
done
```

请将 `/path/to/backup/directory/` 替换为实际的备份文件存储目录。执行该脚本后，系统将删除 `user1` 的所有备份文件。

### 注意事项

1. 在执行删除操作前，请确保已备份重要数据，以防意外情况导致数据丢失。
2. 如果备份文件正在被其他进程使用或锁定，可能会导致删除操作失败。请确保在删除前关闭相关进程或解除锁定。
3. 使用此命令时，请确保具有足够的权限来执行删除操作。如果没有足够的权限，请与系统管理员联系以获取帮助。

### 日志记录

`v-delete-user-backup` 命令将在执行时记录日志信息。这些日志信息可以用于审计、故障排查和其他目的。默认情况下，日志信息将存储在 Hestia 的日志文件中。具体的日志位置和格式可能因 Hestia 的配置而有所不同。请参考 Hestia 的文档以获取有关日志记录的更多详细信息。

## v-delete-user-backup-exclusions

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-user-backup-exclusions)

### 命令概述

`v-delete-user-backup-exclusions` 是 Hestia 提供的一个命令行接口（CLI）命令，用于删除指定用户的备份排除项。这些排除项通常用于指定在备份过程中不应包含的文件或目录。

### 语法

```bash
v-delete-user-backup-exclusions [USER] [SYSTEM]
```

- `[USER]`：必填参数，指定要删除备份排除项的用户名。
- `[SYSTEM]`：可选参数，用于指定要删除的排除项所属的系统或服务类型（如 WEB、DNS、MAIL 等）。如果不提供此参数，则会删除该用户所有的备份排除项。

### 示例

#### 示例 1：删除指定用户的所有备份排除项

```bash
v-delete-user-backup-exclusions admin
```

这个命令会删除用户 `admin` 的所有备份排除项，无论它们是属于哪个系统或服务。

#### 示例 2：删除指定用户的特定系统备份排除项

```bash
v-delete-user-backup-exclusions admin WEB
```

这个命令会删除用户 `admin` 的 `WEB` 系统备份排除项。如果 `admin` 用户没有设置 `WEB` 系统的备份排除项，则该命令不会产生任何效果。

#### 示例 3：删除多个用户的备份排除项

虽然 `v-delete-user-backup-exclusions` 命令一次只能处理一个用户，但你可以通过循环或脚本来处理多个用户。以下是一个简单的 Bash 脚本示例，用于删除多个用户的备份排除项：

```bash
#!/bin/bash

# 定义要删除备份排除项的用户列表
users=("user1" "user2" "user3")

# 遍历用户列表，执行删除命令
for user in "${users[@]}"; do
    v-delete-user-backup-exclusions "$user"
    echo "Deleted backup exclusions for user: $user"
done
```

这个脚本会依次删除 `user1`、`user2` 和 `user3` 的所有备份排除项。

### 注意事项

* 在执行此命令之前，请确保你有足够的权限来修改备份设置。
* 删除备份排除项可能会影响备份的完整性和准确性。在执行此命令之前，请确保你了解可能的影响，并已经做好了相应的备份。
* 如果在删除过程中遇到任何问题或错误，请查看 Hestia 的日志文件以获取更多信息。日志文件的位置和命名可能因 Hestia 的配置和版本而异，但通常可以在 Hestia 的安装目录下找到。

## v-delete-user-ips

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-user-ips)

### 简介

`v-delete-user-ips` 是 Hestia 提供的一个命令行接口（CLI）命令，用于删除指定用户的所有 IP 地址。这个命令特别适用于需要清理用户数据或更改用户配置的场景。

### 用法

```bash
v-delete-user-ips [USER]
```

* `[USER]`：需要删除 IP 地址的用户的用户名。这个参数是必须的。

### 示例

#### 示例 1: 删除用户 admin 的所有 IP 地址

```bash
v-delete-user-ips admin
```

在这个示例中，`admin` 是需要删除 IP 地址的用户的用户名。执行这个命令后，系统将会删除与 `admin` 用户关联的所有 IP 地址。

#### 示例 2: 使用变量指定用户名

如果你正在编写一个脚本，并且用户名是从某个变量中获取的，你可以这样做：

```bash
#!/bin/bash

USERNAME="testuser"
v-delete-user-ips $USERNAME
```

在这个示例中，我们首先定义了一个变量 `USERNAME`，并将其设置为 `testuser`。然后，我们使用 `$USERNAME` 变量作为参数调用 `v-delete-user-ips` 命令。

### 注意事项

* 执行 `v-delete-user-ips` 命令之前，请确保你已经登录到正确的用户账号，并且具有执行该命令的权限。
* 在删除用户 IP 地址之前，请确保你已经备份了所有重要的数据，以防止意外丢失。
* 如果在执行命令时遇到任何问题，请查看 Hestia 的日志文件以获取更多信息。

### 返回值和错误处理

* 如果命令执行成功，`v-delete-user-ips` 将会返回一个退出码 `0`。
* 如果发生错误（例如，用户不存在或没有足够的权限），`v-delete-user-ips` 将会返回一个非零的退出码，并可能输出一条错误消息。你可以使用 shell 脚本中的条件语句来处理这些错误。

### 总结

`v-delete-user-ips` 是一个强大的工具，可以帮助你快速删除指定用户的所有 IP 地址。通过结合示例和注意事项，你可以更好地理解和使用这个命令。如果你有任何疑问或需要进一步的帮助，请查阅 Hestia 的官方文档或联系技术支持团队。

## v-delete-user-log

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-user-log)

### 命令概述

`v-delete-user-log` 是 Hestia 提供的一个命令行接口（CLI）命令，用于删除指定用户的日志文件。这个命令在需要清理用户日志历史或进行系统维护时特别有用。

### 语法

```bash
v-delete-user-log [USER]
```

- `[USER]`：要删除日志的用户名。如果未指定，则默认删除系统日志（如果存在这样的功能）。

### 示例

#### 示例 1：删除特定用户的日志文件

假设我们想要删除名为 `johndoe` 的用户的日志文件，可以使用以下命令：

```bash
v-delete-user-log johndoe
```

执行此命令后，系统将查找并删除位于 Hestia 数据目录下 `johndoe` 用户的日志文件（通常是 `history.log`）。

#### 示例 2：删除系统日志文件（如果支持）

如果 Hestia 支持删除系统日志文件，并且您想执行此操作，可以简单地运行命令而不带用户名参数：

```bash
v-delete-user-log
```

注意：这个行为可能因 Hestia 的具体配置和版本而异，一些版本可能不允许直接删除系统日志。

#### 示例 3：结合脚本使用

如果您经常需要清理用户日志，可以将 `v-delete-user-log` 命令集成到脚本中，以便自动化此过程。例如，以下是一个简单的 Bash 脚本，用于删除多个用户的日志文件：

```bash
#!/bin/bash

# 用户列表
USERS=("johndoe" "janedoe" "exampleuser")

# 遍历用户列表并删除其日志文件
for USER in "${USERS[@]}"; do
    v-delete-user-log "$USER"
    if [ $? -eq 0 ]; then
        echo "用户 $USER 的日志文件已成功删除。"
    else
        echo "删除用户 $USER 的日志文件时出错。"
    fi
done
```

### 注意事项

- 在执行此命令之前，请确保您有足够的权限来删除指定的日志文件。
- 请谨慎使用此命令，因为删除日志文件可能会导致数据丢失。在执行任何删除操作之前，最好先备份重要数据。
- 如果您的 Hestia 版本或配置不支持某些功能（如删除系统日志），请查阅相关的官方文档或联系支持团队以获取更多信息。

## v-delete-user-notification

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-user-notification)

### 简介

`v-delete-user-notification` 是 Hestia 提供的 CLI（命令行接口）命令之一，用于删除用户的通知。通过该命令，系统管理员可以方便地管理用户接收到的通知，保持用户界面的清洁和有序。

### 语法

```bash
v-delete-user-notification USER NOTIFICATION_ID
```

- `USER`：需要删除通知的用户的用户名或ID。
- `NOTIFICATION_ID`：需要删除的通知的ID。如果设置为 "all"，则会删除该用户的所有通知。

### 示例

#### 示例1：删除特定用户的单个通知

假设我们需要删除用户名为 "admin" 的用户的通知ID为 "1" 的通知，可以使用以下命令：

```bash
v-delete-user-notification admin 1
```

执行该命令后，系统将删除用户 "admin" 的通知ID为 "1" 的通知。

#### 示例2：删除特定用户的所有通知

如果我们需要删除用户名为 "admin" 的用户的所有通知，可以将 `NOTIFICATION_ID` 设置为 "all"，并使用以下命令：

```bash
v-delete-user-notification admin all
```

执行该命令后，系统将删除用户 "admin" 的所有通知。

### 注意事项

- 在执行删除操作前，请确保已经正确指定了用户和通知ID，以避免误删除重要通知。
- 如果用户不存在或通知ID无效，系统将返回相应的错误信息。

### 返回值

- 如果删除操作成功，系统将返回成功信息。
- 如果删除操作失败（例如，用户不存在、通知ID无效等），系统将返回错误信息。

### 日志记录

该命令的执行结果将被记录在 Hestia 的系统日志中，方便管理员进行后续跟踪和审计。

### 总结

`v-delete-user-notification` 命令是 Hestia 提供的一个实用的 CLI 命令，用于删除用户的通知。通过该命令，管理员可以方便地管理用户通知，提高用户界面的清晰度和有序性。在实际使用中，请务必注意命令的语法和参数，以确保操作的正确性和有效性。

## v-delete-user-package

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-user-package)

### 描述

`v-delete-user-package` 是 Hestia 提供的一个命令行接口（CLI）命令，用于删除特定的用户套餐。如果用户正在使用该套餐，那么系统会自动将这些用户更新为使用默认套餐。

### 用法

```bash
v-delete-user-package [选项] PACKAGE
```

### 选项

* **PACKAGE**：必选参数，指定要删除的套餐名称。

### 示例

1. **删除名为 'admin' 的用户套餐**

```bash
v-delete-user-package admin
```

执行此命令后，系统将删除名为 'admin' 的用户套餐，并将正在使用该套餐的用户更新为默认套餐。

2. **删除名为 'palegreen' 的用户套餐，并确认**

虽然 `v-delete-user-package` 命令本身不提供直接的确认机制，但你可以在执行命令前通过其他方式（如 `read` 命令）来要求用户确认。


```bash
read -p "Are you sure you want to delete the 'palegreen' package? (y/n) " confirm
if [[ $confirm =~ ^[Yy]$ ]]; then
    v-delete-user-package palegreen
    echo "Package 'palegreen' deleted successfully."
else
    echo "Package deletion cancelled."
fi
```
在这个示例中，我们使用了 `read` 命令来要求用户输入 'y' 或 'n' 以确认是否删除 'palegreen' 套餐。如果用户输入 'y' 或 'Y'，则执行删除操作；否则，打印一条取消消息。

### 注意事项

* 在执行删除操作之前，请确保您已备份所有重要数据，以防意外情况发生。
* 如果要删除的套餐正在被多个用户使用，系统将自动将这些用户更新为默认套餐。请确保默认套餐满足这些用户的需求。
* 在生产环境中执行此类操作之前，请先在测试环境中进行验证，以确保一切按预期进行。

## v-delete-user-sftp-jail

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-user-sftp-jail)

### 概述

在Hestia控制面板中，SFTP Jail功能允许管理员限制SFTP用户的访问范围，将其限制在特定的目录结构中。本指南将详细介绍如何使用Hestia提供的CLI命令`v-delete-user-sftp-jail`来删除SFTP用户的Jail设置，并提供了多个示例以帮助用户更好地理解。

* 此功能解除 USER 的 sftp 的jailed环境系统调用或类似的机制将用户的进程限制在一个特定的文件系统目录权限

### 使用方法

要删除SFTP用户的Jail设置，您可以使用以下命令格式：

```bash
v-delete-user-sftp-jail USERNAME
```

其中`USERNAME`是您要删除SFTP Jail设置的用户名。

#### 示例

1. **删除名为"whistler"的用户的SFTP Jail设置**

```bash
v-delete-user-sftp-jail whistler
```

运行上述命令后，系统将检查是否存在名为"whistler"的用户，并确认其SFTP Jail设置。如果一切正常，系统将删除该用户的SFTP Jail设置。

2. **处理不存在的用户**

如果尝试删除不存在的用户，系统将返回一个错误消息。例如：

```bash
v-delete-user-sftp-jail nonexistentuser
```

运行上述命令后，系统将检查是否存在名为"nonexistentuser"的用户，并发现该用户不存在。因此，系统将返回一个错误消息。

3. **处理非SFTP用户**

如果尝试删除的用户不是SFTP用户（即未在`/etc/ssh/sshd_config`中配置为SFTP用户），系统将返回一个错误消息。这是因为只有SFTP用户才具有SFTP Jail设置。

### 工作原理

`v-delete-user-sftp-jail`命令的工作原理如下：

1. **参数验证**：命令首先验证是否提供了正确的参数（即用户名）。
2. **用户验证**：系统检查`/etc/passwd`文件以确认用户是否存在。
3. **SFTP Jail验证**：系统检查`/etc/ssh/sshd_config`文件以确认用户是否已配置为SFTP用户，并且SFTP Jail设置是否存在。
4. **只读模式检查**：如果Hestia处于只读模式（通常用于演示环境），系统将返回一个错误消息并阻止删除操作。
5. **删除SFTP Jail设置**：如果所有验证都通过，系统将从`/etc/ssh/sshd_config`文件中删除用户的SFTP Jail设置。
6. **恢复目录权限**：如果用户的家目录（默认为`/home/USERNAME`）存在，系统将恢复该目录的所有权给用户。
7. **删除chroot jail**：最后，系统将删除与用户关联的SFTP和FTP chroot jail设置。

### 注意事项

* 在运行此命令之前，请确保您已备份了相关配置文件（如`/etc/ssh/sshd_config`），以防意外情况发生。
* 请谨慎使用此命令，确保您知道要删除哪个用户的SFTP Jail设置。
* 如果您在删除SFTP Jail设置后遇到任何问题，请检查相关日志文件以获取更多信息。

### 总结

`v-delete-user-sftp-jail`命令是Hestia控制面板提供的一个实用工具，用于删除SFTP用户的SFTP Jail设置。通过本指南，您应该已经了解了如何使用该命令以及它的工作原理。如果您有任何疑问或需要进一步的帮助，请随时联系Hestia支持团队。

## v-delete-user-ssh-key

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-user-ssh-key)

### 简介

`v-delete-user-ssh-key` 是一个由hestia提供的CLI（命令行接口）命令，用于从指定用户的SSH授权密钥文件中删除特定的SSH密钥。这个命令在需要撤销用户访问权限或更新密钥的场景中非常有用。

### 用法

```bash
v-delete-user-ssh-key <USER> <KEY_ID>
```

* `<USER>`：要删除SSH密钥的用户的用户名。
* `<KEY_ID>`：要删除的SSH密钥的唯一标识符。这通常是在SSH授权密钥文件中每行密钥前的注释或标识。

### 示例

**示例1**：删除用户"john_doe"的SSH密钥，其密钥ID为"johndoe_rsa_key_2023"

```bash
v-delete-user-ssh-key john_doe johndoe_rsa_key_2023
```

执行此命令后，系统将从用户"john_doe"的SSH授权密钥文件中删除与密钥ID"johndoe_rsa_key_2023"匹配的密钥行。

**示例2**：删除用户"jane_smith"的默认SSH密钥（假设默认密钥没有特定的密钥ID）

在这种情况下，你可能需要手动编辑SSH授权密钥文件或使用其他工具/脚本来找到并删除默认密钥。但是，如果你知道默认密钥的确切内容或某种标识符，你可以使用`grep`和`sed`等命令组合来删除它。这不是`v-delete-user-ssh-key`命令的直接用法，但可以作为参考。

### 注意事项

1. **权限**：运行`v-delete-user-ssh-key`命令的用户通常需要有足够的权限来访问和修改目标用户的SSH授权密钥文件。
2. **密钥ID**：确保提供的密钥ID与SSH授权密钥文件中的密钥行匹配。如果密钥ID不正确，命令将无法找到并删除正确的密钥。
3. **备份**：在删除任何密钥之前，建议备份SSH授权密钥文件以防止意外删除或数据丢失。
4. **验证**：删除密钥后，建议验证SSH访问以确保已正确删除密钥并撤销了相应的访问权限。

### 结论

`v-delete-user-ssh-key`命令是一个强大的工具，用于从用户的SSH授权密钥文件中删除特定的SSH密钥。通过正确使用该命令并遵循上述注意事项，你可以安全地撤销用户的SSH访问权限或更新其密钥。

## v-delete-user-stats

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-user-stats)

### 简介

`v-delete-user-stats` 是 Hestia 提供的 CLI（命令行接口）命令之一，用于删除指定用户的使用统计数据。这个命令可以在管理用户数据、清理过期数据或保护用户隐私等场景中起到关键作用。

### 语法

```bash
v-delete-user-stats USER [DOMAIN]
```

* `USER`：必需参数，指定要删除使用统计数据的用户名。
* `DOMAIN`：可选参数，指定用户所属的域名。如果不指定，则默认为全局统计数据。

### 示例

#### 示例 1：删除指定用户的使用统计数据

```bash
v-delete-user-stats user1
```

这个命令将删除名为 `user1` 的用户的使用统计数据。如果 `user1` 是全局用户，则不需要指定 `DOMAIN` 参数。

#### 示例 2：删除指定用户在特定域名下的使用统计数据

```bash
v-delete-user-stats user2 domain.com
```

这个命令将删除名为 `user2` 的用户在 `domain.com` 域名下的使用统计数据。

#### 示例 3：删除全局用户（root 用户）的所有使用统计数据

```bash
v-delete-user-stats root overall
```

在这个例子中，`root` 通常代表全局用户或管理员用户。`overall` 关键字表示要删除的是全局统计数据，而不是特定域名下的数据。

### 注意事项

* 在执行 `v-delete-user-stats` 命令之前，请确保您有足够的权限来删除这些数据。
* 删除用户统计数据是一个不可逆的操作，因此请务必谨慎操作。
* 如果在删除过程中出现任何错误或问题，请查阅 Hestia 的官方文档或联系技术支持以获取帮助。

### 日志记录

当使用 `v-delete-user-stats` 命令删除用户统计数据时，Hestia 会记录相应的日志信息。这些日志信息可以帮助您跟踪操作的历史记录，并在需要时进行审计。具体的日志记录方式和位置可能因 Hestia 的配置而异，请参考您的 Hestia 安装文档或联系技术支持以获取更多信息。

## 更新系列命令

## v-update-user-counters

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-user-counters)

### 简介

`v-update-user-counters` 是Hestia控制面板提供的CLI（命令行接口）命令之一。该命令的主要功能是更新用户的资源使用计数器，如U_WEB_DOMAINS（Web域名数量）、U_MAIL_ACCOUNTS（邮件账户数量）等。这对于维护用户资源的准确性以及限制用户资源使用上限至关重要。

### 用法

```bash
v-update-user-counters USER
```

- `USER`：需要更新使用计数器的用户名。

### 示例

#### 示例1：更新特定用户的使用计数器

假设我们要更新名为`admin`的用户的使用计数器，可以执行以下命令：

```bash
v-update-user-counters admin
```

执行此命令后，系统将自动检查并更新`admin`用户的所有资源使用计数器。

#### 示例2：批量更新用户的使用计数器

如果需要批量更新多个用户的使用计数器，可以结合其他工具（如`xargs`、`parallel`等）与`v-update-user-counters`命令一起使用。以下是一个使用`xargs`的示例，该示例从用户列表文件中读取用户名，并逐个更新它们的使用计数器：

首先，创建一个包含用户名的文本文件（例如`users.txt`）：

```bash
echo -e "user1\nuser2\nuser3" > users.txt
```

然后，使用`xargs`结合`v-update-user-counters`命令来更新这些用户的使用计数器：

```bash
cat users.txt | xargs -I {} v-update-user-counters {}
```

这条命令将读取`users.txt`文件中的每一行（即每个用户名），并将其作为参数传递给`v-update-user-counters`命令来执行。

### 注意事项

1. 在执行此命令之前，请确保您已经以具有足够权限的用户身份登录到系统（通常是root用户或具有相应权限的管理员用户）。
2. 如果在更新过程中遇到任何错误或问题，请查看Hestia的日志文件以获取更多信息，并根据需要进行故障排除。
3. 请注意，此命令仅更新资源使用计数器，而不会更改或限制用户的实际资源使用。如果您需要限制用户的资源使用，请使用Hestia控制面板中的相应功能进行设置。

## v-update-user-disk

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-user-disk)

`v-update-user-disk` 是一个由 Hestia 提供的命令行工具，用于重新计算并更新特定用户的磁盘使用情况。该命令将扫描用户的家目录，并排除如 web、mail 和 conf 等指定目录，以获取准确的磁盘使用情况，并更新到相应的数据库或配置文件中。

### 基本语法

```bash
v-update-user-disk 用户名
```

其中，`用户名` 是你想要更新磁盘使用情况的用户的登录名。

### 示例

#### 示例 1: 更新 admin 用户的磁盘使用情况

```bash
v-update-user-disk admin
```

执行此命令后，系统将扫描 `admin` 用户的家目录，计算磁盘使用情况（排除 web、mail 和 conf 目录），并更新到 Hestia 的配置或数据库中。

### 注意事项

1. **权限**：执行 `v-update-user-disk` 命令的用户需要有足够的权限来访问和扫描目标用户的家目录，并更新 Hestia 的配置或数据库。
2. **排除目录**：默认情况下，`v-update-user-disk` 会排除用户的 web、mail 和 conf 目录。如果你需要排除其他目录，请查阅 Hestia 的文档以了解如何配置。
3. **错误处理**：如果命令执行过程中发生错误（如权限不足、用户不存在等），`v-update-user-disk` 将显示相应的错误消息。请仔细阅读这些消息，并根据需要进行相应的处理。
4. **日志记录**：Hestia 可能会记录 `v-update-user-disk` 命令的执行情况和结果。你可以查阅 Hestia 的日志文件以获取更多信息。

### 总结

`v-update-user-disk` 是一个实用的命令行工具，用于重新计算并更新 Hestia 用户的磁盘使用情况。通过提供用户名作为参数，你可以轻松地更新特定用户的磁盘使用情况，并确保 Hestia 的配置或数据库中的信息是准确的。如果你在使用过程中遇到任何问题或需要更多帮助，请查阅 Hestia 的官方文档或联系技术支持。

## v-update-user-package

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-user-package)

### 概述

`v-update-user-package` 是 Hestia 提供的一个 CLI（命令行接口）命令，用于更新连接到系统的用户的软件包。此命令接受一个参数，即要更新的软件包名称，并遍历所有已连接用户，检查其是否已安装该软件包，如果已安装，则执行更新操作。

### 用法

```bash
v-update-user-package [PACKAGE]
```

* `[PACKAGE]`：要更新的软件包名称。

### 示例

#### 示例 1：更新默认软件包

假设你想更新名为 "default" 的软件包到所有已连接用户，你可以使用以下命令：

```bash
v-update-user-package default
```

执行该命令后，系统将遍历所有已连接用户，检查其是否已安装 "default" 软件包，如果已安装，则执行更新操作。

#### 示例 2：更新特定用户的软件包

虽然 `v-update-user-package` 命令默认会更新所有已连接用户的软件包，但如果你只想更新特定用户的软件包，你可以结合其他 Hestia CLI 命令来实现。例如，你可以使用 `v-list-users` 命令列出所有用户，然后筛选出你想更新的用户，再单独对其执行 `v-change-user-package` 命令。但这通常比直接使用 `v-update-user-package` 命令更为繁琐。

### 注意事项

* 在执行 `v-update-user-package` 命令之前，请确保你已经以具有足够权限的用户身份登录系统。
* 请确保你要更新的软件包名称是正确的，以避免不必要的错误或问题。
* 如果在执行命令时遇到任何问题或错误，请检查 Hestia 的日志文件以获取更多信息。

### 返回值和日志

* 如果更新成功，`v-update-user-package` 命令通常会返回一个表示成功的状态码，并将相关日志记录到 Hestia 的日志文件中。
* 如果更新失败，命令将返回一个表示失败的状态码，并在日志文件中记录详细的错误信息。你可以使用这些信息来诊断问题并进行相应的修复。

## v-update-user-quota

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-user-quota)

### 概述

`v-update-user-quota` 是一个由 Hestia 提供的命令行接口（CLI）命令，用于更新特定用户的磁盘配额。该命令允许系统管理员根据用户需求或系统策略，调整用户的硬配额和软配额限制。

### 语法

```bash
v-update-user-quota [USER]
```

### 参数

* `USER`：必需参数，指定要更新磁盘配额的用户名。

### 示例

#### 示例 1：更新用户 Alice 的磁盘配额

假设您希望为用户 Alice 设置磁盘配额，其中硬配额为 10GB，软配额为 9GB（即硬配额的 90%）。您可以使用以下命令：

```bash
v-update-user-quota alice
```

注意：此命令假定有一个后端的逻辑或脚本，它会根据用户的套餐或系统策略自动计算并设置配额值。在上面的示例中，我们没有直接指定配额值，而是依赖 Hestia 的配置和策略来确定。

#### 示例 2：为用户 Bob 设置无限配额

如果您希望为用户 Bob 设置无限磁盘配额，可以使用相同的命令，但可能需要在命令之前或之后执行一些额外的步骤来确保配额策略正确更新。这取决于 Hestia 的具体实现。

```bash
v-update-user-quota bob
```

然后，您可能需要手动或通过其他命令/脚本更新 Bob 的配额策略，以允许无限配额。

#### 示例 3：检查用户 Charlie 的当前配额

虽然 `v-update-user-quota` 命令本身不直接用于检查用户的当前配额，但您可以结合其他 Hestia 提供的命令或工具来完成此操作。例如，假设有一个名为 `v-show-user-quota` 的命令可用于此目的：

```bash
v-show-user-quota charlie
```

这将显示用户 Charlie 的当前磁盘配额设置。

### 注意事项

* 在使用 `v-update-user-quota` 命令之前，请确保您已正确配置 Hestia 并具有适当的权限来修改用户配额。
* 配额的具体值和策略可能因系统而异，并且可能受到用户套餐、系统策略或其他因素的影响。因此，在使用此命令时，请务必参考 Hestia 的官方文档或相关资源以获取更多详细信息。
* 在执行任何更改之前，请务必备份重要数据以防止意外丢失或损坏。

## v-update-user-stats

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-user-stats)

### 概述

`v-update-user-stats` 是 Hestia 提供的一个命令行工具，用于更新用户统计信息。此命令可以帮助管理员快速获取并更新系统中用户的各种资源使用情况，从而进行更有效的资源管理和分配。

### 语法

```bash
v-update-user-stats [USER]
```

- `[USER]`：可选参数，指定要更新统计信息的用户名。如果不提供用户名，则会更新所有用户的统计信息。

### 使用示例

#### 示例 1：更新所有用户的统计信息

当你不指定任何用户名时，`v-update-user-stats` 命令会更新系统中所有用户的统计信息。

```bash
v-update-user-stats
```

执行此命令后，系统将遍历所有用户，并更新他们的资源使用情况统计信息。

#### 示例 2：更新指定用户的统计信息

如果你只想更新某个特定用户的统计信息，可以在命令后加上用户名。

```bash
v-update-user-stats admin
```

在这个例子中，`admin` 是要更新统计信息的用户名。执行此命令后，系统将只更新 `admin` 用户的资源使用情况统计信息。

### 注意事项

1. **权限**：执行此命令需要相应的权限。确保你有足够的权限来执行此操作，或者在使用前联系系统管理员。
2. **性能**：当更新大量用户的统计信息时，此命令可能会消耗一定的系统资源。建议在系统负载较低时执行此操作，以避免对系统性能产生不良影响。
3. **数据准确性**：确保 Hestia 的相关配置和数据文件（如用户配置文件）是最新的，以确保统计信息的准确性。
4. **错误处理**：如果命令执行过程中出现错误，请检查命令语法、用户名是否正确，以及系统是否有足够的权限和资源来执行此操作。如有需要，可以查看 Hestia 的日志文件以获取更详细的错误信息。

### 结论

`v-update-user-stats` 命令是 Hestia 提供的一个非常有用的工具，用于更新用户统计信息。通过合理地使用此命令，管理员可以轻松地获取并更新系统中用户的资源使用情况统计信息，从而更好地管理系统资源。

## 取消系列命令

## v-unsuspend-user

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-unsuspend-user)

### 概述

`v-unsuspend-user` 是 Hestia 提供的命令行接口（CLI）命令之一，用于取消挂起（unsuspend）指定的用户账户及其关联的所有对象。这包括用户的 FTP、SFTP、SSH 访问权限，Web 域名，DNS 域名，邮件域名，数据库，以及 cron 作业等。

### 用法

```bash
v-unsuspend-user USER [RESTART]
```

- `USER`：要取消挂起的用户账户的用户名。
- `RESTART`（可选）：一个可选参数，用于指定是否需要重启相关系统服务。如果提供此参数，则相关的系统服务（如 Web 服务器、DNS 服务器等）将被重启。

### 示例

#### 示例 1：取消挂起用户并重启相关服务

```bash
v-unsuspend-user bob yes
```

在这个示例中，我们取消了用户 `bob` 的挂起状态，并指定了 `yes` 参数以重启相关的系统服务。

#### 示例 2：仅取消挂起用户，不重启服务

```bash
v-unsuspend-user alice
```

在这个示例中，我们仅取消了用户 `alice` 的挂起状态，而没有指定 `RESTART` 参数，因此相关的系统服务不会被重启。

### 注意事项

- 在执行 `v-unsuspend-user` 命令之前，请确保您有足够的权限来取消用户的挂起状态。
- 如果在执行命令时遇到任何问题，请检查 Hestia 的日志文件以获取更多信息。
- 如果在取消挂起用户后需要重启系统服务，请确保在执行 `v-unsuspend-user` 命令时提供 `RESTART` 参数。

### 关联命令

- `v-suspend-user`：用于挂起指定的用户账户及其关联的所有对象。
- `v-restart-web`：用于重启 Web 服务器服务。
- `v-restart-dns`：用于重启 DNS 服务器服务（如果可用）。

### 结论

`v-unsuspend-user` 命令是 Hestia 提供的一个强大工具，用于取消挂起用户账户及其关联的所有对象。通过合理地使用此命令，您可以轻松地管理 Hestia 系统中的用户账户状态。

## v-unsuspend-web-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-unsuspend-web-domain)

### 概述

`v-unsuspend-web-domain` 是 Hestia 提供的 CLI 命令，用于取消挂起（unsuspend）特定的 web 域名。当某个 web 域名因为某种原因被挂起时，可以使用此命令来恢复其正常状态。

### 语法

```bash
v-unsuspend-web-domain USER DOMAIN [RESTART]
```

- `USER`: 执行操作的 Hestia 用户名。
- `DOMAIN`: 要取消挂起的 web 域名。
- `[RESTART]`: 可选参数，如果提供，则会在取消挂起后重启 web 服务。

### 示例

#### 示例 1: 取消挂起域名，不重启服务

```bash
v-unsuspend-web-domain admin acme.com
```

在此示例中，我们为名为 "admin" 的用户取消了 "acme.com" 域名的挂起状态，并且没有选择重启 web 服务。

#### 示例 2: 取消挂起域名并重启服务

```bash
v-unsuspend-web-domain admin example.org RESTART
```

在此示例中，我们为名为 "admin" 的用户取消了 "example.org" 域名的挂起状态，并且在操作完成后选择了重启 web 服务。

### 注意事项

1. **用户权限**：执行此命令的用户必须具有足够的权限来取消域名的挂起状态。
2. **域名状态**：在尝试取消挂起之前，请确保该域名当前处于挂起状态。
3. **服务重启**：如果选择了重启服务，请确保当前系统允许这样做，并且了解重启服务可能带来的影响。
4. **错误处理**：如果命令执行失败，请检查命令语法、用户权限以及域名状态是否正确。

## v-unsuspend-web-domains

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-unsuspend-web-domains)

### 概述

`v-unsuspend-web-domains` 命令是 Hestia Control Panel 中的一个命令行工具，用于恢复（取消暂停）指定用户的所有网站。此命令在管理员需要快速恢复用户网站时非常有用。

### 语法

```bash
v-unsuspend-web-domains [选项] 用户名 [重启选项]
```

### 选项

* **用户名**：必填参数，指定要恢复网站的用户名。
* **重启选项**（可选）：指定是否重启 web 服务器和代理服务器。有效值为 "yes" 或 "no"，默认为 "no"。

### 示例

#### 示例 1：恢复指定用户的所有网站（不重启服务）

```bash
v-unsuspend-web-domains admin
```

在上面的示例中，我们使用 `admin` 作为用户名来恢复该用户的所有网站。默认情况下，该命令不会重启 web 服务器或代理服务器。

#### 示例 2：恢复指定用户的所有网站并重启服务

```bash
v-unsuspend-web-domains admin yes
```

在这个示例中，我们不仅要恢复 `admin` 用户的所有网站，还要在完成后重启 web 服务器和代理服务器。这可以通过在命令末尾添加 `yes` 参数来实现。

#### 示例 3：结合其他命令使用

`v-unsuspend-web-domains` 命令可以与其他 Hestia CLI 命令结合使用，以实现更复杂的任务。例如，您可以使用脚本自动暂停和恢复网站，或者在恢复网站后立即执行其他管理任务。

### 注意事项

* 在使用此命令之前，请确保您具有足够的权限来恢复网站。
* 如果在恢复网站时遇到任何问题，请检查 Hestia 的日志文件以获取更多信息。
* 在生产环境中使用此命令时，请务必谨慎，并确保您了解该命令的影响。

### 结论

`v-unsuspend-web-domains` 命令是 Hestia Control Panel 中的一个强大工具，用于快速恢复指定用户的所有网站。通过结合其他选项和参数，您可以根据需要自定义命令的行为。在使用此命令时，请确保遵循最佳实践并注意潜在的风险。

## v-suspend-user

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-suspend-user)

`v-suspend-user` 是 Hestia 提供的 CLI（命令行接口）命令之一，用于暂停或挂起特定用户的账户及其相关对象。这个命令在需要暂时禁止用户访问系统资源或执行某些操作时非常有用。

### 语法

```bash
v-suspend-user USER [RESTART]
```

- `USER`: 需要挂起的用户名称。
- `[RESTART]`: 可选参数，用于指定是否重新启动相关服务。通常设置为 "yes" 或 "no"，或者简单地使用 "y" 或 "n"。如果未指定，则默认为 "no"。

### 功能

- 挂起指定用户的账户，禁止其登录系统。
- 暂停与该用户相关的所有对象，如 FTP 账户、Web 域名、邮件域名等。
- 根据配置选项，可选择是否重新启动相关服务以确保更改立即生效。

### 示例

#### 示例 1: 挂起用户并重启服务

```bash
v-suspend-user alice yes
```

这个命令将挂起用户 "alice" 的账户，并重启与该用户相关的所有服务。

#### 示例 2: 仅挂起用户，不重启服务

```bash
v-suspend-user bob no
```

这个命令将仅挂起用户 "bob" 的账户，不重启任何服务。

#### 示例 3: 批量挂起多个用户

你可以结合 shell 脚本和 `v-suspend-user` 命令来批量挂起多个用户。例如，假设你有一个包含需要挂起用户名称的列表文件 `users_to_suspend.txt`，你可以使用以下脚本批量挂起这些用户：

```bash
#!/bin/bash

# 读取用户列表文件
while IFS= read -r user; do
    v-suspend-user "$user" no
done < "users_to_suspend.txt"
```

这个脚本将逐行读取 `users_to_suspend.txt` 文件中的用户名，并使用 `v-suspend-user` 命令挂起这些用户的账户，同时不重启任何服务。

### 注意事项

- 在使用 `v-suspend-user` 命令之前，请确保你有足够的权限来执行此操作。
- 挂起用户账户将影响该用户的所有活动和服务，因此请确保在执行此操作之前通知相关用户或确保该用户当前没有执行任何重要任务。
- 如果指定了 `[RESTART]` 参数并设置为 "yes"，请确保重启服务不会对系统造成任何不利影响，并且你有适当的备份和恢复策略。

## v-suspend-web-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-suspend-web-domain)

在Hestia控制面板中，`v-suspend-web-domain` 是一个用于暂停网站操作的命令行工具。当网站被暂停后，所有访问者将被重定向到一个解释暂停原因的网页，而网站的所有目录内容将保持不变。

### 使用方法

`v-suspend-web-domain` 命令接受以下参数：

- `USER`: 用于标识网站所有者的用户名。
- `DOMAIN`: 要暂停的网站的域名。
- `[RESTART]`: 可选参数，用于指定是否重启Web服务器。默认为不重启。如果设置为 `yes` 或 `1`，则重启Web服务器。

### 示例

#### 示例 1: 暂停网站而不重启服务器

```bash
v-suspend-web-domain admin example.com
```

在这个例子中，`admin` 是网站所有者的用户名，`example.com` 是要暂停的网站的域名。执行此命令后，`example.com` 网站将被暂停，但Web服务器不会自动重启。

#### 示例 2: 暂停网站并重启服务器

```bash
v-suspend-web-domain admin example.com yes
```

或者

```bash
v-suspend-web-domain admin example.com 1
```

在这个例子中，除了暂停 `example.com` 网站外，还指定了 `yes`（或 `1`）作为第三个参数，表示在暂停后重启Web服务器。

### 注意事项

- 确保在执行此命令之前已经以正确的用户身份登录到Hestia控制面板。
- 暂停网站是一个敏感操作，请确保在执行之前已经备份了所有重要数据。
- 暂停网站可能会导致搜索引擎暂时无法索引该网站，因此在恢复网站之前请确保已经解决了所有问题。

### 返回值和错误处理

`v-suspend-web-domain` 命令将返回一个退出状态码，用于指示命令是否成功执行。如果命令执行成功，将返回 `0`；否则，将返回非零值。如果发生错误，可以通过检查Hestia的日志文件来获取更多信息。

### 总结

`v-suspend-web-domain` 是一个强大的命令行工具，允许您轻松暂停Hestia控制面板中的网站。通过提供正确的参数和选项，您可以灵活地控制网站的状态，并确保在维护或升级过程中不会影响到用户体验。

## v-suspend-web-domains

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-suspend-web-domains)

### 概述

`v-suspend-web-domains` 是 Hestia 提供的 CLI 命令之一，用于暂停指定用户的所有网站。此命令在维护、升级或处理安全事件时特别有用，允许管理员在不中断服务的情况下，暂时将用户的网站置于暂停状态。

### 语法

```bash
v-suspend-web-domains USER [RESTART]
```

- `USER`：要暂停其所有网站的用户的用户名。
- `[RESTART]`：（可选）在暂停网站后是否重启 Web 服务器和代理的标志。如果指定，命令将在完成网站暂停后尝试重启 Web 服务器和代理。

### 示例

#### 示例 1：暂停用户 "john" 的所有网站

```bash
v-suspend-web-domains john
```

执行上述命令后，系统将暂停用户 "john" 拥有的所有网站。默认情况下，此命令不会重启 Web 服务器或代理。

#### 示例 2：暂停用户 "jane" 的所有网站并重启 Web 服务器和代理

```bash
v-suspend-web-domains jane RESTART
```

在这个例子中，除了暂停用户 "jane" 的所有网站外，命令还会尝试重启 Web 服务器和代理。这可以在需要确保更改立即生效的情况下使用。

### 注意事项

1. **权限**：执行 `v-suspend-web-domains` 命令需要适当的系统权限。通常，只有具有管理员权限的用户才能执行此命令。
2. **日志记录**：Hestia 会记录所有 CLI 命令的执行情况，包括 `v-suspend-web-domains`。管理员应该定期检查日志文件，以确保命令按预期执行。
3. **重启选项**：虽然 `[RESTART]` 选项可以确保更改立即生效，但在高负载或生产环境中使用时应该谨慎。重启 Web 服务器和代理可能会对正在进行的操作或用户体验产生影响。
4. **错误处理**：如果命令执行失败（例如，由于权限问题或用户不存在），Hestia 将显示错误消息。管理员应该仔细阅读并处理这些错误消息。

### 总结

`v-suspend-web-domains` 是一个强大的 Hestia CLI 命令，允许管理员轻松暂停指定用户的所有网站。通过结合使用可选的 `[RESTART]` 选项，管理员可以确保更改立即生效，同时保持对系统性能的敏感性和对用户体验的关注。

## 日志系列命令

## v-log-action

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-log-action)

`v-log-action` 是 Hestia 提供的一个命令行工具，用于记录用户或系统操作日志。通过该命令，用户可以将特定的操作事件添加到日志中，以便于后续的追踪和分析。

### 基本语法

```bash
v-log-action [OPTIONS] USER LEVEL CATEGORY DETAILS
```

- `USER`: 操作的用户类型，可以是 "user" 或 "system"。
- `LEVEL`: 事件级别，包括 "Info", "Warning", 和 "Error"。
- `CATEGORY`: 事件类别，根据用户或系统类型有不同的选择。
- `DETAILS`: 事件的详细描述。

### 选项参数

（注意：这里列举的是一些可能的选项参数，具体取决于 Hestia 的版本和配置）

- `-h, --help`: 显示帮助信息并退出。
- `--verbose`: 显示详细的执行过程。
- `--config FILE`: 指定配置文件的位置。

### 示例

#### 示例 1: 记录用户操作日志

```bash
v-log-action user Info web "User JohnDoe updated his website content."
```

这条命令将记录一个用户操作日志，用户名为 "JohnDoe"，事件级别为 "Info"，事件类别为 "web"，详细描述为 "User JohnDoe updated his website content."。

#### 示例 2: 记录系统操作日志

```bash
v-log-action system Warning service "Nginx service restarted due to configuration changes."
```

这条命令将记录一个系统操作日志，用户类型为 "system"，事件级别为 "Warning"，事件类别为 "service"，详细描述为 "Nginx service restarted due to configuration changes."。

#### 示例 3: 使用详细输出

```bash
v-log-action --verbose user Info web "New website content uploaded."
```

通过添加 `--verbose` 选项，你可以看到命令执行的详细过程，包括配置文件加载、参数验证等步骤。

### 注意事项

- 在使用 `v-log-action` 命令之前，请确保已经正确安装了 Hestia，并且相关的配置文件和环境变量已经设置正确。
- 请根据实际情况选择合适的用户类型、事件级别和事件类别。
- 详细描述应该尽可能清晰、准确地描述操作的内容和结果。

### 总结

`v-log-action` 是一个强大的命令行工具，可以帮助你轻松地记录用户和系统操作日志。通过合理地使用它，你可以提高系统的可维护性和安全性。

## v-log-user-login

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-log-user-login)

### 命令概述

`v-log-user-login` 是 Hestia 提供的一个命令行接口（CLI）命令，用于记录用户登录事件。该命令可以捕获用户登录的详细信息，如用户名、IP 地址、登录状态等，并将这些信息记录到日志文件中，以供后续分析和审计使用。

### 命令语法

```bash
v-log-user-login [选项] 用户名 IP地址 登录状态 [其他参数]
```

* **用户名**：执行登录操作的用户名。
* **IP地址**：用户登录时使用的IP地址。
* **登录状态**：登录操作的状态，如成功（success）或失败（failed）。
* **其他参数**：可选参数，如用户代理（User-Agent）、会话ID（Session ID）等。

### 命令选项

（注意：这里列出的选项可能因 Hestia 版本而异，具体请参考官方文档。）

* **-a, --authlog**：是否将登录事件记录到 Hestia 的主日志文件中。默认为不记录。
* **-r, --reason**：登录失败的原因（仅当登录状态为失败时有效）。
* **-h, --help**：显示命令帮助信息。

### 示例

#### 示例 1：记录用户成功登录事件

```bash
v-log-user-login john 192.168.1.100 success
```

此命令将记录用户名为 `john`、IP地址为 `192.168.1.100` 的用户成功登录的事件。默认情况下，该事件将被记录到 Hestia 指定的用户登录日志文件中。

#### 示例 2：记录用户失败登录事件，并指定原因

```bash
v-log-user-login jane 10.0.0.1 failed --reason "invalid credentials"
```

此命令将记录用户名为 `jane`、IP地址为 `10.0.0.1` 的用户登录失败的事件，并指定失败原因为 "invalid credentials"。同样地，该事件将被记录到用户登录日志文件中。

#### 示例 3：将登录事件记录到主日志文件中

```bash
v-log-user-login admin 127.0.0.1 success --authlog
```

此命令不仅将用户名为 `admin`、IP地址为 `127.0.0.1` 的用户成功登录的事件记录到用户登录日志文件中，还将该事件记录到 Hestia 的主日志文件中。这有助于在更广泛的上下文中审计和分析登录事件。

### 注意事项

* 确保你有足够的权限来执行 `v-log-user-login` 命令。
* 根据你的 Hestia 配置和版本，命令的语法和选项可能有所不同。请始终参考官方文档以获取最新和最准确的信息。
* 记录登录事件对于安全审计和故障排查非常重要，请确保定期查看和分析这些日志。

## v-log-user-logout

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-log-user-logout)

### 概述

`v-log-user-logout` 是 Hestia 提供的 CLI (命令行接口) 命令之一，用于记录用户登出事件。此命令接受两个参数：用户名（USER）和会话ID（SESSION_ID），并在指定的日志文件中更新相应会话的状态为“不活跃”（ACTIVE='no'）。

### 参数说明

- **USER**：必需参数，表示执行登出操作的用户名。
- **SESSION_ID**：必需参数，表示要注销的会话的ID。

### 使用示例

#### 示例 1：记录用户 'john_doe' 的会话 'abcd1234' 的登出事件

```bash
v-log-user-logout john_doe abcd1234
```

执行上述命令后，Hestia 将在其配置的日志文件中搜索包含 `SESSION='abcd1234' ACTIVE='yes'` 的行，并将其更新为 `SESSION='abcd1234' ACTIVE='no'`。如果日志文件不存在，命令将创建它。

#### 示例 2：结合脚本使用

在某些场景中，您可能希望从脚本中调用 `v-log-user-logout` 命令。以下是一个简单的示例，展示如何在 Bash 脚本中执行此操作：

```bash
#!/bin/bash

# 设置用户名和会话ID
USER="jane_smith"
SESSION_ID="efgh5678"

# 调用v-log-user-logout命令
v-log-user-logout "$USER" "$SESSION_ID"

# 检查命令执行结果（此部分可能需要根据实际情况添加）
if [ $? -eq 0 ]; then
    echo "用户 $USER 的会话 $SESSION_ID 已成功登出。"
else
    echo "记录用户登出事件时发生错误。"
fi
```

### 注意事项

- 确保在调用 `v-log-user-logout` 命令之前，Hestia 已经正确安装并配置好，相关配置文件（如 `/etc/hestiacp/hestia.conf`）存在且可读。
- 确保传递给命令的用户名和会话ID是有效的，并且用户确实具有该会话ID的活跃会话。
- 如果日志文件不存在，`v-log-user-logout` 命令将创建它，但请注意，这可能需要适当的文件权限。
- 如果在日志文件中找不到指定的会话ID，`sed` 命令将不会进行任何更改。
- 如果需要更复杂的会话管理功能（如会话超时、并发会话控制等），请考虑使用更全面的会话管理系统或库。

## 查看系列命令

## v-list-user

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-user)

### 介绍

`v-list-user` 是 Hestia 提供的一个命令行接口（CLI）命令，用于列出指定用户的参数信息。通过此命令，用户或管理员可以方便地获取用户相关的配置详情，以便于进行后续的操作或维护。

### 语法

```bash
v-list-user USER [FORMAT]
```

- `USER`：要查询参数的用户名。
- `FORMAT`（可选）：输出格式，默认为 `shell`。其他可选格式视 Hestia 版本和配置而定。

### 示例

#### 示例 1：查询用户 admin 的参数（默认格式）

```bash
v-list-user admin
```

执行上述命令后，Hestia 将以默认格式（通常是 shell 脚本形式）输出用户 admin 的相关参数信息。

#### 示例 2：查询用户 admin 的参数，并指定输出格式为 json

假设 Hestia 支持 json 格式输出，则可以执行以下命令：

```bash
v-list-user admin json
```

执行后，Hestia 将以 json 格式输出用户 admin 的相关参数信息，方便与其他系统或工具进行交互。

#### 示例 3：结合其他命令使用

`v-list-user` 命令的输出可以直接用于其他命令或脚本中。例如，可以结合 `grep` 命令来过滤特定的参数信息：

```bash
v-list-user admin | grep 'HOME='
```

上述命令将只输出包含 `HOME=` 的行，即用户 admin 的家目录路径。

### 注意事项

- 在执行 `v-list-user` 命令时，请确保已经正确安装了 Hestia，并且具有足够的权限来执行该命令。
- 如果指定的用户不存在或输入了错误的用户名，Hestia 将返回相应的错误消息。
- 如果指定的输出格式不受支持，Hestia 将使用默认格式进行输出。

### 结论

`v-list-user` 命令是 Hestia 提供的一个强大的工具，用于查询指定用户的参数信息。通过该命令，用户可以方便地获取所需的配置详情，并进行后续的操作或维护。

## v-list-user-auth-log

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-user-auth-log)

### 介绍

`v-list-user-auth-log` 是 Hestia 提供的一个命令行工具，用于列出特定用户的最近10条认证日志记录。这些日志记录可能包含用户登录、注销或其他与认证相关的活动。此命令支持多种输出格式，以满足不同用户的需求。

### 使用方法

```bash
v-list-user-auth-log USER [FORMAT]
```

- `USER`: 要查询的用户名。
- `FORMAT`: 可选参数，指定输出格式。默认为 "shell"。支持的格式包括 "shell"、"json" 和 "plain"。

### 示例

#### 示例 1：以默认 shell 格式列出用户 "john" 的认证日志

```bash
v-list-user-auth-log john
```

输出可能如下：

```shell
DATE~TIME~IP~SESSION~ACTIVE~STATUS
----~----~--~-----------~------
2023-04-01 10:00:00 192.168.1.100 ~session123~yes~success
2023-04-01 09:30:00 192.168.1.200 ~session456~no~failed
...
```

#### 示例 2：以 JSON 格式列出用户 "jane" 的认证日志

```bash
v-list-user-auth-log jane json
```

输出可能如下：

```json
{
  "1": {
    "DATE": "2023-04-01",
    "TIME": "10:30:00",
    "IP": "192.168.1.50",
    "ACTION": "login",
    "STATUS": "success",
    "USER_AGENT": "Mozilla/5.0...",
    "SESSION": "session789",
    "ACTIVE": "yes"
  },
  "2": {
    "DATE": "2023-03-31",
    "TIME": "20:00:00",
    "IP": "192.168.1.10",
    "ACTION": "logout",
    "STATUS": "success",
    "USER_AGENT": "Safari...",
    "SESSION": "sessionABC",
    "ACTIVE": "no"
  },
  ...
}
```

#### 示例 3：以 plain 格式列出用户 "admin" 的认证日志

```bash
v-list-user-auth-log admin plain
```

输出可能如下：

```plain
2023-04-01 11:00:00 192.168.1.250 login success
2023-04-01 10:45:00 192.168.1.150 logout failed
...
```

### 注意事项

- 输出内容可能因实际日志格式和系统配置而异。
- 如果用户不存在或没有相关日志记录，命令可能会返回空或错误信息。
- 使用该命令时，请确保您有足够的权限访问相关的日志文件和系统资源。

### 结论

`v-list-user-auth-log` 命令是 Hestia 系统中一个强大的工具，用于查询和管理用户认证日志。通过不同的输出格式，用户可以根据需要灵活地查看和分析这些数据，从而更好地理解和管理系统的安全性和用户活动。

## v-list-user-backups

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-user-backups)

### 概述

`v-list-user-backups` 命令是一个 Bash 脚本函数，用于获取指定用户的可用备份列表。该命令提供了多种输出格式选项，方便用户根据需求查看备份详情。

### 用法

```bash
v-list-user-backups USER [FORMAT]
```

- `USER`: 指定要查询备份列表的用户名。
- `FORMAT`: 可选参数，用于指定输出格式。默认为 `shell` 格式。支持以下格式：
  - `shell`: 以 shell 脚本格式输出，便于在脚本中解析。
  - `json`: 以 JSON 格式输出，方便与 JSON 解析工具配合使用。
  - `plain`: 以纯文本格式输出，每行包含备份的详细信息。
  - `csv`: 以 CSV 格式输出，便于在电子表格软件中查看和分析。

### 示例

#### 示例 1: 使用 shell 格式

```bash
v-list-user-backups admin shell
```

输出示例：

```bash
BACKUP TYPE SIZE TIME DATE
------ ---- --- ---- ----
backup1 full 10GB 2023-03-29T10:00:00Z 2023-03-29
backup2 incr 5GB 2023-03-28T12:30:00Z 2023-03-28
...
```

#### 示例 2: 使用 JSON 格式

```bash
v-list-user-backups admin json
```

输出示例：

```json
{
  "backup1": {
    "TYPE": "full",
    "SIZE": "10GB",
    "WEB": "...",
    "DNS": "...",
    "MAIL": "...",
    "DB": "...",
    "CRON": "...",
    "UDIR": "...",
    "RUNTIME": "...",
    "TIME": "2023-03-29T10:00:00Z",
    "DATE": "2023-03-29"
  },
  "backup2": {
    ...
  },
  ...
}
```

#### 示例 3: 使用 plain 格式

```bash
v-list-user-backups admin plain
```

输出示例：

```plain
backup1 full 10GB ... ... ... ... ... ... 2023-03-29T10:00:00Z 2023-03-29
backup2 incr 5GB ... ... ... ... ... ... 2023-03-28T12:30:00Z 2023-03-28
...
```

#### 示例 4: 使用 CSV 格式

```bash
v-list-user-backups admin csv
```

输出示例：

```csv
BACKUP,TYPE,SIZE,WEB,DNS,MAIL,CRON,UDIR,RUNTIME,TIME,DATE
backup1,full,10GB,"...","...","...","...","...","...","2023-03-29T10:00:00Z","2023-03-29"
backup2,incr,5GB,"...","...","...","...","...","...","2023-03-28T12:30:00Z","2023-03-28"
...
```

### 注意事项

- 请确保在执行命令前，已经正确设置了 HestiaCP 的相关配置文件和路径。
- 根据实际需求选择合适的输出格式，以便更好地查看和分析备份信息。
- 对于大量备份数据，使用 JSON 或 CSV 格式输出可能更易于管理和分析。

## v-list-user-ips

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-user-ips)

### 概述

`v-list-user-ips` 是 Hestia 系统中一个用于列出用户 IP 地址的 CLI 命令。通过此命令，系统管理员可以方便地获取指定用户的所有可用 IP 地址及其相关信息。本文档将详细介绍该命令的使用方法、选项以及示例。

### 命令用法

#### 基本语法

```bash
v-list-user-ips USER [FORMAT]
```

- `USER`: 必填参数，表示要查询的用户名。
- `FORMAT`: 可选参数，用于指定输出格式。支持以下格式：
  - `shell`（默认）：以 shell 友好的格式输出。
  - `plain`：以纯文本格式输出，字段之间使用制表符分隔。
  - `csv`：以 CSV 格式输出，字段之间使用逗号分隔。
  - `json`：以 JSON 格式输出。

#### 示例

1. **默认输出格式（shell）**

   查询用户 `admin` 的 IP 地址列表：

   ```bash
   v-list-user-ips admin
   ```

   输出示例（假设）：

   ```bash
   IP NAT OWNER STATUS NAME
   -- --- ----- ------ ---
   192.168.1.1 no admin active Server1
   10.0.0.1 yes admin reserved Backup
   ...
   ```

2. **JSON 格式输出**

   查询用户 `admin` 的 IP 地址列表并以 JSON 格式输出：

   ```bash
   v-list-user-ips admin json
   ```

   输出示例（假设）：

   ```json
   {
     "ip_count": 2,
     "192.168.1.1": {
       "OWNER": "admin",
       "STATUS": "active",
       "NAME": "Server1",
       "NAT": "no"
     },
     "10.0.0.1": {
       "OWNER": "admin",
       "STATUS": "reserved",
       "NAME": "Backup",
       "NAT": "yes"
     },
     ...
   }
   ```

3. **CSV 格式输出**

   查询用户 `admin` 的 IP 地址列表并以 CSV 格式输出：

   ```bash
   v-list-user-ips admin csv
   ```

   输出示例（假设）：

   ```csv
   IP,OWNER,STATUS,NAME,NAT
   192.168.1.1,admin,active,Server1,no
   10.0.0.1,admin,reserved,Backup,yes
   ...
   ```

### 注意事项

- 使用该命令时，请确保你有足够的权限来访问和列出用户的 IP 地址信息。
- 如果指定的用户不存在或没有关联的 IP 地址，命令可能会返回空结果或错误消息。
- 在使用非默认输出格式时（如 JSON 或 CSV），请确保你的解析器或文本处理工具能够正确处理相应的格式。

### 总结

`v-list-user-ips` 命令是 Hestia 系统中一个强大的工具，用于查询和列出指定用户的 IP 地址及其相关信息。通过选择不同的输出格式，你可以根据需求灵活地处理这些数据。无论是在系统管理中还是在自动化脚本中，这个命令都能提供极大的便利。

## v-list-user-log

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-user-log)

### 概述

`v-list-user-log` 是一个用于获取系统中最后100个用户命令列表的CLI（命令行接口）工具。通过该工具，用户可以查看指定用户执行的历史命令及其相关日志信息。

### 使用方法

### 基本语法

```bash
v-list-user-log USER [FORMAT]
```

- `USER`: 要查询的用户名。
- `FORMAT`: 可选参数，指定输出格式。默认为`shell`格式。支持的其他格式包括`json`和`plain`。

### 示例

1. **以默认shell格式列出用户"john"的命令日志**

```bash
v-list-user-log john
```

这将按照shell格式（ID~DATE~TIME~LEVEL~CATEGORY~MESSAGE）显示用户"john"的最后100条命令日志。

2. **以JSON格式列出用户"jane"的命令日志**

```bash
v-list-user-log jane json
```

这将按照JSON格式返回用户"jane"的日志信息，便于程序解析和进一步处理。

3. **以plain文本格式列出用户"admin"的命令日志**

```bash
v-list-user-log admin plain
```

plain格式将直接输出每一行日志的原始内容，不经过格式化。

### 输出格式详解

#### shell 格式

shell格式以制表符（`~`）分隔各个字段，包括：

- `ID`: 日志条目的唯一标识符。
- `DATE`: 日志条目的日期。
- `TIME`: 日志条目的时间。
- `LEVEL`: 日志级别（如INFO、ERROR等）。
- `CATEGORY`: 日志分类。
- `MESSAGE`: 日志消息内容。

#### JSON 格式

JSON格式将日志条目组织成一个JSON对象数组，每个对象包含以下字段：

- `ID`: 日志条目的唯一标识符。
- `DATE`: 日志条目的日期。
- `TIME`: 日志条目的时间。
- `LEVEL`: 日志级别（如INFO、ERROR等）。
- `CATEGORY`: 日志分类。
- `MESSAGE`: 日志消息内容（已转义双引号）。

#### plain 格式

plain格式直接输出原始日志条目，每行一个。不包含任何额外的格式化或分隔符。

### 注意事项

- 该命令可能依赖于特定的环境配置和依赖文件（如`/etc/hestiacp/hestia.conf`和`/usr/local/hestia/func/main.sh`），请确保这些文件存在且可访问。
- 由于日志条目的数量可能很大，该命令默认只返回最后100条记录。如果需要更多记录，请咨询相关系统管理员或查看相应的配置文件。
- 在使用JSON或plain格式时，请确保接收和解析输出的程序能够正确处理这些格式。

## v-list-user-notifications

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-user-notifications)

`v-list-user-notifications` 是 Hestia 提供的一个命令行工具，用于列出指定用户的所有通知。此命令提供了灵活的通知格式选项，并支持多种输出格式，方便用户根据需要进行定制。

### 命令格式

```bash
v-list-user-notifications USER [FORMAT]
```

* `USER`：要查询通知的用户名。
* `FORMAT`：可选参数，指定输出格式。默认为 shell 格式。支持的其他格式包括 json 等。

### 示例

#### 示例1：以 shell 格式列出 admin 用户的通知

```bash
v-list-user-notifications admin
```

输出可能类似于：

```bash
TOPIC: 系统更新
NOTICE: Hestia 现已更新至 1.2.3 版本
DATE: 2023-04-01
TIME: 10:00:00
--
TOPIC: 磁盘空间警告
NOTICE: /var/log 分区剩余空间不足 10%
DATE: 2023-03-30
TIME: 15:30:00
--
# ... 更多通知 ...
```

#### 示例2：以 json 格式列出 admin 用户的通知

```bash
v-list-user-notifications admin json
```

输出可能类似于：

```json
{
  "1": {
    "TOPIC": "系统更新",
    "NOTICE": "Hestia 现已更新至 1.2.3 版本",
    "TYPE": "info",
    "ACK": "false",
    "PRIORITY": "0",
    "TIME": "10:00:00",
    "DATE": "2023-04-01"
  },
  "2": {
    "TOPIC": "磁盘空间警告",
    "NOTICE": "/var/log 分区剩余空间不足 10%",
    "TYPE": "warning",
    "ACK": "false",
    "PRIORITY": "1",
    "TIME": "15:30:00",
    "DATE": "2023-03-30"
  },
  # ... 更多通知 ...
}
```

### 注意事项

* 请确保在运行命令之前已经正确安装了 Hestia，并且 CLI 工具可用。
* 不同的输出格式可能会包含不同的字段，具体取决于 Hestia 的配置和通知的类型。
* 对于 json 格式的输出，可以使用各种 JSON 处理工具（如 jq）进行进一步的处理和分析。
* 如果在命令执行过程中遇到任何问题，请查阅 Hestia 的官方文档或联系技术支持以获取帮助。

## v-list-user-package

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-user-package)

`v-list-user-package` 是 Hestia 提供的一个 CLI（命令行接口）命令，用于列出指定用户的软件包信息。该命令允许用户以特定的格式查看其拥有的软件包详情，从而便于管理和维护。

### 命令格式

```bash
v-list-user-package PACKAGE [FORMAT]
```

- `PACKAGE`: 用户的软件包名称或标识符。
- `FORMAT`: 可选参数，指定输出格式。默认为 shell 格式，也可以指定为 json 或其他支持的格式。

### 示例

#### 示例 1: 列出用户的软件包（默认格式）

```bash
v-list-user-package example-package
```

输出可能如下（这里以 shell 格式为例）：

```bash
PACKAGE: example-package
WEB TEMPLATE: default
BACKEND TEMPLATE: nginx
PROXY TEMPLATE: haproxy
DNS TEMPLATE: bind
WEB DOMAINS: example.com, www.example.com
# ... 其他相关配置信息 ...
```

#### 示例 2: 列出用户的软件包（JSON 格式）

```bash
v-list-user-package example-package json
```

输出可能如下（JSON 格式）：

```json
{
  "example-package": {
    "WEB_TEMPLATE": "default",
    "BACKEND_TEMPLATE": "nginx",
    "PROXY_TEMPLATE": "haproxy",
    "DNS_TEMPLATE": "bind",
    "WEB_DOMAINS": ["example.com", "www.example.com"],
    # ... 其他相关配置信息 ...
  }
}
```

#### 示例 3: 列出不存在的软件包

```bash
v-list-user-package non-existent-package
```

在这种情况下，命令可能会返回一个错误消息，表明该软件包不存在：

```bash
Error: Package 'non-existent-package' not found.
```

### 注意事项

- 在使用 `v-list-user-package` 命令之前，请确保已经正确安装了 Hestia 系统，并且已经通过适当的身份验证和授权。
- 如果未指定 `FORMAT` 参数，则默认使用 shell 格式输出。
- 如果指定的软件包不存在，命令将返回一个错误消息。
- 输出的具体内容取决于用户软件包的实际配置和所支持的格式。

### 总结

`v-list-user-package` 命令是 Hestia 系统中一个非常有用的工具，它允许用户轻松地查看和管理其软件包信息。通过指定不同的格式参数，用户可以根据需要自定义输出格式，以满足不同的使用场景。

## v-list-user-packages

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-user-packages)

`v-list-user-packages` 是 Hestia 提供的一个命令行接口（CLI）命令，用于列出用户可用的托管包列表。该命令对于用户和管理员来说都非常有用，因为它可以迅速展示所有可用的服务包，以及每个包所包含的配置和特性。

### 命令语法

```bash
v-list-user-packages [OPTIONS]
```

### 选项参数

* **OPTIONS**（可选）：该命令目前不直接支持选项参数，但未来版本可能会添加。

### 输出格式

命令的输出通常是一个结构化的列表，详细描述了每个可用包的名称、描述、配置参数等信息。输出格式可以是纯文本、JSON 或其他格式，具体取决于 Hestia 的配置和版本。

### 示例

#### 示例 1：基本用法

```bash
v-list-user-packages
```

执行上述命令后，你可能会看到类似以下的输出（这里以纯文本格式为例）：

```plaintext
Available User Packages:
1. Package Name: web-starter
   Description: Basic web hosting package for small websites.
   Features: 1GB Disk Space, 10GB Bandwidth, 1 Domain, 1 Email Account

2. Package Name: web-pro
   Description: Professional web hosting package for medium-sized websites.
   Features: 5GB Disk Space, 50GB Bandwidth, 5 Domains, 10 Email Accounts

...
```

#### 示例 2：JSON 格式输出（假设支持）

如果 Hestia 支持 JSON 格式的输出，你可以通过某种方式（可能是命令行选项或配置文件）来指定输出格式。例如：

```bash
v-list-user-packages --format=json
```

执行上述命令后，你可能会看到类似以下的 JSON 输出：

```json
{
  "packages": [
    {
      "name": "web-starter",
      "description": "Basic web hosting package for small websites.",
      "features": [
        "1GB Disk Space",
        "10GB Bandwidth",
        "1 Domain",
        "1 Email Account"
      ]
    },
    {
      "name": "web-pro",
      "description": "Professional web hosting package for medium-sized websites.",
      "features": [
        "5GB Disk Space",
        "50GB Bandwidth",
        "5 Domains",
        "10 Email Accounts"
      ]
    },
    ...
  ]
}
```

### 注意事项

* 确保你已经正确安装了 Hestia，并且 CLI 工具在你的 PATH 中可用。
* 不同的 Hestia 版本可能支持不同的选项和输出格式，因此请查阅你正在使用的 Hestia 版本的官方文档以获取最准确的信息。
* 如果你在使用该命令时遇到问题，请查阅 Hestia 的日志文件或联系技术支持以获取帮助。

## v-list-user-stats

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-user-stats)

### 概述

`v-list-user-stats` 是基于 HestiaCP 提供的 CLI（命令行界面）命令，用于列出指定用户的统计信息。该命令通过解析用户的统计日志文件，以 JSON 或 Shell 格式展示用户的资源使用情况，如磁盘配额、带宽、域名、数据库等。

### 用法

```bash
v-list-user-stats USER [FORMAT]
```

- `USER`: 要查询统计信息的用户名。
- `FORMAT`: 可选参数，用于指定输出格式。默认为 `shell`，也可以选择 `json` 格式。

### 示例

#### 示例 1: 以 Shell 格式列出 admin 用户的统计信息

```bash
v-list-user-stats admin
```

输出示例（Shell 格式）:

```bash
DATE      WEB     DNS     MAIL    DB      BACKUPS  IP     DISK   BW
----      ---     ---     ----    --      -------  --     ----   --
2023-01-01 10     5       3       2       1        1.2.3.4 10GB   100MB
# 后续行将显示更多统计信息...
```

#### 示例 2: 以 JSON 格式列出 admin 用户的统计信息

```bash
v-list-user-stats admin json
```

输出示例（JSON 格式）:

```json
{
  "2023-01-01": {
    "TIME": "00:00:00",
    "PACKAGE": "Default",
    "IP_OWNED": "1.2.3.4",
    "DISK_QUOTA": "100GB",
    "U_DISK": "10GB",
    "U_DISK_DIRS": "5",
    "U_DISK_WEB": "2GB",
    "U_DISK_MAIL": "1GB",
    "U_DISK_DB": "1GB",
    "BANDWIDTH": "1000MB",
    "U_BANDWIDTH": "100MB",
    "U_WEB_DOMAINS": "10",
    "U_WEB_SSL": "2",
    "U_WEB_ALIASES": "3",
    "U_DNS_DOMAINS": "5",
    "U_DNS_RECORDS": "10",
    "U_MAIL_DOMAINS": "3",
    "U_MAIL_DKIM": "1",
    "U_MAIL_ACCOUNTS": "5",
    "U_DATABASES": "2",
    "U_CRON_JOBS": "1",
    "U_BACKUPS": "1"
  },
  # 后续日期将显示更多统计信息...
}
```

### 注意事项

- 确保您已经安装了 HestiaCP 并正确配置了相关环境变量。
- 用户的统计信息存储在 `$USER_DATA/stats.log` 文件中，确保该文件可访问且格式正确。
- 如果输出格式未指定或无效，将默认使用 Shell 格式。

### 结论

`v-list-user-stats` 命令是一个强大的工具，用于获取 HestiaCP 用户的详细统计信息。通过此命令，管理员可以轻松地跟踪和监控用户的资源使用情况，从而做出更明智的管理决策。

## v-list-users

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-users)

### 概述

`v-list-users` 是 Hestia 提供的 CLI (命令行接口) 命令之一，用于列出系统上的所有用户及其相关信息。这个命令对于系统管理员来说非常有用，可以快速了解系统用户的状态和配置。

### 使用方法

在终端中，你可以通过以下方式使用 `v-list-users` 命令：

```bash
v-list-users [FORMAT]
```

其中 `[FORMAT]` 是一个可选参数，用于指定输出格式。如果不指定格式，则默认使用 shell 格式。

### 输出格式

#### 1. Shell 格式 (默认)

Shell 格式以每行一个用户的方式列出用户信息，每个字段之间使用空格分隔。

示例输出：

```bash
user1 role1 pkg1 web1 dns1 mail1 db1 disk1 bw1 spnd1 date1
user2 role2 pkg2 web2 dns2 mail2 db2 disk2 bw2 spnd2 date2
...
```

#### 2. JSON 格式

JSON 格式以 JSON 对象数组的形式列出用户信息，每个对象代表一个用户。

示例输出：

```json
[
  {
    "username": "user1",
    "role": "role1",
    "package": "pkg1",
    "web": "web1",
    "dns": "dns1",
    "mail": "mail1",
    "db": "db1",
    "disk": "disk1",
    "bw": "bw1",
    "spnd": "spnd1",
    "date": "date1"
  },
  {
    "username": "user2",
    "role": "role2",
    "package": "pkg2",
    "web": "web2",
    "dns": "dns2",
    "mail": "mail2",
    "db": "db2",
    "disk": "disk2",
    "bw": "bw2",
    "spnd": "spnd2",
    "date": "date2"
  },
  ...
]
```

### 示例

#### 示例 1: 列出所有用户 (默认 Shell 格式)

```bash
v-list-users
```

#### 示例 2: 列出所有用户并指定 JSON 格式

```bash
v-list-users json
```

### 注意事项

* 在使用 `v-list-users` 命令之前，请确保你已经正确安装了 Hestia，并且具有执行该命令的权限。
* 输出内容可能因 Hestia 版本或系统配置的不同而有所差异。
* 如果你需要更详细的用户信息或进行其他操作，请参考 Hestia 的官方文档或联系技术支持。

## v-list-users-stats

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-users-stats)

### 概述

`v-list-users-stats` 是Hestia提供的一个命令行接口（CLI）命令，用于列出并显示系统中所有用户的统计信息。这个命令可以帮助管理员快速了解用户的使用情况、活跃度等关键数据，从而做出更明智的决策。

### 使用方法

基本语法如下：

```bash
v-list-users-stats [选项]
```

#### 选项

* `-f` 或 `--format`: 指定输出格式。可选项包括`json`、`plain`、`csv`和`shell`。默认格式为`plain`。
* `-u` 或 `--user`: 指定要查询的用户名。如果不提供此选项，则列出所有用户的统计信息。
* `--help`: 显示命令帮助信息。

### 示例

#### 示例1：列出所有用户的统计信息（默认格式）

```bash
v-list-users-stats
```

执行上述命令后，将按照默认格式（`plain`）列出所有用户的统计信息。输出可能包括用户名、总登录次数、最近登录时间等字段。

#### 示例2：以JSON格式列出所有用户的统计信息

```bash
v-list-users-stats -f json
```

执行上述命令后，将以JSON格式输出所有用户的统计信息。这种格式更易于机器解析和处理。

#### 示例3：列出指定用户的统计信息（JSON格式）

```bash
v-list-users-stats -f json -u username
```

将`username`替换为要查询的实际用户名。执行上述命令后，将以JSON格式输出指定用户的统计信息。

#### 示例4：获取命令帮助信息

```bash
v-list-users-stats --help
```

执行上述命令后，将显示`v-list-users-stats`命令的帮助信息，包括可用选项和用法说明。

### 注意事项

* 确保已正确安装并配置了Hestia系统。
* 在执行命令时，请确保具有足够的权限来访问用户统计信息。
* 根据实际需求选择合适的输出格式。如果需要与其他系统或工具进行交互，建议使用JSON或CSV格式。
* 如果要查询的用户名包含特殊字符或空格，请使用引号将其括起来，以避免解析错误。

## 查询系列命令

## v-get-user-salt

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-get-user-salt)

`v-get-user-salt` 是 Hestia 提供的 CLI（命令行界面）命令之一，用于检索指定用户的密码盐值。在密码学中，盐值通常用于增加密码哈希的复杂性和唯一性，从而提高系统的安全性。

### 命令格式

```bash
v-get-user-salt [USER] [OPTIONS]
```

* `[USER]`：必需参数，指定要检索盐值的用户名。
* `[OPTIONS]`：可选参数，用于指定其他选项，如输出格式等。

### 选项参数

* `-i, --ip [IP]`：指定要查询的用户的IP地址（默认为127.0.0.1）。在某些情况下，你可能需要指定特定的IP地址来检索特定会话的盐值。
* `-f, --format [FORMAT]`：指定输出格式（默认为shell）。可用的格式包括shell、json、plain和csv。

### 示例

#### 示例1：检索admin用户的盐值（默认格式）

```bash
v-get-user-salt admin
```

这将返回admin用户的盐值，默认为shell格式输出。

#### 示例2：指定IP地址和输出格式（JSON）

```bash
v-get-user-salt admin -i 192.168.1.100 -f json
```

这将返回admin用户在IP地址为192.168.1.100的会话中的盐值，并以JSON格式输出。

#### 示例3：使用plain格式输出

```bash
v-get-user-salt admin -f plain
```

这将返回admin用户的盐值，并以plain文本格式输出。

#### 示例4：使用CSV格式输出

```bash
v-get-user-salt admin -f csv
```

这将返回admin用户的盐值，并以CSV格式输出，通常用于导入到电子表格软件中。

### 注意事项

* 确保你有足够的权限来执行此命令，并访问相关的用户数据。
* 在生产环境中使用时，请谨慎处理用户的敏感信息，如密码和盐值。
* 如果命令执行失败或返回错误，请检查你的输入参数是否正确，以及你是否具有正确的权限。

### 总结

`v-get-user-salt` 命令是 Hestia 提供的一个有用的工具，用于检索指定用户的密码盐值。通过指定用户名、IP地址和输出格式等选项参数，你可以灵活地获取所需的信息。请确保在使用此命令时遵循最佳的安全实践，并谨慎处理用户的敏感信息。

## v-get-user-value

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-get-user-value)

### 简介

`v-get-user-value` 是 Hestia 提供的一个命令行接口（CLI）命令，用于获取指定用户的特定参数值。这个命令在自动化脚本、用户配置查询等场景中非常有用。

### 语法

```bash
v-get-user-value USER KEY
```

- `USER`：指定要查询参数值的用户名。
- `KEY`：指定要查询的参数键名。

### 示例

#### 示例 1：获取管理员用户的 FNAME

```bash
v-get-user-value admin FNAME
```

这个命令将返回 `admin` 用户的 `FNAME` 参数值。

#### 示例 2：获取特定用户的 EMAIL

```bash
v-get-user-value someuser EMAIL
```

这个命令将返回 `someuser` 用户的 `EMAIL` 参数值。

#### 示例 3：使用变量传递用户名和键名

```bash
USERNAME=anotheruser
KEY=ADDRESS
v-get-user-value $USERNAME $KEY
```

在这个示例中，我们首先设置了两个变量 `USERNAME` 和 `KEY`，然后使用这些变量作为 `v-get-user-value` 命令的参数。这将返回 `anotheruser` 用户的 `ADDRESS` 参数值。

### 注意事项

- 确保在执行 `v-get-user-value` 命令之前已经正确配置了 Hestia，并且 CLI 命令工具已经安装并可用。
- `USER` 和 `KEY` 参数是区分大小写的，请确保提供正确的值。
- 如果指定的用户或键名不存在，命令可能会返回一个错误消息或空值。

### 返回值

`v-get-user-value` 命令将返回指定用户的指定参数值。如果查询成功，将返回相应的参数值；如果查询失败（例如，用户或键名不存在），可能会返回一个错误消息或空值。

### 后续操作

获取到用户参数值后，你可以根据需要进行后续处理，例如在脚本中使用这些值来配置系统、发送通知等。

### 总结

`v-get-user-value` 是一个实用的 Hestia CLI 命令，用于获取指定用户的特定参数值。通过提供用户名和参数键名作为参数，你可以轻松地查询用户的配置信息。

## v-import-cpanel

* * [命令行Bash 脚本查看](https://hestiamb.org/bin/v-import-cpanel)
* 基于 sk-import-cpanel-backup-to-vestacp
致谢：[Maks Usmanov (skamasle)](https://github.com/Skamasle/sk-import-cpanel-backup-to-vestacp/graphs/contributors)和贡献者：

### 简介

`v-import-cpanel` 是 Hestia 控制面板提供的一个命令行工具，用于将 cPanel 备份导入到 Hestia 的新用户中。此工具大大简化了从 cPanel 迁移至 Hestia 的过程，减少了手动操作的复杂性。

### 语法

```bash
v-import-cpanel [选项] 备份文件路径 [MX选项]
```

### 选项

* **备份文件路径**：指定 cPanel 备份的 `.tar.gz` 文件的路径。
* **MX选项**（可选）：如果需要处理邮件相关的设置，请将此选项设置为 `yes`。

### 示例

#### 示例 1：导入不带邮件设置的备份

```bash
v-import-cpanel /path/to/backup.tar.gz
```

此命令将 `/path/to/backup.tar.gz` 指定的 cPanel 备份导入到 Hestia 中，但不处理邮件设置。

#### 示例 2：导入并处理邮件设置的备份

```bash
v-import-cpanel /path/to/backup.tar.gz yes
```

此命令不仅将 `/path/to/backup.tar.gz` 指定的 cPanel 备份导入到 Hestia 中，还处理邮件设置。

### 注意事项

1. **备份文件完整性**：请确保 cPanel 备份文件完整且未损坏，否则导入过程可能会失败。
2. **权限问题**：运行 `v-import-cpanel` 命令的用户应具有足够的权限以执行导入操作。
3. **邮件设置**：如果导入的备份包含邮件数据，并且您选择处理邮件设置（通过添加 `yes` 作为第二个参数），则请确保 Hestia 服务器已正确配置以接收和发送邮件。
4. **资源限制**：大型备份文件可能需要更长的时间来导入，并且可能会消耗大量的系统资源。请确保在导入过程中系统资源充足。
5. **备份检查**：在导入之前，建议对备份文件进行检查以确保其完整性和可用性。

### 结论

`v-import-cpanel` 命令为从 cPanel 迁移到 Hestia 提供了便捷的解决方案。通过遵循上述指南和示例，您可以轻松地将 cPanel 备份导入到 Hestia 中，并享受 Hestia 提供的强大功能和优质服务。

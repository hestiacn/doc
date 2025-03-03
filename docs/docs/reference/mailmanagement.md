# 邮箱管理系列命令介绍

## v-add-mail-account

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-mail-account)

`v-add-mail-account` 是 Hestia 控制面板（CLI）中的一个脚本命令，是一个命令行工具，用于在邮件系统中添加新的邮件账户。通过此命令，管理员可以创建新的邮件账户，并为其指定用户名、域名、账户名、密码和配额。

### 使用方法

在终端中执行 `v-add-mail-account` 命令，并传递所需的参数。

#### 基本语法

```bash
v-add-mail-account USER DOMAIN ACCOUNT PASSWORD [QUOTA]
```

#### 参数说明

- **USER**：邮件账户所属的用户名。
- **DOMAIN**：邮件账户的域名。
- **ACCOUNT**：邮件账户的账户名。
- **PASSWORD**：邮件账户的密码。
- **QUOTA**（可选）：邮件账户的配额限制，默认为 `unlimited`，表示无限制。

### 示例

以下是一个使用 `v-add-mail-account` 命令的示例：

```bash
v-add-mail-account john example.com john_mail password 1000M
```

上述命令将在 `example.com` 域名下为 `john` 用户创建一个名为 `john_mail` 的邮件账户，密码为 `password`，并设置配额限制为 `1000M`。

### 功能描述

`v-add-mail-account` 命令执行以下操作：

1. 检查传递的参数数量和格式是否有效。
2. 验证用户名、域名和账户名的有效性。
3. 检查邮件系统是否启用以及用户的邮箱是否已被暂停。
4. 检查邮件账户配额是否合法（如果指定了配额）。
5. 验证密码的复杂性。
6. 检查是否在演示模式下运行。
7. 根据邮件系统配置，选择相应的密码加密方式（如BLF-CRYPT、ARGON2ID或MD5）。
8. 将邮件账户信息添加到相应的配置文件中（如Exim）。
9. 创建邮件账户的存储目录，并设置适当的权限。

### 注意事项

- 在执行 `v-add-mail-account` 命令之前，请确保您具备足够的权限和访问控制，以防止未经授权的账户创建。
- 请确保邮件系统已经正确配置，并且能够处理新的邮件账户。
- 在指定配额时，请确保使用的格式正确，例如 `1000M` 表示 1000MB。
- 密码应该足够复杂，以增强账户的安全性。

### 错误处理

- 如果在命令执行过程中遇到错误，命令将返回相应的错误提示信息。请根据提示信息排查问题，并确保所有参数和配置正确无误。
- 如果无法添加邮件账户，可能是由于系统配置错误、权限问题或磁盘空间不足等原因。请检查系统状态和日志文件，以获取更详细的错误信息，并进行相应的修复操作。

### 结论

`v-add-mail-account` 命令是一个方便的工具，用于在邮件系统中创建新的邮件账户。通过提供必要的参数和配置，管理员可以轻松地添加新的账户，并为其设置适当的配额和密码。请按照本文档中的说明进行操作，以确保正确添加和使用邮件账户。

## v-add-mail-account-alias

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-mail-account-alias)

`v-add-mail-account`是 Hestia 控制面板（CLI）中的一个脚本命令，是一个命令行工具，用于在邮件系统中为已存在的邮件账户添加别名。该命令接受用户名、域名、账户名和别名作为参数，并将这些别名添加到对应的邮件账户中。

### 使用方法

在终端中执行 `v-add-mail-account` 命令，并传递所需的参数。

#### 基本语法

```bash
v-add-mail-account USER DOMAIN ACCOUNT ALIAS
```

#### 参数说明

- **USER**：邮件账户所属的用户名。
- **DOMAIN**：邮件账户的域名。
- **ACCOUNT**：邮件账户的账户名。
- **ALIAS**：要添加的邮件别名。

### 功能描述

`v-add-mail-account` 命令执行以下操作：

1. 加载邮件系统的配置文件和必要的函数库。
2. 检查传递的参数数量和格式是否有效。
3. 验证用户名、域名、账户名和别名的有效性。
4. 检查邮件系统是否启用以及用户的邮箱是否已被暂停。
5. 检查邮件账户和别名是否已存在且未被暂停。
6. 如果邮件系统配置为使用 Exim，则将别名添加到对应的别名文件中。
7. 更新邮件账户的别名列表，将新别名添加到现有别名列表中。
8. 记录日志，记录添加别名到邮件账户的操作。

### 注意事项

- 在执行 `v-add-mail-account` 命令之前，请确保您具备足够的权限和访问控制，以防止未经授权的别名添加。
- 请确保邮件系统已经正确配置，并且能够处理邮件别名。
- 别名应该与邮件账户关联，并且应该遵循邮件系统的命名规则。

### 错误处理

- 如果在命令执行过程中遇到错误，命令将返回相应的错误提示信息。请根据提示信息排查问题，并确保所有参数和配置正确无误。
- 如果无法添加别名，可能是由于系统配置错误、权限问题或别名已存在等原因。请检查系统状态和日志文件，以获取更详细的错误信息，并进行相应的修复操作。

### 结论

`v-add-mail-account` 命令是一个方便的工具，用于在邮件系统中为已存在的邮件账户添加别名。通过提供必要的参数和配置，管理员可以轻松地添加新的别名，并扩展邮件账户的功能。请按照本文档中的说明进行操作，以确保正确添加和使用邮件别名。

## v-add-mail-account-autoreply

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-mail-account-autoreply)

`v-add-mail-account-autoreply` 是 Hestia 控制面板（CLI）中的一个脚本命令，是一个命令行工具，用于为指定的邮件账户设置自动回复消息。该命令接受用户名、域名、账户名和自动回复消息作为参数，并将这些消息保存到对应的邮件账户配置中。

### 使用方法

在终端中执行 `v-add-mail-account-autoreply` 命令，并传递所需的参数。

#### 基本语法

```bash
v-add-mail-account-autoreply USER DOMAIN ACCOUNT MESSAGE
```

#### 参数说明

- **USER**：邮件账户所属的用户名。
- **DOMAIN**：邮件账户的域名。
- **ACCOUNT**：邮件账户的账户名。
- **MESSAGE**：要设置的自动回复消息内容。

### 功能描述

`v-add-mail-account-autoreply` 命令执行以下操作：

1. 加载邮件系统的配置文件和必要的函数库。
2. 根据邮件系统的类型，确定邮件用户账号名称。
3. 验证传递的参数数量和格式是否有效。
4. 验证用户名、域名、账户名和自动回复消息的有效性。
5. 检查邮件系统是否启用以及用户的邮箱是否已被暂停。
6. 检查邮件账户和域名的有效性以及是否已暂停。
7. 检查是否在演示模式下运行，如果是则不允许执行命令。
8. 如果邮件系统配置为使用 Exim，则将自动回复消息保存到对应的文件中，并设置适当的权限。
9. 将自动回复消息保存到用户数据目录中的指定文件。
10. 更新邮件账户的自动回复状态，将其设置为启用。
11. 记录日志，记录为邮件账户添加自动回复消息的操作。

#### 示例场景

假设我们有一个邮件服务器，其中使用 Exim 作为邮件传输代理，并且我们想要为名为 `john` 的用户，在 `example.com` 域名下，为邮箱账户 `john@example.com` 设置自动回复消息。

#### 示例命令

在终端中执行以下命令：

```bash
v-add-mail-account-autoreply john example.com john '您好，我现在暂时无法回复您的邮件，请稍后再试。谢谢！'
```

#### 命令解析

- `john`：邮件账户所属的用户名。
- `example.com`：邮件账户的域名。
- `john`：邮件账户的账户名。
- `'您好，我现在暂时无法回复您的邮件，请稍后再试。谢谢！'`：要设置的自动回复消息内容。

#### 执行结果

如果命令执行成功，您应该能看到类似以下的输出信息（具体输出可能因系统配置和日志记录设置而异）：

```bash
Added auto-reply message for mail account john@example.com.
```

此外，您还可以检查系统日志文件以获取更详细的操作记录。

#### 注意事项

- 在执行命令之前，请确保 `john` 用户和 `example.com` 域名已经在邮件系统中正确设置，并且 `john@example.com` 邮箱账户已经存在。
- 提供的自动回复消息内容应该符合邮件编码规范，避免使用特殊字符或格式，以免导致邮件解析错误。
- 请确保您有足够的权限来执行此命令，并且您的邮件系统支持自动回复功能。

#### 错误处理示例

如果提供的参数不正确或邮件账户不存在，命令可能会返回错误提示。例如：

```bash
v-add-mail-account-autoreply john wrongdomain john '自动回复消息'
```

这可能会导致以下错误输出：

```bash
Error: Domain 'wrongdomain' does not exist.
```

在这种情况下，您应该检查提供的域名是否正确，并确保它在邮件系统中已经设置。根据错误提示进行相应的修正后，再次尝试执行命令。

### 注意事项

- 在执行 `v-add-mail-account-autoreply` 命令之前，请确保您具备足够的权限和访问控制，以防止未经授权的自动回复设置。
- 请确保邮件系统已经正确配置，并且能够处理自动回复功能。
- 自动回复消息应该符合邮件系统的要求，并且应该遵循适当的邮件格式和编码。

### 错误处理

- 如果在命令执行过程中遇到错误，命令将返回相应的错误提示信息。请根据提示信息排查问题，并确保所有参数和配置正确无误。
- 如果无法设置自动回复消息，可能是由于系统配置错误、权限问题或邮件账户状态不正确等原因。请检查系统状态和日志文件，以获取更详细的错误信息，并进行相应的修复操作。

### 结论

`v-add-mail-account-autoreply` 命令是一个方便的工具，用于为指定的邮件账户设置自动回复消息。通过提供必要的参数和配置，管理员可以轻松地为邮件账户启用自动回复功能，并定义适当的回复消息。请按照本文档中的说明进行操作，以确保正确设置和使用自动回复功能。

## v-add-mail-account-forward

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-mail-account-forward)

`v-add-mail-account-forward` 是 Hestia 控制面板（CLI）中的一个脚本命令，是一个命令行工具，用于为指定的邮件账户设置邮件转发功能。该命令接受用户名、域名、账户名和转发邮箱地址作为参数，并更新邮件账户的配置以实现邮件转发。

### 使用方法

在终端中执行 `v-add-mail-account-forward` 命令，并传递所需的参数。

#### 基本语法

```bash
v-add-mail-account-forward USER DOMAIN ACCOUNT FORWARD
```

#### 参数说明

- **USER**：邮件账户所属的用户名。
- **DOMAIN**：邮件账户的域名。
- **ACCOUNT**：邮件账户的账户名。
- **FORWARD**：要设置的邮件转发地址。

### 功能描述

`v-add-mail-account-forward` 命令执行以下操作：

1. 加载邮件系统的配置文件和必要的函数库。
2. 验证传递的参数数量和格式是否有效。
3. 检查用户名、域名和账户名的格式是否正确。
4. 检查邮件系统是否启用以及用户的邮箱是否已被暂停。
5. 验证邮件账户和域名的有效性以及是否已暂停。
6. 检查是否已经存在相同的邮件转发地址。
7. 在只读模式下，执行额外的验证操作。
8. 更新邮件账户的转发设置，将指定的转发地址添加到转发列表中。
9. 记录日志，记录为邮件账户启用邮件转发功能的操作。

## v-add-mail-account-forward 示例

#### 场景描述

假设您正在管理一个邮件服务器，并且想要为用户 `john` 在 `example.com` 域名下的邮箱账户 `john@example.com` 设置邮件转发功能。您希望所有发送到 `john@example.com` 的邮件都能自动转发到 `john.forward@gmail.com`。

#### 执行命令

在终端中，您会作为具有足够权限的管理员来执行以下命令：

```bash
v-add-mail-account-forward john example.com john john.forward@gmail.com
```

#### 参数解析

- `john`：邮箱账户所属的用户名。
- `example.com`：邮箱账户的域名。
- `john`：邮箱账户的账户名。
- `john.forward@gmail.com`：希望将邮件转发到的邮箱地址。

#### 预期输出

如果命令执行成功，您可能会看到以下类似的输出信息（具体输出可能因系统配置和日志记录设置而异）：

```
Mail forwarding on mail account john@example.com enabled (send to: john.forward@gmail.com).
```

同时，系统可能会记录一条事件日志，记录此次转发设置的操作。

#### 验证设置

为了验证邮件转发是否已成功设置，您可以尝试向 `john@example.com` 发送一封测试邮件，并检查 `john.forward@gmail.com` 是否能够接收到这封邮件。

#### 注意事项

- 请确保 `john` 用户和 `example.com` 域名已经在邮件系统中正确设置，并且 `john@example.com` 邮箱账户已经存在。
- 提供的转发邮箱地址 `john.forward@gmail.com` 应该是一个有效的、可以接收邮件的地址。
- 转发设置可能会立即生效，也可能会在几分钟内生效，具体取决于邮件服务器的配置和缓存策略。

#### 错误处理示例

如果提供的参数不正确或邮箱账户不存在，命令可能会返回错误提示。例如：

```bash
v-add-mail-account-forward wronguser example.com john john.forward@gmail.com
```

这可能会导致以下错误输出：

```bash
Error: User 'wronguser' does not exist.
```

在这种情况下，您应该检查提供的用户名是否正确，并确保它在邮件系统中已经设置。根据错误提示进行相应的修正后，再次尝试执行命令。

### 注意事项

- 在执行 `v-add-mail-account-forward` 命令之前，请确保您具备足够的权限和访问控制，以防止未经授权的邮件转发设置。
- 请确保邮件系统已经正确配置，并且能够处理邮件转发功能。
- 转发地址应该是一个有效的邮箱地址，并且应该符合邮件系统的要求。
- 如果指定的转发地址已经存在，命令将返回错误提示。

### 错误处理

- 如果在命令执行过程中遇到错误，命令将返回相应的错误提示信息。请根据提示信息排查问题，并确保所有参数和配置正确无误。
- 如果无法设置邮件转发功能，可能是由于系统配置错误、权限问题或邮件账户状态不正确等原因。请检查系统状态和日志文件，以获取更详细的错误信息，并进行相应的修复操作。

### 结论

`v-add-mail-account-forward` 命令是一个方便的工具，用于为指定的邮件账户设置邮件转发功能。通过提供必要的参数和配置，管理员可以轻松地为邮件账户启用邮件转发，并指定转发的目标邮箱地址。请按照本文档中的说明进行操作，以确保正确设置和使用邮件转发功能。

## v-add-mail-account-fwd-only

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-mail-account-fwd-only)

`v-add-mail-account-fwd-only` 是 Hestia 控制面板（CLI）中的一个脚本命令，是一个用于将指定的邮件账户设置为仅转发模式的命令行工具。在设置了仅转发模式后，该账户将不再接收邮件，而是将所有邮件自动转发到预设的转发地址。

### 使用方法

在终端中执行 `v-add-mail-account-fwd-only` 命令，并传递必要的参数。

#### 基本语法

```bash
v-add-mail-account-fwd-only USER DOMAIN ACCOUNT
```

#### 参数说明

- **USER**：邮件账户所属的用户名。
- **DOMAIN**：邮件账户的域名。
- **ACCOUNT**：邮件账户的账户名。

### 功能描述

`v-add-mail-account-fwd-only` 命令执行以下操作：

1. 加载邮件系统的配置文件和必要的函数库。
2. 检查参数数量，确保传递了正确的参数。
3. 验证参数格式的有效性。
4. 检查邮件系统是否启用，以及用户、域名和邮件账户是否有效且未被暂停。
5. 检查邮件账户是否已设置转发地址。
6. 根据邮件系统类型（如 exim4），执行相应的操作，如更新配置文件和所有权。
7. 在邮件账户对象中设置 `FWD_ONLY` 键，并将其值设置为 `yes`，以启用仅转发模式。
8. 记录日志，表明已为指定的邮件账户启用了仅转发标志。

### 示例

假设您有一个邮件账户 `john@example.com`，并且您想要将其设置为仅转发模式。您可以按照以下步骤操作：

1. 打开终端。
2. 输入以下命令，并替换 `john`、`example.com` 和 `john_account` 为实际的用户名、域名和账户名：

```bash
v-add-mail-account-fwd-only john example.com john_account
```

3. 按回车键执行命令。

如果命令执行成功，您将看到相应的日志记录，表明已启用 `john@example.com` 账户的仅转发模式。

### 注意事项

- 在执行 `v-add-mail-account-fwd-only` 命令之前，请确保您具备足够的权限和访问控制，以防止未经授权的邮件账户设置更改。
- 请确保邮件系统已经正确配置，并且能够处理邮件转发功能。
- 在启用仅转发模式之前，请确保已为该账户设置了有效的转发地址。

### 错误处理

如果命令执行过程中遇到错误，例如参数数量不足、格式不正确、邮件系统未启用、用户/域名/账户无效或已被暂停，或者邮件账户未设置转发地址等情况，命令将返回相应的错误提示，并记录错误事件。

### 结论

`v-add-mail-account-fwd-only` 命令为管理员提供了一个方便的工具，用于将指定的邮件账户设置为仅转发模式。通过执行此命令，您可以确保发送到该账户的邮件不会被接收，而是自动转发到预设的转发地址。请按照本文档中的说明进行操作，并根据您的实际需求使用示例来设置邮件账户的仅转发模式。

## v-add-mail-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-mail-domain)

`v-add-mail-domain` 是 Hestia 控制面板（CLI）中的一个脚本命令，是一个用于在邮件系统中添加新的邮件域名的命令行工具。通过执行此命令，您可以配置域名相关的邮件设置，如启用反垃圾邮件、反病毒、DKIM等功能。

### 使用方法

在终端中执行 `v-add-mail-domain` 命令，并传递必要的参数。

#### 基本语法

```bash
v-add-mail-domain USER DOMAIN [ANTISPAM] [ANTIVIRUS] [DKIM] [DKIM_SIZE] [RESTART] [REJECT_SPAM]
```

#### 参数说明

- **USER**：用户名，表示邮件域名的所有者。
- **DOMAIN**：要添加的邮件域名。
- **ANTISPAM**（可选）：是否启用反垃圾邮件功能，默认为 `yes`。
- **ANTIVIRUS**（可选）：是否启用反病毒功能，默认为 `yes`。
- **DKIM**（可选）：是否启用DKIM签名功能，默认为 `yes`。
- **DKIM_SIZE**（可选）：DKIM密钥的大小，默认为 `2048`。
- **RESTART**（可选）：是否重启邮件服务以应用更改，默认为不重启。
- **REJECT_SPAM**（可选）：是否拒绝接收被标记为垃圾邮件的邮件，默认为 `no`。

### 功能描述

`v-add-mail-domain` 命令执行以下操作：

1. 加载邮件系统和系统健康的配置文件及函数库。
2. 验证传递的参数数量、格式和有效性。
3. 检查邮件系统是否启用，以及用户是否有效且未被暂停。
4. 检查域名是否已存在于邮件系统中，并确保域名格式正确，不是IP地址。
5. 检查邮件域名配额是否已满，以及邮件目录是否为符号链接。
6. 检查域名是否属于基本域名所有者。
7. 验证是否在演示模式下运行。
8. 获取或验证域名的IP地址和有效性。
9. 设置或验证反垃圾邮件、反病毒、DKIM、拒绝垃圾邮件等选项的状态。
10. 在邮件系统中添加新的邮件域名，并应用相应的设置。

### 示例

假设您想要为用户 `john` 添加一个新的邮件域名 `example.com`，并启用反垃圾邮件、反病毒和DKIM功能，您可以使用以下命令：

```bash
v-add-mail-domain john example.com
```

由于 `ANTISPAM`、`ANTIVIRUS` 和 `DKIM` 参数未明确指定，它们将使用默认值 `yes`。

如果您想要禁用反病毒功能，并指定DKIM密钥大小为 `1024`，可以运行：

```bash
v-add-mail-domain john example.com yes no yes 1024
```

### 注意事项

- 在执行 `v-add-mail-domain` 命令之前，请确保您具备足够的权限和访问控制，以防止未经授权的邮件域名添加或配置更改。
- 请确保您提供的域名是有效的，并且没有被其他用户或系统使用。
- 根据您的邮件系统配置，某些功能可能已默认启用或禁用，因此请根据实际情况调整参数。

### 错误处理

如果命令执行过程中遇到错误，例如参数格式不正确、域名已存在、用户无效或已被暂停、域名格式错误、IP地址无效等情况，命令将返回相应的错误提示，并可能记录错误事件。

### 结论

`v-add-mail-domain` 命令为管理员提供了一个方便的工具，用于添加和配置新的邮件域名。通过执行此命令，您可以轻松地管理邮件系统中的域名，并根据需要启用或禁用各种邮件功能。请按照本文档中的说明进行操作，并根据您的实际需求使用示例来添加邮件域名。

## v-add-mail-domain-antispam

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-mail-domain-antispam)

`v-add-mail-domain-antispam` 是 Hestia 控制面板（CLI）中的一个脚本命令，是一个命令行工具，用于在特定的邮件域名上启用反垃圾邮件（Antispam）功能。该命令通过修改邮件系统的配置，为指定的邮件域名添加反垃圾邮件保护，从而提高邮件安全性和减少不必要的垃圾邮件。

### 使用方法

在终端中执行 `v-add-mail-domain-antispam` 命令，并传递必要的参数。

#### 基本语法

```bash
v-add-mail-domain-antispam USER DOMAIN
```

#### 参数说明

- **USER**：用户名，表示邮件域名的所有者。
- **DOMAIN**：要启用反垃圾邮件功能的邮件域名。

### 功能描述

`v-add-mail-domain-antispam` 命令执行以下操作：

1. 加载邮件系统和系统健康的配置文件及函数库。
2. 验证传递的参数数量、格式和有效性。
3. 检查邮件系统是否启用，以及用户和邮件域名是否有效且未被暂停。
4. 检查邮件域名是否已存在，并验证其反垃圾邮件功能是否已启用。
5. 根据邮件系统的类型（如 exim），在用户的邮件配置目录中创建反垃圾邮件相关的配置文件或标记。
6. 更新邮件域名的对象值，将反垃圾邮件功能设置为启用状态。
7. 记录日志，标记反垃圾邮件功能已成功启用，并包含相关的用户和域名信息。
8. 退出命令执行。

### 示例

假设您想要为用户 `john` 的 `example.com` 邮件域名启用反垃圾邮件功能，您可以使用以下命令：

```bash
v-add-mail-domain-antispam john example.com
```

执行此命令后，系统将检查 `john` 用户和 `example.com` 域名的有效性，并确认该域名当前未启用反垃圾邮件功能。然后，系统将在适当的配置位置添加反垃圾邮件相关的设置，并将该域名的反垃圾邮件功能状态更新为启用。最后，系统将记录一条日志，表明反垃圾邮件功能已成功启用。

### 注意事项

- 在执行 `v-add-mail-domain-antispam` 命令之前，请确保您具备足够的权限和访问控制，以防止未经授权的配置更改。
- 请确保您提供的用户名和域名是有效的，并且域名确实存在于邮件系统中。
- 根据您的邮件系统配置，反垃圾邮件功能可能已默认启用或禁用。此命令用于显式启用该功能，如果已启用则不会有任何影响。
- 启用反垃圾邮件功能可能会增加邮件处理的开销和延迟，因此请根据实际情况进行权衡。

### 错误处理

如果命令执行过程中遇到错误，例如参数格式不正确、用户或域名无效、域名已启用反垃圾邮件功能等情况，命令将返回相应的错误提示，并可能记录错误事件。

### 结论

`v-add-mail-domain-antispam` 命令提供了一个简单而有效的方式来启用邮件域名的反垃圾邮件功能。通过执行此命令，您可以提高邮件系统的安全性和用户体验，减少不必要的垃圾邮件干扰。请按照本文档中的说明进行操作，并根据您的实际需求使用示例来启用反垃圾邮件功能。

## v-add-mail-domain-antivirus

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-mail-domain-antivirus)

`v-add-mail-domain-antivirus` 是 Hestia 控制面板（CLI）中的一个脚本命令，是一个命令行工具，用于在特定的邮件域名上启用反病毒（Antivirus）扫描功能。该命令通过在邮件系统中添加相应的配置，确保所有通过该域名接收和发送的邮件都会经过反病毒扫描，从而提高邮件安全性，减少病毒传播的风险。

### 使用方法

在终端中执行 `v-add-mail-domain-antivirus` 命令，并传递必要的参数。

#### 基本语法

```bash
v-add-mail-domain-antivirus USER DOMAIN
```

#### 参数说明

- **USER**：用户名，表示邮件域名的所有者。
- **DOMAIN**：要启用反病毒扫描功能的邮件域名。

### 功能描述

`v-add-mail-domain-antivirus` 命令执行以下操作：

1. 加载邮件系统和系统健康的配置文件及函数库。
2. 验证传递的参数数量、格式和有效性。
3. 检查邮件系统是否启用，以及用户和邮件域名是否有效且未被暂停。
4. 检查邮件域名是否已存在，并验证其反病毒扫描功能是否已启用。
5. 根据邮件系统的类型（如 exim），在用户的邮件配置目录中创建反病毒扫描相关的配置文件或标记。
6. 更新邮件域名的对象值，将反病毒扫描功能设置为启用状态。
7. 记录日志，标记反病毒扫描功能已成功启用，并包含相关的用户和域名信息。
8. 退出命令执行。

### 示例

假设您想要为用户 `john` 的 `example.com` 邮件域名启用反病毒扫描功能，您可以使用以下命令：

```bash
v-add-mail-domain-antivirus john example.com
```

执行此命令后，系统将检查 `john` 用户和 `example.com` 域名的有效性，并确认该域名当前未启用反病毒扫描功能。然后，系统将在适当的配置位置添加反病毒扫描相关的设置，并将该域名的反病毒扫描功能状态更新为启用。最后，系统将记录一条日志，表明反病毒扫描功能已成功启用。

### 注意事项

- 在执行 `v-add-mail-domain-antivirus` 命令之前，请确保您具备足够的权限和访问控制，以防止未经授权的配置更改。
- 请确保您提供的用户名和域名是有效的，并且域名确实存在于邮件系统中。
- 根据您的邮件系统配置，反病毒扫描功能可能已默认启用或禁用。此命令用于显式启用该功能，如果已启用则不会有任何影响。
- 启用反病毒扫描功能可能会增加邮件处理的开销和延迟，因此请根据实际情况进行权衡。

### 错误处理

如果命令执行过程中遇到错误，例如参数格式不正确、用户或域名无效、域名已启用反病毒扫描功能等情况，命令将返回相应的错误提示，并可能记录错误事件。

### 结论

`v-add-mail-domain-antivirus` 命令为邮件系统管理员提供了一个方便的工具，用于快速启用邮件域名的反病毒扫描功能。通过执行此命令，您可以增强邮件系统的安全性，保护用户免受病毒邮件的侵害。请按照本文档中的说明进行操作，并根据您的实际需求使用示例来启用反病毒扫描功能。

## v-add-mail-domain-catchall

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-mail-domain-catchall)

`v-add-mail-domain-catchall` 是 Hestia 控制面板（CLI）中的一个脚本命令，是一个命令行工具，用于在特定的邮件域名上设置 catch-all 账户。Catch-all 账户将接收所有发送到该域名的邮件，无论邮件地址是否实际存在。这对于确保所有邮件都能被接收，或者将邮件转发到特定邮箱地址非常有用。

### 使用方法

在终端中执行 `v-add-mail-domain-catchall` 命令，并传递必要的参数。

#### 基本语法

```bash
v-add-mail-domain-catchall USER DOMAIN EMAIL
```

#### 参数说明

- **USER**：用户名，表示邮件域名的所有者。
- **DOMAIN**：要设置 catch-all 账户的邮件域名。
- **EMAIL**：用于接收所有邮件的邮箱地址（catch-all 地址）。

### 功能描述

`v-add-mail-domain-catchall` 命令执行以下操作：

1. 加载邮件系统和系统健康的配置文件及函数库。
2. 验证传递的参数数量、格式和有效性。
3. 检查邮件系统是否启用，以及用户和邮件域名是否有效且未被暂停。
4. 验证 catch-all 功能是否尚未在指定域名上启用。
5. 根据邮件系统的类型（如 exim），在用户的邮件配置目录中修改别名（aliases）文件，以设置 catch-all 功能。
6. 更新邮件域名的对象值，将 catch-all 邮箱地址设置为指定的 `EMAIL`。
7. 记录日志，标记 catch-all 功能已成功启用，并包含相关的用户、域名和邮箱地址信息。
8. 退出命令执行。

### 示例

假设您想要为用户 `john` 的 `example.com` 邮件域名设置一个 catch-all 账户，将所有邮件转发到 `catchall@example.org`，您可以使用以下命令：

```bash
v-add-mail-domain-catchall john example.com catchall@example.org
```

执行此命令后，系统将检查 `john` 用户和 `example.com` 域名的有效性，并确认该域名当前未启用 catch-all 功能。然后，系统将在用户的邮件配置目录中修改别名文件，将 `*@example.com` 的邮件转发到 `catchall@example.org`。最后，系统将更新该域名的 catch-all 设置，并记录一条日志，表明 catch-all 功能已成功启用。

### 注意事项

- 在执行 `v-add-mail-domain-catchall` 命令之前，请确保您具备足够的权限和访问控制，以防止未经授权的配置更改。
- 请确保您提供的用户名、域名和邮箱地址是有效的，并且域名确实存在于邮件系统中。
- 根据您的邮件系统配置，catch-all 功能可能已默认启用或禁用。此命令用于显式启用该功能，如果已启用则可能覆盖现有的设置。
- 启用 catch-all 功能可能会导致大量不必要的邮件被接收，因为所有发送到该域名的邮件都会被转发到指定的邮箱地址。请仔细考虑是否真的需要此功能，并根据实际需求进行配置。

### 错误处理

如果命令执行过程中遇到错误，例如参数格式不正确、用户或域名无效、域名已启用 catch-all 功能等情况，命令将返回相应的错误提示，并可能记录错误事件。

### 结论

`v-add-mail-domain-catchall` 命令为邮件系统管理员提供了一个方便的工具，用于快速设置邮件域名的 catch-all 功能。通过执行此命令，您可以确保所有发送到特定域名的邮件都能被接收或转发到指定的邮箱地址。请按照本文档中的说明进行操作，并根据您的实际需求使用示例来设置 catch-all 功能。

## v-add-mail-domain-dkim

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-mail-domain-dkim)

`v-add-mail-domain-dkim` 是 Hestia 控制面板（CLI）中的一个脚本命令，是一个命令行工具，用于在特定的邮件域名上启用 DKIM（DomainKeys Identified Mail）签名功能。DKIM 是一种电子邮件认证方法，用于验证邮件的发送者和内容是否被篡改。通过启用 DKIM，可以提高邮件的可信度，减少垃圾邮件和伪造邮件的风险。

### 使用方法

在终端中执行 `v-add-mail-domain-dkim` 命令，并传递必要的参数。

#### 基本语法

```bash
v-add-mail-domain-dkim USER DOMAIN [DKIM_SIZE]
```

#### 参数说明

- **USER**：用户名，表示邮件域名的所有者。
- **DOMAIN**：要启用 DKIM 签名的邮件域名。
- **DKIM_SIZE**（可选）：DKIM 密钥的大小，默认为 2048 位。

### 功能描述

`v-add-mail-domain-dkim` 命令执行以下操作：

1. 加载邮件系统和系统健康的配置文件及函数库。
2. 根据邮件系统的类型，确定用于管理邮件的用户账号。
3. 验证传递的参数数量、格式和有效性。
4. 检查邮件系统是否启用，以及用户和邮件域名是否有效且未被暂停。
5. 检查邮件域名是否已启用 DKIM 功能。
6. 生成 DKIM 私钥和公钥文件，并设置适当的权限。
7. 如果邮件系统支持，将私钥复制到邮件配置目录中。
8. 如果 DNS 系统已配置且 DNS 配置文件存在，则自动添加必要的 DKIM TXT 记录到 DNS 配置中。
9. 更新邮件域名的对象值，将 DKIM 状态设置为已启用。
10. 记录日志，标记 DKIM 功能已成功启用，并包含相关的用户、域名信息。
11. 退出命令执行。

### 示例

假设您想要为用户 `john` 的 `example.com` 邮件域名启用 DKIM 签名功能，并使用默认的密钥大小（2048 位），您可以使用以下命令：

```bash
v-add-mail-domain-dkim john example.com
```

执行此命令后，系统将生成 DKIM 私钥和公钥文件，并将私钥复制到用户的邮件配置目录中（如果邮件系统支持）。此外，如果 DNS 系统已配置且 DNS 配置文件存在，系统将自动添加必要的 DKIM TXT 记录到 DNS 配置中。最后，系统将更新邮件域名的 DKIM 状态，并记录一条日志，表明 DKIM 功能已成功启用。

### 注意事项

- 在执行 `v-add-mail-domain-dkim` 命令之前，请确保您具备足够的权限和访问控制，以防止未经授权的配置更改。
- 请确保您提供的用户名和域名是有效的，并且域名确实存在于邮件系统中。
- 根据您的邮件系统和 DNS 配置，DKIM 功能的启用可能需要额外的步骤或配置。此命令仅处理与 DKIM 密钥生成和 DNS 记录添加相关的部分。
- 如果您的 DNS 系统未配置或 DNS 配置文件不存在，命令将不会添加 DNS 记录。在这种情况下，您需要手动添加必要的 DKIM TXT 记录到 DNS 设置中。
- 请谨慎使用 DKIM 功能，并确保正确配置，以避免邮件发送问题或安全漏洞。

### 错误处理

如果命令执行过程中遇到错误，例如参数格式不正确、用户或域名无效、DKIM 功能已启用等情况，命令将返回相应的错误提示，并可能记录错误事件。

### 结论

`v-add-mail-domain-dkim` 命令为邮件系统管理员提供了一个方便的工具，用于启用邮件域名的 DKIM 签名功能。通过执行此命令，您可以提高邮件的可信度，减少垃圾邮件和伪造邮件的风险。请按照本文档中的说明进行操作，并根据您的实际需求使用示例来启用 DKIM 功能。

## v-add-mail-domain-reject

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-mail-domain-reject)

`v-add-mail-domain-reject` 是 Hestia 控制面板（CLI）中的一个脚本命令，命令是一个用于在邮件系统中启用特定邮件域名的垃圾邮件拒收功能的脚本。通过执行此命令，管理员可以为指定的邮件域名配置反垃圾邮件策略，以阻止潜在的垃圾邮件进入用户的收件箱。

### 使用方法

在终端中运行以下命令，并传递必要的参数：

```bash
v-add-mail-domain-reject USER DOMAIN
```

### 参数说明

- **USER**：邮件域名的所有者用户名。
- **DOMAIN**：要启用垃圾邮件拒收功能的邮件域名。

### 功能描述

`v-add-mail-domain-reject` 命令执行以下操作：

1. 加载邮件系统和系统配置相关的文件及函数库。
2. 检查传递的参数数量、格式和有效性。
3. 验证邮件系统是否启用，以及指定的用户和邮件域名是否有效且未被暂停。
4. 检查邮件域名是否已启用垃圾邮件拒收功能。
5. 如果邮件系统支持，为邮件域名创建一个表示启用垃圾邮件拒收的标志文件。
6. 更新邮件域名的对象值，将垃圾邮件拒收状态设置为已启用。
7. 记录日志，标记垃圾邮件拒收功能已成功启用，并包含相关的用户、域名信息。
8. 退出命令执行。

### 示例

假设您想要为用户 `john` 的 `example.com` 邮件域名启用垃圾邮件拒收功能，您可以运行以下命令：

```bash
v-add-mail-domain-reject john example.com
```

执行此命令后，系统将检查相关的配置和有效性，并在邮件系统中为 `example.com` 域名启用垃圾邮件拒收功能。根据邮件系统的配置，可能会创建相应的标志文件或更新配置文件。最后，系统将记录一条日志，表明垃圾邮件拒收功能已成功启用。

### 注意事项

- 在执行 `v-add-mail-domain-reject` 命令之前，请确保您具备足够的权限和访问控制，以防止未经授权的配置更改。
- 请确保您提供的用户名和域名是有效的，并且域名确实存在于邮件系统中。
- 根据您的邮件系统配置，启用垃圾邮件拒收功能可能需要额外的步骤或配置。此命令仅处理与垃圾邮件拒收功能启用相关的部分。
- 如果您的邮件系统不支持垃圾邮件拒收功能或需要特定的配置方式，该命令可能无法正常工作。在这种情况下，请参考邮件系统的文档或寻求技术支持。

### 错误处理

如果命令执行过程中遇到错误，例如参数格式不正确、用户或域名无效、垃圾邮件拒收功能已启用等情况，命令将返回相应的错误提示，并可能记录错误事件。

### 结论

`v-add-mail-domain-reject` 命令为邮件系统管理员提供了一个方便的工具，用于启用邮件域名的垃圾邮件拒收功能。通过执行此命令，您可以提高邮件系统的安全性，减少垃圾邮件的干扰。请按照本文档中的说明进行操作，并根据您的实际需求使用示例来启用垃圾邮件拒收功能。

## v-add-mail-domain-smtp-relay

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-mail-domain-smtp-relay)

`v-add-mail-domain-smtp-relay` 是 Hestia 控制面板（CLI）中的一个脚本命令，是一个用于配置邮件域名SMTP中继的脚本命令。通过此命令，您可以为指定的邮件域名设置SMTP中继服务器，以便通过该服务器发送电子邮件。

### 使用方法

在终端中运行以下命令，并传递必要的参数：

```bash
v-add-mail-domain-smtp-relay USER DOMAIN HOST [USERNAME] [PASSWORD] [PORT]
```

### 参数说明

- **USER**：邮件域名的所有者用户名。
- **DOMAIN**：要配置SMTP中继的邮件域名。
- **HOST**：SMTP中继服务器的地址或主机名。
- **USERNAME**（可选）：SMTP中继服务器的用户名。
- **PASSWORD**（可选）：SMTP中继服务器的密码。
- **PORT**（可选）：SMTP中继服务器的端口号，默认为587。

### 功能描述

`v-add-mail-domain-smtp-relay` 命令执行以下操作：

1. 加载邮件系统和系统配置相关的文件及函数库。
2. 检查传递的参数数量、格式和有效性。
3. 验证邮件系统是否启用，以及指定的用户和邮件域名是否有效且未被暂停。
4. 验证提供的密码和用户名（如果提供）的格式是否有效。
5. 检查系统是否处于演示模式，并阻止在演示模式下进行更改。
6. 创建或更新指定邮件域名的SMTP中继配置文件。
7. 在邮件系统的配置中，为指定域名添加或更新SMTP中继相关的键值对。
8. 记录日志，标记SMTP中继已启用，并包含相关的用户、域名、主机和端口信息。
9. 退出命令执行。

### 示例

假设您想要为用户 `john` 的 `example.com` 邮件域名配置SMTP中继服务器，地址为 `smtp.relay.com`，端口为 `587`，使用用户名 `john_relay` 和密码 `relay_password`，您可以运行以下命令：

```bash
v-add-mail-domain-smtp-relay john example.com smtp.relay.com john_relay relay_password 587
```

执行此命令后，系统将检查相关的配置和有效性，并在邮件系统中为 `example.com` 域名配置SMTP中继服务器。具体的配置信息将存储在相应的配置文件中，并更新到邮件系统的配置中。最后，系统将记录一条日志，表明SMTP中继已成功启用。

### 注意事项

- 在执行 `v-add-mail-domain-smtp-relay` 命令之前，请确保您具备足够的权限和访问控制，以防止未经授权的配置更改。
- 请确保您提供的用户名、密码、主机和端口信息是正确的，并且SMTP中继服务器是可达的。
- 根据您的邮件系统配置，启用SMTP中继可能需要额外的步骤或配置。此命令仅处理与SMTP中继配置相关的部分。
- 如果您的邮件系统不支持SMTP中继或需要特定的配置方式，该命令可能无法正常工作。在这种情况下，请参考邮件系统的文档或寻求技术支持。

### 错误处理

如果命令执行过程中遇到错误，例如参数格式不正确、用户或域名无效、SMTP中继服务器不可达等情况，命令将返回相应的错误提示，并可能记录错误事件。

### 结论

`v-add-mail-domain-smtp-relay` 命令为邮件系统管理员提供了一个方便的工具，用于配置邮件域名的SMTP中继服务器。通过执行此命令，您可以轻松地设置SMTP中继，以便通过指定的服务器发送电子邮件。请按照本文档中的说明进行操作，并根据您的实际需求使用示例来配置SMTP中继。

## v-add-mail-domain-ssl

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-mail-domain-ssl)

`v-add-mail-domain-ssl`是 Hestia 控制面板（CLI）中的一个脚本命令，是一个用于为邮件域名配置SSL证书的脚本命令。通过此命令，您可以为指定的邮件域名启用SSL加密，确保邮件传输的安全性。

### 使用方法

在终端中运行以下命令，并传递必要的参数：

```bash
v-add-mail-domain-ssl USER DOMAIN SSL_DIR [RESTART]
```

### 参数说明

- **USER**：邮件域名的所有者用户名。
- **DOMAIN**：要配置SSL的邮件域名。
- **SSL_DIR**：包含SSL证书和私钥文件的目录路径。
- **RESTART**（可选）：如果提供此参数，则命令执行完成后将尝试重启邮件服务。

### 功能描述

`v-add-mail-domain-ssl` 命令执行以下操作：

1. 加载邮件系统和系统配置相关的文件及函数库。
2. 转换域名格式，确保域名以小写形式且没有不必要的前缀或后缀。
3. 检查传递的参数数量、格式和有效性。
4. 验证邮件系统是否启用，以及指定的用户和邮件域名是否有效且未被暂停。
5. 检查是否已经为域名配置了SSL证书。
6. 检查Web域名的SSL证书是否有效。
7. 检查是否处于演示模式，并阻止在演示模式下进行更改。
8. 如果提供了`RESTART`参数，则验证其格式的有效性。
9. 获取域名的IP地址，并验证其有效性。
10. 调用`add_mail_ssl_config`函数，为邮件域名配置SSL加密。
11. 根据配置的Webmail系统（如Roundcube、Snappymail或Rainloop），更新Webmail的配置。
12. 如果提供了`RESTART`参数，则尝试重启邮件服务以应用新的SSL配置。

### 示例

假设您想要为用户 `john` 的 `example.com` 邮件域名配置SSL证书，证书和私钥文件存储在 `/path/to/ssl_dir` 目录中，并且您希望在配置完成后重启邮件服务，您可以运行以下命令：

```bash
v-add-mail-domain-ssl john example.com /path/to/ssl_dir true
```

执行此命令后，系统将检查相关的配置和有效性，并为 `example.com` 域名配置SSL加密。配置完成后，如果提供了`RESTART`参数，系统将尝试重启邮件服务。

### 注意事项

- 在执行 `v-add-mail-domain-ssl` 命令之前，请确保您已经拥有有效的SSL证书和私钥文件，并且它们位于指定的目录中。
- 请确保您提供的用户名、域名和SSL目录路径是正确的，并且邮件系统支持SSL加密。
- 根据您的邮件系统配置，启用SSL加密可能需要额外的步骤或配置。此命令仅处理与SSL证书配置相关的部分。
- 如果您的邮件系统不支持SSL或需要特定的配置方式，该命令可能无法正常工作。在这种情况下，请参考邮件系统的文档或寻求技术支持。

### 错误处理

如果命令执行过程中遇到错误，例如参数格式不正确、用户或域名无效、SSL证书无效或无法重启邮件服务等情况，命令将返回相应的错误提示，并可能记录错误事件。

### 结论

`v-add-mail-domain-ssl` 命令为邮件系统管理员提供了一个方便的工具，用于为邮件域名配置SSL加密。通过执行此命令，您可以轻松地启用SSL加密，保护邮件传输的安全性。请按照本文档中的说明进行操作，并根据您的实际需求使用示例来配置SSL加密。

## v-add-mail-domain-webmail

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-mail-domain-webmail)

`v-add-mail-domain-webmail` 是 Hestia 控制面板（CLI）中的一个脚本命令，命令用于为指定的用户邮件域名配置Webmail客户端。通过此命令，可以确保用户能够通过Webmail客户端访问其邮件。

### 使用方法

在终端中运行以下命令，并传递必要的参数：

```bash
v-add-mail-domain-webmail USER DOMAIN [WEBMAIL]
```

### 参数说明

- **USER**：邮件域名的所有者用户名。
- **DOMAIN**：要配置Webmail的邮件域名。
- **WEBMAIL**（可选）：要使用的Webmail客户端类型。如果未提供此参数，系统将使用默认配置的Webmail客户端。

### 功能描述

`v-add-mail-domain-webmail` 命令执行以下操作：

1. 加载系统配置和相关的函数库。
2. 验证传递的参数数量和格式是否正确。
3. 检查Web系统和IMAP系统是否已启用。
4. 验证指定的Webmail客户端类型是否有效。
5. 验证指定的用户和邮件域名是否有效且未被暂停。
6. 根据需要配置Webmail客户端的访问别名。
7. 应用配置更改，使Webmail客户端能够访问指定的邮件域名。

### 示例

#### 示例 1: 使用默认Webmail客户端

如果用户 `john` 希望为其 `example.com` 邮件域名配置Webmail客户端，并且想要使用系统默认配置的Webmail客户端，可以运行以下命令：

```bash
v-add-mail-domain-webmail john example.com
```

#### 示例 2: 指定Webmail客户端类型（SnappyMail）

如果用户 `alice` 希望为其 `alice.net` 邮件域名配置SnappyMail Webmail客户端，可以运行以下命令：

```bash
v-add-mail-domain-webmail alice alice.net snappymail
```

#### 示例 3: 指定Webmail客户端类型（Roundcube）

如果用户 `bob` 希望为其 `bobdomain.org` 邮件域名配置Roundcube Webmail客户端，可以运行以下命令：

```bash
v-add-mail-domain-webmail bob bobdomain.org roundcube
```

### 注意事项

- 在执行 `v-add-mail-domain-webmail` 命令之前，请确保Webmail客户端已经正确安装并配置在您的系统上。
- 如果您的邮件系统不支持Webmail或需要特定的配置方式，该命令可能无法正常工作。在这种情况下，请参考邮件系统和Webmail客户端的文档或寻求技术支持。
- 如果未指定Webmail客户端类型，系统将使用默认配置的Webmail客户端。请确保默认配置符合您的需求。

### 错误处理

如果命令执行过程中遇到错误，例如参数格式不正确、用户或域名无效、Webmail客户端类型无效等情况，命令将返回相应的错误提示。请根据错误提示进行相应的检查和调整。

### 结论

`v-add-mail-domain-webmail` 命令为邮件系统管理员提供了一个方便的工具，用于为用户邮件域名配置Webmail客户端。通过执行此命令，您可以轻松地启用Webmail客户端，使用户能够通过Web界面访问和管理邮件。请按照本文档中的说明进行操作，并根据您的实际需求使用示例来配置Webmail客户端。

## v-add-sys-roundcube

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-sys-roundcube)

`v-add-sys-roundcube`是 Hestia 控制面板（CLI）中的一个脚本命令，用于在 HestiaCP 邮件系统中安装或更新 Roundcube Webmail 客户端。该脚本会自动下载 Roundcube 的最新版本，并配置好相关的文件和目录，使得 Roundcube 能够与 HestiaCP 集成，并提供 Web 邮件访问功能。

### 使用方法

在终端中运行以下命令来执行脚本：

```bash
v-add-sys-roundcube [MODE]
```

其中 `[MODE]` 是一个可选参数，用于指定脚本的执行模式。具体的模式参数取决于脚本的实现和您的需求。通常，您可以传递如 `install` 或 `update` 等参数来指示脚本执行安装或更新操作。

### 功能描述

1. **权限检查**：脚本首先检查当前用户是否为 root 用户，因为只有 root 用户才能执行该脚本所需的操作。

2. **环境变量验证**：验证 `$HESTIA`、`$HOMEDIR` 和 `$HESTIA_COMMON_DIR` 等环境变量是否存在，以确保脚本能够正确运行。

3. **数据库系统检查**：确认系统中是否安装了 MySQL 数据库，因为 Roundcube 需要 MySQL 作为其后端数据库。

4. **安装源检查**：如果 Roundcube 已经通过 apt 包管理器安装，脚本会检测到并提示用户无法继续通过此脚本进行安装。

5. **版本检查**：如果 Roundcube 已经安装，脚本会检查已安装的版本与要安装的版本是否相同。如果版本相同，则不会执行任何操作。

6. **下载与安装**：如果满足安装条件，脚本会下载 Roundcube 的最新版本，解压到指定目录，并复制配置文件到相应的位置。

7. **配置链接**：在 Roundcube 的安装完成后，脚本会创建一个指向配置文件的符号链接，以便在后续更新时能够保持配置的一致性。

### 示例

#### 示例 1: 安装 Roundcube

假设您想要全新安装 Roundcube，可以运行以下命令：

```bash
sudo v-add-sys-roundcube install
```

脚本将执行安装流程，包括下载 Roundcube、解压文件、配置目录和文件等。

#### 示例 2: 更新 Roundcube

如果您已经安装了 Roundcube，并想要更新到最新版本，可以运行：

```bash
sudo v-add-sys-roundcube update
```

脚本将检查已安装的版本，并下载最新版本进行更新。

### 注意事项

- 在执行脚本之前，请确保您已经备份了重要的数据和配置文件，以防万一发生意外情况。
- 根据您的网络环境和 Roundcube 的版本大小，下载和安装过程可能需要一些时间。
- 如果在执行脚本过程中遇到错误或问题，请查看脚本输出的错误消息，并根据需要进行故障排除。

### 结论

`v-add-sys-roundcube` 是一个方便的工具，用于在 HestiaCP 系统中安装或更新 Roundcube Webmail 客户端。通过正确使用此脚本，您可以轻松地为您的系统添加或更新 Roundcube 功能，从而为用户提供更加便捷和高效的 Web 邮件访问体验。

## v-add-sys-smtp

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-sys-smtp)

`v-add-sys-smtp` 是 Hestia 控制面板（CLI）中的一个脚本命令，用于为服务器配置 SMTP 账户，以便用于日志记录、通知和内部邮件等。该脚本允许用户指定域名、端口、SMTP 安全性、用户名、密码和电子邮件地址，以配置 SMTP 设置。

### 使用方法

在终端中运行以下命令来执行脚本：

```bash
v-add-sys-smtp DOMAIN PORT SMTP_SECURITY USERNAME PASSWORD EMAIL
```

其中：

- `DOMAIN` 是 SMTP 服务器的域名。
- `PORT` 是 SMTP 服务器使用的端口号。
- `SMTP_SECURITY` 是 SMTP 连接的安全性选项（如 SSL、TLS 或 STARTTLS）。
- `USERNAME` 是 SMTP 账户的用户名。
- `PASSWORD` 是 SMTP 账户的密码。
- `EMAIL` 是服务器用于发送邮件的电子邮件地址。

### 示例

假设您想要配置 SMTP 账户，以便服务器能够通过 `example.com` 域名、`587` 端口、`STARTTLS` 安全性选项、`test@domain.com` 用户名、`securepassword` 密码和 `test@example.com` 电子邮件地址发送邮件。您可以运行以下命令：

```bash
v-add-sys-smtp example.com 587 STARTTLS test@domain.com securepassword test@example.com
```

### 功能描述

1. **参数定义**：脚本首先定义并获取传入的参数，包括域名、端口、SMTP 安全性、用户名、密码和电子邮件地址。

2. **包含文件**：脚本会包含 HestiaCP 的配置文件和函数文件，以便使用其中的变量和函数。

3. **参数检查**：脚本会检查传入的参数数量是否符合要求，并验证域名、端口、电子邮件和密码的格式是否有效。同时，还会检查用户名格式是否有效，并去除密码中的引号。

4. **只读模式检查**：如果服务器处于只读模式（例如，在演示模式下），脚本会进行验证并终止执行。

5. **系统值修改**：脚本会修改系统值，将 SMTP 相关的配置信息（如主机名、端口、安全性、用户名、密码和电子邮件地址）保存到系统中。

6. **日志记录**：脚本会记录一条日志，表明 SMTP 配置已启用，并将执行结果记录到日志文件中。

### 注意事项

- 在执行脚本之前，请确保您已经了解了 SMTP 服务器的配置要求，并获取了正确的配置信息。
- 脚本会修改系统的配置信息，因此请谨慎操作，并确保您具有足够的权限来执行此操作。
- 根据您的网络环境和 SMTP 服务器的配置，脚本的执行可能需要一些时间。
- 如果在执行脚本过程中遇到错误或问题，请查看脚本输出的错误消息，并根据需要进行故障排除。

### 结论

`v-add-sys-smtp` 脚本为 HestiaCP 系统提供了一个方便的方式来配置 SMTP 账户，以便用于服务器的日志记录、通知和内部邮件等。通过正确使用该脚本，您可以轻松地配置 SMTP 设置，并确保服务器能够正常发送邮件。

## v-add-sys-smtp-relay

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-sys-smtp-relay)

`v-add-sys-smtp-relay` 是 Hestia 控制面板（CLI）中的一个脚本命令，用于在系统级别添加 SMTP 中继支持。通过此脚本，用户可以方便地配置 SMTP 中继服务器的相关信息，以便系统能够通过该中继服务器发送邮件。

### 使用方法

在终端中运行以下命令来执行脚本：

```bash
v-add-sys-smtp-relay HOST [USERNAME] [PASSWORD] [PORT]
```

其中：

- `HOST` 是 SMTP 中继服务器的地址。
- `USERNAME` 是 SMTP 中继账户的用户名（可选）。
- `PASSWORD` 是 SMTP 中继账户的密码（可选）。
- `PORT` 是 SMTP 中继服务器使用的端口号（可选，默认为 587）。

### 示例

假设我们有一个 SMTP 中继服务器，其主机名为 `srv.smtprelay.tld`，用户名为 `uname123`，密码为 `pass12345`。我们可以使用以下命令来配置 SMTP 中继：

```bash
v-add-sys-smtp-relay srv.smtprelay.tld uname123 pass12345
```

执行此命令后，脚本将执行以下操作：

1. 定义并获取传入的参数，包括主机地址、用户名、密码和端口号（如果未指定端口号，则使用默认值 587）。
2. 包含必要的配置文件和函数文件，以便使用其中的变量和函数。
3. 检查传入的参数数量、格式和有效性，确保提供的值符合要求。
4. 检查系统邮件服务是否已启用，以确保 SMTP 中继配置有意义。
5. 如果服务器处于只读模式（如演示模式），则脚本会进行验证并终止执行。
6. 修改系统值，将 SMTP 中继相关的配置信息（如主机地址、端口号、用户名）保存到系统中。
7. 创建或更新配置文件（如 `/etc/exim4/smtp_relay.conf`），将主机地址、端口号、用户名和密码写入该文件，以便邮件传输代理使用。
8. 记录一条日志，表明系统级别的 SMTP 中继已启用，并包含相关的配置信息。

### 注意事项

- 在执行脚本之前，请确保您已经了解了 SMTP 中继服务器的配置要求，并获取了正确的配置信息。
- 根据您的网络环境和 SMTP 中继服务器的配置，脚本的执行可能需要一些时间。
- 脚本会修改系统的配置信息并创建或更新配置文件，因此请谨慎操作，并确保您具有足够的权限来执行此操作。
- 如果在执行脚本过程中遇到错误或问题，请查看脚本输出的错误消息，并根据需要进行故障排除。

### 结论

通过结合使用 `v-add-sys-smtp-relay` 命令和提供的示例，您可以轻松地为系统配置 SMTP 中继支持。这将使您的系统能够使用指定的 SMTP 中继服务器发送邮件，提高邮件传输的可靠性和效率。请确保在配置过程中遵循最佳实践和安全准则，以确保系统的安全性和稳定性。

## v-add-sys-snappymail

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-sys-snappymail)

`v-add-sys-snappymail` 是 Hestia 控制面板（CLI）中的一个脚本命令，是一个用于在系统上安装或更新 SnappyMail webmail 客户端的命令。以下是该命令的详细使用说明和示例。

### 命令概述

`v-add-sys-snappymail` 命令负责下载、安装或更新 SnappyMail，并根据需要记录相应的日志信息。该命令通常用于自动化脚本中，以简化 SnappyMail 的部署和更新过程。

### 命令语法

```bash
v-add-sys-snappymail [MODE]
```

### MODE选项

- `-u` 或 `--update`: 指定为更新操作，而不是安装。
- `--install-dir <目录>`: 指定 SnappyMail 的安装目录。
- `--file <文件名>`: 指定下载的 SnappyMail 文件的名称。
- `--url <URL>`: 指定下载的 SnappyMail 文件的 URL。
- `--log-bin <路径>`: 指定用于记录日志的二进制文件路径。
- `--verbose`: 开启详细输出模式，显示更多信息。
- `--help`: 显示帮助信息。

### 示例

#### 示例 1: 安装 SnappyMail

```bash
v-add-sys-snappymail --install-dir /opt/snappymail --file snappymail.tar.gz --url http://example.com/snappymail.tar.gz --log-bin /usr/bin/v-log-action
```

这个示例中，`v-add-sys-snappymail` 命令将从指定的 URL 下载 `snappymail.tar.gz` 文件，并将其安装到 `/opt/snappymail` 目录下。日志记录将使用 `/usr/bin/v-log-action` 二进制文件。

#### 示例 2: 更新 SnappyMail

```bash
v-add-sys-snappymail -u --install-dir /opt/snappymail --file snappymail-update.tar.gz --url http://example.com/snappymail-update.tar.gz
```

在这个示例中，使用 `-u` 或 `--update` 选项来指示命令执行更新操作。它将从指定的 URL 下载 `snappymail-update.tar.gz` 文件，并更新 `/opt/snappymail` 目录下的 SnappyMail 安装。

### 注意事项

- 在执行 `v-add-sys-snappymail` 命令之前，请确保已经正确设置了所有必要的选项和参数。
- 根据实际情况，您可能需要具有适当的权限（如 root 权限）来执行安装或更新操作。
- 请确保提供的 URL 是有效的，并且下载的文件是完整的，以避免安装或更新失败。
- 如果命令执行过程中遇到任何问题，请检查错误消息并根据需要进行故障排除。

### 日志记录

`v-add-sys-snappymail` 命令在执行过程中会记录相关的日志信息。日志记录的具体行为取决于提供的 `--log-bin` 选项的值。您可以根据需要配置日志记录路径和格式，以便后续分析和排查问题。

### 总结

`v-add-sys-snappymail` 命令是一个强大的工具，用于在系统上安装和更新 SnappyMail webmail 客户端。通过正确配置选项和参数，您可以轻松地自动化 SnappyMail 的部署和更新过程，并记录相关的日志信息以供后续分析。

### v-add-user

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-user)

`v-add-user` 是 Hestia 控制面板（CLI）中的一个脚本，命令通常用于添加新用户到系统中，并可以指定用户的各种属性，如密码、电子邮件等。以下是该命令的详细使用说明，并结合了实际示例。

### 命令格式

```bash
v-add-user 用户名 --password 密码 --email 电子邮件地址 [其他选项]
```

### 命令选项

- `--password` 或 `-p`：指定用户的密码。
- `--email` 或 `-e`：指定用户的电子邮件地址。
- `--package` 或 `-k`：指定用户所使用的包或套餐（如果适用）。
- `--other-options`：其他可选参数，根据具体实现而定。

### 示例

#### 示例 1：添加新用户并设置密码及电子邮件

```bash
v-add-user newuser --password MyStr0ngP4ssw0rd --email newuser@example.com
```

在这个示例中，我们添加了一个名为 `newuser` 的新用户，并设置了密码为 `MyStr0ngP4ssw0rd`，电子邮件地址为 `newuser@example.com`。

#### 示例 2：添加新用户并指定包或套餐

```bash
v-add-user premiumuser --password SecureP@ssword --email premiumuser@example.com --package PremiumPackage
```

这个示例演示了如何为 `premiumuser` 用户指定一个 `PremiumPackage` 包或套餐，同时设置了密码和电子邮件地址。

#### 示例 3：使用脚本批量添加用户

如果您需要添加多个用户，并希望自动化这个过程，可以使用脚本结合 `v-add-user` 命令。以下是一个简单的示例脚本：

```bash
#!/bin/bash

# 用户列表及对应的密码和电子邮件
users=("user1" "user2" "user3")
passwords=("P4ssw0rd1" "P4ssw0rd2" "P4ssw0rd3")
emails=("user1@example.com" "user2@example.com" "user3@example.com")

# 遍历用户列表并添加用户
for ((i=0; i<${#users[@]}; i++)); do
    user=${users[$i]}
    password=${passwords[$i]}
    email=${emails[$i]}
    
    v-add-user "$user" --password "$password" --email "$email"
    echo "User $user added with password $password and email $email"
done
```

这个脚本定义了一个用户列表 `users`，以及对应的密码 `passwords` 和电子邮件地址 `emails`。然后，它使用循环遍历用户列表，并使用 `v-add-user` 命令逐个添加用户。

### 注意事项

- 在使用 `v-add-user` 命令时，请确保您有足够的权限来添加用户。
- 出于安全考虑，不要直接在命令行中传递明文密码。在实际应用中，您应该使用更安全的方法来管理和设置用户密码，例如从加密的配置文件或环境变量中读取密码。
- 根据您的系统和环境的不同，`v-add-user` 命令的选项和参数可能有所差异。请确保参考相关文档或帮助信息以获取准确的用法说明。

通过结合上述示例和说明，您应该能够更全面地了解 `v-add-user` 命令的使用方法和常见场景，以便在实际应用中有效地添加和管理用户。

## v-delete-mail-account

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-mail-account)

`v-delete-mail-account`是 Hestia 控制面板（CLI）中的一个脚本， 是一个用于删除邮件账户的脚本命令。它接受三个参数：用户名（USER）、域名（DOMAIN）和账户名（ACCOUNT），用于指定要删除的邮件账户。

### 命令格式

```bash
v-delete-mail-account USER DOMAIN ACCOUNT
```

### 参数说明

- `USER`：邮件账户所属的用户名。
- `DOMAIN`：邮件账户的域名。
- `ACCOUNT`：要删除的邮件账户名。

### 工作流程

1. **参数检查**：检查是否提供了正确的参数数量，并对参数进行格式验证。
2. **系统状态检查**：检查邮件系统是否启用，以及相关的用户、域名和账户是否存在且有效。
3. **别名处理**：如果邮件系统使用的是 exim，脚本会查找并删除与待删除账户相关的别名。
4. **配置文件更新**：从相关配置文件中删除与待删除账户相关的条目。
5. **账户计数更新**：更新域名的账户数量，并减少用户的邮件账户数量。
6. **日志记录**：记录删除邮件账户的操作的信息。

### 示例

假设我们有一个名为 `alice` 的邮件账户，属于用户 `admin`，在 `acme.com` 域名下。要删除这个邮件账户，可以使用以下命令：

```bash
v-delete-mail-account admin acme.com alice
```

执行这个命令后，脚本会执行以下操作：

- 检查参数是否完整且有效。
- 检查 `admin` 用户、`acme.com` 域名和 `alice` 账户是否存在且有效。
- 如果邮件系统使用的是 exim，删除与 `alice` 账户相关的别名。
- 从相关配置文件中删除 `alice` 账户的条目。
- 更新 `acme.com` 域名的账户数量，并减少 `admin` 用户的邮件账户数量。
- 记录删除 `alice@acme.com` 邮件账户的操作日志。

### 注意事项

- 在执行删除操作之前，请确保您具有足够的权限，并确认要删除的账户是正确的。
- 根据您的系统和环境的不同，`v-delete-mail-account` 命令的具体实现和参数可能有所差异。请确保参考相关文档或帮助信息以获取准确的用法说明。

通过使用 `v-delete-mail-account` 命令，您可以方便地删除不再需要的邮件账户，并保持邮件系统的整洁和高效。

### v-delete-mail-account-alias

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-mail-account-alias)

`v-delete-mail-account-alias` 是 Hestia 控制面板（CLI）中的一个脚本，是一个用于删除邮件账户别名的脚本命令。它接受四个参数：用户名（USER）、域名（DOMAIN）、账户名（ACCOUNT）和别名（ALIAS），用于指定要删除的邮件账户别名。

### 命令格式

```bash
v-delete-mail-account-alias USER DOMAIN ACCOUNT ALIAS
```

### 参数说明

- `USER`：邮件账户所属的用户名。
- `DOMAIN`：邮件账户的域名。
- `ACCOUNT`：邮件账户名。
- `ALIAS`：要删除的邮件账户别名。

### 工作流程

1. **参数检查**：检查是否提供了正确的参数数量，并对参数进行格式验证。
2. **系统状态检查**：检查邮件系统是否启用，以及相关的用户、域名和账户是否存在且有效。
3. **别名存在性检查**：确认指定的别名是否存在于账户中。
4. **别名删除**：如果邮件系统使用的是 exim，从别名配置文件中删除指定的别名条目。
5. **别名列表更新**：更新账户的别名列表，删除已删除的别名。
6. **日志记录**：记录删除邮件账户别名的操作信息。

### 示例

假设我们有一个名为 `alice` 的邮件账户，在 `example.com` 域名下，并且该账户有一个别名 `alicia`。要删除这个别名，可以使用以下命令：

```bash
v-delete-mail-account-alias admin example.com alice alicia
```

执行这个命令后，脚本会执行以下操作：

- 检查参数是否完整且有效。
- 检查邮件系统是否启用，以及 `admin` 用户、`example.com` 域名和 `alice` 账户是否存在且有效。
- 确认别名 `alicia` 是否存在于 `alice` 账户的别名列表中。
- 如果邮件系统使用的是 exim，从别名配置文件中删除 `alicia` 的条目。
- 更新 `alice` 账户的别名列表，移除 `alicia`。
- 记录删除 `alicia` 别名的操作日志。

### 示例 1：删除指定用户的邮件账户别名

假设您有一个邮件系统，其中用户 `john` 在 `company.org` 域名下有一个名为 `john.doe` 的账户，并且该账户有一个别名 `johnd`. 您想要删除这个别名，可以使用以下命令：

```bash
v-delete-mail-account-alias john company.org john.doe johnd
```

执行这个命令后，脚本将检查参数的有效性，并删除 `john.doe` 账户中的 `johnd` 别名。

### 示例 2：删除多个别名

如果您想要删除同一个账户下的多个别名，您需要为每个别名单独执行一次命令。例如，如果 `john.doe` 账户还有另一个别名 `j.doe`，您可以这样操作：

首先删除 `johnd` 别名：

```bash
v-delete-mail-account-alias john company.org john.doe johnd
```

然后删除 `j.doe` 别名：

```bash
v-delete-mail-account-alias john company.org john.doe j.doe
```

### 示例 3：错误处理示例

如果您尝试删除一个不存在的别名，脚本会输出错误消息并退出。例如：

```bash
v-delete-mail-account-alias john company.org john.doe nonexistentalias
```

如果 `nonexistentalias` 别名不存在于 `john.doe` 账户中，脚本将输出类似以下的错误消息：

```
Error: alias nonexistentalias doesn't exist
```

并退出执行，返回错误代码。

### 示例 4：检查权限和系统状态

在执行删除别名操作之前，脚本会检查当前用户是否有足够的权限，以及邮件系统是否启用。例如，如果当前用户没有足够的权限，或者邮件系统被禁用，脚本将不会执行删除操作，并输出相应的错误信息。

### 示例 5：结合其他脚本或命令使用

您还可以将 `v-delete-mail-account-alias` 命令与其他脚本或命令结合使用，以实现更复杂的邮件账户管理任务。例如，您可以编写一个脚本，该脚本首先检查别名是否存在，然后根据检查结果决定是否调用 `v-delete-mail-account-alias` 命令。

### 注意事项

- 在执行删除操作之前，请确保您具有足够的权限，并确认要删除的别名是正确的。
- 如果指定的别名不存在于账户中，脚本将输出错误消息并退出。
- 根据您的系统和环境的不同，`v-delete-mail-account-alias` 命令的具体实现和参数可能有所差异。请确保参考相关文档或帮助信息以获取准确的用法说明。

通过使用 `v-delete-mail-account-alias` 命令，您可以方便地管理邮件账户的别名，删除不再需要的别名，保持邮件系统的整洁和高效。

## v-delete-mail-account-autoreply

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-mail-account-autoreply)

`v-delete-mail-account-autoreply` 是 Hestia 控制面板（CLI）中的一个脚本，是一个用于删除邮件账户自动回复消息的脚本命令。它接受三个参数：用户名（USER）、域名（DOMAIN）和账户名（ACCOUNT），用于指定要删除自动回复消息的邮件账户。

### 命令格式

```bash
v-delete-mail-account-autoreply USER DOMAIN ACCOUNT
```

### 参数说明

- `USER`：邮件账户所属的用户名。
- `DOMAIN`：邮件账户的域名。
- `ACCOUNT`：邮件账户名。

### 工作流程

1. **参数检查**：检查是否提供了正确的参数数量，并对参数进行格式验证。
2. **系统状态检查**：检查邮件系统是否启用，以及相关的用户、域名和账户是否存在且有效。
3. **自动回复消息存在性检查**：确认指定的账户是否设置了自动回复消息。
4. **删除自动回复文件**：如果邮件系统使用的是 exim，从自动回复消息的配置文件中删除指定的账户条目。
5. **更新账户配置**：将账户的自动回复值更新为 'no'，表示已删除自动回复消息。
6. **日志记录**：记录删除邮件账户自动回复消息的操作信息。

### 示例

假设我们有一个名为 `bob` 的邮件账户，在 `mydomain.tld` 域名下，并且该账户设置了自动回复消息。要删除这个自动回复消息，可以使用以下命令：

```bash
v-delete-mail-account-autoreply admin mydomain.tld bob
```

执行这个命令后，脚本会执行以下操作：

- 检查参数是否完整且有效。
- 检查邮件系统是否启用，以及 `admin` 用户、`mydomain.tld` 域名和 `bob` 账户是否存在且有效。
- 确认 `bob` 账户是否设置了自动回复消息。
- 如果邮件系统使用的是 exim，从自动回复消息的配置文件中删除 `bob` 的条目。
- 更新 `bob` 账户的配置，将自动回复值设置为 'no'。
- 记录删除 `bob` 账户自动回复消息的操作日志。

### 注意事项

- 在执行删除操作之前，请确保您具有足够的权限，并确认要删除的自动回复消息是正确的。
- 如果指定的账户没有设置自动回复消息，脚本可能仍然会执行，并将自动回复值更新为 'no'，但不会有实际文件被删除。
- 根据您的系统和环境的不同，`v-delete-mail-account-autoreply` 命令的具体实现和参数可能有所差异。请确保参考相关文档或帮助信息以获取准确的用法说明。

通过使用 `v-delete-mail-account-autoreply` 命令，您可以方便地管理邮件账户的自动回复消息，关闭不再需要的自动回复功能，保持邮件系统的整洁和高效。

## v-delete-mail-account-forward

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-mail-account-forward)

`v-delete-mail-account-forward` 是 Hestia 控制面板（CLI）中的一个脚本，是一个用于删除邮件账户转发地址的脚本命令。它接受四个参数：用户名（USER）、域名（DOMAIN）、账户名（ACCOUNT）和要删除的转发地址（EMAIL）。

### 命令格式

```bash
v-delete-mail-account-forward USER DOMAIN ACCOUNT EMAIL
```

### 参数说明

- `USER`：邮件账户所属的用户名。
- `DOMAIN`：邮件账户的域名。
- `ACCOUNT`：邮件账户名。
- `EMAIL`：要删除的转发地址。

### 工作流程

1. **参数检查**：检查是否提供了正确的参数数量，并对参数进行格式验证。
2. **系统状态检查**：确认邮件系统是否启用，并检查用户、域名和账户是否存在且有效。
3. **转发地址存在性检查**：检查指定的转发地址是否存在于账户的转发设置中。
4. **删除转发地址**：从邮件系统的配置文件中删除指定的转发地址。
5. **更新账户配置**：更新账户的转发设置，移除已删除的转发地址。
6. **日志记录**：记录删除邮件账户转发地址的操作信息。

### 示例

假设我们有一个名为 `tony` 的邮件账户，在 `acme.com` 域名下，并且该账户设置了将邮件转发到 `bob@acme.com`。要删除这个转发地址，可以使用以下命令：

```bash
v-delete-mail-account-forward admin acme.com tony bob@acme.com
```

执行这个命令后，脚本会执行以下操作：

- 检查参数是否完整且有效。
- 检查邮件系统是否启用，以及 `admin` 用户、`acme.com` 域名和 `tony` 账户是否存在且有效。
- 确认 `tony` 账户的转发设置中是否包含 `bob@acme.com` 这个地址。
- 如果使用的是 exim 邮件系统，从 `tony` 账户的转发配置文件中删除 `bob@acme.com` 这个转发地址。
- 更新 `tony` 账户的转发设置，移除 `bob@acme.com`。
- 记录删除 `tony` 账户转发地址到 `bob@acme.com` 的操作日志。

### 注意事项

- 在执行删除操作之前，请确保您具有足够的权限，并确认要删除的转发地址是正确的。
- 如果指定的转发地址不存在于账户的转发设置中，脚本可能会记录一个错误或警告信息，但通常不会中断执行。
- 根据您的系统和环境的不同，`v-delete-mail-account-forward` 命令的具体实现和参数可能有所差异。请确保参考相关文档或帮助信息以获取准确的用法说明。

通过使用 `v-delete-mail-account-forward` 命令，您可以方便地管理邮件账户的转发设置，删除不再需要的转发地址，保持邮件转发的清晰和高效。

## v-delete-mail-account-fwd-only

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-mail-account-fwd-only)

`v-delete-mail-account-fwd-only` 脚本用于删除邮件账户的转发仅（forward-only）标志。转发仅标志用于指定账户只接受转发邮件，不接受直接发送到该账户的邮件。本脚本适用于邮件服务器管理，可方便地管理邮件账户的转发设置。

### 脚本参数

- `USER`：邮件账户所属的用户名。
- `DOMAIN`：邮件账户的域名。
- `ACCOUNT`：邮件账户名。

### 工作原理

脚本执行以下操作：

1. **参数检查**：验证是否提供了正确的参数数量，并对参数进行格式验证。
2. **系统状态检查**：确认邮件系统是否启用，并检查用户、域名和账户是否存在且有效。
3. **删除转发仅标志**：根据邮件系统类型（如 exim），从相应的配置文件中删除指定账户的转发仅标志。
4. **更新账户配置**：更新邮件账户的转发设置，禁用转发仅功能。
5. **日志记录**：记录禁用邮件账户转发仅功能的操作信息。

### 示例用法

假设要删除 `example.com` 域名下 `jack` 账户的转发仅标志，可以使用以下命令：

```bash
v-delete-mail-account-fwd-only admin example.com jack
```

其中 `admin` 是执行此操作的管理员用户名。执行此命令后，脚本将按照上述工作流程处理，并删除 `jack` 账户的转发仅标志。

### 注意事项

- 在执行脚本之前，请确保您具有足够的权限，并确认要操作的账户和转发仅标志是正确的。
- 不同的邮件系统可能有不同的配置文件和设置方式，因此请根据您使用的邮件系统类型和版本进行适当的配置和修改。
- 在修改邮件系统配置文件时，请小心谨慎，避免误操作导致邮件服务中断或数据丢失。

通过使用 `v-delete-mail-account-fwd-only` 脚本，您可以方便地管理邮件账户的转发设置，确保账户能够按照您的需求接收邮件或作为转发账户使用。请确保在操作前备份相关配置文件，以防万一。

## v-delete-mail-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-mail-domain)

### 概述

`v-delete-mail-domain` 是 Hestia 控制面板（CLI）中的一个脚本，是一个用于删除邮件域名的脚本工具。该脚本允许管理员通过简单的命令行操作，删除指定邮件域名及其相关的邮件账户、配置和文件。通过该脚本，管理员可以轻松地管理和维护邮件服务器上的邮件域名。

### 使用方法

要使用 `v-delete-mail-domain` 脚本，管理员需要具有相应的权限，并在命令行终端中执行以下命令：

```bash
v-delete-mail-domain [管理员用户名] [邮件域名]
```

其中，`[管理员用户名]` 是执行删除操作的管理员的用户名，`[邮件域名]` 是要删除的邮件域名。

### 示例

#### 示例一：删除单个邮件域名

假设管理员 `admin` 想要删除名为 `example.com` 的邮件域名，可以执行以下命令：

```bash
v-delete-mail-domain admin example.com
```

执行此命令后，`example.com` 域名下的所有邮件账户、配置和文件将被删除。

#### 示例二：删除带有特殊字符的邮件域名

如果邮件域名包含特殊字符，如连字符（`-`），管理员可以照常使用脚本进行删除。例如，要删除名为 `mail-server.net` 的邮件域名，可以执行：

```bash
v-delete-mail-domain admin mail-server.net
```

#### 示例三：确认删除操作

为了确保安全，管理员在执行删除操作前可能需要确认。以下是一个简单的示例，通过用户输入来确认删除操作：

```bash
echo "Are you sure you want to delete the mail domain 'company.org'?"
read response
if [ "$response" == "yes" ]; then
    v-delete-mail-domain admin company.org
    echo "Mail domain 'company.org' has been deleted."
else
    echo "Mail domain deletion has been cancelled."
fi
```

#### 示例四：删除多个邮件域名

如果需要一次性删除多个邮件域名，可以使用循环结构。以下是一个使用 Bash 脚本删除多个邮件域名的示例：

```bash
domains=("domain1.com" "domain2.net" "domain3.org")

for domain in "${domains[@]}"; do
    v-delete-mail-domain admin "$domain"
    if [ $? -eq 0 ]; then
        echo "Mail domain '$domain' has been deleted."
    else
        echo "Failed to delete mail domain '$domain'."
    fi
done
```

#### 示例五：删除前备份配置

在执行删除操作前，进行配置备份是一个良好的实践。以下是一个示例，展示了如何在删除邮件域名之前备份相关的配置文件和目录：

```bash
# 创建备份目录
backup_dir="/path/to/backup/$(date +%Y%m%d%H%M%S)"
mkdir -p "$backup_dir"

# 备份邮件域名的配置文件和目录
cp -r /etc/mailserver/domains/"$domain" "$backup_dir/"
cp /etc/mailserver/mail.conf "$backup_dir/"

# 执行删除操作
v-delete-mail-domain admin "$domain"

# 输出备份信息
echo "Backup created at $backup_dir"
```

在这个示例中，管理员首先创建了一个以当前时间戳命名的备份目录，并将与待删除邮件域名相关的配置文件和目录复制到该目录中。然后，执行删除操作，并输出备份目录的路径以便管理员后续查看或使用。

### 注意事项

- 在执行删除操作之前，请务必确认要删除的邮件域名，避免误删重要数据。
- 根据实际情况，管理员可能需要调整脚本中的路径和配置文件名。
- 在执行脚本之前，确保管理员具有足够的权限来删除邮件域名及其相关文件。

通过 `v-delete-mail-domain` 脚本，管理员可以方便地对邮件服务器上的邮件域名进行管理，确保邮件系统的正常运行和数据安全。请根据实际情况和需求使用脚本，并在执行任何删除操作之前备份重要数据。

## v-delete-mail-domain-antispam

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-mail-domain-antispam)

### 概述

`v-delete-mail-domain-antispam` 是 Hestia 控制面板（CLI）中的一个脚本，脚本用于在邮件系统中禁用特定邮件域名的反垃圾邮件（antispam）功能。它允许管理员通过提供用户名和域名作为参数来执行此操作。该脚本特别适用于基于 HestiaCP 环境的邮件服务器，其中集成了 Exim 邮件传输代理和 SpamAssassin 反垃圾邮件软件。

### 使用方法

脚本的使用方法如下：

```bash
v-delete-mail-domain-antispam [用户名] [域名]
```

其中：

- `[用户名]`：执行操作的管理员或用户的用户名。
- `[域名]`：要禁用反垃圾邮件功能的邮件域名。

### 示例

#### 示例一：禁用单个域名的反垃圾邮件功能

假设管理员 `admin` 想要禁用名为 `example.com` 的邮件域名的反垃圾邮件功能，可以执行以下命令：

```bash
v-delete-mail-domain-antispam admin example.com
```

执行此命令后，脚本将检查参数的有效性，并确保邮件系统已启用，以及指定的用户和域名存在且未被暂停。然后，它将删除相关的反垃圾邮件配置，并更新邮件域名的 `$ANTISPAM` 属性值为 `no`，从而禁用反垃圾邮件功能。

#### 示例二：禁用带有特殊字符的域名的反垃圾邮件功能

如果邮件域名包含特殊字符，如连字符（`-`），管理员可以照常使用脚本进行禁用。例如，要禁用名为 `mail-server.net` 的邮件域名的反垃圾邮件功能，可以执行：

```bash
v-delete-mail-domain-antispam admin mail-server.net
```

#### 示例三：检查参数并处理错误

脚本中包含参数检查和错误处理的逻辑，确保脚本的正确执行。如果提供的参数数量不正确，或者指定的用户或域名不存在、被暂停或没有启用反垃圾邮件功能，脚本将输出相应的错误消息并退出。

#### 示例四：禁用多个域名的反垃圾邮件功能

如果需要一次性禁用多个域名的反垃圾邮件功能，管理员可以编写一个循环结构来依次调用 `v-delete-mail-domain-antispam` 脚本。例如，可以使用 Bash 脚本循环遍历一个包含多个域名的数组，并对每个域名执行禁用操作。

### 注意事项

- 在执行脚本之前，请确保管理员具有足够的权限来修改邮件域名的配置。
- 根据邮件服务器的具体配置和环境，可能需要调整脚本中的路径和变量名称。
- 在禁用反垃圾邮件功能之前，请确保了解相关的安全风险和影响，以避免潜在的邮件滥用或垃圾邮件问题。

通过 `v-delete-mail-domain-antispam` 脚本，管理员可以方便地管理邮件域名的反垃圾邮件设置，提高邮件系统的灵活性和可维护性。请根据实际情况和需求使用脚本，并遵循最佳实践来确保邮件系统的安全和稳定运行。

## v-delete-mail-domain-antivirus

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-mail-domain-antivirus)

### 概述

`v-delete-mail-domain-antivirus` 是 Hestia 控制面板（CLI）中的一个脚本，脚本用于禁用特定邮件域名的反病毒（antivirus）扫描功能。该脚本特别适用于基于 HestiaCP 环境的邮件服务器，其中集成了 Exim 邮件传输代理和 ClamAV 反病毒软件。通过执行此脚本，管理员可以方便地管理邮件系统的安全性，并根据需要禁用不必要的反病毒扫描。

### 使用方法

脚本的使用方法如下：

```bash
v-delete-mail-domain-antivirus [用户名] [域名]
```

其中：

- `[用户名]`：执行操作的管理员或用户的用户名。
- `[域名]`：要禁用反病毒扫描功能的邮件域名。

### 示例

#### 示例一：禁用单个域名的反病毒扫描功能

假设管理员 `admin` 想要禁用名为 `example.com` 的邮件域名的反病毒扫描功能，可以执行以下命令：

```bash
v-delete-mail-domain-antivirus admin example.com
```

执行此命令后，脚本将检查参数的有效性，并确保邮件系统已启用，以及指定的用户和域名存在且未被暂停。然后，它将删除相关的反病毒扫描配置，并更新邮件域名的 `$ANTIVIRUS` 属性值为 `no`，从而禁用反病毒扫描功能。

#### 示例二：禁用带有特殊字符的域名的反病毒扫描功能

如果邮件域名包含特殊字符，如连字符（`-`），管理员可以照常使用脚本进行禁用。例如，要禁用名为 `mail-server.net` 的邮件域名的反病毒扫描功能，可以执行：

```bash
v-delete-mail-domain-antivirus admin mail-server.net
```

#### 示例三：检查参数并处理错误

脚本中包含了参数检查和错误处理的逻辑，确保脚本的正确执行。如果提供的参数数量不正确，或者指定的用户或域名不存在、被暂停或没有启用反病毒扫描功能，脚本将输出相应的错误消息并退出。

#### 示例四：禁用多个域名的反病毒扫描功能

如果需要一次性禁用多个域名的反病毒扫描功能，管理员可以编写一个循环结构来依次调用 `v-delete-mail-domain-antivirus` 脚本。例如，可以使用 Bash 脚本循环遍历一个包含多个域名的数组，并对每个域名执行禁用操作。

### 注意事项

- 在执行脚本之前，请确保管理员具有足够的权限来修改邮件域名的配置。
- 根据邮件服务器的具体配置和环境，可能需要调整脚本中的路径和变量名称。
- 在禁用反病毒扫描功能之前，请确保了解相关的安全风险和影响，以避免潜在的邮件安全问题。

通过 `v-delete-mail-domain-antivirus` 脚本，管理员可以灵活地管理邮件域名的反病毒扫描设置，根据实际需求调整邮件系统的安全策略。请根据实际情况和需求使用脚本，并遵循最佳实践来确保邮件系统的安全和稳定运行。

## v-delete-mail-domain-catchall

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-mail-domain-catchall)

### 脚本概述

`v-delete-mail-domain-catchall` 是 Hestia 控制面板（CLI）中的一个脚本，用于禁用邮件域的 catchall 设置。Catchall 功能是邮件系统中的一个特性，它允许邮件域接收所有发送到该域但无明确收件人的电子邮件，并将这些邮件转发到预设的邮箱中，通常是管理员邮箱或特定的接收邮箱。此脚本旨在通过接收用户名和域名作为参数，来禁用特定邮件域的 catchall 功能。

### 使用示例

#### 示例 1: 禁用管理员用户的 catchall 功能

```bash
v-delete-mail-domain-catchall admin example.com
```

#### 示例 2: 禁用其他用户的 catchall 功能

```bash
v-delete-mail-domain-catchall john.doe mydomain.net
```

### 脚本参数

- `USER`: 用户名，用于标识执行操作的管理员或用户。
- `DOMAIN`: 邮件域名，即需要禁用 catchall 功能的邮件域。

### 脚本功能

1. **参数验证**: 验证脚本是否接收到了正确的用户名和域名参数。
2. **环境配置加载**: 加载邮件系统配置和脚本执行所需的函数库。
3. **权限检查**: 检查当前用户是否有权限执行 catchall 功能的禁用操作。
4. **Catchall 功能禁用**: 根据邮件系统配置，执行禁用 catchall 功能的操作，可能包括从配置文件中删除相关设置或更新数据库记录。
5. **日志记录**: 记录脚本执行的操作、结果以及任何可能的错误或警告信息。

### 注意事项

- 请确保在执行脚本之前已经了解邮件系统的配置和运作方式。
- 禁用 catchall 功能可能会影响邮件域的邮件接收策略，因此请在执行前进行充分的测试和评估。
- 脚本可能需要以具有足够权限的用户身份执行，通常是系统管理员或具有邮件系统管理权限的用户。

### 安全性

- 脚本在执行之前会进行参数验证和环境检查，以确保操作的安全性和准确性。
- 未经授权的用户不应执行此脚本，以免对邮件系统造成不必要的干扰或破坏。

### 脚本扩展与定制

- 可以根据邮件系统的不同配置和需求对脚本进行定制和扩展。
- 可以添加更多的日志记录功能，以便更好地跟踪和监控脚本的执行情况和结果。
- 可以考虑添加异常处理和错误提示，提高脚本的健壮性和用户友好性。

### 总结

`v-delete-mail-domain-catchall` 脚本是一个用于禁用邮件域 catchall 功能的实用工具。通过调用脚本并传递相应的参数，管理员可以轻松地管理邮件转发设置，提高邮件系统的安全性和灵活性。请确保在使用脚本之前充分了解其功能和注意事项，并根据实际情况进行必要的配置和定制。

## v-delete-mail-domain-dkim

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-mail-domain-dkim)

### 脚本概述

`v-delete-mail-domain-dkim` 是 Hestia 控制面板（CLI）中的一个脚本，用于删除特定邮件域的 DKIM（DomainKeys Identified Mail）签名支持。DKIM 是一种电子邮件认证技术，用于验证邮件发送者的身份并确保邮件内容在传输过程中未被篡改。该脚本通过删除 PEM 文件和相关的 DNS 记录来禁用 DKIM 功能。

### 使用示例

#### 示例 1: 禁用管理员用户的邮件域 DKIM 支持

```bash
v-delete-mail-domain-dkim admin mydomain.tld
```

#### 示例 2: 禁用普通用户的邮件域 DKIM 支持

```bash
v-delete-mail-domain-dkim john.doe example.com
```

### 脚本执行流程

1. **参数接收与验证**：脚本接收用户名和域名作为参数，并验证其有效性。

2. **环境配置加载**：加载 Hestia 控制面板的配置文件和必要的函数库。

3. **权限和状态检查**：验证当前用户是否有权限执行此操作，检查邮件系统是否启用，以及用户和域名的有效性。

4. **DKIM 删除操作**：如果邮件系统为 exim，脚本将删除与指定域名相关的 PEM 文件。

5. **DNS 记录删除**：如果启用了 DNS 系统，并且存在与域名相关的 DNS 配置文件，脚本将查找并删除所有与 DKIM 相关的 DNS 记录。

6. **配置更新**：更新系统配置，将域名的 DKIM 状态设置为禁用。

7. **日志记录**：记录脚本执行的操作、结果以及任何可能的错误或警告信息。

### 注意事项

- 在执行此脚本之前，请确保您已经了解 Hestia 控制面板、邮件系统和 DNS 系统的配置和运作方式。
- 禁用 DKIM 功能可能会影响邮件的验证和可信度，因此请确保在执行此操作前已经进行了充分的测试和评估。
- 脚本需要具有足够权限的用户执行，通常是系统管理员或具有邮件系统管理权限的用户。

### 安全性

- 脚本在执行之前会进行参数验证和环境检查，以确保操作的安全性和准确性。
- 未经授权的用户不应执行此脚本，以免对邮件系统或 DNS 系统造成不必要的干扰或破坏。

### 脚本定制与扩展

- 根据您的具体需求，您可以对脚本进行定制和扩展。例如，您可以添加更多的日志记录功能以跟踪脚本的执行情况，或者添加异常处理和错误提示以提高脚本的健壮性。
- 如果您在使用脚本时遇到任何问题或需要进一步的支持，请参考 Hestia 控制面板的官方文档或联系技术支持团队。

### 总结

`v-delete-mail-domain-dkim` 脚本是一个强大的工具，用于在 Hestia 控制面板中删除邮件域的 DKIM 支持。通过调用脚本并传递适当的参数，管理员可以轻松地管理邮件域的 DKIM 设置，从而提高邮件系统的安全性和可信度。请确保在使用脚本之前充分了解其功能和注意事项，并根据实际情况进行必要的配置和定制。

## v-delete-mail-domain-reject

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-mail-domain-reject)

### 命令概述

`v-delete-mail-domain-reject` 是 Hestia 控制面板中的一个命令行工具，用于删除特定邮件域的垃圾邮件拒绝支持。该命令允许管理员禁用对进入邮件的垃圾邮件检测功能，以确保来自特定域名的邮件不会被系统错误地拦截或拒绝。

### 使用方法

使用 `v-delete-mail-domain-reject` 命令时，需要提供两个参数：用户名和域名。

#### 示例

```bash
v-delete-mail-domain-reject admin mydomain.tld
```

在这个例子中，`admin` 是执行命令的用户名，而 `mydomain.tld` 是需要删除垃圾邮件拒绝支持的域名。

### 命令流程

1. **参数接收与验证**：命令接收用户名和域名作为输入，并验证它们的格式和有效性。

2. **环境配置加载**：加载 Hestia 控制面板的配置文件和必要的函数库。

3. **权限和状态检查**：检查当前用户是否有权限执行此操作，并验证邮件系统是否启用，以及指定用户和域名是否存在且未被暂停。

4. **只读模式检查**：如果系统处于只读模式（如演示模式），则执行相应的验证。

5. **删除垃圾邮件拒绝标志**：如果邮件系统为 exim，命令将删除与指定域名相关的垃圾邮件拒绝标志文件。

6. **更新配置**：更新系统配置，将域名的垃圾邮件拒绝状态设置为禁用。

7. **日志记录**：记录命令执行的操作、结果以及任何可能的错误或警告信息。

### 注意事项

- 禁用垃圾邮件拒绝功能可能会增加收到垃圾邮件的风险，因此请在执行此命令前仔细评估风险。
- 执行此命令需要具有足够权限的用户，通常是系统管理员或具有邮件系统管理权限的用户。
- 在禁用垃圾邮件拒绝功能之前，请确保已经了解了垃圾邮件过滤机制和系统配置，以避免不必要的邮件丢失或安全问题。

### 安全性

- 该命令在执行前会进行参数验证和环境检查，以确保操作的安全性和准确性。
- 未经授权的用户不应执行此命令，以避免对邮件系统造成不必要的干扰或破坏。

### 自定义与扩展

- 根据实际需求，您可以自定义或扩展此命令的功能。例如，可以添加更详细的日志记录、错误处理或额外的验证步骤。
- 如果您在使用命令时遇到任何问题或需要更多支持，请参考 Hestia 控制面板的官方文档或联系技术支持团队。

### 总结

`v-delete-mail-domain-reject` 命令是 Hestia 控制面板中一个实用的工具，用于管理邮件域的垃圾邮件拒绝功能。通过正确使用该命令，管理员可以灵活地控制邮件的接收策略，并根据实际情况调整垃圾邮件过滤设置。请确保在理解命令功能和注意事项的前提下谨慎操作，以确保邮件系统的正常运行和安全性。

## v-delete-mail-domain-smtp-relay

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-mail-domain-smtp-relay)

### 命令概述

`v-delete-mail-domain-smtp-relay` 是 Hestia 控制面板中的一个命令行工具，用于删除特定邮件域的 SMTP 中继支持。通过执行此命令，管理员可以禁用特定域名通过 SMTP 中继发送邮件的功能，以控制邮件的发送策略。

### 使用方法

使用 `v-delete-mail-domain-smtp-relay` 命令时，需要提供两个参数：用户名和域名。

#### 示例

```bash
v-delete-mail-domain-smtp-relay user domain.tld
```

在这个例子中，`user` 是执行命令的用户名，而 `domain.tld` 是需要删除 SMTP 中继支持的域名。

### 命令流程

1. **参数接收与验证**：命令接收用户名和域名作为输入，并验证它们的格式和有效性。

2. **环境配置加载**：加载 Hestia 控制面板的配置文件和必要的函数库。

3. **权限和状态检查**：检查当前用户是否有权限执行此操作，并验证邮件系统是否启用，以及指定用户和域名是否存在且未被暂停。

4. **删除 SMTP 中继配置文件**：如果存在与指定域名相关的 SMTP 中继配置文件，则将其删除。

5. **更新配置**：将邮件域的 SMTP 中继相关配置项重置为默认或禁用状态，包括禁用 SMTP 中继功能、清除中继主机、端口、用户名和密码等。

6. **日志记录**：记录命令执行的操作、结果以及任何可能的错误或警告信息。

### 注意事项

- 删除 SMTP 中继支持将阻止指定域名的邮件通过中继服务器发送，确保在执行此命令前已经了解了邮件发送策略和系统配置。
- 执行此命令需要具有足够权限的用户，通常是系统管理员或具有邮件系统管理权限的用户。
- 如果需要在未来重新启用 SMTP 中继功能，请确保在删除前备份相关的配置文件和设置。

### 安全性

- 该命令在执行前会进行参数验证和环境检查，以确保操作的安全性和准确性。
- 未经授权的用户不应执行此命令，以避免对邮件系统造成不必要的干扰或破坏。

### 自定义与扩展

- 根据实际需求，您可以自定义或扩展此命令的功能。例如，可以添加更详细的日志记录、错误处理或额外的验证步骤。
- 如果您在使用命令时遇到任何问题或需要更多支持，请参考 Hestia 控制面板的官方文档或联系技术支持团队。

### 总结

`v-delete-mail-domain-smtp-relay` 命令是 Hestia 控制面板中一个用于管理邮件域 SMTP 中继功能的实用工具。通过正确使用该命令，管理员可以灵活地控制邮件的发送策略，并根据实际情况调整 SMTP 中继设置。请确保在理解命令功能和注意事项的前提下谨慎操作，以确保邮件系统的正常运行和安全性。

## v-delete-mail-domain-ssl

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-mail-domain-ssl)

### 命令概述

`v-delete-mail-domain-ssl` 是 Hestia 控制面板中的一个命令行工具，用于删除特定邮件域的 SSL 支持。通过执行此命令，管理员可以移除邮件域相关的 SSL 证书配置，以禁用邮件服务的加密通信。

### 使用方法

使用 `v-delete-mail-domain-ssl` 命令时，需要提供用户名、域名以及一个可选的重启参数。

#### 示例

```bash
v-delete-mail-domain-ssl user demo.com
```

在这个例子中，`user` 是执行命令的用户名，`demo.com` 是需要删除 SSL 支持的域名。如果需要重启邮件服务器，可以传递一个额外的参数，例如 `true` 或 `yes`。

### 命令流程

1. **参数接收与验证**：命令接收用户名、域名和可选的重启参数，并进行格式化和有效性检查。

2. **环境配置加载**：加载 Hestia 控制面板的配置文件和必要的函数库。

3. **权限和状态检查**：验证当前用户是否有权限执行此操作，检查邮件系统是否启用，以及指定用户和域名是否存在且有效。

4. **只读模式检查**：如果系统处于只读模式（如演示模式），则进行必要的验证和警告。

5. **删除 SSL 配置**：删除邮件域相关的 SSL 证书配置，包括邮件服务和 Webmail 的 SSL 配置。

6. **更新配置**：将邮件域的 SSL 启用状态更新为禁用，并更新相关的 Let's Encrypt 配置和用户 SSL 计数。

7. **重启邮件服务器**：如果提供了重启参数且需要重启邮件服务器，则执行重启操作，并检查重启结果。

8. **日志记录**：记录命令执行的操作、结果以及任何可能的错误或警告信息。

### 注意事项

- 删除 SSL 支持将导致邮件服务不再使用加密连接，确保在执行此命令前已经了解了相关的安全风险。
- 只有在确实需要禁用 SSL 支持时才应执行此命令，以避免对邮件通信的安全性造成不必要的影响。
- 如果需要重新启用 SSL 支持，请确保已经获得了有效的 SSL 证书，并正确配置了相关的 SSL 设置。

### 安全性

- 该命令在执行前会进行参数验证和环境检查，以确保操作的安全性和准确性。
- 未经授权的用户不应执行此命令，以避免对邮件系统造成不必要的干扰或破坏。

### 自定义与扩展

- 根据实际需求，您可以自定义或扩展此命令的功能。例如，可以添加更详细的日志记录、错误处理或额外的验证步骤。
- 如果您在使用命令时遇到任何问题或需要更多支持，请参考 Hestia 控制面板的官方文档或联系技术支持团队。

### 总结

`v-delete-mail-domain-ssl` 命令是 Hestia 控制面板中一个用于管理邮件域 SSL 支持的实用工具。通过正确使用该命令，管理员可以灵活地控制邮件服务的加密通信，并根据实际情况调整 SSL 配置。请确保在执行此命令前充分了解相关的安全风险，并谨慎操作。

## v-delete-mail-domain-webmail

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-mail-domain-webmail)

### 命令概述

`v-delete-mail-domain-webmail` 是 Hestia 控制面板中的一个命令行工具，用于删除特定邮件域的 Webmail 支持。通过执行此命令，管理员可以禁用用户通过 Webmail 访问其邮件域的功能。

### 使用方法

使用 `v-delete-mail-domain-webmail` 命令时，需要提供用户名、域名以及可选的重启和静默参数。

#### 示例

```bash
v-delete-mail-domain-webmail user demo.com true
```

在这个例子中，`user` 是执行命令的用户名，`demo.com` 是需要禁用 Webmail 支持的域名，`true` 表示执行后需要重启相关服务。

### 命令流程

1. **参数接收与验证**：命令接收用户名、域名、重启参数和静默参数，并进行格式化和有效性检查。

2. **环境配置加载**：加载 Hestia 控制面板的配置文件和必要的函数库。

3. **权限和状态检查**：验证当前用户是否有权限执行此操作，并检查邮件、Web 和 IMAP 系统是否启用。

4. **只读模式检查**：如果系统处于只读模式（如演示模式），则进行必要的验证和警告。

5. **删除 Webmail 配置**：如果 `WEBMAIL_ALIAS` 在配置文件中已定义，则删除相关的 Webmail 配置和 SSL 配置。

6. **DNS 记录处理**：如果 DNS 系统已启用，并且 `WEBMAIL_ALIAS` 不等于 "mail"，则查找相关的 DNS 记录，并根据条件决定是否删除 Webmail 相关的 DNS 记录。

7. **更新配置**：将邮件域的 Webmail 启用状态更新为禁用。

8. **服务重启**：如果提供了重启参数，则重启 Web 和代理服务，并检查重启结果。

9. **日志记录**：记录命令执行的操作、结果以及任何可能的错误或警告信息。静默模式下不记录日志信息。

10. **退出**：命令执行完毕后退出。

### 注意事项

- 在执行此命令前，请确保已经备份了重要的配置和数据，以防意外情况发生。
- 删除 Webmail 支持将导致用户无法通过 Web 界面访问其邮件，确保在执行此命令前已经通知了相关用户并得到了他们的同意。
- 如果需要重新启用 Webmail 支持，请确保已经正确配置了相关的 Webmail 设置，并重新启用相应的服务。

### 安全性

- 该命令在执行前会进行参数验证和环境检查，以确保操作的安全性和准确性。
- 未经授权的用户不应执行此命令，以避免对邮件和 Web 服务造成不必要的干扰或破坏。

### 自定义与扩展

- 根据实际需求，您可以自定义或扩展此命令的功能。例如，可以添加更详细的日志记录、错误处理或额外的验证步骤。
- 如果您在使用命令时遇到任何问题或需要更多支持，请参考 Hestia 控制面板的官方文档或联系技术支持团队。

### 总结

`v-delete-mail-domain-webmail` 命令是 Hestia 控制面板中一个用于管理邮件域 Webmail 支持的实用工具。通过正确使用该命令，管理员可以灵活地控制用户对邮件域的 Webmail 访问权限。请确保在执行此命令前充分了解相关的操作和影响，并谨慎操作。

## v-delete-mail-domains

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-mail-domains)

### 命令概述

`v-delete-mail-domains` 是 Hestia 控制面板中的一个命令行工具，用于删除指定用户的所有邮件域。通过执行此命令，管理员可以一次性删除用户下的所有邮件域，从而简化管理过程。

### 使用方法

使用 `v-delete-mail-domains` 命令时，需要提供用户名作为参数。

#### 示例

```bash
v-delete-mail-domains john
```

在这个例子中，`john` 是需要删除其所有邮件域的用户名。

### 命令流程

1. **参数接收与验证**：命令接收用户名作为参数，并进行格式和有效性检查。

2. **环境配置加载**：加载 Hestia 控制面板的配置文件和必要的函数库。

3. **权限和状态检查**：验证当前用户是否有权限执行此操作，并检查邮件系统是否启用。

4. **只读模式检查**：如果系统处于只读模式（如演示模式），则进行必要的验证和警告。

5. **删除邮件域**：通过循环遍历所有非暂停状态的邮件域，使用 `v-delete-mail-domain` 命令逐一删除这些邮件域。

6. **日志记录**：记录命令执行的操作、结果以及任何可能的错误或警告信息。

7. **退出**：命令执行完毕后退出。

### 注意事项

- 在执行此命令前，请确保已经备份了重要的配置和数据，以防意外情况发生。
- 删除邮件域将导致用户无法再通过这些域接收或发送邮件，确保在执行此命令前已经通知了相关用户并得到了他们的同意。
- 请谨慎使用此命令，因为它将一次性删除用户下的所有邮件域，且不可恢复。

### 安全性

- 该命令在执行前会进行参数验证和环境检查，以确保操作的安全性和准确性。
- 未经授权的用户不应执行此命令，以避免对邮件服务造成不必要的干扰或破坏。

### 自定义与扩展

- 根据实际需求，您可以自定义或扩展此命令的功能。例如，可以添加更详细的日志记录、错误处理或额外的验证步骤。
- 如果您在使用命令时遇到任何问题或需要更多支持，请参考 Hestia 控制面板的官方文档或联系技术支持团队。

### 总结

`v-delete-mail-domains` 命令是 Hestia 控制面板中一个用于批量删除用户邮件域的实用工具。通过正确使用该命令，管理员可以高效地管理邮件域，减少手动操作的繁琐性。请确保在执行此命令前充分了解相关的操作和影响，并谨慎操作。

## v-check-mail-account-hash

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-check-mail-account-hash)

### 命令概述

`v-check-mail-account-hash` 是 Hestia 控制面板中的一个命令行工具，用于验证电子邮件账户的密码哈希值。通过提供密码哈希类型、密码和哈希值作为参数，该命令可以检查密码是否与给定的哈希值匹配。

### 使用方法

使用 `v-check-mail-account-hash` 命令时，需要指定三个参数：哈希类型（TYPE）、密码（PASSWORD）和哈希值（HASH）。

#### 示例

```bash
v-check-mail-account-hash ARGONID2 mypassword HASH_VALUE
```

在这个例子中，`ARGONID2` 是哈希类型，`mypassword` 是要验证的密码，`HASH_VALUE` 是与密码对应的哈希值。

### 参数说明

- **TYPE**：哈希类型，如 `BCRYPT` 或 `ARGONID2`。这指示命令使用哪种加密算法来验证密码哈希。
- **PASSWORD**：要验证的密码。
- **HASH**：与密码对应的哈希值。

### 命令流程

1. **参数接收与验证**：命令接收三个参数，并进行有效性检查。

2. **环境配置加载**：加载 Hestia 控制面板的配置文件和必要的函数库。

3. **密码验证**：调用 `is_password_valid` 函数来验证密码是否符合要求。

4. **哈希类型处理**：根据提供的哈希类型（`TYPE`），命令使用不同的算法进行验证。

   - 如果 `TYPE` 是 `BCRYPT`，则使用 `doveadm pw` 命令的 `BLF-CRYPT` 选项来验证密码和哈希值。
   - 如果 `TYPE` 是 `ARGONID2`，则使用 `doveadm pw` 命令的 `ARGON2ID` 选项进行验证。

5. **验证结果处理**：

   - 如果密码与哈希值匹配，命令将退出并返回状态码 0，表示验证成功。
   - 如果密码与哈希值不匹配，命令将输出错误消息并退出，返回状态码 2。
   - 如果提供了不支持的哈希类型，命令将输出错误消息并退出。

6. **退出**：命令执行完毕后退出。

### 注意事项

- 在执行此命令时，请确保提供的哈希类型和哈希值与实际的密码存储机制相匹配。
- 为了安全起见，不要在命令行中直接暴露密码或哈希值，特别是在多用户环境中。
- 如果验证失败，请检查密码和哈希值是否正确，以及是否使用了正确的哈希类型。

### 安全性

- 该命令在内部使用 `doveadm pw` 命令来验证密码哈希，这是一个经过验证和安全的工具。
- 在使用此命令时，请确保遵循最佳的安全实践，如不在不安全的环境中传输敏感信息。

### 自定义与扩展

- 根据实际需求，您可以扩展此命令的功能，例如添加更多的哈希类型支持或集成其他密码验证工具。
- 如果您在使用命令时遇到任何问题或需要更多支持，请参考 Hestia 控制面板的官方文档或联系技术支持团队。

### 总结

`v-check-mail-account-hash` 命令是一个用于验证电子邮件账户密码哈希值的实用工具。通过正确使用该命令，管理员可以方便地验证密码的正确性，确保账户的安全性。请确保在使用此命令时遵循相关的安全和最佳实践。

## v-change-sys-webmail

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-sys-webmail)

### 命令概述

`v-change-sys-webmail` 是一个用于修改 Hestia 控制面板中系统 Webmail 别名 URL 的命令行工具。通过执行此命令，管理员可以方便地更改 Webmail 的访问路径，以满足特定的需求或安全性考虑。

### 使用方法

使用 `v-change-sys-webmail` 命令时，需要提供新的 Webmail 别名作为参数。

#### 示例

```bash
v-change-sys-webmail newwebmailalias
```

在这个例子中，`newwebmailalias` 是新的 Webmail 别名，用于替换现有的别名。

### 参数说明

- **WEBMAIL**：新的 Webmail 别名，用于替换现有的别名。

### 命令流程

1. **参数接收**：命令接收新的 Webmail 别名作为参数。

2. **环境配置加载**：加载 Hestia 控制面板的配置文件和必要的函数库。

3. **验证只读模式**：检查系统是否处于只读模式（如演示模式），如果是，则进行相应的处理或警告。

4. **删除旧的 Webmail 配置**：遍历所有用户和邮件域，删除旧的 Webmail 配置。

5. **设置新的 Webmail 别名**：在系统配置中更新 Webmail 别名的值为新的别名。

6. **添加新的 Webmail 配置**：遍历所有用户和邮件域，为每个邮件域添加新的 Webmail 配置。

7. **更新 Web 服务器配置**：如果系统使用的是 Apache，则更新 Apache 的配置文件，将旧的 Webmail 别名替换为新的别名。

8. **重启服务**：根据参数或默认设置，重启 Web 服务器和代理服务，使更改生效。

9. **日志记录**：记录更改操作的信息，包括新的别名、旧的别名以及操作结果。

10. **退出**：命令执行完毕后退出。

### 注意事项

- 在执行此命令前，请确保已经备份了相关的配置文件和数据，以防意外情况发生。
- 更改 Webmail 别名可能会影响用户访问 Webmail 的方式，请确保在更改后通知相关用户，并提供新的访问路径。
- 如果系统正在使用其他 Web 服务器（如 Nginx），可能需要手动更新配置文件以反映新的 Webmail 别名。

### 安全性

- 修改 Webmail 别名可以增加系统的安全性，通过更改默认的访问路径，减少潜在的攻击面。
- 请确保新的 Webmail 别名足够复杂和难以猜测，以避免被恶意用户利用。

### 自定义与扩展

- 根据实际需求，您可以自定义或扩展此命令的功能。例如，可以添加额外的验证步骤、日志记录或通知机制。
- 如果您在使用命令时遇到任何问题或需要更多支持，请参考 Hestia 控制面板的官方文档或联系技术支持团队。

### 总结

`v-change-sys-webmail` 命令是一个强大的工具，用于修改 Hestia 控制面板中系统 Webmail 的别名 URL。通过正确使用该命令，管理员可以灵活地调整 Webmail 的访问路径，提高系统的安全性和可用性。请确保在执行此命令前充分了解相关的操作和影响，并谨慎操作。

## v-change-mail-account-password

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-mail-account-password)

### 命令概述

`v-change-mail-account-password` 是一个 Hestia 控制面板的命令行工具，用于更改指定邮件账户的密码。该命令允许管理员或授权用户为特定的邮件账户设置新密码，以确保账户的安全性。

### 使用方法

`v-change-mail-account-password` 命令需要四个参数：用户名、域名、账户名和新密码。

#### 示例

```bash
v-change-mail-account-password john example.com john_account newpassword123
```

在这个例子中，`john` 是用户名，`example.com` 是域名，`john_account` 是要更改密码的邮件账户名，`newpassword123` 是新的密码。

### 参数说明

- **user**：用户名，用于标识邮件账户的所有者。
- **domain**：域名，邮件账户所在的域。
- **account**：邮件账户名，要更改密码的特定账户。
- **password**：新密码，为邮件账户设置的新访问凭证。

### 命令流程

1. **参数接收**：命令接收用户名、域名、账户名和新密码作为参数。

2. **环境配置加载**：加载 Hestia 控制面板的配置文件和必要的函数库。

3. **参数验证**：检查提供的参数是否有效，包括格式验证和系统状态检查。

4. **对象有效性检查**：验证用户名、域名和邮件账户是否存在且未被暂停。

5. **密码验证**：验证新密码是否符合系统的密码策略要求。

6. **只读模式检查**：检查系统是否处于只读模式（如演示模式），如果是，则进行相应的处理或警告。

7. **密码加密**：根据系统配置选择适当的加密算法（如 BLF-CRYPT、ARGON2ID 或 MD5），将新密码进行加密处理。

8. **更新密码**：根据邮件系统的类型（如 Exim），更新邮件账户的密码信息。

9. **日志记录**：记录密码更改操作的信息，包括用户名、操作类型和账户名。

10. **退出**：命令执行完毕后退出。

### 注意事项

- 在执行此命令前，请确保您具有足够的权限来更改邮件账户的密码。
- 提供的新密码应符合系统的密码策略要求，以增强账户的安全性。
- 如果邮件系统使用的是特定的加密算法或存储机制，该命令会相应地处理密码的加密和存储。

### 安全性

- 通过使用强密码和定期更改密码，可以减少邮件账户被未经授权访问的风险。
- 密码加密确保了新密码在存储和传输过程中的安全性，防止了密码泄露的风险。

### 自定义与扩展

- 根据实际需求，您可以自定义密码策略、加密算法或日志记录机制，以满足特定的安全性要求。
- 如果您在使用命令时遇到任何问题或需要更多支持，请参考 Hestia 控制面板的官方文档或联系技术支持团队。

### 总结

`v-change-mail-account-password` 命令是 Hestia 控制面板中一个重要的命令行工具，用于更改邮件账户的密码。通过正确使用该命令，管理员可以确保邮件账户的安全性，并维护系统的正常运行。请确保在执行此命令前充分了解相关的操作和影响，并谨慎操作。

## v-change-mail-account-quota

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-mail-account-quota)

### 命令概述

`v-change-mail-account-quota` 是一个 Hestia 控制面板的命令行工具，用于更改指定邮件账户的配额限制。该命令允许管理员或授权用户为特定的邮件账户设置配额，以控制其邮件存储的大小。

### 使用方法

`v-change-mail-account-quota` 命令需要四个参数：用户名、域名、账户名和配额。

#### 示例

```bash
v-change-mail-account-quota john example.com john_account 1000M
```

在这个例子中，`john` 是用户名，`example.com` 是域名，`john_account` 是要更改配额的邮件账户名，`1000M` 是新的配额限制。

### 参数说明

- **user**：用户名，用于标识邮件账户的所有者。
- **domain**：域名，邮件账户所在的域。
- **account**：邮件账户名，要更改配额的特定账户。
- **quota**：配额限制，可以是具体的数字大小（如 1000M）或 'unlimited' 表示无限制。

### 命令流程

1. **参数接收**：命令接收用户名、域名、账户名和配额作为参数。

2. **环境配置加载**：加载 Hestia 控制面板的配置文件和必要的函数库。

3. **参数验证**：检查提供的参数是否有效，包括格式验证和系统状态检查。

4. **对象有效性检查**：验证用户名、域名和邮件账户是否存在且未被暂停。

5. **系统状态检查**：检查邮件系统是否已启用。

6. **配额验证**：如果配额不是 'unlimited'，则验证配额的格式是否符合要求。

7. **密码获取**：获取邮件账户的当前密码哈希值，用于更新配额时保持密码不变。

8. **更新配额**：根据邮件系统的类型（如 Exim），更新邮件账户的配额信息。

9. **日志记录**：记录配额更改操作的信息，包括用户名、操作类型、配额大小和账户名。

10. **退出**：命令执行完毕后退出。

### 注意事项

- 在执行此命令前，请确保您具有足够的权限来更改邮件账户的配额。
- 提供的配额应符合系统的存储限制和配额策略要求。
- 如果邮件账户当前没有设置配额或配额是 'unlimited'，请确保在更新配额时提供正确的值。

### 安全性

- 通过限制邮件账户的配额，可以防止账户占用过多的存储空间，从而维护系统的稳定性和性能。
- 请谨慎设置配额限制，确保它既不会限制用户的正常使用，也不会导致系统资源的滥用。

### 自定义与扩展

- 根据实际需求，您可以自定义配额策略、存储机制或日志记录机制，以满足特定的管理要求。
- 如果您在使用命令时遇到任何问题或需要更多支持，请参考 Hestia 控制面板的官方文档或联系技术支持团队。

### 总结

`v-change-mail-account-quota` 命令是 Hestia 控制面板中一个重要的命令行工具，用于更改邮件账户的配额限制。通过正确使用该命令，管理员可以有效地管理邮件账户的存储使用情况，确保系统的正常运行和资源的合理分配。请确保在执行此命令前充分了解相关的操作和影响，并谨慎操作。

## v-change-mail-account-rate-limit

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-mail-account-rate-limit)

### 命令概述

`v-change-mail-account-rate-limit` 是 Hestia 控制面板中的一个命令行工具，用于更改特定邮件账户的速率限制。该命令允许管理员或授权用户设置邮件账户的发送或接收邮件的速率，以控制邮件流量并防止滥用。

### 使用方法

`v-change-mail-account-rate-limit` 命令需要四个参数：用户名、域名、账户名和速率限制。

#### 示例

```bash
v-change-mail-account-rate-limit john example.com john_account 100/minute
```

在这个例子中，`john` 是用户名，`example.com` 是域名，`john_account` 是要更改速率限制的邮件账户名，`100/minute` 是新的速率限制，表示每分钟最多可以发送或接收 100 封邮件。

### 参数说明

- **user**：用户名，用于标识邮件账户的所有者。
- **domain**：域名，邮件账户所在的域。
- **account**：邮件账户名，要更改速率限制的特定账户。
- **rate**：速率限制，可以是具体的速率值（如 100/minute）或 'system' 表示使用系统默认速率。

### 命令流程

1. **参数接收**：命令接收用户名、域名、账户名和速率限制作为参数。

2. **环境配置加载**：加载 Hestia 控制面板的配置文件和必要的函数库。

3. **参数验证**：检查提供的参数是否有效，包括格式验证和系统状态检查。

4. **对象有效性检查**：验证用户名、域名和邮件账户是否存在且未被暂停。

5. **系统状态检查**：检查邮件系统是否已启用。

6. **速率限制更新**：根据邮件系统的类型（如 Exim），更新邮件账户的速率限制信息。如果速率设置为 'system'，则使用系统默认的速率限制。

7. **日志记录**：记录速率限制更改操作的信息，包括用户名、操作类型、速率限制大小和账户名。

8. **退出**：命令执行完毕后退出。

### 注意事项

- 在执行此命令前，请确保您具有足够的权限来更改邮件账户的速率限制。
- 提供的速率限制应符合系统的处理能力和策略要求，以避免对系统性能造成负面影响。
- 如果邮件账户当前没有设置速率限制或速率限制是 'system'，请确保在更新速率限制时提供正确的值。

### 安全性

- 通过设置邮件账户的速率限制，可以防止恶意用户或滥用行为对系统造成过大的负载。
- 请谨慎设置速率限制值，确保它既不会限制用户的正常使用，也不会导致系统资源的滥用。

### 自定义与扩展

- 根据实际需求，您可以自定义速率限制策略、存储机制或日志记录机制，以满足特定的管理要求。
- 如果您在使用命令时遇到任何问题或需要更多支持，请参考 Hestia 控制面板的官方文档或联系技术支持团队。

### 总结

`v-change-mail-account-rate-limit` 命令是 Hestia 控制面板中一个重要的命令行工具，用于更改邮件账户的速率限制。通过正确使用该命令，管理员可以有效地管理邮件账户的邮件流量，确保系统的正常运行和资源的合理分配。请确保在执行此命令前充分了解相关的操作和影响，并谨慎操作。

## v-change-mail-domain-catchall

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-mail-domain-catchall)

### 命令概述

`v-change-mail-domain-catchall` 是 Hestia 控制面板中的一个命令行工具，用于更改邮件域的通配符（catch-all）地址。通配符地址是指将所有未明确指定收件人的邮件都发送到同一个邮箱地址的功能。此命令允许管理员或授权用户轻松设置或更改通配符地址。

### 使用方法

`v-change-mail-domain-catchall` 命令需要三个参数：用户名、域名和电子邮件地址。

#### 示例

```bash
v-change-mail-domain-catchall john example.com catchall@example.com
```

在这个例子中，`john` 是用户名，`example.com` 是要设置通配符地址的域名，`catchall@example.com` 是新的通配符地址，即所有未指定收件人的邮件都将发送到这个地址。

### 参数说明

- **user**：用户名，用于标识邮件域的所有者。
- **domain**：域名，要设置通配符地址的邮件域。
- **email**：电子邮件地址，新的通配符地址，用于接收所有未指定收件人的邮件。

### 命令流程

1. **参数接收**：命令接收用户名、域名和电子邮件地址作为参数。

2. **环境配置加载**：加载 Hestia 控制面板的配置文件和必要的函数库。

3. **参数验证**：检查提供的参数是否有效，包括格式验证和系统状态检查。

4. **对象有效性检查**：验证用户名和域名是否存在且未被暂停。

5. **系统状态检查**：检查邮件系统是否已启用。

6. **通配符地址更新**：根据邮件系统的类型（如 Exim），更新邮件域的通配符地址信息。

7. **日志记录**：记录通配符地址更改操作的信息，包括用户名、操作类型、域名和新地址。

8. **退出**：命令执行完毕后退出。

### 注意事项

- 在执行此命令前，请确保您具有足够的权限来更改邮件域的通配符地址。
- 确保提供的电子邮件地址是有效的，并且能够接收邮件，以避免丢失未指定收件人的邮件。
- 如果邮件域当前没有设置通配符地址，请确保在更新时提供正确的电子邮件地址。

### 安全性

- 通过设置通配符地址，可以确保所有未指定收件人的邮件都被发送到指定的邮箱，防止邮件丢失或被误发送到其他地址。
- 请谨慎设置通配符地址，确保它不会造成邮件的滥用或泄露敏感信息。

### 自定义与扩展

- 根据实际需求，您可以自定义通配符地址的处理逻辑、存储机制或日志记录机制，以满足特定的管理要求。
- 如果您在使用命令时遇到任何问题或需要更多支持，请参考 Hestia 控制面板的官方文档或联系技术支持团队。

### 总结

`v-change-mail-domain-catchall` 命令是 Hestia 控制面板中一个重要的命令行工具，用于更改邮件域的通配符地址。通过正确使用该命令，管理员可以轻松地管理邮件域的通配符功能，确保所有未指定收件人的邮件都被发送到正确的地址。请确保在执行此命令前充分了解相关的操作和影响，并谨慎操作。

## v-change-mail-domain-rate-limit

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-mail-domain-rate-limit)

### 命令概述

`v-change-mail-domain-rate-limit` 是 Hestia 控制面板的一个命令行工具，用于更改邮件域的速率限制。速率限制可以帮助管理员控制邮件发送的频率和数量，以防止滥用或保护系统资源。此命令允许管理员设置或更改特定邮件域的速率限制。

### 使用方法

`v-change-mail-domain-rate-limit` 命令需要三个参数：用户名、域名和速率限制。

#### 示例

```bash
v-change-mail-domain-rate-limit john example.com 100
```

在这个例子中，`john` 是用户名，`example.com` 是要设置速率限制的邮件域，`100` 是新的速率限制值（例如，每分钟允许发送的邮件数）。

### 参数说明

- **user**：用户名，用于标识邮件域的所有者。
- **domain**：域名，要设置速率限制的邮件域。
- **rate**：速率限制值，可以是具体的数字（如每分钟允许发送的邮件数）或特殊值 `system`，表示使用系统默认值。

### 命令流程

1. **参数接收**：命令接收用户名、域名和速率限制值作为参数。

2. **环境配置加载**：加载 Hestia 控制面板的配置文件和必要的函数库。

3. **参数验证**：检查提供的参数是否有效，包括格式验证和系统状态检查。

4. **对象有效性检查**：验证用户名和域名是否存在且未被暂停。

5. **系统状态检查**：检查邮件系统是否已启用。

6. **速率限制更新**：根据提供的速率限制值，更新邮件域的速率限制信息。

7. **邮件域重建**：重建邮件域的配置，以确保新的速率限制生效。

8. **日志记录**：记录速率限制更改操作的信息，包括用户名、操作类型、域名和新速率限制值。

9. **退出**：命令执行完毕后退出。

### 注意事项

- 在执行此命令前，请确保您具有足够的权限来更改邮件域的速率限制。
- 速率限制值的设置应基于系统资源和邮件发送需求进行合理规划，以避免限制过严或过松。
- 如果将速率限制值设置为 `system`，则会使用系统默认的速率限制值。

### 安全性

- 通过设置速率限制，可以防止邮件发送滥用，保护系统资源和用户数据安全。
- 请确保在设置速率限制时考虑到正常的邮件发送需求，避免对合法用户造成不必要的限制。

### 自定义与扩展

- 根据实际需求，您可以自定义速率限制的处理逻辑、存储机制或日志记录机制，以满足特定的管理要求。
- 如果您在使用命令时遇到任何问题或需要更多支持，请参考 Hestia 控制面板的官方文档或联系技术支持团队。

### 总结

`v-change-mail-domain-rate-limit` 命令是 Hestia 控制面板中一个重要的命令行工具，用于更改邮件域的速率限制。通过正确使用该命令，管理员可以轻松地管理邮件域的发送速率，保护系统资源并防止滥用。请确保在执行此命令前充分了解相关的操作和影响，并谨慎操作。

## v-delete-sys-smtp

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-sys-smtp)

### 命令概述

`v-delete-sys-smtp` 是 Hestia 控制面板提供的一个命令行工具，用于删除或重置系统级的 SMTP 配置。此功能允许管理员删除或重置之前配置的 SMTP 账户，以便重新配置、切换到其他 SMTP 服务或禁用 SMTP 功能。通过删除 SMTP 配置，管理员可以管理服务器发送记录、通知和警告电子邮件等功能的方式。

### 使用方法

`v-delete-sys-smtp` 命令通常无需任何参数即可执行，因为它旨在删除或重置整个 SMTP 配置。

#### 示例

```bash
v-delete-sys-smtp
```

### 命令流程

1. **加载配置**：命令首先加载 Hestia 控制面板的配置文件和必要的函数库。

2. **检查演示模式**：命令会检查 Hestia 是否处于演示模式，以避免在演示环境中意外删除或修改配置。

3. **重置 SMTP 配置**：命令通过调用相关函数，重置 SMTP 相关的系统配置参数。这包括禁用 SMTP 功能、清除 SMTP 服务器的主机名、端口号、安全协议、用户名、密码以及其他相关设置。

4. **日志记录**：命令执行完成后，会记录一条系统日志，表明 SMTP 配置已被删除或重置。

5. **退出**：命令执行完毕后退出。

### 注意事项

- 在执行此命令前，请确保您已了解该命令将删除或重置 SMTP 配置的影响。这将影响服务器发送电子邮件的能力，包括记录、通知和警告等。

- 如果您的系统中有其他服务或应用依赖于 SMTP 功能，它们可能会受到影响。因此，在执行此命令之前，请确保通知相关用户或检查服务状态。

- 请谨慎使用此命令，确保您具有足够的权限，并了解重置 SMTP 配置的后果。

### 安全性

- 删除或重置 SMTP 配置可以增加系统的安全性，特别是在不再需要 SMTP 功能或怀疑存在潜在安全风险时。

- 禁用 SMTP 功能可以防止未经授权的邮件发送和潜在的邮件泄露风险。

### 自定义与扩展

- 如果您需要自定义 SMTP 配置的重置逻辑或添加额外的处理步骤，您可以考虑修改此命令的脚本或创建自定义的 CLI 命令。

- 在进行任何自定义或扩展时，请务必遵循最佳的安全实践，并确保您完全理解所做的更改可能带来的影响。

### 总结

`v-delete-sys-smtp` 命令是 Hestia 控制面板中一个实用的工具，用于删除或重置系统级的 SMTP 配置。通过执行此命令，管理员可以轻松地管理 SMTP 账户，以便重新配置、切换到其他 SMTP 服务或禁用 SMTP 功能。请确保在执行此命令前充分了解其影响，并谨慎操作。

## v-delete-sys-smtp-relay

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-sys-smtp-relay)

### 命令概述

`v-delete-sys-smtp-relay` 是 Hestia 控制面板的一个命令行工具，用于全局禁用 SMTP Relay 支持。SMTP Relay 是一种允许邮件服务器通过另一个邮件服务器发送邮件的功能。在某些情况下，管理员可能希望禁用 SMTP Relay 以增强安全性或简化邮件发送流程。此命令将重置与 SMTP Relay 相关的系统配置，并删除相关的配置文件。

### 使用方法

`v-delete-sys-smtp-relay` 命令无需任何参数即可执行。

#### 示例

```bash
v-delete-sys-smtp-relay
```

### 命令流程

1. **加载配置**：命令首先加载 Hestia 控制面板的配置文件和必要的函数库。

2. **验证只读模式**：检查 Hestia 是否处于只读或演示模式，以防止在不允许更改的环境中执行此命令。

3. **重置 SMTP Relay 配置**：通过调用 `change_sys_value` 函数，将 SMTP Relay 相关的系统值重置为禁用状态，并清空主机名、端口号和用户名等配置信息。

4. **删除配置文件**：命令会删除与 SMTP Relay 相关的配置文件（如 `/etc/exim4/smtp_relay.conf`），以确保配置更改生效。

5. **记录日志**：执行完毕后，记录一条系统日志，表明全局 SMTP Relay 功能已被禁用。

6. **退出**：命令执行完毕后退出。

### 注意事项

- 在执行此命令前，请确保您了解禁用 SMTP Relay 的后果，特别是如果系统中还有其他服务或应用依赖于此功能。

- 禁用 SMTP Relay 可能会影响系统发送邮件的能力，特别是当需要通过其他邮件服务器转发邮件时。

- 删除配置文件是永久性的，因此在执行此命令之前，请确保备份了任何重要的配置信息。

### 安全性

- 禁用 SMTP Relay 可以提高系统的安全性，减少潜在的邮件泄露和滥用风险。

- 通过限制邮件服务器的中继能力，可以防止未经授权的邮件发送和潜在的垃圾邮件问题。

### 自定义与扩展

- 如果您需要自定义 SMTP Relay 的禁用逻辑或添加额外的处理步骤，您可以修改此命令的脚本或创建自定义的 CLI 命令。

- 请注意，在修改系统级配置或编写自定义脚本时，应谨慎操作，并遵循最佳的安全实践。

### 总结

`v-delete-sys-smtp-relay` 命令是 Hestia 控制面板中一个实用的工具，用于全局禁用 SMTP Relay 支持。通过执行此命令，管理员可以轻松地管理邮件服务器的中继功能，增强系统的安全性或简化邮件发送流程。请确保在执行此命令前充分了解其影响，并谨慎操作。

## v-delete-sys-mail-queue

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-sys-mail-queue)

### 命令概述

`v-delete-sys-mail-queue` 是 Hestia 控制面板中的一个命令行工具，用于删除 Exim 邮件队列中的邮件。当邮件服务器上的邮件队列中存在无法发送或长时间滞留的邮件时，此命令可以帮助管理员清理队列，释放系统资源，并避免潜在的邮件发送问题。

### 使用方法

`v-delete-sys-mail-queue` 命令无需任何参数即可执行。执行时，它会检查 Exim 邮件队列中的邮件数量，并提示管理员是否确定要删除队列中的邮件。

#### 示例

```bash
v-delete-sys-mail-queue
```

### 命令流程

1. **加载配置**：命令首先加载 Hestia 控制面板的配置文件和必要的函数库。

2. **验证只读模式**：检查 Hestia 是否处于只读或演示模式，以防止在不允许更改的环境中执行此命令。

3. **检查邮件队列**：使用 `exim -bpc` 命令获取当前 Exim 邮件队列中的邮件数量。

4. **用户确认**：如果邮件队列中存在邮件（数量大于0），命令会提示管理员是否确定要删除这些邮件。管理员需要输入 `y` 或 `Y` 进行确认。

5. **删除邮件**：如果管理员确认删除邮件，命令会使用 `exiqgrep -i | xargs exim -Mrm` 命令删除邮件队列中的所有邮件。

6. **记录日志**：命令执行完毕后，记录一条系统日志，表明邮件队列已被删除，并包含被删除的邮件数量。

7. **退出**：命令执行完毕后退出。

### 注意事项

- 在执行此命令前，请确保您了解删除邮件队列的后果。这将会永久删除队列中的所有邮件，包括那些尚未发送或尝试发送的邮件。

- 如果邮件队列中存在重要的邮件，或者您正在调查邮件发送问题，请在执行此命令前备份队列或导出相关邮件。

- 在执行删除操作前，命令会提示管理员进行确认，以确保不会意外删除邮件。请仔细阅读提示并谨慎操作。

### 安全性

- 删除邮件队列可以释放系统资源，并减少潜在的邮件发送问题，从而提高系统的稳定性和安全性。

- 通过定期清理邮件队列，可以确保邮件服务器保持高效运行，并减少由于长时间滞留邮件而导致的潜在风险。

### 自定义与扩展

- 如果您需要自定义邮件队列的删除逻辑或添加额外的处理步骤，您可以修改此命令的脚本或创建自定义的 CLI 命令。

- 在进行任何自定义或扩展时，请确保您了解 Exim 邮件服务器的工作原理和相关配置，并遵循最佳的安全实践。

### 总结

`v-delete-sys-mail-queue` 命令是 Hestia 控制面板中一个实用的工具，用于删除 Exim 邮件队列中的邮件。通过执行此命令，管理员可以轻松地清理邮件队列，释放系统资源，并避免潜在的邮件发送问题。请确保在执行此命令前充分了解其影响，并谨慎操作。

## v-update-sys-rrd-mail

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-sys-rrd-mail)

### 命令概述

`v-update-sys-rrd-mail` 是 Hestia 控制面板中的一个 CLI（命令行接口）命令，用于更新邮件队列的 RRD（Round Robin Database）统计信息。RRD 是一种用于时间序列数据的存储、检索和绘图的工具，常用于系统监控和性能分析。此命令可以生成不同时间周期（如每日、每周、每月、每年）的邮件队列统计图表，帮助管理员更好地了解邮件服务器的运行状态。

### 使用方法

命令的基本格式为：

```bash
v-update-sys-rrd-mail [period]
```

其中，`[period]` 是一个可选参数，用于指定要更新的时间周期。可选的值包括 `daily`（每日）、`weekly`（每周）、`monthly`（每月）和 `yearly`（每年）。如果不指定时间周期，则默认为 `daily`。

#### 示例

1. 更新每日邮件队列统计信息：

```bash
v-update-sys-rrd-mail daily
```

2. 更新每周邮件队列统计信息：

```bash
v-update-sys-rrd-mail weekly
```

3. 更新每月邮件队列统计信息：

```bash
v-update-sys-rrd-mail monthly
```

4. 更新每年邮件队列统计信息：

```bash
v-update-sys-rrd-mail yearly
```

### 命令流程

1. **参数处理**：命令首先检查是否提供了时间周期参数，并根据参数值设置相应的起始时间、结束时间和网格配置。

2. **配置文件加载**：加载 Hestia 的配置文件和函数库，以便访问相关的配置信息和函数。

3. **RRD 目录和文件检查**：检查 RRD 数据的存储目录和邮件队列的 RRD 文件是否存在。如果不存在，则创建相应的目录和文件。

4. **RRD 数据库创建**：如果邮件队列的 RRD 文件不存在，使用 `rrdtool create` 命令创建新的 RRD 数据库，并定义数据源（DS）和归档规则（RRA）。

5. **邮件队列数量获取**：使用 `exim -bpc` 命令获取当前邮件队列中的邮件数量。

6. **RRD 数据库更新**：将获取到的邮件队列数量更新到 RRD 数据库中。

7. **图表生成**：使用 `rrdtool graph` 命令生成指定时间周期的邮件队列统计图表。图表包括邮件队列的大小、最大值、最小值等统计信息。

8. **错误处理**：如果在执行过程中遇到任何错误，命令将退出并返回相应的错误代码。

9. **退出**：命令执行完毕后退出。

### 注意事项

- 确保在执行命令之前已经安装了 RRDtool 工具，并且 Hestia 控制面板已经正确配置。

- 根据不同的时间周期和邮件队列的活跃程度，生成图表所需的时间可能会有所不同。请耐心等待命令执行完成。

- 如果在执行命令时遇到任何错误或问题，请检查命令的输出和日志文件，以获取更多关于错误原因的信息。

### 自定义与扩展

- 如果需要自定义邮件队列统计图表的样式或配置，可以修改命令中的 RRDtool 图形选项和参数。

- 可以根据实际需求扩展命令的功能，例如添加更多的时间周期选项、支持其他邮件传输代理（MTA）的统计等。

### 总结

`v-update-sys-rrd-mail` 命令是 Hestia 控制面板中一个强大的工具，用于生成邮件队列的统计图表。通过定期执行此命令，管理员可以方便地监控邮件服务器的运行状态，及时发现并处理潜在的问题。请确保按照正确的步骤和参数使用此命令，并根据需要进行适当的自定义和扩展。

## v-update-mail-domain-disk

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-mail-domain-disk)

### 概述

`v-update-mail-domain-disk` 是 Hestia 控制面板中的一个 CLI（命令行接口）工具，用于更新邮件域名的磁盘使用情况。该命令将遍历指定用户的指定邮件域名下的所有邮件账户，并计算每个账户的磁盘占用空间，然后更新相应的系统对象。

### 使用方法

命令的基本格式为：

```bash
v-update-mail-domain-disk USER DOMAIN
```

其中：

- `USER`：要更新磁盘使用情况的用户的用户名。
- `DOMAIN`：要更新磁盘使用情况的邮件域名。

### 示例

以下是几个使用 `v-update-mail-domain-disk` 命令的示例：

#### 示例 1：更新指定用户的邮件域名磁盘使用情况

```bash
v-update-mail-domain-disk admin example.com
```

这个命令将更新用户 `admin` 下 `example.com` 邮件域名的磁盘使用情况。

#### 示例 2：更新多个邮件域名的磁盘使用情况

可以通过编写脚本或循环来批量更新多个邮件域名的磁盘使用情况。例如：

```bash
#!/bin/bash

users=("user1" "user2" "user3")
domains=("domain1.com" "domain2.com" "domain3.com")

for user in "${users[@]}"; do
    for domain in "${domains[@]}"; do
        v-update-mail-domain-disk "$user" "$domain"
    done
done
```

这个脚本将遍历 `users` 和 `domains` 数组，为每对用户和域名组合执行 `v-update-mail-domain-disk` 命令。

### 工作流程

1. **参数定义与验证**：命令首先定义并验证传入的 `user` 和 `domain` 参数。

2. **加载配置与函数**：加载 Hestia 的配置文件和必要的函数库。

3. **检查系统启用状态**：确认邮件系统是否启用，如果未启用或设置为远程模式，则命令直接退出。

4. **验证对象有效性**：检查指定的用户和域名是否存在且有效。

5. **遍历邮件账户**：对于指定域名的每个邮件账户，命令计算其磁盘使用情况。

6. **更新对象值**：将每个账户的磁盘使用情况更新到系统对象中，并计算整个域名的总磁盘使用情况。

7. **重新计算用户磁盘使用情况**：根据更新后的邮件域名磁盘使用情况，重新计算用户的总磁盘使用情况。

8. **记录日志**：记录命令执行的结果到日志中。

### 注意事项

- 在执行此命令之前，请确保 Hestia 控制面板已正确安装并配置。
- 确保提供的用户名和域名是正确且存在的，否则命令将无法执行。
- 如果邮件系统未启用或设置为远程模式，该命令将不会执行任何操作。
- 命令执行期间可能会根据邮件账户的数量和磁盘大小而耗费一些时间。

### 总结

`v-update-mail-domain-disk` 命令是 Hestia 控制面板中用于管理邮件域名磁盘使用情况的实用工具。通过执行此命令，管理员可以确保系统对象中的磁盘使用情况数据保持最新，从而方便进行磁盘空间管理和监控。在使用该命令时，请确保按照正确的格式和参数进行操作，并根据需要进行适当的扩展和定制。

## v-update-mail-domain-ssl

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-mail-domain-ssl)

### 概述

`v-update-mail-domain-ssl` 是 Hestia 控制面板中的一个 CLI（命令行接口）工具，用于更新邮件域名的 SSL 证书。该命令将复制指定的 SSL 证书和私钥文件到 Hestia 系统中对应的邮件域名目录下，并可选地重启邮件、Web 和代理服务以应用新的 SSL 配置。

### 使用方法

命令的基本格式为：

```bash
v-update-mail-domain-ssl USER DOMAIN SSL_DIR [RESTART]
```

其中：

- `USER`：要更新 SSL 证书的用户的用户名。
- `DOMAIN`：要更新 SSL 证书的邮件域名。
- `SSL_DIR`：包含 SSL 证书和私钥文件的目录路径。
- `RESTART`：（可选）指定是否重启服务。可以是 `yes` 或 `no`。如果不提供，则默认为 `no`。

### 示例

以下是几个使用 `v-update-mail-domain-ssl` 命令的示例：

#### 示例 1：更新邮件域名的 SSL 证书而不重启服务

```bash
v-update-mail-domain-ssl admin example.com /path/to/ssl/certs
```

这个命令将更新用户 `admin` 下 `example.com` 邮件域名的 SSL 证书，但不会重启任何服务。

#### 示例 2：更新邮件域名的 SSL 证书并重启服务

```bash
v-update-mail-domain-ssl admin example.com /path/to/ssl/certs yes
```

这个命令除了更新 SSL 证书外，还会重启邮件、Web 和代理服务，以确保新的 SSL 配置生效。

### 工作流程

1. **参数定义与验证**：命令首先定义并验证传入的 `user`、`domain`、`ssl_dir` 和 `restart` 参数。

2. **加载配置与函数**：加载 Hestia 的配置文件和必要的函数库。

3. **检查系统启用状态**：确认邮件系统是否启用。

4. **验证对象有效性**：检查指定的用户、域名和 SSL 目录是否存在且有效，同时确保用户和域名未被暂停。

5. **检查 Web 域名证书有效性**：执行额外的检查以确保 Web 域名证书有效。

6. **复制 SSL 文件**：从指定的 SSL 目录复制证书和私钥文件到 Hestia 系统中对应的邮件域名目录下。

7. **设置文件权限**：为复制的 SSL 文件设置适当的权限。

8. **重启服务**（可选）：如果提供了 `restart` 参数且值为 `yes`，则重启邮件、Web 和代理服务。

9. **检查重启结果**：对每次重启操作进行检查，确保服务成功重启。

10. **记录日志**：记录命令执行的结果到日志中。

### 注意事项

- 在执行此命令之前，请确保已经生成了有效的 SSL 证书和私钥文件，并将其放置在指定的 `ssl_dir` 目录中。
- 如果提供 `restart` 参数并设置为 `yes`，请确保系统有足够的权限来重启邮件、Web 和代理服务。
- 在复制 SSL 文件时，命令会覆盖目标目录下的同名文件，请确保这些文件在复制之前已备份或不再需要。
- 如果邮件、Web 或代理服务重启失败，命令将记录错误信息到日志中，但不会阻止命令的继续执行。请定期检查日志文件以获取潜在的问题。

### 总结

`v-update-mail-domain-ssl` 命令是 Hestia 控制面板中用于管理邮件域名 SSL 证书的重要工具。通过执行此命令，管理员可以方便地更新邮件域名的 SSL 证书，并可选地重启相关服务以确保新的 SSL 配置生效。在使用该命令时，请确保按照正确的格式和参数进行操作，并根据需要进行适当的扩展和定制。

## v-update-mail-domains-disk

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-mail-domains-disk)

### 概述

`v-update-mail-domains-disk` 是 Hestia 控制面板的一个 CLI（命令行接口）工具，用于计算所有邮件域名的磁盘使用情况。该命令会遍历指定用户的所有邮件域名和账号，计算每个账号的磁盘使用情况，并更新相应的配置信息。

### 使用方法

命令的基本格式为：

```bash
v-update-mail-domains-disk USER
```

其中：

- `USER`：要计算磁盘使用情况的用户的用户名。

### 示例

以下是使用 `v-update-mail-domains-disk` 命令的示例：

#### 示例 1：计算管理员用户的邮件域名磁盘使用情况

```bash
v-update-mail-domains-disk admin
```

这个命令将计算用户名为 `admin` 的所有邮件域名和账号的磁盘使用情况，并更新配置信息。

### 工作流程

1. **参数验证**：命令首先检查是否提供了正确的参数，即用户名 `USER`。

2. **加载配置和函数**：命令加载 Hestia 控制面板的配置文件以及必要的函数库。

3. **检查系统启用状态**：确认邮件系统是否启用，并且不是远程系统。

4. **检查用户有效性**：验证提供的用户名是否有效且存在于系统中。

5. **遍历邮件域名**：对于指定用户的每个邮件域名，命令执行以下操作：
   - 初始化域名磁盘使用量为 0。
   - 遍历该域名下的每个邮件账号。
   - 对于每个账号，计算其主目录的磁盘使用情况。
   - 更新该账号的磁盘使用量配置信息。
   - 将账号的磁盘使用量累加到域名的总磁盘使用量上。
   - 更新域名的磁盘使用量配置信息。

6. **重新计算用户磁盘使用量**：根据所有域名的磁盘使用量，重新计算用户的总磁盘使用量。

7. **记录日志**：记录操作的结果到日志中，表示磁盘使用量已成功更新。

8. **退出**：命令执行完毕后退出。

### 注意事项

- 在运行此命令之前，请确保 Hestia 控制面板已经正确配置，并且邮件系统已启用。
- 命令需要有足够的权限来读取邮件账号的主目录，并更新配置信息。
- 如果邮件账号的主目录不存在，命令将假定其磁盘使用量为 0。

### 总结

`v-update-mail-domains-disk` 命令是一个强大的工具，用于管理和监控 Hestia 控制面板中邮件域名的磁盘使用情况。通过计算每个邮件账号和域名的磁盘使用量，管理员可以更好地了解系统的存储状态，并做出相应的优化和规划。在使用该命令时，请确保遵循正确的语法和参数要求，并注意相关的操作注意事项。

## v-update-mail-templates

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-mail-templates)

### 概述

`v-update-mail-templates` 是 Hestia 控制面板的一个 CLI（命令行接口）工具，用于更新邮件模板。该命令会从 Hestia 软件包中获取最新的 Web 邮件模板，并应用到系统中。

### 使用方法

命令的基本格式为：

```bash
v-update-mail-templates [RESTART] [SKIP]
```

其中：

- `RESTART`：可选参数，指定是否重启 Web 服务器和代理服务器。可以设置为 `yes` 或直接传递该参数以触发重启。
- `SKIP`：可选参数，指定是否跳过邮件域名的重建。如果传递了该参数，则不会重建邮件域名。

### 示例

以下是使用 `v-update-mail-templates` 命令的示例：

#### 示例 1：更新邮件模板并重启服务

```bash
v-update-mail-templates yes
```

这个命令将更新邮件模板，并在完成后重启 Web 服务器和代理服务器。

#### 示例 2：仅更新邮件模板，不重启服务

```bash
v-update-mail-templates
```

这个命令仅更新邮件模板，不会触发任何服务的重启。

#### 示例 3：更新邮件模板并跳过邮件域名重建

```bash
v-update-mail-templates no skip
```

这个命令将更新邮件模板，但会跳过邮件域名的重建过程，并且在完成后不会重启服务。

### 工作流程

1. **参数解析**：命令首先解析传入的参数，确定是否需要重启服务和是否跳过邮件域名重建。

2. **更新模板**：命令将 Hestia 安装目录下的邮件模板复制到数据目录下的模板文件夹中，从而更新系统中的模板文件。

3. **重建邮件域名**（如果未跳过）：如果未传递 `SKIP` 参数且邮件系统已启用，命令将遍历所有用户并重建其邮件域名。

4. **重启服务**（如果需要）：如果传递了 `RESTART` 参数或该参数值为 `yes`，命令将重启 Web 服务器和代理服务器。

5. **记录日志**：无论是否发生重启，命令都会记录一条日志，表明默认的邮件域名模板已更新。

6. **退出**：命令执行完毕后退出。

### 注意事项

- 在运行此命令之前，请确保已经备份了重要的数据和配置，以防万一出现意外情况。
- 如果邮件系统未启用或 `SKIP` 参数被传递，邮件域名的重建过程将被跳过。
- 重启服务可能会导致短暂的服务中断，请在低峰时段执行此操作，以最小化对用户的影响。

### 总结

`v-update-mail-templates` 命令是 Hestia 控制面板中用于更新邮件模板的实用工具。通过传递不同的参数，您可以控制是否重启服务和是否跳过邮件域名的重建。在使用该命令时，请确保了解参数的含义和潜在影响，并根据需要谨慎操作。

## v-unsuspend-mail-account

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-unsuspend-mail-account)

`v-unsuspend-mail-account` 是Hestia服务器管理面板中的一个CLI命令，用于取消暂停（恢复）指定的邮件账户。当邮件账户被暂停时，用户将无法使用该账户进行邮件发送和接收操作。通过执行此命令，管理员可以重新激活被暂停的邮件账户。

### 命令语法

`v-unsuspend-mail-account [用户] [域名] [账户]`

- **用户**：邮件账户所属的用户名。
- **域名**：邮件账户所属的域名。
- **账户**：具体的邮件账户名。

### 示例

#### 示例1：恢复名为"john"的用户在"example.com"域下的"john@example.com"邮件账户

```bash
v-unsuspend-mail-account john example.com john
```

#### 示例2：恢复名为"jane"的用户在"domain.net"域下的"jane@domain.net"邮件账户

```bash
v-unsuspend-mail-account jane domain.net jane
```

### 命令执行流程

1. **参数接收与校验**：脚本接收用户输入的三个参数，并对参数进行校验，确保参数的格式正确，并且相关的用户和域名存在。

2. **检查系统配置**：验证邮件系统是否启用，并检查当前是否处于Hestia的演示模式。

3. **检查对象状态**：确认指定的用户、域名和邮件账户是否有效，并且邮件账户当前处于暂停状态。

4. **更新配置文件**：如果邮件系统使用的是Exim，则更新邮件账户的配置文件，移除暂停状态，并设置相应的配额（如果适用）。

5. **更新对象状态**：在Hestia管理面板中更新邮件账户的状态，将其标记为未暂停。

6. **日志记录**：记录一条日志，表明已经成功恢复了指定的邮件账户。

### 注意事项

- 在执行此命令之前，请确保你具有足够的权限来修改邮件账户的状态。
- 如果邮件账户没有处于暂停状态，执行此命令可能不会有任何效果。
- 如果邮件系统不是Exim，那么脚本可能需要针对其他邮件系统进行相应的修改。

### 总结

`v-unsuspend-mail-account`命令是一个实用的CLI工具，用于在Hestia服务器管理面板中快速恢复暂停的邮件账户。通过掌握此命令的使用方法和注意事项，管理员可以更加高效地进行邮件账户管理。

## v-unsuspend-mail-accounts

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-unsuspend-mail-accounts)

`v-unsuspend-mail-accounts` 是Hestia服务器管理面板中的一个CLI命令，用于取消暂停（恢复）指定域名下的所有邮件账户。当某些邮件账户因某种原因被暂停时，可以使用此命令一次性恢复所有暂停的账户。

### 命令语法

`v-unsuspend-mail-accounts [用户] [域名]`

- **用户**：邮件账户所属的用户名。
- **域名**：邮件账户所属的域名。

### 示例

#### 示例1：恢复"admin"用户在"acme.com"域下的所有暂停邮件账户

```bash
v-unsuspend-mail-accounts admin acme.com
```

#### 示例2：恢复"john_doe"用户在"example.org"域下的所有暂停邮件账户

```bash
v-unsuspend-mail-accounts john_doe example.org
```

### 命令执行流程

1. **参数接收与校验**：脚本接收用户输入的用户名和域名参数，并进行格式校验和有效性检查。

2. **系统配置检查**：验证邮件系统是否启用，并检查当前是否处于Hestia的只读模式或演示模式。

3. **对象验证**：确认指定的用户和域名是否存在于Hestia管理面板中，并且用户账户和邮件域名都未被暂停。

4. **账户恢复**：通过循环遍历指定域名下的所有邮件账户，查找状态为暂停的账户，并调用`v-unsuspend-mail-account`命令逐个恢复这些账户。

5. **退出**：命令执行完毕后，脚本退出。

### 注意事项

- 在执行此命令之前，请确保你具有足够的权限来修改邮件账户的状态。
- 此命令会恢复指定域名下所有暂停的邮件账户，因此请谨慎使用，避免误操作。
- 如果邮件系统不是Hestia支持的邮件系统，脚本可能需要进行相应的修改或调整。

### 总结

`v-unsuspend-mail-accounts`命令是Hestia服务器管理面板中一个非常实用的CLI工具，它允许管理员快速恢复指定域名下所有暂停的邮件账户。通过掌握此命令的使用方法和注意事项，管理员可以更加高效地进行邮件账户管理，减少因账户暂停带来的不便。

## v-unsuspend-mail-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-unsuspend-mail-domain)

### 简介

`v-unsuspend-mail-domain` 是Hestia服务器管理面板中的一个CLI命令，用于取消暂停（恢复）指定的邮件域名。当邮件域名因某种原因被暂停时，可以使用此命令来恢复其正常功能。

### 命令语法

`v-unsuspend-mail-domain [用户] [域名] [是否重启服务]`

- **用户**：邮件域名所属的用户名。
- **域名**：需要恢复的邮件域名。
- **是否重启服务**：可选参数，指定是否重启邮件服务以应用更改。默认为`yes`。

### 示例

#### 示例1：恢复"admin"用户的"acme.com"邮件域名，并重启邮件服务

```bash
v-unsuspend-mail-domain admin acme.com yes
```

#### 示例2：恢复"john_doe"用户的"example.org"邮件域名，不重启邮件服务

```bash
v-unsuspend-mail-domain john_doe example.org no
```

### 命令执行流程

1. **参数接收与校验**：脚本接收用户输入的用户名、域名和重启服务参数，并进行格式校验和有效性检查。

2. **系统配置检查**：验证邮件系统是否启用，并检查当前是否处于Hestia的只读模式或演示模式。

3. **对象验证**：确认指定的用户和邮件域名是否存在，并且邮件域名处于暂停状态。

4. **链接配置**：如果邮件系统为`exim`，则创建指向用户邮件配置的符号链接。

5. **更新对象状态**：更新邮件域名的状态，将其`$SUSPENDED`值设置为`no`，表示已恢复。

6. **修改配置文件**：使用`sed`命令直接修改用户的邮件域名配置文件，将`SUSPENDED`值从`yes`改为`no`。

7. **减少暂停计数**：如果用户有其他暂停的邮件账户或域名，则减少其暂停计数。

8. **启用Webmail访问**：如果配置了IMAP系统和Webmail系统，则调用`v-add-mail-domain-webmail`命令为恢复的邮件域名启用Webmail访问功能。

9. **日志记录**：记录恢复邮件域名的操作日志，包括用户、域名和操作信息。

10. **退出**：命令执行完毕后，脚本退出。

### 注意事项

- 在执行此命令之前，请确保你具有足够的权限来修改邮件域名的状态。
- 如果邮件系统不是Hestia支持的邮件系统，脚本可能需要进行相应的修改或调整。
- 重启邮件服务可能会影响正在运行的邮件传输和接收操作，因此请谨慎选择是否重启服务。

### 总结

`v-unsuspend-mail-domain`命令是Hestia服务器管理面板中一个用于恢复暂停邮件域名的CLI工具。通过掌握此命令的使用方法和注意事项，管理员可以更加高效地进行邮件域名管理，确保邮件服务的正常运行。

## v-unsuspend-mail-domains

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-unsuspend-mail-domains)

`v-unsuspend-mail-domains` 是Hestia服务器管理面板中的一个CLI命令，用于取消暂停（恢复）指定用户下的所有邮件域名。当某个用户的多个邮件域名因某种原因被暂停时，可以使用此命令一次性恢复所有暂停的域名。

### 命令语法

`v-unsuspend-mail-domains [用户]`

- **用户**：需要恢复邮件域名的用户名。

### 示例

#### 示例1：恢复"admin"用户下的所有暂停邮件域名

```bash
v-unsuspend-mail-domains admin
```

#### 示例2：恢复"john_doe"用户下的所有暂停邮件域名

```bash
v-unsuspend-mail-domains john_doe
```

### 命令执行流程

1. **参数接收与校验**：脚本接收用户输入的用户名参数，并进行格式校验和有效性检查。

2. **系统配置检查**：验证邮件系统是否启用，并检查当前是否处于Hestia的只读模式或演示模式。

3. **对象验证**：确认指定的用户是否存在，并且用户账户未被暂停。

4. **搜索暂停域名**：通过调用`search_objects`函数，搜索状态为暂停的所有邮件域名。

5. **恢复暂停域名**：对于搜索到的每个暂停域名，调用`v-unsuspend-mail-domain`命令进行恢复操作。

6. **日志记录**：记录恢复邮件域名的操作日志，包括操作结果和参数信息。

7. **退出**：命令执行完毕后，脚本退出。

### 注意事项

- 在执行此命令之前，请确保你具有足够的权限来修改邮件域名的状态。
- 此命令会恢复指定用户下所有暂停的邮件域名，因此请谨慎使用，避免误操作。
- 如果邮件系统不是Hestia支持的邮件系统，脚本可能需要进行相应的修改或调整。

### 总结

`v-unsuspend-mail-domains`命令是Hestia服务器管理面板中一个非常实用的CLI工具，它允许管理员快速恢复指定用户下所有暂停的邮件域名。通过掌握此命令的使用方法和注意事项，管理员可以更加高效地进行邮件域名管理，减少因域名暂停带来的不便。

## v-suspend-mail-account

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-suspend-mail-account)

`v-suspend-mail-account`是Hestia服务器管理面板中的一个CLI命令，用于暂停指定的邮件账户，以防止该账户进行邮件发送和接收操作。这在用户请求暂停账户、账户出现异常或需要进行维护时非常有用。

### 命令语法

`v-suspend-mail-account [用户] [域名] [账户]`

- **用户**：邮件账户所属的用户名。
- **域名**：邮件账户所在的域名。
- **账户**：需要暂停的邮件账户名。

### 示例

#### 示例1：暂停"john_doe"用户的"example.com"域下的"john"账户

```bash
v-suspend-mail-account john_doe example.com john
```

#### 示例2：暂停"admin"用户的"acme.org"域下的"support"账户

```bash
v-suspend-mail-account admin acme.org support
```

### 命令执行流程

1. **参数接收与校验**：脚本接收用户、域名和账户名作为参数，并进行格式校验和有效性检查。

2. **系统配置加载**：加载Hestia服务器的配置文件，以获取相关的系统信息和函数。

3. **参数验证**：
   - 验证邮件系统是否启用。
   - 验证指定的用户、域名和账户是否存在且未被暂停。
   - 检查Hestia是否处于只读模式或演示模式。

4. **处理Exim邮件系统**（如果适用）：
   - 获取账户的配额信息。
   - 修改Exim的配置文件，将账户添加到暂停列表中，并设置相应的配额限制（如果适用）。

5. **更新账户状态**：
   - 更新数据库中指定邮件账户的状态，将其标记为暂停。

6. **日志记录**：记录暂停邮件账户的操作日志，包括用户、账户和域名信息。

7. **退出**：命令执行完毕后，脚本退出。

### 注意事项

- 在执行此命令之前，请确保你具有足够的权限来修改邮件账户的状态。
- 暂停邮件账户将阻止该账户进行邮件发送和接收，因此请确保在暂停之前通知用户或确保这是必要的操作。
- 如果邮件系统不是Hestia支持的邮件系统，脚本可能需要进行相应的修改或调整。

### 总结

`v-suspend-mail-account`命令是Hestia服务器管理面板中一个非常实用的CLI工具，它允许管理员快速暂停指定的邮件账户。通过掌握此命令的使用方法和注意事项，管理员可以更加高效地进行邮件账户管理，确保系统的安全性和稳定性。

## v-suspend-mail-accounts

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-suspend-mail-accounts)

`v-suspend-mail-accounts` 是Hestia服务器管理面板中的一个CLI命令，用于暂停指定用户的所有邮件账户。当需要暂停某个用户的邮件服务时，此命令非常有用。

### 命令语法

`v-suspend-mail-accounts [用户] [域名]`

- **用户**：需要暂停邮件账户的用户名。
- **域名**：用户所属的域名（可选，如未指定，将暂停该用户所有域名的邮件账户）。

### 示例

#### 示例1：暂停"john_doe"用户的所有邮件账户

```bash
v-suspend-mail-accounts john_doe
```

#### 示例2：暂停"admin"用户在"example.com"域下的所有邮件账户

```bash
v-suspend-mail-accounts admin example.com
```

### 命令执行流程

1. **参数接收与校验**：脚本接收用户名和域名作为参数，并进行格式校验和有效性检查。

2. **系统配置加载**：加载Hestia服务器的配置文件，以获取相关的系统信息和函数。

3. **参数验证**：
   - 验证邮件系统是否启用。
   - 验证指定的用户是否存在且未被暂停。
   - 验证指定的域名（如果提供）是否属于该用户且未被暂停。
   - 检查Hestia是否处于只读模式或演示模式。

4. **处理Exim邮件系统**（如果适用）：
   - 如果系统使用的是Exim邮件服务器，则删除对应的Exim配置文件。

5. **删除Webmail配置**：
   - 调用`v-delete-mail-domain-webmail`命令删除Webmail的相关配置。

6. **更新数据库状态**：
   - 更新数据库中该用户所有邮件账户的状态，将其标记为暂停。

7. **修改配置文件**：
   - 直接编辑用户的邮件配置文件，将`SUSPENDED`值从`no`改为`yes`。

8. **增加暂停计数**：
   - 增加用户对象中`$SUSPENDED_MAIL`的值，以记录暂停的邮件账户数。

9. **日志记录**：记录暂停邮件账户的操作日志，包括用户和域名信息。

10. **退出**：命令执行完毕后，脚本退出。

### 注意事项

- 在执行此命令之前，请确保你具有足够的权限来修改邮件账户的状态。
- 暂停邮件账户将阻止该账户的所有邮件发送和接收操作，因此请确保在暂停之前通知用户或确认这是必要的操作。
- 如果邮件系统不是Hestia支持的邮件系统，脚本可能需要进行相应的修改或调整。

### 总结

`v-suspend-mail-accounts`命令是Hestia服务器管理面板中一个功能强大的CLI工具，它允许管理员快速暂停指定用户的所有邮件账户。通过掌握此命令的使用方法和注意事项，管理员可以更加高效地管理邮件服务，确保系统的安全性和稳定性。

## v-suspend-mail-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-suspend-mail-domain)

`v-suspend-mail-domain` 是Hestia服务器管理面板中的一个CLI命令，用于暂停指定用户的邮件域。当需要暂停某个邮件域的邮件服务时，此命令非常有用。

### 命令语法

`v-suspend-mail-domain [用户] [域名]`

- **用户**：需要暂停邮件域的用户名。
- **域名**：需要暂停的邮件域。

### 示例

#### 示例1：暂停"john_doe"用户的"example.com"邮件域

```bash
v-suspend-mail-domain john_doe example.com
```

#### 示例2：暂停"admin"用户的"domain.net"邮件域

```bash
v-suspend-mail-domain admin domain.net
```

### 命令执行流程

1. **参数接收**：脚本接收用户名和域名作为参数。

2. **加载配置和函数**：加载Hestia服务器的配置文件以及相关的函数和脚本。

3. **参数格式化和校验**：对接收到的参数进行格式化和有效性校验，确保它们符合预期的格式。

4. **系统状态检查**：
   - 检查邮件系统是否启用。
   - 验证用户是否存在且未被暂停。
   - 验证邮件域是否存在且未被暂停。

5. **只读模式检查**：检查Hestia是否处于只读模式或演示模式，如果是，则可能不允许执行暂停操作。

6. **处理Exim邮件系统**（如果适用）：
   - 如果系统使用的是Exim邮件服务器，则删除对应的Exim配置文件中关于该域的部分。

7. **删除Webmail配置**：
   - 调用`v-delete-mail-domain-webmail`命令删除该邮件域的Webmail配置。

8. **更新数据库和配置文件**：
   - 在数据库中更新该邮件域的状态，将其标记为暂停。
   - 直接编辑邮件配置文件，将`SUSPENDED`的值从`no`改为`yes`。

9. **增加暂停计数**：
   - 增加用户对象中`$SUSPENDED_MAIL`的值，以记录暂停的邮件域数。

10. **日志记录**：记录暂停邮件域的操作的日志，包括执行操作的用户和暂停的邮件域信息。

11. **退出**：命令执行完毕后，脚本退出。

### 注意事项

- 在执行此命令之前，请确保你具有足够的权限来修改邮件域的状态。
- 暂停邮件域将阻止该域下的所有邮件发送和接收操作，因此请确保在暂停之前通知用户或确认这是必要的操作。
- 如果邮件系统不是Hestia支持的邮件系统，脚本可能需要进行相应的修改或调整。

### 总结

`v-suspend-mail-domain`命令是Hestia服务器管理面板中一个功能强大的CLI工具，它允许管理员快速暂停指定用户的邮件域。通过掌握此命令的使用方法和注意事项，管理员可以更加高效地管理邮件服务，确保系统的安全性和稳定性。

## v-suspend-mail-domains

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-suspend-mail-domains)

`v-suspend-mail-domains` 是Hestia服务器管理面板中的一个CLI命令，用于暂停指定用户的所有邮件域。当需要暂停某个用户的所有邮件服务时，此命令非常有用。

### 命令语法

`v-suspend-mail-domains [用户名]`

- **用户名**：需要暂停所有邮件域的用户名。

### 示例

#### 示例1：暂停"admin"用户的所有邮件域

```bash
v-suspend-mail-domains admin
```

#### 示例2：暂停"john_doe"用户的所有邮件域

```bash
v-suspend-mail-domains john_doe
```

### 命令执行流程

1. **参数接收**：脚本接收一个参数，即需要暂停邮件域的用户名。

2. **加载配置和函数**：加载Hestia服务器的配置文件以及相关的函数和脚本。

3. **参数校验**：检查是否提供了正确的参数数量，并验证用户名是否有效。

4. **系统状态检查**：
   - 检查邮件系统是否启用。
   - 验证用户是否存在。

5. **只读模式检查**：检查Hestia是否处于只读模式或演示模式，如果是，则可能不允许执行暂停操作。

6. **暂停所有邮件域**：
   - 通过循环遍历用户下所有未暂停的邮件域。
   - 对每个未暂停的邮件域，调用`v-suspend-mail-domain`命令来暂停它。

7. **日志记录**：记录暂停邮件域操作的日志，包括执行操作的用户和暂停的邮件域信息。

8. **退出**：命令执行完毕后，脚本退出。

### 注意事项

- 在执行此命令之前，请确保你具有足够的权限来修改邮件域的状态。
- 暂停邮件域将阻止该域下的所有邮件发送和接收操作，因此请确保在暂停之前通知用户或确认这是必要的操作。
- 如果邮件系统不是Hestia支持的邮件系统，脚本可能需要进行相应的修改或调整。

### 总结

`v-suspend-mail-domains`命令是Hestia服务器管理面板中一个功能强大的CLI工具，它允许管理员快速暂停指定用户的所有邮件域。通过掌握此命令的使用方法和注意事项，管理员可以更加高效地管理邮件服务，确保系统的安全性和稳定性。

## v-restart-mail

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-restart-mail)

`v-restart-mail` 是Hestia服务器管理面板中的一个CLI命令，用于重启邮件服务。当邮件服务遇到故障或需要进行更新配置时，该命令可以用来安全地重启邮件系统。

### 命令语法

`v-restart-mail [选项]`

- **选项**：可选参数，用于指定重启的类型或行为。

### 示例

#### 示例1：立即重启邮件服务

```bash
v-restart-mail
```

#### 示例2：计划重启邮件服务

```bash
v-restart-mail scheduled
```

#### 示例3：禁止重启邮件服务

```bash
v-restart-mail no
```

### 命令执行流程

1. **参数解析**：脚本接收一个可选参数，用于指定重启类型（如立即重启或计划重启）。

2. **环境加载**：加载Hestia的配置文件和主要函数脚本。

3. **检查邮件系统**：
   - 检查是否配置了邮件系统，以及邮件系统是否为远程系统。如果是远程系统，则脚本退出，因为远程系统通常不需要本地重启。

4. **检查重启选项**：
   - 如果传递了`no`作为参数，则脚本退出，不进行重启。

5. **计划重启**：
   - 如果传递了`scheduled`作为参数，或者没有传递参数但`SCHEDULED_RESTART`变量设置为`yes`，则将重启任务添加到重启队列中，并退出脚本。

6. **创建临时文件**：用于记录重启过程中的输出和错误信息。

7. **重启IMAP系统**（如果已配置）：
   - 调用`v-restart-service`命令来重启IMAP服务。
   - 如果重启失败，发送电子邮件报告并记录错误。

8. **重启邮件系统**：
   - 调用`v-restart-service`命令来重启邮件服务。
   - 如果重启失败，发送电子邮件报告并记录错误。

9. **更新重启队列**：
   - 如果存在重启队列文件，则从队列中移除当前脚本的重启任务。

10. **清理**：
    - 删除临时文件。

11. **退出**：脚本执行完毕，退出。

### 注意事项

- 在执行此命令之前，请确保已经保存了所有重要的邮件数据，以防万一重启过程中出现数据丢失。
- 如果邮件服务正在处理重要的邮件任务，最好在系统负载较低的时候执行重启，以避免对邮件服务造成不必要的干扰。
- 如果邮件服务重启失败，脚本会尝试发送电子邮件报告给管理员，请确保管理员的电子邮件地址在配置文件中正确设置。

### 总结

`v-restart-mail`命令是Hestia服务器管理面板中一个用于重启邮件服务的CLI工具。通过掌握此命令的使用方法和注意事项，管理员可以更加灵活地管理邮件服务，确保系统的稳定性和可用性。

## v-rebuild-mail-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-rebuild-mail-domain)

`v-restart-mail` 是Hestia服务器管理面板中的一个CLI命令，用于重启邮件服务。当邮件服务遇到故障或需要进行更新配置时，该命令可以用来安全地重启邮件系统。

### 命令语法

`v-restart-mail [选项]`

- **选项**：可选参数，用于指定重启的类型或行为。

### 示例

#### 示例1：立即重启邮件服务

```bash
v-restart-mail
```

#### 示例2：计划重启邮件服务

```bash
v-restart-mail scheduled
```

#### 示例3：禁止重启邮件服务

```bash
v-restart-mail no
```

### 命令执行流程

1. **参数解析**：脚本接收一个可选参数，用于指定重启类型（如立即重启或计划重启）。

2. **环境加载**：加载Hestia的配置文件和主要函数脚本。

3. **检查邮件系统**：
   - 检查是否配置了邮件系统，以及邮件系统是否为远程系统。如果是远程系统，则脚本退出，因为远程系统通常不需要本地重启。

4. **检查重启选项**：
   - 如果传递了`no`作为参数，则脚本退出，不进行重启。

5. **计划重启**：
   - 如果传递了`scheduled`作为参数，或者没有传递参数但`SCHEDULED_RESTART`变量设置为`yes`，则将重启任务添加到重启队列中，并退出脚本。

6. **创建临时文件**：用于记录重启过程中的输出和错误信息。

7. **重启IMAP系统**（如果已配置）：
   - 调用`v-restart-service`命令来重启IMAP服务。
   - 如果重启失败，发送电子邮件报告并记录错误。

8. **重启邮件系统**：
   - 调用`v-restart-service`命令来重启邮件服务。
   - 如果重启失败，发送电子邮件报告并记录错误。

9. **更新重启队列**：
   - 如果存在重启队列文件，则从队列中移除当前脚本的重启任务。

10. **清理**：
    - 删除临时文件。

11. **退出**：脚本执行完毕，退出。

### 注意事项

- 在执行此命令之前，请确保已经保存了所有重要的邮件数据，以防万一重启过程中出现数据丢失。
- 如果邮件服务正在处理重要的邮件任务，最好在系统负载较低的时候执行重启，以避免对邮件服务造成不必要的干扰。
- 如果邮件服务重启失败，脚本会尝试发送电子邮件报告给管理员，请确保管理员的电子邮件地址在配置文件中正确设置。

### 总结

`v-restart-mail`命令是Hestia服务器管理面板中一个用于重启邮件服务的CLI工具。通过掌握此命令的使用方法和注意事项，管理员可以更加灵活地管理邮件服务，确保系统的稳定性和可用性。

## v-rebuild-mail-domains

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-rebuild-mail-domains)

`v-rebuild-mail-domains` 命令脚本是 Hestia 控制面板的一个关键组件，专为重建所有邮件域的 EXIM 配置文件而设计。这一功能在邮件服务器维护、配置更新或故障排除等场景中发挥着至关重要的作用。

### 功能目标

此命令的核心目的是重新生成 EXIM 邮件服务器的配置文件，以确保所有邮件域都能够正确、高效地处理邮件流量。当邮件服务器配置发生更改、系统升级或遭遇特定问题时，可能需要重建这些配置文件。

### 工作流程

当执行 `v-rebuild-mail-domains` 命令时，脚本会按照以下步骤操作：

1. **参数验证**：首先，脚本会验证传入的用户名参数是否有效。同时，它还会检查邮件系统是否启用，以及用户是否处于活动状态（未暂停）。

2. **遍历邮件域**：接下来，脚本会遍历所有邮件域。对于每个域，它会检查其状态，确保只处理那些需要重建配置的域。

3. **重建配置文件**：对于每个需要处理的邮件域，脚本会调用相关的函数或命令来重建 EXIM 配置文件。这通常涉及到根据当前的系统配置、用户设置和邮件域信息生成新的配置文件内容。

4. **应用配置**：一旦配置文件重建完成，脚本会负责将这些新配置应用到 EXIM 邮件服务器上。这通常涉及到重启邮件服务或重新加载配置，以确保新的设置生效。

5. **记录日志**：最后，脚本会记录一条系统日志，表明邮件域的配置文件已经成功重建。这有助于管理员跟踪系统的状态和历史操作。

### 重要性及应用场景

重建邮件域的 EXIM 配置文件对于确保邮件服务的稳定性和可靠性至关重要。以下是几个常见的应用场景：

- **系统升级或迁移**：在进行系统升级或迁移到新的服务器时，邮件服务的配置文件可能需要更新。使用 `v-rebuild-mail-domains` 命令可以确保新的服务器上配置了正确的邮件域信息。

- **配置更改**：当管理员对邮件服务的配置进行更改时，如添加新的邮件域、修改用户设置或调整邮件处理规则等，重建配置文件可以确保这些更改被正确应用。

- **故障排除**：如果邮件服务出现问题，如邮件发送失败、接收延迟或配置错误等，重建配置文件有时可以作为一种故障排除方法，帮助恢复服务的正常功能。

### 注意事项

在使用 `v-rebuild-mail-domains` 命令时，管理员需要注意以下几点：

- **谨慎操作**：由于此命令会重建所有邮件域的配置文件，因此在执行之前应确保了解当前的系统配置和用户设置，避免不必要的配置更改。

- **备份配置**：在执行重建操作之前，建议备份当前的配置文件，以便在出现问题时可以恢复到之前的状态。

- **监控系统状态**：在执行重建操作后，管理员应密切关注邮件服务的状态，确保新的配置被正确应用且服务正常运行。

通过合理使用 `v-rebuild-mail-domains` 命令，管理员可以更有效地管理和维护邮件服务，确保邮件系统的稳定性和高效性。

## v-list-sys-webmail

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-webmail)

`v-list-sys-webmail` 是 Hestia 控制面板的 CLI（命令行接口）命令脚本之一，用于列出系统上已配置并可用的 Webmail 客户端。Webmail 客户端允许用户通过 Web 浏览器来访问、阅读、发送和管理电子邮件，无需安装额外的邮件客户端软件。

### 功能概述

该脚本的主要功能是读取系统配置，并根据配置信息列出所有可用的 Webmail 客户端。这些客户端可能是预安装的，也可能是管理员手动添加的。脚本支持多种输出格式，以便用户可以根据需要选择以何种形式查看结果。

### 使用方法

使用 `v-list-sys-webmail` 命令时，可以通过传递一个可选的参数 `[FORMAT]` 来指定输出格式。如果不传递任何参数，则默认使用某种预设的输出格式（具体取决于脚本的默认设置）。

#### 示例 1：默认格式输出（假设为 Shell 格式）

```bash
v-list-sys-webmail
```

输出示例（假设 Roundcube 和 Rainloop 是已配置的 Webmail 客户端）：

```bash
Available Webmail Clients:
Roundcube
Rainloop
```

#### 示例 2：指定 JSON 格式输出

```bash
v-list-sys-webmail json
```

输出示例：

```json
[
    "Roundcube",
    "Rainloop"
]
```

#### 示例 3：指定 CSV 格式输出

```bash
v-list-sys-webmail csv
```

输出示例：

```csv
Client
Roundcube
Rainloop
```

### 注意事项

* 在使用 `v-list-sys-webmail` 命令之前，请确保已经正确安装和配置了 Hestia 控制面板，并且具有执行 CLI 命令的权限。
* 根据系统的配置和安装的 Webmail 客户端，输出的结果可能会有所不同。
* 如果系统上没有配置任何 Webmail 客户端，该命令可能不会返回任何输出或返回一个空列表。

通过 `v-list-sys-webmail` 命令，管理员和用户可以方便地查看系统上可用的 Webmail 客户端列表，并根据需要进行进一步的配置或访问操作。这有助于确保用户能够轻松地通过 Web 浏览器来使用邮件服务，提高系统的可用性和用户体验。

## v-list-sys-spamd-config

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-spamd-config)

`v-list-sys-spamd-config` 是 Hestia 控制面板的一个 CLI（命令行接口）命令脚本，用于列出系统上 SpamAssassin 的配置参数。SpamAssassin 是一个开源的电子邮件过滤器，用于识别和标记垃圾邮件。

### 功能概述

该脚本的主要功能是读取系统上的 SpamAssassin 配置文件，并列出其中的相关配置参数。它支持多种输出格式，以便用户可以根据需要选择以何种形式查看配置信息。

### 使用方法

使用 `v-list-sys-spamd-config` 命令时，可以通过传递一个可选的参数 `[FORMAT]` 来指定输出格式。如果不传递任何参数，则默认使用 Shell 格式输出。

#### 示例 1：默认 Shell 格式输出

```bash
v-list-sys-spamd-config
```

输出示例：

```bash
config_path:    /etc/spamassassin/local.cf
```

#### 示例 2：JSON 格式输出

```bash
v-list-sys-spamd-config json
```

输出示例：

```json
{
    "CONFIG": {
        "config_path": "/etc/spamassassin/local.cf"
    }
}
```

#### 示例 3：纯文本格式输出

```bash
v-list-sys-spamd-config plain
```

输出示例：

```
/etc/spamassassin/local.cf
```

#### 示例 4：CSV 格式输出

```bash
v-list-sys-spamd-config csv
```

输出示例：

```bash
config_path
/etc/spamassassin/local.cf
```

### 注意事项

* 在使用 `v-list-sys-spamd-config` 命令之前，请确保已经正确安装和配置了 Hestia 控制面板，并且具有执行 CLI 命令的权限。
* 该脚本会尝试在 `/etc/spamassassin` 和 `/etc/mail` 目录下查找名为 `local.cf` 的配置文件，这是 SpamAssassin 的常见配置文件路径。如果文件不存在或无法找到，则可能不会返回任何配置信息。
* 根据系统的配置和安装的 SpamAssassin 版本，输出的结果可能会有所不同。

通过 `v-list-sys-spamd-config` 命令，管理员可以方便地查看 SpamAssassin 的配置路径，从而进行进一步的配置或管理操作。这有助于确保系统的垃圾邮件过滤功能正常运行，提高邮件服务的质量和安全性。

## v-list-sys-mail-status

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-mail-status)

`v-list-sys-mail-status` 是 Hestia 控制面板的一个 CLI（命令行接口）命令脚本，用于列出邮件服务器的状态信息。

### 功能概述

该脚本的主要功能是检查和显示邮件服务器的状态，特别是 Exim 邮件队列的状态以及相关的统计信息。通过此脚本，用户可以快速了解邮件服务器的运行情况和性能指标。

### 使用方法

使用 `v-list-sys-mail-status` 命令时，无需传递任何参数。脚本将自动执行一系列检查，并输出相关信息。

#### 示例：查看邮件服务器状态

```bash
v-list-sys-mail-status
```

执行该命令后，脚本将输出以下信息：

1. **Exim 队列状态**：显示当前在 Exim 邮件队列中的邮件状态，包括等待发送、正在发送或已发送的邮件。
2. **Exim 统计信息**：通过分析 Exim 的日志文件，提供有关邮件传输的统计信息，如发送的邮件数量、接收的邮件数量等。

### 注意事项

* 在使用 `v-list-sys-mail-status` 命令之前，请确保已经正确安装和配置了 Hestia 控制面板，并且邮件服务器（如 Exim）正在运行。
* 脚本会根据系统的配置自动选择正确的日志文件路径进行分析。如果日志文件路径发生更改，可能需要相应地更新脚本。
* 如果脚本无法读取有效的日志行，将输出一条错误消息，并退出执行。

通过 `v-list-sys-mail-status` 命令，管理员可以方便地监控邮件服务器的状态和性能，及时发现潜在问题并进行相应的处理。这有助于确保邮件服务的稳定性和可靠性，提升用户体验。

## v-list-sys-dovecot-config

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-dovecot-config)

`v-list-sys-dovecot-config` 是 Hestia 控制面板的一个 CLI（命令行接口）脚本，用于列出 Dovecot 邮件服务器的配置文件的路径。Dovecot 是一个开源的 IMAP 和 POP3 邮件服务器，广泛用于各种邮件系统中。

### 功能概述

该脚本旨在帮助管理员查找 Dovecot 的主配置文件以及附加的配置文件，并以指定的格式输出这些文件的路径。支持的输出格式包括 JSON、Shell、纯文本和 CSV。

### 使用方法

通过运行 `v-list-sys-dovecot-config` 命令，并传递一个可选参数来指定输出格式，即可获取 Dovecot 配置文件的路径列表。

#### 参数说明

* `[FORMAT]`：可选参数，用于指定输出格式。如果未指定，则默认为 Shell 格式。

#### 输出格式

* `json`：输出 JSON 格式的列表。
* `plain`：输出纯文本格式的列表，每个路径之间使用制表符分隔。
* `csv`：输出 CSV 格式的列表，每个路径占据一列。
* `shell`：输出 Shell 格式的列表，每个路径占据一行。

### 示例

#### 示例 1：默认 Shell 格式输出

```bash
v-list-sys-dovecot-config
```

输出示例：

```bash
config_path:    /etc/dovecot/dovecot.conf
config_path1:   /etc/dovecot/conf.d/10-auth.conf
config_path2:   /etc/dovecot/conf.d/10-logging.conf
config_path3:   /etc/dovecot/conf.d/10-mail.conf
config_path4:   /etc/dovecot/conf.d/10-master.conf
config_path5:   /etc/dovecot/conf.d/10-ssl.conf
config_path6:   /etc/dovecot/conf.d/20-imap.conf
config_path7:   /etc/dovecot/conf.d/20-pop3.conf
config_path8:   /etc/dovecot/conf.d/auth-passwdfile.conf.ext
```

#### 示例 2：JSON 格式输出

```bash
v-list-sys-dovecot-config json
```

输出示例：

```json
{
    "CONFIG": {
        "config_path": "/etc/dovecot/dovecot.conf",
        "config_path1": "/etc/dovecot/conf.d/10-auth.conf",
        "config_path2": "/etc/dovecot/conf.d/10-logging.conf",
        "config_path3": "/etc/dovecot/conf.d/10-mail.conf",
        "config_path4": "/etc/dovecot/conf.d/10-master.conf",
        "config_path5": "/etc/dovecot/conf.d/10-ssl.conf",
        "config_path6": "/etc/dovecot/conf.d/20-imap.conf",
        "config_path7": "/etc/dovecot/conf.d/20-pop3.conf",
        "config_path8": "/etc/dovecot/conf.d/auth-passwdfile.conf.ext"
    }
}
```

#### 示例 3：纯文本格式输出

```bash
v-list-sys-dovecot-config plain
```

输出示例：

```bash
/etc/dovecot/dovecot.conf	/etc/dovecot/conf.d/10-auth.conf	/etc/dovecot/conf.d/10-logging.conf	/etc/dovecot/conf.d/10-mail.conf	/etc/dovecot/conf.d/10-master.conf	/etc/dovecot/conf.d/10-ssl.conf	/etc/dovecot/conf.d/20-imap.conf	/etc/dovecot/conf.d/20-pop3.conf	/etc/dovecot/conf.d/auth-passwdfile.conf.ext
```

#### 示例 4：CSV 格式输出

```bash
v-list-sys-dovecot-config csv
```

输出示例：

```csv
config_path,/etc/dovecot/dovecot.conf
config_path1,/etc/dovecot/conf.d/10-auth.conf
config_path2,/etc/dovecot/conf.d/10-logging.conf
config_path3,/etc/dovecot/conf.d/10-mail.conf
config_path4,/etc/dovecot/conf.d/10-master.conf
config_path5,/etc/dovecot/conf.d/10-ssl.conf
config_path6,/etc/dovecot/conf.d/20-imap.conf
config_path7,/etc/dovecot/conf.d/20-pop3.conf
config_path8,/etc/dovecot/conf.d/auth-passwdfile.conf.ext
```

请注意，上述示例中的配置文件路径可能因具体的 Dovecot 安装和配置而有所不同。

### 脚本片段解析

在你提供的脚本片段中，有几个配置文件路径被硬编码了（`config_path6`, `config_path7`, `config_path8`）。这些路径很可能是 Dovecot 配置的一部分。然后，根据传入的 `format` 参数（如果有的话），脚本会调用相应的函数（如 `json_list`, `plain_list`, `csv_list`, `shell_list`）来以指定的格式输出这些路径。

最后，脚本以 `exit` 命令结束，这会导致脚本终止并返回退出状态码。在大多数情况下，如果没有错误发生，退出状态码将是 0，表示成功执行。

### 使用注意事项

1. 确保你有足够的权限来读取 Dovecot 的配置文件。
2. 根据你的系统配置，Dovecot 的配置文件路径可能有所不同。
3. 如果脚本不是 Hestia 控制面板的一部分，或者你在一个非 Hestia 环境中运行它，你可能需要相应地调整脚本以适应你的环境。

如果你是在一个实际的服务器上运行这个命令，并且你有适当的权限，你应该能够看到 Dovecot 配置文件的实际路径列表。如果你是在一个没有安装 Hestia 或 Dovecot 的系统上运行这个命令，那么你可能需要找到或创建一个适合你的环境的类似脚本。

## v-list-mail-account

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-mail-account)

`v-list-mail-account` 是 Hestia 控制面板的一个 CLI（命令行接口）脚本，用于查询和显示特定邮件账户的详细信息。通过该脚本，管理员可以方便地获取关于邮件账户的别名、转发设置、自动回复状态、配额限制、磁盘使用情况、暂停状态等信息。

### 功能概述

该脚本旨在帮助管理员快速查看和管理邮件账户的各项设置。它支持以多种格式（JSON、Shell、纯文本和 CSV）输出账户信息，以满足不同的需求。

### 使用方法

运行 `v-list-mail-account` 命令，并传递用户、域名和账户名作为参数，以及一个可选的格式参数来指定输出格式。

#### 参数说明

* `user`：Hestia 控制面板中的用户名。
* `domain`：邮件账户所属的域名。
* `account`：要查询的邮件账户名。
* `[FORMAT]`：可选参数，用于指定输出格式。如果未指定，则默认为 Shell 格式。

#### 输出格式

* `json`：输出 JSON 格式的账户信息。
* `plain`：输出纯文本格式的账户信息，每个字段之间使用制表符分隔。
* `csv`：输出 CSV 格式的账户信息，每个字段占据一列。
* `shell`：输出 Shell 格式的账户信息，每个字段占据一行。

### 示例

#### 示例 1：默认 Shell 格式输出

```bash
v-list-mail-account john example.com info
```

输出示例：

```bash
账户：        info
别名：        
转发：        
仅转发：     no
自动回复：   no
配额：        0
磁盘：        /home/john/mail
暂停状态：   no
时间：        1679225709
日期：        2023-03-19 10:15:09
网络邮件别名：webmail.example.com
```

#### 示例 2：JSON 格式输出

```bash
v-list-mail-account john example.com info json
```

输出示例：

```json
{
    "info": {
        "别名": "",
        "转发": "",
        "仅转发": "no",
        "自动回复": "no",
        "配额": "0",
        "速率限制": "",
        "磁盘": "/home/john/mail",
        "暂停状态": "no",
        "时间": "1679225709",
        "日期": "2023-03-19 10:15:09",
        "网络邮件别名": "webmail.example.com"
    }
}
```

#### 示例 3：纯文本格式输出

```bash
v-list-mail-account john example.com info plain
```

输出示例：

```
info    0   0   0   /home/john/mail   no  1679225709  2023-03-19 10:15:09 webmail.example.com
```

#### 示例 4：CSV 格式输出

```bash
v-list-mail-account john example.com info csv
```

输出示例：

```csv
账户,别名,转发,仅转发,自动回复,配额,磁盘,暂停状态,时间,日期
info,,0,no,no,0,/home/john/mail,no,1679225709,2023-03-19 10:15:09,webmail.example.com
```

请注意，上述示例中的输出内容可能因具体的账户设置和状态而有所不同。在实际使用中，你应根据自己的环境和需求来运行该脚本，并查看相应的输出结果。

## v-list-mail-account-autoreply

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-mail-account-autoreply)

`v-list-mail-account-autoreply` 是 Hestia 控制面板的一个 CLI（命令行接口）脚本，用于查询特定邮件账户的自动回复消息。通过该脚本，管理员或用户可以方便地获取关于邮件账户设置的自动回复内容。

### 功能概述

该脚本旨在帮助查看和管理邮件账户的自动回复消息。它支持以多种格式（JSON、纯文本和 CSV）输出自动回复消息内容，以满足不同的需求。

### 使用方法

运行 `v-list-mail-account-autoreply` 命令，并传递用户、域名和账户名作为参数，以及一个可选的格式参数来指定输出格式。

#### 参数说明

* `user`：Hestia 控制面板中的用户名。
* `domain`：邮件账户所属的域名。
* `account`：要查询的邮件账户名。
* `[FORMAT]`：可选参数，用于指定输出格式。如果未指定，则默认为 Shell 格式。

#### 输出格式

* `json`：输出 JSON 格式的自动回复消息。
* `plain`：输出纯文本格式的自动回复消息。
* `csv`：输出 CSV 格式的自动回复消息。

### 示例

#### 示例 1：默认 Shell 格式输出（本脚本中未定义 shell 格式，因此假设输出纯文本格式）

```bash
v-list-mail-account-autoreply admin domain.tld tester
```

输出示例（假设有设置自动回复消息）：

```
感谢您发送的邮件。我目前无法回复，但会尽快回复。
```

如果没有设置自动回复，则可能不输出任何内容或输出一个表示无设置的消息。

#### 示例 2：JSON 格式输出

```bash
v-list-mail-account-autoreply admin domain.tld tester json
```

输出示例：

```json
{
    "tester": {
        "MSG": "感谢您发送的邮件。我目前无法回复，但会尽快回复。"
    }
}
```

如果没有设置自动回复，则 MSG 字段可能为空或包含相应的空值表示。

#### 示例 3：纯文本格式输出

```bash
v-list-mail-account-autoreply admin domain.tld tester plain
```

输出示例：

```
感谢您发送的邮件。我目前无法回复，但会尽快回复。
```

#### 示例 4：CSV 格式输出

```bash
v-list-mail-account-autoreply admin domain.tld tester csv
```

输出示例：

```csv
MSG
感谢您发送的邮件。我目前无法回复，但会尽快回复。
```

请注意，上述示例中的输出内容取决于实际的自动回复消息内容。在实际使用中，你应根据自己的环境和需求来运行该脚本，并查看相应的输出结果。如果邮件账户没有设置自动回复，那么脚本可能不会输出任何消息或会输出一个默认值表示没有设置自动回复。

## v-list-mail-accounts

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-mail-accounts)

`v-list-mail-accounts` 是 Hestia 控制面板的一个 CLI（命令行接口）脚本，用于列出指定域名下的所有邮件账户及其相关信息。通过该脚本，管理员或用户可以方便地查看邮件账户的状态、别名、转发设置、自动回复状态等。

### 功能概述

该脚本旨在帮助管理员和用户快速获取邮件账户的相关信息。它支持以多种格式（JSON、Shell、纯文本和 CSV）输出邮件账户列表及其详细信息，以满足不同的需求。

### 使用方法

运行 `v-list-mail-accounts` 命令，并传递用户名、域名和格式作为参数。

#### 参数说明

* `user`：Hestia 控制面板中的用户名。
* `domain`：要列出邮件账户的域名。
* `[FORMAT]`：可选参数，用于指定输出格式。如果未指定，则默认为 Shell 格式。

#### 输出格式

* `json`：输出 JSON 格式的邮件账户列表及其详细信息。
* `shell`：输出 Shell 格式的邮件账户列表及其部分信息（适用于命令行界面）。
* `plain`：输出纯文本格式的邮件账户列表及其详细信息，以制表符分隔。
* `csv`：输出 CSV 格式的邮件账户列表及其详细信息，以逗号分隔。

### 示例

#### 示例 1：默认 Shell 格式输出

```bash
v-list-mail-accounts admin domain.tld
```

输出示例（假设 `domain.tld` 下有多个邮件账户）：

```
ACCOUNT   ALIAS   FWD   DISK  DATE
-------   -----   ---   ----  ----
john      yes     no    100M  2023-04-01
jane      no      yes   200M  2023-03-15
...
```

#### 示例 2：JSON 格式输出

```bash
v-list-mail-accounts admin domain.tld json
```

输出示例：

```json
{
    "john": {
        "ALIAS": "yes",
        "FWD": "no",
        "FWD_ONLY": "no",
        "AUTOREPLY": "yes",
        "QUOTA": "100M",
        "U_DISK": "10%",
        "SUSPENDED": "no",
        "TIME": "12:00",
        "DATE": "2023-04-01"
    },
    "jane": {
        "ALIAS": "no",
        "FWD": "yes",
        "FWD_ONLY": "no",
        "AUTOREPLY": "no",
        "QUOTA": "200M",
        "U_DISK": "25%",
        "SUSPENDED": "no",
        "TIME": "11:30",
        "DATE": "2023-03-15"
    },
    ...
}
```

#### 示例 3：纯文本格式输出

```bash
v-list-mail-accounts admin domain.tld plain
```

输出示例：

```
john    yes no      no      100M    10% no      12:00   2023-04-01
jane    no  yes     no      200M    25% no      11:30   2023-03-15
...
```

#### 示例 4：CSV 格式输出

```bash
v-list-mail-accounts admin domain.tld csv
```

输出示例：

```csv
ACCOUNT,ALIAS,FWD,FWD_ONLY,AUTOREPLY,QUOTA,U_DISK,SUSPENDED,TIME,DATE
john,"yes","no",no,yes,100M,10%,no,12:00,2023-04-01
jane,"no","yes",no,no,200M,25%,no,11:30,2023-03-15
...
```

请注意，上述示例中的输出内容取决于实际的邮件账户设置和状态。在实际使用中，你应根据自己的环境和需求来运行该脚本，并查看相应的输出结果。如果某些字段没有设置或不存在，则输出中可能为空或显示为默认值。

## v-list-mail-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-mail-domain)

`v-list-mail-domain` 是 Hestia 控制面板的一个 CLI（命令行接口）脚本，用于列出指定域名的邮件域相关信息。通过该脚本，管理员或用户可以方便地查看邮件域的状态、配置、账户数量等。

### 功能概述

该脚本旨在帮助管理员和用户快速获取邮件域的相关信息。它支持以多种格式（JSON、Shell、纯文本）输出邮件域列表及其详细信息，以满足不同的需求。

### 使用方法

运行 `v-list-mail-domain` 命令，并传递用户名和域名作为参数。可选的第三个参数用于指定输出格式。

#### 参数说明

* `user`：Hestia 控制面板中的用户名。
* `domain`：要列出邮件域信息的域名。
* `[format]`：可选参数，用于指定输出格式。如果未指定，则默认为 Shell 格式。

#### 输出格式

* `json`：输出 JSON 格式的邮件域信息。
* `shell`：输出 Shell 格式的邮件域信息，便于在命令行界面中查看。
* `plain`：输出纯文本格式的邮件域信息，以制表符分隔，方便导入到表格或数据库中。

### 示例

#### 示例 1：默认 Shell 格式输出

```bash
v-list-mail-domain admin example.com
```

输出示例：

```
DOMAIN:             example.com
ANTIVIRUS:          yes
ANTISPAM:           yes
DKIM:               yes
CATCHALL:           no
ACCOUNTS:           10
DISK:               50%
SSL:                enabled
RATE_LIMIT:         100/hour
REJECT:             no
LETSENCRYPT:        yes
SUSPENDED:          no
TIME:               12:00
DATE:               2023-04-01
WEBMAIL_ALIAS:      webmail.example.com
WEBMAIL:            roundcube
U_SMTP_RELAY:       no
U_SMTP_RELAY_HOST:  
U_SMTP_RELAY_PORT:  
U_SMTP_RELAY_USERNAME:  
```

#### 示例 2：JSON 格式输出

```bash
v-list-mail-domain admin example.com json
```

输出示例：

```json
{
    "example.com": {
        "ANTIVIRUS": "yes",
        "ANTISPAM": "yes",
        "DKIM": "yes",
        "CATCHALL": "no",
        "ACCOUNTS": "10",
        "U_DISK": "50%",
        "SSL": "enabled",
        "RATE_LIMIT": "100/hour",
        "REJECT": "no",
        "LETSENCRYPT": "yes",
        "SUSPENDED": "no",
        "TIME": "12:00",
        "DATE": "2023-04-01",
        "WEBMAIL_ALIAS": "webmail.example.com",
        "WEBMAIL": "roundcube",
        "U_SMTP_RELAY": "no",
        "U_SMTP_RELAY_HOST": "",
        "U_SMTP_RELAY_PORT": "",
        "U_SMTP_RELAY_USERNAME": ""
    }
}
```

#### 示例 3：纯文本格式输出

```bash
v-list-mail-domain admin example.com plain
```

输出示例：

```
DOMAIN	ANTIVIRUS	ANTISPAM	DKIM	CATCHALL	ACCOUNTS	U_DISK	SSL	RATE_LIMIT	REJECT	LETSENCRYPT	SUSPENDED	TIME	DATE	WEBMAIL_ALIAS	WEBMAIL	U_SMTP_RELAY	U_SMTP_RELAY_HOST	U_SMTP_RELAY_PORT	U_SMTP_RELAY_USERNAME
example.com	yes	yes	yes	no	10	50%	enabled	100/hour	no	yes	no	12:00	2023-04-01	webmail.example.com	roundcube	no			
```

请注意，上述示例中的输出内容取决于实际的邮件域设置和状态。在实际使用中，你应根据自己的环境和需求来运行该脚本，并查看相应的输出结果。

## v-list-mail-domain-dkim

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-mail-domain-dkim)

`v-list-mail-domain-dkim` 是 Hestia 控制面板的一个 CLI（命令行接口）脚本，用于列出指定邮件域的 DKIM（DomainKeys Identified Mail）相关信息。DKIM 是一种电子邮件认证技术，用于验证邮件发送者的身份和邮件的完整性。通过该脚本，管理员或用户可以方便地查看邮件域的 DKIM 密钥信息，以确保邮件的安全性和可信度。

### 功能概述

该脚本旨在帮助管理员和用户快速获取邮件域的 DKIM 密钥对（PEM 和 PUB）。它支持以多种格式（JSON、Shell、纯文本、CSV）输出 DKIM 密钥信息，以满足不同的需求。

### 使用方法

运行 `v-list-mail-domain-dkim` 命令，并传递用户名和域名作为参数。可选的第三个参数用于指定输出格式。

#### 参数说明

* `user`：Hestia 控制面板中的用户名。
* `domain`：要列出 DKIM 信息的邮件域名。
* `[format]`：可选参数，用于指定输出格式。如果未指定，则默认为 Shell 格式。

#### 输出格式

* `json`：输出 JSON 格式的 DKIM 密钥信息。
* `shell`：输出 Shell 格式的 DKIM 密钥信息，便于在命令行界面中查看。
* `plain`：输出纯文本格式的 DKIM 密钥信息，每行一个密钥。
* `csv`：输出 CSV 格式的 DKIM 密钥信息，以逗号分隔。

### 示例

#### 示例 1：默认 Shell 格式输出

```bash
v-list-mail-domain-dkim admin example.com
```

输出示例：

```
-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDKXdE...
-----END PRIVATE KEY-----

-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyHcpF+Zb2sQ...
-----END PUBLIC KEY-----
```

#### 示例 2：JSON 格式输出

```bash
v-list-mail-domain-dkim admin example.com json
```

输出示例：

```json
{
    "example.com": {
        "PEM": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDKXdE...\n-----END PRIVATE KEY-----",
        "PUB": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyHcpF+Zb2sQ...\n-----END PUBLIC KEY-----"
    }
}
```

#### 示例 3：纯文本格式输出

```bash
v-list-mail-domain-dkim admin example.com plain
```

输出示例：

```
-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDKXdE...
-----END PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyHcpF+Zb2sQ...
-----END PUBLIC KEY-----
```

#### 示例 4：CSV 格式输出

```bash
v-list-mail-domain-dkim admin example.com csv
```

输出示例：

```csv
PEM,PUB
"-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDKXdE...\n-----END PRIVATE KEY-----","-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyHcpF+Zb2sQ...\n-----END PUBLIC KEY-----"
```

请注意，上述示例中的输出内容取决于实际的邮件域 DKIM 密钥对。在实际使用中，你应根据自己的环境和需求来运行该脚本，并查看相应的输出结果。确保在处理和共享 DKIM 密钥时采取适当的安全措施，以防止未经授权的访问和滥用。

## v-list-mail-domain-dkim-dns

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-mail-domain-dkim-dns)

`v-list-mail-domain-dkim-dns` 是 Hestia 控制面板的一个 CLI（命令行接口）脚本，用于生成邮件域的 DKIM DNS 记录信息。这个脚本允许管理员或用户以多种格式（JSON、Shell、纯文本、CSV）获取 DKIM TXT 记录的详细内容，以便将这些记录添加到 DNS 提供商的配置中，从而启用邮件的 DKIM 验证。

### 功能概述

* **生成 DKIM TXT 记录**：脚本会读取指定邮件域的公钥文件，并生成相应的 DKIM TXT 记录。
* **支持多种输出格式**：根据用户需求，可以以 JSON、Shell、纯文本或 CSV 格式输出 DKIM TXT 记录。
* **校验参数有效性**：脚本会对输入的用户名、域名和格式参数进行校验，确保它们的合法性。

### 使用方法

运行 `v-list-mail-domain-dkim-dns` 命令，并传递用户名和域名作为参数。可选的第三个参数用于指定输出格式。

#### 参数说明

* `user`：Hestia 控制面板中的用户名。
* `domain`：要生成 DKIM TXT 记录的邮件域名。
* `[format]`：可选参数，用于指定输出格式。如果未指定，则默认为 Shell 格式。

#### 输出格式

* `json`：输出 JSON 格式的 DKIM TXT 记录信息。
* `shell`：输出 Shell 格式的 DKIM TXT 记录信息，以表格形式展示。
* `plain`：输出纯文本格式的 DKIM TXT 记录信息，每行一个记录。
* `csv`：输出 CSV 格式的 DKIM TXT 记录信息，以逗号分隔。

### 示例

#### 示例 1：默认 Shell 格式输出

```bash
v-list-mail-domain-dkim-dns admin example.com
```

输出示例（假设 `example.com` 的 DKIM 支持已激活）：

```
RECORD            TTL         TYPE      VALUE
------            ---         ----      -----
_domainkey        3600   IN   TXT      "t=y; o=~;"
mail._domainkey   3600   IN   TXT      "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA..."
```

注意：这里的 `VALUE` 字段中的公钥 `p=` 后面跟随的是公钥的缩写形式，实际输出会包含完整的公钥字符串。

#### 示例 2：JSON 格式输出

```bash
v-list-mail-domain-dkim-dns admin example.com json
```

输出示例：

```json
{
    "_domainkey": {
        "TTL": "3600",
        "TXT": "t=y; o=~;"
    },
    "mail._domainkey": {
        "TTL": "3600",
        "TXT": "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA..."
    }
}
```

#### 示例 3：纯文本格式输出

```bash
v-list-mail-domain-dkim-dns admin example.com plain
```

输出示例：

```
_domainkey	3600	IN	TXT	"t=y; o=~;"
mail._domainkey	3600	IN	TXT	"v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA..."
```

#### 示例 4：CSV 格式输出

```bash
v-list-mail-domain-dkim-dns admin example.com csv
```

输出示例：

```csv
RECORD,TTL,IN,TYPE,VALUE
_domainkey,3600,IN,TXT,"t=y; o=~;"
mail._domainkey,3600,IN,TXT,"v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA..."
```

请注意，上述示例中的输出内容取决于实际的邮件域 DKIM 密钥和公钥文件。在实际使用中，你应根据自己的环境和需求来运行该脚本，并查看相应的输出结果。确保在将 DKIM TXT 记录添加到 DNS 配置

## v-list-mail-domain-ssl

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-mail-domain-ssl)

`v-list-mail-domain-ssl` 是 Hestia 控制面板的一个 CLI（命令行接口）脚本，用于列出和显示邮件域的 SSL 证书及其相关信息。这个脚本可以帮助管理员或用户以不同的格式获取 SSL 证书详情，以便进行进一步的配置、备份或检查。

### 功能概述

* **列出 SSL 证书信息**：脚本会读取指定邮件域的 SSL 证书文件，并提取相关信息，如证书内容、私钥、CA 证书、主题、别名、有效期等。
* **支持多种输出格式**：根据用户需求，可以以 JSON、Shell、纯文本或 CSV 格式输出 SSL 证书信息。
* **校验参数有效性**：脚本会对输入的用户名、域名和格式参数进行校验，确保它们的合法性。

### 使用方法

运行 `v-list-mail-domain-ssl` 命令，并传递用户名和域名作为参数。可选的第三个参数用于指定输出格式。

#### 参数说明

* `user`：Hestia 控制面板中的用户名。
* `domain`：要列出 SSL 证书信息的邮件域名。
* `[format]`：可选参数，用于指定输出格式。如果未指定，则默认为 Shell 格式。

#### 输出格式

* `json`：输出 JSON 格式的 SSL 证书信息。
* `shell`：输出 Shell 格式的 SSL 证书信息，包括证书内容、私钥等，并以易于阅读的格式展示其他信息。
* `plain`：输出纯文本格式的 SSL 证书信息，每行一个字段。
* `csv`：输出 CSV 格式的 SSL 证书信息，以逗号分隔各个字段。

### 示例

#### 示例 1：默认 Shell 格式输出

```bash
v-list-mail-domain-ssl admin example.com
```

输出示例（假设 `example.com` 的 SSL 证书已正确安装）：

```
-----BEGIN CERTIFICATE-----
... (证书内容) ...
-----END CERTIFICATE-----

-----BEGIN PRIVATE KEY-----
... (私钥内容) ...
-----END PRIVATE KEY-----

-----BEGIN CERTIFICATE-----
... (CA 证书内容) ...
-----END CERTIFICATE-----

SUBJECT:        CN=example.com, ...
ALIASES:        www.example.com, mail.example.com
VALID FROM:     2023-01-01 00:00:00
VALID TIL:      2024-01-01 00:00:00
SIGNATURE:      sha256WithRSAEncryption
PUB_KEY:        ... (公钥内容摘要) ...
ISSUER:         CN=Example CA, ...
```

#### 示例 2：JSON 格式输出

```bash
v-list-mail-domain-ssl admin example.com json
```

输出示例：

```json
{
  "example.com": {
    "CRT": "... (证书内容) ...",
    "KEY": "... (私钥内容) ...",
    "CA": "... (CA 证书内容) ...",
    "SUBJECT": "CN=example.com, ...",
    "ALIASES": "www.example.com, mail.example.com",
    "NOT_BEFORE": "2023-01-01 00:00:00",
    "NOT_AFTER": "2024-01-01 00:00:00",
    "SIGNATURE": "sha256WithRSAEncryption",
    "PUB_KEY": "... (公钥内容摘要) ...",
    "ISSUER": "CN=Example CA, ..."
  }
}
```

#### 示例 3：纯文本格式输出

```bash
v-list-mail-domain-ssl admin example.com plain
```

输出示例：

```
... (证书内容) ...
... (私钥内容) ...
... (CA 证书内容) ...
CN=example.com, ...
www.example.com, mail.example.com
2023-01-01 00:00:00
2024-01-01 00:00:00
sha256WithRSAEncryption
... (公钥内容摘要) ...
CN=Example CA, ...
```

#### 示例 4：CSV 格式输出

```bash
v-list-mail-domain-ssl admin example.com csv
```

输出示例：

```csv
CRT,... (证书内容) ...,KEY,... (私钥内容) ...,CA,... (CA 证书内容)
...,SUBJECT,CN=example.com, ...,ALIASES,http://www.example.com, mail.example.com,NOT_BEFORE,2023-01-01 00:00:00,NOT_AFTER,2024-01-01 00:00:00,SIGNATURE,sha256WithRSAEncryption,PUB_KEY,... (公钥内容摘要) ...,ISSUER,CN=Example CA, ...
```

### 注意事项

* 确保在运行脚本之前，已经正确安装了 Hestia 控制面板，并且具备相应的用户权限。
* 如果邮件域的 SSL 证书未正确安装或配置，脚本可能无法正确提取或显示相关信息。
* 在处理 SSL 证书和私钥时，务必谨慎操作，避免泄露敏感信息。

### 总结

`v-list-mail-domain-ssl` 是一个功能强大的 CLI 脚本，它可以帮助 Hestia 控制面板的用户以多种格式列出和显示邮件域的 SSL 证书信息。通过使用该脚本，用户可以方便地获取证书详情，用于进一步的配置、备份或安全检查。在使用过程中，用户需要确保输入正确的用户名和域名，并根据需要选择适当的输出格式。

## v-list-mail-domains

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-mail-domains)

### 1. 脚本说明

`v-list-mail-domains` 是一个 Hestia 控制面板的 CLI 命令脚本，用于列出指定用户的邮件域信息。该脚本支持多种输出格式，包括 JSON、Shell、Plain 和 CSV。

### 2. 使用方法

脚本需要两个参数：用户名和输出格式。如果未指定输出格式，则默认为 Shell 格式。


```bash
./v-list-mail-domains 用户名 输出格式
```
### 3. 示例

#### 3.1 JSON 格式示例


```bash
./v-list-mail-domains john json
```
输出可能如下：


```json
{
    "example.com": {
        "ANTIVIRUS": "yes",
        "ANTISPAM": "yes",
        "REJECT": "no",
        "RATE_LIMIT": "100",
        "DKIM": "enabled",
        "CATCHALL": "no",
        "ACCOUNTS": "5",
        "U_DISK": "10GB",
        "SSL": "enabled",
        "SUSPENDED": "no",
        "TIME": "2023-04-01 10:00:00",
        "DATE": "2023-03-31",
        "WEBMAIL_ALIAS": "webmail.example.com",
        "WEBMAIL": "roundcube"
    },
    "anotherexample.com": {
        ...
    }
}
```
#### 3.2 Shell 格式示例


```bash
./v-list-mail-domains john shell
```
输出可能如下：


```bash
DOMAIN      ANTIVIRUS   ANTISPAM   DKIM   SSL   ACC   DISK   SPND   DATE
----------  ----------  ---------  ----   ---   ---   ----   ----   ----
example.com yes         yes        enabled  yes   5     10GB   no     2023-03-31
anotherexample.com      ...       ...      ...    ...   ...   ...    ...     ...
```
#### 3.3 Plain 格式示例


```bash
./v-list-mail-domains john plain
```
输出可能如下：


```bash
example.com     yes     yes     enabled  yes   no      5     10GB   no     2023-03-31 10:00:00  webmail.example.com  roundcube
anotherexample.com ...   ...     ...      ...   ...     ...   ...    ...    ...                      ...                  ...
```
#### 3.4 CSV 格式示例


```bash
./v-list-mail-domains john csv
```
输出可能如下：


```csv
DOMAIN,ANTIVIRUS,ANTISPAM,DKIM,SSL,CATCHALL,ACCOUNTS,U_DISK,SUSPENDED,TIME,DATE,WEBMAIL_ALIAS,WEBMAIL
example.com,yes,yes,enabled,yes,no,5,10GB,no,2023-03-31 10:00:00,2023-03-31,webmail.example.com,roundcube
anotherexample.com,...,...,...,...,...,...,...,...,...,...,...,...
```
### 4. 注意事项

* 在运行脚本之前，请确保已经正确安装了 Hestia 控制面板，并且具备相应的用户权限。
* 根据实际需求选择合适的输出格式。
* 如果邮件域的 SSL 证书未正确安装或配置，脚本可能无法正确显示 SSL 状态。

### 5. 总结

`v-list-mail-domains` 脚本为 Hestia 控制面板用户提供了方便的方式来查看邮件域信息。通过选择不同的输出格式，用户可以根据需要获取不同格式的信息，用于进一步的分析、备份或报告。

## v-get-mail-account-value

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-get-mail-account-value)

### 脚本概述

`v-get-mail-account-value` 是 Hestia 控制面板提供的 CLI 命令脚本，用于获取特定邮件账户的特定参数值。通过传入用户名、域名、账户名和参数键作为参数，脚本可以返回与邮件账户相关的参数值。

### 脚本参数

* `USER`: Hestia 控制面板的管理员用户名。
* `DOMAIN`: 邮件账户的域名。
* `ACCOUNT`: 邮件账户的账户名。
* `KEY`: 需要获取的邮件账户参数的键名。

### 使用示例

#### 示例 1：获取邮件账户的配额

假设您想要获取 `example.com` 域名下 `testuser` 账户的配额，可以运行以下命令：

```bash
v-get-mail-account-value admin example.com testuser QUOTA
```

执行上述命令后，脚本将返回 `testuser` 账户的配额值。

#### 示例 2：检查邮件账户是否启用

如果您想要检查 `myshop.net` 域名下 `sales` 账户是否启用，可以执行以下命令：

```bash
v-get-mail-account-value manager myshop.net sales ENABLE
```

脚本将返回 `sales` 账户的启用状态，通常是以 `1` 表示启用，`0` 表示禁用。

#### 示例 3：获取邮件账户的前向地址

假设您想要知道 `alice@alice.org` 账户是否设置了前向地址，可以使用以下命令：

```bash
v-get-mail-account-value alice alice.org alice FORWARD
```

脚本将返回 `alice` 账户的前向地址，如果设置了的话。

### 注意事项

* 请确保您具有足够的权限来执行该脚本，并且已经正确配置了 Hestia 控制面板。
* 脚本中的参数键名通常是区分大小写的，请确保使用正确的键名。
* 如果脚本返回错误信息或无法获取预期结果，请检查您提供的参数是否正确，并参考 Hestia 的官方文档或支持论坛以获取更多帮助。

### 总结

`v-get-mail-account-value` 脚本是一个功能强大的工具，用于获取 Hestia 控制面板中邮件账户的特定参数值。通过提供正确的参数，您可以轻松地获取有关邮件账户的详细信息，并根据需要进行相应的操作和管理。请确保在使用脚本时遵循最佳实践和注意事项，以确保获得准确和可靠的结果。

## v-get-mail-domain-value

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-get-mail-domain-value)

### 脚本概述

`v-get-mail-domain-value` 是 Hestia 控制面板提供的一个 CLI 命令脚本，用于获取特定邮件域名的参数值。通过指定管理员用户名、域名和参数键，脚本能够返回与邮件域名相关的配置信息。

### 脚本参数

* `USER`: Hestia 控制面板的管理员用户名。
* `DOMAIN`: 邮件域名。
* `KEY`: 需要获取的邮件域名参数的键名。

### 使用示例

#### 示例 1：获取邮件域名的 DKIM 密钥

假设您想要获取 `example.com` 邮件域名的 DKIM 密钥，可以运行以下命令：

```bash
v-get-mail-domain-value admin example.com DKIM
```

执行该命令后，脚本将返回 `example.com` 邮件域名的 DKIM 密钥值。

#### 示例 2：检查邮件域名的 MX 记录设置

如果您想要检查 `mydomain.net` 邮件域名是否设置了特定的 MX 记录，可以执行以下命令：

```bash
v-get-mail-domain-value manager mydomain.net MX
```

脚本将返回 `mydomain.net` 邮件域名的 MX 记录设置。

#### 示例 3：获取邮件域名的SPF策略

假设您想要知道 `alice.org` 邮件域名当前的 SPF 策略，可以使用以下命令：

```bash
v-get-mail-domain-value alice alice.org SPF
```

脚本将返回 `alice.org` 邮件域名的 SPF 策略设置。

### 注意事项

* 请确保您已经正确配置了 Hestia 控制面板，并且拥有足够的权限来执行该脚本。
* 脚本中的参数键名通常是区分大小写的，请确保使用正确的键名。
* 如果脚本返回错误信息或无法获取预期结果，请检查您提供的参数是否正确，并参考 Hestia 的官方文档或支持论坛以获取更多帮助。

### 总结

`v-get-mail-domain-value` 脚本提供了一个方便的方式来获取 Hestia 控制面板中邮件域名的特定参数值。通过指定正确的参数，您可以轻松地获取有关邮件域名的配置信息，并根据需要进行相应的操作和管理。请确保在使用脚本时遵循最佳实践和注意事项，以确保获得准确和可靠的结果。

## v-list-sys-clamd-config

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-clamd-config)

### 脚本概述

`v-list-sys-clamd-config` 是 Hestia 控制面板提供的一个 CLI 命令脚本，用于列出 ClamAV 的 clamd 配置文件的路径。通过该脚本，您可以快速获取 ClamAV 的配置文件位置，方便进行配置管理和安全检查。

### 脚本参数

* `format`: 可选参数，用于指定输出格式。默认为 `shell` 格式。支持 `json`、`plain`、`csv` 和 `shell` 四种格式。

### 使用示例

#### 示例 1：以 shell 格式列出 clamd 配置文件路径

执行以下命令，以 shell 格式输出 clamd 配置文件的路径：

```bash
v-list-sys-clamd-config shell
```

输出可能如下：

```bash
config_path:    /etc/clamav/clamd.conf
```

#### 示例 2：以 JSON 格式列出 clamd 配置文件路径

如果您需要以 JSON 格式获取 clamd 配置文件的路径，可以执行以下命令：

```bash
v-list-sys-clamd-config json
```

输出可能如下：

```json
{
    "CONFIG": {
        "config_path": "/etc/clamav/clamd.conf"
    }
}
```

#### 示例 3：以 plain 格式列出 clamd 配置文件路径

如果您只需要 clamd 配置文件的路径，而不需要其他额外的输出，可以使用 plain 格式：

```bash
v-list-sys-clamd-config plain
```

输出将直接显示配置文件路径：

```bash
/etc/clamav/clamd.conf
```

#### 示例 4：以 CSV 格式列出 clamd 配置文件路径

如果您需要将 clamd 配置文件路径以 CSV 格式导出，可以执行以下命令：

```bash
v-list-sys-clamd-config csv
```

输出将类似于：

```bash
config_path
/etc/clamav/clamd.conf
```

### 注意事项

* 脚本会根据不同的系统配置和文件位置自动检测 clamd 的配置文件路径。如果没有找到 `/etc/clamav/clamd.conf`，脚本会尝试查找 `/etc/clamd.conf` 和 `/etc/clamd.d/clamd.conf`。
* 如果您的系统配置与脚本默认检测的位置不同，您可能需要手动指定配置文件的路径。
* 输出格式可以根据您的需求选择，不同的格式适用于不同的使用场景，如脚本处理、手动查看或导入到其他工具中。

### 总结

`v-list-sys-clamd-config` 脚本提供了灵活的方式来获取 ClamAV 的 clamd 配置文件路径。通过指定不同的输出格式，您可以根据需要将配置信息导出为适合您工作流程的格式。请确保在使用脚本时遵循最佳实践，并根据您的系统配置进行适当的调整。

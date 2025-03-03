# 数据库系列命令介绍

## v-dump-database

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-dump-database)

### 概述

`v-dump-database` 是一个命令行工具，用于将指定数据库的内容转储到标准输入（STDIN）或者文件中。此工具支持对转储文件进行压缩，默认为不压缩的 SQL 格式。此外，它还提供了对转储过程的验证和错误处理机制，确保数据的安全性和完整性。

### 依赖与配置

该工具依赖于 HestiaCP 提供的配置文件和函数库，包括 `/etc/hestiacp/hestia.conf`、`/usr/local/hestia/func/main.sh` 和 `/usr/local/hestia/func/db.sh` 等文件。确保这些文件和目录存在于系统中，并且具有正确的权限和配置。

### 使用方法

### 命令格式

```bash
v-dump-database USER DATABASE [FILE] [COMPRESSION]
```

- `USER`：数据库用户名
- `DATABASE`：数据库名
- `FILE`（可选）：输出文件名，如果省略则输出到 STDIN
- `COMPRESSION`（可选）：压缩方式，支持 gzip 或 zstd，如果省略则不进行压缩

### 示例

1. 将数据库内容转储到文件 `test.sql`：

   ```bash
   v-dump-database user user_database > test.sql
   ```

2. 将数据库内容转储到文件并使用 gzip 压缩：

   ```bash
   v-dump-database user user_database file gzip
   ```

3. 将数据库内容转储到文件并使用 zstd 压缩：

   ```bash
   v-dump-database user user_database file zstd
   ```

### 功能特性

- **数据库验证**：在转储前，工具会验证数据库是否存在以及用户是否有足够的权限进行转储操作。
- **错误处理**：如果遇到错误（如数据库不存在、用户权限不足等），工具会输出相应的错误信息并记录日志。
- **压缩支持**：支持 gzip 和 zstd 两种压缩方式，方便用户对转储文件进行压缩存储。
- **时间戳记录**：在转储过程中，工具会生成一个时间戳，用于记录转储的时间。
- **临时目录**：在转储过程中，工具会创建一个临时目录来存放转储过程中的临时文件。

### 注意事项

- 在使用此工具时，请确保 HestiaCP 的相关配置文件和函数库已经正确配置和安装。
- 如果使用压缩选项，请确保系统已经安装了相应的压缩工具（如 gzip 或 zstd）。
- 输出的转储文件可能包含敏感信息，请妥善保管并遵循相关的数据安全规定。

### 结论

`v-dump-database` 是一个功能强大且易于使用的命令行工具，用于将数据库内容转储到 STDIN 或文件中。它支持多种压缩方式，并提供了完善的验证和错误处理机制，为用户提供了灵活、安全、可靠的数据转储方案。

## v-change-database-host-password

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-database-host-password)

`v-change-database-host-password` 是由 hestia 提供的 CLI 命令，用于更改远程数据库主机上的数据库用户密码。此命令特别针对 MySQL 数据库进行了实现，并预留了 PostgreSQL 的实现接口（当前标记为“TBD”）。

### 使用方法

```bash
v-change-database-host-password TYPE HOST DBUSER DBPASS
```

- `TYPE`: 数据库类型，目前支持 `mysql`。
- `HOST`: 数据库主机地址。
- `DBUSER`: 数据库用户名。
- `DBPASS`: 新的数据库密码。

### 示例

**示例 1: 更改 MySQL 数据库的 root 用户密码**

假设我们要将远程 MySQL 数据库的 root 用户密码更改为 `NewPassword123`，并且该数据库位于 `192.168.1.100` 上。

```bash
v-change-database-host-password mysql 192.168.1.100 root NewPassword123
```

执行上述命令后，该命令会：

1. 连接到 MySQL 数据库服务器。
2. 更新 `mysql.user` 表中的 `root` 用户的密码。
3. 刷新 MySQL 权限。
4. 如果更改的是 `root` 用户的密码，还会更新 `/root/.my.cnf` 文件以存储新密码（仅用于 MySQL root 用户）。
5. 更新配置文件中的密码信息。
6. 记录系统日志，表明已更改了远程数据库主机的密码。

**示例 2: 预留的 PostgreSQL 实现（当前不可用）**

虽然 `v-change-database-host-password` 命令预留了对 PostgreSQL 的支持，但当前版本并未实现。如果你尝试使用以下命令：

```bash
v-change-database-host-password pgsql 192.168.1.101 postgres NewPassword123
```

命令将不会执行任何针对 PostgreSQL 的操作，并仅输出一个“TBD”（待办事项）的消息到 `/dev/null`。

### 注意事项

- 请确保你有权更改目标数据库服务器上的密码。
- 对于 MySQL，更改 root 用户的密码后，`/root/.my.cnf` 文件将被更新以存储新密码。这样做是为了方便脚本和应用程序无需每次都输入密码即可连接到 MySQL 服务器。但请注意，这也会增加安全风险，因为该文件可能被其他用户读取。
- 更改密码后，所有使用该密码连接到数据库的服务和应用程序都需要更新其配置以使用新密码。
- 如果 hestia 系统处于只读模式（demo 模式），则此命令将不会执行任何操作。

## v-change-database-owner

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-database-owner)

### 概述

`v-change-database-owner` 是 Hestia 提供的命令行接口（CLI）命令之一，用于更改数据库的所有者。通过此命令，管理员或具有适当权限的用户可以轻松地将数据库的所有权从当前用户转移到另一个用户。

### 语法


```bash
v-change-database-owner [选项] DATABASE USER
```
- `DATABASE`：要更改所有者的数据库名称。
- `USER`：新数据库所有者的用户名。

### 选项

本命令没有额外的选项参数，直接通过位置参数传递所需的数据库名称和新所有者用户名。

### 示例

#### 示例 1：更改数据库所有者

假设要将名为 `mydatabase` 的数据库的所有者更改为 `newowner`，可以运行以下命令：

```bash
v-change-database-owner mydatabase newowner
```

执行成功后，`mydatabase` 的所有者将被更改为 `newowner`。

#### 示例 2：处理不存在的数据库

如果尝试更改不存在的数据库的所有者，命令将返回错误消息。例如：

```bash
v-change-database-owner nonexistentdb newowner
```

可能会收到如下错误消息：

```bash
Error: database nonexistentdb doesn't exist
```

#### 示例 3：处理不存在的用户

如果尝试将数据库的所有权转移给一个不存在的用户，命令也可能返回错误消息。例如：

```bash
v-change-database-owner mydatabase fakeuser
```

可能会收到如下错误消息：

```bash
Error: user fakeuser doesn't exist
```

### 注意事项

1. **权限**：执行此命令的用户必须具有足够的权限来更改数据库的所有者。
2. **系统状态**：在执行此命令之前，请确保 Hestia 系统正常运行，并且数据库服务可访问。
3. **数据备份**：在执行任何可能导致数据丢失或更改的操作之前，建议备份相关数据和配置。
4. **错误处理**：请仔细阅读命令返回的错误消息，并根据需要进行适当的故障排除或修复。

### 结论

`v-change-database-owner` 命令是 Hestia 系统中一个强大的工具，允许管理员轻松更改数据库的所有者。通过遵循上述语法和示例，您可以有效地使用该命令来管理您的数据库所有权。

## v-change-database-password

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-database-password)

`v-change-database-password` 是 Hestia 提供的 CLI 命令，用于更改指定数据库的用户密码。本命令在 Hestia 控制面板环境中执行，用于维护和管理数据库的安全。

### 用法

```bash
v-change-database-password USER DATABASE DBPASS
```

* **USER**: 要更改密码的数据库用户名。
* **DATABASE**: 要更改密码的数据库名称。
* **DBPASS**: 新的数据库密码。

### 示例

#### 示例 1: 更改 MySQL 数据库密码

假设我们要为 `john` 用户在 `mydatabase` 数据库中更改密码为 `newpassword123`，可以执行以下命令：

```bash
v-change-database-password john mydatabase newpassword123
```

执行此命令后，如果所有检查均通过（例如用户存在、数据库存在、密码符合格式等），则会成功更改 `john` 用户在 `mydatabase` 数据库中的密码。

#### 示例 2: 更改 PostgreSQL 数据库密码

对于 PostgreSQL 数据库，过程与 MySQL 相同。假设我们要为 `jane` 用户在 `anotherdb` 数据库中更改密码为 `anotherpass456`，可以执行：

```bash
v-change-database-password jane anotherdb anotherpass456
```

### 脚本逻辑

1. **参数检查**：首先，脚本会检查是否提供了正确数量的参数（在这种情况下为3个），并验证这些参数（用户名、数据库名和密码）的格式是否有效。
2. **用户和数据库验证**：接下来，脚本会检查用户是否存在、是否未被暂停，以及数据库是否存在、是否未被暂停。
3. **密码验证**：还会验证提供的密码是否符合 Hestia 的密码策略。
4. **数据库系统检查**：确认数据库系统（如 MySQL 或 PostgreSQL）是否已启用。
5. **密码更改**：根据数据库类型（MySQL 或 PostgreSQL），调用相应的函数来更改密码。
6. **日志记录**：最后，脚本会记录更改密码的操作，包括更改的用户、数据库和新的密码（但密码在日志中会被哈希或隐藏）。

### 注意事项

* 使用此命令时，请确保您有足够的权限来更改指定的数据库密码。
* 更改密码后，请确保所有使用该数据库的用户都已更新其连接凭据。
* 始终在更改密码之前备份数据库和相关配置文件，以防万一。

## v-change-database-user

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-database-user)

`v-change-database-user` 是 Hestia 提供的 CLI 命令，用于更改指定数据库的用户名。如果提供了新密码，该命令还会同时更新该用户的密码。本命令在 Hestia 控制面板环境中执行，用于维护和管理数据库用户的安全和配置。

### 用法

```bash
v-change-database-user USER DATABASE DBUSER [DBPASS]
```

- **USER**: 执行命令的 Hestia 用户。
- **DATABASE**: 要更改数据库用户的数据库名称。
- **DBUSER**: 新的数据库用户名。通常，该命令会基于原始用户名和提供的 `DBUSER` 参数生成一个新的用户名（例如，通过连接原始用户名和 `DBUSER` 参数）。
- **[DBPASS]**: （可选）新的数据库密码。如果提供了密码，则该命令将同时更新用户的密码。

### 示例

#### 示例 1: 更改 MySQL 数据库用户名（无密码更改）

假设我们要将 `mydatabase` 数据库中的用户从 `olduser` 更改为 `newuser`，但不更改密码，可以执行以下命令：

```bash
v-change-database-user admin mydatabase newuser
```

在这个例子中，新的数据库用户名将是 `admin_newuser`（假设原始用户名是 `admin`）。

#### 示例 2: 更改 PostgreSQL 数据库用户名和密码

假设我们要将 `postgresdb` 数据库中的用户从 `jane` 更改为 `jane_new`，并将密码更改为 `newpass123`，可以执行：

```bash
v-change-database-user admin postgresdb new jane_new newpass123
```

在这个例子中，新的数据库用户名将是 `admin_jane_new`，密码将被更新为 `newpass123`。

### 脚本逻辑

1. **参数检查**：脚本首先验证是否提供了正确数量的参数，并检查这些参数（用户名、数据库名、新用户名和可选密码）的格式是否有效。
2. **用户和数据库验证**：脚本会检查执行命令的用户是否存在、是否未被暂停，以及指定的数据库是否存在、是否未被暂停。
3. **新用户名检查**：如果新用户名与旧用户名相同，则脚本将退出，因为没有必要进行任何更改。
4. **更新数据库配置**：脚本会更新数据库配置，将旧用户名替换为新用户名。
5. **数据库系统处理**：根据数据库类型（MySQL 或 PostgreSQL），脚本将执行相应的操作来重建数据库或更新密码（如果提供了新密码）。
6. **删除旧用户**（如果适用）：如果旧用户名在数据库配置文件中不再存在，脚本将删除与该用户名关联的任何数据库用户（以避免遗留的用户和潜在的安全风险）。
7. **日志记录**：最后，脚本会记录更改数据库用户的操作，包括更改的用户名、数据库和新密码（如果提供了）。

### 注意事项

* 使用此命令时，请确保您有足够的权限来更改指定的数据库用户名和密码。
* 更改用户名后，请确保所有使用该数据库的用户都已更新其连接凭据。
* 始终在更改用户名或密码之前备份数据库和相关配置文件，以防万一。
* 注意，某些数据库系统可能对用户名有特定的格式要求（例如，PostgreSQL 不允许用户名中包含连字符 `-`）。在更改用户名时，请确保新用户名符合这些要求。

## v-update-database-disk

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-database-disk)

`v-update-database-disk` 是 Hestia 提供的 CLI 命令，用于重新计算并更新特定数据库的磁盘使用情况。这对于监控数据库磁盘空间的使用情况、确保准确性以及优化资源分配非常有用。

### 用法

```bash
v-update-database-disk USER DATABASE
```

- **USER**: 执行命令的 Hestia 用户。
- **DATABASE**: 要更新磁盘使用情况的数据库名称。

### 示例

#### 示例 1: 更新 WordPress 数据库的磁盘使用情况

假设您有一个名为 `wp_db` 的 WordPress 数据库，并且您想更新其磁盘使用情况，可以执行以下命令：

```bash
v-update-database-disk admin wp_db
```

在这里，`admin` 是执行命令的 Hestia 用户，而 `wp_db` 是要更新磁盘使用情况的数据库名称。

### 脚本逻辑

1. **参数验证**：首先，脚本会验证是否提供了正确数量的参数（即用户名和数据库名），并检查这些参数的格式是否有效。
2. **系统验证**：接着，脚本会检查数据库系统（如 MySQL 或 PostgreSQL）是否已启用，并验证指定的用户和数据库是否存在。
3. **获取数据库值**：通过调用 `get_database_values` 函数，脚本获取与指定数据库相关的所有值，包括数据库类型（MySQL 或 PostgreSQL）。
4. **计算磁盘使用情况**：根据数据库类型（MySQL 或 PostgreSQL），脚本会调用相应的函数（`get_mysql_disk_usage` 或 `get_pgsql_disk_usage`）来计算数据库的磁盘使用情况。
5. **更新磁盘使用情况**：计算完成后，脚本会调用 `update_object_value` 函数来更新数据库的磁盘使用情况值。此外，它还会调用 `recalc_user_disk_usage` 函数来重新计算指定用户的总磁盘使用情况。
6. **日志记录**：最后，脚本会记录一个事件，表明已成功更新指定数据库的磁盘使用情况。

### 注意事项

* 在执行此命令之前，请确保您有足够的权限来访问和修改指定的数据库。
* 如果数据库磁盘使用情况计算失败或遇到任何错误，脚本将记录相应的错误事件。
* 如果您发现数据库磁盘使用情况与实际不符，可以使用此命令来重新计算并更新它。
* 请注意，此命令可能需要一些时间来完成，具体取决于数据库的大小和复杂性。在执行此命令时，请确保系统资源充足，以避免对数据库性能产生负面影响。

## v-update-databases-disk

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-databases-disk)

`v-update-databases-disk` 是 Hestia 提供的 CLI 命令，用于重新计算并更新指定用户下所有数据库的磁盘使用情况。这有助于确保数据库磁盘使用情况的准确性，并帮助管理员更好地管理存储资源。

### 用法

```bash
v-update-databases-disk USER
```

- **USER**: 执行命令的 Hestia 用户。

### 示例

#### 示例 1: 更新管理员用户下的所有数据库磁盘使用情况

假设您想更新管理员用户 `admin` 下的所有数据库的磁盘使用情况，可以执行以下命令：

```bash
v-update-databases-disk admin
```

### 脚本逻辑

1. **参数验证**：首先，脚本会验证是否提供了正确的参数（即用户名），并检查该参数的格式是否有效。
2. **系统验证**：接着，脚本会检查数据库系统（`$DB_SYSTEM`）是否已启用，并验证指定的用户是否存在。
3. **获取数据库列表**：使用 `$BIN/v-list-databases` 命令和参数 `$user` 来列出指定用户下的所有数据库，并通过 `cut` 命令提取数据库名称。
4. **循环更新**：对于从数据库列表中获取的每一个数据库，脚本都会调用 `v-update-database-disk` 命令来更新该数据库的磁盘使用情况。
5. **日志记录**：更新完成后，脚本会记录一个事件，表明已成功更新指定用户下所有数据库的磁盘使用情况。

### 注意事项

* 在执行此命令之前，请确保您有足够的权限来访问和修改指定用户的所有数据库。
* 如果某个数据库的磁盘使用情况计算失败或遇到任何错误，`v-update-database-disk` 命令会记录相应的错误事件。
* 如果您发现数据库磁盘使用情况与实际不符，可以使用此命令来重新计算并更新它们。
* 请注意，此命令可能需要一些时间来完成，具体取决于数据库的数量和大小。在执行此命令时，请确保系统资源充足，以避免对数据库性能产生负面影响。

## v-unsuspend-database

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-unsuspend-database)

### 简介

`v-unsuspend-database` 是 Hestia 提供的一个 CLI 命令，用于取消暂停指定的数据库。当数据库由于某些原因（如超出资源限制、安全策略等）被暂停时，可以使用此命令来恢复数据库的正常运行状态。

### 用法

```bash
v-unsuspend-database USER DATABASE
```

- **USER**：指定要取消暂停数据库的用户的用户名。
- **DATABASE**：指定要取消暂停的数据库名称。

### 示例

#### 示例 1：取消暂停名为 `mydb` 的数据库（属于用户 `admin`）

```bash
v-unsuspend-database admin mydb
```

#### 示例 2：取消暂停名为 `customerdb` 的数据库（属于用户 `customer123`）

```bash
v-unsuspend-database customer123 customerdb
```

### 参数验证

- **参数数量**：该命令需要两个参数，即 `USER` 和 `DATABASE`。
- **参数格式**：用户名和数据库名都需要是有效的格式。
- **系统状态**：检查数据库系统是否已经启用。
- **对象验证**：验证指定的用户是否存在，并且指定的数据库是否属于该用户。
- **暂停状态**：验证数据库是否处于暂停状态。

### 安全性检查

- **只读模式**：如果 Hestia 处于只读模式（如演示环境），该命令将不会执行任何操作，并返回相应的提示信息。

### 执行操作

- **获取数据库值**：获取与数据库相关的配置值或属性。
- **切换数据库类型**：根据数据库的类型（如 MySQL 或 PostgreSQL），执行相应的取消暂停操作。
- **更新数据库状态**：将数据库的状态从暂停更改为未暂停。
- **更新用户值**（可选）：如果系统跟踪用户的暂停数据库数量，则减少该值。

### 日志记录

- **系统日志**：记录一条系统日志，表明已经成功取消了数据库的暂停状态，并包含相关的用户和数据库信息。
- **事件日志**：记录一条事件日志，用于跟踪和审计。

### 注意事项

- **权限**：在执行此命令之前，请确保您有足够的权限来访问和修改指定的数据库。
- **数据库状态**：请确保数据库确实处于暂停状态，否则该命令可能不会产生任何效果。
- **系统状态**：检查 Hestia 系统和数据库系统是否正常运行，以避免潜在的问题或错误。
- **演示模式**：如果在演示模式下运行此命令，请注意它可能不会产生任何实际效果。

## v-unsuspend-database-host

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-unsuspend-database-host)

### 简介

`v-unsuspend-database-host` 是 Hestia 提供的一个 CLI 命令，用于取消暂停指定的数据库服务器。当数据库服务器由于某些原因（如维护、资源限制等）被暂停时，可以使用此命令来恢复服务器的正常运行状态。

### 用法

```bash
v-unsuspend-database-host TYPE HOST
```

- **TYPE**：指定数据库服务器的类型，如 `mysql`、`pgsql` 等。
- **HOST**：指定要取消暂停的数据库服务器的主机名或 IP 地址。

### 示例

#### 示例 1：取消暂停名为 `localhost` 的 MySQL 数据库服务器

```bash
v-unsuspend-database-host mysql localhost
```

#### 示例 2：取消暂停名为 `dbserver.example.com` 的 PostgreSQL 数据库服务器

```bash
v-unsuspend-database-host pgsql dbserver.example.com
```

### 参数验证

- **参数数量**：该命令需要两个参数，即 `TYPE` 和 `HOST`。
- **参数格式**：`TYPE` 和 `HOST` 都需要是有效的格式。
- **系统状态**：检查数据库系统是否已经启用。
- **对象验证**：验证指定的服务器类型是否有效，并且指定的主机名或 IP 地址是否属于该类型的服务器。
- **暂停状态**：验证指定的数据库服务器是否处于暂停状态。

### 安全性检查

- **只读模式**：如果 Hestia 处于只读模式（如演示环境），该命令将不会执行任何操作，并返回相应的提示信息。

### 取消暂停操作

- **更新服务器状态**：将数据库服务器的暂停状态从“是”更改为“否”，从而恢复其正常运行。

### 日志记录

- **事件日志**：记录一条事件日志，包含取消暂停操作的结果和相关信息，用于跟踪和审计。

### 注意事项

- **权限**：在执行此命令之前，请确保您有足够的权限来访问和修改指定的数据库服务器。
- **服务器状态**：请确保服务器确实处于暂停状态，否则该命令可能不会产生任何效果。
- **系统状态**：检查 Hestia 系统和数据库系统是否正常运行，以避免潜在的问题或错误。
- **演示模式**：如果在演示模式下运行此命令，请注意它可能不会产生任何实际效果。

## v-unsuspend-databases

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-unsuspend-databases)

### 简介

`v-unsuspend-databases` 是 Hestia 提供的一个 CLI 命令，用于取消暂停指定用户的所有数据库。当由于某些原因（如维护、资源限制等）导致用户的数据库被暂停时，可以使用此命令来恢复这些数据库的正常运行状态。

### 用法

```bash
v-unsuspend-databases USER
```

- **USER**：指定要取消暂停其所有数据库的用户名。

### 示例

#### 示例 1：取消暂停用户 `john` 的所有数据库

```bash
v-unsuspend-databases john
```

### 参数验证

- **参数数量**：该命令需要一个参数，即 `USER`。
- **参数格式**：`USER` 需要是有效的用户名格式。
- **系统状态**：检查数据库系统是否已经启用。
- **用户验证**：验证指定的用户是否存在。

### 安全性检查

- **只读模式**：如果 Hestia 处于只读模式（如演示环境），该命令将不会执行任何操作，并返回相应的提示信息。

### 取消暂停操作

- **循环取消暂停**：该命令会遍历所有处于暂停状态的数据库，并对每个数据库执行 `v-unsuspend-database` 命令，以取消其暂停状态。

### 日志记录

- **事件日志**：记录一条事件日志，包含取消暂停操作的结果和相关信息，用于跟踪和审计。

### 注意事项

- **权限**：在执行此命令之前，请确保您有足够的权限来访问和修改指定用户的数据库。
- **数据库状态**：请确保数据库确实处于暂停状态，否则 `v-unsuspend-database` 命令可能不会产生任何效果。
- **系统状态**：检查 Hestia 系统和数据库系统是否正常运行，以避免潜在的问题或错误。
- **演示模式**：如果在演示模式下运行此命令，请注意它可能不会产生任何实际效果。

## v-suspend-database

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-suspend-database)

### 简介

`v-suspend-database` 是 Hestia 提供的一个 CLI 命令，用于暂停指定用户的特定数据库。在某些情况下，为了维护、备份或其他原因，可能需要暂时停止数据库的运行。此时，可以使用此命令来暂停数据库。

### 用法

```bash
v-suspend-database USER DATABASE
```

- **USER**：要暂停数据库的用户的用户名。
- **DATABASE**：要暂停的数据库的名称。

### 示例

#### 示例 1：暂停用户 `admin` 的 `admin_wordpress_db` 数据库

```bash
v-suspend-database admin admin_wordpress_db
```

### 参数验证

- **参数数量**：该命令需要两个参数，即 `USER` 和 `DATABASE`。
- **参数格式**：`USER` 和 `DATABASE` 需要是有效的用户名和数据库名格式。
- **系统状态**：检查数据库系统是否已经启用。
- **用户验证**：验证指定的用户是否存在。
- **数据库验证**：验证指定的数据库是否存在且未被暂停。

### 安全性检查

- **只读模式**：如果 Hestia 处于只读模式（如演示环境），该命令将不会执行任何操作，并返回相应的提示信息。

### 暂停操作

- **数据库类型**：根据数据库的类型（如 MySQL 或 PostgreSQL），调用相应的暂停函数。
- **更新数据库状态**：在数据库中更新该数据库的状态为暂停状态。
- **更新用户统计**：增加指定用户的已暂停数据库计数。

### 日志记录

- **操作日志**：记录一条操作日志，包含暂停数据库的相关信息，如用户名、数据库名和操作时间。
- **事件日志**：记录一条事件日志，用于跟踪和审计。

### 注意事项

- **权限**：在执行此命令之前，请确保您有足够的权限来访问和修改指定用户的数据库。
- **数据库状态**：请确保数据库当前处于正常运行状态，而不是已经暂停或删除状态。
- **系统状态**：检查 Hestia 系统和数据库系统是否正常运行，以避免潜在的问题或错误。
- **演示模式**：如果在演示模式下运行此命令，请注意它可能不会产生任何实际效果。

## v-suspend-database-host

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-suspend-database-host)

### 简介

`v-suspend-database-host` 是 Hestia 提供的一个 CLI 命令，用于暂停指定的数据库服务器。当需要暂时关闭某个数据库服务器以进行维护、升级或其他操作时，可以使用此命令。

### 用法

```bash
v-suspend-database-host TYPE HOST
```

- **TYPE**：数据库类型，如 `mysql`、`pgsql` 等。
- **HOST**：要暂停的数据库服务器的名称或地址。

### 示例

#### 示例 1：暂停名为 `localhost` 的 MySQL 数据库服务器

```bash
v-suspend-database-host mysql localhost
```

### 参数验证

- **参数数量**：该命令需要两个参数，即 `TYPE` 和 `HOST`。
- **参数格式**：`TYPE` 和 `HOST` 需要是有效的数据库类型名和服务器名或地址。
- **系统状态**：检查数据库系统是否已经启用。
- **服务器验证**：验证指定的服务器是否存在且未被暂停。

### 安全性检查

- **只读模式**：如果 Hestia 处于只读模式（如演示环境），该命令将不会执行任何操作，并返回相应的提示信息。

### 暂停操作

- **更新服务器状态**：在配置文件中更新指定数据库服务器的状态为暂停状态。

### 日志记录

- **事件日志**：记录一条事件日志，包含操作成功的信息以及使用的参数。

### 注意事项

- **权限**：在执行此命令之前，请确保您有足够的权限来访问和修改 Hestia 的配置文件以及相关的数据库服务器。
- **服务器状态**：请确保指定的服务器当前处于正常运行状态，而不是已经暂停或删除状态。
- **系统状态**：检查 Hestia 系统和数据库系统是否正常运行，以避免潜在的问题或错误。
- **演示模式**：如果在演示模式下运行此命令，请注意它可能不会产生任何实际效果。

## v-suspend-databases

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-suspend-databases)

### 简介

`v-suspend-databases` 是 Hestia 提供的一个 CLI 命令，用于暂停单个用户下的所有数据库。当需要临时关闭某个用户的所有数据库以进行维护、升级或其他操作时，可以使用此命令。

### 用法

```bash
v-suspend-databases USER
```

- **USER**：要暂停其所有数据库的用户名。

### 示例

#### 示例 1：暂停用户 `admin` 下的所有数据库

```bash
v-suspend-databases admin
```

### 参数验证

- **参数数量**：该命令需要一个参数，即 `USER`。
- **参数格式**：`USER` 需要是有效的用户名。
- **系统状态**：检查数据库系统是否已经启用。
- **用户验证**：验证指定的用户是否存在。

### 安全性检查

- **只读模式**：如果 Hestia 处于只读模式（如演示环境），该命令将不会执行任何操作，并返回相应的提示信息。

### 暂停操作

- **遍历数据库**：该命令会遍历所有未暂停的数据库，并对每个数据库执行暂停操作。
- **单个数据库暂停**：使用 `v-suspend-database` 命令来暂停每个数据库，并传入用户名和数据库名作为参数。

### 日志记录

- **事件日志**：记录一条事件日志，包含操作成功的信息以及使用的参数。

### 注意事项

- **权限**：在执行此命令之前，请确保您有足够的权限来访问和修改 Hestia 的配置文件以及相关的数据库。
- **用户状态**：请确保指定的用户存在，并且其下有数据库可以暂停。
- **系统状态**：检查 Hestia 系统和数据库系统是否正常运行，以避免潜在的问题或错误。
- **演示模式**：如果在演示模式下运行此命令，请注意它可能不会产生任何实际效果。

## v-rebuild-database

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-rebuild-database)

### 简介

`v-rebuild-database` 是 Hestia 提供的一个 CLI 命令，用于重建特定用户的特定数据库。这通常在数据库出现错误或需要重置为初始状态时使用。该命令会根据数据库的类型（如 MySQL 或 PostgreSQL）调用相应的重建函数。

### 用法

```bash
v-rebuild-database USER DATABASE
```

- **USER**：数据库所属的用户名。
- **DATABASE**：要重建的数据库名。

### 示例

#### 示例 1：重建用户 `admin` 下的 `mydb` 数据库

```bash
v-rebuild-database admin mydb
```

### 参数验证

- **参数数量**：该命令需要两个参数，即 `USER` 和 `DATABASE`。
- **参数格式**：`USER` 和 `DATABASE` 需要是有效的用户名和数据库名。
- **系统状态**：检查数据库系统是否已经启用。
- **用户验证**：验证指定的用户是否存在。
- **数据库验证**：验证指定的数据库是否属于该用户。

### 安全性检查

- **只读模式**：如果 Hestia 处于只读模式（如演示环境），该命令将不会执行任何操作，并返回相应的提示信息。

### 重建操作

- **获取数据库值**：通过调用 `get_database_values` 函数来获取数据库的相关信息。
- **根据数据库类型执行重建**：根据数据库类型（MySQL 或 PostgreSQL），调用相应的重建函数（`rebuild_mysql_database` 或 `rebuild_pgsql_database`）。

### 更新用户值

- **更新用户统计信息**：根据重建结果，更新用户的数据库数量、磁盘使用量等统计信息。
- **更新暂停状态**：如果数据库之前处于暂停状态，更新用户的暂停数据库数量。

### 日志记录

- **系统日志**：记录一条系统日志，包含重建数据库的信息（如用户、数据库名）。
- **事件日志**：记录一条事件日志，表示操作已成功执行，并包含相关参数。

### 注意事项

- **权限**：在执行此命令之前，请确保您有足够的权限来访问和修改 Hestia 的配置文件以及相关的数据库。
- **数据库状态**：在执行重建操作之前，请确保数据库处于可重建的状态，并且您已经备份了重要的数据。
- **系统状态**：检查 Hestia 系统和数据库系统是否正常运行，以避免潜在的问题或错误。
- **演示模式**：如果在演示模式下运行此命令，请注意它可能不会产生任何实际效果。

## v-rebuild-databases

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-rebuild-databases)

### 简介

`v-rebuild-database` 是 Hestia 提供的一个 CLI 命令，用于重建特定用户的特定数据库。这通常在数据库出现错误或需要重置为初始状态时使用。该命令会根据数据库的类型（如 MySQL 或 PostgreSQL）调用相应的重建函数。

### 用法

```bash
v-rebuild-database USER DATABASE
```

- **USER**：数据库所属的用户名。
- **DATABASE**：要重建的数据库名。

### 示例

#### 示例 1：重建用户 `admin` 下的 `mydb` 数据库

```bash
v-rebuild-database admin mydb
```

### 参数验证

- **参数数量**：该命令需要两个参数，即 `USER` 和 `DATABASE`。
- **参数格式**：`USER` 和 `DATABASE` 需要是有效的用户名和数据库名。
- **系统状态**：检查数据库系统是否已经启用。
- **用户验证**：验证指定的用户是否存在。
- **数据库验证**：验证指定的数据库是否属于该用户。

### 安全性检查

- **只读模式**：如果 Hestia 处于只读模式（如演示环境），该命令将不会执行任何操作，并返回相应的提示信息。

### 重建操作

- **获取数据库值**：通过调用 `get_database_values` 函数来获取数据库的相关信息。
- **根据数据库类型执行重建**：根据数据库类型（MySQL 或 PostgreSQL），调用相应的重建函数（`rebuild_mysql_database` 或 `rebuild_pgsql_database`）。

### 更新用户值

- **更新用户统计信息**：根据重建结果，更新用户的数据库数量、磁盘使用量等统计信息。
- **更新暂停状态**：如果数据库之前处于暂停状态，更新用户的暂停数据库数量。

### 日志记录

- **系统日志**：记录一条系统日志，包含重建数据库的信息（如用户、数据库名）。
- **事件日志**：记录一条事件日志，表示操作已成功执行，并包含相关参数。

### 注意事项

- **权限**：在执行此命令之前，请确保您有足够的权限来访问和修改 Hestia 的配置文件以及相关的数据库。
- **数据库状态**：在执行重建操作之前，请确保数据库处于可重建的状态，并且您已经备份了重要的数据。
- **系统状态**：检查 Hestia 系统和数据库系统是否正常运行，以避免潜在的问题或错误。
- **演示模式**：如果在演示模式下运行此命令，请注意它可能不会产生任何实际效果。

## v-list-sys-mysql-config

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-mysql-config)

### 简介

`v-list-sys-mysql-config` 是 Hestia 提供的一个 CLI 命令，用于列出 MySQL 服务器系统配置文件（通常是 `my.cnf`）中的关键配置参数。这些参数可能包括最大用户连接数、最大连接数、等待超时、交互超时、最大允许数据包大小等。此命令支持多种输出格式，包括 JSON、纯文本、CSV 和 Shell 格式。

### 用法

```bash
v-list-sys-mysql-config [FORMAT]
```

- **FORMAT**（可选）：指定输出格式。默认为 "shell"。可选值包括 "json"、"plain"、"csv" 和 "shell"。

### 示例

#### 示例 1：默认 Shell 格式输出

```bash
v-list-sys-mysql-config
```

输出可能类似于：

```bash
max_user_connections 100
max_connections      1000
wait_timeout         28800
interactive_timeout  28800
max_allowed_packet   16777216
config_path          /etc/mysql/my.cnf
```

#### 示例 2：JSON 格式输出

```bash
v-list-sys-mysql-config json
```

输出可能类似于：

```json
{
    "CONFIG": {
        "max_user_connections": "100",
        "max_connections": "1000",
        "wait_timeout": "28800",
        "interactive_timeout": "28800",
        "max_allowed_packet": "16777216",
        "config_path": "/etc/mysql/my.cnf"
    }
}
```

#### 示例 3：CSV 格式输出

```bash
v-list-sys-mysql-config csv
```

输出可能类似于：

```bash
max_user_connections,max_connections,wait_timeout,interactive_timeout,max_allowed_packet
100,1000,28800,28800,16777216
```

### 细节分析

- 命令脚本首先定义了多种输出格式的处理函数，包括 `json_list`、`shell_list`、`plain_list` 和 `csv_list`。
- `source` 语句用于加载 Hestia 的配置文件和函数库。
- `config_path` 变量通过 `find` 命令找到系统上的 `my.cnf` 配置文件路径。
- `keys` 变量定义了要从配置文件中提取的关键参数。
- `config` 变量存储了从 `my.cnf` 配置文件中读取的内容（排除了以分号开头的注释行）。
- 根据传入的 `format` 参数，调用相应的处理函数来格式化输出。
- 默认情况下，如果没有提供 `format` 参数，则使用 "shell" 格式输出。

### 注意事项

- 在运行此命令之前，请确保您有足够的权限来读取 `/etc/my*` 目录下的 `my.cnf` 配置文件。
- 如果您的系统上 `my.cnf` 配置文件的路径不是 `/etc/my*` 下的标准位置，您可能需要修改 `config_path` 的查找逻辑。
- 如果配置文件中有特殊的格式或结构，可能需要调整 `egrep` 表达式来正确提取参数。
- 在使用 CSV 格式时，请注意特殊字符（如逗号、引号等）可能导致输出格式错误，特别是在参数值中包含这些字符时。如果需要处理这种情况，可能需要更复杂的解析逻辑。

## v-list-sys-db-status

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-db-status)

### 简介

`v-list-sys-db-status` 是 Hestia 提供的一个 CLI 命令，用于检查并显示配置在 Hestia 系统中的数据库（如 MySQL 和 PostgreSQL）的状态和进程列表。此命令会读取 Hestia 配置文件，并根据配置的数据库类型和主机信息来执行相应的检查。

### 用法

```bash
v-list-sys-db-status
```

该命令不需要任何参数，它会自动读取 Hestia 的配置并显示每个数据库的状态和进程列表。

### 示例

#### 示例 1：检查 MySQL 数据库状态

假设 Hestia 配置文件中包含以下 MySQL 数据库配置：

```bash
DB_SYSTEM="mysql"
```

以及对应的 `mysql.conf` 配置文件内容如下：

```bash
HOST=localhost
USER=root
PASSWORD=secret
```

运行 `v-list-sys-db-status` 命令后，你将看到类似以下的输出：

```bash
MySQL localhost status
Uptime: 1234567 Secs
Threads: 5  Questions: 1234567  Slow queries: 0  Opens: 123  Flush tables: 1  Open tables: 23  Queries per second avg: 0.12

+----+------+-----------------+------+---------+------+----------+------------------+
| Id | User | Host            | db   | Command | Time | State    | Info             |
+----+------+-----------------+------+---------+------+----------+------------------+
|  1 | root | localhost:55555 | NULL | Sleep   |   10 |          | NULL             |
|  2 | root | localhost       | NULL | Query   |    0 | System   | SHOW PROCESSLIST |
+----+------+-----------------+------+---------+------+----------+------------------+

---------------------------------------------
---------------------------------------------
```

#### 示例 2：检查多个数据库状态

如果 Hestia 配置文件中同时配置了 MySQL 和 PostgreSQL 数据库，例如：

```bash
DB_SYSTEM="mysql,pgsql"
```

并且相应的配置文件也正确设置，那么运行 `v-list-sys-db-status` 命令后，将分别显示 MySQL 和 PostgreSQL 数据库的状态和进程列表。

### 细节分析

- 脚本首先通过 `source` 语句加载 Hestia 的配置文件和函数库。
- 检查 `$DB_SYSTEM` 变量是否已设置，如果未设置则直接退出脚本。
- 遍历 `$DB_SYSTEM` 变量中定义的每个数据库系统（如 mysql, pgsql）。
- 对于每个数据库系统，脚本会检查对应的配置文件是否存在，并读取其中的主机、用户名和密码信息。
- 对于 MySQL 数据库，脚本会创建一个临时的配置文件 `.mysql.$HOST`，用于 `mysqladmin` 命令的连接。如果密码不匹配，则会更新配置文件。
- 使用 `mysqladmin` 命令检查 MySQL 数据库的状态和进程列表，并通过 `sed` 命令对输出进行格式化。
- 对于 PostgreSQL 数据库，脚本会检查 `psql` 命令是否存在，并使用环境变量 `PGPASSWORD` 设置密码，然后执行 `psql` 命令来检查数据库的状态和进程列表。
- 脚本在每次检查完一个数据库后，会输出一条分隔线以区分不同的数据库状态信息。

### 注意事项

- 确保 Hestia 的配置文件和数据库配置文件正确无误，并且数据库服务正在运行。
- 对于 MySQL 数据库，需要确保 `mysqladmin` 命令可用，并且具有足够的权限来执行状态检查和进程列表查询。
- 对于 PostgreSQL 数据库，需要确保 `psql` 命令可用，并且环境变量 `PGPASSWORD` 设置正确。
- 脚本中使用了临时配置文件 `.mysql.$HOST` 来存储 MySQL 连接信息，这可能会影响系统的安全性。请确保只有必要的用户和进程可以访问该文件，并在不再需要时删除它。

## v-list-database

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-database)

### 简介

`v-list-database` 是 Hestia 提供的一个 CLI 命令，用于检索并列出指定数据库用户的特定数据库的信息。此命令允许用户以不同的格式（如 JSON、Shell、Plain 或 CSV）获取数据库详情，包括数据库名称、用户、主机、类型、字符集、磁盘使用情况、是否已暂停、时间戳等信息。

### 用法

```bash
v-list-database USER DATABASE [FORMAT]
```

- `USER`：数据库用户名。
- `DATABASE`：要检索的数据库名称。
- `FORMAT`（可选）：指定输出格式，可以是 `json`、`shell`、`plain` 或 `csv`。默认值为 `shell`。

### 示例

#### 示例 1：使用默认 Shell 格式列出数据库信息

```bash
v-list-database myuser mydatabase
```

输出示例：

```bash
DATABASE:       mydatabase
DB USER:        myuser
HOST:           localhost
TYPE:           mysql
CHARSET:        utf8mb4
DISK:           10GB
SUSPENDED:      no
TIME:           2023-03-28 12:34:56
DATE:           2023-03-28
```

#### 示例 2：以 JSON 格式列出数据库信息

```bash
v-list-database myuser mydatabase json
```

输出示例：

```json
{
    "mydatabase": {
        "DATABASE": "mydatabase",
        "DBUSER": "myuser",
        "HOST": "localhost",
        "TYPE": "mysql",
        "CHARSET": "utf8mb4",
        "U_DISK": "10GB",
        "SUSPENDED": "no",
        "TIME": "2023-03-28 12:34:56",
        "DATE": "2023-03-28"
    }
}
```

#### 示例 3：以 CSV 格式列出多个数据库信息

假设你想列出 `myuser` 下的所有数据库信息，并且你有一个包含这些数据库名称的列表文件 `databases.txt`。你可以使用循环和重定向来实现这一点：

```bash
while IFS= read -r db; do
    v-list-database myuser "$db" csv
done < databases.txt > output.csv
```

output.csv` 文件将包含以 CSV 格式列出的所有数据库信息。

### 细节分析

- 脚本首先定义了一个函数 `json_list`、`shell_list`、`plain_list` 和 `csv_list`，用于根据指定的格式格式化输出。
- 脚本通过 `source` 语句加载 Hestia 的配置文件和函数库。
- 脚本使用 `check_args` 和 `is_format_valid` 函数来验证输入参数和格式的有效性。
- 使用 `is_object_valid` 函数验证数据库用户和用户数据库是否存在。
- 脚本通过 `grep` 命令在 `db.conf` 配置文件中查找与指定数据库名称匹配的条目，并使用 `parse_object_kv_list` 函数解析配置信息。
- 根据用户指定的格式，脚本调用相应的函数来格式化输出。

### 注意事项

- 确保 Hestia 的配置文件和数据库配置文件正确无误，并且数据库服务正在运行。
- 在使用脚本时，确保提供了正确的数据库用户名和数据库名称作为参数。
- 根据需要选择适当的输出格式，以便更容易地解析和使用脚本的输出。
- 脚本中的 `db.conf` 文件路径（`$USER_DATA/db.conf`）可能需要根据你的 Hestia 安装进行调整。
- 如果脚本在执行时出现错误，请检查输入参数和 Hestia 配置是否正确。

## v-list-database-host

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-database-host)

### 概述

`v-list-database-host` 是 Hestia 提供的 CLI 命令之一，用于获取数据库主机参数。通过该命令，用户可以轻松地查询指定类型和主机的数据库配置信息。

### 使用方法

```bash
v-list-database-host TYPE HOST [FORMAT]
```

- `TYPE`：数据库类型，如 mysql、postgresql 等。
- `HOST`：要查询的数据库主机名或 IP 地址。
- `FORMAT`（可选）：输出格式，支持 shell、json、plain 等格式，默认为 shell 格式。

### 示例

#### 示例 1：使用默认 shell 格式查询 MySQL 数据库主机参数

```bash
v-list-database-host mysql localhost
```

输出示例：

```bash
HOST: localhost
PORT: 3306
TYPE: mysql
CHARSETS: utf8mb4
MAX_DB: 100
U_SYS_USERS: 5
U_DB_BASES: 20
TPL: default
SUSPENDED: false
TIME: 2023-10-23 10:00:00
DATE: 2023-10-23
```

#### 示例 2：使用 JSON 格式查询 PostgreSQL 数据库主机参数

```bash
v-list-database-host postgresql 192.168.1.100 json
```

输出示例：

```json
{
  "192.168.1.100": {
    "HOST": "192.168.1.100",
    "PORT": "5432",
    "TYPE": "postgresql",
    "CHARSETS": "UTF8",
    "MAX_DB": "200",
    "U_SYS_USERS": "10",
    "U_DB_BASES": "50",
    "TPL": "custom",
    "SUSPENDED": "false",
    "TIME": "2023-10-23 10:30:00",
    "DATE": "2023-10-23"
  }
}
```

#### 示例 3：使用 plain 格式查询 SQLite 数据库主机参数（SQLite 通常没有主机和端口，但为了演示格式，这里假设有一个标识）

```bash
v-list-database-host sqlite /path/to/database.db plain
```

输出示例：

```plain
/path/to/database.db    (无端口)    sqlite    UTF8    (无最大数据库数)    (无系统用户数)    (无数据库基数)    default    false    2023-10-23 11:00:00    2023-10-23
```

### 注意事项

- 请确保已正确安装并配置了 Hestia 系统。
- 在使用命令时，请根据实际情况替换 `TYPE` 和 `HOST` 参数的值。
- 对于 SQLite 这类没有传统意义上的“主机”和“端口”的数据库，可以使用任意字符串作为占位符，或根据实际需要调整输出格式。
- 如有任何疑问或遇到问题，请查阅 Hestia 的官方文档或联系技术支持获取帮助。

## v-list-database-hosts

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-database-hosts)

### 概述

`v-list-database-hosts` 是 Hestia 提供的一个命令行界面（CLI）工具，用于获取所有已配置的数据库主机列表。该命令支持不同的输出格式，以满足不同用户的需求。

### 使用方法

基本语法：

```bash
v-list-database-hosts [FORMAT]
```

其中，`[FORMAT]` 是可选参数，用于指定输出格式。如果不指定格式，则默认为 shell 格式。

### 参数说明

* `[FORMAT]`：指定输出格式。支持的格式包括 `shell`、`json` 等。如果不指定该参数，则默认为 `shell` 格式。

### 示例

#### 示例 1：默认输出格式（shell）

```bash
v-list-database-hosts
```

输出示例（shell 格式）：

```bash
HOST=db1.example.com PORT=3306 TYPE=mysql
HOST=db2.example.com PORT=5432 TYPE=postgresql
```

#### 示例 2：JSON 格式输出

```bash
v-list-database-hosts json
```

输出示例（JSON 格式）：

```json
[
  {
    "HOST": "db1.example.com",
    "PORT": "3306",
    "TYPE": "mysql"
  },
  {
    "HOST": "db2.example.com",
    "PORT": "5432",
    "TYPE": "postgresql"
  }
]
```

#### 示例 3：结合其他命令使用

你可以将 `v-list-database-hosts` 命令的输出与其他命令结合使用，以实现更复杂的操作。例如，你可以使用 `jq` 工具来解析 JSON 格式的输出。

```bash
v-list-database-hosts json | jq '.[] | select(.TYPE=="mysql") | .HOST'
```

上述命令将只输出类型为 MySQL 的数据库主机名。

### 注意事项

* 请确保你已经正确安装了 Hestia 并配置了相关设置。
* 如果在执行命令时遇到问题，请检查你的 Hestia 版本和配置文件是否正确。
* 如果你需要更详细的信息或帮助，请查阅 Hestia 的官方文档或联系支持团队。

### 总结

`v-list-database-hosts` 命令是 Hestia 提供的一个强大的工具，用于获取所有已配置的数据库主机列表。通过指定不同的输出格式，你可以轻松地将其与其他命令或工具结合使用，以实现更复杂的操作。希望本文档能够帮助你更好地理解和使用该命令。

## v-list-databases

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-databases)

### 概述

`v-list-databases` 是 Hestia 提供的一个 CLI（命令行接口）命令，用于获取指定用户的所有数据库列表。此命令支持多种输出格式，并提供了灵活的使用选项。

### 使用方法

基本语法：

```bash
v-list-databases USER [FORMAT]
```

- `USER`：指定要查询其数据库列表的用户名。
- `FORMAT`（可选）：指定输出格式，支持 `json`、`shell` 等格式。如果不指定，则默认为 `shell` 格式。

### 示例

#### 示例 1：以 shell 格式列出用户 `john` 的数据库

```bash
v-list-databases john
```

输出可能类似于：

```bash
DATABASE   USER   HOST   TYPE   DISK   SPND   DATE
---------- -----  ----   ----   ----   ----   ----------
db1        john   local  mysql  10G    no     2023-04-01
db2        john   local  mysql  20G    no     2023-04-02
...
```

#### 示例 2：以 JSON 格式列出用户 `jane` 的数据库

```bash
v-list-databases jane json
```

输出可能类似于：

```json
{
  "db1": {
    "DATABASE": "db1",
    "DBUSER": "jane",
    "HOST": "local",
    "TYPE": "mysql",
    "CHARSET": "utf8mb4",
    "U_DISK": "10G",
    "SUSPENDED": "no",
    "TIME": "some_timestamp",
    "DATE": "2023-04-01"
  },
  "db2": {
    "DATABASE": "db2",
    "DBUSER": "jane",
    "HOST": "local",
    "TYPE": "mysql",
    "CHARSET": "utf8mb4",
    "U_DISK": "20G",
    "SUSPENDED": "no",
    "TIME": "some_other_timestamp",
    "DATE": "2023-04-02"
  },
  ...
}
```

### 注意事项

- 在使用此命令时，请确保您有足够的权限来访问和列出指定用户的数据库。
- 如果指定的用户不存在或没有数据库，命令可能会返回空结果或错误消息。
- 不同的输出格式可能会包含不同的字段和详细程度。请根据您的需求选择合适的输出格式。

### 总结

`v-list-databases` 是 Hestia 提供的一个强大而灵活的 CLI 命令，它允许您轻松地获取指定用户的所有数据库列表。通过指定不同的用户和输出格式，您可以根据需要自定义命令的输出。

## v-add-database-temp-user

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-database-temp-user)

在 HestiaCP（一个开源的Web托管控制面板）中，`v-add-database-temp-user` 命令用于为特定数据库添加临时用户。此命令在需要为开发人员、测试人员或其他临时用户提供数据库访问权限时非常有用。

### 命令格式

```bash
v-add-database-temp-user <DATABASE_NAME> <USERNAME> <PASSWORD> [OPTIONS]
```

- `<DATABASE_NAME>`: 需要添加临时用户的数据库名称。
- `<USERNAME>`: 临时用户的用户名。
- `<PASSWORD>`: 临时用户的密码。
- `[OPTIONS]`: 可选参数，用于进一步定制用户权限或设置。

### 示例

#### 示例1：为 `example_db` 数据库添加临时用户 `temp_user`

```bash
v-add-database-temp-user example_db temp_user MyTemporaryPassword
```

在这个例子中，我们为 `example_db` 数据库添加了一个名为 `temp_user` 的临时用户，并设置了密码为 `MyTemporaryPassword`。

#### 示例2：为 `dev_db` 数据库添加具有特定过期时间的临时用户

HestiaCP 的 `v-add-database-temp-user` 命令可能支持为临时用户设置过期时间（具体取决于版本和配置）。如果支持，您可以使用类似以下的命令：

```bash
v-add-database-temp-user dev_db dev_temp_user DevPassword --expire-in 24h
```

在这个例子中，我们为 `dev_db` 数据库添加了一个名为 `dev_temp_user` 的临时用户，密码为 `DevPassword`，并设置了过期时间为24小时。

### 注意事项

1. **安全性**：请确保您为临时用户分配了适当的权限，并在不再需要时及时删除他们。
2. **密码复杂性**：使用强密码，并定期更换临时用户的密码。
3. **记录**：记录所有临时用户的创建和删除，以便跟踪和审计。
4. **版本兼容性**：不同的 HestiaCP 版本可能具有不同的命令选项和功能。请查阅您正在使用的版本的官方文档以获取详细信息。
5. **备份**：在执行任何可能更改数据库结构的操作之前，请确保已备份您的数据库。

## v-delete-database-host

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-database-host)

### 概述

`v-delete-database-host` 是 Hestia 提供的一个命令行工具，用于从 Hestia 配置中删除指定的数据库主机。该命令仅在没有任何数据库在该主机上创建时才会删除主机配置。

### 使用方法

```bash
v-delete-database-host TYPE HOST
```

* `TYPE`: 数据库类型，如 `pgsql`、`mysql` 等。
* `HOST`: 要删除的数据库主机的主机名或IP地址。

### 示例

#### 示例 1: 删除名为 "localhost" 的 PostgreSQL 数据库主机

```bash
v-delete-database-host pgsql localhost
```

执行上述命令后，如果 "localhost" 上没有创建任何 PostgreSQL 数据库，则相关的 Hestia 配置将被删除。

#### 示例 2: 删除 IP 地址为 "192.168.1.100" 的 MySQL 数据库主机

```bash
v-delete-database-host mysql 192.168.1.100
```

同样地，如果 "192.168.1.100" 上没有创建任何 MySQL 数据库，则相关的 Hestia 配置将被删除。

### 注意事项

* 在执行删除操作之前，请确保目标主机上没有任何重要的数据库或配置，因为一旦删除，这些数据将无法恢复。
* 如果目标主机上仍有数据库存在，`v-delete-database-host` 命令将不会执行删除操作，并可能给出相应的错误提示。
* 在使用此命令之前，请务必备份相关的 Hestia 配置和数据库数据，以防止意外情况发生。

### 日志记录

当成功删除远程数据库主机时，Hestia 会记录一条日志信息，例如：

```bash
Removed remote database host (Host: localhost, Type: pgsql).
```

这条日志信息将被记录在 Hestia 的日志文件中，以供管理员查看和审计。

### 总结

`v-delete-database-host` 命令是 Hestia 提供的一个实用工具，用于从 Hestia 配置中删除指定的数据库主机。通过提供数据库类型和主机名或IP地址作为参数，管理员可以轻松地删除不再需要的数据库主机配置。在执行删除操作之前，请确保备份相关的配置和数据，并谨慎操作以避免不必要的损失。

## v-add-database

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-database)

### 简介

`v-add-database` 是 Hestia 提供的一个命令行接口（CLI）命令，用于在 Hestia 管理的系统中添加新的数据库。该命令允许用户通过简单的参数指定来创建数据库，并自动处理与数据库用户、权限等相关的设置。

### 语法

```bash
v-add-database USER DATABASE DBUSER DBPASS [TYPE] [HOST] [CHARSET]
```

### 参数说明

* `USER`: 必需的参数，表示创建数据库的用户名（通常与 Hestia 系统用户关联）。
* `DATABASE`: 必需的参数，表示要创建的数据库名称。
* `DBUSER`: 必需的参数，表示用于访问该数据库的用户名。
* `DBPASS`: 必需的参数，表示用于访问该数据库的密码。
* `TYPE`: 可选参数，表示数据库类型（如 mysql、pgsql 等）。默认为 mysql。
* `HOST`: 可选参数，表示数据库主机。如果未指定，系统将根据配置自动选择。
* `CHARSET`: 可选参数，表示数据库字符集。默认为 UTF8MB4。

### 示例

#### 示例 1: 添加 MySQL 数据库

假设我们有一个名为 `admin` 的 Hestia 系统用户，想要为其添加一个名为 `wordpress_db` 的 MySQL 数据库，并使用用户名 `matt` 和密码 `qwerty123` 进行访问：

```bash
v-add-database admin wordpress_db matt qwerty123
```

#### 示例 2: 添加 PostgreSQL 数据库并指定字符集

假设我们想要添加一个名为 `ecommerce_db` 的 PostgreSQL 数据库，并使用用户名 `john` 和密码 `secret123` 进行访问，同时指定字符集为 `LATIN1`：

```bash
v-add-database admin ecommerce_db john secret123 pgsql localhost LATIN1
```

在上面的示例中，我们指定了数据库类型为 `pgsql`，主机为 `localhost`，并设置了字符集为 `LATIN1`。

#### 示例 3: 省略可选参数

如果某些可选参数未指定，系统将使用默认值。例如，以下命令将使用默认的数据库类型（mysql）和字符集（UTF8MB4）：

```bash
v-add-database admin blog_db alice mypassword
```

### 注意事项

* 在使用 `v-add-database` 命令之前，请确保已正确配置 Hestia 系统并具有足够的权限。
* 请谨慎选择数据库名称、用户名和密码，以确保系统的安全性和可维护性。
* 如果在添加数据库时遇到问题，请检查 Hestia 的日志文件以获取更多信息。
* 您可以使用[v-list-sys-config](server.html#v-list-sys-config) 脚本获取支持的数据库类型。

## v-add-database-host

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-database-host)

### 命令简介

`v-add-database-host` 是 Hestia 提供的 CLI 命令之一，用于向服务器池中添加新的数据库服务器。此命令支持本地和远程数据库服务器，对于构建数据库集群特别有用。通过添加主机，您可以设置该主机上的数据库数量限制。

### 语法

```bash
v-add-database-host TYPE HOST DBUSER DBPASS [MAX_DB] [CHARSETS] [TEMPLATE] [PORT]
```

### 参数说明

* `TYPE`: 数据库类型（如 `mysql`、`postgresql` 等）。
* `HOST`: 数据库服务器的主机名或 IP 地址。
* `DBUSER`: 用于连接数据库的用户名。
* `DBPASS`: 数据库的密码。
* `[MAX_DB]`: （可选）该主机上允许的最大数据库数量，默认为 500。
* `[CHARSETS]`: （可选）数据库的字符集设置。
* `[TEMPLATE]`: （可选）仅对 PostgreSQL 有效，用于指定数据库模板，默认为 "template1"。
* `[PORT]`: （可选）数据库服务器的端口号，默认为数据库类型的默认端口。

### 示例

#### 示例 1: 添加本地 MySQL 数据库服务器

```bash
v-add-database-host mysql localhost root my_secure_password
```

#### 示例 2: 添加远程 PostgreSQL 数据库服务器，并指定最大数据库数量

```bash
v-add-database-host postgresql remote_host.example.com postgres my_other_secure_password 1000
```

#### 示例 3: 使用所有可选参数添加 MySQL 数据库服务器

```bash
v-add-database-host mysql another_host.example.com db_user another_password 200 utf8mb4 template1 3307
```

### 注意事项

* 使用此命令时，请确保提供的数据库凭据正确且有效。
* 如果指定了最大数据库数量（`MAX_DB`），则当达到该限制时，将无法在该主机上创建更多数据库。
* 对于 PostgreSQL，模板参数（`TEMPLATE`）用于指定创建新数据库时使用的模板。确保该模板在数据库服务器上可用。

### 输出与日志

成功执行命令后，Hestia 将更新其配置以包含新添加的数据库服务器，并在系统日志中记录相关操作。如果遇到任何错误或问题，将显示错误消息，并在日志中记录详细信息。

### 总结

`v-add-database-host` 命令是 Hestia 提供的一个强大工具，用于轻松地向服务器池中添加新的数据库服务器。通过此命令，您可以灵活地扩展和管理您的数据库环境。

## v-list-sys-pgsql-config

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-pgsql-config)

### 简介

`v-list-sys-pgsql-config` 是 Hestia 提供的 CLI 命令，用于列出 PostgreSQL 数据库的配置参数。该命令允许用户快速查看和管理 PostgreSQL 的配置文件，从而优化数据库性能或进行故障排除。

### 使用方法

#### 语法

```bash
v-list-sys-pgsql-config [FORMAT]
```

* `[FORMAT]`：可选参数，指定输出格式。默认为 shell 格式。支持其他格式，如 json、plain、csv 等。

#### 示例

1. **默认输出（shell 格式）**

```bash
v-list-sys-pgsql-config
```

输出可能类似于：

```bash
config_path: /etc/postgresql/12/main/postgresql.conf
pg_hba_path: /etc/postgresql/12/main/pg_hba.conf
```

2. **JSON 格式输出**

```bash
v-list-sys-pgsql-config json
```

输出可能类似于：

```json
{
  "CONFIG": {
    "pg_hba_path": "/etc/postgresql/12/main/pg_hba.conf",
    "config_path": "/etc/postgresql/12/main/postgresql.conf"
  }
}
```

3. **Plain 格式输出**

```bash
v-list-sys-pgsql-config plain
```

输出可能类似于：

```plain
/etc/postgresql/12/main/postgresql.conf
/etc/postgresql/12/main/pg_hba.conf
```

4. **CSV 格式输出**

```bash
v-list-sys-pgsql-config csv
```

输出可能类似于：

```csv
config_path,pg_hba_path
/etc/postgresql/12/main/postgresql.conf,/etc/postgresql/12/main/pg_hba.conf
```

### 注意事项

* 该命令依赖于系统上已安装的 PostgreSQL 版本和配置文件的路径。
* 如果系统上存在多个 PostgreSQL 实例或版本，该命令可能会列出所有相关的配置文件路径。
* 输出格式可能因 Hestia 版本或系统环境的不同而略有差异。

### 结论

`v-list-sys-pgsql-config` 命令为 Hestia 用户提供了一个方便的工具，用于列出和管理 PostgreSQL 的配置文件参数。通过选择不同的输出格式，用户可以根据需要轻松地将信息集成到脚本、文档或分析工具中。
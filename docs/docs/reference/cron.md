# 定时任务系列命令介绍

## v-add-cron-hestia-autoupdate

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-cron-hestia-autoupdate)

`v-add-cron-hestia-autoupdate` 是一个由 Hestia 提供的 CLI 命令，用于自动添加用于系统更新的 cron 任务。这个命令可以设置为使用 APT 或 Git 进行更新。

### 使用方法

```bash
v-add-cron-hestia-autoupdate [MODE]
```

- `MODE`: 可选参数，用于指定更新的类型。可以是 `apt`（默认值）或 `git`。如果不提供该参数，则默认使用 APT 进行更新。

### 示例

#### 示例 1：使用默认设置（APT 更新）

```bash
v-add-cron-hestia-autoupdate
```

这个命令将添加一个 cron 任务，该任务将在某个随机选择的夜间时间（分钟和小时）运行 `v-update-sys-hestia-all` 命令来执行 APT 更新。

#### 示例 2：使用 Git 更新

```bash
v-add-cron-hestia-autoupdate git
```

这个命令将添加一个 cron 任务，该任务将在每天的午夜（00:00）运行 `v-update-sys-hestia-git` 命令来执行 Git 更新。

### 注意事项

- 如果已经存在 `v-update-sys-hestia-all` 或 `v-update-sys-hestia-git` 的 cron 任务，则此命令不会执行任何操作。
- 命令执行前会检查 Hestia 的只读模式（demo mode），如果处于只读模式，则命令将不执行任何操作。
- 添加 cron 任务后，会尝试重启 cron 服务来应用更改。
- 命令执行的结果（包括 cron 重启的结果）将被记录到日志中。
- `generate_password` 函数用于生成随机的分钟和小时值，以确保 cron 任务在夜间的某个随机时间运行。对于 APT 更新，分钟值是从 01 到 59 中随机选择的两个数字，小时值是从 0 到 7 中随机选择的一个数字（代表从午夜到早上 7 点的时间段）。
- 命令中使用了多个 Hestia 提供的函数和工具，如 `source_conf`、`check_hestia_demo_mode`、`v-restart-cron` 和 `v-log-action` 等。这些函数和工具在 Hestia 的脚本和配置文件中定义。
- 使用此命令前，请确保您具有足够的权限来修改 cron 任务和重启 cron 服务。

## v-add-cron-job

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-cron-job)

#### 说明

`v-add-cron-job` 命令用于在 Hestia 系统中为用户添加一个 cron 任务。该命令接受一系列参数，以定义任务的执行时间、要执行的命令以及其它可选参数。

#### 使用方法

```bash
v-add-cron-job USER MIN HOUR DAY MONTH WDAY COMMAND [JOB] [RESTART] [REPORTS]
```

- `USER`: 必填参数，指定要为其添加 cron 任务的用户的用户名。
- `MIN`: 必填参数，cron 任务要运行的分钟数（0-59）。
- `HOUR`: 必填参数，cron 任务要运行的小时数（0-23）。
- `DAY`: 必填参数，cron 任务要运行的日期（1-31，或使用 * 表示每天）。
- `MONTH`: 必填参数，cron 任务要运行的月份（1-12，或使用 * 表示每个月）。
- `WDAY`: 必填参数，cron 任务要运行的星期几（0-7，其中 0 和 7 都表示星期日，或使用 * 表示每星期）。
- `COMMAND`: 必填参数，要执行的命令或脚本。
- `JOB` (可选): 为 cron 任务指定的自定义标识符或名称。如果不提供，将自动生成。
- `RESTART` (可选): 如果设置为 `yes`，则在添加任务后重启 cron 服务。默认为不重启。
- `REPORTS` (可选): 如果设置为 `yes`，则 cron 任务的标准输出和错误输出将通过邮件发送给指定用户。默认为不发送。

#### 示例

1. **为 `admin` 用户添加一个每分钟都执行的备份任务**

```bash
v-add-cron-job admin * * * * * sudo /usr/local/hestia/bin/v-backup-users
```

这个命令将在每分钟为 `admin` 用户执行 `v-backup-users` 脚本。

2. **为 `backupuser` 用户添加一个每日的备份任务，并在添加后重启 cron 服务**

```bash
v-add-cron-job backupuser 0 1 * * * sudo /usr/local/hestia/bin/v-backup-database yes
```

这个命令将在每天的凌晨 1 点为 `backupuser` 用户执行 `v-backup-database` 脚本，并在添加任务后重启 cron 服务。

3. **为 `john` 用户添加一个每周日的备份任务，并设置邮件报告**

```bash
v-add-cron-job john 0 0 * * 0 sudo /usr/local/hestia/bin/v-backup-weekly yes no yes
```

这个命令将在每周日的凌晨 0 点为 `john` 用户执行 `v-backup-weekly` 脚本，并设置任务标识符为 `no`（尽管这通常不是一个好的标识符，这里仅为示例），并且启用邮件报告功能。

#### 注意事项

- 在执行 `v-add-cron-job` 命令之前，请确保您具有足够的权限来修改用户的 cron 任务和重启 cron 服务。
- 邮件报告功能依赖于系统的邮件发送功能，您需要确保系统上已正确配置邮件发送服务器。
- 在添加 cron 任务时，请仔细检查命令和参数，确保它们能够正确执行并符合您的需求。
- 如果您使用自定义的标识符（JOB 参数），请确保它在系统中是唯一的，以避免与现有任务发生冲突。

## v-add-cron-letsencrypt-job

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-cron-letsencrypt-job)

### 说明

`v-add-cron-letsencrypt-job` 是一个用于在 Hestia 系统中为 Let's Encrypt 证书添加 cron 任务的 CLI 命令。该命令确保每5分钟执行一次 `v-update-sys-queue letsencrypt` 命令，以自动更新和续订 Let's Encrypt 证书。

### 使用方法

```bash
v-add-cron-letsencrypt-job
```

此命令不需要任何参数，因为它会自动配置必要的 cron 任务。

### 示例

1. **添加 Let's Encrypt cron 任务**

```bash
v-add-cron-letsencrypt-job
```

执行此命令后，它将检查 `/var/spool/cron/crontabs/hestiaweb` 文件中是否已存在对应的 cron 任务。如果不存在且 `CRON_SYSTEM` 被启用，它将自动添加以下 cron 任务：

```bash
*/5 * * * * sudo /usr/local/hestia/bin/v-update-sys-queue letsencrypt
```

这个 cron 任务将每5分钟执行一次 `v-update-sys-queue letsencrypt` 命令，以确保 Let's Encrypt 证书保持最新状态。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改 cron 任务。
- 如果系统处于只读模式（例如，在演示环境中），则此命令可能无法正常工作。
- 该命令会检查 `CRON_SYSTEM` 是否被启用，如果未启用，则不会添加 cron 任务。
- 该命令会记录一个日志事件，以指示操作是否成功。
- 如果您手动编辑了 `/var/spool/cron/crontabs/hestiaweb` 文件，请确保不要意外删除或修改此 cron 任务。

### 依赖与配置

- 此命令依赖于 `/etc/hestiacp/hestia.conf` 配置文件，该文件应包含正确的 `HESTIA` 变量设置。
- 该命令还依赖于 `/usr/local/hestia/func/main.sh` 和 `/usr/local/hestia/conf/hestia.conf` 文件，这些文件应包含必要的函数和配置。
- 确保系统上的 cron 服务正在运行，以便正确执行 cron 任务。

### 错误处理

- 如果在检查或添加 cron 任务时发生错误，该命令将记录相应的错误事件。
- 如果系统处于只读模式或 `CRON_SYSTEM` 未启用，该命令将不会执行任何操作。

## v-add-cron-reports

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-cron-reports)

### 说明

`v-add-cron-reports` 命令用于在 Hestia 系统中为用户启用 cron 任务的报告和行政通知功能。通过该命令，您可以为指定的用户配置 cron 任务的输出和结果报告，以便更好地跟踪和管理任务执行情况。

### 使用方法

```bash
v-add-cron-reports USER
```

- `USER`: 必填参数，指定要为其启用 cron 报告的用户名。

### 示例

1. **为 admin 用户启用 cron 报告**

```bash
v-add-cron-reports admin
```

执行此命令后，Hestia 系统将为 `admin` 用户启用 cron 任务的报告功能。这意味着，当 `admin` 用户的 cron 任务执行时，其输出和结果将被记录并可能发送通知。

### 验证与检查

- 命令会验证是否提供了正确的参数数量，即必须提供一个用户名。
- 它会检查提供的用户名格式是否有效。
- 系统会检查 `CRON_SYSTEM` 是否启用，以确保 cron 任务可以正常运行。
- 它会验证用户对象是否存在、有效且未被挂起。
- 如果系统处于只读模式（如演示环境），则会进行相应的检查。

### 操作

- 命令会更新指定用户的 `$CRON_REPORTS` 值，将其设置为 `'yes'`，以启用报告功能。
- 系统会同步用户的 cron 任务，确保所有更改都已生效。
- 重启 cron 服务以确保新配置生效。

### 通知与日志

- 如果 cron 重启失败，命令会记录一个错误消息。
- 系统会记录一个操作日志，表明已为用户启用了 cron 任务通知和报告功能。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改用户的 cron 报告设置和重启 cron 服务。
- 启用 cron 报告可能会增加系统的邮件发送量，请确保邮件服务器已正确配置并可以处理额外的邮件负载。
- 如果用户之前已经禁用了 cron 报告，执行此命令将重新启用该功能。

### 依赖与配置

- 该命令依赖于 Hestia 系统的配置文件和函数库，包括 `/etc/hestiacp/hestia.conf` 和 `/usr/local/hestia/func/main.sh`。
- 请确保 `CRON_SYSTEM` 在配置文件中已启用，并且 cron 服务正在运行。
- 用户的 cron 任务和报告设置将存储在 Hestia 系统的用户数据库中。

### 错误处理

- 如果命令执行过程中出现错误，它将通过日志和可能的邮件通知管理员。
- 如果提供的用户名无效或不存在，命令将返回一个错误消息。
- 如果系统处于只读模式或 `CRON_SYSTEM` 未启用，命令将不会执行任何操作并返回相应的错误消息。
通知。

## v-add-cron-restart-job

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-cron-restart-job)

### 说明

`v-add-cron-restart-job` 命令用于在 Hestia 系统中添加或确保存在一个 cron 任务，该任务会定期执行 `v-update-sys-queue restart` 命令以重启系统队列。这有助于在系统负载较高或队列服务出现问题时自动重启队列服务。

### 使用方法

由于此命令没有选项或参数，因此只需直接运行即可：

```bash
v-add-cron-restart-job
```

### 示例

#### 示例 1: 添加或确保 cron 任务存在

直接执行命令，无需任何参数：

```bash
v-add-cron-restart-job
```

如果系统中不存在该 cron 任务，命令将添加一个新的任务到 `/var/spool/cron/crontabs/hestiaweb` 文件中，确保每两小时执行一次 `v-update-sys-queue restart` 命令。

### 验证与检查

- 命令会检查 `$CRON_SYSTEM` 是否已启用，以确保 cron 任务可以被正确执行。
- 如果系统处于只读模式（如演示环境），命令将进行相应的检查。

### 操作

- 命令首先使用 `grep` 查找 `/var/spool/cron/crontabs/hestiaweb` 文件中是否已存在 `v-update-sys-queue restart` 相关的 cron 任务。
- 如果不存在该任务且 `$CRON_SYSTEM` 已启用，则命令会在 crontab 文件中添加一个新的任务，该任务将每两小时执行一次 `v-update-sys-queue restart` 命令。

### 通知与日志

- 命令执行成功后，会记录一条日志事件，表示操作已成功完成。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改系统的 crontab 文件。
- 如果 crontab 文件已存在其他 `v-update-sys-queue restart` 相关的任务，并且这些任务的执行频率与您期望的不同，那么可能需要手动编辑 crontab 文件以确保正确的任务配置。

### 依赖与配置

- 该命令依赖于 Hestia 系统的配置文件和函数库，包括 `/etc/hestiacp/hestia.conf` 和 `/usr/local/hestia/func/main.sh`。
- 请确保 `$CRON_SYSTEM` 在配置文件中已启用，并且 cron 服务正在运行。

### 错误处理

- 如果 `$CRON_SYSTEM` 未启用或系统处于只读模式，命令将不会执行任何操作并可能记录相应的错误或警告信息。
- 如果在尝试修改 crontab 文件时发生错误（例如，文件不可写或权限不足），命令将记录错误并退出。

## v-delete-cron-hestia-autoupdate

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-cron-hestia-autoupdate)

### 说明

`v-delete-cron-hestia-autoupdate` 命令用于删除与 Hestia 自动更新相关的 cron 任务。这些任务可能包括执行 `v-update-sys-hestia-all` 和 `v-update-sys-hestia-git` 命令的 cron 作业，它们用于自动更新 Hestia 系统或其组件。

### 使用方法

由于此命令没有选项或参数，因此只需直接运行即可：

```bash
v-delete-cron-hestia-autoupdate
```

### 示例

#### 示例 1: 删除 Hestia 自动更新 cron 任务

直接执行命令以删除与 Hestia 自动更新相关的 cron 任务：

```bash
v-delete-cron-hestia-autoupdate
```

执行后，命令将搜索 `/var/spool/cron/crontabs/hestiaweb` 文件中的 `v-update-sys-hestia-all` 和 `v-update-sys-hestia-git` 字符串，并删除包含这些字符串的行。之后，命令将尝试重启 cron 服务以确保更改生效。

### 验证与检查

- 命令会检查 `$CRON_SYSTEM` 是否已启用，以确保可以删除和修改 cron 任务。
- 命令还会检查系统是否处于只读模式（如演示环境），以防止不必要的修改。

### 操作

- 使用 `sed` 命令编辑 `/var/spool/cron/crontabs/hestiaweb` 文件，删除包含 `v-update-sys-hestia-all` 和 `v-update-sys-hestia-git` 字符串的行。
- 重启 cron 服务，以确保任何已删除的任务都不会再被执行。

### 通知与日志

- 命令执行成功后，会记录一条警告级别的日志事件，表示自动更新已被禁用。
- 还会记录一条正常的日志事件，表示命令已成功完成。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改系统的 crontab 文件和重启 cron 服务。
- 删除自动更新任务可能会导致系统不再自动接收安全补丁和功能更新。请确保您了解这一潜在影响，并考虑使用其他方法管理系统的更新。

### 依赖与配置

- 该命令依赖于 Hestia 系统的配置文件和函数库，包括 `/etc/hestiacp/hestia.conf` 和 `/usr/local/hestia/func/main.sh`。
- 请确保 `$CRON_SYSTEM` 在配置文件中已启用，并且 cron 服务正在运行。

### 错误处理

- 如果 `$CRON_SYSTEM` 未启用或系统处于只读模式，命令将不会执行任何操作并可能记录相应的错误或警告信息。
- 如果在尝试编辑 crontab 文件或重启 cron 服务时发生错误（例如，文件不可写、权限不足或 cron 服务无法重启），命令将记录错误并退出。

## v-delete-cron-job

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-cron-job)

### 说明

`v-delete-cron-job` 命令用于删除指定的用户 cron 任务。它接受三个参数：用户名（user）、任务标识符（job）以及一个可选的重启标志（restart）。此命令会执行一系列验证，然后删除指定的 cron 任务，并更新相关的系统配置。

### 使用方法

```bash
v-delete-cron-job USER JOB [RESTART]
```

- `USER`：要删除 cron 任务的用户名。
- `JOB`：要删除的 cron 任务的标识符。
- `RESTART`（可选）：一个标志，用于指示是否在删除任务后重启 cron 服务。

### 示例

#### 示例 1: 删除指定用户的 cron 任务

```bash
v-delete-cron-job johnDoe 123
```

此命令将删除名为 `johnDoe` 的用户的标识符为 `123` 的 cron 任务。

#### 示例 2: 删除任务后重启 cron 服务

```bash
v-delete-cron-job janeSmith 456 true
```

此命令将删除名为 `janeSmith` 的用户的标识符为 `456` 的 cron 任务，并在删除后重启 cron 服务。

### 验证与检查

- 命令会检查提供的参数数量是否至少为 2（用户名和任务标识符是必需的）。
- 它会验证用户名和任务标识符的格式是否有效。
- 确保 `$CRON_SYSTEM` 已启用，以便能够修改 cron 任务。
- 检查系统是否处于只读模式（如演示环境），以防止不必要的修改。
- 验证提供的用户名是否有效，并且存在与该用户名关联的任务。
- 验证提供的任务标识符是否对应一个存在的 cron 任务。

### 操作

- 使用 `sed` 命令编辑 `$USER_DATA/cron.conf` 文件，删除包含指定任务标识符的行。
- 对用户的 cron 任务按 ID 进行排序。
- 同步系统 cron 配置与用户 cron 配置。
- 减少用户的 `$U_CRON_JOBS` 值，以反映已删除的任务。
- 如果任务之前被暂停（SUSPENDED），则减少用户的 `$SUSPENDED_CRON` 值。
- 根据提供的重启标志，重启 cron 服务。

### 通知与日志

- 命令执行成功后，会记录一条信息级别的日志事件，表示 cron 任务已成功删除。
- 还会记录一条正常的日志事件，表示命令已成功完成。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改用户的 cron 任务和重启 cron 服务。
- 删除 cron 任务可能会影响用户的自动化操作或计划任务。请确保您了解这一潜在影响。

### 依赖与配置

- 该命令依赖于 Hestia 系统的配置文件和函数库，包括 `/etc/hestiacp/hestia.conf` 和 `/usr/local/hestia/func/main.sh`。
- 请确保 `$CRON_SYSTEM` 在配置文件中已启用，并且 cron 服务正在运行。
- `$USER_DATA/cron.conf` 文件应包含用户的 cron 任务信息。

### 错误处理

- 如果提供的参数数量不足、参数格式无效、系统未启用 cron 或用户/任务不存在，命令将记录相应的错误并退出。
- 如果在尝试编辑配置文件、重启 cron 服务或执行其他操作时发生错误，命令将记录错误并退出。

## v-delete-cron-reports

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-cron-reports)

### 说明

`v-delete-cron-reports` 命令用于禁用指定用户的 cron 任务通知和报告功能。通过修改用户的配置，此命令可以确保用户不再接收 cron 任务执行结果的相关通知和报告。

### 使用方法

```bash
v-delete-cron-reports USER
```

- `USER`：要禁用 cron 任务通知和报告功能的用户名。

### 示例

#### 示例 1: 禁用特定用户的 cron 任务通知和报告

```bash
v-delete-cron-reports johnDoe
```

此命令将禁用名为 `johnDoe` 的用户的 cron 任务通知和报告功能。

### 验证与检查

- 命令会检查提供的参数数量是否为 1（即用户名是必需的）。
- 它会验证用户名的格式是否有效。
- 确保 `$CRON_SYSTEM` 已启用，以便能够修改 cron 任务配置。
- 验证提供的用户名是否有效，并且该用户不是暂停状态。
- 检查系统是否处于只读模式（如演示环境），以防止不必要的修改。

### 操作

- 使用 `update_user_value` 函数更新用户的 `$CRON_REPORTS` 配置项为 `'no'`，以禁用 cron 任务通知和报告。
- 同步系统 cron 配置与用户 cron 配置。
- 重启 cron 服务以确保配置更改生效。

### 通知与日志

- 命令执行成功后，会记录一条信息级别的日志事件，表示 cron 任务通知和报告功能已成功禁用。
- 还会记录一条正常的日志事件，表示命令已成功完成。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改用户的 cron 任务配置和重启 cron 服务。
- 禁用 cron 任务通知和报告功能将阻止用户接收 cron 任务执行结果的相关通知和报告。请确保您了解这一潜在影响。

### 依赖与配置

- 该命令依赖于 Hestia 系统的配置文件和函数库，包括 `/etc/hestiacp/hestia.conf` 和 `/usr/local/hestia/func/main.sh`。
- 请确保 `$CRON_SYSTEM` 在配置文件中已启用，并且 cron 服务正在运行。
- `$HESTIA/conf/hestia.conf` 配置文件应包含与 cron 任务通知和报告相关的配置项。

### 错误处理

- 如果提供的参数数量不足、参数格式无效、系统未启用 cron 或用户不存在/已暂停，命令将记录相应的错误并退出。
- 如果在尝试更新用户配置、同步 cron 配置或重启 cron 服务时发生错误，命令将记录错误并退出。

## v-delete-cron-restart-job

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-cron-restart-job)

### 说明

`v-delete-cron-restart-job` 命令用于从 Hestia 系统的 cron 配置中删除与重启任务相关的 cron 任务。这通常用于管理系统的重启行为，确保在不需要时不会执行不必要的重启任务。

### 使用方法

```bash
v-delete-cron-restart-job
```

由于此命令不需要任何参数，因此只需直接运行即可。

### 示例

#### 示例 1: 删除与重启任务相关的 cron 任务

```bash
v-delete-cron-restart-job
```

执行此命令后，Hestia 系统将检查 `/var/spool/cron/crontabs/hestiaweb` 文件中是否存在与重启任务相关的 cron 任务，并删除它（如果存在）。

### 验证与检查

- 在执行删除操作之前，命令会检查 `$CRON_SYSTEM` 是否已启用，以确保对 cron 任务的修改是有效的。
- 同时，命令还会检查系统是否处于只读模式（如演示环境），以防止不必要的修改。

### 操作

- 使用 `grep` 命令在 `/var/spool/cron/crontabs/hestiaweb` 文件中搜索与重启任务相关的 cron 任务（即包含 `v-update-sys-queue restart` 的行）。
- 如果找到匹配的行，则使用 `sed` 命令将其从文件中删除。

### 日志与通知

- 在成功删除 cron 任务后，命令会记录一条正常的日志事件，表示操作已完成。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改 Hestia 系统的 cron 配置。
- 删除与重启任务相关的 cron 任务可能会影响系统的重启行为，请确保您了解这一潜在影响。

### 依赖与配置

- 该命令依赖于 Hestia 系统的配置文件和函数库，包括 `/etc/hestiacp/hestia.conf` 和 `/usr/local/hestia/func/main.sh`。
- `/var/spool/cron/crontabs/hestiaweb` 文件应包含与 Hestia 系统相关的 cron 任务配置。

### 错误处理

- 如果 `$CRON_SYSTEM` 未启用，或者系统处于只读模式，命令将记录相应的错误并退出。
- 如果在尝试删除 cron 任务时发生错误（例如文件不存在或无法写入），命令将记录错误并退出。

## v-change-cron-job

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-cron-job)

### 说明

`v-change-cron-job` 命令用于修改指定用户的特定 cron 任务。通过提供新的时间参数和命令，该命令可以更新 cron 任务以在指定的时间执行新的命令。

### 使用方法

```bash
v-change-cron-job USER JOB MIN HOUR DAY MONTH WDAY COMMAND
```

- `USER`: 要修改 cron 任务的用户名。
- `JOB`: 要修改的 cron 任务的名称或标识。
- `MIN`: 任务执行时的分钟数（0-59）。
- `HOUR`: 任务执行时的小时数（0-23）。
- `DAY`: 任务执行的日期（1-31）。
- `MONTH`: 任务执行的月份（1-12）。
- `WDAY`: 任务执行的星期几（0-7，其中 0 和 7 都表示星期日）。
- `COMMAND`: 任务执行时要运行的命令。

### 示例

#### 示例 1: 修改用户的 cron 任务

```bash
v-change-cron-job johnDoe backup 0 1 * * 1 '/path/to/backup_script.sh'
```

这个命令将修改用户 `johnDoe` 的名为 `backup` 的 cron 任务，使其在每周一的凌晨 1 点 0 分执行 `/path/to/backup_script.sh` 脚本。

#### 示例 2: 修改带空格和特殊字符的命令

```bash
v-change-cron-job alice notifications 0 12 * * * 'echo "Hello, World! Today is $(date)" >> /tmp/notifications.log'
```

这个命令将修改用户 `alice` 的名为 `notifications` 的 cron 任务，使其在每天的中午 12 点 0 分执行一个包含空格和特殊字符（如 `$()`）的命令，并将输出追加到 `/tmp/notifications.log` 文件中。

### 验证与检查

- 命令首先会检查提供的参数数量是否正确，以及每个参数是否符合预期的格式。
- 然后，它会验证 `$CRON_SYSTEM` 是否已启用，以确保可以修改 cron 任务。
- 接着，它会检查提供的用户名和 cron 任务名称是否有效，并且这些对象不是暂停状态。
- 如果系统处于只读模式（如演示环境），命令将不会执行任何修改操作。

### 操作

- 命令首先会获取当前的时间和日期，以便在日志中记录。
- 然后，它会构造一个包含新 cron 任务信息的字符串，其中命令部分会经过处理以转义任何可能干扰 cron 解析的字符（如单引号）。
- 使用 `sed` 命令从用户的 cron 配置文件中删除旧的 cron 任务。
- 将新的 cron 任务信息追加到用户的 cron 配置文件中。
- 使用 `sort_cron_jobs` 函数对 cron 任务进行排序（如果需要）。
- 同步系统 cron 配置与用户 cron 配置。
- 重启 cron 服务以使配置更改生效。

### 日志与通知

- 命令执行成功后，会记录一条信息级别的日志事件，说明 cron 任务已成功更新，并包含更新的 cron 任务名称和命令。
- 同时，还会记录一条正常的日志事件，表示命令已成功完成。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改用户的 cron 任务配置和重启 cron 服务。
- 修改 cron 任务时，请确保新的时间参数和命令是有效的，并且不会导致任何不期望的行为。

### 依赖与配置

- 该命令依赖于 Hestia 系统的配置文件和函数库，包括 `/etc/hestiacp/hestia.conf` 和 `/usr/local/hestia/func/main.sh`。
- 用户的 cron 配置文件（默认为 `$USER_DATA/cron.conf`）应包含用户的 cron 任务配置。
- 确保 `$CRON_SYSTEM` 在配置文件中已启用，并且 cron 服务正在运行。

### 错误处理

- 如果提供的参数数量不正确、参数格式无效、系统未启用 cron、用户或 cron 任务不存在/已暂停，或者系统处于只读模式，命令将记录相应的错误并退出。
- 如果在尝试修改 cron 配置或重启 cron 服务时发生错误，命令将记录错误并退出。

## v-unsuspend-cron-job

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-unsuspend-cron-job)

### 说明

`v-unsuspend-cron-job` 命令用于取消特定用户的特定 cron 任务的暂停状态。当 cron 任务被暂停时，它不会在预定的时间执行。使用此命令可以恢复 cron 任务的执行。

### 使用方法

```bash
v-unsuspend-cron-job USER JOB [RESTART]
```

- `USER`: 要取消暂停 cron 任务的用户名。
- `JOB`: 要取消暂停的 cron 任务的名称或标识。
- `[RESTART]`: 可选参数，用于指定是否重启 cron 服务。默认为 `yes`。

### 示例

#### 示例 1: 取消暂停 cron 任务并重启 cron 服务

```bash
v-unsuspend-cron-job admin 7
```

这个命令将取消用户 `admin` 的名为 `7` 的 cron 任务的暂停状态，并重启 cron 服务。

#### 示例 2: 取消暂停 cron 任务但不重启 cron 服务

```bash
v-unsuspend-cron-job alice 12 no
```

这个命令将取消用户 `alice` 的名为 `12` 的 cron 任务的暂停状态，但不会重启 cron 服务。

### 验证与检查

- 命令首先会检查提供的参数数量是否正确，以及每个参数是否符合预期的格式。
- 接着，它会验证 `$CRON_SYSTEM` 是否已启用，以确保可以修改 cron 任务的状态。
- 然后，它会检查提供的用户名和 cron 任务名称是否有效，并且这些对象是否处于暂停状态。
- 如果系统处于只读模式（如演示环境），命令将不会执行任何修改操作。

### 操作

- 命令使用 `update_object_value` 函数将 cron 任务的暂停状态设置为 `no`，从而取消其暂停状态。
- 同时，它会减少用户暂停的 cron 任务计数。
- 使用 `sync_cron_jobs` 函数同步系统 cron 配置与用户 cron 配置。
- 如果提供了 `RESTART` 参数并且其值为 `yes`（或未提供此参数，因为默认值为 `yes`），则会重启 cron 服务以使配置更改生效。

### 日志与通知

- 命令执行成功后，会记录一条信息级别的日志事件，说明 cron 任务已成功取消暂停，并包含相关的用户和 cron 任务名称。
- 同时，还会记录一条正常的日志事件，表示命令已成功完成。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改用户的 cron 任务配置和重启 cron 服务。
- 取消暂停 cron 任务之前，请确保这样做符合您的预期，并且不会导致任何不期望的行为。

### 依赖与配置

- 该命令依赖于 Hestia 系统的配置文件和函数库，包括 `/etc/hestiacp/hestia.conf` 和 `/usr/local/hestia/func/main.sh`。
- 确保 `$CRON_SYSTEM` 在配置文件中已启用，并且 cron 服务正在运行。

### 错误处理

- 如果提供的参数数量不正确、参数格式无效、系统未启用 cron、用户或 cron 任务不存在/未暂停，或者系统处于只读模式，命令将记录相应的错误并退出。
- 如果在尝试修改 cron 配置或重启 cron 服务时发生错误，命令将记录错误并退出。

## v-unsuspend-cron-jobs

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-unsuspend-cron-jobs)

### 说明

`v-unsuspend-cron-jobs` 命令用于取消特定用户下所有暂停的 cron 任务的暂停状态。这个命令将遍历所有被暂停的 cron 任务，并对它们进行恢复操作。

### 使用方法

```bash
v-unsuspend-cron-jobs USER [RESTART]
```

- `USER`: 需要取消暂停 cron 任务的用户名。
- `[RESTART]`: 可选参数，用于指定是否重启 cron 服务。如果未指定，则默认为不重启。

### 示例

#### 示例 1: 取消暂停所有 cron 任务并重启 cron 服务

```bash
v-unsuspend-cron-jobs admin yes
```

这个命令将取消用户 `admin` 下的所有暂停的 cron 任务的暂停状态，并重启 cron 服务。

#### 示例 2: 取消暂停所有 cron 任务但不重启 cron 服务

```bash
v-unsuspend-cron-jobs alice no
```

这个命令将取消用户 `alice` 下的所有暂停的 cron 任务的暂停状态，但不会重启 cron 服务。

### 验证与检查

- 命令首先会检查提供的参数数量是否正确，以及用户名是否有效。
- 然后，它会验证系统是否处于只读模式（如演示环境），如果是，则不会执行任何操作。

### 操作

- 命令会遍历所有被暂停的 cron 任务，对于每个任务，它都会调用 `v-unsuspend-cron-job` 命令来取消其暂停状态。
- 如果提供了 `RESTART` 参数并且其值为 `yes`，则会重启 cron 服务以使配置更改生效。

### 日志与通知

- 命令执行成功后，会记录一条日志事件，表示已取消暂停所有 cron 任务。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改用户的 cron 任务配置和重启 cron 服务。
- 取消暂停 cron 任务之前，请确保这样做符合您的预期，并且不会导致任何不期望的行为。

### 依赖与配置

- 该命令依赖于 Hestia 系统的配置文件和函数库，包括 `/etc/hestiacp/hestia.conf` 和 `/usr/local/hestia/func/main.sh`。
- 确保 `$CRON_SYSTEM` 在配置文件中已启用，并且 cron 服务正在运行。

### 错误处理

- 如果提供的参数数量不正确、用户名无效、系统处于只读模式，或者在尝试修改 cron 配置或重启 cron 服务时发生错误，命令将记录相应的错误并退出。

## v-suspend-cron-job

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-suspend-cron-job)

### 说明

`v-suspend-cron-job` 命令用于暂停特定用户的某个 cron 任务。这个命令会修改 cron 任务的配置，将其状态设置为暂停，并在需要时重启 cron 服务以使更改生效。

### 使用方法

```bash
v-suspend-cron-job USER JOB [RESTART]
```

- `USER`: 需要暂停 cron 任务的用户名。
- `JOB`: 需要暂停的 cron 任务的标识符。
- `[RESTART]`: 可选参数，用于指定是否重启 cron 服务。如果未指定，则默认为不重启。

### 示例

#### 示例 1: 暂停用户 `admin` 的 cron 任务 `5` 并重启 cron 服务

```bash
v-suspend-cron-job admin 5 yes
```

这个命令将暂停用户 `admin` 的 cron 任务 `5`，并重启 cron 服务。

#### 示例 2: 暂停用户 `alice` 的 cron 任务 `10` 但不重启 cron 服务

```bash
v-suspend-cron-job alice 10 no
```

这个命令将暂停用户 `alice` 的 cron 任务 `10`，但不会重启 cron 服务。

### 验证与检查

- 命令首先会检查提供的参数数量是否正确，以及用户名和 cron 任务标识符是否有效。
- 然后，它会验证 cron 任务是否已被暂停（通常这个检查是多余的，因为命令的目的是暂停任务，但这里可能用于确保任务状态的一致性）。
- 如果系统处于只读模式（如演示环境），则命令将不会执行任何操作。

### 操作

- 命令会更新 cron 任务的配置，将其状态设置为暂停。
- 同时，它还会增加用户下暂停 cron 任务的计数器（如果系统支持该功能）。
- 接下来，它会同步系统 cron 与用户配置，确保更改被正确应用。
- 如果提供了 `RESTART` 参数并且其值为 `yes`，则会重启 cron 服务以使配置更改生效。

### 日志与通知

- 命令执行后，会记录一条日志事件，包含有关暂停 cron 任务的详细信息。
- 同时，还会使用 `v-log-action` 命令在系统的日志中记录一条信息级别的日志，以供参考和追踪。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改用户的 cron 任务配置和重启 cron 服务。
- 暂停 cron 任务之前，请确保这样做符合您的预期，并且不会导致任何不期望的行为。

### 依赖与配置

- 该命令依赖于 Hestia 系统的配置文件和函数库，包括 `/etc/hestiacp/hestia.conf` 和 `/usr/local/hestia/func/main.sh`。
- 确保 `$CRON_SYSTEM` 在配置文件中已启用，并且 cron 服务正在运行。

### 错误处理

- 如果提供的参数数量不正确、用户名或 cron 任务标识符无效、系统处于只读模式，或者在尝试修改 cron 配置或重启 cron 服务时发生错误，命令将记录相应的错误并退出。

## v-suspend-cron-jobs

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-suspend-cron-jobs)

### 说明

`v-suspend-cron-jobs` 命令用于暂停特定用户的所有 cron 任务。这个命令会遍历用户的所有 cron 任务，并逐个暂停它们。如果需要，它还可以重启 cron 服务以使更改生效。

### 使用方法

```bash
v-suspend-cron-jobs USER [RESTART]
```

- `USER`: 需要暂停 cron 任务的用户名。
- `[RESTART]`: 可选参数，用于指定是否重启 cron 服务。如果未指定，则默认为不重启。

### 示例

#### 示例 1: 暂停用户 `admin` 的所有 cron 任务并重启 cron 服务

```bash
v-suspend-cron-jobs admin yes
```

这个命令将暂停用户 `admin` 的所有 cron 任务，并重启 cron 服务。

#### 示例 2: 暂停用户 `alice` 的所有 cron 任务但不重启 cron 服务

```bash
v-suspend-cron-jobs alice no
```

这个命令将暂停用户 `alice` 的所有 cron 任务，但不会重启 cron 服务。

### 验证与检查

- 命令首先会检查提供的参数数量是否正确，以及用户名是否有效。
- 然后，它会检查系统是否处于只读模式（如演示环境），如果是，则不会执行任何操作。

### 操作

- 命令会遍历指定用户的所有 cron 任务，并逐个调用 `v-suspend-cron-job` 命令来暂停它们。
- 如果提供了 `RESTART` 参数并且其值为 `yes`，则会重启 cron 服务以使配置更改生效。

### 日志与通知

- 命令执行后，会记录一条日志事件，包含有关暂停 cron 任务的详细信息。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改用户的 cron 任务配置和重启 cron 服务。
- 暂停所有 cron 任务之前，请确保这样做符合您的预期，并且不会导致任何不期望的行为。

### 依赖与配置

- 该命令依赖于 Hestia 系统的配置文件和函数库，包括 `/etc/hestiacp/hestia.conf` 和 `/usr/local/hestia/func/main.sh`。
- 还需要确保 `$CRON_SYSTEM` 在配置文件中已启用，并且 cron 服务正在运行。

### 错误处理

- 如果提供的参数数量不正确、用户名无效、系统处于只读模式，或者在尝试修改 cron 配置或重启 cron 服务时发生错误，命令将记录相应的错误并退出。

### 附加说明

- 该命令实际上是通过调用 `v-suspend-cron-job` 命令来实现对单个 cron 任务的暂停，因此，它的行为会受到 `v-suspend-cron-job` 的影响。
- 如果某个 cron 任务已经暂停，则再次暂停它通常不会产生额外的效果。

## v-schedule-letsencrypt-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-schedule-letsencrypt-domain)

### 说明

`v-schedule-letsencrypt-domain` 命令用于为指定的用户域名添加 Let's Encrypt SSL 证书安装的 cron 任务。此命令可以确保在预定的时间自动为给定的域名及其别名安装或更新 SSL 证书。

### 使用方法

```bash
v-schedule-letsencrypt-domain USER DOMAIN [ALIASES]
```

- `USER`: 需要为其添加 cron 任务的用户名。
- `DOMAIN`: 需要安装 SSL 证书的域名。
- `[ALIASES]`: （可选）域名的别名列表，多个别名之间用空格分隔。

### 示例

#### 示例 1: 为 `admin` 用户的 `example.com` 域名添加 cron 任务

```bash
v-schedule-letsencrypt-domain admin example.com
```

这个命令将为 `admin` 用户的 `example.com` 域名添加一个 cron 任务，用于自动安装或更新 SSL 证书。

#### 示例 2: 为 `admin` 用户的 `example.com` 域名及其别名添加 cron 任务

```bash
v-schedule-letsencrypt-domain admin example.com www.example.com
```

这个命令将为 `admin` 用户的 `example.com` 域名和 `www.example.com` 别名添加一个 cron 任务，确保这两个域名都自动安装或更新 SSL 证书。

### 验证与检查

- 命令首先会检查提供的参数数量是否正确，以及用户名、域名和别名是否有效。
- 接着，它会检查 Hestia 系统中是否启用了 Web 系统和 SSL 支持。
- 然后，它会验证指定的用户和域名是否存在且未被暂停。
- 如果系统处于只读模式（如演示环境），则不会执行任何操作。

### 操作

- 如果未提供别名，则命令会尝试从系统中获取域名的别名。
- 然后，它会使用 `v-add-cron-letsencrypt-job` 命令添加 cron 任务调度器，确保在预定的时间执行 Let's Encrypt 证书的安装或更新任务。
- 接着，它将一个任务添加到 `letsencrypt.pipe` 队列中，该任务将在后台执行 `v-add-letsencrypt-domain` 命令，为指定的用户和域名安装或更新 SSL 证书。

### 日志与通知

- 命令执行后，会记录一条日志事件，包含有关添加 cron 任务的详细信息。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改 cron 任务和安装 SSL 证书。
- 请确保指定的域名和别名在 Hestia 系统中存在且正确配置。
- 如果域名或别名已经被暂停，命令将不会执行任何操作。

### 依赖与配置

- 该命令依赖于 Hestia 系统的配置文件和函数库，包括 `/etc/hestiacp/hestia.conf`、`/usr/local/hestia/func/main.sh` 和 `/usr/local/hestia/func/domain.sh`。
- 确保 `$WEB_SYSTEM` 和 `$WEB_SSL` 变量在配置文件中已启用，以支持 Web 系统和 SSL 功能。

### 错误处理

- 如果提供的参数数量不正确、用户名、域名或别名无效、系统未启用 Web 系统或 SSL 支持、指定的用户或域名不存在或已被暂停，则命令将记录相应的错误并退出。

### 附加说明

- 通过使用 `letsencrypt.pipe` 队列，可以确保在后台异步执行 SSL 证书的安装或更新任务，从而不会阻塞当前命令行界面。

## v-restart-cron

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-restart-cron)

### 说明

`v-restart-cron` 命令用于重启 cron 服务，以便它重新读取其配置文件。这通常在修改了 cron 的相关配置或需要立即应用更改时使用。

### 使用方法

```bash
v-restart-cron [OPTION]
```

- **OPTION**:
  - `scheduled`: 如果指定该选项，则会将重启请求添加到队列中，以便在预定的时间执行。如果未指定任何选项且环境变量 `SCHEDULED_RESTART` 设置为 `yes`，也会被视为 `scheduled`。
  - `no`: 如果指定该选项（或未指定任何选项且没有 `SCHEDULED_RESTART` 环境变量），则命令将不会执行任何操作。

### 示例

#### 示例 1: 立即重启 cron 服务

```bash
v-restart-cron
```

这个命令会立即尝试重启 cron 服务。

#### 示例 2: 将 cron 服务的重启请求添加到队列中

```bash
v-restart-cron scheduled
```

或者，如果环境变量 `SCHEDULED_RESTART` 已设置为 `yes`，则可以直接运行：

```bash
v-restart-cron
```

这两个命令都会将重启 cron 服务的请求添加到队列中，以便在预定的时间执行。

### 流程说明

1. **检查 cron 系统配置**：命令首先检查 `$CRON_SYSTEM` 变量是否已设置，并且其值不是 'remote'。如果未设置或值为 'remote'，则命令将退出，不执行任何操作。

2. **处理队列中的重启请求**：如果指定了 `scheduled` 选项，或者没有指定选项但环境变量 `SCHEDULED_RESTART` 设置为 `yes`，则命令会将重启请求添加到 `$HESTIA/data/queue/restart.pipe` 队列文件中。然后命令退出。

3. **执行重启**：如果未指定 `scheduled` 或 `no` 选项（或未指定任何选项且没有 `SCHEDULED_RESTART` 环境变量），则命令将尝试重启 `$CRON_SYSTEM` 指定的 cron 服务。

4. **错误处理**：如果重启失败，命令将调用 `send_email_report` 函数发送包含错误信息的电子邮件给指定的管理员。然后，它会记录一条表示重启失败的事件。

5. **更新重启队列**：在成功执行重启（或确定不需要重启）后，命令将从 `$HESTIA/data/queue/restart.pipe` 队列文件中删除与当前脚本相关的条目（如果有的话）。

### 注意事项

- 请确保在执行此命令之前具有足够的权限来重启 cron 服务。
- 如果指定了 `scheduled` 选项，请注意，重启操作的实际执行时间取决于队列中的其他任务和系统的调度机制。
- 如果未指定任何选项且环境变量 `SCHEDULED_RESTART` 未设置，则命令将不会执行任何操作。

### 依赖与配置

- 此命令依赖于 Hestia 系统的配置文件和函数库，包括 `/etc/hestiacp/hestia.conf`、`/usr/local/hestia/func/main.sh` 和相关的配置文件。
- `$CRON_SYSTEM` 变量必须在配置文件中设置，以指定要重启的 cron 服务的名称。
- `SENDMAIL` 变量和电子邮件配置必须在系统中正确设置，以便在重启失败时发送电子邮件报告。

## v-rebuild-cron-jobs

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-rebuild-cron-jobs)

### 说明

`v-rebuild-cron-jobs` 命令用于为指定用户重新构建系统的 cron 配置文件。这对于在修改或添加用户的 cron 任务后确保 cron 配置的正确性非常有用。

### 使用方法

```bash
v-rebuild-cron-jobs USER [RESTART]
```

- **USER**: 要为其重新构建 cron 配置的用户的用户名。
- **[RESTART]**: 可选参数，用于指定是否在重新构建 cron 配置后重启 cron 服务。默认为不重启。如果指定为 `yes`，则会在重新构建后重启 cron 服务。

### 示例

#### 示例 1: 为 `admin` 用户重新构建 cron 配置，不重启 cron 服务

```bash
v-rebuild-cron-jobs admin
```

#### 示例 2: 为 `john` 用户重新构建 cron 配置，并重启 cron 服务

```bash
v-rebuild-cron-jobs john yes
```

### 流程说明

1. **参数验证**：命令首先验证是否提供了正确的参数数量（至少一个，即用户名），并检查用户名格式是否有效。同时，它还检查系统是否启用了 cron 服务（`$CRON_SYSTEM` 变量）。

2. **权限检查**：命令会检查当前是否在只读模式下运行（如演示模式），并阻止在只读模式下执行此操作。

3. **重新构建 cron 配置**：调用 `sync_cron_jobs` 函数来重新构建指定用户的 cron 配置。

4. **重启 cron 服务（可选）**：如果提供了 `RESTART` 参数且其值为 `yes`，则调用 `v-restart-cron` 命令来重启 cron 服务。这有助于确保新的 cron 配置立即生效。

5. **记录操作**：使用 `v-log-action` 命令记录重新构建 cron 配置的操作，并将日志信息发送到 Hestia 的日志系统。

6. **日志事件**：记录一个事件日志，表示 cron 配置已成功重新构建（和/或已重启 cron 服务）。

### 注意事项

- 确保在执行此命令之前具有足够的权限来重新构建 cron 配置和（如果指定）重启 cron 服务。
- 如果指定了 `RESTART` 参数，请注意重启 cron 服务可能会影响正在运行的 cron 任务。
- 如果没有指定 `RESTART` 参数或将其设置为 `no`，则重新构建的 cron 配置将在 cron 服务的下一次运行时生效。

### 依赖与配置

- 此命令依赖于 Hestia 系统的配置文件和函数库，包括 `/etc/hestiacp/hestia.conf`、`/usr/local/hestia/func/main.sh` 和相关的配置文件。
- `$CRON_SYSTEM` 变量必须在配置文件中设置，以指定要使用的 cron 服务的名称。
- `v-restart-cron` 命令和 `v-log-action` 命令也必须在系统中可用，以便在需要时执行相应的操作。

## v-list-cron-job

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-cron-job)

### 说明

`v-list-cron-job` 命令用于列出指定用户的特定 cron 任务的详细信息。通过指定用户（USER）、任务ID（JOB）和输出格式（FORMAT），该命令将返回相应的 cron 任务信息。

### 使用方法

```bash
v-list-cron-job USER JOB [FORMAT]
```

- **USER**: 用户名，表示要查询 cron 任务的所属用户。
- **JOB**: 任务ID，表示要查询的特定 cron 任务的标识符。
- **[FORMAT]**: 可选参数，指定输出格式。支持以下几种格式：`json`（JSON 格式）、`plain`（纯文本格式）、`csv`（CSV 格式）和 `shell`（适合 shell 脚本阅读的格式）。默认为 `shell` 格式。

### 示例

#### 示例 1: 列出用户 `admin` 的 cron 任务ID为 `123` 的任务详细信息（默认shell格式）

```bash
v-list-cron-job admin 123
```

#### 示例 2: 列出用户 `john` 的 cron 任务ID为 `456` 的任务详细信息，以JSON格式输出

```bash
v-list-cron-job john 456 json
```

#### 示例 3: 列出用户 `mary` 的 cron 任务ID为 `789` 的任务详细信息，以CSV格式输出

```bash
v-list-cron-job mary 789 csv
```

### 输出格式说明

- **json**: 输出为 JSON 格式的 cron 任务详细信息。
- **plain**: 输出为纯文本格式的 cron 任务详细信息，每行显示一个字段和对应的值。
- **csv**: 输出为 CSV 格式的 cron 任务详细信息，每行包含多个字段，以逗号分隔。
- **shell**: 输出为适合 shell 脚本阅读的 cron 任务详细信息，每行显示一个字段和对应的值，格式类似于 `VAR=value`。

### 流程说明

1. **参数验证**：命令首先验证是否提供了正确的参数数量（至少两个，即用户名和任务ID），并检查用户名和任务ID的格式是否有效。
2. **读取配置**：加载 Hestia 系统的配置文件和函数库。
3. **查找 cron 任务**：根据用户名和任务ID在用户的 cron 配置文件中查找对应的 cron 任务行。
4. **解析 cron 任务**：解析找到的 cron 任务行，提取任务的各种属性（如分钟、小时、日期、月份、星期几、命令等）。
5. **格式化输出**：根据指定的输出格式（或默认格式），将提取到的 cron 任务属性格式化为相应的输出内容。
6. **输出结果**：将格式化后的输出内容打印到标准输出（通常是终端或命令行界面）。

### 注意事项

- 如果指定的 `JOB` 不存在，该命令将返回一个错误消息。
- 输出的具体字段可能根据 Hestia 的版本和配置有所不同。
- 输出的时间戳 (`TIME`) 通常是 Unix 时间戳（以秒为单位）。
- 输出的日期 (`DATE`) 通常是 YYYY-MM-DD 格式。
- 输出的 `SUSPENDED` 字段表示该 cron 作业是否已挂起（暂停执行）。
- 命令中使用了多个 Bash 脚本函数（如 `json_list`, `shell_list` 等）来格式化输出，这些函数在脚本内部定义。
- 使用此命令前，请确保您具有足够的权限来访问和读取相关的 cron 配置文件。
- 如果指定的 cron 任务不存在，命令将返回一个错误消息。
- 确保在执行此命令之前具有足够的权限来访问用户的 cron 配置文件。
- 根据不同的输出格式，命令的输出内容可能有所不同。请根据需要选择合适的输出格式。

## v-list-cron-jobs

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-cron-jobs)

### 说明

`v-list-cron-jobs` 命令用于列出指定用户的所有 cron 任务。通过指定用户名（USER）和可选的输出格式（FORMAT），该命令将返回用户的所有 cron 任务信息。

### 使用方法

```bash
v-list-cron-jobs USER [FORMAT]
```

- **USER**: 用户名，表示要查询 cron 任务的所属用户。
- **[FORMAT]**: 可选参数，指定输出格式。支持以下几种格式：`json`（JSON 格式）、`plain`（纯文本格式）、`csv`（CSV 格式）和 `shell`（适合 shell 脚本阅读的格式）。默认为 `shell` 格式。

### 示例

#### 示例 1: 列出用户 `admin` 的所有 cron 任务（默认shell格式）

```bash
v-list-cron-jobs admin
```

#### 示例 2: 列出用户 `john` 的所有 cron 任务，以JSON格式输出

```bash
v-list-cron-jobs john json
```

#### 示例 3: 列出用户 `mary` 的所有 cron 任务，以CSV格式输出

```bash
v-list-cron-jobs mary csv
```

### 输出格式说明

- **json**: 输出为 JSON 格式的 cron 任务列表。每个任务作为一个 JSON 对象，包含任务的详细信息。
- **plain**: 输出为纯文本格式的 cron 任务列表。每行显示一个任务的详细信息，字段之间用制表符分隔。
- **csv**: 输出为 CSV 格式的 cron 任务列表。每行包含多个字段，以逗号分隔，并且字段值被双引号包围（如果包含特殊字符）。
- **shell**: 输出为适合 shell 脚本阅读的 cron 任务列表。每行显示一个任务的详细信息，字段之间用制表符分隔，并使用 `column` 命令进行格式化显示。

### 流程说明

1. **参数验证**：命令首先验证是否提供了正确的参数数量（至少一个，即用户名），并检查用户名的格式是否有效。
2. **读取配置**：加载 Hestia 系统的配置文件和函数库。
3. **读取 cron 任务**：从用户的 cron 配置文件中读取所有的 cron 任务行。
4. **解析 cron 任务**：对于每个 cron 任务行，解析出任务的各种属性（如分钟、小时、日期、月份、星期几、命令等）。
5. **格式化输出**：根据指定的输出格式（或默认格式），将解析出的 cron 任务属性格式化为相应的输出内容。
6. **输出结果**：将格式化后的输出内容打印到标准输出（通常是终端或命令行界面）。如果输出格式为 `shell`，则使用 `column` 命令对输出结果进行格式化显示。

### 注意事项

- 如果指定的用户不存在，命令将返回一个错误消息。
- 确保在执行此命令之前具有足够的权限来访问用户的 cron 配置文件。
- 根据不同的输出格式，命令的输出内容可能有所不同。请根据需要选择合适的输出格式。
- 对于 `shell` 格式的输出，使用了 `column` 命令进行格式化显示，以确保表格整齐易读。如果你的系统没有安装 `column` 命令，你可能需要手动安装或使用其他工具进行格式化。

## v-restore-cron-job

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-restore-cron-job)

### 简介

`v-restore-cron-job` 是 Hestia 提供的一个命令行工具，用于从备份存档中恢复单个 cron 任务。通过该命令，用户可以选择性地还原 cron 作业配置，而不必进行完整的用户或系统备份恢复。

### 语法

```bash
v-restore-cron-job USER BACKUP CRON [NOTIFY]
```

- `USER`: 需要恢复 cron 任务的用户名。
- `BACKUP`: 备份存档的路径或标识符。
- `CRON`: 需要恢复的 cron 任务的标识符或名称（可选，如果备份中只有一个 cron 任务）。
- `NOTIFY`: 恢复完成后是否发送通知（可选，默认为不发送）。

### 示例

#### 示例 1: 恢复名为 'john' 的用户的 cron 任务

如果备份存档位于 `/home/backups/john_backup.tar.gz`，并且需要从中恢复 cron 任务，可以运行以下命令：

```bash
v-restore-cron-job john /home/backups/john_backup.tar.gz
```

#### 示例 2: 恢复指定 cron 任务并发送通知

如果备份存档中包含多个 cron 任务，但只想恢复名为 'backup_cron' 的任务，并在恢复后发送通知，可以运行：

```bash
v-restore-cron-job john /home/backups/john_backup.tar.gz backup_cron yes
```

#### 示例 3: 不指定 cron 任务（适用于只有一个 cron 任务的备份）

如果备份存档中只包含一个 cron 任务，可以直接使用：

```bash
v-restore-cron-job john /home/backups/john_single_cron_backup.tar.gz
```

### 注意事项

- 在执行恢复操作之前，请确保备份存档的完整性和可用性。
- 如果备份存档中包含敏感信息，请确保在安全的环境中执行恢复操作。
- 如果有任何疑问或遇到任何问题，请参考 Hestia 的官方文档或联系支持团队。

### 日志和通知

恢复操作的日志将记录在系统日志中。如果指定了 `NOTIFY` 参数并设置为 `yes`，则恢复完成后将发送通知（通知方式取决于 Hestia 的配置）。

### 总结

`v-restore-cron-job` 命令为 Hestia 用户提供了一个方便的工具，用于从备份存档中恢复单个 cron 任务。通过指定用户名、备份存档路径和 cron 任务名称（可选），用户可以轻松地恢复所需的 cron 配置。

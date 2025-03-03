
# 软件包系列命令介绍

## v-copy-user-package

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-copy-user-package)

### 脚本概述

`v-copy-user-package` 是 Hestia 控制面板提供的一个 CLI 命令脚本，用于复制现有的用户包（package）以创建一个新的包。这可以帮助管理员快速创建类似的包配置，减少重复配置的工作量。

### 使用方法

`v-copy-user-package` 脚本接受两个参数：

1. `PACKAGE`：要复制的现有包的名称。
2. `NEW_PACKAGE`：新包的名称。

### 示例

#### 示例 1：复制一个名为 `default` 的包，并将其命名为 `new_package`

```bash
v-copy-user-package default new_package
```

执行上述命令后，系统将复制名为 `default` 的包，并创建一个名为 `new_package` 的新包。

#### 示例 2：仅指定要复制的包名，未指定新包名（这将导致错误）

```bash
v-copy-user-package default
```

由于未指定新包的名称，此命令将返回错误，提示新包名未指定。

#### 示例 3：复制不存在的包（这将导致错误）

```bash
v-copy-user-package non_existent_package new_package
```

由于要复制的包不存在，此命令将返回错误。

### 注意事项

* 确保要复制的包确实存在，否则脚本将返回错误。
* 新包的名称必须是唯一的，不能与现有包的名称冲突。
* 脚本将同时复制包的定义文件（`.pkg`）和相关的脚本文件（如果有的话，`.sh`）。

### 总结

`v-copy-user-package` 脚本提供了一个方便的方式来复制现有的用户包，从而可以快速创建具有相似配置的新包。在使用时，请确保提供正确的包名称，并遵循脚本的参数要求。如果遇到错误，请根据错误提示进行相应的调整。

## v-rename-user-package

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-rename-user-package)

### 脚本概述

`v-rename-user-package` 是 Hestia 控制面板提供的一个 CLI 命令脚本，用于重命名现有的用户包（package）。通过此脚本，管理员可以方便地更改包的名称，并可选择性地更新使用该包的所有用户的配置。

### 使用方法

`v-rename-user-package` 脚本接受三个参数：

1. `old_name`：要重命名的现有包的当前名称。
2. `new_name`：新的包名称。
3. `mode`（可选）：一个标志，用于指示是否自动更新使用该包的所有用户的配置。如果设置为 "yes"，脚本将自动更新用户的包配置。

### 示例

#### 示例 1：重命名一个包并更新用户配置

```bash
v-rename-user-package old_package_name new_package_name yes
```

此命令将重命名名为 `old_package_name` 的包为 `new_package_name`，并自动更新所有使用该包的用户的配置。

#### 示例 2：仅重命名一个包，不更新用户配置

```bash
v-rename-user-package old_package_name new_package_name
```

或者，你也可以省略 `mode` 参数，效果与上述命令相同。此命令仅重命名包，不会更新用户的配置。

#### 示例 3：尝试重命名一个不存在的包

```bash
v-rename-user-package non_existent_package new_package_name
```

由于 `non_existent_package` 不存在，此命令将返回错误，提示指定的包未找到。

### 注意事项

* 确保提供的旧包名称存在，新包名称是唯一的，不与现有包冲突。
* 如果选择自动更新用户配置，请确保在重命名包之前备份相关数据，以防意外情况发生。
* 如果仅重命名包而不更新用户配置，那么需要手动更新仍使用旧包名称的用户的配置。

### 总结

`v-rename-user-package` 脚本提供了一个灵活的方式来重命名现有的用户包，并可选择性地更新用户的配置。在使用时，请确保提供正确的包名称，并根据需要选择是否更新用户配置。如果遇到错误，请根据错误提示进行相应的调整。
# phpMyAdmin单点登录的系列命令

## v-delete-sys-pma-sso

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-sys-pma-sso)

### 简介

`v-delete-sys-pma-sso` 是 Hestia 提供的 CLI（命令行界面）命令之一，用于禁用 phpMyAdmin 的单点登录（SSO）支持。当您希望从 phpMyAdmin 中移除或禁用 Hestia SSO 插件时，可以使用此命令。

### 用法

```bash
v-delete-sys-pma-sso [选项]
```

### 选项

* **无特定选项**：此命令通常不需要额外的选项即可运行。

### 示例

#### 示例 1：直接禁用 SSO

```bash
v-delete-sys-pma-sso
```

执行上述命令后，Hestia 将自动检查 phpMyAdmin 的安装和配置，并移除或禁用与 Hestia SSO 相关的文件和配置。

#### 示例 2：检查状态后禁用

在某些情况下，您可能希望在禁用 SSO 之前检查其当前状态。虽然 `v-delete-sys-pma-sso` 命令本身并不直接提供检查状态的选项，但您可以结合其他命令或手动检查来实现这一点。

例如，您可以手动检查 `/usr/share/phpmyadmin/` 目录下是否存在 `hestia-sso.php` 文件，以及 `/etc/phpmyadmin/` 目录下是否存在 `hestia-sso.inc.php` 文件。如果这些文件存在，那么 Hestia SSO 可能已经被启用。

```bash
if [ -e /usr/share/phpmyadmin/hestia-sso.php ] && [ -e /etc/phpmyadmin/hestia-sso.inc.php ]; then
    echo "Hestia SSO is enabled. Disabling now..."
    v-delete-sys-pma-sso
else
    echo "Hestia SSO is already disabled or not installed."
fi
```

### 注意事项

* 在执行此命令之前，请确保您具有足够的权限（通常是 root 权限）来修改 phpMyAdmin 的安装和配置。
* 在禁用 SSO 之前，请确保您已备份任何重要的配置文件或数据，以防万一出现意外情况。
* 如果您在使用此命令时遇到任何问题或错误消息，请参考 Hestia 的官方文档或寻求社区支持以获取更多帮助。

## v-add-sys-pma-sso

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-sys-pma-sso)

### 1. 命令概述

`v-add-sys-pma-sso` 是 Hestia 提供的 CLI 命令，用于为 phpMyAdmin 启用单点登录（SSO）支持。通过此命令，管理员可以方便地为 phpMyAdmin 集成单点登录功能，提高系统的安全性和用户体验。

### 2. 使用方法

```bash
v-add-sys-pma-sso [options]
```

### 3. 选项参数

* `[options]`：可选参数，用于指定命令的行为。目前该命令没有特定的选项参数，但未来可能会添加。

### 4. 示例

#### 示例 1：直接启用 SSO

```bash
v-add-sys-pma-sso
```

执行上述命令后，系统将自动为 phpMyAdmin 启用单点登录功能。在此过程中，系统可能会提示管理员输入必要的配置信息或进行其他操作。

#### 示例 2：结合其他命令使用

在实际使用中，管理员可能会将 `v-add-sys-pma-sso` 命令与其他 Hestia CLI 命令结合使用，以实现更复杂的系统配置和管理任务。例如，可以先使用其他命令创建用户、设置权限等，然后再使用 `v-add-sys-pma-sso` 命令为 phpMyAdmin 启用单点登录功能。

### 5. 注意事项

* 在执行 `v-add-sys-pma-sso` 命令之前，请确保已正确安装和配置了 Hestia 和 phpMyAdmin。
* 如果之前已经为 phpMyAdmin 启用了单点登录功能，并且需要重新启用或更改配置，请先使用相应的命令（如 `v-delete-sys-pma-sso`）删除现有的配置，然后再执行 `v-add-sys-pma-sso` 命令。
* 在执行命令过程中，请仔细阅读系统提示和输出信息，以便及时发现和处理可能出现的问题。

### 6. 常见问题解答

* **Q：执行 `v-add-sys-pma-sso` 命令后没有任何反应怎么办？**
* **A：请检查 Hestia 和 phpMyAdmin 是否已正确安装和配置。如果仍然无法解决问题，请查看系统日志或联系技术支持获取帮助。**
* **Q：如何检查是否已经为 phpMyAdmin 启用了单点登录功能？**
* **A：您可以通过登录 phpMyAdmin 并检查其配置或界面来确定是否已经启用了单点登录功能。此外，您还可以使用其他工具或命令来检查系统的配置状态。**

### 7. 总结

`v-add-sys-pma-sso` 命令是 Hestia 提供的一个强大工具，用于为 phpMyAdmin 启用单点登录功能。通过该命令，管理员可以方便地提高系统的安全性和用户体验。在使用该命令时，请确保已正确安装和配置了 Hestia 和 phpMyAdmin，并仔细阅读系统提示和输出信息以处理可能出现的问题。
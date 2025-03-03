# v-change-sys-demo-mode

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-sys-demo-mode)

* [gitee的演示模式启用脚本查看](https://hestiamb.org/bin/hooks/post_install)

* [gitee的演示模式禁用脚本查看](https://hestiamb.org/bin/hooks/pre_install)

* [gitee的演示安装文档查看](https://hestiamb.org/bin/hooks/instll.html)

## 概述

`v-change-sys-demo-mode` 是 HestiaCP 提供的一个命令行工具，用于更改 HestiaCP 的演示模式状态。演示模式通常用于限制对系统的访问或显示特定的演示信息。

### 基本用法

::: code-group

```bash
v-change-sys-demo-mode [yes|no]
```

:::

- `yes`：启用演示模式
- `no`：禁用演示模式

### 示例

### 启用演示模式

要启用演示模式，您可以运行以下命令：

::: code-group

```bash
sudo v-change-sys-demo-mode yes
```

:::

该命令会执行以下操作：

- 调用 HestiaCP 的 API 禁用某些功能（如果有的话）。
- 更新系统配置文件，将 `DEMO_MODE` 设置为 `yes`。
- 重启 Web 服务器和代理服务。
- 记录系统日志，提示演示模式已启用。

### 禁用演示模式

要禁用演示模式，您可以运行以下命令：

::: code-group

```bash
sudo v-change-sys-demo-mode no
```

:::

该命令会执行以下操作：

- 更新系统配置文件，将 `DEMO_MODE` 设置为 `no`。
- 重启 Web 服务器和代理服务。
- 记录系统日志，提示演示模式已禁用。

### 结合其他命令使用

您还可以将 `v-change-sys-demo-mode` 命令与其他 HestiaCP 命令结合使用，以实现更复杂的操作。例如，您可以在启用演示模式后自动更新 Let's Encrypt SSL 证书或修改登录页面的模板。

以下是一个示例脚本，该脚本首先更新 Let's Encrypt SSL 证书，然后启用演示模式，并更新登录页面的模板以包含默认的用户名和密码（注意：出于安全考虑，通常不建议在模板中硬编码密码）：

::: code-group

```bash
#!/bin/bash

# 更新 Let's Encrypt SSL
v-update-letsencrypt-ssl

# 启用演示模式
v-change-sys-demo-mode yes

# 更新模板以启用默认用户名
sed -i "s|autofocus|autofocus value=\"admin\"|g" $HESTIA/web/templates/pages/login/login.php

# 更新模板以启用默认密码
sed -i "s|autofocus|autofocus value=\"StrongSecurePassword\"|g" $HESTIA/web/templates/pages/login/login_1.php
```

:::

**注意**：出于安全考虑，直接在模板中硬编码密码是不推荐的。这只是一个示例，用于说明如何在脚本中结合使用多个命令。

### Hooks 和自定义脚本

您可以将自定义脚本或 Hooks 放置在 `/etc/hestiacp/hooks/` 目录下（如果不存在则创建该目录），以便在特定事件（如启用或禁用演示模式）发生时自动执行。例如，您可以创建一个名为 `change-demo-mode.sh` 的脚本，并将其放置在 `/etc/hestiacp/hooks/` 目录中，以便在调用 `v-change-sys-demo-mode` 命令时执行额外的操作。

对于 hestia-nginx 或 hestia-php 的特定 Hooks，您应该分别将它们放置在 `/etc/hestiacp/hooks/nginx/` 和 `/etc/hestia/hooks/php/` 目录中。

### 版本兼容性

- **1.6.0**：添加了对 hestia-nginx 和 hestia-php Hooks 的支持。
- **1.4.x**：添加了对 HestiaCP Hooks 的基本支持。

### 注意事项

- 在使用 `v-change-sys-demo-mode` 命令之前，请确保您了解该命令的作用以及它如何影响您的 HestiaCP 安装。
- 在生产环境中更改演示模式状态之前，请确保在测试环境中进行充分测试，以确保没有意外的副作用或问题。
- 如果您遇到任何问题或错误，请查阅 HestiaCP 的官方文档或寻求社区支持。

### 总结

`v-change-sys-demo-mode` 命令是 HestiaCP 提供的一个有用的工具，允许管理员轻松地启用或禁用演示模式。通过结合其他命令和自定义脚本，您可以实现更复杂的操作，以满足您的特定需求。

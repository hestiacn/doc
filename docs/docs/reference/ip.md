# IP系列命令介绍

## v-add-sys-api-ip

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-sys-api-ip)

### 概述

`v-add-sys-api-ip` 是 Hestia 系统中用于将指定的 IP 地址添加到 API 允许列表的命令行工具。此命令允许系统管理员灵活地控制哪些 IP 地址可以访问特定的 API 接口，从而提高系统的安全性和可控性。

### 用法

```bash
v-add-sys-api-ip <IP_ADDRESS>
```

### 参数

- `<IP_ADDRESS>`：需要添加到 API 允许列表的 IP 地址。支持 IPv4 和 IPv6 地址格式。

### 示例

#### 示例 1：添加 IPv4 地址

要将 IPv4 地址 `1.1.1.1` 添加到 API 允许列表，可以运行以下命令：

```bash
v-add-sys-api-ip 1.1.1.1
```

#### 示例 2：添加 IPv6 地址

要将 IPv6 地址 `2001:0db8:85a3:0000:0000:8a2e:0370:7334` 添加到 API 允许列表，可以运行以下命令：

```bash
v-add-sys-api-ip 2001:0db8:85a3:0000:0000:8a2e:0370:7334
```

#### 示例 3：连续添加多个 IP 地址

您可以多次运行 `v-add-sys-api-ip` 命令，以将多个 IP 地址添加到 API 允许列表。例如：

```bash
v-add-sys-api-ip 1.1.1.1
v-add-sys-api-ip 2.2.2.2
v-add-sys-api-ip 3.3.3.3
```

### 注意事项

- 在执行 `v-add-sys-api-ip` 命令之前，请确保您已经以具有足够权限的用户身份登录到系统。
- 如果 API 允许列表已经存在其他 IP 地址，新添加的 IP 地址将被追加到列表的末尾，以逗号分隔。
- 如果系统处于只读模式（通常由 `check_hestia_demo_mode` 函数检查），则无法添加新的 IP 地址到 API 允许列表。
- 添加新的 IP 地址后，系统将记录一条日志消息，以通知管理员已成功添加新 IP 地址到 API 允许列表。

### 日志记录

当使用 `v-add-sys-api-ip` 命令成功添加新的 IP 地址到 API 允许列表时，系统将记录一条警告级别的日志消息。此消息包含添加的 IP 地址信息，并指示该 IP 地址已被添加到 API 允许列表。这有助于管理员跟踪系统配置更改并监控潜在的安全风险。

## v-add-sys-ip

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-sys-ip)

### 概述

`v-add-sys-ip` 是 Hestia 提供的一个命令行接口（CLI）命令，用于向系统添加 IP 地址，并创建相关的 rc 脚本。此外，该命令还支持指定 IP 名称，该名称将被用作临时别名的根域名。例如，如果设置了 `a1.myhosting.com` 作为名称，那么在此 IP 上创建的每个新域名将自动获得别名 `$domain.a1.myhosting.com`。此功能当客户想要在 DNS 迁移之前测试网站时非常方便。

### 语法

```bash
v-add-sys-ip IP NETMASK [INTERFACE] [USER] [IP_STATUS] [IP_NAME] [NAT_IP]
```

### 参数

* `IP`: 要添加的 IP 地址。
* `NETMASK`: IP 地址的子网掩码。
* `INTERFACE` (可选): IP 地址所在的网络接口。如果未指定，将尝试自动检测或使用默认接口。
* `USER` (可选): 与 IP 地址关联的用户。如果未指定，将使用根用户。
* `IP_STATUS` (可选): IP 地址的状态，默认为 `shared`。
* `IP_NAME` (可选): IP 名称，用作临时别名的根域名。
* `NAT_IP` (可选): 如果启用 NAT，则指定 NAT IP 地址。

### 示例

#### 示例 1: 添加 IP 地址并指定子网掩码

```bash
v-add-sys-ip 203.0.113.1 255.255.255.0
```

此命令将在系统上添加 IP 地址 `203.0.113.1`，并使用子网掩码 `255.255.255.0`。其他参数将使用默认值。

#### 示例 2: 添加 IP 地址并指定网络接口和用户

```bash
v-add-sys-ip 203.0.113.2 255.255.255.0 eth0 john
```

此命令将在 `eth0` 网络接口上添加 IP 地址 `203.0.113.2`，并使用子网掩码 `255.255.255.0`。此外，该 IP 地址将与用户 `john` 关联。

#### 示例 3: 添加 IP 地址并指定 IP 名称

```bash
v-add-sys-ip 203.0.113.3 255.255.255.0 "" "" "dedicated" web1.example.com
```

此命令将在系统上添加 IP 地址 `203.0.113.3`，并使用子网掩码 `255.255.255.0`。IP 地址的状态被设置为 `dedicated`，并且 IP 名称被设置为 `web1.example.com`。这意味着在此 IP 上创建的新域名将自动获得别名如 `$domain.web1.example.com`。

### 注意事项

* 在使用 `v-add-sys-ip` 命令之前，请确保您有足够的权限来执行此操作。
* 如果要启用 NAT 并指定 NAT IP 地址，请确保您的网络配置支持 NAT，并正确设置 NAT 规则。
* 在使用 IP 名称功能时，请确保 DNS 配置正确，并且已设置相应的通配符记录（如 `*.a1.myhosting.com`）。

## v-delete-sys-api-ip

从允许的 ip 列表中删除 api 地址

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-sys-api-ip)

### 简介

`v-delete-sys-api-ip` 是 Hestia 提供的一个命令行接口（CLI）命令，用于从允许访问 API 的 IP 列表中删除指定的 IP 地址。这个命令在需要控制哪些 IP 可以访问 Hestia 的 API 时非常有用。

### 使用方法

### 语法

```bash
v-delete-sys-api-ip <IP_ADDRESS>
```

### 参数

* `<IP_ADDRESS>`：要删除的 IP 地址，必须是有效的 IPv4 或 IPv6 地址格式。

### 示例

1. **删除 IPv4 地址**

假设要从允许访问 API 的 IP 列表中删除 IP 地址 `192.168.1.1`，可以使用以下命令：

```bash
v-delete-sys-api-ip 192.168.1.1
```

执行成功后，该 IP 地址将不再被允许访问 Hestia 的 API。

2. **删除 IPv6 地址**

如果要删除 IPv6 地址 `2001:0db8:85a3:0000:0000:8a2e:0370:7334`，命令如下：

```bash
v-delete-sys-api-ip 2001:0db8:85a3:0000:0000:8a2e:0370:7334
```

同样地，执行成功后，该 IPv6 地址将被从允许访问 API 的列表中移除。

### 注意事项

* 在执行此命令之前，请确保您具有足够的权限来修改系统配置。
* 在删除 IP 地址之前，请确保该 IP 地址不再需要访问 Hestia 的 API，以避免不必要的访问限制。
* 如果在执行命令时遇到任何问题或错误，请查阅 Hestia 的官方文档或联系技术支持以获取帮助。

### 总结

`v-delete-sys-api-ip` 是一个实用的 Hestia CLI 命令，它允许您从允许访问 API 的 IP 列表中删除指定的 IP 地址。通过使用该命令，您可以轻松地控制哪些 IP 可以访问 Hestia 的 API，从而增强系统的安全性。

## v-change-sys-ip-name

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-sys-ip-name)

### 简介

`v-change-sys-ip-name` 是 Hestia 提供的一个 CLI（命令行接口）命令，用于更改与 IP 地址相关联的 DNS 域名。这个命令允许用户快速、方便地更新系统中 IP 地址的 DNS 记录。

### 用法

```bash
v-change-sys-ip-name [IP] [NAME]
```

- `[IP]`：需要更改 DNS 记录的 IP 地址。
- `[NAME]`：与 IP 地址相关联的新 DNS 域名。

### 示例

#### 示例 1：更改 IP 地址的 DNS 域名

假设你想将 IP 地址 `203.0.113.1` 的 DNS 域名更改为 `acme.com`，你可以使用以下命令：

```bash
v-change-sys-ip-name 203.0.113.1 acme.com
```

执行该命令后，系统将更新与 IP 地址 `203.0.113.1` 相关联的 DNS 域名为 `acme.com`。

#### 示例 2：验证命令执行结果

为了验证 `v-change-sys-ip-name` 命令是否成功执行，你可以通过其他 Hestia 提供的命令或工具来检查 DNS 记录是否已更新。例如，你可以使用 `v-list-sys-ip` 命令列出所有系统 IP 地址及其关联的 DNS 域名，以确认更改是否生效。

```bash
v-list-sys-ip
```

在输出中，你应该能看到 IP 地址 `203.0.113.1` 与 DNS 域名 `acme.com` 相关联。

### 注意事项

- 在执行 `v-change-sys-ip-name` 命令之前，请确保你具有足够的权限来修改 DNS 记录。
- 请确保提供的 IP 地址和 DNS 域名是有效的，并且 DNS 域名尚未被其他 IP 地址使用。
- 如果在执行命令时遇到任何问题或错误，请查阅 Hestia 的官方文档或联系技术支持以获取帮助。

### 结论

`v-change-sys-ip-name` 是一个强大的 CLI 命令，它允许用户轻松更改与 IP 地址相关联的 DNS 域名。通过提供简单的参数和清晰的输出，该命令使得 DNS 记录的更新变得更加简单和高效。

## v-change-sys-ip-nat

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-sys-ip-nat)

### 命令描述

`v-change-sys-ip-nat` 是 Hestia 提供的一个 CLI 命令，用于更改与指定 IP 地址关联的 NAT IP 地址。此命令在执行过程中会更新相关的配置文件，并在需要时重新启动服务以确保更改生效。

### 使用方法

#### 语法

```bash
v-change-sys-ip-nat IP NAT_IP [RESTART]
```

- `IP`：需要更改 NAT IP 的原始 IP 地址。
- `NAT_IP`：新的 NAT IP 地址。
- `[RESTART]`：可选参数，如果提供，将在更改后重新启动相关服务。

#### 示例

1. **更改 NAT IP 地址，不重启服务**

```bash
v-change-sys-ip-nat 10.0.0.1 203.0.113.1
```

这条命令将把 IP 地址为 10.0.0.1 的 NAT IP 更改为 203.0.113.1，并且不会重启任何服务。

2. **更改 NAT IP 地址并重启服务**

```bash
v-change-sys-ip-nat 192.168.1.1 8.8.8.8 RESTART
```

这条命令将把 IP 地址为 192.168.1.1 的 NAT IP 更改为 8.8.8.8，并在更改后重启相关服务。

### 注意事项

- 在执行此命令之前，请确保您有足够的权限来更改系统配置。
- 更改 NAT IP 地址可能会影响网络访问，因此请确保您知道更改的后果，并在生产环境中谨慎操作。
- 如果在更改 NAT IP 地址后遇到任何问题，请检查相关配置文件和日志文件以获取更多信息。

### 日志记录

`v-change-sys-ip-nat` 命令在执行过程中会记录相关的日志信息。您可以在 Hestia 的日志目录中找到这些日志，以了解命令的执行情况和任何可能出现的错误。

### 总结

`v-change-sys-ip-nat` 是一个功能强大的 CLI 命令，可以帮助您轻松地更改系统的 NAT IP 地址。通过提供正确的参数和选项，您可以安全地执行此命令，并在需要时重启相关服务以确保更改生效。

## v-change-sys-ip-owner

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-sys-ip-owner)

### 简介

`v-change-sys-ip-owner` 是Hestia控制面板提供的命令行接口（CLI）命令，用于更改系统中特定IP地址的所有者。这个命令在需要调整IP分配、用户权限或进行其他相关系统任务时非常有用。

### 用法

```bash
v-change-sys-ip-owner <IP_ADDRESS> <USERNAME>
```

- `<IP_ADDRESS>`：要更改所有者的IP地址。
- `<USERNAME>`：新的IP地址所有者的用户名。

### 示例

#### 示例1：更改IP地址为203.0.113.1的所有者为admin

```bash
v-change-sys-ip-owner 203.0.113.1 admin
```

在这个例子中，`203.0.113.1` 的所有者将被更改为 `admin` 用户。

#### 示例2：更改IP地址为192.168.1.100的所有者为john

```bash
v-change-sys-ip-owner 192.168.1.100 john
```

同样地，这个命令将 `192.168.1.100` 的所有者更改为 `john` 用户。

### 注意事项

1. **权限**：运行 `v-change-sys-ip-owner` 命令的用户需要具有足够的权限来更改IP地址的所有者。通常，这要求用户是系统管理员或具有类似权限的角色。
2. **验证**：在更改IP所有者之前，Hestia系统会验证所提供的IP地址和用户名是否有效和存在。如果任何输入无效，命令将失败并显示错误消息。
3. **IP地址状态**：如果IP地址当前正在使用中（例如，绑定到某个网站或服务），更改所有者可能会影响这些服务的运行。在执行此操作之前，请确保了解IP地址的当前用途和任何潜在的影响。
4. **系统日志**：所有 `v-change-sys-ip-owner` 命令的执行都会在Hestia的系统日志中留下记录。这有助于跟踪更改和进行故障排除。

### 结论

`v-change-sys-ip-owner` 命令是Hestia控制面板中一个强大的工具，用于管理IP地址的所有者。通过遵循正确的用法和注意事项，系统管理员可以轻松地更改IP地址的所有者，以满足组织的需要。

## v-change-sys-ip-status

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-sys-ip-status)

### 简介

`v-change-sys-ip-status` 是 Hestia 提供的一个命令行接口（CLI）命令，用于更改系统中指定 IP 地址的状态。此命令允许系统管理员或具有适当权限的用户灵活地管理系统中的 IP 地址。

### 语法

```bash
v-change-sys-ip-status IP_ADDRESS IP_STATUS
```

- `IP_ADDRESS`: 需要更改状态的 IP 地址。
- `IP_STATUS`: 目标 IP 地址的新状态。

### 示例

#### 示例 1: 更改 IP 地址状态为 "active"

```bash
v-change-sys-ip-status 203.0.113.1 active
```

这条命令将把 IP 地址 `203.0.113.1` 的状态更改为 "active"。

#### 示例 2: 更改 IP 地址状态为 "reserved"

```bash
v-change-sys-ip-status 192.168.1.100 reserved
```

这条命令将把 IP 地址 `192.168.1.100` 的状态更改为 "reserved"。

#### 示例 3: 错误的 IP 地址格式

```bash
v-change-sys-ip-status 256.0.0.1 active
```

这条命令将失败，因为 `256.0.0.1` 不是一个有效的 IP 地址。

#### 示例 4: 错误的 IP 状态

```bash
v-change-sys-ip-status 203.0.113.1 invalid_status
```

这条命令将失败，因为 "invalid_status" 不是一个有效的 IP 状态。

### 注意事项

- 在执行此命令之前，请确保您具有适当的权限。
- 请确保提供的 IP 地址和状态是有效的。
- 在更改 IP 地址状态之前，请确保该 IP 地址没有被其他系统或服务使用。
- 执行此命令可能需要一些时间，具体取决于系统配置和性能。

### 返回值

- 如果命令成功执行，将返回成功消息。
- 如果命令失败，将返回错误消息，并说明失败的原因。

### 日志记录

`v-change-sys-ip-status` 命令的执行结果将被记录到 Hestia 的系统日志中，以便进行审计和故障排除。

### 后续操作

在更改 IP 地址状态后，您可能需要执行其他操作来确保系统的正常运行，例如更新 DNS 记录、重新配置网络设备等。请根据您的具体需求进行相应的操作。

## v-update-sys-ip-counters

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-update-sys-ip-counters)

### 概述

`v-update-sys-ip-counters` 是一个命令行工具，用于更新Hestia控制面板系统中IP地址的使用情况计数器。该工具通过读取配置文件和数据库中的信息，计算并更新每个IP地址所关联的Web域名数量和系统用户数量。

### 使用方法

### 基本语法

```bash
v-update-sys-ip-counters [IP]
```

- `[IP]`（可选）：指定要更新的IP地址。如果不提供IP地址，则默认更新所有IP地址。

### 示例

1. **更新所有IP地址的计数器**

直接运行命令，无需指定IP地址：

```bash
v-update-sys-ip-counters
```

2. **更新特定IP地址的计数器**

指定要更新的IP地址：

```bash
v-update-sys-ip-counters 192.168.1.1
```

### 工作原理

`v-update-sys-ip-counters` 命令在执行时，会遵循以下步骤：

1. **读取配置文件**：从`/etc/hestiacp/hestia.conf`和其他相关配置文件中加载必要的配置信息。
2. **验证参数**：检查是否提供了有效的IP地址作为参数，并执行其他必要的验证。
3. **检查只读模式**：如果Hestia控制面板处于只读模式，则命令将不会执行更新操作。
4. **构建IP列表**：如果没有指定IP地址，则命令将自动从`$HESTIA/data/ips/`目录下读取所有IP地址。
5. **更新用户统计信息**：对于每个IP地址，命令会搜索与之关联的Web域名和系统用户信息，并计算数量。
6. **更新计数器**：使用计算得到的Web域名数量和系统用户数量，更新相应的计数器。
7. **记录日志**：将执行结果记录到日志中，以便后续查看和跟踪。

### 注意事项

- 在执行`v-update-sys-ip-counters`命令之前，请确保您已经以具有足够权限的用户身份登录系统。
- 如果Hestia控制面板处于只读模式，则该命令将不会执行任何更新操作。
- 如果在执行命令时遇到任何错误或问题，请查看日志文件以获取更多信息。

### 总结

`v-update-sys-ip-counters` 是一个方便实用的命令行工具，用于更新Hestia控制面板系统中IP地址的使用情况计数器。通过指定IP地址（可选），您可以轻松地更新特定IP地址或所有IP地址的计数器。该命令通过读取配置文件和数据库中的信息，计算并更新Web域名数量和系统用户数量，从而帮助您更好地管理和监控Hestia控制面板系统中的IP地址使用情况。

## v-list-sys-ip

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-ip)

### 命令概述

`v-list-sys-ip` 是 Hestia 提供的一个命令行接口（CLI）命令，用于列出系统的 IP 地址信息。通过此命令，用户可以以不同的格式（如 JSON、PLAIN、CSV、SHELL）获取 IP 地址的详细信息。

### 命令语法

```bash
v-list-sys-ip [IP] [FORMAT]
```

* `[IP]`：可选参数，指定要查询的 IP 地址。如果不提供此参数，命令将列出所有 IP 地址的信息。
* `[FORMAT]`：可选参数，指定输出格式。支持以下格式：
	+ `json`：以 JSON 格式输出 IP 地址信息。
	+ `plain`：以纯文本格式输出 IP 地址信息，各字段以制表符分隔。
	+ `csv`：以 CSV 格式输出 IP 地址信息。
	+ `shell`：以 shell 脚本变量形式输出 IP 地址信息，方便在 shell 脚本中使用。

### 示例

#### 示例 1：列出所有 IP 地址的 JSON 格式信息

```bash
v-list-sys-ip json
```

输出示例（JSON 格式）：

```json
{
  "192.168.1.1": {
    "OWNER": "admin",
    "STATUS": "active",
    "NAME": "eth0",
    "U_SYS_USERS": "1",
    "U_WEB_DOMAINS": "2",
    "INTERFACE": "eth0",
    "NETMASK": "255.255.255.0",
    "NAT": "disabled",
    "TIME": "2023-07-19T10:00:00Z",
    "DATE": "2023-07-19"
  },
  "10.0.0.1": {
    ...
  }
}
```

#### 示例 2：列出指定 IP 地址的 PLAIN 格式信息

```bash
v-list-sys-ip 192.168.1.1 plain
```

输出示例（PLAIN 格式）：

```
IP: 192.168.1.1
NETMASK: 255.255.255.0
INTERFACE: eth0
NAT: disabled
OWNER: admin
STATUS: active
NAME: eth0
USERS: 1
DOMAINS: 2
TIME: 2023-07-19T10:00:00Z
DATE: 2023-07-19
```

#### 示例 3：列出指定 IP 地址的 CSV 格式信息

```bash
v-list-sys-ip 192.168.1.1 csv
```

输出示例（CSV 格式）：

```
IP,OWNER,STATUS,NAME,U_SYS_USERS,U_WEB_DOMAINS,INTERFACE,NETMASK,NAT,TIME,DATE
192.168.1.1,admin,active,eth0,1,2,eth0,255.255.255.0,disabled,2023-07-19T10:00:00Z,2023-07-19
```

### 注意

* 确保 Hestia 已经正确安装并配置好相关的 IP 地址信息。
* 如果指定了不存在的 IP 地址，命令将返回错误消息。
* 根据需要选择合适的输出格式，以便更好地集成到您的系统或脚本中。

## v-list-sys-ips

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-ips)

Hestia 控制面板提供了一个强大的命令行接口（CLI），用于管理和配置系统。其中，`v-list-sys-ips` 命令用于列出系统上的所有 IP 地址及其相关信息。本文档将详细介绍如何使用该命令，并给出多个示例。

### 命令说明

`v-list-sys-ips` 命令可以显示系统 IP 地址的列表，并根据指定的格式（如 JSON、Shell、Plain 或 CSV）进行格式化输出。这对于需要快速查看或导出 IP 地址信息的用户来说非常有用。

### 用法

```bash
v-list-sys-ips [FORMAT]
```

- `FORMAT`（可选）：指定输出格式，可以是 `json`、`shell`、`plain` 或 `csv`。如果未指定，则默认为 `shell` 格式。

### 示例

#### 示例 1：默认 Shell 格式输出

```bash
v-list-sys-ips
```

输出可能类似于：

```bash
IP MASK NAT STATUS WEB DATE
-- ---- --- ------ --- ----
192.168.1.1 255.255.255.0 no active example.com 2023-03-15
10.0.0.1 255.255.255.0 yes inactive test.net 2023-02-20
...
```

#### 示例 2：JSON 格式输出

```bash
v-list-sys-ips json
```

输出可能类似于：

```json
{
  "192.168.1.1": {
    "OWNER": "admin",
    "STATUS": "active",
    "NAME": "example.com",
    "U_SYS_USERS": "5",
    "U_WEB_DOMAINS": "2",
    "INTERFACE": "eth0",
    "NETMASK": "255.255.255.0",
    "NAT": "no",
    "TIME": "12:34:56",
    "DATE": "2023-03-15"
  },
  "10.0.0.1": {
    ...
  },
  ...
}
```

#### 示例 3：Plain 格式输出

```bash
v-list-sys-ips plain
```

输出可能类似于：

```bash
192.168.1.1 admin active example.com 5 2 eth0 255.255.255.0 no 12:34:56 2023-03-15
10.0.0.1 ... ... ... ... ... ... ... ... ... ...
...
```

#### 示例 4：CSV 格式输出

```bash
v-list-sys-ips csv
```

输出可能类似于：

```csv
IP,OWNER,STATUS,NAME,U_SYS_USERS,U_WEB_DOMAINS,INTERFACE,NETMASK,NAT,TIME,DATE
192.168.1.1,admin,active,example.com,5,2,eth0,255.255.255.0,no,12:34:56,2023-03-15
10.0.0.1,...,...,...,...,...,...,...,...,...
...
```

### 注意事项

- 确保您已经正确安装了 Hestia 控制面板，并且具有执行 CLI 命令的权限。
- 在执行命令之前，请确保 Hestia 的配置文件和相关脚本已正确加载和设置。
- 输出格式可能会根据实际的 IP 地址配置和 Hestia 的版本而有所不同。

通过 `v-list-sys-ips` 命令，您可以轻松获取系统 IP 地址的详细信息，并根据需要进行格式化输出。这对于系统管理员和开发人员来说是一个非常有用的工具。
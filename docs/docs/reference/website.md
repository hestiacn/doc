# WEB网站所有配置文件系列命令

## v-add-sys-web-terminal

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-sys-web-terminal)

### 简介

Hestia面板管理系统通过其CLI（命令行界面）工具提供了丰富的管理功能。其中之一是`v-add-sys-web-terminal`命令，该命令用于启用系统的Web终端功能。

### 命令说明

`v-add-sys-web-terminal` 命令允许管理员在Hestia面板中快速启用Web终端功能，从而使用户能够通过Web浏览器直接访问服务器的终端界面。这对于远程管理和故障排除非常有用。

### 使用方法

在Hestia面板的服务器上，使用具有足够权限的用户登录，并打开终端。然后，输入以下命令来启用Web终端功能：

```bash
v-add-sys-web-terminal
```

执行此命令后，系统将自动执行必要的配置和安装步骤，以启用Web终端功能。

### 示例

#### 示例 1：直接启用Web终端

```bash
# 以root用户或具有足够权限的用户身份执行命令
v-add-sys-web-terminal

# 系统将显示安装和配置进度的输出
# ...（安装和配置输出）...

# 安装完成后，Web终端功能将被启用
```

#### 示例 2：检查Web终端状态

虽然`v-add-sys-web-terminal`命令本身没有直接的“检查状态”选项，但您可以通过其他命令或查看Hestia面板的Web界面来确认Web终端是否已启用。

```bash
# 您可以查看相关的配置文件或日志文件，以确认Web终端是否已启用
cat /path/to/hestia/config/web_terminal.conf

# 或者，您可以直接登录到Hestia面板的Web界面，并检查Web终端的设置和状态
```

### 注意事项

* 在执行此命令之前，请确保您已备份所有重要数据，并了解该命令可能带来的任何潜在影响。
* 如果您的服务器已启用了防火墙或安全组策略，请确保已正确配置它们以允许对Web终端的访问。
* 在使用Web终端时，请始终遵循最佳的安全实践，例如使用强密码、限制访问权限等。

### 官方文档

由于Hestia面板管理系统没有集成help命令系统，因此建议查阅官方文档以获取有关`v-add-sys-web-terminal`命令的更多详细信息和用法示例。官方文档通常包含最新的功能介绍、使用说明和故障排除指南，可以帮助您更好地利用Hestia面板管理系统。

## v-add-user-wp-cli

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-user-wp-cli)

### 概述

在Hestia面板管理系统中，`v-add-user-wp-cli`是一个CLI（命令行接口）命令，用于为用户账户添加对WordPress命令行接口（WP-CLI）的支持。WP-CLI允许管理员通过命令行来管理WordPress站点，提供了一系列强大的工具和命令，以自动化常见的WordPress任务。

### 用法

`v-add-user-wp-cli [USER]`

* `[USER]`：需要添加WP-CLI支持的用户名。

### 示例

#### 示例1：为基本用户添加WP-CLI支持

假设我们有一个名为`john_doe`的用户，并且我们希望为他添加WP-CLI支持，可以运行以下命令：

```bash
v-add-user-wp-cli john_doe
```

执行此命令后，系统将为用户`john_doe`在其家目录中创建一个`.wp-cli`目录，并下载和设置WP-CLI的phar文件。此外，系统还会在用户的`.bash_aliases`文件中添加一个别名，以便用户可以通过`wp`命令直接调用WP-CLI。

#### 示例2：更新已存在的WP-CLI安装

如果用户的WP-CLI安装已经存在，但您希望更新到最新版本，可以使用`update`参数（尽管`v-add-user-wp-cli`命令本身可能不支持直接的更新功能，但您可以通过其他方式，如手动更新或使用WP-CLI的`wp cli update`命令来实现）。但请注意，这取决于Hestia的具体实现和版本。

### 注意事项

* 在运行`v-add-user-wp-cli`命令之前，请确保您具有足够的权限来修改用户账户和文件系统。
* 该命令可能需要一些时间来完成，因为它需要下载WP-CLI的phar文件并设置适当的权限。
* 如果命令执行失败，请检查Hestia的日志文件以获取更多信息，或者查看官方文档以获取故障排除帮助。

### 官方文档

由于Hestia面板管理系统没有集成help命令系统，您可能需要参考官方文档来获取关于`v-add-user-wp-cli`命令的更多详细信息和用法示例。官方文档通常包含最新的功能和更新，因此请确保您查看的是与您的Hestia版本相对应的文档。

## 添加系列命令

## v-add-web-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-web-domain)

### 概述

`v-add-web-domain` 是Hestia面板管理系统中的一个CLI（命令行接口）命令，用于向服务器添加虚拟主机。通过此命令，你可以轻松地添加域名、配置IP地址、设置别名、重启服务以及指定代理扩展。

### 命令选项

- **USER**: 指定执行此命令的用户名。
- **DOMAIN**: 要添加的域名。
- **[IP]**: 可选参数，指定与该域名关联的IP地址。如果未指定，将使用默认模板。
- **[RESTART]**: 可选参数，用于指定是否在添加域名后重启相关服务。通常设置为`yes`或`no`。
- **[ALIASES]**: 可选参数，用于指定与该域名关联的别名列表。如果不需要别名，可以传递`none`作为参数。
- **[PROXY_EXTENSIONS]**: 可选参数，用于指定与代理相关的扩展配置。

### 使用示例

**示例1**：添加域名并重启服务

```bash
v-add-web-domain admin example.com 192.168.1.100 yes www.example.com
```

解释：此命令以`admin`用户身份添加`example.com`域名，并将其关联到IP地址`192.168.1.100`。添加完毕后将重启相关服务，并为该域名设置别名`www.example.com`。

**示例2**：添加域名并使用默认IP和别名

```bash
v-add-web-domain admin anotherdomain.com
```

解释：此命令以`admin`用户身份添加`anotherdomain.com`域名。由于未指定IP地址和别名，将使用默认模板，并自动为域名分配`www.anotherdomain.com`类型的别名（除非传递了`none`作为别名参数）。

**示例3**：添加域名但不重启服务

```bash
v-add-web-domain admin testdomain.net 10.0.0.10 no
```

解释：此命令以`admin`用户身份添加`testdomain.net`域名，并将其关联到IP地址`10.0.0.10`。添加完毕后不重启相关服务（由于`no`参数）。

### 注意事项

- 在执行此命令之前，请确保你具有足够的权限来添加虚拟主机。
- 如果指定了IP地址，请确保该IP地址在服务器上已正确配置并可访问。
- 如果需要设置别名，请确保传递的别名列表格式正确，并且每个别名都是有效的。
- 请注意，在执行命令后，可能需要一些时间来使更改生效。你可以通过检查Hestia面板或相关服务状态来确认更改是否已成功应用。

### 官方文档

由于Hestia面板管理系统默认没有集成`help`命令系统，建议参考官方文档以获取更详细的信息和最新更新。官方文档通常包含有关CLI命令的完整列表、选项说明、示例以及故障排除指南。

## v-add-web-domain-alias

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-web-domain-alias)

### 命令介绍

`v-add-web-domain-alias` 是 Hestia 面板管理系统中的一个 CLI（命令行接口）命令，用于为一个域名添加一个或多个别名（也被称为“域名停放”或“域名解析别名”）。此命令支持使用通配符 `<*.domain.tld>`。

### 命令语法

```bash
v-add-web-domain-alias USER DOMAIN ALIASES [RESTART]
```

- `USER`：执行操作的用户名。
- `DOMAIN`：需要添加别名的主域名。
- `ALIASES`：一个或多个别名，使用空格分隔。
- `[RESTART]`：可选参数，指定是否在添加别名后重启 Web 服务。默认为不重启。

### 示例

#### 示例 1：添加单个别名

```bash
v-add-web-domain-alias admin acme.com www.acme.com
```

此命令将把 `www.acme.com` 添加到 `acme.com` 的别名列表中，执行用户为 `admin`。

#### 示例 2：添加多个别名

```bash
v-add-web-domain-alias admin acme.com www.acme.com blog.acme.com
```

此命令将把 `www.acme.com` 和 `blog.acme.com` 添加到 `acme.com` 的别名列表中，执行用户为 `admin`。

#### 示例 3：添加别名并重启 Web 服务

```bash
v-add-web-domain-alias admin acme.com www.acme.com yes
```

此命令将把 `www.acme.com` 添加到 `acme.com` 的别名列表中，并在添加后重启 Web 服务，执行用户为 `admin`。注意，`yes` 参数用于指定重启 Web 服务。

### 注意事项

- 在使用此命令前，请确保您已经登录到具有足够权限的用户账户下。
- 确保提供的 `USER`、`DOMAIN` 和 `ALIASES` 参数是正确和有效的。
- 如果您的服务器配置了防火墙或安全组策略，请确保 CLI 命令能够正常执行。
- 由于 Hestia 没有集成 `help` 命令系统，请参考官方文档以获取更多关于此命令的详细信息和用法示例。

### 结论

`v-add-web-domain-alias` 命令是 Hestia 面板管理系统中一个实用的 CLI 命令，用于为域名添加别名。通过提供正确的参数和选项，您可以轻松地管理和配置您的域名别名。请确保在使用此命令时遵循官方文档的指导和注意事项。

## v-add-web-domain-allow-users

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-web-domain-allow-users)

### 命令简介

`v-add-web-domain-allow-users` 是 Hestia 面板管理系统中的一个 CLI 命令，用于允许特定的用户创建指定域名下的子域名。通过此命令，系统管理员可以绕过“强制子域名所有权”的检查，为特定的用户或用户组赋予创建子域名的权限。

### 命令格式

```bash
v-add-web-domain-allow-users [USER] [DOMAIN]
```

- `[USER]`：指定要赋予权限的用户名。
- `[DOMAIN]`：指定要允许创建子域名的域名。

### 使用示例

#### 示例 1：允许用户 "admin" 创建 "example.com" 下的子域名

```bash
v-add-web-domain-allow-users admin example.com
```

执行上述命令后，用户 "admin" 将被允许在 "example.com" 域名下创建子域名。

#### 示例 2：允许用户组 "developers" 中的所有用户创建 "dev.company.com" 下的子域名（注：此功能可能需要额外的配置或插件支持）

```bash
# 假设存在一个命令或机制可以代表用户组 "developers"
v-add-web-domain-allow-users developers dev.company.com
```

请注意，此示例可能并不直接适用于 Hestia 的标准安装，因为它涉及到用户组的处理，这可能需要额外的配置或第三方插件的支持。

### 注意事项

1. 在执行此命令之前，请确保您已登录到具有足够权限的用户账户。
2. 请谨慎使用此命令，因为它将绕过“强制子域名所有权”的检查。确保您了解授予权限的潜在风险。
3. 如果您不确定某个命令的用法或参数，请查阅官方文档或联系技术支持以获取帮助。

### 命令输出

成功执行此命令后，系统可能不会输出任何内容或返回一个成功的消息。但是，您可以通过检查相关的日志文件或使用其他 Hestia 面板管理工具来验证权限是否已成功授予。

### 常见问题

- **Q**: 我执行了命令，但用户仍然无法创建子域名。
  **A**: 请检查您的命令是否输入正确，并确保您已登录到具有足够权限的用户账户。此外，请检查“强制子域名所有权”的设置是否已正确配置。

- **Q**: 我可以为一个域名授予多个用户的权限吗？
  **A**: 是的，您可以为同一个域名授予多个用户的权限。只需为每个用户分别执行此命令即可。

- **Q**: 我可以撤销已授予的权限吗？
  **A**: Hestia 面板可能提供了相应的命令或界面来撤销已授予的权限。请参考官方文档或联系技术支持以获取更多信息。

## v-add-web-domain-backend

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-web-domain-backend)

### 命令概述

`v-add-web-domain-backend` 是 Hestia 面板管理系统提供的一个 CLI 命令，用于向系统中添加 Web 后端配置。通过该命令，管理员可以快速地添加新的后端服务，并指定相关的配置选项。

### 使用方法

基本语法：

```bash
v-add-web-domain-backend USER DOMAIN [TEMPLATE] [RESTART]
```

* `USER`: 必需的参数，指定执行操作的用户名。
* `DOMAIN`: 必需的参数，指定要添加后端的域名。
* `TEMPLATE`: 可选参数，指定使用的后端模板名称。如果未指定，将使用默认模板。
* `RESTART`: 可选参数，指定操作后是否重启后端服务。默认为不重启。

### 示例

#### 示例 1：使用默认模板添加后端

```bash
v-add-web-domain-backend admin example.com
```

上述命令将以 `admin` 用户身份，为 `example.com` 域名添加后端配置，并使用默认模板。操作完成后，不会重启后端服务。

#### 示例 2：指定模板并重启服务

```bash
v-add-web-domain-backend admin anotherdomain.com custom yes
```

上述命令将以 `admin` 用户身份，为 `anotherdomain.com` 域名添加后端配置，并使用名为 `custom` 的自定义模板。操作完成后，将重启后端服务。

#### 示例 3：仅指定模板

```bash
v-add-web-domain-backend admin thirddomain.com specific
```

上述命令将以 `admin` 用户身份，为 `thirddomain.com` 域名添加后端配置，并使用名为 `specific` 的模板。操作完成后，不会重启后端服务。

### 注意事项

* 请确保执行命令的用户具有足够的权限，以添加和修改后端配置。
* 在使用自定义模板时，请确保该模板已正确配置并可用于当前系统。
* 重启后端服务可能会影响正在运行的应用程序或服务，请在确认无影响后再执行该操作。

### 官方文档

由于 Hestia 面板管理系统默认没有集成 help 命令系统，建议查阅官方文档以获取更详细的信息和更新内容。官方文档通常包含了对 CLI 命令的完整描述、参数说明、示例以及故障排除指南等内容。

## v-add-web-domain-ftp

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-web-domain-ftp)

### 简介

Hestia面板管理系统是一个功能强大的Web服务器控制面板，它允许用户通过直观的界面管理其Web服务器。除此之外，Hestia还提供了一系列CLI（命令行接口）命令，方便用户通过终端进行高级操作。其中，`v-add-web-domain-ftp`命令用于为Web域添加额外的FTP账户。

### 命令概述

`v-add-web-domain-ftp`命令允许用户为指定的Web域创建一个新的FTP账户。通过此命令，用户可以指定FTP账户的用户名、密码以及可选的FTP根目录。

### 命令语法

```bash
v-add-web-domain-ftp USER DOMAIN FTP_USER FTP_PASSWORD [FTP_PATH]
```

* `USER`: Hestia面板中的用户名。
* `DOMAIN`: 要为其添加FTP账户的Web域名。
* `FTP_USER`: 新FTP账户的用户名。
* `FTP_PASSWORD`: 新FTP账户的密码。
* `FTP_PATH`: 可选参数，指定FTP账户的根目录。如果不提供此参数，FTP账户的根目录将默认为Web域的文件系统根目录。

### 命令示例

**示例 1**：为Web域"example.com"的用户"john"创建一个名为"john_ftp"的FTP账户，密码为"p4$$vvOrD"。

```bash
v-add-web-domain-ftp john example.com john_ftp p4$$vvOrD
```

**示例 2**：为Web域"mywebsite.net"的用户"alice"创建一个名为"alice_ftp"的FTP账户，密码为"SecretPassword123"，并指定FTP根目录为"/home/alice/websites/mywebsite.net/ftp"。

```bash
v-add-web-domain-ftp alice mywebsite.net alice_ftp SecretPassword123 /home/alice/websites/mywebsite.net/ftp
```

### 注意事项

* 请确保您有足够的权限在Hestia面板中执行此命令。
* 请使用强密码来保护您的FTP账户安全。
* 如果指定的FTP根目录不存在，命令可能会失败。请确保在执行命令之前创建所需的目录。
* 如果指定的FTP用户名已经存在，命令将失败。请确保为每个FTP账户使用唯一的用户名。

### 官方文档

由于Hestia面板管理系统默认没有集成`help`命令系统，因此建议用户参考官方文档以获取有关`v-add-web-domain-ftp`命令的更多详细信息和最新更新。官方文档通常包含命令的完整语法、参数说明、示例以及故障排除指南。

## v-add-web-domain-httpauth

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-web-domain-httpauth)

### 简介

在Hestia面板管理系统中，`v-add-web-domain-httpauth` 是一个用于为Web域名添加HTTP基本认证的CLI命令。该命令允许你为指定的域名添加用户名和密码保护，以增强网站的安全性。

### 命令语法

```bash
v-add-web-domain-httpauth USER DOMAIN AUTH_USER AUTH_PASSWORD [RESTART]
```

* **USER**: 面板管理系统的用户名。
* **DOMAIN**: 要添加HTTP认证的域名。
* **AUTH_USER**: 用于HTTP认证的用户名。
* **AUTH_PASSWORD**: 与上述用户名对应的密码。
* **[RESTART]**: 可选参数，用于指定是否在添加认证后重启Web服务器。默认为“yes”。

### 示例

#### 示例1：添加HTTP认证并重启服务器

```bash
v-add-web-domain-httpauth admin acme.com user01 password01
```

在这个示例中，我们为`acme.com`域名添加了HTTP认证，使用用户名`user01`和密码`password01`。由于我们没有指定`RESTART`参数，因此Hestia会在添加认证后默认重启Web服务器。

#### 示例2：添加HTTP认证但不重启服务器

```bash
v-add-web-domain-httpauth admin acme.com user02 password02 no
```

在这个示例中，我们同样为`acme.com`域名添加了HTTP认证，但指定了`RESTART`参数为`no`，因此Hestia不会在添加认证后重启Web服务器。

### 注意事项

1. **安全性**：请确保使用强密码，并定期更改它们以提高安全性。
2. **权限**：只有具有适当权限的用户才能使用此命令。确保你以具有足够权限的用户身份运行此命令。
3. **备份**：在更改任何配置之前，最好先备份当前配置。这样，如果出现问题，你可以轻松地恢复到以前的状态。
4. **测试**：在将更改应用于生产环境之前，请在一个测试环境中验证它们的功能和性能。

### 结论

`v-add-web-domain-httpauth`命令是Hestia面板管理系统中一个非常有用的工具，用于为Web域名添加HTTP基本认证。通过遵循上述语法和示例，你可以轻松地为你的网站添加额外的安全性。但是，请记住始终注意安全性和最佳实践，以确保你的网站保持安全和可靠。

## v-add-web-domain-proxy

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-web-domain-proxy)

### 简介

Hestia面板管理系统通过其CLI（命令行界面）提供了`v-add-web-domain-proxy`命令，用于为Web域设置代理规则。此命令允许用户将特定域名的流量代理到其他服务或位置，这对于实现负载均衡、内容分发网络（CDN）集成或其他复杂路由规则时非常有用。

### 命令概述

`v-add-web-domain-proxy`命令允许用户为指定的Web域设置代理设置。用户可以指定源域名、目标地址（可能是另一个域名、IP地址或负载均衡器的地址）以及可选的代理参数。

### 命令语法

```bash
v-add-web-domain-proxy USER DOMAIN TARGET [OPTIONS] [RESTART]
```

* `USER`: 需要为其设置代理的用户的用户名。
* `DOMAIN`: 需要设置代理的原始域名。
* `TARGET`: 代理流量的目标地址（如另一个域名、IP地址或负载均衡器地址）。
* `[OPTIONS]`: 可选的代理设置选项，具体取决于所使用的代理类型和服务。
* `[RESTART]`: 可选参数，如果提供，则重启相关服务以使更改生效（默认为不重启）。

### 示例

#### 示例1：简单域名代理

假设我们想要将`user`用户的`domain.tld`域名代理到`proxy.example.com`。

```bash
v-add-web-domain-proxy user domain.tld proxy.example.com
```

#### 示例2：指定端口

如果目标地址包含特定端口（如`8080`），我们可以这样指定：

```bash
v-add-web-domain-proxy user domain.tld proxy.example.com:8080
```

#### 示例3：使用SSL/TLS

如果目标地址需要SSL/TLS加密连接，可能需要额外的配置选项（具体取决于Hestia的实现）。假设我们有一个SSL证书和私钥，并希望使用它们来连接到目标地址，我们可能会使用类似以下的命令（具体参数可能会有所不同）：

```bash
v-add-web-domain-proxy user domain.tld proxy.example.com --ssl-cert /path/to/cert.pem --ssl-key /path/to/key.pem
```

#### 示例4：重启服务以应用更改

为了确保代理设置立即生效，我们可以选择重启相关服务：

```bash
v-add-web-domain-proxy user domain.tld proxy.example.com yes
```

注意：在上面的示例中，`yes`作为`RESTART`参数的占位符。在实际使用中，您可能需要根据Hestia的具体实现来指定正确的参数值。

### 注意事项

* 在使用此命令之前，请确保您已经以具有足够权限的用户身份登录到Hestia面板管理系统的CLI。
* 请仔细检查您提供的参数，特别是域名、目标地址和任何可选的代理设置选项，以确保它们正确无误。
* 如果您不确定某个参数的含义或用法，请查阅官方文档或联系Hestia支持团队以获取帮助。

### 结论

`v-add-web-domain-proxy`命令是Hestia面板管理系统中一个强大的工具，它允许用户为Web域设置复杂的代理规则。通过遵循上述示例和注意事项，您可以有效地使用此命令来管理您的网站代理需求。

## v-add-web-domain-redirect

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-web-domain-redirect)

### 简介

Hestia面板管理系统通过其CLI（命令行界面）提供了`v-add-web-domain-redirect`命令，用于为Web域添加强制重定向。本文档将详细解释该命令的使用方法，并提供多个示例。

### 命令概述

`v-add-web-domain-redirect`命令允许用户为指定的Web域设置重定向规则。通过此命令，用户可以将流量从一个域重定向到另一个域，这在网站迁移、域名更改或SEO优化等场景中非常有用。

### 命令语法

```bash
v-add-web-domain-redirect USER DOMAIN REDIRECT HTTPCODE [RESTART]
```

* `USER`: 需要为其设置重定向的用户的用户名。
* `DOMAIN`: 需要重定向的原始域名。
* `REDIRECT`: 重定向的目标域名或URL。
* `HTTPCODE`: 重定向时使用的HTTP状态码（默认为301）。
* `[RESTART]`: 可选参数，如果提供，则重启相关服务以使更改生效（默认为不重启）。

### 示例

#### 示例1：简单域名重定向

假设我们想要将`user`用户的`domain.tld`域名重定向到`www.domain.tld`。

```bash
v-add-web-domain-redirect user domain.tld www.domain.tld
```

#### 示例2：自定义HTTP状态码

如果我们希望使用302（临时重定向）而不是默认的301（永久重定向），我们可以这样做：

```bash
v-add-web-domain-redirect user domain.tld shop.domain.tld 302
```

#### 示例3：重定向到不同域名

我们还可以将流量重定向到完全不同的域名：

```bash
v-add-web-domain-redirect user domain.tld different-domain.com
```

#### 示例4：带有重启选项

如果我们希望立即应用更改并重启相关服务，我们可以添加`RESTART`参数：

```bash
v-add-web-domain-redirect user domain.tld new-domain.com yes
```

### 注意事项

* 在使用此命令之前，请确保您已经以具有足够权限的用户身份登录到Hestia面板管理系统的CLI。
* 请仔细检查您提供的参数，特别是域名和URL，以确保它们正确无误。
* 如果您不确定某个参数的含义或用法，请查阅官方文档或联系Hestia支持团队以获取帮助。

### 结论

`v-add-web-domain-redirect`命令是Hestia面板管理系统中一个非常有用的工具，它允许用户轻松地为Web域设置重定向规则。通过遵循上述示例和注意事项，您可以有效地使用此命令来管理您的网站重定向需求。

## v-add-web-domain-ssl

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-web-domain-ssl)

### 介绍

Hestia面板管理系统为了方便用户管理Web服务器，提供了丰富的CLI（命令行界面）命令。其中，`v-add-web-domain-ssl`命令用于为指定的域名添加SSL证书支持，增强网站的安全性。下面将详细介绍该命令的使用方法，并通过多个示例展示其应用。

### 命令格式


```bash
v-add-web-domain-ssl USER DOMAIN SSL_DIR [SSL_HOME] [RESTART]
```

### 参数说明

* `USER`: 用于执行此命令的用户名，通常是Hestia面板的管理员用户。
* `DOMAIN`: 要添加SSL证书的域名。
* `SSL_DIR`: 包含SSL证书文件的目录路径。该目录下应包含`.crt`（证书文件）、`.key`（私钥文件）以及可选的`.ca`（证书链文件）。
* `SSL_HOME`（可选）: SSL证书的家目录，用于存储与SSL相关的配置文件。如果未指定，将使用默认位置。
* `RESTART`（可选）: 是否在添加SSL证书后重启Web服务器。如果指定此参数，将在操作完成后自动重启服务器。

### 示例

#### 示例1：基本用法

假设用户名为`admin`，要为域名`example.com`添加SSL证书，证书文件位于`/tmp/ssl_certs/`目录下：

```bash
v-add-web-domain-ssl admin example.com /tmp/ssl_certs/
```

执行上述命令后，Hestia面板将为`example.com`域名添加SSL证书支持。如果一切顺利，您可以通过HTTPS访问该域名。

#### 示例2：指定SSL家目录

如果您希望将SSL证书的配置文件存储在非默认位置，可以使用`SSL_HOME`参数指定家目录。例如：

```bash
v-add-web-domain-ssl admin example.com /tmp/ssl_certs/ /var/www/ssl/
```

在上述示例中，SSL证书的配置文件将被存储在`/var/www/ssl/`目录下。

#### 示例3：添加SSL证书并重启服务器

如果您希望在添加SSL证书后立即重启Web服务器，以确保更改生效，可以添加`RESTART`参数：

```bash
v-add-web-domain-ssl admin example.com /tmp/ssl_certs/ /var/www/ssl/ RESTART
```

执行此命令后，Hestia面板将添加SSL证书并重启Web服务器。请注意，在重启期间，网站将暂时无法访问。

### 注意事项

* 在执行`v-add-web-domain-ssl`命令之前，请确保您已拥有有效的SSL证书文件，并且文件路径正确无误。
* 如果在添加SSL证书时遇到问题，请检查Hestia面板的日志文件以获取更多信息。
* 重启Web服务器可能会导致短暂的服务中断。请确保在合适的时间段执行此操作，以避免对网站访问者造成不必要的影响。

## v-add-web-domain-ssl-force

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-web-domain-ssl-force)

### 概述

`v-add-web-domain-ssl-force` 是 Hestia 面板管理系统中用于强制指定域名使用 SSL 加密的 CLI 命令。该命令允许管理员为特定用户下的域名启用 SSL 强制重定向，确保所有 HTTP 请求都被重定向到 HTTPS。

### 使用方法

命令的基本语法如下：

```bash
v-add-web-domain-ssl-force USER DOMAIN [RESTART] [QUIET]
```

- `USER`: 要操作的用户名。
- `DOMAIN`: 要启用 SSL 强制的域名。
- `RESTART` (可选): 是否重启 Web 服务器以使更改生效。如果指定，则命令执行后会重启 Web 服务器。
- `QUIET` (可选): 启用安静模式，不显示任何输出信息。

### 示例

#### 示例 1: 启用 SSL 强制，并重启 Web 服务器

```bash
v-add-web-domain-ssl-force admin example.com yes
```

此命令将为 `admin` 用户下的 `example.com` 域名启用 SSL 强制，并在命令执行后重启 Web 服务器。

#### 示例 2: 启用 SSL 强制，但不重启 Web 服务器

```bash
v-add-web-domain-ssl-force admin example.com no
```

此命令同样为 `admin` 用户下的 `example.com` 域名启用 SSL 强制，但不会在命令执行后重启 Web 服务器。管理员可以稍后手动重启服务器以应用更改。

#### 示例 3: 启用 SSL 强制，并启用安静模式

```bash
v-add-web-domain-ssl-force admin example.com yes quiet
```

此命令在启用 SSL 强制并重启 Web 服务器的同时，启用了安静模式，因此不会显示任何输出信息。

### 注意事项

- 在执行此命令之前，请确保已正确配置 SSL 证书，并且该证书对指定的域名有效。
- 如果在命令执行后没有立即看到效果，请检查 Web 服务器的配置是否正确加载了 SSL 强制重定向规则。
- 如果在命令执行过程中遇到任何问题，请查阅 Hestia 面板管理系统的官方文档或寻求技术支持。

### 结论

`v-add-web-domain-ssl-force` 是一个功能强大的 CLI 命令，可以帮助管理员轻松地为指定域名启用 SSL 强制重定向。通过合理使用该命令，可以提高网站的安全性，并保护用户数据在传输过程中的安全。

## v-add-web-domain-ssl-hsts

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-web-domain-ssl-hsts)

### 概述

Hestia面板管理系统是一个功能强大的Web服务器控制面板，它集成了多种CLI（命令行界面）命令，用于自动化和简化服务器管理任务。其中，`v-add-web-domain-ssl-hsts`命令用于为指定的Web域名启用HTTP严格传输安全（HSTS）设置，以增强网站的安全性。

### 命令概述

`v-add-web-domain-ssl-hsts` 命令允许管理员为特定的Web域名启用HSTS。HSTS是一种安全策略机制，它告诉浏览器只能通过HTTPS协议与指定的域名进行通信，拒绝HTTP协议的连接。启用HSTS有助于保护用户免受中间人攻击（MITM）和其他安全威胁。

### 命令语法

```bash
v-add-web-domain-ssl-hsts [选项] 域名
```

* **选项**：该命令可能支持一些选项参数，具体取决于Hestia的版本和配置。然而，通常这个命令不接受任何直接的选项，因为所有必要的配置信息都通过其他方式（如配置文件或环境变量）提供。
* **域名**：指定要启用HSTS的Web域名。

### 使用示例

1. **为单个域名启用HSTS**

假设您要为`example.com`启用HSTS，您可以使用以下命令：

```bash
v-add-web-domain-ssl-hsts example.com
```

执行此命令后，Hestia将配置Web服务器以在响应头中包含HSTS指令，指示浏览器仅通过HTTPS与`example.com`进行通信。

2. **结合其他命令使用**

虽然`v-add-web-domain-ssl-hsts`命令本身不接受许多选项，但您可以将其与其他Hestia CLI命令结合使用，以实现更复杂的任务。例如，您可能首先使用其他命令来配置SSL证书，然后再使用`v-add-web-domain-ssl-hsts`来启用HSTS。

### 注意事项

* 在启用HSTS之前，请确保您的Web服务器已正确配置并可以使用HTTPS协议。
* HSTS是一种强大的安全机制，但一旦启用，它将强制浏览器仅通过HTTPS与您的网站进行通信。因此，在启用HSTS之前，请确保您的网站已准备好处理HTTPS连接。
* HSTS设置通常会在浏览器中缓存一段时间（可以是数月到数年）。在此期间，即使您禁用了服务器上的HSTS，浏览器仍然可能会拒绝通过HTTP与您的网站进行通信。因此，请谨慎使用HSTS，并在启用之前仔细考虑其潜在影响。

### 结论

`v-add-web-domain-ssl-hsts`命令是Hestia面板管理系统中的一个有用工具，用于增强Web站点的安全性。通过启用HSTS，您可以确保浏览器仅通过HTTPS与您的网站进行通信，从而保护用户免受中间人攻击和其他安全威胁。但是，在启用HSTS之前，请确保您的网站已准备好处理HTTPS连接，并仔细考虑其潜在影响。

## v-add-web-domain-ssl-preset

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-web-domain-ssl-preset)

### 概述

`v-add-web-domain-ssl-preset` 是 Hestia 面板管理系统中的一个 CLI（命令行接口）命令，它用于在创建新的 Web 域名时预设 SSL 强制选项。由于 Let's Encrypt SSL 证书的发放可能会受到 DNS 传播延迟的影响，此命令允许管理员在域名创建时立即设置 SSL 强制选项，以便在 Let's Encrypt 证书生效后能够立即启用 SSL。

### 命令选项

- `USER`: 用户名，用于指定操作所属的用户账户。
- `DOMAIN`: 域名，要添加 SSL 预设的 Web 域名。
- `[SSL]`: 可选参数，用于指定是否立即启用 SSL 强制。如果提供此参数并设置为 "yes"，则会在创建域名时立即设置 SSL 强制选项。

### 示例

**示例 1**：为特定用户添加 Web 域名并预设 SSL 强制

```bash
v-add-web-domain-ssl-preset username.example.com yes
```

在这个示例中，假设我们已经登录到 Hestia 面板管理系统的 CLI 环境中，并且希望为用户 `username` 添加名为 `example.com` 的 Web 域名，并立即启用 SSL 强制。注意，这里我们省略了 `USER` 参数，因为 Hestia 的 CLI 环境通常已经为当前用户设置好了上下文。

**示例 2**：为指定用户添加 Web 域名并默认不启用 SSL 强制

```bash
v-add-web-domain-ssl-preset username example.org
```

在这个示例中，我们为用户 `username` 添加了名为 `example.org` 的 Web 域名，但没有立即启用 SSL 强制。这是因为我们没有提供 `[SSL]` 参数，或者提供了但设置为 "no"（默认值）。

### 注意事项

- 在使用此命令之前，请确保您已经登录到 Hestia 面板管理系统的 CLI 环境中，并且具有足够的权限来执行此操作。
- 请仔细检查您提供的用户名和域名是否正确，以避免不必要的错误和混淆。
- 如果您在创建域名后需要更改 SSL 强制选项，可以使用 Hestia 面板的 Web 界面或相应的 CLI 命令来进行更改。

### 结论

`v-add-web-domain-ssl-preset` 命令为 Hestia 面板管理系统提供了一种方便的方式来在创建新的 Web 域名时预设 SSL 强制选项。通过正确地使用此命令，您可以确保在 Let's Encrypt SSL 证书生效后能够立即启用 SSL，从而提高 Web 站点的安全性和可靠性。

## v-add-web-domain-stats

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-web-domain-stats)

Hestia面板管理系统为用户提供了丰富的CLI（命令行接口）命令，以简化服务器和网站的管理任务。其中，`v-add-web-domain-stats` 命令用于为特定域名启用日志分析系统，从而生成域名的统计信息。

### 命令概述

`v-add-web-domain-stats` 命令用于为指定的用户、域名和统计类型启用日志分析系统。启用后，用户可以通过特定的URL（如 `http://domain.tld/vstats/`）查看域名的统计信息。

### 命令语法

```bash
v-add-web-domain-stats USER DOMAIN TYPE
```

* `USER`：指定要为其启用日志分析系统的用户。
* `DOMAIN`：要启用日志分析的域名。
* `TYPE`：指定要使用的统计类型（如 `awstats`）。

### 示例

#### 示例 1：为基本用户启用awstats统计

假设我们有一个名为 `admin` 的用户，并且想要为其域名 `example.com` 启用 `awstats` 统计。可以使用以下命令：

```bash
v-add-web-domain-stats admin example.com awstats
```

执行上述命令后，系统将为 `admin` 用户的 `example.com` 域名启用 `awstats` 统计。用户可以通过访问 `http://example.com/vstats/` 来查看统计信息（注意：默认情况下，此页面不受密码保护）。

#### 示例 2：为高级用户启用自定义统计类型

如果Hestia支持其他统计类型（假设为 `customstats`），并且我们想要为 `premiumuser` 用户的 `customdomain.net` 启用该统计类型，可以使用以下命令：

```bash
v-add-web-domain-stats premiumuser customdomain.net customstats
```

同样地，执行上述命令后，系统将为 `premiumuser` 用户的 `customdomain.net` 域名启用 `customstats` 统计。

### 注意事项

* 在使用 `v-add-web-domain-stats` 命令之前，请确保已正确安装和配置了相应的日志分析系统（如 `awstats`）。
* 如果想要通过密码保护统计信息页面，请使用 `v-add-web-domain_stat_auth` 脚本（此脚本不在本文档的讨论范围内）。
* 请注意，Hestia面板管理系统可能具有其他限制和依赖项，因此在使用CLI命令之前，请确保已阅读并理解了官方文档中的相关说明。

### 结论

`v-add-web-domain-stats` 命令是Hestia面板管理系统中一个非常有用的工具，它允许用户轻松地为域名启用日志分析系统并生成专业的统计信息。通过遵循上述指南和示例，您可以有效地利用此命令来管理您的网站和服务器。

## v-add-web-domain-stats-user

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-web-domain-stats-user)

### 命令介绍

`v-add-web-domain-stats-user` 是Hestia面板管理系统中的一个CLI（命令行界面）命令，用于为Web域名的统计页面添加密码保护。通过此命令，你可以轻松地为指定的Web域名设置统计页面的访问用户和密码。

### 使用方法

#### 基本语法

```bash
v-add-web-domain-stats-user USER DOMAIN STATS_USER STATS_PASSWORD [RESTART]
```

* `USER`: Hestia面板的用户名。
* `DOMAIN`: 要为其添加统计页面密码保护的Web域名。
* `STATS_USER`: 统计页面的用户名。
* `STATS_PASSWORD`: 统计页面的密码。
* `[RESTART]`: 可选参数，用于在修改后重启相关服务。

#### 示例

1. **基本示例**

为`admin`用户下的`example.com`域名设置统计页面的用户名为`watchdog`，密码为`your_password`：

```bash
v-add-web-domain-stats-user admin example.com watchdog your_password
```

2. **带重启的示例**

在修改后，直接重启相关服务：

```bash
v-add-web-domain-stats-user admin example.com watchdog your_password RESTART
```

### 注意事项

* 在执行此命令之前，请确保你有足够的权限来修改Hestia面板的配置。
* 如果在Hestia面板中启用了只读模式，该命令可能无法正常工作。
* 如果你的Hestia面板没有集成help命令系统，你可以参考官方文档或本文档来了解更多关于此命令的信息。

### 常见问题解答

* **问**：如何查看此命令的帮助信息？
* **答**：由于Hestia面板没有集成help命令系统，你需要参考官方文档或本文档来了解更多关于此命令的信息。
* **问**：如果我在执行命令时遇到了错误怎么办？
* **答**：请检查你的命令语法是否正确，以及你是否具有足够的权限来执行此命令。如果问题仍然存在，请查看官方文档或联系Hestia面板的技术支持以获取帮助。

### 总结

`v-add-web-domain-stats-user`命令是Hestia面板管理系统中的一个非常有用的工具，它允许你轻松地为Web域名的统计页面添加密码保护。通过本文档，你可以了解如何使用此命令，并通过示例来熟悉其用法。如果你在使用过程中遇到任何问题，请随时参考官方文档或联系技术支持以获取帮助。

## 修改系列命令

## v-change-web-domain-httpauth

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-web-domain-httpauth)

### 概述

`v-change-web-domain-httpauth` 是 Hestia 面板管理系统提供的一个 CLI 命令，用于更改指定 web 域名下的 HTTP 基本认证用户的密码。此命令允许管理员在不登录面板的情况下，通过命令行快速修改 HTTP 认证凭据。

### 语法

```bash
v-change-web-domain-httpauth USER DOMAIN AUTH_USER AUTH_PASSWORD [RESTART]
```

- `USER`: Hestia 面板中的用户名。
- `DOMAIN`: 需要更改密码的 web 域名。
- `AUTH_USER`: 需要更改密码的 HTTP 基本认证用户名。
- `AUTH_PASSWORD`: 新的 HTTP 基本认证密码。
- `[RESTART]`: 可选参数，如果提供，则命令执行后会尝试重启 web 服务。

### 示例

#### 示例 1: 修改密码但不重启服务

```bash
v-change-web-domain-httpauth admin example.com john newpassword
```

这条命令会将 `example.com` 域名下 HTTP 基本认证用户 `john` 的密码修改为 `newpassword`，但不会尝试重启 web 服务。

#### 示例 2: 修改密码并重启服务

```bash
v-change-web-domain-httpauth admin example.com jane secretpassword123 restart
```

这条命令会将 `example.com` 域名下 HTTP 基本认证用户 `jane` 的密码修改为 `secretpassword123`，并在命令执行后尝试重启 web 服务。

### 注意事项

- 请确保您具有足够的权限来执行此命令。
- 在执行命令之前，请确保您已经备份了任何重要的配置文件或数据。
- 如果命令执行后遇到任何问题，请检查 Hestia 面板的日志文件以获取更多信息。

### 常见问题

- **Q**: 我忘记了 HTTP 基本认证用户的用户名怎么办？
  **A**: 您需要登录到 Hestia 面板来查看或重置 HTTP 基本认证用户的用户名。
- **Q**: 我可以一次为多个用户更改密码吗？
  **A**: 不可以，此命令一次只能为一个用户更改密码。但您可以多次运行此命令来为多个用户更改密码。
- **Q**: 如果我更改了密码但 web 服务没有重启，新的密码会生效吗？
  **A**: 是的，新的密码会立即生效，但重启 web 服务可以确保所有更改都已应用。

## v-change-web-domain-ip

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-web-domain-ip)

### 命令概述

`v-change-web-domain-ip` 是hestia面板管理系统提供的一个CLI（命令行接口）命令，用于更改指定Web域名的IP地址。该命令允许管理员通过命令行快速、便捷地更新域名的IP配置，无需手动编辑配置文件或重启服务。

### 命令语法

```bash
v-change-web-domain-ip USER DOMAIN IP [RESTART]
```

* `USER`: 用户名，需要具有对指定域名进行修改的权限。
* `DOMAIN`: 要更改IP的域名。
* `IP`: 新的IP地址。
* `[RESTART]`: 可选参数，指定是否重启相关服务以使更改生效。默认为不重启。

### 命令示例

#### 示例1：更改域名IP并重启服务

```bash
v-change-web-domain-ip admin example.com 192.168.1.100 yes
```

这个命令将把`example.com`域名的IP地址更改为`192.168.1.100`，并重启相关服务以使更改生效。

#### 示例2：仅更改域名IP，不重启服务

```bash
v-change-web-domain-ip admin example.com 192.168.1.101
```

这个命令将把`example.com`域名的IP地址更改为`192.168.1.101`，但不会重启相关服务。管理员可以在稍后手动重启服务或等待服务自动重新加载配置。

#### 示例3：错误用法示例

```bash
v-change-web-domain-ip user example.com 192.168.1.102 no
```

如果`user`不是有效的用户名或没有权限修改`example.com`域名的IP地址，该命令将失败并显示相应的错误消息。

### 注意事项

* 在使用`v-change-web-domain-ip`命令之前，请确保已正确安装并配置了hestia面板管理系统。
* 请使用具有足够权限的用户名来执行该命令，否则可能会导致权限不足的错误。
* 在更改域名IP地址之前，请确保新的IP地址是可用的，并且已正确配置在服务器上。
* 如果选择重启服务以使更改生效，请确保在重启之前保存所有未保存的工作，并通知可能受影响的用户。

### 常见问题解答

* **问**：如何查看hestia面板管理系统的CLI命令列表？
* **答**：您可以通过在hestia面板管理官方网站查询相关命令。
* **问**：如果我忘记了用户名或密码，该怎么办？
* **答**：如果您忘记了用户名或密码，请尝试使用hestia面板管理系统的密码恢复功能或联系系统管理员进行帮助。

## v-change-web-domain-name

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-web-domain-name)

### 介绍

Hestia面板管理系统为用户提供了丰富的CLI（命令行界面）命令，以便用户可以通过终端执行各种管理任务。其中，`v-change-web-domain-name`命令允许用户轻松更改网站域名。

### 命令语法

```bash
v-change-web-domain-name USER DOMAIN NEW_DOMAIN [RESTART]
```

- `USER`: 需要更改域名的用户的用户名。
- `DOMAIN`: 需要被更改的原始域名。
- `NEW_DOMAIN`: 替换原始域名的新域名。
- `[RESTART]`: 可选参数，如果设置为`yes`，则重新启动相关的Web服务以使更改生效。

### 示例

#### 示例1：基本用法

```bash
v-change-web-domain-name alice wonderland.com lookinglass.com
```

在这个例子中，我们为名为`alice`的用户将`wonderland.com`域名更改为`lookinglass.com`。由于我们没有指定`RESTART`参数，因此Web服务不会自动重启。

#### 示例2：带重启参数的用法

```bash
v-change-web-domain-name bob example.com newexample.com yes
```

在这个例子中，我们为名为`bob`的用户将`example.com`域名更改为`newexample.com`，并指定了`RESTART`参数为`yes`，因此相关的Web服务将会自动重启以使更改生效。

### 注意事项

- 在执行此命令之前，请确保新域名`NEW_DOMAIN`是有效的，并且您拥有对该域名的所有权或管理权限。
- 如果Web服务正在运行，并且您希望更改立即生效，请确保使用`RESTART`参数。
- 在执行此命令之前，请备份任何重要数据，以防万一出现意外情况。

### 常见问题

- **Q**: 我执行了命令，但更改没有生效怎么办？
  **A**: 请检查您是否指定了正确的用户名、原始域名和新域名。另外，如果您没有指定`RESTART`参数，请尝试手动重启Web服务。

- **Q**: 我收到一个错误消息，指出新域名已存在怎么办？
  **A**: 请确保您没有为新域名选择了一个已经存在的域名。您可以使用其他域名或检查您的Hestia面板以确认该域名是否已被其他用户或网站使用。

- **Q**: 如何在Hestia面板中查看更改后的域名？
  **A**: 登录到您的Hestia面板，导航到用户或网站的配置页面，您应该能够看到已更改的域名。

### 总结

`v-change-web-domain-name`命令是Hestia面板管理系统中的一个强大工具，它允许用户轻松更改网站域名。通过遵循上述示例和注意事项，您可以安全、有效地使用此命令来管理您的网站。

## v-change-web-domain-proxy-tpl

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-web-domain-proxy-tpl)

hestia面板管理系统是一款功能强大的服务器管理工具，它默认集成了多个CLI（命令行界面）命令，用于自动化和简化服务器的管理任务。其中，`v-change-web-domain-proxy-tpl`命令允许用户更改Web域名的代理模板，提供了灵活的配置选项和强大的功能。

### 命令概述

`v-change-web-domain-proxy-tpl`命令用于更改hestia面板中Web域名的代理模板设置。通过该命令，用户可以指定用户、域名、新模板以及其他可选参数，以实现对代理配置的快速修改。

### 命令语法

```bash
v-change-web-domain-proxy-tpl USER DOMAIN TEMPLATE [EXTENSIONS] [RESTART]
```

- **USER**：要更改配置的用户的用户名。
- **DOMAIN**：要更改配置的Web域名的名称。
- **TEMPLATE**：新的代理模板名称。
- **[EXTENSIONS]**：可选参数，指定需要应用新模板的文件扩展名列表（以逗号分隔）。如果不指定，将使用默认扩展名列表。
- **[RESTART]**：可选参数，指定是否需要重启代理服务以使更改生效。如果指定为"yes"，则在更改后自动重启代理服务。

### 示例

#### 示例1：基本用法

假设要将用户"admin"的域名"example.com"的代理模板更改为"new_template"，并自动重启代理服务，可以使用以下命令：

```bash
v-change-web-domain-proxy-tpl admin example.com new_template yes
```

#### 示例2：指定文件扩展名

如果只想将特定类型的文件应用新的代理模板，可以指定文件扩展名列表。例如，要将用户"john"的域名"johnsite.net"的代理模板更改为"image_proxy"，并仅对".jpg"和".png"文件生效，可以使用以下命令：

```bash
v-change-web-domain-proxy-tpl john johnsite.net image_proxy jpg,png
```

在这个例子中，只有".jpg"和".png"扩展名的文件将使用新的"image_proxy"模板。

#### 示例3：不重启代理服务

如果在更改配置后不希望立即重启代理服务，可以省略`[RESTART]`参数或将其设置为"no"。例如：

```bash
v-change-web-domain-proxy-tpl alice aliceshop.org mobile_template no
```

这个命令将更改用户"alice"的域名"aliceshop.org"的代理模板为"mobile_template"，但不会自动重启代理服务。用户可以在需要时手动重启服务以使更改生效。

### 注意事项

- 在使用`v-change-web-domain-proxy-tpl`命令之前，请确保已正确安装并配置了hestia面板管理系统。
- 请仔细检查提供的参数值是否正确，以避免不必要的错误和配置问题。
- 如果在更改配置后遇到任何问题，请检查hestia面板的日志文件以获取更多信息，并根据需要进行故障排除。

## v-change-web-domain-sslcert

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-web-domain-sslcert)

### 介绍

Hestia面板管理系统是一款功能强大的Web服务器控制面板，它为用户提供了直观易用的图形界面以及一系列强大的命令行工具（CLI），方便用户进行各种服务器配置和管理操作。其中，`v-change-web-domain-sslcert` 命令是Hestia CLI提供的一个用于更改Web域名SSL证书的重要工具。

### 功能描述

`v-change-web-domain-sslcert` 命令允许用户指定用户名、域名、SSL证书目录（可选）以及重启选项（可选），来更改指定Web域名的SSL证书。如果新的证书文件中包含CA文件，该命令也会自动替换旧的CA文件。

### 使用方法

#### 基本语法

```bash
v-change-web-domain-sslcert USER DOMAIN SSL_DIR [RESTART]
```

* `USER`：具有管理权限的用户名。
* `DOMAIN`：需要更改SSL证书的Web域名。
* `SSL_DIR`：包含新SSL证书和私钥的目录路径（可选）。
* `RESTART`：可选参数，如果设置为true或1，则在更改证书后重启Web服务（可选）。

#### 示例

1. **基本用法**（仅更改SSL证书，不重启服务）：

```bash
v-change-web-domain-sslcert admin example.com /path/to/new/ssl/certs/
```

在这个例子中，`admin` 是具有管理权限的用户名，`example.com` 是需要更改SSL证书的Web域名，`/path/to/new/ssl/certs/` 是包含新SSL证书和私钥的目录路径。

2. **完整用法**（更改SSL证书并重启服务）：

```bash
v-change-web-domain-sslcert admin example.com /path/to/new/ssl/certs/ 1
```

在这个例子中，除了基本用法的参数外，还指定了 `RESTART` 参数为1，表示在更改证书后重启Web服务。

### 注意事项

* 在使用 `v-change-web-domain-sslcert` 命令之前，请确保已经备份了旧的SSL证书和私钥，以防万一出现错误或问题。
* 在指定 `SSL_DIR` 参数时，请确保目录路径正确无误，并且该目录下包含了完整的SSL证书和私钥文件。
* 如果在更改SSL证书后遇到任何问题，可以尝试重启Web服务来解决问题。在重启之前，请确保已经保存了所有未完成的更改。

### 总结

`v-change-web-domain-sslcert` 命令是Hestia面板管理系统CLI提供的一个非常实用的工具，它允许用户方便地更改Web域名的SSL证书。通过掌握该命令的使用方法，用户可以更加灵活地管理自己的Web服务器，确保网站的安全性和可靠性。

## v-change-web-domain-sslhome

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-web-domain-sslhome)

hestia面板管理系统为管理员提供了强大的命令行接口（CLI），使得许多管理任务可以通过脚本或命令行直接执行。`v-change-web-domain-sslhome` 是其中一个命令，用于更改Web域名的SSL主目录。

### 命令概述

`v-change-web-domain-sslhome` 命令允许用户为指定的域名更改SSL主目录。它有两个主要的选项："single" 和 "same"，用于确定公共目录（`public_html` 或 `public_shtml`）的使用方式。

- **single**：将SSL目录设置为与常规HTTP目录分开的独立目录（通常是`public_shtml`）。
- **same**：将SSL目录设置为与常规HTTP目录相同（通常是`public_html`）。

### 命令语法

```bash
v-change-web-domain-sslhome USER DOMAIN SSL_HOME [RESTART]
```

- **USER**：执行命令的管理员用户名。
- **DOMAIN**：要更改SSL主目录的域名。
- **SSL_HOME**：新的SSL主目录的路径或选项（"single" 或 "same"）。
- **[RESTART]**：可选参数，如果提供，将重启相关的Web服务。

### 示例

#### 示例1：将域名的SSL目录设置为单独的目录

```bash
v-change-web-domain-sslhome admin acme.com single
```

此命令将把`acme.com`的SSL目录更改为单独的目录（通常是`public_shtml`），并假设当前用户为`admin`。

#### 示例2：将域名的SSL目录设置为与HTTP目录相同

```bash
v-change-web-domain-sslhome admin example.org same
```

此命令将把`example.org`的SSL目录设置为与HTTP目录相同（通常是`public_html`），并假设当前用户为`admin`。

#### 示例3：带有重启选项的命令

```bash
v-change-web-domain-sslhome admin anotherdomain.net single restart
```

此命令不仅将`anotherdomain.net`的SSL目录更改为单独的目录，而且将重启相关的Web服务。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限，并且了解更改SSL主目录可能带来的影响。
- 更改SSL主目录后，您可能需要更新任何与SSL配置相关的文件或脚本。
- 如果提供了`RESTART`选项，请确保在流量较低的时间段执行此命令，以避免服务中断对用户造成影响。

## v-change-web-domain-docroot

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-web-domain-docroot)

hestia面板管理系统是一个功能强大的Web服务器控制面板，它提供了丰富的功能和管理选项，使得Web服务器的配置和管理变得简单直观。在hestia面板中，除了图形化界面外，还集成了一系列CLI（命令行接口）命令，允许用户通过命令行的方式执行各种管理操作。其中，`v-change-web-domain-docroot`命令用于更改已存在Web域名的文档根目录。

### 命令概述

`v-change-web-domain-docroot`命令允许用户将指定Web域名的文档根目录更改为另一个域名的文档根目录，或者将其重置为默认值。这对于需要快速复制或修改网站结构的管理员来说非常有用。

### 命令语法

```bash
v-change-web-domain-docroot USER DOMAIN TARGET_DOMAIN [DIRECTORY] [PHP]
```

* `USER`：要执行此操作的用户名。
* `DOMAIN`：要更改文档根目录的Web域名。
* `TARGET_DOMAIN`：目标Web域名，其文档根目录将被用作新的文档根目录。如果要重置为默认值，则可以使用`default`作为此参数的值。
* `[DIRECTORY]`（可选）：指定新的文档根目录路径。如果省略此参数，则默认使用`TARGET_DOMAIN`的文档根目录。
* `[PHP]`（可选）：指定是否启用PHP支持。如果省略此参数，则保持原样。

### 示例

#### 示例1：将domain.tld的文档根目录更改为otherdomain.tld的文档根目录

```bash
v-change-web-domain-docroot admin domain.tld otherdomain.tld
```

此命令将`domain.tld`的文档根目录更改为与`otherdomain.tld`相同的目录。

#### 示例2：将test.local的文档根目录重置为默认值

```bash
v-change-web-domain-docroot admin test.local default
```

此命令将`test.local`的文档根目录重置为其在hestia面板中的默认值。

#### 示例3：将example.com的文档根目录更改为/home/user/new_website

```bash
v-change-web-domain-docroot admin example.com default /home/user/new_website
```

此命令将`example.com`的文档根目录更改为`/home/user/new_website`，同时保持PHP支持设置不变。

### 注意事项

* 在执行此命令之前，请确保您有足够的权限来更改Web域名的文档根目录。
* 在更改文档根目录之前，请确保目标目录存在并且具有适当的读写权限。
* 如果目标Web域名不存在或不可用，则此命令可能会失败。
* 在使用此命令之前，请务必备份重要的网站数据以防止意外丢失。

## v-change-web-domain-stats

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-web-domain-stats)

### 概述

`v-change-web-domain-stats` 是hestia面板管理系统提供的一个CLI（命令行界面）命令，用于更改或管理Web域名的统计信息。该命令允许管理员通过指定用户、域名和统计类型来更改站点的统计系统。

### 使用方法

#### 命令格式

```bash
v-change-web-domain-stats USER DOMAIN TYPE
```

* `USER`：指定要操作的用户名。
* `DOMAIN`：指定要操作的域名。
* `TYPE`：指定要使用的统计类型。

#### 示例

1. **更改admin用户的example.com域名的统计类型为awstats**

```bash
v-change-web-domain-stats admin example.com awstats
```

这个命令将会把admin用户的example.com域名的统计系统更改为awstats。

2. **更改test用户的test.com域名的统计类型为webalizer**

```bash
v-change-web-domain-stats test test.com webalizer
```

这个命令将会把test用户的test.com域名的统计系统更改为webalizer。

### 注意事项

* 使用该命令前，请确保已经登录到hestia面板管理系统的CLI环境。
* 确保提供的用户名、域名和统计类型是正确且存在的。
* 根据hestia的配置，可能还需要其他参数或选项。请参考hestia的官方文档或CLI帮助信息以获取更多详细信息。

### 常见问题

* **错误：未知的用户名或域名**
    + 检查提供的用户名和域名是否正确。
    + 确保该用户和域名在hestia面板管理系统中存在且未被暂停。
* **错误：不支持的统计类型**
	+ 检查提供的统计类型是否正确。
	+ 确保hestia面板管理系统支持该统计类型。

### 结论

`v-change-web-domain-stats` 是hestia面板管理系统提供的一个强大的CLI命令，用于更改Web域名的统计信息。通过该命令，管理员可以轻松地更改站点的统计系统，以满足不同的需求。

## v-change-web-domain-tpl

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-web-domain-tpl)

### 简介

hestia面板管理系统作为一款功能强大的服务器管理工具，为用户提供了丰富的命令行接口（CLI）命令，以简化各种系统操作。其中，`v-change-web-domain-tpl`命令用于更改Web域名的模板配置，使得用户能够方便地定制和优化其Web服务。

### 命令语法

```bash
v-change-web-domain-tpl USER DOMAIN TEMPLATE [RESTART]
```

* `USER`: 具有操作权限的用户名。
* `DOMAIN`: 需要更改模板的域名。
* `TEMPLATE`: 新的Web配置模板名称。
* `[RESTART]`: 可选参数，如果指定，则在更改模板后重启Web服务。

### 示例

#### 示例1：基本用法

假设用户`admin`希望将域名`example.com`的Web配置模板更改为`wordpress`，并且不需要重启Web服务，可以使用以下命令：

```bash
v-change-web-domain-tpl admin example.com wordpress
```

#### 示例2：带重启选项

如果用户希望在更改模板后立即重启Web服务，可以添加`RESTART`参数：

```bash
v-change-web-domain-tpl admin example.com wordpress RESTART
```

### 注意事项

* 在执行`v-change-web-domain-tpl`命令之前，请确保您具有足够的权限来更改Web配置。
* 更改模板后，Web服务的配置将更新为所选模板的默认设置。请确保所选模板符合您的需求。
* 如果指定了`RESTART`参数，请确保Web服务能够正常重启，并且不会对现有服务造成任何中断。

### 结论

`v-change-web-domain-tpl`命令是hestia面板管理系统中一个非常实用的CLI命令，它允许用户轻松地更改Web域名的配置模板。通过结合不同的参数和选项，用户可以根据自己的需求定制和优化Web服务。希望本文的介绍和示例能够帮助您更好地理解和使用此命令。

## v-change-user-theme

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-user-theme)

### 介绍

`v-change-user-theme` 是Hestia面板管理系统中的一个CLI（命令行接口）命令，用于更改指定用户的Web UI显示主题。该命令允许管理员通过命令行方式快速为用户设置或更改其界面主题，提供灵活的用户界面定制选项。

### 语法

```bash
v-change-user-theme USER THEME
```

- `USER`: 要更改主题的用户名。
- `THEME`: 要应用的主题名称。

### 示例

#### 示例1：将admin用户的主题更改为dark

```bash
v-change-user-theme admin dark
```

执行上述命令后，admin用户的Web UI界面主题将被更改为dark主题。

#### 示例2：将peter用户的主题更改为vestia

```bash
v-change-user-theme peter vestia
```

执行上述命令后，peter用户的Web UI界面主题将被更改为vestia主题。

### 注意事项

- 在执行`v-change-user-theme`命令之前，请确保已经正确安装并配置了Hestia面板管理系统。
- 确保提供的用户名（USER）和主题名（THEME）是系统中存在且有效的。
- 如果指定的主题不存在，命令可能会失败并显示相应的错误信息。
- 使用该命令时，请确保具有足够的权限来更改用户设置。

### 返回值和日志

执行`v-change-user-theme`命令后，系统将根据操作的成功或失败返回相应的状态码。同时，Hestia面板管理系统还会记录相关的日志信息，以便管理员进行后续的跟踪和审计。

### 总结

`v-change-user-theme`命令是Hestia面板管理系统中的一个实用工具，允许管理员通过命令行方式快速更改用户的Web UI界面主题。通过提供灵活的用户界面定制选项，该命令为管理员和用户提供了更好的使用体验。

## v-change-web-domain-backend-tpl

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-web-domain-backend-tpl)

### 简介

`v-change-web-domain-backend-tpl` 是hestia面板管理系统提供的一个CLI（命令行界面）命令，用于更改Web域名的后端模板。该命令允许管理员或用户快速、便捷地修改Web服务器上的后端配置，以适应不同的应用需求或技术栈。

### 语法

```bash
v-change-web-domain-backend-tpl USER DOMAIN TEMPLATE [RESTART]
```

* **USER**: 需要执行该操作的用户的用户名。
* **DOMAIN**: 要更改其后端模板的域名。
* **TEMPLATE**: 目标后端模板的名称或标识符。
* **[RESTART]**: 可选参数，如果提供，则命令执行后会重启Web服务器以使更改生效。

### 示例

#### 示例1：更改域名后端模板

假设我们要为`admin`用户下的`example.com`域名更改其后端模板为`PHP-7_4`，并且不重启Web服务器，可以执行以下命令：

```bash
v-change-web-domain-backend-tpl admin example.com PHP-7_4
```

执行成功后，hestia面板将自动更新`example.com`域名的后端配置，以使用`PHP-7_4`模板。

#### 示例2：更改域名后端模板并重启Web服务器

如果我们希望在更改后端模板后立即重启Web服务器，可以添加`RESTART`参数：

```bash
v-change-web-domain-backend-tpl admin example.com PHP-7_4 RESTART
```

执行此命令后，hestia面板将更新`example.com`域名的后端配置，并使用`PHP-7_4`模板。然后，它将自动重启Web服务器以使更改生效。

### 注意事项

1. **用户权限**：执行该命令的用户必须具有足够的权限来更改目标域名的后端配置。
2. **模板存在性**：指定的后端模板必须在hestia面板的可用模板列表中存在。
3. **服务器状态**：在执行命令时，确保Web服务器处于可用状态，以便在需要时成功重启。
4. **命令反馈**：该命令将在执行时提供有关操作的反馈和任何潜在的错误消息。请务必仔细阅读这些输出，以确保命令已成功执行并达到预期效果。

## 删除系列命令

## v-delete-web-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-web-domain)

hestia面板管理系统是一个功能强大的服务器控制面板，它为用户提供了直观易用的图形界面来管理服务器资源。然而，对于高级用户或需要自动化任务的用户来说，hestia还提供了丰富的命令行接口（CLI）命令，这些命令可以通过shell脚本或自动化工具来执行。

`v-delete-web-domain`是hestia CLI中的一个重要命令，用于删除Web域名及其相关组件。在删除之前，请务必谨慎操作，并确保您已经备份了重要数据，因为该操作可能会导致数据丢失且难以恢复。

### 命令语法

```bash
v-delete-web-domain USER DOMAIN [RESTART]
```

* `USER`: 需要删除Web域名的用户名。
* `DOMAIN`: 要删除的Web域名。
* `[RESTART]`: 可选参数，如果提供，则在删除域名后重新启动Web服务。

### 示例

#### 示例1：删除域名而不重启服务

```bash
v-delete-web-domain admin wonderland.com
```

此命令将删除用户名为`admin`的用户的`wonderland.com`域名及其相关组件，但不会重启Web服务。

#### 示例2：删除域名并重启服务

```bash
v-delete-web-domain admin wonderland.com RESTART
```

此命令除了删除域名及其相关组件外，还会重启Web服务。这通常用于确保删除操作后Web服务的配置得到更新。

### 注意事项

* 在执行`v-delete-web-domain`命令之前，请确保您已经备份了所有重要数据，因为该命令会删除域名及其所有相关组件，包括统计信息、文件夹内容、SSL证书等。
* 请注意，该操作不是完全受“撤销”功能支持的，因此数据恢复通常只能通过保留的备份来实现。
* 如果在只读模式下运行hestia面板，则可能无法执行此命令。请确保您的面板处于正常模式，以便能够执行删除操作。

### 结论

`v-delete-web-domain`是hestia面板管理系统中的一个强大工具，它允许用户通过命令行接口来删除Web域名及其相关组件。通过提供示例和注意事项，本文旨在帮助用户更好地理解和使用该命令。然而，请务必谨慎操作，并确保在执行任何删除操作之前已经备份了重要数据。

## v-delete-web-domain-alias

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-web-domain-alias)

### 介绍

在hestia面板管理系统中，`v-delete-web-domain-alias` 是一个用于删除Web域名别名的CLI（命令行接口）命令。通过此命令，管理员可以轻松地移除或删除已设置的域名别名（也称为停放域名），从而提高域名管理的效率和灵活性。

### 使用方法

基本语法如下：

```bash
v-delete-web-domain-alias USER DOMAIN ALIAS [RESTART]
```

* `USER`：执行该命令的hestia面板用户的用户名。
* `DOMAIN`：要删除别名的主域名。
* `ALIAS`：要删除的域名别名。
* `[RESTART]`：可选参数，如果指定，则命令执行后会重启Web服务器。

### 示例

#### 示例1：删除一个域名别名

假设我们有一个名为`example.com`的域名，并且想要删除其别名`www.example.com`，我们可以使用以下命令：

```bash
v-delete-web-domain-alias admin example.com www.example.com
```

注意：在这个例子中，`admin`是执行该命令的hestia面板用户的用户名。

#### 示例2：删除多个域名别名并重启Web服务器

如果我们想要同时删除多个域名别名，并在操作后重启Web服务器，可以使用以下命令：

```bash
v-delete-web-domain-alias admin example.com "www.example.com,mobile.example.com" restart
```

在这个例子中，我们同时删除了`www.example.com`和`mobile.example.com`这两个别名，并在操作后通过`restart`参数指定了重启Web服务器。

### 注意事项

* 在执行此命令之前，请确保您具有足够的权限来删除指定的域名别名。
* 如果指定了`[RESTART]`参数，那么Web服务器将在命令执行后被重启。这可能会导致短暂的Web服务中断，请确保在合适的时间执行此操作。
* 如果指定的域名别名不存在，该命令将返回一个错误消息。请仔细检查您输入的别名是否正确。

### 结论

`v-delete-web-domain-alias`是hestia面板管理系统中一个非常有用的CLI命令，它允许管理员轻松地删除Web域名别名。通过掌握该命令的使用方法，您可以更加高效和灵活地管理您的域名资源。

## v-delete-web-domain-allow-users

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-web-domain-allow-users)

### 简介

hestia面板管理系统是一个功能强大的服务器控制面板，它为用户提供了直观的图形界面以及一套完善的命令行接口（CLI），方便用户进行各种服务器配置和管理操作。其中，`v-delete-web-domain-allow-users` 命令就是CLI中的一个重要工具，用于管理特定域名下允许创建子域名的用户列表。

### 命令功能

`v-delete-web-domain-allow-users` 命令用于从特定域名的允许创建子域名用户列表中删除指定用户。这样，被删除的用户将无法再为该域名创建子域名。

### 命令格式

```bash
v-delete-web-domain-allow-users 用户名 域名
```

* `用户名`：要从允许创建子域名用户列表中删除的用户名。
* `域名`：要管理的域名。

### 示例

#### 示例1：删除用户"user1"从"example.com"的允许创建子域名用户列表

```bash
v-delete-web-domain-allow-users user1 example.com
```

执行上述命令后，用户"user1"将不再被允许为"example.com"创建子域名。

#### 示例2：删除多个用户从域名的允许创建子域名用户列表

虽然`v-delete-web-domain-allow-users`命令一次只能处理一个用户名，但你可以通过编写一个简单的循环来批量处理多个用户。例如，假设你有一个用户列表文件`users_to_delete.txt`，每行包含一个用户名，你可以使用以下bash脚本来批量删除这些用户：

```bash
#!/bin/bash

DOMAIN="example.com"
while IFS= read -r USER; do
    v-delete-web-domain-allow-users "$USER" "$DOMAIN"
done < "users_to_delete.txt"
```

将上述脚本保存为一个文件（例如`delete_users.sh`），然后在终端中运行`bash delete_users.sh`即可批量删除指定的用户。

### 注意事项

* 在执行`v-delete-web-domain-allow-users`命令之前，请确保你具有足够的权限来执行该操作。
* 在删除用户之前，请确保该用户确实不再需要为该域名创建子域名，以免误操作导致不必要的麻烦。
* 如果hestia面板管理系统有更新或版本差异，请查阅官方文档以获取最准确的命令使用方法和功能说明。

## v-delete-web-domain-backend

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-web-domain-backend)

### 简介

`v-delete-web-domain-backend` 是 Hestia 面板管理系统中的一个 CLI（命令行接口）命令，用于删除 Web 域名后端配置。该命令能够简化 Web 服务器管理任务，使管理员能够轻松地从后端配置中移除不再需要的域名设置。

### 使用方法

基本语法如下：

```bash
v-delete-web-domain-backend USER DOMAIN [RESTART]
```

- `USER`：执行操作的用户名。
- `DOMAIN`：要删除配置的域名。
- `[RESTART]`：可选参数，如果提供，命令执行后将重启相关服务。

### 示例

#### 示例1：删除域名后端配置（不重启服务）

```bash
v-delete-web-domain-backend admin acme.com
```

在这个示例中，用户 `admin` 删除了域名 `acme.com` 的后端配置。没有提供 `[RESTART]` 参数，因此服务不会被重启。

#### 示例2：删除域名后端配置并重启服务

```bash
v-delete-web-domain-backend admin example.com restart
```

在这个示例中，用户 `admin` 删除了域名 `example.com` 的后端配置，并通过提供 `restart` 参数指定了在操作完成后重启相关服务。

### 注意事项

- 在使用此命令之前，请确保您已经正确安装了 Hestia 面板管理系统，并且您有足够的权限来执行此操作。
- 删除域名后端配置可能会影响到正在运行的网站，请确保在删除之前已经备份了所有重要数据。
- 如果提供了 `[RESTART]` 参数，命令执行后可能会暂时中断服务的可用性，直到重启完成。

### 常见问题

- **Q**：如果执行命令后服务没有按预期重启怎么办？
  **A**：请检查您是否以正确的用户身份运行命令，并且确认服务是否有足够的权限来执行重启操作。此外，检查是否有任何错误消息输出，并按照消息中的指示进行故障排除。

- **Q**：如何确认域名后端配置已被成功删除？
  **A**：您可以通过检查 Hestia 面板管理系统的配置界面或使用其他适当的命令来验证域名后端配置是否已被成功删除。

### 结论

`v-delete-web-domain-backend` 命令是 Hestia 面板管理系统中的一个强大工具，它允许管理员轻松地删除不再需要的域名后端配置。通过遵循上述示例和注意事项，您可以安全地执行此操作并维护您的 Web 服务器环境。

## v-delete-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-domain)

Hestia面板管理系统是一个功能强大的服务器控制面板，它为用户提供了直观易用的Web界面来管理服务器资源。除此之外，Hestia还集成了一系列命令行接口（CLI）命令，允许用户通过终端执行各种管理任务。其中，`v-delete-domain`命令用于删除Web、DNS和邮件域名。

### 命令概述

`v-delete-domain`命令用于从Hestia面板管理系统中删除指定的Web、DNS和邮件域名。该命令接受两个必需参数：用户名（USER）和域名（DOMAIN），以及一个可选参数用于控制服务重启。

### 命令语法

```bash
v-delete-domain USER DOMAIN [RESTART]
```

* `USER`：要执行删除操作的用户名。
* `DOMAIN`：要删除的域名。
* `RESTART`（可选）：控制服务重启的参数。默认为`yes`，表示在删除后重启相关服务；可以设置为`no`来禁用重启。

### 示例

#### 示例1：删除域名并重启服务

```bash
v-delete-domain admin example.com
```

这个命令将删除用户`admin`下的`example.com`域名，并在删除后重启相关服务。

#### 示例2：删除域名但不重启服务

```bash
v-delete-domain admin example.com no
```

这个命令将删除用户`admin`下的`example.com`域名，但在删除后不重启相关服务。

#### 示例3：结合其他命令使用

在实际使用中，`v-delete-domain`命令可以与其他Hestia CLI命令结合使用，以实现更复杂的自动化任务。例如，可以先使用`v-backup-domain`命令备份要删除的域名，然后再使用`v-delete-domain`命令进行删除操作。

### 注意事项

* 在执行`v-delete-domain`命令之前，请确保您已经正确设置了Hestia面板管理系统的环境变量和配置文件。
* 请谨慎使用`v-delete-domain`命令，因为它将永久删除指定的域名及其相关配置和数据。在执行此命令之前，请务必确认您不再需要该域名及其相关资源。
* 如果在删除过程中遇到任何问题或错误，请查看Hestia面板管理系统的日志文件以获取更多信息，并根据需要进行故障排除。

## v-delete-web-domain-ftp

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-web-domain-ftp)

### 概述

`v-delete-web-domain-ftp` 是Hestia面板管理系统提供的CLI（命令行接口）命令之一，用于删除指定域名下的FTP账户。通过该命令，管理员可以快速、安全地管理FTP账户，确保系统的安全性和稳定性。

### 语法

```bash
v-delete-web-domain-ftp USER DOMAIN FTP_USER
```

- `USER`: 执行该命令的用户名，通常为具有足够权限的管理员用户。
- `DOMAIN`: 要删除FTP账户的域名。
- `FTP_USER`: 要删除的FTP账户的用户名。

### 示例

#### 示例1：删除名为`bob_ftp`的FTP账户

假设要删除域名`example.com`下名为`bob_ftp`的FTP账户，可以使用以下命令：

```bash
v-delete-web-domain-ftp admin example.com bob_ftp
```

在这里，`admin`是执行命令的管理员用户名，`example.com`是要删除FTP账户的域名，`bob_ftp`是要删除的FTP账户的用户名。

#### 示例2：使用变量执行命令

在实际使用中，为了更灵活地管理FTP账户，可以将域名和FTP账户用户名存储在变量中，并通过变量执行命令。例如：

```bash
#!/bin/bash

# 定义变量
USER="admin"
DOMAIN="example.com"
FTP_USER="bob_ftp"

# 执行命令
v-delete-web-domain-ftp "$USER" "$DOMAIN" "$FTP_USER"
```

### 注意事项

1. **权限问题**：执行`v-delete-web-domain-ftp`命令的用户必须具有足够的权限来删除FTP账户。否则，命令将无法执行或产生错误。
2. **输入验证**：在编写脚本或使用该命令时，请确保输入的域名和FTP账户用户名是有效的，并且确实存在于系统中。否则，命令可能会产生错误或意外地删除其他账户。
3. **日志记录**：为了跟踪和审计系统操作，建议在执行`v-delete-web-domain-ftp`命令时记录相关的日志信息。这有助于在出现问题时快速定位和解决问题。

### 结论

`v-delete-web-domain-ftp`是Hestia面板管理系统提供的一个强大且实用的CLI命令，用于删除指定域名下的FTP账户。通过灵活使用该命令，管理员可以高效地管理FTP账户，确保系统的安全性和稳定性。

## v-delete-web-domain-httpauth

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-web-domain-httpauth)

### 命令概述

`v-delete-web-domain-httpauth` 是hestia面板管理系统提供的一个CLI（命令行接口）命令，用于删除Web域名的HTTP认证用户。该命令允许管理员通过简单的命令行操作，移除指定域名下的特定HTTP认证用户，从而增强Web服务器的安全性。

### 命令语法

```bash
v-delete-web-domain-httpauth USER DOMAIN AUTH_USER [RESTART]
```

- `USER`: 域名所属的用户名（通常是hestia面板的用户名）。
- `DOMAIN`: 要删除HTTP认证用户的域名。
- `AUTH_USER`: 要删除的HTTP认证用户名。
- `[RESTART]`: 可选参数，指定是否重启Web服务器以使更改生效。默认为"yes"。

### 示例

#### 示例1：删除HTTP认证用户

```bash
v-delete-web-domain-httpauth admin example.com alice
```

这个命令将从`example.com`域名中删除名为`alice`的HTTP认证用户。如果`RESTART`参数未指定，hestia将默认重启Web服务器以使更改生效。

#### 示例2：删除HTTP认证用户并明确指定不重启

```bash
v-delete-web-domain-httpauth admin example.com bob no
```

这个命令将从`example.com`域名中删除名为`bob`的HTTP认证用户，并明确指定不重启Web服务器。管理员可以在稍后手动重启服务器，或者等待下一次计划内的重启。

### 注意事项

- 在执行此命令之前，请确保您已正确备份了相关配置文件和数据库，以防意外情况发生。
- 如果您不确定某个HTTP认证用户是否存在，可以先使用hestia面板的Web界面进行查看和确认。
- 如果在执行命令后遇到问题，请检查hestia面板的日志文件以获取更多信息，并考虑重新加载或重启Web服务器。

### 总结

`v-delete-web-domain-httpauth`命令是hestia面板管理系统提供的一个强大工具，用于管理Web域名的HTTP认证用户。通过简单的命令行操作，管理员可以轻松地删除不再需要的HTTP认证用户，提高Web服务器的安全性。请务必谨慎使用此命令，并确保在执行之前已充分了解其功能和潜在影响。

## v-delete-web-domain-proxy

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-web-domain-proxy)

### 简介

`v-delete-web-domain-proxy` 是hestia面板管理系统提供的一个CLI（命令行界面）命令，用于删除指定用户的Web域名代理配置。该命令简化了手动编辑配置文件的过程，通过简单的命令行操作即可完成配置的删除。

### 用法

```bash
v-delete-web-domain-proxy USER DOMAIN [RESTART]
```

- `USER`：需要删除代理配置的用户名。
- `DOMAIN`：需要删除代理配置的域名。
- `[RESTART]`：可选参数，如果提供，则在删除配置后重启代理服务。

### 示例

#### 示例1：删除用户alice的lookinglass.com域名代理配置

```bash
v-delete-web-domain-proxy alice lookinglass.com
```

执行上述命令后，hestia面板将删除用户alice的lookinglass.com域名的代理配置。

#### 示例2：删除用户bob的example.org域名代理配置并重启代理服务

```bash
v-delete-web-domain-proxy bob example.org RESTART
```

执行上述命令后，hestia面板将删除用户bob的example.org域名的代理配置，并重启代理服务以确保配置更改生效。

### 注意事项

- 在执行删除操作之前，请确保已备份重要配置文件或数据库，以防止意外数据丢失。
- 重启代理服务可能会中断正在进行的Web服务，请确保在合适的时机执行该操作。
- 如果在执行命令时遇到错误或问题，请检查命令语法是否正确，并确保您具有足够的权限来执行该命令。

### 结论

`v-delete-web-domain-proxy` 命令是hestia面板管理系统提供的一个强大工具，用于快速删除指定用户的Web域名代理配置。通过简单的命令行操作，您可以轻松管理hestia面板中的代理配置，提高工作效率。

## 重启系列命令

## v-restart-web

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-restart-web)

### 简介

hestia面板管理系统默认集成了多种CLI（命令行界面）命令，用于执行各种系统级操作。其中，`v-restart-web`命令是用于重启web服务器的专业工具，对于系统管理员和开发者来说，它是一个非常实用的功能。

### 命令描述

`v-restart-web`命令的主要功能是重新加载web服务器的配置并重启web服务。当web服务器配置发生更改时，使用该命令可以确保更改生效，并且web服务能够继续正常运行。

### 使用方法

在hestia面板管理系统的CLI环境中，你可以直接输入`v-restart-web`命令来执行重启操作。该命令支持多种选项和参数，以满足不同场景下的需求。

#### 基本用法

```bash
v-restart-web
```

直接执行上述命令将触发web服务器的重启操作。在重启过程中，系统将会重新加载web服务器的配置文件，并尝试以新的配置启动web服务。

#### 示例

1. **无条件重启**

如果你希望无条件地重启web服务器，无论当前配置是否有更改，都可以使用基本用法：

```bash
v-restart-web
```

执行该命令后，系统将立即开始重启web服务器的过程。

2. **检查配置后重启**

在某些情况下，你可能希望在重启之前先检查web服务器的配置是否正确。虽然`v-restart-web`命令本身并不直接提供配置检查功能，但你可以结合其他工具或命令来实现这一需求。例如，你可以使用`apache2ctl configtest`（对于Apache服务器）或类似的命令来检查配置文件的正确性，然后再执行`v-restart-web`命令进行重启。

```bash
apache2ctl configtest && v-restart-web
```

上述命令首先使用`apache2ctl configtest`检查Apache的配置文件，如果配置正确（返回值为0），则继续执行`v-restart-web`命令进行重启。

### 注意事项

* 在执行`v-restart-web`命令之前，请确保已经保存了所有对web服务器配置文件的更改，并且这些更改是有效的。
* 在重启过程中，web服务将会暂时中断，直到新的配置生效并成功启动web服务为止。因此，在执行该命令之前，请确保已经通知了相关的用户或应用程序，以避免造成不必要的困扰或损失。
* 如果在重启过程中遇到任何问题或错误，请查看hestia面板管理系统的日志文件以获取更多信息，并根据需要进行故障排除。

## v-restart-web-backend

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-restart-web-backend)

hestia面板管理系统是一套功能强大的服务器管理工具，其中包含了多种CLI（命令行界面）命令，以方便用户通过终端直接对服务器进行管理。`v-restart-web-backend`命令是其中之一，主要用于重启web后端服务。

### 命令功能

`v-restart-web-backend`命令的主要功能是重启hestia面板管理系统所管理的web后端服务，如Nginx、PHP-FPM等。这可以在不中断服务的情况下，重新加载配置文件，实现服务的平滑重启。

### 使用方法

在终端中，使用以下格式执行`v-restart-web-backend`命令：

```bash
v-restart-web-backend [选项]
```

* 选项：该命令支持一些可选参数，用于指定重启的方式或行为。具体参数和用法请参考hestia面板管理系统的官方文档。

### 示例

#### 示例1：直接重启web后端服务

```bash
v-restart-web-backend
```

执行上述命令后，hestia面板管理系统将尝试重启当前正在运行的web后端服务。重启过程中，服务将保持在线状态，用户访问不会受到影响。

#### 示例2：带参数重启web后端服务（假设支持）

假设`v-restart-web-backend`命令支持一个名为`--force`的参数，用于强制重启服务，即使服务当前处于忙碌状态。则可以使用以下命令：

```bash
v-restart-web-backend --force
```

执行上述命令后，hestia面板管理系统将无视服务当前的状态，强制重启web后端服务。请注意，在实际使用中，应谨慎使用此类强制重启选项，以免对服务造成不必要的干扰或中断。

### 注意事项

* 在执行`v-restart-web-backend`命令之前，请确保您已经以具有足够权限的用户身份登录到服务器。通常，这需要您使用root用户或具有sudo权限的用户执行该命令。
* 在执行命令之前，请务必备份重要数据，以防意外情况导致数据丢失或损坏。
* 如果您在使用`v-restart-web-backend`命令时遇到问题或错误，请参考hestia面板管理系统的官方文档或寻求专业技术支持。

## v-rebuild-web-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-rebuild-web-domain)

### 简介

Hestia面板是一个功能强大的服务器控制面板，为用户提供了图形界面与命令行界面(CLI)的双重管理方式。其中，`v-rebuild-web-domain`是Hestia面板提供的一个CLI命令，用于重新构建Web域名的配置文件。

### 使用方法

#### 基本语法

```bash
v-rebuild-web-domain USER DOMAIN [RESTART]
```

- `USER`: 要重新构建配置的Web用户的用户名。
- `DOMAIN`: 要重新构建配置的Web域名。
- `[RESTART]`: 可选参数，用于在重新构建配置后重启Web服务器。如果提供此参数，则会在配置重新构建完成后尝试重启Web服务器。

#### 示例

1. **基本用法**：重新构建名为"exampleuser"的用户对应的"example.com"域名的配置文件。

```bash
v-rebuild-web-domain exampleuser example.com
```

2. **带重启参数**：重新构建配置并在完成后重启Web服务器。

```bash
v-rebuild-web-domain exampleuser example.com restart
```

### 注意事项

- 在执行此命令之前，请确保您已经以具有足够权限的用户身份登录到服务器。
- 如果在重新构建配置时遇到任何问题，请检查Hestia面板的日志文件以获取更多信息。
- 重启Web服务器可能会暂时中断网站服务，因此请确保在合适的时间段内执行此操作。

### 常见问题解答

- **Q**：如何确定我的命令是否执行成功？
- **A**：通常，如果命令没有返回任何错误信息，并且您可以通过浏览器访问您的网站而没有问题，那么可以认为命令执行成功。您还可以检查Hestia面板的日志文件以获取更多信息。
- **Q**：为什么我需要重新构建Web域名的配置文件？
- **A**：当您更改了与Web域名相关的设置（如SSL证书、虚拟主机设置等）时，重新构建配置文件可以确保这些更改得到正确应用。此外，如果配置文件出现错误或损坏，重新构建配置文件可能有助于解决问题。

### 总结

`v-rebuild-web-domain`命令是Hestia面板提供的一个强大工具，允许用户通过CLI重新构建Web域名的配置文件。通过正确使用此命令，您可以确保Web服务器的配置与您的需求保持一致，并在需要时快速解决问题。

## v-rebuild-web-domains

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-rebuild-web-domains)

### 概述

在hestia面板管理系统中，`v-rebuild-web-domains` 是一个重要的CLI（命令行界面）命令，用于重建Web域名的配置文件。这对于在修改或更新Web服务器设置后，确保配置文件的准确性和一致性非常有用。

### 使用方法

`v-rebuild-web-domains` 命令的基本语法如下：

```bash
v-rebuild-web-domains [USER] [RESTART]
```

* `USER`：指定要重建配置的用户的用户名。此参数是必需的。
* `RESTART`：可选参数。如果指定此参数，命令将在重建配置后尝试重新启动相关的Web服务。

### 示例

#### 示例1：重建指定用户的Web域名配置

```bash
v-rebuild-web-domains exampleuser
```

在此示例中，`exampleuser` 是要重建Web域名配置的用户名。命令执行后，hestia将重建该用户的所有Web域名配置文件。

#### 示例2：重建指定用户的Web域名配置并重启服务

```bash
v-rebuild-web-domains exampleuser RESTART
```

在此示例中，除了重建`exampleuser`的Web域名配置外，命令还将尝试重新启动相关的Web服务。这可以确保新的配置立即生效。

### 注意事项

* 在执行`v-rebuild-web-domains`命令之前，请确保您已经备份了重要的配置文件和数据，以防意外情况发生。
* 如果在执行命令时遇到任何问题或错误，请检查hestia面板的日志文件以获取更多信息。
* 在使用`RESTART`参数时，请确保您了解重启Web服务可能会中断正在运行的Web应用程序或服务。如果可能的话，请在低峰时段执行此操作。

### 结论

`v-rebuild-web-domains`是hestia面板管理系统中一个强大的CLI命令，它可以帮助您轻松重建Web域名的配置文件。通过正确地使用此命令，您可以确保Web服务器的配置文件的准确性和一致性，从而提高Web应用程序的稳定性和性能。

## 查看系列命令

## v-list-web-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-web-domain)

### 概述

Hestia面板管理系统为了方便管理员进行域名的参数查询和管理，提供了`v-list-web-domain`这一CLI命令。通过此命令，管理员可以轻松地获取指定域名的各项参数信息，并进行相应的处理。

### 命令使用

#### 语法

```bash
v-list-web-domain [USER] [DOMAIN] [FORMAT]
```

- `USER`：指定操作的用户名（必填）。
- `DOMAIN`：需要查询的域名（必填）。
- `FORMAT`：输出格式，支持`shell`、`json`等（可选，默认为`shell`）。

#### 示例

1. **以shell格式获取指定域名参数**

假设我们要以`admin`用户身份查询`example.com`域名的参数，可以使用以下命令：

```bash
v-list-web-domain admin example.com
```

输出将类似以下shell格式：

```bash
DOMAIN: example.com
IP: 192.168.1.1
IP6: ::1
DOCUMENT_ROOT: /var/www/example.com
# ... 其他参数信息 ...
```

2. **以json格式获取指定域名参数**

如果需要以json格式输出参数信息，可以指定`FORMAT`为`json`：

```bash
v-list-web-domain admin example.com json
```

输出将类似以下json格式：

```json
{
  "example.com": {
    "IP": "192.168.1.1",
    "IP6": "::1",
    "DOCUMENT_ROOT": "/var/www/example.com",
    # ... 其他参数信息 ...
  }
}
```

### 注意事项

- 请确保执行命令的用户具有足够的权限，否则可能会因为权限不足而导致命令执行失败。
- 在使用`v-list-web-domain`命令时，请确保输入的`USER`和`DOMAIN`参数正确无误，否则可能无法正确获取到域名的参数信息。
- 根据实际需求选择合适的输出格式，以便更好地处理和使用获取到的参数信息。

### 常见问题及解决方案

- **问题**：执行命令后没有输出或输出错误。
  **解决方案**：检查输入的`USER`和`DOMAIN`参数是否正确，以及执行命令的用户是否具有足够的权限。如果问题仍然存在，请查看Hestia面板管理系统的日志文件以获取更多错误信息。

- **问题**：如何以其他格式输出参数信息？
  **解决方案**：通过指定`FORMAT`参数来选择其他输出格式。目前支持`shell`和`json`两种格式，未来可能会支持更多格式。具体可查看Hestia面板管理系统的官方文档或帮助信息以获取更多格式选项。

## v-list-web-domain-accesslog

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-web-domain-accesslog)

### 简介

`v-list-web-domain-accesslog` 是hestia面板管理系统提供的一个CLI（命令行接口）命令，用于列出指定用户、指定域名下的Web访问日志。该命令可以帮助管理员快速查看和分析网站访问情况，为网站优化和故障排除提供有力支持。

### 语法

```bash
v-list-web-domain-accesslog USER DOMAIN [LINES] [FORMAT]
```

- `USER`：指定要查询的用户名。
- `DOMAIN`：指定要查询的域名。
- `LINES`（可选）：指定返回的行数。默认值为70。
- `FORMAT`（可选）：指定输出格式。可选值包括`shell`（默认）、`json`、`csv`等。

### 示例

#### 示例1：基本用法

```bash
v-list-web-domain-accesslog admin example.com
```

该命令将返回用户`admin`在域名`example.com`下的Web访问日志，最多返回70行，输出格式为shell格式。

#### 示例2：指定行数

```bash
v-list-web-domain-accesslog admin example.com 100
```

该命令将返回用户`admin`在域名`example.com`下的Web访问日志，最多返回100行，输出格式为shell格式。

#### 示例3：指定输出格式（JSON）

```bash
v-list-web-domain-accesslog admin example.com 50 json
```

该命令将返回用户`admin`在域名`example.com`下的Web访问日志，最多返回50行，输出格式为JSON格式。JSON格式的输出更加结构化，方便后续程序处理。

#### 示例4：指定输出格式（CSV）

```bash
v-list-web-domain-accesslog admin example.com csv
```

该命令将返回用户`admin`在域名`example.com`下的Web访问日志，默认返回70行，输出格式为CSV格式。CSV格式的输出适合导入到电子表格软件中进行进一步分析。

### 注意事项

- 确保使用正确的用户名和域名。
- 如果有需要，可以根据实际需求指定行数和输出格式。
- 如果输出内容较多，建议使用管道命令（如`less`、`grep`等）进行分页查看或过滤。

### 总结

`v-list-web-domain-accesslog` 是hestia面板管理系统提供的一个实用的CLI命令，用于快速查看和分析网站访问日志。通过指定用户名、域名、行数和输出格式等参数，可以灵活地获取所需信息，为网站管理提供便利。

## v-list-web-domain-errorlog

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-web-domain-errorlog)

### 简介

`v-list-web-domain-errorlog` 是hestia面板管理系统提供的一个命令行接口（CLI）命令，用于列出指定web域名的错误日志。此命令对于管理员在排查网站问题时非常有用，可以快速定位错误来源。

### 使用方法

基本语法：

```bash
v-list-web-domain-errorlog USER DOMAIN [LINES] [FORMAT]
```

* `USER`：执行命令的用户名，通常是hestia面板的管理员账号。
* `DOMAIN`：要查询错误日志的web域名。
* `LINES`（可选）：指定要显示的日志行数，默认为70行。
* `FORMAT`（可选）：指定输出格式，可以是`shell`（默认）、`json`、`csv`等。

### 示例

#### 示例1：基本用法

假设我们有一个名为`admin`的用户，要查询`acme.com`域名的错误日志，可以使用以下命令：

```bash
v-list-web-domain-errorlog admin acme.com
```

执行后，将显示`acme.com`域名的最后70行错误日志，以默认的`shell`格式输出。

#### 示例2：指定行数

如果我们只想查看最后100行的错误日志，可以加上`LINES`参数：

```bash
v-list-web-domain-errorlog admin acme.com 100
```

#### 示例3：指定输出格式

如果我们希望将日志以JSON格式输出，可以使用`FORMAT`参数：

```bash
v-list-web-domain-errorlog admin acme.com 70 json
```

执行后，将返回一个JSON数组，包含指定行数的错误日志。

#### 示例4：组合使用

我们也可以同时指定行数和输出格式：

```bash
v-list-web-domain-errorlog admin acme.com 50 csv
```

这将返回一个CSV格式的日志列表，包含`acme.com`域名的最后50行错误日志。

### 注意事项

* 在执行CLI命令时，请确保您具有相应的权限和正确的用户凭证。
* 如果指定的域名不存在或没有错误日志，命令可能会返回空结果或错误消息。
* 输出的日志内容可能包含敏感信息，请谨慎处理。

## v-list-web-domain-ssl

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-web-domain-ssl)

### 介绍

hestia面板管理系统为用户提供了一个功能强大的CLI（命令行接口）命令，其中`v-list-web-domain-ssl`命令用于列出指定Web域名的SSL证书信息。该命令能够方便地帮助用户查看和管理SSL证书，确保网站的安全性。

### 使用方法

`v-list-web-domain-ssl`命令的基本使用方法如下：

```bash
v-list-web-domain-ssl [USER] [DOMAIN] [FORMAT]
```

其中：

- `[USER]` 是操作SSL证书的用户名。
- `[DOMAIN]` 是要列出SSL证书的Web域名。
- `[FORMAT]` 是输出格式，可选参数，默认为shell格式。也可以指定为json格式，以便与其他工具或脚本进行交互。

### 示例

#### 示例1：使用默认shell格式列出SSL证书信息

```bash
v-list-web-domain-ssl admin example.com
```

输出可能如下（示例输出，实际内容根据SSL证书而定）：

```bash
-----BEGIN CERTIFICATE-----
...（证书内容）...
-----END CERTIFICATE-----

-----BEGIN PRIVATE KEY-----
...（私钥内容）...
-----END PRIVATE KEY-----

Subject: /CN=example.com
Aliases: www.example.com
Valid From: Mar 1 00:00:00 2023 GMT
Valid Till: Mar 1 23:59:59 2024 GMT
```

#### 示例2：使用json格式列出SSL证书信息

```bash
v-list-web-domain-ssl admin example.com json
```

输出可能如下（示例输出，实际内容根据SSL证书而定）：

```json
{
  "example.com": {
    "CRT": "-----BEGIN CERTIFICATE-----\n...（证书内容）...\n-----END CERTIFICATE-----",
    "KEY": "-----BEGIN PRIVATE KEY-----\n...（私钥内容）...\n-----END PRIVATE KEY-----",
    "SUBJECT": "/CN=example.com",
    "ALIASES": "www.example.com",
    "NOT_BEFORE": "Mar 1 00:00:00 2023 GMT",
    "NOT_AFTER": "Mar 1 23:59:59 2024 GMT"
    // 其他可能的字段，如CA、SIGNATURE、PUB_KEY、ISSUER、SSL_FORCE等
  }
}
```

### 注意事项

- 使用`v-list-web-domain-ssl`命令时，请确保你有足够的权限来查看指定的SSL证书信息。
- 如果指定的Web域名不存在或没有配置SSL证书，命令可能会返回错误信息或空结果。
- 在处理SSL证书和私钥时，请确保遵守最佳安全实践，不要在不受信任的环境中暴露敏感信息。

## v-list-web-domains

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-web-domains)

### 简介

Hestia面板管理系统是一个功能强大的Web服务器控制面板，它为用户提供了直观易用的图形界面来管理Web服务器环境。除了图形界面外，Hestia还提供了命令行接口（CLI），以便用户通过终端执行各种操作。其中，`v-list-web-domains`命令是Hestia CLI中的一个重要命令，用于列出指定用户的所有Web域名。

### 命令格式

```bash
v-list-web-domains USER [FORMAT]
```

* `USER`：指定要列出Web域名的用户名。
* `FORMAT`（可选）：指定输出格式。默认为shell格式。其他可能的格式包括json等。

### 示例

#### 示例1：列出用户alice的所有Web域名（默认shell格式）

```bash
v-list-web-domains alice
```

执行上述命令后，Hestia将返回用户alice的所有Web域名列表，每个域名占一行。

#### 示例2：以JSON格式列出用户bob的所有Web域名

```bash
v-list-web-domains bob json
```

执行上述命令后，Hestia将返回一个JSON格式的字符串，其中包含用户bob的所有Web域名及其相关信息。例如：

```json
[
  {
    "domain": "example1.com",
    "ip": "192.168.1.1",
    "document_root": "/home/bob/web/example1.com/public_html/",
    "suspended": false
  },
  {
    "domain": "example2.net",
    "ip": "192.168.1.2",
    "document_root": "/home/bob/web/example2.net/public_html/",
    "suspended": true
  }
]
```

### 注意事项

* 使用`v-list-web-domains`命令时，请确保已正确安装并配置了Hestia面板管理系统。
* 请确保您具有足够的权限来执行该命令。通常，只有具有管理员权限的用户才能列出其他用户的Web域名。
* 如果指定了不存在的用户名，`v-list-web-domains`命令将返回一个错误消息。
* 输出的Web域名列表可能包含已暂停的域名。如果您只想查看活动域名，请检查输出中的`suspended`字段。

### 结论

`v-list-web-domains`命令是Hestia面板管理系统CLI中的一个非常有用的命令，它允许用户通过终端快速列出指定用户的所有Web域名。通过结合使用不同的输出格式（如shell和JSON），用户可以根据需要自定义输出内容。

## v-list-web-stats

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-web-stats)

### 介绍

hestia面板管理系统是一款功能强大的服务器管理工具，它为用户提供了丰富的Web界面和命令行接口（CLI）来管理服务器资源。其中，`v-list-web-stats`是hestia提供的一个CLI命令，用于列出和分析Web服务器的统计信息。

### 用法

`v-list-web-stats`命令的基本语法如下：

```bash
v-list-web-stats [选项]
```

其中，`[选项]`表示可选的参数或标志，用于指定命令的输出格式或其他行为。

### 选项

* `-f` 或 `--format`：指定输出格式。目前支持`shell`、`json`、`csv`等格式。默认为`shell`格式。

### 示例

#### 示例1：默认格式输出

```bash
v-list-web-stats
```

执行上述命令后，hestia将按照默认的`shell`格式列出Web服务器的统计信息。输出可能类似于以下内容：

```bash
Web Server Statistics:
- Total Requests: 1000
- Average Response Time: 200ms
- Most Requested Page: /index.html
...
```

#### 示例2：使用JSON格式输出

```bash
v-list-web-stats -f json
```

执行上述命令后，hestia将以JSON格式列出Web服务器的统计信息。输出可能类似于以下内容：

```json
{
  "total_requests": 1000,
  "average_response_time": "200ms",
  "most_requested_page": "/index.html",
  ...
}
```

#### 示例3：使用CSV格式输出

```bash
v-list-web-stats -f csv
```

执行上述命令后，hestia将以CSV（逗号分隔值）格式列出Web服务器的统计信息。输出可能类似于以下内容：

```csv
total_requests,average_response_time,most_requested_page,...
1000,200ms,/index.html,...
```

### 注意事项

* 在使用`v-list-web-stats`命令之前，请确保您已经正确安装了hestia面板管理系统，并且已经通过适当的身份验证和授权。
* 某些选项和参数可能因hestia版本的不同而有所差异。请根据您的hestia版本和文档进行相应的调整。

### 总结

`v-list-web-stats`是hestia面板管理系统提供的一个强大而灵活的CLI命令，用于列出和分析Web服务器的统计信息。通过指定不同的选项和参数，您可以以不同的格式获取所需的统计信息，并根据需要进行进一步的处理和分析。

## v-list-web-templates

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-web-templates)

### 概述

Hestia面板管理系统默认集成了多种CLI（命令行界面）命令，方便用户通过终端对系统进行管理和配置。其中，`v-list-web-templates`命令用于获取可供用户使用的Web模板列表。

### 用法

`v-list-web-templates` 命令的基本用法如下：

```bash
v-list-web-templates [FORMAT]
```

- `[FORMAT]`：可选参数，用于指定输出格式。支持以下格式：`json`、`plain`、`csv`、`shell`。如果未指定格式，则默认为`shell`格式。

### 示例

#### 示例1：默认shell格式输出

```bash
v-list-web-templates
```

输出结果（示例）：

```bash
TEMPLATE
--------
template1
template2
template3
...
```

#### 示例2：JSON格式输出

```bash
v-list-web-templates json
```

输出结果（示例）：

```json
[
    "template1",
    "template2",
    "template3",
    ...
]
```

#### 示例3：Plain格式输出（与shell格式类似，但不包含标题）

```bash
v-list-web-templates plain
```

输出结果（示例）：

```bash
template1
template2
template3
...
```

#### 示例4：CSV格式输出（每行一个模板，没有标题）

```bash
v-list-web-templates csv
```

输出结果（示例）：

```bash
template1
template2
template3
...
```

### 注意事项

- 确保您已经正确安装了Hestia面板管理系统，并且具有执行CLI命令的权限。
- 如果在执行命令时遇到任何问题，请检查您的系统环境、Hestia面板版本以及命令的语法是否正确。
- Hestia面板管理系统可能会根据版本更新而调整CLI命令的用法和功能，请参考最新的官方文档或帮助信息以获取最准确的信息。

## v-list-web-templates-backend

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-web-templates-backend)

### 概述

`v-list-web-templates-backend` 是 Hestia 提供的一个命令行接口（CLI）命令，用于列出可用的后端模板。这些模板通常用于在 Hestia 环境中快速部署和配置后端服务。

### 用法

```bash
v-list-web-templates-backend [FORMAT]
```

* `[FORMAT]`（可选）：指定输出格式。支持的格式包括 `json`、`plain`、`csv` 和 `shell`。如果不指定格式，将默认使用 `shell` 格式。

### 示例

#### 示例 1：默认输出（shell 格式）

```bash
$ v-list-web-templates-backend
TEMPLATE
--------
template1
template2
template3
...
```

#### 示例 2：输出为 JSON 格式

```bash
$ v-list-web-templates-backend json
[
    "template1",
    "template2",
    "template3",
    ...
]
```

#### 示例 3：输出为 CSV 格式

```bash
$ v-list-web-templates-backend csv
TEMPLATE
template1
template2
template3
...
```

#### 示例 4：输出为 Plain 格式（与 shell 格式类似，但不包含标题行）

```bash
$ v-list-web-templates-backend plain
template1
template2
template3
...
```

### 注意事项

* 确保你已经正确安装了 Hestia，并且 CLI 命令可用。
* 根据你的 Hestia 配置和环境，可用的后端模板可能会有所不同。
* 如果你在使用该命令时遇到任何问题，请检查你的 Hestia 版本和配置，或参考 Hestia 的官方文档和社区支持。

### 结论

`v-list-web-templates-backend` 命令是 Hestia 提供的一个方便的工具，用于列出可用的后端模板。通过指定不同的输出格式，你可以根据自己的需求选择最适合的格式来查看和使用这些模板。

## v-list-web-templates-proxy

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-web-templates-proxy)

### 1. 命令介绍

`v-list-web-templates-proxy` 是 Hestia 提供的 CLI（命令行界面）命令之一，用于获取当前用户可用的代理模板列表。这些模板通常用于快速配置和部署不同类型的 Web 代理服务。

### 2. 命令选项

此命令接受一个可选的 `[FORMAT]` 参数，用于指定输出格式。支持的格式包括 `json`、`plain`、`csv` 和 `shell`。如果未指定格式，则默认为 `shell` 格式。

### 3. 使用示例

#### 示例 1: 默认 shell 格式输出

```bash
v-list-web-templates-proxy
```

输出示例：

```bash
TEMPLATE
--------
template1
template2
template3
...
```

#### 示例 2: JSON 格式输出

```bash
v-list-web-templates-proxy json
```

输出示例：

```json
[
  "template1",
  "template2",
  "template3",
  ...
]
```

#### 示例 3: CSV 格式输出

```bash
v-list-web-templates-proxy csv
```

输出示例：

```bash
TEMPLATE
template1
template2
template3
...
```

（注意：虽然 CSV 格式通常包括逗号分隔的值和标题行，但在此示例中为了简洁起见，我们省略了这些。）

#### 示例 4: Plain 格式输出

```bash
v-list-web-templates-proxy plain
```

输出示例与 shell 格式相同，因为 plain 格式只是简单地列出模板名称，没有额外的格式化。

### 4. 注意事项

* 使用此命令前，请确保已经正确安装了 Hestia 并配置了相关的环境变量。
* 如果在执行命令时遇到任何问题，请检查 Hestia 的日志文件以获取更多信息。
* 输出的模板列表可能因 Hestia 的版本和配置而有所不同。

### 5. 总结

`v-list-web-templates-proxy` 是一个方便的工具，用于快速查看和管理 Hestia 中的代理模板。通过指定不同的输出格式，您可以根据需要灵活地获取和使用这些模板。

## v-add-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-domain)

### 概述

`v-add-domain` 是 Hestia 控制面板提供的一个命令行接口（CLI）工具，用于向服务器添加 Web、DNS 和邮件域。该命令简化了多系统集成的流程，允许管理员通过单一的命令执行多个操作。

### 语法

```bash
v-add-domain USER DOMAIN [IP] [RESTART]
```

- `USER`: 要为其添加域的用户的用户名。
- `DOMAIN`: 要添加的域的名称。
- `[IP]`: （可选）要绑定到该域的 IP 地址。如果未指定，系统将尝试自动分配。
- `[RESTART]`: （可选）一个标志，指示是否应重新启动相关服务。通常，如果指定了此选项，则值应为 `yes` 或 `no`。

### 示例

#### 示例 1: 添加一个域而不指定 IP 和重启服务

```bash
v-add-domain admin example.com
```

在此示例中，我们为名为 "admin" 的用户添加了名为 "example.com" 的域，没有指定 IP 地址，并且没有请求重新启动服务。

#### 示例 2: 添加一个域并指定 IP 地址

```bash
v-add-domain admin example.com 192.168.1.100
```

在此示例中，我们除了指定用户名和域名外，还指定了 IP 地址 `192.168.1.100`。

#### 示例 3: 添加一个域并请求重启服务

```bash
v-add-domain admin example.com yes
```

请注意，在此示例中，我们没有指定 IP 地址，但指定了 `yes` 作为 `[RESTART]` 参数的值，这意味着在添加域后，系统将尝试重新启动相关服务。

### 注意事项

- 在执行 `v-add-domain` 命令之前，请确保您具有足够的权限，并且 Hestia 控制面板已正确安装和配置。
- 如果未指定 IP 地址，系统将尝试自动为域分配一个可用的 IP 地址。但是，这取决于服务器的配置和网络环境。
- 重新启动服务可能会暂时中断对用户的访问。因此，请确保在维护窗口或用户活动较低的时间段内执行此操作。

### 返回值和错误处理

`v-add-domain` 命令将根据操作的成功或失败返回不同的退出代码。管理员可以根据这些退出代码编写脚本以自动化错误处理和日志记录。此外，命令还将在标准输出中显示有关操作状态的消息。

### 结论

`v-add-domain` 是 Hestia 控制面板提供的一个强大的工具，允许管理员通过单一的命令向服务器添加 Web、DNS 和邮件域。通过结合示例和注意事项，管理员可以更有效地使用此命令来管理其服务器上的域。

## v-unsuspend-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-unsuspend-domain)

### 命令描述

`v-unsuspend-domain` 是 Hestia 提供的 CLI 命令之一，用于取消挂起（unsuspend）指定的 web、DNS 和邮件域名。当某个域名因为某些原因被管理员挂起时，可以使用此命令来恢复其正常状态。

### 命令格式

```bash
v-unsuspend-domain USER DOMAIN [RESTART]
```

- `USER`：执行此操作的用户名（通常为管理员账户）。
- `DOMAIN`：需要取消挂起的域名。
- `[RESTART]`：可选参数，指定是否需要重启相关服务。默认为 "yes"。

### 示例

#### 示例 1: 取消挂起 web/DNS/邮件域名

```bash
v-unsuspend-domain admin example.com
```

在这个例子中，管理员 `admin` 正在取消挂起 `example.com` 这个域名的 web、DNS 和邮件服务。如果 Hestia 配置了这些服务，并且该域名之前被挂起，那么执行此命令后，该域名将恢复正常状态。

#### 示例 2: 取消挂起域名并指定不重启服务

```bash
v-unsuspend-domain admin example.com no
```

在这个例子中，除了取消挂起 `example.com` 这个域名外，还指定了不需要重启相关服务。这在某些情况下可能是有用的，比如当你知道服务重启不会影响其他正在运行的任务时。

#### 示例 3: 取消挂起多个域名

请注意，`v-unsuspend-domain` 命令一次只能处理一个域名。但是，你可以通过循环或脚本来批量处理多个域名。例如：

```bash
#!/bin/bash

domains=("example1.com" "example2.com" "example3.com")
user="admin"

for domain in "${domains[@]}"; do
    v-unsuspend-domain "$user" "$domain"
done
```

这个脚本将取消挂起 `domains` 数组中列出的所有域名。

### 注意事项

* 在执行此命令之前，请确保你有足够的权限来取消挂起域名。
* 如果你的 Hestia 实例没有配置某些服务（如 DNS 或邮件），那么这些服务将不会被影响。
* 在生产环境中执行此类命令之前，请确保你了解它们的潜在影响，并在可能的情况下进行备份或测试。

## v-suspend-domain

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-suspend-domain)

### 1. 概述

`v-suspend-domain` 是 Hestia 提供的命令行接口（CLI）命令之一，用于暂停（或挂起）指定的 Web、DNS 和邮件域名。通过此命令，管理员可以轻松地管理用户域名的状态，确保在需要时暂停服务。

### 2. 命令语法

```bash
v-suspend-domain USER DOMAIN [RESTART]
```

* `USER`: 需要暂停域名的用户名称。
* `DOMAIN`: 需要暂停的域名。
* `RESTART` (可选): 是否在暂停后重启相关服务，默认为 "yes"。

### 3. 示例

#### 示例 1: 暂停域名并重启服务

```bash
v-suspend-domain admin example.com
```

在此示例中，管理员将暂停用户 `admin` 下的 `example.com` 域名，并在操作后重启相关服务。

#### 示例 2: 暂停域名但不重启服务

```bash
v-suspend-domain admin example.com no
```

在此示例中，管理员同样暂停了用户 `admin` 下的 `example.com` 域名，但指定了不重启相关服务。

#### 示例 3: 批量暂停多个域名

虽然 `v-suspend-domain` 命令一次只能处理一个域名，但可以通过脚本或循环来批量处理多个域名。以下是一个简单的 bash 脚本示例，用于暂停多个域名：

```bash
#!/bin/bash

USERS=("admin" "user1" "user2")
DOMAINS=("example.com" "test.com" "demo.net")

for USER in "${USERS[@]}"; do
    for DOMAIN in "${DOMAINS[@]}"; do
        v-suspend-domain "$USER" "$DOMAIN"
        echo "Suspended $DOMAIN for user $USER"
    done
done
```

### 4. 注意事项

* 在执行 `v-suspend-domain` 命令之前，请确保您具有足够的权限来暂停指定的域名。
* 暂停域名可能会影响正在运行的服务，因此请在执行此操作之前通知相关用户或确保服务已备份。
* 如果在暂停域名后遇到任何问题，请检查 Hestia 的日志文件以获取更多信息。

### 5. 结论

`v-suspend-domain` 命令是 Hestia 系统中一个强大且实用的工具，允许管理员轻松地暂停和管理用户域名。通过正确使用此命令，您可以确保系统的稳定性和安全性，同时为用户提供更好的服务体验。
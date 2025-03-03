# DNS 集群与 DNSSEC 介绍

## 概述

自版本 1.7.0 发布以来，我们已实现对 DNSSEC（域名系统安全扩展）的支持。DNSSEC 需要采用主服务器（Master）到从服务器（Slave）的设置。如果现有实现是主-主（Master <-> Master）设置，则不支持 DNSSEC。此外，DNSSEC 要求系统至少为 Ubuntu 22.04 或 Debian 11！

## 在 Hestia 上为您的域名托管 DNS

### 前提条件

以下步骤要求您将域名的 DNS 服务器配置为使用您的 Hestia 服务器。

- 请注意，大多数域名提供商要求配置两个或更多 DNS 服务器。
- 名称服务器很可能需要注册为“Glue 记录”。
- 名称服务器可能需要最多 24 小时才能生效。

### 准备域名和 DNS

1. 在您的 Hestia 主服务器上，使用 **child-ns** 模板[创建一个 DNS 区域](../user-guide/dns#adding-a-dns-zone)。
2. 在您的域名注册商面板中，将域名的名称服务器设置为 Hestia 服务器。

如果您希望最小化与 DNS 相关的停机时间，或希望自动在所有服务器之间同步 DNS 区域，可以考虑设置 DNS 集群。

如果您关心 DNSSEC，则必须使用主-从（Master -> Slave）设置。但是，如果您希望在任何服务器上添加区域并使其复制到其他服务器，则配置为主-主（Master <-> Master）。

::: tip
如果您刚刚设置了从服务器，请检查主机名是否解析，并且您是否拥有有效的 SSL 证书。
:::

## DNS 集群设置

主服务器是创建 DNS 区域的地方，从服务器通过 API 接收区域。Hestia 可以配置为主-主（Master <-> Master）或主-从（Master -> Slave）。在主-主配置中，每个主服务器也是从服务器，因此可以视为主/从 <-> 主/从。

在每个从服务器上，需要一个唯一用户，该用户将被分配区域，并且必须分配“Sync DNS User”或“dns-cluster”角色。

::: info
自 1.6.0 版本发布以来，我们实施了新的 API 访问密钥认证系统。我们强烈建议使用此方法，而不是之前的用户名/密码系统，因为访问密钥和密钥的长度使其更加安全！

如果您仍想使用旧版 API 通过 **admin** 用户名和密码进行认证，请确保将 **Enable legacy API** 访问设置为 **yes**。
:::

### 使用 Hestia API 的主-主 DNS 集群（默认设置）

::: warning
此方法不支持 DNSSEC！
:::

1. 在每个 Hestia 服务器上创建一个新用户，该用户将充当“从服务器”。确保使用用户名“dns-cluster”或具有“dns-cluster”角色。
2. 运行以下命令以启用 DNS 服务器。

```bash
v-add-remote-dns-host slave.yourhost.com 8083 'accesskey:secretkey' '' 'api' 'username'
```

或者，如果您仍想使用 admin 和密码认证（不推荐）：

```bash
v-add-remote-dns-host slave.yourhost.com 8083 'admin' 'strongpassword' 'api' 'username'
```

这样，您可以设置主-从或主-主-主集群。DNS 服务器的链接方式没有限制。

### 使用 Hestia API 的主-从 DNS 集群

::: info
如果尝试通过局域网同步，将无法工作！请参阅[问题](https://github.com/hestiacp/hestiacp/issues/4295)。确保使用公共 IP 地址。
:::

**从服务器**准备：

1. 在**配置服务器** -> **安全** -> **API 允许的 IP 地址**中，将主服务器 IP 加入白名单。
2. 为管理员（或所有用户）启用 API 访问。
3. 在**admin**用户下创建一个 API 密钥，至少具有**sync-dns-cluster** 权限。这可以在用户设置/访问密钥中找到。
4. 创建一个新的 DNS 同步用户，如下：
   - 拥有电子邮件地址（通用地址）
   - 具有“dns-cluster”角色
   - 如果该用户不是常规用户，您可能希望设置“不允许用户登录控制面板”
   - 如果您有多个从服务器，从服务器用户必须唯一
5. 编辑 `/usr/local/hestia/conf/hestia.conf`，将 `DNS_CLUSTER_SYSTEM='hestia'` 更改为 `DNS_CLUSTER_SYSTEM='hestia-zone'`。
6. 编辑 `/etc/bind/named.conf.options`，进行以下更改，然后使用 `systemctl restart bind9` 重启 bind9：

   ```bash
   # 将此行更改
   allow-recursion { 127.0.0.1; ::1; };
   # 改为
   allow-recursion { 127.0.0.1; ::1; your.master.ip.address; };
   # 添加此行
   allow-notify{ your.master.ip.address; };
   ```

**主服务器**准备：

1. 在**主服务器**上，打开 `/usr/local/hestia/conf/hestia.conf`，将 `DNS_CLUSTER_SYSTEM='hestia'` 更改为 `DNS_CLUSTER_SYSTEM='hestia-zone'`。
2. 编辑 `/etc/bind/named.conf.options`，进行以下更改，然后使用 `systemctl restart bind9` 重启 bind9。

   ```bash
   # 将此行更改
   allow-transfer { "none"; };
   # 改为
   allow-transfer { your.slave.ip.address; };
   # 如果添加多个从服务器，则改为
   allow-transfer { first.slave.ip.address; second.slave.ip.address; };
   # 如果添加多个从服务器，添加此行
   also-notify { second.slave.ip.address; };
   ```

3. 运行以下命令以启用每个从 DNS 服务器，并稍等片刻以完成区域传输：

   ```bash
   v-add-remote-dns-host <your slave host name> <port number> '<accesskey>:<secretkey>' '' 'api' '<your chosen slave user name>'
   ```

   如果您仍想使用 admin 和密码认证（不推荐）：

   ```bash
   v-add-remote-dns-host slave.yourhost.com 8083 'admin' 'strongpassword' 'api' 'user-name'
   ```

4. 通过 CLI 命令 `v-list-dns-domains dns-user` 列出**从服务器**上的 DNS 区域，或以 dns-user 身份连接到 Web 界面并查看 DNS 区域，以检查是否成功。

### 将现有 DNS 集群转换为主-从

1. 在**主服务器**和**从服务器**上，打开 `/usr/local/hestia/conf/hestia.conf`，将 `DNS_CLUSTER_SYSTEM='hestia'` 更改为 `DNS_CLUSTER_SYSTEM='hestia-zone'`。
2. 在**主服务器**上，打开 `/etc/bind/named.conf.options`，进行以下更改，然后使用 `systemctl restart bind9` 重启 bind9。

   ```bash
   # 将此行更改
   allow-transfer { "none"; };
   # 改为
   allow-transfer { your.slave.ip.address; };
   # 如果添加多个从服务器，则改为
   allow-transfer { first.slave.ip.address; second.slave.ip.address; };
   # 如果添加多个从服务器，添加此行
   also-notify { second.slave.ip.address; };
   ```

3. 在**从服务器**上，打开 `/etc/bind/named.conf.options`，进行以下更改，然后使用 `systemctl restart bind9` 重启 bind9。

   ```bash
   # 将此行更改
   allow-recursion { 127.0.0.1; ::1; };
   # 改为
   allow-recursion { 127.0.0.1; ::1; your.master.ip.address; };
   # 添加此行
   allow-notify{ your.master.ip.address; };
   ```

4. 使用 `v-sync-dns-cluster` 更新 DNS。

## 启用 DNSSEC

::: warning
当 Hestia 集群以主-主模式运行时，无法使用 DNSSEC。
:::

要启用 DNSSEC，勾选 DNSSEC 前的复选框并保存。

要查看公钥，请转到 DNS 域列表并点击 <i class="fas fas-key"></i> 图标。

根据您的注册商，您可能能够基于 DNSKEY 或 DS 密钥创建新记录。在将 DNSSEC 公钥添加到注册商后，DNSSEC 即启用并生效。

::: danger
在 Hestia 中移除或禁用私钥将导致域名无法访问。
:::

## 常见问题与故障排除

### 是否可以按用户分离 DNS 帐户？

是的，您可以在命令末尾提供用户变量，以便为特定的用户配置 DNS 同步。例如：

```bash
v-add-remote-dns-host slave.yourhost.com 8083 'access_key:secret_key' '' 'api' 'specific_dns_user'
```

这将确保 DNS 区域同步到指定的 `specific_dns_user` 帐户，而不是默认的 DNS 用户。

### DNS 同步未工作，如何排查？

1. **检查 API 访问权限**：
   - 确保在从服务器上为用于同步的用户配置了正确的 API 密钥和权限。
   - 确保主服务器的 IP 地址在从服务器的 API 允许 IP 地址列表中。

2. **检查 Bind 配置**：
   - 在主服务器上，确保 `allow-transfer` 和 `also-notify` 配置正确，包含所有从服务器的 IP 地址。
   - 在从服务器上，确保 `allow-recursion` 和 `allow-notify` 配置正确，包含主服务器的 IP 地址。

3. **查看日志文件**：
   - 检查 `/var/log/named/error.log` 或 `/var/log/syslog` 中的 Bind 相关日志，以查找可能的错误信息。
   - 检查 Hestia 的日志文件，通常位于 `/usr/local/hestia/log/` 目录下，以查找与 DNS 同步相关的错误。

4. **测试连接**：
   - 使用 `telnet` 或 `nc` 工具测试从服务器是否能够连接到主服务器的 DNS 端口（通常是 53）。
   - 例如：`telnet master.yourhost.com 53`

5. **重启服务**：
   - 在更改配置后，确保重启 Bind 服务以应用更改：`systemctl restart bind9`
   - 也可以重启 Hestia 服务以确保所有配置生效：`systemctl restart hestia`

### DNSSEC 启用后，域名无法访问怎么办？

1. **检查 DNSSEC 配置**：
   - 确保在 Hestia 中正确启用了 DNSSEC，并且公钥已正确添加到域名注册商。

2. **验证 DNSSEC 签名**：
   - 使用在线工具（如 DNSViz）验证 DNSSEC 签名是否正确。

3. **检查注册商设置**：
   - 确保域名注册商的 DNSSEC 设置与 Hestia 中生成的公钥匹配。

4. **等待传播**：
   - DNSSEC 更改可能需要一段时间来在全球 DNS 系统中传播。请等待一段时间（通常是几小时到一天）后再检查。

5. **联系支持**：
   - 如果问题仍然存在，请联系您的域名注册商或 Hestia 支持以获取进一步帮助。

### 如何从主-主集群转换为主-从集群？

请按照“将现有 DNS 集群转换为主-从”部分的步骤进行操作。确保在所有服务器上正确更新配置，并重启 Bind 服务以应用更改。

通过以上步骤，您应该能够解决大多数与 DNS 集群和 DNSSEC 相关的问题。如果问题仍然存在，请仔细检查配置文件和日志文件，以查找可能的错误或遗漏。

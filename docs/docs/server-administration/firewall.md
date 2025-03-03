# 防火墙

::: danger 警告
每次编辑或更新防火墙后，`Hestia` 都会清除当前的 `iptables`，除非通过 `Hestia` 和 [自定义脚本](firewall.html#如何自定义iptables规则) 添加规则。
:::

## 如何打开或阻止端口或 IP？

1. 进入Hestia web 控制面版单击右上角的 **<i class="fas fa-fw fa-cog"><span class="visually-hidden"></span></i>服务器** 图标导航至服务器设置。
2. 单击 **<i class="fas fa-fw fa-shield-alt"></i> 防火墙** 按钮。
3. 单击 **<i class="fas fa-fw fa-plus-circle"></i>添加规则** 按钮。
4. 选择所需的操作。
5. 选择所需的协议。
6. 输入您希望应用此规则的端口（“0”表示所有端口）。
7. 设置此规则适用的 IP（所有 IP 为“0.0.0.0/0”）或选择一个 IP 地址。
8. （可选）描述规则的功能。
9. 单击右上角的 **<i class="fas fa-fw fa-save"></i> 保存** 按钮。

您还可以使用 [v-add-firewall-rule](../reference/firewall.html#v-add-firewall-rule) 命令。

## 如何设置 IPSet 黑名单或白名单？

`IPSet`是一个用于管理`IP`地址集合的工具。它允许创建、修改和删除包含IP地址、网络子网和端口号的集合。`IPSet`提供了高效的数据结构和算法，能够快速进行`IP`地址的匹配和查找。`IPSet`经常与防火墙软件（如iptables）一起使用，用于实现更高级的网络规则和过滤策略，提高`iptables`的灵活性并简化其规则。`IPSet`使用索引数据结构存储集合，这使得它在查询大型集合时效率非常高。

1. 单击右上角的 **<i class="fas fa-fw fa-cog"><span class="visually-hidden"></span></i> 服务器** 图标导航至服务器设置。
2. 单击 **<i class="fas fa-fw fa-shield-alt"></i> 防火墙** 按钮。
3. 单击 **<i class="fas fa-fw fa-list"></i>管理 IP 列表** 按钮。
4. 单击 **<i class="fas fa-fw fa-plus-circle"></i> 添加 IP 列表** 按钮。
5. 为您的 **IP** 列表命名。
6. 通过输入以下内容之一来选择数据源：
    - URL：`http://ipverse.net/ipblocks/data/countries/nl.zone`
    - 脚本（使用 `chmod 755`为脚本赋予权限）：`/usr/local/hestia/install/deb/firewall/ipset/blacklist.sh`
    - 文件：`file:/location/of/file`
    - 您还可以使用 `Hestia` 包含的来源之一。
7. 选择所需的 `IP` 版本（v4 或 v6）。
8. 选择是否自动更新列表。
9. 单击右上角的 **<i class="fas fa-fw fa-save"></i> 保存** 按钮。

## 如何自定义iptables规则？

::: danger 警告！
这是一个高级且危险的功能，请确保您知道自己在做什么。
:::

Hestia支持使用脚本来设置自定义规则、链或标志等。

脚本必须放在这里：`/usr/local/hestia/data/firewall/custom.sh`

1. 创建custom.sh：`touch /usr/local/hestia/data/firewall/custom.sh`
2. 使其可执行：`chmod +x /usr/local/hestia/data/firewall/custom.sh`
3. 使用您喜欢的编辑器编辑它。
4. 测试并确保它工作正常。
5. 要使自定义规则持久化，请运行：[v-update-firewall](../reference/firewall.html#v-update-firewall)

**防火墙保护：** 在使规则持久化之前，如果您犯了错误或锁定了自己无法访问服务器，只需重启即可。

custom.sh示例：

```bash
#!/bin/bash

# 获取iptables命令的路径
IPTABLES="$(command -v iptables)"

# 创建一个名为YOURCHAIN的新链
$IPTABLES -N YOURCHAIN

# 清空YOURCHAIN链中的所有规则
$IPTABLES -F YOURCHAIN

# 在YOURCHAIN链中添加一条规则，允许来自任何地址（0.0.0.0/0）的流量返回（即不做任何处理）
$IPTABLES -I YOURCHAIN -s 0.0.0.0/0 -j RETURN

# 在INPUT链的开头插入一条规则，将所有TCP流量（端口1到65535）重定向到YOURCHAIN链
$IPTABLES -I INPUT -p TCP -m multiport --dports 1:65535 -j YOURCHAIN
```

## 我的 IP 集群不起作用

 IP集群必须包含至少 10 个 IP 或 IP 范围。

## 我可以将多个源合并为一个吗？

如果您想将多个 IP 源组合在一起，可以使用以下脚本来实现：
如需查看更多请访问[rir-ip](https://github.com/ipverse/rir-ip)

```bash
#!/bin/bash

BEL=(
	# 国家:比利时
	"https://raw.githubusercontent.com/ipverse/rir-ip/master/country/be/ipv4-aggregated.txt"
	# 国家:荷兰
	"https://raw.githubusercontent.com/ipverse/rir-ip/master/country/nl/ipv4-aggregated.txt"
	# 国家:卢森堡
	"https://raw.githubusercontent.com/ipverse/rir-ip/master/country/lu/ipv4-aggregated.txt"
	# 国家:中国 
	"https://raw.githubusercontent.com/ipverse/rir-ip/master/country/ch/aggregated.json"
    "https://raw.githubusercontent.com/ipverse/rir-ip/master/country/ch/ipv4-aggregated.txt"
    "https://raw.githubusercontent.com/ipverse/rir-ip/master/country/ch/ipv6-aggregated.txt"
)

IP_BEL_TMP=$(mktemp)
for i in "${BEL[@]}"; do
	IP_TMP=$(mktemp)
	((HTTP_RC = $(curl -L --connect-timeout 10 --max-time 10 -o "$IP_TMP" -s -w "%{http_code}" "$i")))
	if ((HTTP_RC == 200 || HTTP_RC == 302 || HTTP_RC == 0)); then # "0" because file:/// returns 000
		command grep -Po '^(?:\d{1,3}\.){3}\d{1,3}(?:/\d{1,2})?' "$IP_TMP" | sed -r 's/^0*([0-9]+)\.0*([0-9]+)\.0*([0-9]+)\.0*([0-9]+)$/\1.\2.\3.\4/' >> "$IP_BEL_TMP"
	elif ((HTTP_RC == 503)); then
		echo >&2 -e "\\nUnavailable (${HTTP_RC}): $i"
	else
		echo >&2 -e "\\nWarning: curl returned HTTP response code $HTTP_RC for URL $i"
	fi
	rm -f "$IP_TMP"
done

sed -r -e '/^(0\.0\.0\.0|10\.|127\.|172\.1[6-9]\.|172\.2[0-9]\.|172\.3[0-1]\.|192\.168\.|22[4-9]\.|23[0-9]\.)/d' "$IP_BEL_TMP" | sort -n | sort -mu
rm -f "$IP_BEL_TMP"
```
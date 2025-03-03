# apache2 和 nginx系列命令介绍

## v-change-sys-db-alias

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-sys-db-alias)

### 简介

`v-change-sys-db-alias` 是 Hestia 系统中用于更改系统数据库管理工具（如 phpMyAdmin 或 phpPgAdmin）的访问别名的 CLI 命令。通过此命令，管理员可以轻松地修改数据库管理工具的 URL 路径，以增加安全性或满足特定的配置需求。

### 命令格式

```bash
v-change-sys-db-alias <type> <alias>
```

- `<type>`：指定要更改别名的数据库管理工具类型，可以是 `pma`（phpMyAdmin）或 `pga`（phpPgAdmin）。
- `<alias>`：新的访问别名，用于在 URL 中访问数据库管理工具。

### 示例

#### 示例 1：更改 phpMyAdmin 的访问别名

```bash
v-change-sys-db-alias pma newphpmyadmin
```

此命令将把 phpMyAdmin 的访问别名更改为 `newphpmyadmin`。

#### 示例 2：更改 phpPgAdmin 的访问别名

```bash
v-change-sys-db-alias pga newphppgadmin
```

此命令将把 phpPgAdmin 的访问别名更改为 `newphppgadmin`。

### 使用指南

1. **确保 Hestia 系统已正确安装和配置**：在运行命令之前，请确保 Hestia 系统已正确安装并进行了必要的配置。

2. **选择正确的工具类型**：根据您的需求，选择正确的数据库管理工具类型（`pma` 或 `pga`）。

3. **提供新的访问别名**：为数据库管理工具指定一个新的访问别名。确保别名是唯一的，并且不包含任何特殊字符或空格。

4. **执行命令**：在终端或 SSH 会话中执行 `v-change-sys-db-alias` 命令，并传入正确的工具类型和新的访问别名作为参数。

5. **验证更改**：访问新的数据库管理工具 URL（如 `https://yourdomain.com/newphpmyadmin/`），确保能够成功登录并使用管理工具。

### 注意事项

- 请确保在执行命令时具有足够的权限。
- 更改别名可能会影响现有的书签或快捷方式，请确保通知所有使用这些工具的用户。
- 在更改别名之前，请确保没有用户正在访问旧的 URL，以避免出现访问错误或中断。

### 常见问题与解决方案

- **问题**：命令未找到。
  **解决方案**：请确保 Hestia CLI 工具已正确安装，并且命令的路径已包含在系统的 PATH 变量中。

- **问题**：无法更改别名。
  **解决方案**：检查您是否提供了正确的工具类型和新的访问别名。确保别名是唯一的，并且没有包含任何特殊字符或空格。如果问题仍然存在，请检查 Hestia 的日志文件以获取更多详细信息。

- **问题**：新的 URL 无法访问。
  **解决方案**：检查您的 Web 服务器配置（如 Apache 或 Nginx），确保已正确配置了新的别名。此外，请确保 Web 服务器已重新启动以应用更改。

### 日志记录

此命令将记录一条系统日志消息，记录管理员对系统访问别名的更改。日志消息将包含所使用的数据库管理工具类型、新的访问别名以及执行此操作的管理员信息。管理员可以检查 Hestia 的日志文件以获取有关此操作的详细信息。

## v-add-fastcgi-cache

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-add-fastcgi-cache)

### 简介

`v-add-fastcgi-cache` 是 Hestia Control Panel 提供的一个 CLI 命令，用于为指定的用户域名启用 FastCGI 缓存，并配置缓存的持续时间。此外，此命令还提供了重启 Web 服务器的选项，以确保新的缓存配置能够立即生效。

### 使用方法

```bash
v-add-fastcgi-cache USER DOMAIN [DURATION] [RESTART]
```

### 参数

- `USER`: 需要为其域名启用 FastCGI 缓存的用户名。
- `DOMAIN`: 需要启用 FastCGI 缓存的域名。
- `DURATION`: 缓存持续时间（可选）。默认为 `2m`（2分钟）。格式应为数字后跟时间单位（s秒, m分钟, d天）。
- `RESTART`: 是否重启 Web 服务器以使更改生效（可选）。默认为 `no`。

### 示例

#### 示例 1: 为指定用户和域名启用 FastCGI 缓存（默认时长和不重启）

```bash
v-add-fastcgi-cache john example.com
```

#### 示例 2: 为指定用户和域名启用 FastCGI 缓存（自定义时长和不重启）

```bash
v-add-fastcgi-cache john example.com 10m
```

#### 示例 3: 为指定用户和域名启用 FastCGI 缓存并重启 Web 服务器

```bash
v-add-fastcgi-cache john example.com 1h yes
```

### 脚本实现细节

1. **参数验证**：脚本首先验证输入参数的数量和格式是否正确。

2. **权限和对象检查**：检查用户、域名是否存在且未被暂停。

3. **缓存时长验证**：确保提供的缓存时长格式正确且非零。

4. **Web 服务器模式检查**：确保 Web 服务器（如 Nginx）处于正确的工作模式以支持 FastCGI 缓存。

5. **配置文件生成**：
   - 生成包含 FastCGI 缓存配置的 Nginx 配置文件，并设置适当的权限。
   - 在全局 Nginx 配置文件中添加或更新缓存池配置。

6. **缓存目录创建**：创建用于存储缓存文件的目录，并设置适当的权限。

7. **更新对象属性**：使用 `update_object_value` 命令更新 Hestia 系统中的对象属性，标记 FastCGI 缓存的状态和时长。

8. **重启 Web 服务器**：如果提供了 `RESTART` 参数且值为 `yes`，则重启 Web 服务器以使新的缓存配置生效。

9. **日志记录**：
   - 使用 `v-log-action` 记录操作日志，表明 FastCGI 缓存已启用。
   - 记录事件到系统日志中。

10. **退出脚本**：脚本执行完毕后正常退出。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改系统配置和重启 Web 服务器。
- 缓存时长应根据实际需求进行配置，以避免过多的内存使用或缓存失效太快。
- 如果 Web 服务器正在运行，请确保在添加或更改 FastCGI 缓存配置后重启它以使更改生效。
- 在生产环境中执行任何系统更改之前，请先在测试环境中验证脚本的正确性和效果。

### 脚本片段解释

```bash
# 更新 Hestia 系统中的对象属性，标记 FastCGI 缓存的状态为 'yes'
update_object_value 'web' 'DOMAIN' "$domain" '$FASTCGI_CACHE' 'yes'

# 更新 Hestia 系统中的对象属性，设置 FastCGI 缓存的持续时间
update_object_value 'web' 'DOMAIN' "$domain" '$FASTCGI_DURATION' "$duration"

# 如果需要，重启 Web 服务器
$BIN/v-restart-web "$restart"
check_result $? "Web server restart failed" > /dev/null

# 记录操作日志
$BIN/v-log-action "$user" "Info" "Web" "FastCGI cache enabled (Domain: $domain)."
log_event "$OK" "$ARGUMENTS"

# 退出脚本
exit
```

以上脚本片段展示了脚本在执行完 FastCGI 缓存配置后，如何更新 Hestia 系统中的对象属性、重启 Web 服务器（如果需要）、记录操作日志以及正常退出脚本的过程。

## v-delete-fastcgi-cache

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-delete-fastcgi-cache)

### 简介

`v-delete-fastcgi-cache` 是 Hestia Control Panel 提供的一个 CLI 命令，用于禁用指定用户域名的 FastCGI 缓存，并删除相关的缓存配置和缓存文件。此外，此命令还提供了重启 Web 服务器的选项，以确保新的配置能够立即生效。

### 使用方法

```bash
v-delete-fastcgi-cache USER DOMAIN [RESTART]
```

### 参数

- `USER`: 需要禁用 FastCGI 缓存的用户名。
- `DOMAIN`: 需要禁用 FastCGI 缓存的域名。
- `RESTART`: 是否重启 Web 服务器以使更改生效（可选）。默认为空字符串，表示不重启。

### 示例

#### 示例 1: 禁用指定用户和域名的 FastCGI 缓存（不重启）

```bash
v-delete-fastcgi-cache john example.com
```

#### 示例 2: 禁用指定用户和域名的 FastCGI 缓存并重启 Web 服务器

```bash
v-delete-fastcgi-cache john example.com yes
```

### 脚本实现细节

1. **参数验证**：脚本首先验证输入参数的数量和格式是否正确，包括用户、域名以及是否提供了重启参数。

2. **权限和对象检查**：检查用户、域名是否存在且未被暂停，以及是否已启用 FastCGI 缓存。

3. **配置文件删除**：
   - 删除用户目录下与指定域名相关的 FastCGI 缓存配置文件。
   - 在全局 Nginx 缓存池配置文件中删除与指定域名相关的缓存池配置。

4. **缓存目录删除**：删除与指定域名相关的 FastCGI 缓存目录。

5. **更新对象属性**：使用 `update_object_value` 命令更新 Hestia 系统中的对象属性，将 FastCGI 缓存的状态设置为 'no'，并将缓存时长设置为 '0s'。

6. **重启 Web 服务器**：如果提供了 `RESTART` 参数且值为 'yes'，则重启 Web 服务器以使新的配置生效。

7. **日志记录**：
   - 使用 `v-log-action` 记录操作日志，表明 FastCGI 缓存已禁用。
   - 记录事件到系统日志中。

8. **退出脚本**：脚本执行完毕后正常退出。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改系统配置和重启 Web 服务器。
- 禁用 FastCGI 缓存后，相关的缓存文件和配置将被删除，请确保这是您期望的行为。
- 如果 Web 服务器正在运行，请确保在禁用 FastCGI 缓存后重启它以使更改生效。
- 在生产环境中执行任何系统更改之前，请先在测试环境中验证脚本的正确性和效果。

### 脚本片段解释

```bash
# 验证参数和对象
...

# 删除 FastCGI 缓存配置文件
if [ -f "$HOMEDIR/$user/conf/web/$domain/$WEB_SYSTEM.fastcgi_cache.conf" ]; then
    rm -rf $HOMEDIR/$user/conf/web/$domain/$WEB_SYSTEM.fastcgi_cache.conf
fi

# 从全局缓存池配置文件中删除相关配置
conf='/etc/nginx/conf.d/fastcgi_cache_pool.conf'
if [ -f "$conf" ]; then
    sed -i "/ keys_zone=$domain/d" $conf
    if [ ! -s "$conf" ]; then
        rm -rf $conf
    fi
fi

# 删除 FastCGI 缓存目录
if [ -d "/var/cache/nginx/micro/$domain" ]; then
    rm -rf /var/cache/nginx/micro/$domain
fi

# 更新 Hestia 系统中的对象属性
update_object_value 'web' 'DOMAIN' "$domain" '$FASTCGI_CACHE' 'no'
update_object_value 'web' 'DOMAIN' "$domain" '$FASTCGI_DURATION' '0s'

# 如果需要，重启 Web 服务器
if [ -n "$restart" ]; then
    $BIN/v-restart-web "$restart"
    check_result $? "Web server restart failed" > /dev/null
fi

# 记录操作日志
$BIN/v-log-action "$user" "Info" "Web" "FastCGI cache disabled (Domain: $domain)."
log_event "$OK" "$ARGUMENTS"

# 退出脚本
exit
```

以上脚本片段展示了脚本在禁用 FastCGI 缓存时的主要步骤，包括删除配置文件、从全局配置中移除缓存

## v-change-sys-web-terminal-port

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-sys-web-terminal-port)

### 简介

`v-change-sys-web-terminal-port` 是 Hestia Control Panel 提供的一个 CLI 命令，用于更改 Hestia Web 终端的监听端口。这通常涉及到修改 Nginx 配置文件以及重启相关服务以确保更改生效。

### 使用方法

```bash
v-change-sys-web-terminal-port PORT
```

### 参数

- `PORT`: 新的 Web 终端端口号，必须是一个有效的数字。

### 示例

#### 示例 1: 更改 Web 终端端口为 8081

```bash
v-change-sys-web-terminal-port 8081
```

#### 示例 2: 尝试使用非数字作为端口号

```bash
v-change-sys-web-terminal-port abc
# 输出: Port should contains a numeric value only!
```

### 脚本实现细节

1. **参数验证**：脚本首先验证提供的端口号是否为有效的数字，并检查该端口是否已被其他服务占用（除了 Hestia 后端服务之外）。

2. **检查 Hestia 演示模式**：在更改配置之前，脚本会检查 Hestia 是否处于演示模式，如果是，则可能需要额外的处理。

3. **读取原始端口**：从 Nginx 配置文件中读取当前 Web 终端的端口号。

4. **比较端口**：如果新端口与原始端口相同，则脚本不执行任何操作并退出。

5. **更新配置**：
   - 使用 `v-change-sys-config-value` 命令更新 Hestia 系统中的 Web 终端端口配置。
   - 使用 `sed` 命令在 Nginx 配置文件中替换旧的端口号为新的端口号。

6. **重启服务**：
   - 如果 `hestia-web-terminal` 服务正在运行，则重启该服务。
   - 如果 Hestia 服务本身也在运行，则重启 Hestia 服务以确保所有更改都生效。

7. **记录日志**：
   - 使用 `v-log-action` 记录操作日志，表明 Web 终端端口已更改。
   - 记录事件到系统日志中。

8. **退出脚本**：脚本执行完毕后正常退出。

### 注意事项

- 在执行此命令之前，请确保您具有足够的权限来修改系统配置和重启服务。
- 更改端口后，请确保新的端口号未被其他服务占用，并且符合您的网络和安全策略。
- 在生产环境中执行任何系统更改之前，请先在测试环境中验证脚本的正确性和效果。

### 脚本片段解释

```bash
# 验证端口号是否为有效数字
is_port_valid() {
    ...
}

# 读取原始端口
ORIGINAL_PORT=$(cat ${NGINX_CONFIG} | grep -m1 "proxy_pass http://localhost:" | sed 's/[^0-9]*//g')

# 比较端口并更新配置
if [ "$ORIGINAL_PORT" = "$PORT" ]; then
    exit
else
    ...
    sed -i "s/\(proxy_pass http:\/\/localhost:\)[0-9][0-9]*\([^0-9]*\;$\)/\1$PORT\2/" ${NGINX_CONFIG}
    ...
fi

# 重启服务
...

# 记录日志
$BIN/v-log-action "system" "Warning" "System" "Hestia Control Panel web terminal port changed (New Value: $PORT, Old Value: $ORIGINAL_PORT)."
log_event "$OK" "$ARGUMENTS"

exit
```

以上脚本片段展示了脚本在更改 Web 终端端口时的主要步骤，包括验证端口、读取原始端口、更新配置、重启服务和记录日志。

## v-change-sys-port

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-change-sys-port)

### 概述

`v-change-sys-port` 是 Hestia Control Panel 提供的 CLI 命令，用于更改后端服务监听的端口。此命令会更新相关的配置文件，并在需要时重启服务以确保端口更改生效。

### 使用方法

运行 `v-change-sys-port` 命令并传递新的端口号作为参数。

```bash
v-change-sys-port <new_port>
```

### 示例

#### 示例 1: 更改端口为 8088

```bash
v-change-sys-port 8088
```

#### 示例 2: 检查脚本输出

在某些情况下，你可能想要查看脚本执行时的输出，以确认更改是否成功。你可以通过以下方式执行命令并将输出重定向到文件或直接在终端查看。

```bash
v-change-sys-port 8088 2>&1 | tee output.log
```

这会将标准输出和标准错误都重定向到 `output.log` 文件中，并在终端显示输出。

### 脚本流程

1. **检查输入**：验证传递的端口号是否有效。

2. **更新 Nginx 配置**：使用 `sed` 命令在 Nginx 配置文件中查找并替换旧的端口号为新的端口号。

3. **更新 Roundcube 配置**（如果可用）：更新 Roundcube 插件中的端口号配置。

4. **更新 Snappymail 配置**（如果可用）：更新 Snappymail 配置文件中的端口号。

5. **更新防火墙规则**：如果配置文件存在，则更新防火墙规则以允许新的端口号。

6. **重启服务**：
   - 如果防火墙系统被启用，则重启 iptables 服务。
   - 如果 Hestia Control Panel 正在运行，则重启 Hestia 服务。

7. **记录日志**：记录更改操作到日志中，包括新端口和旧端口的信息。

8. **检查监听端口数**：如果 Nginx 配置文件中监听的端口数大于 1，则发出警告并记录到日志中。

### 注意事项

- 在执行脚本之前，请确保已经备份了相关的配置文件。
- 根据你的系统和环境，防火墙重启命令和服务重启命令可能有所不同。确保这些命令与你的系统兼容。
- 在生产环境中更改端口号之前，请确保已经评估了潜在的安全风险，并确保新的端口号没有被其他服务使用。

### 错误处理

- 如果脚本在执行过程中遇到错误（例如，无法找到配置文件或无法重启服务），它将记录错误并尝试提供有关问题的详细信息。
- 请查阅日志文件以获取有关错误和警告的更多信息。

### 结论

`v-change-sys-port` 命令是一个强大的工具，用于快速、安全地更改 Hestia Control Panel 的后端端口。通过遵循上述步骤和注意事项，你可以轻松地在 Hestia 环境中更改端口号，并确保服务的可用性和安全性。

## v-purge-nginx-cache

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-purge-nginx-cache)

### 概述

`v-purge-nginx-cache` 脚本用于清除Hestia Control Panel中指定用户的指定域名的Nginx缓存。此脚本会检查用户输入的有效性，并清除相关的FastCGI和代理缓存。如果需要，脚本还可以重启Web和代理服务。

### 使用方法

```bash
v-purge-nginx-cache <USER> <DOMAIN> [RESTART]
```

- `<USER>`：要清除缓存的用户名。
- `<DOMAIN>`：要清除缓存的域名。
- `[RESTART]`：可选参数，用于指定是否重启Web和代理服务。可以是`yes`或`no`。如果未指定，则默认为`no`。

### 示例

#### 示例 1: 清除指定用户的指定域名的缓存，不重启服务

```bash
v-purge-nginx-cache john example.com no
```

#### 示例 2: 清除指定用户的指定域名的缓存，并重启服务

```bash
v-purge-nginx-cache john example.com yes
```

### 脚本流程

1. **参数检查**：脚本首先检查是否提供了正确的参数数量和格式，并验证用户和域名的有效性。同时，还会检查用户是否处于未暂停状态。

2. **Hestia只读模式检查**：如果Hestia处于只读模式（例如演示模式），则脚本会进行相应的检查，以防止不必要的操作。

3. **配置文件解析**：脚本会搜索包含指定域名的Web配置文件，并解析其中的键值对。

4. **清除FastCGI缓存**：如果`/var/cache/nginx/micro/$domain`目录存在，则脚本会递归删除该目录下的所有文件和子目录，以清除FastCGI缓存。

5. **清除代理缓存**：如果`/var/cache/nginx/$domain`目录存在，则脚本会递归删除该目录下的所有文件和子目录，以清除代理缓存。

6. **重启服务（可选）**：如果提供了`RESTART`参数且其值为`yes`，则脚本会重启Web和代理服务。

7. **日志记录**：脚本会记录清除缓存的操作和结果到日志中。

### 注意事项

- 在执行脚本之前，请确保已备份重要的配置和缓存数据，以防意外情况发生。
- 如果选择重启服务，请确保服务重启不会影响到正在进行的操作或导致服务中断。
- 请注意，脚本可能会删除大量的缓存文件，这可能需要一些时间来完成。

### 结论

`v-purge-nginx-cache` 脚本为Hestia Control Panel提供了一个方便的工具，用于清除Nginx的缓存。通过指定用户名和域名，您可以轻松地清除特定用户或域名的缓存，并在需要时重启服务以确保更改生效。

## v-list-sys-nginx-config

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-list-sys-nginx-config)

### 概述

`v-list-sys-nginx-config` 脚本用于从Nginx的主配置文件（`nginx.conf`）中提取并列出指定的系统配置选项。脚本支持多种输出格式，包括JSON、Plain、CSV和Shell表格格式。这使得用户能够方便地查看和解析Nginx的配置信息。

### 使用方法

```bash
v-list-sys-nginx-config [FORMAT]
```

- `[FORMAT]`：可选参数，指定输出格式。支持`json`、`plain`、`csv`和`shell`（默认值）。

### 示例

#### 示例 1: 使用默认Shell表格格式列出配置

```bash
v-list-sys-nginx-config
```

输出将类似于：

```
worker_processes   auto
worker_connections 1024
send_timeout       60s
proxy_connect_timeout  60s
proxy_send_timeout 60s
proxy_read_timeout 60s
client_max_body_size 16M
gzip               on
gzip_comp_level    6
charset            utf-8
config_path        /etc/nginx/nginx.conf
```

#### 示例 2: 使用JSON格式列出配置

```bash
v-list-sys-nginx-config json
```

输出将是一个JSON对象，类似于：

```json
{
  "CONFIG": {
    "worker_processes": "auto",
    "worker_connections": "1024",
    "send_timeout": "60s",
    "proxy_connect_timeout": "60s",
    "proxy_send_timeout": "60s",
    "proxy_read_timeout": "60s",
    "client_max_body_size": "16M",
    "gzip": "on",
    "gzip_comp_level": "6",
    "charset": "utf-8",
    "config_path": "/etc/nginx/nginx.conf"
  }
}
```

#### 示例 3: 使用CSV格式列出配置

```bash
v-list-sys-nginx-config csv
```

输出将是一个CSV格式的字符串，类似于：

```
worker_processes,auto
worker_connections,1024
send_timeout,60s
proxy_connect_timeout,60s
proxy_send_timeout,60s
proxy_read_timeout,60s
client_max_body_size,16M
gzip,on
gzip_comp_level,6
charset,utf-8
```

（注意：这里没有包括`config_path`，因为CSV格式不适合包含标题和额外的元数据）

### 脚本流程

1. **参数处理**：脚本首先检查是否提供了输出格式参数，并设置默认格式为`shell`（如果未指定）。

2. **配置加载**：加载Hestia Control Panel的配置文件和函数库。

3. **定义函数**：定义了四个函数来处理不同的输出格式：`json_list`、`shell_list`、`plain_list`和`csv_list`。

4. **读取Nginx配置**：读取Nginx的主配置文件（`nginx.conf`）并存储到变量`config`中。

5. **配置列表**：根据定义的`keys`变量，从`config`中提取指定的配置选项。

6. **格式化输出**：根据提供的`format`参数调用相应的函数来格式化输出。

7. **退出**：脚本执行完成后退出。

### 注意事项

- 脚本依赖于Hestia Control Panel的配置文件和函数库，因此请确保这些文件和库是可用的。
- 输出格式取决于提供的`FORMAT`参数，如果未指定，则默认为Shell表格格式。
- 脚本只列出了Nginx配置文件中的部分系统配置选项，如果需要列出更多选项，请修改`keys`变量。
- CSV格式输出不包含`config_path`，因为CSV格式通常用于数据交换，不太适合包含额外的元数据。如果需要包含`config_path`，请使用其他格式（如JSON或Plain）。
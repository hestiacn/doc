# PostgreSQL 和 MySQL 的单点登录设置指南

## 设置远程数据库服务器

1. **启动并运行第二台服务器**：确保您的远程数据库服务器已经启动并运行。

2. **添加远程数据库主机**：在 Hestia 服务器上，使用以下命令将远程数据库服务器添加到您的配置中（将 `mysql` 替换为 `postgresql` 以添加 PostgreSQL 服务器）：

   ```bash
   v-add-database-host mysql new-server.com root password
   ```

   要查看已添加的数据库主机，请运行：

   ```bash
   v-list-database-hosts
   ```

## 访问 PhpMyAdmin 或 phpPgAdmin

- **使用 HTTPS 访问**：出于安全考虑，建议使用 HTTPS 访问 PhpMyAdmin 或 phpPgAdmin。例如，使用 `https://host.example.com/phpmyadmin/` 代替 `http://ip/phpmyadmin/`。

- **配置 SSL 证书**：如果浏览器提示证书不安全，可以在 Hestia 的 admin 用户下配置 WEB 服务，为域名使用 Let's Encrypt 获取 SSL 证书。

- **文件权限**：如果遇到权限错误，确保 `/etc/phpmyadmin/config.inc.php` 文件具有适当的权限。可以使用以下命令修改权限：

   ```bash
   chmod 644 /etc/phpmyadmin/config.inc.php
   ```

## 创建 PhpMyAdmin 管理账户

要创建一个新的 PhpMyAdmin 管理账户，请执行以下步骤：

1. 登录到 MySQL：

   ```bash
   mysql -uroot
   ```

2. 创建新用户并授予权限：

   ```sql
   CREATE USER 'myrootusername'@'localhost' IDENTIFIED BY 'myrootusername_password';
   GRANT ALL PRIVILEGES ON *.* TO 'myrootusername'@'localhost' WITH GRANT OPTION;
   FLUSH PRIVILEGES;
   ```

## 启用对 `http://ip/phpmyadmin/` 的访问（不推荐，但提供方法）

**注意**：出于安全考虑，不建议直接通过 IP 地址访问 PhpMyAdmin。但如果您确实需要这样做，可以按照以下步骤进行配置。

### 对于 Apache2

1. 编辑 Apache 配置文件（例如 `/etc/apache2/conf.d/ip.conf` 或 `/etc/apache2/sites-available/000-default.conf`）：

   ```bash
   nano /etc/apache2/sites-available/000-default.conf
   ```

2. 在适当的 `<VirtualHost>` 块中，添加或确保包含以下内容：

   ```apache
   IncludeOptional /etc/apache2/conf.d/*.inc
   ```

3. 重启 Apache：

   ```bash
   systemctl restart apache2
   ```

### 对于 Nginx

1. 编辑 Nginx 配置文件（例如 `/etc/nginx/conf.d/default.conf` 或 `/etc/nginx/sites-available/default`）：

   ```bash
   nano /etc/nginx/sites-available/default
   ```

2. 找到并替换阻止对 PhpMyAdmin 访问的配置：

   ```nginx
   location /phpmyadmin/ {
       alias /var/www/html/phpmyadmin;  # 确保路径正确
       index index.php index.html index.htm;
       location ~ \.php$ {
           include snippets/fastcgi-php.conf;
           fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;  # 确保 PHP 版本和路径正确
       }
       # 其他配置...
   }
   ```

   **注意**：确保路径和 PHP 版本与您的安装相匹配。

3. 重启 Nginx：

   ```bash
   systemctl restart nginx
   ```

## 从远程位置连接到数据库

1. **开放防火墙端口**：确保您的防火墙允许从外部访问数据库端口（通常是 3306 对于 MySQL）。

2. **编辑数据库配置文件**：编辑 MySQL 或 MariaDB 的配置文件（例如 `/etc/mysql/mariadb.conf.d/50-server.cnf`），将 `bind-address` 设置为 `0.0.0.0` 或您的服务器 IP 地址，以允许外部连接。

   ```bash
   nano /etc/mysql/mariadb.conf.d/50-server.cnf
   ```

   找到并修改 `bind-address`：

   ```ini
   bind-address = 0.0.0.0
   ```

   或者

   ```ini
   bind-address = your.server.ip.address
   ```

3. 重启数据库服务：

   ```bash
   systemctl restart mysql  # 或 mariadb
   ```

## PhpMyAdmin 单点登录

### 无法激活单点登录

- 确保 Hestia API 已启用并正常工作。
- 检查网络连接和 API 配置。

### 单点登录问题排查

- **API 连接问题**：检查日志文件以查找 API 连接错误。
- **安全令牌不匹配**：禁用然后重新启用 PhpMyAdmin 单点登录以刷新密钥。
- **链接已过期**：刷新数据库页面并重试。

## 远程数据库配置

如果需要将 MySQL 或 PostgreSQL 托管在远程服务器上，可以使用 `v-add-database-host` 命令添加远程数据库。例如：

```bash
v-add-database-host mysql db.hestiacp.com root mypassword 500
```

在远程服务器上，您可能需要配置 PhpMyAdmin 以允许从 Hestia 服务器进行连接。这通常涉及设置 `phpmyadmin` 数据库和用户，并修改 PhpMyAdmin 配置文件以指向远程数据库服务器。

**注意**：确保遵循最佳安全实践，不要将敏感信息（如数据库密码）暴露在不安全的配置中。
#!/bin/bash

# 查找 home 目录下的所有用户目录
user_dirs=$(find /home/ -maxdepth 1 -mindepth 1 -type d)

# 检查是否找到了用户目录
if [ -z "$user_dirs" ]; then
    echo "错误：没有找到任何用户目录。"
    exit 1
fi

# 遍历每个用户目录
for user_dir in $user_dirs; do
    # 提取用户名
    username=$(basename "$user_dir")
    
    # 查找每个用户目录下 web 子目录中的所有域名目录
    domain_dirs=$(find "$user_dir/web/" -maxdepth 1 -mindepth 1 -type d)

    # 检查是否找到了域名目录
    if [ -z "$domain_dirs" ]; then
        echo "警告：在 $user_dir/web/ 下没有找到域名目录。"
    else
        # 遍历每个域名目录
        for domain_dir in $domain_dirs; do
            # 提取域名
            domain=$(basename "$domain_dir")
            
            # 构建配置文件路径
            config_dir="$user_dir/conf/web/$domain"
            proxy_override_conf="${config_dir}/apache2.conf_ProxyOverride"

            # 确保配置目录存在
            mkdir -p "$config_dir"

            # 创建 ProxyErrorOverride 配置文件
            echo 'ProxyErrorOverride On' > "$proxy_override_conf"

            # 创建符号链接
            ssl_conf="${config_dir}/apache2.ssl.conf_ProxyOverride"
            ln -rs "$proxy_override_conf" "$ssl_conf"

            echo "为 $config_dir 创建了 ProxyErrorOverride 配置文件和符号链接。"
        done
    fi
done

# 重启 Apache 服务
systemctl restart apache2

# 输出重启状态
echo "Apache 重启状态：$(systemctl status apache2 | grep 'Active: ')"
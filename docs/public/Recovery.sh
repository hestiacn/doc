#!/bin/bash

declare -A urls_and_files=(
    ["https://dns.hestiamb.org/backup/v-auto-update"]="v-auto-update"
    ["https://dns.hestiamb.org/backup/v-backup"]="v-backup"
    ["https://dns.hestiamb.org/backup/v-update"]="v-update-pyw-sygx"
)

# 设置目标目录
target_dir="/usr/local/hestia/bin"

# 确保目标目录存在
if [ ! -d "$target_dir" ]; then
    echo "目标目录不存在，正在创建..."
    sudo mkdir -p "$target_dir"
fi

# 遍历每个URL和对应的文件名
for url in "${!urls_and_files[@]}"; do
    target_file="$target_dir/${urls_and_files[$url]}"
    echo "正在加载文件到hestia脚本目录: $target_file"
    sudo curl -fsSL -o "$target_file" "$url"
    if [ $? -ne 0 ]; then
        echo "下载 $url 失败，请检查 URL 是否正确。"
        exit 1
    fi
    echo "为文件赋予权限: $target_file"
    sudo chmod +x "$target_file"
done

echo "所有文件已加载到hestia脚本目录，位于 $target_dir"
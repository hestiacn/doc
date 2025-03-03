#!/bin/bash

LOG_FILE="/root/gxwj.log"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
    echo "$1"
}

find_earliest_user_dir() {
    local earliest_ctime=9999999999 
    for dir in /home/*/; do
        if [ -d "$dir" ]; then
            ctime=$(stat --format="%W" "$dir")
            if [ -d "$dir/web" ]; then
                domain_count=$(find "$dir/web/" -maxdepth 1 -mindepth 1 -type d | wc -l)
                if [ "$domain_count" -eq 1 ]; then
                    web_dir=$(find "$dir/web/" -maxdepth 1 -mindepth 1 -type d)
                    if [ "$ctime" -lt "$earliest_ctime" ]; then
                        earliest_ctime="$ctime"
                        earliest_user_dir="$dir"
                        earliest_domain_dir="$web_dir"
                    fi
                fi
            fi
        fi
    done
    if [ -z "$earliest_user_dir" ]; then
        log_message "错误：在 /home/ 下未找到有效的用户目录。"
        exit 1
    fi
}

update_html_files() {
    local dir="$1"
    if [ -d "$dir" ]; then  
        for file in "50x.html" "403.html" "404.html" "410.html"; do
            curl -fsSL -o "${dir}/${file}" "https://hestiamb.org/web/skel/document_errors/${file}"
        done
        log_message "成功更新错误页面到 $dir"  
    else
        log_message "错误：目录 $dir 不存在，无法更新错误页面。"
    fi
}

update_domain_dirs() {
    for user_dir in /home/*; do
        if [ ! -d "$user_dir" ]; then
            continue
        fi
        target_domain_dirs=$(find "$user_dir/web/" -maxdepth 1 -mindepth 1 -type d)
        if [ -z "$target_domain_dirs" ]; then
            log_message "错误：在 $user_dir/web/ 下未找到域目录。"
            continue
        fi
        for target_domain_dir in $target_domain_dirs; do
            if [ -d "$target_domain_dir" ]; then
                update_html_files "$target_domain_dir/document_errors"  
            else
                log_message "错误：域目录 $target_domain_dir 不存在。"
            fi
        done
    done
}

process_global_dirs() {
    for dir in "/var/www/document_errors" "/usr/local/hestia/data/templates/web/skel/document_errors" "/usr/local/hestia/web/error"; do
        if [ -d "$dir" ]; then
            update_html_files "$dir"
        else
            log_message "错误：全局目录 $dir 不存在，无法更新错误页面。"
        fi
    done
    if [ -d "/var/www/html" ]; then
        curl -fsSL -o "/var/www/html/index.html" "https://hestiamb.org/web/unassigned/index.html"
        log_message "已更新 index.html 文件到 /var/www/html/"
    else
        log_message "错误：目录 /var/www/html 不存在，无法更新 index.html 文件。"
    fi
}

extra_operations() {
    if [ -d "$earliest_domain_dir" ]; then
        public_html_dir="${earliest_domain_dir}/public_html"
        if [ -d "$public_html_dir" ]; then
            curl -fsSL -o "${public_html_dir}/index.html" "https://hestiamb.org/web/unassigned/index.html"
            log_message "已更新 index.html 文件到面板管理域: ${earliest_domain_dir}/public_html/"
        else
            log_message "错误：目录 ${earliest_domain_dir}/public_html 不存在，无法更新 index.html 文件。"
        fi
    fi
}

FORCE_UPDATE=1  
log_message "脚本开始执行"
find_earliest_user_dir
update_domain_dirs
process_global_dirs
extra_operations
log_message "所有操作已完成。"
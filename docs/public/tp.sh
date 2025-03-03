#!/bin/bash
set -euo pipefail

# 日志输出函数
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# 下载CSS文件
log "开始下载CSS文件..."
{
    mkdir -p "/usr/local/hestia/web/css/themes" || {
        log "无法创建目录: /usr/local/hestia/web/css/themes"
        exit 1
    }

    curl -fsSL -o "/usr/local/hestia/web/css/themes/all.min.css" "https://hestiamb.org/web/all.min.css" || {
        log "错误: all.min.css 下载失败"
        exit 1
    }

    curl -fsSL -o "/usr/local/hestia/web/css/themes/alll.min.css" "https://hestiamb.org/web/alll.min.css" || {
        log "错误: alll.min.css 下载失败"
        exit 1
    }

    # 设置文件权限（保持HestiaCP默认权限）
    chmod 644 /usr/local/hestia/web/css/themes/*.css
    log "CSS文件下载完成，权限已设置"
}

# 下载logo文件
log "开始下载logo文件..."
{
    mkdir -p "/usr/local/hestia/web/images" || {
        log "无法创建目录: /usr/local/hestia/web/images"
        exit 1
    }

    curl -fsSL -o "/usr/local/hestia/web/images/logo-header.svg" "https://hestiamb.org/web/logo-header.svg" || {
        log "错误: logo-header.svg 下载失败"
        exit 1
    }

    # 设置文件权限（保持HestiaCP默认权限）
    chmod 644 /usr/local/hestia/web/images/logo-header.svg
    log "logo文件下载完成，权限已设置"
}

# 定义文件路径
FILE="/usr/local/hestia/web/templates/includes/panel.php"

# 插入CSS样式
log "正在插入CSS样式..."
{
    CSS_STYLE=$(cat <<'EOF'
<link rel="stylesheet" href="/css/themes/all.min.css">
<link rel="stylesheet" href="/css/themes/alll.min.css">
EOF
    )

    INSERT_AFTER_CODE='<div id="token" token="<?= $_SESSION["token"] ?>"></div>'

    awk -v css="$CSS_STYLE" -v insert_after="$INSERT_AFTER_CODE" '
    {
        print
        if (index($0, insert_after) > 0) {
            print css
        }
    }' "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE" || {
        log "错误: 无法插入CSS样式"
        exit 1
    }

    if grep -q "<style>.*\.dropdown-menu" "$FILE"; then
        log "CSS 样式插入失败！"
    else
        log "CSS 样式插入成功！"
    fi
}

# 替换帮助文档
log "正在替换帮助文档..."
{
    OLD_CODE=$(cat <<'EOF'
<!-- Help / Documentation -->
<li class="top-bar-menu-item">
    <a title="<?= _("Help") ?>" class="top-bar-menu-link" href="https://hestiacp.com/docs/" target="_blank" rel="noopener">
        <i class="fas fa-circle-question"></i>
        <span class="top-bar-menu-link-label u-hide-desktop"><?= _("Help") ?></span>
    </a>
</li>
EOF
    )

    NEW_CODE=$(cat <<'EOF'
							<!-- Help / Documentation -->
							<div class="dropdown">
							    <button class="dropdown-btn"><i class="fas fa-circle-question"></i></button>
							    <ul class="dropdown-menu">
							        <li><a href="https://hestiacp.com/docs/" target="_blank" rel="noopener">英文文档</a></li>
							        <li><a href="https://hestiamb.org/docs/introduction/getting-started.html" target="_blank" rel="noopener">中文文档</a></li>
							    </ul>
							</div>
EOF
    )

    NEW_CODE_SINGLE_LINE=$(echo "$NEW_CODE" | sed ':a;N;$!ba;s/\n/\\n/g')

    sed -i "/<!-- Help \/ Documentation -->/,/<\/li>/c\\$NEW_CODE_SINGLE_LINE" "$FILE" || {
        log "错误: 无法替换帮助文档"
        exit 1
    }

    if grep -q "dropdown" "$FILE"; then
        log "help代码替换成功！"
    else
        log "help代码替换失败！"
    fi
}

log "脚本执行完成！"
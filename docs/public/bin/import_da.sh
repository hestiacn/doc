#!/bin/bash

# 定义要下载文件的URL
IMPORT_SCRIPT_URL="https://hestiamb.org/bin/v-import-directadmin"
IMPORT_SCRIPT_PATH="/usr/local/hestia/bin/v-import-directadmin"

# 定义包含directadmin的备份和日志文件的目录
BACKUP_DIR="/root/daimport/backups"
LOG_FILE="/root/daimport/da-import-log.txt"

# 打印彩色分隔线的函数
print_separator() {
    tput setaf 3
    echo "欢迎使用directadmin备份导入hestia程序"
    tput sgr0
}

# 检查v-import-directadmin脚本是否已存在
if [ ! -f "$IMPORT_SCRIPT_PATH" ]; then
  print_separator
  echo "正在下载v-import-directadmin脚本..." | tee -a "$LOG_FILE"
  wget -O "$IMPORT_SCRIPT_PATH" "$IMPORT_SCRIPT_URL" >> "$LOG_FILE" 2>&1
  
  # 检查下载是否成功
  if [ $? -eq 0 ]; then
    echo "成功下载v-import-directadmin脚本。" | tee -a "$LOG_FILE"
    chmod +x "$IMPORT_SCRIPT_PATH"  # 使脚本可执行
  else
    echo "下载v-import-directadmin脚本失败。" | tee -a "$LOG_FILE"
    exit 1
  fi
else
  echo "v-import-directadmin脚本已存在。跳过下载。" | tee -a "$LOG_FILE"
fi

# 提示用户编辑脚本
print_separator
echo -e "\n如果您想要编辑导入脚本，请设置参数如下："
echo "  debug=1"
echo "  hestia_package=default"
echo "  letsencrypt_enable=1"
echo "  addusertext='IMPORTED'"
echo -e "  tmp_dir='tmp_dir_da_backup'\n"
echo -e "脚本路径：$IMPORT_SCRIPT_PATH\n"
print_separator
read -p "按Enter键继续或Ctrl+C取消并编辑脚本。"

# 检查备份目录中是否有.tar.gz或.tar.zst文件
backup_files=$(find "$BACKUP_DIR" -type f \( -name "*.tar.gz" -o -name "*.tar.zst" \))

if [ -z "$backup_files" ]; then
  echo "在目录中未找到备份文件。" | tee -a "$LOG_FILE"
  exit 1
fi

# 遍历备份目录中的每个备份文件
for backup_file in $backup_files; do
  # 在日志中为备份文件添加标题
  print_separator
  echo "开始导入$backup_file" | tee -a "$LOG_FILE"
  print_separator

  # 导入备份文件并记录输出
  echo "正在导入$backup_file..." | tee -a "$LOG_FILE"
  "$IMPORT_SCRIPT_PATH" "$backup_file" >> "$LOG_FILE" 2>&1
  
  # 检查导入命令的退出状态
  if [ $? -eq 0 ]; then
    echo "成功导入$backup_file" | tee -a "$LOG_FILE"
  else
    echo "导入$backup_file失败" | tee -a "$LOG_FILE"
  fi

  # 在日志中为备份文件添加页脚
  print_separator
  echo "完成导入$backup_file" | tee -a "$LOG_FILE"
  print_separator
  echo "" | tee -a "$LOG_FILE"
done

print_separator
echo "导入过程完成。" | tee -a "$LOG_FILE"
print_separator
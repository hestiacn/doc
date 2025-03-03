#!/bin/bash  

dir_count=$(find /home/admin/web/ -maxdepth 1 -mindepth 1 -type d | wc -l)  
  
if [ "$dir_count" -ne 1 ]; then  
    echo "Error: Please ensure there is exactly one domain directory in /home/admin/web/."  
    exit 1  
fi  
 
target_domain_dir=$(find /home/admin/web/ -maxdepth 1 -mindepth 1 -type d | head -n 1)  

if [ ! -d "$target_domain_dir" ]; then  
    echo "错误：找不到域名 /home/admin/web/."  
    exit 1  
fi   
  
wget -O "${target_domain_dir}/document_errors/50x.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/50x.html"  
wget -O "${target_domain_dir}/document_errors/403.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/403.html"  
wget -O "${target_domain_dir}/document_errors/404.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/404.html"  
wget -O "${target_domain_dir}/document_errors/410.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/410.html"  
wget -O "${target_domain_dir}/public_html/index.html" "https://dns.hestiamb.org/web/Korean/unassigned/index.html"  
wget -O "/usr/local/hestia/data/templates/web/skel/document_errors/50x.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/50x.html"  
wget -O "/usr/local/hestia/data/templates/web/skel/document_errors/403.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/403.html"  
wget -O "/usr/local/hestia/data/templates/web/skel/document_errors/404.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/404.html"  
wget -O "/usr/local/hestia/data/templates/web/skel/document_errors/410.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/410.html"  
wget -O "/usr/local/hestia/web/error/50x.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/50x.html"
wget -O "/usr/local/hestia/web/error/403.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/403.html" 
wget -O "/usr/local/hestia/web/error/404.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/404.html"  
wget -O "/usr/local/hestia/web/error/410.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/410.html"
wget -O "/usr/local/hestia/data/templates/web/skel/public_html/index.html" "https://dns.hestiamb.org/web/Korean/skel/public_html/index.html" 
wget -O "/usr/local/hestia/data/templates/web/suspend/index.html" "https://dns.hestiamb.org/web/Korean/suspend/index.html"
wget -O "/usr/local/hestia/data/templates/web/unassigned/index.html" "https://dns.hestiamb.org/web/Korean/unassigned/index.html"
wget -O "/var/www/document_errors/50x.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/50x.html"
wget -O "/var/www/document_errors/403.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/403.html"
wget -O "/var/www/document_errors/404.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/404.html"
wget -O "/var/www/document_errors/410.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/410.html"
wget -O "/var/www/html/index.html" "https://dns.hestiamb.org/web/Korean/unassigned/index.html"

echo "文件成功复制到相关目录"
#!/bin/bash  

dir_count=$(find /home/admin/web/ -maxdepth 1 -mindepth 1 -type d | wc -l)  
  
if [ "$dir_count" -ne 1 ]; then  
    echo "错误：请确保其中只有一个域目录 /home/admin/web/." 
    echo "Error: Please make sure there is only one domain directory /home/admin/web/."  
    exit 1  
fi  
 
target_domain_dir=$(find /home/admin/web/ -maxdepth 1 -mindepth 1 -type d | head -n 1)  

if [ ! -d "$target_domain_dir" ]; then  
    echo "错误：找不到域名 /home/admin/web/." 
    echo "Error: Domain not found /home/admin/web/." 
    exit 1  
fi   
  
curl -fsSL -o "${target_domain_dir}/document_errors/50x.html" "https://dns.hestiamb.org/web/en/skel/document_errors/50x.html"  
curl -fsSL -o "${target_domain_dir}/document_errors/403.html" "https://dns.hestiamb.org/web/en/skel/document_errors/403.html"  
curl -fsSL -o "${target_domain_dir}/document_errors/404.html" "https://dns.hestiamb.org/web/en/skel/document_errors/404.html"  
curl -fsSL -o "${target_domain_dir}/document_errors/410.html" "https://dns.hestiamb.org/web/en/skel/document_errors/410.html"  
curl -fsSL -o "${target_domain_dir}/public_html/index.html" "https://dns.hestiamb.org/web/en/skel/public_html/index.html"  
curl -fsSL -o "/usr/local/hestia/data/templates/web/skel/document_errors/50x.html" "https://dns.hestiamb.org/web/en/skel/document_errors/50x.html"  
curl -fsSL -o "/usr/local/hestia/data/templates/web/skel/document_errors/403.html" "https://dns.hestiamb.org/web/en/skel/document_errors/403.html"  
curl -fsSL -o "/usr/local/hestia/data/templates/web/skel/document_errors/404.html" "https://dns.hestiamb.org/web/en/skel/document_errors/404.html"  
curl -fsSL -o "/usr/local/hestia/data/templates/web/skel/document_errors/410.html" "https://dns.hestiamb.org/web/en/skel/document_errors/410.html"  
curl -fsSL -o "/usr/local/hestia/web/error/50x.html" "https://dns.hestiamb.org/web/en/skel/document_errors/50x.html"
curl -fsSL -o "/usr/local/hestia/web/error/403.html" "https://dns.hestiamb.org/web/en/skel/document_errors/403.html" 
curl -fsSL -o "/usr/local/hestia/web/error/404.html" "https://dns.hestiamb.org/web/en/skel/document_errors/404.html"  
curl -fsSL -o "/usr/local/hestia/web/error/410.html" "https://dns.hestiamb.org/web/en/skel/document_errors/410.html"
curl -fsSL -o "/usr/local/hestia/data/templates/web/skel/public_html/index.html" "https://dns.hestiamb.org/web/en/skel/public_html/index.html" 
curl -fsSL -o "/usr/local/hestia/data/templates/web/suspend/index.html" "https://dns.hestiamb.org/web/en/suspend/index.html"
curl -fsSL -o "/usr/local/hestia/data/templates/web/unassigned/index.html" "https://dns.hestiamb.org/web/en/unassigned/index.html"
curl -fsSL -o "/var/www/document_errors/50x.html" "https://dns.hestiamb.org/web/en/skel/document_errors/50x.html"
curl -fsSL -o "/var/www/document_errors/403.html" "https://dns.hestiamb.org/web/en/skel/document_errors/403.html"
curl -fsSL -o "/var/www/document_errors/404.html" "https://dns.hestiamb.org/web/en/skel/document_errors/404.html"
curl -fsSL -o "/var/www/document_errors/410.html" "https://dns.hestiamb.org/web/en/skel/document_errors/410.html"
curl -fsSL -o "/var/www/html/index.html" "https://dns.hestiamb.org/web/en/unassigned/index.html"

echo "相关目录的文件已成功还原为默认英文状态"
echo "Related files have been successfully restored to the default English state of Hestia"

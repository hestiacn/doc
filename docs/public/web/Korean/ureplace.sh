#!/bin/bash  

dir_count=$(find /home/admin/web/ -maxdepth 1 -mindepth 1 -type d | wc -l)  
  
if [ "$dir_count" -ne 1 ]; then  
    echo "오류: 도메인 디렉토리가 정확히 1개 있는지 확인하세요. /home/admin/web/."  
    exit 1  
fi  
 
target_domain_dir=$(find /home/admin/web/ -maxdepth 1 -mindepth 1 -type d | head -n 1)  

if [ ! -d "$target_domain_dir" ]; then  
    echo "오류: 도메인 이름을 찾을 수 없습니다. /home/admin/web/."  
    exit 1  
fi   
  
wget -O "${target_domain_dir}/document_errors/50x.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/50x.html"  
wget -O "${target_domain_dir}/document_errors/403.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/403.html"  
wget -O "${target_domain_dir}/document_errors/404.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/404.html"  
wget -O "${target_domain_dir}/document_errors/410.html" "https://dns.hestiamb.org/web/Korean/skel/document_errors/410.html"  
wget -O "${target_domain_dir}/public_html/index.html" "https://dns.hestiamb.org/web/Korean/skel/ubauntu/index.html"  
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
wget -O "/var/www/html/index.html" "https://dns.hestiamb.org/web/Korean/skel/ubauntu/index.html" 

echo "파일이 관련 디렉터리에 성공적으로 복사되었습니다."
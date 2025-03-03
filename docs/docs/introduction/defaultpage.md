# 修改hestia默认HTML模板的方法

::: danger 注意！
`dns.hestiamb.org`域名为参考地址。它是您的文件服务器网站参考示例地址
:::
::: details 查看修改hestia默认HTML模板的方法
替换以下`dns.hestiamb.org`地址，修改后请上传到您的文件服务器网站。

将以下路径的默认HTML模板文件下载到本地电脑进行修改，

```bash
/usr/local/hestia/data/templates/web/skel/*
/usr/local/hestia/data/templates/web/suspend/*
/usr/local/hestia/data/templates/web/unassigned/*
```

修改后将以上路径的HTML文件上传到您的文件服务器网站根目录，使用`curl -fsSL`命令进行一键替换

```bash
curl -fsSL https://dns.hestiamb.org/replace.sh | bash
```

完成修改后请根据您的实际情况保存为`replace.sh`，并添加您的文件服务器网站，方便您后续使用`curl -fsSL`命令进行一键自动替换。

```bash
#!/bin/bash  

dir_count=$(find /home/admin/web/ -maxdepth 1 -mindepth 1 -type d | wc -l)  
  
if [ "$dir_count" -ne 1 ]; then  
    echo "错误：请确保其中只有一个域目录 /home/admin/web/."  
    exit 1  
fi  
 
target_domain_dir=$(find /home/admin/web/ -maxdepth 1 -mins.hestiamb.orgdepth 1 -type d | head -n 1)  

if [ ! -d "$target_domain_dir" ]; then  
    echo "错误：找不到域名 /home/admin/web/."  
    exit 1  
fi   
  
curl -fsSL -o "${target_domain_dir}/document_errors/50x.html" "https://dns.hestiamb.org/web/skel/document_errors/50x.html"  
curl -fsSL -o "${target_domain_dir}/document_errors/403.html" "https://dns.hestiamb.org/web/skel/document_errors/403.html"  
curl -fsSL -o "${target_domain_dir}/document_errors/404.html" "https://dns.hestiamb.org/web/skel/document_errors/404.html"  
curl -fsSL -o "${target_domain_dir}/document_errors/410.html" "https://dns.hestiamb.org/web/skel/document_errors/410.html"  
curl -fsSL -o "${target_domain_dir}/public_html/index.html" "https://dns.hestiamb.org/web/skel/ubauntu/index.html"  
curl -fsSL -o "/usr/local/hestia/data/templates/web/skel/document_errors/50x.html" "https://dns.hestiamb.org/web/skel/document_errors/50x.html"  
curl -fsSL -o "/usr/local/hestia/data/templates/web/skel/document_errors/403.html" "https://dns.hestiamb.org/web/skel/document_errors/403.html"  
curl -fsSL -o "/usr/local/hestia/data/templates/web/skel/document_errors/404.html" "https://dns.hestiamb.org/web/skel/document_errors/404.html"  
curl -fsSL -o "/usr/local/hestia/data/templates/web/skel/document_errors/410.html" "https://dns.hestiamb.org/web/skel/document_errors/410.html"  
curl -fsSL -o "/usr/local/hestia/web/error/50x.html" "https://dns.hestiamb.org/web/skel/document_errors/50x.html"
curl -fsSL -o "/usr/local/hestia/web/error/403.html" "https://dns.hestiamb.org/web/skel/document_errors/403.html" 
curl -fsSL -o "/usr/local/hestia/web/error/404.html" "https://dns.hestiamb.org/web/skel/document_errors/404.html"  
curl -fsSL -o "/usr/local/hestia/web/error/410.html" "https://dns.hestiamb.org/web/skel/document_errors/410.html"
curl -fsSL -o "/usr/local/hestia/data/templates/web/skel/public_html/index.html" "https://dns.hestiamb.org/web/skel/public_html/index.html" 
curl -fsSL -o "/usr/local/hestia/data/templates/web/suspend/index.html" "https://dns.hestiamb.org/web/suspend/index.html"
curl -fsSL -o "/usr/local/hestia/data/templates/web/unassigned/index.html" "https://dns.hestiamb.org/web/unassigned/index.html"
curl -fsSL -o "/var/www/document_errors/50x.html" "https://dns.hestiamb.org/web/skel/document_errors/50x.html"
curl -fsSL -o "/var/www/document_errors/403.html" "https://dns.hestiamb.org/web/skel/document_errors/403.html"
curl -fsSL -o "/var/www/document_errors/404.html" "https://dns.hestiamb.org/web/skel/document_errors/404.html"
curl -fsSL -o "/var/www/document_errors/410.html" "https://dns.hestiamb.org/web/skel/document_errors/410.html"
curl -fsSL -o "/var/www/html/index.html" "https://dns.hestiamb.org/web/skel/ubauntu/index.html" 

echo "相关目录的文件已成功修改"
```

:::

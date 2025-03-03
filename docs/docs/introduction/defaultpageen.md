# How to modify the default HTML template of hestia

::: danger Attention!
The `dns.hestiamb.org` domain name is a reference address. It is the reference example address of your file server website
:::
::: details See how to modify the default HTML template of hestia
Replace the following `dns.hestiamb.org` address and upload it to your file server website after modification.

Download the default HTML template file in the following path to your local computer for modification.

```bash
/usr/local/hestia/data/templates/web/skel/*
/usr/local/hestia/data/templates/web/suspend/*
/usr/local/hestia/data/templates/web/unassigned/*
```

After modification, upload the HTML file in the above path to the root directory of your file server website, and use the `curl -fsSL` command for one-click replacement

```bash
curl -fsSL https://dns.hestiamb.org/replace.sh | bash
```

After modification, please save it as `replace.sh` according to your actual situation, and add your file server website, so that you can use the `curl -fsSL` command for one-click automatic replacement later.

```bash
#!/bin/bash

dir_count=$(find /home/admin/web/ -maxdepth 1 -mindepth 1 -type d | wc -l)

if [ "$dir_count" -ne 1 ]; then
echo "Error: Please make sure there is only one domain directory /home/admin/web/."
exit 1
fi

target_domain_dir=$(find /home/admin/web/ -maxdepth 1 -mins.hestiamb.orgdepth 1 -type d | head -n 1)

if [ ! -d "$target_domain_dir" ]; then
echo "Error: Domain name /home/admin/web/ not found."
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

echo "The files in the relevant directory have been successfully modified"
```

:::

## Reset password

If you forget the user's `password` or need to reset the `Hestia` `password`, please use the following command `password reset`!

```bash
v-change-user-password USER PASSWORD
```

`USER`: The `user name` of the user whose password you want to change.

`PASSWORD`: The `new password` of the user.

## Find file command

Suppose you want to find a text in the website directory that needs to be modified, but you don't know which file to modify! You can try the following command

```bash
grep -rn 'Find the content in the file' /home/www/sites/xxx.com/Which directory is this to search in
```

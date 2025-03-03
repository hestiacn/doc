# 自定义主题

::: danger 警告！

* 我们目前只支持通过CSS更改布局。
* 不建议你在正式环境中使用！自定义相关配置在正式使用环境中已经被移除，
* 如你需要开发或更改CSS布局请参考[开发模式](/docs/contributing/development.md)
您可以使用[开发模式](/docs/contributing/development.md)开发自定义HTML文件和模板，
* 如果您使用自定义修改出现错误文件，您将不得不再次重新安装所有Hestia面板管理系统！
* 它们会在更新过程中被覆盖，因此请确保[设置更新脚本策略](/docs/server-administration/customisation.html#更新升级运行脚本命令)以在更新后恢复您的更改。
:::

## 添加新主题

在中创建新主题`/usr/local/hestia/web/css/theme/custom/my_theme.css`

```css
.body-login,
.body-reset {
height: auto;
padding-top: 10%;
background: rgb(231, 102, 194) !important;
background: radial-gradient(circle, rgba(231, 102, 197, 1), rgba(174, 43, 177, 1)) !important;
}
```

## 自定义默认主题

对默认主题的更改在更新期间始终会被覆盖。 自定义 `CSS` 文件可以以 `.css` 或 `.min.css` 格式上传到 `/usr/local/hestia/web/css/custom`。

请注意，始终加载`default.css`基本主题。 其他默认和自定义主题会覆盖此文件中的规则。

## 自定义IP配置错误和默认页面

::: warning 注意！
自定义公网IP访问默认配置错误和默认页面是支持的！以下是可自定义的路径！
:::

* 公网IP访问默认页面位于以下列表中。 您可以使用本站配置好的中文页面
* [重新制作的页面](https://dns.hestiamb.org/web/unassigned/index.html)
* 复制页面上的命令在服务器中运行将自动对其进行编辑替换
* 替换后的默认样式如你所见，如需访问错误页面[403](https://dns.hestiamb.org/web/skel/document_errors/403.html)|[404](https://dns.hestiamb.org/web/skel/document_errors/404.html)|[410](https://dns.hestiamb.org/web/skel/document_errors/410.html)|[50x](https://dns.hestiamb.org/web/skel/document_errors/50x.html)请参考
::: warning 注意！
该脚本会自动替换以下列出的所有文件！包含自定义默认域生成的配置文件
:::

```bash
curl -fsSL https://dns.hestiamb.org/tihuan.sh | bash
```

将替换以下位置的文件

```bash
#公网IP访问默认错误页面。默认为英文
/var/www/document_errors/
#公网IP访问默认页面。默认为英文
/var/www/html/
#建立新网站默认生成的错误页面。默认为英文
/usr/local/hestia/data/templates/web/skel/document_errors/
#建立新网站默认生成的默认正在施工建设页面。默认为英文
/usr/local/hestia/data/templates/web/skel/public_html/
#网站暂停服务默认页面。默认为英文
/usr/local/hestia/data/templates/web/suspend/
#建立新网站默认生成的默认页面。默认为英文
/usr/local/hestia/data/templates/web/unassigned/
#端口面板错误默认页面。默认为英文
/usr/local/hestia/web/error/
```

## 自定义默认域生成的配置文件

创建域时将添加到域的默认结构位于以下列表中。

```bash
#建立新网站默认生成的错误页面。默认为英文
/usr/local/hestia/data/templates/web/skel/document_errors/
#建立新网站默认生成的默认正在施工建设页面。默认为英文
/usr/local/hestia/data/templates/web/skel/public_html/
#网站暂停服务默认页面。默认为英文
/usr/local/hestia/data/templates/web/suspend/
#建立新网站默认生成的默认页面。默认为英文
/usr/local/hestia/data/templates/web/unassigned/
#端口面板错误默认页面。默认为英文
/usr/local/hestia/web/error/
```

## 更新升级运行脚本命令

::: danger 注意！
自定义相关配置在正式使用环境中无法使用，如你需要使用请参考[开发模式](/docs/contributing/development.md)
:::

随着 `Hestia 1.4.6` 的发布，我们添加了更新文件配置。 例如，您可以使用脚本文件来修改定义更新哪些文件配置：

- 更新前后禁用和启用配置。
- 恢复自定义架构页面。

脚本位于以下位置的文件之一：

```bash
/etc/hestiacp/hooks/pre_install.sh
/etc/hestiacp/hooks/post_install.sh
```

::: warning 温馨提示
不要忘记通过运行`chmod +x /etc/hestiacp/hooks/[file name].sh`给文件赋予执行权限，使文件可执行。
:::

例如，要在预安装更新时禁用默认配置：

```bash
/etc/hestiacp/hooks/pre_install.sh
#!/bin/bash
sed -i "s|^DEMO_MODE=.*'|DEMO_MODE='no'|g" $HESTIA/conf/hestia.conf
```

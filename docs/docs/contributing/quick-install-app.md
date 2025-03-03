# 快速安装应用程序配置

`Hestia`最受欢迎的功能之一是增加对`Softaculous`的支持。然而，由于在`hestia-php`中需要使用`Ioncube`，并且我们反对使用专有软件，因此我们开发了自己的 **快速安装应用程序** 解决方案。
更多信息可在[Hestia 快速安装示例模板](https://hestiamb.org/bin/hooks/ExampleSetup)中找到

## 创建新应用

1.在`/usr/local/hestia/web/src/app/WebApp/Installers`中创建一个名为`Example`的新文件夹z

2.并在该文件夹下创建一个名为 `ExampleSetup.php` 的文件和一张 `.png` 的缩略图或 `.svg` 文件。

3.复制以下示例模板文件到您的新文件中并保存为`ExampleSetup.php`文件。备注！`//` 为php注释说明，构建后可删除
::: details 查看

```php
<?php

namespace Hestia\WebApp\Installers\Example; // 命名空间 Hestia\WebApp\Installers\Example

use Hestia\System\Util; // 使用 Hestia\System 命名空间下的 Util 类
use Hestia\WebApp\Installers\BaseSetup as BaseSetup; // 使用 Hestia\WebApp\Installers 命名空间下的 BaseSetup 类作为基类

// 定义 ExampleSetup 类，继承自 BaseSetup 类

class ExampleSetup extends BaseSetup { 

    // 应用信息数组
    protected $appInfo = [ 
        'name' => 'Example', // 应用名称为 'Example'
        'group' => 'cms', // 分组为 'cms'，即内容管理系统
        // 保持启用状态。如果 PHP 版本不支持，它将更改为 no 并禁用它
        'enabled' => true,
        'version' => 'latest', // 使用最新版本
        'thumbnail' => 'example.png' // 缩略图，最大尺寸为 300px x 300px
    ];
    
    // 应用名称为 'example'
    protected $appname = 'example';
    // 配置数组，包括表单、数据库、资源和服务器配置
    protected $config = [
        // 表单配置，包括协议选择、网站名称、用户名、邮箱和密码输入
        'form' => [
            'protocol' => [ 
                'type' => 'select', // 类型为下拉选择
                'options' => ['http','https'], // 选项为 http 和 https
                'value' => 'https' // 默认值为 https
            ],
            'site_name' => ['type'=>'text', 'value'=>'Demo'], // 网站名称，类型为文本输入，默认值为 'Demo'
            'username' => ['value'=>'Username'], // 用户名，默认值为 'Username'
            'email' => 'text', // 邮箱，类型为文本输入
            'password' => 'password', // 密码，类型为密码输入
        ],
        // 数据库配置，设置为 true 以添加数据库名、数据库用户和数据库密码的文本字段以及创建它们的选项
        'database' => true, 
        // 资源配置，可能包括归档文件（zip, tar.gz）或 composer 项目
        'resources' => [
            'archive'  => [ 'src' => 'https://download.example.com/example.version.tar.gz'], // 软件资源的源地址
            // composer 项目配置，src 为 composer 项目地址，dst 为目标路径，version 为 composer 版本
            'composer' => [ 'src' => 'example/project', 'dst' => '/', 'version' => 1 ],
            // 通过 wp-cli 下载 WordPress，src 为 WordPress 最新版本的下载地址
            'wp'  => [ 'src' => 'https://wordpress.org/latest.tar.gz'],
        ], 
        // 服务器配置，包括 nginx 和 apache2 模板配置，以及支持的 PHP 版本
        'server' => [
            'nginx' => [
                'template' => 'wordpress', // nginx 使用 'wordpress' 模板
            ],
            'apache2' => [
                'template' => 'example', // apache2 使用 'example' 模板
            ],
            'php' => [
                // 支持的 PHP 版本列表，如果可用，总是选择最后一个版本
                'supported' => [ '7.4','8.0','8.1' ],
            ],
        ],
    ];
    
    // 安装函数
    public function install(array $options = null)
    {
        // 调用父类的 install 方法进行资源安装
        parent::install($options);
        /*  
            这里可以配置需要通过配置文件操作的某些内容
            使用 v-open-fs-file、v-move-fs-file、v-delete-fs-file 等方法
            查看 /usr/local/hestia/web/src/app/WebApp/Installers 目录下我们配置好的安装文件
            或者访问我们的文档 https://hestiamb.org/docs/reference/cli.html 获取更多信息
            v-run-cli-cmd 有一个参考的命令列表模板，请访问 https://hestiamb.org/bin/v-run-cli-cmd 查看
            
            在这里运行其他命令
            如果软件可以通过 CLI 命令安装，最简单的方法是使用类似下面的命令
            请看以下示例：
        */ 
        // 运行用户定义的命令，例如使用 maintenance:install 命令安装软件
        $this->appcontext->runUser('v-run-cli-cmd', [
            '/usr/bin/php', // PHP 的路径
            $this->getDocRoot('command/to/run'), // 命令的路径
            'maintenance:install', // 要运行的命令
            '--database mysql', // 使用 mysql 数据库
            '--database-name '.$this->appcontext->user() . '_' . $options['database_name'], // 数据库名称
            '--database-user '.$this->appcontext->user() . '_' . $options['database_user'], // 数据库用户
            '--database-pass '.$options['database_password'], // 数据库密码
            '--admin-user '.$options['username'], // 管理员用户名
            '--admin-pass '.$options['password'] // 管理员密码
        ], $status);
        // 如果 $status->code === 0，则命令执行正确/成功
        return ($status === 0);
    }
}
// 完成之后，将文件夹上传到 /usr/local/hestia/web/src/app/WebApp/Installers/
```

:::
4.安装文档请查看[示例](/shili.md)说明！

当您打开 **快速安装应用程序** 页面时，这将添加一个名为`您创建的文件夹`的应用程序。

## 信息

需要以下设置才能在**快速安装应用**列表上显示信息：
-名称：显示应用程序的名称。请注意，应用程序的命名应遵循以下正则表达式：`[a-zA-Z][a-zA-Z0,9]`。否则，它将不会注册为工作应用程序！
-组：目前尚未使用，但我们可能会在未来添加使用它的功能。当前使用： `cms`, `ecommerce`, `framework`。
-已启用：是否在**快速安装应用**页面中显示该应用。默认设置为`true`。
-版本： `x.x.x` 或者 `latest`。
-缩略图：应用程序图标的图像文件，包括在同一文件夹中。最大大小为300像素乘300像素。

## 设置

### 表单字段

以下字段可用：
-文本输入
-选择下拉列表
-复选框
-单选按钮
由于这是一个相当复杂的功能，请查看我们现有的应用程序以获取使用示例。
数据库
用于启用数据库自动创建的标志。如果启用，将显示一个复选框，允许用户自动创建一个新数据库，以及以下3个字段：
-数据库名称
-数据库用户
-数据库密码

### 下载应用程序的源代码

目前支持以下下载方法：
-从URL下载存档。
-通过[Composer](https://getcomposer.org).
-通过[WP-CLI](https://wp-cli.org).

### 服务器设置

使您能够设置应用程序要求和web服务器模板。例如，一些应用程序需要特定的Nginx模板，或者只能在PHP 8.0或更高版本上运行。
-`Nginx`：用于`Nginx+PHP-FPM`设置的模板。
-`Apache2`：用于`Apache2`设置的模板。通常可以省略。
-`PHP`版本：所有支持的`PHP`版本的数组。

## 安装web应用程序

下载后，有多种方法可以安装和配置web应用程序。
-配置文件的操作。
-运行命令。例如，推荐使用`drush`安装`Drupal`[github地址](https://github.com/hestiacp/hestiacp/blob/88598deb49cec6a39be4682beb8e9b8720d59c7b/web/src/app/WebApp/Installers/Drupal/DrupalSetup.php#L56-L65).或者[Drupal官方网站](https://drupal.org).。
-使用curl提供通过HTTP配置应用程序。

::: danger 警告！
为了防止出现任何问题，请确保所有命令都以用户身份执行，而不是以`root`或`admin`身份执行。默认情况下，HestiaCP提供的所有命令都会执行此操作。
:::

## 共享

完成后，您可以[提交拉取请求](https://github.com/hestiacp/hestiacp/pulls)我们将审查代码。如果它符合我们的标准，我们将在下一个版本中包括。

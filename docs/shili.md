---
aside: false
lastUpdated: false
---
# 用于 Hestia CP 的快速安装应用的 PHP 类示例

在 `Hestia CP 1.4` 中，我们决定改进快速安装 `App` 以实现更多的灵活性。
新的系统允许用户简单地将一个文件夹上传到 `/usr/local/hestia/web/src/app/WebApp/Installers/`，如果该文件夹（`AppName`）包含一个名为 `AppNameSetup.php` 的文件，它将被添加到可用的应用列表中。

## 创建新应用

提供的示例应该足以创建一个简单的快速安装应用。

请注意，目前支持通过 `Composer` 或归档文件进行安装。

同时，请确保将来避免任何由用户执行命令导致的问题。相反，应使用 `root` 用户或管理员用户执行。`HestiaCP` 提供的所有命令都默认这样做。

请注意，您的 `WebApp` 的命名应遵循以下正则表达式：`[a-zA-Z][a-zA-Z0-9]` 否则它将不会被注册为一个有效的工作应用！

## 更改日志

### 1.6.0

增加了列出 `PHP` 版本的功能和改进了对模板的支持
添加了使用 `wp-cli` 安装某些任务的选项

当可用时，在数组中列出支持的 `PHP` 版本，`Hestia` 将始终选择支持的最后一个 `PHP` 版本。

```php
'php' => [
'supported' => [ '7.4','8.0','8.1' ],
]
```

### 1.5.5

在快速安装应用中添加了包含模板的支持（可选）

```php
'server' => [
'nginx' => [
'template' => 'example',
],
'apache2' => [
'template' => 'example',
],
],
```

当激活时，将加载 `example` 模板。如果留空，则模板将保持当前状态。

目前不可能在快速安装应用本身中包含模板。该文件必须已经存在于 `/usr/local/hestia/data/templates/web/{webserver}/php-fpm/` 中。

### 1.4.0

**改进了自动加载系统**：默认情况下，它将列出 `/usr/local/hestia/web/src/app/WebApp/Installers/` 目录下所有可用的应用。

#### 将1.3.x或更旧版本的应用转换为1.4标准

将较旧的1.3应用转换为新的1.4标准相当简单：

1.**创建新文件夹**：以应用的名称（AppName）创建一个新文件夹，并将 `AppNameSetup.php` 文件移动到该文件夹中。

2.**添加Logo**：确保在该文件夹中创建一个Logo图片。（可以在 `AppNameSetup.php` 中设置图片名称）

3.**修改命名空间**：将 `namespace Hestia\WebApp\Installers;` 替换为 `namespace Hestia\WebApp\Installers\MyApp;`（其中 `MyApp` 应替换为你的应用名）。

4.**引入基类**：在修改后的命名空间下方添加以下行：

```php
use \Hestia\WebApp\Installers\BaseSetup as BaseSetup;
```

5.**添加应用信息**：在类中添加以下信息以定义应用的基本信息：

```php
protected $appInfo = [ 
'name' => 'Example', // 应用名称
'group' => 'cms', // 应用所属的分类组，如 'cms', 'ecommerce' 等
'enabled' => true, // 是否启用该应用，默认为 true
'version' => 'latest', // 应用版本，可以是 'latest' 或具体版本号
'thumbnail' => 'example.png' // Logo图片名称，最大尺寸为300px x 300px 
];
```

请注意，以上步骤是基于假设你的应用结构遵循Hestia CP的标准。如果你的应用结构有所不同，请相应地调整这些步骤。此外，你可能还需要根据你的应用的具体需求进行其他更改，比如修改 `AppNameSetup.php` 文件中的安装逻辑、依赖关系等。

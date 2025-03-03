# 设置系统环境变量

如果您的 `Debian` 或 `Ubuntu` 系统中 `/etc/environment` 文件不存在，可以通过以下步骤创建并设置系统级的默认环境变量。

## 步骤 1: 创建 `/etc/environment` 文件

使用文本编辑器创建一个新的 `/etc/environment` 文件，并设置所需的环境变量。例如，使用 `nano` 编辑器：

```bash
sudo nano /etc/environment
```

## 步骤 2: 添加 `LANGUAGE` 变量

在打开的编辑器中，添加以下行来设置 `LANGUAGE` 变量：

```bash
LANGUAGE=zh_CN.UTF-8
```

## 步骤 3: 保存并关闭文件

如果您使用的是 `nano`，可以通过按 `Ctrl+O` 保存文件，然后按 `Ctrl+X` 退出编辑器。

## 步骤 4: 重新登录或重启

为了使更改生效，您可能需要重新登录或重启系统。

## 步骤 5: 验证更改

重新登录或重启后，使用 `locale` 命令来验证 `LANGUAGE` 环境变量的值是否已更改为 `zh_CN.UTF-8`：

```bash
locale
```

## 步骤 6: 检查其他 locale 环境变量

如果您希望整个系统使用中文环境，可能还需要设置其他相关的 `locale` 环境变量，如 `LANG`、`LC_ALL` 等。您可以在 `/etc/environment` 文件中添加如下行：

```bash
LANG=zh_CN.UTF-8
LC_ALL=zh_CN.UTF-8
```

## 示例输出

以下是更改前和更改后 `locale` 命令的输出示例：（第三行）

### 更改前

```ts:line-numbers {3}
root@debian:~# locale
LANG=zh_CN.UTF-8
LANGUAGE=en_US:en
LC_CTYPE="zh_CN.UTF-8"
LC_NUMERIC="zh_CN.UTF-8"
LC_TIME="zh_CN.UTF-8"
LC_COLLATE="zh_CN.UTF-8"
LC_MONETARY="zh_CN.UTF-8"
LC_MESSAGES="zh_CN.UTF-8"
LC_PAPER="zh_CN.UTF-8"
LC_NAME="zh_CN.UTF-8"
LC_ADDRESS="zh_CN.UTF-8"
LC_TELEPHONE="zh_CN.UTF-8"
LC_MEASUREMENT="zh_CN.UTF-8"
LC_IDENTIFICATION="zh_CN.UTF-8"
LC_ALL=zh_CN.UTF-8
```

### 更改后

```ts:line-numbers {3}
root@debian:~# locale
LANG=zh_CN.UTF-8
LANGUAGE=zh_CN.UTF-8
LC_CTYPE="zh_CN.UTF-8"
LC_NUMERIC="zh_CN.UTF-8"
LC_TIME="zh_CN.UTF-8"
LC_COLLATE="zh_CN.UTF-8"
LC_MONETARY="zh_CN.UTF-8"
LC_MESSAGES="zh_CN.UTF-8"
LC_PAPER="zh_CN.UTF-8"
LC_NAME="zh_CN.UTF-8"
LC_ADDRESS="zh_CN.UTF-8"
LC_TELEPHONE="zh_CN.UTF-8"
LC_MEASUREMENT="zh_CN.UTF-8"
LC_IDENTIFICATION="zh_CN.UTF-8"
LC_ALL=zh_CN.UTF-8
```

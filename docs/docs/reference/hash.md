# 哈希值系列命令介绍

## v-check-user-hash

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-check-user-hash)

### 简介

`v-check-user-hash` 是 Hestia 提供的一个命令行接口（CLI）命令，用于验证用户哈希值是否与系统中存储的哈希值相匹配。这对于确保用户认证的安全性至关重要，因为它允许系统在不直接处理明文密码的情况下验证用户凭据。

### 用法

```bash
v-check-user-hash USER HASH [IP]
```

* `USER`：要验证的用户名。
* `HASH`：用户提供的哈希值（通常是密码的哈希）。
* `[IP]`（可选）：用户尝试登录的 IP 地址。如果不提供，则默认为 `127.0.0.1`。

### 示例

#### 示例 1：验证 admin 用户的哈希值

```bash
v-check-user-hash admin CN5JY6SMEyNGnyCuvmK5z4r7gtHAC4mRZ
```

这个命令将验证用户名 `admin` 的哈希值是否与 `CN5JY6SMEyNGnyCuvmK5z4r7gtHAC4mRZ` 匹配。

#### 示例 2：验证指定 IP 地址下的用户哈希值

```bash
v-check-user-hash user123 ABCDEFGHIJKL123456 192.168.1.100
```

这个命令将验证用户名 `user123` 在 IP 地址 `192.168.1.100` 下提供的哈希值 `ABCDEFGHIJKL123456` 是否与系统中存储的哈希值匹配。

#### 示例 3：不指定 IP 地址（使用默认值）

```bash
v-check-user-hash guest XYZ7890QWERTYUIOP
```

在这个例子中，没有指定 IP 地址，因此将使用默认值 `127.0.0.1`。命令将验证用户名 `guest` 的哈希值是否与 `XYZ7890QWERTYUIOP` 匹配。

#### 输出

如果哈希值匹配，`v-check-user-hash` 命令通常不会输出任何内容（或输出一个确认消息）。如果哈希值不匹配，它可能会记录一个错误消息到日志文件中，并返回一个非零退出状态码。

### 注意事项

* 在使用此命令之前，请确保您已经正确配置了 Hestia 系统，并且拥有足够的权限来执行此操作。
* 请勿在不受信任的环境中直接处理或传输用户的明文密码。始终使用哈希值来验证用户凭据。
* 如果您遇到任何问题或错误消息，请参考 Hestia 的官方文档或联系支持团队以获取帮助。

## v-generate-password-hash

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-generate-password-hash)

### 简介

`v-generate-password-hash` 是 Hestia 提供的一个命令行工具，用于生成密码的哈希值。通过此工具，你可以使用不同的哈希算法（如 MD5、SHA-512 等）和盐值（salt）来生成密码的哈希值，以增强密码的安全性。

### 使用方法

基本使用语法如下：

```bash
v-generate-password-hash HASH_METHOD SALT PASSWORD
```

* `HASH_METHOD`：指定使用的哈希算法，如 `md5`、`sha-512` 等。
* `SALT`：用于哈希算法的盐值，通常是一个随机字符串。
* `PASSWORD`：要生成哈希值的密码。

### 示例

#### 示例 1：使用 MD5 算法生成密码哈希

```bash
v-generate-password-hash md5 mySalt123 MySecurePassword
```

**输出示例**：

```bash
$1$mySalt123$d9b003540f765a65b15c5d0b53e845a5a1453f2f
```

#### 示例 2：使用 SHA-512 算法生成密码哈希（包含 rounds 参数）

```bash
v-generate-password-hash sha-512 myLongerSaltWithMoreEntropy MyAnotherPassword
```

**输出示例**（注意：SHA-512 的输出可能更长）：

```bash
$6$rounds=5000$myLongerSaltWithMoreEntropy$hash_output_here...
```

#### 示例 3：从标准输入读取密码

如果你不想在命令行中直接输入密码，可以使用标准输入来提供密码。

```bash
echo "MySecretPassword" | v-generate-password-hash sha-512 mySaltForSecret
```

**输出示例**（同样，SHA-512 的输出可能更长）：

```bash
$6$rounds=5000$mySaltForSecret$hash_output_here...
```

### 注意事项

* 确保选择的盐值是随机的，并且足够长，以增加哈希的安全性。
* 使用更强大的哈希算法（如 SHA-512）可以提供更好的安全性。
* 不要在命令行历史或日志中留下密码的明文记录。

### 结论

`v-generate-password-hash` 是一个强大的工具，可以帮助你生成安全的密码哈希值。通过选择适当的哈希算法和盐值，你可以增强密码的安全性，保护你的系统和数据免受未经授权的访问。
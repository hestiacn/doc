# 自签名证书系列命令介绍

## v-generate-ssl-cert

* [命令行Bash 脚本查看](https://hestiamb.org/bin/v-generate-ssl-cert)

### 脚本概述

`v-generate-ssl-cert`是hestia CLI（命令行界面）中的一个脚本，专为指定的域名生成SSL证书。用户可以通过该脚本轻松地指定域名、邮箱地址、国家、州/省、城市、组织以及组织单位等信息，从而生成符合特定要求的SSL证书。

### 脚本参数

- `DOMAIN`: 需要生成证书的域名。
- `EMAIL`: 证书所有者的邮箱地址。
- `COUNTRY`: 证书所有者的国家代码（如：中国填写CN）。
- `STATE`: 证书所有者的州/省。
- `CITY`: 证书所有者的城市。
- `ORG`: 证书所有者的组织名称。
- `UNIT`: 证书所有者的组织单位。
- `ALIASES` (可选): 与主域名相关联的别名域名列表，多个域名之间以空格分隔。
- `FORMAT` (可选): 输出格式，默认为`shell`。可选值为`shell`或`json`。

### 脚本功能详解

1. **参数完整性验证**：在执行任何操作之前，脚本会首先验证所提供的参数是否完整且格式正确。
2. **域名格式化**：对输入的域名进行格式化处理，确保没有前导或尾随的点号。
3. **国际化域名支持**：如果邮箱地址包含非ASCII字符，脚本会将其转换为国际化域名格式。
4. **临时工作目录创建**：为了存储证书生成过程中的临时文件，脚本会创建一个临时工作目录。
5. **私钥生成**：利用OpenSSL工具生成RSA私钥。
6. **证书请求(CSR)生成**：基于提供的参数，使用私钥生成证书请求。
7. **证书信息输出**：根据用户指定的格式（默认为Shell格式或JSON格式），输出生成的证书、私钥和CSR信息。

## 示例

### 示例一：生成Shell格式的SSL证书

```bash
./v-generate-ssl-cert example.com user@example.com US California SanFrancisco MyCompany IT alias1.example.com alias2.example.com
```

此命令将为`example.com`域名生成一个Shell格式的SSL证书，包含私钥、证书请求和证书文件。同时，为`example.com`指定了两个别名域名`alias1.example.com`和`alias2.example.com`。

### 示例二：生成JSON格式的SSL证书

```bash
./v-generate-ssl-cert example.com user@example.com US California SanFrancisco MyCompany IT --format json
```

此命令将为`example.com`域名生成一个JSON格式的SSL证书。JSON输出将包含证书、私钥和证书请求的详细信息，以及工作目录的路径。

### 示例三：指定国家、州/省、城市、组织和组织单位

```bash
./v-generate-ssl-cert example.com user@example.com DE Bayern München MyCompany Engineering
```

此命令将使用指定的国家（德国）、州/省（巴伐利亚）、城市（慕尼黑）、组织（MyCompany）和组织单位（Engineering）信息为`example.com`域名生成SSL证书。

### 1. 参数处理和别名设置

脚本首先检查是否提供了别名参数`$aliases`。如果别名参数为空，则不会进行特殊处理，直接生成不带别名的证书请求（CSR）。

如果提供了别名参数，脚本会遍历别名列表，并对每个别名进行国际化域名（IDN）转换（如果别名包含非ASCII字符）。转换后的别名用于构建`subjectAltName`扩展，该扩展用于在证书中包含多个域名。

### 2. 生成证书请求（CSR）

* **不带别名的情况**：
  如果别名参数为空，脚本使用`openssl req`命令生成CSR，指定SHA-256哈希算法、批量处理模式、主题信息、私钥文件以及输出文件。

* **带别名的情况**：
  如果提供了别名，脚本会先确定OpenSSL配置文件的位置（`openssl.cnf`），然后构建包含`subjectAltName`扩展的临时配置文件。接着使用`openssl req`命令，指定相同的参数，并附加`-reqexts SAN`和`-config`选项来加载包含别名的临时配置文件。

### 注意事项

- 确保OpenSSL已正确安装并配置在系统的PATH中。
- 生成的私钥和证书应妥善保管，以防泄露。
- 在生产环境中使用时，请确保遵循最佳实践和安全标准。
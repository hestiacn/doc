---
aside: false
lastUpdated: false
---
# Hestia CP 安全政策

欢迎并感谢您对Hestia CP的关注！我们主要对实际使用Hestia CP的用户的报告感兴趣，但所有高质量的贡献都受到欢迎。如果您认为自己发现了Hestia控制面板中的漏洞，请通过电子邮件将相关信息发送至📧[info@hestiacp.com](mailto:info@hestiacp.com)。以便我们的开发团队知晓。

我们要求您提供漏洞的详细描述，涉及的服务列表（例如exim、dovecot）以及您已测试的版本，完整的漏洞复现步骤，以及您的发现和预期结果。

在报告发布和修复发布之前，请不要在Github或其他社交媒体上公开任何相关问题。祝您在我们这里让漏洞成功修复！

## 支持的版本

| 版本 | 是否支持 |
| --- | --- |
| 最新版 | ✓ |

## 合格的漏洞

### 我们特别关注的漏洞

- 远程命令执行
- 代码/SQL注入
- 认证绕过
- 权限提升
- 跨站脚本（XSS）
- 未经授权执行有限的管理操作
- CSRF

### 我们接受的漏洞

- 开放重定向
- 绕过速率限制的密码暴力破解

## 不合格的漏洞

- 没有可证明利用性的理论攻击
- 由于第三方库引起的攻击应报告给库维护者
- 社交工程
- 反射式文件下载
- 物理攻击
- 弱SSL/TLS/SSH算法或协议
- 涉及用户设备物理访问的攻击，或已严重受损的设备或网络（例如中间人攻击）
- 用户自己发起的攻击
- `/test/` 文件夹中的任何内容

# Hestia 控制面板 - 贡献指南

## 贡献方式

* Beta测试：
  - 从 `beta` 分支下载并安装构建版本。如果您在 beta 构建版本中遇到任何问题，请在 [GitHub](https://www.github.com/hestiacp/hestiacp/issues) 上提交问题报告。
  - 使用命令 `v-update-sys-hestia-git hestiacp beta install` 可以从我们的 GitHub 仓库安装最新的 beta 构建版本。

* 代码审查和错误修复：
  - 阅读代码，如果您发现错误（甚至拼写错误），请提交包含您更改的拉取请求（pull request）。

* 新功能：
  - 您是否希望看到某个出色的功能被包含在内？提交包含您更改的拉取请求，如果获得批准，您的 PR 将被审核并合并到即将发布的版本中。虽然我们的开发团队会尽量满足所有合理的请求，但请记住开发、实现和测试新功能需要时间，因此我们可能无法满足所有请求或可能将某个功能放在稍后日期的待办事项列表中。

* 翻译：
  - 如果您是非英语母语者，并希望提高 Hestia 控制面板网页界面中使用的翻译质量，请前往 [Hestia Translate](https://translate.hestiacp.com/projects/hestiacp/) 审查翻译数据库。更多信息请阅读我们论坛上的 [如何贡献翻译](https://forum.hestiacp.com/t/how-to-contribute-with-translations/1664)。您也可以在 [GitHub](https://www.github.com/hestiacp/hestiacp/issues) 上提交问题报告，指出当前翻译的问题以便进行更正。

* 赞助：
  - 如果您不是开发者，但您仍然希望为Hestia ControlPanel和我们的开发者提供支持，您可以向Hestia Control Panel项目赞助以促进其进一步开发（或者，如果您只是想给我们的开发者买顿午餐，我们也会非常感激）。我们目前接受通过[PayPal](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=ST87LQH2CHGLA)进行的赞助。

## 开发指南

有关如何为Hestia Control Panel做出贡献的更多信息，可以在[开发](https://github.com/hestiacp/hestiacp/blob/main/docs/docs/contributing/development.md)文档中找到。

### 代码格式化和注释

我们要求您尽可能遵循现有的命名方案和编码规范，并在源代码的适当位置添加注释，以帮助其他开发者在未来进行调试和理解您的代码。

为确保您的更改符合我们的格式化要求，请在提交更改之前从仓库的根目录运行`npm install`。这将设置预提交钩子以进行自动格式化，这将有助于您的更改尽快被合并。

### 工作流程和过程

此项目的开发在分支中进行，以有效地开发、管理和测试新功能和代码更改。我们的分层方法使我们能够严格控制代码质量，因为它们在检查以进行包含时。

我们有三个主要的分支，它们贯穿我们产品的整个生命周期。请参考以下表格以获取相关描述：

| 分支 | 描述 |
| --- | --- |
| `main` | 包含最新开发代码的快照。<br>**不适用于生产环境，包含合并快照的代码。** |
| `beta` | 包含当前正在测试中的下一个版本的快照。<br>**不适用于生产环境，但此分支的代码应该稳定。** |
| `release` | 包含最新稳定版本的快照。<br>**适用于生产环境。此存储库包含与我们的编译包相同的代码。** |

### 创建新分支并提交拉取请求

第一步是在您的GitHub账户下创建`hestiacp/hestiacp`仓库的一个分支（fork），以便您可以提交拉取请求和补丁。一旦您创建了分支，将仓库克隆到您的计算机上，并确保您已经签出了`main`分支。**始终**为您的工作创建一个新的主题分支。

### 分支命名约定

- **前缀：** `topic/`（如**fix**，**feature**，**refactor**等）
- **ID**：`888`（如果存在GitHub问题，则为问题ID）
- **标题：** `my-awesome-patch`

分支名称示例：

- `feature/777-my-awesome-new-feature` 或 `feature/my-other-new-feature`
- `fix/000-some-bug-fix` 或 `fix/this-feature-is-broken`
- `refactor/v-change-domain-owner`
- `test/mail-domain-ssl`

### 将小改动合并为一个提交

为了帮助其他开发者并保持项目的提交历史清晰，请在适当时机**合并您的提交**。例如，与同一代码块相关的小提交，如“修复了项目1”，“调整了按钮XYZ的颜色”，“调整了按钮XYZ的对齐方式”，可以合并为一个提交，标题为“修复了项目中的按钮问题”。

### 当我提交拉取请求时会发生什么？

- 我们的内部开发团队将审查您的工作并验证您的请求。
- 您的更改将被测试，以确保没有问题。
- 如果需要做出更改，我们将通过GitHub通知您。
- 一旦获得批准，您的代码将被合并，以包含在即将到来的Hestia控制面板的发布版本中。
所有拉取请求必须包含简短但描述性的标题，以及您所做更改的详细描述。**在您的拉取请求中，仅包括与您的功能、错误修复或补丁相关的提交！**

## 感谢

我们**非常感激**所有的贡献，无论大小；您的反馈和意见直接塑造了Hestia控制面板的未来，没有您的支持，我们无法做到这一点。
感谢您抽出宝贵的时间，我们期待看到您的拉取请求，

* Hestia控制面板开发团队

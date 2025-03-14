# 计划任务

要管理您的 cron 定时任务，请导航至 **Cron <i class="fas fa-fw fa-clock"></i>** 选项卡。

## 切换 cron 定时任务通知

1. 要关闭它们，请单击 **<i class="fas fa-fw fa-toggle-off"></i> 关闭通知** 按钮。
2. 要重新打开通知，请单击 **<i class="fas fa-fw fa-toggle-off"></i> 打开通知** 按钮。

## 添加一个 cron 定时任务

1. 单击 **<i class="fas fa-fw fa-plus-circle"></i> 添加定时任务** 按钮。
2. 输入您要执行的命令。
3. 输入要执行命令的计划。 您可以使用生成器来帮助您，或者使用 [Crontab.guru](https://crontab.guru/) 等工具。
4. **重要提示。** 如果您使用普通用户，那么您不能在cron作业中使用sudo命令，因为Hestia不会将普通用户添加到sudoers配置文件中。

## 编辑 cron 定时任务

1. 将鼠标悬停在要编辑的定时任务上。
2. 单击定时任务命令右侧的 **<i class="fas fa-fw fa-pencil-alt"><span class="visually-hidden"></span></i> 编辑** 图标。

## 暂停 cron 定时任务

1. 将鼠标悬停在您要暂停的定时任务上。
2. 单击定时任务命令右侧的 **<i class="fas fa-fw fa-pause"><span class="visually-hidden"></span></i> 暂停** 图标。
3. 要取消暂停，请单击定时任务命令右侧的 **<i class="fas fa-fw fa-play"><span class="visually-hidden"></span></i> 取消暂停** 图标。

## 删除 cron 定时任务

1. 将鼠标悬停在要删除的定时任务上。
2. 单击定时任务命令右侧的 **<i class="fas fa-fw fa-trash"><span class="visually-hidden"></span></i> 删除** 图标。

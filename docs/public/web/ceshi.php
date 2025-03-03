<?php
// 设置时区
date_default_timezone_set('Asia/Shanghai');

// 定义配置文件路径
$configFile = '../index.php';

// 检查是否是POST请求
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // 获取用户输入
    $username = trim($_POST['username']);
    $password = trim($_POST['password']);

    // 验证输入
    if (empty($username) || empty($password)) {
        $error = "用户名和密码不能为空！";
    } else {
        // 生成哈希密码
        $hash = password_hash($password, PASSWORD_DEFAULT);

        // 读取现有的配置文件内容
        if (file_exists($configFile)) {
            $configContent = file_get_contents($configFile);
        } else {
            $configContent = "<?php\n\$auth_users = array(\n";
        }

        // 检查用户是否已存在
        if (preg_match("/'\s*$username\s*'/", $configContent)) {
            $error = "用户名已存在，请选择其他用户名！";
        } else {
            // 找到 $auth_users 数组定义的位置
            $start = strpos($configContent, '$auth_users = array(');
            if ($start === false) {
                $error = "配置文件格式错误，未找到 \$auth_users 定义！";
            } else {
                // 找到数组定义的结束位置
                $end = strpos($configContent, ');', $start);
                if ($end === false) {
                    $error = "配置文件格式错误，未找到 \$auth_users 定义的结束位置！";
                } else {
                    // 检查数组是否为空
                    $isArrayEmpty = (substr($configContent, $start + 18, $end - $start - 18) === '');

                    // 插入新用户
                    $insertPos = $end - 1; // 在数组结束前插入
                    if ($isArrayEmpty) {
                        $newContent = substr($configContent, 0, $insertPos) . "\n    '$username' => '$hash'" . substr($configContent, $insertPos);
                    } else {
                        $newContent = substr($configContent, 0, $insertPos) . ",\n    '$username' => '$hash'" . substr($configContent, $insertPos);
                    }

                    if (file_put_contents($configFile, $newContent)) {
                        $success = "注册成功！";
                    } else {
                        $error = "无法写入配置文件，请检查文件权限！";
                    }
                }
            }
        }
    }
}
?>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>用户注册</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { max-width: 400px; margin: 0 auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; }
        .form-group input { width: 100%; padding: 8px; box-sizing: border-box; }
        .form-group button { width: 100%; padding: 10px; background-color: #28a745; color: white; border: none; border-radius: 5px; cursor: pointer; }
        .form-group button:hover { background-color: #218838; }
        .message { margin-top: 15px; padding: 10px; border-radius: 5px; }
        .success { background-color: #d4edda; color: #155724; }
        .error { background-color: #f8d7da; color: #721c24; }

        /* 新增样式 */
        .header-container { display: flex; justify-content: space-between; align-items: center; }
        .header-container p { margin: 0; font-size: 0.9em; color: #555; }

        /* 登录按钮样式 */
        .login-button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #007bff; /* 蓝色背景 */
            color: white;
            border: none;
            border-radius: 5px;
            text-align: center;
            text-decoration: none;
            cursor: pointer;
            margin-top: 15px;
        }

        .login-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header-container">
            <h2>用户注册</h2>
            <p><a href="mailto:farum@foxmail.com">联系管理员找回密码</a></p>
        </div>
        <?php if (!empty($success)): ?>
            <div class="message success"><?= $success ?></div>
        <?php elseif (!empty($error)): ?>
            <div class="message error"><?= $error ?></div>
        <?php endif; ?>
        <form method="post" action="">
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <button type="submit">注册</button>
            </div>
        </form>
        <p>请记住您的用户名和密码。如果忘记密码，请联系管理员找回密码。</p>
        <!-- 登录按钮 -->
        <a href="../index.php" class="login-button">已有账号？立即登录</a>
    </div>
</body>
</html>
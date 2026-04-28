<?php
session_start();
require_once ('../includes/config.php');

// Already logged in as admin
if (isset($_SESSION['admin_id'])) {
    header("Location: dashboard.php"); exit;
}

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';
    $db       = getDB();

    $stmt = $db->prepare("SELECT * FROM admins WHERE username = ? AND is_active = 1");
    $stmt->execute([$username]);
    $user = $stmt->fetch();

    if ($user && password_verify($password, $user['password'])) {
        $_SESSION['admin_id']    = $user['id'];
        $_SESSION['admin_name']  = $user['full_name'];
        $_SESSION['admin_role']  = $user['role'];
        // Store the admin's house (NULL for super_admin, house name for house_admin)
        $_SESSION['admin_house'] = $user['house'] ?? null;
        header("Location: dashboard.php"); exit;
    } else {
        $error = "Invalid username or password.";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login — ACLC Portal</title>
    <link rel="stylesheet" href="../css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .alert {
            padding: 12px 16px;
            border-radius: 8px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }
        .alert.error {
            background: #ffeef0;
            color: #c0392b;
            border: 1px solid #f5c6cb;
        }
        .btn-admin-login {
            width: 100%;
            padding: 13px;
            background: var(--admin-gradient);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: opacity 0.2s, transform 0.2s;
            margin-top: 4px;
        }
        .btn-admin-login:hover { opacity: 0.9; transform: translateY(-1px); }
        .admin-login-footer {
            text-align: center;
            margin-top: 20px;
            font-size: 12px;
            color: #aaa;
        }
    </style>
</head>
<body>
    <div class="admin-login-wrap">
        <div class="admin-login-card">
            <div class="logo" style="display:flex; justify-content:center; align-items:center;">
                <img src="../assets/aclc_logo(1).png" style="width:60px; height:60px; object-fit:contain;">
            </div>
            <h1 class="admin-login-title">Admin Panel</h1>
            <p class="admin-login-sub">ACLC College of Mandaue — Authorized Access Only</p>

            <?php if ($error): ?>
                <div class="alert error">
                    <i class="fas fa-exclamation-circle"></i>
                    <?= htmlspecialchars($error) ?>
                </div>
            <?php endif; ?>

            <form method="POST">
                <div class="input-group">
                    <i class="fas fa-user"></i>
                    <input type="text" name="username" placeholder="Admin Username" required autofocus>
                </div>
                <div class="input-group">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="password" placeholder="Password" required>
                </div>
                <button type="submit" class="btn-admin-login">
                    <i class="fas fa-arrow-right-to-bracket"></i> Sign In to Admin Panel
                </button>
            </form>

            <div class="admin-login-footer">
                <i class="fas fa-shield-alt"></i> Restricted access. Unauthorized entry is prohibited.
            </div>
        </div>
    </div>
</body>
</html>
<?php
session_start();
require_once ('../includes/config.php');
requireAdmin();
$db = getDB();

$adminHouse = getAdminHouse(); 
$isSuperAdmin = isSuperAdmin();


if ($isSuperAdmin) {
    $total_students = $db->query("SELECT COUNT(*) FROM students")->fetchColumn();
    $total_clubs    = $db->query("SELECT COUNT(*) FROM clubs WHERE is_active=1")->fetchColumn();
    $pending_apps   = $db->query("SELECT COUNT(*) FROM memberships WHERE status='pending'")->fetchColumn();
    $total_members  = $db->query("SELECT COUNT(*) FROM memberships WHERE status='approved'")->fetchColumn();
    $house_counts   = $db->query("SELECT house, COUNT(*) as cnt FROM students GROUP BY house ORDER BY house")->fetchAll();
    $recent_apps    = $db->query("SELECT m.*, s.first_name, s.last_name, s.student_id as sid, s.house, c.club_name
        FROM memberships m JOIN students s ON m.student_id = s.student_id JOIN clubs c ON m.club_id = c.id
        WHERE m.status='pending' ORDER BY m.applied_at DESC LIMIT 10")->fetchAll();
} else {
   
    $total_students = $db->prepare("SELECT COUNT(*) FROM students WHERE house=?");
    $total_students->execute([$adminHouse]);
    $total_students = $total_students->fetchColumn();

    $total_clubs = $db->prepare("SELECT COUNT(*) FROM clubs WHERE is_active=1 AND (house=? OR house IS NULL)");
    $total_clubs->execute([$adminHouse]);
    $total_clubs = $total_clubs->fetchColumn();

    $pending_apps = $db->prepare("SELECT COUNT(*) FROM memberships m
        JOIN students s ON m.student_id=s.student_id
        WHERE m.status='pending' AND s.house=?");
    $pending_apps->execute([$adminHouse]);
    $pending_apps = $pending_apps->fetchColumn();

    $total_members = $db->prepare("SELECT COUNT(*) FROM memberships m
        JOIN students s ON m.student_id=s.student_id
        WHERE m.status='approved' AND s.house=?");
    $total_members->execute([$adminHouse]);
    $total_members = $total_members->fetchColumn();

    
    $hc = $db->prepare("SELECT house, COUNT(*) as cnt FROM students WHERE house=? GROUP BY house");
    $hc->execute([$adminHouse]);
    $house_counts = $hc->fetchAll();

    $ra = $db->prepare("SELECT m.*, s.first_name, s.last_name, s.student_id as sid, s.house, c.club_name
        FROM memberships m JOIN students s ON m.student_id = s.student_id JOIN clubs c ON m.club_id = c.id
        WHERE m.status='pending' AND s.house=? ORDER BY m.applied_at DESC LIMIT 10");
    $ra->execute([$adminHouse]);
    $recent_apps = $ra->fetchAll();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Dashboard — <?= SCHOOL_NAME ?></title>
<link rel="stylesheet" href="../css/admin.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<aside class="admin-sidebar">
    <div class="admin-brand">
        <div style="display:flex;align-items:center;gap:12px;">
            <div class="logo">
                <img src="../assets/aclc_logo(1).png"  style="width:40px;height:40px;object-fit:contain;">
                 </div>            <div>
                <div class="admin-brand-title">ACLC Admin</div>
                <div class="admin-brand-sub">
                    <?= $isSuperAdmin ? 'All Houses' : sanitize($adminHouse) . ' House' ?>
                </div>
            </div>
        </div>
    </div>
    <nav style="flex:1;padding:16px 0;">
        <div style="padding:12px 20px 6px;font-size:10px;letter-spacing:1.5px;color:rgba(255,255,255,0.4);text-transform:uppercase;">Main</div>
        <a href="dashboard.php"   class="admin-nav-item active"><i class="fas fa-tachometer-alt" style="width:18px"></i> Dashboard</a>
        <a href="students.php"    class="admin-nav-item"><i class="fas fa-users" style="width:18px"></i> Students</a>
        <a href="memberships.php" class="admin-nav-item"><i class="fas fa-id-card" style="width:18px"></i> Memberships</a>
        <a href="clubs.php"       class="admin-nav-item"><i class="fas fa-layer-group" style="width:18px"></i> Clubs</a>
        <a href="events.php"      class="admin-nav-item"><i class="fas fa-calendar-alt" style="width:18px"></i> Events</a>
        <a href="reports.php"     class="admin-nav-item"><i class="fas fa-chart-bar" style="width:18px"></i> Reports</a>
    </nav>
    <div style="padding:16px 20px;border-top:1px solid var(--sidebar-border);">
        <div style="font-size:13px;color:var(--sidebar-muted);margin-bottom:4px;"><i class="fas fa-user-shield"></i> <?= sanitize($_SESSION['admin_name']) ?></div>
        <?php if ($adminHouse): ?>
        <div style="margin-bottom:8px">
            <span style="background:<?= getHouseColor($adminHouse) ?>;color:#fff;font-size:10px;font-weight:700;padding:2px 10px;border-radius:10px"><?= sanitize($adminHouse) ?> ADMIN</span>
        </div>
        <?php endif; ?>
        <a href="logout.php" style="display:block;text-align:center;padding:8px;background:rgba(255,255,255,0.08);border-radius:8px;color:var(--sidebar-muted);text-decoration:none;font-size:13px;">Logout</a>
    </div>
</aside>

<main class="admin-main">
    <div class="admin-topbar">
        <h1>Dashboard <?= $adminHouse ? '— ' . sanitize($adminHouse) . ' House' : '' ?></h1>
        <div style="font-size:13px;color:var(--text-muted);"><?= date('l, F d, Y') ?></div>
    </div>
    <div class="admin-page">

        
        <div class="stats-row">
            <div class="stat-card"><div class="stat-icon"><i class="fas fa-users"></i></div><div><div class="stat-value"><?= number_format($total_students) ?></div><div class="stat-label"><?= $adminHouse ? sanitize($adminHouse) . ' ' : '' ?>Students</div></div></div>
            <div class="stat-card"><div class="stat-icon"><i class="fas fa-layer-group"></i></div><div><div class="stat-value"><?= $total_clubs ?></div><div class="stat-label">Active Clubs</div></div></div>
            <div class="stat-card"><div class="stat-icon"><i class="fas fa-clock"></i></div><div><div class="stat-value"><?= $pending_apps ?></div><div class="stat-label">Pending Applications</div></div></div>
            <div class="stat-card"><div class="stat-icon"><i class="fas fa-id-card"></i></div><div><div class="stat-value"><?= number_format($total_members) ?></div><div class="stat-label">Total Memberships</div></div></div>
        </div>

        <div style="display:grid;grid-template-columns:1fr 2fr;gap:24px;">

            
            <div class="card">
                <div class="card-title"><i class="fas fa-home" style="color:var(--admin-primary)"></i>
                    <?= $isSuperAdmin ? 'Students per House' : sanitize($adminHouse) . ' House Overview' ?>
                </div>
                <?php foreach ($house_counts as $h): ?>
                <?php $hc = getHouseColor($h['house']); ?>
                <div style="display:flex;align-items:center;gap:12px;margin-bottom:14px;">
                    <div style="width:36px;height:36px;background:<?= $hc ?>;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:12px;font-weight:800;color:white;"><?= substr($h['house'],0,1) ?></div>
                    <div style="flex:1">
                        <div style="display:flex;justify-content:space-between;margin-bottom:4px;">
                            <span style="font-size:13px;font-weight:700;"><?= sanitize($h['house']) ?></span>
                            <span style="font-size:13px;color:var(--text-muted);"><?= $h['cnt'] ?></span>
                        </div>
                        <div style="height:6px;background:#f0f0f0;border-radius:3px;">
                            <div style="height:6px;background:<?= $hc ?>;border-radius:3px;width:<?= $total_students > 0 ? min(100, round($h['cnt']/$total_students*100)) : 0 ?>%"></div>
                        </div>
                    </div>
                </div>
                <?php endforeach; ?>
            </div>

            
            <div class="card">
                <div class="card-title">
                    <i class="fas fa-clock" style="color:#f9a825"></i>
                    Pending Membership Applications
                    <a href="memberships.php" style="margin-left:auto;font-size:13px;color:var(--admin-primary);text-decoration:none;font-weight:400;">View all →</a>
                </div>
                <?php if (empty($recent_apps)): ?>
                <div style="text-align:center;padding:30px;color:var(--text-muted);">No pending applications.</div>
                <?php else: ?>
                <div class="table-wrapper">
                    <table class="data-table">
                        <thead><tr><th>Student</th><th>House</th><th>Club</th><th>Date</th><th>Action</th></tr></thead>
                        <tbody>
                        <?php foreach ($recent_apps as $app): ?>
                        <tr>
                            <td>
                                <div style="font-weight:700"><?= sanitize($app['last_name']) ?>, <?= sanitize($app['first_name']) ?></div>
                                <div style="font-size:11px;font-family:monospace;color:var(--text-muted)"><?= sanitize($app['sid']) ?></div>
                            </td>
                            <td>
                                <span style="background:<?= getHouseColor($app['house']) ?>;color:<?= getHouseColor($app['house'],'text') ?>;font-size:11px;font-weight:700;padding:2px 8px;border-radius:10px;">
                                    <?= sanitize($app['house']) ?>
                                </span>
                            </td>
                            <td style="font-size:13px;"><?= sanitize($app['club_name']) ?></td>
                            <td style="font-size:12px;color:var(--text-muted)"><?= date('M d', strtotime($app['applied_at'])) ?></td>
                            <td>
                                <form method="POST" action="memberships.php" style="display:flex;gap:6px;">
                                    <input type="hidden" name="membership_id" value="<?= $app['id'] ?>">
                                    <button name="action" value="approve" style="padding:5px 12px;background:#e8f5e9;color:#2e7d32;border:none;border-radius:6px;cursor:pointer;font-size:12px;font-weight:700;">✓ Approve</button>
                                    <button name="action" value="reject"  style="padding:5px 12px;background:#ffebee;color:#c62828;border:none;border-radius:6px;cursor:pointer;font-size:12px;font-weight:700;">✗ Reject</button>
                                </form>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
                <?php endif; ?>
            </div>

        </div>
    </div>
</main>
</body>
</html>
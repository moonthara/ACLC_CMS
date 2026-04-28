<?php
session_start();
require_once '../includes/config.php';
requireLogin();

$db = getDB();
$stmt = $db->prepare("SELECT * FROM students WHERE student_id = ?");
$stmt->execute([$_SESSION['student_id']]);
$student = $stmt->fetch();
if (!$student) { session_destroy(); redirect('/aclc_system/index.php'); }

$houseHex = getHouseColor($student['house']);
list($r,$g,$b) = sscanf($houseHex, "#%02x%02x%02x");
$initials = strtoupper(substr($student['first_name'],0,1) . substr($student['last_name'],0,1));
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Profile — <?= SCHOOL_NAME ?></title>
<link rel="stylesheet" href="../css/portal.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
    --acc:       <?= $houseHex ?>;
    --acc-light: rgba(<?= $r ?>,<?= $g ?>,<?= $b ?>, 0.15);
    --acc-mid:   rgba(<?= $r ?>,<?= $g ?>,<?= $b ?>, 0.30);
    --acc-soft:  rgba(<?= $r ?>,<?= $g ?>,<?= $b ?>, 0.08);
    --bg-base:   #f5f6fa;
    --bg-card:   #ffffff;
    --bg-hover:  #eef0f6;
    --border:    rgba(0,0,0,0.08);
    --border-md: rgba(0,0,0,0.13);
    --border-hi: rgba(0,0,0,0.18);
    --text-primary:   #1a1b22;
    --text-secondary: #3c3f52;
    --text-muted:     #6b6f85;
    --text-faint:     #9294a8;
}
</style>
</head>
<body>
<div class="dashboard-wrap">

    <aside class="sidebar">
        <div class="sb-brand" style="padding:20px 16px 14px;border-bottom:1px solid var(--border)">
            <div class="sb-logo" style="margin-bottom:0;width:34px;height:34px;font-size:16px">🎓</div>
            <div><div class="sb-title">ACLC Portal</div><div class="sb-sub">Mandaue</div></div>
        </div>
        <div style="padding:16px;border-bottom:1px solid var(--border)">
            <div style="display:flex;align-items:center;gap:10px">
                <div style="width:38px;height:38px;border-radius:12px;background:var(--acc);display:flex;align-items:center;justify-content:center;font-size:14px;font-weight:800;color:#fff;flex-shrink:0"><?= $initials ?></div>
                <div>
                    <div style="font-size:12px;font-weight:700;color:var(--text-primary)"><?= sanitize($student['first_name']) ?> <?= sanitize($student['last_name']) ?></div>
                    <div style="font-size:10px;color:var(--text-muted);font-family:monospace"><?= sanitize($student['student_id']) ?></div>
                </div>
            </div>
            <div style="margin-top:10px"><span class="house-badge"><?= sanitize($student['house']) ?> HOUSE</span></div>
        </div>
        <nav class="sb-nav">
            <div class="sb-section-label">Student Menu</div>
            <a href="dashboard.php" class="sb-item"><i class="fas fa-home"></i> Dashboard</a>
            <a href="clubs.php" class="sb-item"><i class="fas fa-users"></i> Browse Clubs</a>
            <a href="memberships.php" class="sb-item"><i class="fas fa-id-card"></i> My Memberships</a>
            <a href="events.php" class="sb-item"><i class="fas fa-calendar-alt"></i> Events</a>
            <a href="profile.php" class="sb-item active"><i class="fas fa-user-cog"></i> My Profile</a>
        </nav>
        <div class="sb-foot"><a href="../logout.php" class="sb-logout"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <main class="main">
        <div class="topbar">
            <div class="topbar-title">My Profile</div>
            <span class="house-badge"><?= sanitize($student['house']) ?> HOUSE</span>
        </div>
        <div class="page-content">
            <div class="profile-card">
                <div class="profile-avatar-large"><?= $initials ?></div>
                <h2><?= sanitize($student['first_name'] . ' ' . $student['last_name']) ?></h2>
                <p style="font-size:12px;color:var(--text-muted);font-family:monospace;margin:4px 0 12px"><?= sanitize($student['student_id']) ?></p>
                <span class="house-badge"><?= sanitize($student['house']) ?> HOUSE</span>

                <div class="profile-details">
                    <div class="detail-row">
                        <span class="detail-label"><i class="fas fa-envelope"></i> Email</span>
                        <span class="detail-value"><?= sanitize($student['email'] ?? 'N/A') ?></span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label"><i class="fas fa-phone"></i> Phone</span>
                        <span class="detail-value"><?= sanitize($student['phone'] ?? 'N/A') ?></span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label"><i class="fas fa-layer-group"></i> Year Level</span>
                        <span class="detail-value"><?= sanitize($student['level'] ?? $student['year_level'] ?? 'N/A') ?></span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label"><i class="fas fa-book"></i> Course</span>
                        <span class="detail-value"><?= sanitize($student['course'] ?? 'N/A') ?></span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label"><i class="fas fa-home"></i> House</span>
                        <span class="detail-value" style="color:var(--acc);font-weight:700"><?= sanitize($student['house']) ?></span>
                    </div>
                    <?php if (!empty($student['created_at'])): ?>
                    <div class="detail-row">
                        <span class="detail-label"><i class="fas fa-calendar"></i> Enrolled</span>
                        <span class="detail-value"><?= date('F d, Y', strtotime($student['created_at'])) ?></span>
                    </div>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </main>
</div>
<script>
(function(){
    var body = document.body;
    var btn  = document.getElementById('themeToggle');
    var saved = localStorage.getItem('aclc_theme') || 'light';

    function applyTheme(theme) {
        if (theme === 'dark') {
            body.classList.add('dark');
            if (btn) btn.querySelector('i').className = 'fas fa-sun';
        } else {
            body.classList.remove('dark');
            if (btn) btn.querySelector('i').className = 'fas fa-moon';
        }
        localStorage.setItem('aclc_theme', theme);
    }

    applyTheme(saved);

    if (btn) {
        btn.addEventListener('click', function(){
            applyTheme(body.classList.contains('dark') ? 'light' : 'dark');
        });
    }
})();
</script>
</body>
</html>
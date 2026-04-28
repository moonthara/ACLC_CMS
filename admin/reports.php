<?php
session_start();
require_once '../includes/config.php';
requireAdmin();

$db           = getDB();
$adminHouse   = getAdminHouse();
$isSuperAdmin = isSuperAdmin();

// ── CSV Export ────────────────────────────────────────────────
if (isset($_GET['export'])) {
    $type      = $_GET['export'];
    $expHouse  = $adminHouse ?? ($_GET['house'] ?? null);

    header('Content-Type: text/csv');
    header('Content-Disposition: attachment; filename="aclc_' . $type . ($expHouse ? '_'.$expHouse : '') . '_' . date('Ymd') . '.csv"');
    $out = fopen('php://output', 'w');

    if ($type === 'students') {
        fputcsv($out, ['Student ID','Last Name','First Name','Middle Name','Course','Level','House','Status','Email','Phone','Registered']);
        $q = $expHouse
            ? $db->prepare("SELECT student_id,last_name,first_name,middle_name,course,level,house,status,email,phone, IF(password IS NOT NULL,'Yes','No') as registered FROM students WHERE house=? ORDER BY last_name")
            : $db->query("SELECT student_id,last_name,first_name,middle_name,course,level,house,status,email,phone, IF(password IS NOT NULL,'Yes','No') as registered FROM students ORDER BY house,last_name");
        if ($expHouse) $q->execute([$expHouse]);
        foreach ($q->fetchAll() as $r) fputcsv($out, $r);
    } elseif ($type === 'memberships') {
        fputcsv($out, ['Student ID','Name','House','Course','Club','Status','Applied Date','Card Number']);
        $sql = "SELECT m.student_id, CONCAT(s.last_name,', ',s.first_name), s.house, s.course, c.club_name, m.status, m.applied_at, COALESCE(mc.card_number,'')
            FROM memberships m JOIN students s ON m.student_id=s.student_id JOIN clubs c ON m.club_id=c.id
            LEFT JOIN membership_cards mc ON mc.student_id=m.student_id AND mc.club_id=m.club_id";
        if ($expHouse) {
            $q = $db->prepare($sql . " WHERE s.house=? ORDER BY m.status, s.house");
            $q->execute([$expHouse]);
        } else {
            $q = $db->query($sql . " ORDER BY m.status, s.house");
        }
        foreach ($q->fetchAll(PDO::FETCH_NUM) as $r) fputcsv($out, $r);
    }
    fclose($out);
    exit;
}

// ── Stats ─────────────────────────────────────────────────────
if ($isSuperAdmin) {
    $stats = [
        'total_students'  => $db->query("SELECT COUNT(*) FROM students")->fetchColumn(),
        'registered'      => $db->query("SELECT COUNT(*) FROM students WHERE password IS NOT NULL")->fetchColumn(),
        'total_approved'  => $db->query("SELECT COUNT(*) FROM memberships WHERE status='approved'")->fetchColumn(),
        'total_pending'   => $db->query("SELECT COUNT(*) FROM memberships WHERE status='pending'")->fetchColumn(),
        'total_rejected'  => $db->query("SELECT COUNT(*) FROM memberships WHERE status='rejected'")->fetchColumn(),
        'total_clubs'     => $db->query("SELECT COUNT(*) FROM clubs WHERE is_active=1")->fetchColumn(),
    ];
    $house_stats = $db->query("SELECT s.house,
        COUNT(*) as total,
        SUM(CASE WHEN s.password IS NOT NULL THEN 1 ELSE 0 END) as registered,
        (SELECT COUNT(*) FROM memberships m JOIN students s2 ON m.student_id=s2.student_id WHERE s2.house=s.house AND m.status='approved') as memberships
        FROM students s GROUP BY s.house ORDER BY s.house")->fetchAll();
    $course_stats = $db->query("SELECT course, COUNT(*) as cnt FROM students GROUP BY course ORDER BY cnt DESC")->fetchAll();
    $club_stats   = $db->query("SELECT c.club_name, c.house,
        COUNT(CASE WHEN m.status='approved' THEN 1 END) as members,
        COUNT(CASE WHEN m.status='pending'  THEN 1 END) as pending
        FROM clubs c LEFT JOIN memberships m ON c.id=m.club_id WHERE c.is_active=1 GROUP BY c.id ORDER BY members DESC")->fetchAll();
} else {
    // House admin: scoped stats
    $s1 = $db->prepare("SELECT COUNT(*) FROM students WHERE house=?"); $s1->execute([$adminHouse]);
    $s2 = $db->prepare("SELECT COUNT(*) FROM students WHERE house=? AND password IS NOT NULL"); $s2->execute([$adminHouse]);
    $s3 = $db->prepare("SELECT COUNT(*) FROM memberships m JOIN students s ON m.student_id=s.student_id WHERE m.status='approved' AND s.house=?"); $s3->execute([$adminHouse]);
    $s4 = $db->prepare("SELECT COUNT(*) FROM memberships m JOIN students s ON m.student_id=s.student_id WHERE m.status='pending'  AND s.house=?"); $s4->execute([$adminHouse]);
    $s5 = $db->prepare("SELECT COUNT(*) FROM memberships m JOIN students s ON m.student_id=s.student_id WHERE m.status='rejected' AND s.house=?"); $s5->execute([$adminHouse]);
    $s6 = $db->prepare("SELECT COUNT(*) FROM clubs WHERE is_active=1 AND (house=? OR house IS NULL)"); $s6->execute([$adminHouse]);

    $stats = [
        'total_students' => $s1->fetchColumn(),
        'registered'     => $s2->fetchColumn(),
        'total_approved' => $s3->fetchColumn(),
        'total_pending'  => $s4->fetchColumn(),
        'total_rejected' => $s5->fetchColumn(),
        'total_clubs'    => $s6->fetchColumn(),
    ];

    $hs = $db->prepare("SELECT s.house,
        COUNT(*) as total,
        SUM(CASE WHEN s.password IS NOT NULL THEN 1 ELSE 0 END) as registered,
        (SELECT COUNT(*) FROM memberships m2 JOIN students s2 ON m2.student_id=s2.student_id WHERE s2.house=s.house AND m2.status='approved') as memberships
        FROM students s WHERE s.house=? GROUP BY s.house");
    $hs->execute([$adminHouse]);
    $house_stats = $hs->fetchAll();

    $cs = $db->prepare("SELECT course, COUNT(*) as cnt FROM students WHERE house=? GROUP BY course ORDER BY cnt DESC");
    $cs->execute([$adminHouse]);
    $course_stats = $cs->fetchAll();

    $cl = $db->prepare("SELECT c.club_name, c.house,
        COUNT(CASE WHEN m.status='approved' THEN 1 END) as members,
        COUNT(CASE WHEN m.status='pending'  THEN 1 END) as pending
        FROM clubs c LEFT JOIN memberships m ON c.id=m.club_id
        WHERE c.is_active=1 AND (c.house=? OR c.house IS NULL) GROUP BY c.id ORDER BY members DESC");
    $cl->execute([$adminHouse]);
    $club_stats = $cl->fetchAll();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Reports — Admin</title>
<link rel="stylesheet" href="../css/admin.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
.export-btn{display:inline-flex;align-items:center;gap:8px;padding:10px 18px;border-radius:10px;text-decoration:none;font-size:13px;font-weight:700}
</style>
</head>
<body>
<aside class="admin-sidebar">
    <div style="padding:24px 20px;border-bottom:1px solid rgba(255,255,255,0.1)">
        <div style="display:flex;align-items:center;gap:12px">
<div class="logo">
                <img src="../assets/aclc_logo(1).png"  style="width:40px;height:40px;object-fit:contain;">
            </div>            <div>
                <div style="font-size:16px;font-weight:800">ACLC Admin</div>
                <div style="font-size:11px;color:rgba(255,255,255,0.5)"><?= $adminHouse ? sanitize($adminHouse) . ' House' : 'All Houses' ?></div>
            </div>
        </div>
    </div>
    <nav style="flex:1;padding:16px 0">
        <a href="dashboard.php"   class="admin-nav-item"><i class="fas fa-tachometer-alt" style="width:18px"></i> Dashboard</a>
        <a href="students.php"    class="admin-nav-item"><i class="fas fa-users" style="width:18px"></i> Students</a>
        <a href="memberships.php" class="admin-nav-item"><i class="fas fa-id-card" style="width:18px"></i> Memberships</a>
        <a href="clubs.php"       class="admin-nav-item"><i class="fas fa-layer-group" style="width:18px"></i> Clubs</a>
        <a href="events.php"      class="admin-nav-item"><i class="fas fa-calendar-alt" style="width:18px"></i> Events</a>
        <a href="reports.php"     class="admin-nav-item active"><i class="fas fa-chart-bar" style="width:18px"></i> Reports</a>
    </nav>
    <div style="padding:16px 20px;border-top:1px solid rgba(255,255,255,0.1)">
        <?php if ($adminHouse): ?>
        <div style="margin-bottom:8px">
            <span style="background:<?= getHouseColor($adminHouse) ?>;color:#fff;font-size:10px;font-weight:700;padding:2px 10px;border-radius:10px"><?= sanitize($adminHouse) ?> ADMIN</span>
        </div>
        <?php endif; ?>
        <a href="logout.php" style="display:block;text-align:center;padding:8px;background:rgba(255,255,255,0.08);border-radius:8px;color:rgba(255,255,255,0.7);text-decoration:none;font-size:13px">Logout</a>
    </div>
</aside>

<main class="admin-main">
    <div class="admin-topbar">
        <div style="font-size:22px;font-weight:800;color:#1a1a2e">
            Reports &amp; Analytics
            <?php if ($adminHouse): ?>
            <span style="font-size:14px;background:<?= getHouseColor($adminHouse) ?>;color:#fff;padding:3px 12px;border-radius:10px;margin-left:8px;font-weight:700"><?= sanitize($adminHouse) ?> HOUSE</span>
            <?php endif; ?>
        </div>
        <div style="display:flex;gap:10px">
            <a href="?export=students<?= $adminHouse ? '&house='.$adminHouse : '' ?>" class="export-btn" style="background:#e8f0fe;color:#0d47a1"><i class="fas fa-users"></i> Export Students CSV</a>
            <a href="?export=memberships<?= $adminHouse ? '&house='.$adminHouse : '' ?>" class="export-btn" style="background:#e8f5e9;color:#2e7d32"><i class="fas fa-id-card"></i> Export Memberships CSV</a>
        </div>
    </div>

    <div class="admin-page">

        <!-- Summary Stats -->
        <div class="stats-row" style="grid-template-columns:repeat(3,1fr);margin-bottom:28px">
            <div class="stat-card" style="border-left-color:#0d47a1">
                <div class="stat-icon" style="background:#e8f0fe;color:#0d47a1"><i class="fas fa-users"></i></div>
                <div>
                    <div class="stat-value"><?= number_format($stats['total_students']) ?></div>
                    <div class="stat-label"><?= $adminHouse ? sanitize($adminHouse).' ' : '' ?>Students</div>
                    <div style="font-size:12px;color:#888;margin-top:2px"><?= $stats['registered'] ?> registered (<?= $stats['total_students']>0?round($stats['registered']/$stats['total_students']*100):'0' ?>%)</div>
                </div>
            </div>
            <div class="stat-card" style="border-left-color:#2e7d32">
                <div class="stat-icon" style="background:#e8f5e9;color:#2e7d32"><i class="fas fa-id-card"></i></div>
                <div>
                    <div class="stat-value"><?= number_format($stats['total_approved']) ?></div>
                    <div class="stat-label">Approved Memberships</div>
                    <div style="font-size:12px;color:#888;margin-top:2px"><?= $stats['total_pending'] ?> pending · <?= $stats['total_rejected'] ?> rejected</div>
                </div>
            </div>
            <div class="stat-card" style="border-left-color:#00acc1">
                <div class="stat-icon" style="background:#e0f7fa;color:#00acc1"><i class="fas fa-layer-group"></i></div>
                <div>
                    <div class="stat-value"><?= $stats['total_clubs'] ?></div>
                    <div class="stat-label">Active Clubs</div>
                </div>
            </div>
        </div>

        <div style="display:grid;grid-template-columns:1fr 1fr;gap:24px">

            <!-- House Breakdown -->
            <div class="card">
                <div class="card-title"><i class="fas fa-home" style="color:#0d47a1"></i>
                    <?= $isSuperAdmin ? 'Breakdown by House' : sanitize($adminHouse) . ' House Stats' ?>
                </div>
                <div class="table-wrapper">
                <table class="data-table">
                    <thead><tr><th>House</th><th>Students</th><th>Registered</th><th>Memberships</th></tr></thead>
                    <tbody>
                    <?php foreach ($house_stats as $h): ?>
                    <tr>
                        <td><span style="background:<?= getHouseColor($h['house']) ?>;color:<?= getHouseColor($h['house'],'text') ?>;font-size:11px;font-weight:700;padding:3px 10px;border-radius:10px"><?= sanitize($h['house']) ?></span></td>
                        <td style="font-weight:700"><?= $h['total'] ?></td>
                        <td><?= $h['registered'] ?> <span style="color:#888;font-size:12px">(<?= $h['total']>0?round($h['registered']/$h['total']*100):'0' ?>%)</span></td>
                        <td><?= $h['memberships'] ?></td>
                    </tr>
                    <?php endforeach; ?>
                    </tbody>
                </table>
                </div>
            </div>

            <!-- Course Breakdown -->
            <div class="card">
                <div class="card-title"><i class="fas fa-graduation-cap" style="color:#0d47a1"></i> Breakdown by Course</div>
                <?php foreach ($course_stats as $c): ?>
                <div style="display:flex;align-items:center;gap:12px;margin-bottom:14px">
                    <div style="min-width:80px;font-weight:700;font-size:14px"><?= sanitize($c['course']) ?></div>
                    <div style="flex:1;height:10px;background:#f0f0f0;border-radius:5px">
                        <div style="height:10px;background:#0d47a1;border-radius:5px;width:<?= $stats['total_students']>0?round($c['cnt']/$stats['total_students']*100):0 ?>%"></div>
                    </div>
                    <div style="min-width:40px;text-align:right;font-size:14px;font-weight:700;color:#555"><?= $c['cnt'] ?></div>
                </div>
                <?php endforeach; ?>
            </div>

            <!-- Club Stats -->
            <div class="card" style="grid-column:1/-1">
                <div class="card-title"><i class="fas fa-layer-group" style="color:#0d47a1"></i> Club Membership Stats</div>
                <div class="table-wrapper">
                <table class="data-table">
                    <thead><tr><th>Club</th><th>House</th><th>Approved Members</th><th>Pending</th></tr></thead>
                    <tbody>
                    <?php foreach ($club_stats as $cl): ?>
                    <tr>
                        <td style="font-weight:700"><?= sanitize($cl['club_name']) ?></td>
                        <td>
                            <?php if ($cl['house']): ?>
                            <span style="background:<?= getHouseColor($cl['house']) ?>;color:<?= getHouseColor($cl['house'],'text') ?>;font-size:11px;font-weight:700;padding:2px 8px;border-radius:10px"><?= sanitize($cl['house']) ?></span>
                            <?php else: ?>
                            <span style="background:#e8f0fe;color:#0d47a1;font-size:11px;font-weight:700;padding:2px 8px;border-radius:10px">ALL</span>
                            <?php endif; ?>
                        </td>
                        <td><span style="background:#e8f5e9;color:#2e7d32;font-weight:700;padding:3px 10px;border-radius:10px;font-size:13px"><?= $cl['members'] ?></span></td>
                        <td><span style="background:#fff3e0;color:#e65100;font-weight:700;padding:3px 10px;border-radius:10px;font-size:13px"><?= $cl['pending'] ?></span></td>
                    </tr>
                    <?php endforeach; ?>
                    </tbody>
                </table>
                </div>
            </div>
        </div>
    </div>
</main>
</body>
</html>
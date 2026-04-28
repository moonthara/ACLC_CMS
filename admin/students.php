<?php
session_start();
require_once '../includes/config.php';
requireAdmin();

$db = getDB();
$adminHouse   = getAdminHouse();
$isSuperAdmin = isSuperAdmin();

// Search/filter
$search        = trim($_GET['search'] ?? '');
$house_filter  = $adminHouse ?? ($_GET['house'] ?? ''); // house admins cannot change house filter
$course_filter = $_GET['course'] ?? '';
$page_num      = max(1, (int)($_GET['page'] ?? 1));
$per_page      = 25;
$offset        = ($page_num - 1) * $per_page;

$where  = "WHERE 1=1";
$params = [];

// House admin: always lock to their house
if ($adminHouse) {
    $where   .= " AND s.house = ?";
    $params[] = $adminHouse;
} elseif ($house_filter) {
    $where   .= " AND s.house = ?";
    $params[] = $house_filter;
}

if ($search) {
    $where   .= " AND (s.last_name LIKE ? OR s.first_name LIKE ? OR s.student_id LIKE ?)";
    $params[] = "%$search%"; $params[] = "%$search%"; $params[] = "%$search%";
}
if ($course_filter) {
    $where   .= " AND s.course = ?";
    $params[] = $course_filter;
}

$total_count = $db->prepare("SELECT COUNT(*) FROM students s $where");
$total_count->execute($params);
$total       = $total_count->fetchColumn();
$total_pages = ceil($total / $per_page);

$stmt = $db->prepare("SELECT s.*,
    (SELECT COUNT(*) FROM memberships m WHERE m.student_id=s.student_id AND m.status='approved') as club_count
    FROM students s $where ORDER BY s.house, s.last_name LIMIT $per_page OFFSET $offset");
$stmt->execute($params);
$students = $stmt->fetchAll();
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Students — Admin</title>
<link rel="stylesheet" href="../css/admin.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
.filter-bar{background:white;border-radius:12px;padding:18px 20px;margin-bottom:20px;display:flex;gap:12px;flex-wrap:wrap;align-items:center;box-shadow:0 2px 8px rgba(0,0,0,0.05)}
.filter-bar input,.filter-bar select{padding:9px 14px;border:2px solid #e0e0e0;border-radius:8px;font-size:14px;color:#333}
.filter-bar input:focus,.filter-bar select:focus{outline:none;border-color:#0d47a1}
.filter-bar input{flex:1;min-width:200px}
.btn-sm{padding:7px 16px;border:none;border-radius:8px;font-size:13px;font-weight:700;cursor:pointer}
.btn-blue{background:#e8f0fe;color:#0d47a1}
.btn-blue:hover{background:#0d47a1;color:white}
.pagination{display:flex;gap:6px;align-items:center;justify-content:center;margin-top:20px}
.page-btn{width:36px;height:36px;border:2px solid #e0e0e0;border-radius:8px;background:white;cursor:pointer;font-size:14px;display:flex;align-items:center;justify-content:center;text-decoration:none;color:#333}
.page-btn.active{background:#0d47a1;color:white;border-color:#0d47a1}
.page-btn:hover:not(.active){border-color:#0d47a1;color:#0d47a1}
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
        <div style="padding:12px 20px 6px;font-size:10px;letter-spacing:1.5px;color:rgba(255,255,255,0.4);text-transform:uppercase">Main</div>
        <a href="dashboard.php"   class="admin-nav-item"><i class="fas fa-tachometer-alt" style="width:18px"></i> Dashboard</a>
        <a href="students.php"    class="admin-nav-item active"><i class="fas fa-users" style="width:18px"></i> Students</a>
        <a href="memberships.php" class="admin-nav-item"><i class="fas fa-id-card" style="width:18px"></i> Memberships</a>
        <a href="clubs.php"       class="admin-nav-item"><i class="fas fa-layer-group" style="width:18px"></i> Clubs</a>
        <a href="events.php"      class="admin-nav-item"><i class="fas fa-calendar-alt" style="width:18px"></i> Events</a>
        <a href="reports.php"     class="admin-nav-item"><i class="fas fa-chart-bar" style="width:18px"></i> Reports</a>
    </nav>
    <div style="padding:16px 20px;border-top:1px solid rgba(255,255,255,0.1)">
        <div style="font-size:13px;color:rgba(255,255,255,0.7);margin-bottom:8px">
            <i class="fas fa-user-shield"></i> <?= sanitize($_SESSION['admin_name']) ?>
        </div>
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
            Students
            <?php if ($adminHouse): ?>
            <span style="font-size:14px;background:<?= getHouseColor($adminHouse) ?>;color:#fff;padding:3px 12px;border-radius:10px;margin-left:8px;font-weight:700"><?= sanitize($adminHouse) ?> HOUSE</span>
            <?php endif; ?>
            <span style="font-size:16px;color:#888;font-weight:400">(<?= number_format($total) ?> found)</span>
        </div>
        <a href="reports.php?export=students<?= $adminHouse ? '&house='.$adminHouse : '' ?>"
           style="background:#0d47a1;color:white;padding:10px 18px;border-radius:10px;text-decoration:none;font-size:13px;font-weight:700">
           <i class="fas fa-download"></i> Export CSV
        </a>
    </div>

    <div class="admin-page">
        <!-- Filters -->
        <form method="GET" class="filter-bar">
            <input type="text" name="search" value="<?= sanitize($search) ?>" placeholder="🔍  Search by name or student ID...">

            <?php if ($isSuperAdmin): ?>
            <!-- Super admin can filter by any house -->
            <select name="house">
                <option value="">All Houses</option>
                <?php foreach (['AZUL','CAHEL','GIALLIO','ROXXO','VIERRDY'] as $h): ?>
                <option value="<?= $h ?>" <?= $house_filter===$h?'selected':'' ?>><?= $h ?></option>
                <?php endforeach; ?>
            </select>
            <?php else: ?>
            <!-- House admin: house is locked, show it as a label only -->
            <span style="padding:9px 16px;background:<?= getHouseColor($adminHouse) ?>;color:#fff;border-radius:8px;font-size:13px;font-weight:700">
                <?= sanitize($adminHouse) ?> HOUSE
            </span>
            <?php endif; ?>

            <select name="course">
                <option value="">All Courses</option>
                <?php
                $courses = $db->query("SELECT DISTINCT course FROM students ORDER BY course")->fetchAll(PDO::FETCH_COLUMN);
                foreach ($courses as $c): ?>
                <option value="<?= sanitize($c) ?>" <?= $course_filter===$c?'selected':'' ?>><?= sanitize($c) ?></option>
                <?php endforeach; ?>
            </select>
            <button type="submit" class="btn-sm btn-blue"><i class="fas fa-search"></i> Search</button>
            <a href="students.php" class="btn-sm" style="background:#f0f0f0;color:#555;padding:7px 14px;border-radius:8px;text-decoration:none">Clear</a>
        </form>

        <div class="card" style="padding:0">
            <div class="table-wrapper">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Name</th>
                        <th>Course</th>
                        <th>Level</th>
                        <th>House</th>
                        <th>Clubs</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                <?php foreach ($students as $s): ?>
                <tr>
                    <td><code style="font-size:12px;background:#f0f4ff;padding:3px 8px;border-radius:6px"><?= sanitize($s['student_id']) ?></code></td>
                    <td>
                        <div style="font-weight:700"><?= sanitize($s['last_name']) ?>, <?= sanitize($s['first_name']) ?></div>
                        <?php if ($s['middle_name'] && $s['middle_name'] !== '-'): ?>
                        <div style="font-size:12px;color:#888"><?= sanitize($s['middle_name']) ?></div>
                        <?php endif; ?>
                    </td>
                    <td><?= sanitize($s['course']) ?></td>
                    <td><?= sanitize($s['level']) ?></td>
                    <td><span style="background:<?= getHouseColor($s['house']) ?>;color:<?= getHouseColor($s['house'],'text') ?>;font-size:11px;font-weight:700;padding:3px 10px;border-radius:10px"><?= sanitize($s['house']) ?></span></td>
                    <td style="text-align:center">
                        <span style="background:#e8f0fe;color:#0d47a1;font-weight:700;padding:3px 10px;border-radius:10px;font-size:12px"><?= $s['club_count'] ?></span>
                    </td>
                    <td>
                        <?php if (empty($s['password'])): ?>
                        <span style="background:#fff3e0;color:#e65100;font-size:11px;font-weight:700;padding:3px 8px;border-radius:8px">Not Registered</span>
                        <?php else: ?>
                        <span style="background:#e8f5e9;color:#2e7d32;font-size:11px;font-weight:700;padding:3px 8px;border-radius:8px">Registered</span>
                        <?php endif; ?>
                    </td>
                </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
            </div>
        </div>

        <!-- Pagination -->
        <?php if ($total_pages > 1): ?>
        <div class="pagination">
            <?php for ($i = 1; $i <= $total_pages; $i++): ?>
            <a href="?page=<?= $i ?>&search=<?= urlencode($search) ?>&house=<?= urlencode($house_filter) ?>&course=<?= urlencode($course_filter) ?>"
               class="page-btn <?= $i === $page_num ? 'active' : '' ?>"><?= $i ?></a>
            <?php endfor; ?>
        </div>
        <?php endif; ?>
    </div>
</main>
</body>
</html>
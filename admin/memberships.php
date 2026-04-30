<?php
session_start();
require_once '../includes/config.php';
requireAdmin();

$db           = getDB();
$adminHouse   = getAdminHouse();
$isSuperAdmin = isSuperAdmin();
$msg          = '';


if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'], $_POST['membership_id'])) {
    $mid    = (int)$_POST['membership_id'];
    $action = $_POST['action'];


    if (!$isSuperAdmin) {
        $check = $db->prepare("SELECT m.id FROM memberships m
            JOIN students s ON m.student_id=s.student_id
            WHERE m.id=? AND s.house=?");
        $check->execute([$mid, $adminHouse]);
        if (!$check->fetch()) {
            die("Access denied.");
        }
    }

    if ($action === 'approve') {
        $db->prepare("UPDATE memberships SET status='approved', reviewed_at=NOW(), reviewed_by=? WHERE id=?")
           ->execute([$_SESSION['admin_id'], $mid]);
        $stmt = $db->prepare("SELECT * FROM memberships WHERE id=?");
        $stmt->execute([$mid]);
        $m = $stmt->fetch();
        if ($m) {
            $card_number = 'ACLC-' . strtoupper(substr(md5($m['student_id'].$m['club_id'].time()), 0, 8));
            try {
                $db->prepare("INSERT INTO membership_cards (student_id, club_id, card_number) VALUES (?,?,?)")
                   ->execute([$m['student_id'], $m['club_id'], $card_number]);
            } catch (Exception $e) {}
        }
        $msg = "Application approved and membership card issued!";
    } elseif ($action === 'reject') {
        $notes = trim($_POST['notes'] ?? '');
        $db->prepare("UPDATE memberships SET status='rejected', reviewed_at=NOW(), reviewed_by=?, notes=? WHERE id=?")
           ->execute([$_SESSION['admin_id'], $notes, $mid]);
        $msg = "Application rejected.";
    }
}


$status_filter = $_GET['status'] ?? 'pending';
$house_filter  = $adminHouse ?? ($_GET['house'] ?? '');
$search        = trim($_GET['search'] ?? '');

$where  = "WHERE 1=1";
$params = [];

if ($status_filter) { $where .= " AND m.status=?";   $params[] = $status_filter; }


if ($adminHouse) {
    $where .= " AND s.house=?"; $params[] = $adminHouse;
} elseif ($house_filter) {
    $where .= " AND s.house=?"; $params[] = $house_filter;
}

if ($search) {
    $where .= " AND (s.last_name LIKE ? OR s.first_name LIKE ? OR s.student_id LIKE ?)";
    $params[] = "%$search%"; $params[] = "%$search%"; $params[] = "%$search%";
}

$memberships = $db->prepare("SELECT m.*, s.first_name, s.last_name, s.student_id as sid, s.house, s.course,
    c.club_name, mc.card_number
    FROM memberships m
    JOIN students s ON m.student_id = s.student_id
    JOIN clubs c ON m.club_id = c.id
    LEFT JOIN membership_cards mc ON mc.student_id=m.student_id AND mc.club_id=m.club_id
    $where ORDER BY m.applied_at DESC");
$memberships->execute($params);
$memberships = $memberships->fetchAll();


if ($adminHouse) {
    $counts = $db->prepare("SELECT m.status, COUNT(*) as cnt FROM memberships m
        JOIN students s ON m.student_id=s.student_id WHERE s.house=? GROUP BY m.status");
    $counts->execute([$adminHouse]);
} else {
    $counts = $db->query("SELECT status, COUNT(*) as cnt FROM memberships GROUP BY status");
}
$count_map = [];
foreach ($counts->fetchAll() as $c) $count_map[$c['status']] = $c['cnt'];
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Memberships — Admin</title>
<link rel="stylesheet" href="../css/admin.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
.tab-bar{display:flex;gap:4px;background:white;border-radius:12px;padding:6px;margin-bottom:20px;box-shadow:0 2px 8px rgba(0,0,0,0.05)}
.tab{padding:10px 20px;border-radius:8px;text-decoration:none;font-size:14px;font-weight:700;color:#666;transition:all 0.2s}
.tab.active{background:#0d47a1;color:white}
.tab:hover:not(.active){background:#f0f4ff;color:#0d47a1}
.tab .count{background:rgba(255,255,255,0.3);padding:1px 7px;border-radius:10px;font-size:12px;margin-left:6px}
.tab:not(.active) .count{background:#e8f0fe;color:#0d47a1}
.filter-bar{background:white;border-radius:12px;padding:16px 20px;margin-bottom:20px;display:flex;gap:12px;align-items:center;box-shadow:0 2px 8px rgba(0,0,0,0.05)}
.filter-bar input,.filter-bar select{padding:9px 14px;border:2px solid #e0e0e0;border-radius:8px;font-size:14px}
.filter-bar input{flex:1}
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
        <a href="memberships.php" class="admin-nav-item active"><i class="fas fa-id-card" style="width:18px"></i> Memberships</a>
        <a href="clubs.php"       class="admin-nav-item"><i class="fas fa-layer-group" style="width:18px"></i> Clubs</a>
        <a href="events.php"      class="admin-nav-item"><i class="fas fa-calendar-alt" style="width:18px"></i> Events</a>
        <a href="reports.php"     class="admin-nav-item"><i class="fas fa-chart-bar" style="width:18px"></i> Reports</a>
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
            Memberships
            <?php if ($adminHouse): ?>
            <span style="font-size:14px;background:<?= getHouseColor($adminHouse) ?>;color:#fff;padding:3px 12px;border-radius:10px;margin-left:8px;font-weight:700"><?= sanitize($adminHouse) ?> HOUSE</span>
            <?php endif; ?>
        </div>
    </div>

    <div class="admin-page">
        <?php if ($msg): ?>
        <div class="alert alert-success" style="margin-bottom:16px"><i class="fas fa-check-circle"></i> <?= sanitize($msg) ?></div>
        <?php endif; ?>

        
        <div class="tab-bar">
            <?php foreach (['pending' => '⏳ Pending', 'approved' => '✅ Approved', 'rejected' => '❌ Rejected', '' => '📋 All'] as $val => $label): ?>
            <a href="?status=<?= $val ?>" class="tab <?= $status_filter === $val ? 'active' : '' ?>">
                <?= $label ?>
                <?php $cnt = $count_map[$val] ?? ($val===''?array_sum($count_map):0); ?>
                <span class="count"><?= $cnt ?></span>
            </a>
            <?php endforeach; ?>
        </div>

        
        <form method="GET" class="filter-bar">
            <input type="hidden" name="status" value="<?= sanitize($status_filter) ?>">
            <input type="text" name="search" value="<?= sanitize($search) ?>" placeholder="Search by name or student ID...">

            <?php if ($isSuperAdmin): ?>
            <select name="house">
                <option value="">All Houses</option>
                <?php foreach (['AZUL','CAHEL','GIALLIO','ROXXO','VIERRDY'] as $h): ?>
                <option value="<?= $h ?>" <?= $house_filter===$h?'selected':'' ?>><?= $h ?></option>
                <?php endforeach; ?>
            </select>
            <?php else: ?>
            <span style="padding:9px 16px;background:<?= getHouseColor($adminHouse) ?>;color:#fff;border-radius:8px;font-size:13px;font-weight:700">
                <?= sanitize($adminHouse) ?> HOUSE
            </span>
            <?php endif; ?>

            <button type="submit" style="padding:9px 18px;background:#0d47a1;color:white;border:none;border-radius:8px;cursor:pointer;font-weight:700">Search</button>
        </form>

        <div class="card" style="padding:0">
        <div class="table-wrapper">
        <table class="data-table">
            <thead>
                <tr>
                    <th>Student</th>
                    <th>House</th>
                    <th>Course</th>
                    <th>Club</th>
                    <th>Applied</th>
                    <th>Status</th>
                    <th>Card #</th>
                    <?php if ($status_filter === 'pending' || !$status_filter): ?><th>Action</th><?php endif; ?>
                </tr>
            </thead>
            <tbody>
            <?php if (empty($memberships)): ?>
            <tr><td colspan="8" style="text-align:center;padding:30px;color:#aaa">No applications found.</td></tr>
            <?php else: ?>
            <?php foreach ($memberships as $m): ?>
            <tr>
                <td>
                    <div style="font-weight:700"><?= sanitize($m['last_name']) ?>, <?= sanitize($m['first_name']) ?></div>
                    <div style="font-size:11px;font-family:monospace;color:#888"><?= sanitize($m['sid']) ?></div>
                </td>
                <td><span style="background:<?= getHouseColor($m['house']) ?>;color:<?= getHouseColor($m['house'],'text') ?>;font-size:11px;font-weight:700;padding:2px 8px;border-radius:10px"><?= sanitize($m['house']) ?></span></td>
                <td style="font-size:13px"><?= sanitize($m['course']) ?></td>
                <td style="font-size:13px"><?= sanitize($m['club_name']) ?></td>
                <td style="font-size:12px;color:#888"><?= date('M d, Y', strtotime($m['applied_at'])) ?></td>
                <td><span class="membership-status status-<?= $m['status'] ?>"><?= ucfirst($m['status']) ?></span></td>
                <td style="font-size:11px;font-family:monospace;color:#888"><?= $m['card_number'] ? sanitize($m['card_number']) : '—' ?></td>
                <?php if ($status_filter === 'pending' || !$status_filter): ?>
                <td>
                    <?php if ($m['status'] === 'pending'): ?>
                    <div style="display:flex;gap:6px">
                        <form method="POST" style="margin:0">
                            <input type="hidden" name="membership_id" value="<?= $m['id'] ?>">
                            <button name="action" value="approve" style="padding:5px 12px;background:#e8f5e9;color:#2e7d32;border:none;border-radius:6px;cursor:pointer;font-size:12px;font-weight:700">✓ Approve</button>
                        </form>
                        <button onclick="openReject(<?= $m['id'] ?>)" style="padding:5px 12px;background:#ffebee;color:#c62828;border:none;border-radius:6px;cursor:pointer;font-size:12px;font-weight:700">✗ Reject</button>
                    </div>
                    <?php endif; ?>
                </td>
                <?php endif; ?>
            </tr>
            <?php endforeach; ?>
            <?php endif; ?>
            </tbody>
        </table>
        </div>
        </div>
    </div>
</main>


<div class="modal-overlay" id="rejectModal">
    <div class="modal">
        <h3 style="margin-bottom:16px;font-size:18px">Reject Application</h3>
        <form method="POST">
            <input type="hidden" name="action" value="reject">
            <input type="hidden" name="membership_id" id="reject_id">
            <label style="font-size:13px;font-weight:700;color:#555;display:block;margin-bottom:8px">Reason (optional)</label>
            <textarea name="notes" rows="3" style="width:100%;padding:10px;border:2px solid #e0e0e0;border-radius:8px;font-size:14px;resize:none" placeholder="Reason for rejection..."></textarea>
            <div style="display:flex;gap:10px;margin-top:16px">
                <button type="submit" style="flex:1;padding:12px;background:#c62828;color:white;border:none;border-radius:8px;font-weight:700;cursor:pointer">Reject</button>
                <button type="button" onclick="closeReject()" style="flex:1;padding:12px;background:#f0f0f0;color:#333;border:none;border-radius:8px;font-weight:700;cursor:pointer">Cancel</button>
            </div>
        </form>
    </div>
</div>
<script>
function openReject(id) {
    document.getElementById('reject_id').value = id;
    document.getElementById('rejectModal').classList.add('open');
}
function closeReject() {
    document.getElementById('rejectModal').classList.remove('open');
}
</script>
</body>
</html>
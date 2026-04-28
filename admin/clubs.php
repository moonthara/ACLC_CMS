<?php
session_start();
require_once '../includes/config.php';
requireAdmin();

$db           = getDB();
$adminHouse   = getAdminHouse();
$isSuperAdmin = isSuperAdmin();
$msg          = '';

// ── Add club ─────────────────────────────────────────────────
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['add_club'])) {
    $name = trim($_POST['club_name'] ?? '');
    $desc = trim($_POST['description'] ?? '');
    $max  = (int)($_POST['max_members'] ?? 50);

    // House admin can only create clubs for their own house
    $house = $isSuperAdmin ? ($_POST['house'] ?: null) : $adminHouse;

    if ($name) {
        $db->prepare("INSERT INTO clubs (club_name, description, house, max_members, created_by) VALUES (?,?,?,?,?)")
          ->execute([$name, $desc, $house, $max, $_SESSION['admin_id']]);
        $msg = "Club '$name' created successfully!";
    }
}

// ── Toggle active ─────────────────────────────────────────────
if (isset($_GET['toggle'])) {
    $cid = (int)$_GET['toggle'];

    // House admin: only toggle clubs that belong to their house
    if (!$isSuperAdmin) {
        $check = $db->prepare("SELECT id FROM clubs WHERE id=? AND house=?");
        $check->execute([$cid, $adminHouse]);
        if (!$check->fetch()) { redirect('clubs.php'); }
    }

    $db->prepare("UPDATE clubs SET is_active = NOT is_active WHERE id=?")->execute([$cid]);
    redirect('clubs.php');
}

// ── Fetch clubs ───────────────────────────────────────────────
if ($isSuperAdmin) {
    $clubs = $db->query("SELECT c.*,
        (SELECT COUNT(*) FROM memberships m WHERE m.club_id=c.id AND m.status='approved') as member_count,
        (SELECT COUNT(*) FROM memberships m WHERE m.club_id=c.id AND m.status='pending')  as pending_count
        FROM clubs c ORDER BY c.house, c.club_name")->fetchAll();
} else {
    // House admin sees clubs tagged to their house OR open-to-all (NULL house) clubs
    $stmt = $db->prepare("SELECT c.*,
        (SELECT COUNT(*) FROM memberships m WHERE m.club_id=c.id AND m.status='approved') as member_count,
        (SELECT COUNT(*) FROM memberships m WHERE m.club_id=c.id AND m.status='pending')  as pending_count
        FROM clubs c WHERE (c.house=? OR c.house IS NULL) ORDER BY c.house, c.club_name");
    $stmt->execute([$adminHouse]);
    $clubs = $stmt->fetchAll();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Clubs — Admin</title>
<link rel="stylesheet" href="../css/admin.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<aside class="admin-sidebar">
    <div style="padding:24px 20px;border-bottom:1px solid var(--sidebar-border)">
        <div style="display:flex;align-items:center;gap:12px">
<div class="logo">
                <img src="../assets/aclc_logo(1).png"  style="width:40px;height:40px;object-fit:contain;">
            </div>            <div>
                <div class="admin-brand-title">ACLC Admin</div>
                <div class="admin-brand-sub"><?= $adminHouse ? sanitize($adminHouse) . ' House' : 'All Houses' ?></div>
            </div>
        </div>
    </div>
    <nav style="flex:1;padding:16px 0">
        <a href="dashboard.php"   class="admin-nav-item"><i class="fas fa-tachometer-alt" style="width:18px"></i> Dashboard</a>
        <a href="students.php"    class="admin-nav-item"><i class="fas fa-users" style="width:18px"></i> Students</a>
        <a href="memberships.php" class="admin-nav-item"><i class="fas fa-id-card" style="width:18px"></i> Memberships</a>
        <a href="clubs.php"       class="admin-nav-item active"><i class="fas fa-layer-group" style="width:18px"></i> Clubs</a>
        <a href="events.php"      class="admin-nav-item"><i class="fas fa-calendar-alt" style="width:18px"></i> Events</a>
        <a href="reports.php"     class="admin-nav-item"><i class="fas fa-chart-bar" style="width:18px"></i> Reports</a>
    </nav>
    <div style="padding:16px 20px;border-top:1px solid var(--sidebar-border)">
        <?php if ($adminHouse): ?>
        <div style="margin-bottom:8px">
            <span style="background:<?= getHouseColor($adminHouse) ?>;color:#fff;font-size:10px;font-weight:700;padding:2px 10px;border-radius:10px"><?= sanitize($adminHouse) ?> ADMIN</span>
        </div>
        <?php endif; ?>
        <a href="logout.php" style="display:block;text-align:center;padding:8px;background:rgba(255,255,255,0.08);border-radius:8px;color:var(--sidebar-muted);text-decoration:none;font-size:13px">Logout</a>
    </div>
</aside>

<main class="admin-main">
    <div class="admin-topbar">
        <h1>
            Clubs
            <?php if ($adminHouse): ?>
            <span style="font-size:14px;background:<?= getHouseColor($adminHouse) ?>;color:#fff;padding:3px 12px;border-radius:10px;margin-left:8px;font-weight:700"><?= sanitize($adminHouse) ?> HOUSE</span>
            <?php endif; ?>
        </h1>
        <button onclick="document.getElementById('addModal').classList.add('open')" class="btn-primary">
            <i class="fas fa-plus"></i> Add New Club
        </button>
    </div>

    <div class="admin-page">
        <?php if ($msg): ?>
        <div class="alert alert-success" style="margin-bottom:16px;background:#e8f5e9;color:#2e7d32;padding:12px;border-radius:8px;">
            <i class="fas fa-check-circle"></i> <?= sanitize($msg) ?>
        </div>
        <?php endif; ?>

        <div class="clubs-grid">
            <?php foreach ($clubs as $club): ?>
            <div class="club-card" style="<?= !$club['is_active'] ? 'opacity:0.6' : '' ?>">
                <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:10px">
                    <div class="club-card-name"><?= sanitize($club['club_name']) ?></div>
                    <?php if ($club['house']): ?>
                    <span style="background:<?= getHouseColor($club['house']) ?>;color:<?= getHouseColor($club['house'],'text') ?>;font-size:10px;font-weight:700;padding:2px 8px;border-radius:10px"><?= sanitize($club['house']) ?></span>
                    <?php else: ?>
                    <span style="background:#e3f2fd;color:#1565c0;font-size:10px;font-weight:700;padding:2px 8px;border-radius:10px">ALL HOUSES</span>
                    <?php endif; ?>
                </div>
                <div class="club-card-desc"><?= sanitize($club['description'] ?: 'No description.') ?></div>
                <div style="display:grid;grid-template-columns:1fr 1fr;gap:8px;margin-bottom:14px">
                    <div style="background:#e8f5e9;border-radius:8px;padding:8px;text-align:center">
                        <div style="font-size:20px;font-weight:800;color:#2e7d32"><?= $club['member_count'] ?></div>
                        <div style="font-size:11px;color:var(--text-secondary)">Members</div>
                    </div>
                    <div style="background:#fff3e0;border-radius:8px;padding:8px;text-align:center">
                        <div style="font-size:20px;font-weight:800;color:#e65100"><?= $club['pending_count'] ?></div>
                        <div style="font-size:11px;color:var(--text-secondary)">Pending</div>
                    </div>
                </div>
                <div style="display:flex;gap:8px">
                    <a href="memberships.php?club=<?= $club['id'] ?>" style="flex:1;text-align:center;padding:8px;background:#e3f2fd;color:#1565c0;border-radius:8px;text-decoration:none;font-size:12px;font-weight:700">View Members</a>
                    <?php
                    // House admin can only toggle their own house's clubs, not all-houses clubs
                    $canToggle = $isSuperAdmin || ($club['house'] === $adminHouse);
                    ?>
                    <?php if ($canToggle): ?>
                    <a href="?toggle=<?= $club['id'] ?>" style="padding:8px 12px;background:<?= $club['is_active']?'#ffebee':'#e8f5e9' ?>;color:<?= $club['is_active']?'#c62828':'#2e7d32' ?>;border-radius:8px;text-decoration:none;font-size:12px;font-weight:700">
                        <?= $club['is_active'] ? 'Disable' : 'Enable' ?>
                    </a>
                    <?php endif; ?>
                </div>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</main>

<!-- Add Club Modal -->
<div class="modal-overlay" id="addModal">
    <div class="modal">
        <h3 style="margin-bottom:20px;font-size:20px;color:var(--admin-primary)">Add New Club</h3>
        <form method="POST">
            <div class="form-group">
                <label>Club Name *</label>
                <input type="text" name="club_name" required placeholder="e.g. Computer Society">
            </div>
            <div class="form-group">
                <label>Description</label>
                <textarea name="description" rows="3" placeholder="Brief description of the club..."></textarea>
            </div>

            <?php if ($isSuperAdmin): ?>
            <!-- Super admin can assign any house or all houses -->
            <div class="form-group">
                <label>House (leave blank for all houses)</label>
                <select name="house">
                    <option value="">— All Houses —</option>
                    <?php foreach (['AZUL','CAHEL','GIALLIO','ROXXO','VIERRDY'] as $h): ?>
                    <option value="<?= $h ?>"><?= $h ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <?php else: ?>
            <!-- House admin: club is auto-assigned to their house -->
            <div class="form-group">
                <label>House</label>
                <input type="text" value="<?= sanitize($adminHouse) ?>" readonly
                    style="background:#f5f5f5;color:#555;cursor:not-allowed">
                <input type="hidden" name="house" value="<?= sanitize($adminHouse) ?>">
            </div>
            <?php endif; ?>

            <div class="form-group">
                <label>Max Members</label>
                <input type="number" name="max_members" value="50" min="1" max="500">
            </div>
            <div style="display:flex;gap:10px">
                <button type="submit" name="add_club" class="btn-primary" style="flex:1">Create Club</button>
                <button type="button" onclick="document.getElementById('addModal').classList.remove('open')"
                    style="flex:1;padding:12px;background:#f0f0f0;color:#333;border:none;border-radius:8px;font-weight:700;cursor:pointer">
                    Cancel
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
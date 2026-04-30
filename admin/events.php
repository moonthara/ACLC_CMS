<?php
session_start();
require_once '../includes/config.php';
requireAdmin();

$db           = getDB();
$adminHouse   = getAdminHouse();
$isSuperAdmin = isSuperAdmin();
$msg          = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['add_event'])) {
    $title      = trim($_POST['title'] ?? '');
    $desc       = trim($_POST['description'] ?? '');
    $club_id    = $_POST['club_id'] ? (int)$_POST['club_id'] : null;
    $event_date = $_POST['event_date'] ?: null;
    $event_time = $_POST['event_time'] ?: null;
    $venue      = trim($_POST['venue'] ?? '');
    $type       = $_POST['type'] ?? 'event';
    
    $house      = $isSuperAdmin ? ($_POST['house'] ?: null) : $adminHouse;

    if ($title) {
        $db->prepare("INSERT INTO events (club_id, title, description, event_date, event_time, venue, type, house, created_by) VALUES (?,?,?,?,?,?,?,?,?)")
          ->execute([$club_id, $title, $desc, $event_date, $event_time, $venue, $type, $house, $_SESSION['admin_id']]);
        $msg = "Event/Announcement posted!";
    }
}


if (isset($_GET['delete'])) {
    $eid = (int)$_GET['delete'];
    if (!$isSuperAdmin) {
        
        $check = $db->prepare("SELECT id FROM events WHERE id=? AND house=?");
        $check->execute([$eid, $adminHouse]);
        if (!$check->fetch()) { redirect('events.php'); }
    }
    $db->prepare("DELETE FROM events WHERE id=?")->execute([$eid]);
    redirect('events.php');
}


if ($isSuperAdmin) {
    $events = $db->query("SELECT e.*, c.club_name FROM events e LEFT JOIN clubs c ON e.club_id=c.id ORDER BY e.created_at DESC")->fetchAll();
} else {
    $stmt = $db->prepare("SELECT e.*, c.club_name FROM events e LEFT JOIN clubs c ON e.club_id=c.id
        WHERE (e.house=? OR e.house IS NULL) ORDER BY e.created_at DESC");
    $stmt->execute([$adminHouse]);
    $events = $stmt->fetchAll();
}


if ($isSuperAdmin) {
    $clubs = $db->query("SELECT id, club_name FROM clubs WHERE is_active=1 ORDER BY club_name")->fetchAll();
} else {
    $stmt = $db->prepare("SELECT id, club_name FROM clubs WHERE is_active=1 AND (house=? OR house IS NULL) ORDER BY club_name");
    $stmt->execute([$adminHouse]);
    $clubs = $stmt->fetchAll();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Events — Admin</title>
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
        <a href="clubs.php"       class="admin-nav-item"><i class="fas fa-layer-group" style="width:18px"></i> Clubs</a>
        <a href="events.php"      class="admin-nav-item active"><i class="fas fa-calendar-alt" style="width:18px"></i> Events</a>
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
        <h1>Events &amp; Announcements
            <?php if ($adminHouse): ?>
            <span style="font-size:14px;background:<?= getHouseColor($adminHouse) ?>;color:#fff;padding:3px 12px;border-radius:10px;margin-left:8px;font-weight:700"><?= sanitize($adminHouse) ?> HOUSE</span>
            <?php endif; ?>
        </h1>
    </div>
    <div class="admin-page">
        <div>
            <?php if ($msg): ?>
            <div class="alert alert-success" style="margin-bottom:16px;background:#e8f5e9;color:#2e7d32;padding:12px;border-radius:8px;">
                <i class="fas fa-check-circle"></i> <?= sanitize($msg) ?>
            </div>
            <?php endif; ?>
            <div class="card" style="padding:0">
                <?php if (empty($events)): ?>
                <div style="text-align:center;padding:60px;color:var(--text-muted)">No events posted yet.</div>
                <?php else: ?>
                <?php foreach ($events as $ev): ?>
                <div class="event-item">
                    <div class="event-date-box">
                        <div class="event-date-day"><?= $ev['event_date'] ? date('d', strtotime($ev['event_date'])) : '—' ?></div>
                        <div class="event-date-mon"><?= $ev['event_date'] ? date('M', strtotime($ev['event_date'])) : '' ?></div>
                    </div>
                    <div style="flex:1">
                        <div style="display:flex;align-items:center;gap:8px">
                            <div class="event-title"><?= sanitize($ev['title']) ?></div>
                            <span class="event-tag tag-<?= $ev['type'] ?>"><?= ucfirst($ev['type']) ?></span>
                            <?php if ($ev['house']): ?>
                            <span style="background:<?= getHouseColor($ev['house']) ?>;color:<?= getHouseColor($ev['house'],'text') ?>;font-size:10px;font-weight:700;padding:2px 7px;border-radius:10px"><?= sanitize($ev['house']) ?></span>
                            <?php else: ?>
                            <span style="background:#e3f2fd;color:#1565c0;font-size:10px;font-weight:700;padding:2px 7px;border-radius:10px">ALL HOUSES</span>
                            <?php endif; ?>
                        </div>
                        <div class="event-meta"><?= sanitize($ev['club_name'] ?? 'General') ?><?= $ev['venue'] ? ' · ' . sanitize($ev['venue']) : '' ?></div>
                        <?php if ($ev['description']): ?>
                        <div style="font-size:13px;color:var(--text-secondary);margin-top:6px"><?= sanitize($ev['description']) ?></div>
                        <?php endif; ?>
                    </div>
                    <?php
                    
                    $canDelete = $isSuperAdmin || ($ev['house'] === $adminHouse);
                    ?>
                    <?php if ($canDelete): ?>
                    <a href="?delete=<?= $ev['id'] ?>" onclick="return confirm('Delete this event?')"
                       style="color:#c62828;text-decoration:none;font-size:18px;padding:4px 8px">
                       <i class="fas fa-trash"></i>
                    </a>
                    <?php endif; ?>
                </div>
                <?php endforeach; ?>
                <?php endif; ?>
            </div>
        </div>

        <div>
            <div class="card">
                <div class="card-title"><i class="fas fa-plus-circle" style="color:var(--admin-primary)"></i> Post Event / Announcement</div>
                <form method="POST">
                    <div class="form-group">
                        <label>Type</label>
                        <select name="type">
                            <option value="event">📅 Event</option>
                            <option value="announcement">📢 Announcement</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Title *</label>
                        <input type="text" name="title" required placeholder="Event or announcement title">
                    </div>
                    <div class="form-group">
                        <label>Description</label>
                        <textarea name="description" rows="3" placeholder="Details..."></textarea>
                    </div>
                    <div class="form-group">
                        <label>Club (optional)</label>
                        <select name="club_id">
                            <option value="">— General / All Clubs —</option>
                            <?php foreach ($clubs as $cl): ?>
                            <option value="<?= $cl['id'] ?>"><?= sanitize($cl['club_name']) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <?php if ($isSuperAdmin): ?>
                    <div class="form-group">
                        <label>For House (optional)</label>
                        <select name="house">
                            <option value="">— All Houses —</option>
                            <?php foreach (['AZUL','CAHEL','GIALLIO','ROXXO','VIERRDY'] as $h): ?>
                            <option value="<?= $h ?>"><?= $h ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <?php else: ?>
                    <div class="form-group">
                        <label>For House</label>
                        <input type="text" value="<?= sanitize($adminHouse) ?>" readonly
                            style="background:#f5f5f5;color:#555;cursor:not-allowed">
                        <input type="hidden" name="house" value="<?= sanitize($adminHouse) ?>">
                    </div>
                    <?php endif; ?>

                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px">
                        <div class="form-group"><label>Date</label><input type="date" name="event_date"></div>
                        <div class="form-group"><label>Time</label><input type="time" name="event_time"></div>
                    </div>
                    <div class="form-group">
                        <label>Venue</label>
                        <input type="text" name="venue" placeholder="e.g. AVR, Gym, Online">
                    </div>
                    <button type="submit" name="add_event" class="btn-primary">
                        <i class="fas fa-paper-plane"></i> Post
                    </button>
                </form>
            </div>
        </div>
    </div>
</main>
</body>
</html>
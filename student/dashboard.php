<?php
session_start();
require_once '../includes/config.php';
requireLogin();

$db         = getDB();
$student_id = $_SESSION['student_id'];

$stmt = $db->prepare("SELECT * FROM students WHERE student_id = ?");
$stmt->execute([$student_id]);
$student = $stmt->fetch();

if (!$student) { session_destroy(); redirect('/aclc_system/index.php'); }

$approved_count = $db->prepare("SELECT COUNT(*) FROM memberships WHERE student_id=? AND status='approved'");
$approved_count->execute([$student_id]);
$approved_count = (int)$approved_count->fetchColumn();

$pending_count = $db->prepare("SELECT COUNT(*) FROM memberships WHERE student_id=? AND status='pending'");
$pending_count->execute([$student_id]);
$pending_count = (int)$pending_count->fetchColumn();

$mem_stmt = $db->prepare("SELECT m.*, c.club_name, c.description FROM memberships m
    JOIN clubs c ON m.club_id=c.id WHERE m.student_id=? ORDER BY m.status='approved' DESC, m.applied_at DESC LIMIT 4");
$mem_stmt->execute([$student_id]);
$memberships = $mem_stmt->fetchAll();

$ev_stmt = $db->prepare("SELECT e.*, c.club_name FROM events e LEFT JOIN clubs c ON e.club_id=c.id
    WHERE (e.house=? OR e.house IS NULL)
    ORDER BY CASE WHEN e.event_date >= CURDATE() THEN 0 ELSE 1 END, ABS(DATEDIFF(e.event_date, CURDATE())) LIMIT 4");
$ev_stmt->execute([$student['house']]);
$events = $ev_stmt->fetchAll();

$ev_total = $db->prepare("SELECT COUNT(*) FROM events WHERE house=? OR house IS NULL");
$ev_total->execute([$student['house']]);
$ev_total = (int)$ev_total->fetchColumn();

$houseHex  = getHouseColor($student['house']);           
$houseTxt  = getHouseColor($student['house'], 'text');  

list($r,$g,$b) = sscanf($houseHex, "#%02x%02x%02x");

$initials = strtoupper(substr($student['first_name'],0,1) . substr($student['last_name'],0,1));
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard — <?= SCHOOL_NAME ?></title>
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
        <div class="sb-brand" >
             <div class="logo">
                <img src="../assets/aclc_logo(1).png"  style="width:40px;height:40px;object-fit:contain;">
            </div>
            <div>
                <div class="sb-title">ACLC Portal</div>
                <div class="sb-sub">Mandaue</div>
            </div>
        </div>

        <div style="padding:16px;border-bottom:1px solid var(--border)">
            <div style="display:flex;align-items:center;gap:10px">
                <div style="width:38px;height:38px;border-radius:12px;background:var(--acc);display:flex;align-items:center;justify-content:center;font-size:14px;font-weight:800;color:#fff;flex-shrink:0;box-shadow:0 3px 10px var(--acc-mid)"><?= $initials ?></div>
                <div>
                    <div style="font-size:12px;font-weight:700;color:var(--text-primary)"><?= sanitize($student['first_name']) ?> <?= sanitize($student['last_name']) ?></div>
                    <div style="font-size:10px;color:var(--text-muted);font-family:monospace"><?= sanitize($student['student_id']) ?></div>
                </div>
            </div>
            <div style="margin-top:10px">
                <span class="house-badge" style="background:var(--acc);color:<?= $houseTxt ?>"><?= sanitize($student['house']) ?> HOUSE</span>
            </div>
        </div>

        <nav class="sb-nav">
            <div class="sb-section-label">Student Menu</div>
            <a href="dashboard.php" class="sb-item active"><i class="fas fa-home"></i> Dashboard</a>
            <a href="clubs.php" class="sb-item"><i class="fas fa-users"></i> Browse Clubs</a>
            <a href="memberships.php" class="sb-item">
                <i class="fas fa-id-card"></i> My Memberships
                <?php if ($pending_count > 0): ?>
                <span class="badge-count"><?= $pending_count ?></span>
                <?php endif; ?>
            </a>
            <a href="events.php" class="sb-item"><i class="fas fa-calendar-alt"></i> Events
                <?php if ($ev_total > 0): ?><span class="badge-count"><?= $ev_total ?></span><?php endif; ?>
            </a>
            <a href="profile.php" class="sb-item"><i class="fas fa-user-cog"></i> My Profile</a>
        </nav>

        <div class="sb-foot">
            <a href="../logout.php" class="sb-logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </aside>

    <main class="main">

        <div class="topbar">
            <div class="topbar-title">Dashboard</div>
            <div class="topbar-right"><button class="theme-toggle" id="themeToggle" title="Toggle theme"><i class="fas fa-moon"></i></button>
                <span class="house-badge"><?= sanitize($student['house']) ?> HOUSE</span>
            </div>
        </div>

        <div class="page-content">

            <div class="welcome-banner">
                <div class="welcome-avatar" style="font-size:20px">👩‍🎓</div>
                <div>
                    <div class="welcome-name">Welcome back, <?= sanitize($student['first_name']) ?>! 👋</div>
                    <div class="welcome-info">
                        <?= sanitize($student['course'] ?? 'Student') ?>
                        <?php if (!empty($student['level'])): ?> · <?= sanitize($student['level']) ?><?php endif; ?>
                        · <span class="welcome-house"><?= sanitize($student['house']) ?> HOUSE</span>
                    </div>
                </div>
                <div class="welcome-right">
                    <div class="welcome-date"><?= date('D, M d Y') ?></div>
                    <div class="welcome-time" id="liveClock"></div>
                </div>
            </div>

            <div class="stats-row">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-id-card"></i></div>
                    <div>
                        <div class="stat-val"><?= $approved_count ?></div>
                        <div class="stat-label">Clubs Joined</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-clock"></i></div>
                    <div>
                        <div class="stat-val"><?= $pending_count ?></div>
                        <div class="stat-label">Pending</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-calendar-alt"></i></div>
                    <div>
                        <div class="stat-val"><?= $ev_total ?></div>
                        <div class="stat-label">Events</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-home"></i></div>
                    <div>
                        <div class="stat-val" style="font-size:16px;font-weight:800"><?= sanitize($student['house']) ?></div>
                        <div class="stat-label">Your House</div>
                    </div>
                </div>
            </div>

            <div class="grid-2col">

                <div class="card">
                    <div class="card-head">
                        <span class="card-title"><i class="fas fa-id-card"></i> My Memberships</span>
                        <a href="memberships.php" class="card-link">View all →</a>
                    </div>

                    <?php if (empty($memberships)): ?>
                    <div class="empty-state">
                        <i class="fas fa-folder-open"></i>
                        You haven't joined any clubs yet.
                    </div>
                    <?php else: ?>
                    <?php foreach ($memberships as $m): ?>
                    <div class="club-item">
                        <div class="club-icon">🎓</div>
                        <div>
                            <div class="club-name"><?= sanitize($m['club_name']) ?></div>
                            <div class="club-role">Member</div>
                        </div>
                        <span class="club-status status-<?= $m['status'] ?>"><?= ucfirst($m['status']) ?></span>
                    </div>
                    <?php endforeach; ?>
                    <?php endif; ?>

                    <a href="clubs.php" class="btn-browse" style="margin-top:14px">
                        <i class="fas fa-plus"></i> Browse &amp; Join Clubs
                    </a>
                </div>

                <div class="col-right">

                    <div class="card">
                        <div class="card-head">
                            <span class="card-title"><i class="fas fa-bolt"></i> Quick Actions</span>
                        </div>
                        <div class="actions-grid">
                            <a href="memberships.php" class="action-btn">
                                <div class="action-icon">🪪</div>
                                <span class="action-label">My Membership Card</span>
                            </a>
                            <a href="profile.php" class="action-btn">
                                <div class="action-icon">📋</div>
                                <span class="action-label">My Profile</span>
                            </a>
                            <a href="events.php" class="action-btn">
                                <div class="action-icon">📅</div>
                                <span class="action-label">Events</span>
                            </a>
                            <a href="clubs.php" class="action-btn">
                                <div class="action-icon">🔍</div>
                                <span class="action-label">Browse Clubs</span>
                            </a>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-head">
                            <span class="card-title"><i class="fas fa-calendar-alt"></i> Upcoming Events</span>
                            <a href="events.php" class="card-link">See all →</a>
                        </div>

                        <?php if (empty($events)): ?>
                        <div class="empty-state">
                            <i class="fas fa-calendar-times"></i>
                            No events yet.
                        </div>
                        <?php else: ?>
                        <?php foreach ($events as $ev): ?>
                        <div class="event-item">
                            <div class="event-dot"></div>
                            <div>
                                <div class="event-title"><?= sanitize($ev['title']) ?></div>
                                <div class="event-meta">
                                    <?= $ev['event_date'] ? date('M d', strtotime($ev['event_date'])) : 'TBA' ?>
                                    <?= $ev['venue'] ? ' · ' . sanitize($ev['venue']) : '' ?>
                                </div>
                                <span class="event-tag tag-<?= $ev['type'] ?>"><?= ucfirst($ev['type']) ?></span>
                            </div>
                        </div>
                        <?php endforeach; ?>
                        <?php endif; ?>
                    </div>

                </div>
            </div>

        </div>
    </main>
</div>

<script>

function tick() {
    const now = new Date();
    const h = String(now.getHours()).padStart(2,'0');
    const m = String(now.getMinutes()).padStart(2,'0');
    const s = String(now.getSeconds()).padStart(2,'0');
    const el = document.getElementById('liveClock');
    if (el) el.textContent = h + ':' + m + ':' + s;
}
tick();
setInterval(tick, 1000);
</script>
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
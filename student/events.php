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

$stmt = $db->prepare("SELECT e.*, c.club_name FROM events e LEFT JOIN clubs c ON e.club_id=c.id
    WHERE (e.house=? OR e.house IS NULL)
    ORDER BY CASE WHEN e.event_date >= CURDATE() THEN 0 ELSE 1 END, ABS(DATEDIFF(e.event_date, CURDATE()))");
$stmt->execute([$student['house']]);
$events = $stmt->fetchAll();

$houseHex = getHouseColor($student['house']);
list($r,$g,$b) = sscanf($houseHex, "#%02x%02x%02x");
$initials = strtoupper(substr($student['first_name'],0,1) . substr($student['last_name'],0,1));

$today    = date('Y-m-d');
$upcoming = [];
$past     = [];
foreach ($events as $ev) {
    if (!$ev['event_date'] || $ev['event_date'] >= $today) $upcoming[] = $ev;
    else $past[] = $ev;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Events — <?= SCHOOL_NAME ?></title>
<link rel="stylesheet" href="../css/portal.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=IBM+Plex+Mono:wght@400;500&display=swap" rel="stylesheet">
<style>
:root {
    --acc:       <?= $houseHex ?>;
    --acc-light: rgba(<?= $r ?>,<?= $g ?>,<?= $b ?>, 0.15);
    --acc-mid:   rgba(<?= $r ?>,<?= $g ?>,<?= $b ?>, 0.30);
    --acc-soft:  rgba(<?= $r ?>,<?= $g ?>,<?= $b ?>, 0.08);
    --bg-base:   #f5f6fa;
    --bg-card:   #ffffff;
    --border:    rgba(0,0,0,0.08);
    --border-md: rgba(0,0,0,0.13);
    --text-primary:   #1a1b22;
    --text-secondary: #3c3f52;
    --text-muted:     #6b6f85;
    --text-faint:     #9294a8;
}

/* ── DARK MODE ──────────────────────────────────────────── */
body.dark {
    --bg-base:   #0f1117;
    --bg-card:   #1a1d27;
    --border:    rgba(255,255,255,0.08);
    --border-md: rgba(255,255,255,0.12);
    --text-primary:   #e8eaf0;
    --text-secondary: #a8abbe;
    --text-muted:     #6b6f85;
    --text-faint:     #4a4e60;
    --acc-soft:  rgba(<?= $r ?>,<?= $g ?>,<?= $b ?>, 0.12);
    --acc-light: rgba(<?= $r ?>,<?= $g ?>,<?= $b ?>, 0.20);
}

/* ── TABS ───────────────────────────────────────────────── */
.ev-tabs {
    display: flex;
    gap: 8px;
    margin-bottom: 24px;
}
.ev-tab {
    display: inline-flex;
    align-items: center;
    gap: 7px;
    padding: 9px 20px;
    border-radius: 100px;
    border: 2px solid var(--border-md);
    background: var(--bg-card);
    color: var(--text-muted);
    font-size: 13px;
    font-weight: 700;
    font-family: 'IBM Plex Mono', monospace;
    cursor: pointer;
    transition: all 0.18s;
}
.ev-tab:hover { border-color: var(--acc); color: var(--acc); }
.ev-tab.active {
    background: var(--acc);
    border-color: var(--acc);
    color: #fff;
}
.ev-tab .tab-count {
    font-size: 10px;
    padding: 1px 7px;
    border-radius: 100px;
    background: rgba(255,255,255,0.25);
}
.ev-tab:not(.active) .tab-count {
    background: var(--acc-soft);
    color: var(--acc);
}

/* ── SECTION LABEL ──────────────────────────────────────── */
.section-label {
    display: flex;
    align-items: center;
    gap: 10px;
    margin: 28px 0 16px;
    font-size: 11px;
    font-weight: 700;
    font-family: 'IBM Plex Mono', monospace;
    text-transform: uppercase;
    letter-spacing: 1.4px;
    color: var(--text-muted);
}
.section-label::before, .section-label::after {
    content: ''; flex: 1; height: 1px; background: var(--border-md);
}
.section-label:first-child { margin-top: 0; }

/* ── CARD ───────────────────────────────────────────────── */
.ev-card {
    background: var(--bg-card);
    border-radius: 14px;
    border: 1px solid var(--border);
    overflow: hidden;
    margin-bottom: 14px;
    display: flex;
    transition: transform 0.18s, box-shadow 0.18s;
    cursor: pointer;
}
.ev-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 32px rgba(0,0,0,0.13);
    border-color: var(--acc-light);
}
.ev-card.past { opacity: 0.55; }

.ev-stripe { width: 5px; flex-shrink: 0; background: var(--acc); }
.ev-card.past .ev-stripe { opacity: 0.4; }

/* Date col */
.ev-date-col {
    flex-shrink: 0;
    width: 70px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 18px 6px;
    background: var(--acc-soft);
    border-right: 1px solid var(--border);
}
.ev-date-day {
    font-size: 28px;
    font-weight: 800;
    font-family: 'Syne', sans-serif;
    color: var(--acc);
    line-height: 1;
}
.ev-date-mon {
    font-size: 10px;
    font-weight: 700;
    font-family: 'IBM Plex Mono', monospace;
    color: var(--text-muted);
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-top: 3px;
}
.ev-date-tba {
    font-size: 12px;
    font-weight: 700;
    font-family: 'IBM Plex Mono', monospace;
    color: var(--text-faint);
}

/* Body */
.ev-body { flex: 1; padding: 16px 18px; min-width: 0; }
.ev-tags { display: flex; align-items: center; gap: 6px; flex-wrap: wrap; margin-bottom: 7px; }
.ev-badge {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    font-size: 9px;
    font-weight: 700;
    font-family: 'IBM Plex Mono', monospace;
    letter-spacing: 0.5px;
    text-transform: uppercase;
    padding: 3px 9px;
    border-radius: 100px;
    background: var(--acc-soft);
    color: var(--acc);
    border: 1px solid var(--acc-light);
}
.badge-house { color: #fff !important; border: none !important; }
.ev-title {
    font-size: 15px;
    font-weight: 800;
    font-family: 'Syne', sans-serif;
    color: var(--text-primary);
    letter-spacing: -0.01em;
    margin-bottom: 5px;
    line-height: 1.3;
}
.ev-meta-row { display: flex; align-items: center; flex-wrap: wrap; gap: 12px; }
.ev-meta-item {
    display: inline-flex; align-items: center; gap: 5px;
    font-size: 11px; font-family: 'IBM Plex Mono', monospace; color: var(--text-muted);
}
.ev-meta-item i { font-size: 10px; opacity: 0.7; }

/* Right col */
.ev-time-col {
    flex-shrink: 0;
    display: flex; flex-direction: column; align-items: flex-end; justify-content: center;
    padding: 16px 16px 16px 8px; gap: 8px;
}
.ev-time-chip {
    display: inline-flex; align-items: center; gap: 5px;
    font-size: 10px; font-family: 'IBM Plex Mono', monospace; font-weight: 600;
    padding: 5px 10px; border-radius: 100px;
    background: var(--acc-soft); color: var(--acc); border: 1px solid var(--acc-light);
    white-space: nowrap;
}
.ev-upcoming-dot {
    width: 8px; height: 8px; border-radius: 50%;
    background: var(--acc); box-shadow: 0 0 0 3px var(--acc-light);
    animation: pulse-dot 2s infinite;
}
@keyframes pulse-dot {
    0%,100% { box-shadow: 0 0 0 3px var(--acc-light); }
    50%      { box-shadow: 0 0 0 6px var(--acc-soft); }
}

/* Stats */
.ev-stats { display: flex; gap: 10px; margin-bottom: 20px; flex-wrap: wrap; }
.ev-stat-pill {
    display: inline-flex; align-items: center; gap: 8px;
    padding: 9px 16px; border-radius: 10px;
    background: var(--bg-card); border: 1px solid var(--border);
    font-size: 12px; font-family: 'IBM Plex Mono', monospace;
    color: var(--text-secondary); font-weight: 600;
}
.ev-stat-pill .num {
    font-size: 19px; font-weight: 800; font-family: 'Syne', sans-serif;
    color: var(--acc); line-height: 1;
}

/* Empty */
.ev-empty { text-align: center; padding: 60px 20px; color: var(--text-faint); }
.ev-empty i { font-size: 38px; opacity: 0.3; margin-bottom: 12px; display: block; }
.ev-empty p { font-size: 13px; font-family: 'IBM Plex Mono', monospace; }

/* Tab panels */
.tab-panel { display: none; }
.tab-panel.active { display: block; }

/* ── MODAL ──────────────────────────────────────────────── */
.ev-overlay {
    display: none;
    position: fixed;
    inset: 0;
    background: rgba(0,0,0,0.5);
    backdrop-filter: blur(5px);
    z-index: 2000;
    align-items: center;
    justify-content: center;
    padding: 20px;
}
.ev-overlay.open { display: flex; }

.ev-modal {
    background: var(--bg-card);
    border-radius: 16px;
    width: 540px;
    max-width: 96vw;
    max-height: 88vh;
    overflow-y: auto;
    position: relative;
    box-shadow: 0 30px 90px rgba(0,0,0,0.3);
    border: 1px solid var(--border-md);
    animation: modal-in 0.22s cubic-bezier(0.34, 1.56, 0.64, 1);
}
@keyframes modal-in {
    from { opacity: 0; transform: scale(0.92) translateY(16px); }
    to   { opacity: 1; transform: scale(1) translateY(0); }
}

.ev-modal-top {
    height: 6px;
    background: var(--acc);
    flex-shrink: 0;
}

.ev-modal-header {
    padding: 28px 28px 0;
}

.ev-modal-tags {
    display: flex; align-items: center; gap: 6px; flex-wrap: wrap; margin-bottom: 12px;
}

.ev-modal-title {
    font-size: 24px;
    font-weight: 800;
    font-family: 'Syne', sans-serif;
    color: var(--text-primary);
    letter-spacing: -0.02em;
    line-height: 1.2;
    margin-bottom: 20px;
}

.ev-modal-info {
    margin: 0 28px 20px;
    border-radius: 16px;
    background: var(--acc-soft);
    border: 1px solid var(--acc-light);
    padding: 16px 18px;
    display: flex;
    flex-direction: column;
    gap: 10px;
}
.ev-modal-info-row {
    display: flex;
    align-items: center;
    gap: 12px;
    font-size: 12px;
    font-family: 'IBM Plex Mono', monospace;
    color: var(--text-secondary);
}
.ev-modal-info-row i {
    width: 16px;
    text-align: center;
    color: var(--acc);
    font-size: 13px;
    flex-shrink: 0;
}

.ev-modal-desc {
    margin: 0 28px 28px;
    padding-top: 18px;
    border-top: 1px solid var(--border);
    font-size: 13.5px;
    color: var(--text-secondary);
    line-height: 1.8;
}

.ev-modal-close {
    position: absolute;
    top: 14px; right: 14px;
    width: 34px; height: 34px;
    background: var(--acc-soft);
    border: 1px solid var(--acc-light);
    border-radius: 16px;
    display: flex; align-items: center; justify-content: center;
    cursor: pointer;
    font-size: 13px;
    color: var(--acc);
    transition: background 0.15s;
}
.ev-modal-close:hover { background: var(--acc); color: #fff; }
</style>
</head>
<body>
<div class="dashboard-wrap">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <div class="sb-brand" style="padding:20px 16px 14px;border-bottom:1px solid var(--border)">
            <div class="logo">
                <img src="../assets/aclc_logo(1).png"  style="width:40px;height:40px;object-fit:contain;">
            </div>
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
            <a href="dashboard.php"   class="sb-item"><i class="fas fa-home"></i> Dashboard</a>
            <a href="clubs.php"       class="sb-item"><i class="fas fa-users"></i> Browse Clubs</a>
            <a href="memberships.php" class="sb-item"><i class="fas fa-id-card"></i> My Memberships</a>
            <a href="events.php"      class="sb-item active"><i class="fas fa-calendar-alt"></i> Events</a>
            <a href="profile.php"     class="sb-item"><i class="fas fa-user-cog"></i> My Profile</a>
        </nav>
        <div class="sb-foot"><a href="../logout.php" class="sb-logout"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <!-- MAIN -->
    <main class="main">
        <div class="topbar">
            <div class="topbar-title">Events &amp; Announcements</div>
            <span class="house-badge"><?= sanitize($student['house']) ?> HOUSE</span>
        </div>
        <div class="page-content">

            <?php if (empty($events)): ?>
            <div class="ev-empty">
                <i class="fas fa-calendar-times"></i>
                <p>No events or announcements yet.</p>
            </div>
            <?php else: ?>

            <!-- Stats -->
            <div class="ev-stats">
                <div class="ev-stat-pill"><span class="num"><?= count($upcoming) ?></span> Upcoming</div>
                <div class="ev-stat-pill"><span class="num"><?= count($past) ?></span> Past</div>
            </div>

            <!-- Tabs -->
            <div class="ev-tabs">
                <button class="ev-tab active" onclick="switchTab('upcoming', this)">
                    <i class="fas fa-calendar-alt"></i> Upcoming
                    <span class="tab-count"><?= count($upcoming) ?></span>
                </button>
                <button class="ev-tab" onclick="switchTab('past', this)">
                    <i class="fas fa-clock"></i> Past
                    <span class="tab-count"><?= count($past) ?></span>
                </button>
            </div>

            <!-- UPCOMING PANEL -->
            <div class="tab-panel active" id="panel-upcoming">
                <?php if (empty($upcoming)): ?>
                <div class="ev-empty">
                    <i class="fas fa-calendar-check"></i>
                    <p>No upcoming events.</p>
                </div>
                <?php else: ?>
                <?php foreach ($upcoming as $ev):
                    $houseColor = $ev['house'] ? getHouseColor($ev['house']) : '';
                    $days = $ev['event_date'] ? (int)((strtotime($ev['event_date']) - strtotime($today)) / 86400) : -1;
                    $countdown = $days === 0 ? 'Today' : ($days === 1 ? 'Tomorrow' : ($days > 0 ? "In {$days}d" : ''));
                    $dateLabel = $ev['event_date'] ? date('F d, Y', strtotime($ev['event_date'])) : '';
                    $timeLabel = $ev['event_time'] ? date('g:i A', strtotime($ev['event_time'])) : '';
                ?>
                <div class="ev-card"
                    onclick="openModal(this)"
                    data-title="<?= htmlspecialchars($ev['title'], ENT_QUOTES) ?>"
                    data-type="<?= $ev['type'] ?>"
                    data-house="<?= sanitize($ev['house'] ?? '') ?>"
                    data-housecolor="<?= $houseColor ?>"
                    data-date="<?= $dateLabel ?>"
                    data-time="<?= $timeLabel ?>"
                    data-venue="<?= htmlspecialchars($ev['venue'] ?? '', ENT_QUOTES) ?>"
                    data-club="<?= htmlspecialchars($ev['club_name'] ?? '', ENT_QUOTES) ?>"
                    data-desc="<?= htmlspecialchars($ev['description'] ?? '', ENT_QUOTES) ?>">
                    <div class="ev-stripe"></div>
                    <div class="ev-date-col">
                        <?php if ($ev['event_date']): ?>
                        <div class="ev-date-day"><?= date('d', strtotime($ev['event_date'])) ?></div>
                        <div class="ev-date-mon"><?= date('M', strtotime($ev['event_date'])) ?></div>
                        <?php else: ?>
                        <div class="ev-date-tba">TBA</div>
                        <?php endif; ?>
                    </div>
                    <div class="ev-body">
                        <div class="ev-tags">
                            <span class="ev-badge"><?= $ev['type'] === 'announcement' ? '📢' : '📅' ?> <?= ucfirst($ev['type']) ?></span>
                            <?php if ($ev['house']): ?>
                            <span class="ev-badge badge-house" style="background:<?= $houseColor ?>"><?= sanitize($ev['house']) ?></span>
                            <?php else: ?>
                            <span class="ev-badge">🌐 All Houses</span>
                            <?php endif; ?>
                        </div>
                        <div class="ev-title"><?= sanitize($ev['title']) ?></div>
                        <div class="ev-meta-row">
                            <?php if ($ev['club_name']): ?><span class="ev-meta-item"><i class="fas fa-users"></i><?= sanitize($ev['club_name']) ?></span><?php endif; ?>
                            <?php if ($ev['venue']): ?><span class="ev-meta-item"><i class="fas fa-map-marker-alt"></i><?= sanitize($ev['venue']) ?></span><?php endif; ?>
                            <?php if ($ev['event_time']): ?><span class="ev-meta-item"><i class="fas fa-clock"></i><?= $timeLabel ?></span><?php endif; ?>
                        </div>
                    </div>
                    <div class="ev-time-col">
                        <div class="ev-upcoming-dot"></div>
                        <?php if ($countdown): ?>
                        <span class="ev-time-chip"><i class="fas fa-hourglass-half" style="font-size:9px"></i><?= $countdown ?></span>
                        <?php endif; ?>
                    </div>
                </div>
                <?php endforeach; ?>
                <?php endif; ?>
            </div>

            <!-- PAST PANEL -->
            <div class="tab-panel" id="panel-past">
                <?php if (empty($past)): ?>
                <div class="ev-empty">
                    <i class="fas fa-history"></i>
                    <p>No past events.</p>
                </div>
                <?php else: ?>
                <?php foreach ($past as $ev):
                    $houseColor = $ev['house'] ? getHouseColor($ev['house']) : '';
                    $dateLabel = $ev['event_date'] ? date('F d, Y', strtotime($ev['event_date'])) : '';
                    $timeLabel = $ev['event_time'] ? date('g:i A', strtotime($ev['event_time'])) : '';
                ?>
                <div class="ev-card past"
                    onclick="openModal(this)"
                    data-title="<?= htmlspecialchars($ev['title'], ENT_QUOTES) ?>"
                    data-type="<?= $ev['type'] ?>"
                    data-house="<?= sanitize($ev['house'] ?? '') ?>"
                    data-housecolor="<?= $houseColor ?>"
                    data-date="<?= $dateLabel ?>"
                    data-time="<?= $timeLabel ?>"
                    data-venue="<?= htmlspecialchars($ev['venue'] ?? '', ENT_QUOTES) ?>"
                    data-club="<?= htmlspecialchars($ev['club_name'] ?? '', ENT_QUOTES) ?>"
                    data-desc="<?= htmlspecialchars($ev['description'] ?? '', ENT_QUOTES) ?>">
                    <div class="ev-stripe"></div>
                    <div class="ev-date-col">
                        <?php if ($ev['event_date']): ?>
                        <div class="ev-date-day"><?= date('d', strtotime($ev['event_date'])) ?></div>
                        <div class="ev-date-mon"><?= date('M', strtotime($ev['event_date'])) ?></div>
                        <?php else: ?>
                        <div class="ev-date-tba">—</div>
                        <?php endif; ?>
                    </div>
                    <div class="ev-body">
                        <div class="ev-tags">
                            <span class="ev-badge"><?= $ev['type'] === 'announcement' ? '📢' : '📅' ?> <?= ucfirst($ev['type']) ?></span>
                            <?php if ($ev['house']): ?>
                            <span class="ev-badge badge-house" style="background:<?= $houseColor ?>"><?= sanitize($ev['house']) ?></span>
                            <?php else: ?>
                            <span class="ev-badge">🌐 All Houses</span>
                            <?php endif; ?>
                        </div>
                        <div class="ev-title"><?= sanitize($ev['title']) ?></div>
                        <div class="ev-meta-row">
                            <?php if ($ev['club_name']): ?><span class="ev-meta-item"><i class="fas fa-users"></i><?= sanitize($ev['club_name']) ?></span><?php endif; ?>
                            <?php if ($ev['venue']): ?><span class="ev-meta-item"><i class="fas fa-map-marker-alt"></i><?= sanitize($ev['venue']) ?></span><?php endif; ?>
                            <?php if ($ev['event_time']): ?><span class="ev-meta-item"><i class="fas fa-clock"></i><?= $timeLabel ?></span><?php endif; ?>
                        </div>
                    </div>
                    <div class="ev-time-col">
                        <span style="font-size:9px;font-family:'IBM Plex Mono',monospace;color:var(--text-faint);font-weight:600;letter-spacing:0.5px">ENDED</span>
                    </div>
                </div>
                <?php endforeach; ?>
                <?php endif; ?>
            </div>

            <?php endif; ?>
        </div>
    </main>
</div>

<!-- ── MODAL ─────────────────────────────────────────────── -->
<div class="ev-overlay" id="evOverlay" onclick="overlayClick(event)">
    <div class="ev-modal" id="evModal">
        <div class="ev-modal-top"></div>
        <button class="ev-modal-close" onclick="closeModal()"><i class="fas fa-times"></i></button>
        <div class="ev-modal-header">
            <div class="ev-modal-tags" id="mTags"></div>
            <div class="ev-modal-title" id="mTitle"></div>
        </div>
        <div class="ev-modal-info" id="mInfo"></div>
        <div class="ev-modal-desc" id="mDesc" style="display:none"></div>
    </div>
</div>

<script>
/* ── TAB SWITCHING ─────────────────────────────────────── */
function switchTab(name, btn) {
    document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));
    document.querySelectorAll('.ev-tab').forEach(b => b.classList.remove('active'));
    document.getElementById('panel-' + name).classList.add('active');
    btn.classList.add('active');
}

/* ── MODAL ─────────────────────────────────────────────── */
function openModal(el) {
    var d = el.dataset;

    document.getElementById('mTitle').textContent = d.title;

    var tags = '<span class="ev-badge">' + (d.type === 'announcement' ? '📢' : '📅') + ' ' + d.type.charAt(0).toUpperCase() + d.type.slice(1) + '</span>';
    if (d.house) {
        tags += ' <span class="ev-badge badge-house" style="background:' + d.housecolor + '">' + d.house + '</span>';
    } else {
        tags += ' <span class="ev-badge">🌐 All Houses</span>';
    }
    document.getElementById('mTags').innerHTML = tags;

    var info = '';
    if (d.date)  info += '<div class="ev-modal-info-row"><i class="fas fa-calendar"></i><span>' + d.date + '</span></div>';
    if (d.time)  info += '<div class="ev-modal-info-row"><i class="fas fa-clock"></i><span>' + d.time + '</span></div>';
    if (d.venue) info += '<div class="ev-modal-info-row"><i class="fas fa-map-marker-alt"></i><span>' + d.venue + '</span></div>';
    if (d.club)  info += '<div class="ev-modal-info-row"><i class="fas fa-users"></i><span>' + d.club + '</span></div>';

    var infoEl = document.getElementById('mInfo');
    infoEl.innerHTML = info;
    infoEl.style.display = info ? 'flex' : 'none';

    var descEl = document.getElementById('mDesc');
    if (d.desc && d.desc.trim()) {
        descEl.textContent = d.desc;
        descEl.style.display = 'block';
    } else {
        descEl.style.display = 'none';
    }

    document.getElementById('evOverlay').classList.add('open');
    document.body.style.overflow = 'hidden';
}

function closeModal() {
    document.getElementById('evOverlay').classList.remove('open');
    document.body.style.overflow = '';
}

function overlayClick(e) {
    if (e.target === document.getElementById('evOverlay')) closeModal();
}

document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') closeModal();
});

/* ── DARK MODE ─────────────────────────────────────────── */
(function(){
    var body  = document.body;
    var saved = localStorage.getItem('aclc_theme') || 'light';
    var btn   = document.getElementById('themeToggle');

    function applyTheme(theme) {
        body.classList.toggle('dark', theme === 'dark');
        if (btn) btn.querySelector('i').className = theme === 'dark' ? 'fas fa-sun' : 'fas fa-moon';
        localStorage.setItem('aclc_theme', theme);
    }

    applyTheme(saved);
    if (btn) btn.addEventListener('click', function(){
        applyTheme(body.classList.contains('dark') ? 'light' : 'dark');
    });
})();
</script>
</body>
</html>
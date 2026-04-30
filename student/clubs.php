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

$msg   = '';
$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['join_club'])) {
    $club_id = (int)$_POST['club_id'];
    $exists = $db->prepare("SELECT id FROM memberships WHERE student_id=? AND club_id=?");
    $exists->execute([$student_id, $club_id]);
    if ($exists->fetch()) {
        $error = "You have already applied to or joined this club.";
    } else {
        $club = $db->prepare("SELECT * FROM clubs WHERE id=? AND is_active=1");
        $club->execute([$club_id]);
        $club = $club->fetch();
        if (!$club) {
            $error = "Club not found.";
        } else {
            $members = $db->prepare("SELECT COUNT(*) FROM memberships WHERE club_id=? AND status='approved'");
            $members->execute([$club_id]);
            $members = (int)$members->fetchColumn();
            if ($members >= $club['max_members']) {
                $error = "Sorry, this club is full.";
            } else {
                $db->prepare("INSERT INTO memberships (student_id, club_id, status, applied_at) VALUES (?,?,'pending',NOW())")
                   ->execute([$student_id, $club_id]);
                $msg = "Application submitted for <strong>" . htmlspecialchars($club['club_name']) . "</strong>! Waiting for admin approval.";
            }
        }
    }
}

$my_apps = $db->prepare("SELECT club_id, status FROM memberships WHERE student_id=?");
$my_apps->execute([$student_id]);
$my_map = [];
foreach ($my_apps->fetchAll() as $row) {
    $my_map[$row['club_id']] = $row['status'];
}

$houseHex = getHouseColor($student['house']);
list($r,$g,$b) = sscanf($houseHex, "#%02x%02x%02x");

$selected_house = $_GET['house'] ?? null;

$houses = [
    'giallio' => [
        'label'  => 'Giallio House',
        'color'  => '#f7f431',
        'emoji'  => '⚡',
        'motto'  => 'Excellence through discipline',
    ],
    'roxxo'   => [
        'label'  => 'Roxxo House',
        'color'  => '#fc3a3a',
        'emoji'  => '🔥',
        'motto'  => 'Passion drives greatness',
    ],
    'azul'    => [
        'label'  => 'Azul House',
        'color'  => '#3b97ff',
        'emoji'  => '🌊',
        'motto'  => 'Wisdom shapes the future',
    ],
    'cahel'   => [
        'label'  => 'Cahel House',
        'color'  => '#ff8400',
        'emoji'  => '🌿',
        'motto'  => 'Rooted in honor, grown in unity',
    ],
    'vierrdy' => [
        'label'  => 'Vierrdy House',
        'color'  => '#4cf957',
        'emoji'  => '🌱',
        'motto'  => 'Grow bold, serve well',
    ],
];

$student_house_key = strtolower(trim(str_ireplace('house', '', $student['house'])));

$is_own_house = $selected_house &&
    strtolower(trim(str_ireplace('house', '', $selected_house))) === $student_house_key;

$all_clubs_config = [
    [
        'category' => 'Sports & Fitness',
        'cat_icon' => '🏅',
        'items' => [
            [
                'key'   => 'basketball',
                'name'  => 'Basketball Club',
                'icon'  => '🏀',
                'desc'  => 'Build teamwork and discipline through drills, scrimmages, and competitive tournaments.',
                'acts'  => ['Weekly practice', 'Inter-house games', 'Fitness training', 'Tournaments'],
            ],
            [
                'key'   => 'martial',
                'name'  => 'Martial Arts Club',
                'icon'  => '🥋',
                'desc'  => 'Learn self-defense and cultural traditions through Taekwondo and Karate disciplines.',
                'acts'  => ['Technique drills', 'Belt testing', 'Self-defense class', 'Demo events'],
            ],
        ],
    ],
    [
        'category' => 'Arts & Creativity',
        'cat_icon' => '🎨',
        'items' => [
            [
                'key'   => 'theater',
                'name'  => 'Theater Guild',
                'icon'  => '🎭',
                'desc'  => 'Act, direct, or work backstage — bring stories to life through stage productions.',
                'acts'  => ['Script readings', 'Stage productions', 'Improv exercises', 'School plays'],
            ],
            [
                'key'   => 'photo',
                'name'  => 'Photography & Videography Club',
                'icon'  => '📷',
                'desc'  => 'Capture moments and tell stories through the lens — events, portraits, and short films.',
                'acts'  => ['Photo walks', 'Editing workshops', 'Photo exhibits', 'Event coverage'],
            ],
        ],
    ],
    [
        'category' => 'Academic & Professional',
        'cat_icon' => '📚',
        'items' => [
            [
                'key'   => 'debate',
                'name'  => 'Debate Society',
                'icon'  => '🎤',
                'desc'  => 'Sharpen public speaking, logical reasoning, and critical thinking through structured debate.',
                'acts'  => ['Weekly debates', 'Public speaking drills', 'Inter-school contests', 'Current events'],
            ],
            [
                'key'   => 'coding',
                'name'  => 'Computer / Girls Who Code',
                'icon'  => '💻',
                'desc'  => 'Learn programming and collaborate on tech projects — open to all, championing girls in tech.',
                'acts'  => ['Coding challenges', 'Project development', 'Hackathon prep', 'Algorithm study'],
            ],
        ],
    ],
    [
        'category' => 'Culture & Language',
        'cat_icon' => '🌏',
        'items' => [
            [
                'key'   => 'asian',
                'name'  => 'Asian Culture Club',
                'icon'  => '🏮',
                'desc'  => 'Explore the rich traditions, food, festivals, and history from across Asia.',
                'acts'  => ['Cultural fests', 'Language workshops', 'Food events', 'Heritage exhibits'],
            ],
            [
                'key'   => 'nihongo',
                'name'  => 'Nihongo Club',
                'icon'  => '⛩️',
                'desc'  => 'Learn Japanese language and immerse in its culture through anime, film, and conversation.',
                'acts'  => ['Language lessons', 'Anime screenings', 'J-culture events', 'Manga reading'],
            ],
        ],
    ],
    [
        'category' => 'Community & Leadership',
        'cat_icon' => '🤝',
        'items' => [
            [
                'key'   => 'council',
                'name'  => 'Student Council',
                'icon'  => '🏛️',
                'desc'  => 'Represent your peers, organize campus events, and develop real leadership skills.',
                'acts'  => ['School events', 'Peer representation', 'Project management', 'Campus initiatives'],
            ],
            [
                'key'   => 'env',
                'name'  => 'Environmental Action Club',
                'icon'  => '♻️',
                'desc'  => 'Promote sustainability and environmental responsibility through clean-ups and eco-projects.',
                'acts'  => ['Campus clean-ups', 'Tree planting', 'Eco campaigns', 'Sustainability talks'],
            ],
        ],
    ],
];

$all_clubs_db = [];
if ($selected_house) {
    $stmt = $db->prepare("
        SELECT c.*,
            (SELECT COUNT(*) FROM memberships m WHERE m.club_id=c.id AND m.status='approved') as member_count
        FROM clubs c
        WHERE c.is_active=1
        ORDER BY c.club_name
    ");
    $stmt->execute();
    foreach ($stmt->fetchAll() as $row) {
        $all_clubs_db[strtolower($row['club_name'])] = $row;
    }
}

function matchDbClub($key, $name, $db_clubs) {
    $name_lower = strtolower($name);

    foreach ($db_clubs as $dbname => $row) {
        if (strpos($dbname, $key) !== false) return $row;
    }

    $first_word = strtolower(explode(' ', $name)[0]);
    foreach ($db_clubs as $dbname => $row) {
        if (strpos($dbname, $first_word) !== false) return $row;
    }

    foreach (explode(' ', $name_lower) as $word) {
        if (strlen($word) < 4) continue;
        foreach ($db_clubs as $dbname => $row) {
            if (strpos($dbname, $word) !== false) return $row;
        }
    }
    return null;
}

$initials = strtoupper(substr($student['first_name'],0,1) . substr($student['last_name'],0,1));
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Browse Clubs — <?= SCHOOL_NAME ?></title>
<link rel="stylesheet" href="../css/portal.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=IBM+Plex+Mono:wght@400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
    --acc:       <?= $houseHex ?>;
    --acc-r:     <?= $r ?>;
    --acc-g:     <?= $g ?>;
    --acc-b:     <?= $b ?>;
    --acc-light: rgba(<?= $r ?>,<?= $g ?>,<?= $b ?>,0.12);
    --acc-mid:   rgba(<?= $r ?>,<?= $g ?>,<?= $b ?>,0.28);
    --acc-soft:  rgba(<?= $r ?>,<?= $g ?>,<?= $b ?>,0.06);
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

.houses-list {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.house-row-card {
    display: flex;
    align-items: center;
    gap: 0;
    background: var(--bg-card);
    border: 1px solid var(--border);
    border-radius: 14px;
    overflow: hidden;
    cursor: pointer;
    text-decoration: none;
    transition: border-color 0.18s, transform 0.18s, box-shadow 0.18s;
    position: relative;
}

.house-row-card:hover {
    transform: translateX(3px);
    box-shadow: 0 6px 24px rgba(0,0,0,0.25);
}

.house-row-card.is-own {
    border-color: var(--h-color);
}

.house-row-accent {
    width: 5px;
    align-self: stretch;
    flex-shrink: 0;
    background: var(--h-color);
    opacity: 0.85;
}

.house-row-emblem {
    width: 58px;
    height: 58px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 26px;
    flex-shrink: 0;
    margin: 0 4px 0 16px;
    border-radius: 12px;
    background: rgba(var(--h-rgb), 0.12);
    border: 1px solid rgba(var(--h-rgb), 0.2);
}

.house-row-info {
    flex: 1;
    padding: 16px 14px;
    min-width: 0;
}

.house-row-name {
    font-size: 15px;
    font-weight: 800;
    color: var(--text-primary);
    font-family: 'Syne', sans-serif;
    letter-spacing: -0.02em;
    margin-bottom: 2px;
}

.house-row-motto {
    font-size: 11px;
    color: var(--text-muted);
    font-style: italic;
    margin-bottom: 6px;
}

.house-row-meta {
    display: flex;
    align-items: center;
    gap: 8px;
}

.meta-pill {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    font-size: 10px;
    font-family: 'IBM Plex Mono', monospace;
    padding: 3px 9px;
    border-radius: 100px;
    border: 1px solid var(--border);
    color: var(--text-muted);
    background: rgba(255,255,255,0.02);
}

.meta-pill i { font-size: 8px; }

.house-row-right {
    padding: 0 20px 0 10px;
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 8px;
    flex-shrink: 0;
}

.house-status-badge {
    font-size: 10px;
    font-weight: 700;
    font-family: 'IBM Plex Mono', monospace;
    letter-spacing: 0.6px;
    padding: 5px 12px;
    border-radius: 100px;
    white-space: nowrap;
}

.badge-join {
    background: rgba(var(--h-rgb), 0.18);
    color: var(--h-color);
    border: 1px solid rgba(var(--h-rgb), 0.35);
}

.badge-view {
    background: rgba(255,255,255,0.04);
    color: var(--text-faint);
    border: 1px solid var(--border);
}

.your-house-indicator {
    display: flex;
    align-items: center;
    gap: 5px;
    font-size: 9px;
    font-weight: 700;
    font-family: 'IBM Plex Mono', monospace;
    color: var(--h-color);
    letter-spacing: 0.5px;
}

.your-house-dot {
    width: 6px; height: 6px;
    border-radius: 50%;
    background: var(--h-color);
    animation: pulse-dot 2s infinite;
}

@keyframes pulse-dot {
    0%,100% { opacity: 1; transform: scale(1); }
    50%      { opacity: 0.5; transform: scale(0.8); }
}

.house-banner {
    border-radius: 16px;
    padding: 24px 26px;
    margin-bottom: 28px;
    display: flex;
    align-items: center;
    gap: 20px;
    border: 1px solid rgba(var(--h-rgb), 0.25);
    background: linear-gradient(135deg,
        rgba(var(--h-rgb), 0.14) 0%,
        rgba(var(--h-rgb), 0.05) 60%,
        transparent 100%);
    position: relative;
    overflow: hidden;
}

.house-banner::after {
    content: attr(data-emoji);
    position: absolute;
    right: 24px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 72px;
    opacity: 0.07;
    pointer-events: none;
    line-height: 1;
}

.banner-icon {
    width: 60px; height: 60px;
    border-radius: 14px;
    background: rgba(var(--h-rgb), 0.2);
    border: 1.5px solid rgba(var(--h-rgb), 0.35);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 28px;
    flex-shrink: 0;
}

.banner-title {
    font-size: 24px;
    font-weight: 800;
    color: #fff;
    font-family: 'Syne', sans-serif;
    letter-spacing: -0.03em;
    line-height: 1.1;
}

.banner-sub {
    font-size: 11px;
    color: rgba(var(--h-rgb), 0.9);
    font-family: 'IBM Plex Mono', monospace;
    margin-top: 4px;
}

.banner-own-chip {
    margin-left: auto;
    padding: 7px 16px;
    background: rgba(var(--h-rgb), 0.18);
    border: 1px solid rgba(var(--h-rgb), 0.35);
    border-radius: 100px;
    font-size: 10px;
    font-weight: 700;
    font-family: 'IBM Plex Mono', monospace;
    letter-spacing: 0.8px;
    color: var(--h-color);
    flex-shrink: 0;
}

.locked-bar {
    display: flex;
    align-items: center;
    gap: 12px;
    background: rgba(239,68,68,0.06);
    border: 1px solid rgba(239,68,68,0.18);
    border-radius: 10px;
    padding: 12px 16px;
    margin-bottom: 24px;
    font-size: 12px;
    color: #f87171;
    font-family: 'IBM Plex Mono', monospace;
}

.locked-bar i { font-size: 13px; flex-shrink: 0; }

.category-section {
    margin-bottom: 28px;
}

.cat-label {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 11px;
    font-weight: 700;
    font-family: 'IBM Plex Mono', monospace;
    color: var(--text-muted);
    text-transform: uppercase;
    letter-spacing: 1.2px;
    margin-bottom: 12px;
    padding-bottom: 8px;
    border-bottom: 1px solid var(--border);
}

.cat-label-icon {
    font-size: 14px;
}

.cat-label-line {
    flex: 1;
    height: 1px;
    background: var(--border);
}

.cat-count {
    font-size: 9px;
    color: var(--text-faint);
    padding: 2px 7px;
    border: 1px solid var(--border);
    border-radius: 100px;
}

.clubs-row {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
    gap: 14px;
}

.club-card {
    background: var(--bg-card);
    border: 1px solid var(--border);
    border-radius: 14px;
    overflow: visible;
    transition: border-color 0.18s, transform 0.18s;
    display: flex;
    flex-direction: column;
    min-width: 0;
    width: 100%;
}

.club-card:hover {
    border-color: rgba(var(--h-rgb), 0.4);
    transform: translateY(-2px);
}

.club-card-head {
    display: flex;
    align-items: flex-start;
    gap: 12px;
    padding: 16px 16px 0;
    min-width: 0;
}

.club-icon {
    width: 44px; height: 44px;
    border-radius: 11px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    flex-shrink: 0;
    background: rgba(var(--h-rgb), 0.12);
    border: 1px solid rgba(var(--h-rgb), 0.2);
}

.club-name {
    font-size: 13px;
    font-weight: 700;
    font-family: 'Syne', sans-serif;
    color: var(--text-primary);
    letter-spacing: -0.01em;
    line-height: 1.3;
    margin-bottom: 4px;
    word-break: break-word;
}

.club-desc {
    font-size: 11px;
    color: var(--text-secondary);
    line-height: 1.6;
}

.club-acts {
    display: flex;
    flex-wrap: wrap;
    gap: 5px;
    padding: 10px 16px;
}

.act-tag {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    font-size: 10px;
    font-family: 'IBM Plex Mono', monospace;
    padding: 3px 8px;
    border-radius: 100px;
    background: rgba(255,255,255,0.03);
    border: 1px solid var(--border);
    color: var(--text-muted);
    white-space: nowrap;
}

.act-tag::before {
    content: '';
    width: 4px; height: 4px;
    border-radius: 50%;
    background: var(--h-color);
    flex-shrink: 0;
    opacity: 0.7;
}

.club-footer {
    margin-top: auto;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 8px;
    padding: 12px 14px;
    border-top: 1px solid var(--border);
    background: rgba(255,255,255,0.01);
    min-width: 0;
    flex-wrap: nowrap;
}

.cap-wrap {
    display: flex;
    flex-direction: column;
    gap: 4px;
    flex-shrink: 0;
    min-width: 0;
}

.cap-text {
    font-size: 9px;
    font-family: 'IBM Plex Mono', monospace;
    color: var(--text-faint);
    white-space: nowrap;
}

.cap-bar {
    width: 64px;
    height: 3px;
    background: rgba(255,255,255,0.07);
    border-radius: 100px;
    overflow: hidden;
}

.cap-fill {
    height: 100%;
    border-radius: 100px;
    background: var(--h-color);
}

.btn-join {
    padding: 7px 14px;
    border-radius: 8px;
    font-size: 11px;
    font-weight: 700;
    font-family: 'Syne', sans-serif;
    letter-spacing: 0.02em;
    border: none;
    cursor: pointer;
    transition: all 0.15s;
    white-space: nowrap;
    flex-shrink: 0;
    display: inline-flex;
    align-items: center;
    gap: 4px;
}

.btn-join.can {
    background: var(--h-color);
    color: #fff;
    box-shadow: 0 3px 12px rgba(var(--h-rgb), 0.35);
}

.btn-join.can:hover {
    opacity: 0.88;
    transform: translateY(-1px);
    box-shadow: 0 5px 18px rgba(var(--h-rgb), 0.45);
}

.btn-join.member  { background: rgba(74,222,128,0.1);  color: #4ade80; border: 1px solid rgba(74,222,128,0.2);  cursor: default; }
.btn-join.pending { background: rgba(251,191,36,0.1);  color: #fbbf24; border: 1px solid rgba(251,191,36,0.2);  cursor: default; }
.btn-join.locked  { background: transparent; color: var(--text-faint); border: 1px solid var(--border); cursor: not-allowed; }
.btn-join.full    { background: rgba(255,255,255,0.04); color: var(--text-faint); border: 1px solid var(--border); cursor: not-allowed; }
.btn-join.reapply { background: rgba(var(--h-rgb), 0.12); color: var(--h-color); border: 1px solid rgba(var(--h-rgb), 0.25); }
.btn-join.reapply:hover { background: rgba(var(--h-rgb), 0.2); }

.page-intro {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    gap: 12px;
    margin-bottom: 22px;
    flex-wrap: wrap;
}

.page-intro h2 {
    font-size: 20px;
    font-weight: 800;
    color: var(--text-primary);
    font-family: 'Syne', sans-serif;
    letter-spacing: -0.025em;
}

.page-intro p {
    font-size: 11px;
    color: var(--text-muted);
    font-family: 'IBM Plex Mono', monospace;
    margin-top: 4px;
}

.clubs-topbar-back {
    display: inline-flex;
    align-items: center;
    gap: 7px;
    padding: 7px 14px;
    background: rgba(255,255,255,0.04);
    border: 1px solid var(--border-md);
    border-radius: 8px;
    color: var(--text-secondary);
    font-size: 11px;
    font-weight: 600;
    font-family: 'Syne', sans-serif;
    text-decoration: none;
    cursor: pointer;
    transition: all 0.15s;
    margin-bottom: 18px;
}

.clubs-topbar-back:hover {
    background: rgba(255,255,255,0.07);
    color: var(--text-primary);
}
</style>
</head>
<body>
<div class="dashboard-wrap">

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
            <a href="clubs.php"       class="sb-item active"><i class="fas fa-users"></i> Browse Clubs</a>
            <a href="memberships.php" class="sb-item"><i class="fas fa-id-card"></i> My Memberships</a>
            <a href="events.php"      class="sb-item"><i class="fas fa-calendar-alt"></i> Events</a>
            <a href="profile.php"     class="sb-item"><i class="fas fa-user-cog"></i> My Profile</a>
        </nav>
        <div class="sb-foot"><a href="../logout.php" class="sb-logout"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <main class="main">

        <div class="topbar">
            <div style="display:flex;align-items:center;gap:10px">
                <?php if ($selected_house): ?>
                <a href="clubs.php" style="display:flex;align-items:center;justify-content:center;width:28px;height:28px;border-radius:12px;background:rgba(255,255,255,0.04);border:1px solid var(--border-md);color:var(--text-muted);text-decoration:none;font-size:12px;transition:all 0.15s" onmouseover="this.style.background='rgba(255,255,255,0.08)'" onmouseout="this.style.background='rgba(255,255,255,0.04)'">
                    <i class="fas fa-arrow-left"></i>
                </a>
                <?php endif; ?>
                <div>
                    <div class="topbar-title">
                        <?= $selected_house
                            ? htmlspecialchars($houses[strtolower(trim(str_ireplace('house','',$selected_house)))] ['label'] ?? ucfirst($selected_house).' House') . ' — Clubs'
                            : 'Browse Clubs' ?>
                    </div>
                </div>
            </div>
            <span class="house-badge"><?= sanitize($student['house']) ?> HOUSE</span>
        </div>

        <div class="page-content">

            <?php if ($msg): ?>
            <div class="alert alert-success" style="margin-bottom:20px"><i class="fas fa-check-circle"></i> <?= $msg ?></div>
            <?php endif; ?>
            <?php if ($error): ?>
            <div class="alert alert-error" style="margin-bottom:20px"><i class="fas fa-exclamation-circle"></i> <?= sanitize($error) ?></div>
            <?php endif; ?>

            <?php if (!$selected_house): ?>
            
            <div class="page-intro">
                <div>
                    <h2>Select a House</h2>
                    <p>Join clubs from your own house</p>
                </div>
            </div>

            <div class="houses-list">
                <?php foreach ($houses as $key => $house):
                    $is_own = $student_house_key === $key;
                    list($hr,$hg,$hb) = sscanf($house['color'], "#%02x%02x%02x");

                    $cnt = $db->prepare("SELECT COUNT(*) FROM clubs WHERE is_active=1 AND LOWER(REPLACE(REPLACE(house,' HOUSE',''),' house',''))=?");
                    $cnt->execute([$key]);
                    $club_count = (int)$cnt->fetchColumn();
                    if ($club_count === 0) $club_count = 10; // fallback show 10
                ?>
                <a href="clubs.php?house=<?= $key ?>"
                   class="house-row-card <?= $is_own ? 'is-own' : '' ?>"
                   style="--h-color:<?= $house['color'] ?>;--h-rgb:<?= $hr ?>,<?= $hg ?>,<?= $hb ?>">

                    <div class="house-row-accent"></div>

                    <div class="house-row-emblem" style="--h-rgb:<?= $hr ?>,<?= $hg ?>,<?= $hb ?>">
                        <?= $house['emoji'] ?>
                    </div>

                    <div class="house-row-info">
                        <div class="house-row-name"><?= $house['label'] ?></div>
                        <div class="house-row-motto">"<?= $house['motto'] ?>"</div>
                        <div class="house-row-meta">
                            <span class="meta-pill"><i class="fas fa-users"></i><?= $club_count ?> clubs available</span>
                            <?php if ($is_own): ?>
                            <span class="meta-pill" style="color:<?= $house['color'] ?>;border-color:rgba(<?= $hr ?>,<?= $hg ?>,<?= $hb ?>,0.3)">
                                <i class="fas fa-check"></i> Enrolled
                            </span>
                            <?php endif; ?>
                        </div>
                    </div>

                    <div class="house-row-right">
                        <?php if ($is_own): ?>
                        <div class="your-house-indicator">
                            <div class="your-house-dot" style="background:<?= $house['color'] ?>"></div>
                            YOUR HOUSE
                        </div>
                        <?php endif; ?>
                        <span class="house-status-badge <?= $is_own ? 'badge-join' : 'badge-view' ?>"
                              style="<?= $is_own ? "--h-color:{$house['color']};--h-rgb:{$hr},{$hg},{$hb}" : '' ?>">
                            <?= $is_own ? '✦ CAN JOIN' : '⊘ VIEW ONLY' ?>
                        </span>
                    </div>
                </a>
                <?php endforeach; ?>
            </div>

            <?php else:

            $bare_key = strtolower(trim(str_ireplace('house', '', $selected_house)));
            $h        = $houses[$bare_key] ?? null;
            $h_color  = $h ? $h['color'] : '#888';
            list($hr,$hg,$hb) = sscanf($h_color, "#%02x%02x%02x");
            ?>

            <a href="clubs.php" class="clubs-topbar-back">
                <i class="fas fa-arrow-left" style="font-size:10px"></i> All Houses
            </a>

            <div class="house-banner"
                 style="--h-color:<?= $h_color ?>;--h-rgb:<?= $hr ?>,<?= $hg ?>,<?= $hb ?>"
                 data-emoji="<?= $h ? $h['emoji'] : '🏠' ?>">
                <div class="banner-icon"><?= $h ? $h['emoji'] : '🏠' ?></div>
                <div>
                    <div class="banner-title"><?= $h ? $h['label'] : ucfirst($selected_house).' House' ?></div>
                    <div class="banner-sub">
                        <?= $is_own_house
                            ? '✓ Your house — you can apply to any club below'
                            : '⊘ Not your house — browse only, joining is disabled' ?>
                        
                    </div>
                </div>
                <?php if ($is_own_house): ?>
                <div class="banner-own-chip">✦ YOUR HOUSE</div>
                <?php endif; ?>
            </div>

            <?php if (!$is_own_house): ?>
            <div class="locked-bar">
                <i class="fas fa-lock"></i>
                <span>
                    You're browsing <strong><?= $h ? $h['label'] : ucfirst($selected_house).' House' ?></strong>.
                    Joining is only available from your own house
                    (<strong><?= sanitize($student['house']) ?></strong>).
                    <a href="clubs.php?house=<?= $student_house_key ?>" style="color:#f87171;text-decoration:underline;margin-left:5px">Browse your house →</a>
                </span>
            </div>
            <?php endif; ?>

            <?php foreach ($all_clubs_config as $cat): ?>
            <div class="category-section">

                <div class="cat-label">
                    <span class="cat-label-icon"><?= $cat['cat_icon'] ?></span>
                    <span><?= $cat['category'] ?></span>
                    <div class="cat-label-line"></div>
                    <span class="cat-count"><?= count($cat['items']) ?> clubs</span>
                </div>

                <div class="clubs-row">
                    <?php foreach ($cat['items'] as $club_cfg):
                        // Try to match a real DB row
                        $db_row    = matchDbClub($club_cfg['key'], $club_cfg['name'], $all_clubs_db);
                        $club_id   = $db_row ? $db_row['id'] : null;
                        $max_m     = $db_row ? (int)$db_row['max_members']  : 30;
                        $cur_m     = $db_row ? (int)$db_row['member_count'] : 0;
                        $pct       = $max_m > 0 ? min(100, round($cur_m / $max_m * 100)) : 0;
                        $status    = $club_id ? ($my_map[$club_id] ?? null) : null;
                        $is_full   = $cur_m >= $max_m;
                        $desc      = ($db_row && !empty($db_row['description'])) ? $db_row['description'] : $club_cfg['desc'];
                    ?>
                    <div class="club-card" style="--h-color:<?= $h_color ?>;--h-rgb:<?= $hr ?>,<?= $hg ?>,<?= $hb ?>">

                        <div class="club-card-head">
                            <div class="club-icon"><?= $club_cfg['icon'] ?></div>
                            <div style="flex:1;min-width:0">
                                <div class="club-name"><?= htmlspecialchars($club_cfg['name']) ?></div>
                                <div class="club-desc"><?= htmlspecialchars($desc) ?></div>
                            </div>
                        </div>

                        <div class="club-acts">
                            <?php foreach ($club_cfg['acts'] as $act): ?>
                            <span class="act-tag"><?= htmlspecialchars($act) ?></span>
                            <?php endforeach; ?>
                        </div>

                        <div class="club-footer">
                            <div class="cap-wrap">
                                <div class="cap-text"><?= $cur_m ?>/<?= $max_m ?> members</div>
                                <div class="cap-bar">
                                    <div class="cap-fill" style="width:<?= $pct ?>%"></div>
                                </div>
                            </div>

                            <?php if ($status === 'approved'): ?>
                                <button class="btn-join member" disabled>✓ Member</button>

                            <?php elseif ($status === 'pending'): ?>
                                <button class="btn-join pending" disabled>⏳ Pending</button>

                            <?php elseif (!$is_own_house): ?>
                                <button class="btn-join locked" disabled>
                                    <i class="fas fa-lock" style="font-size:9px;margin-right:4px"></i>Locked
                                </button>

                            <?php elseif ($is_full): ?>
                                <button class="btn-join full" disabled>Club Full</button>

                            <?php elseif ($club_id): ?>
                                <form method="POST" style="margin:0">
                                    <input type="hidden" name="club_id" value="<?= $club_id ?>">
                                    <button type="submit" name="join_club" class="btn-join <?= $status === 'rejected' ? 'reapply' : 'can' ?>">
                                        <?= $status === 'rejected' ? '↩ Re-Apply' : '+ Join Club' ?>
                                    </button>
                                </form>

                            <?php else: ?>
                                <button class="btn-join full" disabled>Unavailable</button>
                            <?php endif; ?>
                        </div>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php endforeach; ?>

            <?php endif; ?>
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
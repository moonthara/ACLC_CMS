<?php
session_start();
require_once '../includes/config.php';
requireLogin();

$db = getDB();
$student_id = $_SESSION['student_id'];
$stmt = $db->prepare("SELECT * FROM students WHERE student_id = ?");
$stmt->execute([$student_id]);
$student = $stmt->fetch();
if (!$student) { session_destroy(); redirect('/aclc_system/index.php'); }

$stmt = $db->prepare("SELECT m.*, c.club_name, c.description, c.house as club_house,
    mc.card_number, mc.issued_at
    FROM memberships m 
    JOIN clubs c ON m.club_id = c.id
    LEFT JOIN membership_cards mc ON mc.student_id=m.student_id AND mc.club_id=m.club_id
    WHERE m.student_id = ? ORDER BY m.status='approved' DESC, m.applied_at DESC");
$stmt->execute([$student_id]);
$memberships = $stmt->fetchAll();

// ➕ Calculate stats for overview
$active = array_filter($memberships, fn($m) => $m['status'] === 'approved');
$pending = array_filter($memberships, fn($m) => $m['status'] === 'pending');
$rejected = array_filter($memberships, fn($m) => $m['status'] === 'rejected');

$houseHex  = getHouseColor($student['house']);
$houseTxt  = getHouseColor($student['house'], 'text');
list($r,$g,$b) = sscanf($houseHex, "#%02x%02x%02x");
$initials  = strtoupper(substr($student['first_name'],0,1) . substr($student['last_name'],0,1));
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Memberships — <?= SCHOOL_NAME ?></title>
<link rel="stylesheet" href="../css/portal.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
    --acc:       <?= $houseHex ?>;
    --acc-light: rgba(<?= $r ?>,<?= $g ?>,<?= $b ?>, 0.12);
    --acc-mid:   rgba(<?= $r ?>,<?= $g ?>,<?= $b ?>, 0.25);
    --acc-soft:  rgba(<?= $r ?>,<?= $g ?>,<?= $b ?>, 0.06);
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
/* Override stat icon colors for pending/rejected */
.stat-icon.pending { background:rgba(245,158,11,0.15); color:#fbbf24; border-color:rgba(245,158,11,0.3); }
.stat-icon.rejected { background:rgba(239,68,68,0.15); color:#f87171; border-color:rgba(239,68,68,0.3); }
.stat-val.pending { color:#fbbf24; }
.stat-val.rejected { color:#f87171; }
</style>
</head>
<body>
<div class="dashboard-wrap">
<!-- SIDEBAR (unchanged) -->
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
        <div style="margin-top:10px"><span class="house-badge" style="background:var(--acc);color:<?= $houseTxt ?>"><?= sanitize($student['house']) ?> HOUSE</span></div>
    </div>
    <nav class="sb-nav">
        <div class="sb-section-label">Student Menu</div>
        <a href="dashboard.php" class="sb-item"><i class="fas fa-home"></i> Dashboard</a>
        <a href="clubs.php" class="sb-item"><i class="fas fa-users"></i> Browse Clubs</a>
        <a href="memberships.php" class="sb-item active"><i class="fas fa-id-card"></i> My Memberships</a>
        <a href="events.php" class="sb-item"><i class="fas fa-calendar-alt"></i> Events</a>
        <a href="profile.php" class="sb-item"><i class="fas fa-user-cog"></i> My Profile</a>
    </nav>
    <div class="sb-foot"><a href="../logout.php" class="sb-logout"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
</aside>

<main class="main">
    <div class="topbar">
        <div class="topbar-title">My Memberships</div>
        <span class="house-badge"><?= sanitize($student['house']) ?> HOUSE</span>
    </div>
    
    <div class="page-content">
        <!-- ➕ STATS OVERVIEW (uses CSS classes) -->
        <div class="stats-row">
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-check-circle"></i></div>
                <div>
                    <div class="stat-val"><?= count($active) ?></div>
                    <div class="stat-label">Active</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon pending"><i class="fas fa-clock"></i></div>
                <div>
                    <div class="stat-val pending"><?= count($pending) ?></div>
                    <div class="stat-label">Pending</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon rejected"><i class="fas fa-times-circle"></i></div>
                <div>
                    <div class="stat-val rejected"><?= count($rejected) ?></div>
                    <div class="stat-label">Rejected</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-award"></i></div>
                <div>
                    <div class="stat-val"><?= count($memberships) ?></div>
                    <div class="stat-label">Total</div>
                </div>
            </div>
        </div>

        <?php if (empty($memberships)): ?>
        <!-- ➕ ENHANCED EMPTY STATE (uses CSS) -->
        <div class="card empty-state">
            <i class="fas fa-id-card"></i>
            <h3 style="margin:0 0 8px;color:var(--text-primary)">No memberships yet</h3>
            <p style="margin-bottom:20px;color:var(--text-muted)">Join a club to unlock events, perks, and your digital card!</p>
            <a href="clubs.php" class="btn-join" style="width:auto;padding:10px 24px;display:inline-flex;align-items:center;gap:8px">
                <i class="fas fa-search"></i> Browse Clubs
            </a>
        </div>
        <?php else: ?>
        
        <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(320px,1fr));gap:20px;">
        <?php foreach ($memberships as $m): 
            $cardColor = $m['club_house'] ? getHouseColor($m['club_house']) : $houseHex;
            $cardNum = $m['card_number'] ?? 'CARD-' . strtoupper(substr(md5($student_id.$m['club_id']),0,8));
        ?>
        <div class="card">
            <!-- Header -->
            <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px">
                <div>
                    <div style="font-size:16px;font-weight:800;color:var(--text-primary)"><?= sanitize($m['club_name']) ?></div>
                    <div style="font-size:11px;color:var(--text-muted);margin-top:3px;font-family:'IBM Plex Mono',monospace">
                        Applied: <?= date('M d, Y', strtotime($m['applied_at'])) ?>
                    </div>
                </div>
                <!-- ✅ Uses CSS class for status badge -->
                <span class="membership-status status-<?= $m['status'] ?>"><?= ucfirst($m['status']) ?></span>
            </div>

            <?php if ($m['status'] === 'approved'): ?>
                <!-- ✅ APPROVED: Digital Card (styled with inline gradient + CSS) -->
                <div style="background:linear-gradient(135deg,<?= $cardColor ?>dd,<?= $cardColor ?>88);color:white;border-radius:12px;padding:20px;margin-bottom:12px;position:relative;overflow:hidden">
                    <div style="position:absolute;top:-20px;right:-20px;width:80px;height:80px;border-radius:50%;background:rgba(255,255,255,0.08)"></div>
                    <div style="font-size:9px;opacity:0.75;letter-spacing:1.2px;text-transform:uppercase;margin-bottom:2px"><?= SCHOOL_NAME ?></div>
                    <div style="font-size:10px;opacity:0.65;margin-bottom:14px">Club Membership Card</div>
                    <div style="font-size:17px;font-weight:800;margin-bottom:2px"><?= sanitize($student['last_name']) ?>, <?= sanitize($student['first_name']) ?></div>
                    <div style="font-family:'IBM Plex Mono',monospace;font-size:12px;opacity:0.8"><?= sanitize($student['student_id']) ?></div>
                    <div style="border-top:1px solid rgba(255,255,255,0.2);margin-top:14px;padding-top:10px">
                        <div style="font-size:13px;font-weight:700"><?= sanitize($m['club_name']) ?></div>
                        <?php if ($m['club_house']): ?><div style="font-size:11px;opacity:0.75"><?= sanitize($m['club_house']) ?> House</div><?php endif; ?>
                    </div>
                    <div style="display:flex;justify-content:space-between;align-items:center;margin-top:10px">
                        <div style="font-size:10px;font-family:'IBM Plex Mono',monospace;opacity:0.65"><?= $cardNum ?></div>
                        <div style="font-size:10px;opacity:0.65"><?= $m['issued_at'] ? date('Y', strtotime($m['issued_at'])) : date('Y') ?></div>
                    </div>
                </div>
              

            <?php elseif ($m['status'] === 'pending'): ?>
                <!-- ⏳ PENDING: Enhanced with CSS-friendly styling -->
                <div style="background:rgba(215, 244, 86, 0.07);border:1px dashed rgba(245,158,11,0.3);border-radius:12px;padding:16px;text-align:center">
                    <i class="fas fa-hourglass-half" style="font-size:24px;color:#fbbf24;margin-bottom:8px"></i>
                    <div style="font-size:13px;color:#fbbf24;margin-bottom:6px">Application under review</div>
                    <div style="font-size:11px;color:var(--text-muted);font-family:'IBM Plex Mono',monospace">
                        Submitted: <?= date('M d, Y', strtotime($m['applied_at'])) ?>
                    </div>
                    <div style="font-size:10px;opacity:0.7;margin-top:10px;font-style:italic">✨ Card will appear here once approved!</div>
                </div>
                <!-- Disabled button (uses CSS) -->
                <button class="btn-join btn-disabled" style="margin-top:8px" disabled>
                    <i class="fas fa-lock"></i> View Card (after approval)
                </button>

            <?php elseif ($m['status'] === 'rejected'): ?>
                <!-- ❌ REJECTED: Styled with CSS-friendly approach -->
                <div style="background:rgba(239,68,68,0.07);border:1px solid rgba(239,68,68,0.2);border-radius:12px;padding:16px">
                    <div style="color:#f87171;font-size:13px;margin-bottom:6px">
                        <i class="fas fa-exclamation-triangle"></i> Application not approved
                    </div>
                    <?php if (!empty($m['notes'])): ?>
                        <div style="font-size:11px;opacity:0.85"><strong>Reason:</strong> <?= sanitize($m['notes']) ?></div>
                    <?php endif; ?>
                </div>
                <!-- Reapply button (uses CSS) -->
                <a href="clubs.php?club=<?= $m['club_id'] ?>&reapply=1" class="btn-join" style="margin-top:8px">
                    <i class="fas fa-redo"></i> Reapply
                </a>
            <?php endif; ?>
        </div>
        <?php endforeach; ?>
        </div>
        <?php endif; ?>
    </div>
</main>
</div>

<!-- Optional: Simple JS for interactions -->
<script>
// Basic interactivity (can be expanded later)
document.querySelectorAll('.btn-join:not(.btn-disabled):not([disabled])').forEach(btn => {
    btn.addEventListener('click', function(e) {
        if(!this.onclick) {
            e.preventDefault();
            // Default fallback if no onclick defined
        }
    });
});
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
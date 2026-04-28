<?php
session_start();
require_once 'includes/config.php';

if (isset($_GET['reset'])) {
    unset($_SESSION['login_pending_id'], $_SESSION['login_pending_name'],
          $_SESSION['login_pending_house'], $_SESSION['login_is_new']);
    header("Location: index.php"); exit;
}

if (isset($_SESSION['student_id'])) { header("Location: student/dashboard.php"); exit; }
if (isset($_SESSION['admin_id']))   { header("Location: admin/dashboard.php");   exit; }

$error = '';
$step  = 1;

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'find') {
    $p1 = strtoupper(trim($_POST['p1'] ?? ''));
    $p2 = strtoupper(trim($_POST['p2'] ?? ''));
    $p3 = strtoupper(trim($_POST['p3'] ?? ''));
    $p4 = strtoupper(trim($_POST['p4'] ?? ''));
    $student_id = "$p1-$p2-$p3-$p4";

    if (empty($p1) || empty($p2) || empty($p3) || empty($p4)) {
        $error = 'Please fill in all parts of your Student ID.';
    } else {
        $db   = getDB();
        $stmt = $db->prepare("SELECT student_id, first_name, last_name, house, password FROM students WHERE student_id = ?");
        $stmt->execute([$student_id]);
        $found = $stmt->fetch();

        if (!$found) {
            $error = "Student ID <strong>" . sanitize($student_id) . "</strong> was not found. Please check your ID or contact your instructor.";
        } else {
            $_SESSION['login_pending_id']    = $found['student_id'];
            $_SESSION['login_pending_name']  = $found['last_name'] . ', ' . $found['first_name'];
            $_SESSION['login_pending_house'] = $found['house'];
            $_SESSION['login_is_new']        = empty($found['password']);
            $step = 2;
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'create_password') {
    $sid     = $_SESSION['login_pending_id'] ?? '';
    $pass    = $_POST['password'] ?? '';
    $confirm = $_POST['confirm_password'] ?? '';

    if (empty($sid)) { header("Location: index.php"); exit; }

    if (strlen($pass) < 6) {
        $error = 'Password must be at least 6 characters.';
        $step  = 2;
    } elseif ($pass !== $confirm) {
        $error = 'Passwords do not match.';
        $step  = 2;
    } else {
        $db = getDB();
        $db->prepare("UPDATE students SET password = ? WHERE student_id = ?")
           ->execute([password_hash($pass, PASSWORD_DEFAULT), $sid]);
        $stmt = $db->prepare("SELECT * FROM students WHERE student_id = ?");
        $stmt->execute([$sid]);
        $user = $stmt->fetch();
        unset($_SESSION['login_pending_id'], $_SESSION['login_pending_name'],
              $_SESSION['login_pending_house'], $_SESSION['login_is_new']);
        $_SESSION['student_id']    = $user['student_id'];
        $_SESSION['student_name']  = $user['first_name'] . ' ' . $user['last_name'];
        $_SESSION['student_house'] = $user['house'] ?? '';
        header("Location: student/dashboard.php"); exit;
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'login') {
    $sid      = $_SESSION['login_pending_id'] ?? '';
    $password = $_POST['password'] ?? '';

    if (empty($sid)) { header("Location: index.php"); exit; }

    $db   = getDB();
    $stmt = $db->prepare("SELECT * FROM students WHERE student_id = ?");
    $stmt->execute([$sid]);
    $user = $stmt->fetch();

    if ($user && password_verify($password, $user['password'])) {
        unset($_SESSION['login_pending_id'], $_SESSION['login_pending_name'],
              $_SESSION['login_pending_house'], $_SESSION['login_is_new']);
        $_SESSION['student_id']    = $user['student_id'];
        $_SESSION['student_name']  = $user['first_name'] . ' ' . $user['last_name'];
        $_SESSION['student_house'] = $user['house'] ?? '';
        header("Location: student/dashboard.php"); exit;
    } else {
        $error = "Incorrect password. Please try again.";
        $step  = 2;
    }
}

if ($step === 1 && isset($_SESSION['login_pending_id'])) { $step = 2; }

$pending_id    = $_SESSION['login_pending_id']    ?? '';
$pending_name  = $_SESSION['login_pending_name']  ?? '';
$pending_house = $_SESSION['login_pending_house'] ?? '';
$is_new        = $_SESSION['login_is_new']        ?? false;
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Login — ACLC Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:wght@400;600;700;800&family=Barlow:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
    /* ─── RESET ─────────────────────────────────────────── */
    *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

    /* ─── ROOT VARS ──────────────────────────────────────── */
    :root {
        --accent:   #e01a22;
        --accent2:  #ff4d54;
        --bg:       #0e0e10;
        --card-bg:  rgba(255,255,255,0.04);
        --border:   rgba(66, 14, 14, 0.1);
        --text:     #f0f0f2;
        --muted:    rgba(255,255,255,0.38);
        --field-bg: rgba(255,255,255,0.055);
    }

    /* ─── BODY / BACKGROUND ──────────────────────────────── */
    body {
        font-family: 'Barlow', sans-serif;
        background-color: var(--bg);
        color: var(--text);
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        overflow-x: hidden;
        position: relative;
    }

  
    .bg-layer {
        position: fixed;
        inset: 0;
        z-index: 0;
        background-image: url('assets/school.webp');
        filter: blur(5px);
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        /* Dark overlay so text stays legible on any photo */
        filter: brightness(0.38) saturate(0.7);
    }

    /* Extra vignette / gradient on top of photo */
    .bg-layer::after {
        content: '';
        position: absolute;
        inset: 0;
        background:
            radial-gradient(ellipse 80% 60% at 50% 110%, rgba(224,26,34,0.18) 0%, transparent 65%),
            linear-gradient(to bottom, rgba(14,14,16,0.55) 0%, rgba(14,14,16,0.25) 45%, rgba(14,14,16,0.75) 100%);
    }

    /* ─── TOP NAV ────────────────────────────────────────── */
    .top-nav {
        position: relative;
        z-index: 10;
        display: flex;
        align-items: center;
        gap: 11px;
        padding: 13px 28px;
        background: rgba(10,10,12,0.55);
        backdrop-filter: blur(18px);
        border-bottom: 1px solid rgba(255,255,255,0.06);
    }

    .nav-logo {
        width: 36px; height: 36px;
        border-radius: 8px;
        background: rgba(255,255,255,0.05);
        border: 1px solid rgba(255,255,255,0.09);
        display: flex; align-items: center; justify-content: center;
        overflow: hidden; padding: 4px; flex-shrink: 0;
    }

    .nav-school  { font-family: 'Barlow Condensed', sans-serif; font-size: 15px; font-weight: 700; letter-spacing: 0.02em; }
    .nav-system  { font-size: 9px; color: var(--muted); letter-spacing: 0.12em; text-transform: uppercase; margin-top: 1px; }

    /* ─── PAGE WRAPPER ───────────────────────────────────── */
    .page {
        position: relative;
        z-index: 1;
        flex: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 48px 16px 64px;
    }

    /* ─── SHIELD ICON ────────────────────────────────────── */
    .shield-icon {
        font-size: 38px;
        color: var(--text);
        margin-bottom: 14px;
        opacity: 0.88;
        animation: floatIcon 3.6s ease-in-out infinite;
    }
    @keyframes floatIcon {
        0%, 100% { transform: translateY(0);    }
        50%       { transform: translateY(-5px); }
    }

    /* ─── HEADING ────────────────────────────────────────── */
    .page-title {
        font-family: 'Barlow Condensed', sans-serif;
        font-size: 42px;
        font-weight: 800;
        letter-spacing: 0.12em;
        text-transform: uppercase;
        text-align: center;
        margin-bottom: 6px;
        line-height: 1;
    }

    .page-sub {
        font-size: 10px;
        letter-spacing: 0.18em;
        text-transform: uppercase;
        color: var(--muted);
        text-align: center;
        margin-bottom: 30px;
    }

    /* ─── STEP INDICATORS ────────────────────────────────── */
    .steps {
        display: flex;
        align-items: center;
        margin-bottom: 24px;
        gap: 0;
    }

    .step-dot {
        width: 30px; height: 30px;
        border-radius: 50%;
        border: 1px solid var(--border);
        background: rgba(255,255,255,0.03);
        display: flex; align-items: center; justify-content: center;
        font-size: 11px; font-weight: 700;
        color: var(--muted);
        font-family: 'Barlow Condensed', sans-serif;
        letter-spacing: 0.04em;
        transition: all 0.3s;
    }
    .step-dot.active {
        border-color: var(--accent);
        background: rgba(224,26,34,0.18);
        color: var(--text);
        box-shadow: 0 0 0 3px rgba(224,26,34,0.12);
    }
    .step-dot.done {
        border-color: rgba(224,26,34,0.45);
        background: rgba(224,26,34,0.12);
        color: var(--accent2);
    }
    .step-line {
        width: 56px; height: 1px;
        background: rgba(255,255,255,0.07);
        transition: background 0.3s;
    }
    .step-line.done { background: rgba(224,26,34,0.35); }

    /* ─── ALERT ──────────────────────────────────────────── */
    .alert {
        display: flex; align-items: flex-start; gap: 10px;
        background: rgba(224,26,34,0.07);
        border: 1px solid rgba(224,26,34,0.22);
        border-radius: 8px;
        padding: 11px 14px;
        font-size: 12px;
        color: #ff7070;
        line-height: 1.6;
        max-width: 420px;
        width: 100%;
        margin-bottom: 16px;
        letter-spacing: 0.01em;
    }
    .alert i { margin-top: 1px; flex-shrink: 0; }

    /* ─── CARD ───────────────────────────────────────────── */
    .card {
        background: var(--card-bg);
        backdrop-filter: blur(22px);
        border: 1px solid var(--border);
        border-radius: 12px;              /* sharp corner, reference-image style */
        padding: 32px 30px 28px;
        width: 100%;
        max-width: 420px;
        position: relative;
    }

    /* thin top accent line */
    .card::before {
        content: '';
        position: absolute;
        top: 0; left: 0; right: 0;
        height: 2px;
        background: linear-gradient(90deg, transparent, var(--accent), transparent);
        border-radius: 18px 18px 0 0;
    }

    /* ─── FIELD LABEL ────────────────────────────────────── */
    .field-label {
        font-size: 9px;
        font-weight: 700;
        letter-spacing: 0.16em;
        text-transform: uppercase;
        color: var(--muted);
        margin-bottom: 7px;
        display: flex;
        align-items: center;
        gap: 5px;
    }
    .field-label .req { color: var(--accent); }

    /* ─── ID FORMAT HINT ─────────────────────────────────── */
    .id-hint {
        font-size: 10px;
        color: var(--muted);
        letter-spacing: 0.06em;
        margin-bottom: 14px;
    }
    .id-hint strong { color: rgba(255,255,255,0.72); letter-spacing: 0.03em; }

    /* ─── SEGMENTED ID INPUT ─────────────────────────────── */
    .seg-row {
        display: flex;
        align-items: center;
        gap: 0;
        margin-bottom: 22px;
    }

    .seg-input {
        background: var(--field-bg);
        border: 1px solid var(--border);
        border-radius: 3px;
        padding: 11px 6px;
        font-family: 'Barlow Condensed', sans-serif;
        font-size: 16px;
        font-weight: 700;
        letter-spacing: 0.08em;
        text-transform: uppercase;
        color: var(--text);
        text-align: center;
        outline: none;
        transition: border-color 0.2s, background 0.2s, box-shadow 0.2s;
    }
    .seg-input::placeholder { color: rgba(255,255,255,0.14); }
    .seg-input:focus {
        border-color: rgba(210, 25, 25, 0.35);
        background: rgba(255,255,255,0.08);
        box-shadow: 0 0 0 3px rgba(255,255,255,0.04);
        z-index: 1;
    }
    .seg-input.w1 { width: 60px; }
    .seg-input.w2 { width: 50px; }
    .seg-input.w3 { width: 70px; }
    .seg-input.w4 { width: 92px; }

    .seg-sep {
        font-family: 'Barlow Condensed', sans-serif;
        font-size: 20px;
        font-weight: 700;
        color: rgba(255,255,255,0.18);
        padding: 0 6px;
        user-select: none;
    }

    /* ─── PASSWORD INPUT ─────────────────────────────────── */
    .field-group { margin-bottom: 16px; }

    .pw-wrap { position: relative; }
    .pw-input {
        width: 100%;
        background: var(--field-bg);
        border: 1px solid var(--border);
        border-radius: 3px;
        padding: 12px 42px 12px 14px;
        font-family: 'Barlow', sans-serif;
        font-size: 13px;
        color: var(--text);
        outline: none;
        transition: border-color 0.2s, background 0.2s, box-shadow 0.2s;
    }
    .pw-input::placeholder { color: rgba(255,255,255,0.2); }
    .pw-input:focus {
        border-color: rgba(255,255,255,0.35);
        background: rgba(255,255,255,0.08);
        box-shadow: 0 0 0 3px rgba(255,255,255,0.04);
    }
    .pw-toggle {
        position: absolute;
        right: 12px; top: 50%; transform: translateY(-50%);
        background: none; border: none;
        color: rgba(255,255,255,0.22);
        font-size: 13px; cursor: pointer;
        transition: color 0.2s;
    }
    .pw-toggle:hover { color: rgba(255, 255, 255, 0.41); }

    /* ─── STUDENT FOUND BANNER ───────────────────────────── */
    .student-found {
        display: flex; align-items: center; gap: 12px;
        background: rgba(255,255,255,0.03);
        border: 1px solid var(--border);
        border-radius: 3px;
        padding: 12px 14px;
        margin-bottom: 22px;
        position: relative;
    }
    .student-avatar {
        width: 38px; height: 38px;
        border-radius: 3px;
        background: rgba(255,255,255,0.05);
        border: 1px solid var(--border);
        display: flex; align-items: center; justify-content: center;
        color: var(--muted); font-size: 15px;
        flex-shrink: 0;
    }
    .student-name { font-family: 'Barlow Condensed', sans-serif; font-size: 15px; font-weight: 700; letter-spacing: 0.04em; }
    .student-id   { font-size: 10px; color: var(--muted); letter-spacing: 0.08em; margin-top: 2px; }
    .edit-btn {
        position: absolute; right: 10px; top: 50%; transform: translateY(-50%);
        background: none; border: none;
        color: rgba(255,255,255,0.2); font-size: 12px;
        cursor: pointer; padding: 6px 8px;
        border-radius: 3px; text-decoration: none;
        display: flex; align-items: center;
        transition: color 0.2s, background 0.2s;
    }
    .edit-btn:hover { color: var(--text); background: rgba(255,255,255,0.06); }

    /* ─── NEW USER BADGE ─────────────────────────────────── */
    .new-badge {
        display: inline-flex; align-items: center; gap: 6px;
        background: rgba(251,191,36,0.07);
        border: 1px solid rgba(251,191,36,0.18);
        border-radius: 3px;
        padding: 6px 11px;
        font-size: 10px; font-weight: 600;
        letter-spacing: 0.08em; text-transform: uppercase;
        color: #fbbf24;
        margin-bottom: 16px;
    }

    /* ─── SUB-LABEL (step hint) ──────────────────────────── */
    .sub-label {
        font-size: 10px;
        letter-spacing: 0.12em;
        text-transform: uppercase;
        color: var(--muted);
        margin-bottom: 16px;
    }

    /* ─── MAIN BUTTON ────────────────────────────────────── */
    .btn-main {
        width: 100%;
        padding: 13px;
        background: transparent;
        color: var(--text);
        border: 1px solid var(--text);
        border-radius: 3px;
        font-family: 'Barlow Condensed', sans-serif;
        font-size: 14px;
        font-weight: 700;
        letter-spacing: 0.18em;
        text-transform: uppercase;
        cursor: pointer;
        display: flex; align-items: center; justify-content: center; gap: 9px;
        transition: background 0.2s, color 0.2s, border-color 0.2s;
        margin-top: 6px;
    }
    .btn-main:hover {
        background: var(--text);
        color: #0e0e10;
        border-color: var(--text);
    }
    .btn-main:active { transform: scale(0.99); }

    /* ─── FOOTER ─────────────────────────────────────────── */
    .page-footer {
        margin-top: 18px;
        font-size: 9px;
        letter-spacing: 0.14em;
        text-transform: uppercase;
        color: rgba(255,255,255,0.18);
        text-align: center;
    }
    </style>
</head>
<body>

<!-- Background photo layer — see comment above in CSS to set your image -->
<div class="bg-layer"></div>

<!-- ─── NAV ─────────────────────────────────────────────── -->
<nav class="top-nav">
    <div class="logo">
        <img src="assets/aclc_logo(1).png" alt="ACLC Logo" style="width:50px;height:px;object-fit:contain;">
    </div>
    <div>
        <div class="nav-school">ACLC College of Mandaue</div>
        <div class="nav-system">Club &amp; Membership System</div>
    </div>
</nav>

<!-- ─── PAGE ─────────────────────────────────────────────── -->
<div class="page">

    <div class="logo">
        <img src="assets/aclc_logo(1).png" alt="ACLC Logo" style="width:100px;height:100px;object-fit:contain;">
    </div>
    <h1 class="page-title">Sign in</h1>
    <p class="page-sub">For your protection, please verify your identity.</p>

    <!-- Step indicators -->
    <div class="steps">
        <div class="step-dot <?= $step === 1 ? 'active' : 'done' ?>">
            <?= $step > 1 ? '<i class="fas fa-check" style="font-size:11px"></i>' : '1' ?>
        </div>
        <div class="step-line <?= $step > 1 ? 'done' : '' ?>"></div>
        <div class="step-dot <?= $step === 2 ? 'active' : '' ?>">2</div>
        <div class="step-line"></div>
        <div class="step-dot">3</div>
    </div>

    <!-- Alert -->
    <?php if ($error): ?>
    <div class="alert">
        <i class="fas fa-exclamation-circle"></i>
        <span><?= $error ?></span>
    </div>
    <?php endif; ?>


    <!-- ── STEP 1 ── -->
    <?php if ($step === 1): ?>
    <div class="card">
        <div class="field-label">Student ID <span class="req">*</span></div>
        <p class="id-hint">Format: <strong>C24-01-0001-MAN121</strong></p>
        <form method="POST">
            <input type="hidden" name="action" value="find">
            <div class="seg-row">
                <input type="text" name="p1" id="p1" class="seg-input w1"
                       maxlength="3" placeholder="C24" required autofocus
                       value="<?= sanitize($_POST['p1'] ?? '') ?>">
                <span class="seg-sep">—</span>
                <input type="text" name="p2" id="p2" class="seg-input w2"
                       maxlength="2" placeholder="01" required
                       value="<?= sanitize($_POST['p2'] ?? '') ?>">
                <span class="seg-sep">—</span>
                <input type="text" name="p3" id="p3" class="seg-input w3"
                       maxlength="4" placeholder="0001" required
                       value="<?= sanitize($_POST['p3'] ?? '') ?>">
                <span class="seg-sep">—</span>
                <input type="text" name="p4" id="p4" class="seg-input w4"
                       maxlength="6" placeholder="MAN121" required
                       value="<?= sanitize($_POST['p4'] ?? '') ?>">
            </div>
            <button type="submit" class="btn-main">
                <i class="fas fa-search"></i> Find My Record
            </button>
        </form>
    </div>

    <!-- ── STEP 2 ── -->
    <?php elseif ($step === 2): ?>
    <div class="card">

        <div class="student-found">
            <div class="student-avatar"><i class="fas fa-user-graduate"></i></div>
            <div>
                <div class="student-name"><?= sanitize($pending_name) ?></div>
                <div class="student-id"><?= sanitize($pending_id) ?></div>
            </div>
            <a href="index.php?reset=1" class="edit-btn" title="Use a different ID">
                <i class="fas fa-pencil-alt"></i>
            </a>
        </div>

        <?php if ($is_new): ?>
            <div class="new-badge"><i class="fas fa-star"></i> First time — create a password</div>
            <div class="sub-label">Minimum 6 characters</div>
            <form method="POST">
                <input type="hidden" name="action" value="create_password">
                <div class="field-group">
                    <div class="field-label">Password <span class="req">*</span></div>
                    <div class="pw-wrap">
                        <input type="password" name="password" id="pwField" class="pw-input"
                               placeholder="Create a password" required autofocus>
                        <button type="button" class="pw-toggle" onclick="togglePw()" tabindex="-1">
                            <i class="fas fa-eye" id="pwIcon"></i>
                        </button>
                    </div>
                </div>
                <div class="field-group">
                    <div class="field-label">Confirm Password <span class="req">*</span></div>
                    <div class="pw-wrap">
                        <input type="password" name="confirm_password" id="pwField2" class="pw-input"
                               placeholder="Confirm your password" required>
                        <button type="button" class="pw-toggle" onclick="togglePw2()" tabindex="-1">
                            <i class="fas fa-eye" id="pwIcon2"></i>
                        </button>
                    </div>
                </div>
                <button type="submit" class="btn-main">
                    <i class="fas fa-check-circle"></i> Create Password &amp; Enter
                </button>
            </form>

        <?php else: ?>
            <div class="field-group">
                <div class="field-label">Password <span class="req">*</span></div>
                <div class="pw-wrap">
                    <input type="password" name="password" id="pwField" form="loginForm" class="pw-input"
                           placeholder="Your password" required autofocus>
                    <button type="button" class="pw-toggle" onclick="togglePw()" tabindex="-1">
                        <i class="fas fa-eye" id="pwIcon"></i>
                    </button>
                </div>
            </div>
            <form method="POST" id="loginForm">
                <input type="hidden" name="action" value="login">
                <button type="submit" class="btn-main">
                    <i class="fas fa-arrow-right-to-bracket"></i> Sign In
                </button>
            </form>
        <?php endif; ?>

    </div>
    <?php endif; ?>

    <div class="page-footer">
        <p> Safe and secured.</p>
    </div>

</div><!-- /page -->

<script>
/* ── Segmented ID auto-advance ── */
const segs = ['p1','p2','p3','p4'];
const maxL = [3, 2, 4, 6];
segs.forEach((id, i) => {
    const el = document.getElementById(id);
    if (!el) return;
    el.addEventListener('input', function () {
        this.value = this.value.toUpperCase().replace(/[^A-Z0-9]/g, '');
        if (this.value.length >= maxL[i] && i < segs.length - 1)
            document.getElementById(segs[i + 1])?.focus();
    });
    el.addEventListener('keydown', function (e) {
        if (e.key === 'Backspace' && this.value === '' && i > 0)
            document.getElementById(segs[i - 1])?.focus();
    });
});

/* ── Password toggles ── */
function togglePw() {
    const f = document.getElementById('pwField');
    const i = document.getElementById('pwIcon');
    if (!f) return;
    f.type = f.type === 'password' ? 'text' : 'password';
    i.classList.toggle('fa-eye'); i.classList.toggle('fa-eye-slash');
}
function togglePw2() {
    const f = document.getElementById('pwField2');
    const i = document.getElementById('pwIcon2');
    if (!f) return;
    f.type = f.type === 'password' ? 'text' : 'password';
    i.classList.toggle('fa-eye'); i.classList.toggle('fa-eye-slash');
}
</script>
</body>
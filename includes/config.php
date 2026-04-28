<?php
// ACLC Club & Membership System - Database Config
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'aclc_cms');
define('SITE_NAME', 'ACLC Club & Membership System');
define('SCHOOL_NAME', 'ACLC College of Mandaue');

// House colors
define('HOUSE_COLORS', [
    'AZUL'    => ['primary' => '#3b97ff', 'light' => '#E3F2FD', 'text' => '#ffffff'],
    'CAHEL'   => ['primary' => '#ff8400', 'light' => '#FFF3E0', 'text' => '#ffffff'],
    'GIALLIO' => ['primary' => '#f7f431', 'light' => '#FFFDE7', 'text' => '#ffffff'],
    'ROXXO'   => ['primary' => '#fc3a3a', 'light' => '#FFEBEE', 'text' => '#ffffff'],
    'VIERRDY' => ['primary' => '#4cf957', 'light' => '#E8F5E9', 'text' => '#ffffff'],
]);

function getDB() {
    static $pdo = null;
    if ($pdo === null) {
        try {
            $pdo = new PDO(
                "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4",
                DB_USER, DB_PASS,
                [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                 PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]
            );
        } catch (PDOException $e) {
            die("<div style='font-family:sans-serif;padding:30px;color:red;'>
                <h2>Database Connection Error</h2>
                <p>Please make sure XAMPP MySQL is running and the database is imported.</p>
                <code>" . htmlspecialchars($e->getMessage()) . "</code>
            </div>");
        }
    }
    return $pdo;
}

function redirect($url) {
    header("Location: $url");
    exit;
}

function isLoggedIn() {
    return isset($_SESSION['student_id']);
}

function isAdminLoggedIn() {
    return isset($_SESSION['admin_id']);
}

// Alias used in admin pages
function isAdminIn() {
    return isset($_SESSION['admin_id']);
}

// ── NEW: Role helpers ─────────────────────────────────────────

/**
 * Returns true if the logged-in admin is a Super Admin.
 * Super admins have full access to all houses.
 */
function isSuperAdmin() {
    return isset($_SESSION['admin_role']) && $_SESSION['admin_role'] === 'super_admin';
}

/**
 * Returns the house the logged-in admin manages.
 * Returns NULL for super_admin (manages all houses).
 */
function getAdminHouse() {
    return $_SESSION['admin_house'] ?? null;
}

/**
 * Returns true if the logged-in admin is a House Admin.
 */
function isHouseAdmin() {
    return isset($_SESSION['admin_role']) && $_SESSION['admin_role'] === 'house_admin';
}

/**
 * Builds a SQL WHERE clause fragment and params array for house filtering.
 * If super_admin → no restriction (returns empty string + empty array).
 * If house_admin  → returns " AND {$tableAlias}.house = ?" + [house].
 *
 * Usage:
 *   [$hWhere, $hParams] = houseWhere('s');
 *   $sql = "SELECT * FROM students s WHERE 1=1 $hWhere";
 *   $stmt->execute(array_merge($otherParams, $hParams));
 */
function houseWhere(string $tableAlias = 's'): array {
    $house = getAdminHouse();
    if ($house === null) return ['', []];
    return [" AND {$tableAlias}.house = ?", [$house]];
}

// ─────────────────────────────────────────────────────────────

function getBaseUrl() {
    $script = $_SERVER['SCRIPT_NAME'] ?? '';
    $parts = explode('/', trim($script, '/'));
    return '/' . ($parts[0] ?? '');
}

function requireLogin() {
    if (!isLoggedIn()) {
        $base = getBaseUrl();
        redirect($base . '/index.php');
    }
}

function requireAdmin() {
    if (!isAdminLoggedIn()) {
        $base = getBaseUrl();
        redirect($base . '/admin.php');
    }
}

function sanitize($str) {
    return htmlspecialchars(trim((string)$str), ENT_QUOTES, 'UTF-8');
}

function getHouseColor($house, $type = 'primary') {
    $colors = constant('HOUSE_COLORS');
    return $colors[strtoupper($house)][$type] ?? '#555555';
}
?>
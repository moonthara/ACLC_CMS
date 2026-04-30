-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 28, 2026 at 05:39 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aclc_cms`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `role` enum('super_admin','admin','house_admin') DEFAULT 'admin',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `house` varchar(20) DEFAULT NULL COMMENT 'NULL = access all houses; set to house name for house_admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `full_name`, `email`, `role`, `is_active`, `created_at`, `house`) VALUES
(2, 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrator', NULL, 'super_admin', 1, '2026-04-16 20:03:05', NULL),
(3, 'admin_azul', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'AZUL House Admin', 'azul@aclc.edu.ph', 'house_admin', 1, '2026-04-26 15:58:46', 'AZUL'),
(4, 'admin_cahel', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'CAHEL House Admin', 'cahel@aclc.edu.ph', 'house_admin', 1, '2026-04-26 15:58:46', 'CAHEL'),
(5, 'admin_giallio', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'GIALLIO House Admin', 'giallio@aclc.edu.ph', 'house_admin', 1, '2026-04-26 15:58:46', 'GIALLIO'),
(6, 'admin_roxxo', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'ROXXO House Admin', 'roxxo@aclc.edu.ph', 'house_admin', 1, '2026-04-26 15:58:46', 'ROXXO'),
(7, 'admin_vierrdy', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'VIERRDY House Admin', 'vierrdy@aclc.edu.ph', 'house_admin', 1, '2026-04-26 15:58:46', 'VIERRDY');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Sports & Fitness'),
(2, 'Arts & Creativity'),
(3, 'Academic & Professional'),
(4, 'Culture & Language'),
(5, 'Community & Leadership');

-- --------------------------------------------------------

--
-- Table structure for table `clubs`
--

CREATE TABLE `clubs` (
  `id` int(11) NOT NULL,
  `club_name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `house` varchar(20) DEFAULT NULL COMMENT 'NULL = open to all houses',
  `logo` varchar(255) DEFAULT NULL,
  `max_members` int(11) DEFAULT 50,
  `is_active` tinyint(1) DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clubs`
--

INSERT INTO `clubs` (`id`, `club_name`, `description`, `house`, `logo`, `max_members`, `is_active`, `created_by`, `created_at`) VALUES
(6, 'Computer Society', 'For IT and CS students across all houses', NULL, NULL, 100, 1, 1, '2026-04-13 11:48:37'),
(7, 'Student Council', 'ACLC Mandaue Student Council', NULL, NULL, 50, 1, 1, '2026-04-13 11:48:37'),
(8, 'Basketball Club', 'Official club for Azul house members', 'AZUL', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(9, 'Martial Arts Club', 'Official club for Azul house members', 'AZUL', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(10, 'Basketball Club', 'Official club for Cahel house members', 'CAHEL', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(11, 'Martial Arts Club', 'Official club for Cahel house members', 'CAHEL', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(12, 'Basketball Club', 'Official club for Giallio house members', 'GIALLIO', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(13, 'Martial Arts Club', 'Official club for Giallio house members', 'GIALLIO', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(14, 'Basketball Club', 'Official club for Roxxo house members', 'ROXXO', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(15, 'Martial Arts Club', 'Official club for Roxxo house members', 'ROXXO', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(16, 'Basketball Club', 'Official club for Vierrdy house members', 'VIERRDY', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(17, 'Martial Arts Club', 'Official club for Vierrdy house members', 'VIERRDY', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(18, 'Theater Guild', 'Official club for Azul house members', 'AZUL', NULL, 30, 1, 1, '2026-04-23 23:24:07'),
(19, 'Photography & Videography Club', 'Official club for Azul house members', 'AZUL', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(20, 'Theater Guild', 'Official club for Cahel house members', 'CAHEL', NULL, 30, 1, 1, '2026-04-23 23:24:07'),
(21, 'Photography & Videography Club', 'Official club for Cahel house members', 'CAHEL', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(22, 'Theater Guild', 'Official club for Giallio house members', 'GIALLIO', NULL, 30, 1, 1, '2026-04-23 23:24:07'),
(23, 'Photography & Videography Club', 'Official club for Giallio house members', 'GIALLIO', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(24, 'Theater Guild', 'Official club for Roxxo house members', 'ROXXO', NULL, 30, 1, 1, '2026-04-23 23:24:07'),
(25, 'Photography & Videography Club', 'Official club for Roxxo house members', 'ROXXO', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(26, 'Theater Guild', 'Official club for Vierrdy house members', 'VIERRDY', NULL, 30, 1, 1, '2026-04-23 23:24:07'),
(27, 'Photography & Videography Club', 'Official club for Vierrdy house members', 'VIERRDY', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(28, 'Debate Society', 'For IT and CS students across all houses', 'ALL', NULL, 100, 1, 1, '2026-04-23 23:24:07'),
(29, 'Computer / Girls Who Code', 'For IT and CS students across all houses', 'ALL', NULL, 100, 1, 1, '2026-04-23 23:24:07'),
(30, 'Asian Culture Club', 'Official club for Azul house members', 'AZUL', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(31, 'Nihongo Club', 'Official club for Azul house members', 'AZUL', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(32, 'Asian Culture Club', 'Official club for Cahel house members', 'CAHEL', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(33, 'Nihongo Club', 'Official club for Cahel house members', 'CAHEL', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(34, 'Asian Culture Club', 'Official club for Giallio house members', 'GIALLIO', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(35, 'Nihongo Club', 'Official club for Giallio house members', 'GIALLIO', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(36, 'Asian Culture Club', 'Official club for Roxxo house members', 'ROXXO', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(37, 'Nihongo Club', 'Official club for Roxxo house members', 'ROXXO', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(38, 'Asian Culture Club', 'Official club for Vierrdy house members', 'VIERRDY', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(39, 'Nihongo Club', 'Official club for Vierrdy house members', 'VIERRDY', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(40, 'Student Council', 'ACLC Mandaue Student Council', 'ALL', NULL, 50, 1, 1, '2026-04-23 23:24:07'),
(41, 'Environmental Action Club', 'Official club for Azul house members', 'AZUL', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(42, 'Environmental Action Club', 'Official club for Cahel house members', 'CAHEL', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(43, 'Environmental Action Club', 'Official club for Giallio house members', 'GIALLIO', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(44, 'Environmental Action Club', 'Official club for Roxxo house members', 'ROXXO', NULL, 300, 1, 1, '2026-04-23 23:24:07'),
(45, 'Environmental Action Club', 'Official club for Vierrdy house members', 'VIERRDY', NULL, 300, 1, 1, '2026-04-23 23:24:07');

-- --------------------------------------------------------

--
-- Table structure for table `club_tags`
--

CREATE TABLE `club_tags` (
  `id` int(11) NOT NULL,
  `club_id` int(11) NOT NULL,
  `tag` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `club_id` int(11) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `event_date` date DEFAULT NULL,
  `event_time` time DEFAULT NULL,
  `venue` varchar(200) DEFAULT NULL,
  `type` enum('event','announcement') DEFAULT 'event',
  `house` varchar(20) DEFAULT NULL COMMENT 'NULL = all houses',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `club_id`, `title`, `description`, `event_date`, `event_time`, `venue`, `type`, `house`, `created_by`, `created_at`, `is_active`) VALUES
(1, 6, 'Intro to Web Development Workshop', 'The Computer Society Club cordially invite all IT and CS students to our upcoming hands-on workshop focused on the fundamentals of web development.\r\n\r\nThis is an excellent opportunity to build practical skills in HTML, CSS, and JavaScript under the guidance of our club officers and student mentors.\r\n\r\n📅 Date: May 9, 2025 (Friday)\r\n⏰ Time: 1:00 PM – 4:00 PM\r\n\r\n👥 Open to: All IT and CS students across all houses\r\n\r\nSeats are limited. Interested participants are encouraged to register at the club bulletin board or approach any club officer on or before May 7, 2025.\r\n\r\nWe look forward to your active participation.\r\n\r\nRespectfully,\r\nComputer Society Club\r\nACLC Mandaue', '2026-04-09', '13:00:00', 'Computer Laboratory 2, ACLC Mandaue', 'announcement', NULL, 2, '2026-04-23 23:40:02', 1);

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE `houses` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `houses`
--

INSERT INTO `houses` (`id`, `name`) VALUES
(1, 'Azul'),
(2, 'Cahel'),
(3, 'Giallio'),
(4, 'Roxxo'),
(5, 'Vierrdy');

-- --------------------------------------------------------

--
-- Table structure for table `memberships`
--

CREATE TABLE `memberships` (
  `id` int(11) NOT NULL,
  `student_id` varchar(30) NOT NULL,
  `club_id` int(11) NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `applied_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `reviewed_by` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `memberships`
--

INSERT INTO `memberships` (`id`, `student_id`, `club_id`, `status`, `applied_at`, `reviewed_at`, `reviewed_by`, `notes`) VALUES
(1, 'C24-01-0969-MAN121', 6, 'approved', '2026-04-19 08:05:13', '2026-04-23 17:35:42', 2, NULL),
(2, 'C24-01-0844-MAN121', 29, 'approved', '2026-04-24 00:37:30', '2026-04-27 07:22:06', 3, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `membership_cards`
--

CREATE TABLE `membership_cards` (
  `id` int(11) NOT NULL,
  `student_id` varchar(30) NOT NULL,
  `club_id` int(11) NOT NULL,
  `card_number` varchar(50) NOT NULL,
  `issued_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `membership_cards`
--

INSERT INTO `membership_cards` (`id`, `student_id`, `club_id`, `card_number`, `issued_at`) VALUES
(1, 'C24-01-0969-MAN121', 6, 'ACLC-A7498DC1', '2026-04-23 17:35:42'),
(2, 'C24-01-0844-MAN121', 29, 'ACLC-E0235495', '2026-04-27 07:22:06');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `student_id` varchar(30) NOT NULL COMMENT 'Format: C24-01-XXXX-HOU',
  `last_name` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `course` varchar(20) DEFAULT NULL,
  `level` varchar(10) DEFAULT NULL,
  `status` varchar(30) DEFAULT 'STUDENT',
  `house` varchar(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL COMMENT 'NULL = not yet registered',
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `profile_pic` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `student_id`, `last_name`, `first_name`, `middle_name`, `course`, `level`, `status`, `house`, `password`, `email`, `phone`, `profile_pic`, `is_active`, `created_at`, `updated_at`) VALUES
(26, 'C24-01-0026-MAN121', 'DE GRACIA', 'RENABEB', 'IBARRA', 'BSA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(27, 'C24-01-0027-MAN121', 'DELOS SANTOS', 'MHELKYZEDIC', 'ORNOPIA', 'BSA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(28, 'C24-01-0028-MAN121', 'DOBLE', 'AISHA', 'FLORES', 'BSA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(29, 'C24-01-0029-MAN121', 'ENDIAPE', 'CARLYN', 'SEVILLENO', 'BSA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(30, 'C24-01-0030-MAN121', 'ETULLE', 'RUBELYN', 'ALACIDA', 'BSA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(31, 'C24-01-0031-MAN121', 'FORMENTIRA', 'MERAZOL', 'MIRAFUENTES', 'BSA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(32, 'C24-01-0032-MAN121', 'GEGRIMOSA', 'REBECCA', 'LIMPAG', 'BSA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(33, 'C24-01-0033-MAN121', 'GICALE', 'JAY ART', 'BENARO', 'BSA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(34, 'C24-01-0034-MAN121', 'GONZALES', 'ROSLYN', 'ABENDAN', 'BSA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(35, 'C24-01-0035-MAN121', 'GUISONA', 'RAISA MAE', 'LOON', 'BSA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(36, 'C24-01-0036-MAN121', 'GUPO', 'MARIALYN', 'MEJASCO', 'BSA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(37, 'C24-01-0037-MAN121', 'HERNANDO', 'HERZALEE', '-', 'BSA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(38, 'C24-01-0038-MAN121', 'HORTEL', 'JOHN MOISES', 'HONTANOSAS', 'BSA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(39, 'C24-01-0039-MAN121', 'JUGALBOT', 'ANGEL TRISHA MAE', 'SAMONTE', 'BSA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(40, 'C24-01-0040-MAN121', 'LARGO', 'CHRISTINE', '-', 'BSA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(41, 'C24-01-0041-MAN121', 'LEE', 'CHRISTINA JEAN', 'BAGALANON', 'BSA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(42, 'C24-01-0042-MAN121', 'LERIOS', 'JINGLE', 'SADUCAS', 'BSA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(43, 'C24-01-0043-MAN121', 'LOPEZ', 'JENNIFER', 'JUNIO', 'BSA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(44, 'C24-01-0044-MAN121', 'MACABACYAO', 'PRINCESS HAYCINTH', 'DAMAYO', 'BSA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(45, 'C24-01-0045-MAN121', 'MAGLASANG', 'MAXENE JADE', 'ROSALES', 'BSA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(46, 'C24-01-0046-MAN121', 'MAGRACIA', 'HANZ', 'LIBO-ON', 'BSA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(47, 'C24-01-0047-MAN121', 'MALAGOM', 'CRISSA MAE', 'PEPITO', 'BSA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(48, 'C24-01-0048-MAN121', 'NEDRUDA', 'DANIELA', 'MAQUILANG', 'BSA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(49, 'C24-01-0049-MAN121', 'NORBE', 'LARA JEAN', 'QUIATCHON', 'BSA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(50, 'C24-01-0050-MAN121', 'ORBISO', 'RENZ KRISHAN', 'TAGSIP', 'BSA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(51, 'C24-01-0051-MAN121', 'PAQUIBOT', 'RALPH ANDRE ACE', 'NOCOS', 'BSA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(52, 'C24-01-0052-MAN121', 'PASIGNAHIN', 'MAYBELIN', 'OMADLAO', 'BSA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(53, 'C24-01-0053-MAN121', 'PILAPIL', 'KATE XYRA', 'ALBIOS', 'BSA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(54, 'C24-01-0054-MAN121', 'PITOGO', 'ELCHAN MAE', 'CELOCIA', 'BSA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(55, 'C24-01-0055-MAN121', 'PUEBLAS', 'UNIZA MAE', 'ANGANA', 'BSA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(56, 'C24-01-0056-MAN121', 'PURGATORIO', 'ELSIE', 'MAMAC', 'BSA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(57, 'C24-01-0057-MAN121', 'QUIAPO', 'PRINCESS', 'CLARO', 'BSA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(58, 'C24-01-0058-MAN121', 'QUIZA', 'ANDRE VON KELLY', 'TAGIOBON', 'BSA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(59, 'C24-01-0059-MAN121', 'REMOROZA', 'CRISTYAN JABE', 'BRANZUELA', 'BSA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(60, 'C24-01-0060-MAN121', 'RENDULA', 'JOHN LLOYD', 'ARROGANTE', 'BSA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(61, 'C24-01-0061-MAN121', 'RONDINA', 'REGINE ANNE', 'CARTAGENA', 'BSA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(62, 'C24-01-0062-MAN121', 'SIENES', 'MARIEL ANN', 'ARADO', 'BSA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(63, 'C24-01-0063-MAN121', 'SINADJAN', 'MARY CONCEPCION', 'VARGAS', 'BSA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(64, 'C24-01-0064-MAN121', 'SOMBILON', 'AUBREY LOU', 'ROSAROSO', 'BSA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(65, 'C24-01-0065-MAN121', 'SON', 'JACKIELOU', 'NEGRO', 'BSA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(66, 'C24-01-0066-MAN121', 'SUICO', 'PAULLEN', 'SUDAY', 'BSA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(67, 'C24-01-0067-MAN121', 'TORREFIEL', 'KIM LEE MARIE', 'SOLON', 'BSA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(68, 'C24-01-0068-MAN121', 'TORREJAS', 'RECHEL MAE', 'TAMONDOC', 'BSA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(69, 'C24-01-0069-MAN121', 'TUNDAG', 'YHEZA MAE', 'LAHOYLHOY', 'BSA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(70, 'C24-01-0070-MAN121', 'TUQUIB', 'YVONNE', 'MATARLO', 'BSA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(71, 'C24-01-0071-MAN121', 'VELARA', 'JANROSE', 'PULONG', 'BSA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(72, 'C24-01-0072-MAN121', 'AÃ‘ORA', 'MAY ROSE', 'BENTILLO', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(73, 'C24-01-0073-MAN121', 'ABARQUEZ', 'MICHELLE', 'BONTUYAN', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(74, 'C24-01-0074-MAN121', 'ABAYA', 'MESHALEE', 'SIGLOS', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(75, 'C24-01-0075-MAN121', 'ABELLANOSA', 'KLESLYR CEDRIC', 'LIRAY', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(76, 'C24-01-0076-MAN121', 'AGANAN', 'ANGEL MAE', 'POLESTICO', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(77, 'C24-01-0077-MAN121', 'ALBERCA', 'MERIE JEAN', 'ALBACITE', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(78, 'C24-01-0078-MAN121', 'ALCAYDE', 'JAMAICA', 'DAVIN', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(79, 'C24-01-0079-MAN121', 'ALEJANDRO', 'STRAWBERRY', 'BRACERO', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(80, 'C24-01-0080-MAN121', 'ALIGADO', 'EVELYN', 'VILLACAMPA', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(81, 'C24-01-0081-MAN121', 'ALIPOYO', 'HONEY', 'DELA FUENTE', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(82, 'C24-01-0082-MAN121', 'ALIVIO', 'KRISTEL DYNE', 'SIATON', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(83, 'C24-01-0083-MAN121', 'ALONTAR', 'JULEANA ROSE', 'SABIJON', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(84, 'C24-01-0084-MAN121', 'ALUPINO', 'CASSANDRA MARIE', 'LUMINGKIT', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(85, 'C24-01-0085-MAN121', 'AMISTOSO', 'MITZ NICHOLE', 'VILLARICO', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(86, 'C24-01-0086-MAN121', 'APAS', 'CHESIA', 'PEJO', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(87, 'C24-01-0087-MAN121', 'APOSTOL', 'WINLOVE', 'ESCOLTOR', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(88, 'C24-01-0088-MAN121', 'ARADO', 'SHANE', 'VARGAS', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(89, 'C24-01-0089-MAN121', 'ARNADO', 'DARLENE', 'MATA', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(90, 'C24-01-0090-MAN121', 'ARNADO', 'QUEENLY', 'ESCORA', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(91, 'C24-01-0091-MAN121', 'ARONG', 'KAREN', 'MENDOZA', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(92, 'C24-01-0092-MAN121', 'ATENDIDO', 'DRHECIA KATE', 'MAGNO', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(93, 'C24-01-0093-MAN121', 'BACTONG', 'ROWIE JANE', 'COQUILLA', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(94, 'C24-01-0094-MAN121', 'BAGANG', 'JURYX', '-', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(95, 'C24-01-0095-MAN121', 'BALBIN', 'ARGIEN PAUL', 'BELTRAN', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(96, 'C24-01-0096-MAN121', 'BALDEMOR', 'DAVE', 'BACERRA', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(97, 'C24-01-0097-MAN121', 'BALILI', 'REYNALDO JR.', 'APOSTOL', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(98, 'C24-01-0098-MAN121', 'BARIL', 'ANGEL', 'CULLAMAT', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(99, 'C24-01-0099-MAN121', 'BARREDO', 'MARIE JHUN', 'CABALLERO', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(100, 'C24-01-0100-MAN121', 'BARRIOS', 'CRISANNY ALTHEA', 'CABANGUNAY', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(101, 'C24-01-0101-MAN121', 'BASILIO', 'RIZZA', 'ABONG', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(102, 'C24-01-0102-MAN121', 'BAYO', 'IRISH', 'ROSEL', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(103, 'C24-01-0103-MAN121', 'BELAMIA', 'GUILBERT', 'VILLEGAS', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(104, 'C24-01-0104-MAN121', 'BELLO', 'RACIL', 'ANIBAN', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(105, 'C24-01-0105-MAN121', 'BORJA', 'MARC VINCENT', 'ARMENION', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(106, 'C24-01-0106-MAN121', 'BRILLANTES', 'HANNAH', 'JUMAO-AS', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(107, 'C24-01-0107-MAN121', 'BRIONES', 'AIMIE', 'PACTO', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(108, 'C24-01-0108-MAN121', 'BUSICO', 'HANNAH KIM', 'MONTEBON', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(109, 'C24-01-0109-MAN121', 'CAÑONEO', 'GABRIEL FLORENCE', 'PAÑAREZ', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(110, 'C24-01-0110-MAN121', 'CABAHUG', 'SHARA JANE', 'OGOC', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(111, 'C24-01-0111-MAN121', 'CABERTE', 'REY ANN', 'LEDESMA', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(112, 'C24-01-0112-MAN121', 'CADUCOY', 'CHRISTIAN BRYAN', 'AMALEONA', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(113, 'C24-01-0113-MAN121', 'CAGALCAL', 'ANGEL ANN', 'BERDEN', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(114, 'C24-01-0114-MAN121', 'CANAR', 'JOLIE ANN', 'TABELINO', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(115, 'C24-01-0115-MAN121', 'CARCUSIA', 'ANALYN', 'ANES', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(116, 'C24-01-0116-MAN121', 'CASINILLO', 'EMIE ROSE', 'LUMAPAS', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(117, 'C24-01-0117-MAN121', 'CATAYAS', 'SHIERAMAE', 'CERVANTES', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(118, 'C24-01-0118-MAN121', 'CAUYON', 'BEA', 'TABURNAL', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(119, 'C24-01-0119-MAN121', 'CEMINE', 'CHEENEE JANE', 'ALAAN', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(120, 'C24-01-0120-MAN121', 'CENIZA', 'SAMANTHA NICHOLE', '-', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(121, 'C24-01-0121-MAN121', 'CONGSON', 'JUSTINE', 'RABANES', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(122, 'C24-01-0122-MAN121', 'CUADRA', 'RENZ JOSHUA', 'AMOR', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(123, 'C24-01-0123-MAN121', 'DAYA-UNE', 'ASHLEY', 'ALLOSADA', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(124, 'C24-01-0124-MAN121', 'DEL ROSARIO', 'ANGELICA MAE', 'LUBAS', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(125, 'C24-01-0125-MAN121', 'DERDER', 'LYCA', 'DESABILLE', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(126, 'C24-01-0126-MAN121', 'DUMAGAN', 'LYCA', 'CARBAJOSA', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(127, 'C24-01-0127-MAN121', 'DUNGOG', 'MARY GRACE LHYN', 'SOLABAR', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(128, 'C24-01-0128-MAN121', 'EDUQLAG', 'JOHN LOI', 'CAA’IZAR', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(129, 'C24-01-0129-MAN121', 'ERALINO', 'JOHN MARTIN', 'REQUIRME', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(130, 'C24-01-0130-MAN121', 'FLORES', 'TRISHA', 'AGBO', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(131, 'C24-01-0131-MAN121', 'GARBO', 'MICHAELA', 'MANTE', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(132, 'C24-01-0132-MAN121', 'GARCISO', 'HANNAH', '-', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(133, 'C24-01-0133-MAN121', 'GEPIGA', 'MYLA', 'LARITA', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(134, 'C24-01-0134-MAN121', 'GESULGA', 'LEE GHRANN', 'TAN', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(135, 'C24-01-0135-MAN121', 'GIMPAYAN', 'JITHEL', '-', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(136, 'C24-01-0136-MAN121', 'GUACA', 'LOUEMAR', 'ONDE', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(137, 'C24-01-0137-MAN121', 'HONONGAN', 'MARGIE', 'BACTALAN', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(138, 'C24-01-0138-MAN121', 'ICALINA', 'JEBZEL', 'INSO', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(139, 'C24-01-0139-MAN121', 'INOT', 'MA. ANGELICA', 'ABA-A', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(140, 'C24-01-0140-MAN121', 'IRIARTE', 'CHENIE ANGEL', '-', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(141, 'C24-01-0141-MAN121', 'JADRAQUE', 'RICA MAE', 'CARDEA’O', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(142, 'C24-01-0142-MAN121', 'JAMITO', 'NEHEMIA', 'PALABRICA', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(143, 'C24-01-0143-MAN121', 'JAYA', 'KISHI NEA', 'OROYAN', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(144, 'C24-01-0144-MAN121', 'JOCSON', 'SHAINA MARHEZ', 'NARCISO', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(145, 'C24-01-0145-MAN121', 'JUGALBOT', 'DEVORAH AMOR', 'BARROSA', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(146, 'C24-01-0146-MAN121', 'JUMAO-AS', 'EJ', 'APARICI', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(147, 'C24-01-0147-MAN121', 'LABAJO', 'ALLIAH KYLA', 'JAYME', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(148, 'C24-01-0148-MAN121', 'LABASANO', 'RIACTH MARK', 'SORIA', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(149, 'C24-01-0149-MAN121', 'LAURENTE', 'JOHN REUBEN', 'CASTRO', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(150, 'C24-01-0150-MAN121', 'LAURON', 'MON ALDRICH', 'MAX', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(151, 'C24-01-0151-MAN121', 'LENTORIO', 'CHRISTYL KIETH', 'DALMAN', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(152, 'C24-01-0152-MAN121', 'LLAMOS', 'CAMELO JR.', 'LASTIMOSO', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(153, 'C24-01-0153-MAN121', 'LOPEZ', 'GILLIAN', '-', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(154, 'C24-01-0154-MAN121', 'LUCABON', 'JANINE PITS', 'BANGO', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(155, 'C24-01-0155-MAN121', 'MAG-ASO', 'ANABEL', 'QUINDAO', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(156, 'C24-01-0156-MAN121', 'MAGDUA', 'ANGEL MAE', 'MANDAWE', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(157, 'C24-01-0157-MAN121', 'MALAGAR', 'AMOR LIZETTE', 'CANTILLEP', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(158, 'C24-01-0158-MAN121', 'MALINAO', 'KIMBERLY', 'LIGARAY', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(159, 'C24-01-0159-MAN121', 'MALINAO', 'ROSILYN', 'ARELA', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(160, 'C24-01-0160-MAN121', 'MALOLOY-ON', 'MHECA', 'ABING', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(161, 'C24-01-0161-MAN121', 'MALQUITAR', 'HERMALYN', 'LEGAL', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(162, 'C24-01-0162-MAN121', 'MATA', 'ARAME', 'COLLAMAT', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(163, 'C24-01-0163-MAN121', 'MATA', 'FEBRUARY', 'JUEZAN', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(164, 'C24-01-0164-MAN121', 'MEGUISO', 'VANESSA', 'BONTUYAN', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(165, 'C24-01-0165-MAN121', 'MENCHAVEZ', 'RHEA MAE', 'MABINI', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(166, 'C24-01-0166-MAN121', 'MENDOZA', 'JAMIR', 'MARTEL', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(167, 'C24-01-0167-MAN121', 'MENDOZA', 'MARICHU', 'B', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(168, 'C24-01-0168-MAN121', 'MONDERO', 'GUILLEN FATIMA', 'CABARDO', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(169, 'C24-01-0169-MAN121', 'MONSANTO', 'CHRISTINE JEAN', 'MONDIGO', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(170, 'C24-01-0170-MAN121', 'MONTANO', 'JHON SIMON', 'NARVAEZ', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(171, 'C24-01-0171-MAN121', 'MURILLO', 'HANNAH', 'SALUDAR', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(172, 'C24-01-0172-MAN121', 'NALUPANO', 'SAMANTHA', 'DELA TORRE', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(173, 'C24-01-0173-MAN121', 'NAPARATE', 'BRYAN', 'COMENDADOR', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(174, 'C24-01-0174-MAN121', 'NAPARATE', 'JUDELYN', 'DURAN', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(175, 'C24-01-0175-MAN121', 'NONOL', 'CHELSY ANGEL', 'VERALLO', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(176, 'C24-01-0176-MAN121', 'NOVAL', 'JERALDINE', 'MAGDADARO', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(177, 'C24-01-0177-MAN121', 'OBANDO', 'DENZEL ANTHONY', '-', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(178, 'C24-01-0178-MAN121', 'OLMEDO', 'EMELY', 'SINTO', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(179, 'C24-01-0179-MAN121', 'OPORTO', 'SAM JHENESSIAS', 'PEPITO', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(180, 'C24-01-0180-MAN121', 'ORTEGA', 'ARIANNE MAE', 'REMULTA', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(181, 'C24-01-0181-MAN121', 'OSABEL', 'ALONA JANE', 'BANIA', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(182, 'C24-01-0182-MAN121', 'OTIC', 'APRIL ROSE', 'ALBIOS', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(183, 'C24-01-0183-MAN121', 'PACQUIAO', 'CHARMAINE', 'PITOGO', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(184, 'C24-01-0184-MAN121', 'PALANAS', 'MARIE JECIL', 'CAPUTRE', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(185, 'C24-01-0185-MAN121', 'PAQUIRA', 'MAYBELLE', 'AMACANIN', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(186, 'C24-01-0186-MAN121', 'PARTO', 'EUGENE', 'MABASA', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(187, 'C24-01-0187-MAN121', 'PARUNGAO', 'JESSICA', 'GOLIN', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(188, 'C24-01-0188-MAN121', 'PASAPORTE', 'ROXAN', 'LEDEROS', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(189, 'C24-01-0189-MAN121', 'PATALINGHUG', 'CHELSA', 'ABEJAR', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(190, 'C24-01-0190-MAN121', 'PEPITO', 'NATHANIEL', 'TORREFIEL', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(191, 'C24-01-0191-MAN121', 'PEREZ', 'LEX MATTHEW', '-', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(192, 'C24-01-0192-MAN121', 'POGONIA', 'ISCHE JEAN', 'GUISANDO', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(193, 'C24-01-0193-MAN121', 'RICO', 'CHARLES ANTHONY', 'VIRTUCIO', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(194, 'C24-01-0194-MAN121', 'ROBILLARD', 'BOB-JANDEE', 'HAGUIT', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(195, 'C24-01-0195-MAN121', 'RONDINA', 'LAI CHI', 'DAGATAN', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(196, 'C24-01-0196-MAN121', 'ROSAL', 'JOANA CRISTY', 'MEMBREVE', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(197, 'C24-01-0197-MAN121', 'SAGADSAD', 'SAM ANTHONY', 'SUHTADO', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(198, 'C24-01-0198-MAN121', 'SALAZAR', 'CZARINA MAE', '-', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(199, 'C24-01-0199-MAN121', 'SANSUB', 'DIVINE GRACE', 'ROSAL', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(200, 'C24-01-0200-MAN121', 'SANTOS', 'MARIEL ROSE', 'OMATANG', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(201, 'C24-01-0201-MAN121', 'SASING', 'KENT', 'TOMONGHA', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(202, 'C24-01-0202-MAN121', 'SAYON', 'ASHLEY JANE', 'CUEVAS', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(203, 'C24-01-0203-MAN121', 'SERAFIN', 'ELAINE GRACE', 'TIGLEY', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(204, 'C24-01-0204-MAN121', 'SIATON', 'JHONA MARIE', '-', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(205, 'C24-01-0205-MAN121', 'SIATON', 'MARJORIE', 'HEMONDA', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(206, 'C24-01-0206-MAN121', 'SINOY', 'ANAVELLA', 'ABESTROS', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(207, 'C24-01-0207-MAN121', 'SOCO', 'JOHN DAVE', 'APUNDAR', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(208, 'C24-01-0208-MAN121', 'SONDRITA', 'LUJILLE', 'BENDECIO', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(209, 'C24-01-0209-MAN121', 'SUANO', 'LAURENCE', 'SUQUIB', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(210, 'C24-01-0210-MAN121', 'SUCUANO', 'KESHIA MARIE', 'LOREGA', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(211, 'C24-01-0211-MAN121', 'SUMBELING', 'JAY ANN', 'ORDINARIO', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(212, 'C24-01-0212-MAN121', 'TADLIP', 'ELIZABETH', 'MANGANA', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(213, 'C24-01-0213-MAN121', 'TAGHOY', 'ANDRETTI LUIS', 'BENAMER', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(214, 'C24-01-0214-MAN121', 'TANJAY', 'DANICA FAITH', 'TULING', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(215, 'C24-01-0215-MAN121', 'TAURO', 'JANE', 'ALCONTIN', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(216, 'C24-01-0216-MAN121', 'TAURO', 'JED', 'ALCONTIN', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(217, 'C24-01-0217-MAN121', 'TAUTO-AN', 'LAURENCE', 'BOOC', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(218, 'C24-01-0218-MAN121', 'TIBAY', 'LUI JAY', 'SANCHEZ', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(219, 'C24-01-0219-MAN121', 'TUMULAK', 'SOPHIA MAE', 'ROSALES', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(220, 'C24-01-0220-MAN121', 'TUTTUH', 'ALNUR', 'PARADJI', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(221, 'C24-01-0221-MAN121', 'UNABIA', 'ANTHONY', 'SAGADSAD', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(222, 'C24-01-0222-MAN121', 'VEGA', 'MARK LLOYD', 'MALAZARTE', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(223, 'C24-01-0223-MAN121', 'VEQUIZO', 'ZEUS INNO', 'REGADO', 'BSBA', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(224, 'C24-01-0224-MAN121', 'VIAGEDOR', 'JG LANCE', 'DAGOY', 'BSBA', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(225, 'C24-01-0225-MAN121', 'VILLALON', 'JASMINE', 'OYAO', 'BSBA', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(226, 'C24-01-0226-MAN121', 'VIOLANGO', 'KAYE MAE', 'TANTAN', 'BSBA', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(227, 'C24-01-0227-MAN121', 'YANGYANG', 'LINDSEY', 'HEMPISO', 'BSBA', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(228, 'C24-01-0228-MAN121', 'ABRENICA', 'NATHAN', 'GIMENEZ', 'BSCS', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(229, 'C24-01-0229-MAN121', 'ARPON', 'MARIAN NICOL', 'CAPIN', 'BSCS', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(230, 'C24-01-0230-MAN121', 'BALDEVIESO', 'JAY-R', 'PANES', 'BSCS', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(231, 'C24-01-0231-MAN121', 'BORNEA', 'LARNE', 'LOPEZ', 'BSCS', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(232, 'C24-01-0232-MAN121', 'CALIXTON', 'SEAN COLE', 'PLEA’OS', 'BSCS', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(233, 'C24-01-0233-MAN121', 'CARDIENTE', 'KIRK LIAM', 'MELELOA', 'BSCS', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(234, 'C24-01-0234-MAN121', 'CELEDONIO', 'ZYRENE', 'GRANADA', 'BSCS', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(235, 'C24-01-0235-MAN121', 'CHAVEZ', 'JEZIEL JEAN ROSE', 'BELLEZA', 'BSCS', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(236, 'C24-01-0236-MAN121', 'DACLIZON', 'CHRISTIAN', 'NOYA', 'BSCS', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(237, 'C24-01-0237-MAN121', 'DECLANAN', 'MARIA CLEARE', 'BAYNO', 'BSCS', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(238, 'C24-01-0238-MAN121', 'DEL CASTILLO', 'MYRELOUIE', 'FLORES', 'BSCS', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(239, 'C24-01-0239-MAN121', 'DESPI', 'KENT', 'ARANGCON', 'BSCS', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(240, 'C24-01-0240-MAN121', 'ESGANA', 'RANELA', '-', 'BSCS', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(241, 'C24-01-0241-MAN121', 'GODORNES', 'JAY SHAN', 'DEGAMO', 'BSCS', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(242, 'C24-01-0242-MAN121', 'GONZALES', 'JADE', 'STA. MARIA', 'BSCS', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(243, 'C24-01-0243-MAN121', 'GULFAN', 'GLENN MYKHEL', 'VALIENTE', 'BSCS', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(244, 'C24-01-0244-MAN121', 'JUMAO-AS', 'KEANE', 'ARMENION', 'BSCS', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(245, 'C24-01-0245-MAN121', 'KISKIS', 'MARLO', 'MERCADO', 'BSCS', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(246, 'C24-01-0246-MAN121', 'LABASTIDA', 'DANIEL VINCE', 'SECHICO', 'BSCS', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(247, 'C24-01-0247-MAN121', 'LLANITA', 'KENT JOHN', 'CABAGUE', 'BSCS', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(248, 'C24-01-0248-MAN121', 'MANAYON', 'JOHN ROBEN', 'GAROTE', 'BSCS', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(249, 'C24-01-0249-MAN121', 'MANGYAW', 'CHARLIE', 'CASIANO', 'BSCS', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(250, 'C24-01-0250-MAN121', 'MARA-ASIN', 'FELMAR', 'AREDIDON', 'BSCS', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(251, 'C24-01-0251-MAN121', 'MARIKIT', 'CRIMA NICOLE', 'PULVERA', 'BSCS', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(252, 'C24-01-0252-MAN121', 'OTADOY', 'JOHN DAVE', 'LACANDULA', 'BSCS', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(253, 'C24-01-0253-MAN121', 'PESCADERO', 'RAPHAEL SIMONE ODDY', 'RAYCO', 'BSCS', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(254, 'C24-01-0254-MAN121', 'POVADORA', 'IRISH CLAIR', 'PADAPAT', 'BSCS', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(255, 'C24-01-0255-MAN121', 'QUILLA', 'JAMES KEVIN', 'JUGARAP', 'BSCS', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(256, 'C24-01-0256-MAN121', 'QUIMBO', 'ROSEMARIE', 'CABATINGAN', 'BSCS', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(257, 'C24-01-0257-MAN121', 'RODRIGUEZ', 'ANGEL MAE', 'PAMAYBAY', 'BSCS', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(258, 'C24-01-0258-MAN121', 'SANCHEZ', 'JENNY ANNE', 'BARRIENTOS', 'BSCS', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(259, 'C24-01-0259-MAN121', 'SAYSON', 'MARICEL', 'ENRIQUEZ', 'BSCS', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(260, 'C24-01-0260-MAN121', 'SECO', 'JEHLIA', 'PIEDAD', 'BSCS', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(261, 'C24-01-0261-MAN121', 'SUMALINOG', 'CAROLYN', 'BAGUIO', 'BSCS', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(262, 'C24-01-0262-MAN121', 'TELAR', 'ROYETTE ANDREI', 'COSTO', 'BSCS', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(263, 'C24-01-0263-MAN121', 'TUGBONG', 'LEMAR', 'VILLAHERMOSA', 'BSCS', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(264, 'C24-01-0264-MAN121', 'UNDANG', 'JOSH', 'DOBLE', 'BSCS', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(265, 'C24-01-0265-MAN121', 'WALTER', 'CHRISTIAN EMMANUEL', 'PEPITO', 'BSCS', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(266, 'C24-01-0266-MAN121', 'YLAGAN', 'THOM CLEMENT', 'CONGSON', 'BSCS', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(267, 'C24-01-0267-MAN121', 'ZABATE', 'JOWIE LARA', '-', 'BSCS', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(268, 'C24-01-0268-MAN121', 'ABELLA', 'ANGEL ANNE', 'ALTERADO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(269, 'C24-01-0269-MAN121', 'ABELLA', 'LEAH', '-', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(270, 'C24-01-0270-MAN121', 'ABOABO', 'ALLYA MAE', 'OTEDA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(271, 'C24-01-0271-MAN121', 'ABRAHAN', 'KENT', 'PADAYAO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(272, 'C24-01-0272-MAN121', 'AGAN', 'BABY JEAN', '-', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(273, 'C24-01-0273-MAN121', 'AGUILAR', 'JULIANA', 'DALPA', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(274, 'C24-01-0274-MAN121', 'ALBINO', 'MARL GEBZON', 'ASOY', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(275, 'C24-01-0275-MAN121', 'ALCANTARA', 'CONIE', 'BACULPO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(276, 'C24-01-0276-MAN121', 'ALCARIA', 'SHANE', 'AUMAN', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(277, 'C24-01-0277-MAN121', 'ALCORIZA', 'CHARLES LORENZ', 'SASO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(278, 'C24-01-0278-MAN121', 'ALEGADO', 'JHED VINCENT', 'G', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(279, 'C24-01-0279-MAN121', 'ALGA', 'KHIM', 'TAMPUS', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(280, 'C24-01-0280-MAN121', 'ALIBO', 'KISLY', 'PAQUIBOT', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(281, 'C24-01-0281-MAN121', 'ALIMOREN', 'CRIS JOHN', '-', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(282, 'C24-01-0282-MAN121', 'ALIPAN', 'ELIANA', 'SALANGRON', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(283, 'C24-01-0283-MAN121', 'ALUB', 'LOVELY DIANNE', 'ALQUIZAR', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(284, 'C24-01-0284-MAN121', 'AMAMANGPANG', 'JESSA', 'CARUZ', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(285, 'C24-01-0285-MAN121', 'AMANCIO', 'ERLYN JOY', 'EWICAN', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(286, 'C24-01-0286-MAN121', 'AMISTAD', 'DANIELA', 'OYAO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(287, 'C24-01-0287-MAN121', 'AMIT', 'JOHN LLOYD', 'J', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(288, 'C24-01-0288-MAN121', 'AMIT', 'SHANE ANDRIE', 'TANEO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(289, 'C24-01-0289-MAN121', 'AMODIA', 'CHRISTIAN DALE', 'CASTILLAS', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(290, 'C24-01-0290-MAN121', 'AMOIN', 'HAZELGRACE', 'AGNES', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(291, 'C24-01-0291-MAN121', 'AMORIN', 'FRANCES ANGELA', 'OCAMPO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(292, 'C24-01-0292-MAN121', 'ANDO', 'LOVE', 'PERBIS', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(293, 'C24-01-0293-MAN121', 'ANDUS', 'JAY', 'ABAYON', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(294, 'C24-01-0294-MAN121', 'ANDUS', 'KEVIN', 'ABAYON', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(295, 'C24-01-0295-MAN121', 'ANGHAG', 'JONNA ROSE', 'DELIMA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(296, 'C24-01-0296-MAN121', 'ANITO', 'SHAKIRA JOYCE', '-', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(297, 'C24-01-0297-MAN121', 'ANTOLIHAO', 'AZIEL ROSE', 'MARABULAS', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(298, 'C24-01-0298-MAN121', 'APARRE', 'SASKIA ANDREA', 'OLIVEROS', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(299, 'C24-01-0299-MAN121', 'APAS', 'IVAN JUSHLEE', 'NARBASA', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(300, 'C24-01-0300-MAN121', 'AQUITAN', 'LEANNE KRISTELL', 'SUBRIDO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(301, 'C24-01-0301-MAN121', 'ARANTE', 'CHRISTINE', 'LUPERTE', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(302, 'C24-01-0302-MAN121', 'ARBASTO', 'DHAVE', 'AUGUSTO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(303, 'C24-01-0303-MAN121', 'ARCELO', 'ANGEL', 'LABAJO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(304, 'C24-01-0304-MAN121', 'ARELLANO', 'MA. FAITH FE', 'O', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(305, 'C24-01-0305-MAN121', 'ARENAS', 'VINCENT LLOYD', 'CONCHA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(306, 'C24-01-0306-MAN121', 'ARNADO', 'AIRA MAE', 'LAUREL', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(307, 'C24-01-0307-MAN121', 'ARNADO', 'ARLES', 'LEBRERO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(308, 'C24-01-0308-MAN121', 'ARQUILLANO', 'DB ARTHUR JEAN', 'ROA', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(309, 'C24-01-0309-MAN121', 'ASTILLERO', 'VAN JUSTINE', 'MANATAD', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(310, 'C24-01-0310-MAN121', 'ATAMOSA', 'JADE CLITE', 'CANSERAN', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(311, 'C24-01-0311-MAN121', 'ATIS', 'REZEL GRACE', 'MERCADER', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(312, 'C24-01-0312-MAN121', 'AUDITOR', 'LEMUEL', 'ARCOLO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(313, 'C24-01-0313-MAN121', 'AUGUSTO', 'NIKKA MAY', 'ESTARDO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(314, 'C24-01-0314-MAN121', 'AUMAN', 'JAMES KIRBY', 'IBALE', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(315, 'C24-01-0315-MAN121', 'AUSTERO', 'JENARA', 'AMIGABLE', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(316, 'C24-01-0316-MAN121', 'AVENIDO', 'ANGEL MAE', 'CERIO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(317, 'C24-01-0317-MAN121', 'AYING', 'KATE NICOLE', 'MALINGIN', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(318, 'C24-01-0318-MAN121', 'AYING', 'STEVEN LEE', 'BORINAGA', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(319, 'C24-01-0319-MAN121', 'BABATUAN', 'SHERELYN', 'PANGATUNGAN', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38');
INSERT INTO `students` (`id`, `student_id`, `last_name`, `first_name`, `middle_name`, `course`, `level`, `status`, `house`, `password`, `email`, `phone`, `profile_pic`, `is_active`, `created_at`, `updated_at`) VALUES
(320, 'C24-01-0320-MAN121', 'BACHARO', 'KHRYZIEL XHIEN', '-', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(321, 'C24-01-0321-MAN121', 'BACTUNG', 'KARINA VALERIE', 'V', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(322, 'C24-01-0322-MAN121', 'BACULPO', 'GLORY MHEE', 'OCON', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(323, 'C24-01-0323-MAN121', 'BAHIA', 'KENT ANGELO', 'DUCOS', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(324, 'C24-01-0324-MAN121', 'BAJAR', 'CARLO', 'BACALLA', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(325, 'C24-01-0325-MAN121', 'BALANAY', 'DIRK NOWITZKI', 'CESPON', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(326, 'C24-01-0326-MAN121', 'BALINGCASAG', 'PRECIOUS LARA', 'ESTIBAT', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(327, 'C24-01-0327-MAN121', 'BALINGIT', 'SHARLA SHAYNE', 'LABRADO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(328, 'C24-01-0328-MAN121', 'BALINGKIT', 'CRYSTAL MAE', '-', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(329, 'C24-01-0329-MAN121', 'BANDOLON', 'CHENELYN', 'SETENTA', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(330, 'C24-01-0330-MAN121', 'BAPOR', 'JUSTINE CLOYD', 'CARO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(331, 'C24-01-0331-MAN121', 'BARABA', 'PELROSE', 'ALAA+A', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(332, 'C24-01-0332-MAN121', 'BARANGGAN', 'HAZEL', 'BABIDA', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(333, 'C24-01-0333-MAN121', 'BARANGIAN', 'MARK', '-', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(334, 'C24-01-0334-MAN121', 'BARATAS', 'RINO', 'ASNA', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(335, 'C24-01-0335-MAN121', 'BARQUIN', 'LESLIE JANE', '-', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(336, 'C24-01-0336-MAN121', 'BARREDO', 'IVY JOY', 'CAPARIDA', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(337, 'C24-01-0337-MAN121', 'BARRIENTOS', 'FRANZY NYSE', 'CANTAL', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(338, 'C24-01-0338-MAN121', 'BARROSA', 'KRISTEL JEAN', 'PEPITO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(339, 'C24-01-0339-MAN121', 'BASBAS', 'KRISTINE MAE', 'BALLENA', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(340, 'C24-01-0340-MAN121', 'BATICTC', 'JOHNWEN', 'SISMO-AN', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(341, 'C24-01-0341-MAN121', 'BAYKING', 'NIA’A', 'TORREON', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(342, 'C24-01-0342-MAN121', 'BAYLOSIS', 'NHERIE', 'HINAYAS', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(343, 'C24-01-0343-MAN121', 'BAYO', 'DANIZE', 'TEJENO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(344, 'C24-01-0344-MAN121', 'BEJO', 'JERALD EARL', '-', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(345, 'C24-01-0345-MAN121', 'BENSON', 'GLYCA MARIE', '-', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(346, 'C24-01-0346-MAN121', 'BENTOY', 'CAYENNE', 'BALLERA', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(347, 'C24-01-0347-MAN121', 'BENTULAN', 'ZANE LOURENZ', 'DUNGOG', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(348, 'C24-01-0348-MAN121', 'BERAN', 'SHIELA MAE', 'PADUA', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(349, 'C24-01-0349-MAN121', 'BERDIN', 'KEVIN', 'COLLAMAR', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(350, 'C24-01-0350-MAN121', 'BERDIN', 'SLIER', 'GAUM', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(351, 'C24-01-0351-MAN121', 'BERDON', 'ANGELIKA MAY', 'TORIFEL', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(352, 'C24-01-0352-MAN121', 'BERDON', 'MARJORIE', 'MONSANTO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(353, 'C24-01-0353-MAN121', 'BESABELLA', 'JESUOL', 'RAMOS', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(354, 'C24-01-0354-MAN121', 'BIHAG', 'NORYN', 'ORIT', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(355, 'C24-01-0355-MAN121', 'BILLIONES', 'JOHN MARK', 'SUICO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(356, 'C24-01-0356-MAN121', 'BONGANCISO', 'EMIKLY', 'ALMIRANTE', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(357, 'C24-01-0357-MAN121', 'BORABO', 'ASHLEY NICOLE', 'JIMENEZ', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(358, 'C24-01-0358-MAN121', 'BORCELAS', 'JOWELA', 'ZABATE', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(359, 'C24-01-0359-MAN121', 'BORDO', 'ALEXES DANE', 'MENDOZA', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(360, 'C24-01-0360-MAN121', 'BORRES', 'JOHN DYLAN', 'AGBAY', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(361, 'C24-01-0361-MAN121', 'BOTE', 'ESHEEM SHILLY', 'S', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(362, 'C24-01-0362-MAN121', 'BRANZUELA', 'MIKYLA ANGEL', 'BASUBAS', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(363, 'C24-01-0363-MAN121', 'BRASALUTE', 'KEN VINCENT', 'BURLAOS', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(364, 'C24-01-0364-MAN121', 'BUEN', 'KYLE ANDREA', 'GOLIAT', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(365, 'C24-01-0365-MAN121', 'BUTAL', 'RHEA MAE', 'DUAZO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(366, 'C24-01-0366-MAN121', 'BUTRON', 'DAISY ROSE', 'VISALES', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(367, 'C24-01-0367-MAN121', 'CAÑO', 'FRANZ JOSEPH PATRICK', 'SANTOS', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(368, 'C24-01-0368-MAN121', 'CABAHUG', 'AVIEGAIL', 'RIVERA', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(369, 'C24-01-0369-MAN121', 'CABAHUG', 'CHRISTIAN BRYLE', 'ARANIEGO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(370, 'C24-01-0370-MAN121', 'CABAHUG', 'EDUARDO', 'BACATIO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(371, 'C24-01-0371-MAN121', 'CABAHUG', 'THOM VENICE', '-', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(372, 'C24-01-0372-MAN121', 'CABAJAR', 'FRED LOUIE', 'DELA VICTORIA', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(373, 'C24-01-0373-MAN121', 'CABALLERO', 'KENETH LOYD', 'SABROSO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(374, 'C24-01-0374-MAN121', 'CABALQUINTO', 'ALJANE', 'SINOY', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(375, 'C24-01-0375-MAN121', 'CABASAN', 'CHENEH', 'BASAY', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(376, 'C24-01-0376-MAN121', 'CABATINGAN', 'RHEA MAE', '-', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(377, 'C24-01-0377-MAN121', 'CABILAN', 'JOHN LAYMAR', 'LAGASO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(378, 'C24-01-0378-MAN121', 'CABRERA', 'MAE', 'BRIGOLI', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(379, 'C24-01-0379-MAN121', 'CABURATAN', 'HONEYBEL', 'TOGONON', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(380, 'C24-01-0380-MAN121', 'CAGANG', 'APRIL JOY', '-', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(381, 'C24-01-0381-MAN121', 'CAGANG', 'BRIGILAV', 'JUDAYA', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(382, 'C24-01-0382-MAN121', 'CAJES', 'KIMBERLY', 'AYING', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(383, 'C24-01-0383-MAN121', 'CALUMBA', 'ALEXIS', 'NANO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(384, 'C24-01-0384-MAN121', 'CAMBAYA', 'QUEEN JHUNCELYN', 'VISDA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(385, 'C24-01-0385-MAN121', 'CAMINADE', 'SHANE', 'TULIPAS', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(386, 'C24-01-0386-MAN121', 'CAMPOS', 'MARIEL', 'SABANDO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(387, 'C24-01-0387-MAN121', 'CANILLO', 'CHRISTIAN JAKE', 'BARAN', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(388, 'C24-01-0388-MAN121', 'CANO', 'KHER', 'BITCO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(389, 'C24-01-0389-MAN121', 'CAPANGPANGAN', 'DARIAN MELUZ', 'DIANO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(390, 'C24-01-0390-MAN121', 'CAPIN', 'SHANIE ROSE', 'DANAO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(391, 'C24-01-0391-MAN121', 'CARBONERO', 'SHAMIEL DAZS', 'FUENTES', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(392, 'C24-01-0392-MAN121', 'CARRIAGA', 'SEAN PAUL', 'ESPARRAGUERRA', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(393, 'C24-01-0393-MAN121', 'CARTON', 'NOVY JANE', 'CABALHUG', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(394, 'C24-01-0394-MAN121', 'CARULASAN', 'JAKE', '-', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(395, 'C24-01-0395-MAN121', 'CASERES', 'JULINA', 'PADILLA', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(396, 'C24-01-0396-MAN121', 'CASINILLO', 'GRACE ANN', '-', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(397, 'C24-01-0397-MAN121', 'CASINILLO', 'JAY CLIFFORD', 'ELEGINO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(398, 'C24-01-0398-MAN121', 'CASTANIARES', 'KIMVERLY', 'JOSE', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(399, 'C24-01-0399-MAN121', 'CATALAN', 'IRENE BEA', 'CAMASURA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(400, 'C24-01-0400-MAN121', 'CATALUA’A', 'CHRISTIAN JAY', 'MACALITONG', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(401, 'C24-01-0401-MAN121', 'CATALUÑA', 'KRISTINE', 'YERRO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(402, 'C24-01-0402-MAN121', 'CAVAN', 'SAVINA MAE', 'CONDES', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(403, 'C24-01-0403-MAN121', 'CEBALLOS', 'SHAIRA', 'OSABEL', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(404, 'C24-01-0404-MAN121', 'CEDANTO', 'ALEXA', 'MONGAYA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(405, 'C24-01-0405-MAN121', 'CENIZA', 'SAINT JOSEPH', 'CANTONA', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(406, 'C24-01-0406-MAN121', 'CHOI', 'ANNA MAE', 'LAPIÑA', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(407, 'C24-01-0407-MAN121', 'CIMAFRANCA', 'EDRYAN', 'LANGUIDO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(408, 'C24-01-0408-MAN121', 'COLINA', 'KISHIA ANGEL', 'REMEDIO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(409, 'C24-01-0409-MAN121', 'COMAYAS', 'MITCHE BOY', '-', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(410, 'C24-01-0410-MAN121', 'COMETA', 'LUIGIE', 'PEREZ', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(411, 'C24-01-0411-MAN121', 'COMPUESTO', 'ERIKA', 'IGOT', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(412, 'C24-01-0412-MAN121', 'CORDILLA', 'NICOLE GRACE', 'D', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(413, 'C24-01-0413-MAN121', 'COSEP', 'CYRILL', 'TAMPON', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(414, 'C24-01-0414-MAN121', 'CUADRA', 'KAROL JOSEF', 'SUGAROL', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(415, 'C24-01-0415-MAN121', 'CUEVA', 'SHEENA', 'BACALLA', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(416, 'C24-01-0416-MAN121', 'CUIZON', 'JHIAN ANDRIE', 'M', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(417, 'C24-01-0417-MAN121', 'CUTILLAS', 'JOHN CARLO', 'SUICO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(418, 'C24-01-0418-MAN121', 'CUYA', 'PRINCE BYRON', 'WENCESLAO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(419, 'C24-01-0419-MAN121', 'DAA’O', 'HENSON', 'HIYAS', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(420, 'C24-01-0420-MAN121', 'DACULLO', 'JHON LOUI', 'MEJIAS', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(421, 'C24-01-0421-MAN121', 'DAGASDAS', 'ANGEL', 'ABERIN', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(422, 'C24-01-0422-MAN121', 'DAGOOC', 'DAISYRAE', 'GULIBAN', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(423, 'C24-01-0423-MAN121', 'DANAO', 'HIENZHRON', 'MUNDIN', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(424, 'C24-01-0424-MAN121', 'DANGEL', 'CLENT', 'ARMENTO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(425, 'C24-01-0425-MAN121', 'DANIEL', 'MEGAN', 'M', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(426, 'C24-01-0426-MAN121', 'DARNAYLA', 'DARLING', 'COSEP', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(427, 'C24-01-0427-MAN121', 'DAYUDAY', 'JUVY', 'CAPOY', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(428, 'C24-01-0428-MAN121', 'DEGALA', 'CAROLYN', 'OCHEA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(429, 'C24-01-0429-MAN121', 'DEHAYCO', 'MAE ANN', 'PUEBLA', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(430, 'C24-01-0430-MAN121', 'DEJACTO', 'JEFFERSON', 'SAGARINO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(431, 'C24-01-0431-MAN121', 'DELA CRUZ', 'GEAN', '-', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(432, 'C24-01-0432-MAN121', 'DELA FUENTE', 'REY', 'RICAFORT', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(433, 'C24-01-0433-MAN121', 'DELA FUENTE', 'TREXIE', 'RICAFORT', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(434, 'C24-01-0434-MAN121', 'DELA PEA’A', 'DANICA', 'SAYSON', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(435, 'C24-01-0435-MAN121', 'DELA RIARTE', 'ARVIN', 'BELLITA', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(436, 'C24-01-0436-MAN121', 'DELA TORRE', 'JUN KIER', 'PAROJINOG', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(437, 'C24-01-0437-MAN121', 'DEMARAYE', 'CHARMEL', 'MEGABON', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(438, 'C24-01-0438-MAN121', 'DEMPAS', 'JOHN CARLO', 'VILLACORTE', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(439, 'C24-01-0439-MAN121', 'DERIADA', 'SHANEL MAE', 'SAVIOR', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(440, 'C24-01-0440-MAN121', 'DESUCATAN', 'CARL JOHN', 'COMINGUEZ', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(441, 'C24-01-0441-MAN121', 'DEVERA', 'JOHN RUSSEL', 'CASIO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(442, 'C24-01-0442-MAN121', 'DIACAMOS', 'JEANLIE ANN', '-', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(443, 'C24-01-0443-MAN121', 'DICO', 'CLEY GRACE', 'IGOY', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(444, 'C24-01-0444-MAN121', 'DILAO', 'RAJIV KELCEY', 'DEGAMO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(445, 'C24-01-0445-MAN121', 'DIMARUCUT', 'LYKA ANGELA', 'ALIPORO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(446, 'C24-01-0446-MAN121', 'DIOCAMPO', 'REDJEL', 'ORGE', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(447, 'C24-01-0447-MAN121', 'DIONSON', 'CARL', 'CUTAMORA', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(448, 'C24-01-0448-MAN121', 'DIOSO', 'RJ', 'CACANOG', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(449, 'C24-01-0449-MAN121', 'DONDOYANO', 'ALEXA MAE', '-', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(450, 'C24-01-0450-MAN121', 'DOQUILA', 'MARIEL', 'TAJALE', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(451, 'C24-01-0451-MAN121', 'DUAZO', 'CHRISTINE MAE', 'DUNGOG', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(452, 'C24-01-0452-MAN121', 'DUNGOG', 'JOVIN', 'BERDIN', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(453, 'C24-01-0453-MAN121', 'EFIAN', 'MARC LAURENCE', 'OUANO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(454, 'C24-01-0454-MAN121', 'ENOT', 'JUSTINE LIE', 'UTLANG', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(455, 'C24-01-0455-MAN121', 'ENTERINA', 'JUSTINE', 'HOMECILLO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(456, 'C24-01-0456-MAN121', 'EPA', 'ALEXANDRA MAE', '-', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(457, 'C24-01-0457-MAN121', 'ESCARAN', 'CHUBIL', 'CATIAN', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(458, 'C24-01-0458-MAN121', 'ESPANTE', 'DANIELA', 'CANTAY', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(459, 'C24-01-0459-MAN121', 'ESTIPANO', 'KRISTINE', 'GUILLERMO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(460, 'C24-01-0460-MAN121', 'ESTRADA', 'ALDE JR.', 'PERATER', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(461, 'C24-01-0461-MAN121', 'ESTRERA', 'JOSEPHUS', 'LAMCO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(462, 'C24-01-0462-MAN121', 'EVIDA', 'JEAN CLAIRE', '-', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(463, 'C24-01-0463-MAN121', 'FABILLAR', 'JOCELYN', 'VILLAMOR', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(464, 'C24-01-0464-MAN121', 'FAELNAR', 'DIMPLE MAE', '-', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(465, 'C24-01-0465-MAN121', 'FAJARDO', 'TRACY ANN', 'GOLES', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(466, 'C24-01-0466-MAN121', 'FERNANDEZ', 'IAN', 'MONTEROS', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(467, 'C24-01-0467-MAN121', 'FERNANDEZ', 'MIGUEL', 'REDEMIO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(468, 'C24-01-0468-MAN121', 'FEROLINO', 'JEANSELLE', 'SINOY', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(469, 'C24-01-0469-MAN121', 'FLOR', 'GERRY', 'SUCAYRE', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(470, 'C24-01-0470-MAN121', 'FLORES', 'JHEZLER ALKENT', 'VISPERAS', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(471, 'C24-01-0471-MAN121', 'FLORES', 'JOHN LLOYD', 'TABANAO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(472, 'C24-01-0472-MAN121', 'GABATO', 'JHON JOSEPH', 'MELENDRES', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(473, 'C24-01-0473-MAN121', 'GABISAN', 'JACK STANLEY', 'V', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(474, 'C24-01-0474-MAN121', 'GACUTAN', 'CHARLES', 'DIAMOS', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(475, 'C24-01-0475-MAN121', 'GADRINAB', 'MARY ANN', 'ADAJAR', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(476, 'C24-01-0476-MAN121', 'GALO', 'MARIA JEANY LYN', 'MENDAROS', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(477, 'C24-01-0477-MAN121', 'GALON', 'CARLA MAE', 'TROGANI', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(478, 'C24-01-0478-MAN121', 'GARCIA', 'CAREN JOY', 'CLARO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(479, 'C24-01-0479-MAN121', 'GASTARDO', 'ARIEL', 'VILLARANTE', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(480, 'C24-01-0480-MAN121', 'GASTARDO', 'KIM HAROLD', 'FUENTES', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(481, 'C24-01-0481-MAN121', 'GATCHALIAN', 'LENITH', 'PINOTE', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(482, 'C24-01-0482-MAN121', 'GEGRIMOSA', 'KEITH JANE ANNE', 'PASAOL', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(483, 'C24-01-0483-MAN121', 'GENTILES', 'ANGELIE', 'NGUJO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(484, 'C24-01-0484-MAN121', 'GITGANO', 'KEISHA MARGARETTE', 'FLORES', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(485, 'C24-01-0485-MAN121', 'GORRE', 'MHARIEA AIKAH', '-', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(486, 'C24-01-0486-MAN121', 'GRIPO', 'ALEXIS KARL', 'MEJARES', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(487, 'C24-01-0487-MAN121', 'GUILLANO', 'DIVINE', 'CABALIDA', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(488, 'C24-01-0488-MAN121', 'GUINTO', 'JOANE MARIE', 'B', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(489, 'C24-01-0489-MAN121', 'GUISADIO', 'JOLLYMAR', 'LIBRON', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(490, 'C24-01-0490-MAN121', 'HERBANIA', 'DISEREE ANN', 'ANTIPORTA', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(491, 'C24-01-0491-MAN121', 'HERMOSO', 'JOHANA', 'TAHANLANGIT', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(492, 'C24-01-0492-MAN121', 'HERRERA', 'JAMES CHALRES', '-', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(493, 'C24-01-0493-MAN121', 'HERRERA', 'JEVHELYN', 'RODRIGUEZ', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(494, 'C24-01-0494-MAN121', 'HEYRANA', 'KAREN', 'NOVAL', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(495, 'C24-01-0495-MAN121', 'HUDAYA', 'LOVELYN', 'CASILAC', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(496, 'C24-01-0496-MAN121', 'IBALE', 'XZENLI VON HARVEN', 'CANALES', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(497, 'C24-01-0497-MAN121', 'ICOT', 'J-EN', 'PEPITO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(498, 'C24-01-0498-MAN121', 'IGLORIA', 'JAYMAR', 'SUERTE', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(499, 'C24-01-0499-MAN121', 'IGOT', 'ANNA ROSE', 'P', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(500, 'C24-01-0500-MAN121', 'IGOT', 'JENNY', 'RIPDOS', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(501, 'C24-01-0501-MAN121', 'IGOT', 'KHARL ADRIAN', 'A', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(502, 'C24-01-0502-MAN121', 'IGOT', 'MYLA', 'YONGCO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(503, 'C24-01-0503-MAN121', 'IGOT', 'RISHEL ANN', 'PEPITO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(504, 'C24-01-0504-MAN121', 'IGOY', 'KRISHIA KATE', 'COMEROS', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(505, 'C24-01-0505-MAN121', 'ILIGAN', 'KIMBERLY', 'TAMPUS', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(506, 'C24-01-0506-MAN121', 'ILUSTRISIMO', 'MICHAELA', 'MEDEQUILLO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(507, 'C24-01-0507-MAN121', 'IMPAS', 'AGUSTIN JR.', 'ESTAL', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(508, 'C24-01-0508-MAN121', 'INOC', 'ALAIZA', '-', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(509, 'C24-01-0509-MAN121', 'ISOK', 'CLYDE GREE', '-', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(510, 'C24-01-0510-MAN121', 'ISOK', 'JOHN CHRISTIAN', 'DINOPOL', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(511, 'C24-01-0511-MAN121', 'JAMILI', 'CHRISTIAN', '-', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(512, 'C24-01-0512-MAN121', 'JAVIER', 'LOUIEJAY', 'MANGILAYA', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(513, 'C24-01-0513-MAN121', 'JAYME', 'KIMBERLY', 'DOBLE', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(514, 'C24-01-0514-MAN121', 'JAYME', 'MERRY JHAN', 'DETCHON', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(515, 'C24-01-0515-MAN121', 'JORELLO', 'JAMICA', 'TARUGO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(516, 'C24-01-0516-MAN121', 'JUMAO-AS', 'FELICITY HILARY', 'NOYNAY', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(517, 'C24-01-0517-MAN121', 'LABAPEZ', 'MARCHELLE', 'PAMOTONGAN', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(518, 'C24-01-0518-MAN121', 'LABISORES', 'CHRISTINE ANN', 'GERVACIO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(519, 'C24-01-0519-MAN121', 'LABISTE', 'JESSICA', 'DELANTAR', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(520, 'C24-01-0520-MAN121', 'LABOS', 'NHONA MAE', 'IMPAS', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(521, 'C24-01-0521-MAN121', 'LABUS', 'JONATHAN', 'BERNANTE', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(522, 'C24-01-0522-MAN121', 'LAHOYLAHOY', 'REYAN', 'MANAYON', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(523, 'C24-01-0523-MAN121', 'LALLEN', 'JOHN KEVIN', 'N.', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(524, 'C24-01-0524-MAN121', 'LAMBAYAN', 'NANETH', 'SARNO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(525, 'C24-01-0525-MAN121', 'LAMOCO', 'KARYLL', 'MELENCION', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(526, 'C24-01-0526-MAN121', 'LAMPA', 'JALILAH', 'BAGAY', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(527, 'C24-01-0527-MAN121', 'LAPAZ', 'CHRISTIAN RAY', 'TECSON', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(528, 'C24-01-0528-MAN121', 'LARANJO', 'JAFERLYN', '-', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(529, 'C24-01-0529-MAN121', 'LARIOSA', 'MARC LAWRENCE', '-', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(530, 'C24-01-0530-MAN121', 'LAURON', 'DHEARLY ANNE', 'MOLDES', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(531, 'C24-01-0531-MAN121', 'LAURON', 'KEIR LLOYD', 'LIBUTLIBUT', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(532, 'C24-01-0532-MAN121', 'LAURON', 'LORENCE', 'ANTOLIJAO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(533, 'C24-01-0533-MAN121', 'LAWIS', 'JHEAN ALLEN', 'PITOGO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(534, 'C24-01-0534-MAN121', 'LAYAOG', 'DANIELMAR', 'JUMOLA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(535, 'C24-01-0535-MAN121', 'LAZARITO', 'CHELL JANE', '-', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(536, 'C24-01-0536-MAN121', 'LEGASPINO', 'KRISHA', 'BARIL', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(537, 'C24-01-0537-MAN121', 'LIBOSADA', 'GLADYS MIA', 'N', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(538, 'C24-01-0538-MAN121', 'LICARTE', 'JOLINA', 'SUAN', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(539, 'C24-01-0539-MAN121', 'LIRASAN', 'HEINZ TELEE', 'RAMOS', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(540, 'C24-01-0540-MAN121', 'LOFRANCO', 'PRETCH DENVER', 'CRUZ', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(541, 'C24-01-0541-MAN121', 'LONDRES', 'STEPHANIE SYLE', 'SABRIDO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(542, 'C24-01-0542-MAN121', 'LOPEZ', 'CATHERINE', 'PUEBLAS', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(543, 'C24-01-0543-MAN121', 'LOREGAS', 'KYLA MAE', 'BASUBAS', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(544, 'C24-01-0544-MAN121', 'LOREJO', 'NICOLE', 'ANTONE', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(545, 'C24-01-0545-MAN121', 'MABURA', 'VINCENT CYREL', 'DEMECILLO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(546, 'C24-01-0546-MAN121', 'MAGLASANG', 'KEVIN STEVE', 'ABAYON', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(547, 'C24-01-0547-MAN121', 'MAHINAY', 'RHINA MAE', 'BATULAN', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(548, 'C24-01-0548-MAN121', 'MALAQUE', 'MERLY', 'TORINO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(549, 'C24-01-0549-MAN121', 'MALAZARTE', 'ANDRHEI JUSTINE', 'LINCARO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(550, 'C24-01-0550-MAN121', 'MALBACIAS', 'PRINCE ADRIAN JAY', 'PENIONES', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(551, 'C24-01-0551-MAN121', 'MALOLOY-ON', 'CHRISTIAN CARL', 'APA', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(552, 'C24-01-0552-MAN121', 'MALUYA', 'KATHIA LYNN', 'MASONG', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(553, 'C24-01-0553-MAN121', 'MANDAYA', 'ARMAN JR.', 'EDIOMA', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(554, 'C24-01-0554-MAN121', 'MANGARON', 'JOHN CLYDE', 'PINO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(555, 'C24-01-0555-MAN121', 'MANINANG', 'QUINT MARIEL', 'GAYO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(556, 'C24-01-0556-MAN121', 'MANONGGIRING', 'JOHARRY', 'MANAHAN', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(557, 'C24-01-0557-MAN121', 'MANOS', 'NIEL', 'BARNIDO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(558, 'C24-01-0558-MAN121', 'MAQUILAN', 'MELBIN JR.', 'ABUCAY', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(559, 'C24-01-0559-MAN121', 'MARANGA', 'JESSA MAE', 'CABANDAY', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(560, 'C24-01-0560-MAN121', 'MARIKIT', 'JANTHA MARIZ', 'EVANGELISTA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(561, 'C24-01-0561-MAN121', 'MARIQUIT', 'JODI', 'JUMADAS', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(562, 'C24-01-0562-MAN121', 'MARTEL', 'FATIMA MABETH', 'NODADO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(563, 'C24-01-0563-MAN121', 'MARTUS', 'JOHN PETER', 'ANAZAO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(564, 'C24-01-0564-MAN121', 'MELENCION', 'MICHAEL KYLE', '-', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(565, 'C24-01-0565-MAN121', 'MELENDRES', 'KEN BRYAN', 'VILLAROSA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(566, 'C24-01-0566-MAN121', 'MELGO', 'CHERRY MAE', 'MONTEJO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(567, 'C24-01-0567-MAN121', 'MENDOYOS', 'NICOLE', '-', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(568, 'C24-01-0568-MAN121', 'MENDOZA', 'ASIA DOROTHY', 'TUMULAK', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(569, 'C24-01-0569-MAN121', 'MENDOZA', 'FIRMO JR.', 'GARCIA', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(570, 'C24-01-0570-MAN121', 'MERAL', 'JASMINE', 'PEPITO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(571, 'C24-01-0571-MAN121', 'MERCADO', 'KYLLO', 'TANTAY', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(572, 'C24-01-0572-MAN121', 'MERCADO', 'RJAY', 'AVILO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(573, 'C24-01-0573-MAN121', 'MIRALLO', 'HANNAH JANE', 'SARENAS', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(574, 'C24-01-0574-MAN121', 'MOLEJON', 'MICHELLE', 'ARNEJO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(575, 'C24-01-0575-MAN121', 'MOLINA', 'NASHVILLE', 'RIVERA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(576, 'C24-01-0576-MAN121', 'MONTECILLO', 'CRYSTAL MAE', 'DIPALING', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(577, 'C24-01-0577-MAN121', 'MONTEMOR', 'CHERRY FAITH', 'TABAY', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(578, 'C24-01-0578-MAN121', 'MONTES', 'CHRISTIAN', 'AVENIDO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(579, 'C24-01-0579-MAN121', 'MONTESINO', 'RICO', 'VIGNO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(580, 'C24-01-0580-MAN121', 'MONTOLO', 'MARY ANN ROSE', 'MARTOS', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(581, 'C24-01-0581-MAN121', 'MONTUERTO', 'KAROL SOPHIA', 'VILANDO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(582, 'C24-01-0582-MAN121', 'MORALES', 'REGINE', 'ALGUNO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(583, 'C24-01-0583-MAN121', 'MORALES', 'RIDEL', 'MAKINANO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(584, 'C24-01-0584-MAN121', 'MULLION', 'GRYKA ISHI', 'ALQUIZAR', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(585, 'C24-01-0585-MAN121', 'MUNDIN', 'JOAN', 'GALO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(586, 'C24-01-0586-MAN121', 'MUTIA', 'APRIL JOY', 'MONIDA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(587, 'C24-01-0587-MAN121', 'NABONG', 'MARIE ANGELICA', 'SABLAD', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(588, 'C24-01-0588-MAN121', 'NATURAL', 'JENIEL', 'RICAPLAZA', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(589, 'C24-01-0589-MAN121', 'NAVARRO', 'ALEA FILOMENA', '-', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(590, 'C24-01-0590-MAN121', 'NAVARROZA', 'GHERWEN DAVE', 'PEVIDA', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(591, 'C24-01-0591-MAN121', 'NOEL', 'CHRISTIEN', 'SEPRA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(592, 'C24-01-0592-MAN121', 'NOGALADA', 'FRENCH JOY', 'CONSOLACION', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(593, 'C24-01-0593-MAN121', 'NOVAL', 'ROMER JR.', 'BRACERO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(594, 'C24-01-0594-MAN121', 'NOYNAY', 'CHERRY ANN', '-', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(595, 'C24-01-0595-MAN121', 'OGDIMAN', 'JANCYN', 'PANGATUNGAN', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(596, 'C24-01-0596-MAN121', 'OLARTE', 'RINA MARIE', 'RAMOS', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(597, 'C24-01-0597-MAN121', 'OMILA', 'ALMA', 'ESCOTON', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(598, 'C24-01-0598-MAN121', 'ORONGAN', 'AARON MARK', 'B', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(599, 'C24-01-0599-MAN121', 'OTOM', 'RICHIE', 'OSORNO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(600, 'C24-01-0600-MAN121', 'OUANO', 'JEARENE', 'P', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(601, 'C24-01-0601-MAN121', 'PACARAT', 'MAIRYLL KEITH', 'BRANZUELA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(602, 'C24-01-0602-MAN121', 'PACARDO', 'MARY CHRIS', 'LATAP', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(603, 'C24-01-0603-MAN121', 'PACRIS', 'MARC CHRISTIAN', 'NAPARATE', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(604, 'C24-01-0604-MAN121', 'PADAYAO', 'NICHOLE ANN', 'CADUNGOG', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(605, 'C24-01-0605-MAN121', 'PAGADOR', 'JOHN PAUL', 'SUHOT', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(606, 'C24-01-0606-MAN121', 'PAGALAN', 'JENNERICH', 'CATAYAS', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(607, 'C24-01-0607-MAN121', 'PAGLINAWAN', 'JORALD', 'MONLEON', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(608, 'C24-01-0608-MAN121', 'PAGOBO', 'ALFRED', 'TAN', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(609, 'C24-01-0609-MAN121', 'PAJARILLO', 'RALPH EDISON', 'MIANO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(610, 'C24-01-0610-MAN121', 'PAL', 'PAULO ANTONIO', 'DEGOLLACION', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(611, 'C24-01-0611-MAN121', 'PALGAN', 'GLAIZA KAY', 'PALMA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(612, 'C24-01-0612-MAN121', 'PALINGKOD', 'JEFF IVAN', 'LAMOSTE', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(613, 'C24-01-0613-MAN121', 'PAMISA', 'RAYMOND', '-', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38');
INSERT INTO `students` (`id`, `student_id`, `last_name`, `first_name`, `middle_name`, `course`, `level`, `status`, `house`, `password`, `email`, `phone`, `profile_pic`, `is_active`, `created_at`, `updated_at`) VALUES
(614, 'C24-01-0614-MAN121', 'PAMPLONA', 'JELIAN', 'PAGLINAWAN', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(615, 'C24-01-0615-MAN121', 'PANCHO', 'EUMAR', 'DESCARTIN', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(616, 'C24-01-0616-MAN121', 'PANER', 'RAM JASPER', 'ABELLA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(617, 'C24-01-0617-MAN121', 'PANGATUNGAN', 'LIEZEL MAE', 'PAGOBO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(618, 'C24-01-0618-MAN121', 'PANOY', 'JADE ZOULYCA', 'O.', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(619, 'C24-01-0619-MAN121', 'PANSACALA', 'ARFIL', 'CABRERA', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(620, 'C24-01-0620-MAN121', 'PANTON', 'LOUJEILL ANN', 'HEYROSA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(621, 'C24-01-0621-MAN121', 'PAQUIBOT', 'JERALD', 'HARATA', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(622, 'C24-01-0622-MAN121', 'PAQUIBOT', 'JERO JHEAN', 'TATOY', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(623, 'C24-01-0623-MAN121', 'PAREJA', 'RENCY', 'JUEZAN', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(624, 'C24-01-0624-MAN121', 'PAREJA', 'SHYRAH', 'JUEZAN', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(625, 'C24-01-0625-MAN121', 'PATINDOL', 'DAVE MATTHEW', 'N', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(626, 'C24-01-0626-MAN121', 'PEGALAN', 'JOSE EMMANUEL', 'RODRIGUEZ', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(627, 'C24-01-0627-MAN121', 'PELIGRO', 'ANNA MARIELLE', 'ARMODIA', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(628, 'C24-01-0628-MAN121', 'PENDO', 'JUSTIN', 'LUDIVESE', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(629, 'C24-01-0629-MAN121', 'PEPITO', 'JENNY MAE', 'ICOT', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(630, 'C24-01-0630-MAN121', 'PEPITO', 'JOHN WAYNE', 'ALBERIO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(631, 'C24-01-0631-MAN121', 'PEPITO', 'KIMBERLY', 'HESALTA', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(632, 'C24-01-0632-MAN121', 'PEPITO', 'PAULINE', 'MANABAT', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(633, 'C24-01-0633-MAN121', 'PEPITO', 'RACHEL ANNE', 'DEOCAMPO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(634, 'C24-01-0634-MAN121', 'PILAPIL', 'JB', 'LORE', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(635, 'C24-01-0635-MAN121', 'PITOGO', 'ALEXA RHEA', 'RUIZ', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(636, 'C24-01-0636-MAN121', 'PITOGO', 'KENNETH', 'ARABIS', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(637, 'C24-01-0637-MAN121', 'PITOGO', 'MARK BRYAN', 'CAPUNO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(638, 'C24-01-0638-MAN121', 'PITOGO', 'RHEA MAE', 'PEPITO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(639, 'C24-01-0639-MAN121', 'POGADO', 'ALAIZA ROSE', 'MONZOLIN', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(640, 'C24-01-0640-MAN121', 'POGATA', 'MELANIE', 'ALQUINO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(641, 'C24-01-0641-MAN121', 'POGOY', 'JAMES GHAL', 'ALLONES', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(642, 'C24-01-0642-MAN121', 'PONCE', 'KYLE JOSEPH', '-', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(643, 'C24-01-0643-MAN121', 'PONO', 'KEANRICA', 'L', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(644, 'C24-01-0644-MAN121', 'PONPON', 'ALZHEMER', '-', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(645, 'C24-01-0645-MAN121', 'POTOT', 'RYAN CHRISTIAN', 'BERAME', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(646, 'C24-01-0646-MAN121', 'POVADORA', 'JOHN JAYSON', 'J', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(647, 'C24-01-0647-MAN121', 'PUEBLAS', 'MA. JERSIA', 'ANGANA', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(648, 'C24-01-0648-MAN121', 'QUILLOPAS', 'CATHERINE', 'GUZMAN', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(649, 'C24-01-0649-MAN121', 'QUIMOD', 'SIDNEY LOUIE', '-', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(650, 'C24-01-0650-MAN121', 'QUINTANILLA', 'BRYLLE', 'ALFANTE', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(651, 'C24-01-0651-MAN121', 'QUIRANTE', 'MARIELLE HANNA SHEN', 'GICALE', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(652, 'C24-01-0652-MAN121', 'RABANES', 'JENELYN', 'TAGHOY', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(653, 'C24-01-0653-MAN121', 'RAGAS', 'KENT JOCEL MAE', 'GERONA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(654, 'C24-01-0654-MAN121', 'RASONABLE', 'PATRICIA MAE', 'YDIMNE', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(655, 'C24-01-0655-MAN121', 'REALSE', 'EUNICE ABEGAIL', 'MACALITONG', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(656, 'C24-01-0656-MAN121', 'REBATADO', 'MARVIE', 'GERALIA', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(657, 'C24-01-0657-MAN121', 'RECORTE', 'RICKY RO', 'ESTREMOS', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(658, 'C24-01-0658-MAN121', 'REGALA', 'KYLE EVVAN', 'TUBA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(659, 'C24-01-0659-MAN121', 'REMIZ', 'KATRINA GRACE', 'LUTERO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(660, 'C24-01-0660-MAN121', 'REPDOS', 'SHAKENNA', 'ROJAS', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(661, 'C24-01-0661-MAN121', 'REQUIERME', 'JANLIAH', 'IGOT', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(662, 'C24-01-0662-MAN121', 'REUYAN', 'CHARLOTTE NICOLE', '-', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(663, 'C24-01-0663-MAN121', 'REUYAN', 'SHAINE', 'HERBIETO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(664, 'C24-01-0664-MAN121', 'RIGODON', 'MECA', 'PACOMIO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(665, 'C24-01-0665-MAN121', 'RIVERA', 'JEFFERSON', 'TANATAN', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(666, 'C24-01-0666-MAN121', 'RODRIGO', 'RICH', 'RABOY', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(667, 'C24-01-0667-MAN121', 'ROLDAN', 'WENFORD', 'SANCHEZ', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(668, 'C24-01-0668-MAN121', 'ROLLORATA', 'RECCA LEE', 'GENELASO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(669, 'C24-01-0669-MAN121', 'ROSAL', 'JESSEL ANN', '-', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(670, 'C24-01-0670-MAN121', 'ROSALES', 'LAWRENCE', 'MANLANGIT', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(671, 'C24-01-0671-MAN121', 'ROSKA', 'JESS BERNARD', 'PELAYO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(672, 'C24-01-0672-MAN121', 'ROXAS', 'REASHELE MAE', 'LAHOY', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(673, 'C24-01-0673-MAN121', 'RUIZ', 'SHASSY SHEAN', 'MAGALE', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(674, 'C24-01-0674-MAN121', 'RUSTIA', 'CHRISTIAN', 'DIAZ', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(675, 'C24-01-0675-MAN121', 'SABELINO', 'CLARISA', 'DITON', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(676, 'C24-01-0676-MAN121', 'SABELINO', 'JUREY', 'DITON', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(677, 'C24-01-0677-MAN121', 'SABLAN', 'JENABEL', 'MAGDADARO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(678, 'C24-01-0678-MAN121', 'SACAY', 'PAUL ANTHONY', 'CASTILLO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(679, 'C24-01-0679-MAN121', 'SAGARINO', 'MOSSES TERAD', 'CUEVAS', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(680, 'C24-01-0680-MAN121', 'SALINGUHAY', 'MABEL', 'AYING', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(681, 'C24-01-0681-MAN121', 'SALUBRE', 'CHARLES KRISTOPHER', 'SONIEGA', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(682, 'C24-01-0682-MAN121', 'SAMOREN', 'GRACE LHYNN', 'JUMAWID', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(683, 'C24-01-0683-MAN121', 'SANCEJA', 'JAMES', 'JAMILI', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(684, 'C24-01-0684-MAN121', 'SANCHEZ', 'EDUARDO', 'SACMAR', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(685, 'C24-01-0685-MAN121', 'SANCHEZ', 'RHEYBER JAMES', 'MAMABOY', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(686, 'C24-01-0686-MAN121', 'SARRO', 'KAYE JULIAH', 'VILLOREJO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(687, 'C24-01-0687-MAN121', 'SAYAM', 'KHENT GABRIEL', '-', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(688, 'C24-01-0688-MAN121', 'SEBALLO', 'CHINA', 'BETACHE', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(689, 'C24-01-0689-MAN121', 'SEMIRA', 'CRISTINE', 'QUIREMET', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(690, 'C24-01-0690-MAN121', 'SENARLO', 'RENEBOY JR.', 'BELLEZA', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(691, 'C24-01-0691-MAN121', 'SENDING', 'RICKY', '-', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(692, 'C24-01-0692-MAN121', 'SENERPIDA', 'KENT', 'EPE', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(693, 'C24-01-0693-MAN121', 'SEPE', 'CRIS', 'PADILLA', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(694, 'C24-01-0694-MAN121', 'SEVILLEJO', 'SHANE MAE', 'SEVILLENO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(695, 'C24-01-0695-MAN121', 'SILAWAN', 'JOHN MARK', 'CARDINO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(696, 'C24-01-0696-MAN121', 'SILVANO', 'SHIELA MAE', 'BECALDO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(697, 'C24-01-0697-MAN121', 'SINAGPULO', 'EARL JUSTINE', 'NAYLON', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(698, 'C24-01-0698-MAN121', 'SINGSON', 'LOURENCE', 'TANEO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(699, 'C24-01-0699-MAN121', 'SINTOS', 'JADE VENICE', 'RAYANDAYAN', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(700, 'C24-01-0700-MAN121', 'SOLEDAD', 'HANNAH FAITH', '-', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(701, 'C24-01-0701-MAN121', 'SOLON', 'MARK CYRON', 'PINOTE', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(702, 'C24-01-0702-MAN121', 'SORINGA', 'ROEL JR.', 'ROSAL', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(703, 'C24-01-0703-MAN121', 'SUAN', 'FAITH CHAIRES', 'GACITA', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(704, 'C24-01-0704-MAN121', 'SUCO JR.', 'JUVY', 'MAATA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(705, 'C24-01-0705-MAN121', 'SUGAROL', 'SHEILA', 'GONZAGA', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(706, 'C24-01-0706-MAN121', 'SULLANO', 'KRISTINE JANE', 'PEROLINO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(707, 'C24-01-0707-MAN121', 'SUPERALES', 'JESSA MAE', 'AUZA', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(708, 'C24-01-0708-MAN121', 'TADENA', 'CHRISTIAN', 'AGRAVANTE', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(709, 'C24-01-0709-MAN121', 'TAGALOG', 'JEAN ROSE', 'A', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(710, 'C24-01-0710-MAN121', 'TAMAGOS', 'CHERRY', 'CENA', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(711, 'C24-01-0711-MAN121', 'TAMAYO', 'CJ', 'BITCO', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(712, 'C24-01-0712-MAN121', 'TAMO-O', 'TRISHA MAE', 'MANGOLARE', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(713, 'C24-01-0713-MAN121', 'TAMPEPE', 'JEAN CLERCK', 'SUNOR', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(714, 'C24-01-0714-MAN121', 'TAMPUS', 'ASHLEY LYSA', 'FELISILDA', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(715, 'C24-01-0715-MAN121', 'TAMPUS', 'LERA MAE', 'ARNEJO', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(716, 'C24-01-0716-MAN121', 'TANEO', 'NINA MAE', 'MIQUIABAS', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(717, 'C24-01-0717-MAN121', 'TANOS', 'AIMEE', 'NACUA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(718, 'C24-01-0718-MAN121', 'TAOY', 'JELIAME', 'AMOSCO', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(719, 'C24-01-0719-MAN121', 'TAPANAN', 'CHAIN', 'FLORES', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(720, 'C24-01-0720-MAN121', 'TAPLAC', 'CHERRYMAE', 'BALBUENA', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(721, 'C24-01-0721-MAN121', 'TAUTHO', 'KC EMMANUEL', 'M.', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(722, 'C24-01-0722-MAN121', 'TAYROS', 'RELGEN', 'LALONGA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(723, 'C24-01-0723-MAN121', 'TEJADA', 'JEEHAN MAE', 'RONDINA', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(724, 'C24-01-0724-MAN121', 'TIBON', 'MARY KIMBERLY', 'PATIGAYON', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(725, 'C24-01-0725-MAN121', 'TIOGO', 'STEPHEN GIL', 'POLIGRATES', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(726, 'C24-01-0726-MAN121', 'TOLO', 'LAWRENCE', 'CODERA', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(727, 'C24-01-0727-MAN121', 'TORREJAS', 'ZYRA MARIE', 'JACA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(728, 'C24-01-0728-MAN121', 'TORREON', 'ANGELITO JR.', 'INOC', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(729, 'C24-01-0729-MAN121', 'TOYOTO', 'JOHN MICHAEL', 'M', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(730, 'C24-01-0730-MAN121', 'TUDLASAN', 'AFARIE', 'BASISTER', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(731, 'C24-01-0731-MAN121', 'TUMAYAO', 'LORRAMAE', '-', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(732, 'C24-01-0732-MAN121', 'TUMULAK', 'LOUISE JAKE', 'IPANAG', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(733, 'C24-01-0733-MAN121', 'TUMULAK', 'ROGINE', 'PAMENTO-AN', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(734, 'C24-01-0734-MAN121', 'TUNGAL', 'DIVINE GRACE', 'MONTERA', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(735, 'C24-01-0735-MAN121', 'UBALDE', 'SHIELANI', 'ASUGAN', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(736, 'C24-01-0736-MAN121', 'ULTIMAR', 'AILYN JOY', 'MEJASCO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(737, 'C24-01-0737-MAN121', 'UROT', 'VANESS', 'DOOT', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(738, 'C24-01-0738-MAN121', 'VENTURA', 'LOISE MARIE', 'NAVARRO', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(739, 'C24-01-0739-MAN121', 'VILLAFRANCA', 'RYAN', 'QUIJOTE', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(740, 'C24-01-0740-MAN121', 'VILLAMOR', 'JHON JAYVIE', 'LUMANDAS', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(741, 'C24-01-0741-MAN121', 'VILLEGAS', 'HYA MAE', 'BASTASA', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(742, 'C24-01-0742-MAN121', 'WAGAS', 'MA. ELAINE', 'MAHINAY', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(743, 'C24-01-0743-MAN121', 'WAGWAG', 'JANE MILLICENT', 'CASTILLAS', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(744, 'C24-01-0744-MAN121', 'YABO', 'MARY FIONA', 'LAGARDE', 'BSHM', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(745, 'C24-01-0745-MAN121', 'YAP', 'VINCE', 'DIAZ', 'BSHM', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(746, 'C24-01-0746-MAN121', 'YEOCA', 'MARY JANE', 'CANLUBO', 'BSHM', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(747, 'C24-01-0747-MAN121', 'YMBONG', 'ALLEN KYLE', 'G', 'BSHM', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(748, 'C24-01-0748-MAN121', 'ZOZOBRADO', 'CHRISTIAN', '-', 'BSHM', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(749, 'C24-01-0749-MAN121', 'ABPIT', 'RUBIE ANNE', 'VALLENTE', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(750, 'C24-01-0750-MAN121', 'ABRIGANA', 'CLYDE AUDREY', 'MAHINAY', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(751, 'C24-01-0751-MAN121', 'ACILO', 'ANGEL JOYCE', 'SINTOS', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(752, 'C24-01-0752-MAN121', 'ACOJEDO', 'SAM ULYSSES', 'SULLANO', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(753, 'C24-01-0753-MAN121', 'ACUIN', 'BENJIE', 'BULGADO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(754, 'C24-01-0754-MAN121', 'ADOLFO', 'CHRISTIAN', '-', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(755, 'C24-01-0755-MAN121', 'AGUIPO', 'JOSHUA', 'ERMAC', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(756, 'C24-01-0756-MAN121', 'ALBARICO', 'SAMIL KIETH', 'MADERA', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(757, 'C24-01-0757-MAN121', 'ALEGARME', 'ADRIAN', 'GANAR', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(758, 'C24-01-0758-MAN121', 'ALFEREZ', 'JOHN PHILIP NIÑO', 'MABINI', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(759, 'C24-01-0759-MAN121', 'ALOBA', 'FRANCO LOUISE', 'CABABA', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(760, 'C24-01-0760-MAN121', 'ALVARADO', 'RANCEL-ANN', 'DURAN', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(761, 'C24-01-0761-MAN121', 'ALVAREZ', 'ARIANE ROSE', 'LEONOR', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(762, 'C24-01-0762-MAN121', 'AMACNA', 'GLAIZA MIKAELLA', 'VIRTUDAZO', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(763, 'C24-01-0763-MAN121', 'ANABEZA', 'JACOB ROBINSON', 'DIOCAMPO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(764, 'C24-01-0764-MAN121', 'ANDRIN', 'JUNDEL', 'ROSAL', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(765, 'C24-01-0765-MAN121', 'ANTINIERO', 'IRENE', 'LIMPAG', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(766, 'C24-01-0766-MAN121', 'ARDINES', 'RALPH RAYMUND', 'IGOT', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(767, 'C24-01-0767-MAN121', 'ARIAS', 'ANDREI JUNE', 'ROSIALDA', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(768, 'C24-01-0768-MAN121', 'ARIENZA', 'ARNIE FE', 'DUNGOG', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(769, 'C24-01-0769-MAN121', 'ARPAY', 'JIMUEL KIM', 'LUCERNAS', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(770, 'C24-01-0770-MAN121', 'ASISTORES', 'JAMES MARK', 'AMOGUIS', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(771, 'C24-01-0771-MAN121', 'ASNAHON', 'RICKY MARTIN', 'AMANG', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(772, 'C24-01-0772-MAN121', 'ATIENZA', 'CHARLES PATRICK', 'E', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(773, 'C24-01-0773-MAN121', 'AUGUSTO', 'DIRK DARREL', 'LUPOGAN', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(774, 'C24-01-0774-MAN121', 'AUGUSTO', 'NICOLE', 'MALUYA', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(775, 'C24-01-0775-MAN121', 'AVERGONZADO', 'JHARED LLOYD', 'RAGANAS', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(776, 'C24-01-0776-MAN121', 'AYAO', 'GIDEON', 'PINO', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(777, 'C24-01-0777-MAN121', 'BACALSO', 'PRINCESS MAE ANN', 'ORTIZ', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(778, 'C24-01-0778-MAN121', 'BADAL', 'JAMER', 'L', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(779, 'C24-01-0779-MAN121', 'BAGAMASPAD', 'JUAN MIGUEL', 'CAVADA', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(780, 'C24-01-0780-MAN121', 'BAGUIO', 'JOHN ERICK', 'TROGUE', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(781, 'C24-01-0781-MAN121', 'BAGUIO', 'JOHN MARK', 'TROGUE', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(782, 'C24-01-0782-MAN121', 'BAHIO', 'MARRY', 'RODRIQUEZ', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(783, 'C24-01-0783-MAN121', 'BALAGA', 'JOHN BENEDICT', 'ABUCAYAN', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(784, 'C24-01-0784-MAN121', 'BALTIMORE', 'LESHLEY ANN', 'MACAPOBRE', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(785, 'C24-01-0785-MAN121', 'BANZON', 'CHRISTIAN', 'ROBLE', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(786, 'C24-01-0786-MAN121', 'BANZON', 'RHEA', 'ARLANTE', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(787, 'C24-01-0787-MAN121', 'BARON', 'KANE DAVID', 'ALVAREZ', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(788, 'C24-01-0788-MAN121', 'BARRAL', 'JAMES VINCENT', 'YMBONG', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(789, 'C24-01-0789-MAN121', 'BARRIENTOS', 'KENTH DAVE', 'BIATINGO', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(790, 'C24-01-0790-MAN121', 'BARTIDO', 'CLARK DAVON', 'MIRO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(791, 'C24-01-0791-MAN121', 'BASAKA', 'ARLO KHANE', 'BORJA', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(792, 'C24-01-0792-MAN121', 'BASARTE', 'SHAKHERA', 'MISTULA', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(793, 'C24-01-0793-MAN121', 'BATE', 'KURVYN REY', 'PARDO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(794, 'C24-01-0794-MAN121', 'BATIANCILA', 'JOMARIE', 'ESCARAN', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(795, 'C24-01-0795-MAN121', 'BAWA-AN', 'ROMMEL MILES', 'AYING', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(796, 'C24-01-0796-MAN121', 'BAYUBAY', 'MARK ANTHONY', 'EDAYAN', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(797, 'C24-01-0797-MAN121', 'BENEDICTO', 'XYKIRAH GOLDEN DAWN', '-', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(798, 'C24-01-0798-MAN121', 'BENSI', 'JIEYAN LEE', 'DOSDOS', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(799, 'C24-01-0799-MAN121', 'BENSI', 'RITCHIE JR.', 'AMAMAG-ID', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(800, 'C24-01-0800-MAN121', 'BENTEROSO', 'IAN KIM', 'MEDALLE', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(801, 'C24-01-0801-MAN121', 'BERMUDEZ', 'MURPHY', 'GUTIERREZ', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(802, 'C24-01-0802-MAN121', 'BERSABAL', 'KHENT', 'CALAYAG', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(803, 'C24-01-0803-MAN121', 'BONGHANOY', 'MARY', 'CASTRILLION', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(804, 'C24-01-0804-MAN121', 'BORBOS', 'BENJIE', '-', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(805, 'C24-01-0805-MAN121', 'BORINAGA', 'JOHN KENNETH', '-', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(806, 'C24-01-0806-MAN121', 'BOYONAS', 'KERBY', 'BALANE', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(807, 'C24-01-0807-MAN121', 'BRANZUELA', 'SHAN ARCHER', 'SATO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(808, 'C24-01-0808-MAN121', 'BRIGOLI', 'JHON MARLO', 'ESPERA', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(809, 'C24-01-0809-MAN121', 'BUENAFLOR', 'VINCE', 'PANCHO', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(810, 'C24-01-0810-MAN121', 'BUGTAY', 'CLARIZ', 'ALQUILOS', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(811, 'C24-01-0811-MAN121', 'BUGTONG', 'JOHN JACOB', 'DESABELLE', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(812, 'C24-01-0812-MAN121', 'BUKIRON', 'JOECIL', 'NEGAPATAN', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(813, 'C24-01-0813-MAN121', 'BULSO', 'DANIEL', 'COMEDA', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(814, 'C24-01-0814-MAN121', 'BURGOS', 'JULIA MAE', 'MOSTASISA', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(815, 'C24-01-0815-MAN121', 'CAÃ±AZARES', 'WALTER JR.', '-', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(816, 'C24-01-0816-MAN121', 'CABALHUG', 'REYMARKHEN', 'RAMIREZ', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(817, 'C24-01-0817-MAN121', 'CABANAS', 'JAMES REY', 'TAGHOY', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(818, 'C24-01-0818-MAN121', 'CABASE', 'KIRT ANDREW', 'SARINO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(819, 'C24-01-0819-MAN121', 'CABATO', 'HONEY LEE', '-', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(820, 'C24-01-0820-MAN121', 'CALAMBRO', 'MARK RENIER', 'PINO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(821, 'C24-01-0821-MAN121', 'CALIBO', 'ROSABELLE', 'SABANAL', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(822, 'C24-01-0822-MAN121', 'CALUNOD', 'BENEDICT', 'GEPIGA', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(823, 'C24-01-0823-MAN121', 'CALVARIO', 'RAZELLE KENT', 'YPIL', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(824, 'C24-01-0824-MAN121', 'CAPACITE', 'SAYRICK STEVE', 'LANZA', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(825, 'C24-01-0825-MAN121', 'CAPUTE', 'WYNEMAR', 'LASTIMOSO', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(826, 'C24-01-0826-MAN121', 'CARDEÑO', 'ANGEL MAY', 'TEPACIA', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(827, 'C24-01-0827-MAN121', 'CARMELOTES', 'JOHNLY', 'YBIAS', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(828, 'C24-01-0828-MAN121', 'CARULASAN', 'JEFF MARION', 'GORGONIO', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(829, 'C24-01-0829-MAN121', 'CASIPONG', 'CLYDE MARIE', 'AUGUSTO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(830, 'C24-01-0830-MAN121', 'CELERINOS', 'CHRISTIAN JHUNNEL', 'PACALDO', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(831, 'C24-01-0831-MAN121', 'CHIN', 'HARVY CYMUND', 'ALEGADO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(832, 'C24-01-0832-MAN121', 'CLAR', 'KERN EDZIL', 'BAGUION', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(833, 'C24-01-0833-MAN121', 'CLAUS', 'BABY JANE', 'BARONG', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(834, 'C24-01-0834-MAN121', 'COLEGADO', 'ROWEL REY', 'NACQUILA', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(835, 'C24-01-0835-MAN121', 'COLINA', 'TRESTAN JAMES', '-', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(836, 'C24-01-0836-MAN121', 'COMEROS', 'KENT WAVY', 'PADILLO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(837, 'C24-01-0837-MAN121', 'CONDESA', 'CHRISTIAN', 'BACOLOD', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(838, 'C24-01-0838-MAN121', 'CONSUL', 'MARK REEVE', 'PADILLO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(839, 'C24-01-0839-MAN121', 'CORBO', 'ERA MAE', 'GO-OD', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(840, 'C24-01-0840-MAN121', 'CORBO', 'VINCENT EARL', 'AGSOY', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(841, 'C24-01-0841-MAN121', 'CORREOS', 'VINCE ALLEN', 'BAROMAN', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(842, 'C24-01-0842-MAN121', 'COSEP', 'HESSEL', 'NECESARIO', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(843, 'C24-01-0843-MAN121', 'COSEP', 'KIRZNER BERN', 'CASINILLO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(844, 'C24-01-0844-MAN121', 'COSTINAR', 'GRACE', '-', 'BSIT', '2ND', 'STUDENT', 'AZUL', '$2y$10$w/p2ICL2n2pV4EjVKmCuk.NapgQZ2Rg16C0IeE2tRRud8BzGkPvxO', NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 14:27:57'),
(845, 'C24-01-0845-MAN121', 'COYOCA', 'ALLENE', 'SAYSON', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(846, 'C24-01-0846-MAN121', 'COYOCA', 'FRANCIS', 'ORTEGA', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(847, 'C24-01-0847-MAN121', 'CUARTO', 'REX RYAN', 'LAGUNA', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(848, 'C24-01-0848-MAN121', 'CUIZON', 'HANS JUSTINE', 'MARAON', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(849, 'C24-01-0849-MAN121', 'CUIZON', 'JOHNDALE', 'DALAGUIT', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(850, 'C24-01-0850-MAN121', 'DABALOS', 'JEROME', 'AGBAY', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(851, 'C24-01-0851-MAN121', 'DALUZ', 'LIAN CLYDE', 'BENTULAN', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(852, 'C24-01-0852-MAN121', 'DAMGO', 'JOHN CHRISTIAN', 'ROSALEJOS', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(853, 'C24-01-0853-MAN121', 'DE LOS SANTOS', 'JHON RUSSELL', 'DACULLO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(854, 'C24-01-0854-MAN121', 'DEDICATORIA', 'MARC IANNE', 'OSORIO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(855, 'C24-01-0855-MAN121', 'DEGAMO', 'JOHN REY', 'SABSALON', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(856, 'C24-01-0856-MAN121', 'DELA CRUZ', 'KIRSLY', 'SABANAL', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(857, 'C24-01-0857-MAN121', 'DELA PEÑA', 'EDRIAN', 'MALINAO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(858, 'C24-01-0858-MAN121', 'DELANA', 'RHEA GAIL', 'TUGAHAN', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(859, 'C24-01-0859-MAN121', 'DELOS SANTOS', 'STEVEN', 'UGDAMIN', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(860, 'C24-01-0860-MAN121', 'DICHOS', 'MIANIE', 'DURAN', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(861, 'C24-01-0861-MAN121', 'DIETO', 'DIERO RHASED', 'MONTERDE', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(862, 'C24-01-0862-MAN121', 'DILAO', 'JHON BERNIL', 'DEGAMO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(863, 'C24-01-0863-MAN121', 'DIMPAS', 'JOHN RIEMAR', 'SILVANO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(864, 'C24-01-0864-MAN121', 'DINOPOL', 'SHANE', 'SELGAS', 'BSIT', '2nd', 'STUDENT', 'ROXXO', '$2y$10$6d9dKlJJfU9FDVNFjTjd2O2kBXi1xKRASsUKP0x8YI3krLwhbXk6e', NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-19 06:49:51'),
(865, 'C24-01-0865-MAN121', 'DIPOLOG', 'JOHN PAUL', 'BENIGAY', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(866, 'C24-01-0866-MAN121', 'DOLERA', 'MILES HAROLD', 'DAITOL', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(867, 'C24-01-0867-MAN121', 'DOLLOSO', 'RHAYL', 'TAGALOG', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(868, 'C24-01-0868-MAN121', 'DUAN', 'CLAIRE', 'SERENIO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(869, 'C24-01-0869-MAN121', 'DUNGOG', 'JAMES', 'SIEGA', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(870, 'C24-01-0870-MAN121', 'DUNGOG', 'JASON', 'GALABIN', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(871, 'C24-01-0871-MAN121', 'DURAN', 'MARK JOSEPH', 'CATOCTOCANON', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(872, 'C24-01-0872-MAN121', 'DUYAG', 'MC BRYN', 'AUGUSTO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(873, 'C24-01-0873-MAN121', 'EBARDO', 'ANTHONY', 'ABAYLE', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(874, 'C24-01-0874-MAN121', 'ELLESCAS', 'ROD BRYAN', 'TAUTHO', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(875, 'C24-01-0875-MAN121', 'EMIT', 'ARIEL', 'OCHIA', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(876, 'C24-01-0876-MAN121', 'ERAZO', 'RHINE DAVE', 'MOLEJON', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(877, 'C24-01-0877-MAN121', 'ENECITA', 'RUFFY JAY', 'BURO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(878, 'C24-01-0878-MAN121', 'ENGCO', 'YNU', 'YCONG', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(879, 'C24-01-0879-MAN121', 'ENGHUG', 'ALBECARL', 'MEDIANO', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(880, 'C24-01-0880-MAN121', 'ENGRACIAL', 'DAVE', 'DUHAYLUNGSOD', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(881, 'C24-01-0881-MAN121', 'ESPINOSA', 'JERVEN', '-', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(882, 'C24-01-0882-MAN121', 'EMNACE', 'JHERMAINE NHEIL', 'RECINTO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(883, 'C24-01-0883-MAN121', 'ESGUERRA', 'SYMUND', 'LOBINO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(884, 'C24-01-0884-MAN121', 'ESPARCIA', 'CLEAR JANE', 'SALINAS', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(885, 'C24-01-0885-MAN121', 'ESPELITA', 'VONNE KARL', 'SERONDA', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(886, 'C24-01-0886-MAN121', 'EUPINADO', 'CHRISTIAN', 'RAUT-RAUT', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(887, 'C24-01-0887-MAN121', 'ESCANILLA', 'ORENZI SHAN', 'PASCUAL', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(888, 'C24-01-0888-MAN121', 'ESTARDO', 'RAMEL JR.', 'MALOLOY-ON', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(889, 'C24-01-0889-MAN121', 'EULDAN', 'JUNREY', 'BASIGSIG', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(890, 'C24-01-0890-MAN121', 'EUMAGUE', 'JOHN PHILIP', '-', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(891, 'C24-01-0891-MAN121', 'FRANCISCO', 'KYLA', 'BACALSO', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(892, 'C24-01-0892-MAN121', 'ESTAN', 'ZYKE SIDNEY', 'TATOY', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(893, 'C24-01-0893-MAN121', 'FLORES', 'KIEFER JOHN', 'VICENCION', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(894, 'C24-01-0894-MAN121', 'FLORES', 'MARK ANTHONY', 'SIGUE', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(895, 'C24-01-0895-MAN121', 'FLORIDA', 'YCON JAKE', 'PELOMINO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(896, 'C24-01-0896-MAN121', 'GALABO', 'VINCE COLBY', 'MARABILES', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(897, 'C24-01-0897-MAN121', 'FELICIANO', 'JOHN CARLO', 'PAROT', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(898, 'C24-01-0898-MAN121', 'GABISAN', 'KIRBY', 'ARROGANTE', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(899, 'C24-01-0899-MAN121', 'GABUNADA', 'VINZ KLIEN', 'OCHEA', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(900, 'C24-01-0900-MAN121', 'GACIS', 'ALEX BOY JR.', 'MELECIO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(901, 'C24-01-0901-MAN121', 'GEMINA', 'LESMAR', 'CADANO', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(902, 'C24-01-0902-MAN121', 'FUNTANAR', 'NORIELYN', 'HABUHAB', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(903, 'C24-01-0903-MAN121', 'GAYOL', 'JEISEL', 'LEGARTO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(904, 'C24-01-0904-MAN121', 'GEMIDA', 'KYKEN', 'AMBAY', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(905, 'C24-01-0905-MAN121', 'GEMINA', 'JULIE ANN', 'MENDOZA', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38');
INSERT INTO `students` (`id`, `student_id`, `last_name`, `first_name`, `middle_name`, `course`, `level`, `status`, `house`, `password`, `email`, `phone`, `profile_pic`, `is_active`, `created_at`, `updated_at`) VALUES
(906, 'C24-01-0906-MAN121', 'GILBOLINGO', 'KHARL VHINZIE', 'BASMAYOR', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(907, 'C24-01-0907-MAN121', 'GALLEGO', 'THERONE FRANCOIS', 'RINCONADA', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(908, 'C24-01-0908-MAN121', 'GERVISE', 'JAMES MARKY', 'P', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(909, 'C24-01-0909-MAN121', 'GESIM', 'BRYLLE CHRISTIAN', 'CAPIZNON', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(910, 'C24-01-0910-MAN121', 'GETUTUA', 'CYRIL', 'ESPERAT', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(911, 'C24-01-0911-MAN121', 'GOJETIA', 'AIZA', 'NALDOZA', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(912, 'C24-01-0912-MAN121', 'GEPIGA', 'ADRIAN', 'ARTAJO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(913, 'C24-01-0913-MAN121', 'GILLAMAC', 'JUSTIN JAMES', 'MANGUBAT', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(914, 'C24-01-0914-MAN121', 'GIVA', 'JUDE XIAN', 'BUENO', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(915, 'C24-01-0915-MAN121', 'GODINEZ', 'HERZYN', 'CATAGCATAG', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(916, 'C24-01-0916-MAN121', 'HERBIETO', 'JOHN VINCENT', 'SULTAN', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(917, 'C24-01-0917-MAN121', 'GILIG', 'VINCE KARL', 'MALOLOY-ON', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(918, 'C24-01-0918-MAN121', 'GONZALES', 'CHARMAINE JANE', '-', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(919, 'C24-01-0919-MAN121', 'GRACIA', 'CHRISTIAN EDWARD', 'OYANGOREN', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(920, 'C24-01-0920-MAN121', 'HAMPAC', 'GEO ANGELOU', 'MAICON', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(921, 'C24-01-0921-MAN121', 'ILLUSTRISIMO', 'JUSTINE', 'PAGAS', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(922, 'C24-01-0922-MAN121', 'GONATO', 'RICA JOY', 'CARPEN', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(923, 'C24-01-0923-MAN121', 'IGNACIO', 'JUN RALPHY', 'PETALCORIN', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(924, 'C24-01-0924-MAN121', 'IGOT', 'ALEXANDER JR.', 'SALAZAR', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(925, 'C24-01-0925-MAN121', 'IGOT', 'JADE WALTER', 'BAYO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(926, 'C24-01-0926-MAN121', 'JIMENEZ', 'JOHN LLOYD', 'ALEGADO', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(927, 'C24-01-0927-MAN121', 'HIYAS', 'RONALYN', 'AYING', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(928, 'C24-01-0928-MAN121', 'INOT', 'ELIAN JANE', 'VILLAMOR', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(929, 'C24-01-0929-MAN121', 'INSO', 'JOHANNA MARIE', 'FAUSTOR', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(930, 'C24-01-0930-MAN121', 'JACINTO', 'SHALLOM KYLE', 'TUBIANO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(931, 'C24-01-0931-MAN121', 'LAMBOJON', 'ROGER JR.', 'PAQUIBOT', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(932, 'C24-01-0932-MAN121', 'INGUITO', 'SHANE ANGEL', 'MADERA', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(933, 'C24-01-0933-MAN121', 'JUGAR', 'JAMES RYAN', 'PONCE', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(934, 'C24-01-0934-MAN121', 'JULIANE', 'EDDIEBOY', 'GASULGA', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(935, 'C24-01-0935-MAN121', 'LAMBOJON', 'JIEMON', 'B', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(936, 'C24-01-0936-MAN121', 'LATO', 'MADELYN', 'RAMAN', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(937, 'C24-01-0937-MAN121', 'JOPIA', 'RENGELO', '-', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(938, 'C24-01-0938-MAN121', 'LAPE', 'JHON REY', 'MEJASCO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(939, 'C24-01-0939-MAN121', 'LARIOSA', 'ENJELY', 'CANTUTAY', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(940, 'C24-01-0940-MAN121', 'LASOLA', 'CHRISTIAN JAMES', 'SONDO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(941, 'C24-01-0941-MAN121', 'LIMPANGOG', 'ROLLIE', 'CASTRO', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(942, 'C24-01-0942-MAN121', 'LANGOYAN', 'APRIL ANN', 'DUNGAO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(943, 'C24-01-0943-MAN121', 'LEE', 'ZHAINA', '-', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(944, 'C24-01-0944-MAN121', 'LIM', 'GOD GRACE', 'RIEL', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(945, 'C24-01-0945-MAN121', 'LIMORISAN', 'ADRIAN', '-', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(946, 'C24-01-0946-MAN121', 'LAURENTE', 'KURT JOHNRYL', '-', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(947, 'C24-01-0947-MAN121', 'LINAO', 'GWYNN', 'GALVAN', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(948, 'C24-01-0948-MAN121', 'LISONDRA', 'DANIEL DAVE', 'PASCOBILLO', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(949, 'C24-01-0949-MAN121', 'LIWAGON', 'DARIOUS CYRIL', 'LASTIMOSO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(950, 'C24-01-0950-MAN121', 'LIMPANGOG', 'SAIMEREJ', 'BARRIENTOS', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(951, 'C24-01-0951-MAN121', 'LOPEZ', 'JOHN RENAR', 'DURANO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(952, 'C24-01-0952-MAN121', 'LOZANO', 'MARK AXEL', 'ARNADO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(953, 'C24-01-0953-MAN121', 'MAGLIKIANG', 'CHERRY', 'MONDRANO', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(954, 'C24-01-0954-MAN121', 'LOPEZ', 'JOHN KEITH', '-', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(955, 'C24-01-0955-MAN121', 'MACAS', 'JAY', 'ESPINOSA', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(956, 'C24-01-0956-MAN121', 'MADERA', 'ASTERIO JR.', 'PUZA', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(957, 'C24-01-0957-MAN121', 'MAGLASANG', 'CHRISTIAN', '-', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(958, 'C24-01-0958-MAN121', 'MALAGAR', 'MARK JAY', 'DIONALDO', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(959, 'C24-01-0959-MAN121', 'LUMAAD', 'CARL DAVID', 'GALON', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(960, 'C24-01-0960-MAN121', 'MAG-USARA', 'ERICA', 'CABALLERO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(961, 'C24-01-0961-MAN121', 'MAH', 'FRITZ LAURENCE JACOB', 'ACAIN', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(962, 'C24-01-0962-MAN121', 'MALUNAR', 'RONALD', 'VARISA', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(963, 'C24-01-0963-MAN121', 'MAGSIPOC', 'NIÑO MAR', 'UNABIA', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(964, 'C24-01-0964-MAN121', 'MALINAO', 'PATRICK', 'LAPA', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(965, 'C24-01-0965-MAN121', 'MALINGIN', 'KISHA JOVE', 'YAM-ID', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(966, 'C24-01-0966-MAN121', 'MALOLOY-ON', 'STEVEN JAY', 'TAHANLANGIT', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(967, 'C24-01-0967-MAN121', 'MANTUHAC', 'WAYNE JUSSEL', 'MAGO', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(968, 'C24-01-0968-MAN121', 'MALIGRO', 'LAWRENCE', 'RITARDO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(969, 'C24-01-0969-MAN121', 'MANINGO', 'HANNAH MAICA', 'BONGABONG', 'BSIT', '2ND', 'STUDENT', 'GIALLIO', '$2y$10$d9d4x9gLIpTW3.i2B3/9eOLjXVbrzcjXCkM.FScB15LQXcCYsnqfa', 'maicamaningo440@gmail.com', '09070974875', NULL, 1, '2026-04-13 11:48:38', '2026-04-16 18:40:20'),
(970, 'C24-01-0970-MAN121', 'MANLAPAS', 'DOMINIC JHON', 'CALAGO', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(971, 'C24-01-0971-MAN121', 'MANTEZA', 'JEAN CRISTY DIANNE', 'OMANDAM', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(972, 'C24-01-0972-MAN121', 'MARIENTES', 'MC NICOLE', 'JERUSALEM', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(973, 'C24-01-0973-MAN121', 'MAMITES', 'MARGIE', 'MOPON', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(974, 'C24-01-0974-MAN121', 'MAPULA', 'LERAH', 'MANCIO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(975, 'C24-01-0975-MAN121', 'MARANGA', 'GEORGE CESAR', 'POTOT', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(976, 'C24-01-0976-MAN121', 'MARIANO', 'YASHA', 'PELEGRINO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(977, 'C24-01-0977-MAN121', 'MEDIO', 'KYLE VINCENT', 'ARCILLA', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(978, 'C24-01-0978-MAN121', 'MANUBA', 'SALBAN', 'LLAMOS', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(979, 'C24-01-0979-MAN121', 'MEJORADA', 'AGNES', 'CABANATAN', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(980, 'C24-01-0980-MAN121', 'MAYANG', 'RETCHE', 'CASULAY', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(981, 'C24-01-0981-MAN121', 'MAYOL', 'JOSH ANTHONY', 'ESTRELLADA', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(982, 'C24-01-0982-MAN121', 'MERCADO', 'ELVIN CARL', 'SAYSON', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(983, 'C24-01-0983-MAN121', 'MARIKIT', 'PATRICK JANZEN', 'PULVERA', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(984, 'C24-01-0984-MAN121', 'MIGUEL', 'MARLON JR.', 'BAQUERO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(985, 'C24-01-0985-MAN121', 'MENDOZA', 'GLAYDE JHON', '-', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(986, 'C24-01-0986-MAN121', 'MENINA', 'JASPER CLYDE', 'ROJAS', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(987, 'C24-01-0987-MAN121', 'MOISES', 'DIETHER', '-', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(988, 'C24-01-0988-MAN121', 'MAYAKI', 'DANIEL JAMES', 'MAAMO', 'BSIT', '2nd', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(989, 'C24-01-0989-MAN121', 'MIRAL', 'JOSH ANGELO', '-', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(990, 'C24-01-0990-MAN121', 'MOISES', 'BERNARD', '-', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(991, 'C24-01-0991-MAN121', 'MONDELO', 'JENEL MARK', 'S.', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(992, 'C24-01-0992-MAN121', 'MEJIAS', 'EVAN', '-', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(993, 'C24-01-0993-MAN121', 'MONSULLER', 'RONALY', 'SUDARIA', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(994, 'C24-01-0994-MAN121', 'MOLINA', 'CLIFFORD', 'RIVERA', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(995, 'C24-01-0995-MAN121', 'MOMO', 'STELAH MARISH', 'DECLARO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(996, 'C24-01-0996-MAN121', 'MORENO', 'LAURENCE', 'BIORE', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(997, 'C24-01-0997-MAN121', 'MIAÑOZA', 'JAMES DENVER', 'YLANAN', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(998, 'C24-01-0998-MAN121', 'MONTEMOR', 'EARL JOSHUA', 'LAPECEROS', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(999, 'C24-01-0999-MAN121', 'MONTEZA', 'JOY-ANN', 'ESPIRITO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1000, 'C24-01-1000-MAN121', 'NARRA', 'DIONESA LYKA', 'PEPITO', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1001, 'C24-01-1001-MAN121', 'MOJEMULTA', 'JUREY', 'SALUDAR', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1002, 'C24-01-1002-MAN121', 'NEIS', 'CLYDE IVAN', 'CASUL', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1003, 'C24-01-1003-MAN121', 'NALUGON', 'AXCEL NASH', 'D', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1004, 'C24-01-1004-MAN121', 'NALZARO', 'EARL LAWRENCE', 'MACAPOBRE', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1005, 'C24-01-1005-MAN121', 'NGUJO', 'NEIL ADRIAN', 'RICARDEL', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1006, 'C24-01-1006-MAN121', 'MONDIA', 'JOHN DAVE', 'MISIONA', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1007, 'C24-01-1007-MAN121', 'OCHEA', 'FRENZY GYLE', 'DOBLAS', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1008, 'C24-01-1008-MAN121', 'NGUJO', 'LAWRENCE', 'LAWAS', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1009, 'C24-01-1009-MAN121', 'NGUJO', 'MARIFE', 'ITANG', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1010, 'C24-01-1010-MAN121', 'OMALAN', 'JAMILA', 'BAGAY', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1011, 'C24-01-1011-MAN121', 'MULLET', 'RUFINO JR.', 'LATOY', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1012, 'C24-01-1012-MAN121', 'ONDING', 'KENZ', 'TAPAN', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1013, 'C24-01-1013-MAN121', 'OLINARES', 'FRANCES JAY', 'TIBON', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1014, 'C24-01-1014-MAN121', 'ORTEGA', 'GWYN', 'PALOQUIA', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1015, 'C24-01-1015-MAN121', 'NAVAJA', 'KARL JAMES', 'ITOMAY', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1016, 'C24-01-1016-MAN121', 'ORTEGO', 'JOHN PAUL', 'CABILI', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', '$2y$10$C/WL0FPW1yx/zot/HAm17evCqXPcvrdky.G10kRSFZ2iykYKTfshO', NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-24 00:40:20'),
(1017, 'C24-01-1017-MAN121', 'OPO', 'JEAN HENRI', 'GULANE', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1018, 'C24-01-1018-MAN121', 'ORIAS', 'JASON', 'QUE', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1019, 'C24-01-1019-MAN121', 'PACIFICO', 'EMMANUEL JAMES', 'CATAM-ISAN', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1020, 'C24-01-1020-MAN121', 'NOQUIAO', 'JOSHUA', 'ORGUELLES', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1021, 'C24-01-1021-MAN121', 'PADA-ON', 'ZACH YUAN', '-', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1022, 'C24-01-1022-MAN121', 'ORTIZ', 'CARL ANDRI', 'MADERAL', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1023, 'C24-01-1023-MAN121', 'PACENABO', 'JULIANA MARE', 'BUANGHUG', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1024, 'C24-01-1024-MAN121', 'PAGATPAT', 'CHRISTOPHER', 'CABALTERA', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1025, 'C24-01-1025-MAN121', 'OMPAD', 'JADE', 'MENCEDE', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1026, 'C24-01-1026-MAN121', 'PAHIMUTANG', 'KYLLE', 'C', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1027, 'C24-01-1027-MAN121', 'PADAYAO', 'JOHN VINCENT', 'MONTIBON', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1028, 'C24-01-1028-MAN121', 'PADILLA', 'GERALD LLOYD', 'M', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1029, 'C24-01-1029-MAN121', 'PALENCIA', 'RHOMAR', 'ARELLANO', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1030, 'C24-01-1030-MAN121', 'ORTEGA', 'JOHN REY', 'LUMOYA', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1031, 'C24-01-1031-MAN121', 'PANER', 'RAINE JAMILSON', 'ABELLA', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1032, 'C24-01-1032-MAN121', 'PALAFOX', 'FRANZ KENDRICKZ', 'INSO', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1033, 'C24-01-1033-MAN121', 'PALAG', 'KATRINA', 'DIAPANA', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1034, 'C24-01-1034-MAN121', 'PARAGSA', 'JES RIEL', 'TUBOS', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1035, 'C24-01-1035-MAN121', 'PACTO', 'JOVEN', 'QUIAMAN', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1036, 'C24-01-1036-MAN121', 'PEKITPEKIT', 'JESSON', 'BENEDICTO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1037, 'C24-01-1037-MAN121', 'PANGANIBAN', 'RAQUIE JAY', 'DAYDAY', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1038, 'C24-01-1038-MAN121', 'PAQUIBOT', 'RICHMON', 'DANTES', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1039, 'C24-01-1039-MAN121', 'PEPITO', 'RIANA JANE', 'GARBO', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1040, 'C24-01-1040-MAN121', 'PAGATPAT', 'MARIANE', 'TABACONG', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1041, 'C24-01-1041-MAN121', 'PILARE', 'JAMES BRYAN', 'ARNEJO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1042, 'C24-01-1042-MAN121', 'PENDIJITO', 'NHEL ANDRIAN', '-', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1043, 'C24-01-1043-MAN121', 'PENUELA', 'RICHARD JR.', 'PACULBA', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1044, 'C24-01-1044-MAN121', 'PONCE', 'JENNO', 'NIPA', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1045, 'C24-01-1045-MAN121', 'PALO', 'ALBEA JHANE', 'RESELLES', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1046, 'C24-01-1046-MAN121', 'PORTUGAL', 'CHRISTIAN LEE', 'URSAL', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1047, 'C24-01-1047-MAN121', 'PIRANTE', 'JAMES AARON', 'DAPITAN', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1048, 'C24-01-1048-MAN121', 'PLATINO', 'SEM JOHN', 'GOC-ONG', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1049, 'C24-01-1049-MAN121', 'PUEBLAS', 'JAMES NIKO', 'BANTILAN', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1050, 'C24-01-1050-MAN121', 'PARTUSA', 'RHEZA JADE', 'PELICANO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1051, 'C24-01-1051-MAN121', 'QUIA-OT', 'JOMAR', '-', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1052, 'C24-01-1052-MAN121', 'PRESBITERO', 'SYRELA', 'ROFLO', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1053, 'C24-01-1053-MAN121', 'PUASA', 'ALLEN JOSH', 'BAGUTUA', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1054, 'C24-01-1054-MAN121', 'RANOCO', 'JAMES', 'BUENAFLOR', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1055, 'C24-01-1055-MAN121', 'PESALBON', 'FLORA MAY', 'M', 'BSIT', '2ND', 'STUDENT', 'CAHEL', '$2y$10$qy1J6MnS6rcIzEqUgPIYde3pBmocZbMipfK8xRiW0NvVrinDh23hu', NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-23 23:30:38'),
(1056, 'C24-01-1056-MAN121', 'REFORZADO', 'RUIE', 'ALANO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1057, 'C24-01-1057-MAN121', 'QUIBEDO', 'STEVEN JONE', 'NIERE', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1058, 'C24-01-1058-MAN121', 'RENTUZA', 'REY BEAN', 'MANCERA', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1059, 'C24-01-1059-MAN121', 'PONGAUTAN', 'KIM', 'TUNGAL', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1060, 'C24-01-1060-MAN121', 'RICO', 'JOLIE ANGELA', '-', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1061, 'C24-01-1061-MAN121', 'REGODO', 'EHRON', 'GONZAGA', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1062, 'C24-01-1062-MAN121', 'RIVERA', 'JUNAMIE', '-', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1063, 'C24-01-1063-MAN121', 'QUIAÑO', 'AIRL DANIEL', 'YAGONO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1064, 'C24-01-1064-MAN121', 'ROCA', 'RONA', 'OSABEL', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1065, 'C24-01-1065-MAN121', 'RIVAS', 'DWIGHT CARL', 'ABINGKE', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1066, 'C24-01-1066-MAN121', 'RIVAS', 'KENT LOUIE', 'A', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1067, 'C24-01-1067-MAN121', 'ROMA', 'FAITH ERA MAE', 'JARAPAN', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1068, 'C24-01-1068-MAN121', 'REFORMADO', 'EMMANUEL', 'CABILAO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1069, 'C24-01-1069-MAN121', 'ROQUERO', 'SERWIN KYLE', 'ESTAREJA', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1070, 'C24-01-1070-MAN121', 'RODRIGUEZ', 'DALE MARK', 'VILLASAN', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1071, 'C24-01-1071-MAN121', 'ROMA', 'BOBY LOURENZ THEOFIL', '-', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1072, 'C24-01-1072-MAN121', 'RUBIO', 'JANM ARCH', 'ATON', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1073, 'C24-01-1073-MAN121', 'RETES', 'SHYRANIE FRANCE', '-', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1074, 'C24-01-1074-MAN121', 'RULETE', 'KRISTOFF', 'JAO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1075, 'C24-01-1075-MAN121', 'ROSAL', 'CHRIS LO', 'BOLTRON', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1076, 'C24-01-1076-MAN121', 'ROSALES', 'STEPHANIE DIAN', 'POGIO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1077, 'C24-01-1077-MAN121', 'SAGARINO', 'ENRIQUE III', 'CUEVAS', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1078, 'C24-01-1078-MAN121', 'ROA', 'SHARLA', 'MONTAJES', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1079, 'C24-01-1079-MAN121', 'SALAS', 'GIAN ROLAN', 'BALABA', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1080, 'C24-01-1080-MAN121', 'RUSTIA', 'LIEZEL', 'SONTOUSUIDAD', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1081, 'C24-01-1081-MAN121', 'SABIJON', 'MAYNARD', 'MAHINAY', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1082, 'C24-01-1082-MAN121', 'SALVADOR', 'SKY', 'GAGABUAN', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1083, 'C24-01-1083-MAN121', 'ROMANO', 'CRISTY JEAN', 'BONGCAC', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1084, 'C24-01-1084-MAN121', 'SANTILLAN', 'CHIKE', 'AUSTRIA', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1085, 'C24-01-1085-MAN121', 'SALDE', 'WILMA', 'PEREGRINO', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1086, 'C24-01-1086-MAN121', 'SALVACION', 'PRINCESS BEJIE', 'REY', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1087, 'C24-01-1087-MAN121', 'SATERA', 'CHAD MICHAEL REY', 'ROQUERO', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1088, 'C24-01-1088-MAN121', 'RUELA', 'JASMINE', 'FLORES', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1089, 'C24-01-1089-MAN121', 'SECIBAN', 'LOUIE JAY', 'A', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1090, 'C24-01-1090-MAN121', 'SANTOS', 'JOHN LOUISE', 'NAVAREZ', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1091, 'C24-01-1091-MAN121', 'SAPIO', 'ANGELA', 'COMEDERO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1092, 'C24-01-1092-MAN121', 'SENCIL', 'JHYIA', 'COSIDO', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1093, 'C24-01-1093-MAN121', 'SAGARINO', 'GEN STEPHEN JULIUS', 'PERPETUA', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1094, 'C24-01-1094-MAN121', 'SIENDO', 'JOHN ADRIAN', 'AQUINO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1095, 'C24-01-1095-MAN121', 'SECJADAS', 'SARAH MAE', 'BARULO', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1096, 'C24-01-1096-MAN121', 'SEMENSE', 'RICHARD', 'ROMO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1097, 'C24-01-1097-MAN121', 'SILORIO', 'GERRY JR.', 'BUTANTAN', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1098, 'C24-01-1098-MAN121', 'SANICO', 'JESIELO', 'BORJA', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1099, 'C24-01-1099-MAN121', 'SOCO', 'JOHN DOHNY', 'ALIVIO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1100, 'C24-01-1100-MAN121', 'SIENDO', 'MARK SHEAN', 'PULGO', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1101, 'C24-01-1101-MAN121', 'SILAWAN', 'RALPH', 'PLAZA', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1102, 'C24-01-1102-MAN121', 'SOLON', 'ANGEL MARIE', 'URSONAL', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1103, 'C24-01-1103-MAN121', 'SAYNO', 'JOHN DAVID', 'SEJISMUNDO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1104, 'C24-01-1104-MAN121', 'SORINGA', 'REYMART', 'MAGLENTE', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1105, 'C24-01-1105-MAN121', 'SOLIS', 'SETH', 'BERDIN', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1106, 'C24-01-1106-MAN121', 'SOLLANO', 'JOHN BILLY', 'MALACHICO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1107, 'C24-01-1107-MAN121', 'SULLANO', 'IVAN MITCH GENAR', 'A', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1108, 'C24-01-1108-MAN121', 'SENERPIDA', 'MAE KYLA', 'SILAWAN', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1109, 'C24-01-1109-MAN121', 'SUNGAHID', 'SULPICIO III', 'VILLEGAS', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1110, 'C24-01-1110-MAN121', 'SUELTO', 'JOHN CARLO', 'GIDUCOS', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1111, 'C24-01-1111-MAN121', 'TABANAO', 'NICO JAY', 'BECERIL', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1112, 'C24-01-1112-MAN121', 'SIMBAJON', 'JOHN PAUL', 'DANIEL', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1113, 'C24-01-1113-MAN121', 'TADLAS', 'KENNETH', 'SONTOUSIDAD', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1114, 'C24-01-1114-MAN121', 'SURIGAO', 'JESSA', 'PULGO', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1115, 'C24-01-1115-MAN121', 'SUSON', 'YANZIE', 'PEPITO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1116, 'C24-01-1116-MAN121', 'TAGHOY', 'CYRELL JAMES', '-', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1117, 'C24-01-1117-MAN121', 'SONDONG', 'CLYDE JAY SOLOMON', 'CAÑETE', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1118, 'C24-01-1118-MAN121', 'TALAUGON', 'RHONA MAE', 'PAJAGANAS', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1119, 'C24-01-1119-MAN121', 'TAGADI-AD', 'ROCHELLE ANNE', 'BANCALE', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1120, 'C24-01-1120-MAN121', 'TAGALOG', 'VINCE JAMES', 'CARBONILLA', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1121, 'C24-01-1121-MAN121', 'TAMPUS', 'CLARK DEMVIR', 'DONIO', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1122, 'C24-01-1122-MAN121', 'SUMIDO', 'JOY MAE', 'LINSANGAN', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1123, 'C24-01-1123-MAN121', 'TAMPUS', 'WESLEY', 'MEDILLO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1124, 'C24-01-1124-MAN121', 'TALIDRO', 'JHON LLOYD', 'OCHEA', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1125, 'C24-01-1125-MAN121', 'TAMPOS', 'ANGELA', 'DEL RIO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1126, 'C24-01-1126-MAN121', 'TENIO', 'ZHEDNY', 'URMENETA', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1127, 'C24-01-1127-MAN121', 'TABUELOG', 'MARK LAWRENCE', 'ZAMBO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1128, 'C24-01-1128-MAN121', 'TERO', 'JOHN PAUL', 'SABERON', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1129, 'C24-01-1129-MAN121', 'TANCINCO', 'LANZ MARION', 'P', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1130, 'C24-01-1130-MAN121', 'TATOY', 'JOHN LAURENCE', 'ENCABO', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1131, 'C24-01-1131-MAN121', 'TIMTIM', 'FINCH KARYLLE', 'PANISAL', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1132, 'C24-01-1132-MAN121', 'TAJOR', 'JERALD', 'JUGALBOT', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1133, 'C24-01-1133-MAN121', 'TINDOY', 'GIAN CHARLS', 'SUELO', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1134, 'C24-01-1134-MAN121', 'TINGAL', 'KHENT CLIFORD', 'VISITACION', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1135, 'C24-01-1135-MAN121', 'TIBON', 'CHYLSY KATE', 'CABANAG', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1136, 'C24-01-1136-MAN121', 'TORREMOCHA', 'ARBIE', 'ESPINOSA', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1137, 'C24-01-1137-MAN121', 'TAMPUS', 'MHARVEL SHANNE', 'DAGASDAS', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1138, 'C24-01-1138-MAN121', 'TUMULAK', 'LEON NELL RITCHIE', 'YAGONIA', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1139, 'C24-01-1139-MAN121', 'VALENZONA', 'JOHN PAUL', 'MALINGIN', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1140, 'C24-01-1140-MAN121', 'TERINGTERING', 'JHON LAURENCE', 'PANGILINAN', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1141, 'C24-01-1141-MAN121', 'VALIENTE', 'JEANN', 'CUSGAPA', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1142, 'C24-01-1142-MAN121', 'UNAT', 'MARK DAVE', 'ESCASO', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1143, 'C24-01-1143-MAN121', 'VILLAMOR', 'ROBBIE RHEY', 'MORPOS', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1144, 'C24-01-1144-MAN121', 'TIN-AW', 'BOB LESTER', 'MALUNJAO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1145, 'C24-01-1145-MAN121', 'VILLARIN', 'JOHN BENEDICT', 'MALUYA', 'BSIT', '2nd', 'STUDENT', 'GIALLIO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1146, 'C24-01-1146-MAN121', 'VALLESPIN', 'RJ', 'PAGPAGON', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1147, 'C24-01-1147-MAN121', 'VILLALUA', 'JOHN KENNETH', 'FARAON', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1148, 'C24-01-1148-MAN121', 'WAGAS', 'WAYNE EARL', 'CODENIERA', 'BSIT', '2ND', 'STUDENT', 'AZUL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1149, 'C24-01-1149-MAN121', 'TULING', 'EJ ALDRIN', 'AMACNA', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1150, 'C24-01-1150-MAN121', 'VILLARIN', 'MARLON', 'PARACUELLES', 'BSIT', '2nd', 'STUDENT', 'ROXXO', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1151, 'C24-01-1151-MAN121', 'VISOC', 'QUEZAYA', 'PELEGRIN', 'BSIT', '2nd', 'STUDENT', 'VIERRDY', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1152, 'C24-01-1152-MAN121', 'VALIENTE', 'ANDRE SCOTT', 'BOOC', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1153, 'C24-01-1153-MAN121', 'VILLARIN', 'JHESON', 'LAPUT', 'BSIT', '2ND', 'STUDENT', 'CAHEL', NULL, NULL, NULL, NULL, 1, '2026-04-13 11:48:38', '2026-04-13 11:48:38'),
(1154, 'C24-01-1154-MAN121', 'ZAMBO', 'PAUL GABRIEL', 'ALBURO', 'BSIT', '2ND', 'STUDENT', 'CAHEL', '$2y$10$5FUqUWBlpFMN3Ud9w25zL.CEfrpvey.sScuINFokPtVhAJ.bRhZgi', NULL, NULL, NULL, 1, '2026-04-26 18:33:15', '2026-04-26 18:33:15');

-- --------------------------------------------------------

--
-- Table structure for table `student_id_counter`
--

CREATE TABLE `student_id_counter` (
  `id` int(11) NOT NULL DEFAULT 1,
  `next_seq` int(11) NOT NULL DEFAULT 1,
  `next_house_index` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_id_counter`
--

INSERT INTO `student_id_counter` (`id`, `next_seq`, `next_house_index`) VALUES
(1, 1155, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clubs`
--
ALTER TABLE `clubs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `club_tags`
--
ALTER TABLE `club_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `club_id` (`club_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `memberships`
--
ALTER TABLE `memberships`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_membership` (`student_id`,`club_id`),
  ADD KEY `club_id` (`club_id`);

--
-- Indexes for table `membership_cards`
--
ALTER TABLE `membership_cards`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `card_number` (`card_number`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `club_id` (`club_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_id` (`student_id`);

--
-- Indexes for table `student_id_counter`
--
ALTER TABLE `student_id_counter`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `clubs`
--
ALTER TABLE `clubs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `club_tags`
--
ALTER TABLE `club_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `memberships`
--
ALTER TABLE `memberships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `membership_cards`
--
ALTER TABLE `membership_cards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1155;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `club_tags`
--
ALTER TABLE `club_tags`
  ADD CONSTRAINT `club_tags_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`id`);

--
-- Constraints for table `memberships`
--
ALTER TABLE `memberships`
  ADD CONSTRAINT `memberships_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `memberships_ibfk_2` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `membership_cards`
--
ALTER TABLE `membership_cards`
  ADD CONSTRAINT `membership_cards_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  ADD CONSTRAINT `membership_cards_ibfk_2` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

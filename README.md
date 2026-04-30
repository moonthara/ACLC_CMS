ACLC Online Club & Membership System
ACLC College of Mandaue | IT22F | Hannah Maica Maningo
# 🎓 ACLC Club & Membership System (CMS)

A web-based Club and Membership Management System built for **ACLC College of Mandaue**. It provides a student-facing portal and a role-based admin panel for managing clubs, memberships, events, and reports across the school's five house system.

---

## 📋 Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Houses](#houses)
- [Admin Roles](#admin-roles)
- [Installation](#installation)
- [Database Setup](#database-setup)
- [Usage](#usage)
- [Screenshots](#screenshots)

---

## ✨ Features

### 🧑‍🎓 Student Portal
- Login and registration system
- Personalized dashboard with live clock and house-colored UI
- Browse and apply for club memberships
- View digital membership cards upon approval
- Track application status (Pending / Approved / Rejected)
- View events and announcements filtered by house
- Profile page with student info
- Dark mode toggle

### 🛡️ Admin Panel
- Secure login with **Google reCAPTCHA** verification
- Role-based access control (Super Admin vs House Admin)
- Student directory with search, filter, and CSV export
- Membership approval/rejection workflow with reason notes
- Club management (create, enable/disable)
- Event and announcement posting
- Analytics and reports dashboard
- Export students and memberships to CSV

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Backend | PHP (procedural) |
| Database | MySQL via PDO |
| Frontend | HTML5, CSS3 (custom), vanilla JS |
| Icons | Font Awesome 6.4 |
| Security | Google reCAPTCHA v2 |
| Hosting | InfinityFree (or any PHP/MySQL host) |

---

## 📁 Project Structure

```
aclc_system/
│
├── admin/                  # Admin panel pages
│   ├── login.php
│   ├── logout.php
│   ├── dashboard.php
│   ├── students.php
│   ├── memberships.php
│   ├── clubs.php
│   ├── events.php
│   └── reports.php
│
├── portal/                 # Student portal pages
│   ├── dashboard.php
│   ├── clubs.php
│   ├── memberships.php
│   ├── events.php
│   ├── profile.php
│   └── logout.php
│
├── includes/
│   └── config.php          # DB config, helper functions
│
├── css/
│   ├── admin.css
│   └── portal.css
│
├── assets/
│   └── aclc_logo(1).png
│
├── index.php               # Student login/landing page
└── aclc_cms.sql            # Database schema + seed data
```

---

## 🏠 Houses

The system organizes students into five houses, each with a distinct color theme:

| House | Color |
|---|---|
| AZUL | 🔵 Blue `#3b97ff` |
| CAHEL | 🟠 Orange `#ff8400` |
| GIALLIO | 🟡 Yellow `#f7f431` |
| ROXXO | 🔴 Red `#fc3a3a` |
| VIERRDY | 🟢 Green `#4cf957` |

---

## 👤 Admin Roles

| Role | Access |
|---|---|
| **Super Admin** | Full access — all houses, all clubs, all data |
| **House Admin** | Restricted to their assigned house only |

House Admins can only view and manage students, memberships, clubs, and events within their own house.

---

## ⚙️ Installation

### Requirements
- PHP 7.4 or higher
- MySQL 5.7 or higher
- Apache (XAMPP recommended for local setup)

### Steps

1. **Clone or download** this repository into your web server's root directory:
   ```
   htdocs/aclc_system/   ← for XAMPP
   ```

2. **Import the database:**
   - Open phpMyAdmin
   - Create a new database (e.g., `if0_41780400_aclccms`)
   - Import `aclc_cms.sql`

3. **Configure the database connection** in `includes/config.php`:
   ```php
   define('DB_HOST', 'localhost');       // or your host
   define('DB_USER', 'root');            // your DB username
   define('DB_PASS', '');                // your DB password
   define('DB_NAME', 'aclc_cms');        // your DB name
   ```

4. **Access the system:**
   - Student Portal: `http://localhost/aclc_system/index.php`
   - Admin Panel:    `http://localhost/aclc_system/admin/login.php`

---

## 🗄️ Database Setup

The `aclc_cms.sql` file includes the full schema for the following tables:

| Table | Description |
|---|---|
| `students` | Student accounts and profile info |
| `admins` | Admin accounts with roles and house assignment |
| `clubs` | Club listings with house and max member settings |
| `memberships` | Student club applications and statuses |
| `membership_cards` | Issued digital membership cards |
| `events` | Events and announcements per house |

---

## 🚀 Usage

### Student Login
Students log in using their **Student ID** and password at `index.php`. First-time users may need to be registered by an admin or via a registration flow.

### Admin Login
Admins log in at `admin/login.php` using their username and password. reCAPTCHA must be completed.

### Approving Memberships
1. Go to **Memberships** in the admin panel
2. Filter by `Pending`
3. Click **✓ Approve** to issue a digital card, or **✗ Reject** with an optional reason

### Creating a Club
1. Go to **Clubs** in the admin panel
2. Click **Add New Club**
3. Fill in name, description, house (Super Admin can assign to any house or all houses), and max members

---

## 📌 Notes

- reCAPTCHA keys in `admin/login.php` are configured for the deployed domain. Update them for local or new deployments via [Google reCAPTCHA Console](https://www.google.com/recaptcha/admin).
- The student portal UI dynamically applies the student's house color as the primary accent throughout all pages.
- Membership cards are auto-generated with a unique card number upon approval.

---

## 🏫 About

Developed as a capstone/thesis project for **ACLC College of Mandaue**.  
Built to digitize and streamline club management and student membership tracking across the school's house system.

Submitted to: Sir Remedio Panfilo Jr. — Application Development & Emerging Technology

ACLC Online Club & Membership System
ACLC College of Mandaue | IT22F | Hannah Maica Maningo

---

## 📁 Folder Structure

```
aclc_system/
│
├── index.php                  ← Student Login (Student ID + Password)
├── register.php               ← Student Self-Registration (generates Student ID)
├── logout.php
├── database.sql               ← Import this into phpMyAdmin!
│
├── assets/
│   └── css/
│       └── portal.css         ← All styles
│
├── includes/
│   └── config.php             ← DB connection + helper functions
│
├── student/
│   ├── dashboard.php          ← Student home
│   ├── clubs.php              ← Browse & join clubs
│   ├── my_memberships.php     ← View membership + digital ID card
│   ├── events.php             ← Events & announcements
│   └── profile.php            ← Edit profile & change password
│
└── admin/
    ├── login.php              ← Admin login
    ├── logout.php
    ├── dashboard.php          ← Admin home + pending approvals
    ├── students.php           ← Browse all students
    ├── memberships.php        ← Approve/reject applications
    ├── clubs.php              ← Manage clubs
    ├── events.php             ← Post events & announcements
    └── reports.php            ← Analytics + CSV export
```

---

## 🚀 Setup Instructions (XAMPP)

### Step 1 — Copy files
Place the `aclc_system` folder in:
```
C:\xampp\htdocs\aclc_system\
```

### Step 2 — Import the database
1. Open your browser and go to: `http://localhost/phpmyadmin`
2. Click **New** → create database named: `aclc_cms`
3. Click **Import** → select `aclc_system/database.sql`
4. Click **Go**

### Step 3 — Start XAMPP
- Start **Apache** and **MySQL** in XAMPP Control Panel

### Step 4 — Access the system

| Page | URL |
|------|-----|
| Student Login | http://localhost/aclc_system/ |
| Student Register | http://localhost/aclc_system/register.php |
| Admin Panel | http://localhost/aclc_system/admin/login.php |

---

## 🎓 Student ID System

### How it works
Students **register themselves** at `register.php`. The system:
1. 
4. Student creates their password immediately
5. Student uses their ID + password to log in from then on

### ID Format
```
C24-01-0001-MAN121
 │    │   │    └── Section code (MAN121)
 │    │   └─────── 4-digit sequence (StudentID)
 │    └─────────── Batch/section (01)
 └──────────────── School year code (C24)
```


---

### Pre-loaded Students
Pre-loaded students have **no password yet**. They must go to `register.php`,
but since their name is already in the system... 


---

## 👥 Five Houses
| House | Color |
|-------|-------|
| AZUL | Blue |
| CAHEL | Orange |
| GIALLIO | Yellow |
| ROXXO | Red |
| VIERRDY | Green |

---

## ✨ Features
- **Registration:** own Student Number & Creat their own Password
- **Auto House Assignment:** Round-robin house assignment (no bias)
- **Simple Login:** Just Student ID + Password
- **Digital Membership Cards:** Auto-generated on approval
- **Admin Dashboard:** Live stats, pending applications
- **House-colored UI:** Each house has its own color theme
- **CSV Export:** Students & memberships reports
- **Events & Announcements:** Posted by admins, visible to students

---

## 🛠 Tech Stack
- PHP 8+ (no frameworks)
- MySQL via PDO
- HTML5 / CSS3
- JavaScript (vanilla)
- XAMPP (Apache + MySQL)
- Font Awesome 6 (CDN)

---

*Submitted to: Sir Remedio Panfilo Jr. — Application Development & Emerging Technology*

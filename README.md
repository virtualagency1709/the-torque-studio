# The Torque Studio — Hostinger Production Build

Premium Automotive Detailing & Paint Protection Studio in Tilak Nagar, New Delhi.

Website: [thetorquestudio.in](https://thetorquestudio.in/)  
Contact: +91 81303 29288  
Email: info@thetorquestudio.in / enquiries@thetorquestudio.in  

---

## 🏎️ Overview

This repository contains the production-ready distribution package of **The Torque Studio** website, configured specifically for Hostinger shared/cloud hosting (Apache + PHP + MySQL).

- **Frontend**: High-performance React single-page application built with modern typography, dark-luxury aesthetic, responsive automotive design, and SEO metadata.
- **Backend**: Lightweight PHP REST API with rate limiting, input validation, CORS handling, SMTP mailer notification integration, and MySQL database persistence for customer booking enquiries, services, and FAQ management.

---

## 📁 Project Structure

```
the-torque-studio/
├── .htaccess                 # Main Apache routing and security headers
├── .gitignore                # Git ignore for environment secrets and logs
├── favicon.svg               # Website favicon
├── icons.svg                 # SVG icons sprite
├── index.html                # SPA entry point with SEO & OG tags
├── robots.txt                # Search engine crawler instructions
├── sitemap.xml               # XML sitemap for SEO indexing
├── README.md                 # Project documentation
│
├── assets/                   # Compiled frontend assets and media
│   ├── index-*.js            # Production JS bundle
│   ├── index-*.css           # Production CSS styles
│   ├── hero/                 # Hero section banners
│   ├── services/             # Service showcase images
│   └── gallery/              # Before / After detailing images
│
└── backend/                  # PHP REST API & Database
    ├── .env.example          # Environment configuration template
    ├── config/               # Application configuration
    ├── database/             # Schema definitions and seed data
    │   ├── Database.php      # PDO database singleton connection
    │   ├── schema.sql        # MySQL table schema
    │   └── seed.sql          # Initial database seed records
    ├── public/               # Public entry point for API
    │   ├── .htaccess         # API routing
    │   └── index.php         # API bootstrap & routing dispatcher
    ├── src/
    │   ├── Controllers/      # API Controllers (Enquiries, Services, etc.)
    │   ├── Middleware/       # Auth, CORS, RateLimiter middleware
    │   ├── Services/         # Mailer and upload services
    │   └── Utils/            # Response formatting and validation
    └── storage/
        └── logs/             # Application logs
```

---

## 🚀 Hostinger Deployment Guide

### 1. Upload Files
Upload all files into your domain's `public_html` root directory via Hostinger File Manager or FTP/Git.

### 2. Configure Database
1. Create a MySQL database and user in Hostinger hPanel.
2. Open phpMyAdmin and import `backend/database/schema.sql` and `backend/database/seed.sql`.

### 3. Environment Setup
1. Copy `backend/.env.example` to `backend/.env`:
   ```bash
   cp backend/.env.example backend/.env
   ```
2. Update the credentials in `backend/.env` with your DB details and SMTP configuration:
   ```ini
   APP_ENV=production
   APP_URL=https://thetorquestudio.in
   APP_SECRET=your_secure_random_key_here

   DB_HOST=localhost
   DB_PORT=3306
   DB_NAME=u123456789_torque
   DB_USER=u123456789_admin
   DB_PASS=your_db_password

   SMTP_HOST=smtp.hostinger.com
   SMTP_PORT=587
   SMTP_USER=enquiries@thetorquestudio.in
   SMTP_PASS=your_email_password
   SMTP_SECURE=tls
   MAIL_FROM=enquiries@thetorquestudio.in
   NOTIFICATION_EMAIL=info@thetorquestudio.in
   ```

### 4. File Permissions
Ensure `backend/storage/logs` is writable by PHP (`chmod 755` or `chmod 775`).

---

## 🛡️ Security & Maintenance

- Never commit `backend/.env` containing production passwords or keys.
- Apache `.htaccess` files protect sensitive configuration directories and route requests to `backend/public/index.php` or `index.html`.

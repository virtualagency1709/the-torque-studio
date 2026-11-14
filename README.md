# Radiant Detailing Studio — Production Build

Premium Automotive Detailing & Paint Protection Studio serving Kharghar and Vashi, Navi Mumbai.

Instagram: [@radiantdetailingstudio](https://www.instagram.com/radiantdetailingstudio/?hl=en)  
Kharghar Contact: +91 8591948464  
Vashi Contact: +91 7021003015  

---

## 🏎️ Overview

This repository contains the production-ready distribution package of the **Radiant Detailing Studio** website, configured for static deployment as well as Hostinger shared/cloud hosting (Apache + PHP + MySQL).

- **Frontend**: High-performance React single-page application built with modern typography, dark-luxury aesthetic, responsive automotive design, and SEO metadata.
- **Backend**: Lightweight PHP REST API with rate limiting, input validation, CORS handling, SMTP mailer notification integration, and MySQL database persistence for customer booking enquiries, services, and FAQ management.

---

## 📁 Project Structure

```
radiant-auto-detailing/
├── .htaccess                 # Main Apache routing and security headers
├── .gitignore                # Git ignore for environment secrets and logs
├── favicon.svg               # Website favicon (Radiant red shield logo)
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

## 🚀 Services Provided

1. **Paint Protection Film (PPF)** — Self-healing impact polyurethane armor
2. **Ceramic Coating** — Liquid glass SiO2 nanotechnology
3. **Graphene Coating** — Reduced thermal heat & water spotting resistance
4. **Sun Films** — Premium solar heat rejection & UV window films
5. **Car Polishing** — Single and multi-stage paint defect refinement
6. **Professional Car Wash** — Touch-safe snow foam decontaminating wash

---

## 📞 Contact Information

- **Kharghar Studio Contact**: +91 8591948464
- **Vashi Studio Contact**: +91 7021003015
- **Instagram**: [https://www.instagram.com/radiantdetailingstudio/?hl=en](https://www.instagram.com/radiantdetailingstudio/?hl=en)

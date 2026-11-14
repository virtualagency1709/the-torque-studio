<?php
/**
 * Radiant Detailing Studio — Backend Configuration
 */

// Load .env file if present
$envFile = __DIR__ . '/../.env';
if (file_exists($envFile)) {
    $lines = file($envFile, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        $line = trim($line);
        if ($line === '' || strpos($line, '#') === 0) continue;
        if (strpos($line, '=') !== false) {
            list($key, $val) = explode('=', $line, 2);
            $key = trim($key);
            $val = trim($val, " \t\n\r\0\x0B\"'");
            $_ENV[$key] = $val;
            putenv("$key=$val");
        }
    }
}

return [
    'app_name' => 'Radiant Detailing Studio API',
    'app_env' => getenv('APP_ENV') ?: 'production',
    'app_url' => getenv('APP_URL') ?: 'http://localhost:8000',
    
    // Database credentials
    'db' => [
        'host' => getenv('DB_HOST') ?: 'localhost',
        'port' => getenv('DB_PORT') ?: '3306',
        'dbname' => getenv('DB_NAME') ?: 'radiant_detailing_studio',
        'username' => getenv('DB_USER') ?: 'root',
        'password' => getenv('DB_PASS') !== false ? getenv('DB_PASS') : '',
        'charset' => 'utf8mb4'
    ],

    // Security & Auth
    'security' => [
        'session_lifetime' => 86400, // 24 hours
        'session_cookie_name' => 'radiant_admin_sess',
        'admin_secret' => getenv('APP_SECRET') ?: 'Radiant_Auto_Detailing_Secure_Salt_2026',
    ],

    // SMTP Mailer settings
    'mail' => [
        'smtp_host' => getenv('SMTP_HOST') ?: '',
        'smtp_port' => getenv('SMTP_PORT') ?: 587,
        'smtp_user' => getenv('SMTP_USER') ?: '',
        'smtp_pass' => getenv('SMTP_PASS') ?: '',
        'smtp_secure' => getenv('SMTP_SECURE') ?: 'tls',
        'from_address' => getenv('MAIL_FROM') ?: '',
        'from_name' => 'Radiant Detailing Studio',
        'notification_recipient' => getenv('NOTIFICATION_EMAIL') ?: '',
    ],

    // Uploads
    'storage' => [
        'uploads_path' => __DIR__ . '/../storage/uploads',
        'max_file_size' => 10 * 1024 * 1024, // 10MB
        'allowed_mimes' => ['image/jpeg', 'image/png', 'image/webp', 'image/svg+xml']
    ]
];

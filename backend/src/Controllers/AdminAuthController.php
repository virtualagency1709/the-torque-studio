<?php
/**
 * Admin Authentication Controller
 */

namespace Torque\Controllers;

use Torque\Database\Database;
use Torque\Middleware\AuthMiddleware;
use Torque\Middleware\RateLimiter;
use Torque\Utils\Response;
use Torque\Utils\Validator;

class AdminAuthController {
    public function login(): void {
        // Rate limiting: 5 failed attempts in 5 minutes
        RateLimiter::check('admin_login', 5, 300);

        $data = json_decode(file_get_contents('php://input'), true) ?: $_POST;

        $v = Validator::make($data)
            ->required('username', 'Username / Email')
            ->required('password', 'Password');

        if ($v->fails()) {
            Response::error('Invalid credentials', 422, $v->getErrors());
            return;
        }

        $userIdentifier = trim($data['username']);
        $password = (string)$data['password'];

        $pdo = Database::getConnection();

        // Check if any admin exists in the database.
        $count = (int)$pdo->query("SELECT COUNT(*) FROM admins")->fetchColumn();
        if ($count === 0) {
            // First run: securely register first admin user
            $hash = password_hash($password, PASSWORD_BCRYPT);
            $initStmt = $pdo->prepare("INSERT INTO admins (username, email, password_hash) VALUES (:u, :e, :p)");
            $initStmt->execute([
                ':u' => $userIdentifier,
                ':e' => strpos($userIdentifier, '@') !== false ? $userIdentifier : 'admin@thetorquestudio.in',
                ':p' => $hash
            ]);
        }

        $stmt = $pdo->prepare("SELECT * FROM admins WHERE username = :u OR email = :e LIMIT 1");
        $stmt->execute([':u' => $userIdentifier, ':e' => $userIdentifier]);
        $admin = $stmt->fetch();

        if (!$admin || !password_verify($password, $admin['password_hash'])) {
            Response::error('Invalid username or password.', 401);
            return;
        }

        // Initialize session and regenerate ID for session fixation defense
        if (session_status() === PHP_SESSION_NONE) {
            $config = require __DIR__ . '/../../config/config.php';
            session_name($config['security']['session_cookie_name']);
            session_set_cookie_params([
                'lifetime' => $config['security']['session_lifetime'],
                'path' => '/',
                'domain' => '',
                'secure' => isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on',
                'httponly' => true,
                'samesite' => 'Lax'
            ]);
            session_start();
        }
        session_regenerate_id(true);

        $adminPayload = [
            'id' => (int)$admin['id'],
            'username' => $admin['username'],
            'email' => $admin['email']
        ];

        $_SESSION['admin_user'] = $adminPayload;

        // Update last login
        $pdo->prepare("UPDATE admins SET last_login = NOW() WHERE id = :id")->execute([':id' => $admin['id']]);

        // Generate signed token for authorization headers
        $token = AuthMiddleware::generateToken($adminPayload);

        Response::json([
            'admin' => $adminPayload,
            'token' => $token
        ], 200, 'Login successful');
    }

    public function logout(): void {
        if (session_status() === PHP_SESSION_NONE) {
            $config = require __DIR__ . '/../../config/config.php';
            session_name($config['security']['session_cookie_name']);
            session_start();
        }

        $_SESSION = [];
        if (ini_get("session.use_cookies")) {
            $params = session_get_cookie_params();
            setcookie(session_name(), '', time() - 42000,
                $params["path"], $params["domain"],
                $params["secure"], $params["httponly"]
            );
        }
        session_destroy();

        Response::json(null, 200, 'Logged out successfully');
    }

    public function checkSession(): void {
        $admin = AuthMiddleware::check();
        Response::json(['admin' => $admin]);
    }
}

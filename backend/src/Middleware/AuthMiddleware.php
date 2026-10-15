<?php
/**
 * Admin Authentication Middleware
 */

namespace Torque\Middleware;

use Torque\Utils\Response;

class AuthMiddleware {
    public static function check(): array {
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

        // Check if admin is logged into session
        if (isset($_SESSION['admin_user']) && !empty($_SESSION['admin_user']['id'])) {
            return $_SESSION['admin_user'];
        }

        // Check Authorization header fallback (Bearer token token)
        $headers = getallheaders();
        $authHeader = $headers['Authorization'] ?? $headers['authorization'] ?? '';
        if (preg_match('/Bearer\s+(\S+)/i', $authHeader, $matches)) {
            $token = $matches[1];
            // Decode simple signed token: base64(payload).signature
            $parts = explode('.', $token);
            if (count($parts) === 2) {
                list($payloadB64, $signature) = $parts;
                $config = require __DIR__ . '/../../config/config.php';
                $expectedSig = hash_hmac('sha256', $payloadB64, $config['security']['admin_secret']);
                if (hash_equals($expectedSig, $signature)) {
                    $admin = json_decode(base64_decode($payloadB64), true);
                    if ($admin && isset($admin['id']) && (!isset($admin['exp']) || $admin['exp'] > time())) {
                        return $admin;
                    }
                }
            }
        }

        Response::error('Unauthorized access. Please log in.', 401);
        exit;
    }

    public static function generateToken(array $adminData): string {
        $config = require __DIR__ . '/../../config/config.php';
        $payload = array_merge($adminData, [
            'exp' => time() + $config['security']['session_lifetime']
        ]);
        $payloadB64 = base64_encode(json_encode($payload));
        $signature = hash_hmac('sha256', $payloadB64, $config['security']['admin_secret']);
        return "$payloadB64.$signature";
    }
}

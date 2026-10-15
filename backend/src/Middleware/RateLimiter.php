<?php
/**
 * Rate Limiter to prevent brute-force attacks and enquiry spam
 */

namespace Torque\Middleware;

use Torque\Utils\Response;

class RateLimiter {
    public static function check(string $actionKey, int $maxAttempts = 5, int $decaySeconds = 300): void {
        $ip = $_SERVER['REMOTE_ADDR'] ?? '127.0.0.1';
        $key = 'rate_' . md5($actionKey . '_' . $ip);
        $storageDir = __DIR__ . '/../../storage/logs';

        if (!is_dir($storageDir)) {
            mkdir($storageDir, 0755, true);
        }

        $file = $storageDir . '/' . $key . '.json';
        $now = time();

        $data = ['count' => 0, 'first_attempt' => $now];
        if (file_exists($file)) {
            $content = @file_get_contents($file);
            $parsed = json_decode($content, true);
            if ($parsed && ($now - $parsed['first_attempt']) < $decaySeconds) {
                $data = $parsed;
            }
        }

        $data['count']++;

        if ($data['count'] > $maxAttempts) {
            $retryAfter = $decaySeconds - ($now - $data['first_attempt']);
            header("Retry-After: $retryAfter");
            Response::error("Too many requests. Please try again in $retryAfter seconds.", 429);
            exit;
        }

        @file_put_contents($file, json_encode($data));
    }
}

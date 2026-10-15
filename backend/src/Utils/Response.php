<?php
/**
 * Standardized JSON API Response
 */

namespace Torque\Utils;

class Response {
    public static function json($data = null, int $statusCode = 200, string $message = ''): void {
        http_response_code($statusCode);
        header('Content-Type: application/json; charset=utf-8');
        
        $payload = [
            'success' => ($statusCode >= 200 && $statusCode < 300),
            'status' => $statusCode,
        ];

        if ($message !== '') {
            $payload['message'] = $message;
        }

        if ($data !== null) {
            $payload['data'] = $data;
        }

        echo json_encode($payload, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
        exit;
    }

    public static function error(string $message, int $statusCode = 400, $errors = null): void {
        http_response_code($statusCode);
        header('Content-Type: application/json; charset=utf-8');

        $payload = [
            'success' => false,
            'status' => $statusCode,
            'message' => $message,
        ];

        if ($errors !== null) {
            $payload['errors'] = $errors;
        }

        echo json_encode($payload, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
        exit;
    }
}

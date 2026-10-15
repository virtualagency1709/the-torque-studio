<?php
/**
 * Site Settings Controller
 */

namespace Torque\Controllers;

use Torque\Database\Database;
use Torque\Utils\Response;

class SettingsController {
    public function index(): void {
        $pdo = Database::getConnection();
        $stmt = $pdo->query("SELECT setting_key, setting_value FROM site_settings");
        $rows = $stmt->fetchAll();

        $settings = [];
        // Block sensitive keys from public consumption
        $sensitive = ['smtp_pass', 'db_pass', 'admin_secret'];

        foreach ($rows as $row) {
            if (!in_array($row['setting_key'], $sensitive)) {
                $settings[$row['setting_key']] = $row['setting_value'];
            }
        }

        Response::json($settings);
    }

    public function update(): void {
        $data = json_decode(file_get_contents('php://input'), true) ?: $_POST;
        $pdo = Database::getConnection();

        $stmt = $pdo->prepare("
            INSERT INTO site_settings (setting_key, setting_value) 
            VALUES (:key, :val) 
            ON DUPLICATE KEY UPDATE setting_value = :val2
        ");

        foreach ($data as $key => $val) {
            $stmt->execute([
                ':key' => $key,
                ':val' => (string)$val,
                ':val2' => (string)$val
            ]);
        }

        Response::json(null, 200, 'Site settings updated successfully');
    }
}

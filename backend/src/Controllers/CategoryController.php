<?php
/**
 * Service Category Controller
 */

namespace Torque\Controllers;

use Torque\Database\Database;
use Torque\Utils\Response;

class CategoryController {
    public function index(): void {
        $pdo = Database::getConnection();
        $stmt = $pdo->query("
            SELECT c.*, COUNT(s.id) as services_count 
            FROM service_categories c
            LEFT JOIN services s ON s.category_id = c.id AND s.is_published = 1
            GROUP BY c.id
            ORDER BY c.sort_order ASC, c.name ASC
        ");
        $categories = $stmt->fetchAll();
        Response::json($categories);
    }
}

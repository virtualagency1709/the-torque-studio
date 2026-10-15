<?php
/**
 * Gallery Controller — Showcase items & Before/After comparisons
 */

namespace Torque\Controllers;

use Torque\Database\Database;
use Torque\Utils\Response;
use Torque\Utils\Validator;

class GalleryController {
    public function index(): void {
        $pdo = Database::getConnection();
        $category = $_GET['category'] ?? null;

        $sql = "SELECT * FROM gallery_items WHERE is_published = 1";
        $params = [];

        if (!empty($category) && $category !== 'All') {
            $sql .= " AND category = :category";
            $params[':category'] = $category;
        }

        $sql .= " ORDER BY sort_order ASC, id DESC";

        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        $items = $stmt->fetchAll();

        Response::json($items);
    }

    // Admin endpoints
    public function adminIndex(): void {
        $pdo = Database::getConnection();
        $stmt = $pdo->query("SELECT * FROM gallery_items ORDER BY sort_order ASC, id DESC");
        Response::json($stmt->fetchAll());
    }

    public function store(): void {
        $data = json_decode(file_get_contents('php://input'), true) ?: $_POST;

        $v = Validator::make($data)
            ->required('title', 'Title')
            ->required('category', 'Category')
            ->required('after_image', 'After Image URL');

        if ($v->fails()) {
            Response::error('Validation failed', 422, $v->getErrors());
            return;
        }

        $pdo = Database::getConnection();
        $stmt = $pdo->prepare("
            INSERT INTO gallery_items (
                title, category, before_image, after_image, description,
                vehicle_type, is_before_after, sort_order, is_published
            ) VALUES (
                :title, :category, :before_image, :after_image, :description,
                :vehicle_type, :is_before_after, :sort_order, :is_published
            )
        ");

        $stmt->execute([
            ':title' => Validator::sanitize($data['title']),
            ':category' => Validator::sanitize($data['category']),
            ':before_image' => !empty($data['before_image']) ? $data['before_image'] : null,
            ':after_image' => $data['after_image'],
            ':description' => !empty($data['description']) ? Validator::sanitize($data['description']) : null,
            ':vehicle_type' => !empty($data['vehicle_type']) ? Validator::sanitize($data['vehicle_type']) : null,
            ':is_before_after' => !empty($data['is_before_after']) ? 1 : 0,
            ':sort_order' => (int)($data['sort_order'] ?? 0),
            ':is_published' => isset($data['is_published']) ? (int)$data['is_published'] : 1
        ]);

        Response::json(['id' => $pdo->lastInsertId()], 201, 'Gallery item created successfully');
    }

    public function delete(int $id): void {
        $pdo = Database::getConnection();
        $stmt = $pdo->prepare("DELETE FROM gallery_items WHERE id = :id");
        $stmt->execute([':id' => $id]);
        Response::json(null, 200, 'Gallery item deleted successfully');
    }
}

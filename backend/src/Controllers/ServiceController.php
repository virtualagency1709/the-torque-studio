<?php
/**
 * Service Controller — Manages all 22 detailing services
 */

namespace Torque\Controllers;

use Torque\Database\Database;
use Torque\Utils\Response;
use Torque\Utils\Validator;

class ServiceController {
    public function index(): void {
        $pdo = Database::getConnection();
        
        $categorySlug = $_GET['category'] ?? null;
        $featured = isset($_GET['featured']) ? (int)$_GET['featured'] : null;
        $limit = isset($_GET['limit']) ? (int)$_GET['limit'] : null;

        $sql = "
            SELECT s.id, s.category_id, s.name, s.slug, s.short_description, 
                   s.featured_image, s.is_featured, s.is_published, s.sort_order,
                   c.name as category_name, c.slug as category_slug
            FROM services s
            JOIN service_categories c ON s.category_id = c.id
            WHERE s.is_published = 1
        ";
        $params = [];

        if ($categorySlug) {
            $sql .= " AND c.slug = :category_slug";
            $params[':category_slug'] = $categorySlug;
        }

        if ($featured !== null) {
            $sql .= " AND s.is_featured = :is_featured";
            $params[':is_featured'] = $featured;
        }

        $sql .= " ORDER BY s.sort_order ASC, s.name ASC";

        if ($limit && $limit > 0) {
            $sql .= " LIMIT " . $limit;
        }

        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        $services = $stmt->fetchAll();

        Response::json($services);
    }

    public function showBySlug(string $slug): void {
        $pdo = Database::getConnection();

        $stmt = $pdo->prepare("
            SELECT s.*, c.name as category_name, c.slug as category_slug
            FROM services s
            JOIN service_categories c ON s.category_id = c.id
            WHERE s.slug = :slug AND s.is_published = 1
            LIMIT 1
        ");
        $stmt->execute([':slug' => $slug]);
        $service = $stmt->fetch();

        if (!$service) {
            Response::error('Service not found', 404);
            return;
        }

        // Decode JSON fields
        $jsonFields = ['benefits', 'process', 'included_tasks', 'suitable_vehicles', 'gallery_images', 'faqs', 'related_service_ids'];
        foreach ($jsonFields as $field) {
            if (!empty($service[$field])) {
                $service[$field] = is_string($service[$field]) ? json_decode($service[$field], true) : $service[$field];
            } else {
                $service[$field] = [];
            }
        }

        // Fetch related services if specified
        $service['related_services'] = [];
        if (!empty($service['related_service_ids'])) {
            $inClause = implode(',', array_map('intval', $service['related_service_ids']));
            if (!empty($inClause)) {
                $relStmt = $pdo->query("
                    SELECT id, name, slug, short_description, featured_image
                    FROM services
                    WHERE id IN ($inClause) AND is_published = 1
                    LIMIT 4
                ");
                $service['related_services'] = $relStmt->fetchAll();
            }
        }

        Response::json($service);
    }

    // Admin endpoints
    public function adminIndex(): void {
        $pdo = Database::getConnection();
        $stmt = $pdo->query("
            SELECT s.*, c.name as category_name 
            FROM services s
            JOIN service_categories c ON s.category_id = c.id
            ORDER BY s.sort_order ASC, s.id ASC
        ");
        $services = $stmt->fetchAll();

        // Decode JSON fields for table display
        foreach ($services as &$service) {
            $service['benefits'] = !empty($service['benefits']) ? json_decode($service['benefits'], true) : [];
            $service['process'] = !empty($service['process']) ? json_decode($service['process'], true) : [];
        }

        Response::json($services);
    }

    public function store(): void {
        $data = json_decode(file_get_contents('php://input'), true) ?: $_POST;

        $v = Validator::make($data)
            ->required('name', 'Service Name')
            ->required('category_id', 'Category')
            ->required('short_description', 'Short Description');

        if ($v->fails()) {
            Response::error('Validation failed', 422, $v->getErrors());
            return;
        }

        $slug = !empty($data['slug']) ? $this->slugify($data['slug']) : $this->slugify($data['name']);
        
        $pdo = Database::getConnection();
        
        // Ensure slug is unique
        $checkStmt = $pdo->prepare("SELECT id FROM services WHERE slug = :slug LIMIT 1");
        $checkStmt->execute([':slug' => $slug]);
        if ($checkStmt->fetch()) {
            $slug .= '-' . rand(100, 999);
        }

        $stmt = $pdo->prepare("
            INSERT INTO services (
                category_id, name, slug, short_description, full_description,
                benefits, process, included_tasks, suitable_vehicles,
                featured_image, gallery_images, faqs, meta_title, meta_description,
                is_featured, is_published, sort_order
            ) VALUES (
                :category_id, :name, :slug, :short_description, :full_description,
                :benefits, :process, :included_tasks, :suitable_vehicles,
                :featured_image, :gallery_images, :faqs, :meta_title, :meta_description,
                :is_featured, :is_published, :sort_order
            )
        ");

        $stmt->execute([
            ':category_id' => (int)$data['category_id'],
            ':name' => Validator::sanitize($data['name']),
            ':slug' => $slug,
            ':short_description' => Validator::sanitize($data['short_description']),
            ':full_description' => $data['full_description'] ?? $data['short_description'],
            ':benefits' => isset($data['benefits']) ? json_encode($data['benefits']) : '[]',
            ':process' => isset($data['process']) ? json_encode($data['process']) : '[]',
            ':included_tasks' => isset($data['included_tasks']) ? json_encode($data['included_tasks']) : '[]',
            ':suitable_vehicles' => isset($data['suitable_vehicles']) ? json_encode($data['suitable_vehicles']) : '[]',
            ':featured_image' => $data['featured_image'] ?? '/assets/services/ceramic-coating.jpg',
            ':gallery_images' => isset($data['gallery_images']) ? json_encode($data['gallery_images']) : '[]',
            ':faqs' => isset($data['faqs']) ? json_encode($data['faqs']) : '[]',
            ':meta_title' => $data['meta_title'] ?? ($data['name'] . ' | The Torque Studio'),
            ':meta_description' => $data['meta_description'] ?? $data['short_description'],
            ':is_featured' => !empty($data['is_featured']) ? 1 : 0,
            ':is_published' => isset($data['is_published']) ? (int)$data['is_published'] : 1,
            ':sort_order' => (int)($data['sort_order'] ?? 0)
        ]);

        $newId = $pdo->lastInsertId();
        Response::json(['id' => $newId, 'slug' => $slug], 201, 'Service created successfully');
    }

    public function update(int $id): void {
        $data = json_decode(file_get_contents('php://input'), true) ?: $_POST;
        $pdo = Database::getConnection();

        $stmt = $pdo->prepare("SELECT id FROM services WHERE id = :id LIMIT 1");
        $stmt->execute([':id' => $id]);
        if (!$stmt->fetch()) {
            Response::error('Service not found', 404);
            return;
        }

        $updateFields = [];
        $params = [':id' => $id];

        $allowed = [
            'name', 'category_id', 'short_description', 'full_description',
            'featured_image', 'meta_title', 'meta_description',
            'is_featured', 'is_published', 'sort_order'
        ];

        foreach ($allowed as $f) {
            if (isset($data[$f])) {
                $updateFields[] = "$f = :$f";
                $params[":$f"] = $data[$f];
            }
        }

        $jsonCols = ['benefits', 'process', 'included_tasks', 'suitable_vehicles', 'gallery_images', 'faqs'];
        foreach ($jsonCols as $jc) {
            if (isset($data[$jc])) {
                $updateFields[] = "$jc = :$jc";
                $params[":$jc"] = is_string($data[$jc]) ? $data[$jc] : json_encode($data[$jc]);
            }
        }

        if (empty($updateFields)) {
            Response::json(null, 200, 'No updates provided');
            return;
        }

        $sql = "UPDATE services SET " . implode(', ', $updateFields) . " WHERE id = :id";
        $updateStmt = $pdo->prepare($sql);
        $updateStmt->execute($params);

        Response::json(null, 200, 'Service updated successfully');
    }

    public function delete(int $id): void {
        $pdo = Database::getConnection();
        $stmt = $pdo->prepare("DELETE FROM services WHERE id = :id");
        $stmt->execute([':id' => $id]);
        Response::json(null, 200, 'Service deleted successfully');
    }

    private function slugify(string $text): string {
        $text = preg_replace('~[^\pL\d]+~u', '-', $text);
        $text = iconv('utf-8', 'us-ascii//TRANSLIT', $text);
        $text = preg_replace('~[^-\w]+~', '', $text);
        $text = trim($text, '-');
        $text = preg_replace('~-+~', '-', $text);
        return strtolower($text) ?: 'service-' . time();
    }
}

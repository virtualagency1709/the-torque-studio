<?php
/**
 * FAQ Controller
 */

namespace Torque\Controllers;

use Torque\Database\Database;
use Torque\Utils\Response;
use Torque\Utils\Validator;

class FaqController {
    public function index(): void {
        $pdo = Database::getConnection();
        $stmt = $pdo->query("SELECT * FROM faqs WHERE is_published = 1 ORDER BY sort_order ASC, id ASC");
        Response::json($stmt->fetchAll());
    }

    public function adminIndex(): void {
        $pdo = Database::getConnection();
        $stmt = $pdo->query("SELECT * FROM faqs ORDER BY sort_order ASC, id ASC");
        Response::json($stmt->fetchAll());
    }

    public function store(): void {
        $data = json_decode(file_get_contents('php://input'), true) ?: $_POST;
        $v = Validator::make($data)->required('question')->required('answer');
        if ($v->fails()) {
            Response::error('Question and answer are required', 422, $v->getErrors());
            return;
        }

        $pdo = Database::getConnection();
        $stmt = $pdo->prepare("INSERT INTO faqs (question, answer, category, sort_order, is_published) VALUES (:q, :a, :cat, :so, :pub)");
        $stmt->execute([
            ':q' => Validator::sanitize($data['question']),
            ':a' => Validator::sanitize($data['answer']),
            ':cat' => $data['category'] ?? 'General',
            ':so' => (int)($data['sort_order'] ?? 0),
            ':pub' => isset($data['is_published']) ? (int)$data['is_published'] : 1
        ]);
        Response::json(['id' => $pdo->lastInsertId()], 201, 'FAQ created');
    }

    public function update(int $id): void {
        $data = json_decode(file_get_contents('php://input'), true) ?: $_POST;
        $pdo = Database::getConnection();
        $stmt = $pdo->prepare("UPDATE faqs SET question = :q, answer = :a, category = :cat, sort_order = :so, is_published = :pub WHERE id = :id");
        $stmt->execute([
            ':q' => Validator::sanitize($data['question']),
            ':a' => Validator::sanitize($data['answer']),
            ':cat' => $data['category'] ?? 'General',
            ':so' => (int)($data['sort_order'] ?? 0),
            ':pub' => isset($data['is_published']) ? (int)$data['is_published'] : 1,
            ':id' => $id
        ]);
        Response::json(null, 200, 'FAQ updated');
    }

    public function delete(int $id): void {
        $pdo = Database::getConnection();
        $stmt = $pdo->prepare("DELETE FROM faqs WHERE id = :id");
        $stmt->execute([':id' => $id]);
        Response::json(null, 200, 'FAQ deleted');
    }
}

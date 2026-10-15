<?php
/**
 * Enquiry Controller — Appointment booking requests and customer inquiries
 */

namespace Torque\Controllers;

use Torque\Database\Database;
use Torque\Middleware\RateLimiter;
use Torque\Services\MailerService;
use Torque\Utils\Response;
use Torque\Utils\Validator;

class EnquiryController {
    public function store(): void {
        // Rate limiting: 6 attempts per 10 minutes per IP
        RateLimiter::check('enquiry_submission', 6, 600);

        $rawInput = file_get_contents('php://input');
        $data = json_decode($rawInput, true) ?: $_POST;

        // Anti-spam honeypot: bots fill hidden fields
        if (!empty($data['hp_field']) || !empty($data['website_url'])) {
            // Silently reject bot submission
            Response::json(['reference_id' => 'TQ-' . rand(1000, 9999)], 200, 'Enquiry received.');
            return;
        }

        $v = Validator::make($data)
            ->required('full_name', 'Full Name')
            ->minLength('full_name', 2)
            ->required('phone', 'Phone Number')
            ->phone('phone', 'Phone Number')
            ->email('email', 'Email Address')
            ->required('vehicle_brand', 'Vehicle Brand')
            ->required('vehicle_model', 'Vehicle Model')
            ->required('preferred_date', 'Preferred Date')
            ->required('preferred_time', 'Preferred Time');

        if ($v->fails()) {
            Response::error('Please fill in all required fields accurately.', 422, $v->getErrors());
            return;
        }

        $serviceId = !empty($data['service_id']) ? (int)$data['service_id'] : null;
        $serviceName = !empty($data['service_name']) ? Validator::sanitize($data['service_name']) : 'General Detailing Consultation';

        $pdo = Database::getConnection();

        // If serviceId is provided, confirm service name
        if ($serviceId) {
            $stmt = $pdo->prepare("SELECT name FROM services WHERE id = :id LIMIT 1");
            $stmt->execute([':id' => $serviceId]);
            $svc = $stmt->fetch();
            if ($svc) {
                $serviceName = $svc['name'];
            }
        }

        $ip = $_SERVER['REMOTE_ADDR'] ?? '127.0.0.1';

        $insertSql = "
            INSERT INTO enquiries (
                full_name, phone, email, vehicle_brand, vehicle_model, vehicle_type,
                service_id, service_name, preferred_date, preferred_time,
                additional_notes, consent_given, status, ip_address
            ) VALUES (
                :full_name, :phone, :email, :vehicle_brand, :vehicle_model, :vehicle_type,
                :service_id, :service_name, :preferred_date, :preferred_time,
                :additional_notes, :consent_given, 'new', :ip_address
            )
        ";

        $stmt = $pdo->prepare($insertSql);
        $stmt->execute([
            ':full_name' => Validator::sanitize($data['full_name']),
            ':phone' => Validator::sanitize($data['phone']),
            ':email' => !empty($data['email']) ? Validator::sanitize($data['email']) : null,
            ':vehicle_brand' => Validator::sanitize($data['vehicle_brand']),
            ':vehicle_model' => Validator::sanitize($data['vehicle_model']),
            ':vehicle_type' => Validator::sanitize($data['vehicle_type'] ?? 'Sedan'),
            ':service_id' => $serviceId,
            ':service_name' => $serviceName,
            ':preferred_date' => $data['preferred_date'],
            ':preferred_time' => Validator::sanitize($data['preferred_time']),
            ':additional_notes' => !empty($data['additional_notes']) ? Validator::sanitize($data['additional_notes']) : null,
            ':consent_given' => !empty($data['consent_given']) ? 1 : 1,
            ':ip_address' => $ip
        ]);

        $enquiryId = (int)$pdo->lastInsertId();

        $enquiryPayload = [
            'id' => $enquiryId,
            'full_name' => $data['full_name'],
            'phone' => $data['phone'],
            'email' => $data['email'] ?? null,
            'vehicle_brand' => $data['vehicle_brand'],
            'vehicle_model' => $data['vehicle_model'],
            'vehicle_type' => $data['vehicle_type'] ?? 'Sedan',
            'service_name' => $serviceName,
            'preferred_date' => $data['preferred_date'],
            'preferred_time' => $data['preferred_time'],
            'additional_notes' => $data['additional_notes'] ?? null
        ];

        // Trigger notification
        MailerService::sendEnquiryNotification($enquiryPayload);

        Response::json([
            'id' => $enquiryId,
            'reference_no' => 'TTS-' . date('ymd') . '-' . str_pad((string)$enquiryId, 4, '0', STR_PAD_LEFT),
            'service_name' => $serviceName
        ], 201, 'Your detailing request has been submitted successfully. Our studio will review and contact you shortly to confirm slot availability.');
    }

    public function contact(): void {
        RateLimiter::check('contact_submission', 5, 300);

        $data = json_decode(file_get_contents('php://input'), true) ?: $_POST;

        $v = Validator::make($data)
            ->required('name', 'Name')
            ->required('phone', 'Phone Number')
            ->email('email', 'Email Address')
            ->required('message', 'Message');

        if ($v->fails()) {
            Response::error('Please fill all fields accurately.', 422, $v->getErrors());
            return;
        }

        $pdo = Database::getConnection();
        $stmt = $pdo->prepare("
            INSERT INTO enquiries (
                full_name, phone, email, vehicle_brand, vehicle_model, vehicle_type,
                service_name, preferred_date, preferred_time, additional_notes,
                status, ip_address
            ) VALUES (
                :full_name, :phone, :email, 'General Inquiry', 'N/A', 'Other',
                'General Contact Message', CURDATE(), 'Flexible', :message,
                'new', :ip_address
            )
        ");

        $stmt->execute([
            ':full_name' => Validator::sanitize($data['name']),
            ':phone' => Validator::sanitize($data['phone']),
            ':email' => !empty($data['email']) ? Validator::sanitize($data['email']) : null,
            ':message' => Validator::sanitize($data['message']),
            ':ip_address' => $_SERVER['REMOTE_ADDR'] ?? '127.0.0.1'
        ]);

        Response::json(null, 201, 'Thank you! Your message has been received. We will respond promptly.');
    }

    // Admin endpoints
    public function adminIndex(): void {
        $pdo = Database::getConnection();

        $status = $_GET['status'] ?? null;
        $search = $_GET['search'] ?? null;

        $sql = "SELECT * FROM enquiries WHERE 1=1";
        $params = [];

        if (!empty($status) && $status !== 'all') {
            $sql .= " AND status = :status";
            $params[':status'] = $status;
        }

        if (!empty($search)) {
            $sql .= " AND (full_name LIKE :s1 OR phone LIKE :s2 OR vehicle_brand LIKE :s3 OR vehicle_model LIKE :s4)";
            $params[':s1'] = "%$search%";
            $params[':s2'] = "%$search%";
            $params[':s3'] = "%$search%";
            $params[':s4'] = "%$search%";
        }

        $sql .= " ORDER BY created_at DESC LIMIT 100";

        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        $enquiries = $stmt->fetchAll();

        Response::json($enquiries);
    }

    public function updateStatus(int $id): void {
        $data = json_decode(file_get_contents('php://input'), true) ?: $_POST;

        $allowedStatuses = ['new', 'contacted', 'scheduled', 'completed', 'cancelled'];
        $newStatus = $data['status'] ?? '';

        if (!in_array($newStatus, $allowedStatuses)) {
            Response::error('Invalid status value.', 400);
            return;
        }

        $pdo = Database::getConnection();
        $stmt = $pdo->prepare("UPDATE enquiries SET status = :status WHERE id = :id");
        $stmt->execute([':status' => $newStatus, ':id' => $id]);

        Response::json(['id' => $id, 'status' => $newStatus], 200, 'Status updated successfully');
    }

    public function dashboard(): void {
        $pdo = Database::getConnection();

        // Total enquiries count
        $totalEnquiries = (int)$pdo->query("SELECT COUNT(*) FROM enquiries")->fetchColumn();
        $newEnquiries = (int)$pdo->query("SELECT COUNT(*) FROM enquiries WHERE status = 'new'")->fetchColumn();
        $scheduledEnquiries = (int)$pdo->query("SELECT COUNT(*) FROM enquiries WHERE status = 'scheduled'")->fetchColumn();
        $completedEnquiries = (int)$pdo->query("SELECT COUNT(*) FROM enquiries WHERE status = 'completed'")->fetchColumn();

        // Services & Gallery counts
        $totalServices = (int)$pdo->query("SELECT COUNT(*) FROM services WHERE is_published = 1")->fetchColumn();
        $totalGallery = (int)$pdo->query("SELECT COUNT(*) FROM gallery_items WHERE is_published = 1")->fetchColumn();

        // Recent enquiries
        $recentStmt = $pdo->query("SELECT * FROM enquiries ORDER BY created_at DESC LIMIT 6");
        $recentEnquiries = $recentStmt->fetchAll();

        Response::json([
            'metrics' => [
                'total_enquiries' => $totalEnquiries,
                'new_enquiries' => $newEnquiries,
                'scheduled_enquiries' => $scheduledEnquiries,
                'completed_enquiries' => $completedEnquiries,
                'total_services' => $totalServices,
                'total_gallery' => $totalGallery,
            ],
            'recent_enquiries' => $recentEnquiries
        ]);
    }
}

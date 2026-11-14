<?php
/**
 * Radiant Detailing Studio — REST API Front Controller
 */

// Error handling & logging
ini_set('display_errors', '0');
ini_set('log_errors', '1');
$logDir = __DIR__ . '/../storage/logs';
if (!is_dir($logDir)) {
    mkdir($logDir, 0755, true);
}
ini_set('error_log', $logDir . '/php_error.log');
error_reporting(E_ALL);

// Autoloader for Radiant namespace
spl_autoload_register(function ($class) {
    $prefix = 'Radiant\\';
    $baseDir = __DIR__ . '/../src/';

    $len = strlen($prefix);
    if (strncmp($prefix, $class, $len) !== 0) {
        return;
    }

    $relativeClass = substr($class, $len);
    
    // Check if class is Database
    if ($relativeClass === 'Database\\Database') {
        $file = __DIR__ . '/../database/Database.php';
    } else {
        $file = $baseDir . str_replace('\\', '/', $relativeClass) . '.php';
    }

    if (file_exists($file)) {
        require_once $file;
    }
});

use Radiant\Router;
use Radiant\Middleware\CorsMiddleware;
use Radiant\Middleware\AuthMiddleware;
use Radiant\Utils\Response;
use Radiant\Services\UploadService;
use Radiant\Database\Database;
use Radiant\Controllers\ServiceController;
use Radiant\Controllers\CategoryController;
use Radiant\Controllers\EnquiryController;
use Radiant\Controllers\GalleryController;
use Radiant\Controllers\FaqController;
use Radiant\Controllers\SettingsController;
use Radiant\Controllers\AdminAuthController;

// Handle CORS
CorsMiddleware::handle();

$router = new Router();

// ----------------------------------------------------
// Public Endpoints
// ----------------------------------------------------
$router->get('/api/health', function() {
    $dbOk = false;
    try {
        $pdo = Database::getConnection();
        $pdo->query("SELECT 1");
        $dbOk = true;
    } catch (\Exception $e) {
        $dbOk = false;
    }
    Response::json([
        'status' => 'healthy',
        'database' => $dbOk,
        'app' => 'Radiant Detailing Studio API',
        'version' => '1.0.0',
        'timestamp' => date('c')
    ]);
});

$router->get('/api/site-settings', [SettingsController::class, 'index']);
$router->get('/api/categories', [CategoryController::class, 'index']);
$router->get('/api/services', [ServiceController::class, 'index']);
$router->get('/api/services/{slug}', [ServiceController::class, 'showBySlug']);
$router->get('/api/gallery', [GalleryController::class, 'index']);
$router->get('/api/faqs', [FaqController::class, 'index']);
$router->post('/api/enquiries', [EnquiryController::class, 'store']);
$router->post('/api/contact', [EnquiryController::class, 'contact']);

// ----------------------------------------------------
// Auth Endpoints
// ----------------------------------------------------
$router->post('/api/admin/login', [AdminAuthController::class, 'login']);
$router->post('/api/admin/logout', [AdminAuthController::class, 'logout']);
$router->get('/api/admin/check-session', [AdminAuthController::class, 'checkSession']);

// ----------------------------------------------------
// Protected Admin Endpoints
// ----------------------------------------------------
$authCheck = [AuthMiddleware::class, 'check'];

$router->get('/api/admin/dashboard', [EnquiryController::class, 'dashboard'], [$authCheck]);
$router->get('/api/admin/enquiries', [EnquiryController::class, 'adminIndex'], [$authCheck]);
$router->patch('/api/admin/enquiries/{id}', [EnquiryController::class, 'updateStatus'], [$authCheck]);

$router->get('/api/admin/services', [ServiceController::class, 'adminIndex'], [$authCheck]);
$router->post('/api/admin/services', [ServiceController::class, 'store'], [$authCheck]);
$router->put('/api/admin/services/{id}', [ServiceController::class, 'update'], [$authCheck]);
$router->delete('/api/admin/services/{id}', [ServiceController::class, 'delete'], [$authCheck]);

$router->get('/api/admin/gallery', [GalleryController::class, 'adminIndex'], [$authCheck]);
$router->post('/api/admin/gallery', [GalleryController::class, 'store'], [$authCheck]);
$router->delete('/api/admin/gallery/{id}', [GalleryController::class, 'delete'], [$authCheck]);

$router->get('/api/admin/faqs', [FaqController::class, 'adminIndex'], [$authCheck]);
$router->post('/api/admin/faqs', [FaqController::class, 'store'], [$authCheck]);
$router->put('/api/admin/faqs/{id}', [FaqController::class, 'update'], [$authCheck]);
$router->delete('/api/admin/faqs/{id}', [FaqController::class, 'delete'], [$authCheck]);

$router->put('/api/admin/settings', [SettingsController::class, 'update'], [$authCheck]);

// Upload endpoint
$router->post('/api/admin/upload', function() {
    AuthMiddleware::check();
    if (!isset($_FILES['file'])) {
        Response::error('No file uploaded', 400);
        return;
    }
    try {
        $folder = $_POST['folder'] ?? 'services';
        $path = UploadService::handleUpload($_FILES['file'], $folder);
        Response::json(['url' => $path], 201, 'File uploaded successfully');
    } catch (\Exception $e) {
        Response::error($e->getMessage(), 400);
    }
}, [$authCheck]);

// ----------------------------------------------------
// Dispatch Request
// ----------------------------------------------------
try {
    $method = $_SERVER['REQUEST_METHOD'];
    $uri = $_SERVER['REQUEST_URI'];
    $router->dispatch($method, $uri);
} catch (\Throwable $e) {
    error_log("Unhandled Exception: " . $e->getMessage() . "\n" . $e->getTraceAsString());
    Response::error("An unexpected server error occurred.", 500);
}

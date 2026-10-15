<?php
/**
 * Secure File Upload Service
 */

namespace Torque\Services;

class UploadService {
    public static function handleUpload(array $file, string $subfolder = 'services'): ?string {
        if (!isset($file['error']) || $file['error'] !== UPLOAD_ERR_OK) {
            return null;
        }

        $config = require __DIR__ . '/../../config/config.php';
        $storageConfig = $config['storage'];

        // Verify file size
        if ($file['size'] > $storageConfig['max_file_size']) {
            throw new \Exception('File exceeds maximum allowed size of 10MB.');
        }

        // Verify MIME type using finfo
        $finfo = new \finfo(FILEINFO_MIME_TYPE);
        $mime = $finfo->file($file['tmp_name']);
        if (!in_array($mime, $storageConfig['allowed_mimes'])) {
            throw new \Exception('Invalid image format. Allowed formats: JPEG, PNG, WebP, SVG.');
        }

        // Extension mapping
        $extensions = [
            'image/jpeg' => 'jpg',
            'image/png' => 'png',
            'image/webp' => 'webp',
            'image/svg+xml' => 'svg'
        ];
        $ext = $extensions[$mime] ?? 'jpg';

        $targetDir = $storageConfig['uploads_path'] . '/' . $subfolder;
        if (!is_dir($targetDir)) {
            mkdir($targetDir, 0755, true);
        }

        // Generate cryptographically secure random filename
        $filename = bin2hex(random_bytes(16)) . '.' . $ext;
        $destination = $targetDir . '/' . $filename;

        if (!move_uploaded_file($file['tmp_name'], $destination)) {
            throw new \Exception('Failed to save uploaded file.');
        }

        // Return relative public path
        return '/uploads/' . $subfolder . '/' . $filename;
    }
}

<?php
/**
 * SMTP Mailer Service for Enquiry Notifications
 */

namespace Torque\Services;

class MailerService {
    public static function sendEnquiryNotification(array $enquiry): bool {
        $config = require __DIR__ . '/../../config/config.php';
        $mailConfig = $config['mail'];

        $to = $mailConfig['notification_recipient'];
        $subject = "New Detailing Enquiry: " . $enquiry['full_name'] . " (" . $enquiry['vehicle_brand'] . " " . $enquiry['vehicle_model'] . ")";
        
        $bodyHtml = "
        <div style='font-family: Arial, sans-serif; background-color: #101114; color: #F5F5F5; padding: 24px; border-radius: 8px;'>
            <h2 style='color: #E63946; margin-top: 0;'>New Detailing Booking Request</h2>
            <p style='color: #C7CBD1;'>A customer has submitted a new service enquiry through The Torque Studio website.</p>
            
            <table style='width: 100%; border-collapse: collapse; margin-top: 16px; color: #F5F5F5;'>
                <tr style='border-bottom: 1px solid #22252B;'>
                    <td style='padding: 10px; color: #A5A7AE; width: 35%;'><strong>Full Name:</strong></td>
                    <td style='padding: 10px;'>" . htmlspecialchars($enquiry['full_name']) . "</td>
                </tr>
                <tr style='border-bottom: 1px solid #22252B;'>
                    <td style='padding: 10px; color: #A5A7AE;'><strong>Phone Number:</strong></td>
                    <td style='padding: 10px;'><a href='tel:" . htmlspecialchars($enquiry['phone']) . "' style='color: #E63946;'>" . htmlspecialchars($enquiry['phone']) . "</a></td>
                </tr>
                <tr style='border-bottom: 1px solid #22252B;'>
                    <td style='padding: 10px; color: #A5A7AE;'><strong>Email:</strong></td>
                    <td style='padding: 10px;'>" . htmlspecialchars($enquiry['email'] ?? 'Not provided') . "</td>
                </tr>
                <tr style='border-bottom: 1px solid #22252B;'>
                    <td style='padding: 10px; color: #A5A7AE;'><strong>Vehicle:</strong></td>
                    <td style='padding: 10px;'>" . htmlspecialchars($enquiry['vehicle_brand']) . " " . htmlspecialchars($enquiry['vehicle_model']) . " (" . htmlspecialchars($enquiry['vehicle_type']) . ")</td>
                </tr>
                <tr style='border-bottom: 1px solid #22252B;'>
                    <td style='padding: 10px; color: #A5A7AE;'><strong>Service Required:</strong></td>
                    <td style='padding: 10px; font-weight: bold; color: #E63946;'>" . htmlspecialchars($enquiry['service_name']) . "</td>
                </tr>
                <tr style='border-bottom: 1px solid #22252B;'>
                    <td style='padding: 10px; color: #A5A7AE;'><strong>Preferred Date & Time:</strong></td>
                    <td style='padding: 10px;'>" . htmlspecialchars($enquiry['preferred_date']) . " at " . htmlspecialchars($enquiry['preferred_time']) . "</td>
                </tr>
                <tr style='border-bottom: 1px solid #22252B;'>
                    <td style='padding: 10px; color: #A5A7AE;'><strong>Additional Notes:</strong></td>
                    <td style='padding: 10px;'>" . nl2br(htmlspecialchars($enquiry['additional_notes'] ?? 'None')) . "</td>
                </tr>
                <tr>
                    <td style='padding: 10px; color: #A5A7AE;'><strong>Received At:</strong></td>
                    <td style='padding: 10px;'>" . date('Y-m-d H:i:s') . "</td>
                </tr>
            </table>

            <div style='margin-top: 24px; text-align: center; font-size: 12px; color: #7B8089;'>
                The Torque Studio · K-6, New Mahavir Nagar, Tilak Nagar, New Delhi 110018 · 081303 29288
            </div>
        </div>
        ";

        // If SMTP host is configured, attempt direct socket SMTP delivery
        if (!empty($mailConfig['smtp_host']) && !empty($mailConfig['smtp_user'])) {
            try {
                return self::sendViaSmtp($mailConfig, $to, $subject, $bodyHtml);
            } catch (\Exception $e) {
                error_log("SMTP Error: " . $e->getMessage());
                // Fall through to logging
            }
        }

        // Log notification to disk for verification & audit
        $logDir = __DIR__ . '/../../storage/logs';
        if (!is_dir($logDir)) {
            mkdir($logDir, 0755, true);
        }
        $logEntry = sprintf(
            "[%s] ENQUIRY NOTIFICATION for %s | Phone: %s | Vehicle: %s %s | Service: %s\n",
            date('Y-m-d H:i:s'),
            $enquiry['full_name'],
            $enquiry['phone'],
            $enquiry['vehicle_brand'],
            $enquiry['vehicle_model'],
            $enquiry['service_name']
        );
        @file_put_contents($logDir . '/enquiry_notifications.log', $logEntry, FILE_APPEND);

        return true;
    }

    private static function sendViaSmtp(array $config, string $to, string $subject, string $bodyHtml): bool {
        $host = $config['smtp_host'];
        $port = (int)$config['smtp_port'];
        $timeout = 10;
        
        $socket = @fsockopen($host, $port, $errno, $errstr, $timeout);
        if (!$socket) {
            throw new \Exception("Could not connect to SMTP host: $errstr ($errno)");
        }

        $getResponse = function($sock) {
            $data = '';
            while ($str = fgets($sock, 515)) {
                $data .= $str;
                if (substr($str, 3, 1) === ' ') break;
            }
            return $data;
        };

        $getResponse($socket);

        fputs($socket, "EHLO " . ($_SERVER['SERVER_NAME'] ?? 'localhost') . "\r\n");
        $getResponse($socket);

        if (!empty($config['smtp_user'])) {
            fputs($socket, "AUTH LOGIN\r\n");
            $getResponse($socket);
            fputs($socket, base64_encode($config['smtp_user']) . "\r\n");
            $getResponse($socket);
            fputs($socket, base64_encode($config['smtp_pass']) . "\r\n");
            $authRes = $getResponse($socket);
            if (strpos($authRes, '235') === false) {
                throw new \Exception("SMTP Authentication failed: $authRes");
            }
        }

        fputs($socket, "MAIL FROM: <" . $config['from_address'] . ">\r\n");
        $getResponse($socket);
        fputs($socket, "RCPT TO: <$to>\r\n");
        $getResponse($socket);
        fputs($socket, "DATA\r\n");
        $getResponse($socket);

        $headers  = "MIME-Version: 1.0\r\n";
        $headers .= "Content-Type: text/html; charset=UTF-8\r\n";
        $headers .= "From: " . $config['from_name'] . " <" . $config['from_address'] . ">\r\n";
        $headers .= "To: <$to>\r\n";
        $headers .= "Subject: =?UTF-8?B?" . base64_encode($subject) . "?=\r\n";

        fputs($socket, $headers . "\r\n" . $bodyHtml . "\r\n.\r\n");
        $sendRes = $getResponse($socket);

        fputs($socket, "QUIT\r\n");
        fclose($socket);

        return (strpos($sendRes, '250') !== false);
    }
}

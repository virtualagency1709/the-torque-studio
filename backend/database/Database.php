<?php
/**
 * The Torque Studio — Database Connection Manager (PDO)
 */

namespace Torque\Database;

use PDO;
use PDOException;

class Database {
    private static ?PDO $instance = null;
    private static ?array $config = null;

    public static function init(array $config): void {
        self::$config = $config;
    }

    public static function getConnection(): PDO {
        if (self::$instance === null) {
            if (self::$config === null) {
                $configFile = __DIR__ . '/../config/config.php';
                $appConfig = require $configFile;
                self::$config = $appConfig['db'];
            }

            $dsn = sprintf(
                "mysql:host=%s;port=%s;dbname=%s;charset=%s",
                self::$config['host'],
                self::$config['port'] ?? 3306,
                self::$config['dbname'],
                self::$config['charset'] ?? 'utf8mb4'
            );

            $options = [
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => false,
                PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci"
            ];

            try {
                self::$instance = new PDO($dsn, self::$config['username'], self::$config['password'], $options);
            } catch (PDOException $e) {
                // Try connecting without dbname in case database hasn't been created yet
                try {
                    $rootDsn = sprintf("mysql:host=%s;port=%s;charset=%s", self::$config['host'], self::$config['port'] ?? 3306, self::$config['charset'] ?? 'utf8mb4');
                    $rootPdo = new PDO($rootDsn, self::$config['username'], self::$config['password'], $options);
                    $rootPdo->exec("CREATE DATABASE IF NOT EXISTS `" . self::$config['dbname'] . "` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;");
                    self::$instance = new PDO($dsn, self::$config['username'], self::$config['password'], $options);
                } catch (\Exception $fallbackError) {
                    error_log("Database connection failed: " . $e->getMessage());
                    throw new PDOException("Database connection error: " . $e->getMessage());
                }
            }
        }

        return self::$instance;
    }
}

-- ==========================================================
-- The Torque Studio — Database Schema
-- Location: K-6, New Mahavir Nagar, Tilak Nagar, New Delhi
-- Category: Car Wash / Automotive Detailing
-- ==========================================================

CREATE DATABASE IF NOT EXISTS `the_torque_studio` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `the_torque_studio`;

-- Disable foreign key checks for clean recreation if needed
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `enquiries`;
DROP TABLE IF EXISTS `services`;
DROP TABLE IF EXISTS `service_categories`;
DROP TABLE IF EXISTS `gallery_items`;
DROP TABLE IF EXISTS `faqs`;
DROP TABLE IF EXISTS `site_settings`;
DROP TABLE IF EXISTS `admins`;

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------------------------------------
-- 1. Service Categories Table
-- ----------------------------------------------------------
CREATE TABLE `service_categories` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `slug` VARCHAR(100) NOT NULL UNIQUE,
    `description` TEXT NULL,
    `sort_order` INT NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------
-- 2. Services Table (Supports all 22 detailing services)
-- ----------------------------------------------------------
CREATE TABLE `services` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `category_id` INT NOT NULL,
    `name` VARCHAR(150) NOT NULL,
    `slug` VARCHAR(150) NOT NULL UNIQUE,
    `short_description` VARCHAR(255) NOT NULL,
    `full_description` LONGTEXT NOT NULL,
    `benefits` JSON NULL,
    `process` JSON NULL,
    `included_tasks` JSON NULL,
    `suitable_vehicles` JSON NULL,
    `featured_image` VARCHAR(255) NULL,
    `gallery_images` JSON NULL,
    `faqs` JSON NULL,
    `related_service_ids` JSON NULL,
    `meta_title` VARCHAR(200) NULL,
    `meta_description` VARCHAR(300) NULL,
    `canonical_url` VARCHAR(255) NULL,
    `is_featured` TINYINT(1) NOT NULL DEFAULT 0,
    `is_published` TINYINT(1) NOT NULL DEFAULT 1,
    `sort_order` INT NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`category_id`) REFERENCES `service_categories`(`id`) ON DELETE CASCADE,
    INDEX `idx_services_slug` (`slug`),
    INDEX `idx_services_category` (`category_id`),
    INDEX `idx_services_published` (`is_published`),
    INDEX `idx_services_featured` (`is_featured`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------
-- 3. Enquiries Table (Appointment and consultation requests)
-- ----------------------------------------------------------
CREATE TABLE `enquiries` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `full_name` VARCHAR(150) NOT NULL,
    `phone` VARCHAR(30) NOT NULL,
    `email` VARCHAR(150) NULL,
    `vehicle_brand` VARCHAR(100) NOT NULL,
    `vehicle_model` VARCHAR(100) NOT NULL,
    `vehicle_type` VARCHAR(50) NOT NULL DEFAULT 'Sedan',
    `service_id` INT NULL,
    `service_name` VARCHAR(150) NOT NULL,
    `preferred_date` DATE NOT NULL,
    `preferred_time` VARCHAR(50) NOT NULL,
    `additional_notes` TEXT NULL,
    `consent_given` TINYINT(1) NOT NULL DEFAULT 1,
    `status` ENUM('new', 'contacted', 'scheduled', 'completed', 'cancelled') NOT NULL DEFAULT 'new',
    `ip_address` VARCHAR(45) NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`service_id`) REFERENCES `services`(`id`) ON DELETE SET NULL,
    INDEX `idx_enquiries_status` (`status`),
    INDEX `idx_enquiries_date` (`preferred_date`),
    INDEX `idx_enquiries_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------
-- 4. Gallery Items Table (Showcase and Before/After)
-- ----------------------------------------------------------
CREATE TABLE `gallery_items` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(150) NOT NULL,
    `category` VARCHAR(100) NOT NULL DEFAULT 'Ceramic Coating',
    `before_image` VARCHAR(255) NULL,
    `after_image` VARCHAR(255) NOT NULL,
    `description` VARCHAR(255) NULL,
    `vehicle_type` VARCHAR(100) NULL,
    `is_before_after` TINYINT(1) NOT NULL DEFAULT 0,
    `sort_order` INT NOT NULL DEFAULT 0,
    `is_published` TINYINT(1) NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_gallery_category` (`category`),
    INDEX `idx_gallery_published` (`is_published`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------
-- 5. FAQs Table
-- ----------------------------------------------------------
CREATE TABLE `faqs` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `question` VARCHAR(255) NOT NULL,
    `answer` TEXT NOT NULL,
    `category` VARCHAR(50) NOT NULL DEFAULT 'General',
    `sort_order` INT NOT NULL DEFAULT 0,
    `is_published` TINYINT(1) NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_faqs_category` (`category`),
    INDEX `idx_faqs_published` (`is_published`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------
-- 6. Site Settings Table (Editable via Admin)
-- ----------------------------------------------------------
CREATE TABLE `site_settings` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `setting_key` VARCHAR(100) NOT NULL UNIQUE,
    `setting_value` TEXT NULL,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_settings_key` (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------
-- 7. Admin Users Table
-- ----------------------------------------------------------
CREATE TABLE `admins` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(100) NOT NULL UNIQUE,
    `email` VARCHAR(150) NOT NULL UNIQUE,
    `password_hash` VARCHAR(255) NOT NULL,
    `last_login` TIMESTAMP NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

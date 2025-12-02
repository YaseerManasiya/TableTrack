-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: tabletrack
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `areas`
--

DROP TABLE IF EXISTS `areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `areas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned DEFAULT NULL,
  `area_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `areas_branch_id_foreign` (`branch_id`),
  CONSTRAINT `areas_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areas`
--

LOCK TABLES `areas` WRITE;
/*!40000 ALTER TABLE `areas` DISABLE KEYS */;
INSERT INTO `areas` VALUES (1,1,'Lounge',NULL,NULL),(2,1,'Roof Top',NULL,NULL),(3,1,'Garden',NULL,NULL),(7,3,'Lounge',NULL,NULL),(8,3,'Roof Top',NULL,NULL),(9,3,'Garden',NULL,NULL),(10,5,'Lounge',NULL,NULL),(11,5,'Roof Top',NULL,NULL),(12,5,'Garden',NULL,NULL),(13,7,'Lounge',NULL,NULL),(14,7,'Roof Top',NULL,NULL),(15,7,'Garden',NULL,NULL);
/*!40000 ALTER TABLE `areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch_delivery_settings`
--

DROP TABLE IF EXISTS `branch_delivery_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch_delivery_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned NOT NULL,
  `max_radius` decimal(8,2) NOT NULL DEFAULT '5.00',
  `unit` enum('km','miles') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'km',
  `fee_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fixed',
  `fixed_fee` decimal(8,2) DEFAULT NULL,
  `per_distance_rate` decimal(8,2) DEFAULT NULL,
  `free_delivery_over_amount` decimal(8,2) DEFAULT NULL,
  `free_delivery_within_radius` double DEFAULT NULL,
  `delivery_schedule_start` time DEFAULT NULL,
  `delivery_schedule_end` time DEFAULT NULL,
  `prep_time_minutes` int NOT NULL DEFAULT '20',
  `additional_eta_buffer_time` int DEFAULT NULL,
  `avg_delivery_speed_kmh` int NOT NULL DEFAULT '30',
  `is_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `branch_delivery_settings_branch_id_foreign` (`branch_id`),
  CONSTRAINT `branch_delivery_settings_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch_delivery_settings`
--

LOCK TABLES `branch_delivery_settings` WRITE;
/*!40000 ALTER TABLE `branch_delivery_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `branch_delivery_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branches` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `unique_hash` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cloned_branch_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cloned_branch_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_menu_clone` tinyint(1) NOT NULL DEFAULT '0',
  `is_item_categories_clone` tinyint(1) NOT NULL DEFAULT '0',
  `is_menu_items_clone` tinyint(1) NOT NULL DEFAULT '0',
  `is_item_modifiers_clone` tinyint(1) NOT NULL DEFAULT '0',
  `is_clone_reservation_settings` tinyint(1) NOT NULL DEFAULT '0',
  `is_clone_delivery_settings` tinyint(1) NOT NULL DEFAULT '0',
  `is_clone_kot_setting` tinyint(1) NOT NULL DEFAULT '0',
  `is_modifiers_groups_clone` tinyint(1) NOT NULL DEFAULT '0',
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `lat` decimal(10,7) DEFAULT NULL,
  `lng` decimal(10,7) DEFAULT NULL,
  `count_orders` int NOT NULL DEFAULT '0',
  `total_orders` int NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `branches_unique_hash_unique` (`unique_hash`),
  KEY `branches_restaurant_id_foreign` (`restaurant_id`),
  CONSTRAINT `branches_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES (1,'b31383c5fc4f23d176fd',1,'Daphneytown',NULL,NULL,0,0,0,0,0,0,0,0,'417 Fritsch Streets Suite 060\nLake Sashaside, DC 77492-6026','2025-11-30 02:57:23','2025-11-30 03:00:25',NULL,NULL,22,-1),(2,'0489e416c9d77ecf6398',1,'Port Reva',NULL,NULL,0,0,0,0,0,0,0,0,'51792 Pollich Squares\nLake Sigrid, MN 54391-9208','2025-11-30 02:57:23','2025-11-30 02:57:24',NULL,NULL,0,-1),(3,'3f92fa1de25978c0e165',2,'Rogahnton',NULL,NULL,0,0,0,0,0,0,0,0,'47421 Schowalter Cove\nLake Hertaville, NE 46269','2025-11-30 02:59:34','2025-11-30 03:00:29',NULL,NULL,11,-1),(4,'766e690d272af35023fc',2,'New Norbert',NULL,NULL,0,0,0,0,0,0,0,0,'623 Satterfield Wells Suite 493\nSouth Kitty, WV 59145-1824','2025-11-30 02:59:34','2025-11-30 02:59:34',NULL,NULL,0,-1),(5,'383e74d86caff6d6cc7d',3,'East Wadeside',NULL,NULL,0,0,0,0,0,0,0,0,'5268 Mann Mill\nGutkowskishire, UT 48055-9447','2025-11-30 02:59:54','2025-11-30 03:00:34',NULL,NULL,11,-1),(6,'b0f648fb4675594a7d56',3,'Mablebury',NULL,NULL,0,0,0,0,0,0,0,0,'407 Mavis Fields Apt. 447\nDarrinborough, NJ 82522-2681','2025-11-30 02:59:54','2025-11-30 02:59:55',NULL,NULL,0,-1),(7,'9f3f78e24007f6ffa773',4,'East Hannah',NULL,NULL,0,0,0,0,0,0,0,0,'7936 Bailey Station Suite 686\nNew Maybell, NM 76051','2025-11-30 03:00:19','2025-11-30 03:00:39',NULL,NULL,11,-1),(8,'e6cafa7748de062b2a1d',4,'Lake Jaunita',NULL,NULL,0,0,0,0,0,0,0,0,'7649 Doyle Hill\nHassiemouth, DE 22621','2025-11-30 03:00:19','2025-11-30 03:00:20',NULL,NULL,0,-1);
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_header_images`
--

DROP TABLE IF EXISTS `cart_header_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_header_images` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cart_header_setting_id` bigint unsigned NOT NULL,
  `image_path` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alt_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_header_images_cart_header_setting_id_foreign` (`cart_header_setting_id`),
  CONSTRAINT `cart_header_images_cart_header_setting_id_foreign` FOREIGN KEY (`cart_header_setting_id`) REFERENCES `cart_header_settings` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_header_images`
--

LOCK TABLES `cart_header_images` WRITE;
/*!40000 ALTER TABLE `cart_header_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_header_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_header_settings`
--

DROP TABLE IF EXISTS `cart_header_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_header_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned NOT NULL,
  `header_type` enum('text','image') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `header_text` text COLLATE utf8mb4_unicode_ci,
  `is_header_disabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_header_settings_restaurant_id_foreign` (`restaurant_id`),
  CONSTRAINT `cart_header_settings_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_header_settings`
--

LOCK TABLES `cart_header_settings` WRITE;
/*!40000 ALTER TABLE `cart_header_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_header_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_item_modifier_options`
--

DROP TABLE IF EXISTS `cart_item_modifier_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_item_modifier_options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cart_item_id` bigint unsigned DEFAULT NULL,
  `modifier_option_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_item_modifier_options_cart_item_id_foreign` (`cart_item_id`),
  KEY `cart_item_modifier_options_modifier_option_id_foreign` (`modifier_option_id`),
  CONSTRAINT `cart_item_modifier_options_cart_item_id_foreign` FOREIGN KEY (`cart_item_id`) REFERENCES `cart_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_item_modifier_options_modifier_option_id_foreign` FOREIGN KEY (`modifier_option_id`) REFERENCES `modifier_options` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_item_modifier_options`
--

LOCK TABLES `cart_item_modifier_options` WRITE;
/*!40000 ALTER TABLE `cart_item_modifier_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_item_modifier_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cart_session_id` bigint unsigned DEFAULT NULL,
  `branch_id` bigint unsigned DEFAULT NULL,
  `menu_item_id` bigint unsigned DEFAULT NULL,
  `menu_item_variation_id` bigint unsigned DEFAULT NULL,
  `quantity` int NOT NULL,
  `price` decimal(16,2) NOT NULL,
  `amount` decimal(16,2) NOT NULL,
  `tax_amount` decimal(16,2) DEFAULT NULL,
  `tax_percentage` decimal(8,4) DEFAULT NULL,
  `tax_breakup` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `kiosk_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_items_cart_session_id_foreign` (`cart_session_id`),
  KEY `cart_items_branch_id_foreign` (`branch_id`),
  KEY `cart_items_menu_item_id_foreign` (`menu_item_id`),
  KEY `cart_items_menu_item_variation_id_foreign` (`menu_item_variation_id`),
  KEY `cart_items_kiosk_id_foreign` (`kiosk_id`),
  CONSTRAINT `cart_items_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_cart_session_id_foreign` FOREIGN KEY (`cart_session_id`) REFERENCES `cart_sessions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_kiosk_id_foreign` FOREIGN KEY (`kiosk_id`) REFERENCES `kiosks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_menu_item_id_foreign` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_menu_item_variation_id_foreign` FOREIGN KEY (`menu_item_variation_id`) REFERENCES `menu_item_variations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_sessions`
--

DROP TABLE IF EXISTS `cart_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_sessions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint unsigned DEFAULT NULL,
  `order_id` bigint unsigned DEFAULT NULL,
  `order_type_id` bigint unsigned DEFAULT NULL,
  `placed_via` enum('pos','shop','kiosk') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_total` decimal(16,2) NOT NULL,
  `total` decimal(16,2) NOT NULL,
  `total_tax_amount` decimal(16,2) NOT NULL DEFAULT '0.00',
  `tax_mode` enum('order','item') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'order',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `kiosk_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_sessions_branch_id_foreign` (`branch_id`),
  KEY `cart_sessions_order_id_foreign` (`order_id`),
  KEY `cart_sessions_order_type_id_foreign` (`order_type_id`),
  KEY `cart_sessions_kiosk_id_foreign` (`kiosk_id`),
  CONSTRAINT `cart_sessions_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_sessions_kiosk_id_foreign` FOREIGN KEY (`kiosk_id`) REFERENCES `kiosks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_sessions_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_sessions_order_type_id_foreign` FOREIGN KEY (`order_type_id`) REFERENCES `order_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_sessions`
--

LOCK TABLES `cart_sessions` WRITE;
/*!40000 ALTER TABLE `cart_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_denominations`
--

DROP TABLE IF EXISTS `cash_denominations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cash_denominations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `branch_id` bigint unsigned DEFAULT NULL,
  `value` int NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_denominations`
--

LOCK TABLES `cash_denominations` WRITE;
/*!40000 ALTER TABLE `cash_denominations` DISABLE KEYS */;
/*!40000 ALTER TABLE `cash_denominations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_register_approvals`
--

DROP TABLE IF EXISTS `cash_register_approvals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cash_register_approvals` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cash_register_session_id` bigint unsigned NOT NULL,
  `approved_by` bigint unsigned NOT NULL,
  `approved_at` datetime NOT NULL,
  `manager_note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_register_approvals`
--

LOCK TABLES `cash_register_approvals` WRITE;
/*!40000 ALTER TABLE `cash_register_approvals` DISABLE KEYS */;
/*!40000 ALTER TABLE `cash_register_approvals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_register_counts`
--

DROP TABLE IF EXISTS `cash_register_counts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cash_register_counts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cash_register_session_id` bigint unsigned NOT NULL,
  `cash_denomination_id` bigint unsigned NOT NULL,
  `count` int NOT NULL DEFAULT '0',
  `subtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_register_counts`
--

LOCK TABLES `cash_register_counts` WRITE;
/*!40000 ALTER TABLE `cash_register_counts` DISABLE KEYS */;
/*!40000 ALTER TABLE `cash_register_counts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_register_global_settings`
--

DROP TABLE IF EXISTS `cash_register_global_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cash_register_global_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `purchase_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supported_until` timestamp NULL DEFAULT NULL,
  `purchased_on` timestamp NULL DEFAULT NULL,
  `license_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notify_update` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_register_global_settings`
--

LOCK TABLES `cash_register_global_settings` WRITE;
/*!40000 ALTER TABLE `cash_register_global_settings` DISABLE KEYS */;
INSERT INTO `cash_register_global_settings` VALUES (1,NULL,NULL,NULL,NULL,1,'2025-11-30 04:19:22','2025-11-30 04:19:22');
/*!40000 ALTER TABLE `cash_register_global_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_register_sessions`
--

DROP TABLE IF EXISTS `cash_register_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cash_register_sessions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cash_register_id` bigint unsigned NOT NULL,
  `restaurant_id` bigint unsigned NOT NULL,
  `branch_id` bigint unsigned NOT NULL,
  `opened_by` bigint unsigned NOT NULL,
  `opened_at` datetime NOT NULL,
  `opening_float` decimal(12,2) NOT NULL DEFAULT '0.00',
  `closed_by` bigint unsigned DEFAULT NULL,
  `approved_by` bigint unsigned DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `closed_at` datetime DEFAULT NULL,
  `expected_cash` decimal(12,2) NOT NULL DEFAULT '0.00',
  `counted_cash` decimal(12,2) NOT NULL DEFAULT '0.00',
  `discrepancy` decimal(12,2) NOT NULL DEFAULT '0.00',
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `closing_note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_register_sessions`
--

LOCK TABLES `cash_register_sessions` WRITE;
/*!40000 ALTER TABLE `cash_register_sessions` DISABLE KEYS */;
INSERT INTO `cash_register_sessions` VALUES (1,1,1,1,2,'2025-11-30 10:32:25',100.00,2,NULL,NULL,'2025-11-30 10:36:27',400.00,0.00,-400.00,'pending_approval','','2025-11-30 05:02:25','2025-11-30 05:06:27');
/*!40000 ALTER TABLE `cash_register_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_register_settings`
--

DROP TABLE IF EXISTS `cash_register_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cash_register_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned NOT NULL,
  `force_open_after_login` tinyint(1) NOT NULL DEFAULT '0',
  `force_open_roles` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cash_register_settings_restaurant_id_unique` (`restaurant_id`),
  CONSTRAINT `cash_register_settings_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_register_settings`
--

LOCK TABLES `cash_register_settings` WRITE;
/*!40000 ALTER TABLE `cash_register_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `cash_register_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_register_transactions`
--

DROP TABLE IF EXISTS `cash_register_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cash_register_transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cash_register_session_id` bigint unsigned NOT NULL,
  `restaurant_id` bigint unsigned NOT NULL,
  `branch_id` bigint unsigned NOT NULL,
  `order_id` bigint unsigned DEFAULT NULL,
  `happened_at` datetime NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reason` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `currency_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `running_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `created_by` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cash_register_transactions_order_id_index` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_register_transactions`
--

LOCK TABLES `cash_register_transactions` WRITE;
/*!40000 ALTER TABLE `cash_register_transactions` DISABLE KEYS */;
INSERT INTO `cash_register_transactions` VALUES (1,1,1,1,NULL,'2025-11-30 10:32:48','cash_in',NULL,'',300.00,NULL,0.00,2,'2025-11-30 05:02:48','2025-11-30 05:02:48');
/*!40000 ALTER TABLE `cash_register_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_registers`
--

DROP TABLE IF EXISTS `cash_registers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cash_registers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned NOT NULL,
  `branch_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_registers`
--

LOCK TABLES `cash_registers` WRITE;
/*!40000 ALTER TABLE `cash_registers` DISABLE KEYS */;
INSERT INTO `cash_registers` VALUES (1,1,1,'Default Register',1,'2025-11-30 05:02:13','2025-11-30 05:02:13');
/*!40000 ALTER TABLE `cash_registers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `language_setting_id` bigint unsigned DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_company` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contacts_language_setting_id_foreign` (`language_setting_id`),
  CONSTRAINT `contacts_language_setting_id_foreign` FOREIGN KEY (`language_setting_id`) REFERENCES `language_settings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES (1,1,'support@example.com','Bond Hobbs Inc',NULL,'957 Jamie Station, Lamontborough, SD 27319-9459','2025-11-30 02:57:24','2025-11-30 02:57:24');
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `countries_code` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `countries_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phonecode` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `countries_countries_code_index` (`countries_code`)
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'AF','Afghanistan','93'),(2,'AX','Åland Islands','358'),(3,'AL','Albania','355'),(4,'DZ','Algeria','213'),(5,'AS','American Samoa','1684'),(6,'AD','Andorra','376'),(7,'AO','Angola','244'),(8,'AI','Anguilla','1264'),(9,'AQ','Antarctica','0'),(10,'AG','Antigua and Barbuda','1268'),(11,'AR','Argentina','54'),(12,'AM','Armenia','374'),(13,'AW','Aruba','297'),(14,'AU','Australia','61'),(15,'AT','Austria','43'),(16,'AZ','Azerbaijan','994'),(17,'BS','Bahamas','1242'),(18,'BH','Bahrain','973'),(19,'BD','Bangladesh','880'),(20,'BB','Barbados','1246'),(21,'BY','Belarus','375'),(22,'BE','Belgium','32'),(23,'BZ','Belize','501'),(24,'BJ','Benin','229'),(25,'BM','Bermuda','1441'),(26,'BT','Bhutan','975'),(27,'BO','Bolivia, Plurinational State of','591'),(28,'BQ','Bonaire, Sint Eustatius and Saba','599'),(29,'BA','Bosnia and Herzegovina','387'),(30,'BW','Botswana','267'),(31,'BV','Bouvet Island','0'),(32,'BR','Brazil','55'),(33,'IO','British Indian Ocean Territory','246'),(34,'BN','Brunei Darussalam','673'),(35,'BG','Bulgaria','359'),(36,'BF','Burkina Faso','226'),(37,'BI','Burundi','257'),(38,'KH','Cambodia','855'),(39,'CM','Cameroon','237'),(40,'CA','Canada','1'),(41,'CV','Cape Verde','238'),(42,'KY','Cayman Islands','1345'),(43,'CF','Central African Republic','236'),(44,'TD','Chad','235'),(45,'CL','Chile','56'),(46,'CN','China','86'),(47,'CX','Christmas Island','61'),(48,'CC','Cocos (Keeling) Islands','672'),(49,'CO','Colombia','57'),(50,'KM','Comoros','269'),(51,'CG','Congo','242'),(52,'CD','Congo, the Democratic Republic of the','242'),(53,'CK','Cook Islands','682'),(54,'CR','Costa Rica','506'),(55,'CI','Côte d\'Ivoire','225'),(56,'HR','Croatia','385'),(57,'CU','Cuba','53'),(58,'CW','Curaçao','599'),(59,'CY','Cyprus','357'),(60,'CZ','Czech Republic','420'),(61,'DK','Denmark','45'),(62,'DJ','Djibouti','253'),(63,'DM','Dominica','1767'),(64,'DO','Dominican Republic','1809'),(65,'EC','Ecuador','593'),(66,'EG','Egypt','20'),(67,'SV','El Salvador','503'),(68,'GQ','Equatorial Guinea','240'),(69,'ER','Eritrea','291'),(70,'EE','Estonia','372'),(71,'ET','Ethiopia','251'),(72,'FK','Falkland Islands (Malvinas)','500'),(73,'FO','Faroe Islands','298'),(74,'FJ','Fiji','679'),(75,'FI','Finland','358'),(76,'FR','France','33'),(77,'GF','French Guiana','594'),(78,'PF','French Polynesia','689'),(79,'TF','French Southern Territories','0'),(80,'GA','Gabon','241'),(81,'GM','Gambia','220'),(82,'GE','Georgia','995'),(83,'DE','Germany','49'),(84,'GH','Ghana','233'),(85,'GI','Gibraltar','350'),(86,'GR','Greece','30'),(87,'GL','Greenland','299'),(88,'GD','Grenada','1473'),(89,'GP','Guadeloupe','590'),(90,'GU','Guam','1671'),(91,'GT','Guatemala','502'),(92,'GG','Guernsey','44'),(93,'GN','Guinea','224'),(94,'GW','Guinea-Bissau','245'),(95,'GY','Guyana','592'),(96,'HT','Haiti','509'),(97,'HM','Heard Island and McDonald Islands','0'),(98,'VA','Holy See (Vatican City State)','39'),(99,'HN','Honduras','504'),(100,'HK','Hong Kong','852'),(101,'HU','Hungary','36'),(102,'IS','Iceland','354'),(103,'IN','India','91'),(104,'ID','Indonesia','62'),(105,'IR','Iran, Islamic Republic of','98'),(106,'IQ','Iraq','964'),(107,'IE','Ireland','353'),(108,'IM','Isle of Man','44'),(109,'IL','Israel','972'),(110,'IT','Italy','39'),(111,'JM','Jamaica','1876'),(112,'JP','Japan','81'),(113,'JE','Jersey','44'),(114,'JO','Jordan','962'),(115,'KZ','Kazakhstan','7'),(116,'KE','Kenya','254'),(117,'KI','Kiribati','686'),(118,'KP','Korea, Democratic People\'s Republic of','850'),(119,'KR','Korea, Republic of','82'),(120,'KW','Kuwait','965'),(121,'KG','Kyrgyzstan','996'),(122,'LA','Lao People\'s Democratic Republic','856'),(123,'LV','Latvia','371'),(124,'LB','Lebanon','961'),(125,'LS','Lesotho','266'),(126,'LR','Liberia','231'),(127,'LY','Libya','218'),(128,'LI','Liechtenstein','423'),(129,'LT','Lithuania','370'),(130,'LU','Luxembourg','352'),(131,'MO','Macao','853'),(132,'MK','Macedonia, the Former Yugoslav Republic of','389'),(133,'MG','Madagascar','261'),(134,'MW','Malawi','265'),(135,'MY','Malaysia','60'),(136,'MV','Maldives','960'),(137,'ML','Mali','223'),(138,'MT','Malta','356'),(139,'MH','Marshall Islands','692'),(140,'MQ','Martinique','596'),(141,'MR','Mauritania','222'),(142,'MU','Mauritius','230'),(143,'YT','Mayotte','269'),(144,'MX','Mexico','52'),(145,'FM','Micronesia, Federated States of','691'),(146,'MD','Moldova, Republic of','373'),(147,'MC','Monaco','377'),(148,'MN','Mongolia','976'),(149,'ME','Montenegro','382'),(150,'MS','Montserrat','1664'),(151,'MA','Morocco','212'),(152,'MZ','Mozambique','258'),(153,'MM','Myanmar','95'),(154,'NA','Namibia','264'),(155,'NR','Nauru','674'),(156,'NP','Nepal','977'),(157,'NL','Netherlands','31'),(158,'NC','New Caledonia','687'),(159,'NZ','New Zealand','64'),(160,'NI','Nicaragua','505'),(161,'NE','Niger','227'),(162,'NG','Nigeria','234'),(163,'NU','Niue','683'),(164,'NF','Norfolk Island','672'),(165,'MP','Northern Mariana Islands','1670'),(166,'NO','Norway','47'),(167,'OM','Oman','968'),(168,'PK','Pakistan','92'),(169,'PW','Palau','680'),(170,'PS','Palestine, State of','970'),(171,'PA','Panama','507'),(172,'PG','Papua New Guinea','675'),(173,'PY','Paraguay','595'),(174,'PE','Peru','51'),(175,'PH','Philippines','63'),(176,'PN','Pitcairn','0'),(177,'PL','Poland','48'),(178,'PT','Portugal','351'),(179,'PR','Puerto Rico','1787'),(180,'QA','Qatar','974'),(181,'RE','Réunion','262'),(182,'RO','Romania','40'),(183,'RU','Russian Federation','7'),(184,'RW','Rwanda','250'),(185,'BL','Saint Barthélemy','590'),(186,'SH','Saint Helena, Ascension and Tristan da Cunha','290'),(187,'KN','Saint Kitts and Nevis','1869'),(188,'LC','Saint Lucia','1758'),(189,'MF','Saint Martin (French part)','590'),(190,'PM','Saint Pierre and Miquelon','508'),(191,'VC','Saint Vincent and the Grenadines','1784'),(192,'WS','Samoa','684'),(193,'SM','San Marino','378'),(194,'ST','Sao Tome and Principe','239'),(195,'SA','Saudi Arabia','966'),(196,'SN','Senegal','221'),(197,'RS','Serbia','381'),(198,'SC','Seychelles','248'),(199,'SL','Sierra Leone','232'),(200,'SG','Singapore','65'),(201,'SX','Sint Maarten (Dutch part)','1'),(202,'SK','Slovakia','421'),(203,'SI','Slovenia','386'),(204,'SB','Solomon Islands','677'),(205,'SO','Somalia','252'),(206,'ZA','South Africa','27'),(207,'GS','South Georgia and the South Sandwich Islands','0'),(208,'SS','South Sudan','211'),(209,'ES','Spain','34'),(210,'LK','Sri Lanka','94'),(211,'SD','Sudan','249'),(212,'SR','Suriname','597'),(213,'SJ','Svalbard and Jan Mayen','47'),(214,'SZ','Swaziland','268'),(215,'SE','Sweden','46'),(216,'CH','Switzerland','41'),(217,'SY','Syrian Arab Republic','963'),(218,'TW','Taiwan, Province of China','886'),(219,'TJ','Tajikistan','992'),(220,'TZ','Tanzania, United Republic of','255'),(221,'TH','Thailand','66'),(222,'TL','Timor-Leste','670'),(223,'TG','Togo','228'),(224,'TK','Tokelau','690'),(225,'TO','Tonga','676'),(226,'TT','Trinidad and Tobago','1868'),(227,'TN','Tunisia','216'),(228,'TR','Turkey','90'),(229,'TM','Turkmenistan','7370'),(230,'TC','Turks and Caicos Islands','1649'),(231,'TV','Tuvalu','688'),(232,'UG','Uganda','256'),(233,'UA','Ukraine','380'),(234,'AE','United Arab Emirates','971'),(235,'GB','United Kingdom','44'),(236,'US','United States','1'),(237,'UM','United States Minor Outlying Islands','1'),(238,'UY','Uruguay','598'),(239,'UZ','Uzbekistan','998'),(240,'VU','Vanuatu','678'),(241,'VE','Venezuela, Bolivarian Republic of','58'),(242,'VN','Viet Nam','84'),(243,'VG','Virgin Islands, British','1284'),(244,'VI','Virgin Islands, U.S.','1340'),(245,'WF','Wallis and Futuna','681'),(246,'EH','Western Sahara','212'),(247,'YE','Yemen','967'),(248,'ZM','Zambia','260'),(249,'ZW','Zimbabwe','263');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currencies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `currency_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_symbol` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_position` enum('left','right','left_with_space','right_with_space') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'left',
  `no_of_decimal` int unsigned NOT NULL DEFAULT '2',
  `thousand_separator` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT ',',
  `decimal_separator` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '.',
  `exchange_rate` decimal(16,2) DEFAULT NULL,
  `usd_price` decimal(16,2) DEFAULT NULL,
  `is_cryptocurrency` enum('yes','no') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'no',
  PRIMARY KEY (`id`),
  KEY `currencies_restaurant_id_foreign` (`restaurant_id`),
  CONSTRAINT `currencies_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` VALUES (1,1,'Dollars','USD','$','left',2,',','.',NULL,NULL,'no'),(2,1,'Rupee','INR','₹','left',2,',','.',NULL,NULL,'no'),(3,1,'Pounds','GBP','£','left',2,',','.',NULL,NULL,'no'),(4,1,'Euros','EUR','€','left',2,',','.',NULL,NULL,'no'),(5,2,'Dollars','USD','$','left',2,',','.',NULL,NULL,'no'),(6,2,'Rupee','INR','₹','left',2,',','.',NULL,NULL,'no'),(7,2,'Pounds','GBP','£','left',2,',','.',NULL,NULL,'no'),(8,2,'Euros','EUR','€','left',2,',','.',NULL,NULL,'no'),(9,3,'Dollars','USD','$','left',2,',','.',NULL,NULL,'no'),(10,3,'Rupee','INR','₹','left',2,',','.',NULL,NULL,'no'),(11,3,'Pounds','GBP','£','left',2,',','.',NULL,NULL,'no'),(12,3,'Euros','EUR','€','left',2,',','.',NULL,NULL,'no'),(13,4,'Dollars','USD','$','left',2,',','.',NULL,NULL,'no'),(14,4,'Rupee','INR','₹','left',2,',','.',NULL,NULL,'no'),(15,4,'Pounds','GBP','£','left',2,',','.',NULL,NULL,'no'),(16,4,'Euros','EUR','€','left',2,',','.',NULL,NULL,'no');
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_menus`
--

DROP TABLE IF EXISTS `custom_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_menus` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_content` longtext COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `position` enum('header','footer') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'header',
  `sort_order` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `custom_menus_menu_slug_unique` (`menu_slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_menus`
--

LOCK TABLES `custom_menus` WRITE;
/*!40000 ALTER TABLE `custom_menus` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_addresses`
--

DROP TABLE IF EXISTS `customer_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_addresses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned DEFAULT NULL,
  `label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `lat` decimal(10,7) DEFAULT NULL,
  `lng` decimal(10,7) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_addresses_customer_id_foreign` (`customer_id`),
  CONSTRAINT `customer_addresses_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_addresses`
--

LOCK TABLES `customer_addresses` WRITE;
/*!40000 ALTER TABLE `customer_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_otp` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `delivery_address` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customers_email_unique` (`email`),
  KEY `customers_restaurant_id_foreign` (`restaurant_id`),
  CONSTRAINT `customers_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,1,'Dr. Rose Green DVM',NULL,NULL,'pconsidine@example.org',NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27','2362 Emmerich Burgs Apt. 555\nSouth Audreyburgh, MT 64167-3150'),(2,1,'Lucie Johnson',NULL,NULL,'kjaskolski@example.com',NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27','434 Chadrick Islands Suite 318\nWest Kole, NJ 25741-1883'),(3,1,'Mr. Dee Sporer',NULL,NULL,'ritchie.nasir@example.com',NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27','428 Bailey Mall Apt. 472\nWest Oswald, ND 12888-8563'),(4,1,'Sammy Cormier',NULL,NULL,'schuppe.jacey@example.net',NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27','5588 Arturo Streets\nHollisshire, CO 75466-8245'),(5,1,'Roselyn Steuber DDS',NULL,NULL,'kraig.haley@example.com',NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27','762 Kuhn Points\nNew Nataliamouth, NH 70060'),(6,1,'Kristopher Hauck DVM',NULL,NULL,'urolfson@example.net',NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27','923 Herzog Gardens\nChaunceyburgh, TX 07795-6168'),(7,1,'Mr. Horace Bechtelar MD',NULL,NULL,'psporer@example.org',NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27','50366 Sipes Haven Apt. 620\nBreitenbergville, DE 09788-5241'),(8,1,'Rex Bergstrom',NULL,NULL,'fay.rogers@example.net',NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28','145 Virgil Camp\nWest Queen, MN 92367-1802'),(9,1,'Willow Feest',NULL,NULL,'gmosciski@example.org',NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28','26365 Janae Trafficway\nFisherchester, IN 22182'),(10,1,'Chadd Kreiger',NULL,NULL,'fprohaska@example.net',NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28','8326 Eunice Drive\nArdenbury, AZ 09166'),(11,1,'Micheal Johns',NULL,NULL,'daphney97@example.com',NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28','44434 Eldridge Key\nSouth Stellaport, ID 99987'),(12,1,'Johnson Ward',NULL,NULL,'maxie.jacobs@example.net',NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23','766 Leannon Ville\nPattieberg, PA 73581-1606'),(13,1,'Jody Rippin',NULL,NULL,'leatha.fritsch@example.net',NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23','9082 Kassandra Haven\nPricefort, KS 17167'),(14,1,'Zaria Roberts PhD',NULL,NULL,'murray.alvena@example.org',NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23','478 Darion Shoals Suite 195\nLake Marjory, CA 17362'),(15,1,'Andre Lueilwitz',NULL,NULL,'joelle.little@example.com',NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23','7663 Murphy Mission Suite 926\nJuniortown, KY 44800'),(16,1,'Reta Baumbach',NULL,NULL,'brannon.gislason@example.org',NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24','528 Hill Ports Apt. 637\nWest Shirley, NY 32338'),(17,1,'Florine Rolfson',NULL,NULL,'jarred23@example.org',NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24','46378 Effertz Wells\nSouth Hazleton, RI 54701'),(18,1,'Ryleigh Schmitt',NULL,NULL,'gbruen@example.org',NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24','7453 Halie Forks\nNapoleonshire, WI 43371-6327'),(19,1,'Tamia Mraz',NULL,NULL,'keon92@example.org',NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24','3426 Ward Radial\nCruickshankchester, IL 18955'),(20,1,'Hester Jacobson',NULL,NULL,'padberg.patricia@example.org',NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24','23523 Alexa Curve Apt. 771\nWest Leslystad, RI 04283'),(21,1,'Emmy Bashirian',NULL,NULL,'mrunte@example.org',NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24','55111 Becker Lakes\nMohamedberg, IL 21020-5240'),(22,1,'Prof. Isai Donnelly MD',NULL,NULL,'rodrick78@example.org',NULL,'2025-11-30 03:00:25','2025-11-30 03:00:25','809 Opal Pike\nGrimesport, OK 72270-5439'),(23,2,'Rosamond Prohaska IV',NULL,NULL,'marlen.boehm@example.net',NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28','83495 Weber Lane\nHammesmouth, WA 49234'),(24,2,'Casey Koepp',NULL,NULL,'tsanford@example.org',NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28','8493 Daren Oval\nElzashire, VT 70795'),(25,2,'Mollie Hammes',NULL,NULL,'unique.haag@example.org',NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28','43112 Boyd Avenue\nAureliaport, CA 26952'),(26,2,'Niko Conn',NULL,NULL,'hermina.kirlin@example.com',NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28','968 Karen Garden Apt. 282\nJohnsonburgh, VA 56300'),(27,2,'Noemi Ratke',NULL,NULL,'lempi.zboncak@example.net',NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28','829 Stamm Shoals\nEast Madieton, DE 03936'),(28,2,'Noelia O\'Hara',NULL,NULL,'ksatterfield@example.com',NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29','6403 Austen Freeway Suite 604\nBlockborough, NV 97267-0833'),(29,2,'Dangelo Bins',NULL,NULL,'gerhold.zoey@example.net',NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29','6403 Thompson Cove Suite 167\nSouth Dalton, ME 95803-2082'),(30,2,'Christophe Champlin',NULL,NULL,'cathryn86@example.net',NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29','9843 O\'Connell Junctions Apt. 378\nNorth Carmella, FL 56301-3627'),(31,2,'Jakayla Christiansen',NULL,NULL,'roselyn20@example.net',NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29','785 Cordie Ranch\nEast Aurore, TN 25005-8060'),(32,2,'Prof. Jacinto Cummings PhD',NULL,NULL,'berge.lavonne@example.org',NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29','94094 Urban Turnpike\nJenkinsfurt, DE 21389'),(33,2,'Cale Boehm',NULL,NULL,'huel.neva@example.org',NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29','44761 Harvey Summit\nNicholeland, ID 30605-9842'),(34,3,'Marge Gibson',NULL,NULL,'kayley.fay@example.com',NULL,'2025-11-30 03:00:32','2025-11-30 03:00:32','7808 Alejandrin Pines Suite 246\nEast Santosborough, OR 94210'),(35,3,'Adele McLaughlin IV',NULL,NULL,'streich.simone@example.com',NULL,'2025-11-30 03:00:32','2025-11-30 03:00:32','50647 Leopoldo Burgs Apt. 881\nRogahnhaven, IA 11968'),(36,3,'Prof. Geo Bergstrom',NULL,NULL,'cristina29@example.net',NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33','17546 Ruthe Lake Suite 962\nShannystad, NY 13247-3412'),(37,3,'Mr. Marco Leffler',NULL,NULL,'ttowne@example.com',NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33','327 Doris Ridges Suite 994\nEstefaniafurt, WA 61220-4782'),(38,3,'Dulce Monahan',NULL,NULL,'ldenesik@example.org',NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33','7199 Lilliana Coves Apt. 081\nDanielleborough, ME 70989-1466'),(39,3,'Jessika Erdman',NULL,NULL,'harvey26@example.com',NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33','13215 Marisol Island Apt. 617\nPort Noahport, NJ 89507-0815'),(40,3,'Barton Nicolas',NULL,NULL,'nhoppe@example.com',NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33','5982 Funk Harbors\nNorth Darrenstad, WI 82878-2522'),(41,3,'Maverick Zemlak',NULL,NULL,'senger.nella@example.net',NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33','2298 Wintheiser Greens\nPort Kobeberg, DE 88028-8492'),(42,3,'Federico Cartwright I',NULL,NULL,'qbosco@example.net',NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34','83571 Citlalli Rue\nLake Davionbury, TX 93811-3063'),(43,3,'Miss Willa Legros Sr.',NULL,NULL,'lang.corbin@example.org',NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34','9530 Leif Villages Apt. 636\nGraceport, DE 84156'),(44,3,'Prof. April Swaniawski MD',NULL,NULL,'fmitchell@example.com',NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34','13756 Cristobal Fork Apt. 901\nVeronicashire, NV 62494-7321'),(45,4,'Noemy Hyatt',NULL,NULL,'kelvin.haley@example.net',NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37','985 Myriam Flat Apt. 069\nSouth Matildafort, LA 56906-1500'),(46,4,'Ms. Jaquelin Spinka PhD',NULL,NULL,'schiller.harvey@example.net',NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37','77347 Walter Club Apt. 907\nNew Karleytown, ID 66275'),(47,4,'Prof. Moriah Trantow IV',NULL,NULL,'neha93@example.org',NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37','65715 Labadie Courts Apt. 089\nSanfordfurt, NV 16726'),(48,4,'Ms. Lottie Wunsch V',NULL,NULL,'udietrich@example.net',NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37','8819 Keagan Light Apt. 771\nHegmannstad, ME 04435'),(49,4,'Tina Streich',NULL,NULL,'graciela.bartell@example.com',NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38','45765 Monroe Valleys Suite 919\nLoyceview, NC 81139-2814'),(50,4,'Mrs. Lori McCullough IV',NULL,NULL,'rafael.cole@example.net',NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38','53682 Kali Fort Apt. 655\nSherwoodland, UT 50691-6267'),(51,4,'Kaela Walter IV',NULL,NULL,'dannie17@example.com',NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38','81379 Ollie Mall Suite 936\nRippinport, AR 83220'),(52,4,'Rafaela O\'Conner',NULL,NULL,'mia.zemlak@example.net',NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38','8579 Miles Burgs Suite 036\nHassanport, AZ 72201'),(53,4,'Katheryn Bednar',NULL,NULL,'clinton06@example.com',NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38','51117 Auer Walks\nPort Enola, LA 69694'),(54,4,'Vanessa Collins',NULL,NULL,'cmiller@example.org',NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38','543 Kessler Estates\nLisandroview, AR 69124-5758'),(55,4,'Khalil Fritsch',NULL,NULL,'mcdermott.tracey@example.org',NULL,'2025-11-30 03:00:39','2025-11-30 03:00:39','4552 Donnie Avenue\nGabrielborough, OH 44238-5869');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `database_backup_settings`
--

DROP TABLE IF EXISTS `database_backup_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `database_backup_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `license_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchased_on` timestamp NULL DEFAULT NULL,
  `supported_until` timestamp NULL DEFAULT NULL,
  `notify_update` tinyint(1) NOT NULL DEFAULT '1',
  `is_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `frequency` enum('daily','weekly','monthly') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'daily',
  `backup_time` time NOT NULL DEFAULT '02:00:00',
  `retention_days` int NOT NULL DEFAULT '30',
  `max_backups` int NOT NULL DEFAULT '10',
  `include_files` tinyint(1) NOT NULL DEFAULT '0',
  `include_modules` tinyint(1) NOT NULL DEFAULT '0',
  `storage_location` enum('local','storage_setting') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'local',
  `storage_config` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_backup_settings`
--

LOCK TABLES `database_backup_settings` WRITE;
/*!40000 ALTER TABLE `database_backup_settings` DISABLE KEYS */;
INSERT INTO `database_backup_settings` VALUES (1,NULL,NULL,NULL,NULL,1,0,'daily','02:00:00',30,10,0,0,'local',NULL,'2025-11-30 04:19:20','2025-11-30 04:19:20');
/*!40000 ALTER TABLE `database_backup_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `database_backups`
--

DROP TABLE IF EXISTS `database_backups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `database_backups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_size` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('completed','failed','in_progress') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'in_progress',
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `backup_type` enum('manual','scheduled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'manual',
  `version` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stored_on` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'local',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_backups`
--

LOCK TABLES `database_backups` WRITE;
/*!40000 ALTER TABLE `database_backups` DISABLE KEYS */;
/*!40000 ALTER TABLE `database_backups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_executives`
--

DROP TABLE IF EXISTS `delivery_executives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_executives` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('available','on_delivery','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'available',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `delivery_executives_branch_id_foreign` (`branch_id`),
  CONSTRAINT `delivery_executives_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_executives`
--

LOCK TABLES `delivery_executives` WRITE;
/*!40000 ALTER TABLE `delivery_executives` DISABLE KEYS */;
INSERT INTO `delivery_executives` VALUES (1,1,'Jerad White','925-805-2943',NULL,'available','2025-11-30 02:57:26','2025-11-30 02:57:26'),(2,1,'Cristopher Fahey','1-828-804-1264',NULL,'available','2025-11-30 02:57:26','2025-11-30 02:57:26'),(3,1,'Sam Lesch','(903) 448-3750',NULL,'available','2025-11-30 02:57:26','2025-11-30 02:57:26'),(4,1,'Imelda Moore DVM','+1-959-356-9942',NULL,'available','2025-11-30 02:57:26','2025-11-30 02:57:26'),(5,1,'Elvie Heaney','(575) 900-3001',NULL,'available','2025-11-30 02:57:26','2025-11-30 02:57:26'),(6,1,'Murray Moore','1-315-673-8377',NULL,'available','2025-11-30 02:57:26','2025-11-30 02:57:26'),(7,1,'Mr. Mohammad Nader','+1.930.983.4369',NULL,'available','2025-11-30 02:57:26','2025-11-30 02:57:26'),(8,1,'Dr. Hazel Walsh DVM','+1-813-922-8637',NULL,'available','2025-11-30 02:57:26','2025-11-30 02:57:26'),(9,1,'Erling Senger','470.674.3002',NULL,'available','2025-11-30 02:57:26','2025-11-30 02:57:26'),(10,1,'Dr. Andrew Halvorson','1-830-915-8306',NULL,'available','2025-11-30 02:57:26','2025-11-30 02:57:26'),(11,1,'Prof. Brenda Kiehn','678-617-0604',NULL,'available','2025-11-30 02:57:26','2025-11-30 02:57:26'),(12,1,'Dr. Howard Schiller','1-667-461-8520',NULL,'available','2025-11-30 03:00:23','2025-11-30 03:00:23'),(13,1,'Wilbert Bergnaum','+1-678-519-0792',NULL,'available','2025-11-30 03:00:23','2025-11-30 03:00:23'),(14,1,'Alysha King','+1.351.536.3724',NULL,'available','2025-11-30 03:00:23','2025-11-30 03:00:23'),(15,1,'Efrain Frami','551-207-9147',NULL,'available','2025-11-30 03:00:23','2025-11-30 03:00:23'),(16,1,'Prof. Laurianne Prohaska V','(347) 298-7967',NULL,'available','2025-11-30 03:00:23','2025-11-30 03:00:23'),(17,1,'Boris Bruen','(540) 353-0701',NULL,'available','2025-11-30 03:00:23','2025-11-30 03:00:23'),(18,1,'Betsy Senger','316-804-9467',NULL,'available','2025-11-30 03:00:23','2025-11-30 03:00:23'),(19,1,'Monique Shanahan MD','+1-269-338-1588',NULL,'available','2025-11-30 03:00:23','2025-11-30 03:00:23'),(20,1,'Prof. Frederic Kris','1-629-917-8759',NULL,'available','2025-11-30 03:00:23','2025-11-30 03:00:23'),(21,1,'Miss Rebeca Casper DDS','+16502078629',NULL,'available','2025-11-30 03:00:23','2025-11-30 03:00:23'),(22,1,'Heidi Weber V','541.337.9789',NULL,'available','2025-11-30 03:00:23','2025-11-30 03:00:23'),(23,3,'Marie Ruecker','+1 (480) 953-2509',NULL,'available','2025-11-30 03:00:27','2025-11-30 03:00:27'),(24,3,'Miss Mia Larkin','1-704-629-5729',NULL,'available','2025-11-30 03:00:27','2025-11-30 03:00:27'),(25,3,'Jules Wilkinson Sr.','+1.828.213.6866',NULL,'available','2025-11-30 03:00:27','2025-11-30 03:00:27'),(26,3,'Estevan Hackett III','+1-820-649-7056',NULL,'available','2025-11-30 03:00:27','2025-11-30 03:00:27'),(27,3,'Marisa Osinski II','820-844-3575',NULL,'available','2025-11-30 03:00:27','2025-11-30 03:00:27'),(28,3,'Emilio Heaney II','360.385.7658',NULL,'available','2025-11-30 03:00:27','2025-11-30 03:00:27'),(29,3,'Dr. Jaclyn Larkin','864-534-4036',NULL,'available','2025-11-30 03:00:27','2025-11-30 03:00:27'),(30,3,'Emil Mosciski','(908) 434-1323',NULL,'available','2025-11-30 03:00:27','2025-11-30 03:00:27'),(31,3,'Dr. Bianka Borer','+1-860-482-2805',NULL,'available','2025-11-30 03:00:27','2025-11-30 03:00:27'),(32,3,'Lora Dooley DDS','212-746-6885',NULL,'available','2025-11-30 03:00:28','2025-11-30 03:00:28'),(33,3,'Adaline Kuhlman','941.780.2787',NULL,'available','2025-11-30 03:00:28','2025-11-30 03:00:28'),(34,5,'Howard Koss','+1-747-590-0260',NULL,'available','2025-11-30 03:00:32','2025-11-30 03:00:32'),(35,5,'Grace Lesch','626-977-6761',NULL,'available','2025-11-30 03:00:32','2025-11-30 03:00:32'),(36,5,'Grace Howell','616.290.6788',NULL,'available','2025-11-30 03:00:32','2025-11-30 03:00:32'),(37,5,'Donavon Collins','+1-601-278-5826',NULL,'available','2025-11-30 03:00:32','2025-11-30 03:00:32'),(38,5,'Miss Mireille Fadel I','+19346069657',NULL,'available','2025-11-30 03:00:32','2025-11-30 03:00:32'),(39,5,'Evalyn Jast','+15303026089',NULL,'available','2025-11-30 03:00:32','2025-11-30 03:00:32'),(40,5,'Henri Wiza','+12602283919',NULL,'available','2025-11-30 03:00:32','2025-11-30 03:00:32'),(41,5,'Timmothy Sanford','+1-386-432-4975',NULL,'available','2025-11-30 03:00:32','2025-11-30 03:00:32'),(42,5,'Okey Lowe Jr.','(210) 629-6739',NULL,'available','2025-11-30 03:00:32','2025-11-30 03:00:32'),(43,5,'Shannon Hickle','+1.820.868.3854',NULL,'available','2025-11-30 03:00:32','2025-11-30 03:00:32'),(44,5,'Sabina Schulist','+1 (505) 809-1624',NULL,'available','2025-11-30 03:00:32','2025-11-30 03:00:32'),(45,7,'Dayton Stokes','+1-949-276-4698',NULL,'available','2025-11-30 03:00:37','2025-11-30 03:00:37'),(46,7,'Fern Walter DDS','+1-317-630-6870',NULL,'available','2025-11-30 03:00:37','2025-11-30 03:00:37'),(47,7,'Prof. Weldon Considine','(757) 868-7116',NULL,'available','2025-11-30 03:00:37','2025-11-30 03:00:37'),(48,7,'Maryam Wisoky','+18168013614',NULL,'available','2025-11-30 03:00:37','2025-11-30 03:00:37'),(49,7,'Valentina Streich PhD','1-480-473-5005',NULL,'available','2025-11-30 03:00:37','2025-11-30 03:00:37'),(50,7,'Loy Brakus','786-803-4222',NULL,'available','2025-11-30 03:00:37','2025-11-30 03:00:37'),(51,7,'Freddy Erdman','364.897.8971',NULL,'available','2025-11-30 03:00:37','2025-11-30 03:00:37'),(52,7,'Dr. Karianne Leuschke','651-798-4814',NULL,'available','2025-11-30 03:00:37','2025-11-30 03:00:37'),(53,7,'Hans Jakubowski','971.692.7206',NULL,'available','2025-11-30 03:00:37','2025-11-30 03:00:37'),(54,7,'Prof. Carolyne Satterfield','+1.559.321.1620',NULL,'available','2025-11-30 03:00:37','2025-11-30 03:00:37'),(55,7,'April Harber','650-354-5140',NULL,'available','2025-11-30 03:00:37','2025-11-30 03:00:37');
/*!40000 ALTER TABLE `delivery_executives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_fee_tiers`
--

DROP TABLE IF EXISTS `delivery_fee_tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_fee_tiers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned NOT NULL,
  `min_distance` double DEFAULT NULL,
  `max_distance` double DEFAULT NULL,
  `fee` decimal(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `delivery_fee_tiers_branch_id_foreign` (`branch_id`),
  CONSTRAINT `delivery_fee_tiers_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_fee_tiers`
--

LOCK TABLES `delivery_fee_tiers` WRITE;
/*!40000 ALTER TABLE `delivery_fee_tiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_fee_tiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_platforms`
--

DROP TABLE IF EXISTS `delivery_platforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_platforms` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `commission_type` enum('percent','fixed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'percent',
  `commission_value` decimal(16,2) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `delivery_platforms_branch_id_foreign` (`branch_id`),
  CONSTRAINT `delivery_platforms_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_platforms`
--

LOCK TABLES `delivery_platforms` WRITE;
/*!40000 ALTER TABLE `delivery_platforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_platforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `denominations`
--

DROP TABLE IF EXISTS `denominations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `denominations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` decimal(10,2) NOT NULL,
  `type` enum('coin','note','bill') COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `branch_id` bigint unsigned DEFAULT NULL,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `denominations_uuid_unique` (`uuid`),
  UNIQUE KEY `unique_denomination_per_branch` (`value`,`type`,`branch_id`,`restaurant_id`),
  KEY `denominations_branch_id_restaurant_id_index` (`branch_id`,`restaurant_id`),
  KEY `denominations_type_is_active_index` (`type`,`is_active`),
  KEY `denominations_value_type_index` (`value`,`type`),
  KEY `denominations_restaurant_id_foreign` (`restaurant_id`),
  CONSTRAINT `denominations_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `denominations_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `denominations`
--

LOCK TABLES `denominations` WRITE;
/*!40000 ALTER TABLE `denominations` DISABLE KEYS */;
INSERT INTO `denominations` VALUES (1,'533aa6aa-aa8c-4f0c-bf9f-e78349b78567','Delta',300.00,'coin',NULL,1,1,1,'2025-11-30 05:04:30','2025-11-30 05:04:30',NULL);
/*!40000 ALTER TABLE `denominations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `desktop_applications`
--

DROP TABLE IF EXISTS `desktop_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `desktop_applications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `windows_file_path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mac_file_path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linux_file_path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `desktop_applications`
--

LOCK TABLES `desktop_applications` WRITE;
/*!40000 ALTER TABLE `desktop_applications` DISABLE KEYS */;
INSERT INTO `desktop_applications` VALUES (1,'https://envato.froid.works/app/download/windows','https://envato.froid.works/app/download/macos','https://envato.froid.works/app/download/linux','2025-11-30 02:56:35','2025-11-30 02:56:39');
/*!40000 ALTER TABLE `desktop_applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_settings`
--

DROP TABLE IF EXISTS `email_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `mail_from_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_from_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable_queue` enum('yes','no') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'no',
  `mail_driver` enum('mail','smtp') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'mail',
  `smtp_host` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_port` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_encryption` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `email_verified` tinyint(1) NOT NULL DEFAULT '0',
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_settings`
--

LOCK TABLES `email_settings` WRITE;
/*!40000 ALTER TABLE `email_settings` DISABLE KEYS */;
INSERT INTO `email_settings` VALUES (1,'TableTrack','from@email.com','no','smtp','smtp.gmail.com','465','ssl','myemail@gmail.com',NULL,'2025-11-30 02:57:24','2025-11-30 02:57:24',0,0),(2,'TableTrack','from@email.com','no','smtp','smtp.gmail.com','465','ssl','myemail@gmail.com',NULL,'2025-11-30 02:59:34','2025-11-30 02:59:34',0,0),(3,'TableTrack','from@email.com','no','smtp','smtp.gmail.com','465','ssl','myemail@gmail.com',NULL,'2025-11-30 02:59:55','2025-11-30 02:59:55',0,0),(4,'TableTrack','from@email.com','no','smtp','smtp.gmail.com','465','ssl','myemail@gmail.com',NULL,'2025-11-30 03:00:20','2025-11-30 03:00:20',0,0);
/*!40000 ALTER TABLE `email_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epay_payments`
--

DROP TABLE IF EXISTS `epay_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `epay_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `epay_payment_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` bigint unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_status` enum('pending','completed','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_date` timestamp NULL DEFAULT NULL,
  `payment_error_response` json DEFAULT NULL,
  `epay_invoice_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `epay_secret_hash` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `epay_access_token` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `epay_payments_order_id_foreign` (`order_id`),
  CONSTRAINT `epay_payments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epay_payments`
--

LOCK TABLES `epay_payments` WRITE;
/*!40000 ALTER TABLE `epay_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `epay_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense_categories`
--

DROP TABLE IF EXISTS `expense_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expense_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `expense_categories_branch_id_foreign` (`branch_id`),
  CONSTRAINT `expense_categories_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense_categories`
--

LOCK TABLES `expense_categories` WRITE;
/*!40000 ALTER TABLE `expense_categories` DISABLE KEYS */;
INSERT INTO `expense_categories` VALUES (1,1,'Rent','Monthly rent for restaurant space',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(2,1,'Utilities','Electricity, water, gas, and other utilities',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(3,1,'Salaries','Employee salaries and wages',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(4,1,'Ingredients','Food ingredients and raw materials',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(5,1,'Equipment','Kitchen equipment and appliances',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(6,1,'Marketing','Advertising and promotional expenses',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(7,1,'Insurance','Business insurance and liability coverage',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(8,1,'Maintenance','Repairs and maintenance costs',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(9,1,'Licenses','Business licenses and permits',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(10,1,'Miscellaneous','Other miscellaneous expenses',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(11,2,'Rent','Monthly rent for restaurant space',1,'2025-11-30 02:57:24','2025-11-30 02:57:24'),(12,2,'Utilities','Electricity, water, gas, and other utilities',1,'2025-11-30 02:57:24','2025-11-30 02:57:24'),(13,2,'Salaries','Employee salaries and wages',1,'2025-11-30 02:57:24','2025-11-30 02:57:24'),(14,2,'Ingredients','Food ingredients and raw materials',1,'2025-11-30 02:57:24','2025-11-30 02:57:24'),(15,2,'Equipment','Kitchen equipment and appliances',1,'2025-11-30 02:57:24','2025-11-30 02:57:24'),(16,2,'Marketing','Advertising and promotional expenses',1,'2025-11-30 02:57:24','2025-11-30 02:57:24'),(17,2,'Insurance','Business insurance and liability coverage',1,'2025-11-30 02:57:24','2025-11-30 02:57:24'),(18,2,'Maintenance','Repairs and maintenance costs',1,'2025-11-30 02:57:24','2025-11-30 02:57:24'),(19,2,'Licenses','Business licenses and permits',1,'2025-11-30 02:57:24','2025-11-30 02:57:24'),(20,2,'Miscellaneous','Other miscellaneous expenses',1,'2025-11-30 02:57:24','2025-11-30 02:57:24'),(21,3,'Rent','Monthly rent for restaurant space',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(22,3,'Utilities','Electricity, water, gas, and other utilities',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(23,3,'Salaries','Employee salaries and wages',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(24,3,'Ingredients','Food ingredients and raw materials',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(25,3,'Equipment','Kitchen equipment and appliances',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(26,3,'Marketing','Advertising and promotional expenses',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(27,3,'Insurance','Business insurance and liability coverage',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(28,3,'Maintenance','Repairs and maintenance costs',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(29,3,'Licenses','Business licenses and permits',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(30,3,'Miscellaneous','Other miscellaneous expenses',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(31,4,'Rent','Monthly rent for restaurant space',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(32,4,'Utilities','Electricity, water, gas, and other utilities',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(33,4,'Salaries','Employee salaries and wages',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(34,4,'Ingredients','Food ingredients and raw materials',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(35,4,'Equipment','Kitchen equipment and appliances',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(36,4,'Marketing','Advertising and promotional expenses',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(37,4,'Insurance','Business insurance and liability coverage',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(38,4,'Maintenance','Repairs and maintenance costs',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(39,4,'Licenses','Business licenses and permits',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(40,4,'Miscellaneous','Other miscellaneous expenses',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(41,5,'Rent','Monthly rent for restaurant space',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(42,5,'Utilities','Electricity, water, gas, and other utilities',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(43,5,'Salaries','Employee salaries and wages',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(44,5,'Ingredients','Food ingredients and raw materials',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(45,5,'Equipment','Kitchen equipment and appliances',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(46,5,'Marketing','Advertising and promotional expenses',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(47,5,'Insurance','Business insurance and liability coverage',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(48,5,'Maintenance','Repairs and maintenance costs',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(49,5,'Licenses','Business licenses and permits',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(50,5,'Miscellaneous','Other miscellaneous expenses',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(51,6,'Rent','Monthly rent for restaurant space',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(52,6,'Utilities','Electricity, water, gas, and other utilities',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(53,6,'Salaries','Employee salaries and wages',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(54,6,'Ingredients','Food ingredients and raw materials',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(55,6,'Equipment','Kitchen equipment and appliances',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(56,6,'Marketing','Advertising and promotional expenses',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(57,6,'Insurance','Business insurance and liability coverage',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(58,6,'Maintenance','Repairs and maintenance costs',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(59,6,'Licenses','Business licenses and permits',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(60,6,'Miscellaneous','Other miscellaneous expenses',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(61,7,'Rent','Monthly rent for restaurant space',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(62,7,'Utilities','Electricity, water, gas, and other utilities',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(63,7,'Salaries','Employee salaries and wages',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(64,7,'Ingredients','Food ingredients and raw materials',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(65,7,'Equipment','Kitchen equipment and appliances',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(66,7,'Marketing','Advertising and promotional expenses',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(67,7,'Insurance','Business insurance and liability coverage',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(68,7,'Maintenance','Repairs and maintenance costs',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(69,7,'Licenses','Business licenses and permits',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(70,7,'Miscellaneous','Other miscellaneous expenses',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(71,8,'Rent','Monthly rent for restaurant space',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(72,8,'Utilities','Electricity, water, gas, and other utilities',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(73,8,'Salaries','Employee salaries and wages',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(74,8,'Ingredients','Food ingredients and raw materials',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(75,8,'Equipment','Kitchen equipment and appliances',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(76,8,'Marketing','Advertising and promotional expenses',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(77,8,'Insurance','Business insurance and liability coverage',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(78,8,'Maintenance','Repairs and maintenance costs',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(79,8,'Licenses','Business licenses and permits',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(80,8,'Miscellaneous','Other miscellaneous expenses',1,'2025-11-30 03:00:20','2025-11-30 03:00:20');
/*!40000 ALTER TABLE `expense_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses`
--

DROP TABLE IF EXISTS `expenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expenses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `expense_category_id` bigint unsigned DEFAULT NULL,
  `branch_id` bigint unsigned NOT NULL,
  `expense_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `amount` decimal(10,2) NOT NULL,
  `expense_date` date NOT NULL,
  `payment_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_due_date` date DEFAULT NULL,
  `payment_method` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_expense_category_id_foreign` (`expense_category_id`),
  KEY `expenses_branch_id_foreign` (`branch_id`),
  CONSTRAINT `expenses_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `expenses_expense_category_id_foreign` FOREIGN KEY (`expense_category_id`) REFERENCES `expense_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses`
--

LOCK TABLES `expenses` WRITE;
/*!40000 ALTER TABLE `expenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_storage`
--

DROP TABLE IF EXISTS `file_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file_storage` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `path` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` int unsigned NOT NULL,
  `storage_location` enum('local','aws_s3','digitalocean','wasabi','minio') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'local',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `file_storage_restaurant_id_foreign` (`restaurant_id`),
  CONSTRAINT `file_storage_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_storage`
--

LOCK TABLES `file_storage` WRITE;
/*!40000 ALTER TABLE `file_storage` DISABLE KEYS */;
INSERT INTO `file_storage` VALUES (1,1,'qrcodes','qrcode-branch-1-1.png','image/png',2504,'local','2025-11-30 02:57:23','2025-11-30 02:57:23'),(3,1,'qrcodes','qrcode-branch-2-1.png','image/png',2522,'local','2025-11-30 02:57:23','2025-11-30 02:57:23'),(4,1,'qrcodes','qrcode-branch-2-1.png','image/png',2606,'local','2025-11-30 02:57:24','2025-11-30 02:57:24'),(5,1,'qrcodes','qrcode-1-t-1.png','image/png',4398,'local','2025-11-30 02:57:25','2025-11-30 02:57:25'),(6,1,'qrcodes','qrcode-1-t-2.png','image/png',4698,'local','2025-11-30 02:57:25','2025-11-30 02:57:25'),(7,1,'qrcodes','qrcode-1-t-3.png','image/png',4646,'local','2025-11-30 02:57:25','2025-11-30 02:57:25'),(8,1,'qrcodes','qrcode-1-t-4.png','image/png',4498,'local','2025-11-30 02:57:26','2025-11-30 02:57:26'),(9,1,'qrcodes','qrcode-1-t-5.png','image/png',4593,'local','2025-11-30 02:57:26','2025-11-30 02:57:26'),(10,1,'qrcodes','qrcode-1-t-6.png','image/png',4726,'local','2025-11-30 02:57:26','2025-11-30 02:57:26'),(11,1,'qrcodes','qrcode-1-t-7.png','image/png',4486,'local','2025-11-30 02:57:26','2025-11-30 02:57:26'),(12,1,'qrcodes','qrcode-1-t-8.png','image/png',4743,'local','2025-11-30 02:57:26','2025-11-30 02:57:26'),(13,1,'qrcodes','qrcode-1-t-9.png','image/png',4779,'local','2025-11-30 02:57:26','2025-11-30 02:57:26'),(14,1,'qrcodes','qrcode-1-t-10.png','image/png',4843,'local','2025-11-30 02:57:26','2025-11-30 02:57:26'),(15,2,'qrcodes','qrcode-branch-3-2.png','image/png',2521,'local','2025-11-30 02:59:34','2025-11-30 02:59:34'),(17,2,'qrcodes','qrcode-branch-4-2.png','image/png',2533,'local','2025-11-30 02:59:34','2025-11-30 02:59:34'),(19,3,'qrcodes','qrcode-branch-5-3.png','image/png',2575,'local','2025-11-30 02:59:54','2025-11-30 02:59:54'),(21,3,'qrcodes','qrcode-branch-6-3.png','image/png',2550,'local','2025-11-30 02:59:55','2025-11-30 02:59:55'),(23,4,'qrcodes','qrcode-branch-7-4.png','image/png',2587,'local','2025-11-30 03:00:19','2025-11-30 03:00:19'),(25,4,'qrcodes','qrcode-branch-8-4.png','image/png',2581,'local','2025-11-30 03:00:20','2025-11-30 03:00:20'),(27,1,'qrcodes','qrcode-1-t-1.png','image/png',4423,'local','2025-11-30 03:00:21','2025-11-30 03:00:21'),(28,1,'qrcodes','qrcode-1-t-2.png','image/png',4618,'local','2025-11-30 03:00:21','2025-11-30 03:00:21'),(29,1,'qrcodes','qrcode-1-t-3.png','image/png',4649,'local','2025-11-30 03:00:22','2025-11-30 03:00:22'),(30,1,'qrcodes','qrcode-1-t-4.png','image/png',4517,'local','2025-11-30 03:00:22','2025-11-30 03:00:22'),(31,1,'qrcodes','qrcode-1-t-5.png','image/png',4618,'local','2025-11-30 03:00:22','2025-11-30 03:00:22'),(32,1,'qrcodes','qrcode-1-t-6.png','image/png',4708,'local','2025-11-30 03:00:22','2025-11-30 03:00:22'),(33,1,'qrcodes','qrcode-1-t-7.png','image/png',4492,'local','2025-11-30 03:00:22','2025-11-30 03:00:22'),(34,1,'qrcodes','qrcode-1-t-8.png','image/png',4729,'local','2025-11-30 03:00:22','2025-11-30 03:00:22'),(35,1,'qrcodes','qrcode-1-t-9.png','image/png',4733,'local','2025-11-30 03:00:23','2025-11-30 03:00:23'),(36,1,'qrcodes','qrcode-1-t-10.png','image/png',4873,'local','2025-11-30 03:00:23','2025-11-30 03:00:23'),(37,2,'qrcodes','qrcode-3-t-1.png','image/png',4377,'local','2025-11-30 03:00:26','2025-11-30 03:00:26'),(38,2,'qrcodes','qrcode-3-t-2.png','image/png',4658,'local','2025-11-30 03:00:27','2025-11-30 03:00:27'),(39,2,'qrcodes','qrcode-3-t-3.png','image/png',4712,'local','2025-11-30 03:00:27','2025-11-30 03:00:27'),(40,2,'qrcodes','qrcode-3-t-4.png','image/png',4499,'local','2025-11-30 03:00:27','2025-11-30 03:00:27'),(41,2,'qrcodes','qrcode-3-t-5.png','image/png',4603,'local','2025-11-30 03:00:27','2025-11-30 03:00:27'),(42,2,'qrcodes','qrcode-3-t-6.png','image/png',4726,'local','2025-11-30 03:00:27','2025-11-30 03:00:27'),(43,2,'qrcodes','qrcode-3-t-7.png','image/png',4503,'local','2025-11-30 03:00:27','2025-11-30 03:00:27'),(44,2,'qrcodes','qrcode-3-t-8.png','image/png',4687,'local','2025-11-30 03:00:27','2025-11-30 03:00:27'),(45,2,'qrcodes','qrcode-3-t-9.png','image/png',4744,'local','2025-11-30 03:00:27','2025-11-30 03:00:27'),(46,2,'qrcodes','qrcode-3-t-10.png','image/png',4860,'local','2025-11-30 03:00:27','2025-11-30 03:00:27'),(47,3,'qrcodes','qrcode-5-t-1.png','image/png',4361,'local','2025-11-30 03:00:31','2025-11-30 03:00:31'),(48,3,'qrcodes','qrcode-5-t-2.png','image/png',4659,'local','2025-11-30 03:00:31','2025-11-30 03:00:31'),(49,3,'qrcodes','qrcode-5-t-3.png','image/png',4649,'local','2025-11-30 03:00:31','2025-11-30 03:00:31'),(50,3,'qrcodes','qrcode-5-t-4.png','image/png',4501,'local','2025-11-30 03:00:31','2025-11-30 03:00:31'),(51,3,'qrcodes','qrcode-5-t-5.png','image/png',4629,'local','2025-11-30 03:00:31','2025-11-30 03:00:31'),(52,3,'qrcodes','qrcode-5-t-6.png','image/png',4749,'local','2025-11-30 03:00:31','2025-11-30 03:00:31'),(53,3,'qrcodes','qrcode-5-t-7.png','image/png',4476,'local','2025-11-30 03:00:32','2025-11-30 03:00:32'),(54,3,'qrcodes','qrcode-5-t-8.png','image/png',4709,'local','2025-11-30 03:00:32','2025-11-30 03:00:32'),(55,3,'qrcodes','qrcode-5-t-9.png','image/png',4757,'local','2025-11-30 03:00:32','2025-11-30 03:00:32'),(56,3,'qrcodes','qrcode-5-t-10.png','image/png',4835,'local','2025-11-30 03:00:32','2025-11-30 03:00:32'),(57,4,'qrcodes','qrcode-7-t-1.png','image/png',4377,'local','2025-11-30 03:00:36','2025-11-30 03:00:36'),(58,4,'qrcodes','qrcode-7-t-2.png','image/png',4659,'local','2025-11-30 03:00:36','2025-11-30 03:00:36'),(59,4,'qrcodes','qrcode-7-t-3.png','image/png',4641,'local','2025-11-30 03:00:36','2025-11-30 03:00:36'),(60,4,'qrcodes','qrcode-7-t-4.png','image/png',4503,'local','2025-11-30 03:00:36','2025-11-30 03:00:36'),(61,4,'qrcodes','qrcode-7-t-5.png','image/png',4584,'local','2025-11-30 03:00:36','2025-11-30 03:00:36'),(62,4,'qrcodes','qrcode-7-t-6.png','image/png',4700,'local','2025-11-30 03:00:36','2025-11-30 03:00:36'),(63,4,'qrcodes','qrcode-7-t-7.png','image/png',4458,'local','2025-11-30 03:00:36','2025-11-30 03:00:36'),(64,4,'qrcodes','qrcode-7-t-8.png','image/png',4705,'local','2025-11-30 03:00:37','2025-11-30 03:00:37'),(65,4,'qrcodes','qrcode-7-t-9.png','image/png',4778,'local','2025-11-30 03:00:37','2025-11-30 03:00:37'),(66,4,'qrcodes','qrcode-7-t-10.png','image/png',4854,'local','2025-11-30 03:00:37','2025-11-30 03:00:37');
/*!40000 ALTER TABLE `file_storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_storage_settings`
--

DROP TABLE IF EXISTS `file_storage_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file_storage_settings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `filesystem` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auth_keys` text COLLATE utf8mb4_unicode_ci,
  `status` enum('enabled','disabled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'disabled',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_storage_settings`
--

LOCK TABLES `file_storage_settings` WRITE;
/*!40000 ALTER TABLE `file_storage_settings` DISABLE KEYS */;
INSERT INTO `file_storage_settings` VALUES (1,'local',NULL,'enabled','2025-11-30 02:55:58','2025-11-30 02:55:58');
/*!40000 ALTER TABLE `file_storage_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flags`
--

DROP TABLE IF EXISTS `flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `capital` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `continent` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=267 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flags`
--

LOCK TABLES `flags` WRITE;
/*!40000 ALTER TABLE `flags` DISABLE KEYS */;
INSERT INTO `flags` VALUES (1,'Kabul','af','Asia','Afghanistan'),(2,'Mariehamn','ax','Europe','Aland Islands'),(3,'Tirana','al','Europe','Albania'),(4,'Algiers','dz','Africa','Algeria'),(5,'Pago Pago','as','Oceania','American Samoa'),(6,'Andorra la Vella','ad','Europe','Andorra'),(7,'Luanda','ao','Africa','Angola'),(8,'The Valley','ai','North America','Anguilla'),(9,'','aq','','Antarctica'),(10,'St. John\'s','ag','North America','Antigua and Barbuda'),(11,'Buenos Aires','ar','South America','Argentina'),(12,'Yerevan','am','Asia','Armenia'),(13,'Oranjestad','aw','South America','Aruba'),(14,'Georgetown','ac','Africa','Ascension Island'),(15,'Canberra','au','Oceania','Australia'),(16,'Vienna','at','Europe','Austria'),(17,'Baku','az','Asia','Azerbaijan'),(18,'Nassau','bs','North America','Bahamas'),(19,'Manama','bh','Asia','Bahrain'),(20,'Dhaka','bd','Asia','Bangladesh'),(21,'Bridgetown','bb','North America','Barbados'),(22,'Minsk','by','Europe','Belarus'),(23,'Brussels','be','Europe','Belgium'),(24,'Belmopan','bz','North America','Belize'),(25,'Porto-Novo','bj','Africa','Benin'),(26,'Hamilton','bm','North America','Bermuda'),(27,'Thimphu','bt','Asia','Bhutan'),(28,'Sucre','bo','South America','Bolivia'),(29,'Kralendijk','bq','South America','Bonaire, Sint Eustatius and Saba'),(30,'Sarajevo','ba','Europe','Bosnia and Herzegovina'),(31,'Gaborone','bw','Africa','Botswana'),(32,'','bv','','Bouvet Island'),(33,'Brasília','br','South America','Brazil'),(34,'Diego Garcia','io','Asia','British Indian Ocean Territory'),(35,'Bandar Seri Begawan','bn','Asia','Brunei Darussalam'),(36,'Sofia','bg','Europe','Bulgaria'),(37,'Ouagadougou','bf','Africa','Burkina Faso'),(38,'Bujumbura','bi','Africa','Burundi'),(39,'Praia','cv','Africa','Cabo Verde'),(40,'Phnom Penh','kh','Asia','Cambodia'),(41,'Yaoundé','cm','Africa','Cameroon'),(42,'Ottawa','ca','North America','Canada'),(43,'','ic','','Canary Islands'),(44,'','es-ct','','Catalonia'),(45,'George Town','ky','North America','Cayman Islands'),(46,'Bangui','cf','Africa','Central African Republic'),(47,'','cefta','','Central European Free Trade Agreement'),(48,'','ea','','Ceuta & Melilla'),(49,'N\'Djamena','td','Africa','Chad'),(50,'Santiago','cl','South America','Chile'),(51,'Beijing','cn','Asia','China'),(52,'Flying Fish Cove','cx','Asia','Christmas Island'),(53,'','cp','','Clipperton Island'),(54,'West Island','cc','Asia','Cocos (Keeling) Islands'),(55,'Bogotá','co','South America','Colombia'),(56,'Moroni','km','Africa','Comoros'),(57,'Avarua','ck','Oceania','Cook Islands'),(58,'San José','cr','North America','Costa Rica'),(59,'Zagreb','hr','Europe','Croatia'),(60,'Havana','cu','North America','Cuba'),(61,'Willemstad','cw','South America','Curaçao'),(62,'Nicosia','cy','Europe','Cyprus'),(63,'Prague','cz','Europe','Czech Republic'),(64,'Yamoussoukro','ci','Africa','Côte d\'Ivoire'),(65,'Kinshasa','cd','Africa','Democratic Republic of the Congo'),(66,'Copenhagen','dk','Europe','Denmark'),(67,'','dg','','Diego Garcia'),(68,'Djibouti','dj','Africa','Djibouti'),(69,'Roseau','dm','North America','Dominica'),(70,'Santo Domingo','do','North America','Dominican Republic'),(71,'Quito','ec','South America','Ecuador'),(72,'Cairo','eg','Africa','Egypt'),(73,'San Salvador','sv','North America','El Salvador'),(74,'London','gb-eng','Europe','England'),(75,'Malabo','gq','Africa','Equatorial Guinea'),(76,'Asmara','er','Africa','Eritrea'),(77,'Tallinn','ee','Europe','Estonia'),(78,'Lobamba, Mbabane','sz','Africa','Eswatini'),(79,'Addis Ababa','et','Africa','Ethiopia'),(80,'','eu','','Europe'),(81,'Stanley','fk','South America','Falkland Islands'),(82,'Tórshavn','fo','Europe','Faroe Islands'),(83,'Palikir','fm','Oceania','Federated States of Micronesia'),(84,'Suva','fj','Oceania','Fiji'),(85,'Helsinki','fi','Europe','Finland'),(86,'Paris','fr','Europe','France'),(87,'Cayenne','gf','South America','French Guiana'),(88,'Papeete','pf','Oceania','French Polynesia'),(89,'Saint-Pierre, Réunion','tf','Africa','French Southern Territories'),(90,'Libreville','ga','Africa','Gabon'),(91,'','es-ga','','Galicia'),(92,'Banjul','gm','Africa','Gambia'),(93,'Tbilisi','ge','Asia','Georgia'),(94,'Berlin','de','Europe','Germany'),(95,'Accra','gh','Africa','Ghana'),(96,'Gibraltar','gi','Europe','Gibraltar'),(97,'Athens','gr','Europe','Greece'),(98,'Nuuk','gl','North America','Greenland'),(99,'St. George\'s','gd','North America','Grenada'),(100,'Basse-Terre','gp','North America','Guadeloupe'),(101,'Hagåtña','gu','Oceania','Guam'),(102,'Guatemala City','gt','North America','Guatemala'),(103,'Saint Peter Port','gg','Europe','Guernsey'),(104,'Conakry','gn','Africa','Guinea'),(105,'Bissau','gw','Africa','Guinea-Bissau'),(106,'Georgetown','gy','South America','Guyana'),(107,'Port-au-Prince','ht','North America','Haiti'),(108,'','hm','','Heard Island and McDonald Islands'),(109,'Vatican City','va','Europe','Holy See'),(110,'Tegucigalpa','hn','North America','Honduras'),(111,'Hong Kong','hk','Asia','Hong Kong'),(112,'Budapest','hu','Europe','Hungary'),(113,'Reykjavik','is','Europe','Iceland'),(114,'New Delhi','in','Asia','India'),(115,'Jakarta','id','Asia','Indonesia'),(116,'Tehran','ir','Asia','Iran'),(117,'Baghdad','iq','Asia','Iraq'),(118,'Dublin','ie','Europe','Ireland'),(119,'Douglas','im','Europe','Isle of Man'),(120,'Jerusalem','il','Asia','Israel'),(121,'Rome','it','Europe','Italy'),(122,'Kingston','jm','North America','Jamaica'),(123,'Tokyo','jp','Asia','Japan'),(124,'Saint Helier','je','Europe','Jersey'),(125,'Amman','jo','Asia','Jordan'),(126,'Astana','kz','Asia','Kazakhstan'),(127,'Nairobi','ke','Africa','Kenya'),(128,'South Tarawa','ki','Oceania','Kiribati'),(129,'Pristina','xk','Europe','Kosovo'),(130,'Kuwait City','kw','Asia','Kuwait'),(131,'Bishkek','kg','Asia','Kyrgyzstan'),(132,'Vientiane','la','Asia','Laos'),(133,'Riga','lv','Europe','Latvia'),(134,'Beirut','lb','Asia','Lebanon'),(135,'Maseru','ls','Africa','Lesotho'),(136,'Monrovia','lr','Africa','Liberia'),(137,'Tripoli','ly','Africa','Libya'),(138,'Vaduz','li','Europe','Liechtenstein'),(139,'Vilnius','lt','Europe','Lithuania'),(140,'Luxembourg City','lu','Europe','Luxembourg'),(141,'Macau','mo','Asia','Macau'),(142,'Antananarivo','mg','Africa','Madagascar'),(143,'Lilongwe','mw','Africa','Malawi'),(144,'Kuala Lumpur','my','Asia','Malaysia'),(145,'Malé','mv','Asia','Maldives'),(146,'Bamako','ml','Africa','Mali'),(147,'Valletta','mt','Europe','Malta'),(148,'Majuro','mh','Oceania','Marshall Islands'),(149,'Fort-de-France','mq','North America','Martinique'),(150,'Nouakchott','mr','Africa','Mauritania'),(151,'Port Louis','mu','Africa','Mauritius'),(152,'Mamoudzou','yt','Africa','Mayotte'),(153,'Mexico City','mx','North America','Mexico'),(154,'Chișinău','md','Europe','Moldova'),(155,'Monaco','mc','Europe','Monaco'),(156,'Ulaanbaatar','mn','Asia','Mongolia'),(157,'Podgorica','me','Europe','Montenegro'),(158,'Little Bay, Brades, Plymouth','ms','North America','Montserrat'),(159,'Rabat','ma','Africa','Morocco'),(160,'Maputo','mz','Africa','Mozambique'),(161,'Naypyidaw','mm','Asia','Myanmar'),(162,'Windhoek','na','Africa','Namibia'),(163,'Yaren District','nr','Oceania','Nauru'),(164,'Kathmandu','np','Asia','Nepal'),(165,'Amsterdam','nl','Europe','Netherlands'),(166,'Nouméa','nc','Oceania','New Caledonia'),(167,'Wellington','nz','Oceania','New Zealand'),(168,'Managua','ni','North America','Nicaragua'),(169,'Niamey','ne','Africa','Niger'),(170,'Abuja','ng','Africa','Nigeria'),(171,'Alofi','nu','Oceania','Niue'),(172,'Kingston','nf','Oceania','Norfolk Island'),(173,'Pyongyang','kp','Asia','North Korea'),(174,'Skopje','mk','Europe','North Macedonia'),(175,'Belfast','gb-nir','Europe','Northern Ireland'),(176,'Saipan','mp','Oceania','Northern Mariana Islands'),(177,'Oslo','no','Europe','Norway'),(178,'Muscat','om','Asia','Oman'),(179,'Islamabad','pk','Asia','Pakistan'),(180,'Ngerulmud','pw','Oceania','Palau'),(181,'Panama City','pa','North America','Panama'),(182,'Port Moresby','pg','Oceania','Papua New Guinea'),(183,'Asunción','py','South America','Paraguay'),(184,'Lima','pe','South America','Peru'),(185,'Manila','ph','Asia','Philippines'),(186,'Adamstown','pn','Oceania','Pitcairn'),(187,'Warsaw','pl','Europe','Poland'),(188,'Lisbon','pt','Europe','Portugal'),(189,'San Juan','pr','North America','Puerto Rico'),(190,'Doha','qa','Asia','Qatar'),(191,'Brazzaville','cg','Africa','Republic of the Congo'),(192,'Bucharest','ro','Europe','Romania'),(193,'Moscow','ru','Europe','Russia'),(194,'Kigali','rw','Africa','Rwanda'),(195,'Saint-Denis','re','Africa','Réunion'),(196,'Gustavia','bl','North America','Saint Barthélemy'),(197,'Jamestown','sh','Africa','Saint Helena, Ascension and Tristan da Cunha'),(198,'Basseterre','kn','North America','Saint Kitts and Nevis'),(199,'Castries','lc','North America','Saint Lucia'),(200,'Marigot','mf','North America','Saint Martin'),(201,'Saint-Pierre','pm','North America','Saint Pierre and Miquelon'),(202,'Kingstown','vc','North America','Saint Vincent and the Grenadines'),(203,'Apia','ws','Oceania','Samoa'),(204,'San Marino','sm','Europe','San Marino'),(205,'São Tomé','st','Africa','Sao Tome and Principe'),(206,'Riyadh','sa','Asia','Saudi Arabia'),(207,'Edinburgh','gb-sct','Europe','Scotland'),(208,'Dakar','sn','Africa','Senegal'),(209,'Belgrade','rs','Europe','Serbia'),(210,'Victoria','sc','Africa','Seychelles'),(211,'Freetown','sl','Africa','Sierra Leone'),(212,'Singapore','sg','Asia','Singapore'),(213,'Philipsburg','sx','North America','Sint Maarten'),(214,'Bratislava','sk','Europe','Slovakia'),(215,'Ljubljana','si','Europe','Slovenia'),(216,'Honiara','sb','Oceania','Solomon Islands'),(217,'Mogadishu','so','Africa','Somalia'),(218,'Pretoria','za','Africa','South Africa'),(219,'King Edward Point','gs','Antarctica','South Georgia and the South Sandwich Islands'),(220,'Seoul','kr','Asia','South Korea'),(221,'Juba','ss','Africa','South Sudan'),(222,'Madrid','es','Europe','Spain'),(223,'Sri Jayawardenepura Kotte, Colombo','lk','Asia','Sri Lanka'),(224,'Ramallah','ps','Asia','State of Palestine'),(225,'Khartoum','sd','Africa','Sudan'),(226,'Paramaribo','sr','South America','Suriname'),(227,'Longyearbyen','sj','Europe','Svalbard and Jan Mayen'),(228,'Stockholm','se','Europe','Sweden'),(229,'Bern','ch','Europe','Switzerland'),(230,'Damascus','sy','Asia','Syria'),(231,'Taipei','tw','Asia','Taiwan'),(232,'Dushanbe','tj','Asia','Tajikistan'),(233,'Dodoma','tz','Africa','Tanzania'),(234,'Bangkok','th','Asia','Thailand'),(235,'Dili','tl','Asia','Timor-Leste'),(236,'Lomé','tg','Africa','Togo'),(237,'Nukunonu, Atafu,Tokelau','tk','Oceania','Tokelau'),(238,'Nukuʻalofa','to','Oceania','Tonga'),(239,'Port of Spain','tt','South America','Trinidad and Tobago'),(240,'','ta','','Tristan da Cunha'),(241,'Tunis','tn','Africa','Tunisia'),(242,'Ankara','tr','Asia','Turkey'),(243,'Ashgabat','tm','Asia','Turkmenistan'),(244,'Cockburn Town','tc','North America','Turks and Caicos Islands'),(245,'Funafuti','tv','Oceania','Tuvalu'),(246,'Kampala','ug','Africa','Uganda'),(247,'Kiev','ua','Europe','Ukraine'),(248,'Abu Dhabi','ae','Asia','United Arab Emirates'),(249,'London','gb','Europe','United Kingdom'),(250,'','un','','United Nations'),(251,'Washington, D.C.','um','North America','United States Minor Outlying Islands'),(252,'Washington, D.C.','us','North America','United States of America'),(253,'','xx','','Unknown'),(254,'Montevideo','uy','South America','Uruguay'),(255,'Tashkent','uz','Asia','Uzbekistan'),(256,'Port Vila','vu','Oceania','Vanuatu'),(257,'Caracas','ve','South America','Venezuela'),(258,'Hanoi','vn','Asia','Vietnam'),(259,'Road Town','vg','North America','Virgin Islands (British)'),(260,'Charlotte Amalie','vi','North America','Virgin Islands (U.S.)'),(261,'Cardiff','gb-wls','Europe','Wales'),(262,'Mata-Utu','wf','Oceania','Wallis and Futuna'),(263,'Laayoune','eh','Africa','Western Sahara'),(264,'Sana\'a','ye','Asia','Yemen'),(265,'Lusaka','zm','Africa','Zambia'),(266,'Harare','zw','Africa','Zimbabwe');
/*!40000 ALTER TABLE `flags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flutterwave_payments`
--

DROP TABLE IF EXISTS `flutterwave_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flutterwave_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `flutterwave_payment_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` bigint unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_status` enum('pending','completed','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_date` timestamp NULL DEFAULT NULL,
  `payment_error_response` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `flutterwave_payments_order_id_foreign` (`order_id`),
  CONSTRAINT `flutterwave_payments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flutterwave_payments`
--

LOCK TABLES `flutterwave_payments` WRITE;
/*!40000 ALTER TABLE `flutterwave_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `flutterwave_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `front_details`
--

DROP TABLE IF EXISTS `front_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `front_details` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `language_setting_id` bigint unsigned DEFAULT NULL,
  `header_title` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `header_description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feature_with_image_heading` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `review_heading` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feature_with_icon_heading` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comments_heading` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_heading` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `faq_heading` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `faq_description` text COLLATE utf8mb4_unicode_ci,
  `contact_heading` text COLLATE utf8mb4_unicode_ci,
  `footer_copyright_text` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `front_details_language_setting_id_foreign` (`language_setting_id`),
  CONSTRAINT `front_details_language_setting_id_foreign` FOREIGN KEY (`language_setting_id`) REFERENCES `language_settings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `front_details`
--

LOCK TABLES `front_details` WRITE;
/*!40000 ALTER TABLE `front_details` DISABLE KEYS */;
INSERT INTO `front_details` VALUES (1,1,'Restaurant POS software made simple!','Easily manage orders, menus, and tables in one place. Save time, reduce errors, and grow your business faster',NULL,'Take Control of Your Restaurant','What Restaurant Owners Are Saying','Powerful Features Built to Elevate Your Restaurant Operations',NULL,'Simple, Transparent Pricing','Get everything you need to manage your restaurant with one affordable plan.','Your questions, answered','Answers to the most frequently asked questions.','Contact','© 2025 TableTrack. All Rights Reserved.','2025-11-30 02:57:24','2025-11-30 02:57:24');
/*!40000 ALTER TABLE `front_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `front_faq_settings`
--

DROP TABLE IF EXISTS `front_faq_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `front_faq_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `language_setting_id` bigint unsigned DEFAULT NULL,
  `question` text COLLATE utf8mb4_unicode_ci,
  `answer` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `front_faq_settings_language_setting_id_foreign` (`language_setting_id`),
  CONSTRAINT `front_faq_settings_language_setting_id_foreign` FOREIGN KEY (`language_setting_id`) REFERENCES `language_settings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `front_faq_settings`
--

LOCK TABLES `front_faq_settings` WRITE;
/*!40000 ALTER TABLE `front_faq_settings` DISABLE KEYS */;
INSERT INTO `front_faq_settings` VALUES (1,1,'How can I contact customer support 1?','Our dedicated support team is available via email to assist you with any questions or technical issues.',NULL,NULL),(2,1,'How can I contact customer support?','Our dedicated support team is available via email to assist you with any questions or technical issues.',NULL,NULL),(3,1,'How can I contact customer support?','Our dedicated support team is available via email to assist you with any questions or technical issues.',NULL,NULL),(4,1,'How can I contact customer support?','Our dedicated support team is available via email to assist you with any questions or technical issues.',NULL,NULL),(5,1,'How can I contact customer support?','Our dedicated support team is available via email to assist you with any questions or technical issues.',NULL,NULL),(6,1,'How can I contact customer support?','Our dedicated support team is available via email to assist you with any questions or technical issues.',NULL,NULL);
/*!40000 ALTER TABLE `front_faq_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `front_features`
--

DROP TABLE IF EXISTS `front_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `front_features` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `language_setting_id` bigint unsigned DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `image` longtext COLLATE utf8mb4_unicode_ci,
  `icon` longtext COLLATE utf8mb4_unicode_ci,
  `type` enum('image','icon','task','bills','team','apps') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'image',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `front_features_language_setting_id_foreign` (`language_setting_id`),
  CONSTRAINT `front_features_language_setting_id_foreign` FOREIGN KEY (`language_setting_id`) REFERENCES `language_settings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `front_features`
--

LOCK TABLES `front_features` WRITE;
/*!40000 ALTER TABLE `front_features` DISABLE KEYS */;
INSERT INTO `front_features` VALUES (1,1,'Streamline Order Management','Never lose track of an order again. All your customer orders—from dine-in to takeout—are organized and easily accessible in one place.\n                                Speed up service and keep your kitchen running smoothly.',NULL,NULL,'image',NULL,NULL),(2,1,'Optimize Table Reservations','Maximize seating efficiency with real-time table tracking and reservations. Reduce wait times and ensure no table sits empty during peak hours, improving customer experience and turnover.',NULL,NULL,'image',NULL,NULL),(3,1,'Effortless Menu Management','Easily add, edit, or remove items from your menu on the go. Highlight specials, update prices, and keep everything in sync across all platforms, so your staff and customers always see the latest offerings.',NULL,NULL,'image',NULL,NULL),(4,1,'QR Code Menu','Contactless Ordering Made Easy','<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"16\" height=\"16\" fill=\"currentColor\"\n                            class=\"bi bi-qr-code-scan text-skin-base dark:text-skin-base size-6\" viewBox=\"0 0 16 16\">\n                            <path\n                                d=\"M0 .5A.5.5 0 0 1 .5 0h3a.5.5 0 0 1 0 1H1v2.5a.5.5 0 0 1-1 0zm12 0a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-1 0V1h-2.5a.5.5 0 0 1-.5-.5M.5 12a.5.5 0 0 1 .5.5V15h2.5a.5.5 0 0 1 0 1h-3a.5.5 0 0 1-.5-.5v-3a.5.5 0 0 1 .5-.5m15 0a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1 0-1H15v-2.5a.5.5 0 0 1 .5-.5M4 4h1v1H4z\" />\n                            <path d=\"M7 2H2v5h5zM3 3h3v3H3zm2 8H4v1h1z\" />\n                            <path d=\"M7 9H2v5h5zm-4 1h3v3H3zm8-6h1v1h-1z\" />\n                            <path\n                                d=\"M9 2h5v5H9zm1 1v3h3V3zM8 8v2h1v1H8v1h2v-2h1v2h1v-1h2v-1h-3V8zm2 2H9V9h1zm4 2h-1v1h-2v1h3zm-4 2v-1H8v1z\" />\n                            <path d=\"M12 9h2V8h-2z\" />\n                        </svg>','bi-qr-code','icon',NULL,NULL),(5,1,'Payment Gateway Integration','Fast, Secure, and Flexible Payments using Stripe and Razorpay','<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"16\" height=\"16\" fill=\"currentColor\"\n                        class=\"bi bi-qr-code-scan text-skin-base dark:text-skin-base size-6\" viewBox=\"0 0 16 16\">\n                        <path\n                            d=\"M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm6.226 5.385c-.584 0-.937.164-.937.593 0 .468.607.674 1.36.93 1.228.415 2.844.963 2.851 2.993C11.5 11.868 9.924 13 7.63 13a7.7 7.7 0 0 1-3.009-.626V9.758c.926.506 2.095.88 3.01.88.617 0 1.058-.165 1.058-.671 0-.518-.658-.755-1.453-1.041C6.026 8.49 4.5 7.94 4.5 6.11 4.5 4.165 5.988 3 8.226 3a7.3 7.3 0 0 1 2.734.505v2.583c-.838-.45-1.896-.703-2.734-.703\" />\n                    </svg>','bi-credit-card','icon',NULL,NULL),(6,1,'Staff Management','Separate login for every staff role with different permissions.','<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"16\" height=\"16\" fill=\"currentColor\"\n                        class=\"bi bi-qr-code-scan text-skin-base dark:text-skin-base size-6\" viewBox=\"0 0 16 16\">\n                        <path\n                            d=\"M15 14s1 0 1-1-1-4-5-4-5 3-5 4 1 1 1 1zm-7.978-1L7 12.996c.001-.264.167-1.03.76-1.72C8.312 10.629 9.282 10 11 10c1.717 0 2.687.63 3.24 1.276.593.69.758 1.457.76 1.72l-.008.002-.014.002zM11 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4m3-2a3 3 0 1 1-6 0 3 3 0 0 1 6 0M6.936 9.28a6 6 0 0 0-1.23-.247A7 7 0 0 0 5 9c-4 0-5 3-5 4q0 1 1 1h4.216A2.24 2.24 0 0 1 5 13c0-1.01.377-2.042 1.09-2.904.243-.294.526-.569.846-.816M4.92 10A5.5 5.5 0 0 0 4 13H1c0-.26.164-1.03.76-1.724.545-.636 1.492-1.256 3.16-1.275ZM1.5 5.5a3 3 0 1 1 6 0 3 3 0 0 1-6 0m3-2a2 2 0 1 0 0 4 2 2 0 0 0 0-4\" />\n                    </svg>','bi-people','icon',NULL,NULL),(7,1,'POS (Point of Sale)','Complete POS Integration','<svg class=\"size-6 transition duration-75 text-skin-base dark:text-skin-base\" fill=\"currentColor\"\n                        viewBox=\"0 -0.5 25 25\" viewBox=\"0 0 24 24\" xmlns=\"http://www.w3.org/2000/svg\">\n                        <g id=\"SVGRepo_bgCarrier\" stroke-width=\"0\"></g>\n                        <g id=\"SVGRepo_tracerCarrier\" stroke-linecap=\"round\" stroke-linejoin=\"round\"></g>\n                        <g id=\"SVGRepo_iconCarrier\">\n                            <path fill-rule=\"evenodd\"\n                                d=\"M16,6 L20,6 C21.1045695,6 22,6.8954305 22,8 L22,16 C22,17.1045695 21.1045695,18 20,18 L16,18 L16,19.9411765 C16,21.0658573 15.1177541,22 14,22 L4,22 C2.88224586,22 2,21.0658573 2,19.9411765 L2,4.05882353 C2,2.93414267 2.88224586,2 4,2 L14,2 C15.1177541,2 16,2.93414267 16,4.05882353 L16,6 Z M20,11 L16,11 L16,16 L20,16 L20,11 Z M14,19.9411765 L14,4.05882353 C14,4.01396021 13.9868154,4 14,4 L4,4 C4.01318464,4 4,4.01396021 4,4.05882353 L4,19.9411765 C4,19.9860398 4.01318464,20 4,20 L14,20 C13.9868154,20 14,19.9860398 14,19.9411765 Z M5,19 L5,17 L7,17 L7,19 L5,19 Z M8,19 L8,17 L10,17 L10,19 L8,19 Z M11,19 L11,17 L13,17 L13,19 L11,19 Z M5,16 L5,14 L7,14 L7,16 L5,16 Z M8,16 L8,14 L10,14 L10,16 L8,16 Z M11,16 L11,14 L13,14 L13,16 L11,16 Z M13,5 L13,13 L5,13 L5,5 L13,5 Z M7,7 L7,11 L11,11 L11,7 L7,7 Z M20,9 L20,8 L16,8 L16,9 L20,9 Z\">\n                            </path>\n                        </g>\n                    </svg>','bi-pos','icon',NULL,NULL),(8,1,'Custom Floor Plans','Design Your Restaurants Layout.','<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"16\" height=\"16\" fill=\"currentColor\"\n                        class=\"bi bi-qr-code-scan text-skin-base dark:text-skin-base size-6\" viewBox=\"0 0 16 16\">\n                        <path\n                            d=\"M8.235 1.559a.5.5 0 0 0-.47 0l-7.5 4a.5.5 0 0 0 0 .882L3.188 8 .264 9.559a.5.5 0 0 0 0 .882l7.5 4a.5.5 0 0 0 .47 0l7.5-4a.5.5 0 0 0 0-.882L12.813 8l2.922-1.559a.5.5 0 0 0 0-.882zm3.515 7.008L14.438 10 8 13.433 1.562 10 4.25 8.567l3.515 1.874a.5.5 0 0 0 .47 0zM8 9.433 1.562 6 8 2.567 14.438 6z\" />\n                    </svg>','bi-grid-3x3-gap','icon',NULL,NULL),(9,1,'Kitchen Order Tickets (KOT)','Efficient Kitchen Workflow.','<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"16\" height=\"16\" fill=\"currentColor\"\n                        class=\"bi bi-qr-code-scan text-skin-base dark:text-skin-base size-6\" viewBox=\"0 0 16 16\">\n                        <path\n                            d=\"M3 4.5a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5M11.5 4a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1zm0 2a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1zm0 2a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1zm0 2a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1zm0 2a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1z\" />\n                        <path\n                            d=\"M2.354.646a.5.5 0 0 0-.801.13l-.5 1A.5.5 0 0 0 1 2v13H.5a.5.5 0 0 0 0 1h15a.5.5 0 0 0 0-1H15V2a.5.5 0 0 0-.053-.224l-.5-1a.5.5 0 0 0-.8-.13L13 1.293l-.646-.647a.5.5 0 0 0-.708 0L11 1.293l-.646-.647a.5.5 0 0 0-.708 0L9 1.293 8.354.646a.5.5 0 0 0-.708 0L7 1.293 6.354.646a.5.5 0 0 0-.708 0L5 1.293 4.354.646a.5.5 0 0 0-.708 0L3 1.293zm-.217 1.198.51.51a.5.5 0 0 0 .707 0L4 1.707l.646.647a.5.5 0 0 0 .708 0L6 1.707l.646.647a.5.5 0 0 0 .708 0L8 1.707l.646.647a.5.5 0 0 0 .708 0L10 1.707l.646.647a.5.5 0 0 0 .708 0L12 1.707l.646.647a.5.5 0 0 0 .708 0l.509-.51.137.274V15H2V2.118z\" />\n                    </svg>','bi-receipt','icon',NULL,NULL),(10,1,'Bill Printing','Quick and Accurate Billing.','<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"16\" height=\"16\" fill=\"currentColor\"\n                        class=\"bi bi-qr-code-scan text-skin-base dark:text-skin-base size-6\" viewBox=\"0 0 16 16\">\n                        <path d=\"M2.5 8a.5.5 0 1 0 0-1 .5.5 0 0 0 0 1\" />\n                        <path\n                            d=\"M5 1a2 2 0 0 0-2 2v2H2a2 2 0 0 0-2 2v3a2 2 0 0 0 2 2h1v1a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2v-1h1a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-1V3a2 2 0 0 0-2-2zM4 3a1 1 0 0 1 1-1h6a1 1 0 0 1 1 1v2H4zm1 5a2 2 0 0 0-2 2v1H2a1 1 0 0 1-1-1V7a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-1v-1a2 2 0 0 0-2-2zm7 2v3a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1v-3a1 1 0 0 1 1-1h6a1 1 0 0 1 1 1\" />\n                    </svg>','bi-printer','icon',NULL,NULL),(11,1,'Reports','Data-Driven Decisions.','<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"16\" height=\"16\" fill=\"currentColor\" class=\"bi bi-qr-code-scan text-skin-base dark:text-skin-base size-6\" viewBox=\"0 0 16 16\">\n                    <path fill-rule=\"evenodd\" d=\"M0 0h1v15h15v1H0zm10 3.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-1 0V4.9l-3.613 4.417a.5.5 0 0 1-.74.037L7.06 6.767l-3.656 5.027a.5.5 0 0 1-.808-.588l4-5.5a.5.5 0 0 1 .758-.06l2.609 2.61L13.445 4H10.5a.5.5 0 0 1-.5-.5\"></path>\n                    </svg>','bi-arrow-right-circle-fill','icon',NULL,NULL);
/*!40000 ALTER TABLE `front_features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `front_review_settings`
--

DROP TABLE IF EXISTS `front_review_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `front_review_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `language_setting_id` bigint unsigned DEFAULT NULL,
  `reviews` text COLLATE utf8mb4_unicode_ci,
  `reviewer_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reviewer_designation` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `front_review_settings_language_setting_id_foreign` (`language_setting_id`),
  CONSTRAINT `front_review_settings_language_setting_id_foreign` FOREIGN KEY (`language_setting_id`) REFERENCES `language_settings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `front_review_settings`
--

LOCK TABLES `front_review_settings` WRITE;
/*!40000 ALTER TABLE `front_review_settings` DISABLE KEYS */;
INSERT INTO `front_review_settings` VALUES (1,1,'\" It has completely transformed how we operate. Managing orders, tables, and staff all from one platform has reduced our workload and made everything run more smoothly. \"','John Martin','Owner of Riverbend Bistro',NULL,NULL),(2,1,'\" The QR Code menu and payment integration have made a huge difference for us, especially after the pandemic. Customers love the ease, and we’ve seen faster table turnover.\"','Emily Thompson','Manager at Lakeside Grill',NULL,NULL),(3,1,'\" We are able to track every order in real time, keep our menu updated, and quickly manage payments. It is like having an extra set of hands in the restaurant.\"','Michael Scott','Owner of Downtown Eats',NULL,NULL);
/*!40000 ALTER TABLE `front_review_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `global_currencies`
--

DROP TABLE IF EXISTS `global_currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `global_currencies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `currency_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_symbol` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exchange_rate` decimal(16,2) DEFAULT NULL,
  `usd_price` decimal(16,2) DEFAULT NULL,
  `is_cryptocurrency` enum('yes','no') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'no',
  `currency_position` enum('left','right','left_with_space','right_with_space') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'left',
  `no_of_decimal` int unsigned NOT NULL DEFAULT '2',
  `thousand_separator` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `decimal_separator` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('enable','disable') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'enable',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `global_currencies`
--

LOCK TABLES `global_currencies` WRITE;
/*!40000 ALTER TABLE `global_currencies` DISABLE KEYS */;
INSERT INTO `global_currencies` VALUES (1,'Dollars','$','USD',NULL,NULL,'no','left',2,',','.','enable','2025-11-30 02:55:46','2025-11-30 02:55:46',NULL),(2,'Rupee','₹','INR',NULL,NULL,'no','left',2,',','.','enable','2025-11-30 02:55:46','2025-11-30 02:55:46',NULL),(3,'Pounds','£','GBP',NULL,NULL,'no','left',2,',','.','enable','2025-11-30 02:55:46','2025-11-30 02:55:46',NULL),(4,'Euros','€','EUR',NULL,NULL,'no','left',2,',','.','enable','2025-11-30 02:55:46','2025-11-30 02:55:46',NULL);
/*!40000 ALTER TABLE `global_currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `global_invoices`
--

DROP TABLE IF EXISTS `global_invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `global_invoices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `currency_id` bigint unsigned DEFAULT NULL,
  `package_id` bigint unsigned DEFAULT NULL,
  `global_subscription_id` bigint unsigned DEFAULT NULL,
  `offline_method_id` bigint unsigned DEFAULT NULL,
  `signature` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `package_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_total` int DEFAULT NULL,
  `total` int DEFAULT NULL,
  `billing_frequency` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_interval` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurring` enum('yes','no') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plan_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `stripe_invoice_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pay_date` datetime DEFAULT NULL,
  `next_pay_date` datetime DEFAULT NULL,
  `gateway_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `m_payment_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pf_payment_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payfast_plan` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `global_invoices_restaurant_id_foreign` (`restaurant_id`),
  KEY `global_invoices_currency_id_foreign` (`currency_id`),
  KEY `global_invoices_package_id_foreign` (`package_id`),
  KEY `global_invoices_global_subscription_id_foreign` (`global_subscription_id`),
  KEY `global_invoices_offline_method_id_foreign` (`offline_method_id`),
  CONSTRAINT `global_invoices_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `global_currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `global_invoices_global_subscription_id_foreign` FOREIGN KEY (`global_subscription_id`) REFERENCES `global_subscriptions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `global_invoices_offline_method_id_foreign` FOREIGN KEY (`offline_method_id`) REFERENCES `offline_payment_methods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `global_invoices_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `global_invoices_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `global_invoices`
--

LOCK TABLES `global_invoices` WRITE;
/*!40000 ALTER TABLE `global_invoices` DISABLE KEYS */;
INSERT INTO `global_invoices` VALUES (1,1,1,5,1,NULL,NULL,NULL,'NIPOS59KNMSUXZI',NULL,NULL,'trial',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-11-30 08:27:23','2025-12-30 08:27:23','offline','active','2025-11-30 02:57:23','2025-11-30 02:57:23',NULL,NULL,NULL),(2,2,1,5,2,NULL,NULL,NULL,'N7MYZHIYTQ33SQO',NULL,NULL,'trial',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-11-30 08:29:33','2025-12-30 08:29:33','offline','active','2025-11-30 02:59:34','2025-11-30 02:59:34',NULL,NULL,NULL),(3,3,1,5,3,NULL,NULL,NULL,'KMILH2R32MSK8LF',NULL,NULL,'trial',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-11-30 08:29:54','2025-12-30 08:29:54','offline','active','2025-11-30 02:59:54','2025-11-30 02:59:54',NULL,NULL,NULL),(4,4,1,5,4,NULL,NULL,NULL,'ZSHIGEUG4FZKMGQ',NULL,NULL,'trial',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-11-30 08:30:19','2025-12-30 08:30:19','offline','active','2025-11-30 03:00:19','2025-11-30 03:00:19',NULL,NULL,NULL);
/*!40000 ALTER TABLE `global_invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `global_settings`
--

DROP TABLE IF EXISTS `global_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `global_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `purchase_code` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supported_until` timestamp NULL DEFAULT NULL,
  `last_license_verified_at` timestamp NULL DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `privacy_policy_link` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_privacy_consent_checkbox` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme_hex` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme_rgb` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `locale` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `license_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hide_cron_job` tinyint(1) NOT NULL DEFAULT '0',
  `last_cron_run` timestamp NULL DEFAULT NULL,
  `system_update` tinyint(1) NOT NULL DEFAULT '1',
  `purchased_on` timestamp NULL DEFAULT NULL,
  `timezone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'Asia/Kolkata',
  `disable_landing_site` tinyint(1) NOT NULL DEFAULT '0',
  `landing_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'dynamic',
  `landing_site_type` enum('theme','custom') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'theme',
  `landing_site_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `installed_url` tinytext COLLATE utf8mb4_unicode_ci,
  `requires_approval_after_signup` tinyint(1) NOT NULL DEFAULT '0',
  `facebook_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instagram_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twitter_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `yelp_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_currency_id` bigint unsigned DEFAULT NULL,
  `show_logo_text` tinyint(1) NOT NULL DEFAULT '1',
  `meta_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keyword` text COLLATE utf8mb4_unicode_ci,
  `meta_description` longtext COLLATE utf8mb4_unicode_ci,
  `upload_fav_icon_android_chrome_192` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upload_fav_icon_android_chrome_512` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upload_fav_icon_apple_touch_icon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upload_favicon_16` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upload_favicon_32` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `favicon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hash` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `webmanifest` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_pwa_install_alert_show` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `google_map_api_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `session_driver` enum('file','database') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'database',
  `enable_stripe` tinyint(1) NOT NULL DEFAULT '1',
  `enable_razorpay` tinyint(1) NOT NULL DEFAULT '1',
  `enable_flutterwave` tinyint(1) NOT NULL DEFAULT '1',
  `enable_payfast` tinyint(1) NOT NULL DEFAULT '1',
  `enable_paypal` tinyint(1) NOT NULL DEFAULT '1',
  `enable_paystack` tinyint(1) NOT NULL DEFAULT '1',
  `enable_xendit` tinyint(1) NOT NULL DEFAULT '1',
  `enable_paddle` tinyint(1) NOT NULL DEFAULT '1',
  `enable_epay` tinyint(1) NOT NULL DEFAULT '1',
  `total_vonage_count` int NOT NULL DEFAULT '0',
  `total_msg91_count` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `global_settings_default_currency_id_foreign` (`default_currency_id`),
  CONSTRAINT `global_settings_default_currency_id_foreign` FOREIGN KEY (`default_currency_id`) REFERENCES `global_currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `global_settings`
--

LOCK TABLES `global_settings` WRITE;
/*!40000 ALTER TABLE `global_settings` DISABLE KEYS */;
INSERT INTO `global_settings` VALUES (1,NULL,NULL,NULL,NULL,NULL,0,'2025-11-30 02:57:22','2025-11-30 02:57:22','TableTrack',NULL,'#A78BFA','167, 139, 250','en',NULL,0,NULL,1,NULL,'Asia/Kolkata',0,'dynamic','theme',NULL,'http://localhost',0,'https://www.facebook.com/','https://www.instagram.com/','https://www.twitter.com/',NULL,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'95eb110aa52ff4f563ed6e77c411949a',NULL,'0',NULL,'database',1,1,1,1,1,1,1,1,1,0,0),(2,NULL,NULL,NULL,NULL,NULL,0,'2025-11-30 02:58:53','2025-11-30 02:58:53','TableTrack',NULL,'#A78BFA','167, 139, 250','en',NULL,0,NULL,1,NULL,'Asia/Kolkata',0,'dynamic','theme',NULL,'http://localhost',0,'https://www.facebook.com/','https://www.instagram.com/','https://www.twitter.com/',NULL,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'7174f019154a3f02b8741ea14b3dfe0b',NULL,'0',NULL,'database',1,1,1,1,1,1,1,1,1,0,0),(3,NULL,NULL,NULL,NULL,NULL,0,'2025-11-30 02:59:10','2025-11-30 02:59:10','TableTrack',NULL,'#A78BFA','167, 139, 250','en',NULL,0,NULL,1,NULL,'Asia/Kolkata',0,'dynamic','theme',NULL,'http://localhost',0,'https://www.facebook.com/','https://www.instagram.com/','https://www.twitter.com/',NULL,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'00c59dcef7600fa0018bf42ede222936',NULL,'0',NULL,'database',1,1,1,1,1,1,1,1,1,0,0),(4,NULL,NULL,NULL,NULL,NULL,0,'2025-11-30 02:59:31','2025-11-30 02:59:31','TableTrack',NULL,'#A78BFA','167, 139, 250','en',NULL,0,NULL,1,NULL,'Asia/Kolkata',0,'dynamic','theme',NULL,'http://localhost',0,'https://www.facebook.com/','https://www.instagram.com/','https://www.twitter.com/',NULL,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ffd0da97492d38c74017db77dbaf5f33',NULL,'0',NULL,'database',1,1,1,1,1,1,1,1,1,0,0),(5,NULL,NULL,NULL,NULL,NULL,0,'2025-11-30 02:59:52','2025-11-30 02:59:52','TableTrack',NULL,'#A78BFA','167, 139, 250','en',NULL,0,NULL,1,NULL,'Asia/Kolkata',0,'dynamic','theme',NULL,'http://localhost',0,'https://www.facebook.com/','https://www.instagram.com/','https://www.twitter.com/',NULL,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'6f65fad160c29f84dae9940f0f14abc6',NULL,'0',NULL,'database',1,1,1,1,1,1,1,1,1,0,0),(6,NULL,NULL,NULL,NULL,NULL,0,'2025-11-30 03:00:16','2025-11-30 03:00:16','TableTrack',NULL,'#A78BFA','167, 139, 250','en',NULL,0,NULL,1,NULL,'Asia/Kolkata',0,'dynamic','theme',NULL,'http://localhost',0,'https://www.facebook.com/','https://www.instagram.com/','https://www.twitter.com/',NULL,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'e20ac2a2910b11361d6e8ad54d2093a6',NULL,'0',NULL,'database',1,1,1,1,1,1,1,1,1,0,0);
/*!40000 ALTER TABLE `global_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `global_subscriptions`
--

DROP TABLE IF EXISTS `global_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `global_subscriptions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `package_id` bigint unsigned DEFAULT NULL,
  `currency_id` bigint unsigned DEFAULT NULL,
  `package_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plan_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razorpay_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razorpay_plan` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_price` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trial_ends_at` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_status` enum('active','inactive') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `subscribed_on_date` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `subscription_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flutterwave_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flutterwave_payment_ref` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flutterwave_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flutterwave_customer_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payfast_plan` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payfast_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `global_subscriptions_restaurant_id_foreign` (`restaurant_id`),
  KEY `global_subscriptions_package_id_foreign` (`package_id`),
  KEY `global_subscriptions_currency_id_foreign` (`currency_id`),
  CONSTRAINT `global_subscriptions_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `global_currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `global_subscriptions_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `global_subscriptions_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `global_subscriptions`
--

LOCK TABLES `global_subscriptions` WRITE;
/*!40000 ALTER TABLE `global_subscriptions` DISABLE KEYS */;
INSERT INTO `global_subscriptions` VALUES (1,1,5,1,'trial',NULL,'NIPOS59KNMSUXZI',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'offline','2025-12-30 08:27:23','active','2025-12-30 08:27:23','2025-11-30 08:27:23','2025-11-30 02:57:23','2025-11-30 02:57:23',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,2,5,1,'trial',NULL,'N7MYZHIYTQ33SQO',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'offline','2025-12-30 08:29:33','active','2025-12-30 08:29:33','2025-11-30 08:29:33','2025-11-30 02:59:34','2025-11-30 02:59:34',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,3,5,1,'trial',NULL,'KMILH2R32MSK8LF',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'offline','2025-12-30 08:29:54','active','2025-12-30 08:29:54','2025-11-30 08:29:54','2025-11-30 02:59:54','2025-11-30 02:59:54',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,4,5,1,'trial',NULL,'ZSHIGEUG4FZKMGQ',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'offline','2025-12-30 08:30:19','active','2025-12-30 08:30:19','2025-11-30 08:30:19','2025-11-30 03:00:19','2025-11-30 03:00:19',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `global_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_global_settings`
--

DROP TABLE IF EXISTS `inventory_global_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_global_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `license_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchased_on` timestamp NULL DEFAULT NULL,
  `supported_until` timestamp NULL DEFAULT NULL,
  `notify_update` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_global_settings`
--

LOCK TABLES `inventory_global_settings` WRITE;
/*!40000 ALTER TABLE `inventory_global_settings` DISABLE KEYS */;
INSERT INTO `inventory_global_settings` VALUES (1,NULL,NULL,NULL,NULL,1,'2025-11-30 04:19:27','2025-11-30 04:19:27');
/*!40000 ALTER TABLE `inventory_global_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_item_categories`
--

DROP TABLE IF EXISTS `inventory_item_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_item_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inventory_item_categories_branch_id_foreign` (`branch_id`),
  CONSTRAINT `inventory_item_categories_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_item_categories`
--

LOCK TABLES `inventory_item_categories` WRITE;
/*!40000 ALTER TABLE `inventory_item_categories` DISABLE KEYS */;
INSERT INTO `inventory_item_categories` VALUES (1,1,'Meat & Poultry','2025-11-30 04:19:30','2025-11-30 04:19:30'),(2,1,'Seafood','2025-11-30 04:19:30','2025-11-30 04:19:30'),(3,1,'Dairy & Eggs','2025-11-30 04:19:30','2025-11-30 04:19:30'),(4,1,'Fresh Produce','2025-11-30 04:19:30','2025-11-30 04:19:30'),(5,1,'Herbs & Spices','2025-11-30 04:19:30','2025-11-30 04:19:30'),(6,1,'Dry Goods','2025-11-30 04:19:30','2025-11-30 04:19:30'),(7,1,'Canned Goods','2025-11-30 04:19:30','2025-11-30 04:19:30'),(8,1,'Beverages','2025-11-30 04:19:30','2025-11-30 04:19:30'),(9,1,'Condiments & Sauces','2025-11-30 04:19:30','2025-11-30 04:19:30'),(10,1,'Baking Supplies','2025-11-30 04:19:30','2025-11-30 04:19:30'),(11,1,'Oils & Vinegars','2025-11-30 04:19:30','2025-11-30 04:19:30'),(12,1,'Frozen Foods','2025-11-30 04:19:30','2025-11-30 04:19:30'),(13,1,'Cleaning Supplies','2025-11-30 04:19:30','2025-11-30 04:19:30'),(14,1,'Kitchen Equipment','2025-11-30 04:19:30','2025-11-30 04:19:30'),(15,1,'Disposables','2025-11-30 04:19:30','2025-11-30 04:19:30'),(16,2,'Meat & Poultry','2025-11-30 04:19:30','2025-11-30 04:19:30'),(17,2,'Seafood','2025-11-30 04:19:30','2025-11-30 04:19:30'),(18,2,'Dairy & Eggs','2025-11-30 04:19:30','2025-11-30 04:19:30'),(19,2,'Fresh Produce','2025-11-30 04:19:30','2025-11-30 04:19:30'),(20,2,'Herbs & Spices','2025-11-30 04:19:30','2025-11-30 04:19:30'),(21,2,'Dry Goods','2025-11-30 04:19:30','2025-11-30 04:19:30'),(22,2,'Canned Goods','2025-11-30 04:19:30','2025-11-30 04:19:30'),(23,2,'Beverages','2025-11-30 04:19:30','2025-11-30 04:19:30'),(24,2,'Condiments & Sauces','2025-11-30 04:19:30','2025-11-30 04:19:30'),(25,2,'Baking Supplies','2025-11-30 04:19:30','2025-11-30 04:19:30'),(26,2,'Oils & Vinegars','2025-11-30 04:19:30','2025-11-30 04:19:30'),(27,2,'Frozen Foods','2025-11-30 04:19:30','2025-11-30 04:19:30'),(28,2,'Cleaning Supplies','2025-11-30 04:19:30','2025-11-30 04:19:30'),(29,2,'Kitchen Equipment','2025-11-30 04:19:30','2025-11-30 04:19:30'),(30,2,'Disposables','2025-11-30 04:19:30','2025-11-30 04:19:30'),(31,3,'Meat & Poultry','2025-11-30 04:19:30','2025-11-30 04:19:30'),(32,3,'Seafood','2025-11-30 04:19:30','2025-11-30 04:19:30'),(33,3,'Dairy & Eggs','2025-11-30 04:19:30','2025-11-30 04:19:30'),(34,3,'Fresh Produce','2025-11-30 04:19:30','2025-11-30 04:19:30'),(35,3,'Herbs & Spices','2025-11-30 04:19:30','2025-11-30 04:19:30'),(36,3,'Dry Goods','2025-11-30 04:19:30','2025-11-30 04:19:30'),(37,3,'Canned Goods','2025-11-30 04:19:30','2025-11-30 04:19:30'),(38,3,'Beverages','2025-11-30 04:19:30','2025-11-30 04:19:30'),(39,3,'Condiments & Sauces','2025-11-30 04:19:30','2025-11-30 04:19:30'),(40,3,'Baking Supplies','2025-11-30 04:19:30','2025-11-30 04:19:30'),(41,3,'Oils & Vinegars','2025-11-30 04:19:30','2025-11-30 04:19:30'),(42,3,'Frozen Foods','2025-11-30 04:19:30','2025-11-30 04:19:30'),(43,3,'Cleaning Supplies','2025-11-30 04:19:30','2025-11-30 04:19:30'),(44,3,'Kitchen Equipment','2025-11-30 04:19:30','2025-11-30 04:19:30'),(45,3,'Disposables','2025-11-30 04:19:30','2025-11-30 04:19:30'),(46,4,'Meat & Poultry','2025-11-30 04:19:30','2025-11-30 04:19:30'),(47,4,'Seafood','2025-11-30 04:19:30','2025-11-30 04:19:30'),(48,4,'Dairy & Eggs','2025-11-30 04:19:30','2025-11-30 04:19:30'),(49,4,'Fresh Produce','2025-11-30 04:19:30','2025-11-30 04:19:30'),(50,4,'Herbs & Spices','2025-11-30 04:19:30','2025-11-30 04:19:30'),(51,4,'Dry Goods','2025-11-30 04:19:30','2025-11-30 04:19:30'),(52,4,'Canned Goods','2025-11-30 04:19:30','2025-11-30 04:19:30'),(53,4,'Beverages','2025-11-30 04:19:30','2025-11-30 04:19:30'),(54,4,'Condiments & Sauces','2025-11-30 04:19:31','2025-11-30 04:19:31'),(55,4,'Baking Supplies','2025-11-30 04:19:31','2025-11-30 04:19:31'),(56,4,'Oils & Vinegars','2025-11-30 04:19:31','2025-11-30 04:19:31'),(57,4,'Frozen Foods','2025-11-30 04:19:31','2025-11-30 04:19:31'),(58,4,'Cleaning Supplies','2025-11-30 04:19:31','2025-11-30 04:19:31'),(59,4,'Kitchen Equipment','2025-11-30 04:19:31','2025-11-30 04:19:31'),(60,4,'Disposables','2025-11-30 04:19:31','2025-11-30 04:19:31'),(61,5,'Meat & Poultry','2025-11-30 04:19:31','2025-11-30 04:19:31'),(62,5,'Seafood','2025-11-30 04:19:31','2025-11-30 04:19:31'),(63,5,'Dairy & Eggs','2025-11-30 04:19:31','2025-11-30 04:19:31'),(64,5,'Fresh Produce','2025-11-30 04:19:31','2025-11-30 04:19:31'),(65,5,'Herbs & Spices','2025-11-30 04:19:31','2025-11-30 04:19:31'),(66,5,'Dry Goods','2025-11-30 04:19:31','2025-11-30 04:19:31'),(67,5,'Canned Goods','2025-11-30 04:19:31','2025-11-30 04:19:31'),(68,5,'Beverages','2025-11-30 04:19:31','2025-11-30 04:19:31'),(69,5,'Condiments & Sauces','2025-11-30 04:19:31','2025-11-30 04:19:31'),(70,5,'Baking Supplies','2025-11-30 04:19:31','2025-11-30 04:19:31'),(71,5,'Oils & Vinegars','2025-11-30 04:19:31','2025-11-30 04:19:31'),(72,5,'Frozen Foods','2025-11-30 04:19:31','2025-11-30 04:19:31'),(73,5,'Cleaning Supplies','2025-11-30 04:19:31','2025-11-30 04:19:31'),(74,5,'Kitchen Equipment','2025-11-30 04:19:31','2025-11-30 04:19:31'),(75,5,'Disposables','2025-11-30 04:19:31','2025-11-30 04:19:31'),(76,6,'Meat & Poultry','2025-11-30 04:19:31','2025-11-30 04:19:31'),(77,6,'Seafood','2025-11-30 04:19:31','2025-11-30 04:19:31'),(78,6,'Dairy & Eggs','2025-11-30 04:19:31','2025-11-30 04:19:31'),(79,6,'Fresh Produce','2025-11-30 04:19:31','2025-11-30 04:19:31'),(80,6,'Herbs & Spices','2025-11-30 04:19:31','2025-11-30 04:19:31'),(81,6,'Dry Goods','2025-11-30 04:19:31','2025-11-30 04:19:31'),(82,6,'Canned Goods','2025-11-30 04:19:31','2025-11-30 04:19:31'),(83,6,'Beverages','2025-11-30 04:19:31','2025-11-30 04:19:31'),(84,6,'Condiments & Sauces','2025-11-30 04:19:31','2025-11-30 04:19:31'),(85,6,'Baking Supplies','2025-11-30 04:19:31','2025-11-30 04:19:31'),(86,6,'Oils & Vinegars','2025-11-30 04:19:31','2025-11-30 04:19:31'),(87,6,'Frozen Foods','2025-11-30 04:19:31','2025-11-30 04:19:31'),(88,6,'Cleaning Supplies','2025-11-30 04:19:31','2025-11-30 04:19:31'),(89,6,'Kitchen Equipment','2025-11-30 04:19:31','2025-11-30 04:19:31'),(90,6,'Disposables','2025-11-30 04:19:31','2025-11-30 04:19:31'),(91,7,'Meat & Poultry','2025-11-30 04:19:31','2025-11-30 04:19:31'),(92,7,'Seafood','2025-11-30 04:19:31','2025-11-30 04:19:31'),(93,7,'Dairy & Eggs','2025-11-30 04:19:31','2025-11-30 04:19:31'),(94,7,'Fresh Produce','2025-11-30 04:19:31','2025-11-30 04:19:31'),(95,7,'Herbs & Spices','2025-11-30 04:19:31','2025-11-30 04:19:31'),(96,7,'Dry Goods','2025-11-30 04:19:31','2025-11-30 04:19:31'),(97,7,'Canned Goods','2025-11-30 04:19:31','2025-11-30 04:19:31'),(98,7,'Beverages','2025-11-30 04:19:31','2025-11-30 04:19:31'),(99,7,'Condiments & Sauces','2025-11-30 04:19:31','2025-11-30 04:19:31'),(100,7,'Baking Supplies','2025-11-30 04:19:31','2025-11-30 04:19:31'),(101,7,'Oils & Vinegars','2025-11-30 04:19:31','2025-11-30 04:19:31'),(102,7,'Frozen Foods','2025-11-30 04:19:31','2025-11-30 04:19:31'),(103,7,'Cleaning Supplies','2025-11-30 04:19:31','2025-11-30 04:19:31'),(104,7,'Kitchen Equipment','2025-11-30 04:19:31','2025-11-30 04:19:31'),(105,7,'Disposables','2025-11-30 04:19:31','2025-11-30 04:19:31'),(106,8,'Meat & Poultry','2025-11-30 04:19:31','2025-11-30 04:19:31'),(107,8,'Seafood','2025-11-30 04:19:31','2025-11-30 04:19:31'),(108,8,'Dairy & Eggs','2025-11-30 04:19:31','2025-11-30 04:19:31'),(109,8,'Fresh Produce','2025-11-30 04:19:31','2025-11-30 04:19:31'),(110,8,'Herbs & Spices','2025-11-30 04:19:31','2025-11-30 04:19:31'),(111,8,'Dry Goods','2025-11-30 04:19:31','2025-11-30 04:19:31'),(112,8,'Canned Goods','2025-11-30 04:19:31','2025-11-30 04:19:31'),(113,8,'Beverages','2025-11-30 04:19:31','2025-11-30 04:19:31'),(114,8,'Condiments & Sauces','2025-11-30 04:19:31','2025-11-30 04:19:31'),(115,8,'Baking Supplies','2025-11-30 04:19:31','2025-11-30 04:19:31'),(116,8,'Oils & Vinegars','2025-11-30 04:19:31','2025-11-30 04:19:31'),(117,8,'Frozen Foods','2025-11-30 04:19:31','2025-11-30 04:19:31'),(118,8,'Cleaning Supplies','2025-11-30 04:19:31','2025-11-30 04:19:31'),(119,8,'Kitchen Equipment','2025-11-30 04:19:31','2025-11-30 04:19:31'),(120,8,'Disposables','2025-11-30 04:19:31','2025-11-30 04:19:31');
/*!40000 ALTER TABLE `inventory_item_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_items`
--

DROP TABLE IF EXISTS `inventory_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `inventory_item_category_id` bigint unsigned NOT NULL,
  `unit_id` bigint unsigned NOT NULL,
  `threshold_quantity` decimal(16,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `preferred_supplier_id` bigint unsigned DEFAULT NULL,
  `reorder_quantity` decimal(16,2) NOT NULL DEFAULT '0.00',
  `unit_purchase_price` decimal(16,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `inventory_items_branch_id_foreign` (`branch_id`),
  KEY `inventory_items_inventory_item_category_id_foreign` (`inventory_item_category_id`),
  KEY `inventory_items_unit_id_foreign` (`unit_id`),
  KEY `inventory_items_preferred_supplier_id_foreign` (`preferred_supplier_id`),
  CONSTRAINT `inventory_items_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inventory_items_inventory_item_category_id_foreign` FOREIGN KEY (`inventory_item_category_id`) REFERENCES `inventory_item_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inventory_items_preferred_supplier_id_foreign` FOREIGN KEY (`preferred_supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `inventory_items_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_items`
--

LOCK TABLES `inventory_items` WRITE;
/*!40000 ALTER TABLE `inventory_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_movements`
--

DROP TABLE IF EXISTS `inventory_movements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_movements` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned NOT NULL,
  `inventory_item_id` bigint unsigned NOT NULL,
  `quantity` decimal(16,2) NOT NULL DEFAULT '0.00',
  `transaction_type` enum('in','out','waste','transfer') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'in',
  `waste_reason` enum('expiry','spoilage','customer_complaint','over_preparation','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `added_by` bigint unsigned DEFAULT NULL,
  `supplier_id` bigint unsigned DEFAULT NULL,
  `transfer_branch_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `unit_purchase_price` decimal(16,2) NOT NULL DEFAULT '0.00',
  `expiration_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inventory_movements_branch_id_foreign` (`branch_id`),
  KEY `inventory_movements_inventory_item_id_foreign` (`inventory_item_id`),
  KEY `inventory_movements_added_by_foreign` (`added_by`),
  KEY `inventory_movements_supplier_id_foreign` (`supplier_id`),
  KEY `inventory_movements_transfer_branch_id_foreign` (`transfer_branch_id`),
  CONSTRAINT `inventory_movements_added_by_foreign` FOREIGN KEY (`added_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inventory_movements_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inventory_movements_inventory_item_id_foreign` FOREIGN KEY (`inventory_item_id`) REFERENCES `inventory_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inventory_movements_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `inventory_movements_transfer_branch_id_foreign` FOREIGN KEY (`transfer_branch_id`) REFERENCES `branches` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_movements`
--

LOCK TABLES `inventory_movements` WRITE;
/*!40000 ALTER TABLE `inventory_movements` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory_movements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_settings`
--

DROP TABLE IF EXISTS `inventory_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned NOT NULL,
  `allow_auto_purchase` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inventory_settings_restaurant_id_foreign` (`restaurant_id`),
  CONSTRAINT `inventory_settings_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_settings`
--

LOCK TABLES `inventory_settings` WRITE;
/*!40000 ALTER TABLE `inventory_settings` DISABLE KEYS */;
INSERT INTO `inventory_settings` VALUES (1,1,0,'2025-11-30 04:19:30','2025-11-30 04:19:30'),(2,2,0,'2025-11-30 04:19:30','2025-11-30 04:19:30'),(3,3,0,'2025-11-30 04:19:31','2025-11-30 04:19:31'),(4,4,0,'2025-11-30 04:19:31','2025-11-30 04:19:31');
/*!40000 ALTER TABLE `inventory_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_stocks`
--

DROP TABLE IF EXISTS `inventory_stocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_stocks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned NOT NULL,
  `inventory_item_id` bigint unsigned NOT NULL,
  `quantity` decimal(16,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inventory_stocks_branch_id_foreign` (`branch_id`),
  KEY `inventory_stocks_inventory_item_id_foreign` (`inventory_item_id`),
  CONSTRAINT `inventory_stocks_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inventory_stocks_inventory_item_id_foreign` FOREIGN KEY (`inventory_item_id`) REFERENCES `inventory_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_stocks`
--

LOCK TABLES `inventory_stocks` WRITE;
/*!40000 ALTER TABLE `inventory_stocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory_stocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_categories`
--

DROP TABLE IF EXISTS `item_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned DEFAULT NULL,
  `category_name` text COLLATE utf8mb4_unicode_ci,
  `sort_order` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_categories_branch_id_foreign` (`branch_id`),
  CONSTRAINT `item_categories_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_categories`
--

LOCK TABLES `item_categories` WRITE;
/*!40000 ALTER TABLE `item_categories` DISABLE KEYS */;
INSERT INTO `item_categories` VALUES (1,1,'{\"en\":\"Starters\"}',0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(2,1,'{\"en\":\"Main Course\"}',0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(3,1,'{\"en\":\"Breads\"}',0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(4,1,'{\"en\":\"Rice\"}',0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(5,1,'{\"en\":\"Desserts\"}',0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(6,1,'{\"en\":\"Beverages\"}',0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(7,1,'{\"en\":\"Salads\"}',0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(8,1,'{\"en\":\"Soups\"}',0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(9,1,'{\"en\":\"Sides\"}',0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(10,1,'{\"en\":\"Snacks\"}',0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(11,1,'{\"en\":\"Fast Food\"}',0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(12,1,'{\"en\":\"Smoothies\"}',0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(13,1,'{\"en\":\"Juices\"}',0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(14,1,'{\"en\":\"Starters\"}',0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(15,1,'{\"en\":\"Main Course\"}',0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(16,1,'{\"en\":\"Breads\"}',0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(17,1,'{\"en\":\"Rice\"}',0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(18,1,'{\"en\":\"Desserts\"}',0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(19,1,'{\"en\":\"Beverages\"}',0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(20,1,'{\"en\":\"Salads\"}',0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(21,1,'{\"en\":\"Soups\"}',0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(22,1,'{\"en\":\"Sides\"}',0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(23,1,'{\"en\":\"Snacks\"}',0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(24,1,'{\"en\":\"Fast Food\"}',0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(25,1,'{\"en\":\"Smoothies\"}',0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(26,1,'{\"en\":\"Juices\"}',0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(27,3,'{\"en\":\"Starters\"}',0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(28,3,'{\"en\":\"Main Course\"}',0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(29,3,'{\"en\":\"Breads\"}',0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(30,3,'{\"en\":\"Rice\"}',0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(31,3,'{\"en\":\"Desserts\"}',0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(32,3,'{\"en\":\"Beverages\"}',0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(33,3,'{\"en\":\"Salads\"}',0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(34,3,'{\"en\":\"Soups\"}',0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(35,3,'{\"en\":\"Sides\"}',0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(36,3,'{\"en\":\"Snacks\"}',0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(37,3,'{\"en\":\"Fast Food\"}',0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(38,3,'{\"en\":\"Smoothies\"}',0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(39,3,'{\"en\":\"Juices\"}',0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(40,5,'{\"en\":\"Starters\"}',0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(41,5,'{\"en\":\"Main Course\"}',0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(42,5,'{\"en\":\"Breads\"}',0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(43,5,'{\"en\":\"Rice\"}',0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(44,5,'{\"en\":\"Desserts\"}',0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(45,5,'{\"en\":\"Beverages\"}',0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(46,5,'{\"en\":\"Salads\"}',0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(47,5,'{\"en\":\"Soups\"}',0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(48,5,'{\"en\":\"Sides\"}',0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(49,5,'{\"en\":\"Snacks\"}',0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(50,5,'{\"en\":\"Fast Food\"}',0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(51,5,'{\"en\":\"Smoothies\"}',0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(52,5,'{\"en\":\"Juices\"}',0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(53,7,'{\"en\":\"Starters\"}',0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(54,7,'{\"en\":\"Main Course\"}',0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(55,7,'{\"en\":\"Breads\"}',0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(56,7,'{\"en\":\"Rice\"}',0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(57,7,'{\"en\":\"Desserts\"}',0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(58,7,'{\"en\":\"Beverages\"}',0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(59,7,'{\"en\":\"Salads\"}',0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(60,7,'{\"en\":\"Soups\"}',0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(61,7,'{\"en\":\"Sides\"}',0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(62,7,'{\"en\":\"Snacks\"}',0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(63,7,'{\"en\":\"Fast Food\"}',0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(64,7,'{\"en\":\"Smoothies\"}',0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(65,7,'{\"en\":\"Juices\"}',0,'2025-11-30 03:00:37','2025-11-30 03:00:37');
/*!40000 ALTER TABLE `item_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_modifiers`
--

DROP TABLE IF EXISTS `item_modifiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_modifiers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `menu_item_id` bigint unsigned DEFAULT NULL,
  `menu_item_variation_id` bigint unsigned DEFAULT NULL,
  `modifier_group_id` bigint unsigned DEFAULT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT '0',
  `allow_multiple_selection` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_modifiers_menu_item_id_foreign` (`menu_item_id`),
  KEY `item_modifiers_modifier_group_id_foreign` (`modifier_group_id`),
  KEY `item_modifiers_menu_item_variation_id_foreign` (`menu_item_variation_id`),
  CONSTRAINT `item_modifiers_menu_item_id_foreign` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `item_modifiers_menu_item_variation_id_foreign` FOREIGN KEY (`menu_item_variation_id`) REFERENCES `menu_item_variations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `item_modifiers_modifier_group_id_foreign` FOREIGN KEY (`modifier_group_id`) REFERENCES `modifier_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_modifiers`
--

LOCK TABLES `item_modifiers` WRITE;
/*!40000 ALTER TABLE `item_modifiers` DISABLE KEYS */;
INSERT INTO `item_modifiers` VALUES (1,9,NULL,2,0,0,NULL,NULL),(2,2,NULL,1,0,0,NULL,NULL),(3,2,NULL,2,0,0,NULL,NULL),(4,24,NULL,4,0,0,NULL,NULL),(5,17,NULL,3,0,0,NULL,NULL),(6,17,NULL,4,0,0,NULL,NULL),(7,39,NULL,6,0,0,NULL,NULL),(8,32,NULL,5,0,0,NULL,NULL),(9,32,NULL,6,0,0,NULL,NULL),(10,54,NULL,8,0,0,NULL,NULL),(11,47,NULL,7,0,0,NULL,NULL),(12,47,NULL,8,0,0,NULL,NULL),(13,69,NULL,10,0,0,NULL,NULL),(14,62,NULL,9,0,0,NULL,NULL),(15,62,NULL,10,0,0,NULL,NULL);
/*!40000 ALTER TABLE `item_modifiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kiosk_ads`
--

DROP TABLE IF EXISTS `kiosk_ads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kiosk_ads` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `heading` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kiosk_ads`
--

LOCK TABLES `kiosk_ads` WRITE;
/*!40000 ALTER TABLE `kiosk_ads` DISABLE KEYS */;
/*!40000 ALTER TABLE `kiosk_ads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kiosk_global_settings`
--

DROP TABLE IF EXISTS `kiosk_global_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kiosk_global_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `license_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchased_on` timestamp NULL DEFAULT NULL,
  `supported_until` timestamp NULL DEFAULT NULL,
  `notify_update` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kiosk_global_settings`
--

LOCK TABLES `kiosk_global_settings` WRITE;
/*!40000 ALTER TABLE `kiosk_global_settings` DISABLE KEYS */;
INSERT INTO `kiosk_global_settings` VALUES (1,NULL,NULL,NULL,NULL,1,'2025-11-30 04:19:33','2025-11-30 04:19:33');
/*!40000 ALTER TABLE `kiosk_global_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kiosks`
--

DROP TABLE IF EXISTS `kiosks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kiosks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned NOT NULL,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `require_name` tinyint(1) NOT NULL DEFAULT '1',
  `require_email` tinyint(1) NOT NULL DEFAULT '0',
  `require_phone` tinyint(1) NOT NULL DEFAULT '1',
  `last_seen_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `kiosks_branch_id_code_unique` (`branch_id`,`code`),
  UNIQUE KEY `kiosks_branch_id_name_unique` (`branch_id`,`name`),
  CONSTRAINT `kiosks_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kiosks`
--

LOCK TABLES `kiosks` WRITE;
/*!40000 ALTER TABLE `kiosks` DISABLE KEYS */;
INSERT INTO `kiosks` VALUES (1,1,'508411','Daphneytown',1,1,0,1,NULL,'2025-11-30 04:19:34','2025-11-30 04:19:34'),(2,2,'785352','Port Reva',1,1,0,1,NULL,'2025-11-30 04:19:34','2025-11-30 04:19:34'),(3,3,'175393','Rogahnton',1,1,0,1,NULL,'2025-11-30 04:19:34','2025-11-30 04:19:34'),(4,4,'709184','New Norbert',1,1,0,1,NULL,'2025-11-30 04:19:34','2025-11-30 04:19:34'),(5,5,'931905','East Wadeside',1,1,0,1,NULL,'2025-11-30 04:19:34','2025-11-30 04:19:34'),(6,6,'354986','Mablebury',1,1,0,1,NULL,'2025-11-30 04:19:34','2025-11-30 04:19:34'),(7,7,'670887','East Hannah',1,1,0,1,NULL,'2025-11-30 04:19:34','2025-11-30 04:19:34'),(8,8,'279398','Lake Jaunita',1,1,0,1,NULL,'2025-11-30 04:19:34','2025-11-30 04:19:34');
/*!40000 ALTER TABLE `kiosks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kitchen_global_settings`
--

DROP TABLE IF EXISTS `kitchen_global_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kitchen_global_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `license_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchased_on` timestamp NULL DEFAULT NULL,
  `supported_until` timestamp NULL DEFAULT NULL,
  `notify_update` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kitchen_global_settings`
--

LOCK TABLES `kitchen_global_settings` WRITE;
/*!40000 ALTER TABLE `kitchen_global_settings` DISABLE KEYS */;
INSERT INTO `kitchen_global_settings` VALUES (1,NULL,NULL,NULL,NULL,1,'2025-11-30 04:19:36','2025-11-30 04:19:36');
/*!40000 ALTER TABLE `kitchen_global_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kot_cancel_reasons`
--

DROP TABLE IF EXISTS `kot_cancel_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kot_cancel_reasons` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `reason` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cancel_order` tinyint(1) NOT NULL DEFAULT '0',
  `cancel_kot` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kot_cancel_reasons_restaurant_id_foreign` (`restaurant_id`),
  CONSTRAINT `kot_cancel_reasons_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kot_cancel_reasons`
--

LOCK TABLES `kot_cancel_reasons` WRITE;
/*!40000 ALTER TABLE `kot_cancel_reasons` DISABLE KEYS */;
INSERT INTO `kot_cancel_reasons` VALUES (1,1,'Customer changed their mind',1,0,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(2,1,'Customer requested to cancel',1,0,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(3,1,'Payment issues',1,0,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(4,1,'Customer no longer wants the order',1,0,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(5,1,'Ingredient not available',0,1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(6,1,'Preparation time too long',0,1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(7,1,'Quality issue with ingredients',0,1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(8,1,'System error/Technical issue',1,1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(9,1,'Restaurant closing early',1,1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(10,1,'Other',1,1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(11,1,'Customer changed their mind',1,0,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(12,1,'Customer requested to cancel',1,0,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(13,1,'Payment issues',1,0,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(14,1,'Customer no longer wants the order',1,0,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(15,1,'Ingredient not available',0,1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(16,1,'Preparation time too long',0,1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(17,1,'Quality issue with ingredients',0,1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(18,1,'System error/Technical issue',1,1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(19,1,'Restaurant closing early',1,1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(20,1,'Other',1,1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(21,2,'Customer changed their mind',1,0,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(22,2,'Customer requested to cancel',1,0,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(23,2,'Payment issues',1,0,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(24,2,'Customer no longer wants the order',1,0,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(25,2,'Ingredient not available',0,1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(26,2,'Preparation time too long',0,1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(27,2,'Quality issue with ingredients',0,1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(28,2,'System error/Technical issue',1,1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(29,2,'Restaurant closing early',1,1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(30,2,'Other',1,1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(31,3,'Customer changed their mind',1,0,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(32,3,'Customer requested to cancel',1,0,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(33,3,'Payment issues',1,0,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(34,3,'Customer no longer wants the order',1,0,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(35,3,'Ingredient not available',0,1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(36,3,'Preparation time too long',0,1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(37,3,'Quality issue with ingredients',0,1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(38,3,'System error/Technical issue',1,1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(39,3,'Restaurant closing early',1,1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(40,3,'Other',1,1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(41,4,'Customer changed their mind',1,0,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(42,4,'Customer requested to cancel',1,0,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(43,4,'Payment issues',1,0,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(44,4,'Customer no longer wants the order',1,0,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(45,4,'Ingredient not available',0,1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(46,4,'Preparation time too long',0,1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(47,4,'Quality issue with ingredients',0,1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(48,4,'System error/Technical issue',1,1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(49,4,'Restaurant closing early',1,1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(50,4,'Other',1,1,'2025-11-30 03:00:35','2025-11-30 03:00:35');
/*!40000 ALTER TABLE `kot_cancel_reasons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kot_item_modifier_options`
--

DROP TABLE IF EXISTS `kot_item_modifier_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kot_item_modifier_options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `kot_item_id` bigint unsigned NOT NULL,
  `modifier_option_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kot_item_modifier_options_kot_item_id_foreign` (`kot_item_id`),
  KEY `kot_item_modifier_options_modifier_option_id_foreign` (`modifier_option_id`),
  CONSTRAINT `kot_item_modifier_options_kot_item_id_foreign` FOREIGN KEY (`kot_item_id`) REFERENCES `kot_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kot_item_modifier_options_modifier_option_id_foreign` FOREIGN KEY (`modifier_option_id`) REFERENCES `modifier_options` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kot_item_modifier_options`
--

LOCK TABLES `kot_item_modifier_options` WRITE;
/*!40000 ALTER TABLE `kot_item_modifier_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `kot_item_modifier_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kot_items`
--

DROP TABLE IF EXISTS `kot_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kot_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `kot_id` bigint unsigned NOT NULL,
  `order_item_id` bigint unsigned DEFAULT NULL,
  `transaction_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `menu_item_id` bigint unsigned NOT NULL,
  `menu_item_variation_id` bigint unsigned DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `quantity` int NOT NULL,
  `status` enum('pending','cooking','ready','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancel_reason_id` bigint unsigned DEFAULT NULL,
  `cancel_reason_text` text COLLATE utf8mb4_unicode_ci,
  `cancelled_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kot_items_kot_id_foreign` (`kot_id`),
  KEY `kot_items_menu_item_id_foreign` (`menu_item_id`),
  KEY `kot_items_menu_item_variation_id_foreign` (`menu_item_variation_id`),
  KEY `kot_items_cancel_reason_id_foreign` (`cancel_reason_id`),
  KEY `kot_items_order_item_id_foreign` (`order_item_id`),
  KEY `kot_items_cancelled_by_foreign` (`cancelled_by`),
  CONSTRAINT `kot_items_cancel_reason_id_foreign` FOREIGN KEY (`cancel_reason_id`) REFERENCES `kot_cancel_reasons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kot_items_cancelled_by_foreign` FOREIGN KEY (`cancelled_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `kot_items_kot_id_foreign` FOREIGN KEY (`kot_id`) REFERENCES `kots` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kot_items_menu_item_id_foreign` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `kot_items_menu_item_variation_id_foreign` FOREIGN KEY (`menu_item_variation_id`) REFERENCES `menu_item_variations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `kot_items_order_item_id_foreign` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kot_items`
--

LOCK TABLES `kot_items` WRITE;
/*!40000 ALTER TABLE `kot_items` DISABLE KEYS */;
INSERT INTO `kot_items` VALUES (1,1,NULL,NULL,2,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(2,1,NULL,NULL,8,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(3,2,NULL,NULL,9,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(4,2,NULL,NULL,11,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(5,3,NULL,NULL,1,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(6,3,NULL,NULL,2,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(7,4,NULL,NULL,11,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(8,4,NULL,NULL,12,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(9,4,NULL,NULL,8,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(10,4,NULL,NULL,7,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(11,4,NULL,NULL,13,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(12,5,NULL,NULL,12,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(13,5,NULL,NULL,6,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(14,5,NULL,NULL,10,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(15,5,NULL,NULL,9,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(16,5,NULL,NULL,1,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(17,6,NULL,NULL,7,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(18,6,NULL,NULL,11,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(19,6,NULL,NULL,4,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(20,6,NULL,NULL,5,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(21,6,NULL,NULL,10,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(22,7,NULL,NULL,4,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(23,7,NULL,NULL,9,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(24,7,NULL,NULL,8,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(25,8,NULL,NULL,8,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(26,9,NULL,NULL,2,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(27,9,NULL,NULL,13,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(28,9,NULL,NULL,4,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(29,9,NULL,NULL,5,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(30,10,NULL,NULL,9,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(31,10,NULL,NULL,3,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(32,11,NULL,NULL,5,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(33,11,NULL,NULL,15,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(34,12,NULL,NULL,20,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(35,12,NULL,NULL,24,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(36,12,NULL,NULL,19,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(37,12,NULL,NULL,27,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(38,13,NULL,NULL,6,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(39,14,NULL,NULL,15,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(40,15,NULL,NULL,29,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(41,15,NULL,NULL,12,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(42,15,NULL,NULL,6,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(43,16,NULL,NULL,1,NULL,NULL,1,'cooking',NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 04:17:54'),(44,16,NULL,NULL,7,NULL,NULL,3,'cooking',NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 04:18:00'),(45,16,NULL,NULL,4,NULL,NULL,2,'cooking',NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 04:18:02'),(46,16,NULL,NULL,6,NULL,NULL,3,'cooking',NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 04:18:02'),(47,17,NULL,NULL,9,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(48,18,NULL,NULL,17,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(49,18,NULL,NULL,9,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(50,18,NULL,NULL,16,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(51,19,NULL,NULL,14,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(52,19,NULL,NULL,19,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(53,19,NULL,NULL,10,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(54,19,NULL,NULL,29,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(55,19,NULL,NULL,18,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(56,20,NULL,NULL,4,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(57,20,NULL,NULL,6,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(58,20,NULL,NULL,15,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(59,20,NULL,NULL,28,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(60,20,NULL,NULL,1,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(61,21,NULL,NULL,19,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:25','2025-11-30 03:00:25'),(62,22,NULL,NULL,20,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:25','2025-11-30 03:00:25'),(63,22,NULL,NULL,18,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:25','2025-11-30 03:00:25'),(64,22,NULL,NULL,30,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:25','2025-11-30 03:00:25'),(65,22,NULL,NULL,6,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:25','2025-11-30 03:00:25'),(66,23,NULL,NULL,33,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(67,23,NULL,NULL,40,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(68,24,NULL,NULL,42,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(69,24,NULL,NULL,31,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(70,24,NULL,NULL,43,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(71,24,NULL,NULL,39,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(72,24,NULL,NULL,44,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(73,25,NULL,NULL,38,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(74,25,NULL,NULL,35,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(75,25,NULL,NULL,32,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(76,25,NULL,NULL,40,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(77,25,NULL,NULL,34,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(78,26,NULL,NULL,33,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(79,26,NULL,NULL,45,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(80,26,NULL,NULL,44,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(81,26,NULL,NULL,34,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(82,26,NULL,NULL,35,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(83,27,NULL,NULL,36,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(84,27,NULL,NULL,45,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(85,28,NULL,NULL,38,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(86,28,NULL,NULL,35,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(87,29,NULL,NULL,35,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(88,29,NULL,NULL,33,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(89,29,NULL,NULL,41,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(90,29,NULL,NULL,44,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(91,30,NULL,NULL,42,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(92,30,NULL,NULL,37,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(93,30,NULL,NULL,34,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(94,30,NULL,NULL,43,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(95,31,NULL,NULL,45,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(96,32,NULL,NULL,34,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(97,32,NULL,NULL,35,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(98,32,NULL,NULL,33,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(99,32,NULL,NULL,32,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(100,33,NULL,NULL,31,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(101,34,NULL,NULL,49,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(102,34,NULL,NULL,50,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(103,34,NULL,NULL,47,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(104,34,NULL,NULL,58,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(105,34,NULL,NULL,51,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(106,35,NULL,NULL,48,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(107,35,NULL,NULL,50,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(108,35,NULL,NULL,54,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(109,35,NULL,NULL,55,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(110,36,NULL,NULL,57,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(111,37,NULL,NULL,51,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(112,37,NULL,NULL,59,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(113,37,NULL,NULL,49,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(114,38,NULL,NULL,53,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(115,38,NULL,NULL,58,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(116,38,NULL,NULL,52,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(117,39,NULL,NULL,53,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(118,39,NULL,NULL,50,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(119,39,NULL,NULL,58,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(120,40,NULL,NULL,59,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(121,41,NULL,NULL,49,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(122,41,NULL,NULL,52,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(123,41,NULL,NULL,50,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(124,42,NULL,NULL,60,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(125,42,NULL,NULL,53,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(126,42,NULL,NULL,57,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(127,43,NULL,NULL,52,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(128,43,NULL,NULL,47,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(129,43,NULL,NULL,55,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(130,43,NULL,NULL,46,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(131,43,NULL,NULL,53,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(132,44,NULL,NULL,55,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(133,44,NULL,NULL,47,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(134,44,NULL,NULL,48,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(135,44,NULL,NULL,46,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(136,44,NULL,NULL,57,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(137,45,NULL,NULL,66,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(138,45,NULL,NULL,68,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(139,46,NULL,NULL,65,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(140,46,NULL,NULL,69,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(141,46,NULL,NULL,72,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(142,47,NULL,NULL,73,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(143,47,NULL,NULL,65,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(144,48,NULL,NULL,63,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(145,49,NULL,NULL,68,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(146,49,NULL,NULL,66,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(147,50,NULL,NULL,65,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(148,50,NULL,NULL,64,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(149,50,NULL,NULL,75,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(150,51,NULL,NULL,72,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(151,51,NULL,NULL,62,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(152,51,NULL,NULL,63,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(153,51,NULL,NULL,67,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(154,51,NULL,NULL,75,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(155,52,NULL,NULL,64,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(156,52,NULL,NULL,68,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(157,52,NULL,NULL,65,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(158,52,NULL,NULL,63,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(159,53,NULL,NULL,70,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(160,53,NULL,NULL,74,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(161,54,NULL,NULL,64,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(162,54,NULL,NULL,62,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(163,55,NULL,NULL,61,NULL,NULL,2,NULL,NULL,NULL,NULL,'2025-11-30 03:00:39','2025-11-30 03:00:39'),(164,55,NULL,NULL,73,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:39','2025-11-30 03:00:39'),(165,55,NULL,NULL,70,NULL,NULL,1,NULL,NULL,NULL,NULL,'2025-11-30 03:00:39','2025-11-30 03:00:39'),(166,55,NULL,NULL,74,NULL,NULL,3,NULL,NULL,NULL,NULL,'2025-11-30 03:00:39','2025-11-30 03:00:39');
/*!40000 ALTER TABLE `kot_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kot_places`
--

DROP TABLE IF EXISTS `kot_places`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kot_places` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `printer_id` bigint unsigned DEFAULT NULL,
  `branch_id` bigint unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kot_places_branch_id_foreign` (`branch_id`),
  KEY `kot_places_printer_id_foreign` (`printer_id`),
  CONSTRAINT `kot_places_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `kot_places_printer_id_foreign` FOREIGN KEY (`printer_id`) REFERENCES `printers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kot_places`
--

LOCK TABLES `kot_places` WRITE;
/*!40000 ALTER TABLE `kot_places` DISABLE KEYS */;
INSERT INTO `kot_places` VALUES (1,1,1,'Default Kitchen','food',1,1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(2,2,2,'Default Kitchen','food',1,1,'2025-11-30 02:57:23','2025-11-30 02:57:24'),(3,3,3,'Default Kitchen','food',1,1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(4,4,4,'Default Kitchen','food',1,1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(5,5,5,'Default Kitchen','food',1,1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(6,6,6,'Default Kitchen','food',1,1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(7,7,7,'Default Kitchen','food',1,1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(8,8,8,'Default Kitchen','food',1,1,'2025-11-30 03:00:20','2025-11-30 03:00:20');
/*!40000 ALTER TABLE `kot_places` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kot_settings`
--

DROP TABLE IF EXISTS `kot_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kot_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned NOT NULL,
  `default_status` enum('pending','cooking') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `enable_item_level_status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kot_settings_branch_id_foreign` (`branch_id`),
  CONSTRAINT `kot_settings_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kot_settings`
--

LOCK TABLES `kot_settings` WRITE;
/*!40000 ALTER TABLE `kot_settings` DISABLE KEYS */;
INSERT INTO `kot_settings` VALUES (1,1,'pending',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(2,1,'pending',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(3,2,'pending',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(4,2,'pending',1,'2025-11-30 02:57:24','2025-11-30 02:57:24'),(5,3,'pending',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(6,3,'pending',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(7,4,'pending',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(8,4,'pending',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(9,5,'pending',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(10,5,'pending',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(11,6,'pending',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(12,6,'pending',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(13,7,'pending',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(14,7,'pending',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(15,8,'pending',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(16,8,'pending',1,'2025-11-30 03:00:20','2025-11-30 03:00:20');
/*!40000 ALTER TABLE `kot_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kots`
--

DROP TABLE IF EXISTS `kots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kots` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned DEFAULT NULL,
  `kitchen_place_id` bigint unsigned DEFAULT NULL,
  `kot_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token_number` int unsigned DEFAULT NULL,
  `order_id` bigint unsigned NOT NULL,
  `order_type_id` bigint unsigned DEFAULT NULL,
  `transaction_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `status` enum('pending_confirmation','in_kitchen','food_ready','served','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'in_kitchen',
  `cancel_reason_id` bigint unsigned DEFAULT NULL,
  `cancel_reason_text` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kots_order_id_foreign` (`order_id`),
  KEY `kots_branch_id_foreign` (`branch_id`),
  KEY `kots_cancel_reason_id_foreign` (`cancel_reason_id`),
  KEY `kots_order_type_id_foreign` (`order_type_id`),
  KEY `kots_kitchen_place_id_foreign` (`kitchen_place_id`),
  CONSTRAINT `kots_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kots_cancel_reason_id_foreign` FOREIGN KEY (`cancel_reason_id`) REFERENCES `kot_cancel_reasons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kots_kitchen_place_id_foreign` FOREIGN KEY (`kitchen_place_id`) REFERENCES `kot_places` (`id`) ON DELETE SET NULL,
  CONSTRAINT `kots_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `kots_order_type_id_foreign` FOREIGN KEY (`order_type_id`) REFERENCES `order_types` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kots`
--

LOCK TABLES `kots` WRITE;
/*!40000 ALTER TABLE `kots` DISABLE KEYS */;
INSERT INTO `kots` VALUES (1,1,NULL,'1',NULL,1,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(2,1,NULL,'2',NULL,2,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(3,1,NULL,'3',NULL,3,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(4,1,NULL,'4',NULL,4,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(5,1,NULL,'5',NULL,5,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(6,1,NULL,'6',NULL,6,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(7,1,NULL,'7',NULL,7,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(8,1,NULL,'8',NULL,8,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(9,1,NULL,'9',NULL,9,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(10,1,NULL,'10',NULL,10,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(11,1,NULL,'11',NULL,11,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(12,1,NULL,'12',NULL,12,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(13,1,NULL,'13',NULL,13,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(14,1,NULL,'14',NULL,14,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(15,1,NULL,'15',NULL,15,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(16,1,NULL,'16',NULL,16,NULL,NULL,NULL,'in_kitchen',NULL,NULL,'2025-11-30 03:00:24','2025-11-30 04:18:02'),(17,1,NULL,'17',NULL,17,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(18,1,NULL,'18',NULL,18,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(19,1,NULL,'19',NULL,19,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(20,1,NULL,'20',NULL,20,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(21,1,NULL,'21',NULL,21,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:25','2025-11-30 03:00:25'),(22,1,NULL,'22',NULL,22,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:25','2025-11-30 03:00:25'),(23,3,NULL,'23',NULL,23,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(24,3,NULL,'24',NULL,24,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(25,3,NULL,'25',NULL,25,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(26,3,NULL,'26',NULL,26,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(27,3,NULL,'27',NULL,27,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(28,3,NULL,'28',NULL,28,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(29,3,NULL,'29',NULL,29,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(30,3,NULL,'30',NULL,30,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(31,3,NULL,'31',NULL,31,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(32,3,NULL,'32',NULL,32,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(33,3,NULL,'33',NULL,33,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(34,5,NULL,'34',NULL,34,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(35,5,NULL,'35',NULL,35,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(36,5,NULL,'36',NULL,36,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(37,5,NULL,'37',NULL,37,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(38,5,NULL,'38',NULL,38,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(39,5,NULL,'39',NULL,39,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(40,5,NULL,'40',NULL,40,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(41,5,NULL,'41',NULL,41,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(42,5,NULL,'42',NULL,42,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(43,5,NULL,'43',NULL,43,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(44,5,NULL,'44',NULL,44,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(45,7,NULL,'45',NULL,45,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(46,7,NULL,'46',NULL,46,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(47,7,NULL,'47',NULL,47,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(48,7,NULL,'48',NULL,48,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(49,7,NULL,'49',NULL,49,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(50,7,NULL,'50',NULL,50,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(51,7,NULL,'51',NULL,51,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(52,7,NULL,'52',NULL,52,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(53,7,NULL,'53',NULL,53,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(54,7,NULL,'54',NULL,54,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(55,7,NULL,'55',NULL,55,NULL,NULL,NULL,'pending_confirmation',NULL,NULL,'2025-11-30 03:00:39','2025-11-30 03:00:39');
/*!40000 ALTER TABLE `kots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_pack_settings`
--

DROP TABLE IF EXISTS `language_pack_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `language_pack_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `purchase_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supported_until` timestamp NULL DEFAULT NULL,
  `purchased_on` timestamp NULL DEFAULT NULL,
  `license_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notify_update` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_pack_settings`
--

LOCK TABLES `language_pack_settings` WRITE;
/*!40000 ALTER TABLE `language_pack_settings` DISABLE KEYS */;
INSERT INTO `language_pack_settings` VALUES (1,NULL,NULL,NULL,NULL,1,'2025-11-30 04:19:39','2025-11-30 04:19:39');
/*!40000 ALTER TABLE `language_pack_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_settings`
--

DROP TABLE IF EXISTS `language_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `language_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `language_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `language_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `flag_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `is_rtl` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_settings`
--

LOCK TABLES `language_settings` WRITE;
/*!40000 ALTER TABLE `language_settings` DISABLE KEYS */;
INSERT INTO `language_settings` VALUES (1,'en','English','gb',1,0,NULL,NULL),(2,'ar','Arabic','sa',0,1,NULL,NULL),(3,'de','German','de',0,0,NULL,NULL),(4,'es','Spanish','es',0,0,NULL,NULL),(5,'et','Estonian','et',0,0,NULL,NULL),(6,'fa','Farsi','ir',0,1,NULL,NULL),(7,'fr','French','fr',0,0,NULL,NULL),(8,'el','Greek','gr',0,0,NULL,NULL),(9,'it','Italian','it',0,0,NULL,NULL),(10,'nl','Dutch','nl',0,0,NULL,NULL),(11,'pl','Polish','pl',0,0,NULL,NULL),(12,'pt','Portuguese','pt',0,0,NULL,NULL),(13,'pt-br','Portuguese (Brazil)','br',0,0,NULL,NULL),(14,'ro','Romanian','ro',0,0,NULL,NULL),(15,'ru','Russian','ru',0,0,NULL,NULL),(16,'tr','Turkish','tr',0,0,NULL,NULL),(17,'zh-CN','Chinese (S)','cn',0,0,NULL,NULL),(18,'zh-TW','Chinese (T)','cn',0,0,NULL,NULL),(19,'en','English','gb',1,0,NULL,NULL),(20,'ar','Arabic','sa',0,1,NULL,NULL),(21,'de','German','de',0,0,NULL,NULL),(22,'es','Spanish','es',0,0,NULL,NULL),(23,'et','Estonian','et',0,0,NULL,NULL),(24,'fa','Farsi','ir',0,1,NULL,NULL),(25,'fr','French','fr',0,0,NULL,NULL),(26,'el','Greek','gr',0,0,NULL,NULL),(27,'it','Italian','it',0,0,NULL,NULL),(28,'nl','Dutch','nl',0,0,NULL,NULL),(29,'pl','Polish','pl',0,0,NULL,NULL),(30,'pt','Portuguese','pt',0,0,NULL,NULL),(31,'pt-br','Portuguese (Brazil)','br',0,0,NULL,NULL),(32,'ro','Romanian','ro',0,0,NULL,NULL),(33,'ru','Russian','ru',0,0,NULL,NULL),(34,'tr','Turkish','tr',0,0,NULL,NULL),(35,'zh-CN','Chinese (S)','cn',0,0,NULL,NULL),(36,'zh-TW','Chinese (T)','cn',0,0,NULL,NULL),(37,'en','English','gb',1,0,NULL,NULL),(38,'ar','Arabic','sa',0,1,NULL,NULL),(39,'de','German','de',0,0,NULL,NULL),(40,'es','Spanish','es',0,0,NULL,NULL),(41,'et','Estonian','et',0,0,NULL,NULL),(42,'fa','Farsi','ir',0,1,NULL,NULL),(43,'fr','French','fr',0,0,NULL,NULL),(44,'el','Greek','gr',0,0,NULL,NULL),(45,'it','Italian','it',0,0,NULL,NULL),(46,'nl','Dutch','nl',0,0,NULL,NULL),(47,'pl','Polish','pl',0,0,NULL,NULL),(48,'pt','Portuguese','pt',0,0,NULL,NULL),(49,'pt-br','Portuguese (Brazil)','br',0,0,NULL,NULL),(50,'ro','Romanian','ro',0,0,NULL,NULL),(51,'ru','Russian','ru',0,0,NULL,NULL),(52,'tr','Turkish','tr',0,0,NULL,NULL),(53,'zh-CN','Chinese (S)','cn',0,0,NULL,NULL),(54,'zh-TW','Chinese (T)','cn',0,0,NULL,NULL),(55,'en','English','gb',1,0,NULL,NULL),(56,'ar','Arabic','sa',0,1,NULL,NULL),(57,'de','German','de',0,0,NULL,NULL),(58,'es','Spanish','es',0,0,NULL,NULL),(59,'et','Estonian','et',0,0,NULL,NULL),(60,'fa','Farsi','ir',0,1,NULL,NULL),(61,'fr','French','fr',0,0,NULL,NULL),(62,'el','Greek','gr',0,0,NULL,NULL),(63,'it','Italian','it',0,0,NULL,NULL),(64,'nl','Dutch','nl',0,0,NULL,NULL),(65,'pl','Polish','pl',0,0,NULL,NULL),(66,'pt','Portuguese','pt',0,0,NULL,NULL),(67,'pt-br','Portuguese (Brazil)','br',0,0,NULL,NULL),(68,'ro','Romanian','ro',0,0,NULL,NULL),(69,'ru','Russian','ru',0,0,NULL,NULL),(70,'tr','Turkish','tr',0,0,NULL,NULL),(71,'zh-CN','Chinese (S)','cn',0,0,NULL,NULL),(72,'zh-TW','Chinese (T)','cn',0,0,NULL,NULL);
/*!40000 ALTER TABLE `language_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ltm_translations`
--

DROP TABLE IF EXISTS `ltm_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ltm_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `status` int NOT NULL DEFAULT '0',
  `locale` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `group` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `key` text COLLATE utf8mb4_bin NOT NULL,
  `value` text COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ltm_translations`
--

LOCK TABLES `ltm_translations` WRITE;
/*!40000 ALTER TABLE `ltm_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ltm_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_item_prices`
--

DROP TABLE IF EXISTS `menu_item_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_item_prices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `menu_item_id` bigint unsigned NOT NULL,
  `order_type_id` bigint unsigned NOT NULL,
  `delivery_app_id` bigint unsigned DEFAULT NULL,
  `menu_item_variation_id` bigint unsigned DEFAULT NULL,
  `calculated_price` decimal(16,2) NOT NULL,
  `override_price` decimal(16,2) DEFAULT NULL,
  `final_price` decimal(16,2) NOT NULL DEFAULT '0.00',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_item_prices_menu_item_id_foreign` (`menu_item_id`),
  KEY `menu_item_prices_order_type_id_foreign` (`order_type_id`),
  KEY `menu_item_prices_delivery_app_id_foreign` (`delivery_app_id`),
  KEY `menu_item_prices_menu_item_variation_id_foreign` (`menu_item_variation_id`),
  CONSTRAINT `menu_item_prices_delivery_app_id_foreign` FOREIGN KEY (`delivery_app_id`) REFERENCES `delivery_platforms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `menu_item_prices_menu_item_id_foreign` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `menu_item_prices_menu_item_variation_id_foreign` FOREIGN KEY (`menu_item_variation_id`) REFERENCES `menu_item_variations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `menu_item_prices_order_type_id_foreign` FOREIGN KEY (`order_type_id`) REFERENCES `order_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_item_prices`
--

LOCK TABLES `menu_item_prices` WRITE;
/*!40000 ALTER TABLE `menu_item_prices` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu_item_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_item_tax`
--

DROP TABLE IF EXISTS `menu_item_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_item_tax` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `menu_item_id` bigint unsigned NOT NULL,
  `tax_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_item_tax_menu_item_id_foreign` (`menu_item_id`),
  KEY `menu_item_tax_tax_id_foreign` (`tax_id`),
  CONSTRAINT `menu_item_tax_menu_item_id_foreign` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `menu_item_tax_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_item_tax`
--

LOCK TABLES `menu_item_tax` WRITE;
/*!40000 ALTER TABLE `menu_item_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu_item_tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_item_translations`
--

DROP TABLE IF EXISTS `menu_item_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_item_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `menu_item_id` bigint unsigned NOT NULL,
  `locale` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menu_item_translations_menu_item_id_locale_unique` (`menu_item_id`,`locale`),
  KEY `menu_item_translations_locale_index` (`locale`),
  CONSTRAINT `menu_item_translations_menu_item_id_foreign` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_item_translations`
--

LOCK TABLES `menu_item_translations` WRITE;
/*!40000 ALTER TABLE `menu_item_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu_item_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_item_variations`
--

DROP TABLE IF EXISTS `menu_item_variations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_item_variations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `variation` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(16,2) NOT NULL,
  `menu_item_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_item_variations_menu_item_id_foreign` (`menu_item_id`),
  CONSTRAINT `menu_item_variations_menu_item_id_foreign` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_item_variations`
--

LOCK TABLES `menu_item_variations` WRITE;
/*!40000 ALTER TABLE `menu_item_variations` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu_item_variations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_items`
--

DROP TABLE IF EXISTS `menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned DEFAULT NULL,
  `kot_place_id` bigint unsigned DEFAULT NULL,
  `item_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `type` enum('veg','non-veg','egg','drink','other','halal') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(16,2) DEFAULT NULL,
  `menu_id` bigint unsigned NOT NULL,
  `item_category_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `preparation_time` int DEFAULT NULL,
  `is_available` tinyint(1) NOT NULL DEFAULT '1',
  `show_on_customer_site` tinyint(1) NOT NULL DEFAULT '1',
  `in_stock` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int unsigned NOT NULL DEFAULT '0',
  `tax_inclusive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `menu_items_menu_id_foreign` (`menu_id`),
  KEY `menu_items_item_category_id_foreign` (`item_category_id`),
  KEY `idx_branch_available` (`branch_id`,`is_available`),
  CONSTRAINT `menu_items_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `menu_items_item_category_id_foreign` FOREIGN KEY (`item_category_id`) REFERENCES `item_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_items`
--

LOCK TABLES `menu_items` WRITE;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` VALUES (1,1,1,'Butter Chicken','butter-chicken.webp','Tender chicken cooked in a rich tomato and butter gravy.','non-veg',320.00,1,2,NULL,NULL,13,1,1,1,0,0),(2,1,1,'Paneer Tikka','paneer-tikka.webp','Grilled cottage cheese marinated in spicy yogurt.','veg',250.00,1,1,NULL,NULL,29,1,1,1,0,0),(3,1,1,'Dal Makhani','dal-makhni.webp','Creamy and rich black lentils cooked with butter and spices.','veg',180.00,1,2,NULL,NULL,18,1,1,1,0,0),(4,1,1,'Tandoori Roti','tandoori-roti.webp','Traditional whole wheat bread cooked in a clay oven.','veg',25.00,1,3,NULL,NULL,27,1,1,1,0,0),(5,1,1,'Naan','naan-recipe.webp','Soft and fluffy bread baked in a tandoor.','veg',40.00,1,3,NULL,NULL,28,1,1,1,0,0),(6,1,1,'Masala Dosa','masala-dosa.webp','Crispy rice and lentil crepe filled with spiced mashed potatoes.','veg',120.00,2,2,NULL,NULL,20,1,1,1,0,0),(7,1,1,'Idli Sambar','idli-sambar.webp','Steamed rice cakes served with lentil soup and chutney.','veg',90.00,2,2,NULL,NULL,24,1,1,1,0,0),(8,1,1,'Medu Vada','medu-vada.webp','Crispy lentil fritters with chutney and sambar.','veg',80.00,2,1,NULL,NULL,11,1,1,1,0,0),(9,1,1,'Uttapam','uttapam.webp','Thick rice and lentil pancake topped with onions and tomatoes.','veg',130.00,2,2,NULL,NULL,10,1,1,1,0,0),(10,1,1,'Hyderabadi Chicken Biryani','chicken-hyderabadi-biryani.webp','Fragrant rice cooked with tender meat and aromatic spices.','non-veg',300.00,2,4,NULL,NULL,26,1,1,1,0,0),(11,1,1,'Chicken Manchurian','chicken-manchurian.webp','Juicy chicken balls in a tangy Manchurian sauce.','non-veg',260.00,3,2,NULL,NULL,21,1,1,1,0,0),(12,1,1,'Vegetable Hakka Noodles','vegetable-hakka-noodles.webp','Stir-fried noodles with a mix of vegetables in a savory sauce.','veg',180.00,3,2,NULL,NULL,12,1,1,1,0,0),(13,1,1,'Chilli Paneer','chilli-paneer.webp','Spicy cottage cheese cubes tossed in a tangy Indo-Chinese sauce.','veg',240.00,3,2,NULL,NULL,24,1,1,1,0,0),(14,1,1,'Spring Rolls','spring-rolls.webp','Crispy rolls stuffed with a mix of vegetables and served with tangy dip.','veg',150.00,3,1,NULL,NULL,11,1,1,1,0,0),(15,1,1,'Veg Manchow Soup','vegetable-manchow-soup.webp','Spicy vegetable soup with crispy fried noodles.','veg',120.00,3,1,NULL,NULL,20,1,1,1,0,0),(16,1,1,'Butter Chicken','butter-chicken.webp','Tender chicken cooked in a rich tomato and butter gravy.','non-veg',320.00,4,15,NULL,NULL,11,1,1,1,0,0),(17,1,1,'Paneer Tikka','paneer-tikka.webp','Grilled cottage cheese marinated in spicy yogurt.','veg',250.00,4,14,NULL,NULL,30,1,1,1,0,0),(18,1,1,'Dal Makhani','dal-makhni.webp','Creamy and rich black lentils cooked with butter and spices.','veg',180.00,4,15,NULL,NULL,16,1,1,1,0,0),(19,1,1,'Tandoori Roti','tandoori-roti.webp','Traditional whole wheat bread cooked in a clay oven.','veg',25.00,4,16,NULL,NULL,30,1,1,1,0,0),(20,1,1,'Naan','naan-recipe.webp','Soft and fluffy bread baked in a tandoor.','veg',40.00,4,16,NULL,NULL,21,1,1,1,0,0),(21,1,1,'Masala Dosa','masala-dosa.webp','Crispy rice and lentil crepe filled with spiced mashed potatoes.','veg',120.00,5,15,NULL,NULL,13,1,1,1,0,0),(22,1,1,'Idli Sambar','idli-sambar.webp','Steamed rice cakes served with lentil soup and chutney.','veg',90.00,5,15,NULL,NULL,17,1,1,1,0,0),(23,1,1,'Medu Vada','medu-vada.webp','Crispy lentil fritters with chutney and sambar.','veg',80.00,5,14,NULL,NULL,15,1,1,1,0,0),(24,1,1,'Uttapam','uttapam.webp','Thick rice and lentil pancake topped with onions and tomatoes.','veg',130.00,5,15,NULL,NULL,18,1,1,1,0,0),(25,1,1,'Hyderabadi Chicken Biryani','chicken-hyderabadi-biryani.webp','Fragrant rice cooked with tender meat and aromatic spices.','non-veg',300.00,5,17,NULL,NULL,15,1,1,1,0,0),(26,1,1,'Chicken Manchurian','chicken-manchurian.webp','Juicy chicken balls in a tangy Manchurian sauce.','non-veg',260.00,6,15,NULL,NULL,25,1,1,1,0,0),(27,1,1,'Vegetable Hakka Noodles','vegetable-hakka-noodles.webp','Stir-fried noodles with a mix of vegetables in a savory sauce.','veg',180.00,6,15,NULL,NULL,14,1,1,1,0,0),(28,1,1,'Chilli Paneer','chilli-paneer.webp','Spicy cottage cheese cubes tossed in a tangy Indo-Chinese sauce.','veg',240.00,6,15,NULL,NULL,24,1,1,1,0,0),(29,1,1,'Spring Rolls','spring-rolls.webp','Crispy rolls stuffed with a mix of vegetables and served with tangy dip.','veg',150.00,6,14,NULL,NULL,28,1,1,1,0,0),(30,1,1,'Veg Manchow Soup','vegetable-manchow-soup.webp','Spicy vegetable soup with crispy fried noodles.','veg',120.00,6,14,NULL,NULL,12,1,1,1,0,0),(31,3,3,'Butter Chicken','butter-chicken.webp','Tender chicken cooked in a rich tomato and butter gravy.','non-veg',320.00,7,28,NULL,NULL,24,1,1,1,0,0),(32,3,3,'Paneer Tikka','paneer-tikka.webp','Grilled cottage cheese marinated in spicy yogurt.','veg',250.00,7,27,NULL,NULL,15,1,1,1,0,0),(33,3,3,'Dal Makhani','dal-makhni.webp','Creamy and rich black lentils cooked with butter and spices.','veg',180.00,7,28,NULL,NULL,27,1,1,1,0,0),(34,3,3,'Tandoori Roti','tandoori-roti.webp','Traditional whole wheat bread cooked in a clay oven.','veg',25.00,7,29,NULL,NULL,12,1,1,1,0,0),(35,3,3,'Naan','naan-recipe.webp','Soft and fluffy bread baked in a tandoor.','veg',40.00,7,29,NULL,NULL,11,1,1,1,0,0),(36,3,3,'Masala Dosa','masala-dosa.webp','Crispy rice and lentil crepe filled with spiced mashed potatoes.','veg',120.00,8,28,NULL,NULL,20,1,1,1,0,0),(37,3,3,'Idli Sambar','idli-sambar.webp','Steamed rice cakes served with lentil soup and chutney.','veg',90.00,8,28,NULL,NULL,11,1,1,1,0,0),(38,3,3,'Medu Vada','medu-vada.webp','Crispy lentil fritters with chutney and sambar.','veg',80.00,8,27,NULL,NULL,16,1,1,1,0,0),(39,3,3,'Uttapam','uttapam.webp','Thick rice and lentil pancake topped with onions and tomatoes.','veg',130.00,8,28,NULL,NULL,13,1,1,1,0,0),(40,3,3,'Hyderabadi Chicken Biryani','chicken-hyderabadi-biryani.webp','Fragrant rice cooked with tender meat and aromatic spices.','non-veg',300.00,8,30,NULL,NULL,13,1,1,1,0,0),(41,3,3,'Chicken Manchurian','chicken-manchurian.webp','Juicy chicken balls in a tangy Manchurian sauce.','non-veg',260.00,9,28,NULL,NULL,17,1,1,1,0,0),(42,3,3,'Vegetable Hakka Noodles','vegetable-hakka-noodles.webp','Stir-fried noodles with a mix of vegetables in a savory sauce.','veg',180.00,9,28,NULL,NULL,18,1,1,1,0,0),(43,3,3,'Chilli Paneer','chilli-paneer.webp','Spicy cottage cheese cubes tossed in a tangy Indo-Chinese sauce.','veg',240.00,9,28,NULL,NULL,22,1,1,1,0,0),(44,3,3,'Spring Rolls','spring-rolls.webp','Crispy rolls stuffed with a mix of vegetables and served with tangy dip.','veg',150.00,9,27,NULL,NULL,21,1,1,1,0,0),(45,3,3,'Veg Manchow Soup','vegetable-manchow-soup.webp','Spicy vegetable soup with crispy fried noodles.','veg',120.00,9,27,NULL,NULL,25,1,1,1,0,0),(46,5,5,'Butter Chicken','butter-chicken.webp','Tender chicken cooked in a rich tomato and butter gravy.','non-veg',320.00,10,41,NULL,NULL,17,1,1,1,0,0),(47,5,5,'Paneer Tikka','paneer-tikka.webp','Grilled cottage cheese marinated in spicy yogurt.','veg',250.00,10,40,NULL,NULL,18,1,1,1,0,0),(48,5,5,'Dal Makhani','dal-makhni.webp','Creamy and rich black lentils cooked with butter and spices.','veg',180.00,10,41,NULL,NULL,23,1,1,1,0,0),(49,5,5,'Tandoori Roti','tandoori-roti.webp','Traditional whole wheat bread cooked in a clay oven.','veg',25.00,10,42,NULL,NULL,26,1,1,1,0,0),(50,5,5,'Naan','naan-recipe.webp','Soft and fluffy bread baked in a tandoor.','veg',40.00,10,42,NULL,NULL,16,1,1,1,0,0),(51,5,5,'Masala Dosa','masala-dosa.webp','Crispy rice and lentil crepe filled with spiced mashed potatoes.','veg',120.00,11,41,NULL,NULL,10,1,1,1,0,0),(52,5,5,'Idli Sambar','idli-sambar.webp','Steamed rice cakes served with lentil soup and chutney.','veg',90.00,11,41,NULL,NULL,15,1,1,1,0,0),(53,5,5,'Medu Vada','medu-vada.webp','Crispy lentil fritters with chutney and sambar.','veg',80.00,11,40,NULL,NULL,17,1,1,1,0,0),(54,5,5,'Uttapam','uttapam.webp','Thick rice and lentil pancake topped with onions and tomatoes.','veg',130.00,11,41,NULL,NULL,18,1,1,1,0,0),(55,5,5,'Hyderabadi Chicken Biryani','chicken-hyderabadi-biryani.webp','Fragrant rice cooked with tender meat and aromatic spices.','non-veg',300.00,11,43,NULL,NULL,18,1,1,1,0,0),(56,5,5,'Chicken Manchurian','chicken-manchurian.webp','Juicy chicken balls in a tangy Manchurian sauce.','non-veg',260.00,12,41,NULL,NULL,27,1,1,1,0,0),(57,5,5,'Vegetable Hakka Noodles','vegetable-hakka-noodles.webp','Stir-fried noodles with a mix of vegetables in a savory sauce.','veg',180.00,12,41,NULL,NULL,27,1,1,1,0,0),(58,5,5,'Chilli Paneer','chilli-paneer.webp','Spicy cottage cheese cubes tossed in a tangy Indo-Chinese sauce.','veg',240.00,12,41,NULL,NULL,15,1,1,1,0,0),(59,5,5,'Spring Rolls','spring-rolls.webp','Crispy rolls stuffed with a mix of vegetables and served with tangy dip.','veg',150.00,12,40,NULL,NULL,26,1,1,1,0,0),(60,5,5,'Veg Manchow Soup','vegetable-manchow-soup.webp','Spicy vegetable soup with crispy fried noodles.','veg',120.00,12,40,NULL,NULL,26,1,1,1,0,0),(61,7,7,'Butter Chicken','butter-chicken.webp','Tender chicken cooked in a rich tomato and butter gravy.','non-veg',320.00,13,54,NULL,NULL,29,1,1,1,0,0),(62,7,7,'Paneer Tikka','paneer-tikka.webp','Grilled cottage cheese marinated in spicy yogurt.','veg',250.00,13,53,NULL,NULL,13,1,1,1,0,0),(63,7,7,'Dal Makhani','dal-makhni.webp','Creamy and rich black lentils cooked with butter and spices.','veg',180.00,13,54,NULL,NULL,10,1,1,1,0,0),(64,7,7,'Tandoori Roti','tandoori-roti.webp','Traditional whole wheat bread cooked in a clay oven.','veg',25.00,13,55,NULL,NULL,23,1,1,1,0,0),(65,7,7,'Naan','naan-recipe.webp','Soft and fluffy bread baked in a tandoor.','veg',40.00,13,55,NULL,NULL,25,1,1,1,0,0),(66,7,7,'Masala Dosa','masala-dosa.webp','Crispy rice and lentil crepe filled with spiced mashed potatoes.','veg',120.00,14,54,NULL,NULL,21,1,1,1,0,0),(67,7,7,'Idli Sambar','idli-sambar.webp','Steamed rice cakes served with lentil soup and chutney.','veg',90.00,14,54,NULL,NULL,18,1,1,1,0,0),(68,7,7,'Medu Vada','medu-vada.webp','Crispy lentil fritters with chutney and sambar.','veg',80.00,14,53,NULL,NULL,30,1,1,1,0,0),(69,7,7,'Uttapam','uttapam.webp','Thick rice and lentil pancake topped with onions and tomatoes.','veg',130.00,14,54,NULL,NULL,14,1,1,1,0,0),(70,7,7,'Hyderabadi Chicken Biryani','chicken-hyderabadi-biryani.webp','Fragrant rice cooked with tender meat and aromatic spices.','non-veg',300.00,14,56,NULL,NULL,26,1,1,1,0,0),(71,7,7,'Chicken Manchurian','chicken-manchurian.webp','Juicy chicken balls in a tangy Manchurian sauce.','non-veg',260.00,15,54,NULL,NULL,22,1,1,1,0,0),(72,7,7,'Vegetable Hakka Noodles','vegetable-hakka-noodles.webp','Stir-fried noodles with a mix of vegetables in a savory sauce.','veg',180.00,15,54,NULL,NULL,27,1,1,1,0,0),(73,7,7,'Chilli Paneer','chilli-paneer.webp','Spicy cottage cheese cubes tossed in a tangy Indo-Chinese sauce.','veg',240.00,15,54,NULL,NULL,27,1,1,1,0,0),(74,7,7,'Spring Rolls','spring-rolls.webp','Crispy rolls stuffed with a mix of vegetables and served with tangy dip.','veg',150.00,15,53,NULL,NULL,16,1,1,1,0,0),(75,7,7,'Veg Manchow Soup','vegetable-manchow-soup.webp','Spicy vegetable soup with crispy fried noodles.','veg',120.00,15,53,NULL,NULL,19,1,1,1,0,0);
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned DEFAULT NULL,
  `menu_name` text COLLATE utf8mb4_unicode_ci,
  `sort_order` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menus_branch_id_foreign` (`branch_id`),
  CONSTRAINT `menus_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,1,'{\"en\":\"North Indian Delights\"}',0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(2,1,'{\"en\":\"South Indian Sensations\"}',0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(3,1,'{\"en\":\"Indo-Chinese Fusion\"}',0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(4,1,'{\"en\":\"North Indian Delights\"}',0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(5,1,'{\"en\":\"South Indian Sensations\"}',0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(6,1,'{\"en\":\"Indo-Chinese Fusion\"}',0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(7,3,'{\"en\":\"North Indian Delights\"}',0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(8,3,'{\"en\":\"South Indian Sensations\"}',0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(9,3,'{\"en\":\"Indo-Chinese Fusion\"}',0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(10,5,'{\"en\":\"North Indian Delights\"}',0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(11,5,'{\"en\":\"South Indian Sensations\"}',0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(12,5,'{\"en\":\"Indo-Chinese Fusion\"}',0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(13,7,'{\"en\":\"North Indian Delights\"}',0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(14,7,'{\"en\":\"South Indian Sensations\"}',0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(15,7,'{\"en\":\"Indo-Chinese Fusion\"}',0,'2025-11-30 03:00:37','2025-11-30 03:00:37');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=300 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2014_04_02_193005_create_translations_table',1),(5,'2024_01_01_create_printers_table',1),(6,'2024_03_13_000002_create_expense_categories_table',1),(7,'2024_07_01_060651_add_two_factor_columns_to_users_table',1),(8,'2024_07_01_060707_create_personal_access_tokens_table',1),(9,'2024_07_02_064204_create_menus_table',1),(10,'2024_07_12_070634_create_areas_table',1),(11,'2024_07_16_103816_create_orders_table',1),(12,'2024_07_21_083459_add_user_type_column',1),(13,'2024_07_24_131631_create_payments_table',1),(14,'2024_07_31_081306_add_email_otp_column',1),(15,'2024_08_02_061808_create_countries_table',1),(16,'2024_08_02_071637_create_restaurant_settings_table',1),(17,'2024_08_04_104258_create_razorpay_payments_table',1),(18,'2024_08_05_092258_create_stripe_payments_table',1),(19,'2024_08_05_110157_create_payment_gateway_credentials_table',1),(20,'2024_08_13_033139_create_global_settings_table',1),(21,'2024_08_13_073129_update_settings_add_envato_key',1),(22,'2024_08_13_073129_update_settings_add_support_key',1),(23,'2024_08_14_073129_update_settings_add_email',1),(24,'2024_08_14_073129_update_settings_add_last_verified_key',1),(25,'2024_09_13_081726_create_modules_table',1),(26,'2024_09_14_130619_create_permission_tables',1),(27,'2024_09_27_071339_create_reservations_table',1),(28,'2024_10_02_090924_create_email_settings_table',1),(29,'2024_10_03_073837_create_notification_settings_table',1),(30,'2024_10_11_100539_create_branches_table',1),(31,'2024_10_14_121135_create_onboarding_steps_table',1),(32,'2024_10_15_071238_add_restaurant_hash_column',1),(33,'2024_10_15_071238_storage',1),(34,'2024_10_15_100639_create_restaurant_payments_table',1),(35,'2024_10_27_101326_create_packages_table',1),(36,'2024_11_02_112920_create_language_settings_table',1),(37,'2024_11_02_120314_create_flags_table',1),(38,'2024_11_02_120314_email_settings_table',1),(39,'2024_11_08_071617_add_customer_login_required_column',1),(40,'2024_11_08_093032_create_superadmin_payment_gateways_table',1),(41,'2024_11_08_133506_add_stripe_column_for_license',1),(42,'2024_11_12_055119_create_delivery_executives_table',1),(43,'2024_11_12_055632_add_order_types_column',1),(44,'2024_11_12_060500_create_order_histories_table',1),(45,'2024_11_12_060500_global_license_type_table',1),(46,'2024_11_12_060500_global_purchase_on_table',1),(47,'2024_11_12_060500_global_setting_timezone_table',1),(48,'2024_11_17_052707_currency_position',1),(49,'2024_11_17_052707_move_qr_code',1),(50,'2024_11_19_113852_add_is_active_to_restaurants_table',1),(51,'2024_11_20_114816_add_staff_welcome_email_notification',1),(52,'2024_11_25_061322_create_pusher_settings_table',1),(53,'2024_11_26_090216_create_global_currencies_table',1),(54,'2024_12_03_085842_add_about_us_column',1),(55,'2024_12_03_104817_add_currency_id_packages',1),(56,'2024_12_04_080223_add_allow_customer_delivery_orders',1),(57,'2024_12_04_115601_add_preparation_time_column',1),(58,'2024_12_11_110000_create_tables_for_subscription_table',1),(59,'2024_12_11_131225_add_disable_landing_site_columns',1),(60,'2024_12_12_090840_create_waiter_requests_table',1),(61,'2024_12_13_090840_add_domain_global_setting',1),(62,'2024_12_16_080201_create_lifetime_subscriptions_for_paid_restaurants',1),(63,'2024_12_23_124452_add_payment_enabled_columns_to_payment_settings_table',1),(64,'2024_12_27_054246_add_table_reservation_default_status_to_restaurants_table',1),(65,'2024_12_30_074018_create_split_orders_table',1),(66,'2024_12_30_200942_create_restaurant_settings_table',1),(67,'2025_01_03_050139_add_social_media_links_to_reataurants_table',1),(68,'2025_01_03_093938_add_social_media_links_to_global_settings_table',1),(69,'2025_01_06_111550_create_receipt_settings_table',1),(70,'2025_01_09_073145_generate_qr_codes_for_existing_branches',1),(71,'2025_01_09_115652_update_receipt_settings_for_existing_restaurants',1),(72,'2025_01_10_064103_add_table_required_column_to_customer_settings_table',1),(73,'2025_01_10_100552_insert_to_file_storage_settings_default_values',1),(74,'2025_01_11_063817_add_default_currency_column',1),(75,'2025_01_15_000000_create_cart_header_settings_table',1),(76,'2025_01_15_000001_create_cart_header_images_table',1),(77,'2025_01_16_000000_add_is_header_disabled_to_cart_header_settings_table',1),(78,'2025_01_16_125322_add_is_enabled_to_menu_items_table',1),(79,'2025_01_16_131100_regenrate_qr_codes',1),(80,'2025_01_20_000000_add_restaurant_id_to_roles',1),(81,'2025_01_20_071544_add_branch_limit_to_packages_table',1),(82,'2025_01_20_091630_update_item_type',1),(83,'2025_01_20_125429_add_discount_columns_to_orders_table',1),(84,'2025_01_21_064139_add_show_logo_text_column',1),(85,'2025_01_21_064256_add_offline_payment',1),(86,'2025_01_21_132218_fix_user_roles',1),(87,'2025_01_22_114720_add_show_tax_to_receipt_setting',1),(88,'2025_01_23_065746_create_modifier_groups_table',1),(89,'2025_01_23_085333_create_restaurant_taxes_table',1),(90,'2025_01_23_090554_create_modifier_options_table',1),(91,'2025_01_23_094318_create_item_modifiers_table',1),(92,'2025_01_23_121154_create_order_item_modifier_options_table',1),(93,'2025_01_27_065822_add_balance_column_to_payment',1),(94,'2025_01_28_111039_add_allow_dine_in_orders_to_restaurant',1),(95,'2025_01_30_050755_add_yelp_icon_to_global_settings',1),(96,'2025_01_30_055744_add_yelp_link_to_restaurants',1),(97,'2025_01_30_100556_fix_package_price_length',1),(98,'2025_01_30_104043_add_meta_data_to_global_settings',1),(99,'2025_01_31_000001_create_predefined_amounts_table',1),(100,'2025_02_03_062109_add_is_cash_payment_enabled_to_payment',1),(101,'2025_02_04_140538_add_transaction_id_kot',1),(102,'2025_02_15_121956_add_hide_new_orders_option_to_restaurant',1),(103,'2025_02_17_052801_create_restaurant_charges_settings_table',1),(104,'2025_02_17_093729_add_favicon_to_restaurant',1),(105,'2025_02_19_091730_update_menu_name_to_json',1),(106,'2025_02_20_095321_add_waiter_request_options_to_restaurant',1),(107,'2025_02_21_051534_add_hash_to_global_settings_table',1),(108,'2025_02_21_102116_add_column_to_settings',1),(109,'2025_02_24_063827_add_payment_qr_to_receipt_settings',1),(110,'2025_02_24_111946_add_permissions_to_customers',1),(111,'2025_03_04_114535_add_is_enabled_to_restaurant_charges',1),(112,'2025_03_10_055100_add_tip_column_to_orders_table',1),(113,'2025_03_10_100727_add_is_pwa_intall_alert_show_column_in_restaurants_table',1),(114,'2025_03_17_090450_add_meta_title_to_global_settings',1),(115,'2025_03_18_044410_create_expenses_table',1),(116,'2025_03_19_092459_create_custom_menus_table',1),(117,'2025_03_19_103047_update_additional_modules',1),(118,'2025_03_24_084350_add_show_payments_column_to_receipt_settings_table',1),(119,'2025_04_01_050059_add_branch_id_to_expense_category',1),(120,'2025_04_01_051356_add_branch_id_to_expenses',1),(121,'2025_04_02_071911_update_kot_status_enum',1),(122,'2025_04_07_112351_add_payment_recived_status_to_orders_table',1),(123,'2025_04_08_063624_update_meta_keywords',1),(124,'2025_04_10_065753_add_flutterwave_payment_gateway_columns_and_tables',1),(125,'2025_04_15_084543_create_front_details_table',1),(126,'2025_04_22_065157_create_front_reviews_setting_table',1),(127,'2025_04_22_091055_create_branch_delivery_settings_table',1),(128,'2025_04_22_091146_create_customer_addresses_table',1),(129,'2025_04_22_091223_create_delivery_fee_tiers_table',1),(130,'2025_04_22_091258_add_delivery_columns_to_orders_table',1),(131,'2025_04_29_102014_add_landing_type_column_in_global_settings_table',1),(132,'2025_04_29_114538_add_front_data_in_front_details_table',1),(133,'2025_05_14_094039_update_printers_settings_columns_to_printers_table',1),(134,'2025_05_15_071027_create_kot_places_table',1),(135,'2025_05_23_124746_add_in_stock_column',1),(136,'2025_05_26_105151_relocate_map_api_key_to_superadmin_settings',1),(137,'2025_05_26_114443_modify_kot_places_table',1),(138,'2025_05_30_081624_add_show_item_on_customer_site_to_menu_items',1),(139,'2025_06_02_081928_add_session_driver_column_to_global_settings',1),(140,'2025_06_02_112147_add_columns_to_superadmin_payment_gateways_table',1),(141,'2025_06_02_112903_add_paypal_payment_column_to_payment_gateway_credentials',1),(142,'2025_06_02_113108_create_paypal_payments_table',1),(143,'2025_06_02_114326_add_paypal_payment_in_payment_method_to_payments',1),(144,'2025_06_03_095923_add_status_column_kot_item',1),(145,'2025_06_04_065130_add_columns_payfast_in_superadmin_payment_gateways_table',1),(146,'2025_06_05_063256_add_sort_order_columns_in_menu_and_items',1),(147,'2025_06_05_112055_create_kot_settings_table',1),(148,'2025_06_06_050159_add_payfast_payment_column_to_payment_gateway_credentials',1),(149,'2025_06_06_051204_create_payfast_payments_table',1),(150,'2025_06_10_093131_change_delete_cascade_for_orders',1),(151,'2025_06_11_061716_add_uuid_to_orders_table',1),(152,'2025_06_11_062354_add_columns_paystack_in_superadmin_payment_gateways_table',1),(153,'2025_06_13_112612_add_phone_to_users',1),(154,'2025_06_13_113200_add_column_paystack_payments_to_payment_gateway_credentials',1),(155,'2025_06_13_113240_create_paystack_payments_table',1),(156,'2025_06_16_104533_add_note_columns_to_kot_items_and_order_items',1),(157,'2025_06_18_112425_add_payment_gateways_to_restaurants_table',1),(158,'2025_06_19_070518_add_position_to_custom_menus_table',1),(159,'2025_06_20_060452_add_columns_to_branch_table',1),(160,'2025_06_20_092521_add_others_type_to_payments_table',1),(161,'2025_06_23_101041_create_kot_cancel_reasons_table',1),(162,'2025_06_23_120021_update_kot_place_id_in_menu_items',1),(163,'2025_06_24_092521_disable_printer',1),(164,'2025_06_24_092811_add_column_cancel_kot_reason_to_kots_table',1),(165,'2025_06_24_102830_update_enum_status_to_kots_table',1),(166,'2025_06_25_094311_add_column_cancellation_reason_to_orders_table',1),(167,'2025_06_26_060831_add_custom_delivery_options_to_restaurants_table',1),(168,'2025_06_27_084541_insert_sample_kot_cancel_reasons_data',1),(169,'2025_07_01_112529_create_print_jobs_table',1),(170,'2025_07_01_133114_add_placed_via_column_orders_table',1),(171,'2025_07_02_090709_create_order_types_table',1),(172,'2025_07_02_105440_add_translations_columns_for_modifier_group',1),(173,'2025_07_02_114040_add_unique_hash_to_branches_table',1),(174,'2025_07_03_123829_update_kot_place_id_for_cloned_menu_items',1),(175,'2025_07_04_064350_update_order_type_id_in_orders',1),(176,'2025_07_04_081809_add_tax_mode_to_restaurants_table',1),(177,'2025_07_04_131541_create_desktop_applications_table',1),(178,'2025_07_07_070122_add_pusher_broadcast_to_pusher_settings_table',1),(179,'2025_07_07_110131_create_menu_item_taxes_table',1),(180,'2025_07_14_082950_add_columns_to_restaurants_table',1),(181,'2025_07_14_124125_add_pick_up_date_range_in_restaurants_table',1),(182,'2025_07_17_122331_create_order_number_settings',1),(183,'2025_07_29_063129_modify_item_type_in-menus',1),(184,'2025_07_29_082605_add_show_halal_and_veg_option_to_restaurants',1),(185,'2025_07_30_125616_add_tax_mode_to_orders',1),(186,'2025_08_01_114055_add_reservation_column_to_restaurants_table',1),(187,'2025_08_04_131541_create_desktop_applications_update_table',1),(188,'2025_08_05_081541_modify_split_orders_table_add_bank_transfer',1),(189,'2025_08_06_065323_change_payment_method_to_string_in_payments_table',1),(190,'2025_08_07_033322_add_column_disable_slot_minutes_to_restaurants_table',1),(191,'2025_08_08_115502_add_variation_id_to_item_modifiers',1),(192,'2025_08_12_133228_change_package_description_length',1),(193,'2025_08_13_060315_rename_payfast_columns_in_superadmin_payment_gateways_table',1),(194,'2025_08_13_110934_add_default_expense_categories_to_existing_branches',1),(195,'2025_08_16_110310_add_slot_time_difference_to_reservations',1),(196,'2025_08_19_071639_fix_tax_percent_to_unlimited_decimal',1),(197,'2025_08_19_131541_create_desktop_applications_mac_update_table',1),(198,'2025_08_20_000001_add_quantity_to_split_order_items',1),(199,'2025_08_21_100452_add_html_content_print_job',1),(200,'2025_08_25_050939_add_hide_menu_item_image_columns_to_restaurants_table',1),(201,'2025_08_25_060934_add_xendit_payment_gateway_to_payment_gateway_credentials_table',1),(202,'2025_08_25_061405_add_xendit_to_global_settings_table',1),(203,'2025_08_25_061500_create_xendit_payments_table',1),(204,'2025_08_25_062000_add_xendit_webhook_verification_tokens',1),(205,'2025_08_29_091315_add_phone_code_to_customers_table',1),(206,'2025_09_02_085025_add_xendit_payment_column_to_superadmin_payment_gateways_table',1),(207,'2025_09_02_113846_add_xendit_payments_column_to_packages_table',1),(208,'2025_09_02_130000_create_otps_table',1),(209,'2025_09_11_094443_remove_phone_unique',1),(210,'2025_09_15_100452_remove_extra_content_print_job',1),(211,'2025_09_17_094034_create_cart_session_tables',1),(212,'2025_09_18_051324_add_limit_columns_to_packages_table',1),(213,'2025_09_18_083624_add_table_lock_columns_and_settings',1),(214,'2025_09_23_062535_add_cancel_functionality_to_kot_items_table',1),(215,'2025_09_25_063220_add_xendit_webhook_token_to_superadmin_payment_gateways',1),(216,'2025_09_26_115847_add_token_number_to_orders_table',1),(217,'2025_09_26_115854_add_enable_token_number_to_order_types_table',1),(218,'2025_09_29_095519_create_delivery_platforms_table',1),(219,'2025_10_01_064424_create_menu_item_prices_table',1),(220,'2025_10_07_070000_add_reference_id_to_payment_tables',1),(221,'2025_10_07_094006_add_token_number_to_kots_table',1),(222,'2025_10_07_094018_remove_token_number_from_orders_table',1),(223,'2025_10_08_095954_add_columns_paddle_payment_keys_to_superadmin_payment_gateways',1),(224,'2025_10_08_102000_add_paddle_client_token_columns_to_superadmin_payment_gateways',1),(225,'2025_10_09_041734_add_enable_paddle_to_global_settings_table',1),(226,'2025_10_09_065853_remove_payload_from_print_jobs',1),(227,'2025_10_09_084200_add_package_id_to_restaurant_payments_table',1),(228,'2025_10_09_091500_add_paddle_price_ids_to_packages_table',1),(229,'2025_10_10_100000_add_paddle_webhook_secret_to_superadmin_payment_gateways',1),(230,'2025_10_10_122321_add_privacy_policy_link_to_global_settings_table',1),(231,'2025_10_14_000001_create_modifier_option_prices_table',1),(232,'2025_10_14_071228_add_consent_fields_to_users_table',1),(233,'2025_10_14_105354_add_order_item_id_to_kot_items_table',1),(234,'2025_10_15_045419_sms_count_packages',1),(235,'2025_10_17_074528_add_delivery_app_id_orders_table',1),(236,'2025_10_27_065853_add_from_printer_type',1),(237,'2025_10_28_065738_add_discount_permission_to_existing_roles',1),(238,'2025_10_28_081340_add_multipos_limit_to_packages_table',1),(239,'2025_10_30_055800_add_qr_order_location_columns_to_restaurants_table',1),(240,'2025_11_03_065853_add_from_printer_enum',1),(241,'2025_11_07_065319_add_disable_order_type_popup_to_restaurants_table',1),(242,'2025_11_10_000000_add_show_customer_phone_to_receipt_settings_table',1),(243,'2025_11_10_000001_add_show_payment_status_to_receipt_settings_table',1),(244,'2025_11_10_100652_add_added_by_to_orders_table',1),(245,'2025_11_12_081126_create_table_epay_payments_table',1),(246,'2025_11_13_060849_add_cancelled_by_to_orders_table',1),(247,'2025_11_18_083606_add_modifier_option_prices_column_to_table',1),(248,'2025_12_20_000000_add_cancelled_by_to_kot_items_table',1),(249,'2025_01_15_000000_create_database_backups_table',2),(250,'2025_01_15_000001_create_database_backup_settings_table',2),(251,'2025_09_01_073008_create_global_settings_table',3),(252,'2025_09_16_000001_create_cash_register_module',3),(253,'2025_09_16_000001_create_cash_registers_tables',3),(254,'2025_09_18_000002_add_approval_columns_to_cash_register_sessions',3),(255,'2025_09_20_000003_create_denominations_table',3),(256,'2025_09_26_043532_create_cash_register_settings_table',3),(257,'2025_09_29_120001_add_order_id_to_cash_register_transactions_table',3),(258,'2025_10_08_070529_add_open_register_permission_to_cash_register_module',3),(259,'2025_10_08_080000_rename_cash_register_permissions',3),(260,'2025_10_10_120000_drop_currency_from_denominations',3),(261,'2025_01_01_121040_inventory_global_settings',4),(262,'2025_02_06_095827_create_invetory_module_table',4),(263,'2025_02_12_create_purchase_orders_tables',4),(264,'2025_03_02_181226_create_inventory_settings_table',4),(265,'2025_03_05_100018_create_inventory_settings_table',4),(266,'2025_03_19_113535_soft_delete_supplier',4),(267,'2025_03_20_113535_permission_supplier',4),(268,'2025_07_07_000000_add_variation_support_to_recipes_table',4),(269,'2025_07_07_000001_add_modifier_option_support_to_recipes_table',4),(270,'2025_07_07_000002_make_menu_item_id_nullable_in_recipes_table copy',4),(271,'2025_09_11_000002_update_cascade_purchase_orders_table',4),(272,'2025_08_01_164051_create_kiosk_setting_tables',5),(273,'2025_09_26_164051_create_kiosk_tables',5),(274,'2025_09_26_164052_create_kiosk_promos_tables',5),(275,'2025_10_08_164052_create_kiosks',5),(276,'2025_01_01_121040_kitchen_global_settings',6),(277,'2025_05_19_163251_add_permission_to_kot_places',6),(278,'2025_06_12_094512_add_kitchen_place_id_to_kot',6),(279,'2025_06_16_121348_update_kot_place_id_in_menu_items',6),(280,'2023_10_09_114356_create_language_pack_settings_table',7),(281,'2023_11_02_094141_language_pack_notify_update_global_settings',7),(282,'2023_11_28_094141_language_license_type_update_global_settings',7),(283,'2023_12_19_091940_purchased_on_language_setting_table',7),(284,'2025_01_01_073008_create_global_settings_table',8),(285,'2025_01_15_000001_create_pos_machines_table',8),(286,'2025_01_15_000002_add_pos_machine_id_to_orders_table',8),(287,'2025_01_15_000003_add_pos_machine_id_to_register_sessions_table',8),(288,'2025_01_15_000004_add_pos_machine_request_notification_setting',8),(289,'2025_10_24_100001_create_multi_pos_module',8),(290,'2025_11_07_093246_add_device_id_to_pos_machines_table',8),(291,'2025_11_24_181400_call_activate_command_for_notification_settings',8),(292,'2025_08_25_062431_create_sms_settings_table',9),(293,'2025_08_25_085421_create_sms_permissions_table',9),(294,'2025_08_28_081001_create_sms_notification_settings_table',9),(295,'2025_09_09_045430_create_sms_template_table',9),(296,'2025_09_25_065936_create_sms_usage_logs_table',9),(297,'2025_09_26_055517_add_columns_to_packages_table',9),(298,'2020_04_09_121040_subdomain_settings',10),(299,'2024_11_01_000000_add_sub_domain_in_companies_table',10);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES (1,'App\\Models\\User',1),(2,'App\\Models\\User',2),(4,'App\\Models\\User',3),(6,'App\\Models\\User',5),(10,'App\\Models\\User',5),(14,'App\\Models\\User',5),(8,'App\\Models\\User',6),(12,'App\\Models\\User',7),(16,'App\\Models\\User',8);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modifier_group_translations`
--

DROP TABLE IF EXISTS `modifier_group_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modifier_group_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `modifier_group_id` bigint unsigned NOT NULL,
  `locale` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `modifier_group_translations_modifier_group_id_locale_unique` (`modifier_group_id`,`locale`),
  KEY `modifier_group_translations_locale_index` (`locale`),
  CONSTRAINT `modifier_group_translations_modifier_group_id_foreign` FOREIGN KEY (`modifier_group_id`) REFERENCES `modifier_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modifier_group_translations`
--

LOCK TABLES `modifier_group_translations` WRITE;
/*!40000 ALTER TABLE `modifier_group_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `modifier_group_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modifier_groups`
--

DROP TABLE IF EXISTS `modifier_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modifier_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `modifier_groups_branch_id_foreign` (`branch_id`),
  CONSTRAINT `modifier_groups_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modifier_groups`
--

LOCK TABLES `modifier_groups` WRITE;
/*!40000 ALTER TABLE `modifier_groups` DISABLE KEYS */;
INSERT INTO `modifier_groups` VALUES (1,'Extra Toppings',NULL,1,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(2,'Dips & Sauces',NULL,1,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(3,'Extra Toppings',NULL,1,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(4,'Dips & Sauces',NULL,1,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(5,'Extra Toppings',NULL,3,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(6,'Dips & Sauces',NULL,3,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(7,'Extra Toppings',NULL,5,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(8,'Dips & Sauces',NULL,5,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(9,'Extra Toppings',NULL,7,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(10,'Dips & Sauces',NULL,7,'2025-11-30 03:00:37','2025-11-30 03:00:37');
/*!40000 ALTER TABLE `modifier_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modifier_option_prices`
--

DROP TABLE IF EXISTS `modifier_option_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modifier_option_prices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `modifier_group_id` bigint unsigned NOT NULL,
  `modifier_option_id` bigint unsigned DEFAULT NULL,
  `order_type_id` bigint unsigned DEFAULT NULL,
  `delivery_app_id` bigint unsigned DEFAULT NULL,
  `calculated_price` decimal(16,2) NOT NULL,
  `override_price` decimal(16,2) DEFAULT NULL,
  `final_price` decimal(16,2) NOT NULL DEFAULT '0.00',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `modifier_option_prices_modifier_group_id_foreign` (`modifier_group_id`),
  KEY `modifier_option_prices_modifier_option_id_foreign` (`modifier_option_id`),
  KEY `modifier_option_prices_order_type_id_foreign` (`order_type_id`),
  KEY `modifier_option_prices_delivery_app_id_foreign` (`delivery_app_id`),
  CONSTRAINT `modifier_option_prices_delivery_app_id_foreign` FOREIGN KEY (`delivery_app_id`) REFERENCES `delivery_platforms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `modifier_option_prices_modifier_group_id_foreign` FOREIGN KEY (`modifier_group_id`) REFERENCES `modifier_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `modifier_option_prices_modifier_option_id_foreign` FOREIGN KEY (`modifier_option_id`) REFERENCES `modifier_options` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `modifier_option_prices_order_type_id_foreign` FOREIGN KEY (`order_type_id`) REFERENCES `order_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modifier_option_prices`
--

LOCK TABLES `modifier_option_prices` WRITE;
/*!40000 ALTER TABLE `modifier_option_prices` DISABLE KEYS */;
/*!40000 ALTER TABLE `modifier_option_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modifier_options`
--

DROP TABLE IF EXISTS `modifier_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modifier_options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `modifier_group_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `price` decimal(16,2) NOT NULL,
  `is_available` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int NOT NULL DEFAULT '0',
  `is_preselected` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `modifier_options_modifier_group_id_foreign` (`modifier_group_id`),
  CONSTRAINT `modifier_options_modifier_group_id_foreign` FOREIGN KEY (`modifier_group_id`) REFERENCES `modifier_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modifier_options`
--

LOCK TABLES `modifier_options` WRITE;
/*!40000 ALTER TABLE `modifier_options` DISABLE KEYS */;
INSERT INTO `modifier_options` VALUES (1,1,'{\"en\":\"Extra Paneer\"}',1.50,1,0,0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(2,1,'{\"en\":\"Shredded Cheese\"}',1.00,1,0,0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(3,1,'{\"en\":\"Caramelized Onions\"}',0.75,1,0,0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(4,1,'{\"en\":\"Grilled Mushrooms\"}',1.25,1,0,0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(5,2,'{\"en\":\"Garlic Aioli\"}',0.50,1,0,0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(6,2,'{\"en\":\"Spicy Mayo\"}',0.50,1,0,0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(7,2,'{\"en\":\"Mint Chutney\"}',0.75,1,0,0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(8,2,'{\"en\":\"Tamarind Sauce\"}',0.75,1,0,0,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(9,3,'{\"en\":\"Extra Paneer\"}',1.50,1,0,0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(10,3,'{\"en\":\"Shredded Cheese\"}',1.00,1,0,0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(11,3,'{\"en\":\"Caramelized Onions\"}',0.75,1,0,0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(12,3,'{\"en\":\"Grilled Mushrooms\"}',1.25,1,0,0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(13,4,'{\"en\":\"Garlic Aioli\"}',0.50,1,0,0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(14,4,'{\"en\":\"Spicy Mayo\"}',0.50,1,0,0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(15,4,'{\"en\":\"Mint Chutney\"}',0.75,1,0,0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(16,4,'{\"en\":\"Tamarind Sauce\"}',0.75,1,0,0,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(17,5,'{\"en\":\"Extra Paneer\"}',1.50,1,0,0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(18,5,'{\"en\":\"Shredded Cheese\"}',1.00,1,0,0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(19,5,'{\"en\":\"Caramelized Onions\"}',0.75,1,0,0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(20,5,'{\"en\":\"Grilled Mushrooms\"}',1.25,1,0,0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(21,6,'{\"en\":\"Garlic Aioli\"}',0.50,1,0,0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(22,6,'{\"en\":\"Spicy Mayo\"}',0.50,1,0,0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(23,6,'{\"en\":\"Mint Chutney\"}',0.75,1,0,0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(24,6,'{\"en\":\"Tamarind Sauce\"}',0.75,1,0,0,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(25,7,'{\"en\":\"Extra Paneer\"}',1.50,1,0,0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(26,7,'{\"en\":\"Shredded Cheese\"}',1.00,1,0,0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(27,7,'{\"en\":\"Caramelized Onions\"}',0.75,1,0,0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(28,7,'{\"en\":\"Grilled Mushrooms\"}',1.25,1,0,0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(29,8,'{\"en\":\"Garlic Aioli\"}',0.50,1,0,0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(30,8,'{\"en\":\"Spicy Mayo\"}',0.50,1,0,0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(31,8,'{\"en\":\"Mint Chutney\"}',0.75,1,0,0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(32,8,'{\"en\":\"Tamarind Sauce\"}',0.75,1,0,0,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(33,9,'{\"en\":\"Extra Paneer\"}',1.50,1,0,0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(34,9,'{\"en\":\"Shredded Cheese\"}',1.00,1,0,0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(35,9,'{\"en\":\"Caramelized Onions\"}',0.75,1,0,0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(36,9,'{\"en\":\"Grilled Mushrooms\"}',1.25,1,0,0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(37,10,'{\"en\":\"Garlic Aioli\"}',0.50,1,0,0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(38,10,'{\"en\":\"Spicy Mayo\"}',0.50,1,0,0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(39,10,'{\"en\":\"Mint Chutney\"}',0.75,1,0,0,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(40,10,'{\"en\":\"Tamarind Sauce\"}',0.75,1,0,0,'2025-11-30 03:00:37','2025-11-30 03:00:37');
/*!40000 ALTER TABLE `modifier_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modules` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules`
--

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` VALUES (1,'Menu',NULL,NULL),(2,'Menu Item',NULL,NULL),(3,'Item Category',NULL,NULL),(4,'Area',NULL,NULL),(5,'Table',NULL,NULL),(6,'Reservation',NULL,NULL),(7,'KOT',NULL,NULL),(8,'Order',NULL,NULL),(9,'Customer',NULL,NULL),(10,'Staff',NULL,NULL),(11,'Payment',NULL,NULL),(12,'Report',NULL,NULL),(13,'Settings',NULL,NULL),(14,'Delivery Executive',NULL,NULL),(15,'Waiter Request',NULL,NULL),(16,'Expense',NULL,NULL),(17,'Menu',NULL,NULL),(18,'Menu Item',NULL,NULL),(19,'Item Category',NULL,NULL),(20,'Area',NULL,NULL),(21,'Table',NULL,NULL),(22,'Reservation',NULL,NULL),(23,'KOT',NULL,NULL),(24,'Order',NULL,NULL),(25,'Customer',NULL,NULL),(26,'Staff',NULL,NULL),(27,'Payment',NULL,NULL),(28,'Report',NULL,NULL),(29,'Settings',NULL,NULL),(30,'Delivery Executive',NULL,NULL),(31,'Waiter Request',NULL,NULL),(32,'Expense',NULL,NULL),(33,'Menu',NULL,NULL),(34,'Menu Item',NULL,NULL),(35,'Item Category',NULL,NULL),(36,'Area',NULL,NULL),(37,'Table',NULL,NULL),(38,'Reservation',NULL,NULL),(39,'KOT',NULL,NULL),(40,'Order',NULL,NULL),(41,'Customer',NULL,NULL),(42,'Staff',NULL,NULL),(43,'Payment',NULL,NULL),(44,'Report',NULL,NULL),(45,'Settings',NULL,NULL),(46,'Delivery Executive',NULL,NULL),(47,'Waiter Request',NULL,NULL),(48,'Expense',NULL,NULL),(49,'Menu',NULL,NULL),(50,'Menu Item',NULL,NULL),(51,'Item Category',NULL,NULL),(52,'Area',NULL,NULL),(53,'Table',NULL,NULL),(54,'Reservation',NULL,NULL),(55,'KOT',NULL,NULL),(56,'Order',NULL,NULL),(57,'Customer',NULL,NULL),(58,'Staff',NULL,NULL),(59,'Payment',NULL,NULL),(60,'Report',NULL,NULL),(61,'Settings',NULL,NULL),(62,'Delivery Executive',NULL,NULL),(63,'Waiter Request',NULL,NULL),(64,'Expense',NULL,NULL),(65,'Menu',NULL,NULL),(66,'Menu Item',NULL,NULL),(67,'Item Category',NULL,NULL),(68,'Area',NULL,NULL),(69,'Table',NULL,NULL),(70,'Reservation',NULL,NULL),(71,'KOT',NULL,NULL),(72,'Order',NULL,NULL),(73,'Customer',NULL,NULL),(74,'Staff',NULL,NULL),(75,'Payment',NULL,NULL),(76,'Report',NULL,NULL),(77,'Settings',NULL,NULL),(78,'Delivery Executive',NULL,NULL),(79,'Waiter Request',NULL,NULL),(80,'Expense',NULL,NULL),(81,'Menu',NULL,NULL),(82,'Menu Item',NULL,NULL),(83,'Item Category',NULL,NULL),(84,'Area',NULL,NULL),(85,'Table',NULL,NULL),(86,'Reservation',NULL,NULL),(87,'KOT',NULL,NULL),(88,'Order',NULL,NULL),(89,'Customer',NULL,NULL),(90,'Staff',NULL,NULL),(91,'Payment',NULL,NULL),(92,'Report',NULL,NULL),(93,'Settings',NULL,NULL),(94,'Delivery Executive',NULL,NULL),(95,'Waiter Request',NULL,NULL),(96,'Expense',NULL,NULL),(97,'Cash Register','2025-11-30 04:19:22','2025-11-30 04:19:22'),(98,'Inventory','2025-11-30 04:19:29','2025-11-30 04:19:29'),(99,'Kiosk','2025-11-30 04:19:33','2025-11-30 04:19:33'),(100,'Kitchen','2025-11-30 04:19:36','2025-11-30 04:19:36'),(101,'MultiPOS','2025-11-30 04:19:42','2025-11-30 04:19:42'),(102,'Sms','2025-11-30 04:19:45','2025-11-30 04:19:45'),(103,'LanguagePack','2025-12-02 10:20:09','2025-12-02 10:20:09');
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `multi_pos_global_settings`
--

DROP TABLE IF EXISTS `multi_pos_global_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `multi_pos_global_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `purchase_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supported_until` timestamp NULL DEFAULT NULL,
  `purchased_on` timestamp NULL DEFAULT NULL,
  `license_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notify_update` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multi_pos_global_settings`
--

LOCK TABLES `multi_pos_global_settings` WRITE;
/*!40000 ALTER TABLE `multi_pos_global_settings` DISABLE KEYS */;
INSERT INTO `multi_pos_global_settings` VALUES (1,NULL,NULL,NULL,NULL,1,'2025-11-30 04:19:41','2025-11-30 04:19:41');
/*!40000 ALTER TABLE `multi_pos_global_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_settings`
--

DROP TABLE IF EXISTS `notification_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `send_email` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_settings_restaurant_id_foreign` (`restaurant_id`),
  CONSTRAINT `notification_settings_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_settings`
--

LOCK TABLES `notification_settings` WRITE;
/*!40000 ALTER TABLE `notification_settings` DISABLE KEYS */;
INSERT INTO `notification_settings` VALUES (1,1,'order_received',1,NULL,NULL),(2,1,'reservation_confirmed',1,NULL,NULL),(3,1,'new_reservation',1,NULL,NULL),(4,1,'order_bill_sent',1,NULL,NULL),(5,1,'staff_welcome',1,NULL,NULL),(6,2,'order_received',1,NULL,NULL),(7,2,'reservation_confirmed',1,NULL,NULL),(8,2,'new_reservation',1,NULL,NULL),(9,2,'order_bill_sent',1,NULL,NULL),(10,2,'staff_welcome',1,NULL,NULL),(11,3,'order_received',1,NULL,NULL),(12,3,'reservation_confirmed',1,NULL,NULL),(13,3,'new_reservation',1,NULL,NULL),(14,3,'order_bill_sent',1,NULL,NULL),(15,3,'staff_welcome',1,NULL,NULL),(16,4,'order_received',1,NULL,NULL),(17,4,'reservation_confirmed',1,NULL,NULL),(18,4,'new_reservation',1,NULL,NULL),(19,4,'order_bill_sent',1,NULL,NULL),(20,4,'staff_welcome',1,NULL,NULL),(21,1,'pos_machine_request',1,'2025-11-30 04:19:42','2025-11-30 04:19:42'),(22,2,'pos_machine_request',1,'2025-11-30 04:19:42','2025-11-30 04:19:42'),(23,3,'pos_machine_request',1,'2025-11-30 04:19:42','2025-11-30 04:19:42'),(24,4,'pos_machine_request',1,'2025-11-30 04:19:42','2025-11-30 04:19:42');
/*!40000 ALTER TABLE `notification_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offline_payment_methods`
--

DROP TABLE IF EXISTS `offline_payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offline_payment_methods` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `offline_payment_methods_restaurant_id_foreign` (`restaurant_id`),
  CONSTRAINT `offline_payment_methods_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offline_payment_methods`
--

LOCK TABLES `offline_payment_methods` WRITE;
/*!40000 ALTER TABLE `offline_payment_methods` DISABLE KEYS */;
/*!40000 ALTER TABLE `offline_payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offline_plan_changes`
--

DROP TABLE IF EXISTS `offline_plan_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offline_plan_changes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `package_id` bigint unsigned NOT NULL,
  `package_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `pay_date` date DEFAULT NULL,
  `next_pay_date` date DEFAULT NULL,
  `invoice_id` bigint unsigned DEFAULT NULL,
  `offline_method_id` bigint unsigned DEFAULT NULL,
  `file_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('verified','pending','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `remark` text COLLATE utf8mb4_unicode_ci,
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `offline_plan_changes_restaurant_id_foreign` (`restaurant_id`),
  KEY `offline_plan_changes_package_id_foreign` (`package_id`),
  KEY `offline_plan_changes_invoice_id_foreign` (`invoice_id`),
  KEY `offline_plan_changes_offline_method_id_foreign` (`offline_method_id`),
  CONSTRAINT `offline_plan_changes_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `global_invoices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `offline_plan_changes_offline_method_id_foreign` FOREIGN KEY (`offline_method_id`) REFERENCES `offline_payment_methods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `offline_plan_changes_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `offline_plan_changes_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offline_plan_changes`
--

LOCK TABLES `offline_plan_changes` WRITE;
/*!40000 ALTER TABLE `offline_plan_changes` DISABLE KEYS */;
/*!40000 ALTER TABLE `offline_plan_changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `onboarding_steps`
--

DROP TABLE IF EXISTS `onboarding_steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `onboarding_steps` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned NOT NULL,
  `add_area_completed` tinyint(1) NOT NULL DEFAULT '0',
  `add_table_completed` tinyint(1) NOT NULL DEFAULT '0',
  `add_menu_completed` tinyint(1) NOT NULL DEFAULT '0',
  `add_menu_items_completed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `onboarding_steps_branch_id_foreign` (`branch_id`),
  CONSTRAINT `onboarding_steps_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `onboarding_steps`
--

LOCK TABLES `onboarding_steps` WRITE;
/*!40000 ALTER TABLE `onboarding_steps` DISABLE KEYS */;
INSERT INTO `onboarding_steps` VALUES (1,1,1,1,1,1,'2025-11-30 02:57:23','2025-11-30 03:00:25'),(2,1,1,1,1,1,'2025-11-30 02:57:23','2025-11-30 03:00:25'),(3,2,0,0,0,0,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(4,2,0,0,0,0,'2025-11-30 02:57:24','2025-11-30 02:57:24'),(5,3,1,1,1,1,'2025-11-30 02:59:34','2025-11-30 03:00:30'),(6,3,1,1,1,1,'2025-11-30 02:59:34','2025-11-30 03:00:30'),(7,4,0,0,0,0,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(8,4,0,0,0,0,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(9,5,1,1,1,1,'2025-11-30 02:59:54','2025-11-30 03:00:34'),(10,5,1,1,1,1,'2025-11-30 02:59:54','2025-11-30 03:00:34'),(11,6,0,0,0,0,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(12,6,0,0,0,0,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(13,7,1,1,1,1,'2025-11-30 03:00:19','2025-11-30 03:00:39'),(14,7,1,1,1,1,'2025-11-30 03:00:19','2025-11-30 03:00:39'),(15,8,0,0,0,0,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(16,8,0,0,0,0,'2025-11-30 03:00:20','2025-11-30 03:00:20');
/*!40000 ALTER TABLE `onboarding_steps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_charges`
--

DROP TABLE IF EXISTS `order_charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_charges` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `charge_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_charges_order_id_foreign` (`order_id`),
  KEY `order_charges_charge_id_foreign` (`charge_id`),
  CONSTRAINT `order_charges_charge_id_foreign` FOREIGN KEY (`charge_id`) REFERENCES `restaurant_charges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_charges_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_charges`
--

LOCK TABLES `order_charges` WRITE;
/*!40000 ALTER TABLE `order_charges` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_charges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_histories`
--

DROP TABLE IF EXISTS `order_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_histories_order_id_foreign` (`order_id`),
  CONSTRAINT `order_histories_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_histories`
--

LOCK TABLES `order_histories` WRITE;
/*!40000 ALTER TABLE `order_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item_modifier_options`
--

DROP TABLE IF EXISTS `order_item_modifier_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item_modifier_options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_item_id` bigint unsigned NOT NULL,
  `modifier_option_id` bigint unsigned DEFAULT NULL,
  `modifier_option_name` text COLLATE utf8mb4_unicode_ci,
  `modifier_option_price` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_item_modifier_options_order_item_id_foreign` (`order_item_id`),
  KEY `order_item_modifier_options_modifier_option_id_foreign` (`modifier_option_id`),
  CONSTRAINT `order_item_modifier_options_modifier_option_id_foreign` FOREIGN KEY (`modifier_option_id`) REFERENCES `modifier_options` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `order_item_modifier_options_order_item_id_foreign` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item_modifier_options`
--

LOCK TABLES `order_item_modifier_options` WRITE;
/*!40000 ALTER TABLE `order_item_modifier_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_item_modifier_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned DEFAULT NULL,
  `order_id` bigint unsigned NOT NULL,
  `transaction_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `menu_item_id` bigint unsigned NOT NULL,
  `menu_item_variation_id` bigint unsigned DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `quantity` int NOT NULL,
  `price` decimal(16,2) NOT NULL,
  `amount` decimal(16,2) NOT NULL,
  `tax_amount` decimal(15,2) DEFAULT NULL,
  `tax_percentage` decimal(8,4) DEFAULT NULL,
  `tax_breakup` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  KEY `order_items_menu_item_id_foreign` (`menu_item_id`),
  KEY `order_items_menu_item_variation_id_foreign` (`menu_item_variation_id`),
  KEY `order_items_branch_id_foreign` (`branch_id`),
  CONSTRAINT `order_items_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_items_menu_item_id_foreign` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_menu_item_variation_id_foreign` FOREIGN KEY (`menu_item_variation_id`) REFERENCES `menu_item_variations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,1,NULL,2,NULL,NULL,2,250.00,500.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(2,1,1,NULL,8,NULL,NULL,1,80.00,80.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(3,1,2,NULL,9,NULL,NULL,2,130.00,260.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(4,1,2,NULL,11,NULL,NULL,3,260.00,780.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(5,1,3,NULL,1,NULL,NULL,2,320.00,640.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(6,1,3,NULL,2,NULL,NULL,2,250.00,500.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(7,1,4,NULL,11,NULL,NULL,2,260.00,520.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(8,1,4,NULL,12,NULL,NULL,1,180.00,180.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(9,1,4,NULL,8,NULL,NULL,2,80.00,160.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(10,1,4,NULL,7,NULL,NULL,2,90.00,180.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(11,1,4,NULL,13,NULL,NULL,2,240.00,480.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(12,1,5,NULL,12,NULL,NULL,3,180.00,540.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(13,1,5,NULL,6,NULL,NULL,3,120.00,360.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(14,1,5,NULL,10,NULL,NULL,2,300.00,600.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(15,1,5,NULL,9,NULL,NULL,2,130.00,260.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(16,1,5,NULL,1,NULL,NULL,1,320.00,320.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(17,1,6,NULL,7,NULL,NULL,1,90.00,90.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(18,1,6,NULL,11,NULL,NULL,2,260.00,520.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(19,1,6,NULL,4,NULL,NULL,1,25.00,25.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(20,1,6,NULL,5,NULL,NULL,1,40.00,40.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(21,1,6,NULL,10,NULL,NULL,1,300.00,300.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(22,1,7,NULL,4,NULL,NULL,1,25.00,25.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(23,1,7,NULL,9,NULL,NULL,1,130.00,130.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(24,1,7,NULL,8,NULL,NULL,1,80.00,80.00,NULL,NULL,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(25,1,8,NULL,8,NULL,NULL,3,80.00,240.00,NULL,NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(26,1,9,NULL,2,NULL,NULL,1,250.00,250.00,NULL,NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(27,1,9,NULL,13,NULL,NULL,3,240.00,720.00,NULL,NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(28,1,9,NULL,4,NULL,NULL,1,25.00,25.00,NULL,NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(29,1,9,NULL,5,NULL,NULL,1,40.00,40.00,NULL,NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(30,1,10,NULL,9,NULL,NULL,3,130.00,390.00,NULL,NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(31,1,10,NULL,3,NULL,NULL,3,180.00,540.00,NULL,NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(32,1,11,NULL,5,NULL,NULL,3,40.00,120.00,NULL,NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(33,1,11,NULL,15,NULL,NULL,3,120.00,360.00,NULL,NULL,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(34,1,12,NULL,20,NULL,NULL,1,40.00,40.00,NULL,NULL,NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(35,1,12,NULL,24,NULL,NULL,2,130.00,260.00,NULL,NULL,NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(36,1,12,NULL,19,NULL,NULL,2,25.00,50.00,NULL,NULL,NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(37,1,12,NULL,27,NULL,NULL,2,180.00,360.00,NULL,NULL,NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(38,1,13,NULL,6,NULL,NULL,3,120.00,360.00,NULL,NULL,NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(39,1,14,NULL,15,NULL,NULL,3,120.00,360.00,NULL,NULL,NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(40,1,15,NULL,29,NULL,NULL,3,150.00,450.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(41,1,15,NULL,12,NULL,NULL,3,180.00,540.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(42,1,15,NULL,6,NULL,NULL,1,120.00,120.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(43,1,16,NULL,1,NULL,NULL,1,320.00,320.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(44,1,16,NULL,7,NULL,NULL,3,90.00,270.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(45,1,16,NULL,4,NULL,NULL,2,25.00,50.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(46,1,16,NULL,6,NULL,NULL,3,120.00,360.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(47,1,17,NULL,9,NULL,NULL,1,130.00,130.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(48,1,18,NULL,17,NULL,NULL,2,250.00,500.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(49,1,18,NULL,9,NULL,NULL,2,130.00,260.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(50,1,18,NULL,16,NULL,NULL,2,320.00,640.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(51,1,19,NULL,14,NULL,NULL,3,150.00,450.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(52,1,19,NULL,19,NULL,NULL,2,25.00,50.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(53,1,19,NULL,10,NULL,NULL,3,300.00,900.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(54,1,19,NULL,29,NULL,NULL,1,150.00,150.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(55,1,19,NULL,18,NULL,NULL,1,180.00,180.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(56,1,20,NULL,4,NULL,NULL,1,25.00,25.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(57,1,20,NULL,6,NULL,NULL,1,120.00,120.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(58,1,20,NULL,15,NULL,NULL,2,120.00,240.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(59,1,20,NULL,28,NULL,NULL,1,240.00,240.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(60,1,20,NULL,1,NULL,NULL,3,320.00,960.00,NULL,NULL,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(61,1,21,NULL,19,NULL,NULL,1,25.00,25.00,NULL,NULL,NULL,'2025-11-30 03:00:25','2025-11-30 03:00:25'),(62,1,22,NULL,20,NULL,NULL,3,40.00,120.00,NULL,NULL,NULL,'2025-11-30 03:00:25','2025-11-30 03:00:25'),(63,1,22,NULL,18,NULL,NULL,1,180.00,180.00,NULL,NULL,NULL,'2025-11-30 03:00:25','2025-11-30 03:00:25'),(64,1,22,NULL,30,NULL,NULL,2,120.00,240.00,NULL,NULL,NULL,'2025-11-30 03:00:25','2025-11-30 03:00:25'),(65,1,22,NULL,6,NULL,NULL,3,120.00,360.00,NULL,NULL,NULL,'2025-11-30 03:00:25','2025-11-30 03:00:25'),(66,3,23,NULL,33,NULL,NULL,1,180.00,180.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(67,3,23,NULL,40,NULL,NULL,2,300.00,600.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(68,3,24,NULL,42,NULL,NULL,2,180.00,360.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(69,3,24,NULL,31,NULL,NULL,3,320.00,960.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(70,3,24,NULL,43,NULL,NULL,3,240.00,720.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(71,3,24,NULL,39,NULL,NULL,3,130.00,390.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(72,3,24,NULL,44,NULL,NULL,3,150.00,450.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(73,3,25,NULL,38,NULL,NULL,2,80.00,160.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(74,3,25,NULL,35,NULL,NULL,3,40.00,120.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(75,3,25,NULL,32,NULL,NULL,1,250.00,250.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(76,3,25,NULL,40,NULL,NULL,1,300.00,300.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(77,3,25,NULL,34,NULL,NULL,2,25.00,50.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(78,3,26,NULL,33,NULL,NULL,1,180.00,180.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(79,3,26,NULL,45,NULL,NULL,1,120.00,120.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(80,3,26,NULL,44,NULL,NULL,3,150.00,450.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(81,3,26,NULL,34,NULL,NULL,3,25.00,75.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(82,3,26,NULL,35,NULL,NULL,1,40.00,40.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(83,3,27,NULL,36,NULL,NULL,1,120.00,120.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(84,3,27,NULL,45,NULL,NULL,2,120.00,240.00,NULL,NULL,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(85,3,28,NULL,38,NULL,NULL,3,80.00,240.00,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(86,3,28,NULL,35,NULL,NULL,2,40.00,80.00,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(87,3,29,NULL,35,NULL,NULL,1,40.00,40.00,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(88,3,29,NULL,33,NULL,NULL,1,180.00,180.00,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(89,3,29,NULL,41,NULL,NULL,1,260.00,260.00,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(90,3,29,NULL,44,NULL,NULL,1,150.00,150.00,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(91,3,30,NULL,42,NULL,NULL,1,180.00,180.00,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(92,3,30,NULL,37,NULL,NULL,2,90.00,180.00,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(93,3,30,NULL,34,NULL,NULL,2,25.00,50.00,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(94,3,30,NULL,43,NULL,NULL,3,240.00,720.00,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(95,3,31,NULL,45,NULL,NULL,3,120.00,360.00,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(96,3,32,NULL,34,NULL,NULL,3,25.00,75.00,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(97,3,32,NULL,35,NULL,NULL,3,40.00,120.00,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(98,3,32,NULL,33,NULL,NULL,2,180.00,360.00,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(99,3,32,NULL,32,NULL,NULL,1,250.00,250.00,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(100,3,33,NULL,31,NULL,NULL,1,320.00,320.00,NULL,NULL,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(101,5,34,NULL,49,NULL,NULL,2,25.00,50.00,NULL,NULL,NULL,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(102,5,34,NULL,50,NULL,NULL,2,40.00,80.00,NULL,NULL,NULL,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(103,5,34,NULL,47,NULL,NULL,3,250.00,750.00,NULL,NULL,NULL,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(104,5,34,NULL,58,NULL,NULL,3,240.00,720.00,NULL,NULL,NULL,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(105,5,34,NULL,51,NULL,NULL,3,120.00,360.00,NULL,NULL,NULL,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(106,5,35,NULL,48,NULL,NULL,2,180.00,360.00,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(107,5,35,NULL,50,NULL,NULL,1,40.00,40.00,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(108,5,35,NULL,54,NULL,NULL,2,130.00,260.00,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(109,5,35,NULL,55,NULL,NULL,3,300.00,900.00,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(110,5,36,NULL,57,NULL,NULL,1,180.00,180.00,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(111,5,37,NULL,51,NULL,NULL,1,120.00,120.00,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(112,5,37,NULL,59,NULL,NULL,2,150.00,300.00,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(113,5,37,NULL,49,NULL,NULL,2,25.00,50.00,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(114,5,38,NULL,53,NULL,NULL,1,80.00,80.00,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(115,5,38,NULL,58,NULL,NULL,3,240.00,720.00,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(116,5,38,NULL,52,NULL,NULL,3,90.00,270.00,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(117,5,39,NULL,53,NULL,NULL,2,80.00,160.00,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(118,5,39,NULL,50,NULL,NULL,1,40.00,40.00,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(119,5,39,NULL,58,NULL,NULL,2,240.00,480.00,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(120,5,40,NULL,59,NULL,NULL,3,150.00,450.00,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(121,5,41,NULL,49,NULL,NULL,2,25.00,50.00,NULL,NULL,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(122,5,41,NULL,52,NULL,NULL,2,90.00,180.00,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(123,5,41,NULL,50,NULL,NULL,1,40.00,40.00,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(124,5,42,NULL,60,NULL,NULL,3,120.00,360.00,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(125,5,42,NULL,53,NULL,NULL,1,80.00,80.00,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(126,5,42,NULL,57,NULL,NULL,2,180.00,360.00,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(127,5,43,NULL,52,NULL,NULL,2,90.00,180.00,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(128,5,43,NULL,47,NULL,NULL,1,250.00,250.00,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(129,5,43,NULL,55,NULL,NULL,1,300.00,300.00,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(130,5,43,NULL,46,NULL,NULL,2,320.00,640.00,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(131,5,43,NULL,53,NULL,NULL,2,80.00,160.00,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(132,5,44,NULL,55,NULL,NULL,3,300.00,900.00,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(133,5,44,NULL,47,NULL,NULL,1,250.00,250.00,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(134,5,44,NULL,48,NULL,NULL,3,180.00,540.00,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(135,5,44,NULL,46,NULL,NULL,3,320.00,960.00,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(136,5,44,NULL,57,NULL,NULL,2,180.00,360.00,NULL,NULL,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(137,7,45,NULL,66,NULL,NULL,3,120.00,360.00,NULL,NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(138,7,45,NULL,68,NULL,NULL,3,80.00,240.00,NULL,NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(139,7,46,NULL,65,NULL,NULL,3,40.00,120.00,NULL,NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(140,7,46,NULL,69,NULL,NULL,1,130.00,130.00,NULL,NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(141,7,46,NULL,72,NULL,NULL,2,180.00,360.00,NULL,NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(142,7,47,NULL,73,NULL,NULL,1,240.00,240.00,NULL,NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(143,7,47,NULL,65,NULL,NULL,1,40.00,40.00,NULL,NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(144,7,48,NULL,63,NULL,NULL,2,180.00,360.00,NULL,NULL,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(145,7,49,NULL,68,NULL,NULL,3,80.00,240.00,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(146,7,49,NULL,66,NULL,NULL,3,120.00,360.00,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(147,7,50,NULL,65,NULL,NULL,2,40.00,80.00,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(148,7,50,NULL,64,NULL,NULL,2,25.00,50.00,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(149,7,50,NULL,75,NULL,NULL,1,120.00,120.00,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(150,7,51,NULL,72,NULL,NULL,1,180.00,180.00,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(151,7,51,NULL,62,NULL,NULL,2,250.00,500.00,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(152,7,51,NULL,63,NULL,NULL,2,180.00,360.00,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(153,7,51,NULL,67,NULL,NULL,1,90.00,90.00,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(154,7,51,NULL,75,NULL,NULL,1,120.00,120.00,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(155,7,52,NULL,64,NULL,NULL,1,25.00,25.00,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(156,7,52,NULL,68,NULL,NULL,2,80.00,160.00,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(157,7,52,NULL,65,NULL,NULL,1,40.00,40.00,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(158,7,52,NULL,63,NULL,NULL,1,180.00,180.00,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(159,7,53,NULL,70,NULL,NULL,2,300.00,600.00,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(160,7,53,NULL,74,NULL,NULL,1,150.00,150.00,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(161,7,54,NULL,64,NULL,NULL,3,25.00,75.00,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(162,7,54,NULL,62,NULL,NULL,1,250.00,250.00,NULL,NULL,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(163,7,55,NULL,61,NULL,NULL,2,320.00,640.00,NULL,NULL,NULL,'2025-11-30 03:00:39','2025-11-30 03:00:39'),(164,7,55,NULL,73,NULL,NULL,3,240.00,720.00,NULL,NULL,NULL,'2025-11-30 03:00:39','2025-11-30 03:00:39'),(165,7,55,NULL,70,NULL,NULL,1,300.00,300.00,NULL,NULL,NULL,'2025-11-30 03:00:39','2025-11-30 03:00:39'),(166,7,55,NULL,74,NULL,NULL,3,150.00,450.00,NULL,NULL,NULL,'2025-11-30 03:00:39','2025-11-30 03:00:39');
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_number_settings`
--

DROP TABLE IF EXISTS `order_number_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_number_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned NOT NULL,
  `enable_feature` tinyint(1) NOT NULL DEFAULT '0',
  `prefix` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ORD',
  `digits` tinyint unsigned NOT NULL DEFAULT '3',
  `separator` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-',
  `include_date` tinyint(1) NOT NULL DEFAULT '0',
  `show_year` tinyint(1) NOT NULL DEFAULT '0',
  `show_month` tinyint(1) NOT NULL DEFAULT '0',
  `show_day` tinyint(1) NOT NULL DEFAULT '0',
  `show_time` tinyint(1) NOT NULL DEFAULT '0',
  `reset_daily` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_number_settings_branch_id_foreign` (`branch_id`),
  CONSTRAINT `order_number_settings_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_number_settings`
--

LOCK TABLES `order_number_settings` WRITE;
/*!40000 ALTER TABLE `order_number_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_number_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_places`
--

DROP TABLE IF EXISTS `order_places`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_places` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `printer_id` bigint unsigned DEFAULT NULL,
  `branch_id` bigint unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_places_branch_id_foreign` (`branch_id`),
  KEY `order_places_printer_id_foreign` (`printer_id`),
  CONSTRAINT `order_places_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_places_printer_id_foreign` FOREIGN KEY (`printer_id`) REFERENCES `printers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_places`
--

LOCK TABLES `order_places` WRITE;
/*!40000 ALTER TABLE `order_places` DISABLE KEYS */;
INSERT INTO `order_places` VALUES (1,NULL,1,'Default POS Terminal','vegetarian',1,1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(2,NULL,2,'Default POS Terminal','vegetarian',1,1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(3,NULL,3,'Default POS Terminal','vegetarian',1,1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(4,NULL,4,'Default POS Terminal','vegetarian',1,1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(5,NULL,5,'Default POS Terminal','vegetarian',1,1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(6,NULL,6,'Default POS Terminal','vegetarian',1,1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(7,NULL,7,'Default POS Terminal','vegetarian',1,1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(8,NULL,8,'Default POS Terminal','vegetarian',1,1,'2025-11-30 03:00:20','2025-11-30 03:00:20');
/*!40000 ALTER TABLE `order_places` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_taxes`
--

DROP TABLE IF EXISTS `order_taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_taxes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `tax_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_taxes_order_id_foreign` (`order_id`),
  KEY `order_taxes_tax_id_foreign` (`tax_id`),
  CONSTRAINT `order_taxes_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_taxes_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=507 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_taxes`
--

LOCK TABLES `order_taxes` WRITE;
/*!40000 ALTER TABLE `order_taxes` DISABLE KEYS */;
INSERT INTO `order_taxes` VALUES (1,1,1),(2,1,2),(3,2,1),(4,2,2),(5,3,1),(6,3,2),(7,4,1),(8,4,2),(9,5,1),(10,5,2),(11,6,1),(12,6,2),(13,7,1),(14,7,2),(15,8,1),(16,8,2),(17,9,1),(18,9,2),(19,10,1),(20,10,2),(21,11,1),(22,11,2),(23,12,1),(24,12,2),(25,12,3),(26,12,4),(27,12,5),(28,12,6),(29,12,7),(30,12,8),(31,13,1),(32,13,2),(33,13,3),(34,13,4),(35,13,5),(36,13,6),(37,13,7),(38,13,8),(39,14,1),(40,14,2),(41,14,3),(42,14,4),(43,14,5),(44,14,6),(45,14,7),(46,14,8),(47,15,1),(48,15,2),(49,15,3),(50,15,4),(51,15,5),(52,15,6),(53,15,7),(54,15,8),(55,16,1),(56,16,2),(57,16,3),(58,16,4),(59,16,5),(60,16,6),(61,16,7),(62,16,8),(63,17,1),(64,17,2),(65,17,3),(66,17,4),(67,17,5),(68,17,6),(69,17,7),(70,17,8),(71,18,1),(72,18,2),(73,18,3),(74,18,4),(75,18,5),(76,18,6),(77,18,7),(78,18,8),(79,19,1),(80,19,2),(81,19,3),(82,19,4),(83,19,5),(84,19,6),(85,19,7),(86,19,8),(87,20,1),(88,20,2),(89,20,3),(90,20,4),(91,20,5),(92,20,6),(93,20,7),(94,20,8),(95,21,1),(96,21,2),(97,21,3),(98,21,4),(99,21,5),(100,21,6),(101,21,7),(102,21,8),(103,22,1),(104,22,2),(105,22,3),(106,22,4),(107,22,5),(108,22,6),(109,22,7),(110,22,8),(111,23,1),(112,23,2),(113,23,3),(114,23,4),(115,23,5),(116,23,6),(117,23,7),(118,23,8),(119,23,9),(120,23,10),(121,24,1),(122,24,2),(123,24,3),(124,24,4),(125,24,5),(126,24,6),(127,24,7),(128,24,8),(129,24,9),(130,24,10),(131,25,1),(132,25,2),(133,25,3),(134,25,4),(135,25,5),(136,25,6),(137,25,7),(138,25,8),(139,25,9),(140,25,10),(141,26,1),(142,26,2),(143,26,3),(144,26,4),(145,26,5),(146,26,6),(147,26,7),(148,26,8),(149,26,9),(150,26,10),(151,27,1),(152,27,2),(153,27,3),(154,27,4),(155,27,5),(156,27,6),(157,27,7),(158,27,8),(159,27,9),(160,27,10),(161,28,1),(162,28,2),(163,28,3),(164,28,4),(165,28,5),(166,28,6),(167,28,7),(168,28,8),(169,28,9),(170,28,10),(171,29,1),(172,29,2),(173,29,3),(174,29,4),(175,29,5),(176,29,6),(177,29,7),(178,29,8),(179,29,9),(180,29,10),(181,30,1),(182,30,2),(183,30,3),(184,30,4),(185,30,5),(186,30,6),(187,30,7),(188,30,8),(189,30,9),(190,30,10),(191,31,1),(192,31,2),(193,31,3),(194,31,4),(195,31,5),(196,31,6),(197,31,7),(198,31,8),(199,31,9),(200,31,10),(201,32,1),(202,32,2),(203,32,3),(204,32,4),(205,32,5),(206,32,6),(207,32,7),(208,32,8),(209,32,9),(210,32,10),(211,33,1),(212,33,2),(213,33,3),(214,33,4),(215,33,5),(216,33,6),(217,33,7),(218,33,8),(219,33,9),(220,33,10),(221,34,1),(222,34,2),(223,34,3),(224,34,4),(225,34,5),(226,34,6),(227,34,7),(228,34,8),(229,34,9),(230,34,10),(231,34,11),(232,34,12),(233,35,1),(234,35,2),(235,35,3),(236,35,4),(237,35,5),(238,35,6),(239,35,7),(240,35,8),(241,35,9),(242,35,10),(243,35,11),(244,35,12),(245,36,1),(246,36,2),(247,36,3),(248,36,4),(249,36,5),(250,36,6),(251,36,7),(252,36,8),(253,36,9),(254,36,10),(255,36,11),(256,36,12),(257,37,1),(258,37,2),(259,37,3),(260,37,4),(261,37,5),(262,37,6),(263,37,7),(264,37,8),(265,37,9),(266,37,10),(267,37,11),(268,37,12),(269,38,1),(270,38,2),(271,38,3),(272,38,4),(273,38,5),(274,38,6),(275,38,7),(276,38,8),(277,38,9),(278,38,10),(279,38,11),(280,38,12),(281,39,1),(282,39,2),(283,39,3),(284,39,4),(285,39,5),(286,39,6),(287,39,7),(288,39,8),(289,39,9),(290,39,10),(291,39,11),(292,39,12),(293,40,1),(294,40,2),(295,40,3),(296,40,4),(297,40,5),(298,40,6),(299,40,7),(300,40,8),(301,40,9),(302,40,10),(303,40,11),(304,40,12),(305,41,1),(306,41,2),(307,41,3),(308,41,4),(309,41,5),(310,41,6),(311,41,7),(312,41,8),(313,41,9),(314,41,10),(315,41,11),(316,41,12),(317,42,1),(318,42,2),(319,42,3),(320,42,4),(321,42,5),(322,42,6),(323,42,7),(324,42,8),(325,42,9),(326,42,10),(327,42,11),(328,42,12),(329,43,1),(330,43,2),(331,43,3),(332,43,4),(333,43,5),(334,43,6),(335,43,7),(336,43,8),(337,43,9),(338,43,10),(339,43,11),(340,43,12),(341,44,1),(342,44,2),(343,44,3),(344,44,4),(345,44,5),(346,44,6),(347,44,7),(348,44,8),(349,44,9),(350,44,10),(351,44,11),(352,44,12),(353,45,1),(354,45,2),(355,45,3),(356,45,4),(357,45,5),(358,45,6),(359,45,7),(360,45,8),(361,45,9),(362,45,10),(363,45,11),(364,45,12),(365,45,13),(366,45,14),(367,46,1),(368,46,2),(369,46,3),(370,46,4),(371,46,5),(372,46,6),(373,46,7),(374,46,8),(375,46,9),(376,46,10),(377,46,11),(378,46,12),(379,46,13),(380,46,14),(381,47,1),(382,47,2),(383,47,3),(384,47,4),(385,47,5),(386,47,6),(387,47,7),(388,47,8),(389,47,9),(390,47,10),(391,47,11),(392,47,12),(393,47,13),(394,47,14),(395,48,1),(396,48,2),(397,48,3),(398,48,4),(399,48,5),(400,48,6),(401,48,7),(402,48,8),(403,48,9),(404,48,10),(405,48,11),(406,48,12),(407,48,13),(408,48,14),(409,49,1),(410,49,2),(411,49,3),(412,49,4),(413,49,5),(414,49,6),(415,49,7),(416,49,8),(417,49,9),(418,49,10),(419,49,11),(420,49,12),(421,49,13),(422,49,14),(423,50,1),(424,50,2),(425,50,3),(426,50,4),(427,50,5),(428,50,6),(429,50,7),(430,50,8),(431,50,9),(432,50,10),(433,50,11),(434,50,12),(435,50,13),(436,50,14),(437,51,1),(438,51,2),(439,51,3),(440,51,4),(441,51,5),(442,51,6),(443,51,7),(444,51,8),(445,51,9),(446,51,10),(447,51,11),(448,51,12),(449,51,13),(450,51,14),(451,52,1),(452,52,2),(453,52,3),(454,52,4),(455,52,5),(456,52,6),(457,52,7),(458,52,8),(459,52,9),(460,52,10),(461,52,11),(462,52,12),(463,52,13),(464,52,14),(465,53,1),(466,53,2),(467,53,3),(468,53,4),(469,53,5),(470,53,6),(471,53,7),(472,53,8),(473,53,9),(474,53,10),(475,53,11),(476,53,12),(477,53,13),(478,53,14),(479,54,1),(480,54,2),(481,54,3),(482,54,4),(483,54,5),(484,54,6),(485,54,7),(486,54,8),(487,54,9),(488,54,10),(489,54,11),(490,54,12),(491,54,13),(492,54,14),(493,55,1),(494,55,2),(495,55,3),(496,55,4),(497,55,5),(498,55,6),(499,55,7),(500,55,8),(501,55,9),(502,55,10),(503,55,11),(504,55,12),(505,55,13),(506,55,14);
/*!40000 ALTER TABLE `order_taxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_types`
--

DROP TABLE IF EXISTS `order_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned DEFAULT NULL,
  `order_type_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `enable_token_number` tinyint(1) NOT NULL DEFAULT '0',
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_types_branch_id_foreign` (`branch_id`),
  CONSTRAINT `order_types_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_types`
--

LOCK TABLES `order_types` WRITE;
/*!40000 ALTER TABLE `order_types` DISABLE KEYS */;
INSERT INTO `order_types` VALUES (1,1,'Dine In','dine_in',1,1,0,'dine_in','2025-11-30 02:57:23','2025-11-30 02:57:23'),(2,1,'Delivery','delivery',1,1,0,'delivery','2025-11-30 02:57:23','2025-11-30 02:57:23'),(3,1,'Pickup','pickup',1,1,0,'pickup','2025-11-30 02:57:23','2025-11-30 02:57:23'),(4,2,'Dine In','dine_in',1,1,0,'dine_in','2025-11-30 02:57:24','2025-11-30 02:57:24'),(5,2,'Delivery','delivery',1,1,0,'delivery','2025-11-30 02:57:24','2025-11-30 02:57:24'),(6,2,'Pickup','pickup',1,1,0,'pickup','2025-11-30 02:57:24','2025-11-30 02:57:24'),(7,3,'Dine In','dine_in',1,1,0,'dine_in','2025-11-30 02:59:34','2025-11-30 02:59:34'),(8,3,'Delivery','delivery',1,1,0,'delivery','2025-11-30 02:59:34','2025-11-30 02:59:34'),(9,3,'Pickup','pickup',1,1,0,'pickup','2025-11-30 02:59:34','2025-11-30 02:59:34'),(10,4,'Dine In','dine_in',1,1,0,'dine_in','2025-11-30 02:59:34','2025-11-30 02:59:34'),(11,4,'Delivery','delivery',1,1,0,'delivery','2025-11-30 02:59:34','2025-11-30 02:59:34'),(12,4,'Pickup','pickup',1,1,0,'pickup','2025-11-30 02:59:34','2025-11-30 02:59:34'),(13,5,'Dine In','dine_in',1,1,0,'dine_in','2025-11-30 02:59:54','2025-11-30 02:59:54'),(14,5,'Delivery','delivery',1,1,0,'delivery','2025-11-30 02:59:54','2025-11-30 02:59:54'),(15,5,'Pickup','pickup',1,1,0,'pickup','2025-11-30 02:59:54','2025-11-30 02:59:54'),(16,6,'Dine In','dine_in',1,1,0,'dine_in','2025-11-30 02:59:55','2025-11-30 02:59:55'),(17,6,'Delivery','delivery',1,1,0,'delivery','2025-11-30 02:59:55','2025-11-30 02:59:55'),(18,6,'Pickup','pickup',1,1,0,'pickup','2025-11-30 02:59:55','2025-11-30 02:59:55'),(19,7,'Dine In','dine_in',1,1,0,'dine_in','2025-11-30 03:00:19','2025-11-30 03:00:19'),(20,7,'Delivery','delivery',1,1,0,'delivery','2025-11-30 03:00:19','2025-11-30 03:00:19'),(21,7,'Pickup','pickup',1,1,0,'pickup','2025-11-30 03:00:19','2025-11-30 03:00:19'),(22,8,'Dine In','dine_in',1,1,0,'dine_in','2025-11-30 03:00:20','2025-11-30 03:00:20'),(23,8,'Delivery','delivery',1,1,0,'delivery','2025-11-30 03:00:20','2025-11-30 03:00:20'),(24,8,'Pickup','pickup',1,1,0,'pickup','2025-11-30 03:00:20','2025-11-30 03:00:20');
/*!40000 ALTER TABLE `order_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch_id` bigint unsigned DEFAULT NULL,
  `pos_machine_id` bigint unsigned DEFAULT NULL,
  `order_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `formatted_order_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_time` datetime NOT NULL,
  `table_id` bigint unsigned DEFAULT NULL,
  `customer_id` bigint unsigned DEFAULT NULL,
  `number_of_pax` int DEFAULT NULL,
  `waiter_id` bigint unsigned DEFAULT NULL,
  `added_by` bigint unsigned DEFAULT NULL,
  `cancelled_by` bigint unsigned DEFAULT NULL,
  `status` enum('draft','kot','billed','paid','canceled','payment_due','ready','out_for_delivery','delivered','pending_verification') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'kot',
  `placed_via` enum('pos','shop','kiosk') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_total` decimal(16,2) NOT NULL,
  `tip_amount` decimal(16,2) DEFAULT '0.00',
  `total_tax_amount` decimal(16,2) DEFAULT '0.00',
  `tax_mode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tip_note` text COLLATE utf8mb4_unicode_ci,
  `total` decimal(16,2) NOT NULL,
  `amount_paid` decimal(16,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `order_type_id` bigint unsigned DEFAULT NULL,
  `delivery_app_id` bigint unsigned DEFAULT NULL,
  `custom_order_type_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pickup_date` datetime DEFAULT NULL,
  `delivery_executive_id` bigint unsigned DEFAULT NULL,
  `delivery_address` text COLLATE utf8mb4_unicode_ci,
  `delivery_time` datetime DEFAULT NULL,
  `estimated_delivery_time` datetime DEFAULT NULL,
  `split_type` enum('even','custom','items') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_value` decimal(16,2) DEFAULT NULL,
  `discount_amount` decimal(16,2) DEFAULT NULL,
  `order_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'placed',
  `delivery_fee` decimal(8,2) NOT NULL DEFAULT '0.00',
  `customer_lat` decimal(10,7) DEFAULT NULL,
  `customer_lng` decimal(10,7) DEFAULT NULL,
  `is_within_radius` tinyint(1) NOT NULL DEFAULT '0',
  `delivery_started_at` timestamp NULL DEFAULT NULL,
  `delivered_at` timestamp NULL DEFAULT NULL,
  `estimated_eta_min` int DEFAULT NULL,
  `estimated_eta_max` int DEFAULT NULL,
  `cancel_reason_id` bigint unsigned DEFAULT NULL,
  `cancel_reason_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reservation_id` bigint unsigned DEFAULT NULL,
  `kiosk_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_uuid_unique` (`uuid`),
  KEY `orders_table_id_foreign` (`table_id`),
  KEY `orders_customer_id_foreign` (`customer_id`),
  KEY `orders_delivery_executive_id_foreign` (`delivery_executive_id`),
  KEY `orders_waiter_id_foreign` (`waiter_id`),
  KEY `orders_cancel_reason_id_foreign` (`cancel_reason_id`),
  KEY `idx_branch_date` (`branch_id`,`date_time`),
  KEY `orders_order_type_id_foreign` (`order_type_id`),
  KEY `orders_reservation_id_foreign` (`reservation_id`),
  KEY `orders_delivery_app_id_foreign` (`delivery_app_id`),
  KEY `orders_added_by_foreign` (`added_by`),
  KEY `orders_cancelled_by_foreign` (`cancelled_by`),
  KEY `orders_kiosk_id_foreign` (`kiosk_id`),
  KEY `orders_pos_machine_id_index` (`pos_machine_id`),
  CONSTRAINT `orders_added_by_foreign` FOREIGN KEY (`added_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `orders_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_cancel_reason_id_foreign` FOREIGN KEY (`cancel_reason_id`) REFERENCES `kot_cancel_reasons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_cancelled_by_foreign` FOREIGN KEY (`cancelled_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `orders_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `orders_delivery_app_id_foreign` FOREIGN KEY (`delivery_app_id`) REFERENCES `delivery_platforms` (`id`) ON DELETE SET NULL,
  CONSTRAINT `orders_delivery_executive_id_foreign` FOREIGN KEY (`delivery_executive_id`) REFERENCES `delivery_executives` (`id`) ON DELETE SET NULL,
  CONSTRAINT `orders_kiosk_id_foreign` FOREIGN KEY (`kiosk_id`) REFERENCES `kiosks` (`id`) ON DELETE SET NULL,
  CONSTRAINT `orders_order_type_id_foreign` FOREIGN KEY (`order_type_id`) REFERENCES `order_types` (`id`) ON DELETE SET NULL,
  CONSTRAINT `orders_pos_machine_id_foreign` FOREIGN KEY (`pos_machine_id`) REFERENCES `pos_machines` (`id`) ON DELETE SET NULL,
  CONSTRAINT `orders_reservation_id_foreign` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`) ON DELETE SET NULL,
  CONSTRAINT `orders_table_id_foreign` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_waiter_id_foreign` FOREIGN KEY (`waiter_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'4ed8b11c-509b-43b1-a762-1539a78e2fac',1,1,'1',NULL,'2025-11-30 08:27:27',2,1,NULL,3,NULL,NULL,'paid','pos',580.00,0.00,0.00,NULL,NULL,609.00,609.00,'2025-11-30 02:57:27','2025-11-30 02:57:27',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'2c13a615-03e5-4f14-9cba-5d5104b48503',1,1,'2',NULL,'2025-11-30 08:27:27',9,2,NULL,3,NULL,NULL,'paid','pos',1040.00,0.00,0.00,NULL,NULL,1092.00,1092.00,'2025-11-30 02:57:27','2025-11-30 02:57:27',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'9d25b1fa-eaa4-49b5-9e71-59b767ad7214',1,NULL,'3',NULL,'2025-11-30 08:27:27',4,3,NULL,3,NULL,NULL,'paid','pos',1140.00,0.00,0.00,NULL,NULL,1197.00,1197.00,'2025-11-30 02:57:27','2025-11-30 02:57:27',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'710d0804-01cd-4fb0-b515-0281b100f753',1,NULL,'4',NULL,'2025-11-30 08:27:27',6,4,NULL,3,NULL,NULL,'paid','pos',1520.00,0.00,0.00,NULL,NULL,1596.00,1596.00,'2025-11-30 02:57:27','2025-11-30 02:57:27',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'1cc4b597-7725-426f-8381-4885414dac7d',1,NULL,'5',NULL,'2025-11-30 08:27:27',8,5,NULL,3,NULL,NULL,'paid','pos',2080.00,0.00,0.00,NULL,NULL,2184.00,2184.00,'2025-11-30 02:57:27','2025-11-30 02:57:27',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'a585bfdf-5578-4210-8662-c5b72f76415a',1,NULL,'6',NULL,'2025-11-29 08:27:27',6,6,NULL,3,NULL,NULL,'paid','pos',975.00,0.00,0.00,NULL,NULL,1024.00,1024.00,'2025-11-30 02:57:27','2025-11-30 02:57:27',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'12a4e4cd-6c9b-4ef1-8fa6-562fb4d0889f',1,NULL,'7',NULL,'2025-11-27 08:27:27',2,7,NULL,3,NULL,NULL,'paid','pos',235.00,0.00,0.00,NULL,NULL,247.00,247.00,'2025-11-30 02:57:27','2025-11-30 02:57:28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,'6a39e498-6231-4bab-b9fd-11501706bc65',1,NULL,'8',NULL,'2025-11-28 08:27:28',9,8,NULL,3,NULL,NULL,'paid','pos',240.00,0.00,0.00,NULL,NULL,252.00,252.00,'2025-11-30 02:57:28','2025-11-30 02:57:28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,'54113603-e963-405c-8a5a-c0c3efb2f0a9',1,NULL,'9',NULL,'2025-11-28 08:27:28',5,9,NULL,3,NULL,NULL,'paid','pos',1035.00,0.00,0.00,NULL,NULL,1087.00,1087.00,'2025-11-30 02:57:28','2025-11-30 02:57:28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,'cf63f93b-9295-4f92-9984-c9368621c7b5',1,NULL,'10',NULL,'2025-11-27 08:27:28',6,10,NULL,3,NULL,NULL,'paid','pos',930.00,0.00,0.00,NULL,NULL,977.00,977.00,'2025-11-30 02:57:28','2025-11-30 02:57:28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,'1e97737d-c0f8-479a-97d0-0859c0d41140',1,NULL,'11',NULL,'2025-11-28 08:27:28',7,11,NULL,3,NULL,NULL,'paid','pos',480.00,0.00,0.00,NULL,NULL,504.00,504.00,'2025-11-30 02:57:28','2025-11-30 02:57:28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,'856c45e7-ec29-4455-99c5-ebc7b7e3e498',1,NULL,'12',NULL,'2025-11-30 08:30:23',13,12,NULL,3,NULL,NULL,'paid','pos',710.00,0.00,0.00,NULL,NULL,852.00,852.00,'2025-11-30 03:00:23','2025-11-30 03:00:23',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,'a1ccb4cd-3bc3-4a48-a757-022dad72fe6c',1,NULL,'13',NULL,'2025-11-30 08:30:23',19,13,NULL,3,NULL,NULL,'paid','pos',360.00,0.00,0.00,NULL,NULL,432.00,432.00,'2025-11-30 03:00:23','2025-11-30 03:00:23',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,'870ef40b-ab6d-476d-941d-7ee2aca7bd48',1,NULL,'14',NULL,'2025-11-30 08:30:23',15,14,NULL,3,NULL,NULL,'paid','pos',360.00,0.00,0.00,NULL,NULL,432.00,432.00,'2025-11-30 03:00:23','2025-11-30 03:00:23',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(15,'d06badad-1719-4be1-9033-45d40d022a39',1,NULL,'15',NULL,'2025-11-30 08:30:23',15,15,NULL,3,NULL,NULL,'paid','pos',1110.00,0.00,0.00,NULL,NULL,1332.00,1332.00,'2025-11-30 03:00:23','2025-11-30 03:00:24',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(16,'d0ea0769-0b75-4543-b4fa-39e386e6b5ec',1,NULL,'16',NULL,'2025-11-30 08:30:24',3,16,NULL,3,NULL,NULL,'paid','pos',1000.00,0.00,0.00,NULL,NULL,1200.00,1200.00,'2025-11-30 03:00:24','2025-11-30 04:17:54',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'preparing',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(17,'9a8ca547-bdac-4947-ab3e-3da43b99f360',1,NULL,'17',NULL,'2025-11-29 08:30:24',18,17,NULL,3,NULL,NULL,'paid','pos',130.00,0.00,0.00,NULL,NULL,156.00,156.00,'2025-11-30 03:00:24','2025-11-30 03:00:24',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(18,'18ee1fb6-d0b8-4b6c-89ec-5b9dc0b50ace',1,NULL,'18',NULL,'2025-11-29 08:30:24',12,18,NULL,3,NULL,NULL,'paid','pos',1400.00,0.00,0.00,NULL,NULL,1680.00,1680.00,'2025-11-30 03:00:24','2025-11-30 03:00:24',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(19,'94b0c6ff-0d90-4139-b9a1-fd4ff9cbd88b',1,NULL,'19',NULL,'2025-11-28 08:30:24',9,19,NULL,3,NULL,NULL,'paid','pos',1730.00,0.00,0.00,NULL,NULL,2076.00,2076.00,'2025-11-30 03:00:24','2025-11-30 03:00:24',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(20,'93fb4193-06e9-447e-9e35-9e2563e7fde1',1,NULL,'20',NULL,'2025-11-29 08:30:24',19,20,NULL,3,NULL,NULL,'paid','pos',1585.00,0.00,0.00,NULL,NULL,1902.00,1902.00,'2025-11-30 03:00:24','2025-11-30 03:00:24',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(21,'349261ae-a703-4321-8b77-7e0e2a56d512',1,NULL,'21',NULL,'2025-11-29 08:30:25',6,21,NULL,3,NULL,NULL,'paid','pos',25.00,0.00,0.00,NULL,NULL,30.00,30.00,'2025-11-30 03:00:25','2025-11-30 03:00:25',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(22,'21187464-512c-4fb7-8736-a0a069c7800a',1,NULL,'22',NULL,'2025-11-27 08:30:25',4,22,NULL,3,NULL,NULL,'paid','pos',900.00,0.00,0.00,NULL,NULL,1080.00,1080.00,'2025-11-30 03:00:25','2025-11-30 03:00:25',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(23,'30bf99f8-1f46-494b-ad6b-9f3f16aa10f2',3,NULL,'1',NULL,'2025-11-30 08:30:28',24,23,NULL,6,NULL,NULL,'paid','pos',780.00,0.00,0.00,NULL,NULL,975.00,975.00,'2025-11-30 03:00:28','2025-11-30 03:00:28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(24,'fef7be6b-44a8-4fea-852d-63e9fdd8cfa8',3,NULL,'24',NULL,'2025-11-30 08:30:28',27,24,NULL,6,NULL,NULL,'paid','pos',2880.00,0.00,0.00,NULL,NULL,3600.00,3600.00,'2025-11-30 03:00:28','2025-11-30 03:00:28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(25,'7d25814a-5eb6-4542-ad91-49da1ecf1061',3,NULL,'25',NULL,'2025-11-30 08:30:28',28,25,NULL,6,NULL,NULL,'paid','pos',880.00,0.00,0.00,NULL,NULL,1100.00,1100.00,'2025-11-30 03:00:28','2025-11-30 03:00:28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(26,'1c689fea-b754-4e6c-a2bb-465b072e6b35',3,NULL,'26',NULL,'2025-11-30 08:30:28',25,26,NULL,6,NULL,NULL,'paid','pos',865.00,0.00,0.00,NULL,NULL,1081.00,1081.00,'2025-11-30 03:00:28','2025-11-30 03:00:28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(27,'75376929-e110-4fbf-85bc-3b963f5d1902',3,NULL,'27',NULL,'2025-11-30 08:30:28',27,27,NULL,6,NULL,NULL,'paid','pos',360.00,0.00,0.00,NULL,NULL,450.00,450.00,'2025-11-30 03:00:28','2025-11-30 03:00:29',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(28,'bbc83f34-9ce6-4919-b8dc-51642d0cc391',3,NULL,'28',NULL,'2025-11-29 08:30:29',23,28,NULL,6,NULL,NULL,'paid','pos',320.00,0.00,0.00,NULL,NULL,400.00,400.00,'2025-11-30 03:00:29','2025-11-30 03:00:29',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(29,'fab57e15-17e5-4779-ac95-487601c8093e',3,NULL,'29',NULL,'2025-11-27 08:30:29',28,29,NULL,6,NULL,NULL,'paid','pos',630.00,0.00,0.00,NULL,NULL,788.00,788.00,'2025-11-30 03:00:29','2025-11-30 03:00:29',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(30,'b43e719e-55d5-4510-90b2-dcaf172d546a',3,NULL,'30',NULL,'2025-11-28 08:30:29',29,30,NULL,6,NULL,NULL,'paid','pos',1130.00,0.00,0.00,NULL,NULL,1413.00,1413.00,'2025-11-30 03:00:29','2025-11-30 03:00:29',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(31,'e0a2ef22-452e-4bdb-93a5-1b025d0e83c0',3,NULL,'31',NULL,'2025-11-27 08:30:29',27,31,NULL,6,NULL,NULL,'paid','pos',360.00,0.00,0.00,NULL,NULL,450.00,450.00,'2025-11-30 03:00:29','2025-11-30 03:00:29',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(32,'f71670e4-6b7e-4e07-9fa9-cd69dc5a9997',3,NULL,'32',NULL,'2025-11-27 08:30:29',26,32,NULL,6,NULL,NULL,'paid','pos',805.00,0.00,0.00,NULL,NULL,1006.00,1006.00,'2025-11-30 03:00:29','2025-11-30 03:00:29',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(33,'837f98bb-b871-4905-b900-818eb6cc2890',3,NULL,'33',NULL,'2025-11-27 08:30:29',28,33,NULL,6,NULL,NULL,'paid','pos',320.00,0.00,0.00,NULL,NULL,400.00,400.00,'2025-11-30 03:00:29','2025-11-30 03:00:30',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(34,'11e39f05-f361-4dcf-80a5-e5b1898a078a',5,NULL,'1',NULL,'2025-11-30 08:30:32',32,34,NULL,7,NULL,NULL,'paid','pos',1960.00,0.00,0.00,NULL,NULL,2548.00,2548.00,'2025-11-30 03:00:32','2025-11-30 03:00:32',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(35,'9357609c-5bad-4b42-8533-02948294527a',5,NULL,'35',NULL,'2025-11-30 08:30:32',34,35,NULL,7,NULL,NULL,'paid','pos',1560.00,0.00,0.00,NULL,NULL,2028.00,2028.00,'2025-11-30 03:00:32','2025-11-30 03:00:33',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(36,'3f14bf25-cc5a-49f0-af10-22ee0c05c375',5,NULL,'36',NULL,'2025-11-30 08:30:33',31,36,NULL,7,NULL,NULL,'paid','pos',180.00,0.00,0.00,NULL,NULL,234.00,234.00,'2025-11-30 03:00:33','2025-11-30 03:00:33',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(37,'741ffd42-cff8-4165-b9a7-e81536a30d3a',5,NULL,'37',NULL,'2025-11-30 08:30:33',36,37,NULL,7,NULL,NULL,'paid','pos',470.00,0.00,0.00,NULL,NULL,611.00,611.00,'2025-11-30 03:00:33','2025-11-30 03:00:33',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(38,'a43d28aa-1b2d-4b56-bfee-cb49d35cadf1',5,NULL,'38',NULL,'2025-11-30 08:30:33',37,38,NULL,7,NULL,NULL,'paid','pos',1070.00,0.00,0.00,NULL,NULL,1391.00,1391.00,'2025-11-30 03:00:33','2025-11-30 03:00:33',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(39,'f04a9f05-ed13-4dd6-8c69-0e2a67fa9670',5,NULL,'39',NULL,'2025-11-28 08:30:33',38,39,NULL,7,NULL,NULL,'paid','pos',680.00,0.00,0.00,NULL,NULL,884.00,884.00,'2025-11-30 03:00:33','2025-11-30 03:00:33',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(40,'7969fd7d-2163-44f0-9940-ea421555bcae',5,NULL,'40',NULL,'2025-11-29 08:30:33',39,40,NULL,7,NULL,NULL,'paid','pos',450.00,0.00,0.00,NULL,NULL,585.00,585.00,'2025-11-30 03:00:33','2025-11-30 03:00:33',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(41,'de4db045-837a-40cb-9c35-7d02e2fd559a',5,NULL,'41',NULL,'2025-11-28 08:30:33',39,41,NULL,7,NULL,NULL,'paid','pos',270.00,0.00,0.00,NULL,NULL,351.00,351.00,'2025-11-30 03:00:33','2025-11-30 03:00:34',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(42,'ce625598-3f27-4db9-958d-ed0576349a7e',5,NULL,'42',NULL,'2025-11-27 08:30:34',37,42,NULL,7,NULL,NULL,'paid','pos',800.00,0.00,0.00,NULL,NULL,1040.00,1040.00,'2025-11-30 03:00:34','2025-11-30 03:00:34',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(43,'6a3b80a2-cd9e-41c9-8c0a-6aa118eaaebc',5,NULL,'43',NULL,'2025-11-28 08:30:34',37,43,NULL,7,NULL,NULL,'paid','pos',1530.00,0.00,0.00,NULL,NULL,1989.00,1989.00,'2025-11-30 03:00:34','2025-11-30 03:00:34',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(44,'4c8591b2-5d40-48a7-b30c-1c5a705a1ed4',5,NULL,'44',NULL,'2025-11-28 08:30:34',31,44,NULL,7,NULL,NULL,'paid','pos',3010.00,0.00,0.00,NULL,NULL,3913.00,3913.00,'2025-11-30 03:00:34','2025-11-30 03:00:34',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(45,'756c3ccd-723c-46ff-aa9d-ee62ff953a77',7,NULL,'1',NULL,'2025-11-30 08:30:37',49,45,NULL,8,NULL,NULL,'paid','pos',600.00,0.00,0.00,NULL,NULL,810.00,810.00,'2025-11-30 03:00:37','2025-11-30 03:00:37',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(46,'46bd8bc2-b1a5-42cc-bbfb-ce9d89339335',7,NULL,'46',NULL,'2025-11-30 08:30:37',45,46,NULL,8,NULL,NULL,'paid','pos',610.00,0.00,0.00,NULL,NULL,824.00,824.00,'2025-11-30 03:00:37','2025-11-30 03:00:37',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(47,'1ff2e4f5-8294-4398-9056-7e49ea0bc3e6',7,NULL,'47',NULL,'2025-11-30 08:30:37',49,47,NULL,8,NULL,NULL,'paid','pos',280.00,0.00,0.00,NULL,NULL,378.00,378.00,'2025-11-30 03:00:37','2025-11-30 03:00:37',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(48,'cbf77692-e276-494e-8a7f-1a07fe1cd9cf',7,NULL,'48',NULL,'2025-11-30 08:30:37',42,48,NULL,8,NULL,NULL,'paid','pos',360.00,0.00,0.00,NULL,NULL,486.00,486.00,'2025-11-30 03:00:37','2025-11-30 03:00:38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(49,'1a0e295d-3f19-41cf-bb80-6926391c42eb',7,NULL,'49',NULL,'2025-11-30 08:30:38',45,49,NULL,8,NULL,NULL,'paid','pos',600.00,0.00,0.00,NULL,NULL,810.00,810.00,'2025-11-30 03:00:38','2025-11-30 03:00:38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(50,'4373d088-6018-4a77-93ee-9a1222009061',7,NULL,'50',NULL,'2025-11-28 08:30:38',42,50,NULL,8,NULL,NULL,'paid','pos',250.00,0.00,0.00,NULL,NULL,338.00,338.00,'2025-11-30 03:00:38','2025-11-30 03:00:38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(51,'98df725b-faea-434a-bc29-f3c67fdf2381',7,NULL,'51',NULL,'2025-11-29 08:30:38',41,51,NULL,8,NULL,NULL,'paid','pos',1250.00,0.00,0.00,NULL,NULL,1688.00,1688.00,'2025-11-30 03:00:38','2025-11-30 03:00:38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(52,'976f7b8d-0259-44e5-b049-994ecc10923b',7,NULL,'52',NULL,'2025-11-29 08:30:38',50,52,NULL,8,NULL,NULL,'paid','pos',405.00,0.00,0.00,NULL,NULL,547.00,547.00,'2025-11-30 03:00:38','2025-11-30 03:00:38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(53,'7956c4d5-fc4f-423e-b7ba-90073d681048',7,NULL,'53',NULL,'2025-11-29 08:30:38',44,53,NULL,8,NULL,NULL,'paid','pos',750.00,0.00,0.00,NULL,NULL,1013.00,1013.00,'2025-11-30 03:00:38','2025-11-30 03:00:38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(54,'1ab1aba2-da71-49bc-90b9-5d0581e399bb',7,NULL,'54',NULL,'2025-11-28 08:30:38',46,54,NULL,8,NULL,NULL,'paid','pos',325.00,0.00,0.00,NULL,NULL,439.00,439.00,'2025-11-30 03:00:38','2025-11-30 03:00:39',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(55,'c07bad7b-d5e9-4b84-964b-633cee1bd404',7,NULL,'55',NULL,'2025-11-28 08:30:39',43,55,NULL,8,NULL,NULL,'paid','pos',2110.00,0.00,0.00,NULL,NULL,2849.00,2849.00,'2025-11-30 03:00:39','2025-11-30 03:00:39',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'placed',0.00,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `otps`
--

DROP TABLE IF EXISTS `otps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `otps` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `identifier` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'login',
  `expires_at` timestamp NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `otps_identifier_type_index` (`identifier`,`type`),
  KEY `otps_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `otps`
--

LOCK TABLES `otps` WRITE;
/*!40000 ALTER TABLE `otps` DISABLE KEYS */;
/*!40000 ALTER TABLE `otps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_modules`
--

DROP TABLE IF EXISTS `package_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package_modules` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `package_id` bigint unsigned DEFAULT NULL,
  `module_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `package_modules_package_id_foreign` (`package_id`),
  KEY `package_modules_module_id_foreign` (`module_id`),
  CONSTRAINT `package_modules_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `package_modules_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1741 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_modules`
--

LOCK TABLES `package_modules` WRITE;
/*!40000 ALTER TABLE `package_modules` DISABLE KEYS */;
INSERT INTO `package_modules` VALUES (1,1,1,NULL,NULL),(2,1,2,NULL,NULL),(3,1,3,NULL,NULL),(4,1,4,NULL,NULL),(5,1,5,NULL,NULL),(6,1,6,NULL,NULL),(7,1,7,NULL,NULL),(8,1,8,NULL,NULL),(9,1,9,NULL,NULL),(10,1,10,NULL,NULL),(11,1,11,NULL,NULL),(12,1,12,NULL,NULL),(13,1,13,NULL,NULL),(14,1,14,NULL,NULL),(15,1,15,NULL,NULL),(16,1,16,NULL,NULL),(17,2,1,NULL,NULL),(18,2,2,NULL,NULL),(19,2,3,NULL,NULL),(20,2,4,NULL,NULL),(21,2,5,NULL,NULL),(22,2,6,NULL,NULL),(23,2,7,NULL,NULL),(24,2,8,NULL,NULL),(25,2,9,NULL,NULL),(26,2,10,NULL,NULL),(27,2,11,NULL,NULL),(28,2,12,NULL,NULL),(29,2,13,NULL,NULL),(30,2,14,NULL,NULL),(31,2,15,NULL,NULL),(32,2,16,NULL,NULL),(33,3,1,NULL,NULL),(34,3,2,NULL,NULL),(35,3,3,NULL,NULL),(36,3,4,NULL,NULL),(37,3,5,NULL,NULL),(38,3,6,NULL,NULL),(39,3,7,NULL,NULL),(40,3,8,NULL,NULL),(41,3,9,NULL,NULL),(42,3,10,NULL,NULL),(43,3,11,NULL,NULL),(44,3,12,NULL,NULL),(45,3,13,NULL,NULL),(46,3,14,NULL,NULL),(47,3,15,NULL,NULL),(48,3,16,NULL,NULL),(49,4,1,NULL,NULL),(50,4,2,NULL,NULL),(51,4,3,NULL,NULL),(52,4,4,NULL,NULL),(53,4,5,NULL,NULL),(54,4,6,NULL,NULL),(55,4,7,NULL,NULL),(56,4,8,NULL,NULL),(57,4,9,NULL,NULL),(58,4,10,NULL,NULL),(59,4,11,NULL,NULL),(60,4,12,NULL,NULL),(61,4,13,NULL,NULL),(62,4,14,NULL,NULL),(63,4,15,NULL,NULL),(64,4,16,NULL,NULL),(65,5,1,NULL,NULL),(66,5,2,NULL,NULL),(67,5,3,NULL,NULL),(68,5,4,NULL,NULL),(69,5,5,NULL,NULL),(70,5,6,NULL,NULL),(71,5,7,NULL,NULL),(72,5,8,NULL,NULL),(73,5,9,NULL,NULL),(74,5,10,NULL,NULL),(75,5,11,NULL,NULL),(76,5,12,NULL,NULL),(77,5,13,NULL,NULL),(78,5,14,NULL,NULL),(79,5,15,NULL,NULL),(80,5,16,NULL,NULL),(1681,1,101,NULL,NULL),(1682,2,101,NULL,NULL),(1683,3,101,NULL,NULL),(1684,4,101,NULL,NULL),(1685,5,101,NULL,NULL),(1711,1,100,NULL,NULL),(1712,1,98,NULL,NULL),(1713,1,99,NULL,NULL),(1714,1,102,NULL,NULL),(1715,2,100,NULL,NULL),(1716,2,98,NULL,NULL),(1717,2,99,NULL,NULL),(1718,2,102,NULL,NULL),(1719,3,100,NULL,NULL),(1720,3,98,NULL,NULL),(1721,3,99,NULL,NULL),(1722,3,102,NULL,NULL),(1723,4,100,NULL,NULL),(1724,4,98,NULL,NULL),(1725,4,99,NULL,NULL),(1726,4,102,NULL,NULL),(1727,5,100,NULL,NULL),(1728,5,98,NULL,NULL),(1729,5,99,NULL,NULL),(1730,5,102,NULL,NULL),(1731,1,97,NULL,NULL),(1732,2,97,NULL,NULL),(1733,3,97,NULL,NULL),(1734,4,97,NULL,NULL),(1735,5,97,NULL,NULL),(1736,1,103,NULL,NULL),(1737,2,103,NULL,NULL),(1738,3,103,NULL,NULL),(1739,4,103,NULL,NULL),(1740,5,103,NULL,NULL);
/*!40000 ALTER TABLE `package_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packages`
--

DROP TABLE IF EXISTS `packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `packages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `package_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(16,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `currency_id` bigint unsigned DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `annual_price` decimal(16,2) DEFAULT NULL,
  `monthly_price` decimal(16,2) DEFAULT NULL,
  `monthly_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `annual_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `stripe_annual_plan_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_monthly_plan_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razorpay_annual_plan_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razorpay_monthly_plan_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flutterwave_annual_plan_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flutterwave_monthly_plan_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paystack_annual_plan_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paystack_monthly_plan_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `xendit_annual_plan_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `xendit_monthly_plan_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paddle_annual_price_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paddle_monthly_price_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paddle_lifetime_price_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_lifetime_plan_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razorpay_lifetime_plan_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_cycle` tinyint unsigned DEFAULT NULL,
  `sort_order` int unsigned DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `is_free` tinyint(1) NOT NULL DEFAULT '0',
  `is_recommended` tinyint(1) NOT NULL DEFAULT '0',
  `package_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'standard',
  `trial_status` tinyint(1) DEFAULT NULL,
  `trial_days` int DEFAULT NULL,
  `trial_notification_before_days` int DEFAULT NULL,
  `trial_message` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_features` longtext COLLATE utf8mb4_unicode_ci,
  `branch_limit` int DEFAULT '-1',
  `multipos_limit` int DEFAULT '-1',
  `menu_items_limit` int NOT NULL DEFAULT '-1',
  `order_limit` int NOT NULL DEFAULT '-1',
  `staff_limit` int NOT NULL DEFAULT '-1',
  `sms_count` int NOT NULL DEFAULT '0',
  `carry_forward_sms` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `packages_currency_id_foreign` (`currency_id`),
  CONSTRAINT `packages_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `global_currencies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packages`
--

LOCK TABLES `packages` WRITE;
/*!40000 ALTER TABLE `packages` DISABLE KEYS */;
INSERT INTO `packages` VALUES (1,'Default',0.00,'2025-11-30 02:57:22','2025-11-30 02:57:22',1,'Its a default package and cannot be deleted',NULL,NULL,'0','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,12,1,0,1,0,'default',NULL,NULL,NULL,NULL,NULL,-1,-1,-1,-1,-1,0,0),(2,'Subscription Package',0.00,'2025-11-30 02:57:22','2025-11-30 02:57:22',1,'This is a subscription package',100.00,10.00,'1','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,10,2,0,0,1,'standard',NULL,NULL,NULL,NULL,NULL,-1,-1,-1,-1,-1,0,0),(3,'Life Time',199.00,'2025-11-30 02:57:22','2025-11-30 02:57:22',1,'This is a lifetime access package',NULL,NULL,'0','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0,1,'lifetime',NULL,NULL,NULL,NULL,'[\"Change Branch\",\"Export Report\",\"Table Reservation\",\"Payment Gateway Integration\",\"Theme Setting\",\"Customer Display\"]',-1,-1,-1,-1,-1,0,0),(4,'Private Package',0.00,'2025-11-30 02:57:22','2025-11-30 02:57:22',1,'This is a private package',50.00,5.00,'1','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,12,4,1,0,0,'standard',NULL,NULL,NULL,NULL,NULL,-1,-1,-1,-1,-1,0,0),(5,'Trial Package',0.00,'2025-11-30 02:57:22','2025-11-30 02:57:22',1,'This is a trial package',NULL,NULL,'0','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,1,0,'trial',1,30,5,'30 Days Free Trial','[\"Change Branch\",\"Export Report\",\"Table Reservation\",\"Payment Gateway Integration\",\"Theme Setting\",\"Customer Display\"]',-1,-1,-1,-1,-1,0,0);
/*!40000 ALTER TABLE `packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payfast_payments`
--

DROP TABLE IF EXISTS `payfast_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payfast_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `payfast_payment_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` bigint unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_status` enum('pending','completed','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_date` timestamp NULL DEFAULT NULL,
  `payment_error_response` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payfast_payments_order_id_foreign` (`order_id`),
  CONSTRAINT `payfast_payments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payfast_payments`
--

LOCK TABLES `payfast_payments` WRITE;
/*!40000 ALTER TABLE `payfast_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payfast_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_gateway_credentials`
--

DROP TABLE IF EXISTS `payment_gateway_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_gateway_credentials` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `razorpay_key` text COLLATE utf8mb4_unicode_ci,
  `razorpay_secret` text COLLATE utf8mb4_unicode_ci,
  `razorpay_status` tinyint(1) NOT NULL DEFAULT '0',
  `stripe_key` text COLLATE utf8mb4_unicode_ci,
  `stripe_secret` text COLLATE utf8mb4_unicode_ci,
  `stripe_status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_dine_in_payment_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_delivery_payment_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_pickup_payment_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_cash_payment_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_qr_payment_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_offline_payment_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `offline_payment_detail` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qr_code_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flutterwave_status` tinyint(1) NOT NULL DEFAULT '0',
  `flutterwave_mode` enum('test','live') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'test',
  `test_flutterwave_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_flutterwave_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_flutterwave_hash` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_flutterwave_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_flutterwave_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_flutterwave_hash` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flutterwave_webhook_secret_hash` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paypal_client_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paypal_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paypal_status` tinyint(1) NOT NULL DEFAULT '0',
  `paypal_mode` enum('sandbox','live') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sandbox',
  `sandbox_paypal_client_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sandbox_paypal_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payfast_merchant_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payfast_merchant_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payfast_passphrase` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payfast_mode` enum('sandbox','live') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sandbox',
  `payfast_status` tinyint(1) NOT NULL DEFAULT '0',
  `test_payfast_merchant_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_payfast_merchant_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_payfast_passphrase` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paystack_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paystack_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paystack_merchant_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paystack_status` tinyint(1) NOT NULL DEFAULT '0',
  `paystack_mode` enum('sandbox','live') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sandbox',
  `test_paystack_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_paystack_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_paystack_merchant_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paystack_payment_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'https://api.paystack.co',
  `xendit_status` tinyint(1) NOT NULL DEFAULT '0',
  `xendit_mode` enum('sandbox','live') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sandbox',
  `test_xendit_public_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_xendit_secret_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_xendit_public_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_xendit_secret_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_xendit_webhook_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_xendit_webhook_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `epay_status` tinyint(1) NOT NULL DEFAULT '0',
  `epay_mode` enum('sandbox','live') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sandbox',
  `epay_client_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `epay_client_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `epay_terminal_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_epay_client_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_epay_client_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_epay_terminal_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_gateway_credentials_restaurant_id_foreign` (`restaurant_id`),
  CONSTRAINT `payment_gateway_credentials_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_gateway_credentials`
--

LOCK TABLES `payment_gateway_credentials` WRITE;
/*!40000 ALTER TABLE `payment_gateway_credentials` DISABLE KEYS */;
INSERT INTO `payment_gateway_credentials` VALUES (1,1,NULL,NULL,0,NULL,NULL,0,'2025-11-30 02:57:23','2025-11-30 02:57:23',0,0,0,0,0,0,NULL,NULL,0,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,'sandbox',0,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,'https://api.paystack.co',0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL),(2,1,NULL,NULL,0,NULL,NULL,0,'2025-11-30 02:57:24','2025-11-30 02:57:24',0,0,0,0,0,0,NULL,NULL,0,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,'sandbox',0,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,'https://api.paystack.co',0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL),(3,2,NULL,NULL,0,NULL,NULL,0,'2025-11-30 02:59:33','2025-11-30 02:59:33',0,0,0,0,0,0,NULL,NULL,0,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,'sandbox',0,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,'https://api.paystack.co',0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL),(4,1,NULL,NULL,0,NULL,NULL,0,'2025-11-30 02:59:35','2025-11-30 02:59:35',0,0,0,0,0,0,NULL,NULL,0,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,'sandbox',0,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,'https://api.paystack.co',0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL),(5,3,NULL,NULL,0,NULL,NULL,0,'2025-11-30 02:59:54','2025-11-30 02:59:54',0,0,0,0,0,0,NULL,NULL,0,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,'sandbox',0,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,'https://api.paystack.co',0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL),(6,1,NULL,NULL,0,NULL,NULL,0,'2025-11-30 02:59:55','2025-11-30 02:59:55',0,0,0,0,0,0,NULL,NULL,0,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,'sandbox',0,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,'https://api.paystack.co',0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL),(7,4,NULL,NULL,0,NULL,NULL,0,'2025-11-30 03:00:19','2025-11-30 03:00:19',0,0,0,0,0,0,NULL,NULL,0,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,'sandbox',0,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,'https://api.paystack.co',0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL),(8,1,NULL,NULL,0,NULL,NULL,0,'2025-11-30 03:00:20','2025-11-30 03:00:20',0,0,0,0,0,0,NULL,NULL,0,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,'sandbox',0,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,'https://api.paystack.co',0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL),(9,2,NULL,NULL,0,NULL,NULL,0,'2025-11-30 03:00:25','2025-11-30 03:00:25',0,0,0,0,0,0,NULL,NULL,0,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,'sandbox',0,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,'https://api.paystack.co',0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL),(10,3,NULL,NULL,0,NULL,NULL,0,'2025-11-30 03:00:30','2025-11-30 03:00:30',0,0,0,0,0,0,NULL,NULL,0,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,'sandbox',0,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,'https://api.paystack.co',0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL),(11,4,NULL,NULL,0,NULL,NULL,0,'2025-11-30 03:00:34','2025-11-30 03:00:34',0,0,0,0,0,0,NULL,NULL,0,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,'sandbox',0,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,'https://api.paystack.co',0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `payment_gateway_credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned DEFAULT NULL,
  `order_id` bigint unsigned NOT NULL,
  `payment_method` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cash',
  `amount` decimal(16,2) NOT NULL,
  `balance` decimal(16,2) DEFAULT '0.00',
  `transaction_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payments_order_id_foreign` (`order_id`),
  KEY `payments_branch_id_foreign` (`branch_id`),
  CONSTRAINT `payments_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,1,'card',609.00,0.00,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(2,1,2,'cash',1092.00,0.00,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(3,1,3,'upi',1197.00,0.00,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(4,1,4,'card',1596.00,0.00,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(5,1,5,'card',2184.00,0.00,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(6,1,6,'card',1024.00,0.00,NULL,'2025-11-30 02:57:27','2025-11-30 02:57:27'),(7,1,7,'upi',247.00,0.00,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(8,1,8,'card',252.00,0.00,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(9,1,9,'card',1087.00,0.00,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(10,1,10,'upi',977.00,0.00,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(11,1,11,'card',504.00,0.00,NULL,'2025-11-30 02:57:28','2025-11-30 02:57:28'),(12,1,12,'upi',852.00,0.00,NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(13,1,13,'cash',432.00,0.00,NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(14,1,14,'card',432.00,0.00,NULL,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(15,1,15,'cash',1332.00,0.00,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(16,1,16,'upi',1200.00,0.00,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(17,1,17,'cash',156.00,0.00,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(18,1,18,'upi',1680.00,0.00,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(19,1,19,'upi',2076.00,0.00,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(20,1,20,'card',1902.00,0.00,NULL,'2025-11-30 03:00:24','2025-11-30 03:00:24'),(21,1,21,'cash',30.00,0.00,NULL,'2025-11-30 03:00:25','2025-11-30 03:00:25'),(22,1,22,'upi',1080.00,0.00,NULL,'2025-11-30 03:00:25','2025-11-30 03:00:25'),(23,3,23,'cash',975.00,0.00,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(24,3,24,'card',3600.00,0.00,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(25,3,25,'upi',1100.00,0.00,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(26,3,26,'upi',1081.00,0.00,NULL,'2025-11-30 03:00:28','2025-11-30 03:00:28'),(27,3,27,'card',450.00,0.00,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(28,3,28,'card',400.00,0.00,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(29,3,29,'cash',788.00,0.00,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(30,3,30,'cash',1413.00,0.00,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(31,3,31,'cash',450.00,0.00,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(32,3,32,'cash',1006.00,0.00,NULL,'2025-11-30 03:00:29','2025-11-30 03:00:29'),(33,3,33,'card',400.00,0.00,NULL,'2025-11-30 03:00:30','2025-11-30 03:00:30'),(34,5,34,'card',2548.00,0.00,NULL,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(35,5,35,'cash',2028.00,0.00,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(36,5,36,'card',234.00,0.00,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(37,5,37,'upi',611.00,0.00,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(38,5,38,'upi',1391.00,0.00,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(39,5,39,'cash',884.00,0.00,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(40,5,40,'cash',585.00,0.00,NULL,'2025-11-30 03:00:33','2025-11-30 03:00:33'),(41,5,41,'cash',351.00,0.00,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(42,5,42,'cash',1040.00,0.00,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(43,5,43,'upi',1989.00,0.00,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(44,5,44,'card',3913.00,0.00,NULL,'2025-11-30 03:00:34','2025-11-30 03:00:34'),(45,7,45,'cash',810.00,0.00,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(46,7,46,'upi',824.00,0.00,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(47,7,47,'card',378.00,0.00,NULL,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(48,7,48,'upi',486.00,0.00,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(49,7,49,'cash',810.00,0.00,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(50,7,50,'card',338.00,0.00,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(51,7,51,'upi',1688.00,0.00,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(52,7,52,'cash',547.00,0.00,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(53,7,53,'cash',1013.00,0.00,NULL,'2025-11-30 03:00:38','2025-11-30 03:00:38'),(54,7,54,'card',439.00,0.00,NULL,'2025-11-30 03:00:39','2025-11-30 03:00:39'),(55,7,55,'cash',2849.00,0.00,NULL,'2025-11-30 03:00:39','2025-11-30 03:00:39');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paypal_payments`
--

DROP TABLE IF EXISTS `paypal_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paypal_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `paypal_payment_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` bigint unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_status` enum('pending','completed','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_date` timestamp NULL DEFAULT NULL,
  `payment_error_response` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `paypal_payments_order_id_foreign` (`order_id`),
  CONSTRAINT `paypal_payments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paypal_payments`
--

LOCK TABLES `paypal_payments` WRITE;
/*!40000 ALTER TABLE `paypal_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `paypal_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paystack_payments`
--

DROP TABLE IF EXISTS `paystack_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paystack_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `paystack_payment_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` bigint unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_status` enum('pending','completed','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_date` timestamp NULL DEFAULT NULL,
  `payment_error_response` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `paystack_payments_order_id_foreign` (`order_id`),
  CONSTRAINT `paystack_payments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paystack_payments`
--

LOCK TABLES `paystack_payments` WRITE;
/*!40000 ALTER TABLE `paystack_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `paystack_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`),
  KEY `permissions_module_id_foreign` (`module_id`),
  CONSTRAINT `permissions_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'Create Menu','web',1,NULL,NULL),(2,'Show Menu','web',1,NULL,NULL),(3,'Update Menu','web',1,NULL,NULL),(4,'Delete Menu','web',1,NULL,NULL),(5,'Create Menu Item','web',2,NULL,NULL),(6,'Show Menu Item','web',2,NULL,NULL),(7,'Update Menu Item','web',2,NULL,NULL),(8,'Delete Menu Item','web',2,NULL,NULL),(9,'Create Item Category','web',3,NULL,NULL),(10,'Show Item Category','web',3,NULL,NULL),(11,'Update Item Category','web',3,NULL,NULL),(12,'Delete Item Category','web',3,NULL,NULL),(13,'Create Area','web',4,NULL,NULL),(14,'Show Area','web',4,NULL,NULL),(15,'Update Area','web',4,NULL,NULL),(16,'Delete Area','web',4,NULL,NULL),(17,'Create Table','web',5,NULL,NULL),(18,'Show Table','web',5,NULL,NULL),(19,'Update Table','web',5,NULL,NULL),(20,'Delete Table','web',5,NULL,NULL),(21,'Create Reservation','web',6,NULL,NULL),(22,'Show Reservation','web',6,NULL,NULL),(23,'Update Reservation','web',6,NULL,NULL),(24,'Delete Reservation','web',6,NULL,NULL),(25,'Manage KOT','web',7,NULL,NULL),(26,'Create Order','web',8,NULL,NULL),(27,'Show Order','web',8,NULL,NULL),(28,'Update Order','web',8,NULL,NULL),(29,'Delete Order','web',8,NULL,NULL),(30,'Add Discount on POS','web',8,NULL,NULL),(31,'Create Customer','web',9,NULL,NULL),(32,'Show Customer','web',9,NULL,NULL),(33,'Update Customer','web',9,NULL,NULL),(34,'Delete Customer','web',9,NULL,NULL),(35,'Create Staff Member','web',10,NULL,NULL),(36,'Show Staff Member','web',10,NULL,NULL),(37,'Update Staff Member','web',10,NULL,NULL),(38,'Delete Staff Member','web',10,NULL,NULL),(39,'Create Delivery Executive','web',14,NULL,NULL),(40,'Show Delivery Executive','web',14,NULL,NULL),(41,'Update Delivery Executive','web',14,NULL,NULL),(42,'Delete Delivery Executive','web',14,NULL,NULL),(43,'Show Payments','web',11,NULL,NULL),(44,'Show Reports','web',12,NULL,NULL),(45,'Manage Settings','web',13,NULL,NULL),(46,'Manage Waiter Request','web',15,NULL,NULL),(47,'Create Expense','web',16,NULL,NULL),(48,'Show Expense','web',16,NULL,NULL),(49,'Update Expense','web',16,NULL,NULL),(50,'Delete Expense','web',16,NULL,NULL),(51,'Create Expense Category','web',16,NULL,NULL),(52,'Show Expense Category','web',16,NULL,NULL),(53,'Update Expense Category','web',16,NULL,NULL),(54,'Delete Expense Category','web',16,NULL,NULL),(109,'Manage Cash Register Settings','web',97,'2025-11-30 04:19:22','2025-11-30 04:19:24'),(110,'View Cash Register Reports','web',97,'2025-11-30 04:19:22','2025-11-30 04:19:22'),(111,'Manage Cash Denominations','web',97,'2025-11-30 04:19:22','2025-11-30 04:19:24'),(112,'Approve Cash Register','web',97,'2025-11-30 04:19:22','2025-11-30 04:19:22'),(113,'Open Cash Register','web',97,'2025-11-30 04:19:24','2025-11-30 04:19:24'),(114,'Create Inventory Item','web',98,NULL,NULL),(115,'Show Inventory Item','web',98,NULL,NULL),(116,'Update Inventory Item','web',98,NULL,NULL),(117,'Delete Inventory Item','web',98,NULL,NULL),(118,'Create Inventory Movement','web',98,NULL,NULL),(119,'Show Inventory Movement','web',98,NULL,NULL),(120,'Update Inventory Movement','web',98,NULL,NULL),(121,'Delete Inventory Movement','web',98,NULL,NULL),(122,'Show Inventory Stock','web',98,NULL,NULL),(123,'Create Unit','web',98,NULL,NULL),(124,'Show Unit','web',98,NULL,NULL),(125,'Update Unit','web',98,NULL,NULL),(126,'Delete Unit','web',98,NULL,NULL),(127,'Create Recipe','web',98,NULL,NULL),(128,'Show Recipe','web',98,NULL,NULL),(129,'Update Recipe','web',98,NULL,NULL),(130,'Delete Recipe','web',98,NULL,NULL),(131,'Create Purchase Order','web',98,NULL,NULL),(132,'Show Purchase Order','web',98,NULL,NULL),(133,'Update Purchase Order','web',98,NULL,NULL),(134,'Delete Purchase Order','web',98,NULL,NULL),(135,'Show Inventory Report','web',98,NULL,NULL),(136,'Update Inventory Settings','web',98,NULL,NULL),(137,'Show Supplier','web',98,NULL,NULL),(138,'Create Supplier','web',98,NULL,NULL),(139,'Update Supplier','web',98,NULL,NULL),(140,'Delete Supplier','web',98,NULL,NULL),(141,'Show Kitchen Place','web',100,'2025-11-30 04:19:36','2025-11-30 04:19:36'),(142,'Create Kitchen Place','web',100,'2025-11-30 04:19:36','2025-11-30 04:19:36'),(143,'Update Kitchen Place','web',100,'2025-11-30 04:19:36','2025-11-30 04:19:36'),(144,'Delete Kitchen Place','web',100,'2025-11-30 04:19:36','2025-11-30 04:19:36'),(145,'Manage MultiPOS Machines','web',101,'2025-11-30 04:19:42','2025-11-30 04:19:42'),(146,'Update Sms Setting','web',102,'2025-11-30 04:19:45','2025-11-30 04:19:45');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pos_machines`
--

DROP TABLE IF EXISTS `pos_machines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pos_machines` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned NOT NULL,
  `alias` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `public_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `device_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','active','declined') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `last_seen_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `approved_by` bigint unsigned DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pos_machines_public_id_unique` (`public_id`),
  UNIQUE KEY `pos_machines_token_unique` (`token`),
  KEY `pos_machines_created_by_foreign` (`created_by`),
  KEY `pos_machines_approved_by_foreign` (`approved_by`),
  KEY `pos_machines_branch_id_status_index` (`branch_id`,`status`),
  KEY `pos_machines_status_index` (`status`),
  KEY `pos_machines_device_id_branch_id_index` (`device_id`,`branch_id`),
  CONSTRAINT `pos_machines_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `pos_machines_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pos_machines_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pos_machines`
--

LOCK TABLES `pos_machines` WRITE;
/*!40000 ALTER TABLE `pos_machines` DISABLE KEYS */;
INSERT INTO `pos_machines` VALUES (1,1,'Counter 1','01KBFVC914PRFY598FB50835AH','O66YnGhGkTwJHPZvIXKz27N5ZlgujExL9v3hf6COgzewTljzNcgj9Ogrx2bM3Zfh','k3HFpagFF8vhqsowO6eZUF1VRDviVBdxWM05yj7vOvM3Bf24Pfnw3sTW1wjnIIGG','pending',NULL,2,NULL,NULL,NULL,'2025-12-02 10:07:27','2025-12-02 10:07:27'),(2,1,'Counter 1','01KBFVCE6X8BPWP8ASBEGVGM6S','TuBSlao9wZJ4TszhHOvZfCRAycIMgv6afWzgTLXNJijHnJFGCmLHeD6BqoURS1cB','gTr3kaACBPdHKx9MeURWEqv7iWyXivezFSbw11HAPDLXcoUmOJVkGvzEWPEb1j6i','active','2025-12-02 10:14:34',2,2,'2025-12-02 10:08:26',NULL,'2025-12-02 10:07:32','2025-12-02 10:14:34'),(3,1,'Demo','01KBFWTPE5GJ42M85GBKCPXD6A','325FP0r2TPj2ye87biqBRi7JHqrjcI4oRiPi7kFEnaqS43AOahETqVV7wAZuLlJP','KViQjSlVp2cLOKeaUUlbTgTz5Ts63bGWUAKCcNIwhxySOc2QdE5LuGgOdlnzm2e2','active','2025-12-02 10:42:25',2,2,'2025-12-02 10:33:03',NULL,'2025-12-02 10:32:48','2025-12-02 10:42:25');
/*!40000 ALTER TABLE `pos_machines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `predefined_amounts`
--

DROP TABLE IF EXISTS `predefined_amounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `predefined_amounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `predefined_amounts_restaurant_id_foreign` (`restaurant_id`),
  CONSTRAINT `predefined_amounts_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `predefined_amounts`
--

LOCK TABLES `predefined_amounts` WRITE;
/*!40000 ALTER TABLE `predefined_amounts` DISABLE KEYS */;
INSERT INTO `predefined_amounts` VALUES (1,1,50.00,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(2,1,100.00,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(3,1,500.00,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(4,1,1000.00,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(5,2,50.00,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(6,2,100.00,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(7,2,500.00,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(8,2,1000.00,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(9,3,50.00,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(10,3,100.00,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(11,3,500.00,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(12,3,1000.00,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(13,4,50.00,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(14,4,100.00,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(15,4,500.00,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(16,4,1000.00,'2025-11-30 03:00:19','2025-11-30 03:00:19');
/*!40000 ALTER TABLE `predefined_amounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `print_jobs`
--

DROP TABLE IF EXISTS `print_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `print_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `printer_id` bigint unsigned DEFAULT NULL,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `branch_id` bigint unsigned DEFAULT NULL,
  `status` enum('done','failed','printing','pending') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `error` text COLLATE utf8mb4_unicode_ci,
  `response_printer` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_filename` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `printed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `print_jobs_printer_id_foreign` (`printer_id`),
  KEY `print_jobs_restaurant_id_foreign` (`restaurant_id`),
  KEY `print_jobs_branch_id_foreign` (`branch_id`),
  CONSTRAINT `print_jobs_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `print_jobs_printer_id_foreign` FOREIGN KEY (`printer_id`) REFERENCES `printers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `print_jobs_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `print_jobs`
--

LOCK TABLES `print_jobs` WRITE;
/*!40000 ALTER TABLE `print_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `print_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `printers`
--

DROP TABLE IF EXISTS `printers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `printers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `branch_id` bigint unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `printing_choice` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `print_type` enum('image','pdf') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'image',
  `kots` text COLLATE utf8mb4_unicode_ci,
  `orders` text COLLATE utf8mb4_unicode_ci,
  `print_format` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_qr_code` int DEFAULT NULL,
  `open_cash_drawer` enum('yes','no') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `share_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('network','windows','linux','default') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `printer_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `printers_restaurant_id_foreign` (`restaurant_id`),
  KEY `printers_branch_id_foreign` (`branch_id`),
  CONSTRAINT `printers_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `printers_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `printers`
--

LOCK TABLES `printers` WRITE;
/*!40000 ALTER TABLE `printers` DISABLE KEYS */;
INSERT INTO `printers` VALUES (1,1,1,'Default Printer','browserPopupPrint','image','[1]','[1]',NULL,NULL,NULL,NULL,NULL,1,1,NULL,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(2,1,2,'Default Printer','browserPopupPrint','image','[2]','[2]',NULL,NULL,NULL,NULL,NULL,1,1,NULL,'2025-11-30 02:57:24','2025-11-30 02:57:24'),(3,2,3,'Default Printer','browserPopupPrint','image','[3]','[3]',NULL,NULL,NULL,NULL,NULL,1,1,NULL,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(4,2,4,'Default Printer','browserPopupPrint','image','[4]','[4]',NULL,NULL,NULL,NULL,NULL,1,1,NULL,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(5,3,5,'Default Printer','browserPopupPrint','image','[5]','[5]',NULL,NULL,NULL,NULL,NULL,1,1,NULL,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(6,3,6,'Default Printer','browserPopupPrint','image','[6]','[6]',NULL,NULL,NULL,NULL,NULL,1,1,NULL,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(7,4,7,'Default Printer','browserPopupPrint','image','[7]','[7]',NULL,NULL,NULL,NULL,NULL,1,1,NULL,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(8,4,8,'Default Printer','browserPopupPrint','image','[8]','[8]',NULL,NULL,NULL,NULL,NULL,1,1,NULL,'2025-11-30 03:00:20','2025-11-30 03:00:20');
/*!40000 ALTER TABLE `printers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_order_items`
--

DROP TABLE IF EXISTS `purchase_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_order_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `purchase_order_id` bigint unsigned NOT NULL,
  `inventory_item_id` bigint unsigned NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `received_quantity` decimal(10,2) NOT NULL DEFAULT '0.00',
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_order_items_purchase_order_id_foreign` (`purchase_order_id`),
  KEY `purchase_order_items_inventory_item_id_foreign` (`inventory_item_id`),
  CONSTRAINT `purchase_order_items_inventory_item_id_foreign` FOREIGN KEY (`inventory_item_id`) REFERENCES `inventory_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchase_order_items_purchase_order_id_foreign` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_order_items`
--

LOCK TABLES `purchase_order_items` WRITE;
/*!40000 ALTER TABLE `purchase_order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_orders`
--

DROP TABLE IF EXISTS `purchase_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `po_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint unsigned NOT NULL,
  `supplier_id` bigint unsigned NOT NULL,
  `order_date` date NOT NULL,
  `expected_delivery_date` date DEFAULT NULL,
  `total_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `status` enum('draft','sent','received','partially_received','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `purchase_orders_po_number_unique` (`po_number`),
  KEY `purchase_orders_branch_id_foreign` (`branch_id`),
  KEY `purchase_orders_supplier_id_foreign` (`supplier_id`),
  KEY `purchase_orders_created_by_foreign` (`created_by`),
  CONSTRAINT `purchase_orders_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchase_orders_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchase_orders_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_orders`
--

LOCK TABLES `purchase_orders` WRITE;
/*!40000 ALTER TABLE `purchase_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pusher_settings`
--

DROP TABLE IF EXISTS `pusher_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pusher_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `beamer_status` tinyint(1) NOT NULL DEFAULT '0',
  `instance_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `beam_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `pusher_broadcast` tinyint(1) NOT NULL DEFAULT '0',
  `pusher_app_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pusher_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pusher_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pusher_cluster` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pusher_settings`
--

LOCK TABLES `pusher_settings` WRITE;
/*!40000 ALTER TABLE `pusher_settings` DISABLE KEYS */;
INSERT INTO `pusher_settings` VALUES (1,0,NULL,NULL,'2025-11-30 02:55:46','2025-11-30 02:55:46',0,NULL,NULL,NULL,NULL),(2,0,NULL,NULL,'2025-11-30 02:57:24','2025-11-30 02:57:24',0,NULL,NULL,NULL,NULL),(3,0,NULL,NULL,'2025-11-30 02:59:35','2025-11-30 02:59:35',0,NULL,NULL,NULL,NULL),(4,0,NULL,NULL,'2025-11-30 02:59:55','2025-11-30 02:59:55',0,NULL,NULL,NULL,NULL),(5,0,NULL,NULL,'2025-11-30 03:00:20','2025-11-30 03:00:20',0,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `pusher_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `razorpay_payments`
--

DROP TABLE IF EXISTS `razorpay_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `razorpay_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `payment_date` datetime DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `payment_status` enum('pending','requested','declined','completed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_error_response` text COLLATE utf8mb4_unicode_ci,
  `razorpay_order_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razorpay_payment_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razorpay_signature` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `razorpay_payments_order_id_foreign` (`order_id`),
  CONSTRAINT `razorpay_payments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `razorpay_payments`
--

LOCK TABLES `razorpay_payments` WRITE;
/*!40000 ALTER TABLE `razorpay_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `razorpay_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipt_settings`
--

DROP TABLE IF EXISTS `receipt_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipt_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `show_customer_name` tinyint(1) NOT NULL DEFAULT '0',
  `show_customer_address` tinyint(1) NOT NULL DEFAULT '0',
  `show_customer_phone` tinyint(1) NOT NULL DEFAULT '0',
  `show_table_number` tinyint(1) NOT NULL DEFAULT '0',
  `payment_qr_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_payment_qr_code` tinyint(1) NOT NULL DEFAULT '0',
  `show_waiter` tinyint(1) NOT NULL DEFAULT '0',
  `show_total_guest` tinyint(1) NOT NULL DEFAULT '0',
  `show_restaurant_logo` tinyint(1) NOT NULL DEFAULT '0',
  `show_tax` tinyint(1) NOT NULL DEFAULT '0',
  `show_payment_details` tinyint(1) NOT NULL DEFAULT '1',
  `show_payment_status` tinyint(1) NOT NULL DEFAULT '0',
  `show_order_type` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `receipt_settings_restaurant_id_foreign` (`restaurant_id`),
  CONSTRAINT `receipt_settings_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt_settings`
--

LOCK TABLES `receipt_settings` WRITE;
/*!40000 ALTER TABLE `receipt_settings` DISABLE KEYS */;
INSERT INTO `receipt_settings` VALUES (1,1,0,0,0,0,NULL,0,0,0,0,0,1,0,0,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(2,2,0,0,0,0,NULL,0,0,0,0,0,1,0,0,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(3,3,0,0,0,0,NULL,0,0,0,0,0,1,0,0,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(4,4,0,0,0,0,NULL,0,0,0,0,0,1,0,0,'2025-11-30 03:00:19','2025-11-30 03:00:19');
/*!40000 ALTER TABLE `receipt_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipes`
--

DROP TABLE IF EXISTS `recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `menu_item_id` bigint unsigned DEFAULT NULL,
  `menu_item_variation_id` bigint unsigned DEFAULT NULL,
  `modifier_option_id` bigint unsigned DEFAULT NULL,
  `inventory_item_id` bigint unsigned NOT NULL,
  `quantity` decimal(16,2) NOT NULL DEFAULT '0.00',
  `unit_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recipes_menu_item_id_foreign` (`menu_item_id`),
  KEY `recipes_inventory_item_id_foreign` (`inventory_item_id`),
  KEY `recipes_unit_id_foreign` (`unit_id`),
  KEY `recipes_menu_item_variation_id_foreign` (`menu_item_variation_id`),
  KEY `recipes_modifier_option_id_foreign` (`modifier_option_id`),
  CONSTRAINT `recipes_inventory_item_id_foreign` FOREIGN KEY (`inventory_item_id`) REFERENCES `inventory_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recipes_menu_item_id_foreign` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recipes_menu_item_variation_id_foreign` FOREIGN KEY (`menu_item_variation_id`) REFERENCES `menu_item_variations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recipes_modifier_option_id_foreign` FOREIGN KEY (`modifier_option_id`) REFERENCES `modifier_options` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recipes_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipes`
--

LOCK TABLES `recipes` WRITE;
/*!40000 ALTER TABLE `recipes` DISABLE KEYS */;
/*!40000 ALTER TABLE `recipes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation_settings`
--

DROP TABLE IF EXISTS `reservation_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned DEFAULT NULL,
  `day_of_week` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') COLLATE utf8mb4_unicode_ci NOT NULL,
  `time_slot_start` time NOT NULL,
  `time_slot_end` time NOT NULL,
  `time_slot_difference` int NOT NULL,
  `slot_type` enum('Breakfast','Lunch','Dinner') COLLATE utf8mb4_unicode_ci NOT NULL,
  `available` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reservation_settings_branch_id_foreign` (`branch_id`),
  CONSTRAINT `reservation_settings_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=274 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation_settings`
--

LOCK TABLES `reservation_settings` WRITE;
/*!40000 ALTER TABLE `reservation_settings` DISABLE KEYS */;
INSERT INTO `reservation_settings` VALUES (1,1,'Monday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(2,1,'Monday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(3,1,'Monday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(4,1,'Tuesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(5,1,'Tuesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(6,1,'Tuesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(7,1,'Wednesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(8,1,'Wednesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(9,1,'Wednesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(10,1,'Thursday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(11,1,'Thursday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(12,1,'Thursday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(13,1,'Friday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(14,1,'Friday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(15,1,'Friday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(16,1,'Saturday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(17,1,'Saturday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(18,1,'Saturday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(19,1,'Sunday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(20,1,'Sunday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(21,1,'Sunday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(22,2,'Monday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(23,2,'Monday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(24,2,'Monday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(25,2,'Tuesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(26,2,'Tuesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(27,2,'Tuesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(28,2,'Wednesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(29,2,'Wednesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(30,2,'Wednesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(31,2,'Thursday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(32,2,'Thursday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(33,2,'Thursday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(34,2,'Friday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(35,2,'Friday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(36,2,'Friday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(37,2,'Saturday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(38,2,'Saturday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(39,2,'Saturday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(40,2,'Sunday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(41,2,'Sunday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(42,2,'Sunday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:23','2025-11-30 02:57:23'),(43,1,'Monday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(44,1,'Monday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(45,1,'Monday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(46,1,'Tuesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(47,1,'Tuesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(48,1,'Tuesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(49,1,'Wednesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(50,1,'Wednesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(51,1,'Wednesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(52,1,'Thursday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(53,1,'Thursday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(54,1,'Thursday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(55,1,'Friday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(56,1,'Friday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(57,1,'Friday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(58,1,'Saturday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(59,1,'Saturday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(60,1,'Saturday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(61,1,'Sunday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(62,1,'Sunday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(63,1,'Sunday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(64,3,'Monday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(65,3,'Monday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(66,3,'Monday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(67,3,'Tuesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(68,3,'Tuesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(69,3,'Tuesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(70,3,'Wednesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(71,3,'Wednesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(72,3,'Wednesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(73,3,'Thursday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(74,3,'Thursday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(75,3,'Thursday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(76,3,'Friday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(77,3,'Friday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(78,3,'Friday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(79,3,'Saturday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(80,3,'Saturday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(81,3,'Saturday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(82,3,'Sunday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(83,3,'Sunday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(84,3,'Sunday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(85,4,'Monday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(86,4,'Monday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(87,4,'Monday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(88,4,'Tuesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(89,4,'Tuesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(90,4,'Tuesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(91,4,'Wednesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(92,4,'Wednesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(93,4,'Wednesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(94,4,'Thursday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(95,4,'Thursday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(96,4,'Thursday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(97,4,'Friday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(98,4,'Friday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(99,4,'Friday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(100,4,'Saturday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(101,4,'Saturday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(102,4,'Saturday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(103,4,'Sunday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(104,4,'Sunday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(105,4,'Sunday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:34','2025-11-30 02:59:34'),(106,5,'Monday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(107,5,'Monday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(108,5,'Monday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(109,5,'Tuesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(110,5,'Tuesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(111,5,'Tuesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(112,5,'Wednesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(113,5,'Wednesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(114,5,'Wednesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(115,5,'Thursday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(116,5,'Thursday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(117,5,'Thursday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(118,5,'Friday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(119,5,'Friday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(120,5,'Friday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(121,5,'Saturday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(122,5,'Saturday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(123,5,'Saturday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(124,5,'Sunday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(125,5,'Sunday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(126,5,'Sunday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:54','2025-11-30 02:59:54'),(127,6,'Monday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(128,6,'Monday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(129,6,'Monday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(130,6,'Tuesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(131,6,'Tuesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(132,6,'Tuesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(133,6,'Wednesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(134,6,'Wednesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(135,6,'Wednesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(136,6,'Thursday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(137,6,'Thursday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(138,6,'Thursday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(139,6,'Friday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(140,6,'Friday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(141,6,'Friday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(142,6,'Saturday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(143,6,'Saturday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(144,6,'Saturday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(145,6,'Sunday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(146,6,'Sunday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(147,6,'Sunday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 02:59:55','2025-11-30 02:59:55'),(148,7,'Monday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(149,7,'Monday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(150,7,'Monday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(151,7,'Tuesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(152,7,'Tuesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(153,7,'Tuesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(154,7,'Wednesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(155,7,'Wednesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(156,7,'Wednesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(157,7,'Thursday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(158,7,'Thursday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(159,7,'Thursday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(160,7,'Friday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(161,7,'Friday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(162,7,'Friday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(163,7,'Saturday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(164,7,'Saturday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(165,7,'Saturday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(166,7,'Sunday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(167,7,'Sunday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(168,7,'Sunday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:19','2025-11-30 03:00:19'),(169,8,'Monday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(170,8,'Monday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(171,8,'Monday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(172,8,'Tuesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(173,8,'Tuesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(174,8,'Tuesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(175,8,'Wednesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(176,8,'Wednesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(177,8,'Wednesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(178,8,'Thursday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(179,8,'Thursday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(180,8,'Thursday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(181,8,'Friday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(182,8,'Friday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(183,8,'Friday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(184,8,'Saturday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(185,8,'Saturday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(186,8,'Saturday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(187,8,'Sunday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(188,8,'Sunday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(189,8,'Sunday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:20','2025-11-30 03:00:20'),(190,1,'Monday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(191,1,'Monday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(192,1,'Monday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(193,1,'Tuesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(194,1,'Tuesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(195,1,'Tuesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(196,1,'Wednesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(197,1,'Wednesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(198,1,'Wednesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(199,1,'Thursday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(200,1,'Thursday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(201,1,'Thursday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(202,1,'Friday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(203,1,'Friday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(204,1,'Friday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(205,1,'Saturday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(206,1,'Saturday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(207,1,'Saturday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(208,1,'Sunday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(209,1,'Sunday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(210,1,'Sunday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(211,3,'Monday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(212,3,'Monday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(213,3,'Monday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(214,3,'Tuesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(215,3,'Tuesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(216,3,'Tuesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(217,3,'Wednesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(218,3,'Wednesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(219,3,'Wednesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(220,3,'Thursday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(221,3,'Thursday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(222,3,'Thursday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(223,3,'Friday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(224,3,'Friday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(225,3,'Friday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(226,3,'Saturday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(227,3,'Saturday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(228,3,'Saturday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(229,3,'Sunday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(230,3,'Sunday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(231,3,'Sunday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(232,5,'Monday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(233,5,'Monday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(234,5,'Monday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(235,5,'Tuesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(236,5,'Tuesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(237,5,'Tuesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(238,5,'Wednesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(239,5,'Wednesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(240,5,'Wednesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(241,5,'Thursday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(242,5,'Thursday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(243,5,'Thursday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(244,5,'Friday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(245,5,'Friday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(246,5,'Friday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(247,5,'Saturday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(248,5,'Saturday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(249,5,'Saturday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(250,5,'Sunday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(251,5,'Sunday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(252,5,'Sunday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(253,7,'Monday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(254,7,'Monday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(255,7,'Monday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(256,7,'Tuesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(257,7,'Tuesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(258,7,'Tuesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(259,7,'Wednesday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(260,7,'Wednesday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(261,7,'Wednesday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(262,7,'Thursday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(263,7,'Thursday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(264,7,'Thursday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(265,7,'Friday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(266,7,'Friday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(267,7,'Friday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(268,7,'Saturday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(269,7,'Saturday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(270,7,'Saturday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(271,7,'Sunday','08:00:00','11:00:00',30,'Breakfast',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(272,7,'Sunday','12:00:00','17:00:00',60,'Lunch',1,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(273,7,'Sunday','18:00:00','22:00:00',60,'Dinner',1,'2025-11-30 03:00:35','2025-11-30 03:00:35');
/*!40000 ALTER TABLE `reservation_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned DEFAULT NULL,
  `table_id` bigint unsigned DEFAULT NULL,
  `customer_id` bigint unsigned DEFAULT NULL,
  `reservation_date_time` datetime NOT NULL,
  `party_size` int NOT NULL,
  `special_requests` text COLLATE utf8mb4_unicode_ci,
  `reservation_status` enum('Pending','Confirmed','Checked_In','Cancelled','No_Show') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Confirmed',
  `reservation_slot_type` enum('Breakfast','Lunch','Dinner') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `slot_time_difference` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reservations_table_id_foreign` (`table_id`),
  KEY `reservations_customer_id_foreign` (`customer_id`),
  KEY `reservations_branch_id_foreign` (`branch_id`),
  CONSTRAINT `reservations_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reservations_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `reservations_table_id_foreign` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant_charges`
--

DROP TABLE IF EXISTS `restaurant_charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant_charges` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `charge_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `charge_type` enum('percent','fixed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fixed',
  `charge_value` decimal(16,2) DEFAULT NULL,
  `order_types` json NOT NULL COMMENT 'Supported order types: DineIn, Delivery, PickUp',
  `is_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `restaurant_charges_restaurant_id_foreign` (`restaurant_id`),
  KEY `restaurant_charges_charge_name_index` (`charge_name`),
  CONSTRAINT `restaurant_charges_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_charges`
--

LOCK TABLES `restaurant_charges` WRITE;
/*!40000 ALTER TABLE `restaurant_charges` DISABLE KEYS */;
/*!40000 ALTER TABLE `restaurant_charges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant_payments`
--

DROP TABLE IF EXISTS `restaurant_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned NOT NULL,
  `amount` decimal(16,2) NOT NULL,
  `status` enum('pending','paid','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_source` enum('official_site','app_sumo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'official_site',
  `razorpay_order_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razorpay_payment_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razorpay_signature` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_date_time` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `stripe_payment_intent` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_session_id` text COLLATE utf8mb4_unicode_ci,
  `package_id` bigint unsigned DEFAULT NULL,
  `package_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flutterwave_transaction_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flutterwave_payment_ref` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paypal_payment_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `restaurant_payments_restaurant_id_foreign` (`restaurant_id`),
  KEY `restaurant_payments_package_id_foreign` (`package_id`),
  CONSTRAINT `restaurant_payments_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `restaurant_payments_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_payments`
--

LOCK TABLES `restaurant_payments` WRITE;
/*!40000 ALTER TABLE `restaurant_payments` DISABLE KEYS */;
INSERT INTO `restaurant_payments` VALUES (1,1,99.00,'paid','official_site',NULL,NULL,NULL,NULL,NULL,'2025-11-30 08:27:28','2025-11-30 02:57:28','2025-11-30 02:57:28',NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2,1,99.00,'paid','official_site',NULL,NULL,NULL,NULL,NULL,'2025-11-30 08:30:25','2025-11-30 03:00:25','2025-11-30 03:00:25',NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(3,2,99.00,'paid','official_site',NULL,NULL,NULL,NULL,NULL,'2025-11-30 08:30:30','2025-11-30 03:00:30','2025-11-30 03:00:30',NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(4,3,99.00,'paid','official_site',NULL,NULL,NULL,NULL,NULL,'2025-11-30 08:30:34','2025-11-30 03:00:34','2025-11-30 03:00:34',NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(5,4,99.00,'paid','official_site',NULL,NULL,NULL,NULL,NULL,'2025-11-30 08:30:39','2025-11-30 03:00:39','2025-11-30 03:00:39',NULL,NULL,1,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `restaurant_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant_taxes`
--

DROP TABLE IF EXISTS `restaurant_taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant_taxes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned NOT NULL,
  `tax_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `restaurant_taxes_restaurant_id_foreign` (`restaurant_id`),
  CONSTRAINT `restaurant_taxes_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_taxes`
--

LOCK TABLES `restaurant_taxes` WRITE;
/*!40000 ALTER TABLE `restaurant_taxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `restaurant_taxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurants`
--

DROP TABLE IF EXISTS `restaurants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurants` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sub_domain` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hash` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timezone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `theme_hex` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `theme_rgb` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_id` bigint unsigned NOT NULL,
  `hide_new_orders` tinyint(1) NOT NULL DEFAULT '0',
  `hide_new_reservations` tinyint(1) NOT NULL DEFAULT '0',
  `hide_new_waiter_request` tinyint(1) NOT NULL DEFAULT '0',
  `currency_id` bigint unsigned DEFAULT NULL,
  `license_type` enum('free','paid') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'free',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `customer_login_required` tinyint(1) NOT NULL DEFAULT '0',
  `about_us` longtext COLLATE utf8mb4_unicode_ci,
  `allow_customer_delivery_orders` tinyint(1) NOT NULL DEFAULT '1',
  `allow_customer_pickup_orders` tinyint(1) NOT NULL DEFAULT '1',
  `pickup_days_range` int DEFAULT '7',
  `allow_customer_orders` tinyint(1) NOT NULL DEFAULT '1',
  `allow_dine_in_orders` tinyint(1) NOT NULL DEFAULT '1',
  `show_veg` tinyint(1) NOT NULL DEFAULT '1',
  `show_halal` tinyint(1) NOT NULL DEFAULT '0',
  `package_id` bigint unsigned DEFAULT NULL,
  `package_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive','license_expired') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `license_expire_on` datetime DEFAULT NULL,
  `count_sms` int NOT NULL DEFAULT '0',
  `total_sms` int NOT NULL DEFAULT '-1',
  `trial_ends_at` datetime DEFAULT NULL,
  `license_updated_at` datetime DEFAULT NULL,
  `subscription_updated_at` datetime DEFAULT NULL,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pm_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pm_last_four` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_waiter_request_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `default_table_reservation_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Confirmed',
  `disable_slot_minutes` int NOT NULL DEFAULT '30',
  `approval_status` enum('Pending','Approved','Rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Approved',
  `rejection_reason` text COLLATE utf8mb4_unicode_ci,
  `facebook_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instagram_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twitter_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `yelp_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `table_required` tinyint(1) NOT NULL DEFAULT '0',
  `show_logo_text` tinyint(1) NOT NULL DEFAULT '1',
  `meta_keyword` text COLLATE utf8mb4_unicode_ci,
  `meta_description` longtext COLLATE utf8mb4_unicode_ci,
  `upload_fav_icon_android_chrome_192` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upload_fav_icon_android_chrome_512` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upload_fav_icon_apple_touch_icon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upload_favicon_16` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upload_favicon_32` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `favicon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_waiter_request_enabled_on_desktop` tinyint(1) NOT NULL DEFAULT '1',
  `is_waiter_request_enabled_on_mobile` tinyint(1) NOT NULL DEFAULT '1',
  `is_waiter_request_enabled_open_by_qr` tinyint(1) NOT NULL DEFAULT '0',
  `webmanifest` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable_tip_shop` tinyint(1) NOT NULL DEFAULT '1',
  `enable_tip_pos` tinyint(1) NOT NULL DEFAULT '1',
  `is_pwa_install_alert_show` tinyint(1) NOT NULL DEFAULT '0',
  `auto_confirm_orders` tinyint(1) NOT NULL DEFAULT '0',
  `restrict_qr_order_by_location` tinyint(1) NOT NULL DEFAULT '0',
  `qr_order_radius_meters` int unsigned DEFAULT NULL,
  `show_order_type_options` tinyint(1) NOT NULL DEFAULT '1',
  `disable_order_type_popup` tinyint(1) NOT NULL DEFAULT '0',
  `default_order_type_id` bigint unsigned DEFAULT NULL,
  `hide_menu_item_image_on_pos` tinyint(1) NOT NULL DEFAULT '0',
  `hide_menu_item_image_on_customer_site` tinyint(1) NOT NULL DEFAULT '0',
  `tax_mode` enum('order','item') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'order',
  `tax_inclusive` tinyint(1) NOT NULL DEFAULT '0',
  `customer_site_language` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable_admin_reservation` tinyint(1) NOT NULL DEFAULT '1',
  `enable_customer_reservation` tinyint(1) NOT NULL DEFAULT '1',
  `minimum_party_size` int NOT NULL DEFAULT '1',
  `table_lock_timeout_minutes` int NOT NULL DEFAULT '10',
  PRIMARY KEY (`id`),
  KEY `restaurant_settings_country_id_foreign` (`country_id`),
  KEY `restaurant_settings_currency_id_foreign` (`currency_id`),
  KEY `restaurants_package_id_foreign` (`package_id`),
  KEY `restaurants_default_order_type_id_foreign` (`default_order_type_id`),
  CONSTRAINT `restaurant_settings_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `restaurant_settings_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE,
  CONSTRAINT `restaurants_default_order_type_id_foreign` FOREIGN KEY (`default_order_type_id`) REFERENCES `order_types` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `restaurants_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurants`
--

LOCK TABLES `restaurants` WRITE;
/*!40000 ALTER TABLE `restaurants` DISABLE KEYS */;
INSERT INTO `restaurants` VALUES (1,'demo.tabletrack.test','Demo Restaurant','demo-restaurant','45082 Matilde Divide Apt. 839\nMadisynside, AZ 23863','+17378641403',NULL,'demo.restaurant@example.com','America/New_York','#A78BFA','167, 139, 250',NULL,236,0,0,0,1,'paid',1,'2025-11-30 02:57:23','2025-11-30 04:19:48',0,'<p class=\"text-lg text-gray-600 mb-6\">\n          Welcome to our restaurant, where great food and good vibes come together! We\'re a local, family-owned spot that loves bringing people together over delicious meals and unforgettable moments. Whether you\'re here for a quick bite, a family dinner, or a celebration, we\'re all about making your time with us special.\n        </p>\n        <p class=\"text-lg text-gray-600 mb-6\">\n          Our menu is packed with dishes made from fresh, quality ingredients because we believe food should taste as\n          good as it makes you feel. From our signature dishes to seasonal specials, there\'s always something to excite\n          your taste buds.\n        </p>\n        <p class=\"text-lg text-gray-600 mb-6\">\n          But we\'re not just about the food—we\'re about community. We love seeing familiar faces and welcoming new ones.\n          Our team is a fun, friendly bunch dedicated to serving you with a smile and making sure every visit feels like\n          coming home.\n        </p>\n        <p class=\"text-lg text-gray-600\">\n          So, come on in, grab a seat, and let us take care of the rest. We can\'t wait to share our love of food with\n          you!\n        </p>\n        <p class=\"text-lg text-gray-800 font-semibold mt-6\">See you soon! ?️✨</p>',1,1,7,1,1,1,0,5,'trial','active','2025-12-30 08:27:23',0,-1,'2025-12-30 08:27:23','2025-11-30 08:27:23','2025-11-30 08:27:23',NULL,NULL,NULL,1,'Confirmed',30,'Approved',NULL,'https://www.facebook.com/','https://www.instagram.com/','https://www.twitter.com/',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0,NULL,1,1,0,0,0,NULL,1,0,NULL,0,0,'order',0,'en',1,1,1,10),(2,'demo.tabletrack.test','Demo Restaurant','demo-restaurant-1','916 Roob Junction\nEast Sarina, OR 35490','+14795120534',NULL,'demo.restaurant@example.com','America/New_York','#A78BFA','167, 139, 250',NULL,236,0,0,0,5,'paid',1,'2025-11-30 02:59:33','2025-11-30 04:19:48',0,'<p class=\"text-lg text-gray-600 mb-6\">\n          Welcome to our restaurant, where great food and good vibes come together! We\'re a local, family-owned spot that loves bringing people together over delicious meals and unforgettable moments. Whether you\'re here for a quick bite, a family dinner, or a celebration, we\'re all about making your time with us special.\n        </p>\n        <p class=\"text-lg text-gray-600 mb-6\">\n          Our menu is packed with dishes made from fresh, quality ingredients because we believe food should taste as\n          good as it makes you feel. From our signature dishes to seasonal specials, there\'s always something to excite\n          your taste buds.\n        </p>\n        <p class=\"text-lg text-gray-600 mb-6\">\n          But we\'re not just about the food—we\'re about community. We love seeing familiar faces and welcoming new ones.\n          Our team is a fun, friendly bunch dedicated to serving you with a smile and making sure every visit feels like\n          coming home.\n        </p>\n        <p class=\"text-lg text-gray-600\">\n          So, come on in, grab a seat, and let us take care of the rest. We can\'t wait to share our love of food with\n          you!\n        </p>\n        <p class=\"text-lg text-gray-800 font-semibold mt-6\">See you soon! ?️✨</p>',1,1,7,1,1,1,0,5,'trial','active','2025-12-30 08:29:33',0,-1,'2025-12-30 08:29:33','2025-11-30 08:29:33','2025-11-30 08:29:33',NULL,NULL,NULL,1,'Confirmed',30,'Approved',NULL,'https://www.facebook.com/','https://www.instagram.com/','https://www.twitter.com/',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0,NULL,1,1,0,0,0,NULL,1,0,NULL,0,0,'order',0,'en',1,1,1,10),(3,'demo.tabletrack.test','Demo Restaurant','demo-restaurant-2','6106 Terry Alley Suite 632\nHyattland, OH 27451-8296','+15592821422',NULL,'demo.restaurant@example.com','America/New_York','#A78BFA','167, 139, 250',NULL,236,0,0,0,9,'paid',1,'2025-11-30 02:59:54','2025-11-30 04:19:48',0,'<p class=\"text-lg text-gray-600 mb-6\">\n          Welcome to our restaurant, where great food and good vibes come together! We\'re a local, family-owned spot that loves bringing people together over delicious meals and unforgettable moments. Whether you\'re here for a quick bite, a family dinner, or a celebration, we\'re all about making your time with us special.\n        </p>\n        <p class=\"text-lg text-gray-600 mb-6\">\n          Our menu is packed with dishes made from fresh, quality ingredients because we believe food should taste as\n          good as it makes you feel. From our signature dishes to seasonal specials, there\'s always something to excite\n          your taste buds.\n        </p>\n        <p class=\"text-lg text-gray-600 mb-6\">\n          But we\'re not just about the food—we\'re about community. We love seeing familiar faces and welcoming new ones.\n          Our team is a fun, friendly bunch dedicated to serving you with a smile and making sure every visit feels like\n          coming home.\n        </p>\n        <p class=\"text-lg text-gray-600\">\n          So, come on in, grab a seat, and let us take care of the rest. We can\'t wait to share our love of food with\n          you!\n        </p>\n        <p class=\"text-lg text-gray-800 font-semibold mt-6\">See you soon! ?️✨</p>',1,1,7,1,1,1,0,5,'trial','active','2025-12-30 08:29:54',0,-1,'2025-12-30 08:29:54','2025-11-30 08:29:54','2025-11-30 08:29:54',NULL,NULL,NULL,1,'Confirmed',30,'Approved',NULL,'https://www.facebook.com/','https://www.instagram.com/','https://www.twitter.com/',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0,NULL,1,1,0,0,0,NULL,1,0,NULL,0,0,'order',0,'en',1,1,1,10),(4,'demo.tabletrack.test','Demo Restaurant','demo-restaurant-3','1928 Haley Ridge\nRoryland, UT 37011','+16406483801',NULL,'demo.restaurant@example.com','America/New_York','#A78BFA','167, 139, 250',NULL,236,0,0,0,13,'paid',1,'2025-11-30 03:00:19','2025-11-30 04:19:48',0,'<p class=\"text-lg text-gray-600 mb-6\">\n          Welcome to our restaurant, where great food and good vibes come together! We\'re a local, family-owned spot that loves bringing people together over delicious meals and unforgettable moments. Whether you\'re here for a quick bite, a family dinner, or a celebration, we\'re all about making your time with us special.\n        </p>\n        <p class=\"text-lg text-gray-600 mb-6\">\n          Our menu is packed with dishes made from fresh, quality ingredients because we believe food should taste as\n          good as it makes you feel. From our signature dishes to seasonal specials, there\'s always something to excite\n          your taste buds.\n        </p>\n        <p class=\"text-lg text-gray-600 mb-6\">\n          But we\'re not just about the food—we\'re about community. We love seeing familiar faces and welcoming new ones.\n          Our team is a fun, friendly bunch dedicated to serving you with a smile and making sure every visit feels like\n          coming home.\n        </p>\n        <p class=\"text-lg text-gray-600\">\n          So, come on in, grab a seat, and let us take care of the rest. We can\'t wait to share our love of food with\n          you!\n        </p>\n        <p class=\"text-lg text-gray-800 font-semibold mt-6\">See you soon! ?️✨</p>',1,1,7,1,1,1,0,5,'trial','active','2025-12-30 08:30:19',0,-1,'2025-12-30 08:30:19','2025-11-30 08:30:19','2025-11-30 08:30:19',NULL,NULL,NULL,1,'Confirmed',30,'Approved',NULL,'https://www.facebook.com/','https://www.instagram.com/','https://www.twitter.com/',NULL,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,0,NULL,1,1,0,0,0,NULL,1,0,NULL,0,0,'order',0,'en',1,1,1,10);
/*!40000 ALTER TABLE `restaurants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` VALUES (1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(8,2),(9,2),(10,2),(11,2),(12,2),(13,2),(14,2),(15,2),(16,2),(17,2),(18,2),(19,2),(20,2),(21,2),(22,2),(23,2),(24,2),(25,2),(26,2),(27,2),(28,2),(29,2),(30,2),(31,2),(32,2),(33,2),(34,2),(35,2),(36,2),(37,2),(38,2),(39,2),(40,2),(41,2),(42,2),(43,2),(44,2),(45,2),(46,2),(47,2),(48,2),(49,2),(50,2),(51,2),(52,2),(53,2),(54,2),(109,2),(110,2),(111,2),(112,2),(113,2),(114,2),(115,2),(116,2),(117,2),(118,2),(119,2),(120,2),(121,2),(122,2),(123,2),(124,2),(125,2),(126,2),(127,2),(128,2),(129,2),(130,2),(131,2),(132,2),(133,2),(134,2),(135,2),(136,2),(137,2),(138,2),(139,2),(140,2),(141,2),(142,2),(143,2),(144,2),(145,2),(146,2),(1,3),(2,3),(3,3),(4,3),(5,3),(6,3),(7,3),(8,3),(9,3),(10,3),(11,3),(12,3),(13,3),(14,3),(15,3),(16,3),(17,3),(18,3),(19,3),(20,3),(21,3),(22,3),(23,3),(24,3),(25,3),(26,3),(27,3),(28,3),(29,3),(30,3),(31,3),(32,3),(33,3),(34,3),(35,3),(36,3),(37,3),(38,3),(39,3),(40,3),(41,3),(42,3),(43,3),(44,3),(45,3),(46,3),(47,3),(48,3),(49,3),(50,3),(51,3),(52,3),(53,3),(54,3),(109,3),(110,3),(111,3),(112,3),(113,3),(114,3),(115,3),(116,3),(117,3),(118,3),(119,3),(120,3),(121,3),(122,3),(123,3),(124,3),(125,3),(126,3),(127,3),(128,3),(129,3),(130,3),(131,3),(132,3),(133,3),(134,3),(135,3),(136,3),(137,3),(138,3),(139,3),(140,3),(141,3),(142,3),(143,3),(144,3),(145,3),(146,3),(1,6),(2,6),(3,6),(4,6),(5,6),(6,6),(7,6),(8,6),(9,6),(10,6),(11,6),(12,6),(13,6),(14,6),(15,6),(16,6),(17,6),(18,6),(19,6),(20,6),(21,6),(22,6),(23,6),(24,6),(25,6),(26,6),(27,6),(28,6),(29,6),(30,6),(31,6),(32,6),(33,6),(34,6),(35,6),(36,6),(37,6),(38,6),(39,6),(40,6),(41,6),(42,6),(43,6),(44,6),(45,6),(46,6),(47,6),(48,6),(49,6),(50,6),(51,6),(52,6),(53,6),(54,6),(109,6),(110,6),(111,6),(112,6),(113,6),(114,6),(115,6),(116,6),(117,6),(118,6),(119,6),(120,6),(121,6),(122,6),(123,6),(124,6),(125,6),(126,6),(127,6),(128,6),(129,6),(130,6),(131,6),(132,6),(133,6),(134,6),(135,6),(136,6),(137,6),(138,6),(139,6),(140,6),(141,6),(142,6),(143,6),(144,6),(145,6),(146,6),(1,7),(2,7),(3,7),(4,7),(5,7),(6,7),(7,7),(8,7),(9,7),(10,7),(11,7),(12,7),(13,7),(14,7),(15,7),(16,7),(17,7),(18,7),(19,7),(20,7),(21,7),(22,7),(23,7),(24,7),(25,7),(26,7),(27,7),(28,7),(29,7),(30,7),(31,7),(32,7),(33,7),(34,7),(35,7),(36,7),(37,7),(38,7),(39,7),(40,7),(41,7),(42,7),(43,7),(44,7),(45,7),(46,7),(47,7),(48,7),(49,7),(50,7),(51,7),(52,7),(53,7),(54,7),(109,7),(110,7),(111,7),(112,7),(113,7),(114,7),(115,7),(116,7),(117,7),(118,7),(119,7),(120,7),(121,7),(122,7),(123,7),(124,7),(125,7),(126,7),(127,7),(128,7),(129,7),(130,7),(131,7),(132,7),(133,7),(134,7),(135,7),(136,7),(137,7),(138,7),(139,7),(140,7),(141,7),(142,7),(143,7),(144,7),(145,7),(146,7),(1,10),(2,10),(3,10),(4,10),(5,10),(6,10),(7,10),(8,10),(9,10),(10,10),(11,10),(12,10),(13,10),(14,10),(15,10),(16,10),(17,10),(18,10),(19,10),(20,10),(21,10),(22,10),(23,10),(24,10),(25,10),(26,10),(27,10),(28,10),(29,10),(30,10),(31,10),(32,10),(33,10),(34,10),(35,10),(36,10),(37,10),(38,10),(39,10),(40,10),(41,10),(42,10),(43,10),(44,10),(45,10),(46,10),(47,10),(48,10),(49,10),(50,10),(51,10),(52,10),(53,10),(54,10),(109,10),(110,10),(111,10),(112,10),(113,10),(114,10),(115,10),(116,10),(117,10),(118,10),(119,10),(120,10),(121,10),(122,10),(123,10),(124,10),(125,10),(126,10),(127,10),(128,10),(129,10),(130,10),(131,10),(132,10),(133,10),(134,10),(135,10),(136,10),(137,10),(138,10),(139,10),(140,10),(141,10),(142,10),(143,10),(144,10),(145,10),(146,10),(1,11),(2,11),(3,11),(4,11),(5,11),(6,11),(7,11),(8,11),(9,11),(10,11),(11,11),(12,11),(13,11),(14,11),(15,11),(16,11),(17,11),(18,11),(19,11),(20,11),(21,11),(22,11),(23,11),(24,11),(25,11),(26,11),(27,11),(28,11),(29,11),(30,11),(31,11),(32,11),(33,11),(34,11),(35,11),(36,11),(37,11),(38,11),(39,11),(40,11),(41,11),(42,11),(43,11),(44,11),(45,11),(46,11),(47,11),(48,11),(49,11),(50,11),(51,11),(52,11),(53,11),(54,11),(109,11),(110,11),(111,11),(112,11),(113,11),(114,11),(115,11),(116,11),(117,11),(118,11),(119,11),(120,11),(121,11),(122,11),(123,11),(124,11),(125,11),(126,11),(127,11),(128,11),(129,11),(130,11),(131,11),(132,11),(133,11),(134,11),(135,11),(136,11),(137,11),(138,11),(139,11),(140,11),(141,11),(142,11),(143,11),(144,11),(145,11),(146,11),(1,14),(2,14),(3,14),(4,14),(5,14),(6,14),(7,14),(8,14),(9,14),(10,14),(11,14),(12,14),(13,14),(14,14),(15,14),(16,14),(17,14),(18,14),(19,14),(20,14),(21,14),(22,14),(23,14),(24,14),(25,14),(26,14),(27,14),(28,14),(29,14),(30,14),(31,14),(32,14),(33,14),(34,14),(35,14),(36,14),(37,14),(38,14),(39,14),(40,14),(41,14),(42,14),(43,14),(44,14),(45,14),(46,14),(47,14),(48,14),(49,14),(50,14),(51,14),(52,14),(53,14),(54,14),(109,14),(110,14),(111,14),(112,14),(113,14),(114,14),(115,14),(116,14),(117,14),(118,14),(119,14),(120,14),(121,14),(122,14),(123,14),(124,14),(125,14),(126,14),(127,14),(128,14),(129,14),(130,14),(131,14),(132,14),(133,14),(134,14),(135,14),(136,14),(137,14),(138,14),(139,14),(140,14),(141,14),(142,14),(143,14),(144,14),(145,14),(146,14),(1,15),(2,15),(3,15),(4,15),(5,15),(6,15),(7,15),(8,15),(9,15),(10,15),(11,15),(12,15),(13,15),(14,15),(15,15),(16,15),(17,15),(18,15),(19,15),(20,15),(21,15),(22,15),(23,15),(24,15),(25,15),(26,15),(27,15),(28,15),(29,15),(30,15),(31,15),(32,15),(33,15),(34,15),(35,15),(36,15),(37,15),(38,15),(39,15),(40,15),(41,15),(42,15),(43,15),(44,15),(45,15),(46,15),(47,15),(48,15),(49,15),(50,15),(51,15),(52,15),(53,15),(54,15),(109,15),(110,15),(111,15),(112,15),(113,15),(114,15),(115,15),(116,15),(117,15),(118,15),(119,15),(120,15),(121,15),(122,15),(123,15),(124,15),(125,15),(126,15),(127,15),(128,15),(129,15),(130,15),(131,15),(132,15),(133,15),(134,15),(135,15),(136,15),(137,15),(138,15),(139,15),(140,15),(141,15),(142,15),(143,15),(144,15),(145,15),(146,15);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`),
  KEY `roles_restaurant_id_foreign` (`restaurant_id`),
  CONSTRAINT `roles_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Super Admin','Super Admin','web','2025-11-30 02:57:22','2025-11-30 02:57:22',NULL),(2,'Admin_1','Admin','web','2025-11-30 02:57:24','2025-11-30 02:57:24',1),(3,'Branch Head_1','Branch Head','web','2025-11-30 02:57:24','2025-11-30 02:57:24',1),(4,'Waiter_1','Waiter','web','2025-11-30 02:57:24','2025-11-30 02:57:24',1),(5,'Chef_1','Chef','web','2025-11-30 02:57:24','2025-11-30 02:57:24',1),(6,'Admin_2','Admin','web','2025-11-30 03:00:25','2025-11-30 03:00:25',2),(7,'Branch Head_2','Branch Head','web','2025-11-30 03:00:25','2025-11-30 03:00:25',2),(8,'Waiter_2','Waiter','web','2025-11-30 03:00:25','2025-11-30 03:00:25',2),(9,'Chef_2','Chef','web','2025-11-30 03:00:25','2025-11-30 03:00:25',2),(10,'Admin_3','Admin','web','2025-11-30 03:00:30','2025-11-30 03:00:30',3),(11,'Branch Head_3','Branch Head','web','2025-11-30 03:00:30','2025-11-30 03:00:30',3),(12,'Waiter_3','Waiter','web','2025-11-30 03:00:30','2025-11-30 03:00:30',3),(13,'Chef_3','Chef','web','2025-11-30 03:00:30','2025-11-30 03:00:30',3),(14,'Admin_4','Admin','web','2025-11-30 03:00:34','2025-11-30 03:00:34',4),(15,'Branch Head_4','Branch Head','web','2025-11-30 03:00:34','2025-11-30 03:00:34',4),(16,'Waiter_4','Waiter','web','2025-11-30 03:00:34','2025-11-30 03:00:34',4),(17,'Chef_4','Chef','web','2025-11-30 03:00:34','2025-11-30 03:00:34',4);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('HgjP4CnGqIJjOr08HSL1M71yguJN647pvxRPbhg6',2,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','YToyMDp7czo2OiJfdG9rZW4iO3M6NDA6ImFIMWpvNVdtYWtPMHI0SFJwWElMcUhZOFBBN2FMM0R2WW96Mmd6MloiO3M6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6MjA6ImNoZWNrX21pZ3JhdGVfc3RhdHVzIjtzOjQ6Ikdvb2QiO3M6MTU6ImN1c3RvbWVyX2lzX3J0bCI7aTowO3M6NDoidXNlciI7TzoxNToiQXBwXE1vZGVsc1xVc2VyIjozNjp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJteXNxbCI7czo4OiIAKgB0YWJsZSI7czo1OiJ1c2VycyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjI0OntzOjI6ImlkIjtpOjI7czoxMzoicmVzdGF1cmFudF9pZCI7aToxO3M6OToiYnJhbmNoX2lkIjtOO3M6NDoibmFtZSI7czo4OiJKb2huIERvZSI7czo1OiJlbWFpbCI7czoxNzoiYWRtaW5AZXhhbXBsZS5jb20iO3M6MTI6InBob25lX251bWJlciI7TjtzOjEwOiJwaG9uZV9jb2RlIjtOO3M6MjY6InRlcm1zX2FuZF9wcml2YWN5X2FjY2VwdGVkIjtpOjA7czoyNToibWFya2V0aW5nX2VtYWlsc19hY2NlcHRlZCI7aTowO3M6MTc6ImVtYWlsX3ZlcmlmaWVkX2F0IjtOO3M6ODoicGFzc3dvcmQiO3M6NjA6IiQyeSQxMiQ4LmsuSG05VjNxWXJwV2ZBN2t4TG5lLkFKakpDUXdOeVRQaXZjUk4ybThhVFhFLjJFVVJpcSI7czoxNzoidHdvX2ZhY3Rvcl9zZWNyZXQiO047czoyNToidHdvX2ZhY3Rvcl9yZWNvdmVyeV9jb2RlcyI7TjtzOjIzOiJ0d29fZmFjdG9yX2NvbmZpcm1lZF9hdCI7TjtzOjE0OiJyZW1lbWJlcl90b2tlbiI7TjtzOjE1OiJjdXJyZW50X3RlYW1faWQiO047czoxODoicHJvZmlsZV9waG90b19wYXRoIjtOO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDg6Mjc6MjUiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjUtMTItMDIgMTU6NDY6MzMiO3M6NjoibG9jYWxlIjtzOjI6ImVuIjtzOjk6InN0cmlwZV9pZCI7TjtzOjc6InBtX3R5cGUiO047czoxMjoicG1fbGFzdF9mb3VyIjtOO3M6MTM6InRyaWFsX2VuZHNfYXQiO047fXM6MTE6IgAqAG9yaWdpbmFsIjthOjI0OntzOjI6ImlkIjtpOjI7czoxMzoicmVzdGF1cmFudF9pZCI7aToxO3M6OToiYnJhbmNoX2lkIjtOO3M6NDoibmFtZSI7czo4OiJKb2huIERvZSI7czo1OiJlbWFpbCI7czoxNzoiYWRtaW5AZXhhbXBsZS5jb20iO3M6MTI6InBob25lX251bWJlciI7TjtzOjEwOiJwaG9uZV9jb2RlIjtOO3M6MjY6InRlcm1zX2FuZF9wcml2YWN5X2FjY2VwdGVkIjtpOjA7czoyNToibWFya2V0aW5nX2VtYWlsc19hY2NlcHRlZCI7aTowO3M6MTc6ImVtYWlsX3ZlcmlmaWVkX2F0IjtOO3M6ODoicGFzc3dvcmQiO3M6NjA6IiQyeSQxMiQ4LmsuSG05VjNxWXJwV2ZBN2t4TG5lLkFKakpDUXdOeVRQaXZjUk4ybThhVFhFLjJFVVJpcSI7czoxNzoidHdvX2ZhY3Rvcl9zZWNyZXQiO047czoyNToidHdvX2ZhY3Rvcl9yZWNvdmVyeV9jb2RlcyI7TjtzOjIzOiJ0d29fZmFjdG9yX2NvbmZpcm1lZF9hdCI7TjtzOjE0OiJyZW1lbWJlcl90b2tlbiI7TjtzOjE1OiJjdXJyZW50X3RlYW1faWQiO047czoxODoicHJvZmlsZV9waG90b19wYXRoIjtOO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDg6Mjc6MjUiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjUtMTItMDIgMTU6NDY6MzMiO3M6NjoibG9jYWxlIjtzOjI6ImVuIjtzOjk6InN0cmlwZV9pZCI7TjtzOjc6InBtX3R5cGUiO047czoxMjoicG1fbGFzdF9mb3VyIjtOO3M6MTM6InRyaWFsX2VuZHNfYXQiO047fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjY6e3M6MTc6ImVtYWlsX3ZlcmlmaWVkX2F0IjtzOjg6ImRhdGV0aW1lIjtzOjg6InBhc3N3b3JkIjtzOjY6Imhhc2hlZCI7czoxMzoicmVzdGF1cmFudF9pZCI7czo3OiJpbnRlZ2VyIjtzOjk6ImJyYW5jaF9pZCI7czo3OiJpbnRlZ2VyIjtzOjI2OiJ0ZXJtc19hbmRfcHJpdmFjeV9hY2NlcHRlZCI7czo3OiJib29sZWFuIjtzOjI1OiJtYXJrZXRpbmdfZW1haWxzX2FjY2VwdGVkIjtzOjc6ImJvb2xlYW4iO31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MTp7aTowO3M6MTc6InByb2ZpbGVfcGhvdG9fdXJsIjt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTozOntzOjEwOiJyZXN0YXVyYW50IjtPOjIxOiJBcHBcTW9kZWxzXFJlc3RhdXJhbnQiOjM5OntzOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjExOiJyZXN0YXVyYW50cyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjgzOntzOjI6ImlkIjtpOjE7czoxMDoic3ViX2RvbWFpbiI7czoyMDoiZGVtby50YWJsZXRyYWNrLnRlc3QiO3M6NDoibmFtZSI7czoxNToiRGVtbyBSZXN0YXVyYW50IjtzOjQ6Imhhc2giO3M6MTU6ImRlbW8tcmVzdGF1cmFudCI7czo3OiJhZGRyZXNzIjtzOjUxOiI0NTA4MiBNYXRpbGRlIERpdmlkZSBBcHQuIDgzOQpNYWRpc3luc2lkZSwgQVogMjM4NjMiO3M6MTI6InBob25lX251bWJlciI7czoxMjoiKzE3Mzc4NjQxNDAzIjtzOjEwOiJwaG9uZV9jb2RlIjtOO3M6NToiZW1haWwiO3M6Mjc6ImRlbW8ucmVzdGF1cmFudEBleGFtcGxlLmNvbSI7czo4OiJ0aW1lem9uZSI7czoxNjoiQW1lcmljYS9OZXdfWW9yayI7czo5OiJ0aGVtZV9oZXgiO3M6NzoiI0E3OEJGQSI7czo5OiJ0aGVtZV9yZ2IiO3M6MTM6IjE2NywgMTM5LCAyNTAiO3M6NDoibG9nbyI7TjtzOjEwOiJjb3VudHJ5X2lkIjtpOjIzNjtzOjE1OiJoaWRlX25ld19vcmRlcnMiO2k6MDtzOjIxOiJoaWRlX25ld19yZXNlcnZhdGlvbnMiO2k6MDtzOjIzOiJoaWRlX25ld193YWl0ZXJfcmVxdWVzdCI7aTowO3M6MTE6ImN1cnJlbmN5X2lkIjtpOjE7czoxMjoibGljZW5zZV90eXBlIjtzOjQ6InBhaWQiO3M6OToiaXNfYWN0aXZlIjtpOjE7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMyI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwOTo0OTo0OCI7czoyMzoiY3VzdG9tZXJfbG9naW5fcmVxdWlyZWQiO2k6MDtzOjg6ImFib3V0X3VzIjtzOjEzMDQ6IjxwIGNsYXNzPSJ0ZXh0LWxnIHRleHQtZ3JheS02MDAgbWItNiI+CiAgICAgICAgICBXZWxjb21lIHRvIG91ciByZXN0YXVyYW50LCB3aGVyZSBncmVhdCBmb29kIGFuZCBnb29kIHZpYmVzIGNvbWUgdG9nZXRoZXIhIFdlJ3JlIGEgbG9jYWwsIGZhbWlseS1vd25lZCBzcG90IHRoYXQgbG92ZXMgYnJpbmdpbmcgcGVvcGxlIHRvZ2V0aGVyIG92ZXIgZGVsaWNpb3VzIG1lYWxzIGFuZCB1bmZvcmdldHRhYmxlIG1vbWVudHMuIFdoZXRoZXIgeW91J3JlIGhlcmUgZm9yIGEgcXVpY2sgYml0ZSwgYSBmYW1pbHkgZGlubmVyLCBvciBhIGNlbGVicmF0aW9uLCB3ZSdyZSBhbGwgYWJvdXQgbWFraW5nIHlvdXIgdGltZSB3aXRoIHVzIHNwZWNpYWwuCiAgICAgICAgPC9wPgogICAgICAgIDxwIGNsYXNzPSJ0ZXh0LWxnIHRleHQtZ3JheS02MDAgbWItNiI+CiAgICAgICAgICBPdXIgbWVudSBpcyBwYWNrZWQgd2l0aCBkaXNoZXMgbWFkZSBmcm9tIGZyZXNoLCBxdWFsaXR5IGluZ3JlZGllbnRzIGJlY2F1c2Ugd2UgYmVsaWV2ZSBmb29kIHNob3VsZCB0YXN0ZSBhcwogICAgICAgICAgZ29vZCBhcyBpdCBtYWtlcyB5b3UgZmVlbC4gRnJvbSBvdXIgc2lnbmF0dXJlIGRpc2hlcyB0byBzZWFzb25hbCBzcGVjaWFscywgdGhlcmUncyBhbHdheXMgc29tZXRoaW5nIHRvIGV4Y2l0ZQogICAgICAgICAgeW91ciB0YXN0ZSBidWRzLgogICAgICAgIDwvcD4KICAgICAgICA8cCBjbGFzcz0idGV4dC1sZyB0ZXh0LWdyYXktNjAwIG1iLTYiPgogICAgICAgICAgQnV0IHdlJ3JlIG5vdCBqdXN0IGFib3V0IHRoZSBmb29k4oCUd2UncmUgYWJvdXQgY29tbXVuaXR5LiBXZSBsb3ZlIHNlZWluZyBmYW1pbGlhciBmYWNlcyBhbmQgd2VsY29taW5nIG5ldyBvbmVzLgogICAgICAgICAgT3VyIHRlYW0gaXMgYSBmdW4sIGZyaWVuZGx5IGJ1bmNoIGRlZGljYXRlZCB0byBzZXJ2aW5nIHlvdSB3aXRoIGEgc21pbGUgYW5kIG1ha2luZyBzdXJlIGV2ZXJ5IHZpc2l0IGZlZWxzIGxpa2UKICAgICAgICAgIGNvbWluZyBob21lLgogICAgICAgIDwvcD4KICAgICAgICA8cCBjbGFzcz0idGV4dC1sZyB0ZXh0LWdyYXktNjAwIj4KICAgICAgICAgIFNvLCBjb21lIG9uIGluLCBncmFiIGEgc2VhdCwgYW5kIGxldCB1cyB0YWtlIGNhcmUgb2YgdGhlIHJlc3QuIFdlIGNhbid0IHdhaXQgdG8gc2hhcmUgb3VyIGxvdmUgb2YgZm9vZCB3aXRoCiAgICAgICAgICB5b3UhCiAgICAgICAgPC9wPgogICAgICAgIDxwIGNsYXNzPSJ0ZXh0LWxnIHRleHQtZ3JheS04MDAgZm9udC1zZW1pYm9sZCBtdC02Ij5TZWUgeW91IHNvb24hIPCfjb3vuI/inKg8L3A+IjtzOjMwOiJhbGxvd19jdXN0b21lcl9kZWxpdmVyeV9vcmRlcnMiO2k6MTtzOjI4OiJhbGxvd19jdXN0b21lcl9waWNrdXBfb3JkZXJzIjtpOjE7czoxNzoicGlja3VwX2RheXNfcmFuZ2UiO2k6NztzOjIxOiJhbGxvd19jdXN0b21lcl9vcmRlcnMiO2k6MTtzOjIwOiJhbGxvd19kaW5lX2luX29yZGVycyI7aToxO3M6ODoic2hvd192ZWciO2k6MTtzOjEwOiJzaG93X2hhbGFsIjtpOjA7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6MTI6InBhY2thZ2VfdHlwZSI7czo1OiJ0cmlhbCI7czo2OiJzdGF0dXMiO3M6NjoiYWN0aXZlIjtzOjE3OiJsaWNlbnNlX2V4cGlyZV9vbiI7czoxOToiMjAyNS0xMi0zMCAwODoyNzoyMyI7czo5OiJjb3VudF9zbXMiO2k6MDtzOjk6InRvdGFsX3NtcyI7aTotMTtzOjEzOiJ0cmlhbF9lbmRzX2F0IjtzOjE5OiIyMDI1LTEyLTMwIDA4OjI3OjIzIjtzOjE4OiJsaWNlbnNlX3VwZGF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDg6Mjc6MjMiO3M6MjM6InN1YnNjcmlwdGlvbl91cGRhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA4OjI3OjIzIjtzOjk6InN0cmlwZV9pZCI7TjtzOjc6InBtX3R5cGUiO047czoxMjoicG1fbGFzdF9mb3VyIjtOO3M6MjU6ImlzX3dhaXRlcl9yZXF1ZXN0X2VuYWJsZWQiO2k6MTtzOjMyOiJkZWZhdWx0X3RhYmxlX3Jlc2VydmF0aW9uX3N0YXR1cyI7czo5OiJDb25maXJtZWQiO3M6MjA6ImRpc2FibGVfc2xvdF9taW51dGVzIjtpOjMwO3M6MTU6ImFwcHJvdmFsX3N0YXR1cyI7czo4OiJBcHByb3ZlZCI7czoxNjoicmVqZWN0aW9uX3JlYXNvbiI7TjtzOjEzOiJmYWNlYm9va19saW5rIjtzOjI1OiJodHRwczovL3d3dy5mYWNlYm9vay5jb20vIjtzOjE0OiJpbnN0YWdyYW1fbGluayI7czoyNjoiaHR0cHM6Ly93d3cuaW5zdGFncmFtLmNvbS8iO3M6MTI6InR3aXR0ZXJfbGluayI7czoyNDoiaHR0cHM6Ly93d3cudHdpdHRlci5jb20vIjtzOjk6InllbHBfbGluayI7TjtzOjE0OiJ0YWJsZV9yZXF1aXJlZCI7aTowO3M6MTQ6InNob3dfbG9nb190ZXh0IjtpOjE7czoxMjoibWV0YV9rZXl3b3JkIjtOO3M6MTY6Im1ldGFfZGVzY3JpcHRpb24iO047czozNDoidXBsb2FkX2Zhdl9pY29uX2FuZHJvaWRfY2hyb21lXzE5MiI7TjtzOjM0OiJ1cGxvYWRfZmF2X2ljb25fYW5kcm9pZF9jaHJvbWVfNTEyIjtOO3M6MzI6InVwbG9hZF9mYXZfaWNvbl9hcHBsZV90b3VjaF9pY29uIjtOO3M6MTc6InVwbG9hZF9mYXZpY29uXzE2IjtOO3M6MTc6InVwbG9hZF9mYXZpY29uXzMyIjtOO3M6NzoiZmF2aWNvbiI7TjtzOjM2OiJpc193YWl0ZXJfcmVxdWVzdF9lbmFibGVkX29uX2Rlc2t0b3AiO2k6MTtzOjM1OiJpc193YWl0ZXJfcmVxdWVzdF9lbmFibGVkX29uX21vYmlsZSI7aToxO3M6MzY6ImlzX3dhaXRlcl9yZXF1ZXN0X2VuYWJsZWRfb3Blbl9ieV9xciI7aTowO3M6MTE6IndlYm1hbmlmZXN0IjtOO3M6MTU6ImVuYWJsZV90aXBfc2hvcCI7aToxO3M6MTQ6ImVuYWJsZV90aXBfcG9zIjtpOjE7czoyNToiaXNfcHdhX2luc3RhbGxfYWxlcnRfc2hvdyI7aTowO3M6MTk6ImF1dG9fY29uZmlybV9vcmRlcnMiO2k6MDtzOjI5OiJyZXN0cmljdF9xcl9vcmRlcl9ieV9sb2NhdGlvbiI7aTowO3M6MjI6InFyX29yZGVyX3JhZGl1c19tZXRlcnMiO047czoyMzoic2hvd19vcmRlcl90eXBlX29wdGlvbnMiO2k6MTtzOjI0OiJkaXNhYmxlX29yZGVyX3R5cGVfcG9wdXAiO2k6MDtzOjIxOiJkZWZhdWx0X29yZGVyX3R5cGVfaWQiO047czoyNzoiaGlkZV9tZW51X2l0ZW1faW1hZ2Vfb25fcG9zIjtpOjA7czozNzoiaGlkZV9tZW51X2l0ZW1faW1hZ2Vfb25fY3VzdG9tZXJfc2l0ZSI7aTowO3M6ODoidGF4X21vZGUiO3M6NToib3JkZXIiO3M6MTM6InRheF9pbmNsdXNpdmUiO2k6MDtzOjIyOiJjdXN0b21lcl9zaXRlX2xhbmd1YWdlIjtzOjI6ImVuIjtzOjI0OiJlbmFibGVfYWRtaW5fcmVzZXJ2YXRpb24iO2k6MTtzOjI3OiJlbmFibGVfY3VzdG9tZXJfcmVzZXJ2YXRpb24iO2k6MTtzOjE4OiJtaW5pbXVtX3BhcnR5X3NpemUiO2k6MTtzOjI2OiJ0YWJsZV9sb2NrX3RpbWVvdXRfbWludXRlcyI7aToxMDt9czoxMToiACoAb3JpZ2luYWwiO2E6ODM6e3M6MjoiaWQiO2k6MTtzOjEwOiJzdWJfZG9tYWluIjtzOjIwOiJkZW1vLnRhYmxldHJhY2sudGVzdCI7czo0OiJuYW1lIjtzOjE1OiJEZW1vIFJlc3RhdXJhbnQiO3M6NDoiaGFzaCI7czoxNToiZGVtby1yZXN0YXVyYW50IjtzOjc6ImFkZHJlc3MiO3M6NTE6IjQ1MDgyIE1hdGlsZGUgRGl2aWRlIEFwdC4gODM5Ck1hZGlzeW5zaWRlLCBBWiAyMzg2MyI7czoxMjoicGhvbmVfbnVtYmVyIjtzOjEyOiIrMTczNzg2NDE0MDMiO3M6MTA6InBob25lX2NvZGUiO047czo1OiJlbWFpbCI7czoyNzoiZGVtby5yZXN0YXVyYW50QGV4YW1wbGUuY29tIjtzOjg6InRpbWV6b25lIjtzOjE2OiJBbWVyaWNhL05ld19Zb3JrIjtzOjk6InRoZW1lX2hleCI7czo3OiIjQTc4QkZBIjtzOjk6InRoZW1lX3JnYiI7czoxMzoiMTY3LCAxMzksIDI1MCI7czo0OiJsb2dvIjtOO3M6MTA6ImNvdW50cnlfaWQiO2k6MjM2O3M6MTU6ImhpZGVfbmV3X29yZGVycyI7aTowO3M6MjE6ImhpZGVfbmV3X3Jlc2VydmF0aW9ucyI7aTowO3M6MjM6ImhpZGVfbmV3X3dhaXRlcl9yZXF1ZXN0IjtpOjA7czoxMToiY3VycmVuY3lfaWQiO2k6MTtzOjEyOiJsaWNlbnNlX3R5cGUiO3M6NDoicGFpZCI7czo5OiJpc19hY3RpdmUiO2k6MTtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA4OjI3OjIzIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA5OjQ5OjQ4IjtzOjIzOiJjdXN0b21lcl9sb2dpbl9yZXF1aXJlZCI7aTowO3M6ODoiYWJvdXRfdXMiO3M6MTMwNDoiPHAgY2xhc3M9InRleHQtbGcgdGV4dC1ncmF5LTYwMCBtYi02Ij4KICAgICAgICAgIFdlbGNvbWUgdG8gb3VyIHJlc3RhdXJhbnQsIHdoZXJlIGdyZWF0IGZvb2QgYW5kIGdvb2QgdmliZXMgY29tZSB0b2dldGhlciEgV2UncmUgYSBsb2NhbCwgZmFtaWx5LW93bmVkIHNwb3QgdGhhdCBsb3ZlcyBicmluZ2luZyBwZW9wbGUgdG9nZXRoZXIgb3ZlciBkZWxpY2lvdXMgbWVhbHMgYW5kIHVuZm9yZ2V0dGFibGUgbW9tZW50cy4gV2hldGhlciB5b3UncmUgaGVyZSBmb3IgYSBxdWljayBiaXRlLCBhIGZhbWlseSBkaW5uZXIsIG9yIGEgY2VsZWJyYXRpb24sIHdlJ3JlIGFsbCBhYm91dCBtYWtpbmcgeW91ciB0aW1lIHdpdGggdXMgc3BlY2lhbC4KICAgICAgICA8L3A+CiAgICAgICAgPHAgY2xhc3M9InRleHQtbGcgdGV4dC1ncmF5LTYwMCBtYi02Ij4KICAgICAgICAgIE91ciBtZW51IGlzIHBhY2tlZCB3aXRoIGRpc2hlcyBtYWRlIGZyb20gZnJlc2gsIHF1YWxpdHkgaW5ncmVkaWVudHMgYmVjYXVzZSB3ZSBiZWxpZXZlIGZvb2Qgc2hvdWxkIHRhc3RlIGFzCiAgICAgICAgICBnb29kIGFzIGl0IG1ha2VzIHlvdSBmZWVsLiBGcm9tIG91ciBzaWduYXR1cmUgZGlzaGVzIHRvIHNlYXNvbmFsIHNwZWNpYWxzLCB0aGVyZSdzIGFsd2F5cyBzb21ldGhpbmcgdG8gZXhjaXRlCiAgICAgICAgICB5b3VyIHRhc3RlIGJ1ZHMuCiAgICAgICAgPC9wPgogICAgICAgIDxwIGNsYXNzPSJ0ZXh0LWxnIHRleHQtZ3JheS02MDAgbWItNiI+CiAgICAgICAgICBCdXQgd2UncmUgbm90IGp1c3QgYWJvdXQgdGhlIGZvb2TigJR3ZSdyZSBhYm91dCBjb21tdW5pdHkuIFdlIGxvdmUgc2VlaW5nIGZhbWlsaWFyIGZhY2VzIGFuZCB3ZWxjb21pbmcgbmV3IG9uZXMuCiAgICAgICAgICBPdXIgdGVhbSBpcyBhIGZ1biwgZnJpZW5kbHkgYnVuY2ggZGVkaWNhdGVkIHRvIHNlcnZpbmcgeW91IHdpdGggYSBzbWlsZSBhbmQgbWFraW5nIHN1cmUgZXZlcnkgdmlzaXQgZmVlbHMgbGlrZQogICAgICAgICAgY29taW5nIGhvbWUuCiAgICAgICAgPC9wPgogICAgICAgIDxwIGNsYXNzPSJ0ZXh0LWxnIHRleHQtZ3JheS02MDAiPgogICAgICAgICAgU28sIGNvbWUgb24gaW4sIGdyYWIgYSBzZWF0LCBhbmQgbGV0IHVzIHRha2UgY2FyZSBvZiB0aGUgcmVzdC4gV2UgY2FuJ3Qgd2FpdCB0byBzaGFyZSBvdXIgbG92ZSBvZiBmb29kIHdpdGgKICAgICAgICAgIHlvdSEKICAgICAgICA8L3A+CiAgICAgICAgPHAgY2xhc3M9InRleHQtbGcgdGV4dC1ncmF5LTgwMCBmb250LXNlbWlib2xkIG10LTYiPlNlZSB5b3Ugc29vbiEg8J+Nve+4j+KcqDwvcD4iO3M6MzA6ImFsbG93X2N1c3RvbWVyX2RlbGl2ZXJ5X29yZGVycyI7aToxO3M6Mjg6ImFsbG93X2N1c3RvbWVyX3BpY2t1cF9vcmRlcnMiO2k6MTtzOjE3OiJwaWNrdXBfZGF5c19yYW5nZSI7aTo3O3M6MjE6ImFsbG93X2N1c3RvbWVyX29yZGVycyI7aToxO3M6MjA6ImFsbG93X2RpbmVfaW5fb3JkZXJzIjtpOjE7czo4OiJzaG93X3ZlZyI7aToxO3M6MTA6InNob3dfaGFsYWwiO2k6MDtzOjEwOiJwYWNrYWdlX2lkIjtpOjU7czoxMjoicGFja2FnZV90eXBlIjtzOjU6InRyaWFsIjtzOjY6InN0YXR1cyI7czo2OiJhY3RpdmUiO3M6MTc6ImxpY2Vuc2VfZXhwaXJlX29uIjtzOjE5OiIyMDI1LTEyLTMwIDA4OjI3OjIzIjtzOjk6ImNvdW50X3NtcyI7aTowO3M6OToidG90YWxfc21zIjtpOi0xO3M6MTM6InRyaWFsX2VuZHNfYXQiO3M6MTk6IjIwMjUtMTItMzAgMDg6Mjc6MjMiO3M6MTg6ImxpY2Vuc2VfdXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMyI7czoyMzoic3Vic2NyaXB0aW9uX3VwZGF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDg6Mjc6MjMiO3M6OToic3RyaXBlX2lkIjtOO3M6NzoicG1fdHlwZSI7TjtzOjEyOiJwbV9sYXN0X2ZvdXIiO047czoyNToiaXNfd2FpdGVyX3JlcXVlc3RfZW5hYmxlZCI7aToxO3M6MzI6ImRlZmF1bHRfdGFibGVfcmVzZXJ2YXRpb25fc3RhdHVzIjtzOjk6IkNvbmZpcm1lZCI7czoyMDoiZGlzYWJsZV9zbG90X21pbnV0ZXMiO2k6MzA7czoxNToiYXBwcm92YWxfc3RhdHVzIjtzOjg6IkFwcHJvdmVkIjtzOjE2OiJyZWplY3Rpb25fcmVhc29uIjtOO3M6MTM6ImZhY2Vib29rX2xpbmsiO3M6MjU6Imh0dHBzOi8vd3d3LmZhY2Vib29rLmNvbS8iO3M6MTQ6Imluc3RhZ3JhbV9saW5rIjtzOjI2OiJodHRwczovL3d3dy5pbnN0YWdyYW0uY29tLyI7czoxMjoidHdpdHRlcl9saW5rIjtzOjI0OiJodHRwczovL3d3dy50d2l0dGVyLmNvbS8iO3M6OToieWVscF9saW5rIjtOO3M6MTQ6InRhYmxlX3JlcXVpcmVkIjtpOjA7czoxNDoic2hvd19sb2dvX3RleHQiO2k6MTtzOjEyOiJtZXRhX2tleXdvcmQiO047czoxNjoibWV0YV9kZXNjcmlwdGlvbiI7TjtzOjM0OiJ1cGxvYWRfZmF2X2ljb25fYW5kcm9pZF9jaHJvbWVfMTkyIjtOO3M6MzQ6InVwbG9hZF9mYXZfaWNvbl9hbmRyb2lkX2Nocm9tZV81MTIiO047czozMjoidXBsb2FkX2Zhdl9pY29uX2FwcGxlX3RvdWNoX2ljb24iO047czoxNzoidXBsb2FkX2Zhdmljb25fMTYiO047czoxNzoidXBsb2FkX2Zhdmljb25fMzIiO047czo3OiJmYXZpY29uIjtOO3M6MzY6ImlzX3dhaXRlcl9yZXF1ZXN0X2VuYWJsZWRfb25fZGVza3RvcCI7aToxO3M6MzU6ImlzX3dhaXRlcl9yZXF1ZXN0X2VuYWJsZWRfb25fbW9iaWxlIjtpOjE7czozNjoiaXNfd2FpdGVyX3JlcXVlc3RfZW5hYmxlZF9vcGVuX2J5X3FyIjtpOjA7czoxMToid2VibWFuaWZlc3QiO047czoxNToiZW5hYmxlX3RpcF9zaG9wIjtpOjE7czoxNDoiZW5hYmxlX3RpcF9wb3MiO2k6MTtzOjI1OiJpc19wd2FfaW5zdGFsbF9hbGVydF9zaG93IjtpOjA7czoxOToiYXV0b19jb25maXJtX29yZGVycyI7aTowO3M6Mjk6InJlc3RyaWN0X3FyX29yZGVyX2J5X2xvY2F0aW9uIjtpOjA7czoyMjoicXJfb3JkZXJfcmFkaXVzX21ldGVycyI7TjtzOjIzOiJzaG93X29yZGVyX3R5cGVfb3B0aW9ucyI7aToxO3M6MjQ6ImRpc2FibGVfb3JkZXJfdHlwZV9wb3B1cCI7aTowO3M6MjE6ImRlZmF1bHRfb3JkZXJfdHlwZV9pZCI7TjtzOjI3OiJoaWRlX21lbnVfaXRlbV9pbWFnZV9vbl9wb3MiO2k6MDtzOjM3OiJoaWRlX21lbnVfaXRlbV9pbWFnZV9vbl9jdXN0b21lcl9zaXRlIjtpOjA7czo4OiJ0YXhfbW9kZSI7czo1OiJvcmRlciI7czoxMzoidGF4X2luY2x1c2l2ZSI7aTowO3M6MjI6ImN1c3RvbWVyX3NpdGVfbGFuZ3VhZ2UiO3M6MjoiZW4iO3M6MjQ6ImVuYWJsZV9hZG1pbl9yZXNlcnZhdGlvbiI7aToxO3M6Mjc6ImVuYWJsZV9jdXN0b21lcl9yZXNlcnZhdGlvbiI7aToxO3M6MTg6Im1pbmltdW1fcGFydHlfc2l6ZSI7aToxO3M6MjY6InRhYmxlX2xvY2tfdGltZW91dF9taW51dGVzIjtpOjEwO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YToxMTp7czoxNzoibGljZW5zZV9leHBpcmVfb24iO3M6ODoiZGF0ZXRpbWUiO3M6MTU6InRyaWFsX2V4cGlyZV9vbiI7czo4OiJkYXRldGltZSI7czoxODoibGljZW5zZV91cGRhdGVkX2F0IjtzOjg6ImRhdGV0aW1lIjtzOjIzOiJzdWJzY3JpcHRpb25fdXBkYXRlZF9hdCI7czo4OiJkYXRldGltZSI7czoxMDoiY3JlYXRlZF9hdCI7czo4OiJkYXRldGltZSI7czoxMDoidXBkYXRlZF9hdCI7czo4OiJkYXRldGltZSI7czoyMzoiY3VzdG9tX2RlbGl2ZXJ5X29wdGlvbnMiO3M6NToiYXJyYXkiO3M6OToiaXNfYWN0aXZlIjtzOjc6ImJvb2xlYW4iO3M6MjQ6ImVuYWJsZV9hZG1pbl9yZXNlcnZhdGlvbiI7czo3OiJib29sZWFuIjtzOjI3OiJlbmFibGVfY3VzdG9tZXJfcmVzZXJ2YXRpb24iO3M6NzoiYm9vbGVhbiI7czoyOToicmVzdHJpY3RfcXJfb3JkZXJfYnlfbG9jYXRpb24iO3M6NzoiYm9vbGVhbiI7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YToxOntpOjA7czo4OiJsb2dvX3VybCI7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo4OiJicmFuY2hlcyI7TzozOToiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxDb2xsZWN0aW9uIjoyOntzOjg6IgAqAGl0ZW1zIjthOjI6e2k6MDtPOjE3OiJBcHBcTW9kZWxzXEJyYW5jaCI6MzM6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6ODoiYnJhbmNoZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToyMTp7czoyOiJpZCI7aToxO3M6MTE6InVuaXF1ZV9oYXNoIjtzOjIwOiJiMzEzODNjNWZjNGYyM2QxNzZmZCI7czoxMzoicmVzdGF1cmFudF9pZCI7aToxO3M6NDoibmFtZSI7czoxMToiRGFwaG5leXRvd24iO3M6MTg6ImNsb25lZF9icmFuY2hfbmFtZSI7TjtzOjE2OiJjbG9uZWRfYnJhbmNoX2lkIjtOO3M6MTM6ImlzX21lbnVfY2xvbmUiO2k6MDtzOjI0OiJpc19pdGVtX2NhdGVnb3JpZXNfY2xvbmUiO2k6MDtzOjE5OiJpc19tZW51X2l0ZW1zX2Nsb25lIjtpOjA7czoyMzoiaXNfaXRlbV9tb2RpZmllcnNfY2xvbmUiO2k6MDtzOjI5OiJpc19jbG9uZV9yZXNlcnZhdGlvbl9zZXR0aW5ncyI7aTowO3M6MjY6ImlzX2Nsb25lX2RlbGl2ZXJ5X3NldHRpbmdzIjtpOjA7czoyMDoiaXNfY2xvbmVfa290X3NldHRpbmciO2k6MDtzOjI1OiJpc19tb2RpZmllcnNfZ3JvdXBzX2Nsb25lIjtpOjA7czo3OiJhZGRyZXNzIjtzOjU5OiI0MTcgRnJpdHNjaCBTdHJlZXRzIFN1aXRlIDA2MApMYWtlIFNhc2hhc2lkZSwgREMgNzc0OTItNjAyNiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMyI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODozMDoyNSI7czozOiJsYXQiO047czozOiJsbmciO047czoxMjoiY291bnRfb3JkZXJzIjtpOjIyO3M6MTI6InRvdGFsX29yZGVycyI7aTotMTt9czoxMToiACoAb3JpZ2luYWwiO2E6MjE6e3M6MjoiaWQiO2k6MTtzOjExOiJ1bmlxdWVfaGFzaCI7czoyMDoiYjMxMzgzYzVmYzRmMjNkMTc2ZmQiO3M6MTM6InJlc3RhdXJhbnRfaWQiO2k6MTtzOjQ6Im5hbWUiO3M6MTE6IkRhcGhuZXl0b3duIjtzOjE4OiJjbG9uZWRfYnJhbmNoX25hbWUiO047czoxNjoiY2xvbmVkX2JyYW5jaF9pZCI7TjtzOjEzOiJpc19tZW51X2Nsb25lIjtpOjA7czoyNDoiaXNfaXRlbV9jYXRlZ29yaWVzX2Nsb25lIjtpOjA7czoxOToiaXNfbWVudV9pdGVtc19jbG9uZSI7aTowO3M6MjM6ImlzX2l0ZW1fbW9kaWZpZXJzX2Nsb25lIjtpOjA7czoyOToiaXNfY2xvbmVfcmVzZXJ2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X3Jlc2VydmF0aW9uX3NldHRpbmdzIjtpOjA7czoyNjoiaXNfY2xvbmVfZGVsaXZlcnlfc2V0dGluZ3MiO2k6MDtzOjIwOiJpc19jbG9uZV9rb3Rfc2V0dGluZyI7aTowO3M6MjU6ImlzX21vZGlmaWVyc19ncm91cHNfY2xvbmUiO2k6MDtzOjc6ImFkZHJlc3MiO3M6NDg6IjUxNzkyIFBvbGxpY2ggU3F1YXJlcwpMYWtlIFNpZ3JpZCwgTU4gNTQzOTEtOTIwOCI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMyI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyNCI7czozOiJsYXQiO047czozOiJsbmciO047czoxMjoiY291bnRfb3JkZXJzIjtpOjA7czoxMjoidG90YWxfb3JkZXJzIjtpOi0xO31zOjExOiIAKgBvcmlnaW5hbCI7YToyMTp7czoyOiJpZCI7aToyO3M6MTE6InVuaXF1ZV9oYXNoIjtzOjIwOiIwNDg5ZTQxNmM5ZDc3ZWNmNjM5OCI7czoxMzoicmVzdGF1cmFudF9pZCI7aToxO3M6NDoibmFtZSI7czo5OiJQb3J0IFJldmEiO3M6MTg6ImNsb25lZF9icmFuY2hfbmFtZSI7TjtzOjE2OiJjbG9uZWRfYnJhbmNoX2lkIjtOO3M6MTM6ImlzX21lbnVfY2xvbmUiO2k6MDtzOjI0OiJpc19pdGVtX2NhdGVnb3JpZXNfY2xvbmUiO2k6MDtzOjE5OiJpc19tZW51X2l0ZW1zX2Nsb25lIjtpOjA7czoyMzoiaXNfaXRlbV9tb2RpZmllcnNfY2xvbmUiO2k6MDtzOjI5OiJpc19jbG9uZV9yZXNlcnZhdGlvbl9zZXR0aW5ncyI7aTowO3M6MjY6ImlzX2Nsb25lX2RlbGl2ZXJ5X3NldHRpbmdzIjtpOjA7czoyMDoiaXNfY2xvbmVfa290X3NldHRpbmciO2k6MDtzOjI1OiJpc19tb2RpZmllcnNfZ3JvdXBzX2Nsb25lIjtpOjA7czo3OiJhZGRyZXNzIjtzOjQ4OiI1MTc5MiBQb2xsaWNoIFNxdWFyZXMKTGFrZSBTaWdyaWQsIE1OIDU0MzkxLTky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ODoicGFzc3dvcmQiO2k6MTtzOjE0OiJyZW1lbWJlcl90b2tlbiI7aToyO3M6MjU6InR3b19mYWN0b3JfcmVjb3ZlcnlfY29kZXMiO2k6MztzOjE3OiJ0d29fZmFjdG9yX3NlY3JldCI7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjEwOntpOjA7czo0OiJuYW1lIjtpOjE7czo1OiJlbWFpbCI7aToyO3M6ODoicGFzc3dvcmQiO2k6MztzOjk6ImJyYW5jaF9pZCI7aTo0O3M6MTM6InJlc3RhdXJhbnRfaWQiO2k6NTtzOjY6ImxvY2FsZSI7aTo2O3M6MTI6InBob25lX251bWJlciI7aTo3O3M6MTA6InBob25lX2NvZGUiO2k6ODtzOjI2OiJ0ZXJtc19hbmRfcHJpdmFjeV9hY2NlcHRlZCI7aTo5O3M6MjU6Im1hcmtldGluZ19lbWFpbHNfYWNjZXB0ZWQiO31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO31zOjE5OiIAKgBhdXRoUGFzc3dvcmROYW1lIjtzOjg6InBhc3N3b3JkIjtzOjIwOiIAKgByZW1lbWJlclRva2VuTmFtZSI7czoxNDoicmVtZW1iZXJfdG9rZW4iO3M6MTQ6IgAqAGFjY2Vzc1Rva2VuIjtOO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czo2OToiaHR0cDovLzEyNy4wLjAuMTo4MDAwL21hbmlmZXN0Lmpzb24/aGFzaD1kZW1vLXJlc3RhdXJhbnQmdXJsPXNldHRpbmdzIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjE2OiJyb2xlX3Blcm1pc3Npb25zIjthOjkyOntpOjA7czoxMToiQ3JlYXRlIE1lbnUiO2k6MTtzOjk6IlNob3cgTWVudSI7aToyO3M6MTE6IlVwZGF0ZSBNZW51IjtpOjM7czoxMToiRGVsZXRlIE1lbnUiO2k6NDtzOjE2OiJDcmVhdGUgTWVudSBJdGVtIjtpOjU7czoxNDoiU2hvdyBNZW51IEl0ZW0iO2k6NjtzOjE2OiJVcGRhdGUgTWVudSBJdGVtIjtpOjc7czoxNjoiRGVsZXRlIE1lbnUgSXRlbSI7aTo4O3M6MjA6IkNyZWF0ZSBJdGVtIENhdGVnb3J5IjtpOjk7czoxODoiU2hvdyBJdGVtIENhdGVnb3J5IjtpOjEwO3M6MjA6IlVwZGF0ZSBJdGVtIENhdGVnb3J5IjtpOjExO3M6MjA6IkRlbGV0ZSBJdGVtIENhdGVnb3J5IjtpOjEyO3M6MTE6IkNyZWF0ZSBBcmVhIjtpOjEzO3M6OToiU2hvdyBBcmVhIjtpOjE0O3M6MTE6IlVwZGF0ZSBBcmVhIjtpOjE1O3M6MTE6IkRlbGV0ZSBBcmVhIjtpOjE2O3M6MTI6IkNyZWF0ZSBUYWJsZSI7aToxNztzOjEwOiJTaG93IFRhYmxlIjtpOjE4O3M6MTI6IlVwZGF0ZSBUYWJsZSI7aToxOTtzOjEyOiJEZWxldGUgVGFibGUiO2k6MjA7czoxODoiQ3JlYXRlIFJlc2VydmF0aW9uIjtpOjIxO3M6MTY6IlNob3cgUmVzZXJ2YXRpb24iO2k6MjI7czoxODoiVXBkYXRlIFJlc2VydmF0aW9uIjtpOjIzO3M6MTg6IkRlbGV0ZSBSZXNlcnZhdGlvbiI7aToyNDtzOjEwOiJNYW5hZ2UgS09UIjtpOjI1O3M6MTI6IkNyZWF0ZSBPcmRlciI7aToyNjtzOjEwOiJTaG93IE9yZGVyIjtpOjI3O3M6MTI6IlVwZGF0ZSBPcmRlciI7aToyODtzOjEyOiJEZWxldGUgT3JkZXIiO2k6Mjk7czoxOToiQWRkIERpc2NvdW50IG9uIFBPUyI7aTozMDtzOjE1OiJDcmVhdGUgQ3VzdG9tZXIiO2k6MzE7czoxMzoiU2hvdyBDdXN0b21lciI7aTozMjtzOjE1OiJVcGRhdGUgQ3VzdG9tZXIiO2k6MzM7czoxNToiRGVsZXRlIEN1c3RvbWVyIjtpOjM0O3M6MTk6IkNyZWF0ZSBTdGFmZiBNZW1iZXIiO2k6MzU7czoxNzoiU2hvdyBTdGFmZiBNZW1iZXIiO2k6MzY7czoxOToiVXBkYXRlIFN0YWZmIE1lbWJlciI7aTozNztzOjE5OiJEZWxldGUgU3RhZmYgTWVtYmVyIjtpOjM4O3M6MjU6IkNyZWF0ZSBEZWxpdmVyeSBFeGVjdXRpdmUiO2k6Mzk7czoyMzoiU2hvdyBEZWxpdmVyeSBFeGVjdXRpdmUiO2k6NDA7czoyNToiVXBkYXRlIERlbGl2ZXJ5IEV4ZWN1dGl2ZSI7aTo0MTtzOjI1OiJEZWxldGUgRGVsaXZlcnkgRXhlY3V0aXZlIjtpOjQyO3M6MTM6IlNob3cgUGF5bWVudHMiO2k6NDM7czoxMjoiU2hvdyBSZXBvcnRzIjtpOjQ0O3M6MTU6Ik1hbmFnZSBTZXR0aW5ncyI7aTo0NTtzOjIxOiJNYW5hZ2UgV2FpdGVyIFJlcXVlc3QiO2k6NDY7czoxNDoiQ3JlYXRlIEV4cGVuc2UiO2k6NDc7czoxMjoiU2hvdyBFeHBlbnNlIjtpOjQ4O3M6MTQ6IlVwZGF0ZSBFeHBlbnNlIjtpOjQ5O3M6MTQ6IkRlbGV0ZSBFeHBlbnNlIjtpOjUwO3M6MjM6IkNyZWF0ZSBFeHBlbnNlIENhdGVnb3J5IjtpOjUxO3M6MjE6IlNob3cgRXhwZW5zZSBDYXRlZ29yeSI7aTo1MjtzOjIzOiJVcGRhdGUgRXhwZW5zZSBDYXRlZ29yeSI7aTo1MztzOjIzOiJEZWxldGUgRXhwZW5zZSBDYXRlZ29yeSI7aTo1NDtzOjI5OiJNYW5hZ2UgQ2FzaCBSZWdpc3RlciBTZXR0aW5ncyI7aTo1NTtzOjI2OiJWaWV3IENhc2ggUmVnaXN0ZXIgUmVwb3J0cyI7aTo1NjtzOjI1OiJNYW5hZ2UgQ2FzaCBEZW5vbWluYXRpb25zIjtpOjU3O3M6MjE6IkFwcHJvdmUgQ2FzaCBSZWdpc3RlciI7aTo1ODtzOjE4OiJPcGVuIENhc2ggUmVnaXN0ZXIiO2k6NTk7czoyMToiQ3JlYXRlIEludmVudG9yeSBJdGVtIjtpOjYwO3M6MTk6IlNob3cgSW52ZW50b3J5IEl0ZW0iO2k6NjE7czoyMToiVXBkYXRlIEludmVudG9yeSBJdGVtIjtpOjYyO3M6MjE6IkRlbGV0ZSBJbnZlbnRvcnkgSXRlbSI7aTo2MztzOjI1OiJDcmVhdGUgSW52ZW50b3J5IE1vdmVtZW50IjtpOjY0O3M6MjM6IlNob3cgSW52ZW50b3J5IE1vdmVtZW50IjtpOjY1O3M6MjU6IlVwZGF0ZSBJbnZlbnRvcnkgTW92ZW1lbnQiO2k6NjY7czoyNToiRGVsZXRlIEludmVudG9yeSBNb3ZlbWVudCI7aTo2NztzOjIwOiJTaG93IEludmVudG9yeSBTdG9jayI7aTo2ODtzOjExOiJDcmVhdGUgVW5pdCI7aTo2OTtzOjk6IlNob3cgVW5pdCI7aTo3MDtzOjExOiJVcGRhdGUgVW5pdCI7aTo3MTtzOjExOiJEZWxldGUgVW5pdCI7aTo3MjtzOjEzOiJDcmVhdGUgUmVjaXBlIjtpOjczO3M6MTE6IlNob3cgUmVjaXBlIjtpOjc0O3M6MTM6IlVwZGF0ZSBSZWNpcGUiO2k6NzU7czoxMzoiRGVsZXRlIFJlY2lwZSI7aTo3NjtzOjIxOiJDcmVhdGUgUHVyY2hhc2UgT3JkZXIiO2k6Nzc7czoxOToiU2hvdyBQdXJjaGFzZSBPcmRlciI7aTo3ODtzOjIxOiJVcGRhdGUgUHVyY2hhc2UgT3JkZXIiO2k6Nzk7czoyMToiRGVsZXRlIFB1cmNoYXNlIE9yZGVyIjtpOjgwO3M6MjE6IlNob3cgSW52ZW50b3J5IFJlcG9ydCI7aTo4MTtzOjI1OiJVcGRhdGUgSW52ZW50b3J5IFNldHRpbmdzIjtpOjgyO3M6MTM6IlNob3cgU3VwcGxpZXIiO2k6ODM7czoxNToiQ3JlYXRlIFN1cHBsaWVyIjtpOjg0O3M6MTU6IlVwZGF0ZSBTdXBwbGllciI7aTo4NTtzOjE1OiJEZWxldGUgU3VwcGxpZXIiO2k6ODY7czoxODoiU2hvdyBLaXRjaGVuIFBsYWNlIjtpOjg3O3M6MjA6IkNyZWF0ZSBLaXRjaGVuIFBsYWNlIjtpOjg4O3M6MjA6IlVwZGF0ZSBLaXRjaGVuIFBsYWNlIjtpOjg5O3M6MjA6IkRlbGV0ZSBLaXRjaGVuIFBsYWNlIjtpOjkwO3M6MjQ6Ik1hbmFnZSBNdWx0aVBPUyBNYWNoaW5lcyI7aTo5MTtzOjE4OiJVcGRhdGUgU21zIFNldHRpbmciO31zOjEwOiJyZXN0YXVyYW50IjtPOjIxOiJBcHBcTW9kZWxzXFJlc3RhdXJhbnQiOjM5OntzOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjExOiJyZXN0YXVyYW50cyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjgzOntzOjI6ImlkIjtpOjE7czoxMDoic3ViX2RvbWFpbiI7czoyMDoiZGVtby50YWJsZXRyYWNrLnRlc3QiO3M6NDoibmFtZSI7czoxNToiRGVtbyBSZXN0YXVyYW50IjtzOjQ6Imhhc2giO3M6MTU6ImRlbW8tcmVzdGF1cmFudCI7czo3OiJhZGRyZXNzIjtzOjUxOiI0NTA4MiBNYXRpbGRlIERpdmlkZSBBcHQuIDgzOQpNYWRpc3luc2lkZSwgQVogMjM4NjMiO3M6MTI6InBob25lX251bWJlciI7czoxMjoiKzE3Mzc4NjQxNDAzIjtzOjEwOiJwaG9uZV9jb2RlIjtOO3M6NToiZW1haWwiO3M6Mjc6ImRlbW8ucmVzdGF1cmFudEBleGFtcGxlLmNvbSI7czo4OiJ0aW1lem9uZSI7czoxNjoiQW1lcmljYS9OZXdfWW9yayI7czo5OiJ0aGVtZV9oZXgiO3M6NzoiI0E3OEJGQSI7czo5OiJ0aGVtZV9yZ2IiO3M6MTM6IjE2NywgMTM5LCAyNTAiO3M6NDoibG9nbyI7TjtzOjEwOiJjb3VudHJ5X2lkIjtpOjIzNjtzOjE1OiJoaWRlX25ld19vcmRlcnMiO2k6MDtzOjIxOiJoaWRlX25ld19yZXNlcnZhdGlvbnMiO2k6MDtzOjIzOiJoaWRlX25ld193YWl0ZXJfcmVxdWVzdCI7aTowO3M6MTE6ImN1cnJlbmN5X2lkIjtpOjE7czoxMjoibGljZW5zZV90eXBlIjtzOjQ6InBhaWQiO3M6OToiaXNfYWN0aXZlIjtpOjE7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMyI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwOTo0OTo0OCI7czoyMzoiY3VzdG9tZXJfbG9naW5fcmVxdWlyZWQiO2k6MDtzOjg6ImFib3V0X3VzIjtzOjEzMDQ6IjxwIGNsYXNzPSJ0ZXh0LWxnIHRleHQtZ3JheS02MDAgbWItNiI+CiAgICAgICAgICBXZWxjb21lIHRvIG91ciByZXN0YXVyYW50LCB3aGVyZSBncmVhdCBmb29kIGFuZCBnb29kIHZpYmVzIGNvbWUgdG9nZXRoZXIhIFdlJ3JlIGEgbG9jYWwsIGZhbWlseS1vd25lZCBzcG90IHRoYXQgbG92ZXMgYnJpbmdpbmcgcGVvcGxlIHRvZ2V0aGVyIG92ZXIgZGVsaWNpb3VzIG1lYWxzIGFuZCB1bmZvcmdldHRhYmxlIG1vbWVudHMuIFdoZXRoZXIgeW91J3JlIGhlcmUgZm9yIGEgcXVpY2sgYml0ZSwgYSBmYW1pbHkgZGlubmVyLCBvciBhIGNlbGVicmF0aW9uLCB3ZSdyZSBhbGwgYWJvdXQgbWFraW5nIHlvdXIgdGltZSB3aXRoIHVzIHNwZWNpYWwuCiAgICAgICAgPC9wPgogICAgICAgIDxwIGNsYXNzPSJ0ZXh0LWxnIHRleHQtZ3JheS02MDAgbWItNiI+CiAgICAgICAgICBPdXIgbWVudSBpcyBwYWNrZWQgd2l0aCBkaXNoZXMgbWFkZSBmcm9tIGZyZXNoLCBxdWFsaXR5IGluZ3JlZGllbnRzIGJlY2F1c2Ugd2UgYmVsaWV2ZSBmb29kIHNob3VsZCB0YXN0ZSBhcwogICAgICAgICAgZ29vZCBhcyBpdCBtYWtlcyB5b3UgZmVlbC4gRnJvbSBvdXIgc2lnbmF0dXJlIGRpc2hlcyB0byBzZWFzb25hbCBzcGVjaWFscywgdGhlcmUncyBhbHdheXMgc29tZXRoaW5nIHRvIGV4Y2l0ZQogICAgICAgICAgeW91ciB0YXN0ZSBidWRzLgogICAgICAgIDwvcD4KICAgICAgICA8cCBjbGFzcz0idGV4dC1sZyB0ZXh0LWdyYXktNjAwIG1iLTYiPgogICAgICAgICAgQnV0IHdlJ3JlIG5vdCBqdXN0IGFib3V0IHRoZSBmb29k4oCUd2UncmUgYWJvdXQgY29tbXVuaXR5LiBXZSBsb3ZlIHNlZWluZyBmYW1pbGlhciBmYWNlcyBhbmQgd2VsY29taW5nIG5ldyBvbmVzLgogICAgICAgICAgT3VyIHRlYW0gaXMgYSBmdW4sIGZyaWVuZGx5IGJ1bmNoIGRlZGljYXRlZCB0byBzZXJ2aW5nIHlvdSB3aXRoIGEgc21pbGUgYW5kIG1ha2luZyBzdXJlIGV2ZXJ5IHZpc2l0IGZlZWxzIGxpa2UKICAgICAgICAgIGNvbWluZyBob21lLgogICAgICAgIDwvcD4KICAgICAgICA8cCBjbGFzcz0idGV4dC1sZyB0ZXh0LWdyYXktNjAwIj4KICAgICAgICAgIFNvLCBjb21lIG9uIGluLCBncmFiIGEgc2VhdCwgYW5kIGxldCB1cyB0YWtlIGNhcmUgb2YgdGhlIHJlc3QuIFdlIGNhbid0IHdhaXQgdG8gc2hhcmUgb3VyIGxvdmUgb2YgZm9vZCB3aXRoCiAgICAgICAgICB5b3UhCiAgICAgICAgPC9wPgogICAgICAgIDxwIGNsYXNzPSJ0ZXh0LWxnIHRleHQtZ3JheS04MDAgZm9udC1zZW1pYm9sZCBtdC02Ij5TZWUgeW91IHNvb24hIPCfjb3vuI/inKg8L3A+IjtzOjMwOiJhbGxvd19jdXN0b21lcl9kZWxpdmVyeV9vcmRlcnMiO2k6MTtzOjI4OiJhbGxvd19jdXN0b21lcl9waWNrdXBfb3JkZXJzIjtpOjE7czoxNzoicGlja3VwX2RheXNfcmFuZ2UiO2k6NztzOjIxOiJhbGxvd19jdXN0b21lcl9vcmRlcnMiO2k6MTtzOjIwOiJhbGxvd19kaW5lX2luX29yZGVycyI7aToxO3M6ODoic2hvd192ZWciO2k6MTtzOjEwOiJzaG93X2hhbGFsIjtpOjA7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6MTI6InBhY2thZ2VfdHlwZSI7czo1OiJ0cmlhbCI7czo2OiJzdGF0dXMiO3M6NjoiYWN0aXZlIjtzOjE3OiJsaWNlbnNlX2V4cGlyZV9vbiI7czoxOToiMjAyNS0xMi0zMCAwODoyNzoyMyI7czo5OiJjb3VudF9zbXMiO2k6MDtzOjk6InRvdGFsX3NtcyI7aTotMTtzOjEzOiJ0cmlhbF9lbmRzX2F0IjtzOjE5OiIyMDI1LTEyLTMwIDA4OjI3OjIzIjtzOjE4OiJsaWNlbnNlX3VwZGF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDg6Mjc6MjMiO3M6MjM6InN1YnNjcmlwdGlvbl91cGRhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA4OjI3OjIzIjtzOjk6InN0cmlwZV9pZCI7TjtzOjc6InBtX3R5cGUiO047czoxMjoicG1fbGFzdF9mb3VyIjtOO3M6MjU6ImlzX3dhaXRlcl9yZXF1ZXN0X2VuYWJsZWQiO2k6MTtzOjMyOiJkZWZhdWx0X3RhYmxlX3Jlc2VydmF0aW9uX3N0YXR1cyI7czo5OiJDb25maXJtZWQiO3M6MjA6ImRpc2FibGVfc2xvdF9taW51dGVzIjtpOjMwO3M6MTU6ImFwcHJvdmFsX3N0YXR1cyI7czo4OiJBcHByb3ZlZCI7czoxNjoicmVqZWN0aW9uX3JlYXNvbiI7TjtzOjEzOiJmYWNlYm9va19saW5rIjtzOjI1OiJodHRwczovL3d3dy5mYWNlYm9vay5jb20vIjtzOjE0OiJpbnN0YWdyYW1fbGluayI7czoyNjoiaHR0cHM6Ly93d3cuaW5zdGFncmFtLmNvbS8iO3M6MTI6InR3aXR0ZXJfbGluayI7czoyNDoiaHR0cHM6Ly93d3cudHdpdHRlci5jb20vIjtzOjk6InllbHBfbGluayI7TjtzOjE0OiJ0YWJsZV9yZXF1aXJlZCI7aTowO3M6MTQ6InNob3dfbG9nb190ZXh0IjtpOjE7czoxMjoibWV0YV9rZXl3b3JkIjtOO3M6MTY6Im1ldGFfZGVzY3JpcHRpb24iO047czozNDoidXBsb2FkX2Zhdl9pY29uX2FuZHJvaWRfY2hyb21lXzE5MiI7TjtzOjM0OiJ1cGxvYWRfZmF2X2ljb25fYW5kcm9pZF9jaHJvbWVfNTEyIjtOO3M6MzI6InVwbG9hZF9mYXZfaWNvbl9hcHBsZV90b3VjaF9pY29uIjtOO3M6MTc6InVwbG9hZF9mYXZpY29uXzE2IjtOO3M6MTc6InVwbG9hZF9mYXZpY29uXzMyIjtOO3M6NzoiZmF2aWNvbiI7TjtzOjM2OiJpc193YWl0ZXJfcmVxdWVzdF9lbmFibGVkX29uX2Rlc2t0b3AiO2k6MTtzOjM1OiJpc193YWl0ZXJfcmVxdWVzdF9lbmFibGVkX29uX21vYmlsZSI7aToxO3M6MzY6ImlzX3dhaXRlcl9yZXF1ZXN0X2VuYWJsZWRfb3Blbl9ieV9xciI7aTowO3M6MTE6IndlYm1hbmlmZXN0IjtOO3M6MTU6ImVuYWJsZV90aXBfc2hvcCI7aToxO3M6MTQ6ImVuYWJsZV90aXBfcG9zIjtpOjE7czoyNToiaXNfcHdhX2luc3RhbGxfYWxlcnRfc2hvdyI7aTowO3M6MTk6ImF1dG9fY29uZmlybV9vcmRlcnMiO2k6MDtzOjI5OiJyZXN0cmljdF9xcl9vcmRlcl9ieV9sb2NhdGlvbiI7aTowO3M6MjI6InFyX29yZGVyX3JhZGl1c19tZXRlcnMiO047czoyMzoic2hvd19vcmRlcl90eXBlX29wdGlvbnMiO2k6MTtzOjI0OiJkaXNhYmxlX29yZGVyX3R5cGVfcG9wdXAiO2k6MDtzOjIxOiJkZWZhdWx0X29yZGVyX3R5cGVfaWQiO047czoyNzoiaGlkZV9tZW51X2l0ZW1faW1hZ2Vfb25fcG9zIjtpOjA7czozNzoiaGlkZV9tZW51X2l0ZW1faW1hZ2Vfb25fY3VzdG9tZXJfc2l0ZSI7aTowO3M6ODoidGF4X21vZGUiO3M6NToib3JkZXIiO3M6MTM6InRheF9pbmNsdXNpdmUiO2k6MDtzOjIyOiJjdXN0b21lcl9zaXRlX2xhbmd1YWdlIjtzOjI6ImVuIjtzOjI0OiJlbmFibGVfYWRtaW5fcmVzZXJ2YXRpb24iO2k6MTtzOjI3OiJlbmFibGVfY3VzdG9tZXJfcmVzZXJ2YXRpb24iO2k6MTtzOjE4OiJtaW5pbXVtX3BhcnR5X3NpemUiO2k6MTtzOjI2OiJ0YWJsZV9sb2NrX3RpbWVvdXRfbWludXRlcyI7aToxMDt9czoxMToiACoAb3JpZ2luYWwiO2E6ODM6e3M6MjoiaWQiO2k6MTtzOjEwOiJzdWJfZG9tYWluIjtzOjIwOiJkZW1vLnRhYmxldHJhY2sudGVzdCI7czo0OiJuYW1lIjtzOjE1OiJEZW1vIFJlc3RhdXJhbnQiO3M6NDoiaGFzaCI7czoxNToiZGVtby1yZXN0YXVyYW50IjtzOjc6ImFkZHJlc3MiO3M6NTE6IjQ1MDgyIE1hdGlsZGUgRGl2aWRlIEFwdC4gODM5Ck1hZGlzeW5zaWRlLCBBWiAyMzg2MyI7czoxMjoicGhvbmVfbnVtYmVyIjtzOjEyOiIrMTczNzg2NDE0MDMiO3M6MTA6InBob25lX2NvZGUiO047czo1OiJlbWFpbCI7czoyNzoiZGVtby5yZXN0YXVyYW50QGV4YW1wbGUuY29tIjtzOjg6InRpbWV6b25lIjtzOjE2OiJBbWVyaWNhL05ld19Zb3JrIjtzOjk6InRoZW1lX2hleCI7czo3OiIjQTc4QkZBIjtzOjk6InRoZW1lX3JnYiI7czoxMzoiMTY3LCAxMzksIDI1MCI7czo0OiJsb2dvIjtOO3M6MTA6ImNvdW50cnlfaWQiO2k6MjM2O3M6MTU6ImhpZGVfbmV3X29yZGVycyI7aTowO3M6MjE6ImhpZGVfbmV3X3Jlc2VydmF0aW9ucyI7aTowO3M6MjM6ImhpZGVfbmV3X3dhaXRlcl9yZXF1ZXN0IjtpOjA7czoxMToiY3VycmVuY3lfaWQiO2k6MTtzOjEyOiJsaWNlbnNlX3R5cGUiO3M6NDoicGFpZCI7czo5OiJpc19hY3RpdmUiO2k6MTtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA4OjI3OjIzIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA5OjQ5OjQ4IjtzOjIzOiJjdXN0b21lcl9sb2dpbl9yZXF1aXJlZCI7aTowO3M6ODoiYWJvdXRfdXMiO3M6MTMwNDoiPHAgY2xhc3M9InRleHQtbGcgdGV4dC1ncmF5LTYwMCBtYi02Ij4KICAgICAgICAgIFdlbGNvbWUgdG8gb3VyIHJlc3RhdXJhbnQsIHdoZXJlIGdyZWF0IGZvb2QgYW5kIGdvb2QgdmliZXMgY29tZSB0b2dldGhlciEgV2UncmUgYSBsb2NhbCwgZmFtaWx5LW93bmVkIHNwb3QgdGhhdCBsb3ZlcyBicmluZ2luZyBwZW9wbGUgdG9nZXRoZXIgb3ZlciBkZWxpY2lvdXMgbWVhbHMgYW5kIHVuZm9yZ2V0dGFibGUgbW9tZW50cy4gV2hldGhlciB5b3UncmUgaGVyZSBmb3IgYSBxdWljayBiaXRlLCBhIGZhbWlseSBkaW5uZXIsIG9yIGEgY2VsZWJyYXRpb24sIHdlJ3JlIGFsbCBhYm91dCBtYWtpbmcgeW91ciB0aW1lIHdpdGggdXMgc3BlY2lhbC4KICAgICAgICA8L3A+CiAgICAgICAgPHAgY2xhc3M9InRleHQtbGcgdGV4dC1ncmF5LTYwMCBtYi02Ij4KICAgICAgICAgIE91ciBtZW51IGlzIHBhY2tlZCB3aXRoIGRpc2hlcyBtYWRlIGZyb20gZnJlc2gsIHF1YWxpdHkgaW5ncmVkaWVudHMgYmVjYXVzZSB3ZSBiZWxpZXZlIGZvb2Qgc2hvdWxkIHRhc3RlIGFzCiAgICAgICAgICBnb29kIGFzIGl0IG1ha2VzIHlvdSBmZWVsLiBGcm9tIG91ciBzaWduYXR1cmUgZGlzaGVzIHRvIHNlYXNvbmFsIHNwZWNpYWxzLCB0aGVyZSdzIGFsd2F5cyBzb21ldGhpbmcgdG8gZXhjaXRlCiAgICAgICAgICB5b3VyIHRhc3RlIGJ1ZHMuCiAgICAgICAgPC9wPgogICAgICAgIDxwIGNsYXNzPSJ0ZXh0LWxnIHRleHQtZ3JheS02MDAgbWItNiI+CiAgICAgICAgICBCdXQgd2UncmUgbm90IGp1c3QgYWJvdXQgdGhlIGZvb2TigJR3ZSdyZSBhYm91dCBjb21tdW5pdHkuIFdlIGxvdmUgc2VlaW5nIGZhbWlsaWFyIGZhY2VzIGFuZCB3ZWxjb21pbmcgbmV3IG9uZXMuCiAgICAgICAgICBPdXIgdGVhbSBpcyBhIGZ1biwgZnJpZW5kbHkgYnVuY2ggZGVkaWNhdGVkIHRvIHNlcnZpbmcgeW91IHdpdGggYSBzbWlsZSBhbmQgbWFraW5nIHN1cmUgZXZlcnkgdmlzaXQgZmVlbHMgbGlrZQogICAgICAgICAgY29taW5nIGhvbWUuCiAgICAgICAgPC9wPgogICAgICAgIDxwIGNsYXNzPSJ0ZXh0LWxnIHRleHQtZ3JheS02MDAiPgogICAgICAgICAgU28sIGNvbWUgb24gaW4sIGdyYWIgYSBzZWF0LCBhbmQgbGV0IHVzIHRha2UgY2FyZSBvZiB0aGUgcmVzdC4gV2UgY2FuJ3Qgd2FpdCB0byBzaGFyZSBvdXIgbG92ZSBvZiBmb29kIHdpdGgKICAgICAgICAgIHlvdSEKICAgICAgICA8L3A+CiAgICAgICAgPHAgY2xhc3M9InRleHQtbGcgdGV4dC1ncmF5LTgwMCBmb250LXNlbWlib2xkIG10LTYiPlNlZSB5b3Ugc29vbiEg8J+Nve+4j+KcqDwvcD4iO3M6MzA6ImFsbG93X2N1c3RvbWVyX2RlbGl2ZXJ5X29yZGVycyI7aToxO3M6Mjg6ImFsbG93X2N1c3RvbWVyX3BpY2t1cF9vcmRlcnMiO2k6MTtzOjE3OiJwaWNrdXBfZGF5c19yYW5nZSI7aTo3O3M6MjE6ImFsbG93X2N1c3RvbWVyX29yZGVycyI7aToxO3M6MjA6ImFsbG93X2RpbmVfaW5fb3JkZXJzIjtpOjE7czo4OiJzaG93X3ZlZyI7aToxO3M6MTA6InNob3dfaGFsYWwiO2k6MDtzOjEwOiJwYWNrYWdlX2lkIjtpOjU7czoxMjoicGFja2FnZV90eXBlIjtzOjU6InRyaWFsIjtzOjY6InN0YXR1cyI7czo2OiJhY3RpdmUiO3M6MTc6ImxpY2Vuc2VfZXhwaXJlX29uIjtzOjE5OiIyMDI1LTEyLTMwIDA4OjI3OjIzIjtzOjk6ImNvdW50X3NtcyI7aTowO3M6OToidG90YWxfc21zIjtpOi0xO3M6MTM6InRyaWFsX2VuZHNfYXQiO3M6MTk6IjIwMjUtMTItMzAgMDg6Mjc6MjMiO3M6MTg6ImxpY2Vuc2VfdXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMyI7czoyMzoic3Vic2NyaXB0aW9uX3VwZGF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDg6Mjc6MjMiO3M6OToic3RyaXBlX2lkIjtOO3M6NzoicG1fdHlwZSI7TjtzOjEyOiJwbV9sYXN0X2ZvdXIiO047czoyNToiaXNfd2FpdGVyX3JlcXVlc3RfZW5hYmxlZCI7aToxO3M6MzI6ImRlZmF1bHRfdGFibGVfcmVzZXJ2YXRpb25fc3RhdHVzIjtzOjk6IkNvbmZpcm1lZCI7czoyMDoiZGlzYWJsZV9zbG90X21pbnV0ZXMiO2k6MzA7czoxNToiYXBwcm92YWxfc3RhdHVzIjtzOjg6IkFwcHJvdmVkIjtzOjE2OiJyZWplY3Rpb25fcmVhc29uIjtOO3M6MTM6ImZhY2Vib29rX2xpbmsiO3M6MjU6Imh0dHBzOi8vd3d3LmZhY2Vib29rLmNvbS8iO3M6MTQ6Imluc3RhZ3JhbV9saW5rIjtzOjI2OiJodHRwczovL3d3dy5pbnN0YWdyYW0uY29tLyI7czoxMjoidHdpdHRlcl9saW5rIjtzOjI0OiJodHRwczovL3d3dy50d2l0dGVyLmNvbS8iO3M6OToieWVscF9saW5rIjtOO3M6MTQ6InRhYmxlX3JlcXVpcmVkIjtpOjA7czoxNDoic2hvd19sb2dvX3RleHQiO2k6MTtzOjEyOiJtZXRhX2tleXdvcmQiO047czoxNjoibWV0YV9kZXNjcmlwdGlvbiI7TjtzOjM0OiJ1cGxvYWRfZmF2X2ljb25fYW5kcm9pZF9jaHJvbWVfMTkyIjtOO3M6MzQ6InVwbG9hZF9mYXZfaWNvbl9hbmRyb2lkX2Nocm9tZV81MTIiO047czozMjoidXBsb2FkX2Zhdl9pY29uX2FwcGxlX3RvdWNoX2ljb24iO047czoxNzoidXBsb2FkX2Zhdmljb25fMTYiO047czoxNzoidXBsb2FkX2Zhdmljb25fMzIiO047czo3OiJmYXZpY29uIjtOO3M6MzY6ImlzX3dhaXRlcl9yZXF1ZXN0X2VuYWJsZWRfb25fZGVza3RvcCI7aToxO3M6MzU6ImlzX3dhaXRlcl9yZXF1ZXN0X2VuYWJsZWRfb25fbW9iaWxlIjtpOjE7czozNjoiaXNfd2FpdGVyX3JlcXVlc3RfZW5hYmxlZF9vcGVuX2J5X3FyIjtpOjA7czoxMToid2VibWFuaWZlc3QiO047czoxNToiZW5hYmxlX3RpcF9zaG9wIjtpOjE7czoxNDoiZW5hYmxlX3RpcF9wb3MiO2k6MTtzOjI1OiJpc19wd2FfaW5zdGFsbF9hbGVydF9zaG93IjtpOjA7czoxOToiYXV0b19jb25maXJtX29yZGVycyI7aTowO3M6Mjk6InJlc3RyaWN0X3FyX29yZGVyX2J5X2xvY2F0aW9uIjtpOjA7czoyMjoicXJfb3JkZXJfcmFkaXVzX21ldGVycyI7TjtzOjIzOiJzaG93X29yZGVyX3R5cGVfb3B0aW9ucyI7aToxO3M6MjQ6ImRpc2FibGVfb3JkZXJfdHlwZV9wb3B1cCI7aTowO3M6MjE6ImRlZmF1bHRfb3JkZXJfdHlwZV9pZCI7TjtzOjI3OiJoaWRlX21lbnVfaXRlbV9pbWFnZV9vbl9wb3MiO2k6MDtzOjM3OiJoaWRlX21lbnVfaXRlbV9pbWFnZV9vbl9jdXN0b21lcl9zaXRlIjtpOjA7czo4OiJ0YXhfbW9kZSI7czo1OiJvcmRlciI7czoxMzoidGF4X2luY2x1c2l2ZSI7aTowO3M6MjI6ImN1c3RvbWVyX3NpdGVfbGFuZ3VhZ2UiO3M6MjoiZW4iO3M6MjQ6ImVuYWJsZV9hZG1pbl9yZXNlcnZhdGlvbiI7aToxO3M6Mjc6ImVuYWJsZV9jdXN0b21lcl9yZXNlcnZhdGlvbiI7aToxO3M6MTg6Im1pbmltdW1fcGFydHlfc2l6ZSI7aToxO3M6MjY6InRhYmxlX2xvY2tfdGltZW91dF9taW51dGVzIjtpOjEwO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YToxMTp7czoxNzoibGljZW5zZV9leHBpcmVfb24iO3M6ODoiZGF0ZXRpbWUiO3M6MTU6InRyaWFsX2V4cGlyZV9vbiI7czo4OiJkYXRldGltZSI7czoxODoibGljZW5zZV91cGRhdGVkX2F0IjtzOjg6ImRhdGV0aW1lIjtzOjIzOiJzdWJzY3JpcHRpb25fdXBkYXRlZF9hdCI7czo4OiJkYXRldGltZSI7czoxMDoiY3JlYXRlZF9hdCI7czo4OiJkYXRldGltZSI7czoxMDoidXBkYXRlZF9hdCI7czo4OiJkYXRldGltZSI7czoyMzoiY3VzdG9tX2RlbGl2ZXJ5X29wdGlvbnMiO3M6NToiYXJyYXkiO3M6OToiaXNfYWN0aXZlIjtzOjc6ImJvb2xlYW4iO3M6MjQ6ImVuYWJsZV9hZG1pbl9yZXNlcnZhdGlvbiI7czo3OiJib29sZWFuIjtzOjI3OiJlbmFibGVfY3VzdG9tZXJfcmVzZXJ2YXRpb24iO3M6NzoiYm9vbGVhbiI7czoyOToicmVzdHJpY3RfcXJfb3JkZXJfYnlfbG9jYXRpb24iO3M6NzoiYm9vbGVhbiI7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YToxOntpOjA7czo4OiJsb2dvX3VybCI7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6NDp7czo3OiJwYWNrYWdlIjtPOjE4OiJBcHBcTW9kZWxzXFBhY2thZ2UiOjMzOntzOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjg6InBhY2thZ2VzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6NDQ6e3M6MjoiaWQiO2k6NTtzOjEyOiJwYWNrYWdlX25hbWUiO3M6MTM6IlRyaWFsIFBhY2thZ2UiO3M6NToicHJpY2UiO3M6NDoiMC4wMCI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMiI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMiI7czoxMToiY3VycmVuY3lfaWQiO2k6MTtzOjExOiJkZXNjcmlwdGlvbiI7czoyMzoiVGhpcyBpcyBhIHRyaWFsIHBhY2thZ2UiO3M6MTI6ImFubnVhbF9wcmljZSI7TjtzOjEzOiJtb250aGx5X3ByaWNlIjtOO3M6MTQ6Im1vbnRobHlfc3RhdHVzIjtpOjA7czoxMzoiYW5udWFsX3N0YXR1cyI7aTowO3M6MjE6InN0cmlwZV9hbm51YWxfcGxhbl9pZCI7TjtzOjIyOiJzdHJpcGVfbW9udGhseV9wbGFuX2lkIjtOO3M6MjM6InJhem9ycGF5X2FubnVhbF9wbGFuX2lkIjtOO3M6MjQ6InJhem9ycGF5X21vbnRobHlfcGxhbl9pZCI7TjtzOjI2OiJmbHV0dGVyd2F2ZV9hbm51YWxfcGxhbl9pZCI7TjtzOjI3OiJmbHV0dGVyd2F2ZV9tb250aGx5X3BsYW5faWQiO047czoyMzoicGF5c3RhY2tfYW5udWFsX3BsYW5faWQiO047czoyNDoicGF5c3RhY2tfbW9udGhseV9wbGFuX2lkIjtOO3M6MjE6InhlbmRpdF9hbm51YWxfcGxhbl9pZCI7TjtzOjIyOiJ4ZW5kaXRfbW9udGhseV9wbGFuX2lkIjtOO3M6MjI6InBhZGRsZV9hbm51YWxfcHJpY2VfaWQiO047czoyMzoicGFkZGxlX21vbnRobHlfcHJpY2VfaWQiO047czoyNDoicGFkZGxlX2xpZmV0aW1lX3ByaWNlX2lkIjtOO3M6MjM6InN0cmlwZV9saWZldGltZV9wbGFuX2lkIjtOO3M6MjU6InJhem9ycGF5X2xpZmV0aW1lX3BsYW5faWQiO047czoxMzoiYmlsbGluZ19jeWNsZSI7aTowO3M6MTA6InNvcnRfb3JkZXIiO047czoxMDoiaXNfcHJpdmF0ZSI7aTowO3M6NzoiaXNfZnJlZSI7aToxO3M6MTQ6ImlzX3JlY29tbWVuZGVkIjtpOjA7czoxMjoicGFja2FnZV90eXBlIjtzOjU6InRyaWFsIjtzOjEyOiJ0cmlhbF9zdGF0dXMiO2k6MTtzOjEwOiJ0cmlhbF9kYXlzIjtpOjMwO3M6MzA6InRyaWFsX25vdGlmaWNhdGlvbl9iZWZvcmVfZGF5cyI7aTo1O3M6MTM6InRyaWFsX21lc3NhZ2UiO3M6MTg6IjMwIERheXMgRnJlZSBUcmlhbCI7czoxOToiYWRkaXRpb25hbF9mZWF0dXJlcyI7czoxMTg6IlsiQ2hhbmdlIEJyYW5jaCIsIkV4cG9ydCBSZXBvcnQiLCJUYWJsZSBSZXNlcnZhdGlvbiIsIlBheW1lbnQgR2F0ZXdheSBJbnRlZ3JhdGlvbiIsIlRoZW1lIFNldHRpbmciLCJDdXN0b21lciBEaXNwbGF5Il0iO3M6MTI6ImJyYW5jaF9saW1pdCI7aTotMTtzOjE0OiJtdWx0aXBvc19saW1pdCI7aTotMTtzOjE2OiJtZW51X2l0ZW1zX2xpbWl0IjtpOi0xO3M6MTE6Im9yZGVyX2xpbWl0IjtpOi0xO3M6MTE6InN0YWZmX2xpbWl0IjtpOi0xO3M6OToic21zX2NvdW50IjtpOjA7czoxNzoiY2FycnlfZm9yd2FyZF9zbXMiO2k6MDt9czoxMToiACoAb3JpZ2luYWwiO2E6NDQ6e3M6MjoiaWQiO2k6NTtzOjEyOiJwYWNrYWdlX25hbWUiO3M6MTM6IlRyaWFsIFBhY2thZ2UiO3M6NToicHJpY2UiO3M6NDoiMC4wMCI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMiI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMiI7czoxMToiY3VycmVuY3lfaWQiO2k6MTtzOjExOiJkZXNjcmlwdGlvbiI7czoyMzoiVGhpcyBpcyBhIHRyaWFsIHBhY2thZ2UiO3M6MTI6ImFubnVhbF9wcmljZSI7TjtzOjEzOiJtb250aGx5X3ByaWNlIjtOO3M6MTQ6Im1vbnRobHlfc3RhdHVzIjtzOjE6IjAiO3M6MTM6ImFubnVhbF9zdGF0dXMiO3M6MToiMCI7czoyMToic3RyaXBlX2FubnVhbF9wbGFuX2lkIjtOO3M6MjI6InN0cmlwZV9tb250aGx5X3BsYW5faWQiO047czoyMzoicmF6b3JwYXlfYW5udWFsX3BsYW5faWQiO047czoyNDoicmF6b3JwYXlfbW9udGhseV9wbGFuX2lkIjtOO3M6MjY6ImZsdXR0ZXJ3YXZlX2FubnVhbF9wbGFuX2lkIjtOO3M6Mjc6ImZsdXR0ZXJ3YXZlX21vbnRobHlfcGxhbl9pZCI7TjtzOjIzOiJwYXlzdGFja19hbm51YWxfcGxhbl9pZCI7TjtzOjI0OiJwYXlzdGFja19tb250aGx5X3BsYW5faWQiO047czoyMToieGVuZGl0X2FubnVhbF9wbGFuX2lkIjtOO3M6MjI6InhlbmRpdF9tb250aGx5X3BsYW5faWQiO047czoyMjoicGFkZGxlX2FubnVhbF9wcmljZV9pZCI7TjtzOjIzOiJwYWRkbGVfbW9udGhseV9wcmljZV9pZCI7TjtzOjI0OiJwYWRkbGVfbGlmZXRpbWVfcHJpY2VfaWQiO047czoyMzoic3RyaXBlX2xpZmV0aW1lX3BsYW5faWQiO047czoyNToicmF6b3JwYXlfbGlmZXRpbWVfcGxhbl9pZCI7TjtzOjEzOiJiaWxsaW5nX2N5Y2xlIjtpOjA7czoxMDoic29ydF9vcmRlciI7TjtzOjEwOiJpc19wcml2YXRlIjtpOjA7czo3OiJpc19mcmVlIjtpOjE7czoxNDoiaXNfcmVjb21tZW5kZWQiO2k6MDtzOjEyOiJwYWNrYWdlX3R5cGUiO3M6NToidHJpYWwiO3M6MTI6InRyaWFsX3N0YXR1cyI7aToxO3M6MTA6InRyaWFsX2RheXMiO2k6MzA7czozMDoidHJpYWxfbm90aWZpY2F0aW9uX2JlZm9yZV9kYXlzIjtpOjU7czoxMzoidHJpYWxfbWVzc2FnZSI7czoxODoiMzAgRGF5cyBGcmVlIFRyaWFsIjtzOjE5OiJhZGRpdGlvbmFsX2ZlYXR1cmVzIjtzOjExODoiWyJDaGFuZ2UgQnJhbmNoIiwiRXhwb3J0IFJlcG9ydCIsIlRhYmxlIFJlc2VydmF0aW9uIiwiUGF5bWVudCBHYXRld2F5IEludGVncmF0aW9uIiwiVGhlbWUgU2V0dGluZyIsIkN1c3RvbWVyIERpc3BsYXkiXSI7czoxMjoiYnJhbmNoX2xpbWl0IjtpOi0xO3M6MTQ6Im11bHRpcG9zX2xpbWl0IjtpOi0xO3M6MTY6Im1lbnVfaXRlbXNfbGltaXQiO2k6LTE7czoxMToib3JkZXJfbGltaXQiO2k6LTE7czoxMToic3RhZmZfbGltaXQiO2k6LTE7czo5OiJzbXNfY291bnQiO2k6MDtzOjE3OiJjYXJyeV9mb3J3YXJkX3NtcyI7aTowO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTozOntzOjEyOiJwYWNrYWdlX3R5cGUiO3M6MjE6IkFwcFxFbnVtc1xQYWNrYWdlVHlwZSI7czoxMDoidHJpYWxfZGF5cyI7czo3OiJpbnRlZ2VyIjtzOjMwOiJ0cmlhbF9ub3RpZmljYXRpb25fYmVmb3JlX2RheXMiO3M6NzoiaW50ZWdlciI7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YToxOntzOjc6Im1vZHVsZXMiO086Mzk6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcQ29sbGVjdGlvbiI6Mjp7czo4OiIAKgBpdGVtcyI7YToyMzp7aTowO086MTc6IkFwcFxNb2RlbHNcTW9kdWxlIjozMzp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJteXNxbCI7czo4OiIAKgB0YWJsZSI7czo3OiJtb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6NDp7czoyOiJpZCI7aToxO3M6NDoibmFtZSI7czo0OiJNZW51IjtzOjEwOiJjcmVhdGVkX2F0IjtOO3M6MTA6InVwZGF0ZWRfYXQiO047fXM6MTE6IgAqAG9yaWdpbmFsIjthOjY6e3M6MjoiaWQiO2k6MTtzOjQ6Im5hbWUiO3M6NDoiTWVudSI7czoxMDoiY3JlYXRlZF9hdCI7TjtzOjEwOiJ1cGRhdGVkX2F0IjtOO3M6MTY6InBpdm90X3BhY2thZ2VfaWQiO2k6NTtzOjE1OiJwaXZvdF9tb2R1bGVfaWQiO2k6MTt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YToxOntzOjU6InBpdm90IjtPOjQ0OiJJbGx1bWluYXRlXERhdGFiYXNlXEVsb3F1ZW50XFJlbGF0aW9uc1xQaXZvdCI6Mzc6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO047czo4OiIAKgB0YWJsZSI7czoxNToicGFja2FnZV9tb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjA7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6Mjp7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6OToibW9kdWxlX2lkIjtpOjE7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aToxO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjA6e31zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjI3OiIAKgByZWxhdGlvbkF1dG9sb2FkQ2FsbGJhY2siO047czoyNjoiACoAcmVsYXRpb25BdXRvbG9hZENvbnRleHQiO047czoxMDoidGltZXN0YW1wcyI7YjowO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MDp7fXM6MTE6InBpdm90UGFyZW50IjtPOjE4OiJBcHBcTW9kZWxzXFBhY2thZ2UiOjMzOntzOjEzOiIAKgBjb25uZWN0aW9uIjtOO3M6ODoiACoAdGFibGUiO3M6ODoicGFja2FnZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MDtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YTowOnt9czoxMToiACoAb3JpZ2luYWwiO2E6MDp7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjM6e3M6MTI6InBhY2thZ2VfdHlwZSI7czoyMToiQXBwXEVudW1zXFBhY2thZ2VUeXBlIjtzOjEwOiJ0cmlhbF9kYXlzIjtzOjc6ImludGVnZXIiO3M6MzA6InRyaWFsX25vdGlmaWNhdGlvbl9iZWZvcmVfZGF5cyI7czo3OiJpbnRlZ2VyIjt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjA6e31zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjI3OiIAKgByZWxhdGlvbkF1dG9sb2FkQ2FsbGJhY2siO047czoyNjoiACoAcmVsYXRpb25BdXRvbG9hZENvbnRleHQiO047czoxMDoidGltZXN0YW1wcyI7YjoxO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MjoiaWQiO319czoxMjoicGl2b3RSZWxhdGVkIjtPOjE3OiJBcHBcTW9kZWxzXE1vZHVsZSI6MzM6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO047czo4OiIAKgB0YWJsZSI7TjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjA7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MDp7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjA6e31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjA6e31zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjI3OiIAKgByZWxhdGlvbkF1dG9sb2FkQ2FsbGJhY2siO047czoyNjoiACoAcmVsYXRpb25BdXRvbG9hZENvbnRleHQiO047czoxMDoidGltZXN0YW1wcyI7YjoxO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MjoiaWQiO319czoxMzoiACoAZm9yZWlnbktleSI7czoxMDoicGFja2FnZV9pZCI7czoxMzoiACoAcmVsYXRlZEtleSI7czo5OiJtb2R1bGVfaWQiO319czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjI6ImlkIjt9fWk6MTtPOjE3OiJBcHBcTW9kZWxzXE1vZHVsZSI6MzM6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6NzoibW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjQ6e3M6MjoiaWQiO2k6MjtzOjQ6Im5hbWUiO3M6OToiTWVudSBJdGVtIjtzOjEwOiJjcmVhdGVkX2F0IjtOO3M6MTA6InVwZGF0ZWRfYXQiO047fXM6MTE6IgAqAG9yaWdpbmFsIjthOjY6e3M6MjoiaWQiO2k6MjtzOjQ6Im5hbWUiO3M6OToiTWVudSBJdGVtIjtzOjEwOiJjcmVhdGVkX2F0IjtOO3M6MTA6InVwZGF0ZWRfYXQiO047czoxNjoicGl2b3RfcGFja2FnZV9pZCI7aTo1O3M6MTU6InBpdm90X21vZHVsZV9pZCI7aToyO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjE6e3M6NToicGl2b3QiO086NDQ6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcUmVsYXRpb25zXFBpdm90IjozNzp7czoxMzoiACoAY29ubmVjdGlvbiI7TjtzOjg6IgAqAHRhYmxlIjtzOjE1OiJwYWNrYWdlX21vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MDtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToyOntzOjEwOiJwYWNrYWdlX2lkIjtpOjU7czo5OiJtb2R1bGVfaWQiO2k6Mjt9czoxMToiACoAb3JpZ2luYWwiO2E6Mjp7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6OToibW9kdWxlX2lkIjtpOjI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MDp7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjA7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YTowOnt9czoxMToicGl2b3RQYXJlbnQiO3I6MTIwMDtzOjEyOiJwaXZvdFJlbGF0ZWQiO3I6MTIzODtzOjEzOiIAKgBmb3JlaWduS2V5IjtzOjEwOiJwYWNrYWdlX2lkIjtzOjEzOiIAKgByZWxhdGVkS2V5IjtzOjk6Im1vZHVsZV9pZCI7fX1zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjI3OiIAKgByZWxhdGlvbkF1dG9sb2FkQ2FsbGJhY2siO047czoyNjoiACoAcmVsYXRpb25BdXRvbG9hZENvbnRleHQiO047czoxMDoidGltZXN0YW1wcyI7YjoxO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MjoiaWQiO319aToyO086MTc6IkFwcFxNb2RlbHNcTW9kdWxlIjozMzp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJteXNxbCI7czo4OiIAKgB0YWJsZSI7czo3OiJtb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6NDp7czoyOiJpZCI7aTozO3M6NDoibmFtZSI7czoxMzoiSXRlbSBDYXRlZ29yeSI7czoxMDoiY3JlYXRlZF9hdCI7TjtzOjEwOiJ1cGRhdGVkX2F0IjtOO31zOjExOiIAKgBvcmlnaW5hbCI7YTo2OntzOjI6ImlkIjtpOjM7czo0OiJuYW1lIjtzOjEzOiJJdGVtIENhdGVnb3J5IjtzOjEwOiJjcmVhdGVkX2F0IjtOO3M6MTA6InVwZGF0ZWRfYXQiO047czoxNjoicGl2b3RfcGFja2FnZV9pZCI7aTo1O3M6MTU6InBpdm90X21vZHVsZV9pZCI7aTozO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjE6e3M6NToicGl2b3QiO086NDQ6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcUmVsYXRpb25zXFBpdm90IjozNzp7czoxMzoiACoAY29ubmVjdGlvbiI7TjtzOjg6IgAqAHRhYmxlIjtzOjE1OiJwYWNrYWdlX21vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MDtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToyOntzOjEwOiJwYWNrYWdlX2lkIjtpOjU7czo5OiJtb2R1bGVfaWQiO2k6Mzt9czoxMToiACoAb3JpZ2luYWwiO2E6Mjp7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6OToibW9kdWxlX2lkIjtpOjM7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MDp7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjA7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YTowOnt9czoxMToicGl2b3RQYXJlbnQiO3I6MTIwMDtzOjEyOiJwaXZvdFJlbGF0ZWQiO3I6MTIzODtzOjEzOiIAKgBmb3JlaWduS2V5IjtzOjEwOiJwYWNrYWdlX2lkIjtzOjEzOiIAKgByZWxhdGVkS2V5IjtzOjk6Im1vZHVsZV9pZCI7fX1zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjI3OiIAKgByZWxhdGlvbkF1dG9sb2FkQ2FsbGJhY2siO047czoyNjoiACoAcmVsYXRpb25BdXRvbG9hZENvbnRleHQiO047czoxMDoidGltZXN0YW1wcyI7YjoxO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MjoiaWQiO319aTozO086MTc6IkFwcFxNb2RlbHNcTW9kdWxlIjozMzp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJteXNxbCI7czo4OiIAKgB0YWJsZSI7czo3OiJtb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6NDp7czoyOiJpZCI7aTo0O3M6NDoibmFtZSI7czo0OiJBcmVhIjtzOjEwOiJjcmVhdGVkX2F0IjtOO3M6MTA6InVwZGF0ZWRfYXQiO047fXM6MTE6IgAqAG9yaWdpbmFsIjthOjY6e3M6MjoiaWQiO2k6NDtzOjQ6Im5hbWUiO3M6NDoiQXJlYSI7czoxMDoiY3JlYXRlZF9hdCI7TjtzOjEwOiJ1cGRhdGVkX2F0IjtOO3M6MTY6InBpdm90X3BhY2thZ2VfaWQiO2k6NTtzOjE1OiJwaXZvdF9tb2R1bGVfaWQiO2k6NDt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YToxOntzOjU6InBpdm90IjtPOjQ0OiJJbGx1bWluYXRlXERhdGFiYXNlXEVsb3F1ZW50XFJlbGF0aW9uc1xQaXZvdCI6Mzc6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO047czo4OiIAKgB0YWJsZSI7czoxNToicGFja2FnZV9tb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjA7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6Mjp7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6OToibW9kdWxlX2lkIjtpOjQ7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aTo0O31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjA6e31zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjI3OiIAKgByZWxhdGlvbkF1dG9sb2FkQ2FsbGJhY2siO047czoyNjoiACoAcmVsYXRpb25BdXRvbG9hZENvbnRleHQiO047czoxMDoidGltZXN0YW1wcyI7YjowO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MDp7fXM6MTE6InBpdm90UGFyZW50IjtyOjEyMDA7czoxMjoicGl2b3RSZWxhdGVkIjtyOjEyMzg7czoxMzoiACoAZm9yZWlnbktleSI7czoxMDoicGFja2FnZV9pZCI7czoxMzoiACoAcmVsYXRlZEtleSI7czo5OiJtb2R1bGVfaWQiO319czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjI6ImlkIjt9fWk6NDtPOjE3OiJBcHBcTW9kZWxzXE1vZHVsZSI6MzM6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6NzoibW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjQ6e3M6MjoiaWQiO2k6NTtzOjQ6Im5hbWUiO3M6NToiVGFibGUiO3M6MTA6ImNyZWF0ZWRfYXQiO047czoxMDoidXBkYXRlZF9hdCI7Tjt9czoxMToiACoAb3JpZ2luYWwiO2E6Njp7czoyOiJpZCI7aTo1O3M6NDoibmFtZSI7czo1OiJUYWJsZSI7czoxMDoiY3JlYXRlZF9hdCI7TjtzOjEwOiJ1cGRhdGVkX2F0IjtOO3M6MTY6InBpdm90X3BhY2thZ2VfaWQiO2k6NTtzOjE1OiJwaXZvdF9tb2R1bGVfaWQiO2k6NTt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YToxOntzOjU6InBpdm90IjtPOjQ0OiJJbGx1bWluYXRlXERhdGFiYXNlXEVsb3F1ZW50XFJlbGF0aW9uc1xQaXZvdCI6Mzc6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO047czo4OiIAKgB0YWJsZSI7czoxNToicGFja2FnZV9tb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjA7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6Mjp7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6OToibW9kdWxlX2lkIjtpOjU7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aTo1O31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjA6e31zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjI3OiIAKgByZWxhdGlvbkF1dG9sb2FkQ2FsbGJhY2siO047czoyNjoiACoAcmVsYXRpb25BdXRvbG9hZENvbnRleHQiO047czoxMDoidGltZXN0YW1wcyI7YjowO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MDp7fXM6MTE6InBpdm90UGFyZW50IjtyOjEyMDA7czoxMjoicGl2b3RSZWxhdGVkIjtyOjEyMzg7czoxMzoiACoAZm9yZWlnbktleSI7czoxMDoicGFja2FnZV9pZCI7czoxMzoiACoAcmVsYXRlZEtleSI7czo5OiJtb2R1bGVfaWQiO319czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjI6ImlkIjt9fWk6NTtPOjE3OiJBcHBcTW9kZWxzXE1vZHVsZSI6MzM6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6NzoibW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjQ6e3M6MjoiaWQiO2k6NjtzOjQ6Im5hbWUiO3M6MTE6IlJlc2VydmF0aW9uIjtzOjEwOiJjcmVhdGVkX2F0IjtOO3M6MTA6InVwZGF0ZWRfYXQiO047fXM6MTE6IgAqAG9yaWdpbmFsIjthOjY6e3M6MjoiaWQiO2k6NjtzOjQ6Im5hbWUiO3M6MTE6IlJlc2VydmF0aW9uIjtzOjEwOiJjcmVhdGVkX2F0IjtOO3M6MTA6InVwZGF0ZWRfYXQiO047czoxNjoicGl2b3RfcGFja2FnZV9pZCI7aTo1O3M6MTU6InBpdm90X21vZHVsZV9pZCI7aTo2O31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjE6e3M6NToicGl2b3QiO086NDQ6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcUmVsYXRpb25zXFBpdm90IjozNzp7czoxMzoiACoAY29ubmVjdGlvbiI7TjtzOjg6IgAqAHRhYmxlIjtzOjE1OiJwYWNrYWdlX21vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MDtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToyOntzOjEwOiJwYWNrYWdlX2lkIjtpOjU7czo5OiJtb2R1bGVfaWQiO2k6Njt9czoxMToiACoAb3JpZ2luYWwiO2E6Mjp7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6OToibW9kdWxlX2lkIjtpOjY7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MDp7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjA7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YTowOnt9czoxMToicGl2b3RQYXJlbnQiO3I6MTIwMDtzOjEyOiJwaXZvdFJlbGF0ZWQiO3I6MTIzODtzOjEzOiIAKgBmb3JlaWduS2V5IjtzOjEwOiJwYWNrYWdlX2lkIjtzOjEzOiIAKgByZWxhdGVkS2V5IjtzOjk6Im1vZHVsZV9pZCI7fX1zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjI3OiIAKgByZWxhdGlvbkF1dG9sb2FkQ2FsbGJhY2siO047czoyNjoiACoAcmVsYXRpb25BdXRvbG9hZENvbnRleHQiO047czoxMDoidGltZXN0YW1wcyI7YjoxO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MjoiaWQiO319aTo2O086MTc6IkFwcFxNb2RlbHNcTW9kdWxlIjozMzp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJteXNxbCI7czo4OiIAKgB0YWJsZSI7czo3OiJtb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6NDp7czoyOiJpZCI7aTo3O3M6NDoibmFtZSI7czozOiJLT1QiO3M6MTA6ImNyZWF0ZWRfYXQiO047czoxMDoidXBkYXRlZF9hdCI7Tjt9czoxMToiACoAb3JpZ2luYWwiO2E6Njp7czoyOiJpZCI7aTo3O3M6NDoibmFtZSI7czozOiJLT1QiO3M6MTA6ImNyZWF0ZWRfYXQiO047czoxMDoidXBkYXRlZF9hdCI7TjtzOjE2OiJwaXZvdF9wYWNrYWdlX2lkIjtpOjU7czoxNToicGl2b3RfbW9kdWxlX2lkIjtpOjc7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo1OiJwaXZvdCI7Tzo0NDoiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxSZWxhdGlvbnNcUGl2b3QiOjM3OntzOjEzOiIAKgBjb25uZWN0aW9uIjtOO3M6ODoiACoAdGFibGUiO3M6MTU6InBhY2thZ2VfbW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjowO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aTo3O31zOjExOiIAKgBvcmlnaW5hbCI7YToyOntzOjEwOiJwYWNrYWdlX2lkIjtpOjU7czo5OiJtb2R1bGVfaWQiO2k6Nzt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MDtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjA6e31zOjExOiJwaXZvdFBhcmVudCI7cjoxMjAwO3M6MTI6InBpdm90UmVsYXRlZCI7cjoxMjM4O3M6MTM6IgAqAGZvcmVpZ25LZXkiO3M6MTA6InBhY2thZ2VfaWQiO3M6MTM6IgAqAHJlbGF0ZWRLZXkiO3M6OToibW9kdWxlX2lkIjt9fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoyOiJpZCI7fX1pOjc7TzoxNzoiQXBwXE1vZGVsc1xNb2R1bGUiOjMzOntzOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjc6Im1vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YTo0OntzOjI6ImlkIjtpOjg7czo0OiJuYW1lIjtzOjU6Ik9yZGVyIjtzOjEwOiJjcmVhdGVkX2F0IjtOO3M6MTA6InVwZGF0ZWRfYXQiO047fXM6MTE6IgAqAG9yaWdpbmFsIjthOjY6e3M6MjoiaWQiO2k6ODtzOjQ6Im5hbWUiO3M6NToiT3JkZXIiO3M6MTA6ImNyZWF0ZWRfYXQiO047czoxMDoidXBkYXRlZF9hdCI7TjtzOjE2OiJwaXZvdF9wYWNrYWdlX2lkIjtpOjU7czoxNToicGl2b3RfbW9kdWxlX2lkIjtpOjg7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo1OiJwaXZvdCI7Tzo0NDoiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxSZWxhdGlvbnNcUGl2b3QiOjM3OntzOjEzOiIAKgBjb25uZWN0aW9uIjtOO3M6ODoiACoAdGFibGUiO3M6MTU6InBhY2thZ2VfbW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjowO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aTo4O31zOjExOiIAKgBvcmlnaW5hbCI7YToyOntzOjEwOiJwYWNrYWdlX2lkIjtpOjU7czo5OiJtb2R1bGVfaWQiO2k6ODt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MDtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjA6e31zOjExOiJwaXZvdFBhcmVudCI7cjoxMjAwO3M6MTI6InBpdm90UmVsYXRlZCI7cjoxMjM4O3M6MTM6IgAqAGZvcmVpZ25LZXkiO3M6MTA6InBhY2thZ2VfaWQiO3M6MTM6IgAqAHJlbGF0ZWRLZXkiO3M6OToibW9kdWxlX2lkIjt9fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoyOiJpZCI7fX1pOjg7TzoxNzoiQXBwXE1vZGVsc1xNb2R1bGUiOjMzOntzOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjc6Im1vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YTo0OntzOjI6ImlkIjtpOjk7czo0OiJuYW1lIjtzOjg6IkN1c3RvbWVyIjtzOjEwOiJjcmVhdGVkX2F0IjtOO3M6MTA6InVwZGF0ZWRfYXQiO047fXM6MTE6IgAqAG9yaWdpbmFsIjthOjY6e3M6MjoiaWQiO2k6OTtzOjQ6Im5hbWUiO3M6ODoiQ3VzdG9tZXIiO3M6MTA6ImNyZWF0ZWRfYXQiO047czoxMDoidXBkYXRlZF9hdCI7TjtzOjE2OiJwaXZvdF9wYWNrYWdlX2lkIjtpOjU7czoxNToicGl2b3RfbW9kdWxlX2lkIjtpOjk7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo1OiJwaXZvdCI7Tzo0NDoiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxSZWxhdGlvbnNcUGl2b3QiOjM3OntzOjEzOiIAKgBjb25uZWN0aW9uIjtOO3M6ODoiACoAdGFibGUiO3M6MTU6InBhY2thZ2VfbW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjowO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aTo5O31zOjExOiIAKgBvcmlnaW5hbCI7YToyOntzOjEwOiJwYWNrYWdlX2lkIjtpOjU7czo5OiJtb2R1bGVfaWQiO2k6OTt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MDtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjA6e31zOjExOiJwaXZvdFBhcmVudCI7cjoxMjAwO3M6MTI6InBpdm90UmVsYXRlZCI7cjoxMjM4O3M6MTM6IgAqAGZvcmVpZ25LZXkiO3M6MTA6InBhY2thZ2VfaWQiO3M6MTM6IgAqAHJlbGF0ZWRLZXkiO3M6OToibW9kdWxlX2lkIjt9fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoyOiJpZCI7fX1pOjk7TzoxNzoiQXBwXE1vZGVsc1xNb2R1bGUiOjMzOntzOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjc6Im1vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YTo0OntzOjI6ImlkIjtpOjEwO3M6NDoibmFtZSI7czo1OiJTdGFmZiI7czoxMDoiY3JlYXRlZF9hdCI7TjtzOjEwOiJ1cGRhdGVkX2F0IjtOO31zOjExOiIAKgBvcmlnaW5hbCI7YTo2OntzOjI6ImlkIjtpOjEwO3M6NDoibmFtZSI7czo1OiJTdGFmZiI7czoxMDoiY3JlYXRlZF9hdCI7TjtzOjEwOiJ1cGRhdGVkX2F0IjtOO3M6MTY6InBpdm90X3BhY2thZ2VfaWQiO2k6NTtzOjE1OiJwaXZvdF9tb2R1bGVfaWQiO2k6MTA7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo1OiJwaXZvdCI7Tzo0NDoiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxSZWxhdGlvbnNcUGl2b3QiOjM3OntzOjEzOiIAKgBjb25uZWN0aW9uIjtOO3M6ODoiACoAdGFibGUiO3M6MTU6InBhY2thZ2VfbW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjowO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aToxMDt9czoxMToiACoAb3JpZ2luYWwiO2E6Mjp7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6OToibW9kdWxlX2lkIjtpOjEwO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjA6e31zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjI3OiIAKgByZWxhdGlvbkF1dG9sb2FkQ2FsbGJhY2siO047czoyNjoiACoAcmVsYXRpb25BdXRvbG9hZENvbnRleHQiO047czoxMDoidGltZXN0YW1wcyI7YjowO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MDp7fXM6MTE6InBpdm90UGFyZW50IjtyOjEyMDA7czoxMjoicGl2b3RSZWxhdGVkIjtyOjEyMzg7czoxMzoiACoAZm9yZWlnbktleSI7czoxMDoicGFja2FnZV9pZCI7czoxMzoiACoAcmVsYXRlZEtleSI7czo5OiJtb2R1bGVfaWQiO319czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjI6ImlkIjt9fWk6MTA7TzoxNzoiQXBwXE1vZGVsc1xNb2R1bGUiOjMzOntzOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjc6Im1vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YTo0OntzOjI6ImlkIjtpOjExO3M6NDoibmFtZSI7czo3OiJQYXltZW50IjtzOjEwOiJjcmVhdGVkX2F0IjtOO3M6MTA6InVwZGF0ZWRfYXQiO047fXM6MTE6IgAqAG9yaWdpbmFsIjthOjY6e3M6MjoiaWQiO2k6MTE7czo0OiJuYW1lIjtzOjc6IlBheW1lbnQiO3M6MTA6ImNyZWF0ZWRfYXQiO047czoxMDoidXBkYXRlZF9hdCI7TjtzOjE2OiJwaXZvdF9wYWNrYWdlX2lkIjtpOjU7czoxNToicGl2b3RfbW9kdWxlX2lkIjtpOjExO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjE6e3M6NToicGl2b3QiO086NDQ6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcUmVsYXRpb25zXFBpdm90IjozNzp7czoxMzoiACoAY29ubmVjdGlvbiI7TjtzOjg6IgAqAHRhYmxlIjtzOjE1OiJwYWNrYWdlX21vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MDtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToyOntzOjEwOiJwYWNrYWdlX2lkIjtpOjU7czo5OiJtb2R1bGVfaWQiO2k6MTE7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aToxMTt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MDtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjA6e31zOjExOiJwaXZvdFBhcmVudCI7cjoxMjAwO3M6MTI6InBpdm90UmVsYXRlZCI7cjoxMjM4O3M6MTM6IgAqAGZvcmVpZ25LZXkiO3M6MTA6InBhY2thZ2VfaWQiO3M6MTM6IgAqAHJlbGF0ZWRLZXkiO3M6OToibW9kdWxlX2lkIjt9fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoyOiJpZCI7fX1pOjExO086MTc6IkFwcFxNb2RlbHNcTW9kdWxlIjozMzp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJteXNxbCI7czo4OiIAKgB0YWJsZSI7czo3OiJtb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6NDp7czoyOiJpZCI7aToxMjtzOjQ6Im5hbWUiO3M6NjoiUmVwb3J0IjtzOjEwOiJjcmVhdGVkX2F0IjtOO3M6MTA6InVwZGF0ZWRfYXQiO047fXM6MTE6IgAqAG9yaWdpbmFsIjthOjY6e3M6MjoiaWQiO2k6MTI7czo0OiJuYW1lIjtzOjY6IlJlcG9ydCI7czoxMDoiY3JlYXRlZF9hdCI7TjtzOjEwOiJ1cGRhdGVkX2F0IjtOO3M6MTY6InBpdm90X3BhY2thZ2VfaWQiO2k6NTtzOjE1OiJwaXZvdF9tb2R1bGVfaWQiO2k6MTI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo1OiJwaXZvdCI7Tzo0NDoiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxSZWxhdGlvbnNcUGl2b3QiOjM3OntzOjEzOiIAKgBjb25uZWN0aW9uIjtOO3M6ODoiACoAdGFibGUiO3M6MTU6InBhY2thZ2VfbW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjowO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aToxMjt9czoxMToiACoAb3JpZ2luYWwiO2E6Mjp7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6OToibW9kdWxlX2lkIjtpOjEyO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjA6e31zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjI3OiIAKgByZWxhdGlvbkF1dG9sb2FkQ2FsbGJhY2siO047czoyNjoiACoAcmVsYXRpb25BdXRvbG9hZENvbnRleHQiO047czoxMDoidGltZXN0YW1wcyI7YjowO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MDp7fXM6MTE6InBpdm90UGFyZW50IjtyOjEyMDA7czoxMjoicGl2b3RSZWxhdGVkIjtyOjEyMzg7czoxMzoiACoAZm9yZWlnbktleSI7czoxMDoicGFja2FnZV9pZCI7czoxMzoiACoAcmVsYXRlZEtleSI7czo5OiJtb2R1bGVfaWQiO319czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjI6ImlkIjt9fWk6MTI7TzoxNzoiQXBwXE1vZGVsc1xNb2R1bGUiOjMzOntzOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjc6Im1vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YTo0OntzOjI6ImlkIjtpOjEzO3M6NDoibmFtZSI7czo4OiJTZXR0aW5ncyI7czoxMDoiY3JlYXRlZF9hdCI7TjtzOjEwOiJ1cGRhdGVkX2F0IjtOO31zOjExOiIAKgBvcmlnaW5hbCI7YTo2OntzOjI6ImlkIjtpOjEzO3M6NDoibmFtZSI7czo4OiJTZXR0aW5ncyI7czoxMDoiY3JlYXRlZF9hdCI7TjtzOjEwOiJ1cGRhdGVkX2F0IjtOO3M6MTY6InBpdm90X3BhY2thZ2VfaWQiO2k6NTtzOjE1OiJwaXZvdF9tb2R1bGVfaWQiO2k6MTM7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo1OiJwaXZvdCI7Tzo0NDoiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxSZWxhdGlvbnNcUGl2b3QiOjM3OntzOjEzOiIAKgBjb25uZWN0aW9uIjtOO3M6ODoiACoAdGFibGUiO3M6MTU6InBhY2thZ2VfbW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjowO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aToxMzt9czoxMToiACoAb3JpZ2luYWwiO2E6Mjp7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6OToibW9kdWxlX2lkIjtpOjEzO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjA6e31zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjI3OiIAKgByZWxhdGlvbkF1dG9sb2FkQ2FsbGJhY2siO047czoyNjoiACoAcmVsYXRpb25BdXRvbG9hZENvbnRleHQiO047czoxMDoidGltZXN0YW1wcyI7YjowO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MDp7fXM6MTE6InBpdm90UGFyZW50IjtyOjEyMDA7czoxMjoicGl2b3RSZWxhdGVkIjtyOjEyMzg7czoxMzoiACoAZm9yZWlnbktleSI7czoxMDoicGFja2FnZV9pZCI7czoxMzoiACoAcmVsYXRlZEtleSI7czo5OiJtb2R1bGVfaWQiO319czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjI6ImlkIjt9fWk6MTM7TzoxNzoiQXBwXE1vZGVsc1xNb2R1bGUiOjMzOntzOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjc6Im1vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YTo0OntzOjI6ImlkIjtpOjE0O3M6NDoibmFtZSI7czoxODoiRGVsaXZlcnkgRXhlY3V0aXZlIjtzOjEwOiJjcmVhdGVkX2F0IjtOO3M6MTA6InVwZGF0ZWRfYXQiO047fXM6MTE6IgAqAG9yaWdpbmFsIjthOjY6e3M6MjoiaWQiO2k6MTQ7czo0OiJuYW1lIjtzOjE4OiJEZWxpdmVyeSBFeGVjdXRpdmUiO3M6MTA6ImNyZWF0ZWRfYXQiO047czoxMDoidXBkYXRlZF9hdCI7TjtzOjE2OiJwaXZvdF9wYWNrYWdlX2lkIjtpOjU7czoxNToicGl2b3RfbW9kdWxlX2lkIjtpOjE0O31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjE6e3M6NToicGl2b3QiO086NDQ6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcUmVsYXRpb25zXFBpdm90IjozNzp7czoxMzoiACoAY29ubmVjdGlvbiI7TjtzOjg6IgAqAHRhYmxlIjtzOjE1OiJwYWNrYWdlX21vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MDtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToyOntzOjEwOiJwYWNrYWdlX2lkIjtpOjU7czo5OiJtb2R1bGVfaWQiO2k6MTQ7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aToxNDt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MDtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjA6e31zOjExOiJwaXZvdFBhcmVudCI7cjoxMjAwO3M6MTI6InBpdm90UmVsYXRlZCI7cjoxMjM4O3M6MTM6IgAqAGZvcmVpZ25LZXkiO3M6MTA6InBhY2thZ2VfaWQiO3M6MTM6IgAqAHJlbGF0ZWRLZXkiO3M6OToibW9kdWxlX2lkIjt9fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoyOiJpZCI7fX1pOjE0O086MTc6IkFwcFxNb2RlbHNcTW9kdWxlIjozMzp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJteXNxbCI7czo4OiIAKgB0YWJsZSI7czo3OiJtb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6NDp7czoyOiJpZCI7aToxNTtzOjQ6Im5hbWUiO3M6MTQ6IldhaXRlciBSZXF1ZXN0IjtzOjEwOiJjcmVhdGVkX2F0IjtOO3M6MTA6InVwZGF0ZWRfYXQiO047fXM6MTE6IgAqAG9yaWdpbmFsIjthOjY6e3M6MjoiaWQiO2k6MTU7czo0OiJuYW1lIjtzOjE0OiJXYWl0ZXIgUmVxdWVzdCI7czoxMDoiY3JlYXRlZF9hdCI7TjtzOjEwOiJ1cGRhdGVkX2F0IjtOO3M6MTY6InBpdm90X3BhY2thZ2VfaWQiO2k6NTtzOjE1OiJwaXZvdF9tb2R1bGVfaWQiO2k6MTU7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo1OiJwaXZvdCI7Tzo0NDoiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxSZWxhdGlvbnNcUGl2b3QiOjM3OntzOjEzOiIAKgBjb25uZWN0aW9uIjtOO3M6ODoiACoAdGFibGUiO3M6MTU6InBhY2thZ2VfbW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjowO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aToxNTt9czoxMToiACoAb3JpZ2luYWwiO2E6Mjp7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6OToibW9kdWxlX2lkIjtpOjE1O31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjA6e31zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjI3OiIAKgByZWxhdGlvbkF1dG9sb2FkQ2FsbGJhY2siO047czoyNjoiACoAcmVsYXRpb25BdXRvbG9hZENvbnRleHQiO047czoxMDoidGltZXN0YW1wcyI7YjowO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MDp7fXM6MTE6InBpdm90UGFyZW50IjtyOjEyMDA7czoxMjoicGl2b3RSZWxhdGVkIjtyOjEyMzg7czoxMzoiACoAZm9yZWlnbktleSI7czoxMDoicGFja2FnZV9pZCI7czoxMzoiACoAcmVsYXRlZEtleSI7czo5OiJtb2R1bGVfaWQiO319czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjI6ImlkIjt9fWk6MTU7TzoxNzoiQXBwXE1vZGVsc1xNb2R1bGUiOjMzOntzOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjc6Im1vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YTo0OntzOjI6ImlkIjtpOjE2O3M6NDoibmFtZSI7czo3OiJFeHBlbnNlIjtzOjEwOiJjcmVhdGVkX2F0IjtOO3M6MTA6InVwZGF0ZWRfYXQiO047fXM6MTE6IgAqAG9yaWdpbmFsIjthOjY6e3M6MjoiaWQiO2k6MTY7czo0OiJuYW1lIjtzOjc6IkV4cGVuc2UiO3M6MTA6ImNyZWF0ZWRfYXQiO047czoxMDoidXBkYXRlZF9hdCI7TjtzOjE2OiJwaXZvdF9wYWNrYWdlX2lkIjtpOjU7czoxNToicGl2b3RfbW9kdWxlX2lkIjtpOjE2O31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjE6e3M6NToicGl2b3QiO086NDQ6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcUmVsYXRpb25zXFBpdm90IjozNzp7czoxMzoiACoAY29ubmVjdGlvbiI7TjtzOjg6IgAqAHRhYmxlIjtzOjE1OiJwYWNrYWdlX21vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MDtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToyOntzOjEwOiJwYWNrYWdlX2lkIjtpOjU7czo5OiJtb2R1bGVfaWQiO2k6MTY7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aToxNjt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MDtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjA6e31zOjExOiJwaXZvdFBhcmVudCI7cjoxMjAwO3M6MTI6InBpdm90UmVsYXRlZCI7cjoxMjM4O3M6MTM6IgAqAGZvcmVpZ25LZXkiO3M6MTA6InBhY2thZ2VfaWQiO3M6MTM6IgAqAHJlbGF0ZWRLZXkiO3M6OToibW9kdWxlX2lkIjt9fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoyOiJpZCI7fX1pOjE2O086MTc6IkFwcFxNb2RlbHNcTW9kdWxlIjozMzp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJteXNxbCI7czo4OiIAKgB0YWJsZSI7czo3OiJtb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6NDp7czoyOiJpZCI7aToxMDE7czo0OiJuYW1lIjtzOjg6Ik11bHRpUE9TIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA5OjQ5OjQyIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA5OjQ5OjQyIjt9czoxMToiACoAb3JpZ2luYWwiO2E6Njp7czoyOiJpZCI7aToxMDE7czo0OiJuYW1lIjtzOjg6Ik11bHRpUE9TIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA5OjQ5OjQyIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA5OjQ5OjQyIjtzOjE2OiJwaXZvdF9wYWNrYWdlX2lkIjtpOjU7czoxNToicGl2b3RfbW9kdWxlX2lkIjtpOjEwMTt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YToxOntzOjU6InBpdm90IjtPOjQ0OiJJbGx1bWluYXRlXERhdGFiYXNlXEVsb3F1ZW50XFJlbGF0aW9uc1xQaXZvdCI6Mzc6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO047czo4OiIAKgB0YWJsZSI7czoxNToicGFja2FnZV9tb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjA7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6Mjp7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6OToibW9kdWxlX2lkIjtpOjEwMTt9czoxMToiACoAb3JpZ2luYWwiO2E6Mjp7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6OToibW9kdWxlX2lkIjtpOjEwMTt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MDtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjA6e31zOjExOiJwaXZvdFBhcmVudCI7cjoxMjAwO3M6MTI6InBpdm90UmVsYXRlZCI7cjoxMjM4O3M6MTM6IgAqAGZvcmVpZ25LZXkiO3M6MTA6InBhY2thZ2VfaWQiO3M6MTM6IgAqAHJlbGF0ZWRLZXkiO3M6OToibW9kdWxlX2lkIjt9fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoyOiJpZCI7fX1pOjE3O086MTc6IkFwcFxNb2RlbHNcTW9kdWxlIjozMzp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJteXNxbCI7czo4OiIAKgB0YWJsZSI7czo3OiJtb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6NDp7czoyOiJpZCI7aToxMDA7czo0OiJuYW1lIjtzOjc6IktpdGNoZW4iO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDk6NDk6MzYiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDk6NDk6MzYiO31zOjExOiIAKgBvcmlnaW5hbCI7YTo2OntzOjI6ImlkIjtpOjEwMDtzOjQ6Im5hbWUiO3M6NzoiS2l0Y2hlbiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwOTo0OTozNiI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwOTo0OTozNiI7czoxNjoicGl2b3RfcGFja2FnZV9pZCI7aTo1O3M6MTU6InBpdm90X21vZHVsZV9pZCI7aToxMDA7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo1OiJwaXZvdCI7Tzo0NDoiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxSZWxhdGlvbnNcUGl2b3QiOjM3OntzOjEzOiIAKgBjb25uZWN0aW9uIjtOO3M6ODoiACoAdGFibGUiO3M6MTU6InBhY2thZ2VfbW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjowO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aToxMDA7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aToxMDA7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MDp7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjA7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YTowOnt9czoxMToicGl2b3RQYXJlbnQiO3I6MTIwMDtzOjEyOiJwaXZvdFJlbGF0ZWQiO3I6MTIzODtzOjEzOiIAKgBmb3JlaWduS2V5IjtzOjEwOiJwYWNrYWdlX2lkIjtzOjEzOiIAKgByZWxhdGVkS2V5IjtzOjk6Im1vZHVsZV9pZCI7fX1zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjI3OiIAKgByZWxhdGlvbkF1dG9sb2FkQ2FsbGJhY2siO047czoyNjoiACoAcmVsYXRpb25BdXRvbG9hZENvbnRleHQiO047czoxMDoidGltZXN0YW1wcyI7YjoxO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MjoiaWQiO319aToxODtPOjE3OiJBcHBcTW9kZWxzXE1vZHVsZSI6MzM6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6NzoibW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjQ6e3M6MjoiaWQiO2k6OTg7czo0OiJuYW1lIjtzOjk6IkludmVudG9yeSI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwOTo0OToyOSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwOTo0OToyOSI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjY6e3M6MjoiaWQiO2k6OTg7czo0OiJuYW1lIjtzOjk6IkludmVudG9yeSI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwOTo0OToyOSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwOTo0OToyOSI7czoxNjoicGl2b3RfcGFja2FnZV9pZCI7aTo1O3M6MTU6InBpdm90X21vZHVsZV9pZCI7aTo5ODt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YToxOntzOjU6InBpdm90IjtPOjQ0OiJJbGx1bWluYXRlXERhdGFiYXNlXEVsb3F1ZW50XFJlbGF0aW9uc1xQaXZvdCI6Mzc6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO047czo4OiIAKgB0YWJsZSI7czoxNToicGFja2FnZV9tb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjA7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6Mjp7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6OToibW9kdWxlX2lkIjtpOjk4O31zOjExOiIAKgBvcmlnaW5hbCI7YToyOntzOjEwOiJwYWNrYWdlX2lkIjtpOjU7czo5OiJtb2R1bGVfaWQiO2k6OTg7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MDp7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjA7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YTowOnt9czoxMToicGl2b3RQYXJlbnQiO3I6MTIwMDtzOjEyOiJwaXZvdFJlbGF0ZWQiO3I6MTIzODtzOjEzOiIAKgBmb3JlaWduS2V5IjtzOjEwOiJwYWNrYWdlX2lkIjtzOjEzOiIAKgByZWxhdGVkS2V5IjtzOjk6Im1vZHVsZV9pZCI7fX1zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjI3OiIAKgByZWxhdGlvbkF1dG9sb2FkQ2FsbGJhY2siO047czoyNjoiACoAcmVsYXRpb25BdXRvbG9hZENvbnRleHQiO047czoxMDoidGltZXN0YW1wcyI7YjoxO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MjoiaWQiO319aToxOTtPOjE3OiJBcHBcTW9kZWxzXE1vZHVsZSI6MzM6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6NzoibW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjQ6e3M6MjoiaWQiO2k6OTk7czo0OiJuYW1lIjtzOjU6Iktpb3NrIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA5OjQ5OjMzIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA5OjQ5OjMzIjt9czoxMToiACoAb3JpZ2luYWwiO2E6Njp7czoyOiJpZCI7aTo5OTtzOjQ6Im5hbWUiO3M6NToiS2lvc2siO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDk6NDk6MzMiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDk6NDk6MzMiO3M6MTY6InBpdm90X3BhY2thZ2VfaWQiO2k6NTtzOjE1OiJwaXZvdF9tb2R1bGVfaWQiO2k6OTk7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo1OiJwaXZvdCI7Tzo0NDoiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxSZWxhdGlvbnNcUGl2b3QiOjM3OntzOjEzOiIAKgBjb25uZWN0aW9uIjtOO3M6ODoiACoAdGFibGUiO3M6MTU6InBhY2thZ2VfbW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjowO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aTo5OTt9czoxMToiACoAb3JpZ2luYWwiO2E6Mjp7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6OToibW9kdWxlX2lkIjtpOjk5O31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjA6e31zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjI3OiIAKgByZWxhdGlvbkF1dG9sb2FkQ2FsbGJhY2siO047czoyNjoiACoAcmVsYXRpb25BdXRvbG9hZENvbnRleHQiO047czoxMDoidGltZXN0YW1wcyI7YjowO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MDp7fXM6MTE6InBpdm90UGFyZW50IjtyOjEyMDA7czoxMjoicGl2b3RSZWxhdGVkIjtyOjEyMzg7czoxMzoiACoAZm9yZWlnbktleSI7czoxMDoicGFja2FnZV9pZCI7czoxMzoiACoAcmVsYXRlZEtleSI7czo5OiJtb2R1bGVfaWQiO319czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjI6ImlkIjt9fWk6MjA7TzoxNzoiQXBwXE1vZGVsc1xNb2R1bGUiOjMzOntzOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjc6Im1vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YTo0OntzOjI6ImlkIjtpOjEwMjtzOjQ6Im5hbWUiO3M6MzoiU21zIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA5OjQ5OjQ1IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA5OjQ5OjQ1Ijt9czoxMToiACoAb3JpZ2luYWwiO2E6Njp7czoyOiJpZCI7aToxMDI7czo0OiJuYW1lIjtzOjM6IlNtcyI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwOTo0OTo0NSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwOTo0OTo0NSI7czoxNjoicGl2b3RfcGFja2FnZV9pZCI7aTo1O3M6MTU6InBpdm90X21vZHVsZV9pZCI7aToxMDI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo1OiJwaXZvdCI7Tzo0NDoiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxSZWxhdGlvbnNcUGl2b3QiOjM3OntzOjEzOiIAKgBjb25uZWN0aW9uIjtOO3M6ODoiACoAdGFibGUiO3M6MTU6InBhY2thZ2VfbW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjowO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aToxMDI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aToxMDI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MDp7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjA7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YTowOnt9czoxMToicGl2b3RQYXJlbnQiO3I6MTIwMDtzOjEyOiJwaXZvdFJlbGF0ZWQiO3I6MTIzODtzOjEzOiIAKgBmb3JlaWduS2V5IjtzOjEwOiJwYWNrYWdlX2lkIjtzOjEzOiIAKgByZWxhdGVkS2V5IjtzOjk6Im1vZHVsZV9pZCI7fX1zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjI3OiIAKgByZWxhdGlvbkF1dG9sb2FkQ2FsbGJhY2siO047czoyNjoiACoAcmVsYXRpb25BdXRvbG9hZENvbnRleHQiO047czoxMDoidGltZXN0YW1wcyI7YjoxO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MjoiaWQiO319aToyMTtPOjE3OiJBcHBcTW9kZWxzXE1vZHVsZSI6MzM6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6NzoibW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjQ6e3M6MjoiaWQiO2k6OTc7czo0OiJuYW1lIjtzOjEzOiJDYXNoIFJlZ2lzdGVyIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA5OjQ5OjIyIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA5OjQ5OjIyIjt9czoxMToiACoAb3JpZ2luYWwiO2E6Njp7czoyOiJpZCI7aTo5NztzOjQ6Im5hbWUiO3M6MTM6IkNhc2ggUmVnaXN0ZXIiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDk6NDk6MjIiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDk6NDk6MjIiO3M6MTY6InBpdm90X3BhY2thZ2VfaWQiO2k6NTtzOjE1OiJwaXZvdF9tb2R1bGVfaWQiO2k6OTc7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo1OiJwaXZvdCI7Tzo0NDoiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxSZWxhdGlvbnNcUGl2b3QiOjM3OntzOjEzOiIAKgBjb25uZWN0aW9uIjtOO3M6ODoiACoAdGFibGUiO3M6MTU6InBhY2thZ2VfbW9kdWxlcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjowO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjI6e3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjk6Im1vZHVsZV9pZCI7aTo5Nzt9czoxMToiACoAb3JpZ2luYWwiO2E6Mjp7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6OToibW9kdWxlX2lkIjtpOjk3O31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjA6e31zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjI3OiIAKgByZWxhdGlvbkF1dG9sb2FkQ2FsbGJhY2siO047czoyNjoiACoAcmVsYXRpb25BdXRvbG9hZENvbnRleHQiO047czoxMDoidGltZXN0YW1wcyI7YjowO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6MDp7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MDp7fXM6MTE6InBpdm90UGFyZW50IjtyOjEyMDA7czoxMjoicGl2b3RSZWxhdGVkIjtyOjEyMzg7czoxMzoiACoAZm9yZWlnbktleSI7czoxMDoicGFja2FnZV9pZCI7czoxMzoiACoAcmVsYXRlZEtleSI7czo5OiJtb2R1bGVfaWQiO319czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjI6ImlkIjt9fWk6MjI7TzoxNzoiQXBwXE1vZGVsc1xNb2R1bGUiOjMzOntzOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjc6Im1vZHVsZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YTo0OntzOjI6ImlkIjtpOjEwMztzOjQ6Im5hbWUiO3M6MTI6Ikxhbmd1YWdlUGFjayI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNS0xMi0wMiAxNTo1MDowOSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMi0wMiAxNTo1MDowOSI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjY6e3M6MjoiaWQiO2k6MTAzO3M6NDoibmFtZSI7czoxMjoiTGFuZ3VhZ2VQYWNrIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI1LTEyLTAyIDE1OjUwOjA5IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI1LTEyLTAyIDE1OjUwOjA5IjtzOjE2OiJwaXZvdF9wYWNrYWdlX2lkIjtpOjU7czoxNToicGl2b3RfbW9kdWxlX2lkIjtpOjEwMzt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YToxOntzOjU6InBpdm90IjtPOjQ0OiJJbGx1bWluYXRlXERhdGFiYXNlXEVsb3F1ZW50XFJlbGF0aW9uc1xQaXZvdCI6Mzc6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO047czo4OiIAKgB0YWJsZSI7czoxNToicGFja2FnZV9tb2R1bGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjA7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6Mjp7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6OToibW9kdWxlX2lkIjtpOjEwMzt9czoxMToiACoAb3JpZ2luYWwiO2E6Mjp7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6OToibW9kdWxlX2lkIjtpOjEwMzt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MDtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjA6e31zOjExOiJwaXZvdFBhcmVudCI7cjoxMjAwO3M6MTI6InBpdm90UmVsYXRlZCI7cjoxMjM4O3M6MTM6IgAqAGZvcmVpZ25LZXkiO3M6MTA6InBhY2thZ2VfaWQiO3M6MTM6IgAqAHJlbGF0ZWRLZXkiO3M6OToibW9kdWxlX2lkIjt9fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoyOiJpZCI7fX19czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO319czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjI6ImlkIjt9fXM6ODoiY3VycmVuY3kiO086MTk6IkFwcFxNb2RlbHNcQ3VycmVuY3kiOjMzOntzOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjEwOiJjdXJyZW5jaWVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTI6e3M6MjoiaWQiO2k6MTtzOjEzOiJyZXN0YXVyYW50X2lkIjtpOjE7czoxMzoiY3VycmVuY3lfbmFtZSI7czo3OiJEb2xsYXJzIjtzOjEzOiJjdXJyZW5jeV9jb2RlIjtzOjM6IlVTRCI7czoxNToiY3VycmVuY3lfc3ltYm9sIjtzOjE6IiQiO3M6MTc6ImN1cnJlbmN5X3Bvc2l0aW9uIjtzOjQ6ImxlZnQiO3M6MTM6Im5vX29mX2RlY2ltYWwiO2k6MjtzOjE4OiJ0aG91c2FuZF9zZXBhcmF0b3IiO3M6MToiLCI7czoxNzoiZGVjaW1hbF9zZXBhcmF0b3IiO3M6MToiLiI7czoxMzoiZXhjaGFuZ2VfcmF0ZSI7TjtzOjk6InVzZF9wcmljZSI7TjtzOjE3OiJpc19jcnlwdG9jdXJyZW5jeSI7czoyOiJubyI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjEyOntzOjI6ImlkIjtpOjE7czoxMzoicmVzdGF1cmFudF9pZCI7aToxO3M6MTM6ImN1cnJlbmN5X25hbWUiO3M6NzoiRG9sbGFycyI7czoxMzoiY3VycmVuY3lfY29kZSI7czozOiJVU0QiO3M6MTU6ImN1cnJlbmN5X3N5bWJvbCI7czoxOiIkIjtzOjE3OiJjdXJyZW5jeV9wb3NpdGlvbiI7czo0OiJsZWZ0IjtzOjEzOiJub19vZl9kZWNpbWFsIjtpOjI7czoxODoidGhvdXNhbmRfc2VwYXJhdG9yIjtzOjE6IiwiO3M6MTc6ImRlY2ltYWxfc2VwYXJhdG9yIjtzOjE6Ii4iO3M6MTM6ImV4Y2hhbmdlX3JhdGUiO047czo5OiJ1c2RfcHJpY2UiO047czoxNzoiaXNfY3J5cHRvY3VycmVuY3kiO3M6Mjoibm8iO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjE6e3M6MTA6InJlc3RhdXJhbnQiO086MjE6IkFwcFxNb2RlbHNcUmVzdGF1cmFudCI6Mzk6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6MTE6InJlc3RhdXJhbnRzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6ODM6e3M6MjoiaWQiO2k6MTtzOjEwOiJzdWJfZG9tYWluIjtzOjIwOiJkZW1vLnRhYmxldHJhY2sudGVzdCI7czo0OiJuYW1lIjtzOjE1OiJEZW1vIFJlc3RhdXJhbnQiO3M6NDoiaGFzaCI7czoxNToiZGVtby1yZXN0YXVyYW50IjtzOjc6ImFkZHJlc3MiO3M6NTE6IjQ1MDgyIE1hdGlsZGUgRGl2aWRlIEFwdC4gODM5Ck1hZGlzeW5zaWRlLCBBWiAyMzg2MyI7czoxMjoicGhvbmVfbnVtYmVyIjtzOjEyOiIrMTczNzg2NDE0MDMiO3M6MTA6InBob25lX2NvZGUiO047czo1OiJlbWFpbCI7czoyNzoiZGVtby5yZXN0YXVyYW50QGV4YW1wbGUuY29tIjtzOjg6InRpbWV6b25lIjtzOjE2OiJBbWVyaWNhL05ld19Zb3JrIjtzOjk6InRoZW1lX2hleCI7czo3OiIjQTc4QkZBIjtzOjk6InRoZW1lX3JnYiI7czoxMzoiMTY3LCAxMzksIDI1MCI7czo0OiJsb2dvIjtOO3M6MTA6ImNvdW50cnlfaWQiO2k6MjM2O3M6MTU6ImhpZGVfbmV3X29yZGVycyI7aTowO3M6MjE6ImhpZGVfbmV3X3Jlc2VydmF0aW9ucyI7aTowO3M6MjM6ImhpZGVfbmV3X3dhaXRlcl9yZXF1ZXN0IjtpOjA7czoxMToiY3VycmVuY3lfaWQiO2k6MTtzOjEyOiJsaWNlbnNlX3R5cGUiO3M6NDoicGFpZCI7czo5OiJpc19hY3RpdmUiO2k6MTtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA4OjI3OjIzIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA5OjQ5OjQ4IjtzOjIzOiJjdXN0b21lcl9sb2dpbl9yZXF1aXJlZCI7aTowO3M6ODoiYWJvdXRfdXMiO3M6MTMwNDoiPHAgY2xhc3M9InRleHQtbGcgdGV4dC1ncmF5LTYwMCBtYi02Ij4KICAgICAgICAgIFdlbGNvbWUgdG8gb3VyIHJlc3RhdXJhbnQsIHdoZXJlIGdyZWF0IGZvb2QgYW5kIGdvb2QgdmliZXMgY29tZSB0b2dldGhlciEgV2UncmUgYSBsb2NhbCwgZmFtaWx5LW93bmVkIHNwb3QgdGhhdCBsb3ZlcyBicmluZ2luZyBwZW9wbGUgdG9nZXRoZXIgb3ZlciBkZWxpY2lvdXMgbWVhbHMgYW5kIHVuZm9yZ2V0dGFibGUgbW9tZW50cy4gV2hldGhlciB5b3UncmUgaGVyZSBmb3IgYSBxdWljayBiaXRlLCBhIGZhbWlseSBkaW5uZXIsIG9yIGEgY2VsZWJyYXRpb24sIHdlJ3JlIGFsbCBhYm91dCBtYWtpbmcgeW91ciB0aW1lIHdpdGggdXMgc3BlY2lhbC4KICAgICAgICA8L3A+CiAgICAgICAgPHAgY2xhc3M9InRleHQtbGcgdGV4dC1ncmF5LTYwMCBtYi02Ij4KICAgICAgICAgIE91ciBtZW51IGlzIHBhY2tlZCB3aXRoIGRpc2hlcyBtYWRlIGZyb20gZnJlc2gsIHF1YWxpdHkgaW5ncmVkaWVudHMgYmVjYXVzZSB3ZSBiZWxpZXZlIGZvb2Qgc2hvdWxkIHRhc3RlIGFzCiAgICAgICAgICBnb29kIGFzIGl0IG1ha2VzIHlvdSBmZWVsLiBGcm9tIG91ciBzaWduYXR1cmUgZGlzaGVzIHRvIHNlYXNvbmFsIHNwZWNpYWxzLCB0aGVyZSdzIGFsd2F5cyBzb21ldGhpbmcgdG8gZXhjaXRlCiAgICAgICAgICB5b3VyIHRhc3RlIGJ1ZHMuCiAgICAgICAgPC9wPgogICAgICAgIDxwIGNsYXNzPSJ0ZXh0LWxnIHRleHQtZ3JheS02MDAgbWItNiI+CiAgICAgICAgICBCdXQgd2UncmUgbm90IGp1c3QgYWJvdXQgdGhlIGZvb2TigJR3ZSdyZSBhYm91dCBjb21tdW5pdHkuIFdlIGxvdmUgc2VlaW5nIGZhbWlsaWFyIGZhY2VzIGFuZCB3ZWxjb21pbmcgbmV3IG9uZXMuCiAgICAgICAgICBPdXIgdGVhbSBpcyBhIGZ1biwgZnJpZW5kbHkgYnVuY2ggZGVkaWNhdGVkIHRvIHNlcnZpbmcgeW91IHdpdGggYSBzbWlsZSBhbmQgbWFraW5nIHN1cmUgZXZlcnkgdmlzaXQgZmVlbHMgbGlrZQogICAgICAgICAgY29taW5nIGhvbWUuCiAgICAgICAgPC9wPgogICAgICAgIDxwIGNsYXNzPSJ0ZXh0LWxnIHRleHQtZ3JheS02MDAiPgogICAgICAgICAgU28sIGNvbWUgb24gaW4sIGdyYWIgYSBzZWF0LCBhbmQgbGV0IHVzIHRha2UgY2FyZSBvZiB0aGUgcmVzdC4gV2UgY2FuJ3Qgd2FpdCB0byBzaGFyZSBvdXIgbG92ZSBvZiBmb29kIHdpdGgKICAgICAgICAgIHlvdSEKICAgICAgICA8L3A+CiAgICAgICAgPHAgY2xhc3M9InRleHQtbGcgdGV4dC1ncmF5LTgwMCBmb250LXNlbWlib2xkIG10LTYiPlNlZSB5b3Ugc29vbiEg8J+Nve+4j+KcqDwvcD4iO3M6MzA6ImFsbG93X2N1c3RvbWVyX2RlbGl2ZXJ5X29yZGVycyI7aToxO3M6Mjg6ImFsbG93X2N1c3RvbWVyX3BpY2t1cF9vcmRlcnMiO2k6MTtzOjE3OiJwaWNrdXBfZGF5c19yYW5nZSI7aTo3O3M6MjE6ImFsbG93X2N1c3RvbWVyX29yZGVycyI7aToxO3M6MjA6ImFsbG93X2RpbmVfaW5fb3JkZXJzIjtpOjE7czo4OiJzaG93X3ZlZyI7aToxO3M6MTA6InNob3dfaGFsYWwiO2k6MDtzOjEwOiJwYWNrYWdlX2lkIjtpOjU7czoxMjoicGFja2FnZV90eXBlIjtzOjU6InRyaWFsIjtzOjY6InN0YXR1cyI7czo2OiJhY3RpdmUiO3M6MTc6ImxpY2Vuc2VfZXhwaXJlX29uIjtzOjE5OiIyMDI1LTEyLTMwIDA4OjI3OjIzIjtzOjk6ImNvdW50X3NtcyI7aTowO3M6OToidG90YWxfc21zIjtpOi0xO3M6MTM6InRyaWFsX2VuZHNfYXQiO3M6MTk6IjIwMjUtMTItMzAgMDg6Mjc6MjMiO3M6MTg6ImxpY2Vuc2VfdXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMyI7czoyMzoic3Vic2NyaXB0aW9uX3VwZGF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDg6Mjc6MjMiO3M6OToic3RyaXBlX2lkIjtOO3M6NzoicG1fdHlwZSI7TjtzOjEyOiJwbV9sYXN0X2ZvdXIiO047czoyNToiaXNfd2FpdGVyX3JlcXVlc3RfZW5hYmxlZCI7aToxO3M6MzI6ImRlZmF1bHRfdGFibGVfcmVzZXJ2YXRpb25fc3RhdHVzIjtzOjk6IkNvbmZpcm1lZCI7czoyMDoiZGlzYWJsZV9zbG90X21pbnV0ZXMiO2k6MzA7czoxNToiYXBwcm92YWxfc3RhdHVzIjtzOjg6IkFwcHJvdmVkIjtzOjE2OiJyZWplY3Rpb25fcmVhc29uIjtOO3M6MTM6ImZhY2Vib29rX2xpbmsiO3M6MjU6Imh0dHBzOi8vd3d3LmZhY2Vib29rLmNvbS8iO3M6MTQ6Imluc3RhZ3JhbV9saW5rIjtzOjI2OiJodHRwczovL3d3dy5pbnN0YWdyYW0uY29tLyI7czoxMjoidHdpdHRlcl9saW5rIjtzOjI0OiJodHRwczovL3d3dy50d2l0dGVyLmNvbS8iO3M6OToieWVscF9saW5rIjtOO3M6MTQ6InRhYmxlX3JlcXVpcmVkIjtpOjA7czoxNDoic2hvd19sb2dvX3RleHQiO2k6MTtzOjEyOiJtZXRhX2tleXdvcmQiO047czoxNjoibWV0YV9kZXNjcmlwdGlvbiI7TjtzOjM0OiJ1cGxvYWRfZmF2X2ljb25fYW5kcm9pZF9jaHJvbWVfMTkyIjtOO3M6MzQ6InVwbG9hZF9mYXZfaWNvbl9hbmRyb2lkX2Nocm9tZV81MTIiO047czozMjoidXBsb2FkX2Zhdl9pY29uX2FwcGxlX3RvdWNoX2ljb24iO047czoxNzoidXBsb2FkX2Zhdmljb25fMTYiO047czoxNzoidXBsb2FkX2Zhdmljb25fMzIiO047czo3OiJmYXZpY29uIjtOO3M6MzY6ImlzX3dhaXRlcl9yZXF1ZXN0X2VuYWJsZWRfb25fZGVza3RvcCI7aToxO3M6MzU6ImlzX3dhaXRlcl9yZXF1ZXN0X2VuYWJsZWRfb25fbW9iaWxlIjtpOjE7czozNjoiaXNfd2FpdGVyX3JlcXVlc3RfZW5hYmxlZF9vcGVuX2J5X3FyIjtpOjA7czoxMToid2VibWFuaWZlc3QiO047czoxNToiZW5hYmxlX3RpcF9zaG9wIjtpOjE7czoxNDoiZW5hYmxlX3RpcF9wb3MiO2k6MTtzOjI1OiJpc19wd2FfaW5zdGFsbF9hbGVydF9zaG93IjtpOjA7czoxOToiYXV0b19jb25maXJtX29yZGVycyI7aTowO3M6Mjk6InJlc3RyaWN0X3FyX29yZGVyX2J5X2xvY2F0aW9uIjtpOjA7czoyMjoicXJfb3JkZXJfcmFkaXVzX21ldGVycyI7TjtzOjIzOiJzaG93X29yZGVyX3R5cGVfb3B0aW9ucyI7aToxO3M6MjQ6ImRpc2FibGVfb3JkZXJfdHlwZV9wb3B1cCI7aTowO3M6MjE6ImRlZmF1bHRfb3JkZXJfdHlwZV9pZCI7TjtzOjI3OiJoaWRlX21lbnVfaXRlbV9pbWFnZV9vbl9wb3MiO2k6MDtzOjM3OiJoaWRlX21lbnVfaXRlbV9pbWFnZV9vbl9jdXN0b21lcl9zaXRlIjtpOjA7czo4OiJ0YXhfbW9kZSI7czo1OiJvcmRlciI7czoxMzoidGF4X2luY2x1c2l2ZSI7aTowO3M6MjI6ImN1c3RvbWVyX3NpdGVfbGFuZ3VhZ2UiO3M6MjoiZW4iO3M6MjQ6ImVuYWJsZV9hZG1pbl9yZXNlcnZhdGlvbiI7aToxO3M6Mjc6ImVuYWJsZV9jdXN0b21lcl9yZXNlcnZhdGlvbiI7aToxO3M6MTg6Im1pbmltdW1fcGFydHlfc2l6ZSI7aToxO3M6MjY6InRhYmxlX2xvY2tfdGltZW91dF9taW51dGVzIjtpOjEwO31zOjExOiIAKgBvcmlnaW5hbCI7YTo4Mzp7czoyOiJpZCI7aToxO3M6MTA6InN1Yl9kb21haW4iO3M6MjA6ImRlbW8udGFibGV0cmFjay50ZXN0IjtzOjQ6Im5hbWUiO3M6MTU6IkRlbW8gUmVzdGF1cmFudCI7czo0OiJoYXNoIjtzOjE1OiJkZW1vLXJlc3RhdXJhbnQiO3M6NzoiYWRkcmVzcyI7czo1MToiNDUwODIgTWF0aWxkZSBEaXZpZGUgQXB0LiA4MzkKTWFkaXN5bnNpZGUsIEFaIDIzODYzIjtzOjEyOiJwaG9uZV9udW1iZXIiO3M6MTI6IisxNzM3ODY0MTQwMyI7czoxMDoicGhvbmVfY29kZSI7TjtzOjU6ImVtYWlsIjtzOjI3OiJkZW1vLnJlc3RhdXJhbnRAZXhhbXBsZS5jb20iO3M6ODoidGltZXpvbmUiO3M6MTY6IkFtZXJpY2EvTmV3X1lvcmsiO3M6OToidGhlbWVfaGV4IjtzOjc6IiNBNzhCRkEiO3M6OToidGhlbWVfcmdiIjtzOjEzOiIxNjcsIDEzOSwgMjUwIjtzOjQ6ImxvZ28iO047czoxMDoiY291bnRyeV9pZCI7aToyMzY7czoxNToiaGlkZV9uZXdfb3JkZXJzIjtpOjA7czoyMToiaGlkZV9uZXdfcmVzZXJ2YXRpb25zIjtpOjA7czoyMzoiaGlkZV9uZXdfd2FpdGVyX3JlcXVlc3QiO2k6MDtzOjExOiJjdXJyZW5jeV9pZCI7aToxO3M6MTI6ImxpY2Vuc2VfdHlwZSI7czo0OiJwYWlkIjtzOjk6ImlzX2FjdGl2ZSI7aToxO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDg6Mjc6MjMiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDk6NDk6NDgiO3M6MjM6ImN1c3RvbWVyX2xvZ2luX3JlcXVpcmVkIjtpOjA7czo4OiJhYm91dF91cyI7czoxMzA0OiI8cCBjbGFzcz0idGV4dC1sZyB0ZXh0LWdyYXktNjAwIG1iLTYiPgogICAgICAgICAgV2VsY29tZSB0byBvdXIgcmVzdGF1cmFudCwgd2hlcmUgZ3JlYXQgZm9vZCBhbmQgZ29vZCB2aWJlcyBjb21lIHRvZ2V0aGVyISBXZSdyZSBhIGxvY2FsLCBmYW1pbHktb3duZWQgc3BvdCB0aGF0IGxvdmVzIGJyaW5naW5nIHBlb3BsZSB0b2dldGhlciBvdmVyIGRlbGljaW91cyBtZWFscyBhbmQgdW5mb3JnZXR0YWJsZSBtb21lbnRzLiBXaGV0aGVyIHlvdSdyZSBoZXJlIGZvciBhIHF1aWNrIGJpdGUsIGEgZmFtaWx5IGRpbm5lciwgb3IgYSBjZWxlYnJhdGlvbiwgd2UncmUgYWxsIGFib3V0IG1ha2luZyB5b3VyIHRpbWUgd2l0aCB1cyBzcGVjaWFsLgogICAgICAgIDwvcD4KICAgICAgICA8cCBjbGFzcz0idGV4dC1sZyB0ZXh0LWdyYXktNjAwIG1iLTYiPgogICAgICAgICAgT3VyIG1lbnUgaXMgcGFja2VkIHdpdGggZGlzaGVzIG1hZGUgZnJvbSBmcmVzaCwgcXVhbGl0eSBpbmdyZWRpZW50cyBiZWNhdXNlIHdlIGJlbGlldmUgZm9vZCBzaG91bGQgdGFzdGUgYXMKICAgICAgICAgIGdvb2QgYXMgaXQgbWFrZXMgeW91IGZlZWwuIEZyb20gb3VyIHNpZ25hdHVyZSBkaXNoZXMgdG8gc2Vhc29uYWwgc3BlY2lhbHMsIHRoZXJlJ3MgYWx3YXlzIHNvbWV0aGluZyB0byBleGNpdGUKICAgICAgICAgIHlvdXIgdGFzdGUgYnVkcy4KICAgICAgICA8L3A+CiAgICAgICAgPHAgY2xhc3M9InRleHQtbGcgdGV4dC1ncmF5LTYwMCBtYi02Ij4KICAgICAgICAgIEJ1dCB3ZSdyZSBub3QganVzdCBhYm91dCB0aGUgZm9vZOKAlHdlJ3JlIGFib3V0IGNvbW11bml0eS4gV2UgbG92ZSBzZWVpbmcgZmFtaWxpYXIgZmFjZXMgYW5kIHdlbGNvbWluZyBuZXcgb25lcy4KICAgICAgICAgIE91ciB0ZWFtIGlzIGEgZnVuLCBmcmllbmRseSBidW5jaCBkZWRpY2F0ZWQgdG8gc2VydmluZyB5b3Ugd2l0aCBhIHNtaWxlIGFuZCBtYWtpbmcgc3VyZSBldmVyeSB2aXNpdCBmZWVscyBsaWtlCiAgICAgICAgICBjb21pbmcgaG9tZS4KICAgICAgICA8L3A+CiAgICAgICAgPHAgY2xhc3M9InRleHQtbGcgdGV4dC1ncmF5LTYwMCI+CiAgICAgICAgICBTbywgY29tZSBvbiBpbiwgZ3JhYiBhIHNlYXQsIGFuZCBsZXQgdXMgdGFrZSBjYXJlIG9mIHRoZSByZXN0LiBXZSBjYW4ndCB3YWl0IHRvIHNoYXJlIG91ciBsb3ZlIG9mIGZvb2Qgd2l0aAogICAgICAgICAgeW91IQogICAgICAgIDwvcD4KICAgICAgICA8cCBjbGFzcz0idGV4dC1sZyB0ZXh0LWdyYXktODAwIGZvbnQtc2VtaWJvbGQgbXQtNiI+U2VlIHlvdSBzb29uISDwn42977iP4pyoPC9wPiI7czozMDoiYWxsb3dfY3VzdG9tZXJfZGVsaXZlcnlfb3JkZXJzIjtpOjE7czoyODoiYWxsb3dfY3VzdG9tZXJfcGlja3VwX29yZGVycyI7aToxO3M6MTc6InBpY2t1cF9kYXlzX3JhbmdlIjtpOjc7czoyMToiYWxsb3dfY3VzdG9tZXJfb3JkZXJzIjtpOjE7czoyMDoiYWxsb3dfZGluZV9pbl9vcmRlcnMiO2k6MTtzOjg6InNob3dfdmVnIjtpOjE7czoxMDoic2hvd19oYWxhbCI7aTowO3M6MTA6InBhY2thZ2VfaWQiO2k6NTtzOjEyOiJwYWNrYWdlX3R5cGUiO3M6NToidHJpYWwiO3M6Njoic3RhdHVzIjtzOjY6ImFjdGl2ZSI7czoxNzoibGljZW5zZV9leHBpcmVfb24iO3M6MTk6IjIwMjUtMTItMzAgMDg6Mjc6MjMiO3M6OToiY291bnRfc21zIjtpOjA7czo5OiJ0b3RhbF9zbXMiO2k6LTE7czoxMzoidHJpYWxfZW5kc19hdCI7czoxOToiMjAyNS0xMi0zMCAwODoyNzoyMyI7czoxODoibGljZW5zZV91cGRhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA4OjI3OjIzIjtzOjIzOiJzdWJzY3JpcHRpb25fdXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMyI7czo5OiJzdHJpcGVfaWQiO047czo3OiJwbV90eXBlIjtOO3M6MTI6InBtX2xhc3RfZm91ciI7TjtzOjI1OiJpc193YWl0ZXJfcmVxdWVzdF9lbmFibGVkIjtpOjE7czozMjoiZGVmYXVsdF90YWJsZV9yZXNlcnZhdGlvbl9zdGF0dXMiO3M6OToiQ29uZmlybWVkIjtzOjIwOiJkaXNhYmxlX3Nsb3RfbWludXRlcyI7aTozMDtzOjE1OiJhcHByb3ZhbF9zdGF0dXMiO3M6ODoiQXBwcm92ZWQiO3M6MTY6InJlamVjdGlvbl9yZWFzb24iO047czoxMzoiZmFjZWJvb2tfbGluayI7czoyNToiaHR0cHM6Ly93d3cuZmFjZWJvb2suY29tLyI7czoxNDoiaW5zdGFncmFtX2xpbmsiO3M6MjY6Imh0dHBzOi8vd3d3Lmluc3RhZ3JhbS5jb20vIjtzOjEyOiJ0d2l0dGVyX2xpbmsiO3M6MjQ6Imh0dHBzOi8vd3d3LnR3aXR0ZXIuY29tLyI7czo5OiJ5ZWxwX2xpbmsiO047czoxNDoidGFibGVfcmVxdWlyZWQiO2k6MDtzOjE0OiJzaG93X2xvZ29fdGV4dCI7aToxO3M6MTI6Im1ldGFfa2V5d29yZCI7TjtzOjE2OiJtZXRhX2Rlc2NyaXB0aW9uIjtOO3M6MzQ6InVwbG9hZF9mYXZfaWNvbl9hbmRyb2lkX2Nocm9tZV8xOTIiO047czozNDoidXBsb2FkX2Zhdl9pY29uX2FuZHJvaWRfY2hyb21lXzUxMiI7TjtzOjMyOiJ1cGxvYWRfZmF2X2ljb25fYXBwbGVfdG91Y2hfaWNvbiI7TjtzOjE3OiJ1cGxvYWRfZmF2aWNvbl8xNiI7TjtzOjE3OiJ1cGxvYWRfZmF2aWNvbl8zMiI7TjtzOjc6ImZhdmljb24iO047czozNjoiaXNfd2FpdGVyX3JlcXVlc3RfZW5hYmxlZF9vbl9kZXNrdG9wIjtpOjE7czozNToiaXNfd2FpdGVyX3JlcXVlc3RfZW5hYmxlZF9vbl9tb2JpbGUiO2k6MTtzOjM2OiJpc193YWl0ZXJfcmVxdWVzdF9lbmFibGVkX29wZW5fYnlfcXIiO2k6MDtzOjExOiJ3ZWJtYW5pZmVzdCI7TjtzOjE1OiJlbmFibGVfdGlwX3Nob3AiO2k6MTtzOjE0OiJlbmFibGVfdGlwX3BvcyI7aToxO3M6MjU6ImlzX3B3YV9pbnN0YWxsX2FsZXJ0X3Nob3ciO2k6MDtzOjE5OiJhdXRvX2NvbmZpcm1fb3JkZXJzIjtpOjA7czoyOToicmVzdHJpY3RfcXJfb3JkZXJfYnlfbG9jYXRpb24iO2k6MDtzOjIyOiJxcl9vcmRlcl9yYWRpdXNfbWV0ZXJzIjtOO3M6MjM6InNob3dfb3JkZXJfdHlwZV9vcHRpb25zIjtpOjE7czoyNDoiZGlzYWJsZV9vcmRlcl90eXBlX3BvcHVwIjtpOjA7czoyMToiZGVmYXVsdF9vcmRlcl90eXBlX2lkIjtOO3M6Mjc6ImhpZGVfbWVudV9pdGVtX2ltYWdlX29uX3BvcyI7aTowO3M6Mzc6ImhpZGVfbWVudV9pdGVtX2ltYWdlX29uX2N1c3RvbWVyX3NpdGUiO2k6MDtzOjg6InRheF9tb2RlIjtzOjU6Im9yZGVyIjtzOjEzOiJ0YXhfaW5jbHVzaXZlIjtpOjA7czoyMjoiY3VzdG9tZXJfc2l0ZV9sYW5ndWFnZSI7czoyOiJlbiI7czoyNDoiZW5hYmxlX2FkbWluX3Jlc2VydmF0aW9uIjtpOjE7czoyNzoiZW5hYmxlX2N1c3RvbWVyX3Jlc2VydmF0aW9uIjtpOjE7czoxODoibWluaW11bV9wYXJ0eV9zaXplIjtpOjE7czoyNjoidGFibGVfbG9ja190aW1lb3V0X21pbnV0ZXMiO2k6MTA7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjExOntzOjE3OiJsaWNlbnNlX2V4cGlyZV9vbiI7czo4OiJkYXRldGltZSI7czoxNToidHJpYWxfZXhwaXJlX29uIjtzOjg6ImRhdGV0aW1lIjtzOjE4OiJsaWNlbnNlX3VwZGF0ZWRfYXQiO3M6ODoiZGF0ZXRpbWUiO3M6MjM6InN1YnNjcmlwdGlvbl91cGRhdGVkX2F0IjtzOjg6ImRhdGV0aW1lIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjg6ImRhdGV0aW1lIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjg6ImRhdGV0aW1lIjtzOjIzOiJjdXN0b21fZGVsaXZlcnlfb3B0aW9ucyI7czo1OiJhcnJheSI7czo5OiJpc19hY3RpdmUiO3M6NzoiYm9vbGVhbiI7czoyNDoiZW5hYmxlX2FkbWluX3Jlc2VydmF0aW9uIjtzOjc6ImJvb2xlYW4iO3M6Mjc6ImVuYWJsZV9jdXN0b21lcl9yZXNlcnZhdGlvbiI7czo3OiJib29sZWFuIjtzOjI5OiJyZXN0cmljdF9xcl9vcmRlcl9ieV9sb2NhdGlvbiI7czo3OiJib29sZWFuIjt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjE6e2k6MDtzOjg6ImxvZ29fdXJsIjt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YToxOntzOjg6ImN1cnJlbmN5IjtPOjE5OiJBcHBcTW9kZWxzXEN1cnJlbmN5IjozMzp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJteXNxbCI7czo4OiIAKgB0YWJsZSI7czoxMDoiY3VycmVuY2llcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjEyOntzOjI6ImlkIjtpOjE7czoxMzoicmVzdGF1cmFudF9pZCI7aToxO3M6MTM6ImN1cnJlbmN5X25hbWUiO3M6NzoiRG9sbGFycyI7czoxMzoiY3VycmVuY3lfY29kZSI7czozOiJVU0QiO3M6MTU6ImN1cnJlbmN5X3N5bWJvbCI7czoxOiIkIjtzOjE3OiJjdXJyZW5jeV9wb3NpdGlvbiI7czo0OiJsZWZ0IjtzOjEzOiJub19vZl9kZWNpbWFsIjtpOjI7czoxODoidGhvdXNhbmRfc2VwYXJhdG9yIjtzOjE6IiwiO3M6MTc6ImRlY2ltYWxfc2VwYXJhdG9yIjtzOjE6Ii4iO3M6MTM6ImV4Y2hhbmdlX3JhdGUiO047czo5OiJ1c2RfcHJpY2UiO047czoxNzoiaXNfY3J5cHRvY3VycmVuY3kiO3M6Mjoibm8iO31zOjExOiIAKgBvcmlnaW5hbCI7YToxMjp7czoyOiJpZCI7aToxO3M6MTM6InJlc3RhdXJhbnRfaWQiO2k6MTtzOjEzOiJjdXJyZW5jeV9uYW1lIjtzOjc6IkRvbGxhcnMiO3M6MTM6ImN1cnJlbmN5X2NvZGUiO3M6MzoiVVNEIjtzOjE1OiJjdXJyZW5jeV9zeW1ib2wiO3M6MToiJCI7czoxNzoiY3VycmVuY3lfcG9zaXRpb24iO3M6NDoibGVmdCI7czoxMzoibm9fb2ZfZGVjaW1hbCI7aToyO3M6MTg6InRob3VzYW5kX3NlcGFyYXRvciI7czoxOiIsIjtzOjE3OiJkZWNpbWFsX3NlcGFyYXRvciI7czoxOiIuIjtzOjEzOiJleGNoYW5nZV9yYXRlIjtOO3M6OToidXNkX3ByaWNlIjtOO3M6MTc6ImlzX2NyeXB0b2N1cnJlbmN5IjtzOjI6Im5vIjt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MDtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoyOiJpZCI7fXM6MTc6ImN1c3RvbWVySXBBZGRyZXNzIjtOO3M6MjQ6ImVzdGltYXRpb25CaWxsaW5nQWRkcmVzcyI7YTowOnt9czoxMzoiY29sbGVjdFRheElkcyI7YjowO3M6ODoiY291cG9uSWQiO047czoxNToicHJvbW90aW9uQ29kZUlkIjtOO3M6MTk6ImFsbG93UHJvbW90aW9uQ29kZXMiO2I6MDt9fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjA7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fXM6ODoiYnJhbmNoZXMiO086Mzk6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcQ29sbGVjdGlvbiI6Mjp7czo4OiIAKgBpdGVtcyI7YToyOntpOjA7TzoxNzoiQXBwXE1vZGVsc1xCcmFuY2giOjMzOntzOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjg6ImJyYW5jaGVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MjE6e3M6MjoiaWQiO2k6MTtzOjExOiJ1bmlxdWVfaGFzaCI7czoyMDoiYjMxMzgzYzVmYzRmMjNkMTc2ZmQiO3M6MTM6InJlc3RhdXJhbnRfaWQiO2k6MTtzOjQ6Im5hbWUiO3M6MTE6IkRhcGhuZXl0b3duIjtzOjE4OiJjbG9uZWRfYnJhbmNoX25hbWUiO047czoxNjoiY2xvbmVkX2JyYW5jaF9pZCI7TjtzOjEzOiJpc19tZW51X2Nsb25lIjtpOjA7czoyNDoiaXNfaXRlbV9jYXRlZ29yaWVzX2Nsb25lIjtpOjA7czoxOToiaXNfbWVudV9pdGVtc19jbG9uZSI7aTowO3M6MjM6ImlzX2l0ZW1fbW9kaWZpZXJzX2Nsb25lIjtpOjA7czoyOToiaXNfY2xvbmVfcmVzZXJ2YXRpb25fc2V0dGluZ3MiO2k6MDtzOjI2OiJpc19jbG9uZV9kZWxpdmVyeV9zZXR0aW5ncyI7aTowO3M6MjA6ImlzX2Nsb25lX2tvdF9zZXR0aW5nIjtpOjA7czoyNToiaXNfbW9kaWZpZXJzX2dyb3Vwc19jbG9uZSI7aTowO3M6NzoiYWRkcmVzcyI7czo1OToiNDE3IEZyaXRzY2ggU3RyZWV0cyBTdWl0ZSAwNjAKTGFrZSBTYXNoYXNpZGUsIERDIDc3NDkyLTYwMjYiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDg6Mjc6MjMiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDg6MzA6MjUiO3M6MzoibGF0IjtOO3M6MzoibG5nIjtOO3M6MTI6ImNvdW50X29yZGVycyI7aToyMjtzOjEyOiJ0b3RhbF9vcmRlcnMiO2k6LTE7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjIxOntzOjI6ImlkIjtpOjE7czoxMToidW5pcXVlX2hhc2giO3M6MjA6ImIzMTM4M2M1ZmM0ZjIzZDE3NmZkIjtzOjEzOiJyZXN0YXVyYW50X2lkIjtpOjE7czo0OiJuYW1lIjtzOjExOiJEYXBobmV5dG93biI7czoxODoiY2xvbmVkX2JyYW5jaF9uYW1lIjtOO3M6MTY6ImNsb25lZF9icmFuY2hfaWQiO047czoxMzoiaXNfbWVudV9jbG9uZSI7aTowO3M6MjQ6ImlzX2l0ZW1fY2F0ZWdvcmllc19jbG9uZSI7aTowO3M6MTk6ImlzX21lbnVfaXRlbXNfY2xvbmUiO2k6MDtzOjIzOiJpc19pdGVtX21vZGlmaWVyc19jbG9uZSI7aTowO3M6Mjk6ImlzX2Nsb25lX3Jlc2VydmF0aW9uX3NldHRpbmdzIjtpOjA7czoyNjoiaXNfY2xvbmVfZGVsaXZlcnlfc2V0dGluZ3MiO2k6MDtzOjIwOiJpc19jbG9uZV9rb3Rfc2V0dGluZyI7aTowO3M6MjU6ImlzX21vZGlmaWVyc19ncm91cHNfY2xvbmUiO2k6MDtzOjc6ImFkZHJlc3MiO3M6NTk6IjQxNyBGcml0c2NoIFN0cmVldHMgU3VpdGUgMDYwCkxha2UgU2FzaGFzaWRlLCBEQyA3NzQ5Mi02MDI2IjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA4OjI3OjIzIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA4OjMwOjI1IjtzOjM6ImxhdCI7TjtzOjM6ImxuZyI7TjtzOjEyOiJjb3VudF9vcmRlcnMiO2k6MjI7czoxMjoidG90YWxfb3JkZXJzIjtpOi0xO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YToyOntzOjM6ImxhdCI7czo1OiJmbG9hdCI7czozOiJsbmciO3M6NToiZmxvYXQiO31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MDp7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTo5OntpOjA7czo0OiJuYW1lIjtpOjE7czo3OiJhZGRyZXNzIjtpOjI7czo1OiJwaG9uZSI7aTozO3M6NToiZW1haWwiO2k6NDtzOjEzOiJyZXN0YXVyYW50X2lkIjtpOjU7czo5OiJpc19hY3RpdmUiO2k6NjtzOjExOiJ1bmlxdWVfaGFzaCI7aTo3O3M6MzoibGF0IjtpOjg7czozOiJsbmciO31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjI6ImlkIjt9fWk6MTtPOjE3OiJBcHBcTW9kZWxzXEJyYW5jaCI6MzM6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6ODoiYnJhbmNoZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToyMTp7czoyOiJpZCI7aToyO3M6MTE6InVuaXF1ZV9oYXNoIjtzOjIwOiIwNDg5ZTQxNmM5ZDc3ZWNmNjM5OCI7czoxMzoicmVzdGF1cmFudF9pZCI7aToxO3M6NDoibmFtZSI7czo5OiJQb3J0IFJldmEiO3M6MTg6ImNsb25lZF9icmFuY2hfbmFtZSI7TjtzOjE2OiJjbG9uZWRfYnJhbmNoX2lkIjtOO3M6MTM6ImlzX21lbnVfY2xvbmUiO2k6MDtzOjI0OiJpc19pdGVtX2NhdGVnb3JpZXNfY2xvbmUiO2k6MDtzOjE5OiJpc19tZW51X2l0ZW1zX2Nsb25lIjtpOjA7czoyMzoiaXNfaXRlbV9tb2RpZmllcnNfY2xvbmUiO2k6MDtzOjI5OiJpc19jbG9uZV9yZXNlcnZhdGlvbl9zZXR0aW5ncyI7aTowO3M6MjY6ImlzX2Nsb25lX2RlbGl2ZXJ5X3NldHRpbmdzIjtpOjA7czoyMDoiaXNfY2xvbmVfa290X3NldHRpbmciO2k6MDtzOjI1OiJpc19tb2RpZmllcnNfZ3JvdXBzX2Nsb25lIjtpOjA7czo3OiJhZGRyZXNzIjtzOjQ4OiI1MTc5MiBQb2xsaWNoIFNxdWFyZXMKTGFrZSBTaWdyaWQsIE1OIDU0MzkxLTkyMDgiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDg6Mjc6MjMiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDg6Mjc6MjQiO3M6MzoibGF0IjtOO3M6MzoibG5nIjtOO3M6MTI6ImNvdW50X29yZGVycyI7aTowO3M6MTI6InRvdGFsX29yZGVycyI7aTotMTt9czoxMToiACoAb3JpZ2luYWwiO2E6MjE6e3M6MjoiaWQiO2k6MjtzOjExOiJ1bmlxdWVfaGFzaCI7czoyMDoiMDQ4OWU0MTZjOWQ3N2VjZjYzOTgiO3M6MTM6InJlc3RhdXJhbnRfaWQiO2k6MTtzOjQ6Im5hbWUiO3M6OToiUG9ydCBSZXZhIjtzOjE4OiJjbG9uZWRfYnJhbmNoX25hbWUiO047czoxNjoiY2xvbmVkX2JyYW5jaF9pZCI7TjtzOjEzOiJpc19tZW51X2Nsb25lIjtpOjA7czoyNDoiaXNfaXRlbV9jYXRlZ29yaWVzX2Nsb25lIjtpOjA7czoxOToiaXNfbWVudV9pdGVtc19jbG9uZSI7aTowO3M6MjM6ImlzX2l0ZW1fbW9kaWZpZXJzX2Nsb25lIjtpOjA7czoyOToiaXNfY2xvbmVfcmVzZXJ2YXRpb25fc2V0dGluZ3MiO2k6MDtzOjI2OiJpc19jbG9uZV9kZWxpdmVyeV9zZXR0aW5ncyI7aTowO3M6MjA6ImlzX2Nsb25lX2tvdF9zZXR0aW5nIjtpOjA7czoyNToiaXNfbW9kaWZpZXJzX2dyb3Vwc19jbG9uZSI7aTowO3M6NzoiYWRkcmVzcyI7czo0ODoiNTE3OTIgUG9sbGljaCBTcXVhcmVzCkxha2UgU2lncmlkLCBNTiA1NDM5MS05MjA4IjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA4OjI3OjIzIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA4OjI3OjI0IjtzOjM6ImxhdCI7TjtzOjM6ImxuZyI7TjtzOjEyOiJjb3VudF9vcmRlcnMiO2k6MDtzOjEyOiJ0b3RhbF9vcmRlcnMiO2k6LTE7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjI6e3M6MzoibGF0IjtzOjU6ImZsb2F0IjtzOjM6ImxuZyI7czo1OiJmbG9hdCI7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjk6e2k6MDtzOjQ6Im5hbWUiO2k6MTtzOjc6ImFkZHJlc3MiO2k6MjtzOjU6InBob25lIjtpOjM7czo1OiJlbWFpbCI7aTo0O3M6MTM6InJlc3RhdXJhbnRfaWQiO2k6NTtzOjk6ImlzX2FjdGl2ZSI7aTo2O3M6MTE6InVuaXF1ZV9oYXNoIjtpOjc7czozOiJsYXQiO2k6ODtzOjM6ImxuZyI7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MjoiaWQiO319fXM6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDt9czoxNDoicmVjZWlwdFNldHRpbmciO086MjU6IkFwcFxNb2RlbHNcUmVjZWlwdFNldHRpbmciOjMzOntzOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjE2OiJyZWNlaXB0X3NldHRpbmdzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTc6e3M6MjoiaWQiO2k6MTtzOjEzOiJyZXN0YXVyYW50X2lkIjtpOjE7czoxODoic2hvd19jdXN0b21lcl9uYW1lIjtpOjA7czoyMToic2hvd19jdXN0b21lcl9hZGRyZXNzIjtpOjA7czoxOToic2hvd19jdXN0b21lcl9waG9uZSI7aTowO3M6MTc6InNob3dfdGFibGVfbnVtYmVyIjtpOjA7czoxNToicGF5bWVudF9xcl9jb2RlIjtOO3M6MjA6InNob3dfcGF5bWVudF9xcl9jb2RlIjtpOjA7czoxMToic2hvd193YWl0ZXIiO2k6MDtzOjE2OiJzaG93X3RvdGFsX2d1ZXN0IjtpOjA7czoyMDoic2hvd19yZXN0YXVyYW50X2xvZ28iO2k6MDtzOjg6InNob3dfdGF4IjtpOjA7czoyMDoic2hvd19wYXltZW50X2RldGFpbHMiO2k6MTtzOjE5OiJzaG93X3BheW1lbnRfc3RhdHVzIjtpOjA7czoxNToic2hvd19vcmRlcl90eXBlIjtpOjA7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMyI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMyI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjE3OntzOjI6ImlkIjtpOjE7czoxMzoicmVzdGF1cmFudF9pZCI7aToxO3M6MTg6InNob3dfY3VzdG9tZXJfbmFtZSI7aTowO3M6MjE6InNob3dfY3VzdG9tZXJfYWRkcmVzcyI7aTowO3M6MTk6InNob3dfY3VzdG9tZXJfcGhvbmUiO2k6MDtzOjE3OiJzaG93X3RhYmxlX251bWJlciI7aTowO3M6MTU6InBheW1lbnRf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RGFwaG5leXRvd24iO3M6MTg6ImNsb25lZF9icmFuY2hfbmFtZSI7TjtzOjE2OiJjbG9uZWRfYnJhbmNoX2lkIjtOO3M6MTM6ImlzX21lbnVfY2xvbmUiO2k6MDtzOjI0OiJpc19pdGVtX2NhdGVnb3JpZXNfY2xvbmUiO2k6MDtzOjE5OiJpc19tZW51X2l0ZW1zX2Nsb25lIjtpOjA7czoyMzoiaXNfaXRlbV9tb2RpZmllcnNfY2xvbmUiO2k6MDtzOjI5OiJpc19jbG9uZV9yZXNlcnZhdGlvbl9zZXR0aW5ncyI7aTowO3M6MjY6ImlzX2Nsb25lX2RlbGl2ZXJ5X3NldHRpbmdzIjtpOjA7czoyMDoiaXNfY2xvbmVfa290X3NldHRpbmciO2k6MDtzOjI1OiJpc19tb2RpZmllcnNfZ3JvdXBzX2Nsb25lIjtpOjA7czo3OiJhZGRyZXNzIjtzOjU5OiI0MTcgRnJpdHNjaCBTdHJlZXRzIFN1aXRlIDA2MApMYWtlIFNhc2hhc2lkZSwgREMgNzc0OTItNjAyNiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMyI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODozMDoyNSI7czozOiJsYXQiO047czozOiJsbmciO047czoxMjoiY291bnRfb3JkZXJzIjtpOjIyO3M6MTI6InRvdGFsX29yZGVycyI7aTotMTt9czoxMToiACoAb3JpZ2luYWwiO2E6MjE6e3M6MjoiaWQiO2k6MTtzOjExOiJ1bmlxdWVfaGFzaCI7czoyMDoiYjMxMzgzYzVmYzRmMjNkMTc2ZmQiO3M6MTM6InJlc3RhdXJhbnRfaWQiO2k6MTtzOjQ6Im5hbWUiO3M6MTE6IkRhcGhuZXl0b3duIjtzOjE4OiJjbG9uZWRfYnJhbmNoX25hbWUiO047czoxNjoiY2xvbmVkX2JyYW5jaF9pZCI7TjtzOjEzOiJpc19tZW51X2Nsb25lIjtpOjA7czoyNDoiaXNfaXRlbV9jYXRlZ29yaWVzX2Nsb25lIjtpOjA7czoxOToiaXNfbWVudV9pdGVtc19jbG9uZSI7aTowO3M6MjM6ImlzX2l0ZW1fbW9kaWZpZXJzX2Ns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YWl0ZXJfcmVxdWVzdCI7aTowO3M6MTE6ImN1cnJlbmN5X2lkIjtpOjE7czoxMjoibGljZW5zZV90eXBlIjtzOjQ6InBhaWQiO3M6OToiaXNfYWN0aXZlIjtpOjE7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMyI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwOTo0OTo0OCI7czoyMzoiY3VzdG9tZXJfbG9naW5fcmVxdWlyZWQiO2k6MDtzOjg6ImFib3V0X3VzIjtzOjEzMDQ6IjxwIGNsYXNzPSJ0ZXh0LWxnIHRleHQtZ3JheS02MDAgbWItNiI+CiAgICAgICAgICBXZWxjb21lIHRvIG91ciByZXN0YXVyYW50LCB3aGVyZSBncmVhdCBmb29kIGFuZCBnb29kIHZpYmVzIGNvbWUgdG9nZXRoZXIhIFdlJ3JlIGEgbG9jYWwsIGZhbWlseS1vd25lZCBzcG90IHRoYXQgbG92ZXMgYnJpbmdpbmcgcGVvcGxlIHRvZ2V0aGVyIG92ZXIgZGVsaWNpb3VzIG1lYWxzIGFuZCB1bmZvcmdldHRhYmxlIG1vbWVudHMuIFdoZXRoZXIgeW91J3JlIGhlcmUgZm9yIGEgcXVpY2sgYml0ZSwgYSBmYW1pbHkgZGlubmVyLCBvciBhIGNlbGVicmF0aW9uLCB3ZSdyZSBhbGwgYWJvdXQgbWFraW5nIHlvdXIgdGltZSB3aXRoIHVzIHNwZWNpYWwuCiAgICAgICAgPC9wPgogICAgICAgIDxwIGNsYXNzPSJ0ZXh0LWxnIHRleHQtZ3JheS02MDAgbWItNiI+CiAgICAgICAgICBPdXIgbWVudSBpcyBwYWNrZWQgd2l0aCBkaXNoZXMgbWFkZSBmcm9tIGZyZXNoLCBxdWFsaXR5IGluZ3JlZGllbnRzIGJlY2F1c2Ugd2UgYmVsaWV2ZSBmb29kIHNob3VsZCB0YXN0ZSBhcwogICAgICAgICAgZ29vZCBhcyBpdCBtYWtlcyB5b3UgZmVlbC4gRnJvbSBvdXIgc2lnbmF0dXJlIGRpc2hlcyB0byBzZWFzb25hbCBzcGVjaWFscywgdGhlcmUncyBhbHdheXMgc29tZXRoaW5nIHRvIGV4Y2l0ZQogICAgICAgICAgeW91ciB0YXN0ZSBidWRzLgogICAgICAgIDwvcD4KICAgICAgICA8cCBjbGFzcz0idGV4dC1sZyB0ZXh0LWdyYXktNjAwIG1iLTYiPgogICAgICAgICAgQnV0IHdlJ3JlIG5vdCBqdXN0IGFib3V0IHRoZSBmb29k4oCUd2UncmUgYWJvdXQgY29tbXVuaXR5LiBXZSBsb3ZlIHNlZWluZyBmYW1pbGlhciBmYWNlcyBhbmQgd2VsY29taW5nIG5ldyBvbmVzLgogICAgICAgICAgT3VyIHRlYW0gaXMgYSBmdW4sIGZyaWVuZGx5IGJ1bmNoIGRlZGljYXRlZCB0byBzZXJ2aW5nIHlvdSB3aXRoIGEgc21pbGUgYW5kIG1ha2luZyBzdXJlIGV2ZXJ5IHZpc2l0IGZlZWxzIGxpa2UKICAgICAgICAgIGNvbWluZyBob21lLgogICAgICAgIDwvcD4KICAgICAgICA8cCBjbGFzcz0idGV4dC1sZyB0ZXh0LWdyYXktNjAwIj4KICAgICAgICAgIFNvLCBjb21lIG9uIGluLCBncmFiIGEgc2VhdCwgYW5kIGxldCB1cyB0YWtlIGNhcmUgb2YgdGhlIHJlc3QuIFdlIGNhbid0IHdhaXQgdG8gc2hhcmUgb3VyIGxvdmUgb2YgZm9vZCB3aXRoCiAgICAgICAgICB5b3UhCiAgICAgICAgPC9wPgogICAgICAgIDxwIGNsYXNzPSJ0ZXh0LWxnIHRleHQtZ3JheS04MDAgZm9udC1zZW1pYm9sZCBtdC02Ij5TZWUgeW91IHNvb24hIPCfjb3vuI/inKg8L3A+IjtzOjMwOiJhbGxvd19jdXN0b21lcl9kZWxpdmVyeV9vcmRlcnMiO2k6MTtzOjI4OiJhbGxvd19jdXN0b21lcl9waWNrdXBfb3JkZXJzIjtpOjE7czoxNzoicGlja3VwX2RheXNfcmFuZ2UiO2k6NztzOjIxOiJhbGxvd19jdXN0b21lcl9vcmRlcnMiO2k6MTtzOjIwOiJhbGxvd19kaW5lX2luX29yZGVycyI7aToxO3M6ODoic2hvd192ZWciO2k6MTtzOjEwOiJzaG93X2hhbGFsIjtpOjA7czoxMDoicGFja2FnZV9pZCI7aTo1O3M6MTI6InBhY2thZ2VfdHlwZSI7czo1OiJ0cmlhbCI7czo2OiJzdGF0dXMiO3M6NjoiYWN0aXZlIjtzOjE3OiJsaWNlbnNlX2V4cGlyZV9vbiI7czoxOToiMjAyNS0xMi0zMCAwODoyNzoyMyI7czo5OiJjb3VudF9zbXMiO2k6MDtzOjk6InRvdGFsX3NtcyI7aTotMTtzOjEzOiJ0cmlhbF9lbmRzX2F0IjtzOjE5OiIyMDI1LTEyLTMwIDA4OjI3OjIzIjtzOjE4OiJsaWNlbnNlX3VwZGF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDg6Mjc6MjMiO3M6MjM6InN1YnNjcmlwdGlvbl91cGRhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA4OjI3OjIzIjtzOjk6InN0cmlwZV9pZCI7TjtzOjc6InBtX3R5cGUiO047czoxMjoicG1fbGFzdF9mb3VyIjtOO3M6MjU6ImlzX3dhaXRlcl9yZXF1ZXN0X2VuYWJsZWQiO2k6MTtzOjMyOiJkZWZhdWx0X3RhYmxlX3Jlc2VydmF0aW9uX3N0YXR1cyI7czo5OiJDb25maXJtZWQiO3M6MjA6ImRpc2FibGVfc2xvdF9taW51dGVzIjtpOjMwO3M6MTU6ImFwcHJvdmFsX3N0YXR1cyI7czo4OiJBcHByb3ZlZCI7czoxNjoicmVqZWN0aW9uX3JlYXNvbiI7TjtzOjEzOiJmYWNlYm9va19saW5rIjtzOjI1OiJodHRwczovL3d3dy5mYWNlYm9vay5jb20vIjtzOjE0OiJpbnN0YWdyYW1fbGluayI7czoyNjoiaHR0cHM6Ly93d3cuaW5zdGFncmFtLmNvbS8iO3M6MTI6InR3aXR0ZXJfbGluayI7czoyNDoiaHR0cHM6Ly93d3cudHdpdHRlci5jb20vIjtzOjk6InllbHBfbGluayI7TjtzOjE0OiJ0YWJsZV9yZXF1aXJlZCI7aTowO3M6MTQ6InNob3dfbG9nb190ZXh0IjtpOjE7czoxMjoibWV0YV9rZXl3b3JkIjtOO3M6MTY6Im1ldGFfZGVzY3JpcHRpb24iO047czozNDoidXBsb2FkX2Zhdl9pY29uX2FuZHJvaWRfY2hyb21lXzE5MiI7TjtzOjM0OiJ1cGxvYWRfZmF2X2ljb25fYW5kcm9pZF9jaHJvbWVfNTEyIjtOO3M6MzI6InVwbG9hZF9mYXZfaWNvbl9hcHBsZV90b3VjaF9pY29uIjtOO3M6MTc6InVwbG9hZF9mYXZpY29uXzE2IjtOO3M6MTc6InVwbG9hZF9mYXZpY29uXzMyIjtOO3M6NzoiZmF2aWNvbiI7TjtzOjM2OiJpc193YWl0ZXJfcmVxdWVzdF9lbmFibGVkX29uX2Rlc2t0b3AiO2k6MTtzOjM1OiJpc193YWl0ZXJfcmVxdWVzdF9lbmFibGVkX29uX21vYmlsZSI7aToxO3M6MzY6ImlzX3dhaXRlcl9yZXF1ZXN0X2VuYWJsZWRfb3Blbl9ieV9xciI7aTowO3M6MTE6IndlYm1hbmlmZXN0IjtOO3M6MTU6ImVuYWJsZV90aXBfc2hvcCI7aToxO3M6MTQ6ImVuYWJsZV90aXBfcG9zIjtpOjE7czoyNToiaXNfcHdhX2luc3RhbGxfYWxlcnRfc2hvdyI7aTowO3M6MTk6ImF1dG9fY29uZmlybV9vcmRlcnMiO2k6MDtzOjI5OiJyZXN0cmljdF9xcl9vcmRlcl9ieV9sb2NhdGlvbiI7aTowO3M6MjI6InFyX29yZGVyX3JhZGl1c19tZXRlcnMiO047czoyMzoic2hvd19vcmRlcl90eXBlX29wdGlvbnMiO2k6MTtzOjI0OiJkaXNhYmxlX29yZGVyX3R5cGVfcG9wdXAiO2k6MDtzOjIxOiJkZWZhdWx0X29yZGVyX3R5cGVfaWQiO047czoyNzoiaGlkZV9tZW51X2l0ZW1faW1hZ2Vfb25fcG9zIjtpOjA7czozNzoiaGlkZV9tZW51X2l0ZW1faW1hZ2Vfb25fY3VzdG9tZXJfc2l0ZSI7aTowO3M6ODoidGF4X21vZGUiO3M6NToib3JkZXIiO3M6MTM6InRheF9pbmNsdXNpdmUiO2k6MDtzOjIyOiJjdXN0b21lcl9zaXRlX2xhbmd1YWdlIjtzOjI6ImVuIjtzOjI0OiJlbmFibGVfYWRtaW5fcmVzZXJ2YXRpb24iO2k6MTtzOjI3OiJlbmFibGVfY3VzdG9tZXJfcmVzZXJ2YXRpb24iO2k6MTtzOjE4OiJtaW5pbXVtX3BhcnR5X3NpemUiO2k6MTtzOjI2OiJ0YWJsZV9sb2NrX3RpbWVvdXRfbWludXRlcyI7aToxMDt9czoxMToiACoAb3JpZ2luYWwiO2E6ODM6e3M6MjoiaWQiO2k6MTtzOjEwOiJzdWJfZG9tYWluIjtzOjIwOiJkZW1vLnRhYmxldHJhY2sudGVzdCI7czo0OiJuYW1lIjtzOjE1OiJEZW1vIFJlc3RhdXJhbnQiO3M6NDoiaGFzaCI7czoxNToiZGVtby1yZXN0YXVyYW50IjtzOjc6ImFkZHJlc3MiO3M6NTE6IjQ1MDgyIE1hdGlsZGUgRGl2aWRlIEFwdC4gODM5Ck1hZGlzeW5zaWRlLCBBWiAyMzg2MyI7czoxMjoicGhvbmVfbnVtYmVyIjtzOjEyOiIrMTczNzg2NDE0MDMiO3M6MTA6InBob25lX2NvZGUiO047czo1OiJlbWFpbCI7czoyNzoiZGVtby5yZXN0YXVyYW50QGV4YW1wbGUuY29tIjtzOjg6InRpbWV6b25lIjtzOjE2OiJBbWVyaWNhL05ld19Zb3JrIjtzOjk6InRoZW1lX2hleCI7czo3OiIjQTc4QkZBIjtzOjk6InRoZW1lX3JnYiI7czoxMzoiMTY3LCAxMzksIDI1MCI7czo0OiJsb2dvIjtOO3M6MTA6ImNvdW50cnlfaWQiO2k6MjM2O3M6MTU6ImhpZGVfbmV3X29yZGVycyI7aTowO3M6MjE6ImhpZGVfbmV3X3Jlc2VydmF0aW9ucyI7aTowO3M6MjM6ImhpZGVfbmV3X3dhaXRlcl9yZXF1ZXN0IjtpOjA7czoxMToiY3VycmVuY3lfaWQiO2k6MTtzOjEyOiJsaWNlbnNlX3R5cGUiO3M6NDoicGFpZCI7czo5OiJpc19hY3RpdmUiO2k6MTtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA4OjI3OjIzIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA5OjQ5OjQ4IjtzOjIzOiJjdXN0b21lcl9sb2dpbl9yZXF1aXJlZCI7aTowO3M6ODoiYWJvdXRfdXMiO3M6MTMwNDoiPHAgY2xhc3M9InRleHQtbGcgdGV4dC1ncmF5LTYwMCBtYi02Ij4KICAgICAgICAgIFdlbGNvbWUgdG8gb3VyIHJlc3RhdXJhbnQsIHdoZXJlIGdyZWF0IGZvb2QgYW5kIGdvb2QgdmliZXMgY29tZSB0b2dldGhlciEgV2UncmUgYSBsb2NhbCwgZmFtaWx5LW93bmVkIHNwb3QgdGhhdCBsb3ZlcyBicmluZ2luZyBwZW9wbGUgdG9nZXRoZXIgb3ZlciBkZWxpY2lvdXMgbWVhbHMgYW5kIHVuZm9yZ2V0dGFibGUgbW9tZW50cy4gV2hldGhlciB5b3UncmUgaGVyZSBmb3IgYSBxdWljayBiaXRlLCBhIGZhbWlseSBkaW5uZXIsIG9yIGEgY2VsZWJyYXRpb24sIHdlJ3JlIGFsbCBhYm91dCBtYWtpbmcgeW91ciB0aW1lIHdpdGggdXMgc3BlY2lhbC4KICAgICAgICA8L3A+CiAgICAgICAgPHAgY2xhc3M9InRleHQtbGcgdGV4dC1ncmF5LTYwMCBtYi02Ij4KICAgICAgICAgIE91ciBtZW51IGlzIHBhY2tlZCB3aXRoIGRpc2hlcyBtYWRlIGZyb20gZnJlc2gsIHF1YWxpdHkgaW5ncmVkaWVudHMgYmVjYXVzZSB3ZSBiZWxpZXZlIGZvb2Qgc2hvdWxkIHRhc3RlIGFzCiAgICAgICAgICBnb29kIGFzIGl0IG1ha2VzIHlvdSBmZWVsLiBGcm9tIG91ciBzaWduYXR1cmUgZGlzaGVzIHRvIHNlYXNvbmFsIHNwZWNpYWxzLCB0aGVyZSdzIGFsd2F5cyBzb21ldGhpbmcgdG8gZXhjaXRlCiAgICAgICAgICB5b3VyIHRhc3RlIGJ1ZHMuCiAgICAgICAgPC9wPgogICAgICAgIDxwIGNsYXNzPSJ0ZXh0LWxnIHRleHQtZ3JheS02MDAgbWItNiI+CiAgICAgICAgICBCdXQgd2UncmUgbm90IGp1c3QgYWJvdXQgdGhlIGZvb2TigJR3ZSdyZSBhYm91dCBjb21tdW5pdHkuIFdlIGxvdmUgc2VlaW5nIGZhbWlsaWFyIGZhY2VzIGFuZCB3ZWxjb21pbmcgbmV3IG9uZXMuCiAgICAgICAgICBPdXIgdGVhbSBpcyBhIGZ1biwgZnJpZW5kbHkgYnVuY2ggZGVkaWNhdGVkIHRvIHNlcnZpbmcgeW91IHdpdGggYSBzbWlsZSBhbmQgbWFraW5nIHN1cmUgZXZlcnkgdmlzaXQgZmVlbHMgbGlrZQogICAgICAgICAgY29taW5nIGhvbWUuCiAgICAgICAgPC9wPgogICAgICAgIDxwIGNsYXNzPSJ0ZXh0LWxnIHRleHQtZ3JheS02MDAiPgogICAgICAgICAgU28sIGNvbWUgb24gaW4sIGdyYWIgYSBzZWF0LCBhbmQgbGV0IHVzIHRha2UgY2FyZSBvZiB0aGUgcmVzdC4gV2UgY2FuJ3Qgd2FpdCB0byBzaGFyZSBvdXIgbG92ZSBvZiBmb29kIHdpdGgKICAgICAgICAgIHlvdSEKICAgICAgICA8L3A+CiAgICAgICAgPHAgY2xhc3M9InRleHQtbGcgdGV4dC1ncmF5LTgwMCBmb250LXNlbWlib2xkIG10LTYiPlNlZSB5b3Ugc29vbiEg8J+Nve+4j+KcqDwvcD4iO3M6MzA6ImFsbG93X2N1c3RvbWVyX2RlbGl2ZXJ5X29yZGVycyI7aToxO3M6Mjg6ImFsbG93X2N1c3RvbWVyX3BpY2t1cF9vcmRlcnMiO2k6MTtzOjE3OiJwaWNrdXBfZGF5c19yYW5nZSI7aTo3O3M6MjE6ImFsbG93X2N1c3RvbWVyX29yZGVycyI7aToxO3M6MjA6ImFsbG93X2RpbmVfaW5fb3JkZXJzIjtpOjE7czo4OiJzaG93X3ZlZyI7aToxO3M6MTA6InNob3dfaGFsYWwiO2k6MDtzOjEwOiJwYWNrYWdlX2lkIjtpOjU7czoxMjoicGFja2FnZV90eXBlIjtzOjU6InRyaWFsIjtzOjY6InN0YXR1cyI7czo2OiJhY3RpdmUiO3M6MTc6ImxpY2Vuc2VfZXhwaXJlX29uIjtzOjE5OiIyMDI1LTEyLTMwIDA4OjI3OjIzIjtzOjk6ImNvdW50X3NtcyI7aTowO3M6OToidG90YWxfc21zIjtpOi0xO3M6MTM6InRyaWFsX2VuZHNfYXQiO3M6MTk6IjIwMjUtMTItMzAgMDg6Mjc6MjMiO3M6MTg6ImxpY2Vuc2VfdXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMyI7czoyMzoic3Vic2NyaXB0aW9uX3VwZGF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDg6Mjc6MjMiO3M6OToic3RyaXBlX2lkIjtOO3M6NzoicG1fdHlwZSI7TjtzOjEyOiJwbV9sYXN0X2ZvdXIiO047czoyNToiaXNfd2FpdGVyX3JlcXVlc3RfZW5hYmxlZCI7aToxO3M6MzI6ImRlZmF1bHRfdGFibGVfcmVzZXJ2YXRpb25fc3RhdHVzIjtzOjk6IkNvbmZpcm1lZCI7czoyMDoiZGlzYWJsZV9zbG90X21pbnV0ZXMiO2k6MzA7czoxNToiYXBwcm92YWxfc3RhdHVzIjtzOjg6IkFwcHJvdmVkIjtzOjE2OiJyZWplY3Rpb25fcmVhc29uIjtOO3M6MTM6ImZhY2Vib29rX2xpbmsiO3M6MjU6Imh0dHBzOi8vd3d3LmZhY2Vib29rLmNvbS8iO3M6MTQ6Imluc3RhZ3JhbV9saW5rIjtzOjI2OiJodHRwczovL3d3dy5pbnN0YWdyYW0uY29tLyI7czoxMjoidHdpdHRlcl9saW5rIjtzOjI0OiJodHRwczovL3d3dy50d2l0dGVyLmNvbS8iO3M6OToieWVscF9saW5rIjtOO3M6MTQ6InRhYmxlX3JlcXVpcmVkIjtpOjA7czoxNDoic2hvd19sb2dvX3RleHQiO2k6MTtzOjEyOiJtZXRhX2tleXdvcmQiO047czoxNjoibWV0YV9kZXNjcmlwdGlvbiI7TjtzOjM0OiJ1cGxvYWRfZmF2X2ljb25fYW5kcm9pZF9jaHJvbWVfMTkyIjtOO3M6MzQ6InVwbG9hZF9mYXZfaWNvbl9hbmRyb2lkX2Nocm9tZV81MTIiO047czozMjoidXBsb2FkX2Zhdl9pY29uX2FwcGxlX3RvdWNoX2ljb24iO047czoxNzoidXBsb2FkX2Zhdmljb25fMTYiO047czoxNzoidXBsb2FkX2Zhdmljb25fMzIiO047czo3OiJmYXZpY29uIjtOO3M6MzY6ImlzX3dhaXRlcl9yZXF1ZXN0X2VuYWJsZWRfb25fZGVza3RvcCI7aToxO3M6MzU6ImlzX3dhaXRlcl9yZXF1ZXN0X2VuYWJsZWRfb25fbW9iaWxlIjtpOjE7czozNjoiaXNfd2FpdGVyX3JlcXVlc3RfZW5hYmxlZF9vcGVuX2J5X3FyIjtpOjA7czoxMToid2VibWFuaWZlc3QiO047czoxNToiZW5hYmxlX3RpcF9zaG9wIjtpOjE7czoxNDoiZW5hYmxlX3RpcF9wb3MiO2k6MTtzOjI1OiJpc19wd2FfaW5zdGFsbF9hbGVydF9zaG93IjtpOjA7czoxOToiYXV0b19jb25maXJtX29yZGVycyI7aTowO3M6Mjk6InJlc3RyaWN0X3FyX29yZGVyX2J5X2xvY2F0aW9uIjtpOjA7czoyMjoicXJfb3JkZXJfcmFkaXVzX21ldGVycyI7TjtzOjIzOiJzaG93X29yZGVyX3R5cGVfb3B0aW9ucyI7aToxO3M6MjQ6ImRpc2FibGVfb3JkZXJfdHlwZV9wb3B1cCI7aTowO3M6MjE6ImRlZmF1bHRfb3JkZXJfdHlwZV9pZCI7TjtzOjI3OiJoaWRlX21lbnVfaXRlbV9pbWFnZV9vbl9wb3MiO2k6MDtzOjM3OiJoaWRlX21lbnVfaXRlbV9pbWFnZV9vbl9jdXN0b21lcl9zaXRlIjtpOjA7czo4OiJ0YXhfbW9kZSI7czo1OiJvcmRlciI7czoxMzoidGF4X2luY2x1c2l2ZSI7aTowO3M6MjI6ImN1c3RvbWVyX3NpdGVfbGFuZ3VhZ2UiO3M6MjoiZW4iO3M6MjQ6ImVuYWJsZV9hZG1pbl9yZXNlcnZhdGlvbiI7aToxO3M6Mjc6ImVuYWJsZV9jdXN0b21lcl9yZXNlcnZhdGlvbiI7aToxO3M6MTg6Im1pbmltdW1fcGFydHlfc2l6ZSI7aToxO3M6MjY6InRhYmxlX2xvY2tfdGltZW91dF9taW51dGVzIjtpOjEwO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YToxMTp7czoxNzoibGljZW5zZV9leHBpcmVfb24iO3M6ODoiZGF0ZXRpbWUiO3M6MTU6InRyaWFsX2V4cGlyZV9vbiI7czo4OiJkYXRldGltZSI7czoxODoibGljZW5zZV91cGRhdGVkX2F0IjtzOjg6ImRhdGV0aW1lIjtzOjIzOiJzdWJzY3JpcHRpb25fdXBkYXRlZF9hdCI7czo4OiJkYXRldGltZSI7czoxMDoiY3JlYXRlZF9hdCI7czo4OiJkYXRldGltZSI7czoxMDoidXBkYXRlZF9hdCI7czo4OiJkYXRldGltZSI7czoyMzoiY3VzdG9tX2RlbGl2ZXJ5X29wdGlvbnMiO3M6NToiYXJyYXkiO3M6OToiaXNfYWN0aXZlIjtzOjc6ImJvb2xlYW4iO3M6MjQ6ImVuYWJsZV9hZG1pbl9yZXNlcnZhdGlvbiI7czo3OiJib29sZWFuIjtzOjI3OiJlbmFibGVfY3VzdG9tZXJfcmVzZXJ2YXRpb24iO3M6NzoiYm9vbGVhbiI7czoyOToicmVzdHJpY3RfcXJfb3JkZXJfYnlfbG9jYXRpb24iO3M6NzoiYm9vbGVhbiI7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YToxOntpOjA7czo4OiJsb2dvX3VybCI7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MDp7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoyOiJpZCI7fXM6MTc6ImN1c3RvbWVySXBBZGRyZXNzIjtOO3M6MjQ6ImVzdGltYXRpb25CaWxsaW5nQWRkcmVzcyI7YTowOnt9czoxMzoiY29sbGVjdFRheElkcyI7YjowO3M6ODoiY291cG9uSWQiO047czoxNToicHJvbW90aW9uQ29kZUlkIjtOO3M6MTk6ImFsbG93UHJvbW90aW9uQ29kZXMiO2I6MDt9fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjA7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fXM6ODoiY3VycmVuY3kiO3M6MToiJCI7czo1OiJpc1J0bCI7YjowO3M6MTY6Imxhc3Rfb3JkZXJfY291bnQiO2k6MDtzOjE3OiJ0b2RheV9vcmRlcl9jb3VudCI7aTowO3M6Mjg6ImFjdGl2ZV93YWl0ZXJfcmVxdWVzdHNfY291bnQiO2k6MDtzOjg6ImJyYW5jaGVzIjtyOjM1NDc7czoyMzoiY3VycmVuY3lfZm9ybWF0X3NldHRpbmciO3I6MzIxMDt9',1764700668),('i90ep0ZK3dJD1qba1QF0WA5ZKijbqUEKnS1McXV2',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','YToyOntzOjY6Il90b2tlbiI7czo0MDoiQTFYaGQ2empVZ1N1MnVWR3UwWGdXQ2JqMzBYemtVNVlQdzMxYkF5WCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1764692949),('lUi471VGVEftF5cOXtsOGae4SusbPOu5d86msccm',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','YToxNDp7czo2OiJfdG9rZW4iO3M6NDA6IkowQWpyQVNVR1gwd3BQZUU1WUtpRFI5MnV2d2lUYU1KMkNuUGp4a0wiO3M6MjA6ImNoZWNrX21pZ3JhdGVfc3RhdHVzIjtzOjQ6Ikdvb2QiO3M6MTU6ImN1c3RvbWVyX2lzX3J0bCI7aTowO3M6MzE6Imdsb2JhbF9jdXJyZW5jeV9mb3JtYXRfc2V0dGluZzEiO086MjU6IkFwcFxNb2RlbHNcR2xvYmFsQ3VycmVuY3kiOjM0OntzOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtzOjE3OiJnbG9iYWxfY3VycmVuY2llcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjE1OntzOjI6ImlkIjtpOjE7czoxMzoiY3VycmVuY3lfbmFtZSI7czo3OiJEb2xsYXJzIjtzOjE1OiJjdXJyZW5jeV9zeW1ib2wiO3M6MToiJCI7czoxMzoiY3VycmVuY3lfY29kZSI7czozOiJVU0QiO3M6MTM6ImV4Y2hhbmdlX3JhdGUiO047czo5OiJ1c2RfcHJpY2UiO047czoxNzoiaXNfY3J5cHRvY3VycmVuY3kiO3M6Mjoibm8iO3M6MTc6ImN1cnJlbmN5X3Bvc2l0aW9uIjtzOjQ6ImxlZnQiO3M6MTM6Im5vX29mX2RlY2ltYWwiO2k6MjtzOjE4OiJ0aG91c2FuZF9zZXBhcmF0b3IiO3M6MToiLCI7czoxNzoiZGVjaW1hbF9zZXBhcmF0b3IiO3M6MToiLiI7czo2OiJzdGF0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O2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToyNDp7czoyOiJpZCI7aToxO3M6MTM6InJlc3RhdXJhbnRfaWQiO047czo5OiJicmFuY2hfaWQiO047czo0OiJuYW1lIjtzOjExOiJFbW1hIEhvbGRlbiI7czo1OiJlbWFpbCI7czoyMjoic3VwZXJhZG1pbkBleGFtcGxlLmNvbSI7czoxMjoicGhvbmVfbnVtYmVyIjtOO3M6MTA6InBob25lX2NvZGUiO047czoyNjoidGVybXNfYW5kX3ByaXZhY3lfYWNjZXB0ZWQiO2k6MDtzOjI1OiJtYXJrZXRpbmdfZW1haWxzX2FjY2VwdGVkIjtpOjA7czoxNzoiZW1haWxfdmVyaWZpZWRfYXQiO047czo4OiJwYXNzd29yZCI7czo2MDoiJDJ5JDEyJElhdS5ycXJOS1hFdmNWNzExZXNqSS5GU0Y0UTlEUENyemlQUnBzQjY3MC9zU0ZSS2dEdDFHIjtzOjE3OiJ0d29fZmFjdG9yX3NlY3JldCI7TjtzOjI1OiJ0d29fZmFjdG9yX3JlY292ZXJ5X2NvZGVzIjtOO3M6MjM6InR3b19mYWN0b3JfY29uZmlybWVkX2F0IjtOO3M6MTQ6InJlbWVtYmVyX3Rva2VuIjtOO3M6MTU6ImN1cnJlbnRfdGVhbV9pZCI7TjtzOjE4OiJwcm9maWxlX3Bob3RvX3BhdGgiO047czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMyI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyMyI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToic3RyaXBlX2lkIjtOO3M6NzoicG1fdHlwZSI7TjtzOjEyOiJwbV9sYXN0X2ZvdXIiO047czoxMzoidHJpYWxfZW5kc19hdCI7Tjt9czoxMToiACoAb3JpZ2luYWwiO2E6MjQ6e3M6MjoiaWQiO2k6MTtzOjEzOiJyZXN0YXVyYW50X2lkIjtOO3M6OToiYnJhbmNoX2lkIjtOO3M6NDoibmFtZSI7czoxMToiRW1tYSBIb2xkZW4iO3M6NToiZW1haWwiO3M6MjI6InN1cGVyYWRtaW5AZXhhbXBsZS5jb20iO3M6MTI6InBob25lX251bWJlciI7TjtzOjEwOiJwaG9uZV9jb2RlIjtOO3M6MjY6InRlcm1zX2FuZF9wcml2YWN5X2FjY2VwdGVkIjtpOjA7czoyNToibWFya2V0aW5nX2VtYWlsc19hY2NlcHRlZCI7aTowO3M6MTc6ImVtYWlsX3ZlcmlmaWVkX2F0IjtOO3M6ODoicGFzc3dvcmQiO3M6NjA6IiQyeSQxMiRJYXUucnFyTktYRXZjVjcxMWVzakkuRlNGNFE5RFBDcnppUFJwc0I2NzAvc1NGUktnRHQxRyI7czoxNzoidHdvX2ZhY3Rvcl9zZWNyZXQiO047czoyNToidHdvX2ZhY3Rvcl9yZWNvdmVyeV9jb2RlcyI7TjtzOjIzOiJ0d29fZmFjdG9yX2NvbmZpcm1lZF9hdCI7TjtzOjE0OiJyZW1lbWJlcl90b2tlbiI7TjtzOjE1OiJjdXJyZW50X3RlYW1faWQiO047czoxODoicHJvZmlsZV9waG90b19wYXRoIjtOO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDg6Mjc6MjMiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjUtMTEtMzAgMDg6Mjc6MjMiO3M6NjoibG9jYWxlIjtzOjI6ImVuIjtzOjk6InN0cmlwZV9pZCI7TjtzOjc6InBtX3R5cGUiO047czoxMjoicG1fbGFzdF9mb3VyIjtOO3M6MTM6InRyaWFsX2VuZHNfYXQiO047fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjY6e3M6MTc6ImVtYWlsX3ZlcmlmaWVkX2F0IjtzOjg6ImRhdGV0aW1lIjtzOjg6InBhc3N3b3JkIjtzOjY6Imhhc2hlZCI7czoxMzoicmVzdGF1cmFudF9pZCI7czo3OiJpbnRlZ2VyIjtzOjk6ImJyYW5jaF9pZCI7czo3OiJpbnRlZ2VyIjtzOjI2OiJ0ZXJtc19hbmRfcHJpdmFjeV9hY2NlcHRlZCI7czo3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b25lX251bWJlciI7aTo3O3M6MTA6InBob25lX2NvZGUiO2k6ODtzOjI2OiJ0ZXJtc19hbmRfcHJpdmFjeV9hY2NlcHRlZCI7aTo5O3M6MjU6Im1hcmtldGluZ19lbWFpbHNfYWNjZXB0ZWQiO31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO31zOjE5OiIAKgBhdXRoUGFzc3dvcmROYW1lIjtzOjg6InBhc3N3b3JkIjtzOjIwOiIAKgByZW1lbWJlclRva2VuTmFtZSI7czoxNDoicmVtZW1iZXJfdG9rZW4iO3M6MTQ6IgAqAGFjY2Vzc1Rva2VuIjtOO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czo0MzoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL3N1cGVyLWFkbWluLWRhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNjoicm9sZV9wZXJtaXNzaW9ucyI7YTowOnt9czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMiRJYXUucnFyTktYRXZjVjcxMWVzakkuRlNGNFE5RFBDcnppUFJwc0I2NzAvc1NGUktnRHQxRyI7czoxMjoic210cF9zZXR0aW5nIjtPOjIzOiJBcHBcTW9kZWxzXEVtYWlsU2V0dGluZyI6MzM6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO3M6MTQ6ImVtYWlsX3NldHRpbmdzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTQ6e3M6MjoiaWQiO2k6MTtzOjE0OiJtYWlsX2Zyb21fbmFtZSI7czoxMDoiVGFibGVUcmFjayI7czoxNToibWFpbF9mcm9tX2VtYWlsIjtzOjE0OiJmcm9tQGVtYWlsLmNvbSI7czoxMjoiZW5hYmxlX3F1ZXVlIjtzOjI6Im5vIjtzOjExOiJtYWlsX2RyaXZlciI7czo0OiJzbXRwIjtzOjk6InNtdHBfaG9zdCI7czoxNDoic210cC5nbWFpbC5jb20iO3M6OToic210cF9wb3J0IjtpOjQ2NTtzOjE1OiJzbXRwX2VuY3J5cHRpb24iO3M6Mzoic3NsIjtzOjEzOiJtYWlsX3VzZXJuYW1lIjtzOjE3OiJteWVtYWlsQGdtYWlsLmNvbSI7czoxMzoibWFpbF9wYXNzd29yZCI7TjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA4OjI3OjI0IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI1LTExLTMwIDA4OjI3OjI0IjtzOjE0OiJlbWFpbF92ZXJpZmllZCI7aTowO3M6ODoidmVyaWZpZWQiO2k6MDt9czoxMToiACoAb3JpZ2luYWwiO2E6MTQ6e3M6MjoiaWQiO2k6MTtzOjE0OiJtYWlsX2Zyb21fbmFtZSI7czoxMDoiVGFibGVUcmFjayI7czoxNToibWFpbF9mcm9tX2VtYWlsIjtzOjE0OiJmcm9tQGVtYWlsLmNvbSI7czoxMjoiZW5hYmxlX3F1ZXVlIjtzOjI6Im5vIjtzOjExOiJtYWlsX2RyaXZlciI7czo0OiJzbXRwIjtzOjk6InNtdHBfaG9zdCI7czoxNDoic210cC5nbWFpbC5jb20iO3M6OToic210cF9wb3J0IjtzOjM6IjQ2NSI7czoxNToic210cF9lbmNyeXB0aW9uIjtzOjM6InNzbCI7czoxMzoibWFpbF91c2VybmFtZSI7czoxNzoibXllbWFpbEBnbWFpbC5jb20iO3M6MTM6Im1haWxfcGFzc3dvcmQiO047czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyNCI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNS0xMS0zMCAwODoyNzoyNCI7czoxNDoiZW1haWxfdmVyaWZpZWQiO2k6MDtzOjg6InZlcmlmaWVkIjtpOjA7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MDp7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoyOiJpZCI7fX1zOjU6ImlzUnRsIjtiOjA7czoyMToicGFzc3dvcmRfaGFzaF9zYW5jdHVtIjtzOjYwOiIkMnkkMTIkSWF1LnJxck5LWEV2Y1Y3MTFlc2pJLkZTRjRROURQQ3J6aVBScHNCNjcwL3NTRlJLZ0R0MUciO3M6NDoiYXV0aCI7YToxOntzOjIxOiJwYXNzd29yZF9jb25maXJtZWRfYXQiO2k6MTc2NDY5Mzc1Mjt9fQ==',1764693789);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_global_settings`
--

DROP TABLE IF EXISTS `sms_global_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms_global_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `license_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchased_on` timestamp NULL DEFAULT NULL,
  `supported_until` timestamp NULL DEFAULT NULL,
  `notify_update` tinyint(1) NOT NULL DEFAULT '1',
  `vonage_api_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vonage_api_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vonage_from_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `msg91_auth_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `msg91_from` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vonage_status` tinyint(1) NOT NULL DEFAULT '0',
  `msg91_status` tinyint(1) NOT NULL DEFAULT '0',
  `phone_verification_status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_global_settings`
--

LOCK TABLES `sms_global_settings` WRITE;
/*!40000 ALTER TABLE `sms_global_settings` DISABLE KEYS */;
INSERT INTO `sms_global_settings` VALUES (1,NULL,NULL,NULL,NULL,1,'demo123455666654654654654645654654654645645654656546456546`','qweqwewqeqweqweqwewqeqwewqe','9876543210','','',1,0,1,'2025-11-30 04:19:45','2025-12-02 10:22:41');
/*!40000 ALTER TABLE `sms_global_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_notification_settings`
--

DROP TABLE IF EXISTS `sms_notification_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms_notification_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `send_sms` enum('yes','no') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'no',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sms_notification_settings_restaurant_id_foreign` (`restaurant_id`),
  CONSTRAINT `sms_notification_settings_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_notification_settings`
--

LOCK TABLES `sms_notification_settings` WRITE;
/*!40000 ALTER TABLE `sms_notification_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms_notification_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_templates`
--

DROP TABLE IF EXISTS `sms_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms_templates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `flow_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sms_templates_type_unique` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_templates`
--

LOCK TABLES `sms_templates` WRITE;
/*!40000 ALTER TABLE `sms_templates` DISABLE KEYS */;
INSERT INTO `sms_templates` VALUES (1,'reservation_confirmed','','2025-11-30 04:19:46','2025-12-02 10:22:08'),(2,'order_bill_sent','','2025-11-30 04:19:46','2025-12-02 10:22:08'),(3,'send_otp','','2025-11-30 04:19:46','2025-12-02 10:22:08'),(4,'send_verify_otp','','2025-11-30 04:19:46','2025-12-02 10:22:08');
/*!40000 ALTER TABLE `sms_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_usage_logs`
--

DROP TABLE IF EXISTS `sms_usage_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms_usage_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `branch_id` bigint unsigned DEFAULT NULL,
  `date` datetime NOT NULL,
  `gateway` enum('vonage','msg91') COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('reservation_confirmed','order_bill_sent','send_otp') COLLATE utf8mb4_unicode_ci NOT NULL,
  `count` int NOT NULL DEFAULT '1',
  `package_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sms_usage_unique` (`restaurant_id`,`branch_id`,`type`,`gateway`,`date`),
  KEY `sms_usage_logs_branch_id_foreign` (`branch_id`),
  KEY `sms_usage_logs_restaurant_id_date_index` (`restaurant_id`,`date`),
  KEY `sms_usage_logs_gateway_type_index` (`gateway`,`type`),
  KEY `sms_usage_logs_date_gateway_index` (`date`,`gateway`),
  KEY `sms_usage_logs_package_id_date_index` (`package_id`,`date`),
  CONSTRAINT `sms_usage_logs_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sms_usage_logs_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sms_usage_logs_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_usage_logs`
--

LOCK TABLES `sms_usage_logs` WRITE;
/*!40000 ALTER TABLE `sms_usage_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms_usage_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `split_order_items`
--

DROP TABLE IF EXISTS `split_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `split_order_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `split_order_id` bigint unsigned NOT NULL,
  `order_item_id` bigint unsigned NOT NULL,
  `quantity` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `split_order_items_split_order_id_foreign` (`split_order_id`),
  KEY `split_order_items_order_item_id_foreign` (`order_item_id`),
  CONSTRAINT `split_order_items_order_item_id_foreign` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `split_order_items_split_order_id_foreign` FOREIGN KEY (`split_order_id`) REFERENCES `split_orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `split_order_items`
--

LOCK TABLES `split_order_items` WRITE;
/*!40000 ALTER TABLE `split_order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `split_order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `split_orders`
--

DROP TABLE IF EXISTS `split_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `split_orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `amount` decimal(16,2) NOT NULL,
  `status` enum('pending','paid') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_method` enum('cash','upi','card','bank_transfer','due','stripe','razorpay') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cash',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `split_orders_order_id_foreign` (`order_id`),
  CONSTRAINT `split_orders_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `split_orders`
--

LOCK TABLES `split_orders` WRITE;
/*!40000 ALTER TABLE `split_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `split_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stripe_payments`
--

DROP TABLE IF EXISTS `stripe_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stripe_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `payment_date` datetime DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `payment_status` enum('pending','requested','declined','completed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_error_response` text COLLATE utf8mb4_unicode_ci,
  `stripe_payment_intent` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_session_id` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stripe_payments_order_id_foreign` (`order_id`),
  CONSTRAINT `stripe_payments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stripe_payments`
--

LOCK TABLES `stripe_payments` WRITE;
/*!40000 ALTER TABLE `stripe_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `stripe_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_domain_module_settings`
--

DROP TABLE IF EXISTS `sub_domain_module_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_domain_module_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `license_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchased_on` timestamp NULL DEFAULT NULL,
  `supported_until` timestamp NULL DEFAULT NULL,
  `banned_subdomain` longtext COLLATE utf8mb4_unicode_ci,
  `notify_update` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_domain_module_settings`
--

LOCK TABLES `sub_domain_module_settings` WRITE;
/*!40000 ALTER TABLE `sub_domain_module_settings` DISABLE KEYS */;
INSERT INTO `sub_domain_module_settings` VALUES (1,NULL,NULL,NULL,NULL,NULL,1,'2025-11-30 04:19:48','2025-11-30 04:19:48');
/*!40000 ALTER TABLE `sub_domain_module_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `superadmin_payment_gateways`
--

DROP TABLE IF EXISTS `superadmin_payment_gateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `superadmin_payment_gateways` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `razorpay_type` enum('test','live') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'test',
  `test_razorpay_key` text COLLATE utf8mb4_unicode_ci,
  `test_razorpay_secret` text COLLATE utf8mb4_unicode_ci,
  `razorpay_test_webhook_key` text COLLATE utf8mb4_unicode_ci,
  `live_razorpay_key` text COLLATE utf8mb4_unicode_ci,
  `live_razorpay_secret` text COLLATE utf8mb4_unicode_ci,
  `razorpay_live_webhook_key` text COLLATE utf8mb4_unicode_ci,
  `razorpay_status` tinyint(1) NOT NULL DEFAULT '0',
  `stripe_type` enum('test','live') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'test',
  `test_stripe_key` text COLLATE utf8mb4_unicode_ci,
  `test_stripe_secret` text COLLATE utf8mb4_unicode_ci,
  `stripe_test_webhook_key` text COLLATE utf8mb4_unicode_ci,
  `live_stripe_key` text COLLATE utf8mb4_unicode_ci,
  `live_stripe_secret` text COLLATE utf8mb4_unicode_ci,
  `stripe_live_webhook_key` text COLLATE utf8mb4_unicode_ci,
  `stripe_status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `flutterwave_status` tinyint(1) NOT NULL DEFAULT '0',
  `flutterwave_type` enum('test','live') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'test',
  `test_flutterwave_key` text COLLATE utf8mb4_unicode_ci,
  `test_flutterwave_secret` text COLLATE utf8mb4_unicode_ci,
  `test_flutterwave_hash` text COLLATE utf8mb4_unicode_ci,
  `flutterwave_test_webhook_key` text COLLATE utf8mb4_unicode_ci,
  `live_flutterwave_key` text COLLATE utf8mb4_unicode_ci,
  `live_flutterwave_secret` text COLLATE utf8mb4_unicode_ci,
  `live_flutterwave_hash` text COLLATE utf8mb4_unicode_ci,
  `flutterwave_live_webhook_key` text COLLATE utf8mb4_unicode_ci,
  `live_paypal_client_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_paypal_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_paypal_client_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_paypal_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paypal_status` tinyint(1) NOT NULL DEFAULT '0',
  `paypal_mode` enum('sandbox','live') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sandbox',
  `live_payfast_merchant_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_payfast_merchant_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_payfast_passphrase` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_payfast_merchant_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_payfast_merchant_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_payfast_passphrase` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payfast_mode` enum('sandbox','live') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sandbox',
  `payfast_status` tinyint(1) NOT NULL DEFAULT '0',
  `live_paystack_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_paystack_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_paystack_merchant_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_paystack_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_paystack_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_paystack_merchant_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paystack_payment_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'https://api.paystack.co',
  `paystack_status` tinyint(1) NOT NULL DEFAULT '0',
  `paystack_mode` enum('sandbox','live') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sandbox',
  `xendit_status` tinyint(1) NOT NULL DEFAULT '0',
  `xendit_mode` enum('sandbox','live') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sandbox',
  `test_xendit_public_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_xendit_secret_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_xendit_public_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_xendit_secret_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_xendit_webhook_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_xendit_webhook_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paddle_status` tinyint(1) NOT NULL DEFAULT '0',
  `paddle_mode` enum('sandbox','live') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sandbox',
  `test_paddle_vendor_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_paddle_api_key` text COLLATE utf8mb4_unicode_ci,
  `test_paddle_public_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_paddle_client_token` text COLLATE utf8mb4_unicode_ci,
  `live_paddle_vendor_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_paddle_api_key` text COLLATE utf8mb4_unicode_ci,
  `live_paddle_public_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_paddle_client_token` text COLLATE utf8mb4_unicode_ci,
  `paddle_webhook_secret` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `superadmin_payment_gateways`
--

LOCK TABLES `superadmin_payment_gateways` WRITE;
/*!40000 ALTER TABLE `superadmin_payment_gateways` DISABLE KEYS */;
INSERT INTO `superadmin_payment_gateways` VALUES (1,'test',NULL,NULL,NULL,NULL,NULL,NULL,0,'test',NULL,NULL,NULL,NULL,NULL,NULL,0,'2025-11-30 02:55:43','2025-11-30 02:55:43',0,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,'sandbox',0,NULL,NULL,NULL,NULL,NULL,NULL,'https://api.paystack.co',0,'sandbox',0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'test',NULL,NULL,NULL,NULL,NULL,NULL,0,'test',NULL,NULL,NULL,NULL,NULL,NULL,0,'2025-11-30 02:57:24','2025-11-30 02:57:24',0,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,'sandbox',0,NULL,NULL,NULL,NULL,NULL,NULL,'https://api.paystack.co',0,'sandbox',0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'test',NULL,NULL,NULL,NULL,NULL,NULL,0,'test',NULL,NULL,NULL,NULL,NULL,NULL,0,'2025-11-30 02:59:34','2025-11-30 02:59:34',0,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,'sandbox',0,NULL,NULL,NULL,NULL,NULL,NULL,'https://api.paystack.co',0,'sandbox',0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'test',NULL,NULL,NULL,NULL,NULL,NULL,0,'test',NULL,NULL,NULL,NULL,NULL,NULL,0,'2025-11-30 02:59:55','2025-11-30 02:59:55',0,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,'sandbox',0,NULL,NULL,NULL,NULL,NULL,NULL,'https://api.paystack.co',0,'sandbox',0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'test',NULL,NULL,NULL,NULL,NULL,NULL,0,'test',NULL,NULL,NULL,NULL,NULL,NULL,0,'2025-11-30 03:00:20','2025-11-30 03:00:20',0,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,'sandbox',0,NULL,NULL,NULL,NULL,NULL,NULL,'https://api.paystack.co',0,'sandbox',0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,0,'sandbox',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `superadmin_payment_gateways` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `suppliers_restaurant_id_foreign` (`restaurant_id`),
  CONSTRAINT `suppliers_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `table_sessions`
--

DROP TABLE IF EXISTS `table_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `table_sessions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned NOT NULL,
  `table_id` bigint unsigned NOT NULL,
  `locked_by_user_id` bigint unsigned DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `last_activity_at` datetime DEFAULT NULL,
  `session_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `table_sessions_session_token_unique` (`session_token`),
  KEY `table_sessions_branch_id_foreign` (`branch_id`),
  KEY `table_sessions_locked_by_user_id_foreign` (`locked_by_user_id`),
  KEY `table_sessions_table_id_locked_by_user_id_index` (`table_id`,`locked_by_user_id`),
  KEY `table_sessions_last_activity_at_index` (`last_activity_at`),
  CONSTRAINT `table_sessions_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `table_sessions_locked_by_user_id_foreign` FOREIGN KEY (`locked_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `table_sessions_table_id_foreign` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `table_sessions`
--

LOCK TABLES `table_sessions` WRITE;
/*!40000 ALTER TABLE `table_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `table_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tables`
--

DROP TABLE IF EXISTS `tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tables` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned DEFAULT NULL,
  `table_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hash` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `available_status` enum('available','reserved','running') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'available',
  `area_id` bigint unsigned NOT NULL,
  `seating_capacity` tinyint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tables_area_id_foreign` (`area_id`),
  KEY `tables_branch_id_foreign` (`branch_id`),
  CONSTRAINT `tables_area_id_foreign` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tables_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tables`
--

LOCK TABLES `tables` WRITE;
/*!40000 ALTER TABLE `tables` DISABLE KEYS */;
INSERT INTO `tables` VALUES (1,1,'T-1','7643e2f8746841d38ebaeb151184b49e','active','available',1,7,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(2,1,'T-2','4f1deec3a3fa18d203aec0801ac8a143','active','available',3,4,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(3,1,'T-3','42c0594efe8562c815ecb3ac24cbfc61','active','available',3,6,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(4,1,'T-4','48672960ceb187b6ce3fa9558cd73b7b','active','available',1,3,'2025-11-30 02:57:25','2025-11-30 02:57:25'),(5,1,'T-5','743411924d5088f3fd4fdab40866f236','active','available',3,4,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(6,1,'T-6','f773aac136376088ac27f7bd1aafa231','active','available',3,7,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(7,1,'T-7','9e1b104f7d9f80dc873b88c99560aa9b','active','available',2,2,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(8,1,'T-8','4342658baf2cfbdc5bf0a75b01cfcaba','active','available',1,7,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(9,1,'T-9','42a551722ba22c25f7e4067a97b7f12e','active','available',2,8,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(10,1,'T-10','631107d3d502bbc5f34510d12fbd77fa','active','available',2,8,'2025-11-30 02:57:26','2025-11-30 02:57:26'),(11,1,'T-1','8f4564714240fc3fbc7f5c5564bb33ba','active','available',4,6,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(12,1,'T-2','f9cc2ba05d7dc54b129e79da89cc9952','active','available',2,7,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(13,1,'T-3','e77af267a6543c79b9830be39c3defde','active','available',3,7,'2025-11-30 03:00:21','2025-11-30 03:00:21'),(14,1,'T-4','eea2076ed5f77d062842e46401566d37','active','available',6,5,'2025-11-30 03:00:22','2025-11-30 03:00:22'),(15,1,'T-5','40f905e9f1cd9999ac4a3f7897f3c7f3','active','available',6,8,'2025-11-30 03:00:22','2025-11-30 03:00:22'),(16,1,'T-6','5ae1919f5386617994a77d49c1b49c1a','active','available',3,6,'2025-11-30 03:00:22','2025-11-30 03:00:22'),(17,1,'T-7','eabd11096ea1c664523d298ecc5d58fc','active','available',1,8,'2025-11-30 03:00:22','2025-11-30 03:00:22'),(18,1,'T-8','ee82218803b8320699d7d2d90e0dd5c2','active','available',4,8,'2025-11-30 03:00:22','2025-11-30 03:00:22'),(19,1,'T-9','e0e17b6f3e1ef6f680b145a797c4fc75','active','available',2,4,'2025-11-30 03:00:22','2025-11-30 03:00:22'),(20,1,'T-10','b6862e1ccf5a398e1ab03a5a2448b78d','active','available',3,6,'2025-11-30 03:00:23','2025-11-30 03:00:23'),(21,3,'T-1','fa5cc697b0a84b9ead028eea36b8728a','active','available',7,4,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(22,3,'T-2','f1f1815aa68d99ceaaf0fb519e390a46','active','available',3,3,'2025-11-30 03:00:26','2025-11-30 03:00:26'),(23,3,'T-3','e359f3e100d8a308d676e90e1370578b','active','available',9,2,'2025-11-30 03:00:27','2025-11-30 03:00:27'),(24,3,'T-4','4a5d6c7ed1ee930e1ccd6aef0109b94d','active','available',1,5,'2025-11-30 03:00:27','2025-11-30 03:00:27'),(25,3,'T-5','8821de3eb244fda97eb71b1090f62469','active','available',1,7,'2025-11-30 03:00:27','2025-11-30 03:00:27'),(26,3,'T-6','2ad5e3fe0404661e144748b6bdc73743','active','available',5,3,'2025-11-30 03:00:27','2025-11-30 03:00:27'),(27,3,'T-7','0223d48e8f71bab9b657974cf20aa2ff','active','available',2,7,'2025-11-30 03:00:27','2025-11-30 03:00:27'),(28,3,'T-8','8fcff4c939ea1633709b9440182ce4fd','active','available',3,3,'2025-11-30 03:00:27','2025-11-30 03:00:27'),(29,3,'T-9','da22a76a6191df05b02c20a0ba31541b','active','available',9,2,'2025-11-30 03:00:27','2025-11-30 03:00:27'),(30,3,'T-10','eb95236d6b82e04d9954373c7104c077','active','available',2,8,'2025-11-30 03:00:27','2025-11-30 03:00:27'),(31,5,'T-1','f06cd5eeff769e8201c78c67b521584d','active','available',2,4,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(32,5,'T-2','fd1a246eee33b39bd93e775b75ca166b','active','available',5,8,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(33,5,'T-3','0d8bcabcb85ff849d686b4268fa888a4','active','available',3,7,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(34,5,'T-4','66f558a7089f29caeea96a7cd9564d36','active','available',3,4,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(35,5,'T-5','56a6a704ae9c001b040f110430397c39','active','available',5,2,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(36,5,'T-6','05756e95935a7cb8554cbc33a2644cc4','active','available',11,4,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(37,5,'T-7','b6294f91b6df62b74ba4f57119db3df5','active','available',12,4,'2025-11-30 03:00:31','2025-11-30 03:00:31'),(38,5,'T-8','30211943fc8a58093ca483bdaf953c25','active','available',4,6,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(39,5,'T-9','e37f87657860ed27d8c9016d544533bc','active','available',1,8,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(40,5,'T-10','5038bb15b575556b670bc71ba3ad9398','active','available',3,6,'2025-11-30 03:00:32','2025-11-30 03:00:32'),(41,7,'T-1','c6e079d53978f33cadfae129f1b7804d','active','available',13,5,'2025-11-30 03:00:35','2025-11-30 03:00:35'),(42,7,'T-2','347958d5511055f4bcb6b4bf90814256','active','available',15,4,'2025-11-30 03:00:36','2025-11-30 03:00:36'),(43,7,'T-3','83873ca263351728070a84ca54e083e3','active','available',5,6,'2025-11-30 03:00:36','2025-11-30 03:00:36'),(44,7,'T-4','697b8fcf1336730ce0193603a882b492','active','available',13,4,'2025-11-30 03:00:36','2025-11-30 03:00:36'),(45,7,'T-5','d1d5dd054e27e003cd952d3c86fe9840','active','available',15,8,'2025-11-30 03:00:36','2025-11-30 03:00:36'),(46,7,'T-6','d2114a6e429beec5d7b59fbf0cef733b','active','available',14,2,'2025-11-30 03:00:36','2025-11-30 03:00:36'),(47,7,'T-7','26ac6ed9fd839130a67455eeaf7bd111','active','available',1,5,'2025-11-30 03:00:36','2025-11-30 03:00:36'),(48,7,'T-8','0ae93fe600b75e94722f8c932e07c89f','active','available',11,2,'2025-11-30 03:00:36','2025-11-30 03:00:36'),(49,7,'T-9','4fca7e96bc36e13f680041340746d110','active','available',10,6,'2025-11-30 03:00:37','2025-11-30 03:00:37'),(50,7,'T-10','89a757aa4405e144940cf37a70246db1','active','available',9,5,'2025-11-30 03:00:37','2025-11-30 03:00:37');
/*!40000 ALTER TABLE `tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxes`
--

DROP TABLE IF EXISTS `taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taxes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `tax_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tax_percent` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `taxes_restaurant_id_foreign` (`restaurant_id`),
  CONSTRAINT `taxes_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxes`
--

LOCK TABLES `taxes` WRITE;
/*!40000 ALTER TABLE `taxes` DISABLE KEYS */;
INSERT INTO `taxes` VALUES (1,1,'SGST','2.5','2025-11-30 02:57:24','2025-11-30 02:57:24'),(2,1,'CGST','2.5','2025-11-30 02:57:24','2025-11-30 02:57:24'),(3,1,'SGST','2.5','2025-11-30 02:59:35','2025-11-30 02:59:35'),(4,1,'CGST','2.5','2025-11-30 02:59:35','2025-11-30 02:59:35'),(5,1,'SGST','2.5','2025-11-30 02:59:55','2025-11-30 02:59:55'),(6,1,'CGST','2.5','2025-11-30 02:59:55','2025-11-30 02:59:55'),(7,1,'SGST','2.5','2025-11-30 03:00:20','2025-11-30 03:00:20'),(8,1,'CGST','2.5','2025-11-30 03:00:20','2025-11-30 03:00:20'),(9,2,'SGST','2.5','2025-11-30 03:00:25','2025-11-30 03:00:25'),(10,2,'CGST','2.5','2025-11-30 03:00:25','2025-11-30 03:00:25'),(11,3,'SGST','2.5','2025-11-30 03:00:30','2025-11-30 03:00:30'),(12,3,'CGST','2.5','2025-11-30 03:00:30','2025-11-30 03:00:30'),(13,4,'SGST','2.5','2025-11-30 03:00:34','2025-11-30 03:00:34'),(14,4,'CGST','2.5','2025-11-30 03:00:34','2025-11-30 03:00:34');
/*!40000 ALTER TABLE `taxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `units` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `units_branch_id_foreign` (`branch_id`),
  CONSTRAINT `units_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `units`
--

LOCK TABLES `units` WRITE;
/*!40000 ALTER TABLE `units` DISABLE KEYS */;
INSERT INTO `units` VALUES (1,1,'Kilogram','kg','2025-11-30 04:19:30','2025-11-30 04:19:30'),(2,1,'Gram','g','2025-11-30 04:19:30','2025-11-30 04:19:30'),(3,1,'Liter','L','2025-11-30 04:19:30','2025-11-30 04:19:30'),(4,1,'Milliliter','ml','2025-11-30 04:19:30','2025-11-30 04:19:30'),(5,1,'Piece','pc','2025-11-30 04:19:30','2025-11-30 04:19:30'),(6,1,'Box','box','2025-11-30 04:19:30','2025-11-30 04:19:30'),(7,1,'Dozen','dz','2025-11-30 04:19:30','2025-11-30 04:19:30'),(8,1,'Bottle','btl','2025-11-30 04:19:30','2025-11-30 04:19:30'),(9,1,'Package','pkg','2025-11-30 04:19:30','2025-11-30 04:19:30'),(10,1,'Can','can','2025-11-30 04:19:30','2025-11-30 04:19:30'),(11,2,'Kilogram','kg','2025-11-30 04:19:30','2025-11-30 04:19:30'),(12,2,'Gram','g','2025-11-30 04:19:30','2025-11-30 04:19:30'),(13,2,'Liter','L','2025-11-30 04:19:30','2025-11-30 04:19:30'),(14,2,'Milliliter','ml','2025-11-30 04:19:30','2025-11-30 04:19:30'),(15,2,'Piece','pc','2025-11-30 04:19:30','2025-11-30 04:19:30'),(16,2,'Box','box','2025-11-30 04:19:30','2025-11-30 04:19:30'),(17,2,'Dozen','dz','2025-11-30 04:19:30','2025-11-30 04:19:30'),(18,2,'Bottle','btl','2025-11-30 04:19:30','2025-11-30 04:19:30'),(19,2,'Package','pkg','2025-11-30 04:19:30','2025-11-30 04:19:30'),(20,2,'Can','can','2025-11-30 04:19:30','2025-11-30 04:19:30'),(21,3,'Kilogram','kg','2025-11-30 04:19:30','2025-11-30 04:19:30'),(22,3,'Gram','g','2025-11-30 04:19:30','2025-11-30 04:19:30'),(23,3,'Liter','L','2025-11-30 04:19:30','2025-11-30 04:19:30'),(24,3,'Milliliter','ml','2025-11-30 04:19:30','2025-11-30 04:19:30'),(25,3,'Piece','pc','2025-11-30 04:19:30','2025-11-30 04:19:30'),(26,3,'Box','box','2025-11-30 04:19:30','2025-11-30 04:19:30'),(27,3,'Dozen','dz','2025-11-30 04:19:30','2025-11-30 04:19:30'),(28,3,'Bottle','btl','2025-11-30 04:19:30','2025-11-30 04:19:30'),(29,3,'Package','pkg','2025-11-30 04:19:30','2025-11-30 04:19:30'),(30,3,'Can','can','2025-11-30 04:19:30','2025-11-30 04:19:30'),(31,4,'Kilogram','kg','2025-11-30 04:19:30','2025-11-30 04:19:30'),(32,4,'Gram','g','2025-11-30 04:19:30','2025-11-30 04:19:30'),(33,4,'Liter','L','2025-11-30 04:19:30','2025-11-30 04:19:30'),(34,4,'Milliliter','ml','2025-11-30 04:19:30','2025-11-30 04:19:30'),(35,4,'Piece','pc','2025-11-30 04:19:30','2025-11-30 04:19:30'),(36,4,'Box','box','2025-11-30 04:19:30','2025-11-30 04:19:30'),(37,4,'Dozen','dz','2025-11-30 04:19:30','2025-11-30 04:19:30'),(38,4,'Bottle','btl','2025-11-30 04:19:30','2025-11-30 04:19:30'),(39,4,'Package','pkg','2025-11-30 04:19:30','2025-11-30 04:19:30'),(40,4,'Can','can','2025-11-30 04:19:30','2025-11-30 04:19:30'),(41,5,'Kilogram','kg','2025-11-30 04:19:31','2025-11-30 04:19:31'),(42,5,'Gram','g','2025-11-30 04:19:31','2025-11-30 04:19:31'),(43,5,'Liter','L','2025-11-30 04:19:31','2025-11-30 04:19:31'),(44,5,'Milliliter','ml','2025-11-30 04:19:31','2025-11-30 04:19:31'),(45,5,'Piece','pc','2025-11-30 04:19:31','2025-11-30 04:19:31'),(46,5,'Box','box','2025-11-30 04:19:31','2025-11-30 04:19:31'),(47,5,'Dozen','dz','2025-11-30 04:19:31','2025-11-30 04:19:31'),(48,5,'Bottle','btl','2025-11-30 04:19:31','2025-11-30 04:19:31'),(49,5,'Package','pkg','2025-11-30 04:19:31','2025-11-30 04:19:31'),(50,5,'Can','can','2025-11-30 04:19:31','2025-11-30 04:19:31'),(51,6,'Kilogram','kg','2025-11-30 04:19:31','2025-11-30 04:19:31'),(52,6,'Gram','g','2025-11-30 04:19:31','2025-11-30 04:19:31'),(53,6,'Liter','L','2025-11-30 04:19:31','2025-11-30 04:19:31'),(54,6,'Milliliter','ml','2025-11-30 04:19:31','2025-11-30 04:19:31'),(55,6,'Piece','pc','2025-11-30 04:19:31','2025-11-30 04:19:31'),(56,6,'Box','box','2025-11-30 04:19:31','2025-11-30 04:19:31'),(57,6,'Dozen','dz','2025-11-30 04:19:31','2025-11-30 04:19:31'),(58,6,'Bottle','btl','2025-11-30 04:19:31','2025-11-30 04:19:31'),(59,6,'Package','pkg','2025-11-30 04:19:31','2025-11-30 04:19:31'),(60,6,'Can','can','2025-11-30 04:19:31','2025-11-30 04:19:31'),(61,7,'Kilogram','kg','2025-11-30 04:19:31','2025-11-30 04:19:31'),(62,7,'Gram','g','2025-11-30 04:19:31','2025-11-30 04:19:31'),(63,7,'Liter','L','2025-11-30 04:19:31','2025-11-30 04:19:31'),(64,7,'Milliliter','ml','2025-11-30 04:19:31','2025-11-30 04:19:31'),(65,7,'Piece','pc','2025-11-30 04:19:31','2025-11-30 04:19:31'),(66,7,'Box','box','2025-11-30 04:19:31','2025-11-30 04:19:31'),(67,7,'Dozen','dz','2025-11-30 04:19:31','2025-11-30 04:19:31'),(68,7,'Bottle','btl','2025-11-30 04:19:31','2025-11-30 04:19:31'),(69,7,'Package','pkg','2025-11-30 04:19:31','2025-11-30 04:19:31'),(70,7,'Can','can','2025-11-30 04:19:31','2025-11-30 04:19:31'),(71,8,'Kilogram','kg','2025-11-30 04:19:31','2025-11-30 04:19:31'),(72,8,'Gram','g','2025-11-30 04:19:31','2025-11-30 04:19:31'),(73,8,'Liter','L','2025-11-30 04:19:31','2025-11-30 04:19:31'),(74,8,'Milliliter','ml','2025-11-30 04:19:31','2025-11-30 04:19:31'),(75,8,'Piece','pc','2025-11-30 04:19:31','2025-11-30 04:19:31'),(76,8,'Box','box','2025-11-30 04:19:31','2025-11-30 04:19:31'),(77,8,'Dozen','dz','2025-11-30 04:19:31','2025-11-30 04:19:31'),(78,8,'Bottle','btl','2025-11-30 04:19:31','2025-11-30 04:19:31'),(79,8,'Package','pkg','2025-11-30 04:19:31','2025-11-30 04:19:31'),(80,8,'Can','can','2025-11-30 04:19:31','2025-11-30 04:19:31');
/*!40000 ALTER TABLE `units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint unsigned DEFAULT NULL,
  `branch_id` bigint unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `terms_and_privacy_accepted` tinyint(1) NOT NULL DEFAULT '0',
  `marketing_emails_accepted` tinyint(1) NOT NULL DEFAULT '0',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_team_id` bigint unsigned DEFAULT NULL,
  `profile_photo_path` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `locale` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pm_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pm_last_four` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_restaurant_id_foreign` (`restaurant_id`),
  KEY `users_stripe_id_index` (`stripe_id`),
  KEY `idx_branch_email` (`branch_id`,`email`),
  CONSTRAINT `users_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `users_restaurant_id_foreign` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,NULL,'Emma Holden','superadmin@example.com',NULL,NULL,0,0,NULL,'$2y$12$Iau.rqrNKXEvcV711esjI.FSF4Q9DPCrziPRpsB670/sSFRKgDt1G',NULL,NULL,NULL,NULL,NULL,NULL,'2025-11-30 02:57:23','2025-12-02 11:12:46','en',NULL,NULL,NULL,NULL),(2,1,NULL,'John Doe','admin@example.com',NULL,NULL,0,0,NULL,'$2y$12$8.k.Hm9V3qYrpWfA7kxLne.AJjJCQwNyTPivcRN2m8aTXE.2EURiq',NULL,NULL,NULL,NULL,NULL,NULL,'2025-11-30 02:57:25','2025-12-02 10:16:33','en',NULL,NULL,NULL,NULL),(3,1,1,'Jaquelyn Battle','waiter@example.com',NULL,NULL,0,0,NULL,'$2y$12$Tc0YqExdTlZvPdKNDsIaVO.LfA0/oxvVfO6.GiY7oVsD9XDirVnEW',NULL,NULL,NULL,NULL,NULL,NULL,'2025-11-30 02:57:25','2025-11-30 02:57:25','en',NULL,NULL,NULL,NULL),(5,2,NULL,'Miss Maida Ondricka','demo.restaurant@example.com',NULL,NULL,0,0,NULL,'$2y$12$WWNThT58rgCri4cJAbvSMuos8nGcfHnKORySGHP1YbcZg9351xcZq',NULL,NULL,NULL,NULL,NULL,NULL,'2025-11-30 03:00:26','2025-11-30 03:00:26','en',NULL,NULL,NULL,NULL),(6,2,3,'Wilson Ledner','barrows.karianne@example.org',NULL,NULL,0,0,NULL,'$2y$12$VD3Ycn2aGTm5lDE6E7efBeCg9lE07BZtThumEqsk/NcYF7ld1aYUy',NULL,NULL,NULL,NULL,NULL,NULL,'2025-11-30 03:00:26','2025-11-30 03:00:26','en',NULL,NULL,NULL,NULL),(7,3,5,'Kelsie Durgan','emily44@example.com',NULL,NULL,0,0,NULL,'$2y$12$EFNlsofun81me9xJ9ECvQ.LEo9vBAqdMpL2r.4bFEtzB53tPVxVU2',NULL,NULL,NULL,NULL,NULL,NULL,'2025-11-30 03:00:31','2025-11-30 03:00:31','en',NULL,NULL,NULL,NULL),(8,4,7,'Salma Simonis','wreichel@example.org',NULL,NULL,0,0,NULL,'$2y$12$qygQ9QcyOclBpmu3Jk.CLOfqKPw1SKulnWGD6jteJH2/qqFswfE1a',NULL,NULL,NULL,NULL,NULL,NULL,'2025-11-30 03:00:35','2025-11-30 03:00:35','en',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waiter_requests`
--

DROP TABLE IF EXISTS `waiter_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `waiter_requests` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint unsigned NOT NULL,
  `table_id` bigint unsigned NOT NULL,
  `status` enum('pending','completed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `waiter_requests_branch_id_foreign` (`branch_id`),
  KEY `waiter_requests_table_id_foreign` (`table_id`),
  CONSTRAINT `waiter_requests_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `waiter_requests_table_id_foreign` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waiter_requests`
--

LOCK TABLES `waiter_requests` WRITE;
/*!40000 ALTER TABLE `waiter_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `waiter_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xendit_payments`
--

DROP TABLE IF EXISTS `xendit_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xendit_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `payment_date` datetime DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `payment_status` enum('pending','requested','declined','completed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_error_response` text COLLATE utf8mb4_unicode_ci,
  `xendit_payment_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `xendit_invoice_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `xendit_external_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `xendit_payments_order_id_foreign` (`order_id`),
  CONSTRAINT `xendit_payments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xendit_payments`
--

LOCK TABLES `xendit_payments` WRITE;
/*!40000 ALTER TABLE `xendit_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `xendit_payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-03  0:13:03

-- MariaDB dump 10.19-11.1.2-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: app
-- ------------------------------------------------------
-- Server version	11.1.2-MariaDB-1:11.1.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `data_rows`
--

DROP TABLE IF EXISTS `data_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_rows` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_type_id` int(10) unsigned NOT NULL,
  `field` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `browse` tinyint(1) NOT NULL DEFAULT 1,
  `read` tinyint(1) NOT NULL DEFAULT 1,
  `edit` tinyint(1) NOT NULL DEFAULT 1,
  `add` tinyint(1) NOT NULL DEFAULT 1,
  `delete` tinyint(1) NOT NULL DEFAULT 1,
  `details` text DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `data_rows_data_type_id_foreign` (`data_type_id`),
  CONSTRAINT `data_rows_data_type_id_foreign` FOREIGN KEY (`data_type_id`) REFERENCES `data_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_rows`
--

LOCK TABLES `data_rows` WRITE;
/*!40000 ALTER TABLE `data_rows` DISABLE KEYS */;
INSERT INTO `data_rows` VALUES
(1,1,'id','number','ID',1,0,0,0,0,0,'{}',1),
(2,1,'name','text','Име',1,1,1,1,1,1,'{}',2),
(3,1,'email','text','Email',1,1,1,1,1,1,'{}',3),
(4,1,'password','password','Парола',1,0,0,1,1,0,'{}',4),
(5,1,'remember_token','text','Remember Token',0,0,0,0,0,0,'{}',5),
(6,1,'created_at','timestamp','Регистриран на',0,1,1,0,0,0,'{}',6),
(7,1,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',8),
(8,1,'avatar','image','Снимка',0,1,1,1,1,1,'{}',9),
(9,1,'user_belongsto_role_relationship','relationship','Роля',0,1,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsTo\",\"column\":\"role_id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"roles\",\"pivot\":\"0\",\"taggable\":\"0\"}',11),
(10,1,'user_belongstomany_role_relationship','relationship','Роли',0,0,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"user_roles\",\"pivot\":\"1\",\"taggable\":\"0\"}',12),
(11,1,'settings','hidden','Settings',0,0,0,0,0,0,'{}',15),
(12,2,'id','number','ID',1,0,0,0,0,0,NULL,1),
(13,2,'name','text','Name',1,1,1,1,1,1,NULL,2),
(14,2,'created_at','timestamp','Created At',0,0,0,0,0,0,NULL,3),
(15,2,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,4),
(16,3,'id','number','ID',1,0,0,0,0,0,NULL,1),
(17,3,'name','text','Name',1,1,1,1,1,1,NULL,2),
(18,3,'created_at','timestamp','Created At',0,0,0,0,0,0,NULL,3),
(19,3,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,4),
(20,3,'display_name','text','Display Name',1,1,1,1,1,1,NULL,5),
(21,1,'role_id','text','Role',0,1,1,1,1,1,'{}',10),
(22,5,'id','text','Id',1,0,0,0,0,0,'{}',1),
(23,5,'deleted_at','timestamp','Deleted At',0,0,0,0,0,0,'{}',2),
(24,5,'created_at','timestamp','Вход',0,1,1,1,0,1,'{\"format\":\"%d\\/%m\\/%y %H:%M:%S\"}',3),
(26,5,'user_id','text','User',1,1,1,1,1,1,'{}',5),
(27,5,'log_belongsto_user_relationship','relationship','Работник',0,1,1,1,1,1,'{\"model\":\"App\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"user_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"data_rows\",\"pivot\":\"0\",\"taggable\":\"0\"}',6),
(28,6,'id','text','Id',1,0,0,0,0,0,'{}',1),
(29,6,'name','text','Име',1,1,1,1,1,1,'{}',2),
(30,6,'created_at','timestamp','Регистриран на',0,1,1,1,0,1,'{}',3),
(31,6,'order','number','Ред',0,1,1,1,0,1,'{}',6),
(32,6,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',4),
(33,5,'log_belongsto_reader_relationship','relationship','Четец',0,1,1,1,1,1,'{\"model\":\"App\\\\Reader\",\"table\":\"readers\",\"type\":\"belongsTo\",\"column\":\"reader_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"data_rows\",\"pivot\":\"0\",\"taggable\":\"0\"}',7),
(34,5,'reader_id','text','Reader',1,1,1,1,1,1,'{}',6),
(35,1,'email_verified_at','timestamp','Email потвърден на',0,1,1,1,1,1,'{}',7),
(36,7,'id','text','Id',1,0,0,0,0,0,'{}',1),
(37,7,'tag','text','Номер',1,1,1,1,1,1,'{}',2),
(38,7,'user_id','text','User Id',1,1,1,1,1,1,'{}',3),
(39,7,'created_at','timestamp','Регистриран на',0,1,1,1,0,1,'{}',4),
(40,7,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',5),
(41,7,'tag_belongsto_user_relationship','relationship','Работник',0,1,1,1,1,1,'{\"model\":\"App\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"user_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"data_rows\",\"pivot\":\"0\",\"taggable\":\"0\"}',6),
(42,5,'log_belongsto_tag_relationship','relationship','Карта',0,1,1,1,1,1,'{\"model\":\"App\\\\Tag\",\"table\":\"tags\",\"type\":\"belongsTo\",\"column\":\"tag_id\",\"key\":\"id\",\"label\":\"tag\",\"pivot_table\":\"data_rows\",\"pivot\":\"0\",\"taggable\":\"0\"}',8),
(43,5,'tag_id','text','Tag Id',1,1,1,1,1,1,'{}',7),
(44,6,'mac','text','MAC',0,1,1,1,1,1,'{}',5),
(45,8,'id','text','Id',1,0,0,0,0,0,'{}',1),
(46,8,'name','text','Име',0,1,1,1,1,1,'{}',2),
(47,8,'created_at','timestamp','Регистриран на',0,1,1,1,0,1,'{}',3),
(48,8,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',4),
(49,1,'user_belongsto_section_relationship','relationship','Отдел',0,1,1,1,1,1,'{\"model\":\"App\\\\Section\",\"table\":\"sections\",\"type\":\"belongsTo\",\"column\":\"section_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"data_rows\",\"pivot\":\"0\",\"taggable\":\"0\"}',14),
(50,1,'section_id','text','Section Id',0,1,1,1,1,1,'{}',13),
(51,5,'exited_at','timestamp','Изход',0,1,1,1,1,1,'{\"format\":\"%d\\/%m\\/%y %H:%M:%S\",\"datepicker\":{\"format\":\"DD-MM-YYYY\"}}',4),
(52,9,'id','text','Id',1,0,0,0,0,0,'{}',1),
(53,9,'message','text','Съобщение',0,1,1,1,1,1,'{}',2),
(54,9,'type','text','Тип',0,1,1,1,1,1,'{}',3),
(55,9,'created_at','timestamp','Записана на',0,1,1,1,0,1,'{}',4),
(56,9,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',5),
(57,6,'stats','code_editor','Stats',0,0,1,0,0,0,'{}',7);
/*!40000 ALTER TABLE `data_rows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_types`
--

DROP TABLE IF EXISTS `data_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `display_name_singular` varchar(255) NOT NULL,
  `display_name_plural` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `model_name` varchar(255) DEFAULT NULL,
  `policy_name` varchar(255) DEFAULT NULL,
  `controller` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `generate_permissions` tinyint(1) NOT NULL DEFAULT 0,
  `server_side` tinyint(4) NOT NULL DEFAULT 0,
  `details` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `data_types_name_unique` (`name`),
  UNIQUE KEY `data_types_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_types`
--

LOCK TABLES `data_types` WRITE;
/*!40000 ALTER TABLE `data_types` DISABLE KEYS */;
INSERT INTO `data_types` VALUES
(1,'users','users','Човек','Хора','voyager-person','TCG\\Voyager\\Models\\User','TCG\\Voyager\\Policies\\UserPolicy','TCG\\Voyager\\Http\\Controllers\\VoyagerUserController',NULL,1,0,'{\"order_column\":\"name\",\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":\"name\",\"scope\":null}','2020-05-10 19:07:09','2020-05-15 06:13:38'),
(2,'menus','menus','Menu','Menus','voyager-list','TCG\\Voyager\\Models\\Menu',NULL,'','',1,0,NULL,'2020-05-10 19:07:09','2020-05-10 19:07:09'),
(3,'roles','roles','Role','Roles','voyager-lock','TCG\\Voyager\\Models\\Role',NULL,'TCG\\Voyager\\Http\\Controllers\\VoyagerRoleController','',1,0,NULL,'2020-05-10 19:07:09','2020-05-10 19:07:09'),
(5,'logs','logs','Запис','Записи','voyager-logbook','App\\Log',NULL,NULL,NULL,1,1,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2020-05-10 19:21:26','2020-05-25 06:10:25'),
(6,'readers','readers','Четец','Четци','voyager-location','App\\Reader',NULL,NULL,'Reader devices in the domain.',1,0,'{\"order_column\":\"order\",\"order_display_column\":\"name\",\"order_direction\":\"asc\",\"default_search_key\":\"name\",\"scope\":null}','2020-05-10 19:43:25','2020-12-02 16:49:15'),
(7,'tags','tags','Карта','Карти','voyager-credit-cards','App\\Tag',NULL,NULL,NULL,1,1,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2020-05-10 21:11:18','2020-05-11 08:49:56'),
(8,'sections','sections','Отдел','Отдели','voyager-company','App\\Section',NULL,NULL,NULL,1,0,'{\"order_column\":\"name\",\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":\"name\",\"scope\":null}','2020-05-11 16:23:56','2020-05-11 16:28:42'),
(9,'errors','errors','Грешка','Грешки','voyager-warning','App\\Error',NULL,NULL,NULL,1,1,'{\"order_column\":\"created_at\",\"order_display_column\":\"created_at\",\"order_direction\":\"desc\",\"default_search_key\":\"message\"}','2020-06-13 11:27:45','2020-06-13 11:27:45');
/*!40000 ALTER TABLE `data_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `errors`
--

DROP TABLE IF EXISTS `errors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `errors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message` text DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `errors`
--

LOCK TABLES `errors` WRITE;
/*!40000 ALTER TABLE `errors` DISABLE KEYS */;
/*!40000 ALTER TABLE `errors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
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
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
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
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `exited_at` timestamp NULL DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `reader_id` varchar(100) NOT NULL,
  `tag_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `logs_user_id_index` (`user_id`),
  KEY `logs_created_at_index` (`created_at`),
  KEY `logs_deleted_at_index` (`deleted_at`),
  KEY `logs_reader_id_index` (`reader_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_items`
--

DROP TABLE IF EXISTS `menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` int(10) unsigned DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL DEFAULT '_self',
  `icon_class` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  `parameters` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_items_menu_id_foreign` (`menu_id`),
  CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_items`
--

LOCK TABLES `menu_items` WRITE;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` VALUES
(1,1,'Начало','','_self','voyager-boat','#000000',NULL,1,'2020-05-10 19:07:09','2020-05-10 20:32:51','voyager.dashboard','null'),
(3,1,'Хора','','_self','voyager-person','#000000',14,2,'2020-05-10 19:07:09','2021-01-28 16:33:15','voyager.users.index','null'),
(5,1,'Инструменти','','_self','voyager-tools','#000000',14,9,'2020-05-10 19:07:09','2021-01-28 17:26:08',NULL,''),
(6,1,'Menu Builder','','_self','voyager-list',NULL,5,3,'2020-05-10 19:07:09','2021-01-28 16:34:11','voyager.menus.index',NULL),
(7,1,'Database','','_self','voyager-data',NULL,26,1,'2020-05-10 19:07:09','2021-01-28 17:26:48','voyager.database.index',NULL),
(8,1,'Compass','','_self','voyager-compass',NULL,5,4,'2020-05-10 19:07:09','2021-01-28 16:34:11','voyager.compass.index',NULL),
(9,1,'BREAD','','_self','voyager-bread',NULL,26,2,'2020-05-10 19:07:09','2021-01-28 17:26:48','voyager.bread.index',NULL),
(10,1,'Настройки','','_self','voyager-settings','#000000',26,3,'2020-05-10 19:07:09','2021-01-28 17:26:48','voyager.settings.index','null'),
(11,1,'Hooks','','_self','voyager-hook',NULL,5,5,'2020-05-10 19:07:10','2021-01-28 16:34:11','voyager.hooks',NULL),
(12,1,'Записи','','_self','voyager-logbook','#000000',14,1,'2020-05-10 19:21:26','2021-01-28 16:33:08','voyager.logs.index','null'),
(13,1,'Четци','','_self','voyager-location','#000000',14,5,'2020-05-10 19:43:25','2021-01-28 16:33:24','voyager.readers.index','null'),
(14,1,'Администрация','','_self','voyager-settings','#000000',NULL,4,'2020-05-10 19:47:25','2021-01-28 17:26:43',NULL,''),
(15,1,'Карти','','_self','voyager-tag',NULL,14,3,'2020-05-10 21:11:18','2021-01-28 16:33:17','voyager.tags.index',NULL),
(16,1,'Отдели','','_self','voyager-company',NULL,14,4,'2020-05-11 16:23:56','2021-01-28 16:33:21','voyager.sections.index',NULL),
(17,1,'Монитор','/monitor','_self','voyager-eye','#000000',NULL,2,'2020-05-11 22:29:12','2020-05-11 22:29:25',NULL,''),
(18,1,'Отчети','/report','_self','voyager-logbook','#000000',NULL,3,'2020-05-25 05:40:04','2021-01-28 17:26:43',NULL,''),
(19,1,'Грешки','','_self','voyager-warning',NULL,14,6,'2020-06-13 11:27:45','2021-01-28 16:33:24','voyager.errors.index',NULL),
(21,1,'Медия','','_self','voyager-images',NULL,14,7,'2020-10-26 12:19:26','2021-01-28 16:33:33','voyager.media.index',NULL),
(23,1,'Роли','','_self','voyager-lock',NULL,26,4,'2020-10-26 12:19:26','2021-01-28 17:26:48','voyager.roles.index',NULL),
(24,1,'Настройки на Менюто','','_self','voyager-list',NULL,5,6,'2020-10-26 12:19:26','2021-01-28 16:34:11','voyager.menus.index',NULL),
(25,1,'База данни','','_self','voyager-data',NULL,26,5,'2020-10-26 12:19:26','2021-01-28 17:26:43','voyager.database.index',NULL),
(26,1,'Настройки','','_self',NULL,'#000000',14,8,'2021-01-28 16:32:32','2021-01-28 17:26:01',NULL,''),
(27,1,'Dashboard','','_self','voyager-boat',NULL,NULL,1,'2023-09-05 15:51:16','2023-09-05 15:51:16','voyager.dashboard',NULL),
(28,1,'Потребители','','_self','voyager-person',NULL,NULL,3,'2023-09-05 15:51:16','2023-09-05 15:51:16','voyager.users.index',NULL);
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES
(1,'admin','2020-05-10 19:07:09','2020-05-10 19:07:09');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES
(1,'2014_10_12_000000_create_users_table',1),
(2,'2016_01_01_000000_add_voyager_user_fields',1),
(3,'2016_01_01_000000_create_data_types_table',1),
(4,'2016_05_19_173453_create_menu_table',1),
(5,'2016_10_21_190000_create_roles_table',1),
(6,'2016_10_21_190000_create_settings_table',1),
(7,'2016_11_30_135954_create_permission_table',1),
(8,'2016_11_30_141208_create_permission_role_table',1),
(9,'2016_12_26_201236_data_types__add__server_side',1),
(10,'2017_01_13_000000_add_route_to_menu_items_table',1),
(11,'2017_01_14_005015_create_translations_table',1),
(12,'2017_01_15_000000_make_table_name_nullable_in_permissions_table',1),
(13,'2017_03_06_000000_add_controller_to_data_types_table',1),
(14,'2017_04_21_000000_add_order_to_data_rows_table',1),
(15,'2017_07_05_210000_add_policyname_to_data_types_table',1),
(16,'2017_08_05_000000_add_group_to_settings_table',1),
(17,'2017_11_26_013050_add_user_role_relationship',1),
(18,'2017_11_26_015000_create_user_roles_table',1),
(19,'2018_03_11_000000_add_user_settings',1),
(20,'2018_03_14_000000_add_details_to_data_types_table',1),
(21,'2018_03_16_000000_make_settings_value_nullable',1),
(22,'2019_08_19_000000_create_failed_jobs_table',1),
(24,'2020_05_19_212704_create_websockets_statistics_entries_table',2),
(25,'2020_10_28_010747_create_jobs_table',3),
(26,'2020_10_28_012615_create_notifications_table',3);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_role`
--

DROP TABLE IF EXISTS `permission_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_role` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_permission_id_index` (`permission_id`),
  KEY `permission_role_role_id_index` (`role_id`),
  CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_role`
--

LOCK TABLES `permission_role` WRITE;
/*!40000 ALTER TABLE `permission_role` DISABLE KEYS */;
INSERT INTO `permission_role` VALUES
(1,1),
(1,2),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1),
(11,1),
(12,1),
(13,1),
(14,1),
(15,1),
(16,1),
(17,1),
(18,1),
(19,1),
(20,1),
(21,1),
(22,1),
(23,1),
(24,1),
(25,1),
(26,1),
(27,1),
(27,2),
(28,1),
(28,2),
(29,1),
(30,1),
(31,1),
(32,1),
(33,1),
(34,1),
(35,1),
(36,1),
(37,1),
(38,1),
(39,1),
(40,1),
(41,1),
(42,1),
(43,1),
(44,1),
(45,1),
(46,1),
(47,1),
(48,1),
(49,1),
(50,1),
(51,1);
/*!40000 ALTER TABLE `permission_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permissions_key_index` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES
(1,'browse_admin',NULL,'2020-05-10 19:07:10','2020-05-10 19:07:10'),
(2,'browse_bread',NULL,'2020-05-10 19:07:10','2020-05-10 19:07:10'),
(3,'browse_database',NULL,'2020-05-10 19:07:10','2020-05-10 19:07:10'),
(4,'browse_media',NULL,'2020-05-10 19:07:10','2020-05-10 19:07:10'),
(5,'browse_compass',NULL,'2020-05-10 19:07:10','2020-05-10 19:07:10'),
(6,'browse_menus','menus','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(7,'read_menus','menus','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(8,'edit_menus','menus','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(9,'add_menus','menus','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(10,'delete_menus','menus','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(11,'browse_roles','roles','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(12,'read_roles','roles','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(13,'edit_roles','roles','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(14,'add_roles','roles','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(15,'delete_roles','roles','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(16,'browse_users','users','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(17,'read_users','users','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(18,'edit_users','users','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(19,'add_users','users','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(20,'delete_users','users','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(21,'browse_settings','settings','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(22,'read_settings','settings','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(23,'edit_settings','settings','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(24,'add_settings','settings','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(25,'delete_settings','settings','2020-05-10 19:07:10','2020-05-10 19:07:10'),
(26,'browse_hooks',NULL,'2020-05-10 19:07:10','2020-05-10 19:07:10'),
(27,'browse_logs','logs','2020-05-10 19:21:26','2020-05-10 19:21:26'),
(28,'read_logs','logs','2020-05-10 19:21:26','2020-05-10 19:21:26'),
(29,'edit_logs','logs','2020-05-10 19:21:26','2020-05-10 19:21:26'),
(30,'add_logs','logs','2020-05-10 19:21:26','2020-05-10 19:21:26'),
(31,'delete_logs','logs','2020-05-10 19:21:26','2020-05-10 19:21:26'),
(32,'browse_readers','readers','2020-05-10 19:43:25','2020-05-10 19:43:25'),
(33,'read_readers','readers','2020-05-10 19:43:25','2020-05-10 19:43:25'),
(34,'edit_readers','readers','2020-05-10 19:43:25','2020-05-10 19:43:25'),
(35,'add_readers','readers','2020-05-10 19:43:25','2020-05-10 19:43:25'),
(36,'delete_readers','readers','2020-05-10 19:43:25','2020-05-10 19:43:25'),
(37,'browse_tags','tags','2020-05-10 21:11:18','2020-05-10 21:11:18'),
(38,'read_tags','tags','2020-05-10 21:11:18','2020-05-10 21:11:18'),
(39,'edit_tags','tags','2020-05-10 21:11:18','2020-05-10 21:11:18'),
(40,'add_tags','tags','2020-05-10 21:11:18','2020-05-10 21:11:18'),
(41,'delete_tags','tags','2020-05-10 21:11:18','2020-05-10 21:11:18'),
(42,'browse_sections','sections','2020-05-11 16:23:56','2020-05-11 16:23:56'),
(43,'read_sections','sections','2020-05-11 16:23:56','2020-05-11 16:23:56'),
(44,'edit_sections','sections','2020-05-11 16:23:56','2020-05-11 16:23:56'),
(45,'add_sections','sections','2020-05-11 16:23:56','2020-05-11 16:23:56'),
(46,'delete_sections','sections','2020-05-11 16:23:56','2020-05-11 16:23:56'),
(47,'browse_errors','errors','2020-06-13 11:27:45','2020-06-13 11:27:45'),
(48,'read_errors','errors','2020-06-13 11:27:45','2020-06-13 11:27:45'),
(49,'edit_errors','errors','2020-06-13 11:27:45','2020-06-13 11:27:45'),
(50,'add_errors','errors','2020-06-13 11:27:45','2020-06-13 11:27:45'),
(51,'delete_errors','errors','2020-06-13 11:27:45','2020-06-13 11:27:45');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `readers`
--

DROP TABLE IF EXISTS `readers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `readers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `mac` varchar(100) DEFAULT NULL,
  `stats` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`stats`)),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `readers`
--

LOCK TABLES `readers` WRITE;
/*!40000 ALTER TABLE `readers` DISABLE KEYS */;
/*!40000 ALTER TABLE `readers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES
(1,'admin','Администратор','2020-05-10 19:07:09','2020-05-10 20:37:33'),
(2,'user','Служител','2020-05-10 19:07:10','2020-05-10 20:37:20');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `details` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `group` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES
(1,'site.title','Site Title','Nikdim','','text',1,'Site'),
(2,'site.description','Site Description','Personnel Tracking','','text',2,'Site'),
(3,'site.logo','Site Logo','settings/November2020/iFm8H3bKdYjDXYFY7cop.png','','image',3,'Site'),
(4,'site.google_analytics_tracking_id','Google Analytics Tracking ID',NULL,'','text',4,'Site'),
(5,'admin.bg_image','Admin Background Image','settings/May2020/K0nlYbNESoYKgj0D3wvk.jpg','','image',5,'Admin'),
(6,'admin.title','Admin Title','Nikdim','','text',1,'Admin'),
(7,'admin.description','Admin Description','Raffy от NetShell','','text',2,'Admin'),
(8,'admin.loader','Admin Loader','','','image',3,'Admin'),
(9,'admin.icon_image','Admin Icon Image','settings/November2020/vGPKnJOVnwP8u7uNPCQB.png','','image',4,'Admin'),
(10,'admin.google_analytics_client_id','Google Analytics Client ID (used for admin dashboard)',NULL,'','text',1,'Admin'),
(11,'site.workday_start','Работно време - начало','08:00',NULL,'text',6,'Site'),
(12,'site.workday_end','Работно време - край','17:00',NULL,'text',7,'Site'),
(13,'site.open_time','Време за отключване','3',NULL,'text',8,'Site'),
(14,'site.overwrite_time','Толеранс за неуспешен вход','1',NULL,'text',9,'Site');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(255) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translations`
--

DROP TABLE IF EXISTS `translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(255) NOT NULL,
  `column_name` varchar(255) NOT NULL,
  `foreign_key` int(10) unsigned NOT NULL,
  `locale` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `translations_table_name_column_name_foreign_key_locale_unique` (`table_name`,`column_name`,`foreign_key`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translations`
--

LOCK TABLES `translations` WRITE;
/*!40000 ALTER TABLE `translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `user_roles_user_id_index` (`user_id`),
  KEY `user_roles_role_id_index` (`role_id`),
  CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,1,'Администратор','ash@rain.com','users/January2021/fAoL4bTN2L70e6xJ0DCo.jpg',NULL,'$2y$10$a5bhE1KIuRKe3K6hub8uXeFN9dd0/XTrVXORhqmF.rQsuvj4oWT9y','mpdGpJYs6iGAGDT9d2cvBCpln7P1N22iqE7FvijO3wdpVQhZ9p3pRsGeTQTF','{\"locale\":\"bg\"}','2020-05-10 19:08:35','2021-01-20 12:57:26',11);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `websockets_statistics_entries`
--

DROP TABLE IF EXISTS `websockets_statistics_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `websockets_statistics_entries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `app_id` varchar(255) NOT NULL,
  `peak_connection_count` int(11) NOT NULL,
  `websocket_message_count` int(11) NOT NULL,
  `api_message_count` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `websockets_statistics_entries`
--

LOCK TABLES `websockets_statistics_entries` WRITE;
/*!40000 ALTER TABLE `websockets_statistics_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `websockets_statistics_entries` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-05 13:13:55

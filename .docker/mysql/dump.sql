-- MySQL dump 10.17  Distrib 10.3.22-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: raffy
-- ------------------------------------------------------
-- Server version	10.3.22-MariaDB-1ubuntu1

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
  `field` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `browse` tinyint(1) NOT NULL DEFAULT 1,
  `read` tinyint(1) NOT NULL DEFAULT 1,
  `edit` tinyint(1) NOT NULL DEFAULT 1,
  `add` tinyint(1) NOT NULL DEFAULT 1,
  `delete` tinyint(1) NOT NULL DEFAULT 1,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `data_rows_data_type_id_foreign` (`data_type_id`),
  CONSTRAINT `data_rows_data_type_id_foreign` FOREIGN KEY (`data_type_id`) REFERENCES `data_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_rows`
--

LOCK TABLES `data_rows` WRITE;
/*!40000 ALTER TABLE `data_rows` DISABLE KEYS */;
INSERT INTO `data_rows` VALUES (1,1,'id','number','ID',1,0,0,0,0,0,'{}',1),(2,1,'name','text','Име',1,1,1,1,1,1,'{}',2),(3,1,'email','text','Email',1,1,1,1,1,1,'{}',3),(4,1,'password','password','Парола',1,0,0,1,1,0,'{}',4),(5,1,'remember_token','text','Remember Token',0,0,0,0,0,0,'{}',5),(6,1,'created_at','timestamp','Регистриран на',0,1,1,0,0,0,'{}',6),(7,1,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',8),(8,1,'avatar','image','Снимка',0,1,1,1,1,1,'{}',9),(9,1,'user_belongsto_role_relationship','relationship','Роля',0,1,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsTo\",\"column\":\"role_id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"roles\",\"pivot\":\"0\",\"taggable\":\"0\"}',11),(10,1,'user_belongstomany_role_relationship','relationship','Роли',0,0,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"user_roles\",\"pivot\":\"1\",\"taggable\":\"0\"}',12),(11,1,'settings','hidden','Settings',0,0,0,0,0,0,'{}',15),(12,2,'id','number','ID',1,0,0,0,0,0,NULL,1),(13,2,'name','text','Name',1,1,1,1,1,1,NULL,2),(14,2,'created_at','timestamp','Created At',0,0,0,0,0,0,NULL,3),(15,2,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,4),(16,3,'id','number','ID',1,0,0,0,0,0,NULL,1),(17,3,'name','text','Name',1,1,1,1,1,1,NULL,2),(18,3,'created_at','timestamp','Created At',0,0,0,0,0,0,NULL,3),(19,3,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,4),(20,3,'display_name','text','Display Name',1,1,1,1,1,1,NULL,5),(21,1,'role_id','text','Role',0,1,1,1,1,1,'{}',10),(22,5,'id','text','Id',1,0,0,0,0,0,'{}',1),(23,5,'deleted_at','timestamp','Deleted At',0,0,0,0,0,0,'{}',2),(24,5,'created_at','timestamp','Вход',0,1,1,1,0,1,'{\"format\":\"%d\\/%m\\/%y %H:%M:%S\"}',3),(26,5,'user_id','text','User',1,1,1,1,1,1,'{}',5),(27,5,'log_belongsto_user_relationship','relationship','Работник',0,1,1,1,1,1,'{\"model\":\"App\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"user_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"data_rows\",\"pivot\":\"0\",\"taggable\":\"0\"}',6),(28,6,'id','text','Id',1,0,0,0,0,0,'{}',1),(29,6,'name','text','Име',1,1,1,1,1,1,'{}',2),(30,6,'created_at','timestamp','Регистриран на',0,1,1,1,0,1,'{}',3),(31,6,'order','number','Ред',0,1,1,1,0,1,'{}',6),(32,6,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',4),(33,5,'log_belongsto_reader_relationship','relationship','Четец',0,1,1,1,1,1,'{\"model\":\"App\\\\Reader\",\"table\":\"readers\",\"type\":\"belongsTo\",\"column\":\"reader_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"data_rows\",\"pivot\":\"0\",\"taggable\":\"0\"}',7),(34,5,'reader_id','text','Reader',1,1,1,1,1,1,'{}',6),(35,1,'email_verified_at','timestamp','Email потвърден на',0,1,1,1,1,1,'{}',7),(36,7,'id','text','Id',1,0,0,0,0,0,'{}',1),(37,7,'tag','text','Номер',1,1,1,1,1,1,'{}',2),(38,7,'user_id','text','User Id',1,1,1,1,1,1,'{}',3),(39,7,'created_at','timestamp','Регистриран на',0,1,1,1,0,1,'{}',4),(40,7,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',5),(41,7,'tag_belongsto_user_relationship','relationship','Работник',0,1,1,1,1,1,'{\"model\":\"App\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"user_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"data_rows\",\"pivot\":\"0\",\"taggable\":\"0\"}',6),(42,5,'log_belongsto_tag_relationship','relationship','Карта',0,1,1,1,1,1,'{\"model\":\"App\\\\Tag\",\"table\":\"tags\",\"type\":\"belongsTo\",\"column\":\"tag_id\",\"key\":\"id\",\"label\":\"tag\",\"pivot_table\":\"data_rows\",\"pivot\":\"0\",\"taggable\":\"0\"}',8),(43,5,'tag_id','text','Tag Id',1,1,1,1,1,1,'{}',7),(44,6,'mac','text','MAC',0,1,1,1,1,1,'{}',5),(45,8,'id','text','Id',1,0,0,0,0,0,'{}',1),(46,8,'name','text','Име',0,1,1,1,1,1,'{}',2),(47,8,'created_at','timestamp','Регистриран на',0,1,1,1,0,1,'{}',3),(48,8,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',4),(49,1,'user_belongsto_section_relationship','relationship','Отдел',0,1,1,1,1,1,'{\"model\":\"App\\\\Section\",\"table\":\"sections\",\"type\":\"belongsTo\",\"column\":\"section_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"data_rows\",\"pivot\":\"0\",\"taggable\":\"0\"}',14),(50,1,'section_id','text','Section Id',0,1,1,1,1,1,'{}',13),(51,5,'exited_at','timestamp','Изход',0,1,1,1,1,1,'{\"format\":\"%d\\/%m\\/%y %H:%M:%S\",\"datepicker\":{\"format\":\"DD-MM-YYYY\"}}',4),(52,9,'id','text','Id',1,0,0,0,0,0,'{}',1),(53,9,'message','text','Съобщение',0,1,1,1,1,1,'{}',2),(54,9,'type','text','Тип',0,1,1,1,1,1,'{}',3),(55,9,'created_at','timestamp','Записана на',0,1,1,1,0,1,'{}',4),(56,9,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',5);
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_singular` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_plural` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `policy_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `controller` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generate_permissions` tinyint(1) NOT NULL DEFAULT 0,
  `server_side` tinyint(4) NOT NULL DEFAULT 0,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
INSERT INTO `data_types` VALUES (1,'users','users','Човек','Хора','voyager-person','TCG\\Voyager\\Models\\User','TCG\\Voyager\\Policies\\UserPolicy','TCG\\Voyager\\Http\\Controllers\\VoyagerUserController',NULL,1,0,'{\"order_column\":\"name\",\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":\"name\",\"scope\":null}','2020-05-10 19:07:09','2020-05-15 06:13:38'),(2,'menus','menus','Menu','Menus','voyager-list','TCG\\Voyager\\Models\\Menu',NULL,'','',1,0,NULL,'2020-05-10 19:07:09','2020-05-10 19:07:09'),(3,'roles','roles','Role','Roles','voyager-lock','TCG\\Voyager\\Models\\Role',NULL,'TCG\\Voyager\\Http\\Controllers\\VoyagerRoleController','',1,0,NULL,'2020-05-10 19:07:09','2020-05-10 19:07:09'),(5,'logs','logs','Запис','Записи','voyager-logbook','App\\Log',NULL,NULL,NULL,1,1,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2020-05-10 19:21:26','2020-05-25 06:10:25'),(6,'readers','readers','Четец','Четци','voyager-location','App\\Reader',NULL,NULL,'Reader devices in the domain.',1,0,'{\"order_column\":\"order\",\"order_display_column\":\"name\",\"order_direction\":\"asc\",\"default_search_key\":\"name\",\"scope\":null}','2020-05-10 19:43:25','2020-06-13 11:58:49'),(7,'tags','tags','Карта','Карти','voyager-credit-cards','App\\Tag',NULL,NULL,NULL,1,1,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2020-05-10 21:11:18','2020-05-11 08:49:56'),(8,'sections','sections','Отдел','Отдели','voyager-company','App\\Section',NULL,NULL,NULL,1,0,'{\"order_column\":\"name\",\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":\"name\",\"scope\":null}','2020-05-11 16:23:56','2020-05-11 16:28:42'),(9,'errors','errors','Грешка','Грешки','voyager-warning','App\\Error',NULL,NULL,NULL,1,1,'{\"order_column\":\"created_at\",\"order_display_column\":\"created_at\",\"order_direction\":\"desc\",\"default_search_key\":\"message\"}','2020-06-13 11:27:45','2020-06-13 11:27:45');
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
  `message` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `errors`
--

LOCK TABLES `errors` WRITE;
/*!40000 ALTER TABLE `errors` DISABLE KEYS */;
INSERT INTO `errors` VALUES (53,'Непозната карта \"785538939246\" от четец \"Главен портал\".','Карта','2020-07-03 17:58:12','2020-07-03 17:58:12'),(54,'Непозната карта \"508248415119\" от четец \"Главен портал\".','Карта','2020-08-10 09:15:50','2020-08-10 09:15:50'),(55,'Непозната карта \"508248415119\" от четец \"Главен портал\".','Карта','2020-08-10 09:15:54','2020-08-10 09:15:54'),(56,'Непозната карта \"785538939246\" от четец \"Главен портал\".','Карта','2020-08-10 14:31:30','2020-08-10 14:31:30'),(57,'Непозната карта \"785538939246\" от четец \"Главен портал\".','Карта','2020-08-10 14:31:36','2020-08-10 14:31:36'),(58,'Непозната карта \"785538939246\" от четец \"Главен портал\".','Карта','2020-08-10 14:31:38','2020-08-10 14:31:38'),(59,'Непозната карта \"785538939246\" от четец \"Главен портал\".','Карта','2020-08-10 14:31:41','2020-08-10 14:31:41'),(60,'Непозната карта \"508248415119\" от четец \"Главен портал\".','Карта','2020-08-10 14:32:53','2020-08-10 14:32:53'),(61,'Непозната карта \"785538939246\" от четец \"Главен портал\".','Карта','2020-08-10 16:15:15','2020-08-10 16:15:15'),(62,'Непозната карта \"508248415119\" от четец \"Главен портал\".','Карта','2020-08-10 16:20:28','2020-08-10 16:20:28'),(63,'Непозната карта \"508248415119\" от четец \"Главен портал\".','Карта','2020-08-10 16:20:33','2020-08-10 16:20:33'),(64,'Непозната карта \"508248415119\" от четец \"Главен портал\".','Карта','2020-08-10 16:20:57','2020-08-10 16:20:57'),(65,'Непозната карта \"508248415119\" от четец \"Главен портал\".','Карта','2020-08-10 16:21:00','2020-08-10 16:21:00'),(66,'Непозната карта \"508248415119\" от четец \"Главен портал\".','Карта','2020-08-10 16:22:08','2020-08-10 16:22:08'),(67,'Непозната карта \"785538939246\" от четец \"Главен портал\".','Карта','2020-09-04 16:23:43','2020-09-04 16:23:43');
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
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `reader_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tag_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `logs_user_id_index` (`user_id`),
  KEY `logs_created_at_index` (`created_at`),
  KEY `logs_deleted_at_index` (`deleted_at`),
  KEY `logs_reader_id_index` (`reader_id`)
) ENGINE=InnoDB AUTO_INCREMENT=299 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES (134,NULL,'2020-05-26 07:20:43','2020-05-26 07:34:20',1,'1',1),(135,NULL,'2020-05-26 07:34:22','2020-05-26 07:35:01',1,'1',1),(136,NULL,'2020-05-26 10:36:59','2020-05-26 10:37:04',1,'1',1),(137,NULL,'2020-05-26 10:38:03','2020-05-26 10:38:13',1,'1',1),(138,NULL,'2020-05-26 10:38:41','2020-05-26 10:38:45',3,'1',2),(139,NULL,'2020-05-26 10:38:51','2020-05-26 10:39:09',3,'1',2),(140,NULL,'2020-05-26 10:40:14','2020-05-26 10:40:17',1,'1',1),(141,NULL,'2020-05-26 10:44:50','2020-05-26 10:44:55',1,'1',1),(142,NULL,'2020-05-26 10:45:12','2020-05-26 10:46:39',1,'1',1),(143,NULL,'2020-05-26 10:49:19','2020-05-26 10:50:05',1,'1',1),(144,NULL,'2020-05-26 10:51:11','2020-05-26 10:51:17',1,'1',1),(145,NULL,'2020-05-26 10:51:22','2020-05-26 10:51:25',1,'1',1),(146,NULL,'2020-05-26 10:51:41','2020-05-26 10:52:14',3,'1',2),(147,NULL,'2020-05-26 10:52:51','2020-05-26 10:52:55',3,'1',2),(148,NULL,'2020-05-26 10:56:18','2020-05-26 10:56:21',3,'1',2),(149,NULL,'2020-05-26 10:58:00','2020-05-26 10:58:36',3,'1',2),(150,NULL,'2020-05-26 10:58:41','2020-05-26 10:59:28',3,'1',2),(151,NULL,'2020-05-26 11:00:46','2020-05-26 11:00:51',3,'1',2),(152,NULL,'2020-05-26 11:01:26','2020-05-26 11:01:30',3,'1',2),(153,NULL,'2020-05-26 11:40:06','2020-05-26 11:40:15',1,'1',1),(154,NULL,'2020-05-26 11:45:15','2020-05-26 11:45:18',3,'1',2),(155,NULL,'2020-05-26 11:47:31','2020-05-26 11:47:35',1,'1',1),(156,NULL,'2020-05-26 11:48:13','2020-05-26 11:48:16',3,'1',2),(157,NULL,'2020-05-26 11:49:56','2020-05-26 11:49:58',1,'1',1),(158,NULL,'2020-05-26 11:51:03','2020-05-26 11:51:07',3,'1',2),(159,NULL,'2020-05-26 11:52:22','2020-05-26 11:52:27',1,'1',1),(160,NULL,'2020-05-26 11:53:01','2020-05-26 11:53:05',3,'1',2),(161,NULL,'2020-05-26 11:55:00','2020-05-26 14:55:00',3,'1',2),(162,NULL,'2020-05-26 19:33:18','2020-05-26 19:33:25',1,'1',1),(163,NULL,'2020-05-26 19:33:34','2020-05-26 19:33:41',1,'1',1),(164,NULL,'2020-05-26 19:34:03','2020-05-26 19:36:35',1,'1',1),(165,NULL,'2020-05-27 13:18:25','2020-05-27 17:36:11',3,'1',2),(166,NULL,'2020-05-28 12:24:19','2020-05-28 12:24:31',3,'1',2),(167,NULL,'2020-05-28 12:24:26','2020-05-28 12:35:37',1,'1',1),(168,NULL,'2020-05-28 19:12:53','2020-05-28 19:13:13',3,'1',2),(169,NULL,'2020-05-28 19:13:02','2020-05-28 19:16:31',1,'1',1),(170,NULL,'2020-05-28 19:16:26','2020-05-28 19:26:30',3,'1',2),(171,NULL,'2020-05-28 19:49:14','2020-05-28 19:50:50',3,'1',2),(172,NULL,'2020-05-28 19:49:57','2020-05-28 20:24:27',1,'1',1),(173,NULL,'2020-05-29 08:37:51','2020-05-29 14:13:09',1,'1',1),(174,NULL,'2020-05-29 08:37:57','2020-05-29 14:13:23',3,'1',2),(175,NULL,'2020-05-29 18:13:50','2020-05-29 18:14:03',3,'1',2),(176,NULL,'2020-06-02 14:08:04','2020-06-02 14:08:28',1,'1',1),(177,NULL,'2020-06-02 14:08:15','2020-06-02 19:03:49',3,'1',2),(178,NULL,'2020-06-04 12:03:03','2020-06-04 12:40:58',1,'1',1),(179,NULL,'2020-06-04 12:03:22','2020-06-04 12:59:49',3,'1',2),(180,NULL,'2020-06-04 12:59:54','2020-06-04 13:15:48',1,'1',1),(185,NULL,'2020-06-06 10:36:53','2020-06-06 10:42:17',3,'1',2),(186,NULL,'2020-06-06 10:44:31','2020-06-06 10:50:12',3,'1',2),(187,NULL,'2020-06-06 10:55:58','2020-06-06 11:00:23',3,'1',2),(188,NULL,'2020-06-06 11:01:19','2020-06-06 15:10:53',3,'1',2),(189,NULL,'2020-06-06 15:12:51','2020-06-06 15:14:56',3,'1',2),(190,NULL,'2020-06-06 15:17:43','2020-06-06 15:25:34',3,'1',2),(191,NULL,'2020-06-06 15:28:39','2020-06-06 20:29:17',3,'1',2),(192,NULL,'2020-06-06 20:31:00','2020-06-07 22:52:00',3,'1',2),(193,NULL,'2020-06-13 23:02:06','2020-06-16 15:52:12',3,'1',2),(194,NULL,'2020-06-15 21:50:10','2020-06-15 21:57:09',3,'2',2),(195,NULL,'2020-06-16 15:47:42','2020-06-16 16:47:20',3,'2',2),(196,NULL,'2020-06-16 16:51:55','2020-06-16 17:01:20',3,'2',2),(197,NULL,'2020-06-16 17:03:27','2020-06-16 17:46:49',3,'1',2),(198,NULL,'2020-06-16 17:03:16','2020-06-16 17:52:58',3,'2',2),(201,NULL,'2020-06-29 19:06:59','2020-06-29 19:21:26',3,'2',2),(202,NULL,'2020-06-29 19:21:30','2020-06-29 19:25:07',3,'2',2),(203,NULL,'2020-06-29 19:25:15','2020-06-29 19:28:18',3,'2',2),(204,NULL,'2020-06-29 19:28:30','2020-07-02 17:40:24',3,'2',2),(205,NULL,'2020-07-02 17:41:00','2020-07-02 17:45:41',3,'2',2),(206,NULL,'2020-07-02 17:47:39','2020-07-02 17:50:57',3,'2',2),(207,NULL,'2020-07-02 17:52:26','2020-07-02 20:17:30',3,'2',2),(208,NULL,'2020-07-02 20:25:23','2020-07-02 20:45:12',3,'2',2),(209,NULL,'2020-07-02 20:47:02','2020-07-03 07:27:08',3,'2',2),(210,NULL,'2020-07-03 07:28:05','2020-07-03 17:52:38',3,'2',2),(211,NULL,'2020-07-03 17:51:03','2020-07-03 17:56:59',3,'1',2),(212,NULL,'2020-07-03 17:59:44','2020-07-03 18:06:03',3,'1',2),(213,NULL,'2020-07-03 17:58:00','2020-07-04 18:54:00',1,'1',1),(214,NULL,'2020-07-03 18:06:09','2020-07-03 18:06:14',3,'1',2),(215,NULL,'2020-07-03 18:08:41','2020-07-03 18:08:47',3,'1',2),(216,NULL,'2020-07-03 18:24:04','2020-07-03 18:24:12',3,'1',2),(217,NULL,'2020-07-03 18:24:22','2020-07-03 18:24:28',3,'1',2),(218,NULL,'2020-07-03 18:24:38','2020-07-03 18:28:57',3,'1',2),(219,NULL,'2020-07-03 18:29:57','2020-07-03 18:36:43',3,'1',2),(220,NULL,'2020-08-04 18:54:33','2020-08-07 06:45:13',1,'1',1),(221,NULL,'2020-08-07 11:44:58','2020-08-07 11:55:07',1,'1',1),(222,NULL,'2020-08-07 11:56:02','2020-08-07 11:57:21',1,'1',1),(223,NULL,'2020-08-07 11:58:46','2020-08-07 12:00:46',3,'1',2),(224,NULL,'2020-08-07 11:58:22','2020-08-07 11:59:27',1,'1',1),(225,NULL,'2020-08-07 12:01:11','2020-08-07 12:04:24',3,'1',2),(226,NULL,'2020-08-07 12:45:51','2020-08-07 12:47:07',3,'1',2),(227,NULL,'2020-08-07 12:47:56','2020-08-07 12:49:04',1,'1',1),(228,NULL,'2020-08-07 12:47:51','2020-08-07 12:49:38',3,'1',2),(229,NULL,'2020-08-07 12:49:51','2020-08-10 09:17:00',1,'1',1),(230,NULL,'2020-08-07 17:07:39','2020-08-10 09:15:03',3,'1',2),(231,NULL,'2020-08-10 09:16:03','2020-08-10 14:32:06',3,'1',2),(232,NULL,'2020-08-10 09:17:15','2020-08-10 14:26:20',1,'1',1),(233,NULL,'2020-08-10 14:26:25','2020-08-10 16:15:26',1,'1',1),(234,NULL,'2020-08-10 14:32:59','2020-08-10 14:36:21',3,'1',2),(235,NULL,'2020-08-10 14:51:43','2020-08-10 15:58:37',3,'1',2),(236,NULL,'2020-08-10 15:58:55','2020-08-10 16:05:57',3,'1',2),(237,NULL,'2020-08-10 16:06:02','2020-08-10 16:14:18',3,'1',2),(238,NULL,'2020-08-10 16:15:00','2020-08-10 16:20:43',3,'1',2),(239,NULL,'2020-08-10 16:21:25','2020-09-03 13:58:26',3,'1',2),(240,NULL,'2020-08-10 16:23:18','2020-08-10 16:24:33',4,'1',3),(241,NULL,'2020-08-10 16:25:49','2020-08-11 12:02:49',4,'1',3),(242,NULL,'2020-08-10 16:25:45','2020-08-11 12:04:50',1,'1',1),(243,NULL,'2020-08-11 12:03:11','2020-08-11 12:04:23',4,'1',3),(244,NULL,'2020-09-03 13:58:16','2020-09-03 15:11:49',4,'1',3),(245,NULL,'2020-09-03 15:12:34','2020-09-03 15:22:46',4,'1',3),(246,NULL,'2020-09-03 15:24:43','2020-09-03 15:34:25',4,'1',3),(247,NULL,'2020-09-03 15:24:53','2020-09-03 16:00:54',3,'1',2),(248,NULL,'2020-09-03 15:35:02','2020-09-03 16:29:11',4,'1',3),(249,NULL,'2020-09-03 16:01:57','2020-09-03 16:12:33',3,'1',2),(250,NULL,'2020-09-03 16:16:26','2020-09-03 16:22:58',3,'1',2),(251,NULL,'2020-09-03 16:30:47','2020-09-03 16:35:28',4,'1',3),(252,NULL,'2020-09-03 16:36:06','2020-09-03 16:37:38',4,'1',3),(253,NULL,'2020-09-03 16:36:00','2020-09-04 16:22:55',3,'1',2),(254,NULL,'2020-09-03 16:39:37','2020-09-04 16:22:47',4,'1',3),(255,NULL,'2020-09-04 16:23:18','2020-09-04 16:24:30',3,'1',2),(256,NULL,'2020-09-04 16:24:44','2020-09-08 16:10:17',4,'1',3),(257,NULL,'2020-09-04 16:23:48','2020-09-04 16:25:01',1,'1',1),(258,NULL,'2020-09-04 16:24:50','2020-09-08 16:10:08',3,'1',2),(259,NULL,'2020-09-04 16:25:18','2020-09-08 16:11:43',1,'1',1),(260,NULL,'2020-09-08 16:10:57','2020-09-08 16:12:14',4,'1',3),(261,NULL,'2020-09-08 16:11:10','2020-09-08 16:12:21',3,'1',2),(262,NULL,'2020-09-08 16:13:08','2020-09-08 16:48:49',4,'1',3),(263,NULL,'2020-09-08 16:13:36','2020-09-08 16:39:29',3,'1',2),(264,NULL,'2020-09-08 16:41:17','2020-09-08 16:42:38',3,'1',2),(265,NULL,'2020-09-08 16:46:37','2020-09-08 16:48:34',3,'1',2),(266,NULL,'2020-09-08 16:48:28','2020-10-05 16:41:16',1,'1',1),(267,NULL,'2020-09-08 16:55:30','2020-09-16 15:20:37',3,'1',2),(268,NULL,'2020-09-16 15:21:38','2020-09-16 15:23:09',4,'1',3),(269,NULL,'2020-09-16 15:21:45','2020-09-16 15:23:50',3,'1',2),(270,NULL,'2020-09-16 15:23:40','2020-09-16 15:25:50',4,'1',3),(271,NULL,'2020-09-16 15:25:41','2020-09-16 15:27:34',3,'1',2),(272,NULL,'2020-09-16 15:28:08','2020-09-16 16:04:19',4,'1',3),(273,NULL,'2020-09-16 15:28:00','2020-09-16 16:03:56',3,'1',2),(274,NULL,'2020-09-16 16:04:10','2020-09-16 16:06:07',3,'1',2),(275,NULL,'2020-09-16 16:07:09','2020-09-16 16:08:18',4,'1',3),(276,NULL,'2020-09-16 16:06:56','2020-09-16 16:09:36',3,'1',2),(277,NULL,'2020-09-16 16:09:30','2020-09-16 16:11:28',4,'1',3),(278,NULL,'2020-09-16 16:11:14','2020-09-16 16:12:20',3,'1',2),(279,NULL,'2020-09-16 16:12:12','2020-09-16 16:15:11',4,'1',3),(280,NULL,'2020-09-16 16:12:25','2020-10-05 08:19:35',3,'1',2),(281,NULL,'2020-09-16 16:18:18','2020-09-16 17:12:32',4,'1',3),(282,NULL,'2020-09-16 17:17:26','2020-09-16 17:24:57',4,'1',3),(283,NULL,'2020-09-16 17:25:33','2020-09-17 07:18:43',4,'1',3),(284,NULL,'2020-09-17 07:19:23','2020-09-17 17:12:06',4,'1',3),(285,NULL,'2020-09-17 17:13:33','2020-09-18 07:18:38',4,'1',3),(286,NULL,'2020-09-18 07:18:49','2020-09-18 17:15:24',4,'1',3),(287,NULL,'2020-09-18 17:17:03','2020-09-23 07:28:30',4,'1',3),(288,NULL,'2020-09-23 07:28:35','2020-09-24 07:18:07',4,'1',3),(289,NULL,'2020-09-24 07:18:26','2020-09-25 17:14:12',4,'1',3),(290,NULL,'2020-09-25 17:15:25','2020-10-02 10:24:57',4,'1',3),(291,NULL,'2020-10-02 10:26:12',NULL,4,'1',3),(292,NULL,'2020-10-05 08:20:22','2020-10-05 08:42:07',3,'1',2),(293,NULL,'2020-10-05 08:42:11','2020-10-05 08:46:05',3,'1',2),(294,NULL,'2020-10-05 08:48:06','2020-10-05 13:45:03',3,'1',2),(295,NULL,'2020-10-05 13:45:14','2020-10-05 16:40:50',3,'1',2),(296,NULL,'2020-10-05 16:41:57',NULL,1,'1',1),(297,NULL,'2020-10-05 16:49:41','2020-10-05 17:10:38',3,'1',2),(298,NULL,'2020-10-05 17:10:53',NULL,3,'1',2);
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
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '_self',
  `icon_class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameters` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_items_menu_id_foreign` (`menu_id`),
  CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_items`
--

LOCK TABLES `menu_items` WRITE;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` VALUES (1,1,'Начало','','_self','voyager-boat','#000000',NULL,1,'2020-05-10 19:07:09','2020-05-10 20:32:51','voyager.dashboard','null'),(2,1,'Файлове','','_self','voyager-images','#000000',5,1,'2020-05-10 19:07:09','2020-05-25 05:40:50','voyager.media.index','null'),(3,1,'Хора','','_self','voyager-person','#000000',14,2,'2020-05-10 19:07:09','2020-05-25 05:40:28','voyager.users.index','null'),(4,1,'Roles','','_self','voyager-lock',NULL,5,5,'2020-05-10 19:07:09','2020-05-25 05:40:47','voyager.roles.index',NULL),(5,1,'Инструменти','','_self','voyager-tools','#000000',NULL,6,'2020-05-10 19:07:09','2020-06-15 21:56:20',NULL,''),(6,1,'Menu Builder','','_self','voyager-list',NULL,5,6,'2020-05-10 19:07:09','2020-05-25 05:40:47','voyager.menus.index',NULL),(7,1,'Database','','_self','voyager-data',NULL,5,4,'2020-05-10 19:07:09','2020-05-25 05:40:53','voyager.database.index',NULL),(8,1,'Compass','','_self','voyager-compass',NULL,5,7,'2020-05-10 19:07:09','2020-05-25 05:40:47','voyager.compass.index',NULL),(9,1,'BREAD','','_self','voyager-bread',NULL,5,3,'2020-05-10 19:07:09','2020-05-25 05:40:53','voyager.bread.index',NULL),(10,1,'Настройки','','_self','voyager-settings','#000000',5,2,'2020-05-10 19:07:09','2020-05-25 05:40:53','voyager.settings.index','null'),(11,1,'Hooks','','_self','voyager-hook',NULL,5,8,'2020-05-10 19:07:10','2020-05-25 05:40:47','voyager.hooks',NULL),(12,1,'Записи','','_self','voyager-logbook','#000000',14,1,'2020-05-10 19:21:26','2020-05-25 05:40:28','voyager.logs.index','null'),(13,1,'Четци','','_self','voyager-location','#000000',14,5,'2020-05-10 19:43:25','2020-05-25 05:40:41','voyager.readers.index','null'),(14,1,'Управление','','_self','voyager-settings','#000000',NULL,5,'2020-05-10 19:47:25','2020-06-15 21:56:20',NULL,''),(15,1,'Карти','','_self','voyager-tag',NULL,14,3,'2020-05-10 21:11:18','2020-05-25 05:40:32','voyager.tags.index',NULL),(16,1,'Отдели','','_self','voyager-company',NULL,14,4,'2020-05-11 16:23:56','2020-05-25 05:40:41','voyager.sections.index',NULL),(17,1,'Монитор','/monitor','_self','voyager-eye','#000000',NULL,2,'2020-05-11 22:29:12','2020-05-11 22:29:25',NULL,''),(18,1,'Отчети','/report','_self','voyager-logbook','#000000',NULL,3,'2020-05-25 05:40:04','2020-05-25 05:40:25',NULL,''),(19,1,'Грешки','','_self','voyager-warning',NULL,NULL,4,'2020-06-13 11:27:45','2020-06-15 21:56:20','voyager.errors.index',NULL);
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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
INSERT INTO `menus` VALUES (1,'admin','2020-05-10 19:07:09','2020-05-10 19:07:09');
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
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2016_01_01_000000_add_voyager_user_fields',1),(3,'2016_01_01_000000_create_data_types_table',1),(4,'2016_05_19_173453_create_menu_table',1),(5,'2016_10_21_190000_create_roles_table',1),(6,'2016_10_21_190000_create_settings_table',1),(7,'2016_11_30_135954_create_permission_table',1),(8,'2016_11_30_141208_create_permission_role_table',1),(9,'2016_12_26_201236_data_types__add__server_side',1),(10,'2017_01_13_000000_add_route_to_menu_items_table',1),(11,'2017_01_14_005015_create_translations_table',1),(12,'2017_01_15_000000_make_table_name_nullable_in_permissions_table',1),(13,'2017_03_06_000000_add_controller_to_data_types_table',1),(14,'2017_04_21_000000_add_order_to_data_rows_table',1),(15,'2017_07_05_210000_add_policyname_to_data_types_table',1),(16,'2017_08_05_000000_add_group_to_settings_table',1),(17,'2017_11_26_013050_add_user_role_relationship',1),(18,'2017_11_26_015000_create_user_roles_table',1),(19,'2018_03_11_000000_add_user_settings',1),(20,'2018_03_14_000000_add_details_to_data_types_table',1),(21,'2018_03_16_000000_make_settings_value_nullable',1),(22,'2019_08_19_000000_create_failed_jobs_table',1),(24,'2020_05_19_212704_create_websockets_statistics_entries_table',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
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
INSERT INTO `permission_role` VALUES (1,1),(1,2),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(23,1),(24,1),(25,1),(26,1),(27,1),(27,2),(28,1),(28,2),(29,1),(30,1),(31,1),(32,1),(33,1),(34,1),(35,1),(36,1),(37,1),(38,1),(39,1),(40,1),(41,1),(42,1),(43,1),(44,1),(45,1),(46,1),(47,1),(48,1),(49,1),(50,1),(51,1);
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
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
INSERT INTO `permissions` VALUES (1,'browse_admin',NULL,'2020-05-10 19:07:10','2020-05-10 19:07:10'),(2,'browse_bread',NULL,'2020-05-10 19:07:10','2020-05-10 19:07:10'),(3,'browse_database',NULL,'2020-05-10 19:07:10','2020-05-10 19:07:10'),(4,'browse_media',NULL,'2020-05-10 19:07:10','2020-05-10 19:07:10'),(5,'browse_compass',NULL,'2020-05-10 19:07:10','2020-05-10 19:07:10'),(6,'browse_menus','menus','2020-05-10 19:07:10','2020-05-10 19:07:10'),(7,'read_menus','menus','2020-05-10 19:07:10','2020-05-10 19:07:10'),(8,'edit_menus','menus','2020-05-10 19:07:10','2020-05-10 19:07:10'),(9,'add_menus','menus','2020-05-10 19:07:10','2020-05-10 19:07:10'),(10,'delete_menus','menus','2020-05-10 19:07:10','2020-05-10 19:07:10'),(11,'browse_roles','roles','2020-05-10 19:07:10','2020-05-10 19:07:10'),(12,'read_roles','roles','2020-05-10 19:07:10','2020-05-10 19:07:10'),(13,'edit_roles','roles','2020-05-10 19:07:10','2020-05-10 19:07:10'),(14,'add_roles','roles','2020-05-10 19:07:10','2020-05-10 19:07:10'),(15,'delete_roles','roles','2020-05-10 19:07:10','2020-05-10 19:07:10'),(16,'browse_users','users','2020-05-10 19:07:10','2020-05-10 19:07:10'),(17,'read_users','users','2020-05-10 19:07:10','2020-05-10 19:07:10'),(18,'edit_users','users','2020-05-10 19:07:10','2020-05-10 19:07:10'),(19,'add_users','users','2020-05-10 19:07:10','2020-05-10 19:07:10'),(20,'delete_users','users','2020-05-10 19:07:10','2020-05-10 19:07:10'),(21,'browse_settings','settings','2020-05-10 19:07:10','2020-05-10 19:07:10'),(22,'read_settings','settings','2020-05-10 19:07:10','2020-05-10 19:07:10'),(23,'edit_settings','settings','2020-05-10 19:07:10','2020-05-10 19:07:10'),(24,'add_settings','settings','2020-05-10 19:07:10','2020-05-10 19:07:10'),(25,'delete_settings','settings','2020-05-10 19:07:10','2020-05-10 19:07:10'),(26,'browse_hooks',NULL,'2020-05-10 19:07:10','2020-05-10 19:07:10'),(27,'browse_logs','logs','2020-05-10 19:21:26','2020-05-10 19:21:26'),(28,'read_logs','logs','2020-05-10 19:21:26','2020-05-10 19:21:26'),(29,'edit_logs','logs','2020-05-10 19:21:26','2020-05-10 19:21:26'),(30,'add_logs','logs','2020-05-10 19:21:26','2020-05-10 19:21:26'),(31,'delete_logs','logs','2020-05-10 19:21:26','2020-05-10 19:21:26'),(32,'browse_readers','readers','2020-05-10 19:43:25','2020-05-10 19:43:25'),(33,'read_readers','readers','2020-05-10 19:43:25','2020-05-10 19:43:25'),(34,'edit_readers','readers','2020-05-10 19:43:25','2020-05-10 19:43:25'),(35,'add_readers','readers','2020-05-10 19:43:25','2020-05-10 19:43:25'),(36,'delete_readers','readers','2020-05-10 19:43:25','2020-05-10 19:43:25'),(37,'browse_tags','tags','2020-05-10 21:11:18','2020-05-10 21:11:18'),(38,'read_tags','tags','2020-05-10 21:11:18','2020-05-10 21:11:18'),(39,'edit_tags','tags','2020-05-10 21:11:18','2020-05-10 21:11:18'),(40,'add_tags','tags','2020-05-10 21:11:18','2020-05-10 21:11:18'),(41,'delete_tags','tags','2020-05-10 21:11:18','2020-05-10 21:11:18'),(42,'browse_sections','sections','2020-05-11 16:23:56','2020-05-11 16:23:56'),(43,'read_sections','sections','2020-05-11 16:23:56','2020-05-11 16:23:56'),(44,'edit_sections','sections','2020-05-11 16:23:56','2020-05-11 16:23:56'),(45,'add_sections','sections','2020-05-11 16:23:56','2020-05-11 16:23:56'),(46,'delete_sections','sections','2020-05-11 16:23:56','2020-05-11 16:23:56'),(47,'browse_errors','errors','2020-06-13 11:27:45','2020-06-13 11:27:45'),(48,'read_errors','errors','2020-06-13 11:27:45','2020-06-13 11:27:45'),(49,'edit_errors','errors','2020-06-13 11:27:45','2020-06-13 11:27:45'),(50,'add_errors','errors','2020-06-13 11:27:45','2020-06-13 11:27:45'),(51,'delete_errors','errors','2020-06-13 11:27:45','2020-06-13 11:27:45');
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `mac` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `readers`
--

LOCK TABLES `readers` WRITE;
/*!40000 ALTER TABLE `readers` DISABLE KEYS */;
INSERT INTO `readers` VALUES (1,'Главен портал','2020-05-10 19:51:00',1,'2020-05-11 09:55:39','140870681499624'),(2,'Офис Администратор','2020-06-13 11:59:25',2,'2020-06-13 11:59:37','242606369536836');
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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
INSERT INTO `roles` VALUES (1,'admin','Администратор','2020-05-10 19:07:09','2020-05-10 20:37:33'),(2,'user','Служител','2020-05-10 19:07:10','2020-05-10 20:37:20');
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,'Високоволтови предпазители','2020-05-11 16:25:42','2020-05-11 16:25:42'),(2,'Високомощни предпазители','2020-05-11 16:25:59','2020-05-11 16:25:59'),(3,'Цех инструментален','2020-05-11 16:26:12','2020-05-11 16:26:12'),(4,'Пресов участък','2020-05-11 16:26:26','2020-05-11 16:26:26'),(5,'Заваръчно','2020-05-11 16:26:35','2020-05-11 16:26:35'),(6,'Цех разединители','2020-05-11 16:26:48','2020-05-11 16:26:48'),(7,'Енергомеханичен','2020-05-11 16:27:02','2020-05-11 16:27:02'),(8,'Ел. лаборатория','2020-05-11 16:27:12','2020-05-11 16:27:12'),(9,'Опаковки','2020-05-11 16:27:20','2020-05-11 16:27:20'),(10,'Склад','2020-05-11 16:27:26','2020-05-11 16:27:26'),(11,'Администрация','2020-05-11 16:27:35','2020-05-11 16:27:35'),(12,'Електропорцелан','2020-05-11 16:27:46','2020-05-11 16:27:46'),(13,'Галваничен участък','2020-05-11 16:27:58','2020-05-11 16:27:58'),(14,'Охрана','2020-05-11 16:28:04','2020-05-11 16:28:04');
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
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'site.title','Site Title','Nikdim','','text',1,'Site'),(2,'site.description','Site Description','Personnel Tracking','','text',2,'Site'),(3,'site.logo','Site Logo','settings/October2020/39Xz4HEtz8Y3VcA4IkSN.png','','image',3,'Site'),(4,'site.google_analytics_tracking_id','Google Analytics Tracking ID',NULL,'','text',4,'Site'),(5,'admin.bg_image','Admin Background Image','settings/May2020/K0nlYbNESoYKgj0D3wvk.jpg','','image',5,'Admin'),(6,'admin.title','Admin Title','Nikdim','','text',1,'Admin'),(7,'admin.description','Admin Description','Raffy от NetShell','','text',2,'Admin'),(8,'admin.loader','Admin Loader','','','image',3,'Admin'),(9,'admin.icon_image','Admin Icon Image','settings/October2020/0T7rVGtBL0WfH56nFqY5.png','','image',4,'Admin'),(10,'admin.google_analytics_client_id','Google Analytics Client ID (used for admin dashboard)',NULL,'','text',1,'Admin'),(11,'site.workday_start','Работно време - начало','08:00',NULL,'text',6,'Site'),(12,'site.workday_end','Работно време - край','17:00',NULL,'text',7,'Site'),(13,'site.open_time','Време за отключване','4',NULL,'text',8,'Site'),(14,'site.overwrite_time','Толеранс за неуспешен вход','1',NULL,'text',9,'Site');
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
  `tag` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'716177144219',1,'2020-05-10 22:22:00','2020-05-11 08:49:22'),(2,'498433678293',3,'2020-05-11 08:50:00','2020-05-21 18:10:55'),(3,'508248415119',4,'2020-08-10 16:22:28','2020-08-10 16:22:28');
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
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `column_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foreign_key` int(10) unsigned NOT NULL,
  `locale` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `settings` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'Боян Администратор','ash@rain.com','users/May2020/Z5AcR65MXbWivSKowU85.jpg',NULL,'$2y$10$a5bhE1KIuRKe3K6hub8uXeFN9dd0/XTrVXORhqmF.rQsuvj4oWT9y','BMM8DFH0sRJNMhE56vF68a8eL1150e3KBehn2Gpr1HCx9F8tWVBxXhEZEqcc','{\"locale\":\"bg\"}','2020-05-10 19:08:35','2020-05-21 15:42:43',11),(2,2,'Боян Работник','rain@ash.com','users/May2020/hZV4eeVEJe0CS3QGRoVg.jpg',NULL,'$2y$10$AjhsbiZd1Lk3Ef6B7t1ty.lSGhMtSPMMVuIElRiCqBeHqDTuNXQdi',NULL,'{\"locale\":\"bg\"}','2020-05-10 20:37:59','2020-05-21 15:42:19',8),(3,1,'Дончо Донев','info@nikdim.bg','users/May2020/amthAHQeH270oWpM1Des.png',NULL,'$2y$10$LDUcR4s6S8Ubdf9wV0qmJuCBLUTPxLEn4BbAss8wZcOk1kS.7WeG2',NULL,'{\"locale\":\"bg\"}','2020-05-12 15:20:34','2020-10-05 16:48:51',11),(4,1,'Милен Балкански','mbalkanski@yahoo.com','users/default.png',NULL,'$2y$10$NKKg/AIfzJZNzS68temoJujhbf5NPGeSOLJeRdU8S4RH7gxWbsHeu',NULL,'{\"locale\":\"bg\"}','2020-08-10 16:21:46','2020-08-10 16:21:46',8);
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
  `app_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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

-- Dump completed on 2020-10-20 11:59:51
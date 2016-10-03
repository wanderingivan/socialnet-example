

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acl_class`
--

DROP TABLE IF EXISTS `acl_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_class` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `class` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_uk_2` (`class`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_class`
--

LOCK TABLES `acl_class` WRITE;
/*!40000 ALTER TABLE `acl_class` DISABLE KEYS */;
INSERT INTO `acl_class` VALUES (6,'com.ecommerce.model.Product'),(7,'com.ecommerce.model.User');
/*!40000 ALTER TABLE `acl_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_entry`
--

DROP TABLE IF EXISTS `acl_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_entry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `acl_object_identity` bigint(20) NOT NULL,
  `ace_order` int(11) NOT NULL,
  `sid` bigint(20) NOT NULL,
  `mask` int(11) NOT NULL,
  `granting` tinyint(1) NOT NULL,
  `audit_success` tinyint(1) NOT NULL,
  `audit_failure` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_uk_4` (`acl_object_identity`,`ace_order`),
  KEY `foreign_fk_5` (`sid`),
  CONSTRAINT `foreign_fk_4` FOREIGN KEY (`acl_object_identity`) REFERENCES `acl_object_identity` (`id`),
  CONSTRAINT `foreign_fk_5` FOREIGN KEY (`sid`) REFERENCES `acl_sid` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_entry`
--

LOCK TABLES `acl_entry` WRITE;
/*!40000 ALTER TABLE `acl_entry` DISABLE KEYS */;
INSERT INTO `acl_entry` VALUES (1,1,0,7,2,1,0,0),(2,1,1,7,8,1,0,0),(3,2,0,7,2,1,0,0),(4,2,1,7,8,1,0,0),(5,3,0,7,2,1,0,0),(6,3,1,7,8,1,0,0),(7,4,0,9,2,1,0,0),(8,4,1,9,8,1,0,0),(11,6,0,7,2,1,0,0),(12,6,1,7,8,1,0,0),(13,7,0,7,2,1,0,0),(14,7,1,7,8,1,0,0),(15,8,0,7,2,1,0,0),(16,8,1,7,8,1,0,0),(17,9,0,7,2,1,0,0),(18,9,1,7,8,1,0,0),(19,10,0,7,2,1,0,0),(20,10,1,7,8,1,0,0),(21,11,0,7,2,1,0,0),(22,11,1,7,8,1,0,0),(23,12,0,9,2,1,0,0),(24,12,1,9,1,1,0,0),(25,13,0,9,2,1,0,0),(26,13,1,9,8,1,0,0),(27,14,0,9,2,1,0,0),(28,14,1,9,8,1,0,0),(29,15,0,9,2,1,0,0),(30,15,1,9,8,1,0,0),(31,16,0,9,2,1,0,0),(32,16,1,9,8,1,0,0),(33,17,0,9,2,1,0,0),(34,17,1,9,8,1,0,0),(35,18,0,9,2,1,0,0),(36,18,1,9,8,1,0,0),(37,19,0,9,2,1,0,0),(38,19,1,9,8,1,0,0),(39,20,0,9,2,1,0,0),(40,20,1,9,8,1,0,0),(41,21,0,10,2,1,0,0),(42,21,1,10,1,1,0,0),(44,22,1,10,8,1,0,0),(45,23,0,10,2,1,0,0),(46,23,1,10,8,1,0,0),(47,24,0,10,2,1,0,0),(48,24,1,10,8,1,0,0),(49,25,0,10,2,1,0,0),(50,25,1,10,8,1,0,0),(51,26,0,10,2,1,0,0),(52,26,1,10,8,1,0,0),(53,27,0,7,2,1,0,0),(54,27,1,7,1,1,0,0),(71,44,0,9,2,1,0,0),(72,44,1,9,8,1,0,0);
/*!40000 ALTER TABLE `acl_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_object_identity`
--

DROP TABLE IF EXISTS `acl_object_identity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_object_identity` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `object_id_class` bigint(20) NOT NULL,
  `object_id_identity` bigint(20) NOT NULL,
  `parent_object` bigint(20) DEFAULT NULL,
  `owner_sid` bigint(20) DEFAULT NULL,
  `entries_inheriting` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_uk_3` (`object_id_class`,`object_id_identity`),
  KEY `foreign_fk_1` (`parent_object`),
  KEY `foreign_fk_3` (`owner_sid`),
  CONSTRAINT `foreign_fk_1` FOREIGN KEY (`parent_object`) REFERENCES `acl_object_identity` (`id`),
  CONSTRAINT `foreign_fk_2` FOREIGN KEY (`object_id_class`) REFERENCES `acl_class` (`id`),
  CONSTRAINT `foreign_fk_3` FOREIGN KEY (`owner_sid`) REFERENCES `acl_sid` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_object_identity`
--

LOCK TABLES `acl_object_identity` WRITE;
/*!40000 ALTER TABLE `acl_object_identity` DISABLE KEYS */;
INSERT INTO `acl_object_identity` VALUES (1,6,1,NULL,7,1),(2,6,2,NULL,7,1),(3,6,3,NULL,7,1),(4,6,4,NULL,7,1),(6,6,7,NULL,7,1),(7,6,8,NULL,7,1),(8,6,9,NULL,7,1),(9,6,10,NULL,7,1),(10,6,11,NULL,7,1),(11,6,12,NULL,7,1),(12,7,4,NULL,9,1),(13,6,13,NULL,9,1),(14,6,14,NULL,9,1),(15,6,15,NULL,9,1),(16,6,16,NULL,9,1),(17,6,17,NULL,9,1),(18,6,18,NULL,9,1),(19,6,19,NULL,9,1),(20,6,20,NULL,9,1),(21,7,5,NULL,10,1),(22,6,21,NULL,10,1),(23,6,22,NULL,10,1),(24,6,23,NULL,10,1),(25,6,24,NULL,10,1),(26,6,25,NULL,10,1),(27,7,1,NULL,7,1),(43,6,26,NULL,9,1),(44,6,27,NULL,9,1);
/*!40000 ALTER TABLE `acl_object_identity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_sid`
--

DROP TABLE IF EXISTS `acl_sid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_sid` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `principal` tinyint(1) NOT NULL,
  `sid` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_uk_1` (`sid`,`principal`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_sid`
--

LOCK TABLES `acl_sid` WRITE;
/*!40000 ALTER TABLE `acl_sid` DISABLE KEYS */;
INSERT INTO `acl_sid` VALUES (19,1,'anonymousUser'),(20,1,'test username'),(23,1,'testUser'),(7,1,'user1'),(9,1,'user2'),(10,1,'user3'),(11,1,'user5'),(21,1,'user55'),(13,1,'usernam67'),(22,1,'username2345'),(12,1,'username6');
/*!40000 ALTER TABLE `acl_sid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authorities`
--

DROP TABLE IF EXISTS `authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorities` (
  `username` varchar(50) NOT NULL,
  `authority` varchar(50) NOT NULL,
  UNIQUE KEY `ix_auth_username` (`username`,`authority`),
  CONSTRAINT `fk_authorities_users` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorities`
--

LOCK TABLES `authorities` WRITE;
/*!40000 ALTER TABLE `authorities` DISABLE KEYS */;
INSERT INTO `authorities` VALUES ('user1','ROLE_USER'),('user2','ROLE_USER'),('user3','ROLE_ADMIN');
/*!40000 ALTER TABLE `authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carts` (
  `cart_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`cart_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `user_id_cart_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES (19,1),(1,4),(2,5);
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts_products`
--

DROP TABLE IF EXISTS `carts_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carts_products` (
  `cart_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  KEY `product_id_carts_fk` (`product_id`),
  KEY `cart_id_fk` (`cart_id`),
  CONSTRAINT `cart_id_fk` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`cart_id`) ON DELETE CASCADE,
  CONSTRAINT `product_id_carts_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts_products`
--

LOCK TABLES `carts_products` WRITE;
/*!40000 ALTER TABLE `carts_products` DISABLE KEYS */;
INSERT INTO `carts_products` VALUES (1,22),(1,18),(1,4);
/*!40000 ALTER TABLE `carts_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_messages`
--

DROP TABLE IF EXISTS `chat_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat_messages` (
  `message_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `message` varchar(180) NOT NULL,
  `sent` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `read` tinyint(4) NOT NULL DEFAULT '0',
  `chat_id` bigint(20) unsigned NOT NULL,
  `sender_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `m_sender_id_fk` (`sender_id`),
  KEY `conversation_id_fk` (`chat_id`),
  CONSTRAINT `conversation_id_fk` FOREIGN KEY (`chat_id`) REFERENCES `chats` (`chat_id`) ON DELETE CASCADE,
  CONSTRAINT `m_sender_id_fk` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_messages`
--

LOCK TABLES `chat_messages` WRITE;
/*!40000 ALTER TABLE `chat_messages` DISABLE KEYS */;
INSERT INTO `chat_messages` VALUES (1,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',1,1,5),(2,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',1,1,4),(3,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',1,2,1),(4,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',1,2,5),(7,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',1,2,5),(8,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',1,1,5),(9,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',1,2,5),(10,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',1,2,1),(11,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',1,1,4),(12,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',1,1,4),(13,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',1,2,5),(14,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',1,3,4),(15,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',1,3,1),(16,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',1,1,4),(18,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',0,4,5),(19,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',1,3,4),(20,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',1,3,4),(21,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',1,3,4),(22,'Lorem Ipsum dolor sit amet','2016-09-30 22:44:21',1,3,4);
/*!40000 ALTER TABLE `chat_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chats`
--

DROP TABLE IF EXISTS `chats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chats` (
  `chat_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`chat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats`
--

LOCK TABLES `chats` WRITE;
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
INSERT INTO `chats` VALUES (1,'2016-06-08 19:35:43'),(2,'2016-06-02 14:54:42'),(3,'2016-08-29 23:20:19'),(4,'2016-06-16 19:46:42');
/*!40000 ALTER TABLE `chats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chats_join_table`
--

DROP TABLE IF EXISTS `chats_join_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chats_join_table` (
  `chat_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`chat_id`),
  KEY `chat_id_fk` (`chat_id`),
  CONSTRAINT `chat_id_fk` FOREIGN KEY (`chat_id`) REFERENCES `chats` (`chat_id`) ON DELETE CASCADE,
  CONSTRAINT `chat_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats_join_table`
--

LOCK TABLES `chats_join_table` WRITE;
/*!40000 ALTER TABLE `chats_join_table` DISABLE KEYS */;
INSERT INTO `chats_join_table` VALUES (1,4),(1,5),(2,1),(2,5),(3,1),(3,4),(4,5);
/*!40000 ALTER TABLE `chats_join_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `details`
--

DROP TABLE IF EXISTS `details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `details` (
  `detail_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `message` varchar(250) DEFAULT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`detail_id`),
  KEY `product_id_detail_fk` (`product_id`),
  CONSTRAINT `product_id_detail_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=340 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `details`
--

LOCK TABLES `details` WRITE;
/*!40000 ALTER TABLE `details` DISABLE KEYS */;
INSERT INTO `details` VALUES (7,'Introduction: March 1977',4),(8,'Primary Function: A-10 -- close air support, OA-10 - airborne forward air control',4),(9,'Power Plant: Two General Electric TF34-GE-1 00 turbofans',4),(10,'Thrust: 9,065 pounds each engine',4),(14,'Wingspan: 57 feet, 6 inches (17.42 meters)',4),(15,'Length: 53 feet, 4 inches (16.16 meters)',4),(16,'Height: 14 feet, 8 inches (4.42 meters)',4),(17,'Weight: 29,000 pounds (13,154 kilograms)',4),(63,'Initial Year of Service: 1986',7),(64,'Crew: 4',7),(65,'Length: 146.00 ft',7),(66,'Width: 137.14 ft (41.80 m)',7),(67,'Height: 34.12ft (10.40 m)',7),(68,'Weight (Empty): 192,023 lb (87,100 kg)',7),(69,'Weight (MTOW): 477,080 lb (216,400 kg)',7),(70,'Powerplant: 4 x General Electric F-101-GE-102 afterburning turbofan engines developing 30,780 lb of thrust each.',7),(106,'Maximum Takeoff Weight: 51,000 pounds (22,950 kilograms)',4),(107,'Fuel Capacity: 11,000 pounds (7,257 kilograms)',4),(108,'Payload: 16,000 pounds (7,257 kilograms)',4),(109,'Speed: 420 miles per hour (Mach 0.56)',4),(110,'Range: 800 miles (695 nautical miles)',4),(111,'Ceiling: 45,000 feet (13,636 meters)',4),(112,'One 30 mm GAU-8/A seven-barrel Gatling gun',4),(113,'Up to 16,000 pounds (7,200 kilograms) of mixed ordnance',4),(114,'Crew: One',4),(115,'Maximum Speed: 833 mph (1,340 kmh; 724 kts)',7),(116,'Maximum Range: 7,456 miles (12,000 km)',7),(117,'Service Ceiling: 59,055 ft (18,000 m; 11.2 miles)',7),(118,'Hardpoints: 6',7),(119,'Armament Suite:\r\nUp to 59,000 lb of ordnance across six external hardpoints and 75,000 lb in three internal bomb bays.',7),(120,'Primary function: 	Multi-role heavy bomber.',8),(121,'Power Plant/Manufacturer: 	Four General Electric F-118-GE-100 engines',8),(122,'Thrust: 	17,300 pounds each engine (7,847 kilograms)',8),(123,'Length: 	69 feet (20.9 meters)',8),(124,'Height: 	17 feet (5.1 meters)',8),(125,'Wingspan: 	172 feet (52.12 meters)',8),(126,'Speed, cruise: 	High subsonic',8),(127,'Speed, minimum approach: 	140 mph',8),(128,'Ceiling: 	50,000 feet (15,000 meters)',8),(129,'Weight, Takeoff, (Typical): 	336,500-350,000 pounds (152,600-159,000 kilograms)',8),(130,'Weight, Empty: 	125,000-160,000 lb',8),(131,'Crew: 	Two pilots',8),(132,'Range: 6000 Nautical Miles',8),(133,'Primary function: heavy bomber',9),(134,'Power plant: Eight Pratt &amp; Whitney engines TF33-P-3/103 turbofan',9),(135,'Thrust: each engine up to 17,000 pounds',9),(136,'Wingspan: 185 feet (56.4 meters)',9),(137,'Length: 159 feet, 4 inches (48.5 meters)',9),(138,'Height: 40 feet, 8 inches (12.4 meters)',9),(139,'Weight: Approximately 185,000 pounds (83,250 kilograms)',9),(140,'Maximum takeoff weight: 488,000 pounds (219,600 kilograms)',9),(141,'Fuel capacity: 312,197 pounds (141,610 kilograms)',9),(142,'Payload: 70,000 pounds (31,500 kilograms)',9),(143,'Speed: 650 miles per hour (Mach 0.84)',9),(144,'Range: 8,800 miles (7,652 nautical miles)',9),(145,'Ceiling: 50,000 feet (15,151.5 meters)',9),(146,'Armament: approximately 70,000 pounds (31,500 kilograms) mixed ordnance -- bombs, mines and missiles. (modified to carry air-launched cruise missiles)',9),(147,'Crew: five (aircraft commander, pilot, radar navigator, navigator and electronic warfare officer)',9),(148,'Initial operating capability: April 1952',9),(149,'Length: 51.35 ft (15.65 m)',10),(150,'Width: 26.97 ft (8.22 m)',10),(151,'Height: 14.93ft (4.55 m)',10),(152,'Weight (Empty): 16,061 lb (7,285 kg)',10),(153,'Weight (MTOW): 36,376 lb (16,500 kg)',10),(154,'Powerplant: 1 x IAI/General Electric license-build J79-JIE turbojet engine with afterburn developing 17,860 lb of thrust.',10),(155,'Maximum Speed: 1,516 mph (2,440 kmh; 1,317 kts)',10),(156,'Maximum Range: 548 miles (882 km)',10),(157,'Service Ceiling: 58,038 ft (17,690 m; 11.0 miles)',10),(158,'Rate-of-Climb: 45,866 feet-per-minute (13,980 m/min)',10),(159,'Hardpoints: 9',10),(160,'Initial Year of Service: 2003',11),(161,'Crew: 1',11),(162,'Length: 52.36 ft (15.96 m)',11),(163,'Width: 35.93 ft (10.95 m)',11),(164,'Height: 17.32ft (5.28 m)',11),(165,'Weight (Empty): 24,251 lb (11,000 kg)',11),(166,'Weight (MTOW): 51,809 lb (23,500 kg)',11),(167,'Powerplant: 2 x Eurojet EJ200 afterburning turbofans developing 20,250 lb of thrust each.',11),(168,'Maximum Speed: 1,550 mph (2,495 kmh; 1,347 kts)',11),(169,'Maximum Range: 1,802 miles (2,900 km)',11),(170,'Service Ceiling: 64,993 ft (19,810 m; 12.3 miles)',11),(171,'Rate-of-Climb: 62,000 feet-per-minute (18,898 m/min)',11),(172,'Hardpoints: 13',11),(173,'Length: 56.82 ft (17.32 m)',12),(174,'Width: 37.27 ft (11.36 m)',12),(175,'Height: 15.52ft (4.73 m)',12),(176,'Weight (Empty): 24,028 lb (10,899 kg)',12),(177,'Weight (MTOW): 43,431 lb (19,700 kg)',12),(178,'Powerplant: 2 x Klimov RD-33 turbofans with afterburner developing 18,300 lb of thrust each.',12),(179,'Maximum Speed: 1,519 mph (2,445 kmh; 1,320 kts)',12),(180,'Maximum Range: 889 miles (1,430 km)',12),(181,'Service Ceiling: 59,058 ft (18,001 m; 11.2 miles)',12),(182,'Rate-of-Climb: 65,000 feet-per-minute (19,812 m/min)',12),(183,'Hardpoints: 9',12),(184,'Initial Year of Service: 1984',12),(185,'Length: 62.07 ft (18.92 m)',13),(186,'Width: 44.49 ft (13.56 m)',13),(187,'Height: 16.47ft (5.02 m)',13),(188,'Weight (Empty): 31,998 lb (14,514 kg)',13),(189,'Weight (MTOW): 54,999 lb (24,947 kg)',13),(190,'Powerplant: 2 x Pratt &amp;amp; Whitney F119-PW-100 afterburning turbofans developing 35,000 lb of thrust each.',13),(191,'Maximum Speed: 1,599 mph (2,574 kmh; 1,390 kts)',13),(192,'Maximum Range: 2,000 miles (3,218 km)',13),(193,'Service Ceiling: 50,000 ft (15,240 m; 9.5 miles)',13),(194,'Hardpoints: 4 External; 8 Internal',13),(195,'Initial Year of Service: 1997',14),(196,'Length: 46.26 ft (14.1 m)',14),(197,'Width: 27.56 ft (8.40 m)',14),(198,'Height: 14.76ft (4.50 m)',14),(199,'Weight (Empty): 14,991 lb (6,800 kg)',14),(200,'Weight (MTOW): 30,865 lb (14,000 kg)',14),(201,'Powerplant: 1 x Volvo Aero RM12 (General Electric F404) turbofan engine with afterburner developing 18,100 lb thrust.',14),(202,'Maximum Speed: 1,367 mph (2,200 kmh; 1,188 kts)',14),(203,'Maximum Range: 497 miles (800 km)',14),(204,'Service Ceiling: 50,000 ft (15,240 m; 9.5 miles)',14),(205,'Hardpoints: 9 (including wingtips)',14),(206,'Crew: 1',14),(207,'Initial Year of Service: 2015',15),(208,'Length: 50.43 ft (15.37 m)',15),(209,'Width: 34.94 ft (10.65 m)',15),(210,'Height: 17.32ft (5.28 m)',15),(211,'Weight (Empty): 26,455 lb (12,000 kg)',15),(212,'Weight (MTOW): 59,966 lb (27,200 kg)',15),(213,'Powerplant: 1 x Pratt & Whitney F135 F119-PW-100 turbofan developing 40,000 lb thrust with afterburner with General Electric GE F120 alternate core engine.',15),(214,'Maximum Speed: 1,200 mph (1,931 kmh; 1,043 kts)',15),(215,'Maximum Range: 1,367 miles (2,200 km)',15),(216,'Service Ceiling: 50,000 ft (15,240 m; 9.5 miles)',15),(217,'Hardpoints: 6',15),(218,'Initial Year of Service: 2001',16),(219,'Length: 50.20 ft (15.3 m)',16),(220,'Width: 35.76 ft (10.90 m)',16),(221,'Height: 17.52ft (5.34 m)',16),(222,'Weight (Empty): 20,944 lb (9,500 kg)',16),(223,'Weight (MTOW): 54,013 lb (24,500 kg)',16),(224,'Powerplant: 2 x SNECMA M88-2 augmented turbofan engines with afterburner developing 19,555 lb of thrust.',16),(225,'Maximum Speed: 1,190 mph (1,915 kmh; 1,034 kts)',16),(226,'Maximum Range: 1,150 miles (1,850 km)',16),(227,'Service Ceiling: 49,984 ft (15,235 m; 9.5 miles)',16),(228,'Rate-of-Climb: 60,000 feet-per-minute (18,288 m/min)',16),(229,'Hardpoints: 14 (including two wingtip mounts)',16),(230,'Crew: 1',16),(231,'Manufacturer: Dassault Aviation - France',16),(232,'Initial Year of Service: 1972',17),(233,'Length: 139.11 ft (42.4 m)',17),(234,'Width: 112.47 ft (34.28 m)',17),(235,'Height: 36.25ft (11.05 m)',17),(236,'Weight (Empty): 119,050 lb (54,000 kg)',17),(237,'Weight (MTOW): 273,373 lb (124,000 kg)',17),(238,'Powerplant: 2 x Kuznetsov NK-25 turbofan engines developing 55,100lbs of thrust each',17),(239,'Maximum Speed: 1,243 mph (2,000 kmh; 1,080 kts)',17),(240,'Maximum Range: 1,498 miles (2,410 km)',17),(241,'Service Ceiling: 43,635 ft (13,300 m; 8.3 miles)',17),(242,'Hardpoints: 4',17),(243,'Crew: 4',17),(244,'Initial Year of Service: 1989',18),(245,'Length: 177.49 ft (54.1 m)',18),(246,'Width: 182.74 ft (55.70 m)',18),(247,'Height: 42.98ft (13.10 m)',18),(248,'Weight (Empty): 242,508 lb (110,000 kg)',18),(249,'Weight (MTOW): 606,271 lb (275,000 kg)',18),(250,'Powerplant: 4 x Kuznetsov NK-321 turbofan engines developing 55,115 lb of thrust each.',18),(251,'Maximum Speed: 1,243 mph (2,000 kmh; 1,080 kts)',18),(252,'Maximum Range: 8,699 miles (14,000 km)',18),(253,'Service Ceiling: 60,039 ft (18,300 m; 11.4 miles)',18),(254,'Rate-of-Climb: 13,780 feet-per-minute (4,200 m/min)',18),(255,'Hardpoints: 2',18),(256,'Crew: 4',18),(257,'Initial Year of Service: 1958',19),(258,'Length: 114.17 ft (34.8 m)',19),(259,'Width: 108.27 ft (33.00 m)',19),(260,'Height: 33.99ft (10.36 m)',19),(261,'Weight (Empty): 82,012 lb (37,200 kg)',19),(262,'Weight (MTOW): 174,165 lb (79,000 kg)',19),(263,'Powerplant: 2 x Xian WP8 turbojet engines delivering 20,900lbs of thrust each',19),(264,'Maximum Speed: 652 mph (1,050 kmh; 567 kts)',19),(265,'Maximum Range: 3,728 miles (6,000 km)',19),(266,'Service Ceiling: 41,995 ft (12,800 m; 8.0 miles)',19),(267,'Hardpoints: Up to 6',19),(268,'Crew: 4',19),(269,'Length: 154.20 ft (47 m)',20),(270,'Width: 164.04 ft (50.00 m)',20),(271,'Height: 49.21ft (15.00 m)',20),(272,'Weight (Empty): 220,462 lb (100,000 kg)',20),(273,'Weight (MTOW): 485,017 lb (220,000 kg)',20),(274,'Powerplant: 4 x Soloviev D-30Kp-2 turbofan engines (to be replaced by WS-20 turbofans in production).',20),(275,'Maximum Speed: 572 mph (920 kmh; 497 kts)',20),(276,'Maximum Range: 2,796 miles (4,500 km)',20),(277,'Service Ceiling: 42,651 ft (13,000 m; 8.1 miles)',20),(278,'Initial Year of Service: 2007',21),(279,'Length: 57.41 ft (17.5 m)',21),(280,'Width: 84.65 ft (25.80 m)',21),(281,'Height: 22.08ft (6.73 m)',21),(282,'Weight (Empty): 33,069 lb (15,000 kg)',21),(283,'Weight (MTOW): 60,407 lb (27,400 kg)',21),(284,'Powerplant: 2 x Rolls-Royce T406-AE 1107C-Liberty turboshaft engines generating 6,150 shaft horsepower and driving 2 x three-blade propeller systems.',21),(285,'Maximum Speed: 316 mph (509 kmh; 275 kts)',21),(286,'Maximum Range: 1,011 miles (1,627 km)',21),(287,'Service Ceiling: 25,000 ft (7,620 m; 4.7 miles)',21),(288,'Rate-of-Climb: 3,160 feet-per-minute (963 m/min)',21),(289,'Crew: 3 + 24',21),(290,'Initial Year of Service: 1975',22),(291,'Length: 152.85 ft (46.59 m)',22),(292,'Width: 165.68 ft (50.50 m)',22),(293,'Height: 48.43ft (14.76 m)',22),(294,'Weight (Empty): 202,825 lb (92,000 kg)',22),(295,'Weight (MTOW): 418,878 lb (190,000 kg)',22),(296,'Powerplant: 4 x Soloviev D-30KP turbofan engines developing 26,500 lb of thrust each.',22),(297,'Maximum Speed: 559 mph (900 kmh; 486 kts)',22),(298,'Maximum Range: 2,734 miles (4,400 km)',22),(299,'Service Ceiling: 42,651 ft (13,000 m; 8.1 miles)',22),(300,'Hardpoints: 4',22),(301,'Crew: 5 to 10',22),(302,'Initial Year of Service: 2003',23),(303,'Length: 37.17 ft (11.33 m)',23),(304,'Width: 36.55 ft (11.14 m)',23),(305,'Height: 13.02ft (3.97 m)',23),(306,'Weight (Empty): 6,658 lb (3,020 kg)',23),(307,'Weight (MTOW): 11,464 lb (5,200 kg)',23),(308,'Powerplant: 1 x Pratt &amp; Whitney Canada PT6A-68C developing 1,600 horsepower.',23),(309,'Maximum Speed: 229 mph (368 kmh; 199 kts)',23),(310,'Maximum Range: 2,995 miles (4,820 km)',23),(311,'Service Ceiling: 35,007 ft (10,670 m; 6.6 miles)',23),(312,'Rate-of-Climb: 79 feet-per-minute (24 m/min)',23),(313,'Hardpoints: 5',23),(314,'Crew: 2',23),(315,'Initial Year of Service: 1989',24),(316,'Length: 43.41 ft (13.23 m)',24),(317,'Width: 29.10 ft (8.87 m)',24),(318,'Height: 14.93ft (4.55 m)',24),(319,'Weight (Empty): 14,837 lb (6,730 kg)',24),(320,'Weight (MTOW): 28,660 lb (13,000 kg)',24),(321,'Powerplant: 1 x Rolls-Royce Spey Mk 807 non-afterburning turbofan engine developing 11,030 lb of thrust',24),(322,'Maximum Speed: 651 mph (1,047 kmh; 565 kts)',24),(323,'Maximum Range: 345 miles (556 km)',24),(324,'Service Ceiling: 42,651 ft (13,000 m; 8.1 miles)',24),(325,'Rate-of-Climb: 10,250 feet-per-minute (3,124 m/min)',24),(326,'Hardpoints: 7 (including wingtips)',24),(327,'Initial Year of Service: 1992',25),(328,'Length: 73.16 ft (22.3 m)',25),(329,'Width: 41.99 ft (12.80 m)',25),(330,'Height: 20.34ft (6.20 m)',25),(331,'Weight (Empty): 31,967 lb (14,500 kg)',25),(332,'Weight (MTOW): 62,832 lb (28,500 kg)',25),(333,'Powerplant: 1 x Xian WS9 (Spey Mk 202) turbofan engine producing 12,250lbs thrust on dry and 20,500lbs thrust with reheat',25),(334,'Maximum Speed: 1,118 mph (1,800 kmh; 972 kts)',25),(335,'Maximum Range: 2,299 miles (3,700 km)',25),(336,'Service Ceiling: 52,493 ft (16,000 m; 9.9 miles)',25),(337,'Hardpoints: 9',25),(338,'Crew: 2',25),(339,'',24);
/*!40000 ALTER TABLE `details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `featured`
--

DROP TABLE IF EXISTS `featured`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `featured` (
  `product_id` bigint(20) unsigned NOT NULL,
  `added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`,`added`),
  CONSTRAINT `feat_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `featured`
--

LOCK TABLES `featured` WRITE;
/*!40000 ALTER TABLE `featured` DISABLE KEYS */;
INSERT INTO `featured` VALUES (9,'2016-06-05 16:46:39'),(15,'2016-06-05 16:46:49'),(16,'2016-06-05 16:46:46'),(17,'2016-06-05 16:46:44'),(24,'2016-06-05 16:51:39');
/*!40000 ALTER TABLE `featured` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `order_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `address` varchar(250) DEFAULT NULL,
  `sent` tinyint(4) DEFAULT NULL,
  `total` decimal(14,2) DEFAULT NULL,
  `sold` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  KEY `user_id_order_fk` (`user_id`),
  CONSTRAINT `user_id_order_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,4,'some address',1,30000.00,'2016-05-03 16:35:40'),(2,4,'another address',1,3000000.00,'2016-05-03 23:22:57'),(3,4,NULL,1,685000000.00,'2016-05-26 20:49:36'),(4,5,'address',1,493100000.00,'2016-05-26 21:33:59'),(5,4,NULL,1,7000000.00,'2016-05-26 21:43:58'),(6,4,NULL,1,243000000.00,'2016-06-01 16:39:50'),(7,5,'address',1,140000000.00,'2016-06-06 10:55:12'),(8,4,NULL,1,294200000.00,'2016-06-06 12:07:33'),(10,5,'address',1,4500000.00,'2016-08-29 23:18:40'),(11,5,'address',1,25000000.00,'2016-08-31 00:30:13'),(12,1,NULL,1,409000000.00,'2016-10-01 09:47:40'),(13,1,NULL,1,9000000.00,'2016-10-03 02:34:17');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_products`
--

DROP TABLE IF EXISTS `orders_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_products` (
  `order_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  KEY `product_id_orders_fk` (`product_id`),
  KEY `order_id_fk` (`order_id`),
  CONSTRAINT `order_id_fk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `product_id_orders_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_products`
--

LOCK TABLES `orders_products` WRITE;
/*!40000 ALTER TABLE `orders_products` DISABLE KEYS */;
INSERT INTO `orders_products` VALUES (1,18),(1,18),(1,24),(2,15),(2,8),(2,8),(3,18),(3,18),(3,15),(4,24),(4,7),(4,17),(5,20),(6,9),(6,25),(6,23),(6,11),(7,15),(7,19),(7,23),(8,21),(8,11),(8,25),(8,21),(10,10),(11,25),(12,17),(12,17),(12,22),(13,23);
/*!40000 ALTER TABLE `orders_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `product_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `category` varchar(50) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `price` decimal(14,2) NOT NULL,
  `imagePath` varchar(250) NOT NULL,
  `hits` int(11) NOT NULL DEFAULT '0',
  `sold` int(11) NOT NULL DEFAULT '0',
  `sale` tinyint(4) NOT NULL DEFAULT '0',
  `featured` tinyint(4) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `name` (`name`),
  KEY `user_id_fk` (`user_id`),
  CONSTRAINT `user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (4,'Fairchild Republic A-10 Thunderbolt II','ground-attack','The A-10 was designed around the 30 mm GAU-8 Avenger rotary cannon that is its primary armament. The A-10\'s airframe was designed for durability, with measures such as 1,200 pounds (540 kg) of titanium armor to protect the cockpit and aircraft systems, enabling it to absorb a significant amount of damage and continue flying. Its short takeoff and landing capability permits operation from airstrips close to the front lines, while its simple design enables maintenance at forward bases with limited facilities',18800000.00,'A-10.jpg',59,0,0,0,'2016-09-30 22:46:29',1),(7,'Rockwell B-1 Lancer','bombers','The Rockwell (now part of Boeing) B-1 Lancer[N 1] is a four-engine supersonic variable-sweep wing, jet-powered heavy strategic bomber used by the United States Air Force (USAF). It was first envisioned in the 1960s as a supersonic bomber with Mach 2 speed, and sufficient range and payload to replace the Boeing B-52 Stratofortress. It was developed into the B-1B, primarily a low-level penetrator with long range and Mach 1.25 speed capability at high altitude. It is commonly called the \"Bone\" (originally from \"B-One\").',283100000.00,'Rockwell_B_1_Lancer.jpg',24,0,0,0,'2016-09-30 22:46:29',1),(8,'Northrop Grumman B-2 Spirit','bombers','The Northrop Grumman B-2 \"Spirit\" (generically referred to as the \"Stealth Bomber\") became the pinnacle of tail-less flight design that began in the mind of Northrop founder, Jack Northrop. Not only was the B-2 groundbreaking in its use of a tail-less approach, but the aircraft was designed from the outset with radar-evading/absorbing \"stealth\" capabilities in mind, generating a small heat signature and slim profile that incorporated body-coating materials. This would allow the bomber to infiltrate enemy airspace, hit vital targets against an unsuspecting enemy with precision weapons, and leave the area undetected - forming the spearhead of an assault that was to lead the way for additional waves of \"non-stealth\" aircraft to finish the job.',2000000000.00,'b2.jpg',4,0,0,0,'2016-09-30 22:46:29',1),(9,'Boeing B-52 Stratofortress','bombers','For more than 40 years B-52 Stratofortresses have been the backbone of the manned strategic bomber force for the United States. The B-52 is capable of dropping or launching the widest array of weapons in the U.S. inventory. This includes gravity bombs, cluster bombs, precision guided missiles and joint direct attack munitions. Updated with modern technology the B-52 will be capable of delivering the full complement of joint developed weapons and will continue into the 21st century as an important element of our nation\'s defenses. Current engineering analyses show the B-52\'s life span to extend beyond the year 2040.',84000000.00,'boeing_b-52jpg',3,0,0,1,'2016-09-30 22:46:29',1),(10,'IAI Kfir','fighters','The Israel Aircraft Industries Kfir  \"Lion Cub\" is an Israeli-built all-weather, multirole combat aircraft based on a modified French Dassault Mirage 5 airframe, with Israeli avionics and an Israeli-built version of the General Electric J79 turbojet engine.',4500000.00,'kfir.jpg',36,1,0,0,'2016-09-30 22:46:29',1),(11,'Eurofighter Typhoon','fighters','The Eurofighter Typhoon is a highly agile aircraft, designed to be a supremely effective dogfighter when in combat with other aircraft.[9] Later production aircraft have been increasingly better equipped to undertake air-to-surface strike missions and to be compatible with a likewise increasing number of different armaments and equipment including Storm Shadow and the RAF\'s Brimstone. The Typhoon saw its combat debut during the 2011 military intervention in Libya with the Royal Air Force and the Italian Air Force, performing aerial reconnaissance and ground strike missions. The type has also taken primary responsibility for air-defence duties for the majority of customer nations.',125000000.00,'eurofighter typhoon.jpg',14,1,0,0,'2016-09-30 22:46:29',1),(12,'Mikoyan MiG-29 Fulcrum','fighters','The Mikoyan MiG-29 (NATO reporting name: \"Fulcrum\") is a twin-engine jet fighter aircraft designed in the Soviet Union. Developed by the Mikoyan design bureau as an air superiority fighter during the 1970s, the MiG-29, along with the larger Sukhoi Su-27, was developed to counter new American fighters such as the McDonnell Douglas F-15 Eagle, and the General Dynamics F-16 Fighting Falcon.[6] The MiG-29 entered service with the Soviet Air Force in 1982.',29000000.00,'Mig29 Polish.jpg',17,0,1,0,'2016-09-30 22:46:29',1),(13,'Lockheed Martin F-22 Raptor','fighters','The Lockheed Martin F-22 Raptor is a single-seat, twin-engine, all-weather stealth tactical fighter aircraft developed for the United States Air Force (USAF). The result of the USAF\'s Advanced Tactical Fighter program, the aircraft was designed primarily as an air superiority fighter, but has additional capabilities including ground attack, electronic warfare, and signals intelligence roles.[6] Lockheed Martin is the prime contractor and was responsible for the majority of the airframe, weapon systems, and final assembly of the F-22, while program partner Boeing provided the wings, aft fuselage, avionics integration, and training systems.',150000000.00,'f-22 raptor.jpg',5,0,0,0,'2016-09-30 22:46:29',4),(14,'Saab JAS 39 Gripen','fighters','The Saab JAS 39 Gripen  is a light single-engine multirole fighter aircraft manufactured by the Swedish aerospace company Saab. It was designed to replace the Saab 35 Draken and 37 Viggen in the Swedish Air Force (Flygvapnet). The Gripen has a delta wing and canard configuration with relaxed stability design and fly-by-wire flight controls. It is powered by the Volvo RM12, and has a top speed of Mach 2. Later aircraft are modified for NATO interoperability standards and to undertake in-flight refuelling.',68900000.00,'saab gripen.jpg',12,0,0,0,'2016-09-30 22:46:29',4),(15,'Lockheed Martin F-35 Lightning II','fighters','The Lockheed Martin F-35 Lightning II is a family of single-seat, single-engine, all-weather stealth multirole fighters undergoing final development and testing by the United States. The fifth generation combat aircraft is designed to perform ground attack, aerial reconnaissance, and air defense missions. The F-35 has three main models: the F-35A conventional takeoff and landing (CTOL) variant, the F-35B short take-off and vertical-landing (STOVL) variant, and the F-35C carrier-based Catapult Assisted Take-Off But Arrested Recovery (CATOBAR) variant.',85000000.00,'F-35.jpg',25,1,0,1,'2016-09-30 22:46:29',4),(16,'Dassault Rafale','fighters','The Dassault Rafale ( Literally meaning \"gust of wind\", and \"burst of fire\" in a more military sense) is a French twin-engine, canard delta wing, multirole fighter aircraft designed and built by Dassault Aviation. Equipped with a wide range of weapons, the Rafale is intended to perform air supremacy, interdiction, aerial reconnaissance, and nuclear strike missions.',94000000.00,'rafale.jpg',17,0,0,1,'2016-09-30 22:46:29',4),(17,'Tupolev Tu-22M','bombers','The Tupolev Tu-22M (NATO reporting name: Backfire) is a supersonic, variable-sweep wing, long-range strategic and maritime strike bomber developed by the Tupolev Design Bureau.',200000000.00,'Tupolev_Tu_22M_bomber.jpg',11,2,0,1,'2016-09-30 22:46:29',4),(18,'Tupolev Tu-160','bombers','The Tupolev Tu-160 (NATO reporting name: Blackjack) is a supersonic, variable-sweep wing heavy strategic bomber designed by the Tupolev Design Bureau in the Soviet Union. Although several civil and military transport aircraft are larger in overall dimensions, the Tu-160 is the world\'s largest combat aircraft, largest supersonic aircraft and largest variable-sweep aircraft built.',300000000.00,'Tupolev_Tu_160_Blackjack.jpg',11,0,0,0,'2016-09-30 22:46:29',4),(19,'Xian H-6','bombers','The Xian H-6  is a license-built version of the Soviet Tupolev Tu-16 twin-engine jet bomber, built for the Chinese People\'s Liberation Army Air Force.',46000000.00,'xian h-6.jpg',20,2,1,0,'2016-09-30 22:46:29',4),(20,'Xian Y-20','transport','The Xian Y-20  is a large military transport aircraft. The project is being developed by Xi\'an Aircraft Industrial Corporation and was officially launched in 2006. The official codename of the aircraft is Kunpeng  after the mythical bird of ancient China that can fly for thousands of kilometres.',7000000.00,'Xian Y-20.jpg',29,1,0,0,'2016-09-30 22:46:29',4),(21,'Bell Boeing V-22 Osprey','transport','The Bell Boeing V-22 Osprey is an American multi-mission, tiltrotor military aircraft with both a vertical takeoff and landing (VTOL), and short takeoff and landing (STOL) capability. It is designed to combine the functionality of a conventional helicopter with the long-range, high-speed cruise performance of a turboprop aircraft.',72100000.00,'V22_Osprey.jpg',17,2,0,0,'2016-09-30 22:46:29',5),(22,'Ilyushin Il-76','transport','The Ilyushin IL-76 heavy transport was debuted in the early 1970s, entered service in the mid-1970s and is still operating today - some 36 years after its inception. At any rate, the IL-76 has proven something of a success story worldwide with an estimated 960 examples delivered. The airframe has also become highly adaptable to the needs of its clients in varying roles. Roles include both military and civilian functions, in carrying military paratroopers or civilian passengers as well as heavy cargo hauling. Other roles have been pressed upon the IL-76 including that of Electronic Intelligence (ELINT), AWACS-type duties, airborne hospital, Electronic CounterMeasures (ECM) (IL-76PP), airborne command post (IL-VPK), maritime Search and Rescue (SAR), firefighting, \"Zero-G\" training for Russian cosmonauts (IL-76MDK) and aerial refueling.',9000000.00,'ilyushin-il-76-06.jpg',16,1,0,0,'2016-09-30 22:46:29',5),(23,'Embraer EMB 314 Super Tucano','ground-attack','The Embraer EMB 314 Super Tucano, also named ALX or A-29 is a turboprop aircraft designed for light attack, counter insurgency (COIN), close air support, aerial reconnaissance missions in low threat environments, as well as providing pilot training. Designed to operate in high temperature and humidity conditions in extremely rugged terrain, the Super Tucano is highly maneuverable, has a low heat signature, incorporates 4th generation avionics and weapons system to deliver precision guided munitions',9000000.00,'Super Tucano.jpg',23,2,0,0,'2016-09-30 22:46:29',5),(24,'International AMX','ground-attack','The AMX International AMX is a ground-attack aircraft for battlefield interdiction, close air support and reconnaissance missions. It was built until 1999 by AMX International, an Italian-Brazilian joint venture. The AMX is designated A-1 by the Brazilian Air Force, and A-11 Ghibli by the Italian Air Force.\r\n\r\nThe AMX is capable of operating at high subsonic speed and low altitude, by day or night, and if necessary, from bases with poorly equipped or damaged runways. Low IR signature and reduced radar equivalent cross-section help prevent detection, while low vulnerability of structure and systems aid survivability, while integrated ECM, air-to-air missiles and nose-mounted guns provide self-defence capabilities.',10000000.00,'AMX International.jpg',63,0,1,1,'2016-09-30 22:46:29',5),(25,'Xian JH-7','ground-attack','The Xian JH-7 (Jianjiji Hongzhaji  fighter-bomber); NATO reporting name Flounder), also known as the FBC-1 (Fighter/Bomber China-1) Flying Leopard, is a tandem two-seat, twin-engine fighter-bomber in service with the People\'s Liberation Army Naval Air Force (PLANAF), and the People\'s Liberation Army Air Force (PLAAF).[4] The main contractors are Xian Aircraft Industrial Corporation (XAC) and the 603rd Aircraft Design Institute (later named the First Aircraft Institute of AVIC-I)',25000000.00,'Xian JH-72.jpg',32,3,0,0,'2016-09-30 22:46:29',5);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews` (
  `review_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `message` varchar(500) NOT NULL,
  `rating` smallint(10) NOT NULL DEFAULT '5',
  `user_id` bigint(20) unsigned NOT NULL,
  `posted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `product_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`review_id`),
  KEY `user_id_review_fk` (`user_id`),
  KEY `product_id_review_fk` (`product_id`),
  CONSTRAINT `product_id_review_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  CONSTRAINT `user_id_review_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,'Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur',3,1,'2016-09-30 22:47:02',4),(2,'Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur',3,1,'2016-09-30 22:47:02',4),(3,'Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur',1,1,'2016-09-30 22:47:02',4),(4,'Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur',2,1,'2016-09-30 22:47:02',11),(5,'Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur',5,1,'2016-09-30 22:47:02',4),(6,'Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur',5,1,'2016-09-30 22:47:02',23);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks` (
  `task_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `description` varchar(500) NOT NULL,
  `message` varchar(500) DEFAULT NULL,
  `assigner` varchar(50) NOT NULL,
  `assignee` varchar(50) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `completed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `complete` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`task_id`),
  KEY `assigner_fk` (`assigner`),
  KEY `assignee_fk` (`assignee`),
  CONSTRAINT `assignee_fk` FOREIGN KEY (`assignee`) REFERENCES `users` (`username`) ON DELETE CASCADE,
  CONSTRAINT `assigner_fk` FOREIGN KEY (`assigner`) REFERENCES `users` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,'testTask1','and empty test task',NULL,'user2','user3','2016-05-20 08:27:38','2016-05-20 08:27:38',1),(2,'testTask2','and empty test task',NULL,'user3','user3','2016-05-20 08:28:05','0000-00-00 00:00:00',0),(3,'testTask2','and empty test task',NULL,'user3','user2','2016-05-20 08:28:08','0000-00-00 00:00:00',0);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(125) NOT NULL,
  `email` varchar(150) NOT NULL,
  `address` varchar(250) NOT NULL,
  `details` varchar(250) DEFAULT NULL,
  `imagePath` varchar(250) DEFAULT NULL,
  `createdOn` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `enabled` tinyint(4) NOT NULL DEFAULT '1',
  `locked` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'user1','$2a$12$VS/uHFtA/hOd2.inb05e3u9Mx5RryLvU6zdU2cDxDBL5TmMwS/m/.','email1@email.com','','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.','user.jpg','2016-09-30 22:45:55',1,1),(4,'user2','$2a$12$5iF1uK78PGunRm559tepCO5j6diYRqsEbosP7ILrbZBYtWK.eCnam','email2@email.com','missing','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.','user.jpg','2016-09-30 22:45:55',1,1),(5,'user3','$2a$12$VS/uHFtA/hOd2.inb05e3u9Mx5RryLvU6zdU2cDxDBL5TmMwS/m/.','email@email.com','missing','an admin account','eCgPZnhh.jpg','2016-09-30 22:45:55',1,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-03 17:48:00

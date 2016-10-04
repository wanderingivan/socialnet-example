

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_class`
--

LOCK TABLES `acl_class` WRITE;
/*!40000 ALTER TABLE `acl_class` DISABLE KEYS */;
INSERT INTO `acl_class` VALUES (8,'com.socialnet.model.Article'),(9,'com.socialnet.model.User');
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_entry`
--

LOCK TABLES `acl_entry` WRITE;
/*!40000 ALTER TABLE `acl_entry` DISABLE KEYS */;
INSERT INTO `acl_entry` VALUES (1,3,0,12,2,1,0,0),(2,3,1,12,1,1,0,0),(3,4,0,13,2,1,0,0),(4,4,1,13,1,1,0,0),(5,5,0,14,2,1,0,0),(6,5,1,14,1,1,0,0),(7,6,0,15,2,1,0,0),(8,6,1,15,1,1,0,0),(9,7,0,16,2,1,0,0),(10,7,1,16,1,1,0,0),(11,8,0,17,2,1,0,0),(12,8,1,17,1,1,0,0),(13,9,0,18,2,1,0,0),(14,9,1,18,1,1,0,0),(15,10,0,19,2,1,0,0),(16,10,1,19,1,1,0,0),(17,11,0,20,2,1,0,0),(18,11,1,20,1,1,0,0),(19,12,0,21,2,1,0,0),(20,12,1,21,1,1,0,0),(21,13,0,22,2,1,0,0),(22,13,1,22,1,1,0,0),(23,14,0,24,2,1,0,0),(24,14,1,24,1,1,0,0),(25,15,0,25,2,1,0,0),(26,15,1,25,1,1,0,0),(27,16,0,26,2,1,0,0),(28,16,1,26,1,1,0,0),(29,17,0,13,2,1,0,0),(30,17,1,13,1,1,0,0),(31,18,0,16,2,1,0,0),(32,18,1,16,1,1,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_object_identity`
--

LOCK TABLES `acl_object_identity` WRITE;
/*!40000 ALTER TABLE `acl_object_identity` DISABLE KEYS */;
INSERT INTO `acl_object_identity` VALUES (3,8,3,NULL,12,1),(4,8,4,NULL,13,1),(5,8,5,NULL,14,1),(6,8,6,NULL,15,1),(7,8,7,NULL,16,1),(8,8,8,NULL,17,1),(9,8,9,NULL,18,1),(10,8,10,NULL,19,1),(11,8,11,NULL,20,1),(12,8,12,NULL,21,1),(13,8,14,NULL,22,1),(14,9,15,NULL,24,1),(15,9,16,NULL,25,1),(16,9,17,NULL,26,1),(17,9,18,NULL,13,1),(18,9,19,NULL,16,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_sid`
--

LOCK TABLES `acl_sid` WRITE;
/*!40000 ALTER TABLE `acl_sid` DISABLE KEYS */;
INSERT INTO `acl_sid` VALUES (24,1,'admin'),(11,1,'anonymousUser'),(21,1,'newUser'),(23,1,'newUser1'),(27,1,'username with spaces in'),(25,1,'username1'),(20,1,'username1138'),(26,1,'username2'),(14,1,'username23'),(15,1,'username23456'),(13,1,'username3'),(22,1,'username30001'),(12,1,'username359'),(16,1,'username4'),(17,1,'username5'),(18,1,'username61'),(19,1,'username62');
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
  PRIMARY KEY (`username`,`authority`),
  CONSTRAINT `username_fk_auth` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorities`
--

LOCK TABLES `authorities` WRITE;
/*!40000 ALTER TABLE `authorities` DISABLE KEYS */;
INSERT INTO `authorities` VALUES ('admin','ROLE_ADMIN'),('username1','ROLE_USER'),('username2','ROLE_USER'),('username3','ROLE_USER'),('username4','ROLE_USER');
/*!40000 ALTER TABLE `authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_messages`
--

DROP TABLE IF EXISTS `chat_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat_messages` (
  `message_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message` varchar(180) NOT NULL,
  `sent` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `chat_id` bigint(20) DEFAULT NULL,
  `sender_id` bigint(20) DEFAULT NULL,
  `read` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`message_id`),
  KEY `m_sender_id_fk` (`sender_id`),
  KEY `conversation_id_fk` (`chat_id`),
  CONSTRAINT `conversation_id_fk` FOREIGN KEY (`chat_id`) REFERENCES `chats` (`chat_id`) ON DELETE CASCADE,
  CONSTRAINT `m_sender_id_fk` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_messages`
--

LOCK TABLES `chat_messages` WRITE;
/*!40000 ALTER TABLE `chat_messages` DISABLE KEYS */;
INSERT INTO `chat_messages` VALUES (1,'Ipsum lorem','2016-10-01 20:04:33',7,17,1),(2,'Etiam semper justo eu metus semper bibendum.','2016-10-01 20:19:01',8,19,1),(3,'Ut ullamcorper vestibulum tortor ut eleifend. ','2016-10-01 20:19:57',8,18,1),(4,'Donec id orci lacinia, egestas purus sit amet, posuere mauris. Nunc sagittis accumsan massa, at dapibus felis feugiat sit amet.','2016-10-01 20:26:32',8,19,1),(5,'Donec ipsum est, iaculis et dui et, iaculis iaculis nunc. Proin volutpat lectus vel nibh volutpat auctor. Fusce purus risus, condimentum ac dictum','2016-10-01 20:26:57',9,19,1),(6,'Maecenas justo turpis, pretium vel ipsum nec, maximus venenatis dolor. Donec vitae luctus quam.','2016-10-03 12:19:24',7,16,0),(7,'Lorem ipsum dolor sit amet','2016-10-03 13:35:27',10,19,0),(8,'Aliquam sollicitudin arcu in tortor auctor ornare. Vivamus eget massa a lacus condimentum fringilla. Morbi tristique eu sapien vel accumsan.','2016-10-03 13:36:25',11,18,0),(9,'Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Morbi eget ligula quis nisi tristique vehicula sit amet ut magna. Nunc pharetra luctus o','2016-10-03 13:36:41',8,18,0),(10,'Duis tempor enim ac eros eleifend, in finibus ante','2016-10-03 13:38:18',11,16,0),(11,'Duis tempor enim ac eros eleifend, in finibus ante','2016-10-03 13:39:10',10,16,0);
/*!40000 ALTER TABLE `chat_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chats`
--

DROP TABLE IF EXISTS `chats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chats` (
  `chat_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`chat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats`
--

LOCK TABLES `chats` WRITE;
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
INSERT INTO `chats` VALUES (1,'2016-08-30 16:12:19'),(2,'2016-04-07 13:44:14'),(3,'2016-04-06 13:19:28'),(4,'2016-06-17 23:21:57'),(5,'2016-06-16 18:44:31'),(6,'2016-06-19 12:38:24'),(7,'2016-10-03 12:19:24'),(8,'2016-10-03 13:36:41'),(9,'2016-10-01 20:26:57'),(10,'2016-10-03 13:39:10'),(11,'2016-10-03 13:38:18');
/*!40000 ALTER TABLE `chats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chats_join_table`
--

DROP TABLE IF EXISTS `chats_join_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chats_join_table` (
  `chat_id` bigint(20) NOT NULL DEFAULT '0',
  `user_id` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`chat_id`),
  KEY `chat_id_fk` (`chat_id`),
  CONSTRAINT `chat_id_fk` FOREIGN KEY (`chat_id`) REFERENCES `chats` (`chat_id`) ON DELETE CASCADE,
  CONSTRAINT `user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats_join_table`
--

LOCK TABLES `chats_join_table` WRITE;
/*!40000 ALTER TABLE `chats_join_table` DISABLE KEYS */;
INSERT INTO `chats_join_table` VALUES (7,16),(7,17),(8,18),(8,19),(9,17),(9,19),(10,16),(10,19),(11,16),(11,18);
/*!40000 ALTER TABLE `chats_join_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `details`
--

DROP TABLE IF EXISTS `details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `details` (
  `details_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `occupation` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`details_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `details`
--

LOCK TABLES `details` WRITE;
/*!40000 ALTER TABLE `details` DISABLE KEYS */;
INSERT INTO `details` VALUES (1,'occupation','address',NULL,'new description'),(2,'kibik','face2',NULL,'this user has no special details'),(3,'','',NULL,''),(7,'La 5FN bait','Berlin',NULL,'This user plays way too much outdated flight sims'),(9,'','',NULL,'An admin account'),(10,'Placeholder','',NULL,'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.'),(11,'','',NULL,'Maecenas eget lectus sed massa tempor dignissim ac quis lacus'),(12,'Placeholder user','',NULL,'Integer nec magna hendrerit, convallis sem at, tristique nibh. Donec ipsum est, iaculis et dui et, iaculis iaculis nunc. Proin volutpat lectus vel nibh volutpat auctor. Fusce purus risus, condimentum ac dictum a, hendrerit ac erat.');
/*!40000 ALTER TABLE `details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_requests`
--

DROP TABLE IF EXISTS `friend_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friend_requests` (
  `friend_request_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `accepted` tinyint(4) NOT NULL DEFAULT '0',
  `denied` tinyint(4) NOT NULL DEFAULT '0',
  `sender_id` bigint(20) NOT NULL,
  `receiver_id` bigint(20) NOT NULL,
  PRIMARY KEY (`friend_request_id`),
  KEY `fr_sender_id_fk` (`sender_id`),
  KEY `fr_receiver_id_fk` (`receiver_id`),
  CONSTRAINT `fr_receiver_id_fk` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `fr_sender_id_fk` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_requests`
--

LOCK TABLES `friend_requests` WRITE;
/*!40000 ALTER TABLE `friend_requests` DISABLE KEYS */;
INSERT INTO `friend_requests` VALUES (1,1,0,17,16),(2,1,0,18,16),(3,1,0,18,17),(4,1,0,19,17),(5,1,0,19,18),(6,0,0,19,16);
/*!40000 ALTER TABLE `friend_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friendships`
--

DROP TABLE IF EXISTS `friendships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friendships` (
  `user1_id` bigint(20) NOT NULL DEFAULT '0',
  `user2_id` bigint(20) NOT NULL DEFAULT '0',
  `createdOn` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user1_id`,`user2_id`),
  KEY `user2_id_fk` (`user2_id`),
  CONSTRAINT `user1_id_fk` FOREIGN KEY (`user1_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `user2_id_fk` FOREIGN KEY (`user2_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friendships`
--

LOCK TABLES `friendships` WRITE;
/*!40000 ALTER TABLE `friendships` DISABLE KEYS */;
INSERT INTO `friendships` VALUES (16,17,'2016-10-01 20:05:38'),(16,18,'2016-10-03 12:33:25'),(17,16,'2016-10-01 20:05:38'),(17,18,'2016-10-01 20:21:21'),(17,19,'2016-10-01 20:21:23'),(18,16,'2016-10-03 12:33:25'),(18,17,'2016-10-01 20:21:21'),(18,19,'2016-10-01 20:19:41'),(19,17,'2016-10-01 20:21:23'),(19,18,'2016-10-01 20:19:41');
/*!40000 ALTER TABLE `friendships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `image_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `imagePath` varchar(250) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `description` varchar(60) DEFAULT NULL,
  `uploaded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`image_id`),
  KEY `image_user_id_fk` (`user_id`),
  CONSTRAINT `image_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (8,'HD_VRSCDX_Night_Rod_Spec',NULL,'test','2016-03-18 18:20:28'),(9,'HD_VRSCDX_Night_Rod_Special_2010_02_1280x1024.jpg',NULL,'test2','2016-03-18 18:22:49'),(10,'userimage2.jpg',16,'Profile picture','2016-10-01 19:57:50'),(11,'2016.jpg',16,'cover image','2016-10-01 19:58:58'),(12,'concert.jpg',16,'Concert image','2016-10-01 19:59:44'),(13,'church.jpg',16,'church','2016-10-01 20:00:30'),(14,'userimage1.jpg',17,'profile image','2016-10-01 20:01:59'),(15,'conference.jpg',17,'Conference room','2016-10-01 20:02:47'),(16,'userimage3.jpg',18,'Profile image','2016-10-01 20:10:13'),(17,'sportscar.jpg',18,'sports car','2016-10-01 20:11:49'),(18,'userimage4.jpg',19,'profile image','2016-10-01 20:15:17'),(19,'sunsetbeach.jpg',19,'Sunset at a beach','2016-10-01 20:16:13'),(20,'swans.jpg',19,'Swans at sunset','2016-10-01 20:24:54'),(21,'scyscrapers.jpg',17,'scyscrapers','2016-10-03 11:34:50'),(22,'concerta.jpg',16,'A concert','2016-10-03 11:56:00');
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `likes_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sender_id` bigint(20) DEFAULT NULL,
  `wall_post_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`likes_id`),
  KEY `like_sender_id_fk` (`sender_id`),
  KEY `like_wp_id_fk` (`wall_post_id`),
  CONSTRAINT `like_sender_id_fk` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `like_wp_id_fk` FOREIGN KEY (`wall_post_id`) REFERENCES `wall_posts` (`wall_post_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
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
  CONSTRAINT `assignee_fk` FOREIGN KEY (`assignee`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `assigner_fk` FOREIGN KEY (`assigner`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(180) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `details_id` bigint(20) DEFAULT NULL,
  `profilePic` varchar(250) DEFAULT NULL,
  `coverImage` varchar(250) DEFAULT NULL,
  `createdOn` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `enabled` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  KEY `user_details_fk` (`details_id`),
  CONSTRAINT `user_details_fk` FOREIGN KEY (`details_id`) REFERENCES `details` (`details_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (15,'admin','email@email.com','$2a$12$f6vQ1U8ALraV7sR1xm9/V.AdnRO53NhKjnxbIMTZJqqenGOC3QY1S',NULL,9,'user.jpg','placeholder.jpg','2016-10-01 13:39:23',1),(16,'username1','email@email.com','$2a$12$ibkLB9LbWrkesujkB6X0PuU4O47ynUwhmpR9U7/biEE2QFc0i.Miu',NULL,10,'userimage2.jpg','concert.jpg','2016-10-01 13:49:09',1),(17,'username2','email2@email.com','$2a$12$EJi6Io8tuABWnmuXtoOqUutv6a0yQUIn0LenQMfLGW2EiewV8F9Qu',NULL,NULL,'userimage1.jpg','scyscrapers.jpg','2016-10-01 20:01:19',1),(18,'username3','email3@email.com','$2a$12$vaeaHsPPxdp5atmH8k6FKeLl.YEDUKAAusYp48AhlFPSpr4UFMvcm',NULL,11,'userimage3.jpg','sportscar.jpg','2016-10-01 20:09:19',1),(19,'username4','email4@email.com','$2a$12$iaGZBgjP8jPBhusgoOLFieTwLK1/uIjeZU694ldy2TvGRJT3cpVPu',NULL,12,'userimage4.jpg','sunsetbeach.jpg','2016-10-01 20:14:33',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wall_messages`
--

DROP TABLE IF EXISTS `wall_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wall_messages` (
  `wall_message_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message` varchar(350) NOT NULL,
  `sent` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sender_id` bigint(20) DEFAULT NULL,
  `wall_post_id` bigint(20) DEFAULT NULL,
  `imagePath` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`wall_message_id`),
  KEY `wm_sender_id_fk` (`sender_id`),
  KEY `wall_post_id_fk` (`wall_post_id`),
  CONSTRAINT `wall_post_id_fk` FOREIGN KEY (`wall_post_id`) REFERENCES `wall_posts` (`wall_post_id`) ON DELETE CASCADE,
  CONSTRAINT `wm_sender_id_fk` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wall_messages`
--

LOCK TABLES `wall_messages` WRITE;
/*!40000 ALTER TABLE `wall_messages` DISABLE KEYS */;
INSERT INTO `wall_messages` VALUES (1,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam scelerisque massa metus, non varius odio semper scelerisque. ','2016-10-01 20:06:38',16,1,'cubietruck.jpg'),(2,'Suspendisse potenti. Aliquam laoreet et metus sed ornare. Nam consequat velit at lectus malesuada, in aliquam orci vulputate. ','2016-10-01 20:08:26',16,2,'spaceshuttle.jpg'),(3,'Suspendisse potenti. Aliquam laoreet et metus sed ornare. Nam consequat velit at lectus malesuada, in aliquam orci vulputate. Nulla laoreet porta elit, ac ornare velit fringilla egestas.','2016-10-01 20:12:25',18,3,'sportscar.jpg'),(4,'Sed eget condimentum massa. Nam nisl erat, facilisis a arcu sit amet, pulvinar blandit nulla. Integer mattis laoreet elementum. Quisque vitae euismod libero, vel hendrerit dolor. Phasellus mollis urna sem, et fringilla diam laoreet non. ','2016-10-01 20:18:23',19,4,'28990387124_f28f1c5abc_b.jpg'),(5,'Etiam semper justo eu metus semper bibendum.','2016-10-01 20:18:49',19,3,NULL),(6,'Ut ullamcorper vestibulum tortor ut eleifend. ','2016-10-01 20:19:34',18,4,NULL),(7,'Pellentesque quis viverra quam. Mauris laoreet eleifend ex, dapibus rhoncus magna gravida ac.','2016-10-01 20:20:40',18,3,NULL),(8,'Pellentesque quis viverra quam. Mauris laoreet eleifend ex, dapibus rhoncus magna gravida ac.','2016-10-01 20:22:05',17,5,'screen.jpg'),(9,'Pellentesque quis viverra quam. Mauris laoreet eleifend ex, dapibus rhoncus magna gravida ac.','2016-10-01 20:22:31',17,4,NULL),(10,'Donec feugiat scelerisque tellus ut feugiat. Sed et nulla eu libero hendrerit pellentesque sit amet congue libero.','2016-10-01 20:22:41',17,3,NULL),(11,'Integer nec magna hendrerit, convallis sem at, tristique nibh. Donec ipsum est, iaculis et dui et, iaculis iaculis nunc. Proin volutpat lectus vel nibh volutpat auctor. Fusce purus risus, condimentum ac dictum a, hendrerit ac erat.','2016-10-01 20:23:17',17,6,NULL),(12,'Nam nisl erat, facilisis a arcu sit amet, pulvinar blandit nulla. Integer mattis laoreet elementum. Quisque vitae euismod libero, vel hendrerit dolor. Phasellus mollis urna sem, et fringilla diam laoreet non.','2016-10-01 20:24:22',19,7,NULL),(13,'Donec id orci lacinia, egestas purus sit amet, posuere mauris. Nunc sagittis accumsan massa, at dapibus felis feugiat sit amet.','2016-10-01 20:25:54',19,8,'swans.jpg'),(14,'Aliquam laoreet et metus sed ornare.','2016-10-01 20:27:39',19,5,NULL),(15,'Suspendisse at tempus neque. Duis auctor ullamcorper sollicitudin. Proin ut odio quis nisi semper lobortis varius a neque.','2016-10-01 20:27:55',19,9,NULL),(16,'Integer eu sollicitudin libero, id molestie enim.','2016-10-01 20:28:38',17,9,NULL),(17,'Sed sit amet bibendum libero.','2016-10-01 20:28:46',17,5,NULL),(18,'Sed sit amet bibendum libero.','2016-10-01 20:29:01',17,2,NULL),(19,'Proin fringilla ut lacus et feugiat. Duis vel nisi quis magna imperdiet condimentum vitae sed orci. Nulla facilisi. ','2016-10-01 20:29:10',17,1,NULL),(20,'Ut vitae lorem venenatis, posuere ex non, sagittis eros. Etiam malesuada, eros non rutrum ullamcorper, tortor ante suscipit justo, non lacinia eros metus ac velit.','2016-10-01 20:30:46',17,10,'sportscar.jpg'),(21,'Quisque aliquam ante sit amet massa dapibus sollicitudin. ','2016-10-01 20:31:24',17,2,NULL),(22,'Proin nisi orci, venenatis at augue nec, mattis congue felis.','2016-10-01 20:31:36',17,10,NULL),(23,'Mauris malesuada, odio nec maximus tempus, leo tellus suscipit massa, a convallis risus magna quis risus.','2016-10-03 12:13:08',16,2,NULL),(24,'Maecenas justo turpis, pretium vel ipsum nec, maximus venenatis dolor.','2016-10-03 12:13:19',16,10,NULL),(25,' Suspendisse potenti. Praesent feugiat ullamcorper justo, vel ornare velit venenatis eget. Fusce euismod varius dui, eu placerat mi tincidunt vel. Integer porta sed neque et elementum. ','2016-10-03 12:13:37',16,11,NULL),(26,'Vestibulum dolor nibh, finibus at placerat non, cursus eu libero. Aliquam consectetur, est vel sollicitudin lobortis, nisl augue aliquam metus, at feugiat lectus lacus vitae justo.','2016-10-03 12:17:08',19,12,NULL),(27,'Aliquam erat volutpat. Pellentesque venenatis ultrices erat vitae convallis.','2016-10-03 12:18:27',16,12,NULL),(30,'Pellentesque faucibus venenatis tortor at consectetur. Sed ante magna, elementum at quam a, efficitur commodo odio. Mauris malesuada, odio nec maximus tempus, leo tellus suscipit massa, a convallis risus magna quis risus.','2016-10-03 12:21:58',16,15,'highway1.jpg'),(31,'Lorem ipsum dolor sit amet.','2016-10-03 12:33:50',16,9,NULL),(32,'Lorem ipsum dolor sit ','2016-10-03 12:34:58',16,3,NULL),(33,'In hac habitasse platea dictumst. Suspendisse potenti. Praesent eu nisi efficitur, aliquam sapien sit amet, luctus augue. Maecenas gravida et ex eu laoreet.','2016-10-03 12:38:08',18,16,NULL),(34,'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Morbi vitae fringilla ante, et sollicitudin velit. Cras vitae metus vitae velit convallis varius sed id tellus. ','2016-10-03 12:39:17',16,17,'concerta.jpg'),(35,'Nam quam est, porttitor eu metus ac, congue tempus ipsum.','2016-10-03 12:41:16',16,16,NULL),(36,'Praesent eget mauris vulputate, gravida nibh sed, facilisis elit.','2016-10-03 12:58:06',19,16,NULL),(37,'Sed vel eros ac lectus luctus lacinia in non lacus. Nulla risus nulla, volutpat eu egestas ac, sagittis et nibh. Maecenas ut lacus sed ante venenatis pellentesque.','2016-10-03 12:59:50',19,17,NULL),(38,'Aliquam tempor, dui convallis ullamcorper tincidunt, arcu mauris congue tellus, ornare vestibulum est nibh ut enim. Maecenas non pharetra justo. Proin lobortis sollicitudin aliquam. Nam id porttitor dolor.','2016-10-03 13:04:07',18,16,NULL),(39,'Pellentesque volutpat, diam ac blandit commodo, leo augue dictum neque, sit amet posuere est ipsum in tellus.','2016-10-03 13:04:47',18,17,NULL),(40,'Sed vel eros ac lectus luctus lacinia in non lacus. Nulla risus nulla, volutpat eu egestas ac, sagittis et nibh. Maecenas ut lacus sed ante venenatis pellentesque.','2016-10-03 13:06:25',17,17,NULL),(41,'Suspendisse non massa non sem posuere hendrerit non eu velit.','2016-10-03 13:06:54',16,17,NULL),(42,'Praesent vel pulvinar quam, ut varius lorem.','2016-10-03 13:07:38',18,17,NULL),(43,'Sed tempor tempus diam ac eleifend. ','2016-10-03 13:13:13',17,17,NULL);
/*!40000 ALTER TABLE `wall_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wall_posts`
--

DROP TABLE IF EXISTS `wall_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wall_posts` (
  `wall_post_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `owner_id` bigint(20) NOT NULL,
  PRIMARY KEY (`wall_post_id`),
  KEY `wp_user_id_fk` (`owner_id`),
  CONSTRAINT `wp_user_id_fk` FOREIGN KEY (`owner_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wall_posts`
--

LOCK TABLES `wall_posts` WRITE;
/*!40000 ALTER TABLE `wall_posts` DISABLE KEYS */;
INSERT INTO `wall_posts` VALUES (1,16),(2,16),(10,16),(11,16),(12,16),(15,16),(16,16),(17,16),(5,17),(9,17),(3,18),(4,18),(6,18),(7,19),(8,19);
/*!40000 ALTER TABLE `wall_posts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-04 10:05:09

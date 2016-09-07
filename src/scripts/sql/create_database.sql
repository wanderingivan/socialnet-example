DROP TABLE IF EXISTS `acl_entry`;
DROP TABLE IF EXISTS `acl_object_identity`;
DROP TABLE IF EXISTS `acl_class`;
DROP TABLE IF EXISTS `acl_sid`;
DROP TABLE IF EXISTS `authorities`;

DROP TABLE IF EXISTS `friendships`;
DROP TABLE IF EXISTS `chat_messages`;
DROP TABLE IF EXISTS `chats_join_table`;
DROP TABLE IF EXISTS `chats`;

DROP TABLE IF EXISTS `friend_requests`;
DROP TABLE IF EXISTS `wall_messages`;
DROP TABLE IF EXISTS `likes`;
DROP TABLE IF EXISTS `wall_posts`;
DROP TABLE IF EXISTS `images`;
DROP TABLE IF EXISTS `tasks`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `details`;





CREATE TABLE details(
	`details_id` BIGINT NOT NULL AUTO_INCREMENT,
	`occupation` VARCHAR(50),
  	`description` VARCHAR(250),
  	`address` VARCHAR(50),
	`birthday` DATE,
	PRIMARY KEY(details_id)
)ENGINE=InnoDB;

CREATE TABLE users(
	`user_id` BIGINT NOT NULL AUTO_INCREMENT,
	`username` VARCHAR(50) NOT NULL UNIQUE,
	`email` VARCHAR(50) NOT NULL UNIQUE,
	`password` VARCHAR(180) NOT NULL, 
	`description` VARCHAR(250),
	`details_id` BIGINT,
	`profilePic` VARCHAR(250),
  	`coverImage` VARCHAR(250),
	`createdOn` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`enabled` TINYINT DEFAULT 1,
	CONSTRAINT user_details_fk FOREIGN KEY(details_id) REFERENCES details(details_id),
	PRIMARY KEY(user_id)
)ENGINE=InnoDB;



CREATE TABLE images(
  `image_id` BIGINT NOT NULL AUTO_INCREMENT,
	`imagePath` VARCHAR(250)  NOT NULL,
	`user_id` BIGINT,
	`description` VARCHAR(60),
	`uploaded` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT image_user_id_fk FOREIGN KEY(`user_id`) REFERENCES users(`user_id`) ON DELETE CASCADE,
	PRIMARY KEY(`image_id`)
)ENGINE=InnoDB;



CREATE TABLE wall_posts(
	`wall_post_id` BIGINT  NOT NULL AUTO_INCREMENT,
  `owner_id` BIGINT NOT NULL,
	CONSTRAINT wp_user_id_fk FOREIGN KEY(`owner_id`) REFERENCES users(`user_id`) ON DELETE CASCADE,
  PRIMARY KEY(wall_post_id)
)ENGINE=InnoDB;

CREATE TABLE `likes`(
   `likes_id`	BIGINT NOT NULL AUTO_INCREMENT,
	 `sender_id` BIGINT,
	 `wall_post_id` BIGINT,
	 CONSTRAINT like_sender_id_fk FOREIGN KEY(sender_id) REFERENCES users(user_id) ON DELETE CASCADE,
	 CONSTRAINT like_wp_id_fk FOREIGN KEY(wall_post_id) REFERENCES wall_posts(wall_post_id) ON DELETE CASCADE,
   PRIMARY KEY(likes_id)
)ENGINE=InnoDB;

CREATE TABLE wall_messages(
	`wall_message_id` BIGINT  NOT NULL AUTO_INCREMENT,
	`message` VARCHAR(350) NOT NULL,
	`sent` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`sender_id` BIGINT,
	`wall_post_id` BIGINT,
	`imagePath` VARCHAR(250),
	CONSTRAINT wm_sender_id_fk FOREIGN KEY(sender_id) REFERENCES users(user_id) ON DELETE CASCADE,
	CONSTRAINT wall_post_id_fk FOREIGN KEY(wall_post_id) REFERENCES wall_posts(wall_post_id) ON DELETE CASCADE,
	PRIMARY KEY(wall_message_id)
)ENGINE=InnoDB;



CREATE TABLE friend_requests(
	`friend_request_id` BIGINT  NOT NULL AUTO_INCREMENT,
    `accepted` TINYINT NOT NULL DEFAULT 0,
	`denied` TINYINT NOT NULL DEFAULT 0,
    `sender_id` BIGINT,
	`receiver_id` BIGINT,
	CONSTRAINT fr_sender_id_fk FOREIGN KEY(sender_id) REFERENCES users(user_id) ON DELETE CASCADE, 
	CONSTRAINT fr_receiver_id_fk FOREIGN KEY(receiver_id) REFERENCES users(user_id) ON DELETE CASCADE,
	PRIMARY KEY(friend_request_id)
)ENGINE=InnoDB;

CREATE TABLE `chats`(
	`chat_id` BIGINT  NOT NULL AUTO_INCREMENT,
    `lastUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(`chat_id`)
)ENGINE=InnoDB;

CREATE TABLE `chat_messages`(
	`message_id` BIGINT  NOT NULL AUTO_INCREMENT,
    `message` VARCHAR(180) NOT NULL,
	`sent` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`chat_id` BIGINT,
	`sender_id` BIGINT,
    `read` TINYINT DEFAULT 0,
	CONSTRAINT m_sender_id_fk FOREIGN KEY(sender_id) REFERENCES users(user_id) ON DELETE CASCADE,
	CONSTRAINT conversation_id_fk FOREIGN KEY(chat_id) REFERENCES chats(chat_id) ON DELETE CASCADE,
	PRIMARY KEY(message_id)
)ENGINE=InnoDB;
	
CREATE TABLE `chats_join_table`(
	`chat_id` BIGINT,
	`user_id` BIGINT,
	PRIMARY KEY(`user_id`,`chat_id`),
	CONSTRAINT user_id_fk FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE,
	CONSTRAINT chat_id_fk FOREIGN KEY(chat_id) REFERENCES chats(chat_id) ON DELETE CASCADE
)ENGINE=InnoDB;

CREATE TABLE `friendships`(
	`user1_id` BIGINT,
	`user2_id` BIGINT,
	`createdOn` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(`user1_id`,`user2_id`),
	CONSTRAINT user1_id_fk FOREIGN KEY(user1_id) REFERENCES users(user_id) ON DELETE CASCADE, 
	CONSTRAINT user2_id_fk FOREIGN KEY(user2_id) REFERENCES users(user_id) ON DELETE CASCADE
)ENGINE=InnoDB;

CREATE TABLE `tasks` (
	task_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  	name VARCHAR(250) NOT NULL,
  	description VARCHAR(500) NOT NULL,
  	message VARCHAR(500),
	assigner VARCHAR(50) NOT NULL,
    assignee VARCHAR(50) NOT NULL,
	created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	completed TIMESTAMP NULL DEFAULT NULL,
	complete TINYINT NOT NULL DEFAULT 0,
	CONSTRAINT assigner_fk FOREIGN KEY(assigner) REFERENCES users(username) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT assignee_fk FOREIGN KEY(assignee) REFERENCES users(username) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY(task_id)
);

CREATE TABLE `acl_sid` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `principal` tinyint(1) NOT NULL,
  `sid` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_uk_1` (`sid`,`principal`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

CREATE TABLE `acl_class` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `class` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_uk_2` (`class`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `authorities` (
  `username` varchar(50) NOT NULL,
  `authority` varchar(50) NOT NULL,
  CONSTRAINT `username_fk_auth` FOREIGN KEY(`username`) REFERENCES `users`(`username`) ON DELETE CASCADE,
  PRIMARY KEY(`username`,`authority`)
)	ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Stored Procedures

DROP PROCEDURE IF EXISTS addMessage;
DROP PROCEDURE IF EXISTS sendMessage;
DROP PROCEDURE IF EXISTS addWallPost;
DROP PROCEDURE IF EXISTS addWallMessage;
DROP PROCEDURE IF EXISTS unread;
DROP PROCEDURE IF EXISTS countUnread;
DROP PROCEDURE IF EXISTS sendFriendRequest;
DROP PROCEDURE IF EXISTS addLike;

DELIMITER //

CREATE PROCEDURE `addMessage`(IN username VARCHAR(50),IN chatId BIGINT, IN message VARCHAR(250))
BEGIN
	INSERT INTO chat_messages(sender_id,chat_id,message) VALUES((SELECT u.user_id FROM users u WHERE u.username= username),chatId,message);
  UPDATE chats SET lastUpdate = NOW() WHERE chat_id = chatId;
  SELECT * FROM chat_messages WHERE message_id = LAST_INSERT_ID();
END//

CREATE PROCEDURE `sendMessage` (IN msg VARCHAR(250),IN sender VARCHAR(50),IN receiver VARCHAR(50))
BEGIN
DECLARE chatId BIGINT;
SELECT chat_id FROM chats_join_table WHERE user_id IN (SELECT user_id FROM users where username = sender or username = receiver) GROUP BY chat_id HAVING count(*) > 1 INTO chatId;

IF chatId IS NULL THEN
    INSERT INTO chats(lastUpdate) VALUES(NOW());
    SELECT LAST_INSERT_ID() INTO chatId;
    INSERT INTO chats_join_table(chat_id,user_id) VALUES(chatId,(SELECT user_id FROM users WHERE username =sender));
    INSERT INTO chats_join_table(chat_id,user_id) VALUES(chatId,(SELECT user_id FROM users WHERE username =receiver));	
END IF;
CALL addMessage(sender,chatId,msg); 
END//

CREATE PROCEDURE `addWallPost` (IN sender VARCHAR(50), IN receiver VARCHAR(50), IN message VARCHAR(250), IN imagePath VARCHAR(250))
BEGIN
	INSERT INTO wall_posts(owner_id) VALUES ((SELECT u.user_id from users u WHERE u.username = receiver));
  INSERT INTO wall_messages(wall_post_id,sender_id,message,imagePath) VALUES(LAST_INSERT_ID(),(SELECT u.user_id from users u WHERE u.username = sender),message,imagePath);
END//

CREATE PROCEDURE `addWallMessage` (IN sender VARCHAR(50), IN wallPostId BIGINT, IN message VARCHAR(250))
BEGIN
  INSERT INTO wall_messages(wall_post_id,sender_id,message) VALUES(wallPostId,(SELECT u.user_id from users u WHERE u.username = sender),message);
  SELECT * FROM wall_messages WHERE wall_message_id = LAST_INSERT_ID();
END//

CREATE PROCEDURE `addLike` (IN sender VARCHAR(50), IN postId BIGINT)
BEGIN 
 	INSERT INTO likes(sender_id,wall_post_id) VALUES ((SELECT u.user_id from users u WHERE u.username = sender),postId);
END//

CREATE PROCEDURE `unread` (IN username VARCHAR(50))
BEGIN 
DECLARE user_id BIGINT;
    SELECT u.user_id FROM users u WHERE u.username = username INTO user_id;
    SELECT *
      FROM chat_messages cm 
           INNER JOIN users u 
           ON u.user_id = cm.sender_id 
     WHERE cm.chat_id IN (SELECT cj.chat_id FROM chats_join_table cj WHERE cj.user_id=user_id) 
       AND cm.sender_id !=user_id 
       AND cm.read=0
  ORDER BY cm.sent DESC;
    UPDATE chat_messages cm SET cm.read = 1 WHERE cm.chat_id IN (SELECT chat_id cj from chats_join_table cj WHERE cj.user_id=user_id) AND cm.sender_id !=user_id AND cm.read=0;
END//

CREATE PROCEDURE `countUnread` (IN username VARCHAR(50))
BEGIN 
DECLARE user_id BIGINT;
    SELECT u.user_id FROM users u WHERE u.username = username INTO user_id;
    SELECT count(*) as unread
      FROM chat_messages cm 
           INNER JOIN users u 
           ON u.user_id = cm.sender_id 
     WHERE cm.chat_id IN (SELECT cj.chat_id FROM chats_join_table cj WHERE cj.user_id=user_id) 
       AND cm.sender_id != user_id 
       AND cm.read=0;
END//

DROP PROCEDURE IF EXISTS sendFriendRequest;//
CREATE PROCEDURE `sendFriendRequest` (IN sender VARCHAR(50),IN receiver VARCHAR(50))
BEGIN
DECLARE sender_id BIGINT;
DECLARE receiver_id BIGINT;
    SELECT u.user_id FROM users u WHERE u.username = sender INTO sender_id;
    SELECT u.user_id FROM users u WHERE u.username = receiver INTO receiver_id;
    IF ((SELECT 1 FROM friend_requests fr WHERE fr.sender_id = sender_id AND fr.receiver_id = receiver_id) IS NULL) THEN
        INSERT INTO friend_requests(sender_id,receiver_id) VALUES(sender_id,receiver_id);
    END IF;
END//

DELIMITER ;

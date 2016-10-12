-- Stored Procedures

DROP PROCEDURE IF EXISTS addMessage//
DROP PROCEDURE IF EXISTS sendMessage//
DROP PROCEDURE IF EXISTS addWallPost//
DROP PROCEDURE IF EXISTS addWallMessage//
DROP PROCEDURE IF EXISTS unread//
DROP PROCEDURE IF EXISTS countUnread//
DROP PROCEDURE IF EXISTS sendFriendRequest//
DROP PROCEDURE IF EXISTS addLike//


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

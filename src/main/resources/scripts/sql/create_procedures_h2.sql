

CREATE ALIAS IF NOT EXISTS addMessage AS $$ 
void addMessage(Connection conn,String username, long chatId,String message) throws SQLException {

	conn.setAutoCommit(false);
	PreparedStatement addMessageStmt = conn.prepareStatement("INSERT INTO chat_messages(sender_id,chat_id,message) VALUES((SELECT u.user_id FROM users u WHERE u.username= ?),?,?)");
	addMessageStmt.setString(1,username);
	addMessageStmt.setLong(2,chatId);
	addMessageStmt.setString(3,message);
	addMessageStmt.executeUpdate();
	
	PreparedStatement updateChatsMessage = conn.prepareStatement("UPDATE chats SET lastUpdate = NOW() WHERE chat_id = ?");
	updateChatsMessage.setLong(1,chatId);
	updateChatsMessage.executeUpdate();

	conn.commit();
}
$$;

CREATE ALIAS IF NOT EXISTS sendMessage AS $$
void sendMessage(Connection conn,String message, String sender, String receiver) throws SQLException {
	conn.setAutoCommit(false);
	Long chatId = null;
	PreparedStatement getChatStmt = conn.prepareStatement("SELECT chat_id as chatId FROM chats_join_table WHERE user_id IN (SELECT user_id FROM users WHERE username = ? OR username = ?) GROUP BY chat_id HAVING count(*) > 1");
	getChatStmt.setString(1,sender);
	getChatStmt.setString(2,receiver);
	ResultSet rs = getChatStmt.executeQuery();
	
	if(rs.next()== false){
		conn.prepareStatement("INSERT INTO chats(lastUpdate) VALUES(NOW())")
		    .executeUpdate();
		rs = conn.prepareStatement("SELECT LAST_INSERT_ID() as newCId")
		         .executeQuery();
		rs.next();
		chatId = rs.getLong("newCId");
		System.out.println("ChatId: " + chatId);
		PreparedStatement addUserToChatStmt = conn.prepareStatement("INSERT INTO chats_join_table(chat_id,user_id) VALUES(?,(SELECT user_id FROM users WHERE username =?))");
		addUserToChatStmt.setLong(1,chatId);
		addUserToChatStmt.setString(2,sender);
		addUserToChatStmt.executeUpdate();
		addUserToChatStmt.setString(2,receiver);
		addUserToChatStmt.executeUpdate();
	}else{
		chatId = rs.getLong("chatId");
	}
	
	PreparedStatement addMessageStmt = conn.prepareStatement("INSERT INTO chat_messages(sender_id,chat_id,message) VALUES((SELECT u.user_id FROM users u WHERE u.username= ?),?,?)");
	addMessageStmt.setString(1,sender);
	addMessageStmt.setLong(2,chatId);
	addMessageStmt.setString(3,message);
	addMessageStmt.executeUpdate();
	
	PreparedStatement updateChatsMessage = conn.prepareStatement("UPDATE chats SET lastUpdate = NOW() WHERE chat_id = ?");
	updateChatsMessage.setLong(1,chatId);
	updateChatsMessage.executeUpdate();

	conn.commit();
}
$$;

CREATE ALIAS IF NOT EXISTS addWallPost AS $$
void addWallPost(Connection conn, String sender,String receiver,String message,String imagePath) throws SQLException {
	conn.setAutoCommit(false);
	PreparedStatement addWp = conn.prepareStatement("INSERT INTO wall_posts(owner_id) VALUES ((SELECT u.user_id from users u WHERE u.username = ?))");
	addWp.setString(1,receiver);
	addWp.executeUpdate();
	
	PreparedStatement addFirstMsg = conn.prepareStatement("INSERT INTO wall_messages(wall_post_id,sender_id,message,imagePath) VALUES(LAST_INSERT_ID(),(SELECT u.user_id from users u WHERE u.username = ?),?,?)");
	addFirstMsg.setString(1,sender);
	addFirstMsg.setString(2,message);
	addFirstMsg.setString(3,imagePath);
	addFirstMsg.executeUpdate();
	conn.commit();
}
$$;

CREATE ALIAS IF NOT EXISTS addWallMessage AS $$
ResultSet addWallMessage(Connection conn,String sender,long wallPostId,String message) throws SQLException {
	conn.setAutoCommit(false);
	PreparedStatement insertStmt = conn.prepareStatement("INSERT INTO wall_messages(wall_post_id,sender_id,message) VALUES(?,(SELECT u.user_id from users u WHERE u.username = ?),?)");
	insertStmt.setLong(1,wallPostId);
	insertStmt.setString(2,sender);
	insertStmt.setString(3,message);
	insertStmt.executeUpdate();
	
	PreparedStatement selectStmt = conn.prepareStatement("SELECT * FROM wall_messages WHERE wall_message_id = LAST_INSERT_ID()");
	ResultSet rs = selectStmt.executeQuery();
	conn.commit();
	return rs;
}
$$;

CREATE ALIAS IF NOT EXISTS addLike AS $$
void addLike(Connection conn, String sender,long postId) throws SQLException {
	conn.setAutoCommit(false);
	PreparedStatement  addStmt = conn.prepareStatement("INSERT INTO likes(sender_id,wall_post_id) VALUES ((SELECT u.user_id from users u WHERE u.username = ?),?)");
	addStmt.setString(1,sender);
	addStmt.setLong(2,postId);
	addStmt.executeUpdate();
	conn.commit();
}
$$;

CREATE ALIAS IF NOT EXISTS unread AS $$
ResultSet unread(Connection conn, String username) throws SQLException {
	conn.setAutoCommit(false);
	PreparedStatement userStm = conn.prepareStatement("SELECT u.user_id as userId FROM users u WHERE u.username = ?");
	userStm.setString(1,username);
	ResultSet rs = userStm.executeQuery();
	rs.next();
	Long userId = rs.getLong("userId");	
	
	PreparedStatement countStmt = conn.prepareStatement("SELECT * FROM chat_messages cm INNER JOIN users u ON u.user_id = cm.sender_id WHERE cm.chat_id IN (SELECT cj.chat_id FROM chats_join_table cj WHERE cj.user_id=?) AND cm.sender_id != ? AND cm.read=0");
	countStmt.setLong(1,userId);
	countStmt.setLong(2,userId);
	rs = countStmt.executeQuery();
	
	PreparedStatement updateStmt =conn.prepareStatement("UPDATE chat_messages cm SET cm.read = 1 WHERE cm.chat_id IN (SELECT chat_id from chats_join_table WHERE user_id=?) AND cm.sender_id !=? AND cm.read=0");
	updateStmt.setLong(1,userId);
	updateStmt.setLong(2,userId);
	updateStmt.executeUpdate();
	conn.commit();
	return rs;
}
$$;

CREATE ALIAS IF NOT EXISTS countunread AS $$
ResultSet countUnread(Connection conn, String username) throws SQLException {
	conn.setAutoCommit(false);
	PreparedStatement userStm = conn.prepareStatement("SELECT u.user_id as userId FROM users u WHERE u.username = ?");
	userStm.setString(1,username);
	ResultSet rs = userStm.executeQuery();
	rs.next();
	Long userId = rs.getLong("userId");
	PreparedStatement countStmt = conn.prepareStatement("SELECT count(*) as unread FROM chat_messages cm INNER JOIN users u ON u.user_id = cm.sender_id WHERE cm.chat_id IN (SELECT cj.chat_id FROM chats_join_table cj WHERE cj.user_id=?) AND cm.sender_id != ? AND cm.read=0;");
	countStmt.setLong(1,userId);
	countStmt.setLong(2,userId);
	rs = countStmt.executeQuery();
	conn.commit();
	return rs;
}
$$;

CREATE ALIAS IF NOT EXISTS sendfriendrequest AS $$
void sendFriendRequest(Connection conn, String sender,String receiver) throws SQLException {
	conn.setAutoCommit(false);
	ResultSet rs = null;
	PreparedStatement userStmt = conn.prepareStatement("SELECT u.user_id as userId FROM users u WHERE u.username = ?");
	userStmt.setString(1,sender);
	rs = userStmt.executeQuery();
	rs.next();
	long senderId = rs.getLong("userId");
	userStmt.setString(1,receiver);
	rs = userStmt.executeQuery();
	rs.next();
	long receiverId = rs.getLong("userId");
	
	PreparedStatement existsStmt = conn.prepareStatement("SELECT 1 FROM friend_requests fr WHERE fr.sender_id = ? AND fr.receiver_id = ?");
	existsStmt.setLong(1,senderId);
	existsStmt.setLong(2,receiverId);
	rs = existsStmt.executeQuery();
	if(!rs.next()){
		PreparedStatement addFrStmt = conn.prepareStatement("INSERT INTO friend_requests(sender_id,receiver_id) VALUES(?,?)");
		addFrStmt.setLong(1,senderId);
		addFrStmt.setLong(2,receiverId);
		addFrStmt.executeUpdate();
	}
	conn.commit();
}
$$;

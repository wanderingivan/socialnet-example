package com.socialnet.dao;

import java.util.List;

import com.socialnet.model.Chat;
import com.socialnet.model.Message;
import com.socialnet.model.Task;
import com.socialnet.model.WallPost;

/**
 *	DAO interface providing 
 *  methods for manipulating messages. 
 */
public interface MessageDao {

	/**
	 * Inserts a wall post in the database.
	 * @param sender The author of the post
	 * @param receiver The user on whose wall the post will go. Effectively the owner of the post
	 * @param message The message of the post
	 * @param imagePath Optional image
	 */
	void createWallPost(String sender, String receiver,String message, String imagePath);
	
	/**
	 * Inserts a message to in the database.
	 * On success returns the created message
	 * @param sender the author of the message
	 * @param wallPostId the id of the post to add this message to
	 * @param message 
	 * @return
	 */
	String[] postWallMessage(String sender, long wallPostId, String message);

	/**
	 * Lists wall posts for a user with matching username
	 * @param username
	 * @return
	 */
	List<WallPost> getWallPostsForUser(String username);

	/**
	 * Loads a wall post by its id
	 * @param id
	 * @return
	 */
	WallPost getWallPost(long id);

	/**
	 * Adds a like to a wall post
	 * @param username
	 * @param postId
	 */
	void addLike(String username, long postId);

	/**
	 * Returns messages for a post beggining from index
	 * @param postId the post to load the messages from 
	 * @param index the index to beggin from
	 * @return WallMessages converted to a string []
	 */
	List<String[]> getWallMessages(long postId, int index);

	/**
	 * 
	 * Returns a wall post for a user from index.
	 * Must ensure that wall posts are ordered
	 * @param user_id
	 * @param index
	 * @return the wall post converted as a string []
	 */
	List<String[]> getWallPost(long user_id, int index);

	/**
	 * 
	 * Returns a wall post for a user from index.
	 * Must ensure that wall posts are ordered
	 * @param user_id
	 * @param index
	 * @return
	 */
	WallPost loadWallPost(long userId, int index);
	
	/**
	 * Sends a messages between two users.
	 * If a chat with the users doesn't exits creates a new chat
	 * @param message
	 * @param sender
	 * @param receiver
	 */
	void sendMessage(String message, String sender, String receiver);

	/**
	 * Sends  message to a chat
	 * @param sender the username of the sender
	 * @param chatId the chat to add the message to 
	 * @param message the message content to add
	 */
	void addMessage(String sender, long chatId, String message);
	
	List<Chat> loadUserChats(String username);

	/**
	 * Retrieve a chat by id 
	 * @param chatId
	 * @return
	 */
	Chat loadChat(long chatId);
	
	/**
	 * Returns the unread  messages count for a user from the database
	 * @param username
	 * 
	 * @return count
	 */
	int countUnread(String username);

	/**
	 * Returns a list  of unread messages for a user from the database.
	 * The messages will be marked as read after retrieval.
	 * @param user_id the id of the user 
	 * @return a collection of Message ordered by date of post.
	 * @see Message
	 */
	List<Message> getUnread(String username);
	
	/**
	 * List tasks from the database for a particular user.
	 * @param username the user whose assigned taskes will be fetched
	 * 
	 * @param fetchAll optional parameter sets whether all task 
	 *        would be retrieved or just a limited set
	 * @return a collection of Task ordered by task creation date
	 * @see Task
	 */
	List<Task> getTasks(String username, boolean fetchAll);

	/**
	 * List tasks from the database.
	 * @param fetchAll optional parameter sets whether all task 
	 *        would be retrieved or just a limited set
	 *        
	 * @return a collection of Task ordered by task creation date
	 * @see Task
	 */
	List<Task> getTasks(boolean fetchAll);

	/**
	 * Removes a task from the db
	 * @param taskId id of the task in db
	 */
	void removeTask(long taskId);

	/**
	 *  Sets a task as complete 
	 * @param taskId id of the task in db
	 * @param comment optional comment on task completion 
	 */
	void completeTask(long taskId, String comment);

	/**
	 * Inserts a task for the specified user in the database.<br/>
	 * The task will appear in a users pending tasks
	 * and is visible to everyone with admin permission 
	 * @param task the 
	 * @param assigner username that creates the task
	 * @param assignee 
	 */
	void addTask(Task task, String assigner, String assignee);

	/**
	 * Returns the unfinished tasks count for the admin user from the database
	 * @param username
	 * 
	 * @return count
	 */
	int countPending(String username);

	void deleteWallPost(long postId);
}

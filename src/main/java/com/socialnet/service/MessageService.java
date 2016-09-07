package com.socialnet.service;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;

import com.socialnet.model.Chat;
import com.socialnet.model.Message;
import com.socialnet.model.Task;
import com.socialnet.model.WallPost;

/**
 * Service layer interface
 * Provides methods for interacting
 * with messages,likes and wall posts.
 *
 */
public interface MessageService {

	/**
	 * Creates a wall post on a user's wall.
	 * @param sender The author of the post
	 * @param receiver The user on whose wall the post will go. Effectively the owner of the post
	 * @param message The message of the post
	 * @param imagePath Optional image
	 */
	@PreAuthorize("isAuthenticated()")
	void createWallPost(String sender, String receiver,String message, String imagePath);
	
	/**
	 * Adds a message to an existing wall post.
	 * On success returns the created message
	 * @param sender the author of the message
	 * @param wallPostId the id of the post to add this message to
	 * @param message 
	 * @return
	 */
	@PreAuthorize("isAuthenticated()")
	String[] postWallMessage(String sender, long wallPostId, String message);

	/**
	 * Returns wall posts for a user with matching username
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
	@PreAuthorize("isAuthenticated()")
	void addLike(String username, long postId);

	/**
	 * Returns messages for a post beggining from index
	 * @param postId the post to load the messages from 
	 * @param index the index to beggin from
	 * @return WallMessages converted to a string []
	 */
	List<String[]> loadComments(long postId, int index);

	/**
	 * 
	 * Returns a wall post for a user from index.
	 * Must ensure that wall posts are ordered
	 * @param user_id
	 * @param index
	 * @return the wall post converted as a string []
	 */
	List<String[]> loadPost(long user_id, int index);

	/**
	 * 
	 * Returns a wall post for a user starting at index.
	 * @param user_id
	 * @param index
	 * @return
	 */
	WallPost loadWallPost(long userId, int index);
	
	/**
	 * Sends a messages between two users.
	 * @param message
	 * @param sender
	 * @param receiver
	 */
	@PreAuthorize("isAuthenticated()")
	void sendMessage(String message, String sender, String receiver);

	/**
	 * Sends  message to a chat
	 * @param sender the username of the sender
	 * @param chatId the chat to add the message to 
	 * @param message the message content to add
	 */
	@PreAuthorize("isAuthenticated()")
	void addMessage(String sender, String message, long chatId); 
	
	List<Chat> getUserChats(String username);

	/**
	 * Retrieve a chat by id 
	 * @param chatId
	 * @return
	 */
	Chat getChat(long chatId);
	
	/**
	 * Returns the unread  messages count for a user from the database
	 * @param username
	 * 
	 * @return count
	 */
	@PreAuthorize("isAuthenticated()")
	int countUnread(String username);

	/**
	 * Returns a list  of unread messages for a user from the database.
	 * The messages will be marked as read after retrieval.
	 * @param user_id the id of the user 
	 * @return a collection of Message ordered by date of post.
	 * @see Message
	 */
	@PreAuthorize("isAuthenticated()")
	List<Message> getUnread(String username);
	
	/**
	 * Loads recent unfinished tasks for a particular user.
	 * @param username the user whose assigned tasks will be fetched
	 * @return a collection of Task ordered by task creation date
	 * @see Task
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	List<Task> retrieveUserPendingTasks(String username);
	
	/**
	 * Loads all tasks for a particular user.
	 * @param username the user whose assigned tasks will be fetched
	 * @return a collection of Task ordered by task creation date
	 * @see Task
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	List<Task> retrieveUserTasks(String username);

	/**
	 * List most recent tasks. 
	 * @return a collection of Task ordered by task creation date
	 * @see Task
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	List<Task> latestTasks();
	
	/**
	 * Loads all tasks. 
	 * @param username the user whose assigned tasks will be fetched
	 * @return a collection of Task ordered by task creation date
	 * @see Task
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	List<Task> retrieveAllTasks();

	/**
	 * Removes a task, 
	 * @param taskId id of the task in db
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	void removeTask(long taskId);

	/**
	 *  Sets a task as complete 
	 * @param taskId id of the task in db
	 * @param comment optional comment on task completion 
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	void completeTask(long taskId, String comment);

	/**
	 * Adds a task for the specified user<br/>
	 * The task will appear in a users pending tasks
	 * and is visible to everyone with admin permission 
	 * @param task the 
	 * @param assigner username that creates the task
	 * @param assignee 
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	void addTask(Task task, String assigner, String assignee);

	/**
	 * Returns the unfinished tasks count for the admin user. 
	 * @param username
	 * 
	 * @return count
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	int countPending(String username);

	void deleteWallPost(long postId);
}

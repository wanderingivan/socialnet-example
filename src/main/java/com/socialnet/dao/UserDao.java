package com.socialnet.dao;

import java.util.List;

import com.socialnet.model.Details;
import com.socialnet.model.FriendRequest;
import com.socialnet.model.Image;
import com.socialnet.model.User;

public interface UserDao {
	
	 /**
	  * Persists a user into the db
	  * Inserts the user in the group with the lowest authority role.
	  * @param user the user to persist
	  * @return the persisted user's id
	  */
	long createUser(User user);

	 /**
	  * Retrieves an user form the database
	  * @param username
	  * @return
	  */
	User retrieveUserByUsername(String username);

	/**
	 * Edits a user
	 * @param user
	 */
	void update(User user);

	/**
	 * Removes users with matching username from the database
	 * @param username
	 * @return
	 */
	long deleteByUsername(String username);
	
	 /**
	  * Finds users matching 
	  * @param username
	  * @return a map containing matching users usernames as key
	  * and imagePaths as values
	  */
	List<User> findUsers(String username);

	
	/**
	 * Adds the sender and receiver of a friend request
	 * as friends
	 * @param friendRequestId the id of the friend request
	 */
	void createFriendship(long friendRequestId);
	
	/**
	 * Sets a friend request as denied
	 * @param friendRequestId
	 */
	void denyFriendRequest(long friendRequestId);
	
	/**
	 * Removes a friendship between two users
	 * @param user1
	 * @param user2
	 */
	void removeFriendship(String user1, String user2);
	
	/**
	 * Creates a friend request from a user
	 * @param sender
	 * @param receiver 
	 */
	void sendFriendRequest(String sender, String receiver);

	/**
	 * Adds details for user
	 * @param details
	 * @param userId
	 */
	void addDetails(Details details, long userId);

	/**
	 * Adds an image to a users'gallery
	 * @param image
	 * @param username
	 */
	void addToGallery(Image image, String username);

	/**
	 * Changes a users cover picture to image already in database
	 * @param username the user to apply the change to
	 * @param imageId id of the image
	 */
	void changeCoverImage(String username, long imageId);

	/**
	 * Changes a users profile picture to image already in database
	 * @param username the user to apply the change to
	 * @param imageId id of the image
	 */
	void changeProfilePic(String username, long imageId);

	/**
	 * Checks if a username is in the database
	 * @param username
	 * @return
	 */
	boolean checkUsernameAvailability(String username);

	/**
	 * Removes an image from the database
	 * @param imageId
	 * @return
	 */
	String removeImage(long imageId);

	/**
	 * Load all pending user friend requests
	 * @param username
	 * @return
	 */
	List<FriendRequest> getFriendRequests(String username);

	/**
	 * Counts the number of pending FriendRequests a user has 
	 * @param username
	 * @return
	 */
	long countFriendRequests(String username);
	
	 /**
	  * Loads a list of users ordered by creation date
	  * @return
	  */
	List<User> newUsers();

	void changeAuthority(String username, String authority);

	 /**
	  * Locks a user
	  * @param username
	  */
	void disableUser(String username);
	
	 /**
	  * Sets a user as unlocked
	  * @param username
	  */
	void enableUser(String username);

	/**
	 * Lists all Images owned by user.
	 * Used when deleting a user
	 * @param username
	 * @return
	 */
	List<Image> getUserImages(String username);





}

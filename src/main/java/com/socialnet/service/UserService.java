package com.socialnet.service;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;

import com.socialnet.model.Details;
import com.socialnet.model.FriendRequest;
import com.socialnet.model.Image;
import com.socialnet.model.User;

/**
 * Service layer interface
 * Provides methods for CRUD actions on Users 
 * and administrative methods for locking and
 * changing a users authority role 
 * performs checks  on user method permissions
 */
public interface UserService {


	 /**
	  * Persists a user into the db
	  * Inserts the user in the group with the lowest authority role.
	  * Must create an acl
	  * @param user the user to persist
	  * @return the persisted user's id
	  */
	@PreAuthorize("isAnonymous()")
	void createUser(User user);

	 /**
	  * Retrieves an user from the database
	  * @param username
	  * @return
	  */
	User loadUser(String username);

	/**
	 * Edits a user
	 * @param user
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN') or hasPermission(#user, 'WRITE')")
	void updateUser(User user);

	/**
	 * Removes users with matching username from the database
	 * @param username
	 * @return
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	void delete(String username);
	
	 /**
	  * Finds users matching 
	  * @param username
	  * @return a map containing matching users usernames as key
	  * and imagePaths as values
	  */
	List<User> findUsers(String username);

	
	/**
	 * Creates a friendship between two users
	 * @param user1
	 * @param user2
	 */
	@PreAuthorize("isAuthenticated()")
	void acceptFriendRequest(long frindRequestId);

	/**
	 * Sets a friend request as denied
	 * @param friendRequestId
	 */
	@PreAuthorize("isAuthenticated()")
	void denyFriendRequest(long friendRequestId);
	
	/**
	 * Removes a friendship between two users
	 * @param user1
	 * @param user2
	 */
	@PreAuthorize("isAuthenticated()")
	void removeFriendship(String user1, String user2);
	
	/**
	 * Creates a friend request from a user
	 * @param sender
	 * @param receiver 
	 */
	@PreAuthorize("isAuthenticated()")
	void sendFriendRequest(String sender, String receiver);

	/**
	 * Adds details for user
	 * @param details
	 * @param userId
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN') or hasPermission(#user, 'WRITE')")
	void addDetails(Details details,User user);

	/**
	 * Adds an image to a users'gallery
	 * @param fileName the name of the file to use 
	 * @param username
	 */
	public void addToUserGallery(String fileName, String description,
			String username); 

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
	@PreAuthorize("isAuthenticated()")
	List<FriendRequest> getFriendRequests(String username);

	/**
	 * Counts the number of pending FriendRequests a user has 
	 * @param username
	 * @return
	 */
	@PreAuthorize("isAuthenticated()")
	long countFriendRequests(String username);
	
	 /**
	  * Loads a list of users ordered by creation date
	  * @return
	  */
	List<User> newUsers();

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	void changeAuthority(String username, String authority);

	 /**
	  * Locks a user
	  * @param username
	  */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	void disableUser(String username);
	
	 /**
	  * Sets a user as unlocked
	  * @param username
	  */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	void enableUser(String username);

	/**
	 * Returns all images owned by a user
	 * @param username
	 * @return
	 */
	List<Image> getUserImages(String username);



}

package com.socialnet.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.security.acls.domain.BasePermission;
import org.springframework.security.acls.domain.ObjectIdentityImpl;
import org.springframework.security.acls.domain.PrincipalSid;
import org.springframework.security.acls.model.MutableAcl;
import org.springframework.security.acls.model.MutableAclService;
import org.springframework.security.acls.model.Sid;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.socialnet.dao.UserDao;
import com.socialnet.model.Details;
import com.socialnet.model.FriendRequest;
import com.socialnet.model.Image;
import com.socialnet.model.User;
import com.socialnet.service.UserService;

/**
 * Implementation of UserService that delegates
 * transaction management to Spring <br/>
 * and creates ACLs for new users.
 * @see UserService
 * 
 */
public class UserServiceImpl implements UserService {

	private String defaultProfileImagePath,
	               defaultCoverImagePath;
	
	private UserDao dao;
	private MutableAclService aclService;
	private PasswordEncoder encoder;
	

	public UserServiceImpl(UserDao userDao, MutableAclService aclService,String[] defaultImagePaths,PasswordEncoder encoder) {
		super();
		this.dao = userDao;
		this.aclService = aclService;
		this.defaultProfileImagePath = defaultImagePaths[0];
		this.defaultCoverImagePath = defaultImagePaths[1];
		this.encoder = encoder;
	}

	@Override
	@Transactional
	public void createUser(User user) {
		user.setProfilePic(defaultProfileImagePath);
		user.setCoverImage(defaultCoverImagePath);
		user.setEnabled(true);
		user.setPassword(encoder.encode(user.getPassword()));
		long id = dao.createUser(user);
		createAcl(new PrincipalSid(user.getUsername()),id);
	}
	
	@Override
	@Transactional
	public User loadUser(String username) {
		return dao.retrieveUserByUsername(username);
	}
	
	@Override
	@Transactional
	public void updateUser(User user) {
		dao.update(user);
	}

	@Override
	@Transactional
	public void delete(String username) {
		long id = dao.deleteByUsername(username);
		deleteAcl(id);
	}
	
	@Override
	@Transactional
	public void addDetails(Details details,User user){
		dao.addDetails(details,user.getId());
	}
	
	@Override
	@Transactional
	public List<User> findUsers(String username) {
		return dao.findUsers(username);
	}
	
	@Override
	@Transactional
	public void sendFriendRequest(String username1, String username2) {
		dao.sendFriendRequest(username1, username2);
	}

	@Override
	@Transactional
	public void acceptFriendRequest(long frindRequestId) {
		dao.createFriendship(frindRequestId);
	}
	
	@Override
	@Transactional
	public void denyFriendRequest(long friendRequestId) {
		dao.denyFriendRequest(friendRequestId);
	}
	
	@Override
	@Transactional
	public void removeFriendship(String username1, String username2) {
		dao.removeFriendship(username1, username2);
		
	}
	
	@Override
	@Transactional
	public void addToUserGallery(String path, String description,
			String username) {
		dao.addToGallery(new Image(path,description),username);
	}
	
	@Override
	@Transactional
	public void changeCoverImage(String username, long imageId) {
		dao.changeCoverImage(username,imageId);
	}

	@Override
	@Transactional
	public void changeProfilePic(String username, long imageId) {
		dao.changeProfilePic(username,imageId);
		
	}
	
	@Override
	@Transactional
	public boolean checkUsernameAvailability(String username) {
		return dao.checkUsernameAvailability(username);
	}

	@Override
	@Transactional
	public String removeImage(long imageId) {
		return dao.removeImage(imageId);
	}
	
	@Override
	@Transactional
	public List<FriendRequest> getFriendRequests(String username) {
		return dao.getFriendRequests(username);
	}

	@Override
	@Transactional
	public long countFriendRequests(String username) {
		return dao.countFriendRequests(username);
	}

	@Override
	@Transactional
	public List<User> newUsers() {
		return dao.newUsers();
	}
	
	@Override
	@Transactional
	public void enableUser(String username) {
		dao.enableUser(username);
	}

	@Override
	@Transactional
	public void disableUser(String username) {
		dao.disableUser(username);
	}

	@Override
	@Transactional
	public void changeAuthority(String username, String authority) {
		dao.changeAuthority(username,authority);
	}
	
	@Override
	@Transactional
	public List<Image> getUserImages(String username){
		return dao.getUserImages(username);
	}
	
	/* Create acl that allows the user to edit his profile and check their cart 
	 * Profile deletion is handled only by ADMIN */
	private void createAcl(Sid sid,long id){
		MutableAcl acl= aclService.createAcl(new ObjectIdentityImpl(User.class,id));
		acl.setOwner(sid);// The default Mutable Acl Impl will set the owner from the security context holder
		                  // which at this point is anonymous user
		aclService.updateAcl(acl);
		acl.insertAce(acl.getEntries().size(), BasePermission.WRITE, sid, true);
		acl.insertAce(acl.getEntries().size(), BasePermission.READ, sid, true);
		aclService.updateAcl(acl);
	}

	private void deleteAcl(long id){
		aclService.deleteAcl(new ObjectIdentityImpl(User.class,Long.valueOf(id)), true);
	}


}

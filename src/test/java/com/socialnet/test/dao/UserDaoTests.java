package com.socialnet.test.dao;

import java.io.File;
import java.net.MalformedURLException;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.dbunit.dataset.DataSetException;
import org.dbunit.dataset.IDataSet;
import org.dbunit.dataset.xml.FlatXmlDataSetBuilder;
import org.hibernate.exception.ConstraintViolationException;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.socialnet.dao.UserDao;
import com.socialnet.exception.DuplicateEmailException;
import com.socialnet.exception.DuplicateUsernameException;
import com.socialnet.model.Details;
import com.socialnet.model.Image;
import com.socialnet.model.User;


public class UserDaoTests extends AbstractDaoTest {
	
	private static String userToCreate = "create",
						  userToLoad = "username2",
						  userToDelete = "username3",
						  userWithFiveFriends = "username5",
					      userWithTwoFriends ="username6";
								  
	UserDao userDao;


	@Test
	@Transactional
	public void testUserCreate() {
		User toCreate = new User(userToCreate, "email", "password");
		userDao.createUser(toCreate);
		User test = getUser(userToCreate);
		assertEquals(toCreate.getUsername(),test.getUsername());
		assertEquals(toCreate.getEmail(),test.getEmail());
		assertEquals(toCreate.getPassword(),test.getPassword());
	}
	
	@Test(expected=DuplicateUsernameException.class)
	@Transactional
	public void testCreateUserDuplicateUsernameException() {
		userDao.createUser(new User("username2","",""));
		User test = getUser(userToCreate);
		assertEquals(userToCreate,test.getUsername());
	}
	
	@Test(expected=DuplicateEmailException.class)
	@Transactional
	public void testCreateUserDuplicateEmailException() {
		try{
		userDao.createUser(new User(userToCreate,"some@email1",""));
		User test = getUser(userToCreate);
		assertEquals(userToCreate,test.getUsername());
		}catch(ConstraintViolationException ex){
			System.out.println(ex.getConstraintName());
		}
	}
	
	
	@Test
	@Transactional
	public void testUserRetrieve() {
		User test = userDao.retrieveUserByUsername(userToLoad);
		assertNotNull(test);
		assertEquals(userToLoad, test.getUsername());
	}
	
	@Test
	@Transactional
	public void testUpdateUser() {
		User toEdit = new User("username4", "new email", "new password");
		toEdit.setId(4);
		userDao.update(toEdit);
		User test = getUser(toEdit.getUsername());
		assertEquals(toEdit.getUsername(),test.getUsername());
		assertEquals(toEdit.getEmail(),test.getEmail());
		assertEquals(toEdit.getPassword(),test.getPassword());
	}
	
	@Test
	@Transactional
	public void testDeleteUser() {
		assertNotNull(getUser(userToDelete)); // Make sure db was instantiated properly
		userDao.deleteByUsername(userToDelete);
		assertNull("User was not deleted!",userDao.retrieveUserByUsername(userToDelete));
	}
	
	@Test 
	@Transactional
	public void testFriendRetrieval() {
		User has5Friends = getUser(userWithFiveFriends);
		assertEquals("Incorrect number of users retrieved",5,has5Friends.getFriends().size());
		User has2Friends = getUser(userWithTwoFriends);
		assertEquals("Incorrect number of users retrieved",2,has2Friends.getFriends().size());
	}
	
	@Test
	@Transactional
	public void testCountFriendRequests(){
		long friendRequestCount = userDao.countFriendRequests("username6");
		assertEquals(1,friendRequestCount);
	}
	
	@Test
	@Transactional
	public void testDenyFriendRequest(){
		userDao.denyFriendRequest(1);
		long friendRequestCount = userDao.countFriendRequests("username2");
		assertEquals(0,friendRequestCount);
	}
	
	@Test
	@Transactional
	public void testAddFriendship() {
		userDao.createFriendship(1);
		User has5Friends = getUser(userWithFiveFriends);
		User test = getUser(userToLoad);
		assertEquals("Incorrect number of users retrieved",6,has5Friends.getFriends().size());
		assertEquals("Incorrect number of users retrieved",1,test.getFriends().size());
	}
	
	@Test
	@Transactional
	public void testRemoveFriendship() {
		userDao.removeFriendship(userWithFiveFriends,userWithTwoFriends);
		User has5Friends = getUser(userWithFiveFriends);
		
		User has2Friends = getUser(userWithTwoFriends);
		assertEquals("Incorrect number of users retrieved",4,has5Friends.getFriends().size());
		assertEquals("Incorrect number of users retrieved",1,has2Friends.getFriends().size());
	}

	
	@Test
	@Transactional
	public void testGetFriendRequests(){
		assertEquals(1,userDao.getFriendRequests("username6").size());
	}
	@Test
	@Transactional
	public void testAddFriendRequest() {
		userDao.sendFriendRequest(userWithFiveFriends,userToLoad);
		User has5Friends = getUser(userWithFiveFriends);
		assertEquals("Incorrect number of friend requests retrieved",1,has5Friends.getFriendRequests().size());
	}

	@Test
	@Transactional
	public void testAddDetails() {
		Details details = new Details();
		details.setAddress("address");
		details.setOccupation("occupation");
		details.setBirthday(new Date());
		userDao.addDetails(details,2);
		Details test = getUser(userToLoad).getDetails();
		assertNotNull("No details saved",test);
		assertEquals("Incorrect Details saved", details,test);
	}

	@Test
	@Transactional
	public void testFindUsers(){
		List<User> users = userDao.findUsers("username");
		assertNotNull(users);
		assertEquals("Incorrect number of users retrieved",11,users.size());
	}
	
	@Test
	@Transactional
	public void testChangeCoverImage(){
		userDao.changeCoverImage(userToLoad, 1);
		User test = userDao.retrieveUserByUsername(userToLoad);
		assertEquals("Incorrect path saved","/testPath",test.getCoverImage());
	}
	
	@Test
	@Transactional
	public void testChangeProfilePic(){
		userDao.changeProfilePic(userToLoad, 2);
		User test = userDao.retrieveUserByUsername(userToLoad);
		assertEquals("Incorrect path saved","/testPath2",test.getProfilePic());
	}

	@Test
	@Transactional
	public void testCheckUsernameAvailabilityExistingUsername(){
		assertFalse(userDao.checkUsernameAvailability(userToLoad));
	}
	
	@Test
	@Transactional
	public void testCheckUsernameAvailabilityNonexistingUsername(){
		assertTrue(userDao.checkUsernameAvailability(userToCreate));
		
	}
	
	@Test
	@Transactional
	public void testAddImageToUserGallery(){
		userDao.addToGallery(new Image("/testpath3", "test"), userToLoad);
		User test = getUser(userToLoad);
		Image testImage = test.getGallery().get(0);
		assertEquals("Incorrect path saved in db","/testpath3",testImage.getImagePath());
		assertEquals("Incorrect description saved in db","test",testImage.getDescription());
		
	}
	
	@Test
	@Transactional
	public void testRemoveImageFromUserGallery(){
		String path = userDao.removeImage(3);
		assertEquals("Incorrect image removed","/testPath3",path);
		User test = getUser("username5");
		assertEquals(1,test.getGallery().size());
	}
	
	
	@Test
	@Transactional
	public void testLockUser(){
		userDao.disableUser(userToLoad);
		User test = getUser(userToLoad);
		assertEquals("User was not disabled", false, test.isEnabled());
		
	
	}
	
	@Test
	@Transactional
	public void testUnlockUser(){
		userDao.enableUser("username7");
		User test = getUser("username7");
		assertEquals("User was not enabled", true, test.isEnabled());
	}
	
	@Test
	@Transactional
	public void testUserAuthorityChange(){
		userDao.changeAuthority(userToLoad, "ADMIN");
	}

	@Test(expected=IllegalArgumentException.class)
	@Transactional
	public void testAuthorityChangeIllegalArgument(){
		userDao.changeAuthority(userToLoad, "ROLE_");
	}
	
	@Test
	@Transactional
	public void tesGetUserImages(){
		List<Image> images = userDao.getUserImages("username5");
		assertEquals(2,images.size());
	}
	
	private User getUser(String username) {
		return userDao.retrieveUserByUsername(username);
	}
	

	@Autowired
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	@Override
	protected IDataSet getDataSet() throws MalformedURLException, DataSetException {
		return new FlatXmlDataSetBuilder().build(new File(defaultTestResourceFolder.concat("DbTestDataSet.xml")));
	}
	
}

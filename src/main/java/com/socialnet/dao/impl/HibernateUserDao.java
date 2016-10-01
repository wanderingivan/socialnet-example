package com.socialnet.dao.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.socialnet.dao.UserDao;
import com.socialnet.exception.extractor.ConstraintExceptionConverter;
import com.socialnet.model.Details;
import com.socialnet.model.FriendRequest;
import com.socialnet.model.Image;
import com.socialnet.model.User;

@Repository
@SuppressWarnings("unchecked")
public class HibernateUserDao extends AbstractHibernateDao<User> implements UserDao{

	
	private static Logger logger = Logger.getLogger(HibernateUserDao.class);
	
	
	@Autowired
	public HibernateUserDao(SessionFactory sessionFactory) {
		super(sessionFactory,User.class);
	}

	@Override
	public long createUser(User user) {

		logger.debug(String.format("Saving user %s",user.getUsername()));
		Session session = getSession();
		long savedID = 0;
		try{
			savedID = (Long) session.save(user);
		}catch(ConstraintViolationException ce){
			RuntimeException ex = ConstraintExceptionConverter.convertException(ce);
			throw ex;
		}
		SQLQuery query = session.createSQLQuery("INSERT INTO authorities(username,authority) VALUES(:username,'ROLE_USER')");
		query.setString("username", user.getUsername());
		query.executeUpdate();
		return savedID;
	}
	
	@Override
	public User retrieveUserByUsername(String username) {
		logger.debug(String.format("retrieving user with username %s",username));

		return getWithCriteria(new String[]{"username",username});
	}

	@Override
	public void update(User user) {
		try{
			logger.debug(String.format("Updating user %s",user.getUsername()));
		    Query q = createQuery("Update users SET username=:username,email=:email WHERE id=:id")
		                          .setString("username",user.getUsername())
		                          .setString("email",user.getEmail())
		                          .setLong("id", user.getId());
		    q.executeUpdate();
		}catch(HibernateException e){
			logger.error("Exception while updating user\n:"+user,e);
			throw new RuntimeException(e);
		}
	}


	
	@Override
	public long deleteByUsername(String username) {
		return remove(retrieveUserByUsername(username));
	}

	private long remove(User user){
		try{
			Session session = getSession();
			logger.debug(String.format("Deleting user %s with id %d",user.getUsername(),user.getId()));
			session.delete(user);
			return user.getId();
		}catch(HibernateException e){
			logger.error("Exception while deleting user "+ user +"\n" 
																 ,e);
			throw new RuntimeException(e);
		}
	}
	
	@Override
	public List<User> findUsers(String username){
		List<User> users = null;
		StringBuilder restrictionBuilder = new StringBuilder("%");
		restrictionBuilder.append(username);
		restrictionBuilder.append("%");
		try{
			Criteria crit = createCriteria()
			                       .add(Restrictions.ilike("username",restrictionBuilder.toString()));
		    users = crit.list();
	    }catch(HibernateException e){
		    logger.error("Exception while retrieving users with username: "+ username +"\n" + e);
			throw new RuntimeException(e);
	    }
		return users;
	}
	
	@Override
	public void createFriendship(long frId) {
		FriendRequest fr = (FriendRequest) getSession().load(FriendRequest.class, frId);
		fr.setAccepted(true);
		User sender = fr.getSender();
		User receiver = fr.getReceiver();
		sender.addFriend(receiver);
		receiver.addFriend(sender);
		
	}
	
	@Override
	public void denyFriendRequest(long friendRequestId) {
		createQuery("UPDATE friend_requests SET denied = 1 WHERE id = :id")
		            .setLong("id", friendRequestId)
		            .executeUpdate();
	};

	@Override
	public void removeFriendship(String sender, String receiver) {
		
		User user1 = retrieveUserByUsername(sender);
		User user2 = retrieveUserByUsername(receiver);
		user1.removeFriend(user2);
		user2.removeFriend(user1);
		
	}

	@Override
	public void sendFriendRequest(String receiver,String sender) {
		getNamedQuery("sendFriendRequest")
					.setParameter("sender", sender)
					.setParameter("receiver", receiver)
					.executeUpdate();
		
	}
	
	@Override
	public void addDetails(Details details,long userId){
		logger.debug(String.format("Adding details %s for user with id %d",details,userId));
		Session	session = getSession();
		User u = (User) session.load(User.class, userId);
		u.setDetails(details);
		session.persist(details);
		session.saveOrUpdate(u);
	}
	
	@Override
	public void addToGallery(Image image, String username) {
		Session session = getSession();
		User u = retrieveUserByUsername(username);
		image.setOwner(u);
		u.addImage(image);
		session.persist(image);
		session.saveOrUpdate(u);//Update cache
	}

	@Override
	public void changeCoverImage(String username, long imageId) {
		createQuery("UPDATE users SET coverImage =(SELECT i.imagePath FROM images i  WHERE i.id=:id) WHERE username=:username")
		          .setLong("id", imageId)
		          .setString("username",username)
		          .executeUpdate();
	}

	@Override
	public void changeProfilePic(String username, long imageId) {
		createQuery("UPDATE users SET profilePic =(SELECT i.imagePath FROM images i  WHERE i.id=:id) WHERE username=:username")
		          .setLong("id", imageId)
		          .setString("username",username)
		          .executeUpdate();
	}

	@Override
	public boolean checkUsernameAvailability(String username) {
		Query q = createQuery("SELECT 1  FROM users u where u.username=:username")
		          .setString("username", username);		
		return (q.uniqueResult() == null);
	}

	@Override
	public String removeImage(long imageId) {
		logger.debug("Removing image with id " + imageId );
		Session session = getSession();
		Image image =  (Image) session.load(Image.class, imageId); 
		String path = image.getImagePath();
		User u = image.getOwner();
		u.removeFromGallery(image);// Otherwise the image will loiter in the user's cache
		session.delete(image);
		session.saveOrUpdate(u);
		return path;
	}

	@Override
	public List<FriendRequest> getFriendRequests(String username) {
		return createCriteria(FriendRequest.class,"friendRequest")
				           .createAlias("friendRequest.receiver", "receiver")
						   .add(Restrictions.eq("receiver.username",username))
						   .add(Restrictions.eq("accepted" ,false))
						   .add(Restrictions.eq("denied" ,false))
						   .list();
	}

	@Override
	public long countFriendRequests(String username) {
		return (long) createCriteria(FriendRequest.class,"friendRequest")
								  .createAlias("friendRequest.receiver", "receiver")
								  .add(Restrictions.eq("receiver.username",username))
								  .add(Restrictions.eq("accepted" ,false))
								  .add(Restrictions.eq("denied" ,false))
				                  .setProjection(Projections.rowCount())
				                  .uniqueResult(); 
	}

	@Override
	public List<User> newUsers() {
		return createCriteria(User.class)
				           .addOrder(Order.desc("createdOn"))
				           .setMaxResults(5)
				           .list();
	}
	
	@Override
	public void enableUser(String username) {
		changeUserLock(username,true);
	}

	@Override
	public void disableUser(String username) {
		changeUserLock(username,false);
	}
	

	@Override
	public void changeAuthority(String username, String authority) {
	    logger.info(String.format("Changing role to %s for username %s",authority,username));			
		getSession().createSQLQuery("UPDATE authorities SET authority=:group where username=:username")
		            .setString("group", resolveRole(authority))
			        .setString("username",username)
			        .executeUpdate();
	}
	
	@Override
	public List<Image> getUserImages(String username){
		return createCriteria(Image.class,"image")
					       .createAlias("image.owner", "owner")
					       .add(Restrictions.eq("owner.username",username))
					       .list();
	}
	
	@Override
	public String getPassword(String principal) {
		
		return (String) createCriteria()
				                 .add(Restrictions.eq("username",principal))
				                 .setProjection(Projections.projectionList().add(Projections.property("password")))
				                 .setMaxResults(1)
				                 .uniqueResult();
	}

	@Override
	public void changePassword(String principal, String password) {
		logger.info("Changing password for user " + principal);
		createQuery("UPDATE users SET password=:password WHERE username=:username")
		           .setString("password", password)
		           .setString("username", principal)
		           .executeUpdate();
	}
	
	/**
	 * Locks or unlocks a user
	 * @param username the user to lock or unlock 
	 * @param enabled whether to lock or unlock user 
	 */
	private void changeUserLock(String username,boolean enabled){
		logger.info(String.format("Setting enabled to %s for username %s",enabled,username));			
		createQuery("UPDATE users SET enabled=:enabled where username=:username")
		            .setBoolean("enabled", enabled)
			        .setString("username",username)
			        .executeUpdate();
	}
	
	/**
	 * Resolve the supplied role to an authority role that 
	 * Spring Security uses.<br/>
	 * Used before updating a user's role.
	 * @param role This is the role that will be resolved
	 * @return String role that will be saved to db 
	 * @throws IllegalArgumentException if supplied role is unmapped
	 */
	private String resolveRole(String role){
		role = role.toUpperCase();
		switch(role){
		case "USER":
			role="ROLE_USER";
			break;
		case "ADMIN":
			role = "ROLE_ADMIN";
			break;
		default:
			throw new IllegalArgumentException("Received an unmapped role as argument "+role);
		}
		return role;
	}



}

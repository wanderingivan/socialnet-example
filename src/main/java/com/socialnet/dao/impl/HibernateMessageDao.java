package com.socialnet.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.type.IntegerType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.socialnet.dao.MessageDao;
import com.socialnet.model.Chat;
import com.socialnet.model.Message;
import com.socialnet.model.Task;
import com.socialnet.model.WallMessage;
import com.socialnet.model.WallPost;

@Repository
@SuppressWarnings("unchecked")
public class HibernateMessageDao extends AbstractHibernateDao<Message> implements MessageDao {

	
	private static Logger logger = Logger.getLogger(HibernateMessageDao.class);
	
	@Autowired
	public HibernateMessageDao(SessionFactory sessionFactory) {
		
		super(sessionFactory,Message.class);
	}
	

	@Override
	public void sendMessage(String message, String sender, String receiver) {
		getNamedQuery("sendMessage")
		            .setParameter("sender", sender)
		            .setParameter("receiver",receiver)
		            .setParameter("msg",message)
		            .executeUpdate();
	}

	@Override
	public void addMessage(String sender, long chatId, String message) {
	    getNamedQuery("addMessageToChat")
		            .setParameter("sender", sender)
		            .setParameter("message",message)
		            .setParameter("chatId",chatId)
		            .executeUpdate();
		
	}
	
    @Override
	public void createWallPost(String sender, String receiver, String message,String imagePath) {
		getNamedQuery("addWallPost")
		            .setParameter("sender", sender)
		            .setParameter("receiver",receiver)
		            .setParameter("message",message)
		            .setParameter("imagePath",imagePath)
		            .executeUpdate();
	}

	@Override
	public String [] postWallMessage(String sender, long wallPostId, String message) {
		logger.debug(String.format("Saving message %s on wall %d by user %s",message,wallPostId,sender));
		Session session = getSession();
		WallMessage newMessage =  (WallMessage) session.getNamedQuery("addWallMessage")
		                                               .setParameter("sender",sender)
		                                               .setParameter("wallPostId",wallPostId)
		                                               .setParameter("message",message)
		                                               .uniqueResult();
		WallPost wp = (WallPost) session.load(WallPost.class, wallPostId);
		wp.addMessage(newMessage);
		session.saveOrUpdate(wp); // update cache
		return convertToStringArray(newMessage);
		
	}

	@Override
	public List<String[]> getWallMessages(long postId,int index){
		List<String[]> result = new ArrayList<>();
		List<WallMessage> l= createCriteria(WallMessage.class)
		                            .createAlias("wallPost", "parent")
		                            .add(Restrictions.eq("parent.id", postId))
		                            .setFirstResult(index)
		                            .setMaxResults(5)
		                            .list();
		
		for(WallMessage msg : l){
			result.add(convertToStringArray(msg));
		}
		return result;
	}
	
	@Override
	public List<String[]> getWallPost(long user_id,int index){
		List<String[]> result = new ArrayList<>();
		Criteria crit = createCriteria(WallPost.class)
				                    .createAlias("owner","user")
				                    .add(Restrictions.eq("user.id",user_id))
				                    .setFirstResult(index)
				                    .setMaxResults(1);
		WallPost p = (WallPost) crit.uniqueResult();
		result.add(new String[]{String.valueOf(p.getId()),p.getOwner().getUsername(),p.getOwner().getProfilePic()});
		int size = p.getMessages().size() > 5 ? 5 : p.getMessages().size();
		for(int i = 0; i < size;i++){
			if(i  < p.getMessages().size()){
			 result.add(convertToStringArray(p.getMessages().get(i)));
			}
		}
		return result;
	}
	
	@Override
	public List<Chat> loadUserChats(String username){
		return    createCriteria(Chat.class,"chat")
		                            .createAlias("chat.users", "users")
		                            .add(Restrictions.eq("users.username",username))
		                            .list();
	}
	
	@Override
	public Chat loadChat(long chatId){
		return (Chat) getSession().load(Chat.class,chatId);
	}
	

	private String [] convertToStringArray(WallMessage msg){
		return new String []{ String.valueOf(msg.getId()),
					          msg.getMessage(),
					          msg.getPoster().getUsername(),
				              msg.getPoster().getProfilePic()
				            };
	}

	@Override
	public List<WallPost> getWallPostsForUser(String username) {
		Criteria crit = createCriteria(WallPost.class);
		Criteria userCrit = crit.createCriteria("owner");
		userCrit.add(Restrictions.eq("username",username));
		return crit.list();
	}

	@Override
	public WallPost getWallPost(long id) {
		return (WallPost) getSession().load(WallPost.class, id);
	}

	@Override
	public void addLike(String username, long postId) {
		logger.info(String.format("Creating like with username %s for postId %d",username,postId));
		getNamedQuery("addLike")
					.setString("sender", username)
					.setLong("postId",postId)
					.executeUpdate();
	}

	@Override
	public WallPost loadWallPost(long userId, int index) {
		return (WallPost) createCriteria(WallPost.class)
				                      .createAlias("owner","user")
				                      .add(Restrictions.eq("user.id",userId))
				                      .addOrder(Order.desc("id"))
				                      .setFirstResult(index)
				                      .setMaxResults(1)
				                      .uniqueResult();
	}
	
	@Override
	@Transactional
	public int countUnread(String username) {
		return (int) getSession().createSQLQuery("CALL countUnread(:username)")
						   .addScalar("unread",new IntegerType())
				           .setString("username", username)
				           .uniqueResult();
	}

	@Override
	public List<Message> getUnread(String username) {
		return getNamedQuery("unread")
		                   .setString("username", username)
		                   .list();
	}
	
	@Override
	public int countPending(String username) {
		return (Integer) getSession().createSQLQuery("SELECT count(*) as cnt FROM tasks WHERE assignee = :assignee AND complete = 0")
				                     .addScalar("cnt", new IntegerType())
				                     .setString("assignee", username)
				                     .uniqueResult();
	}

	@Override
	public void addTask(Task task, String assigner, String assignee) {
		task.setAssignee(assignee);
		task.setAssigner(assigner);
		task.setCreated(new Date());
		getSession().persist(task);
	}

	@Override
	public void completeTask(long taskId, String comment) {
		createQuery("UPDATE tasks SET message = :comment, complete = true, completed = NOW() WHERE id = :id")
		            .setString("comment", comment)
		            .setLong("id",taskId)
		            .executeUpdate();
	}

	@Override
	public void removeTask(long taskId) {
		createQuery("DELETE FROM tasks where id = :id")
		            .setLong("id", taskId)
		            .executeUpdate();
	}

	@Override
	public List<Task> getTasks(boolean fetchAll) {
		Criteria crit = createCriteria(Task.class)
				                    .addOrder(Order.desc("created"));
		if(!fetchAll){ crit.setMaxResults(10);}
		return crit.list();
	}

	@Override
	public List<Task> getTasks(String username, boolean fetchAll) {
		Criteria crit =createCriteria(Task.class)
				                    .add(Restrictions.eq("assignee",username))
				                    .addOrder(Order.desc("created"))
				                    .addOrder(Order.desc("complete"));
		if(!fetchAll){ 
			crit.add(Restrictions.eq("complete", false));
			crit.setMaxResults(10);
		}
		
		return crit.list();
	}


	@Override
	public void deleteWallPost(long postId) {
		createQuery("DELETE FROM wall_posts WHERE wall_post_id = :id")
		            .setLong("id", postId)
		            .executeUpdate();
	}
}

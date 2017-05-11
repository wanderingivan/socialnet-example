package com.socialnet.test.dao;

import java.io.File;
import java.net.MalformedURLException;
import java.util.List;

import org.dbunit.dataset.DataSetException;
import org.dbunit.dataset.IDataSet;
import org.dbunit.dataset.xml.FlatXmlDataSetBuilder;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.socialnet.dao.MessageDao;
import com.socialnet.model.Chat;
import com.socialnet.model.Like;
import com.socialnet.model.Message;
import com.socialnet.model.Task;
import com.socialnet.model.WallMessage;
import com.socialnet.model.WallPost;

public class MessageDaoTests extends AbstractDaoTest{

	private MessageDao dao;

	private static String userWithNoWallposts1 = "username2",
						  userWithNoWallposts2 = "username5",
						  userWithOneWallPost = "username8",
						  poster = "username3",
						  userTestConversation1="username10";
	@Test
	@Transactional
	public void testSendMessage(){
		dao.sendMessage("message4", "username3", "username4");
		List<Chat> chats = dao.loadUserChats("username4");
		assertNotNull(chats);
		assertEquals(1,chats.size());
		assertEquals(1,chats.get(0).getMessages().size());
	}
	
	@Test
	@Transactional
	public void testRetrieveConversation(){
		List<Chat> chats = dao.loadUserChats(userTestConversation1);
		assertEquals("Wrong number of conversations retrieved",1,chats.size());
		Chat test = chats.get(0);
		assertEquals("Wrong number of messages retrieved",2,test.getMessages().size());
	}
	
	@Test
	@Transactional
	public void testSendMessageExistingChat(){
		dao.sendMessage("message5","username10","username11");
		List<Chat> chats = dao.loadUserChats("username11");
		assertNotNull(chats);
		assertEquals(1,chats.size());
		assertEquals(3,chats.get(0).getMessages().size());
	}

	@Test
	@Transactional
	public void testAddMessage(){
	    dao.addMessage("username10",5,"test message");
		List<Chat> chats = dao.loadUserChats("username11");
		assertNotNull(chats);
		assertEquals(1,chats.size());
		assertEquals(3,chats.get(0).getMessages().size());	
	}
	
	@Test
	@Transactional
	public void testCreateWallPost() {
		dao.createWallPost(userWithNoWallposts1,userWithNoWallposts2,"mes",null);
		WallPost post = dao.getWallPostsForUser(userWithNoWallposts2).get(0);
		assertEquals("Incorrect number of posts saved",1,post.getMessages().size());
		assertEquals(1,post.getMessages().size());
		assertEquals("Wrong owner saved",userWithNoWallposts2,post.getOwner().getUsername());
		WallMessage msg = (WallMessage) post.getMessages().get(0);
		assertEquals("Wrong message saved","mes",msg.getMessage());
		assertEquals("Incorrect sender saved",userWithNoWallposts1,msg.getPoster().getUsername());
	}
	
	@Test
	@Transactional
	public void testSendWallPostMessage() {

		dao.postWallMessage(poster,3,"message2");
		WallPost post = dao.getWallPost(3);
		System.out.println(post.getMessages());
		assertEquals("Incorrect number of messages saved",2,post.getMessages().size());
		
		WallMessage msg = post.getMessages().get(1);
		assertEquals("Wrong message saved","message2",msg.getMessage());
		assertEquals("Incorrect sender saved",poster,msg.getPoster().getUsername());
		
		
	}
	

	
	@Test
	@Transactional
	public void testRetrieveWallPosts(){
		List<WallPost> posts = dao.getWallPostsForUser(userWithOneWallPost);
		assertEquals("Incorrect number of posts retrieved",1,posts.size());
	}
	
	@Test
	@Transactional
	public void testGetWallMessages(){
		List<String []> test = dao.getWallMessages(4, 5);
		assertEquals("Incorrect number of posts retrieved",test.size(),2);
	}
	

	
	@Test
	@Transactional
	public void testLikeWallPost(){
		dao.addLike("username2",3);
		WallPost p = dao.getWallPost(3);
		assertEquals("Incorrect number of likes retrieved", 2,p.getLikes().size());
		Like l = p.getLikes().get(1);
		assertEquals("Incorrect user saved","username2",l.getUser().getUsername());
	}

	@Test
	@Transactional
	public void testRetrieveWallPostLikes(){
		WallPost p = dao.getWallPost(3);
		assertEquals("Incorrect number of likes retrieved", 1,p.getLikes().size());
		Like l = p.getLikes().get(0);
		assertEquals("Incorrect user saved","username1",l.getUser().getUsername());
	}


	@Test
	@Transactional
	public void testCountUnread(){
		int unread = dao.countUnread("username10");
		assertEquals(1, unread);
	}
		
	@Test
	@Transactional
	public void testGetUnread(){
		dao.addMessage("username11", 5, "message");
		List<Message> unread =dao.getUnread("username10");
		assertNotNull(unread);
		assertEquals(2, unread.size());
		//Depends on testCountUnread
		int count =dao.countUnread("username1");
		assertEquals(0,count);
	}
	
	
	
	@Test
	@Transactional
	public void testTaskRetrieval(){
		List<Task> tasks = dao.getTasks(false);
		assertNotNull(tasks);
		assertEquals(2, tasks.size());
	}
	
	@Test
	@Transactional
	public void testUserTasksRetrieval(){
		List<Task> tasks = dao.getTasks("username1",false);
		assertNotNull(tasks);
		assertEquals(1, tasks.size());
		Task test = tasks.get(0);
		assertEquals("username2",test.getAssigner());
		assertEquals("username1",test.getAssignee());
	}
	
	@Test
	@Transactional
	public void testCountTasks(){
		int tasks = dao.countPending("username1");
		assertEquals(1,tasks);
	}
	
	@Test
	@Transactional
	public void testAddTask(){
		dao.addTask(new Task("test task 3","test desc"), "username2", "username3");
		List<Task> tasks = dao.getTasks("username3",true);
		assertNotNull(tasks);
		assertEquals(2, tasks.size());
		Task test = tasks.get(0);
		assertEquals("username2",test.getAssigner());
		assertEquals("username3",test.getAssignee());
	}
	
	@Test
	@Transactional
	public void testCompleteTask(){
		dao.completeTask(1, "complete message");
		List<Task> tasks = dao.getTasks("username1",true);
		assertNotNull(tasks);
		assertEquals(1, tasks.size());
		Task test = tasks.get(0);
		assertTrue(test.isComplete());
		assertNotNull(test.getCompleted());
		assertEquals("complete message", test.getComment());
	}
	
	@Test
	@Transactional
	public void testRemoveTask(){
		dao.removeTask(1);
		List<Task> tasks = dao.getTasks("username1",true);
		assertEquals(0, tasks.size());
	}
	
	@Override
	protected IDataSet getDataSet() throws MalformedURLException, DataSetException {
		return new FlatXmlDataSetBuilder().build(new File(defaultTestResourceFolder.concat("DbTestDataSet.xml")));
	}

	@Autowired
	public void setMessageDao(MessageDao messageDao) {
		this.dao = messageDao;
	}
	
	
	
}

package com.socialnet.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.socialnet.model.Chat;
import com.socialnet.model.Message;
import com.socialnet.model.Task;
import com.socialnet.model.WallPost;
import com.socialnet.service.ImageService;
import com.socialnet.service.MessageService;
import com.socialnet.dao.MessageDao;
/**
 *	Implementation of MessageService that delegates transaction management
 *	to spring<br/>
 *	and performs checks on method permissions.
 *  @see MessageService
 *
 */
@Service
public class MessageServiceImpl implements MessageService {

	
	private MessageDao dao;
	private ImageService imageService;
	
	@Autowired
	public MessageServiceImpl(MessageDao dao,ImageService imageService){
		super();
		this.dao = dao;
		this.imageService = imageService;
			
	}

	@Override
	@Transactional
	public void createWallPost(String sender, String owner, String message,String imagePath) {
		dao.createWallPost(sender, owner, message,imagePath);
	}

	@Override
	@Transactional
	public String[] postWallMessage(String sender, long postId, String message) {
		String[] result = dao.postWallMessage(sender, postId, message);
		convertImageToB64(result);
		return result;
	}

	@Override
	@Transactional
	public WallPost getWallPost(long postId) {
		return dao.getWallPost(postId);
	}

	@Override
	@Transactional
	public List<WallPost> getWallPostsForUser(String username) {
		return dao.getWallPostsForUser(username);
	}

	@Override
	@Transactional
	public Chat getChat(long chatId) {
		return dao.loadChat(chatId);
	}

	@Override
	@Transactional
	public List<Chat> getUserChats(String username) {
		return dao.loadUserChats(username);
	}

	@Override
	@Transactional
	public void sendMessage(String message, String sender, String receiver) {
		dao.sendMessage(message, sender, receiver);
	}

	@Override
	@Transactional
	public void addMessage(String sender, String message, long chatId) {
		dao.addMessage(sender, chatId, message);
	}

	@Override
	@Transactional
	public List<String []> loadComments(long postId,int index){
		List<String[]> result = dao.getWallMessages(postId, index);
		convertImageToB64(result);
		return result;
	}
	
	@Override
	@Transactional
	public List<String []> loadPost(long user_id,int index){
		List<String[]> result =  dao.getWallPost(user_id, index);
		convertImageToB64(result);
		return result;
	}
	
	@Override
	@Transactional
	public void addLike(String username, long postId) {
		dao.addLike(username, postId);
	}
	
	@Override
	@Transactional
	public WallPost loadWallPost(long userId, int index) {
		return dao.loadWallPost(userId,index);
	}
	
	@Override
	@Transactional
	public int countUnread(String username) {
		return dao.countUnread(username);
	}

	@Override
	@Transactional
	@PreAuthorize("isAuthenticated()")
	public List<Message> getUnread(String username) {
		return dao.getUnread(username);
	}
	
	@Override
	@Transactional
	public void addTask(Task task, String username, String assigned) {
		dao.addTask(task, username, assigned);
	}

	@Override
	@Transactional
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void completeTask(long taskId, String comment) {
		dao.completeTask(taskId, comment);
	}

	@Override
	@Transactional
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void removeTask(long taskId) {
		dao.removeTask(taskId);
	}

	@Override
	@Transactional
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public List<Task> latestTasks() {
		return dao.getTasks(false);
	}

	@Override
	@Transactional
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public List<Task> retrieveAllTasks(){
		return dao.getTasks(true);
	}
	
	@Override
	@Transactional
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public List<Task> retrieveUserPendingTasks(String username){
		return dao.getTasks(username, false);
	}
	
	@Override
	@Transactional
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public List<Task> retrieveUserTasks(String username) {
		return dao.getTasks(username, true);
	}

	@Override
	@Transactional
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public int countPending(String username) {
		return dao.countPending(username);
	}	
	
	/** 
	 * Converts images to b64 string suitable for ajax response
	 * 
	 */
	private void convertImageToB64(List<String[]> messages) {
		for(String [] msg : messages){
			convertImageToB64(msg);
		}
	}
	
	private void convertImageToB64(String[] message){
		try{
			message[3] = imageService.getB64(message[3]);
		}catch (Exception e) {
			message[3] = null;
		}
	}

	@Override
	@Transactional
	public void deleteWallPost(long postId) {
		dao.deleteWallPost(postId);
	}


}

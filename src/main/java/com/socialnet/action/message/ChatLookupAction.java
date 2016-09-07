package com.socialnet.action.message;


import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.socialnet.model.Chat;

public class ChatLookupAction extends AbstractMessageAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8044228595888924231L;
	private static final Logger logger = Logger.getLogger(ChatLookupAction.class);			
	
	private boolean full;
	private long chatId;
	private Chat chat;
	
	@Action(value="chat", results={@Result(name="success",location="/WEB-INF/content/jsp/user/chat.jsp")})
	public String execute(){
		try{			
			logger.trace("Loading chat " + chatId);
			chat = service.getChat(chatId);
			logger.debug("Result " +chat);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught " +e);
		}
		return ERROR;
	}

	public long getChatId() {
		return chatId;
	}

	public void setChatId(long chatId) {
		this.chatId = chatId;
	}


	public Chat getChat() {
		return chat;
	}

	public boolean isFull() {
		return full;
	}

	public void setFull(boolean full) {
		this.full = full;
	}

	public void setChat(Chat chat) {
		this.chat = chat;
	}

	public String getUsername() {
		return username;
	}
	
}

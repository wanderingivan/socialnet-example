package com.socialnet.action.message;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

public class MessageAction extends AbstractMessageAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7473970671976688423L;
	private static final Logger logger = Logger.getLogger(MessageAction.class);			
	
	private String message,
				   receiver;
	private long chatId;
	
	@Action(value="send-message",results={@Result(name="success",type="redirectAction",params={"namespace","/user","actionName","user-messages"})})
	public String execute(){
		try{
			logger.debug( String.format("Sending Message to %s from %s",receiver,username));
			service.sendMessage(message,username,receiver);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught " +e);
		}
		return ERROR;
	}


	@Action(value="reply-message",results={@Result(name="success",type="redirectAction",params={"namespace","/user","actionName","user-messages"})})
	public String addMessage(){
		try{
			logger.debug( String.format("Sending Message chat %d from %s",chatId,username));
			service.addMessage(username,message,chatId);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught " +e);
		}
		return ERROR;
	}
	

	public void setMessage(String message) {
		this.message = message;
	}


	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}


	public void setChatId(long chatId) {
		this.chatId = chatId;
	}

}

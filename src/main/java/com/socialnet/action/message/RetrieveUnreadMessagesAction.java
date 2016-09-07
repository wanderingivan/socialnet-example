package com.socialnet.action.message;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import com.socialnet.interceptor.AuthenticatedUserAware;
import com.socialnet.model.Message;
import com.socialnet.service.MessageService;
import com.opensymphony.xwork2.ActionSupport;

import java.util.List;

/**
 * 
 *	Provides an action method for retrieving a user's
 *  unread messages. 
 *
 */
@ParentPackage("message")
@InterceptorRefs(value={@InterceptorRef(value="authAwareStack")})
public class RetrieveUnreadMessagesAction extends ActionSupport implements
		AuthenticatedUserAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7460760231809882831L;

	private static final Logger logger = Logger.getLogger(RetrieveUnreadMessagesAction.class);	
	
	private MessageService service;
	
	private List<Message> messages;
	private String username;

	
	@Action(value="unread-messages",results={@Result(name="success",location="/WEB-INF/content/jsp/user/unreadMessages.jsp")})
	public String execute(){
		try{
			logger.debug("Getting unread messages for " + username);
			messages = service.getUnread(username);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Caught exception "+ e);
			logger.error(e);
			e.printStackTrace();
		}
		return ERROR;
	}

	public List<Message> getMessages() {
		return messages;
	}

	public void setMessages(List<Message> messages) {
		this.messages = messages;
	}
	
	@Autowired
	public void setService(MessageService service) {
		this.service = service;
	}

	@Override
	public void setUser(String username) {
		this.username= username;
	}

}

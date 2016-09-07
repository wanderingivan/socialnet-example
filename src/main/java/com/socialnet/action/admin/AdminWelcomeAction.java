package com.socialnet.action.admin;

import java.util.List;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.socialnet.interceptor.AuthenticatedUserAware;
import com.socialnet.model.Chat;
import com.socialnet.model.User;
import com.socialnet.service.MessageService;
import com.socialnet.service.UserService;
import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("admin")
@InterceptorRefs(value={@InterceptorRef(value="authAwareStack")})
public class AdminWelcomeAction extends ActionSupport implements AuthenticatedUserAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6991332764405014072L;
	private static final Logger logger = Logger.getLogger(AdminWelcomeAction.class);

	
	@Autowired
	private MessageService	messageService;
	
	
	@Autowired
	private UserService userService;
	
	private List<User> newestUsers;
	
	private List<Chat> userChats;
	
	private String username;

	@Action(value="welcome",results={@Result(name="success",location="/WEB-INF/content/jsp/admin/admin.jsp")})
	public String execute(){
		logger.trace("Loading Admin Homepage");
		newestUsers = userService.newUsers();
		userChats = messageService.getUserChats(username);
		return SUCCESS;
	}


	public MessageService getMessageService() {
		return messageService;
	}


	public void setMessageService(MessageService messageService) {
		this.messageService = messageService;
	}

	public UserService getUserService() {
		return userService;
	}


	public void setUserService(UserService userService) {
		this.userService = userService;
	}


	public List<User> getNewestUsers() {
		return newestUsers;
	}

	public List<Chat> getUserChats() {
		return userChats;
	}


	public void setUserChats(List<Chat> userChats) {
		this.userChats = userChats;
	}


	public void setNewestUsers(List<User> newestUsers) {
		this.newestUsers = newestUsers;
	}


	@Override
	public void setUser(String username) {
		this.username = username;
	}

}

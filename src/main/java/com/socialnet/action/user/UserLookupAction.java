package com.socialnet.action.user;


import java.util.List;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Actions;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.socialnet.interceptor.AuthenticatedUserAware;
import com.socialnet.model.User;


@InterceptorRefs({@InterceptorRef(value="authAwareStack")})
@Results({@Result(name="missing",type="redirectAction",params={"actionName","search","username","${username}","searchMessage","global.no_user"})
        })
public class UserLookupAction extends AbstractUserAction implements AuthenticatedUserAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3259629197812646525L;
	private static final Logger logger = Logger.getLogger(UserLookupAction.class);

	private String authenticatedUser;
	private String searchMessage = "global.matching";
	
	private User user;
	private List<User> users;
	
	@Actions({
			  @Action(value="show",results={@Result(name="success",type="tiles",location="userHomeLayout")}),
	          @Action(value="gallery",results={@Result(name="success",type="tiles",location="userGalleryLayout")}),
	          @Action(value="friends",results={@Result(name="success",type="tiles",location="userFriendsLayout")}),
	          @Action(value="details",results={@Result(name="success",type="tiles",location="userDetailsLayout")}),
			  @Action(value="user-messages", results={@Result(name="success", type="tiles", location="userMessagesLayout")})
	})
	public String execute(){
		try{
			if(username==null){
				username = authenticatedUser;
			}
			logger.trace("Loading user " + username);
			user = service.loadUser(username);
			logger.debug("Loaded user " + user);
			if(user == null){return "missing";}
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught loading user " + e);
		}
		return ERROR;
	}
	
	@Action(value="search",results={@Result(name="success",type="tiles",location="userListLayout")})
	public String loadUsers(){
		try{
			logger.trace("Searching for  users with username " + username);
			users = service.findUsers(username);
			logger.debug("Loaded users " + users);
			username = username.toUpperCase();
			searchMessage = getText(searchMessage);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught loading users " + e);
		}
		return ERROR;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public void setUser(String username) {
		this.authenticatedUser = username;
	}

	public String getSearchMessage() {
		return searchMessage;
	}

	public void setSearchMessage(String searchMessage) {
		this.searchMessage = searchMessage;
	}
	
}
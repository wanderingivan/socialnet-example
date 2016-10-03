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
@Results({@Result(name="redirect",type="redirectAction",params={"actionName","search","username","${username}","missing","true"})
        })
public class UserLookupAction extends AbstractUserAction implements AuthenticatedUserAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3259629197812646525L;
	private static final Logger logger = Logger.getLogger(UserLookupAction.class);

	private String authenticatedUser;
	private String searchMessage = "global.matching",
			       missingMessage = "global.no_user";
	private boolean missing;
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
			user = service.loadUser(username);
			if(logger.isDebugEnabled()){
				logger.debug("Loaded user " + user);
			}
			if(user == null){
				return "redirect";
			}
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught loading user " + e);
		}
		return ERROR;
	}
	
	@Action(value="search",results={@Result(name="success",type="tiles",location="userListLayout")})
	public String loadUsers(){
		try{
			users = service.findUsers(username);
			if(logger.isDebugEnabled()){
				logger.debug("Loaded users " + users);
			}
			username = username.toUpperCase();
			if(!missing){
				searchMessage = getText(searchMessage);
			}else{
				searchMessage = getText(missingMessage);
			}
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

	public void setMissing(boolean missing) {
		this.missing = missing;
	}
	
}
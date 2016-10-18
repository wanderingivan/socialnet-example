package com.socialnet.action.user;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.Result;

import com.socialnet.interceptor.AuthenticatedUserAware;
import com.socialnet.model.User;

@InterceptorRefs({@InterceptorRef(value="authAwareStack")})
public class LoadEditAction extends AbstractUserAction implements AuthenticatedUserAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5382893343202763527L;
	private static final Logger logger = Logger.getLogger(LoadEditAction.class);
	
	private String authenticatedUser;
	
	private User user;
	
	@Action(value="editPage",results={@Result(name="success",type="tiles",location="userEditLayout")})
	public String execute(){
		try{
			if(logger.isTraceEnabled()){
				logger.trace("Loading user for editing");
			}
			if(username==null){
				username = authenticatedUser;
			}
			user = service.loadUser(username);
			logger.debug("Loaded user " + user);
			return SUCCESS;
		}catch(Exception e){
			
		}
		return ERROR;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public long getId(){
		return user.getId();
	}

	@Override
	public void setUser(String username) {
		this.authenticatedUser = username;
	}
	
}

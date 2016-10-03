package com.socialnet.action.user;


import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.Result;

import com.socialnet.interceptor.AuthenticatedUserAware;


@InterceptorRefs({@InterceptorRef(value="authAwareStack")})
public class UserImageAction extends AbstractUserAction implements AuthenticatedUserAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = -5890581530903482622L;
	private static Logger logger = Logger.getLogger(UserImageAction.class);
	private long imageId;

	private String authenticatedUser;
	
	@Action(value="changeCover",results={@Result(name="success",type="redirectAction", params={"actionName","gallery"})})
	public String execute(){
		try{
			if(username==null){
				username = authenticatedUser;
			}
			service.changeCoverImage(username,imageId);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught changing user cover " +e );
		}
		return ERROR;
	}
	
	@Action(value="changeProfileImage",results={@Result(name="success",type="redirectAction", params={"actionName","gallery"})})
	public String changeProfilePic(){
		try{
			if(username==null){
				username = authenticatedUser;
			}
			service.changeProfilePic(username,imageId);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught changing profile image "+e );
		}
		return ERROR;
	}

	public long getImageId() {
		return imageId;
	}

	public void setImageId(long imageId) {
		this.imageId = imageId;
	}

	@Override
	public void setUser(String username) {
		this.authenticatedUser = username;
	}
	
	
}

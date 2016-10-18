package com.socialnet.action.user;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.socialnet.interceptor.AuthenticatedUserAware;
import com.socialnet.service.ImageService;

@InterceptorRefs({@InterceptorRef(value="authAwareStack")})
public class DeleteUserAction extends AbstractUserAction implements AuthenticatedUserAware{

	/**
	 * 
	 */
	private static Logger logger  = Logger.getLogger(DeleteUserAction.class);
	private static final long serialVersionUID = -3970178174439812336L;
	
	private String authenticatedUser;
	
	private ImageService imageService;
	
	@Action(value="delete",results={@Result(name="success", type="redirectAction", params={"actionName","adminHome"})})
	public String execute(){
		try{
	        if(logger.isInfoEnabled()){
	            logger.info(" User  "+ authenticatedUser + "Deleting User "+ username);
	        }
			imageService.removeImages(service.getUserImages(username));
			service.delete(username);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught when deleting user "+ username + "\n" + e);
		}
		return ERROR;
	}


	@Override
	public void setUser(String username) {
		this.authenticatedUser = username;
	}

	@Autowired
	public void setImageService(ImageService imageService) {
		this.imageService = imageService;
	}
	
	
	
}	
	
	


package com.socialnet.action.user;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

public class CheckUsernameAction extends AbstractUserAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5742775317365568410L;
	private static final Logger logger = Logger.getLogger(CheckUsernameAction.class);
	
	private boolean available;
	
	private String message;
	
	@Action(value="checkAvailability",results={@Result(name="success",type="json")})
	public  String execute(){
		try{
			available = service.checkUsernameAvailability(getUsername());
			if(available){
				message = getText("global.isAvailable");
			}else{
				message = getText("global.isUnavailable");
			}
			 return SUCCESS;
		}catch(Exception e){
				logger.error("Error checking username availability for username " + username);
		}
		return ERROR;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
}

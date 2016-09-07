package com.socialnet.action.user;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.socialnet.model.Details;
import com.socialnet.model.User;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.validator.annotations.VisitorFieldValidator;

public class AddDetailsAction extends AbstractUserAction implements ModelDriven<Details>{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4058571151871980071L;
	private static final Logger logger = Logger.getLogger(AddDetailsAction.class);

	private Details details;
	
	private long userId;
	
	@Action(value="addDetails", results={@Result(name="success",type="redirectAction", params={"actionName","details"}),
										 @Result(name="input",type="tiles", location="userEditLayout")})
	public String execute(){
		try{
			logger.trace(String.format("Adding details %s for user %d",details,userId));
			service.addDetails(details, new User(userId));// User.class is needed for the acl to function properly
			return SUCCESS;
		}catch(Exception e){
			logger.error(String.format("Error adding details %s for user %d",details,userId));
		}
		return ERROR;
	}

	
	
	
	@VisitorFieldValidator(appendPrefix=true)
	public Details getDetails() {
		return details;
	}

	public void setDetails(Details details) {
		this.details = details;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	@Override
	public Details getModel() {
		return details;
	}
}

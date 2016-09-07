package com.socialnet.action.user;


import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.socialnet.exception.DuplicateEmailException;
import com.socialnet.exception.DuplicateUsernameException;
import com.socialnet.model.User;
import com.socialnet.service.UserService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.validator.annotations.VisitorFieldValidator;


@ParentPackage("user")
public class CreateUpdateAction extends ActionSupport implements ModelDriven<User>{

	
	
	/**
	 * 
	 */
	private static Logger logger = Logger.getLogger(CreateUpdateAction.class);
	private static final long serialVersionUID = -5654252693089079347L;
	
	private UserService userService;
	
	private User user = new User();
	

	@Action(value="create",results={@Result(name="success", type="redirectAction", params={"actionName","show","username","${user.username}"}),
								    @Result(name="input",location="/WEB-INF/content/jsp/base/create.jsp")})
	public String execute(){
		try{
			logger.info(String.format("Creating user with username %s and email %s",user.getUsername(),user.getEmail()));
			userService.createUser(user);
			return SUCCESS;
			
		}catch(DuplicateEmailException de){

			addFieldError("user.email", getText("global.duplicate_email"));
			return INPUT;

		}catch(DuplicateUsernameException de){
			
			addFieldError("user.username", getText("global.duplicate_username"));
			return INPUT;
			
		}catch(Exception e){
			logger.error("Exception caught creating user " + user.getUsername() + "\n" + e );
			e.printStackTrace();
		}
		return ERROR;
	}
	
	@Action(value="edit",results={@Result(name="success", type="redirectAction", params={"actionName","/logout"}),
								  @Result(name="input",type="tiles", location="userEditLayout")})
	public String editUser(){
		try{
			logger.info(String.format("Updating user with username %s and email %s",user.getUsername(),user.getEmail()));
			userService.updateUser(user);
			return SUCCESS;
			
		}catch(DuplicateEmailException de){

			addFieldError("user.email", getText("global.duplicate_email"));
			return INPUT;

		}catch(DuplicateUsernameException de){
			
			addFieldError("user.username", getText("global.duplicate_username"));
			return INPUT;
			
		}catch(Exception e){
			logger.error("Exception caught updating user with " + user.getUsername() + "\n" + e );
		}	
		return ERROR;
	}
	
	@Override
	public User getModel(){
		return user;
	}

	@VisitorFieldValidator(appendPrefix=true)
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Autowired
	public void setUserService(UserService service){
		this.userService = service;
	}

}

package com.socialnet.action.user;


import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.beans.factory.annotation.Autowired;

import com.socialnet.exception.DuplicateEmailException;
import com.socialnet.exception.DuplicateUsernameException;
import com.socialnet.model.User;
import com.socialnet.service.UserService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.validator.annotations.VisitorFieldValidator;


@ParentPackage("user")
public class CreateUpdateAction extends ActionSupport implements ModelDriven<User>, ServletRequestAware {

	
    
	
	/**
	 * 
	 */
	private static Logger logger = Logger.getLogger(CreateUpdateAction.class);
	private static final long serialVersionUID = -5654252693089079347L;
	
	private UserService userService;
	
	private User user = new User();
    private HttpServletRequest http;
	

	@Action(value="create",results={@Result(name="success", type="redirectAction", params={"actionName","show","username","${user.username}"}),
								    @Result(name="input", type="tiles", location="userCreateLayout")})
	public String execute(){
		try{
	        if(logger.isInfoEnabled()){
	            logger.info(String.format("Creating user with username %s and email %s",user.getUsername(),user.getEmail()));
	        }
	        if(!validatePassword(user.getPassword())){
	            return INPUT;
	        }
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
	


    @Action(value="edit",results={@Result(name="success", type="redirectAction", params={"actionName","/index","namespace","/"}),
								  @Result(name="input",type="tiles", location="userEditInputLayout")})
	public String editUser(){
		try{
	        if(logger.isInfoEnabled()){
			    logger.info(String.format("Updating user with id %d, username %s and email %s",user.getId(),user.getUsername(),user.getEmail()));
	        }
			userService.updateUser(user);
	        http.logout();
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

    @Override
    public void setServletRequest(HttpServletRequest http) {
        this.http = http;
    }
    
    /**
     * Validates password string 
     * and updates fieldErrors if needed
     * @return
     */
	private boolean validatePassword(String password) {
	    if(password.isEmpty()){ 
	        addFieldError("user.password", getText("global.field_required"));
	        return false;
	    }
	    if(password.length() > 50 || password.length() < 5){
	        addFieldError("user.password", getText("global.field_password_length"));
	        return false;
	    }
	    return true;
    }

}

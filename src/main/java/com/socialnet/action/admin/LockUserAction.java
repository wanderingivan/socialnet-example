package com.socialnet.action.admin;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.socialnet.service.UserService;
import com.opensymphony.xwork2.ActionSupport;


@ParentPackage("admin")
public class LockUserAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8311269827905963276L;
	private static final Logger logger = Logger.getLogger(LockUserAction.class); 
	
	private UserService service;
	
	private String username;
	

	@Action(value="enableUser",results={@Result(name="success",type="redirectAction",params={"namespace","/user","actionName","show","username","${username}"})})
	public String execute(){
        if(logger.isInfoEnabled()){
            logger.info("Locking user with username: " + username);
        }
		try{
			service.enableUser(username);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Error enabling user: "+ username + "\n" +e);
		}
		return ERROR;
	}

	@Action(value="disableUser",results={@Result(name="success",type="redirectAction",params={"namespace","/user","actionName","show","username","${username}"})})
	public String disableUser() {
        if(logger.isInfoEnabled()){
            logger.info("Locking user with username: " + username);
        }
		try{
			service.disableUser(username);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Error enabling user: "+ username + "\n" + e);
		}
		return ERROR;	
	}

	@Autowired
	public void setService(UserService service) {
		this.service = service;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
}

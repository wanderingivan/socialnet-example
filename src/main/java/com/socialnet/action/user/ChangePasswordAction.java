package com.socialnet.action.user;

import javax.servlet.http.HttpServletRequest;

import com.socialnet.exception.IncorrectPasswordException;
import com.socialnet.interceptor.AuthenticatedUserAware;

import com.opensymphony.xwork2.validator.annotations.RequiredStringValidator;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.interceptor.ServletRequestAware;

@InterceptorRefs(value={@InterceptorRef(value="authAwareStack")})
public class ChangePasswordAction extends AbstractUserAction implements
		AuthenticatedUserAware,ServletRequestAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5463924621931797938L;
	private static final Logger logger = Logger.getLogger(ChangePasswordAction.class); 

	private HttpServletRequest http;
	
	private String user,
	 			   oldPassword,
	 			   newPassword;
	
	@Action(value="changePassword",results={@Result(name="success", type="redirectAction", params={"actionName","index","namespace","/"}),
											@Result(name="input", type="tiles", location="changePasswordLayout")})
	public String changePassword(){
		try{
	        if(logger.isInfoEnabled()){
	            logger.info("Changing password for user " + user);
	        }
			service.changePassword(user,oldPassword,newPassword);
			http.logout();
			return SUCCESS;
		}catch(IncorrectPasswordException ex){
			addFieldError("oldPassword", getText("global.incorrect_password"));
			return INPUT;
		}catch(Exception ex){
			logger.error("Exception caught changing password for user" + user + "\n" +ex);
		}
		return ERROR;
	}
	
	@Override
	public void setUser(String username) {
		this.user = username;
	}
	
	public String getOldPassword() {
		return oldPassword;
	}

	@RequiredStringValidator(fieldName="oldPassword",key="global.field_required")
	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}

	public String getNewPassword() {
		return newPassword;
	}

	@RequiredStringValidator(fieldName="newPassword",key="global.field_required")
	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	@Override
	public void setServletRequest(HttpServletRequest http) {
		this.http = http;
	}

}

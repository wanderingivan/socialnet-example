package com.socialnet.action.admin;


import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.socialnet.interceptor.AuthenticatedUserAware;
import com.socialnet.service.MessageService;
import com.opensymphony.xwork2.ActionSupport;


@ParentPackage("admin")
@InterceptorRefs(value={@InterceptorRef(value="authAwareStack")})
public class CountUserTasksAction extends ActionSupport implements
		AuthenticatedUserAware {
	
    /**
	 * 
	 */
	private static final long serialVersionUID = -2634975104305034603L;
	private static final Logger logger = Logger.getLogger(CountUserTasksAction.class);
	private int tasks;
	private String message,
				   username;
	private MessageService service;

	@Action(value="countTasks", results={@Result(name="success",type="json")})
	public String execute(){
		try{
			tasks = service.countPending(username);
			message = String.valueOf(tasks)
					        .concat(getText("global.pending_tasks"));
			logger.debug("Message: " + message);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught counting tasks for " + username +" " + e);
		}
		return ERROR;
	}
	

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	@Autowired
	public void setService(MessageService service) {
		this.service = service;
	}

	@Override
	public void setUser(String username) {
		this.username = username;
	}
	
}

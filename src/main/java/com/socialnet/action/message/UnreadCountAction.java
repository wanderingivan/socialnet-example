package com.socialnet.action.message;


import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;

import com.socialnet.interceptor.AuthenticatedUserAware;
import com.socialnet.service.MessageService;
import com.opensymphony.xwork2.ActionSupport;


/**
 * 
 *	Provides an action method for retrieving a user's
 *  unread messages count. 
 */
@ParentPackage("message")
@InterceptorRefs(value={@InterceptorRef(value="authAwareStack")})
public class UnreadCountAction extends ActionSupport implements
		AuthenticatedUserAware {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4782191955441013987L;

	private static final Logger logger = Logger.getLogger(UnreadCountAction.class);	

	private MessageService service;
	
	private int count;
	
	private String message;
	private String username;
	

	@Action(value="unread-count",results={@Result(name="success",type="json")})
	public String execute(){
		try{
			count = service.countUnread(username);
			if(count == 0){
				message =getText("global.no_unread");
			}else if(count == 1){
				message = getText("global.one_unread");
			}else{
				message = getText("global.multiple_unread");
			}
			return SUCCESS;
		}catch(Exception e){
			logger.error("Caught exception counting unread for "+ username +" " +e);
		}
		return ERROR;
	}
	
	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public void setUser(String username) {
		this.username= username;
	}

	
	@Autowired
	public void setService(MessageService service) {
		this.service = service;
	}
}

package com.socialnet.action.message;

import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;

import com.socialnet.interceptor.AuthenticatedUserAware;
import com.socialnet.service.MessageService;
import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("message")
@InterceptorRefs({@InterceptorRef(value="authAwareStack")})
public abstract class AbstractMessageAction extends ActionSupport implements AuthenticatedUserAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = -555790676324309028L;

	protected MessageService service;
	protected String username;
	
	@Autowired
	public void setService(MessageService messageService) {
		this.service = messageService;
	}

	@Override
	public void setUser(String username){
		this.username = username;
	}
	
}

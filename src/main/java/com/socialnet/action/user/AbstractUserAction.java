package com.socialnet.action.user;

import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;

import com.socialnet.service.UserService;
import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("user")
public abstract class AbstractUserAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8926749179492693294L;
	protected String username;
	
	protected UserService service;
		

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
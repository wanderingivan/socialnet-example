package com.socialnet.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import com.socialnet.interceptor.AuthenticatedUserAware;
import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("default")
@InterceptorRefs({@InterceptorRef(value="authAwareStack")})
public class IndexAction extends ActionSupport implements AuthenticatedUserAware{

	/**
	 * 
	 */
	private String username;
	
	private static final long serialVersionUID = 6098027670989202611L;
	
	@Action(value="index", results={@Result(name="success",type="tiles",location="loginLayout"),
								    @Result(name="homepage", type="redirectAction", params={"namespace","/user",
								    		                                                "actionName","show",
								    		                                                "username","${username}"})})
	public String execute(){
		if(username == null){
			return SUCCESS;
		}else{
			return "homepage";
		}
	}

	@Override
	public void setUser(String username) {
		this.username = username;
	}

	public String getUsername() {
		return username;
	}


	
	
}

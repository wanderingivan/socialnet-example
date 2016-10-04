package com.socialnet.interceptor;

import org.apache.log4j.Logger;
import org.springframework.security.core.context.SecurityContextHolder;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class AuthInterceptor extends AbstractInterceptor {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6165549166976305137L;
	private static final Logger logger = Logger.getLogger(AuthInterceptor.class);

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		if(invocation.getAction() instanceof AuthenticatedUserAware){
			if(logger.isDebugEnabled()){
				logger.debug("Auth Interceptor Intercepting action " + invocation.getAction().getClass().getSimpleName() + "\n Inserting user" + getUserFromSecurityContext());
			}
			((AuthenticatedUserAware) invocation.getAction()).setUser(getUserFromSecurityContext());
		}
		return invocation.invoke();
	}

	private String getUserFromSecurityContext(){
		
		String username=  SecurityContextHolder.getContext()
									       .getAuthentication()
									       .getName();
		if(username.equals("anonymousUser")){
			return null;
		}
		return username;
	}
}

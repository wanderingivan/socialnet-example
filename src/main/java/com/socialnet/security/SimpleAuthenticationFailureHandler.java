package com.socialnet.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

public class SimpleAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler{
	
	Logger logger = Logger.getLogger(getClass());

	

	public SimpleAuthenticationFailureHandler(String defaultFailureUrl) {
		super(defaultFailureUrl);
	}


	@Override
	public void onAuthenticationFailure(HttpServletRequest request,
				HttpServletResponse response, AuthenticationException exception) 
							throws ServletException,IOException{
		logger.error("Failed Authenticating user");
		logger.error("Request was: "+request);
		logger.error("Exception was: "+exception);
		super.onAuthenticationFailure(request, response, exception);
	}

}

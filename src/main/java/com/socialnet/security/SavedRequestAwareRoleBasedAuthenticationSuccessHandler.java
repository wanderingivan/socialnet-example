package com.socialnet.security;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

/**
 * An authentication success strategy that makes use 
 * of DefaultSavedRequest which may have been stored in the 
 * session by the ExceptionTranslationFilter.<br/>
 * If a usable DefaultSavedRequest is not found it will try to 
 * redirect to a welcome page based on the user's role.<br/>
 * If a welcome page cannot be resolved this way it will delegate to the base class. 
 * 
 *
 */
public class SavedRequestAwareRoleBasedAuthenticationSuccessHandler extends
		SimpleUrlAuthenticationSuccessHandler {
	
	private static final Logger logger = Logger.getLogger(SavedRequestAwareRoleBasedAuthenticationSuccessHandler.class);
	
	protected RequestCache requestCache = new HttpSessionRequestCache();	
	
	private Map<String,String> roleUrls;	
	
	
	
	
	public SavedRequestAwareRoleBasedAuthenticationSuccessHandler(Map<String, String> roleUrls,String defaultTargetUrl) {
		super(defaultTargetUrl);           //Set up back-up url in case url or role resolution fails.
		setAlwaysUseDefaultTargetUrl(true);
		this.roleUrls = roleUrls;
	}

	/**
	 * Tries to redirect to url from  a request in RequestCache 
	 * or based on user role.<br/>
	 * If a {@code SavedRequest} is not found sends a welcome page redirect based on a
	 * user's highest privilege role.<br/>
	 * If no welcome page is found for role falls back to 
	 * superclass handle method which redirects to defaultTargetUrl
	 * @see RequestCache
	 * @see SavedRequest
	 */
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request,
			HttpServletResponse response, Authentication authentication)
					throws IOException, ServletException {
		
		logger.info("Successfull auth from " + authentication);
		
		String targetUrl = getTargetUrlFromCache(request, response);
		if(targetUrl != null){
			if(logger.isDebugEnabled()){
				logger.debug("Redirecting to SavedRequest Url: " + targetUrl);
			}
			sendRedirect(request, response, targetUrl);
			return;
		}
			
		String role = resolveUserRole(authentication);
		targetUrl = roleUrls.get(role);
		if( targetUrl == null){
			logger.error("Returned Unmapped Role: " + role);
			super.handle(request, response, authentication);
			return;
		}
		
		sendRedirect(request, response, roleUrls.get(role) );

			
	}
	
	/**
	 * Sends a redirect to the target url and then  calls 
     * clearAuthenticationAttributes() to remove any leftover session data.
	 * @param request the request which caused the successful authentication
	 * @param response the response
 	 * @param url the url to redirect to
	 * @throws IOException
	 */
	protected void sendRedirect(HttpServletRequest request, HttpServletResponse response, String url) throws IOException{
		getRedirectStrategy().sendRedirect(request, response, url);
		clearAuthenticationAttributes(request);
    }
	
	
	/**
	 * Convenience method to extract redirect urls from saved requests in RequestCache
	 * @param request the request which caused the successful authentication
	 * @param response the response
	 * @return saved request redirect url from cache or null if cache is empty
	 */
	private String getTargetUrlFromCache(HttpServletRequest request,HttpServletResponse response){
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		if(savedRequest != null){
			return savedRequest.getRedirectUrl();
		}
		return null;
		
	}
	
	
	/**
	 * Resolves user role to use for redirects from an authentication token.<br/>
	 * ROLE_ADMIN has highest priority - will always be returned even if the user
	 * has other roles in the list<br/>
	 * ROLE_USER has lowest priority - will be returned only if there are no other
	 * priorities in a user authority list.
	 * @param authentication the Authentication object which was created during the authentication process.
	 * @return the role with highest privilege in the authentication
	 */
	private String resolveUserRole(Authentication authentication) {
		String role = null;
		for(GrantedAuthority ga : authentication.getAuthorities()){
			if(ga.getAuthority().equals("ROLE_ADMIN")){
				return "ROLE_ADMIN";
			}else if(!(ga.getAuthority().equals("ROLE_USER"))){
				role = ga.getAuthority();
			}
		}
		if(role != null){ return role;}
		else            { return "ROLE_USER";}
	}

	public void setRequestCache(RequestCache requestCache) {
		this.requestCache = requestCache;
	}
	
}

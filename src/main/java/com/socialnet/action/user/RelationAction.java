package com.socialnet.action.user;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.Result;

import com.socialnet.interceptor.AuthenticatedUserAware;

@InterceptorRefs({@InterceptorRef(value="authAwareStack")})
public class RelationAction extends AbstractUserAction implements AuthenticatedUserAware{

	
	
	/**
	 * 
	 */
	private static Logger logger  = Logger.getLogger(RelationAction.class);
	private static final long serialVersionUID = -5087106269387989464L;
	private String  receiver,
					authenticatedUser,
					message;

	@Action(value="friendRequest",results={@Result(name="success", type="json")})
	public String execute(){
		try{
	        if(logger.isInfoEnabled()){
	            logger.info("Sending friend request to user " + receiver+ " from " + authenticatedUser);
	        }
			service.sendFriendRequest(receiver,authenticatedUser);
			message = getText("global.friend_request_sent");
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught while sending friend request between " + receiver + " " + authenticatedUser + "\n" + e);
		}
		return ERROR;
	}
	
	@Action(value="removeFriend",results={@Result(name="success", type="json")})
	public String removeFriendShip(){
		try{
            if(logger.isInfoEnabled()){
                logger.info("Removing friendship for " + receiver + " " + authenticatedUser);
            }
			service.removeFriendship(receiver,authenticatedUser);
			message = getText("global.removed_friendship");
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught while removing friendship between " + receiver + " " + authenticatedUser + "\n" + e);
		}
		return ERROR;
	
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	@Override
	public void setUser(String username) {
		this.authenticatedUser = username;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
}

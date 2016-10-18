package com.socialnet.action.user;

import com.socialnet.interceptor.AuthenticatedUserAware;
import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.Result;

@InterceptorRefs({@InterceptorRef(value="authAwareStack")})
public class FriendRequestAction extends AbstractUserAction implements
		AuthenticatedUserAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1972038986695586592L;
	private static Logger logger  = Logger.getLogger(RelationAction.class);
	private String user,
				   message;
	private long friendRequestId;

	@Action(value="acceptFriendRequest",results={@Result(name="success", type="json")})
	public String addFriend(){
		try{
	        if(logger.isInfoEnabled()){
	            logger.info(String.format("User %s accepting friend request %d",user,friendRequestId ));
	        }
			service.acceptFriendRequest(friendRequestId);
			message = getText("global.friend_request_accepted");
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught while accepting friend request " +friendRequestId+"\n" + e);
		}
		return ERROR;
	}
	
	@Action(value="denyFriendRequest",results={@Result(name="success",type="json")})
	public String execute(){
		try{
	        if(logger.isInfoEnabled()){
	            logger.info(String.format("User %s denying friend request %d",user,friendRequestId ));
	        }
			service.denyFriendRequest(friendRequestId);
			message = getText("global.friend_request_denied");
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught while denying friend request " +friendRequestId+"\n" + e);
		}
		return ERROR;
	}
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public long getFriendRequestId() {
		return friendRequestId;
	}

	public void setFriendRequestId(long friendRequestId) {
		this.friendRequestId = friendRequestId;
	}

	@Override
	public void setUser(String username) {
		this.user = username;
	}
}

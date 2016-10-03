package com.socialnet.action.user;

import java.util.List;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import com.socialnet.interceptor.AuthenticatedUserAware;
import com.socialnet.model.FriendRequest;

@InterceptorRefs(value={@InterceptorRef(value="authAwareStack")})
public class RetrieveFriendRequestsAction extends AbstractUserAction implements
		AuthenticatedUserAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = -78175587242302633L;

	private static final Logger logger =Logger.getLogger(RetrieveFriendRequestsAction.class);
	
	private List<FriendRequest> friendRequests;
	private String username;

	@Action(value="friend-requests",results={@Result(name="success",location="/WEB-INF/content/jsp/user/friendRequests.jsp")})
	public String execute(){
		try{
			friendRequests = service.getFriendRequests(username);
			if(logger.isDebugEnabled()){
				logger.debug("Friend Requests " + friendRequests);
			}
			return SUCCESS;
		}catch(Exception e){
			logger.error("Error getting friend requests for " + username);
		}
		return ERROR;
	}
	
	@Override
	public void setUser(String username) {
		this.username= username;
	}

	public List<FriendRequest> getFriendRequests() {
		return friendRequests;
	}

	public void setFriendRequests(List<FriendRequest> friendRequests) {
		this.friendRequests = friendRequests;
	}

	
}

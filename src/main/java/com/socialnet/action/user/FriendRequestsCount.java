package com.socialnet.action.user;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.Result;

import com.socialnet.interceptor.AuthenticatedUserAware;

@InterceptorRefs(value={@InterceptorRef(value="authAwareStack")})
public class FriendRequestsCount extends AbstractUserAction implements
		AuthenticatedUserAware {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5530939624346734141L;

	private static final Logger logger =Logger.getLogger(FriendRequestsCount.class);
	
	private String result,
				   username;
	private long count;

	@Action(value="friendrequest-count",results={@Result(name="success",type="json")})
	public String execute(){
        if(logger.isTraceEnabled()){
            logger.trace("Getting friend request count for " + username);
        }
		try{
			count = service.countFriendRequests(username);
			if(count == 1){
				result = getText("global.friend_request");
			}else if(count > 1){
				result = getText("global.friend_requests");
			}else{
				result = getText("global.no_friend_requests");
			}
			return SUCCESS;
			
		}catch(Exception e){
			logger.error("Error getting friend request count for " + username);
		}
		return ERROR;
	}
	
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	@Override
	public void setUser(String username) {
		this.username = username;
	}

	public long getCount() {
		return count;
	}

	public void setCount(long count) {
		this.count = count;
	}

	
}

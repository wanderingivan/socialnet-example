package com.socialnet.action.message;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

public class LikeAction extends AbstractMessageAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4314779756874305623L;
	private static final Logger logger = Logger.getLogger(LikeAction.class);			
	
	private String username;
	private long postId;
	
	@Action(value="like",results={@Result(name="success",type="json")})
	public String execute(){
		try{
	        if(logger.isInfoEnabled()){
	            logger.info("Adding like to post " + postId + " by "+username);
	        }
			service.addLike(username, postId);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught adding like to post " + postId +"\n" +e);
		}
		return ERROR;
	}

	public long getPostId() {
		return postId;
	}

	public void setPostId(long postId) {
		this.postId = postId;
	}
	
}

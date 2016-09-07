package com.socialnet.action.message;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

public class AddWallPostMessageAction extends AbstractMessageAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3309742894234686057L;
	private static final Logger logger = Logger.getLogger(WallPostAction.class);			

	
	private String message;
	private long postId;
	private String[] result;
	
	@Action(value="post-reply",results={@Result(name="success", type="json")})
	public String execute(){
		try{
			logger.trace("Adding WallPost Message");
			logger.debug(String.format("PostOptions sender:%s postId:%d message:%s",username,postId,message));
			result = service.postWallMessage(username,postId,message);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught adding wall message to post " + postId + "\n"+ e);
		}
		return ERROR;
	}
	
	public long getPostId() {
		return postId;
	}

	public void setPostId(long postId) {
		this.postId = postId;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String [] getResult() {
		return result;
	}


	
}

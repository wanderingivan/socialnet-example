package com.socialnet.action.message;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

public class DeleteWallPostAction extends AbstractMessageAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6604200298750094449L;
	private static final Logger logger = Logger.getLogger(DeleteWallPostAction.class);
	public long postId;
	
	@Action(value="deletePost",results={@Result(name="success", type="redirectAction",params={"namespace","/","actionName","index"})})
	public String execute(){
		logger.info(String.format("User %s deleting wall post %d",username,postId));
		try{
			service.deleteWallPost(postId);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Error deleting wall post " + postId);
			logger.error(e);
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

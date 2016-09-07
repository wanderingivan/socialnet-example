package com.socialnet.action.message;

import java.util.List;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

public class WallPostAjaxAction extends AbstractMessageAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1918322283517533948L;
	private static final Logger logger = Logger.getLogger(WallPostAjaxAction.class);

	
	private List<String[]> result;
	private long postId,
	             userId;
	private int index;
	
	@Action(value="loadComments",results={@Result(name="success", type="json")})
	public String execute(){
		logger.debug(String.format("Loading comments for post %d index %d",postId,index));
		try{
			result = service.loadComments(postId,index);

			return SUCCESS;
		}catch(Exception e){
			logger.error("Error retrieving messages for post " + postId);
		}
		return ERROR;
	}
	

	public long getPostId() {
		return postId;
	}

	public void setPostId(long postId) {
		this.postId = postId;
	}

	
	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public List<String[]> getResult() {
		return result;
	}
	
}

package com.socialnet.action.message;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.socialnet.model.WallPost;
import com.opensymphony.xwork2.ModelDriven;

public class LoadWallPostAction extends AbstractMessageAction implements ModelDriven<WallPost> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2135570447391262316L;
	private static final Logger logger = Logger.getLogger(LoadWallPostAction.class);

	private WallPost wallPost;
	
	private long userId;
	private int index;
	
	@Action(value="loadPost", results={@Result(name="success", location="/WEB-INF/content/jsp/user/wallPost.jsp")})
	public String execute(){
		logger.debug(String.format("Loading wallPost for user %d index %d",userId,index));
		try{
			wallPost = service.loadWallPost(userId,index);
			logger.info("Result " + wallPost);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Error retrieving messages for user " + userId);
		}
		return ERROR;
	}

	public WallPost getWallPost() {
		return wallPost;
	}

	public void setWallPost(WallPost wallPost) {
		this.wallPost = wallPost;
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

	@Override
	public WallPost getModel() {
		return getWallPost();
	}
	
	
	
}

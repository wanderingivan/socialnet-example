package com.socialnet.action.message;

import java.util.List;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.socialnet.model.WallPost;

public class WallPostLookupAction extends AbstractMessageAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3779121429969184869L;
	private static final Logger logger = Logger.getLogger(WallPostLookupAction.class);

	private String username;
	private long postId;
	
	private WallPost post;
	private List<WallPost> posts;
	
	@Action(value="wall", results={@Result(name="success",type="json")})
	public String execute(){
		try{
			logger.trace("Loading wall for user "+username );
			posts = service.getWallPostsForUser(username);
			logger.debug("Result " + posts);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught " + e);
		}
		return ERROR;
	}
	
	@Action(value="post", results={@Result(name="success",type="json")})
	public String loadPost(){
		try{
			logger.trace("Loading post with id " + postId );
			post = service.getWallPost(postId);
			logger.debug("Result " + post);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught " + e);
		}
		return ERROR;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public long getPostId() {
		return postId;
	}

	public void setPostId(long postId) {
		this.postId = postId;
	}

	public WallPost getPost() {
		return post;
	}

	public void setPost(WallPost post) {
		this.post = post;
	}

	public List<WallPost> getPosts() {
		return posts;
	}

	public void setPosts(List<WallPost> posts) {
		this.posts = posts;
	}
	
}

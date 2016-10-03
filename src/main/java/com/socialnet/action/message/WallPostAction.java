package com.socialnet.action.message;

import java.io.File;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;


import com.socialnet.service.ImageService;


public class WallPostAction extends AbstractMessageAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3146822348011000582L;
	private static final Logger logger = Logger.getLogger(WallPostAction.class);			

	private ImageService imageService;
	
	private File postImage;
	
	private String message,
				   owner,
				   postImageContentType,
				   postImageFileName;
	

	@Action(value="create",results={@Result(name="success", type="redirectAction", params={"actionName","show","namespace","/user","username","${owner}"})})
	public String execute(){
			String path = null;
		try{
			if(logger.isDebugEnabled()){
				logger.debug(String.format("WallPost options sender: %s owner: %s message %s",username,owner,message));
			}
			if(postImage != null){
				path = imageService.saveImage(postImage, postImageContentType, postImageFileName);
				
			}
			service.createWallPost(username,owner,message,path);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught creating wall message"+ e);
			System.out.println("Cause" + e.getCause());
			e.printStackTrace();
		}
		return ERROR;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public File getPostImage() {
		return postImage;
	}


	public void setPostImage(File postImage) {
		this.postImage = postImage;
	}


	public String getPostImageContentType() {
		return postImageContentType;
	}


	public void setPostImageContentType(String postImageContentType) {
		this.postImageContentType = postImageContentType;
	}


	public String getPostImageFileName() {
		return postImageFileName;
	}


	public void setPostImageFileName(String postImageFileName) {
		this.postImageFileName = postImageFileName;
	}


	@Autowired
	public void setImageService(ImageService imageService) {
		this.imageService = imageService;
	}
	
	
	
}

package com.socialnet.action.user;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.socialnet.service.ImageService;

public class DeleteImageAction extends AbstractUserAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2877832880177218343L;
	private static final Logger logger = Logger.getLogger(DeleteImageAction.class);

	private long imageId;
	private ImageService imageService;
	
	@Action(value="removeImage",results={@Result(type="redirectAction",params={"actionName","gallery"})})
	public String execute(){
		try{
		    String path = service.removeImage(imageId);
		    imageService.removeImage(path);
			return SUCCESS;
		}catch(Exception e){
			
			logger.error("Error deleting image with id "+ imageId + "\n" + e);
		}
		return ERROR;
		
	}

	public long getImageId() {
		return imageId;
	}

	public void setImageId(long imageId) {
		this.imageId = imageId;
	}
	
	@Autowired
	public void setImageService(ImageService imageService) {
		this.imageService = imageService;
	}
}

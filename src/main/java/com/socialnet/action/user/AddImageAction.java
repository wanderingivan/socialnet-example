package com.socialnet.action.user;

import java.io.File;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.socialnet.interceptor.AuthenticatedUserAware;
import com.socialnet.service.ImageService;


@InterceptorRefs({@InterceptorRef(value="authAwareStack")})
public class AddImageAction extends AbstractUserAction implements AuthenticatedUserAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = -166157700331744750L;
	private static final Logger logger = Logger.getLogger(AddImageAction.class);
	
	private File image;
	private String imageFileName,
				   imageContentType,
				   description,
	               username;

	private ImageService imageService;
	
	@Action(value="addImage", results={@Result(name="success",type="redirectAction", params={"actionName","gallery"})})
	public String execute(){
		try{

			logger.trace("Uploading image " + image);
			logger.debug("Saving for username " + username);
			String fileName = imageService.saveImage(image, imageContentType, imageFileName);
			service.addToUserGallery(fileName,description,username);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught uploading file " + e);
			e.printStackTrace();
		}
		return ERROR;
	}


	public File getImage() {
		return image;
	}

	public void setImage(File image) {
		this.image = image;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getImageContentType() {
		return imageContentType;
	}

	public void setImageContentType(String imageContentType) {
		this.imageContentType = imageContentType;
	}

	public String getDescription() {
		return description;
	}

	//@StringLengthFieldValidator(maxLength="500",message="Description can not be longer than ${maxLength} characters",fieldName="description")
	public void setDescription(String description) {
		this.description = description;
	}

	public ImageService getImageService() {
		return imageService;
	}

	@Autowired
	public void setImageService(ImageService imageService) {
		this.imageService = imageService;
	}


	@Override
	public void setUser(String username) {
		this.username = username;
	}
	
}

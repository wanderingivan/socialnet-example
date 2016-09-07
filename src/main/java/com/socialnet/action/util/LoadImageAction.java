package com.socialnet.action.util;


import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.beans.factory.annotation.Autowired;

import com.socialnet.service.ImageService;


@ParentPackage("util")
public class LoadImageAction implements ServletRequestAware{

	@Autowired
	private ImageService service;
	
	String path;
	
	private HttpServletRequest servletRequest;

	
	@Action(value="loadImage",results={@Result(name="ImageResult", type="imageBytesResult",params={"contentType","${imageContentType}",
																									"contentDisposition","${imageContentDisposition}"})})
	public String execute(){
		return "ImageResult";
	}

	public byte[] getImageInBytes() {
		return service.loadImage(path);
	}
	
	public String getImageContentType(){
		return "image/jpg";
	}
	
	public String getImageContentDisposition() {
		return "anyname.jpg";
	}


	@Override
	public void setServletRequest(HttpServletRequest arg0) {
		this.servletRequest = arg0;
	}
	
	public HttpServletRequest getServletRequest() {
		return servletRequest;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String imagePath) {
		this.path = imagePath;
	}

	public void setService(ImageService service) {
		this.service = service;
	}
}
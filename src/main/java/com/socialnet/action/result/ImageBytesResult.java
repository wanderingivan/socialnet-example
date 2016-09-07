package com.socialnet.action.result;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.Result;

import com.socialnet.action.util.LoadImageAction;

public class ImageBytesResult implements Result {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6956487193438831420L;
	
	public static final String DEFAULT_PARAM = null;

	@Override
	public void execute(ActionInvocation invocation) throws Exception {
		LoadImageAction action = (LoadImageAction) invocation.getAction();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(action.getImageContentType());
		
		response.getOutputStream().write(action.getImageInBytes());
		response.getOutputStream().flush();
	}

}
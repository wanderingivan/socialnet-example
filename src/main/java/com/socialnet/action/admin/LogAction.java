package com.socialnet.action.admin;

import java.util.List;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;

import com.socialnet.service.LogService;
import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("admin")
public class LogAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7057350732356171751L;
	private static final Logger logger = Logger.getLogger(LogAction.class);

	
	private String logFile;
	private List<String> logContents;
	
	private LogService service;
	
	
	@Action(value="logAction",results={@Result(name="success",location="/WEB-INF/content/jsp/admin/log.jsp")})
	public String execute(){
		try{
			logger.debug("Retrieving Log " + logFile);
			logContents = service.getLog(logFile);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught when retrieving log\n: " + e );
		}
		return ERROR;
	}

	public String getLogFile() {
		return logFile;
	}

	public void setLogFile(String logFileName) {
		this.logFile = logFileName;
	}

	public List<String> getLogContents() {
		return logContents;
	}

	public void setLogContents(List<String> logContents) {
		this.logContents = logContents;
	}

	@Autowired
	public void setService(LogService service) {
		this.service = service;
	}
	
	
	
}

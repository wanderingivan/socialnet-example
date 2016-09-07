package com.socialnet.action.admin;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.socialnet.interceptor.AuthenticatedUserAware;
import com.socialnet.model.Task;
import com.socialnet.service.MessageService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@ParentPackage("admin")
@InterceptorRefs(value={@InterceptorRef(value="authAwareStack")})
public class TasksAction extends ActionSupport implements
														  AuthenticatedUserAware, ModelDriven<Task> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4412691530351645973L;

	private static final Logger logger = Logger.getLogger(RetrieveTasksAction.class);
	
	private Task task = new Task();
	private String assigned,
				     comment,
				     username;
	private MessageService service;
	
	@Action(value="addTask",results={@Result(name="",type="redirectAction",params={"actionName","welcome"})})
	public String addTask(){
		try{
			service.addTask(task,username,assigned);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught adding task");
			logger.error(e);
		}
		return ERROR;
	}
	
	@Action(value="completeTask",results={@Result(name="",type="redirectAction",params={"actionName","welcome"})})
	public String completeTask(){
		try{
			service.completeTask(task.getId(),comment);
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught completing task");
			logger.error(e);
		}
		return ERROR;
	}
	
	@Action(value="removeTask",results={@Result(name="",type="redirectAction",params={"actionName","welcome"})})
	public String removeTask(){
		try{
			service.removeTask(task.getId());
			return SUCCESS;
		}catch(Exception e){
			logger.error("Exception caught removing task");
			logger.error(e);
		}
		return ERROR;
	}
	
	public String getAssigned() {
		return assigned;
	}

	public void setAssigned(String assigned) {
		this.assigned = assigned;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	@Override
	public Task getModel() {
		return task;
	}

	@Autowired
	public void setService(MessageService service) {
		this.service = service;
	}

	@Override
	public void setUser(String username) {
		this.username = username;
	}

}

package com.socialnet.action.admin;

import java.lang.management.ManagementFactory;
import java.lang.management.OperatingSystemMXBean;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("admin")
public class SysInfoAction extends ActionSupport{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4856662245815418967L;
	private static final Logger logger = Logger.getLogger(SysInfoAction.class);
	private double loadAverage;
	private String uptime;
	
	@Action(value="sysload",results={@Result(name="success",type="json")})
	public String loadAverage(){
		try{
			
			OperatingSystemMXBean opBean = ManagementFactory.getOperatingSystemMXBean();
			loadAverage = (opBean.getSystemLoadAverage()/opBean.getAvailableProcessors()) * 100;
			return SUCCESS;
		}catch(Exception e){
			logger.error("Error executing SysInfoAction");
			logger.error(e);
		}
		return ERROR;
	}
	
	@Action(value="uptime",results={@Result(name="success",type="json")})
	public String uptime(){
		try{
			uptime = getDurationBreakdown(ManagementFactory.getRuntimeMXBean().getUptime());
			return SUCCESS;
		}catch(Exception e){
			logger.error("Error executing SysInfoAction");
			logger.error(e);
		}
		return ERROR;
	}
	
	/**
     * Convert a millisecond duration to a string format
     * 
     * @param millis A duration to convert to a string form
     * @return A string of the form "X Days Y Hours Z Minutes A Seconds".
     */
    private String getDurationBreakdown(long millis){
    	
        if(millis < 0){
        	throw new IllegalArgumentException("Duration must be greater than zero!");
        }

        long days = TimeUnit.MILLISECONDS.toDays(millis);
        millis -= TimeUnit.DAYS.toMillis(days);
        long hours = TimeUnit.MILLISECONDS.toHours(millis);
        millis -= TimeUnit.HOURS.toMillis(hours);
        long minutes = TimeUnit.MILLISECONDS.toMinutes(millis);
        millis -= TimeUnit.MINUTES.toMillis(minutes);
        long seconds = TimeUnit.MILLISECONDS.toSeconds(millis);

        StringBuilder sb = new StringBuilder(64);
        sb.append(days);
        sb.append(" Days ");
        sb.append(hours);
        sb.append(" Hours ");
        sb.append(minutes);
        sb.append(" Minutes ");
        sb.append(seconds);
        sb.append(" Seconds");

        return(sb.toString());
    }
	
	public double getLoadAverage() {
		return loadAverage;
	}

	public void setLoadAverage(double loadAverage) {
		this.loadAverage = loadAverage;
	}

	public String getUptime() {
		return uptime;
	}

	public void setUptime(String uptime) {
		this.uptime = uptime;
	}
	
}

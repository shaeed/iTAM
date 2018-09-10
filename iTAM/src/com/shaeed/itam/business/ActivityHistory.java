package com.shaeed.itam.business;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.shaeed.itam.beans.Activity;
import com.shaeed.itam.db.Database;

public class ActivityHistory implements SessionAware{
	int type;
	int start;
	int end;
	List<Activity> acts;
	String message;

	//Session object
	private Map<String, Object> session;
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public String execute() {
		if(getOldActivities()) {
			//Success
			message = "success s";
			return "success";
		}
		message = "error f";
		return "success";
	}

	boolean getOldActivities() {
		Database db = new DbFromSession().getDbConnection(session);
		acts = db.getOldActivities(type, start, end);
		if(acts == null) {
			//Database read error
			return false;
		}
		
		//Fill the name and color info
		new TamCommonFunctions(session).fillDetails(acts);
		
		return true;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public List<Activity> getActs() {
		return acts;
	}

	public void setActs(List<Activity> acts) {
		this.acts = acts;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
}

package com.shaeed.itam.business;

import java.util.Date;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.shaeed.itam.db.Database;
import com.shaeed.itam.db.DateHelper;

public class SaveActivity implements SessionAware {
	public String column;
	public int sno;
	public String data;
	public String message;

	//Session object
	private Map<String, Object> session;
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public String execute() {  
		if(saveActivity()) {
			message = "Saved";
			return "success";
		} else {
			if(message == null) {
				message = "Database error.";
				return "error";
			}
		}

		return "error";
	}

	boolean saveActivity() {
		//Get database connection
		Database db = (Database)session.get("dbconnection");
		if(db == null) {
			//Session expired
			message = "Session expired. Please start again ...";
			return false;
		}

		//Store the data
		return db.updateActivity(sno, column, data);
	}
	
	public String completedButton(){
		//String endDate = new DateHelper().decodeDate(new Date());
		//Save the received column info
		saveActivity();
		//Save the end date
		column = "enddate";
		data = new DateHelper().decodeDate(new Date());
		if(saveActivity()) {
			message = "Saved";
		} else {
			message="Not able to save. Try again.";
			return "error";
		}
		return "success";
	}

	public String getColumn() {
		return column;
	}

	public void setColumn(String column) {
		this.column = column;
	}

	public int getSno() {
		return sno;
	}

	public void setSno(int sno) {
		this.sno = sno;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}	
}

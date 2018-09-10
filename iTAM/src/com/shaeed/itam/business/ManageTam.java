package com.shaeed.itam.business;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.shaeed.itam.beans.Tam;
import com.shaeed.itam.db.Database;

public class ManageTam implements SessionAware {
	public String column;
	public String data;
	public String tamId;
	public String message;

	//Session object
	private Map<String, Object> session;
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	
	/*
	 * Method to update the TAM details.
	 */
	public String update() {
		message = null;
		if(updateTam()) {
			message = "Saved";
			return "success";
		} else {
			if(message == null) {
				message = "Database error.";
				return "error";
			}
		}

		return "error";
	}//End update
	
	public String deactivate() {
		message = null;
		if(deactivateTam()) {
			message = "Tam deactivated. To re-activate, contact iTAM admin.";
			return "success";
		} else {
			if(message == null) {
				message = "Database error.";
				return "error";
			}
		}

		return "error";
	}//End deactivate

	boolean updateTam() {
		//Get database connection
		Database db = (Database)session.get("dbconnection");
		if(db == null) {
			//Session expired
			message = "Session expired. Please start again ...";
			return false;
		}

		//Store the data
		return db.updateTam(tamId, column, data);
	}//End updateAttendee
	
	boolean deactivateTam() {
		//Get database connection
		Database db = (Database)session.get("dbconnection");
		if(db == null) {
			//Session expired
			message = "Session expired. Please start again ...";
			return false;
		}

		//Store the data
		return db.updateTam(tamId, "available", "0");
	}//End updateAttendee
	
	/*
	 * Return Tam details in Tam object
	 */
	protected Tam getTam(String tamId) {
		//Get database connection
		Database db = (Database)session.get("dbconnection");
		if(db == null) {
			//Session expired
			message = "Session expired. Please start again ...";
			return null;
		}

		//Store the data
		return db.getTam(tamId);
	}

	public String getColumn() {
		return column;
	}

	public void setColumn(String column) {
		this.column = column;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getTamId() {
		return tamId;
	}

	public void setTamId(String tamId) {
		this.tamId = tamId;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}


}

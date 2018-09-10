package com.shaeed.itam.business;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.shaeed.itam.beans.Attendee;
import com.shaeed.itam.beans.Tam;
import com.shaeed.itam.db.Database;

public class ManageAttendee implements SessionAware{
	String column;
	String eid;
	String data;
	String message;
	String tamId;
	List<Attendee> atnds;
	Tam tam;

	//Session object
	private Map<String, Object> session;
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public String update() {
		if(updateAttendee()) {
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
	
	public String delete() {
		if(deleteAttendee()) {
			message = "Attendee deleted.";
			return "success";
		}
		else {
			message = "Database error.";
			return "error";
		}		
	}//End delete
	
	public String display() {
		DataFromSession dfs = new DataFromSession(session);
		dfs.removeAttendees();
		//Set TAM id
		dfs.setTamIdSession(tamId);
		atnds = dfs.getAttendees();
		if(atnds.size() == 0)
			atnds = null;
		
		//Get TAM details
		ManageTam mt = new ManageTam();
		mt.setSession(session);
		tam = mt.getTam(tamId);
		
		if(atnds == null && tam == null)
			return "error";
		return "success";
	}//End display
	
	boolean deleteAttendee() {
		Database db = new DbFromSession().getDbConnection(session);
		if(tamId != null)
			db.setTamId(tamId);
		
		return db.deleteAttendee(eid);
	}

	boolean updateAttendee() {
		//Get database connection
		Database db = (Database)session.get("dbconnection");
		if(db == null) {
			//Session expired
			message = "Session expired. Please start again ...";
			return false;
		}

		//Store the data
		return db.updateAttendee(eid, column, data);
	}//End updateAttendee

	public String getColumn() {
		return column;
	}

	public void setColumn(String column) {
		this.column = column;
	}

	public String getEid() {
		return eid;
	}

	public void setEid(String eid) {
		this.eid = eid;
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

	public String getTamId() {
		return tamId;
	}

	public void setTamId(String tamId) {
		this.tamId = tamId;
	}

	public List<Attendee> getAtnds() {
		return atnds;
	}

	public void setAtnds(List<Attendee> atnds) {
		this.atnds = atnds;
	}

	public Tam getTam() {
		return tam;
	}

	public void setTam(Tam tam) {
		this.tam = tam;
	}
	
}

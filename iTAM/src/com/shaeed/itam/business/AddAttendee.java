package com.shaeed.itam.business;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.shaeed.itam.beans.Attendee;
import com.shaeed.itam.db.Database;

public class AddAttendee implements SessionAware {
	String eid;
	String first;
	String last;
	String email;
	String tamId;
	String message;

	//Session object
	private Map<String, Object> session;
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public String execute() {
		if(eid != null) {
			if(addAttendee()) {
				message = "Addition success.";
				return "success";
			} else {
				message = "Addition failed.";
				return "error";
			}
		}
		message = "null eid received for AddAttendee class.";
		return "error";
	}

	boolean addAttendee() {
		//Prepare Attendee object
		Attendee at = new Attendee();
		at.eid = eid;
		at.email = email;
		at.first = first;
		at.last = last;

		//DB object
		Database db = new DbFromSession().getDbConnection(session);
		if(tamId != null)
			db.setTamId(tamId);

		return db.addAttendee(at);
	} //End addAttendee

	public String getEid() {
		return eid;
	}

	public void setEid(String eid) {
		this.eid = eid;
	}

	public String getFirst() {
		return first;
	}

	public void setFirst(String first) {
		this.first = first;
	}

	public String getLast() {
		return last;
	}

	public void setLast(String last) {
		this.last = last;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

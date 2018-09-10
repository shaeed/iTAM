package com.shaeed.itam.business;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.shaeed.itam.beans.Tam;
import com.shaeed.itam.db.Database;

public class AddTam implements SessionAware {
	String tamId;
	String team;
	String admin;
	String responsible;
	String tamTime;
	String theme;
	int type;
	String message;

	//Session object
	private Map<String, Object> session;
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public String execute() {
		boolean at = addTam();
		boolean ct = createTables();
		if(!(ct && at)) {
			//Table creation failed.
			message = "Table creation failed!";
			return "error";
		}
		return "success";
	}

	boolean addTam() {
		//Prepare the Tam object
		Tam tam = new Tam();
		tam.id = tamId;
		tam.admin = admin;
		tam.available = true;
		tam.responsible = responsible;
		tam.team = team;
		tam.tamTime = tamTime;
		tam.type = type;
		tam.theme = theme;
		
		//Insert tam details in Database
		Database db = new DbFromSession().getDbConnection(session);
		return db.addTam(tam);
	}
	
	boolean createTables() {
		DbFromSession dbfromsession = new DbFromSession();
		Database db = dbfromsession.getDbConnection(session);
		boolean res = db.createTables(tamId);
		db.closeConnection();
		dbfromsession.removeDbConnection(session);
		
		return res;
	} // End createTables

	
	public String getTamId() {
		return tamId;
	}

	public void setTamId(String tamId) {
		this.tamId = tamId;
	}

	public String getTeam() {
		return team;
	}

	public void setTeam(String team) {
		this.team = team;
	}

	public String getAdmin() {
		return admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}

	public String getResponsible() {
		return responsible;
	}

	public void setResponsible(String responsible) {
		this.responsible = responsible;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getTamTime() {
		return tamTime;
	}

	public void setTamTime(String tamTime) {
		this.tamTime = tamTime;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}
	
}

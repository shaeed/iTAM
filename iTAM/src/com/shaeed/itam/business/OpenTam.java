package com.shaeed.itam.business;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.shaeed.itam.beans.Activity;
import com.shaeed.itam.db.Database;

public class OpenTam implements SessionAware {
	public String tamId;
	public String team;
	public String admin;
	public String responsible;
	public String tamTime;
	public String theme;
	public Date todayDate;
	List<Activity> task;
	List<Activity> keyactivity;
	List<Activity> impidea;
	List<Activity> addon;
	List<Activity> info;
	String message;

	//Session object
	private Map<String, Object> session;
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public String execute() {

		if(team == null || responsible == null) {
			//Not from tams.jsp page
			//Check Session for tamId
			DataFromSession dfs = new DataFromSession(session);
			tamId = dfs.getTamIdSession();
			responsible = dfs.getResponsibleSession();
			team =  dfs.getTeamSession();
			tamTime = dfs.getTamTimeSession();
			theme = dfs.getThemeSession();

			if(tamId == null) {
				//Session don't have data
				message = "Session expired. Please go to home page.";
				return new ThemeSelector(session).error();
			}
		} else {
			//Save the data in session
			DataFromSession dfs = new DataFromSession(session);
			dfs.setTamIdSession(tamId);
			dfs.setResponsibleSession(responsible);
			dfs.setTeamSession(team);
			dfs.setTamTimeSession(tamTime);
			dfs.setThemeSession(theme);
		}

		if(!getAllActivity()) {
			message = "Database error!";
			return new ThemeSelector(session).error();
		}

		//Get todays date
		todayDate = new Date();

		return new ThemeSelector(session).success();
	}

	boolean getAllActivity() {
		//Get database connection
		Database db = getDataBaseConnection();

		List<Activity> acts = db.getAllActivities();
		if(acts == null) {
			//Database read error
			return false;
		}

		//Create Attendee list
		new DataFromSession(session).getAttendees();

		//Fill the color and Responsible
		new TamCommonFunctions(session).fillDetails(acts);

		//Populate the lists
		Iterator<Activity> it = acts.iterator();
		Activity ac;
		keyactivity = new ArrayList<Activity>();
		impidea = new ArrayList<Activity>();
		addon = new ArrayList<Activity>();
		task = new ArrayList<Activity>();
		info = new ArrayList<Activity>();

		while(it.hasNext()) {
			ac = it.next();
			switch (ac.type) {
			case 1:
				keyactivity.add(ac);
				break;
			case 2:
				impidea.add(ac);
				break;
			case 3:
				addon.add(ac);
				break;
			case 4:
				task.add(ac);
				break;
			case 5:
				info.add(ac);
				break;

			default:
				System.out.println("Error in getAllActivity.");
				break;
			}//End switch
		}//End while
		
		//Check for empty list
		if(keyactivity.isEmpty()) {
			keyactivity = null;
		}
		if(impidea.isEmpty()) {
			impidea = null;
		}
		if(addon.isEmpty()) {
			addon = null;
		}
		if(task.isEmpty()) {
			task = null;
		}
		if(info.isEmpty()) {
			info = null;
		}

		return true;
	}//End  getAllActivity

	//Get the database connection
	Database getDataBaseConnection() {
		Database db;
		db = new DbFromSession().getDbConnection(session);

		if(tamId != null)
			db.setTamId(tamId);

		return db;
	} //End getDataBaseConnection

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

	public Date getTodayDate() {
		return todayDate;
	}

	public void setTodayDate(Date todayDate) {
		this.todayDate = todayDate;
	}

	public List<Activity> getTask() {
		return task;
	}

	public void setTask(List<Activity> task) {
		this.task = task;
	}

	public List<Activity> getKeyactivity() {
		return keyactivity;
	}

	public void setKeyactivity(List<Activity> keyactivity) {
		this.keyactivity = keyactivity;
	}

	public List<Activity> getImpidea() {
		return impidea;
	}

	public void setImpidea(List<Activity> impidea) {
		this.impidea = impidea;
	}

	public List<Activity> getAddon() {
		return addon;
	}

	public void setAddon(List<Activity> addon) {
		this.addon = addon;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public List<Activity> getInfo() {
		return info;
	}

	public void setInfo(List<Activity> info) {
		this.info = info;
	}

	public String getTamTime() {
		return tamTime;
	}

	public void setTamTime(String tamTime) {
		this.tamTime = tamTime;
	}

	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}
}

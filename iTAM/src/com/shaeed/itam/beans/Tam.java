package com.shaeed.itam.beans;

/**
 * This class will hold the details of TAM.
 * @author shaeed
 *
 */
public class Tam {
	public String id;
	public String team;
	public String admin;
	public String responsible;
	public String tamTime;
	public int type;
	public String theme;
	public boolean available;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public boolean isAvailable() {
		return available;
	}
	public void setAvailable(boolean available) {
		this.available = available;
	}
	public String getTheme() {
		return theme;
	}
	public void setTheme(String theme) {
		this.theme = theme;
	}
	
}

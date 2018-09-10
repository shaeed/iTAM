package com.shaeed.itam.beans;

public class Activity {
	public int sno;
	public String activity;
	public String eid;
	public String responsible; //First name
	/*
	 * -----------| KeyAct------|---Task------
	 * Start date -  On which   | Target date
	 *              act started |
	 * End Date   - Finish Date | Finish date
	 * Create Dt  - Create dt   | Create date
	 */
	public String startDate;
	public String endDate;
	public String createDate; //Activity creation date
	public int type; //1- Key activity, 2- Improvement idea, 3- AndOn, 4- Task, 5- Information
	public boolean completed;
	public String mis;
	public String activityType;
	public String color;
	
	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
	}
	public String getActivity() {
		return activity;
	}
	public void setActivity(String activity) {
		this.activity = activity;
	}
	public String getEid() {
		return eid;
	}
	public void setEid(String eid) {
		this.eid = eid;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public boolean isCompleted() {
		return completed;
	}
	public void setCompleted(boolean completed) {
		this.completed = completed;
	}
	public String getMis() {
		return mis;
	}
	public void setMis(String mis) {
		this.mis = mis;
	}
	public String getActivityType() {
		return activityType;
	}
	public void setActivityType(String activityType) {
		this.activityType = activityType;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getResponsible() {
		return responsible;
	}
	public void setResponsible(String responsible) {
		this.responsible = responsible;
	}
	
	
}

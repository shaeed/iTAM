package com.shaeed.itam.business;

import java.util.Date;
import java.util.Iterator;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.shaeed.itam.beans.Activity;
import com.shaeed.itam.beans.Attendee;
import com.shaeed.itam.db.Database;
import com.shaeed.itam.db.DateHelper;

public class AddActivity implements SessionAware {
	public int sno;
	public String activity;
	public String responsible;
	public String startDate;
	public String endDate;
	public String createDate; //Activity creation date
	public int type; //1- Key activity, 2- Improvement idea, 3- AndOn, 4- Task
	public boolean completed;
	public String mis;
	public String activityType;
	public String message;

	//Session object
	private Map<String, Object> session;
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public String execute() {
		if(addActivity()) {
			switch(type) {
			case 1:
				return "openTamKey";

			case 2:
				return "openTamImpr";

			case 3:
				return "openTamAndOn";

			case 4:
				return "openTamTask";

			case 5:
				return "openTamInfo";
			default:
				break;
			}
		}
		message = "Something went wrong!";
		return "error";
	}

	private boolean addActivity() {
		//Prepare the Activity object
		Activity act = new Activity();
		if(startDate != null)
			act.startDate = startDate;
		if(createDate == null) {
			DateHelper dh = new DateHelper();
			act.createDate = dh.decodeDate(new Date());
		}
		act.activity = activity;
		act.activityType = activityType;
		act.type = type;

		//DB object
		Database db = new DbFromSession().getDbConnection(session);

		//For whole team, only in case of Task
		boolean flag = false;
		if(type == 4 && responsible.equals("team")) {
			Iterator<Attendee> it = new DataFromSession(session).getAttendees().iterator();
			while(it.hasNext()) {
				Attendee at = it.next();
				act.eid = at.eid;
				//Add activity
				flag = db.addActivity(act);
			}
		} else {
			act.eid = responsible;
			flag = db.addActivity(act);
		}

		if(flag)
			return true;
		else {
			message = "Not able to save to Database.";
			return false;
		}//End if flag
	}//End addActivity

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

	public String getResponsible() {
		return responsible;
	}

	public void setResponsible(String responsible) {
		this.responsible = responsible;
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

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	
}

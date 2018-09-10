package com.shaeed.itam.db;

import java.util.List;

import com.shaeed.itam.beans.Activity;
import com.shaeed.itam.beans.Attendee;
import com.shaeed.itam.beans.Tam;

public interface Database {
	//Table name constants
	final static String TASK_T = "_task";
	final static String ACTVITY_T = "_activity";
	final static String RESP_T = "_resp";
	final static String TAMS = "available_tams";
	final static String ATTENDEE_T = "_attendee";
	
	void setTamId(String id);
	
	List<Attendee> getAllAttendees();
	List<Activity> getAllActivities();
	List<Activity> getOldActivities(int type, int start, int end);
	List<Tam> getAllTams();
	Tam getTam(String tamId);
	
	
	boolean updateAttendee(String eid, String column, String info);
	boolean updateActivity(int key, String column, String info);
	boolean updateTam(String tamId, String column, String info);
	
	boolean addAttendee(Attendee atnd);
	public boolean addActivity(Activity act);
	boolean addTam(Tam tam);
	
	boolean deleteAttendee(String eid);
	
	boolean createTables(String tamId);
	
	boolean closeConnection();
	
}

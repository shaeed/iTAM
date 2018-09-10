package com.shaeed.itam.business;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.shaeed.itam.beans.Attendee;
import com.shaeed.itam.db.Database;

public class DataFromSession {
	private static final String ATTENDEES_LIST = "atndList";
	private static final String ATTENDEES_LIST_DICT = "atndListDict";
	private static final String TAM_ID = "tamId";
	private static final String RESPONSIBLE = "responsible";
	private static final String TEAM = "team";
	private static final String THEME = "theme";
	private static final String TAM_TIME = "team";
	Map<String, Object> session;
	
	//Constructor
	public DataFromSession(Map<String, Object> session) {
		this.session = session;
	}
	
	void setTamIdSession(String id) {
		session.put(TAM_ID, id);
	}
	String getTamIdSession() {
		return (String)session.get(TAM_ID);
	}
	
	void setResponsibleSession(String responsible) {
		session.put(RESPONSIBLE, responsible);
	}
	String getResponsibleSession() {
		return (String)session.get(RESPONSIBLE);
	}
	
	void setTeamSession(String team) {
		session.put(TEAM, team);
	}
	String getTeamSession() {
		return (String)session.get(TEAM);
	}
	
	void setThemeSession(String theme) {
		session.put(THEME, theme);
	}
	String getThemeSession() {
		return (String)session.get(THEME);
	}
	
	void setTamTimeSession(String tt) {
		session.put(TAM_TIME, tt);
	}
	String getTamTimeSession() {
		return (String)session.get(TAM_TIME);
	}
	
	List<Attendee> getAttendees(){
		@SuppressWarnings("unchecked")
		List<Attendee> at = (List<Attendee>)session.get(ATTENDEES_LIST);
		if(at == null) {
			//DB object
			Database db = new DbFromSession().getDbConnection(session);
			if(getTamIdSession() != null)
				db.setTamId(getTamIdSession());
			at = db.getAllAttendees();
			
			//Attendee dictionary
			//key- First name
			Map<String, String> dict = new HashMap<String, String>();
			if(at != null) {
				Iterator<Attendee> it = at.iterator();
				while(it.hasNext()) {
					Attendee atnd = it.next();
					dict.put(atnd.eid, atnd.first);
				}
				dict.put("team", "Team");
				
				session.put(ATTENDEES_LIST, at);
				session.put(ATTENDEES_LIST_DICT, dict);
			}//End if
		}
		return at;
	}//End getAllAttendees
	
	void removeAttendees() {
		session.remove(ATTENDEES_LIST);
	}//End removeAttendees
	
	@SuppressWarnings("unchecked")
	public Map<String, String> getAttendeeDict(){
		Map<String, String> dict = (Map<String, String>)session.get(ATTENDEES_LIST_DICT);
		if(dict == null) {
			getAttendees();
		}
		return (Map<String, String>)session.get(ATTENDEES_LIST_DICT);
	}
}

package com.shaeed.itam.business;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.shaeed.itam.beans.Activity;
import com.shaeed.itam.db.DateHelper;

public class TamCommonFunctions {
	Map<String, Object> session;
	
	public TamCommonFunctions(Map<String, Object> session) {
		this.session = session;
	}
	
	protected void fillDetails(List<Activity> acts) {
		Iterator<Activity> it = acts.iterator();
		Activity act = null;
		Map<String, String> atndDict = new DataFromSession(session).getAttendeeDict();

		Date today = new Date();
		Date startDate = null;
		DateHelper dh = new DateHelper();

		while(it.hasNext()) {
			act = it.next();
			//Responsible
			if(!(atndDict.get(act.eid) == null || atndDict.get(act.eid).equals("")))
				act.responsible = atndDict.get(act.eid);

			//Color
			startDate = dh.encodeToDtaeObj(act.startDate);
			if(today.after(startDate)) {
				//Target date over
				if(act.completed == true) {
					//Already completed
					act.color = "GREEN";
				} else 
					act.color = "RED";
			} else {
				
			}
		}//End while it.hasNext

	}//End fillDetails
}

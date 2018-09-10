package com.shaeed.itam.business;

import java.util.Map;

public class ThemeSelector {
	private static final String SUCCESS = "success";
	private static final String SUCCESS_B = "successb";
	private static final String ERROR = "error";
	private static final String ERROR_B = "errorb";
	
	Map<String, Object> session;

	//Constructor
	public ThemeSelector(Map<String, Object> session) {
		this.session = session;
	}

	public String success() {
		String thm = new DataFromSession(session).getThemeSession();
		if(thm == null) {
			//Theme is not present in session
			return SUCCESS_B;
		}
		
		String theme = SUCCESS_B;
		switch (thm) {
		case "basic":
			theme = SUCCESS_B;
			break;
			
		case "advance":
			theme = SUCCESS;
			break;

		default:
			break;
		}//End theme
		
		return theme;
	}//End success

	public String error() {
		String thm = new DataFromSession(session).getThemeSession();
		if(thm == null) {
			//Theme is not present in session
			return ERROR_B;
		}
		
		String theme = ERROR_B;
		switch (thm) {
		case "basic":
			theme = ERROR_B;
			break;
			
		case "advance":
			theme = ERROR;
			break;

		default:
			break;
		}//End switch
		
		return theme;
	}//End error
}

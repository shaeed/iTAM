package com.shaeed.itam.business;

public class Test {
	String text;
	String shaeed;
	String message;
	
	
	public String execute() {
		if(shaeed.equals("shaeed")) {
			message = "shaeed";
			return "success";
		} else {
			message = "khan";
			return "error";
		}
	}


	public String getText() {
		return text;
	}


	public void setText(String text) {
		this.text = text;
	}


	public String getMessage() {
		return message;
	}


	public void setMessage(String message) {
		this.message = message;
	}


	public String getShaeed() {
		return shaeed;
	}


	public void setShaeed(String shaeed) {
		this.shaeed = shaeed;
	}
	
	
}

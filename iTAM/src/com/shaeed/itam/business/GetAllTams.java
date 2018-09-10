package com.shaeed.itam.business;

import java.sql.SQLException;
import java.util.List;

import com.shaeed.itam.beans.Tam;
import com.shaeed.itam.db.Database;
import com.shaeed.itam.db.DbFactory;
import com.shaeed.itam.exceptions.DBNotFound;

/**
 * This class will return an ArrayList of all the available TAMs.
 * @author shaeed
 *
 */
public class GetAllTams {
	//List of Tam
	List<Tam> tams;
	String message;
	
	public String execute() {
		tams = getAllTams();
		if(tams == null) {
			message = "Database error!";
			return "error";
		}
		return "successb";
	}
	
	private List<Tam> getAllTams() {
		Database db;
		try {
			db = DbFactory.getConnection("sql");
		} catch (SQLException | DBNotFound e) {
			return null;
		}
		
		List<Tam> tams = db.getAllTams();
		db.closeConnection();
		return  tams;
	}

	public List<Tam> getTams() {
		return tams;
	}

	public void setTams(List<Tam> tams) {
		this.tams = tams;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
}

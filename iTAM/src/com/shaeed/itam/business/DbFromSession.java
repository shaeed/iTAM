package com.shaeed.itam.business;

import java.sql.SQLException;
import java.util.Map;

import com.shaeed.itam.db.Database;
import com.shaeed.itam.db.DbFactory;
import com.shaeed.itam.exceptions.DBNotFound;

public class DbFromSession {
	
	//Get the database connection
	Database getDbConnection(Map<String, Object> session) {
		Database db;
		db = (Database)session.get("dbconnection");
		try {
			if(db == null) {
				db = DbFactory.getConnection("sql");
				session.put("dbconnection", db);
			}
		} catch (SQLException | DBNotFound e) {
			System.out.println("Exception DbFromSession getDbConnection");
			return null;
		}
		return db;
	} //End getDataBaseConnection
	
	void removeDbConnection(Map<String, Object> session) {
		session.remove("dbconnection");
	}
}

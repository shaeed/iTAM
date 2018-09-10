package com.shaeed.itam.db;

import java.sql.SQLException;

import com.shaeed.itam.exceptions.DBNotFound;

public class DbFactory {
	private final static String sqlHost = "//localhost:3306/";
	private final static String sqlUserId = "root";
	private final static String sqlPassword = "123";
	
	
	/**
	 * To get the database connection.
	 * @param databaseType Name of the database
	 * @return A Database object
	 * @throws SQLException 
	 * @throws DBNotFound 
	 */
	public static Database getConnection(String databaseType) throws SQLException, DBNotFound {
		return getConnection(databaseType, "iTam");
	}

	public static Database getConnection(String databaseType, String databse) throws SQLException, DBNotFound {
		switch(databaseType) {
		case "sql":
			return new SqlDatabase(sqlHost, databse, sqlUserId, sqlPassword);
			
		default :
			throw new DBNotFound("Database not found!");
		}
		
	}
}

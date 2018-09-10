package com.shaeed.itam.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.shaeed.itam.beans.Activity;
import com.shaeed.itam.beans.Attendee;
import com.shaeed.itam.beans.Tam;

public class SqlDatabase implements Database {

	//A unique identifier for TAM/Project like AT, BP3 etc.
	private String tamId;

	private Connection con;
	private Statement st;

	static {
		try {
			//Load JDBC driver
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * Constructor
	 * @param host Database address
	 * @param dbName Name of the Database
	 * @param userId User name
	 * @param password Password
	 * @throws SQLException Exception
	 */
	public SqlDatabase(String host, String dbName, String userId, String password) throws SQLException {
		String url = "jdbc:mysql:" + host + dbName;
		con = DriverManager.getConnection(url, userId, password);
		st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	}

	@Override
	public List<Activity> getAllActivities() {
		String query = "select * from " + tamId + ACTVITY_T + " WHERE completed IS NULL";
		return executeActivityQuery(query);
	}//End getAllActivities
	
	private List<Activity> executeActivityQuery(String query){
		List<Activity> acts = new ArrayList<Activity>();

		//Query data base and create the Activity list
		ResultSet rs;
		Date dt;
		DateHelper dth = new DateHelper();
		try {
			rs = st.executeQuery(query);
			rs.beforeFirst();
			while(rs.next()) {
				Activity act = new Activity();
				act.sno = rs.getInt("sno");
				act.completed = rs.getBoolean("completed");
				act.activity = rs.getString("activity");
				act.eid = rs.getString("eid");

				dt = rs.getDate("startdate");
				act.startDate = dth.decodeDate(dt);
				dt = rs.getDate("enddate");
				act.endDate = dth.decodeDate(dt);

				act.mis = rs.getString("mis");
				act.activityType = rs.getString("activitytype");
				act.type = rs.getInt("type");
				acts.add(act);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}//End Try

		return acts;
	}//End executeActivityQuery

	@Override
	public boolean updateActivity(int key, String column, String info) {
		//Convert date format to match sql
		if(column.toLowerCase().contains("date")) {
			info = new DateHelper().encodeDate(info);
		}

		String query = "update " + tamId + ACTVITY_T + " set " + column + " = '" +
				info + "' where sno = " + key;

		return executeUpdateQuery(query);
	}

	@Override
	public boolean addActivity(Activity act) {
		String std = new DateHelper().encodeDate(act.startDate);
		String crtd = new DateHelper().encodeDate(act.createDate);
		//insert into at_task
		String query = "INSERT INTO " + tamId + ACTVITY_T +
				"(eid, activity, startdate, createdate, "
				+ "type, mis, activitytype) VALUES ('" 
				+ act.eid + "', '"
				+ act.activity + "', '"
				+ std + "', '"
				+ crtd + "', "
				+ act.type + ", '"
				+ act.mis + "', '"
				+ act.activityType
				+ "')";
		return executeUpdateQuery(query);
	}//End addActivity

	@Override
	public boolean closeConnection() {
		try {
			if(st != null)
				st.close();
			if(con != null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}

	@Override
	public List<Tam> getAllTams() {
		String query = "select * from " + TAMS + " where available = 1";
		List<Tam> tams = new ArrayList<Tam>();

		//Query data base and create the task list
		try {
			ResultSet rs = st.executeQuery(query);
			rs.beforeFirst();
			while(rs.next()) {
				Tam tam = new Tam();

				tam.available = rs.getBoolean("available");
				tam.id = rs.getString("id");
				tam.team = rs.getString("team");
				tam.admin = rs.getString("admin");
				tam.responsible = rs.getString("responsible");
				tam.tamTime = rs.getString("tamtime");
				tam.theme = rs.getString("theme");
				tam.type = rs.getInt("type");

				tams.add(tam);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return tams;
	}

	@Override
	public void setTamId(String id) {
		tamId = id;
	}

	@Override
	public boolean createTables(String tamId) {
		if(tamId == null)
			return false;

		String query;
		/*
		 * Activity table
		 * create table at_activity (sno int not null auto_increment, 
		 * eid varchar(10), 
		 * activity varchar(255), 
		 * completed boolean, 
		 * startdate date, 
		 * enddate date, 
		 * createdate date, 
		 * type int, 
		 * mis varchar(255), 
		 * activitytype varchar(255), 
		 * primary key(sno))
		 */
		query = "CREATE TABLE " + tamId + ACTVITY_T +
				"(" + 
				"sno int not null auto_increment, " +
				"eid varchar(10), " +
				"activity varchar(255), " + 
				"completed boolean, " + 
				"startdate date, " + 
				"enddate date, " +
				"createdate date, " +
				"type int, " +
				"mis varchar(255), " + 
				"activitytype varchar(255), " + 
				"primary key(sno) " +
				")";
		boolean act = executeUpdateQuery(query);

		/*
		 * Attendee Table
		 * create table at_attendee (eid varchar(10),
		 * first varchar(255),
		 * last varchar(255),
		 * email varchar(255),
		 * role int,
		 * primary key(eid))
		 */
		query = "CREATE TABLE " + tamId + ATTENDEE_T +
				"(" + 
				"eid varchar(10), " +
				"first varchar(255), " +
				"last varchar(255), " + 
				"email varchar(255), " + 
				"role int, " + 
				"primary key(eid) " + 
				")";
		boolean att = executeUpdateQuery(query);

		return act & att;
	} //End createTables

	private boolean executeUpdateQuery(String query) {
		try {
			st.executeUpdate(query);
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	} //End executeUpdateQuery

	@Override
	public boolean addTam(Tam tam) {
		//insert into available_tams (id, team, admin, 
		//responsible, available) values ('at', 'AT', 'E863021', 'Jayateerth', 1)
		String query = "INSERT INTO " + TAMS +
				" (id, team, admin, responsible, available, tamtime, type, theme) " +
				"values ( '" +
				tam.id +"', '" +
				tam.team + "', '" +
				tam.admin + "', '" +
				tam.responsible + "', '" +
				boolToInt(tam.available) + "', '" +
				tam.tamTime + "', '" +
				tam.type + "', '" +
				tam.theme + "'" +
				" )";

		return executeUpdateQuery(query);
	}

	private int boolToInt(boolean b) {
		return b?1:0;
	}

	@Override
	public boolean addAttendee(Attendee atnd) {
		//insert into at_attendee values('e863021', 'shaeed', 'khan', 'shaeed.khan@honeywell.com')
		String query = "INSERT INTO " + tamId + ATTENDEE_T +
				"(eid, first, last, email, role) VALUES ('" +
				atnd.eid + "', '" +
				atnd.first + "', '" +
				atnd.last + "', '" + 
				atnd.email + "', '" +
				atnd.role + "'" +
				")";
		return executeUpdateQuery(query);
	}

	@Override
	public List<Attendee> getAllAttendees() {
		String query = "select * from " + tamId + ATTENDEE_T;
		List<Attendee> ats = new ArrayList<Attendee>();

		//Query data base and create the task list
		ResultSet rs = null;		
		try {
			rs = st.executeQuery(query);
			rs.beforeFirst();
			while(rs.next()) {
				Attendee at = new Attendee();
				at.eid = rs.getString("eid");
				at.first = rs.getString("first");
				at.last = rs.getString("last");
				at.email = rs.getString("email");
				at.role = rs.getInt("role");

				ats.add(at);
			}// End While
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}//End Try

		return ats;
	}//End getAllAttendees

	@Override
	public boolean updateAttendee(String eid, String column, String info) {
		String query = "update " + tamId + ATTENDEE_T + " set " + column + " = '" +
				info + "' where eid = '" + eid + "'";

		return executeUpdateQuery(query);
	}
	
	@Override
	public boolean updateTam(String tamId, String column, String info) {
		String query = "update " + TAMS + " set " + column + " = '" +
				info + "' where id = '" + tamId + "'";

		return executeUpdateQuery(query);
	}

	@Override
	public boolean deleteAttendee(String eid) {
		String query = "DELETE FROM " + tamId + ATTENDEE_T + 
				" WHERE eid = '" + eid + "'";

		return executeUpdateQuery(query);
	}

	@Override
	public Tam getTam(String tamId) {
		String query = "select * from " + TAMS + " where id= '" + tamId + "'";
		Tam tam = new Tam();

		//Query data base and create the task list
		try {
			ResultSet rs = st.executeQuery(query);
			rs.beforeFirst();
			rs.next();
			//while(rs.next()) {
				tam.available = rs.getBoolean("available");
				tam.id = rs.getString("id");
				tam.team = rs.getString("team");
				tam.admin = rs.getString("admin");
				tam.responsible = rs.getString("responsible");
				tam.tamTime = rs.getString("tamtime");
				tam.theme = rs.getString("theme");
				tam.type = rs.getInt("type");
			//}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return tam;
	}

	@Override
	public List<Activity> getOldActivities(int type, int start, int end) {
		String query = "SELECT * FROM " + tamId + ACTVITY_T 
				+ " WHERE completed=1 and type=" + type 
				+ " LIMIT " + start + "," + end;
		
		return executeActivityQuery(query);
	}//End getOldActivities

}//End Class SqlDatabase

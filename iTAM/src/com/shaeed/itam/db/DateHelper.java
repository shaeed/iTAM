package com.shaeed.itam.db;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateHelper {
	private static final String HTML_DATE_TYPE = "dd MMM, yy";
	private static final String SQL_DATE_TYPE = "YYYY-MM-dd";

	/*
	 * For Storing in Sql.
	 * Convert HTML date to SQL date format.
	 * From String
	 * @return SQL type date
	 */
	public String encodeDate(String dt) {
		Date date = encodeToDtaeObj(dt);
		if(date == null)
			return null;
		return new SimpleDateFormat(SQL_DATE_TYPE).format(date);
	}

	/*
	 * Convert Date object to SQL date format.
	 * From Date object, java.util.Date
	 * @return SQL type date
	 */
	public String encodeDate(Date dt) {
		return new SimpleDateFormat(SQL_DATE_TYPE).format(dt);
	}

	/*
	 * Converting HTML date String to Date object
	 * For comparing the Date object
	 */
	public Date encodeToDtaeObj(String dt) {
		//Input check
		if(dt == null) {
			return null;
		}
		//Incoming date string is of type 12 Jan, 2018
		SimpleDateFormat sd = new SimpleDateFormat(HTML_DATE_TYPE);
		Date date = null;
		try {
			date = sd.parse(dt.trim());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	/*
	 * For Displaying in HTML
	 * Convert Sql Date object to HTML format date String.
	 * @return HTML type date
	 */
	public String decodeDate(Date dt) {
		//Input check
		if(dt == null) {
			return null;
		}
		SimpleDateFormat sd = new SimpleDateFormat(HTML_DATE_TYPE);
		return sd.format(dt);
	}
}

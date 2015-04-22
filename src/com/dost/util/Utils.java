package com.dost.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

public class Utils {

	private static final String patternString = "yyyy-MM-dd HH:mm:ss";
	
	public static String formatDate(Date date) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return dateFormat.format(date);
	}
	
	public static Date formatDate(String dateStr) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = null;
		try {
			date = dateFormat.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}
	
	public static String formatDate(String format, Date date) {
		SimpleDateFormat dateFormat = new SimpleDateFormat(format);
		return dateFormat.format(date);
	}
	
	public static Date formatDate(String format, String dateStr) {
		SimpleDateFormat dateFormat = new SimpleDateFormat(format);
		Date date = null;
		try {
			date = dateFormat.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}
	
	public static String unixToDate(String unix_timestamp) {    
	    long timestamp = Long.parseLong(unix_timestamp) * 1000;

	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    String date = null;
	    date = sdf.format(timestamp);
	    return date.toString();
	}
	
	public static Long dateToUnix(String date) {    
	    Date localDate = formatDate("yyyy-M-dd HH:mm:ss", date);
	    localDate.setHours(localDate.getHours() - 4);
//	    return localDate.getTime() / 1000L;
	    return localDate.getTime();
	}
	
	public static boolean showSignUpPage(HttpServletRequest request) {
		boolean showSignUpPage = true;
		String ipAddress = request.getHeader("X-FORWARDED-FOR");  
		if (ipAddress == null) {  
		   ipAddress = request.getRemoteAddr();  
		}
		try {
			showSignUpPage = NetMaskLookupService.ValidateIP(ipAddress);
		}
		catch (Exception e) {
			e.printStackTrace();
			showSignUpPage = false;
		} 
		return showSignUpPage;
	}
	
	public static String generateUniqueToken() {
		UUID uniqueId = UUID.randomUUID();
		return uniqueId.toString();
	}
	
	public static Date convertDatetoIST(Date inputDate) {
		Date returnDate = null;
		try {
		    DateFormat utcFormat = new SimpleDateFormat("hh:mm a, dd MMMM yyyy");
		    utcFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
		    DateFormat indianFormat = new SimpleDateFormat("hh:mm a, dd MMMM yyyy");
		    indianFormat.setTimeZone(TimeZone.getTimeZone("Asia/Kolkata"));
		    Date timestamp = utcFormat.parse(formatDate(inputDate));
		    String output = indianFormat.format(timestamp);
		    returnDate = formatDate(output);
		}
		catch (ParseException pe) {
			pe.printStackTrace();
		}
		return returnDate;
	}
	
	public static String convertDatetoIST(String inputDate) {
		String returnDate = null;
		try {
		    DateFormat utcFormat = new SimpleDateFormat("hh:mm a, dd MMMM yyyy");
		    utcFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
		    DateFormat indianFormat = new SimpleDateFormat("hh:mm a, dd MMMM yyyy");
		    indianFormat.setTimeZone(TimeZone.getTimeZone("Asia/Kolkata"));
		    Date timestamp = utcFormat.parse(inputDate);
		    returnDate = indianFormat.format(timestamp);
		}
		catch (ParseException pe) {
			pe.printStackTrace();
		}
		return returnDate;
	}
}

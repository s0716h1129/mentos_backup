<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.*"%>
<%@page import="org.json.simple.*"%>


<%
	String loginName = (String) request.getAttribute("login_name");
	System.out.println("여기 jsp : " + loginName);

	JSONObject jsonMain = new JSONObject();
	JSONArray jArray = new JSONArray();

	JSONObject jObject = new JSONObject();

	System.out.println(loginName);
	jObject.put("loginName", loginName);

	//jArray.add(0, jObject);

	//jsonMain.put("List", jArray);

	out.println(jObject);
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "org.json.simple.*" %>
<%@ page import = "com.study.springboot.dto.ClassJoinDto" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<%
	JSONObject jsonMain1 = new JSONObject();
	JSONArray jArray1 = new JSONArray();
	
	ArrayList<ClassJoinDto> array1 = (ArrayList<ClassJoinDto>) request.getAttribute("memberAtted");
	
	for (int i=0; i<array1.size(); i++) {
		JSONObject jobject1 = new JSONObject();
		
		jobject1.put("join_class_num", array1.get(i).getJoin_class_num());
		jobject1.put("class_name", array1.get(i).getClass_name());
		jobject1.put("class_mento", array1.get(i).getClass_mento());
		jobject1.put("class_place", array1.get(i).getClass_place());
		jobject1.put("class_startdate", array1.get(i).getClass_startdate());
		jobject1.put("class_enddate", array1.get(i).getClass_enddate());
		jobject1.put("class_starttime", array1.get(i).getClass_starttime());
		jobject1.put("class_endtime", array1.get(i).getClass_endtime());
		jobject1.put("class_image", array1.get(i).getClass_image());
		jobject1.put("join_type", array1.get(i).getJoin_type());
		
		jArray1.add(i, jobject1);
	}
	
	jsonMain1.put("attendList", jArray1);
	out.println(jsonMain1);
	
	JSONObject jsonMain2 = new JSONObject();
	JSONArray jArray2 = new JSONArray();
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
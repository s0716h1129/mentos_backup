<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "org.json.simple.*" %>
<%@ page import = "com.study.springboot.dto.ClassJoinDto" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<%
	JSONObject jsonMain = new JSONObject();
	JSONArray jArray = new JSONArray();
	
	ArrayList<ClassJoinDto> array = (ArrayList<ClassJoinDto>) request.getAttribute("classList");

	for (int i=0; i<array.size(); i++) {
		JSONObject jobject = new JSONObject();
		
		jobject.put("join_class_num", array.get(i).getJoin_class_num());
		jobject.put("class_name", array.get(i).getClass_name());
		jobject.put("class_mento", array.get(i).getClass_mento());
		jobject.put("class_place", array.get(i).getClass_place());
		jobject.put("class_startdate", array.get(i).getClass_startdate());
		jobject.put("class_enddate", array.get(i).getClass_enddate());
		jobject.put("class_starttime", array.get(i).getClass_starttime());
		jobject.put("class_endtime", array.get(i).getClass_endtime());
		jobject.put("join_type", array.get(i).getJoin_type());
		
		jArray.add(i, jobject);
	}
	jsonMain.put("List", jArray);
	out.println(jsonMain);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
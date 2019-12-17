<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "org.json.simple.*" %>
<%@ page import = "com.study.springboot.dto.MemberDto" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<%
	JSONObject jsonMain = new JSONObject();
	JSONArray jArray = new JSONArray();	
	JSONObject jObject = new JSONObject();
	
	MemberDto dto = (MemberDto) request.getAttribute("memberInfo");

	jObject.put("member_image", dto.getMember_image());
	jObject.put("member_intro", dto.getMember_intro());
	jObject.put("email", dto.getEmail());
	jObject.put("nickname", dto.getNickname());
	jObject.put("phonenumber", dto.getPhonenumber());
	jObject.put("interest_area", dto.getInterest_area());
	jObject.put("interest_major", dto.getInterest_major());
	jObject.put("interest_group", dto.getInterest_group());
	
	jArray.add(0, jObject);
	
	jsonMain.put("MemberList", jArray);
	out.println(jsonMain);
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
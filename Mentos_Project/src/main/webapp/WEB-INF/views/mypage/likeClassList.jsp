<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery.js"></script>
<title>Insert title here</title>
</head>
<body>
	<h1>찜목록</h1>
	
	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
		<tr>
			<th> 강좌 번호 </th>
			<th> 강좌 이름 </th>
			<th> 개최 멘토 </th>
			<th> 진행 장소 </th>
			<th> 진행 기간 </th>
		</tr>
	
		<c:forEach items="${classList}" var="dto">
		<tr>
			<td> ${dto.join_class_num} </td>
			<td> <a href=""> ${dto.class_name} </a> </td>
			<td> ${dto.class_mento} </td>
			<td> ${dto.class_place} </td>
			<td> ${dto.class_date} </td>
		</tr>
		</c:forEach>
	
	</table>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyPage Class List</title>
</head>
<body>
	<%@include file ="../header.jsp" %>
	<h1>마이 페이지 - 참여 강좌 정보</h1> <br><br>
	
	<h3> 참여 신청 강좌</h3>
	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
		<tr>
			<th> 강좌 번호 </th>
			<th> 강좌 이름 </th>
			<th> 개최 멘토 </th>
			<th> 진행 장소 </th>
			<th> 진행 기간 </th>
			<th> 진행 시간 </th>
		</tr>
		
		<c:forEach items="${classList}" var="cdto">
		<c:if test="${cdto.join_type eq 'start'}">
			<tr>
				<td> ${cdto.join_class_num} </td>
				<td> ${cdto.class_name} </td>
				<td> ${cdto.class_mento} </td>
				<td> ${cdto.class_place} </td>
				<c:choose>
					<c:when test="${cdto.class_startdate eq cdto.class_enddate}">
						<td> ${cdto.class_startdate}</td>
					</c:when>
					<c:otherwise>
						<td> ${cdto.class_startdate} ~ ${cdto.class_enddate} </td>
					</c:otherwise>
				</c:choose>
				
				<td> ${cdto.class_starttime} ~ ${cdto.class_endtime} </td>
			</tr>
		</c:if>
		</c:forEach>
	</table>
	
	
	<h3> 참여 중인 강좌</h3>
	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
		<tr>
			<th> 강좌 번호 </th>
			<th> 강좌 이름 </th>
			<th> 개최 멘토 </th>
			<th> 진행 장소 </th>
			<th> 진행 기간 </th>
			<th> 진행 시간 </th>
		</tr>
		
		
		<c:forEach items="${classList}" var="cdto">
		<c:if test="${cdto.join_type eq 'ing'}">
			<tr>
				<td> ${cdto.join_class_num} </td>
				<td> <a href=""> ${cdto.class_name} </a> </td>
				<td> ${cdto.class_mento} </td>
				<td> ${cdto.class_place} </td>
				<c:choose>
					<c:when test="${cdto.class_startdate eq cdto.class_enddate}">
						<td> ${cdto.class_startdate}</td>
					</c:when>
					<c:otherwise>
						<td> ${cdto.class_startdate} ~ ${cdto.class_enddate} </td>
					</c:otherwise>
				</c:choose>
				<td> ${cdto.class_starttime} ~ ${cdto.class_endtime} </td>
			</tr>
		</c:if>
		</c:forEach>
	</table>
	
	<h3> 참여가 끝난 강좌</h3>
	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
		<tr>
			<th> 강좌 번호 </th>
			<th> 강좌 이름 </th>
			<th> 개최 멘토 </th>
			<th> 진행 장소 </th>
			<th> 진행 기간 </th>
			<th> 진행 시간 </th>
		</tr>
		
		<c:forEach items="${classList}" var="cdto">
		<c:if test="${cdto.join_type eq 'end'}">
			<tr>
				<td> ${cdto.join_class_num} </td>
				<td> <a href=""> ${cdto.class_name} </a> </td>
				<td> ${cdto.class_mento} </td>
				<td> ${cdto.class_place} </td>
				<c:choose>
					<c:when test="${cdto.class_startdate eq cdto.class_enddate}">
						<td> ${cdto.class_startdate}</td>
					</c:when>
					<c:otherwise>
						<td> ${cdto.class_startdate} ~ ${cdto.class_enddate} </td>
					</c:otherwise>
				</c:choose>
				<td> ${cdto.class_starttime} ~ ${cdto.class_endtime} </td>
			</tr>
			</c:if>
		</c:forEach>
	</table>
	<%@include file ="../footer.jsp" %>
</body>
</html>
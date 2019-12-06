<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery.js"></script>
<title>MembeAdmin</title>

<style>
	#container {
	}
	#left {
		border-style: solid;
		border-width: 1px;
		width:80%;
	}
	#right {
		border-style: solid;
		border-width: 1px;
		text-align: right;
		width:20%;
	}
</style>

</head>
<body>
	장소 관리
	
	<form action="placeSerch">
		<select id="serType" name="serType">
			<option value="s1" selected=selected> 번호 </option>
			<option value="s2"> 이름 </option>
		</select>
		
		<input type="text" id="serch" name="serch"> &nbsp;
		<input type="submit" value="검색">		
		<input type="hidden" id="type" name="type" value="place">
	</form>
	
	<div id='container'>
	    <div id='left'>
	    <table width="500" cellpadding="0" cellspacing="0" border="1">
	    	<tr>
	    		<th> 장소 번호 </th>
	    		<th> 장소 이름 </th>
	    		<th> 주소 </th>
	    		<th> 대여 가능 시간 </th>
	    		<th> 수용 가능 인원 </th>
	    		<th> 대여료 </th>
	    		<th> 장소 제공자 전화 번호 </th>
	    		<th> 장소 대여자 </th>
	    	</tr>
	    	
			<c:forEach items="${serList}" var="dto">
			<tr>
			   	<td> ${dto.place_number} </td>
			   	<td> ${dto.place_name} </td>
			   	<td> ${dto.place} </td>
			   	<td> ${dto.place_time} </td>
		   		<td> ${dto.place_people_num} </td>
		   		<td> ${dto.place_price} </td>
		  		<td> ${dto.place_phone} </td>
		  		<td> ${dto.place_rent} </td>
			</tr>
			</c:forEach>

	    	
	    </table>

	    </div>
	    
	    <div id='right'>
	   		<button type="button" onclick=""> 장소 리뷰 내역 조회 </button> <br><br>
			<button type="button" onclick=""> 장소 결제 내역 조회 </button> <br><br>
			<button type="button" onclick=""> 장소 대여 취소 </button> <br><br>
			<button type="button" onclick=""> 장소 정보 수정 </button> <br><br>
			<button type="button" onclick=""> 장소 등록 삭제 </button> <br><br>
	    </div>
	</div>
</body>
</html>
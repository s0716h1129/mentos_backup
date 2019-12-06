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

<script>
	function classDelete() {
		if($('#deleteClass').val().length == 0) {
			alert("아이디를 작성해주세요.");
		}
		
		
	}
</script>

</head>
<body>
	강좌 관리
	
	<form action="classSerch">
		<select id="serType" name="serType">
			<option value="s1" selected=selected> 강좌 번호</option>
			<option value="s2"> 강좌 이름 </option>
			<option value="s3"> 개최 멘토 </option>
		</select>
		<input type="text" id="cId" name="cId"> &nbsp;
		<input type="submit" value="검색">		
		<input type="hidden" id="type" name="type" value="class">
	</form>
	
	<div id='container'>
	    <div id='left'>
	    <table width="500" cellpadding="0" cellspacing="0" border="1">
	    	<tr>
	    		<th> 강좌 번호 </th>
	    		<th> 강좌 이름 </th>
	    		<th> 개최 멘토 </th>
	    		<th> 참여 멘티 </th>
	    		<th> 진행 장소 </th>
	    		<th> 진행 기간 </th>
	    	</tr>

			<c:forEach items="${serList}" var="dto">
			<tr>
			   	<td> ${dto.class_number} </td>
			   	<td> ${dto.class_name} </td>
			   	<td> ${dto.class_mento} </td>
			   	<td> ${dto.class_mentee} </td>
		   		<td> ${dto.class_place} </td>
		   		<td> ${dto.class_date} </td>
			</tr>
			</c:forEach>
	    </table>
	    
	    <c:if test="${param.menu eq 'delete'}">
	    	<hr>
	    	강좌 삭제 <br>
	    	<form>
	    		삭제 강좌 번호 : <input type="text" id="deleteClass" name="deleteClass">
	    		<input type ="button" value="확인" onclick="classDelete()">
	    	</form>

	    </c:if>

	    </div>
	    
	    <div id='right'>
	    	<button type="button" onclick=""> 강좌 리뷰 내역 조회 </button> <br><br>
			<button type="button" onclick=""> 강좌 결제 내역 조회 </button> <br><br>
			<button type="button" onclick=""> 강좌 상세 내용 </button> <br><br>
			<button type="button" onclick=""> 강좌 정보 수정하기 </button> <br><br>
			<button type="button" onclick="location.href='classSerch?type=class&menu=delete&cId=${param.cId}&serType=${param.serType}'"> 강좌 삭제 </button> <br><br>
	    </div>
	</div>
</body>
</html>
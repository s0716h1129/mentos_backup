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
		<input type="hidden" id="menu" name="menu" value="">
	</form>
	
	<div id='container'>
	    <div id='left'>
	    <table width="500" cellpadding="0" cellspacing="0" border="1">
	    	<tr>
	    		<th> 강좌 번호 </th>
	    		<th> 강좌 이름 </th>
	    		<th> 개최 멘토 </th>
	    		<th> 진행 장소 </th>
	    		<th> 진행 기간 </th>
	    		<th> 결제 내역 </th>
	    		<th> 리뷰 내역 </th>
	    	</tr>

			<c:forEach items="${serList}" var="dto">
			<tr>
			   	<td> ${dto.class_number} </td>
			   	<td> ${dto.class_name} </td>
			   	<td> ${dto.class_mento} </td>
		   		<td> ${dto.class_place} </td>
		   		<td> ${dto.class_date} </td>
		   		<td> <a href="./classSerch?type=class&menu=pay&serType=${param.serType}&cId=${dto.class_number}" > 결제 확인 </a> </td>
		   		<td> <a href="./classSerch?type=class&menu=review&serType=${param.serType}&cId=${dto.class_number}" > 리뷰 확인 </a></td>
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
	    
	    <c:if test="${param.menu eq 'pay'}">
	    	<hr>
	    	결제 내역 <br>
	    	<table width="500" cellpadding="0" cellspacing="0" border="1">
	    		<tr>
	    			<th> 결제 멘티 </th>
	    			<th> 금액 </th>
	    			<th> 결제일 </th>
	    			<th> 환불 / 결제 상황 </th>
	    		</tr>
	    		
	    		<c:forEach items="${cPay}" var="pdto">
	    		<tr>
	    			<td> ${pdto.pay_member} </td>
	    			<td> ${pdto.pay_price} </td>
	    			<td> ${pdto.pay_date} </td>
	    			<td> ${pdto.refund} </td>
	    		</tr>
	    		</c:forEach>
	    	
	    	</table>
	    </c:if>
	    
	    <c:if test="${param.menu eq 'review'}">
	    	<hr>
	    	리뷰 내역 <br>
	    	<table width="500" cellpadding="0" cellspacing="0" border="1">
	    		<tr>
	    			<th> 리뷰 번호 </th>
	    			<th> 작성자 </th>
	    			<th> 별점 </th>
	    			<th> 내용 </th>
	    		</tr>
	    		
	    		<tr>
	    			<td> </td>
	    			<td> </td>
	    			<td> </td>
	    			<td> </td>
	    		</tr>
	    	</table>
	    	
	    </c:if>

	    </div>
	    
	    <div id='right'>
			<button type="button" onclick=""> 강좌 상세 내용 </button> <br><br>
			<button type="button" onclick=""> 강좌 정보 수정하기 </button> <br><br>
			<button type="button" onclick="location.href='classSerch?type=class&menu=delete&cId=${param.cId}&serType=${param.serType}'"> 강좌 삭제 </button> <br><br>
	    </div>
	</div>
</body>
</html>
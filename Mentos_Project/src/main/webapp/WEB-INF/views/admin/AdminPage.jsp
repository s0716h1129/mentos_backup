<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery.js"></script>
<title>Admin Page</title>


<style>
	#container {
		display: flex;
	}
	#box-left {
		flex: 1;
		border-style: solid;
		border-width: 1px;
	}
	#box-right {
		flex: 5;
		border-style: solid;
		border-width: 1px;
		text-align: right;
	}
</style>

</head>
<body>
	<h1>관리자</h1>
	
	<hr>
	
	<div id='container'>
	    <div id='box-left'>
	    	<button type="button" onclick="location.href='./main?type=member'"> 회원 관리 </button> <br><br>
			<button type="button" onclick="location.href='./main?type=class'"> 강좌 관리 </button> <br><br>
			<button type="button" onclick="location.href='./main?type=place'"> 장소 관리</button>  <br><br>
	    </div>
	    <div id='box-right'>
	    	<c:if test="${param.type eq 'member'}">
	    		<jsp:include page="memberAdmin.jsp" flush="false" />
	    	</c:if>
	    	<c:if test="${param.type eq 'class'}">
	    		<jsp:include page="classAdmin.jsp" flush="false" />
	    	</c:if>
	    	<c:if test="${param.type eq 'place'}">
	    		<jsp:include page="placeAdmin.jsp" flush="false" />
	    	</c:if>
	    </div>
	</div>

</body>
</html>
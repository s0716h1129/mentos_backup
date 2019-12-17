<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<script src="http://code.jquery.com/jquery.js"></script>
<title>MyPage</title>

</head>
<body>
	<%@include file ="../header.jsp" %>	 
	 
	<div class="container" style="text-align: center;">
		<div class="card">
	    	<div class="card-header">
	    		<i class="fas fa-table"></i>
				<h1> 회원 정보 </h1>
			</div>
	    	<div class="card-body">
	        	<h5 class="card-title">ID : ${info.email}</h5>
	        	 <p class="card-text"> ${info.member_intro}</p>
	        </div>
	  		<ul class="list-group list-group-flush">
	    		
	    		<li class="list-group-item">
	    			닉네임 : ${info.nickname}<br>
	    			등급 : ${grade} (${info.member_score}점)<br>
	    			전화 번호 : ${info.phonenumber} <br>
	    		</li>
	    		
	    		<li class="list-group-item">
	    			회원 이미지 <br>
	    			<!-- 나중에 이미지 추가 넣기 -->    		
	    		</li>
	    		
	    		<li class="list-group-item">
					관심 모임 <br>
	    			${info.interest_class} <br>
	    		</li>
	    		
	    		<li class="list-group-item">
					관심 분야 <br>
	    			${info.interest_major} <br>
	    		</li>
	    		
	    		<li class="list-group-item">
					관심 직군 <br>
	    			${info.interest_group} <br>
	    		</li>
	    		
	    		<li class="list-group-item">
	
	    			관심 지역 <br>
	    			${info.interest_area} <br>
	    		</li>
	  		</ul>
	  		<div class="card-body">
	  		<a href="./modifyForm" class="card-link">회원 정보 수정</a>
	    		<a href="#" class="card-link">출결 확인</a>
	    		<a href="#" onClick="history.back()" class="card-link">이전페이지로</a>
	    		<a href="./memberLeaveForm" class="card-link">회원 탈퇴</a>
	  		</div>
	    </div>
    </div>
    <br>
 
	<%@include file ="../footer.jsp" %>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<script src="http://code.jquery.com/jquery.js"></script>
<title>Admin Page</title>

<!-- Bootstrap core CSS -->
<link href="../resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="../resources/css/sb-admin.css" rel="stylesheet">
<link href="../resources/css/scrolling-nav.css" rel="stylesheet">

</head>
<body id="page-top">
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
   	<h3 class='text-white'> Mentos AdminPage </h3>
  </nav>
  
  <div id="wrapper">
  	<ul class="sidebar navbar-nav navbar-dark bg-dark">
  	  <c:choose>
  	  	<c:when test="${param.type eq 'member'}">
  	  		<li class="nav-item dropdown">
        		<a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false">
          			<span> <br><br> 회원 관리 </span>
        		</a>
       			<div class="dropdown-menu show" aria-labelledby="pagesDropdown">
          			<a class="dropdown-item" href="./main?type=member"> 회원 검색 </a>
          			<a class="dropdown-item" href="./memberSerch?type=member&menu=grade&mId=${param.mId}"> 회원 등급 변경 </a>
          			<a class="dropdown-item" href="./memberSerch?type=member&menu=cPw&mId=${param.mId}"> 회원 비밀번호 변경 </a>
          			<a class="dropdown-item" href="./memberSerch?type=member&menu=cState&mId=${param.mId}"> 정지/삭제/블랙리스트 </a>
        		</div>
      		</li>
  	  	</c:when>
  	  <c:otherwise>
  	  	  <li class="nav-item">
  	  	  	<a class="nav-link" href="./main?type=member">
          		<span> <br><br> 회원 관리 </span>
        	</a>
          </li>
  	  </c:otherwise>
  	  </c:choose>
      
       <c:choose>
  	  	<c:when test="${param.type eq 'class'}">
  	  	  <li class="nav-item active">
  	  	  	<a class="nav-link" href="./main?type=class">
          		<span> 강좌 관리 </span>
       		</a>
        	</li>
  	  	</c:when>
  	  	<c:otherwise>
  	  	  <li class="nav-item">
  	  	  	<a class="nav-link" href="./main?type=class">
          		<span> 강좌 관리 </span>
        	</a>
        	</li>
  	  	</c:otherwise>
  	  </c:choose>
      
      <c:choose>
  	  	<c:when test="${param.type eq 'place'}">
  	  	  <li class="nav-item active">
  	  	  	<a class="nav-link" href="./main?type=place">
          		<span> 장소 관리 </span>
       		</a>
        	</li>
  	  </c:when>
  	  	<c:otherwise>
  	  	  <li class="nav-item">
  	  	  	<a class="nav-link" href="./main?type=place">
          		<i class="fas fa-fw fa-tachometer-alt"></i>
          		<span> 장소 관리 </span>
        	</a>
        	</li>
  	  	</c:otherwise>
  	  </c:choose>
    </ul>
    
    <div id="content-wrapper" style="padding: 100px 00px 100px 00px">
      <div class="container-fluid">
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
  </div>
 
	
  <%@include file ="../footer.jsp" %>


</body>
</html>
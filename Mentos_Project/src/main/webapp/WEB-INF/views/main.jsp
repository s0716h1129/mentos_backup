<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 	
	String id = (String)session.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
<title>Insert title here</title>

  <!-- Bootstrap core CSS -->
  <link href="../resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="../resources/css/scrolling-nav.css" rel="stylesheet">

</head>
<body>
<!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
    <div class="container">
      <a class="navbar-brand js-scroll-trigger" href="#page-top">Mentos Main</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
        <c:if test="${id == null}">
          <li class="nav-item">
			<a class="nav-link js-scroll-trigger"  href="/main/joinForm">join</a>
          </li>
          <li class="nav-item">
       		<a class="nav-link js-scroll-trigger"  href="/main/loginForm">login</a>
          </li>
       </c:if>
       	<c:if test="${id != null}">
			<tr>
				<td>${id} </td>
			</tr>
		  <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="memberModify">정보수정</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="/main/logout">logout</a>
          </li>
       </c:if>
        </ul>
      </div>
    </div>
  </nav>
   <header class="primary text-white">
   		<!-- <form action="/class/list" method="post">
		    <aside style='float: right;'>
		      <select name='type'> 검색 컬럼
				    <option value="">검색</option>
				    <option value="place">지역</option>
				    <option value="major">분야</option>
				    <option value="mento">작성자</option>
		      </select>
		      <input type='text' name='search' size="50" value='' placeholder="특수문자는 사용할수 없습니다.">
		      <input type='submit' value="검색">    
		     </aside> 
		</form> -->
	 </header>
	 
	 <div id='container'>
	    <div id='box-right'>
	    	<jsp:include page="class/class_list.jsp" flush="false" />
	    </div>
	</div>
	 <!-- Footer -->
  <footer class="py-5 bg-dark">
    <div class="container">
      	<ol class="breadcrumb">
  			<li><a class="btn btn-primary" href="/main/">회사소개</a></li>
  			<li><a class="btn btn-primary" href="/main/">이용하기</a></li>
  			<li><a class="btn btn-primary" href="/main/">문의하기</a></li>
  			<li><a class="btn btn-primary" href="/main/">고객센터</a></li>
		</ol>
    </div>
    <!-- /.container -->
  </footer>
	 <!-- Bootstrap core JavaScript -->
  <script src="../resources/vendor/jquery/jquery.min.js"></script>
  <script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Plugin JavaScript -->
  <script src="../resources/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom JavaScript for this theme -->
  <script src="../resources/js/scrolling-nav.js"></script>
</body>
</html>
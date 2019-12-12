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
  <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>

    <script type="text/javascript">
    function alram(){
       setInterval(function() {
         checkAlram();
      }, 4000);
    }
    function checkAlram(){
      var userID = '<%= id %>';
      $.ajax({
          type: "POST",
          url: "/main/check_alram",
          data: {
				 userID: encodeURIComponent(userID),
			 },

          success: function(result){
             if(result >= 1){
                show_alram(result);
             }else{
                show_alram(''); 
             }
          }
      });
   }
    function show_alram(result) {
      $('#alram').html(result);
   }

    function onMenu() {
    	 if($("#category").css("display") == "none"){   
    		$('#category').css('display','block');
    	 } else {
    		 $('#category').css('display','none');
    	 }
    }

    </script>
</head>
<body>
<!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
    <div class="container">
      <a class="navbar-brand js-scroll-trigger" href="/main">Mentos Main</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
        <c:if test="${id == null}">
          <li class="nav-item">
         <a class="nav-link js-scroll-trigger"  href="/main/joinForm">회원가입</a>
          </li>
          <li class="nav-item">
             <a class="nav-link js-scroll-trigger"  href="/main/loginForm">로그인</a>
          </li>
       </c:if>
          <c:if test="${id != null}">
         <div style="color:yellow; ">${id} </div>
        <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="/mypage/modifyForm">정보수정</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="/main/logout">로그아웃</a>
          </li>
       </c:if>
          <li class="nav-item">
             <a class="nav-link js-scroll-trigger"  href="/main/service">서비스안내</a>
          </li>
          <li class="nav-item">
             <a class="nav-link js-scroll-trigger"  href="/cs/cs">고객센터</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
   <header class="primary text-white" style='text-align: center;'>
  <div class="user_area" style='display: inline-block;'>
    <ul class="list-group list-group-horizontal">
     <li class="list-group-item">
      <form class="search_form" action="/class/list" method="GET">
            <label for="searchInput">검색할 모임을 입력해주세요.</label>
            <input type="text" id="searchInput" class="search_input" name="s" value="" title="키워드로 모임을 검색하세요" data-event="200760">
            <input type="submit" class="btn_search" value="검색" title="검색">
       </form>
      </li>

	  <li class="list-group-item"><div class="dropdown">
			  <a class="btn btn-secondary dropdown-toggle" href="/mypage/mypage" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			    마이페이지
			  </a>
			  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				<a class="dropdown-item" href="/mypage/main">마이페이지</a>
				<a class="dropdown-item" href="/mypage/modifyForm">회원정보수정</a>
				<a class="dropdown-item" href="/mypage/modifyPwForm">비밀번호변경</a>
				<a class="dropdown-item" href="/mypage/memberClass">신청내역</a>
				<a class="dropdown-item" href="/mypage/memberPay">결제내역</a>
				<a class="dropdown-item" href="/mypage/">찜내역</a>

           </div>
			</div></li>
	   <li class="list-group-item"><a href="/class/write_view">모임개설</a></li>
     <li class="list-group-item"><a href="#">모임관리</a></li>

	  <%if(id != null) {%>
	  <script type="text/javascript">
		$(document).ready(function() {
			//alram();	
		});
	</script>
	  <li class="list-group-item"><a href="/account/login?returnUrl=/">알림</a></li>
	  <%} %>
	</ul>

</div>
<div style='text-align: center;'>
		<div style="margin:30px;">
		  <ul class="list-group list-group-horizontal">
    		 <li class="list-group-item">
			<p>
			<button class="btn" type="button" onclick="onMenu()">카테고리</button>
			</p>
			</li>
 		 	 <li class="list-group-item">
 		 	<a href="#">베스트</a>
 		 	</li>
 		 	<li class="list-group-item">
 		 	<a href="/place/place_list">장소</a>
 		 	</li>
 		  </ul>
		    <div class="collapse" id="category">
		      <div class="card-horizontal">
		      	<div style="colur:#FFFFFF; text-align: left; float:left;">
		      		<a href="#">분류</a>
		      		 <ul class="list-group list-group-horizontal">
    					  <li class="list-group-item"><a href="#">베스트1</a></li>
    					  <li class="list-group-item"><a href="#">베스트2</a></li>
    					  <li class="list-group-item"><a href="#">베스트3</a></li>
    					  <li class="list-group-item"><a href="#">베스트4</a></li>
					</ul>
					<ul class="list-group list-group-horizontal">		    					  
    					  <li class="list-group-item"><a href="#">베스트5</a></li>
    					  <li class="list-group-item"><a href="#">베스트6</a></li>
    					  <li class="list-group-item"><a href="#">베스트7</a></li>
    					  <li class="list-group-item"><a href="#">베스트8</a></li>
    				</ul>
					<ul class="list-group list-group-horizontal">
    					  <li class="list-group-item"><a href="#">베스트9</a></li>
    					  <li class="list-group-item"><a href="#">베스트10</a></li>
    					  <li class="list-group-item"><a href="#">베스트11</a></li>
    					  <li class="list-group-item"><a href="#">베스트12</a></li>
					</ul>
		      	</div>
		      	<div style="colur:#FFFFFF; text-align: left; float:left;">
		      		<a href="#">지역</a>
		      		<ul class="list-group list-group-horizontal">
		      			<li class="list-group-item"><a href="#">서울</a></li>
    					<li class="list-group-item"><a href="#">인천/경기</a></li>
    					<li class="list-group-item"><a href="#">대전/충청/세종</a></li>
		      		</ul>
		      		<ul class="list-group list-group-horizontal">
		      			<li class="list-group-item"><a href="#">부산/울산/경남</a></li>
    					<li class="list-group-item"><a href="#">광주/전라</a></li>
    					<li class="list-group-item"><a href="#">대구/경북</a></li>
		      		</ul>
		      		<ul class="list-group list-group-horizontal">
		      			<li class="list-group-item"><a href="#">강원</a></li>
    					<li class="list-group-item"><a href="#">제주</a></li>
    					<li class="list-group-item"><a href="#">기타지역</a></li>
		      		</ul>
		      	</div>
		      </div>	
 		 	</div>
 		 </div>
	</div>
	 </header>

</body>
</html>
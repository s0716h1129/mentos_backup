<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <!-- Bootstrap core CSS -->
  <link href="../resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
<%-- 	
<form action="findIdPw" method="post">
			<h3>아이디 찾기</h3>
			<p>
				<label>Name</label>
				<input type="text" id="name" name="name">
			</p>
			<p>
				<label>PhoneNumber</label>
				<input type="text" id="phoneNumber" name="phoneNumber">
			</p>
			<p>
				<button type="submit" id=findBtn >find</button>
				<button type="button" onclick="history.go(-1);">Cancel</button>
			</p>
	</form>
	<c:if test="${id != null}">
			<h5>
				${ id }
			</h5>
	</c:if>
	
	<form action="find_pw" method="post">
<div class="w3-content w3-container w3-margin-top">
	<div class="w3-container w3-card-4">
		<div class="w3-center w3-large w3-margin-top">
			<h3>비밀번호 찾기</h3>
		</div>
		<div>
			<p>
				<label>Email</label>
				<input class="w3-input" type="text" id="email" name="email" required>
			</p>
			<p class="w3-center">
				<button type="submit" id=findBtn >find</button>
				<button type="button" onclick="history.go(-1);" >Cancel</button>
			</p>
		</div>
	</div>
</div>
</form>
<a href="joinForm">join</a> &nbsp;&nbsp;&nbsp;
<a href="main">main</a> &nbsp;&nbsp;&nbsp;
 --%>
<div class="container">
    <div class="row">
      <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
        <div class="card card-signin my-5">
          <div class="card-body">
            <h5 class="card-title text-center">findIdPw</h5>
            <form class="form-signin" action="findIdPw" method="post">
               <div class="form-label-group">
                <label for="name">name</label>
                <input type="text" id="name" name="name" class="form-control" placeholder="name" required>
              </div>
               <div class="form-label-group">
                <label for="phoneNumber">phoneNumber</label>
                <input type="password" id="phoneNumber" name="phoneNumber" value="${dto.phonenumber}" class="form-control" placeholder="phonenumber" required>
              </div>
              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit" id=findBtn >findId</button>
              <hr class="my-4">
			    <a href="loginForm" class="btn btn-primary">login</a> &nbsp;&nbsp;&nbsp;
			    <a href="joinForm" class="btn btn-primary">join</a> &nbsp;&nbsp;&nbsp;
			    <a href="../main" class="btn btn-primary">main</a> &nbsp;&nbsp;&nbsp;
            </form>
             <form class="form-signin" action="find_pw" method="post">
               <div class="form-label-group">
                <label for="email">email</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="email" required>
              </div>
              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit"id=findBtn>find Pw</button>
              <hr class="my-4">
			    <a href="loginForm" class="btn btn-primary">login</a> &nbsp;&nbsp;&nbsp;
			    <a href="joinForm" class="btn btn-primary">join</a> &nbsp;&nbsp;&nbsp;
			    <a href="../main" class="btn btn-primary">main</a> &nbsp;&nbsp;&nbsp;
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
 
  <!-- Bootstrap core JavaScript -->
  <script src="../resources/vendor/jquery/jquery.min.js"></script>
  <script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Plugin JavaScript -->
  <script src="../resources/vendor/jquery-easing/jquery.easing.min.js"></script>
</body>
</html>
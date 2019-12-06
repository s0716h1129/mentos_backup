<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%
	String id = (String)session.getAttribute("id");
	String profile_image = (String)session.getAttribute("profile_image");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <!-- Bootstrap core CSS -->
  <link href="../resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
	<%-- <form action="joinForm" method="post">
		이메일 : <input type="text" id="email" name="email" value="${dto.email}"  >	<br>
		<c:if test="<%=id == null %>">
			아이디 : <input type="text" id="id" name="id" value="${dto.memberid}"> <br>
			비밀번호 : <input type="password" id="pw" name="pw" value="${dto.password}"  > <br>
			비밀번호 확인 : <input type="password" id="pw_check" name="pw"  > <br>
			image : <input type="text" id="image" name="image" value="${dto.member_image}"  >	<br>
		</c:if>
		닉네임 : <input type="text" id="nickname" name="nickname" value="${dto.nickname}"  >	<br>
		전화번호 : <input type="text" id="phoneNumber" name="phoneNumber" value="${dto.phonenumber}"  >	<br>
		<input type="submit" value="회원가입" > &nbsp;&nbsp;&nbsp;
	</form>
	<a href="loginForm">login</a> &nbsp;&nbsp;&nbsp;
	<c:if test="<%=id == null %>">
		<a href="../main">main</a> &nbsp;&nbsp;&nbsp;
	</c:if> --%>
<div class="container">
    <div class="row">
      <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
        <div class="card card-signin my-5">
          <div class="card-body">
            <h5 class="card-title text-center">Join In</h5>
            <form class="form-signin" action="joinForm" method="post">
              <div class="form-label-group">
                <label for="inputEmail">Email address</label>
                <input type="email" name="email" value="${dto.email}"  id="inputEmail" class="form-control" placeholder="Email address" required autofocus>
              </div>
              <div class="form-label-group">
                <label for="inputPassword">Password</label>
                <input type="password" name="pw" value="${dto.password}" id="inputPassword" class="form-control" placeholder="Password" required>
              </div>
               <div class="form-label-group">
                <label for="inputPasswordCheck">PasswordCheck</label>
                <input type="password" name="MemberPw" id="inputPasswordCheck" class="form-control" placeholder="PasswordCheck" required>
              </div>
               <div class="form-label-group">
                <label for="nickname">nickname</label>
                <input type="text" id="nickname" name="nickname" value="${dto.nickname}" class="form-control" placeholder="nickname" required>
              </div>
               <div class="form-label-group">
                <label for="phoneNumber">phoneNumber</label>
                <input type="password" id="phoneNumber" name="phoneNumber" value="${dto.phonenumber}" class="form-control" placeholder="phonenumber" required>
              </div>
              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">Join in</button>
              <hr class="my-4">
                <a href="findIdPw" class="btn btn-primary">findID / PW</a> &nbsp;&nbsp;&nbsp;
			    <a href="loginForm" class="btn btn-primary">login</a> &nbsp;&nbsp;&nbsp;
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
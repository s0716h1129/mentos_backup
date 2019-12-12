<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LoginForm</title>
</head>
<body>
<%@include file ="header.jsp" %>
<%if(id != null) %>
<jsp:forward page="/main"/>
<div class="container">
    <div class="row">
      <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
        <div class="card card-signin my-5">
          <div class="card-body">
            <h5 class="card-title text-center">Sign In</h5>
            <c:url value="../j_spring_security_check"  var="loginUrl" />
            <form class="form-signin" action="${loginUrl}" method="post">
              <c:if test="${param.error != null}">
					<p>
						Login Error! <br />
						${error_message}
					</p>
			  </c:if>
              <div class="form-label-group">
                <input type="email" name="MemberId" value="${username}" id="inputEmail" class="form-control" placeholder="Email address" required autofocus>
                <label for="inputEmail">Email address</label>
              </div>

              <div class="form-label-group">
                <input type="password" name="MemberPw" id="inputPassword" class="form-control" placeholder="Password" required>
                <label for="inputPassword">Password</label>
              </div>

              <div class="custom-control custom-checkbox mb-3">
                <input type="checkbox" class="custom-control-input" id="customCheck1">
                <label class="custom-control-label" for="customCheck1">Remember password</label>
              </div>
              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">Sign in</button>
              <hr class="my-4">
                <a href="findIdPw" class="btn btn-primary">findID / PW</a> &nbsp;&nbsp;&nbsp;
			    <a href="joinForm" class="btn btn-primary">join</a> &nbsp;&nbsp;&nbsp;
			    <a href="../main" class="btn btn-primary">main</a> &nbsp;&nbsp;&nbsp;
              <!-- <button class="btn btn-lg btn-google btn-block text-uppercase" type="submit"><i class="fab fa-google mr-2"></i> Sign in with Google</button> -->
              <a href="https://kauth.kakao.com/oauth/authorize?client_id=a68c8c847423a2284c6e8b645f7060cd&redirect_uri=http://localhost:8081/main/login&response_type=code">
            	<img src="/img/kakao_account_login_btn_medium_narrow.png">
    		  </a>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
 
<%@include file ="footer.jsp" %>
</body>
</html>
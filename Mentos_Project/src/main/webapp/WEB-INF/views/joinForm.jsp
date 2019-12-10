<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%
	String snscheck = (String)session.getAttribute("snscheck");
	String profile_image = (String)session.getAttribute("profile_image");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

</head>
<body>
<%@include file ="header.jsp" %>

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
              <c:if test="<%=snscheck == null %>">
              <div class="form-label-group">
                <label for="inputPassword">Password</label>
                <input type="password" name="pw" value="${dto.password}" id="inputPassword" class="form-control" placeholder="Password" required>
              </div>
               <div class="form-label-group">
                <label for="inputPasswordCheck">PasswordCheck</label>
                <input type="password" name="MemberPw" id="inputPasswordCheck" class="form-control" placeholder="PasswordCheck" required>
              </div>
              </c:if>
               <div class="form-label-group">
                <label for="nickname">nickname</label>
                <input type="text" id="nickname" name="nickname" value="${dto.nickname}" class="form-control" placeholder="nickname" required>
              </div>
               <div class="form-label-group">
                <label for="phoneNumber">phoneNumber</label>
                <input type="text" id="phoneNumber" name="phoneNumber" value="${dto.phonenumber}" class="form-control" placeholder="phonenumber" required>
              </div>
              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">Join in</button>
              <hr class="my-4">
                <a href="findIdPw" class="btn btn-primary">findID / PW</a> &nbsp;&nbsp;&nbsp;
			    <a href="loginForm" class="btn btn-primary">login</a> &nbsp;&nbsp;&nbsp;
			    <c:if test="<%=snscheck == null %>">
			    <a href="../main" class="btn btn-primary">main</a> &nbsp;&nbsp;&nbsp;
			    </c:if>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>

<%@include file ="footer.jsp" %>
</body>
</html>
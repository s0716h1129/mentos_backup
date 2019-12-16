<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file ="header.jsp" %>
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
                <input type="text" id="phoneNumber" name="phoneNumber" value="${dto.phonenumber}" class="form-control" placeholder="phonenumber" required>
              </div>
              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit" id=findBtn >findId</button>
              <c:if test="${id != null}">
					<h5>
						아이디는 ${ id }
					</h5>
			</c:if>
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
<%@include file ="footer.jsp" %>
</body>
</html>
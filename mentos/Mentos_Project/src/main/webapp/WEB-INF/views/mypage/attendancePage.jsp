<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Attendance Page</title>

<style>
	#container {
	  display: flex;
	}
	#box-left {
		border-style: solid;
		border-width: 1px;
		text-align: right;
		flex: 3;
	}
	#box-center {
		border-style: solid;
		border-width: 1px;
		text-align: right;
		flex: 3;
		text-align: center;
	}
	#box-right {
		border-style: solid;
		border-width: 1px;
		text-align: right;
		flex: 1;
		text-align: right;
	}
</style>

</head>
<body>

	<div id='container'>
	    <div id='box-left'>왼쪽</div>
	    <div id='box-center'>가운데</div>
	    <div id='box-right'>오른쪽</div>
	</div>
</body>
</html>
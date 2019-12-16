<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyPage Class List</title>
</head>
<body>
	<h1>마이 페이지 - 결제 내역 보기</h1> <br><br>

	<h3> 강좌 결제 내역 </h3>
	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
		<tr>
			<td> 결제 강좌 </td>
			<td> 결제 금액 </td>
			<td> 결제 일 </td>
			<td> 환불 여부 </td>
		</tr>
		
        <c:forEach items="${classPay}" var="cdto">
			<tr>
				<td> ${cdto.class_name} </td>
				<td> ${cdto.pay_price} </td>
				<td> ${cdto.pay_date} </td>
				<td> ${cdto.refund} </td>
			</tr>
		</c:forEach>
	</table>
	
	<h3> 장소 결제 내역 </h3>
	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
		<tr>
			<td> 결제 장소 </td>
			<td> 결제 금액 </td>
			<td> 결제 일 </td>
			<td> 환불 여부 </td>
		</tr>
		
		<c:forEach items="${placePay}" var="ppay">
		<tr>
			<td> ${ppay.place_name}</td>
			<td> ${ppay.pay_price} </td>
			<td> ${ppay.pay_date} </td>
			<td> ${ppay.refund} </td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>
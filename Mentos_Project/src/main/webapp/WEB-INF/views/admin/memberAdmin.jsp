<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery.js"></script>
<title>MembeAdmin</title>

<style>
	#container {
	}
	#left {
		border-style: solid;
		border-width: 1px;
		width:80%;
	}
	#right {
		border-style: solid;
		border-width: 1px;
		text-align: right;
		width:20%;
	}
</style>

<script>
	// 비밀번호 변경
	function changePw() {
		if ($('#pId').val().length == 0) {
			alert("변경 할 아이디를 입력해주세요.");
			$('#pId').focus();
			return;
		}
		
		if ($('#pw').val().length == 0) {
			alert("변경 할 비밀번호를 입력해주세요.");
			$('#pw').focus();
			return;
		}
		
		if ($('#pw').val().length < 8) {
			alert("비밀번호는 8자리 이상 입력해주세요.");
			$('#pw').focus();
			return;
		}
		
		if ($('#checkPw').val().length == 0) {
			alert("변경 할 비밀번호를 입력해주세요.");
			$('#checkPw').focus();
			return;
		}
		
		if ($('#pw').val() != $('#checkPw').val()) {
			alert("비밀번호 확인과 일치하지 않습니다.");
			$('#pw').focus();
			return;
		}
		
		submit_ajax();
	}
	
	function submit_ajax() {
		var queryString = $("#pw-form").serialize();
		$.ajax({
			url: './pwModify',
			type: 'POST',
			data: queryString,
			dataType: 'text',
			success: function(json) {
				var result = JSON.parse(json);
				if (result.code == "success") {
					alert(result.desc)
					window.location.replace("./main?type=member")
				} else {
					alert(result.desc)
				}
				
			}
		});
	}
	
	
	// 계정 정지, 삭제, 블랙 리스트
	function mState() {
		if ($('#sId').val().length == 0) {
			alert("변경 할 아이디를 입력해주세요.");
			$('#sId').focus();
			return;
		}
		
		submit_mState();
		
	}
	
	function submit_mState() {
		var queryString = $("#state-form").serialize();
		$.ajax({
			url: './stateAjax',
			type: 'POST',
			data: queryString,
			dataType: 'text',
			success: function(json) {
				var result = JSON.parse(json);
				
				
				if (result.code == "success") {
					if ($('#sState').val() == 'stop') {
						var con = confirm("일정 기간 동안 계정을 정지 하겠습니까");
						if (con == true) {
							var date = prompt("정지 기간을 정해주세요.", "7");
							window.location.replace("./memberState?type=member&sType=stop&mId="+$('#sId').val()+"&date="+date)
						} else if (con == false) {
							alert("취소되었습니다.")
							return;
						}
						
					}else if ($('#sState').val() == 'allStop') {
						var con = confirm("계정을 영구 정지 하겠습니까");
						if (con == true) {
							window.location.replace("./memberState?type=member&sType=allStop&mId="+$('#sId').val())
						} else if (con == false) {
							alert("취소되었습니다.")
							return;
						}
						
					} else if ($('#sState').val() == 'delete') {
						var con = confirm("계정을 탈퇴 시키겠습니까");	
						if (con == true) {
							window.location.replace("./memberState?type=member&sType=delete&mId="+$('#sId').val())
						} else if (con == false) {
							alert("취소되었습니다.")
							return;
						}
						
					} else if ($('#sState').val() == 'blackList') {
						var con = confirm("블랙리스트 처리하시겠습니까");	
						if (con == true) {
							window.location.replace("./memberState?type=member&sType=blackList&mId="+$('#sId').val())
						} else if (con == false) {
							alert("취소되었습니다.")
							return;
						}	
						
					} else if ($('#sState').val() == 'member') {
						var con = confirm("일반 회원으로 전환시키겠습니까");	
						if (con == true) {
							window.location.replace("./memberState?type=member&sType=member&mId="+$('#sId').val())
						} else if (con == false) {
							alert("취소되었습니다.")
							return;
						}	
					}
				} else {
					alert(result.desc)
				}
				
			}
		});
	}
	
</script>

</head>
<body>
	회원 관리
	
	<form action="memberSerch">
		<input type="text" id="mId" name="mId"> &nbsp;
		<input type="submit" value="검색">		
		<input type="hidden" id="type" name="type" value="member">
		<input type="hidden" id="menu" name="menu" value="">
	</form>
	
	<div id='container'>
	    <div id='left'>
	    <table width="500" cellpadding="0" cellspacing="0" border="1">
	    	<tr>
	    		<th> 아이디 </th>
	    		<th> 이름 </th>
	    		<th> 전화번호 </th>
	    		<th> 포인트 </th>
	    		<th> 등급 </th>
	    		<th> 결제 내역 </th>
	    		<th> 계정 상태 </th>
	    		<c:if test ="${serList.member_state eq 'ROLE_DATE_STOP'}">
	    		<th> 일시 정지 풀리는 날짜 </th>
	    		</c:if>
	    	</tr>

			<tr>
			   	<td> ${serList.email} </td>
			   	<td> ${serList.nickname} </td>	
			   	<td> ${serList.phonenumber} </td>
		   		<td> ${serList.point} </td>
		   		<td> ${serList.member_score} </td>
		   		<td> <a href="./memberSerch?type=member&menu=pay&mId=${param.mId}"> ${payCount} </a> </td>
		  		<td> 
			  		<c:if test= "${serList.member_state eq 'ROLE_MEMBER'}">
			  			일반 회원
			  		</c:if>
			  		<c:if test= "${serList.member_state eq 'ROLE_ADMIN'}">
			  			관리자
			  		</c:if>
			  		<c:if test= "${serList.member_state eq 'ROLE_STOP'}">
			  			계정 영구 정지
			  		</c:if>
			  		<c:if test= "${serList.member_state eq 'ROLE_DATE_STOP'}">
			  			계정 일시 정지
			  		</c:if>
			  		<c:if test= "${serList.member_state eq 'ROLE_LEAVE'}">
			  			탈퇴
			  		</c:if>
			  		<c:if test= "${serList.member_state eq 'ROLE_BLACKLIST'}">
			  			블랙리스트
			  		</c:if>
		  		</td>
		  		<c:if test ="${serList.member_state eq 'ROLE_DATE_STOP'}">
	    		<td> ${serList.stop_day} </td>
	    		</c:if>
			</tr>	
	
	    </table>


	    <c:if test="${param.menu eq 'cPw'}">
 	    	<hr><br>
		    비밀번호 변경
			<form id="pw-form">
				아이디 : <input type="text" id="pId" name="pId"><br>
				변경 비밀번호 : <input type="password" id="pw" name="pw"><br>
				변경 비밀번호 확인 : <input type="password" id="checkPw" name="checkPw"><br>
				<input type="button" onclick="changePw()" value="비밀번호 변경"><br>
			</form>
	   	</c:if>
	   	
	   	<c:if test="${param.menu eq 'cState'}">
	   		<hr><br>
	   		<form id="state-form">
	   			항목 선택하고 아이디를 입력해주세요.<br>
	    		<select id="sState" name="sState">
	    			<option value="stop" selected=selected> 단기 정지 </option>
	    			<option value="allStop"> 영구 정지 </option>
	    			<option value="delete"> 계정 탈퇴 </option>
	    			<option value="blackList"> 블랙리스트 </option>
	    			<option value="member"> 일반 회원으로 전환 </option>
	    		</select>	   		
	    		<input type="text" id="sId" name="sId">
	    		<input type="button" onclick="mState()" value="실행"><br>
	    	</form>
	   	
	   	</c:if>
	   	
	   	<c:if test="${param.menu eq 'pay'}">
	   		<hr><br>
	   		<h2> 강좌 결제 내역 </h2>
	   		<table width="500" cellpadding="0" cellspacing="0" border="1">
	   			<tr>
	   				<th> 결제 내역 </th>
	   				<th> 결제 금액 </th>
	   				<th> 결제일 </th>
	   				<th> 환불 </th>
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
		   	
		   	<br> <h2> 장소 결제 내역 </h2>
		   	<table width="500" cellpadding="0" cellspacing="0" border="1">
	   			<tr>
	   				<th> 결제 내역 </th>
	   				<th> 결제 금액 </th>
	   				<th> 결제일 </th>
	   				<th> 환불 </th>
	   			</tr>
	   			
	   			<c:forEach items="${placePay}" var="pdto">
	   			<tr>
	   				<td> ${pdto.place_name} </td>
	   				<td> ${pdto.pay_price} </td>
	   				<td> ${pdto.pay_date} </td>
	   				<td> ${pdto.refund} </td>
	   			</tr>
	   			</c:forEach>
		   	</table>
	   	</c:if>

	    </div>
	    <div id='right'>
	    	<button type="button" onclick="location.href='./memberSerch?type=member&menu=cState&mId=${param.mId}'"> 회원 정지 / 삭제 / 블랙리스트 </button> <br><br>
			<button type="button" onclick=""> 회원 등급 변경</button> <br><br>
			<button type="button" onclick="location.href='./memberSerch?type=member&menu=cPw&mId=${param.mId}'"> 회원 비밀번호 변경 </button> <br><br>
	    </div>
	</div>
</body>
</html>
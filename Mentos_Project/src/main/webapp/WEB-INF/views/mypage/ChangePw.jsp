<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery.js"></script>
<title>Change Password</title>

<script>
	function check() {
		if ($('#changePw').val().length == 0) {
			alert("변경 할 비밀번호를 입력해주세요.");
			$('#changePw').focus();
			return;
		}
		
		if ($('#changePw').val().length < 8) {
			alert("비밀번호는 8자리 이상 입력해주세요.");
			$('#changePw').focus();
			return;
		}
		
		if ($('#checkPw').val().length == 0) {
			alert("변경 할 비밀번호를 입력해주세요.");
			$('#checkPw').focus();
			return;
		}
		
		if ($('#changePw').val() != $('#checkPw').val()) {
			alert("비밀번호 확인과 일치하지 않습니다.");
			$('#changePw').focus();
			return;
		}
		
		if ($('#pw').val().length == 0) {
			alert("비밀번호를 입력해주세요.");
			$('#pw').focus();
			return;
		}
		
		submit_ajax();
	}
	
	function submit_ajax() {
		var queryString = $("#my-form").serialize();
		$.ajax({
			url: '/modifyAjaxPw',
			type: 'POST',
			data: queryString,
			dataType: 'text',
			success: function(json) {
				var result = JSON.parse(json);
				if (result.code == "success") {
					alert(result.desc)
					window.location.replace("/mypage")
				} else {
					alert(result.desc)
				}
				
			}
		});
	}
	
</script>
</head>
<body>
	<h1> 비밀번호 변경 </h1>
	
	<form id="my-form" method="post">
		변경할 비밀번호 : <input type="password" name="changePw" id="changePw"> <br>
		비밀번호 확인 : <input type="password" name="checkPw" id="checkPw"> <br>
		기존 비밀번호 : <input type="password" name="pw" id="pw"> <br>

		<input type="button" onclick="check()" value="완료"> &nbsp;
		<button type="button" onclick="location.href='mypage'">취소</button>
	</form>
	
</body>
</html>
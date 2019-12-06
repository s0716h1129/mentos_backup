<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery.js"></script>
<title>Member Leave</title>

<script>
	function check() {
		if ($('#mId').val().length == 0) {
			alert("아이디를 입력해주세요.");
			$('#mId').focus();
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
			url: '/memberLeaveAjax',
			type: 'POST',
			data: queryString,
			dataType: 'text',
			success: function(json) {
				var result = JSON.parse(json);
				
				if (result.code == "success") {
					var con = confirm(result.desc)
					
					if (con == true) {
						alert("탈퇴 처리하였습니다.");
						window.location.replace("/memberLeave")
					} else if (con == false) {
						alert("탈퇴를 취소하였습니다.");
						window.location.replace("/mypage")
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
	<h1> 회원 탈퇴</h1>

	<form id="my-form" method="post">
		아이디 : <input type="text" name="mId" id="mId"> <br>
		비밀번호 : <input type="password" name="pw" id="pw"> <br>
		
		<input type="button" onclick="check()" value="완료"> &nbsp;
		<button type="button" onclick="location.href='mypage'">취소</button>
	</form>
</body>
</html>
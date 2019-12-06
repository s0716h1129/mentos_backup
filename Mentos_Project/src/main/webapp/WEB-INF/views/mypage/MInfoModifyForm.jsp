<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery.js"></script>
<title>Member Information Modify</title>

<script>
	function check() {
		if ($('#pw').val().length == 0) {
			alert("비밀번호를 입력해주세요.");
			$('#pw').focus();
			return;
		}
		
		if ($('#eMail').val().length == 0) {
			alert("이메일을 입력해주세요.");
			$('#eMail').focus();
			return;
		}
		
		if ($('#eMail').val().length < 10) {
			alert("올바른 이메일을 입력해주세요.");
			$('#eMail').focus();
			return;
		}
		
		submit_ajax();
	}
	
	function submit_ajax() {
		var queryString = $("#my-form").serialize();
		$.ajax({
			url: '/modifyAjax',
			type: 'POST',
			data: queryString,
			dataType: 'text',
			success: function(json) {
				var result = JSON.parse(json);
				if (result.code == "success") {
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
	<h1> 회원 정보 수정 </h1><br><br>
	
	아이디 : ${infoDto.id}<br>
	닉네임 : ${infoDto.nickname} <br>
	전화 번호 : ${infoDto.phonenumber} <br>
	<form id="my-form" method="post">
		자기 소개 : <input type="text" id="mIntro" name="mIntro" value="${infoDto.member_intro}"> <br>
		이메일 : <input type="text" id="eMail" name="eMail" value="${infoDto.email}"> <br>
		관심 지역 : <input type="text" id="intArea" name="intArea" value="${infoDto.interest_area}"> <br>
		관심 분야 : <input type="text" id="intMajor" name="intMajor" value="${infoDto.interest_major}"> <br>
		관심 직군 : <input type="text" id="intGroup" name="intGroup" value="${infoDto.interest_group}"> <br>
		비밀번호 확인 : <input type="password" id="pw" name="pw"> <br><br>
		
		<input type="hidden" name="mId" value="${infoDto.id}">
		
		<input type="button" onclick="check()" value="완료"> &nbsp;
		<button type="button" onclick="location.href='mypage'">취소</button> &nbsp;
	</form>

</body>
</html>
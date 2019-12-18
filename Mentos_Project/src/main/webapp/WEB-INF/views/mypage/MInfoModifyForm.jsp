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

		
		submit_ajax();
	}
	
	function submit_ajax() {
		var queryString = $("#my-form").serialize();
		$.ajax({
			url: './modifyAjax',
			type: 'POST',
			data: queryString,
			success: function(data) {
				var result = JSON.parse(data);
				if (result.code == "success") {
					window.location.replace("/mypage");
				} else {
					alert(result.desc)
				}
				
			}
		});
	}
</script>
</head>
<body>
	<%@include file ="../header.jsp" %>	
	
	<div class="container" style="text-align: center;">
		<div class="card">
	    	<div class="card-header">
	    		<i class="fas fa-table"></i>
				<h1> 회원 정보 수정 </h1>
			</div>
			<ul class="list-group list-group-flush">
				<li class="list-group-item">
					아이디 : ${infoDto.email} <br>
					닉네임 : ${infoDto.nickname} <br>
					전화 번호 : ${infoDto.phonenumber} <br>
					<form id="my-form" method="post">
						<div class="input-group mb-3">
						  <div class="input-group-prepend">
						    <span class="input-group-text" id="basic-addon1">자기 소개</span>
						  </div>
						  <input type="text" id="mIntro" name="mIntro" class="form-control" value="${infoDto.member_intro}" placeholder="${infoDto.member_intro}" aria-describedby="basic-addon1">
						</div>
						
						<div class="input-group mb-3">
						  <div class="input-group-prepend">
						    <span class="input-group-text" id="basic-addon1">관심지역</span>
						  </div>
						  <input type="text" id="intArea" name="intArea" class="form-control" value="${infoDto.interest_area}" placeholder="${infoDto.interest_area}" aria-describedby="basic-addon1">
						</div>
						
						<div class="input-group mb-3">
						  <div class="input-group-prepend">
						    <span class="input-group-text" id="basic-addon1">관심 분야</span>
						  </div>
						  <input type="text" id="intMajor" name="intMajor" class="form-control" value="${infoDto.interest_major}" placeholder="${infoDto.interest_major}" aria-describedby="basic-addon1">
						</div>
						
						<div class="input-group mb-3">
						  <div class="input-group-prepend">
						    <span class="input-group-text" id="basic-addon1">관심 직군</span>
						  </div>
						  <input type="text" id="intGroup" name="intGroup" class="form-control" value="${infoDto.interest_group}" placeholder="${infoDto.interest_group}" aria-describedby="basic-addon1">
						</div>
						
						<div class="input-group mb-3">
						  <div class="input-group-prepend">
						    <span class="input-group-text" id="basic-addon1">비밀번호 재입력</span>
						  </div>
						  <input type="password"  id="pw" name="pw" class="form-control" aria-describedby="basic-addon1">
						</div>
						
						<input type="hidden" name="mId" value="${infoDto.email}">
					</form>
	    		</li>
	    	</ul>
	    	
	    	<div class="card-body">
	  			<input type="button" onclick="check()" value="완료" class="card-link"> &nbsp;
	    		<a href="#" onClick="history.back()">이전페이지로</a> &nbsp;
	  		</div>
		</div>
	</div><br>
	
	아이디 : ${infoDto.email}<br>
	닉네임 : ${infoDto.nickname} <br>
	전화 번호 : ${infoDto.phonenumber} <br>
	<form id="my-form" method="post">
		자기 소개 : <input type="text" id="mIntro" name="mIntro" value="${infoDto.member_intro}"> <br>
		이메일 : <input type="text" id="eMail" name="eMail" value="${infoDto.email}"> <br>
		관심 지역 : <input type="text" id="intArea" name="intArea" value="${infoDto.interest_area}"> <br>
		관심 분야 : <input type="text" id="intMajor" name="intMajor" value="${infoDto.interest_major}"> <br>
		관심 직군 : <input type="text" id="intGroup" name="intGroup" value="${infoDto.interest_group}"> <br>
		비밀번호 확인 : <input type="password" id="pw" name="pw"> <br><br>
		
		<input type="hidden" name="mId" value="${infoDto.email}">
		
		<input type="button" onclick="check()" value="완료"> &nbsp;
		 <a href="#" onClick="history.back()">이전페이지로</a> &nbsp;
	</form>
	
	<%@include file ="../footer.jsp" %>

</body>
</html>
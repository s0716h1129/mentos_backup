<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
<!-- include summernote css/js-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="fileUp" action="rentDao" method="post" name="rental">	
		<table width="800" cellpadding="0" cellsapcing="0" border="1">
			<tr>
				<td>장소이름</td>
				<td><input type="text" name="place_name" placeholder="장소 이름" class=""></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="place_address" id="sample5_address" readonly placeholder="주소">
					<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색">
				</td>
			</tr>
			<tr>
				<td>수용인원</td>
				<td><input type="text" name="place_people_num"  placeholder="수용인원 수" class=""></td>
			</tr>
			<tr>
				<td>대여료</td>
				<td><input type="text" name="place_money"  placeholder="대여료" class=""></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="text" name="place_phone" placeholder="전화번호" class=""></td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="place_email" placeholder="이메일" class=""></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea id="summernote"  name="place_content" placeholder="장소정보" ></textarea>
				<script>	
					$('#summernote').summernote({
						height: 600,
						fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
						fontNamesIgnoreCheck : [ '맑은고딕' ],
						focus: true,
						
						callbacks: {
							onImageUpload: function(files, editor, welEditable) {
					            for (var i = files.length - 1; i >= 0; i--) {
					            	sendFile(files[i], this);
					            }
					        }
						}	
					});
					function sendFile(file, editor) {
						var form_data = new FormData();
					  	form_data.append('file', file);
					  	$.ajax({
					    	data: form_data,
					    	type: "POST",
					    	url: './imageUpload',
					    	cache: false,
					    	contentType: false,
					    	enctype: 'multipart/form-data',
					    	processData: false,
					    	success: function(img_name) {
					    		var obj = JSON.parse(img_name);
					    		var url = obj.url;
					    		console.log("img_name" + url);
					      		$(editor).summernote('editor.insertImage', url);
					    	},
					  		error : function(error) {
					  			console.log(error);
					  		}
					  	});
					}
					</script></td>
			</tr>
			<tr>
				<td>이미지</td>
				<td><input id="img" type="file" name="place_image" />
				<script>
				
				</script>
				</td>
			</tr>
			<tr>
				<td>전송</td>
				<td><input id="btnSubmit" type="submit" value="전송">
					<input type="button" value="취소" onclick="javascript:window.location='list'" /></td>
			</tr>
		</table>	
	</form>
	
	<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ea9f4a6ee158dc6b3bf6c48f1c63afe7"></script>
	<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });


    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }
	</script>
	
</body>
</html>
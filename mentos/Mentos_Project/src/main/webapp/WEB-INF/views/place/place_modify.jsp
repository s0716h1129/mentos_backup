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
<script>
	function File(){
	    var form = $('#modifyOk')[0];
	    var formData = new FormData(form);
	    formData.append("place_image_file", $("#place_image_file")[0].files[0]);
	    
	
	    $.ajax({
	    	data: formData,
	    	type: "POST",
	    	url: './imageUpload',
	    	cache: false,
	    	contentType: false,
	    	enctype: 'multipart/form-data',
	    	processData: false,
	        success: function(result){
	        	
	        	var obj = JSON.parse(result);
	    		var url = obj.url;
	    		alert("업로드 성공!! : " + url);
	 
	    		$('#img_source').attr('src',url);
	    		$('#place_image').val(url);
	        }
	    });
	}
</script>
<body>

<div class="container">

<form id="fileUp" action="modifyOk" method="post" name="rental">	
	<input type="hidden" name="place_number" value="${ dto.place_number }">
	<div class="form-group">
		<div style="float:left;" class="col-md-12">
			<h2>썸네일 이미지</h2>
		</div>
		<div class="form-row">
		
			<div class="form-group col-md-4">
				<div id="img" class="image-container">
				<img id="img_source">
				</div>
			</div>
			
			<div class="form-group col-md-12">
				<input type="file" id="place_image_file" name="place_image_file" size ="50" class="form-control"> <br>
				<div style="text-align:center;">
				<a href="javascript:File();" class="btn btn-primary btn-lg active" role="button">등록</a>
				</div>
				<input type="hidden" name="place_image" id="place_image">
			</div>
			
		</div>
	</div>
	
	<div class="form-group">
		<div style="float:left;" class="col-md-12">
			<label>공간유형</label>
		</div>
		<div class="form-group col-md-6">
			<select class="form-control" name="place_space">
				<option value="스터디">스터디</option>
				<option value="파티룸">파티룸</option>
				<option value="작업실">작업실</option>
				<option value="회의실">회의실</option>
			</select>
		</div>
	</div>
	
	<div class="form-group">
		<div style="float:left;" class="col-md-12">
			<label>대여 기간</label>
		</div>
		<div class="form-row">
			<div class="form-group col-md-2">
				<input type="date" name="place_receiveStartDate" class="form-control">		
			</div>
			<div class="form-group col-md-2">
				<select class="form-control" name="place_receiveStartTime">
					<option value="00:00">00:00</option>
					<option value="00:30">00:30</option>
					<option value="01:00">01:00</option>
					<option value="01:30">01:30</option>
					<option value="02:00">02:00</option>
					<option value="02:30">02:30</option>
					<option value="03:00">03:00</option>
					<option value="03:30">03:30</option>
					<option value="04:00">04:00</option>
					<option value="04:30">04:30</option>
					<option value="05:00">05:00</option>
					<option value="05:30">05:30</option>
					<option value="06:00">06:00</option>
					<option value="06:30">06:30</option>
					<option value="07:00">07:00</option>
					<option value="07:30">07:30</option>
					<option value="08:00">08:00</option>
					<option value="08:30">08:30</option>
					<option value="09:00">09:00</option>
					<option value="09:30">09:30</option>
					<option value="10:00">10:00</option>
					<option value="10:30">10:30</option>
					<option value="11:00">11:00</option>
					<option value="11:30">11:30</option>
					<option value="12:00" selected="selected">12:00</option>
					<option value="12:30">12:30</option>
					<option value="13:00">13:00</option>
					<option value="13:30">13:30</option>
					<option value="14:00">14:00</option>
					<option value="14:30">14:30</option>
					<option value="15:00">15:00</option>
					<option value="15:30">15:30</option>
					<option value="16:00">16:00</option>
					<option value="16:30">16:30</option>
					<option value="17:00">17:00</option>
					<option value="17:30">17:30</option>
					<option value="18:00">18:00</option>
					<option value="18:30">18:30</option>
					<option value="19:00">19:00</option>
					<option value="19:30">19:30</option>
					<option value="20:00">20:00</option>
					<option value="20:30">20:30</option>
					<option value="21:00">21:00</option>
					<option value="21:30">21:30</option>
					<option value="22:00">22:00</option>
					<option value="22:30">22:30</option>
					<option value="23:00">23:00</option>
					<option value="23:30">23:30</option>
				</select>
			</div>
			<div class="form-group col-md-2" style="text-align:left; vertical-align: middle;">
부터
			</div>
			<div class="form-group col-md-2">
				<input type="date" name="place_receiveEndDate" class="form-control">
			</div>
			<div class="form-group col-md-2">
				<select class="form-control" name="place_receiveEndTime">
					<option value="00:00">00:00</option>
					<option value="00:30">00:30</option>
					<option value="01:00">01:00</option>
					<option value="01:30">01:30</option>
					<option value="02:00">02:00</option>
					<option value="02:30">02:30</option>
					<option value="03:00">03:00</option>
					<option value="03:30">03:30</option>
					<option value="04:00">04:00</option>
					<option value="04:30">04:30</option>
					<option value="05:00">05:00</option>
					<option value="05:30">05:30</option>
					<option value="06:00">06:00</option>
					<option value="06:30">06:30</option>
					<option value="07:00">07:00</option>
					<option value="07:30">07:30</option>
					<option value="08:00">08:00</option>
					<option value="08:30">08:30</option>
					<option value="09:00">09:00</option>
					<option value="09:30">09:30</option>
					<option value="10:00">10:00</option>
					<option value="10:30">10:30</option>
					<option value="11:00">11:00</option>
					<option value="11:30">11:30</option>
					<option value="12:00" selected="selected">12:00</option>
					<option value="12:30">12:30</option>
					<option value="13:00">13:00</option>
					<option value="13:30">13:30</option>
					<option value="14:00">14:00</option>
					<option value="14:30">14:30</option>
					<option value="15:00">15:00</option>
					<option value="15:30">15:30</option>
					<option value="16:00">16:00</option>
					<option value="16:30">16:30</option>
					<option value="17:00">17:00</option>
					<option value="17:30">17:30</option>
					<option value="18:00">18:00</option>
					<option value="18:30">18:30</option>
					<option value="19:00">19:00</option>
					<option value="19:30">19:30</option>
					<option value="20:00">20:00</option>
					<option value="20:30">20:30</option>
					<option value="21:00">21:00</option>
					<option value="21:30">21:30</option>
					<option value="22:00">22:00</option>
					<option value="22:30">22:30</option>
					<option value="23:00">23:00</option>
					<option value="23:30">23:30</option>
				</select>
			</div>
			<div class="form-group col-md-2" style="text-align:left; vertical-align: middle;">
까지
			</div>
		</div>
	</div>

	<div class="form-group">
		<div style="float:left;" class="col-md-12">
			<label>대여 장소</label>
		</div>
		<div class="form-row">
			<div class="form-group col-md-12">
				<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색" class="form-control"><br>
				<input type="text" name="place" id="sample5_address" class="form-control" readonly placeholder="주소" value=" ${dto.place}">
				<input type="text" name="place_place" id="detail_address" class="form-control" placeholder="나머지 주소" value=" ${dto.place_place}">
				<div id="map" class="form-group col-md-12" style="height:500px; margin-top:10px; display:none"></div>
				
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
										
				                        $('#class_location').val(result.road_address.region_1depth_name);
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
			</div>
		</div>
	</div>
	
	<div class="form-group col-md-12">
		<label for="inputAddress2">아이디</label>
		<input type="text" name="place_email" value="${dto.place_email }" placeholder="이메일" class="form-control">
	</div>
	
	<div class="form-group col-md-12">
		<label for="inputAddress2">전화번호</label>
		<input type="text" name="place_phone" value="${dto.place_phone}" placeholder="전화번호" class="form-control">
	</div>
	
	<div class="form-group col-md-12">
		<label for="inputAddress2">장소 이름</label>
		<input type="text" name="place_name" placeholder="장소 이름" value="${dto.place_name }" class="form-control">
	</div>
	
	<div class="form-group col-md-12">
		<label for="inputAddress2">수용인원</label>
		<input type="text" name="place_people_num" value="${dto.place_people_num}"  placeholder="수용인원 수" class="form-control">
	</div>
	
		<div class="form-group col-md-12">
		<label for="inputAddress2">대여료</label>
		<input type="text" name="place_price" value="${dto.place_price}"  placeholder="대여료" class="form-control">
	</div>
	
	<div class="form-group col-md-12">
		<label for="inputAddress2">장소정보</label>
		<textarea id="summernote" name="place_content" class="form-control" placeholder="장소정보">${dto.place_content }</textarea> 
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
		</script>
		</div>
	<div class="form-group col-md-12">
		<button type="submit" class="btn btn-primary">등록</button>
	</div>
	
</form>	
</div>

</body>
</html>
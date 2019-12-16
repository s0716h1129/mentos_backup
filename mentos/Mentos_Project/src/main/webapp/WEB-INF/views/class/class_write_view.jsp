<%@include file ="../header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	

	function uploadFile(){
	 var form = $('#classWrite')[0];
	 var formData = new FormData(form);
	 formData.append("class_image_file", $("#class_image_file")[0].files[0]);
	 
	
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
	 		$('#class_image').val(url);
	}
	 });
	}

	
	$(function() {
	    $("input#class_payment").on("keyup", function() {
	    	var inputNumber = $('#class_payment').val();
	    	
	    	var reNumber = inputNumber.replace(/,/gi, "");
	    	
	    	console.log("inputNum : " + reNumber);
	    	
	    	function numberFormat(reNumber) {
	    		
	    		return reNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    	}
	    	
	    	$("#class_payment").val(numberFormat(reNumber));
	    });
	});

</script>

</head>
<body>

<div class="container">
	<form action="classWrite" method="post">
	<input type="hidden" name="class_state" value="true">
	<input type="hidden" id="class_location" name="class_location" value="true">
	<input type="hidden" id="class_location_x" name="class_location_x" value="true">
	<input type="hidden" id="class_location_y" name="class_location_y" value="true">
	
	<div class="form">
	
		<div class="form-group">
			<div style="float:left;" class="col-md-12">
				<label>썸네일 이미지</label>
			</div>
			<div class="form-row col-md-12" style="display: flex;">
				<div class="form-group col-md-8">
					<div id="img" class="image-container">
					<img id="img_source" style="width: 700px; height: 400px;">
					</div>
				</div>
				<div class="form-group col-md-4" style="position:relative;">
					<div style="position:absolute; right:0px; bottom:0px; text-align : right;">
						<input type="file" id="class_image_file" name="class_image_file" class="form-control" size = "50"> <br>
						<a href="javascript:uploadFile();" class="btn btn-primary btn-lg active" role="button">등록</a>
						<input type="hidden" name="class_image" id="class_image">
					</div>
				</div>
			</div>
		</div>
		
		<div class="form-group">
			<div style="float:left;" class="col-md-12">
				<label>카테고리 / 모임명</label>
			</div>
			<div class="form-row">
				<div class="form-group col-md-4">
					<select name="class_category" class="form-control">
						<option value="">카테고리 선택</option>
						<option value="교육">교육</option>
						<option value="강연">강연</option>
						<option value="문화/예술">문화/예술</option>
						<option value="방송/연예">방송/연예</option>
						<option value="전시/박람회">전시/박람회</option>
						<option value="패션/뷰티">패션/뷰티</option>
						<option value="여행">여행</option>
						<option value="취미">취미</option>
						<option value="기타">기타</option>
					</select>
				</div>
				<div class="form-group col-md-8">
					<input type="text" name="class_name" class="form-control">
				</div>
			</div>
		</div>
	
		<div class="form-group">
			<div style="float:left;" class="col-md-12">
				<label>모임 일시</label>
			</div>
			<div class="form-row">
				<div class="form-group col-md-2">
					<input type="date" name="class_startDate" class="form-control">		
				</div>
				<div class="form-group col-md-2">
					<select class="form-control" id="class_startTime" name="class_startTime">
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
					<input type="date" name="class_endDate" class="form-control">
				</div>
				<div class="form-group col-md-2">
					<select class="form-control" id="class_endTime"  name="class_endTime">
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
				<label>접수 기간</label>
			</div>
			<div class="form-row">
				<div class="form-group col-md-2">
					<input type="date" name="class_receiveStartDate" class="form-control">		
				</div>
				<div class="form-group col-md-2">
					<select class="form-control" name="class_receiveStartTime">
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
					<input type="date" name="class_receiveEndDate" class="form-control">
				</div>
				<div class="form-group col-md-2">
					<select class="form-control" name="class_receiveEndTime">
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
				<label>모임 장소</label>
			</div>
			<div class="form-row">
				<div class="form-group col-md-12">
					<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색" class="form-control"><br>
					<input type="text" id="sample5_address" placeholder="주소" class="form-control" readonly="readonly">
					<input type="text" id="detail_address" placeholder="나머지 주소" class="form-control">
					<input type="button" id="addressButton" value="주소 등록" class="form-control">
					<script type="text/javascript">
					$("#addressButton").on("click",function(){     
						var address = $('#sample5_address').val() + " " + $('#detail_address').val();
						console.log("address " +address);
						$("#class_place").val(address);
					});
					</script>
				</div>
				<br>
				<div class="form-group col-md-12">
					<input type="text" id="class_place" name="class_place" class="form-control"> 
				</div>
				<div id="map" class="form-group col-md-12" style="height:500px; margin-top:10px; display:none"></div>
				
				<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3e3bd2cc527b7ea57ecfc6e10dbcf2c5&libraries=services"></script>
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
				                        $('#class_location_y').val(result.y);
				                        $('#class_location_x').val(result.x);
				                        
				                        // 지도를 보여준다.
				                        mapContainer.style.display = "block";
				                        map.relayout();
				                        // 지도 중심을 변경한다.
				                        map.setCenter(coords);
				                        // 마커를 결과값으로 받은 위치로 옮긴다.
				                        marker.setPosition(coords);
				                        
				                    	// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
				                        var iwContent = '<div style="padding:5px;">' + addr + '</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
				                            iwPosition = new daum.maps.LatLng(33.450701, 126.570667), //인포윈도우 표시 위치입니다
				                            iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
				                        // 인포윈도우를 생성합니다
				                        var infowindow = new daum.maps.InfoWindow({
				                            position : iwPosition,
				                            content : iwContent,
				                            removable : iwRemoveable
				                        });
				                        // 마커에 클릭이벤트를 등록합니다
				                        daum.maps.event.addListener(marker, 'click', function() {
				                              // 마커 위에 인포윈도우를 표시합니다
				                              infowindow.open(map, marker);  
				                        });
				                    }
				                });
				            }
				        }).open();
				    }
				</script>
			</div>
			
		</div>
	
		
		
		
		<div class="form-group col-md-12">
			<label for="inputAddress2">그룹 인원 설정</label>
			 <input type="text" name="class_maxNumber" class="form-control"> 
		</div>
	
		<div class="form-group col-md-12">
			<label for="inputAddress2">강사 소개</label>
			<input type="text" name="class_mento_information" class="form-control">
		</div>
		
		<div class="form-group col-md-12">
			<label for="inputAddress2">강사</label>
			<input type="text" name="class_mento" class="form-control">
		</div>
	
		<div class="form-group col-md-12">
			<label for="inputAddress2">상세 내용 입력</label>
			<textarea id="summernote" name="class_content" class="form-control" placeholder="content"></textarea> 
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
			<label for="inputAddress2">요금 선택</label>
			<input type="text" class="form-control" id="class_payment" name="class_payment" placeholder="">
		</div>
		
		<div class="form-group col-md-12">
			<label for="inputAddress2">강좌 인원</label>
			<input type="text" class="form-control" name="class_maxNumber" placeholder="">
		</div>
		
		<div class="form-group col-md-12">
			<button type="submit" class="btn btn-primary">Sign in</button>
		</div>
		
	
	</div>
	</form>
</div>
<script>
var date = new Date();
var yyyy = date.getFullYear();
var mm = date.getMonth()+1 > 9 ? date.getMonth()+1 : '0' + date.getMonth()+1;
var dd = date.getDate() > 9 ? date.getDate() : '0' + date.getDate();
 
$("input[type=date]").val(yyyy+"-"+mm+"-"+dd);

</script>
<%@include file ="../footer.jsp" %>
</body>
</html>
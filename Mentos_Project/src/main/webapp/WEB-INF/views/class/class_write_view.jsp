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

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	function uploadFile(){
	    var form = $('#classWrite')[0];
	    var formData = new FormData(form);
	    formData.append("class_image", $("#class_image")[0].files[0]);
	    
	
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
	        }
	    });
	}

</script>

</head>
<body>
<form action="classWrite" method="post">	
	<table width="500" cellpadding="0" cellsapcing="0" border="1">
		
		
			<tr>
				<td> 이름 </td>
				<td> <input type="text" name="class_name" size = "50"> </td>
			</tr>
			
			<tr>
				<td> 제목 </td>
				<td> <input type="text" name="class_mento" size = "50"> </td>
			</tr>
			
			<tr>
				<td> 내용 </td>
				<td><textarea id="summernote" name="class_content" placeholder="content"></textarea> 
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
				</td>
			</tr>
			
			<tr>
				<td> 장소 </td>
				<td> <input type="text" name="class_place" size = "50"> </td>
			</tr>
			
			<tr>
				<td> 이미지 </td>
				<td> 
				<div id="img" class="image-container">
				<img id="img_source">
				</div>
				<input type="file" id="class_image" name="class_image" size = "50"> <br>
				<a class="ui-shadow ui-btn ui-corner-all" href="javascript:uploadFile();">등록</a> </td>
			</tr>
			
			<tr>
				<td> 멘토 정보 </td>
				<td> <input type="text" name="class_mento_information" size = "50"> </td>
			</tr>
			<tr>
				<td> 기간 </td>
				<td> 시작 날짜 : <input type="date" name="class_startDate" size = "50"> </td>		
				<td> 종료 날짜 : <input type="date" name="class_endDate" size = "50"> </td>		
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="입력"> &nbsp;&nbsp;
					<a href="list">목록보기</a>
				</td>
			</tr>
	
	</table>
</form>
</body>
</html>
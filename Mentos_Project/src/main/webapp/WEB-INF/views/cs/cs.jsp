<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file ="../header.jsp" %>
 <!-- Page Content -->
  <div class="container">
    <div class="row">
      <div  style='text-align: center;'>
        <div style='display: inline-block;'>
          <a href="/cs/QnA">QnA</a>
          <a href="/cs/report">신고하기</a>
          <a href="/cs/notice">공지사항</a>
          <a href="/cs/history">나의 문의내역</a>
        </div>
      </div>
	</div>
</div>
 <!-- wrapping -->
    <div class="content_wrapping max_width_area">
        <div class="main_area">
            <!-- 메인콘텐츠 시작 -->
            <div class="main_content">
                <form class="area_form" action="/cs/inquire" method="post" enctype="multipart/form-data" id="main_content_form">
                    <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response">
                    <input type="hidden" name="proc" value="createInquire" />
                    <input type="submit" style="display: none">
                    <input type="hidden" name="reportEnvironment" value="" />
                    <p class="info_manage">온오프믹스를 이용하시면서 <strong>궁금한 점이나 어려운 점, 모임 관련 내용이나 온오프믹스 전반적인 문의</strong>를 입력 해 주세요.<br>문의 하신 내용은 확인 후 메일로 답변을 드립니다.</p>
                    <div class="input_email">
                        <h4 class="label"><span class="required">*</span>이메일</h4>
                        <div class="write_wrap">
                            <input type="email" id="email" name="email" class="emailbox email" value="">
                            <p class="tip_txt">* 답변 받을 이메일 주소를 확인해 주세요.</p>
                        </div>
                    </div>
                    <div class="input_phone">
                        <h4 class="label">전화번호</h4>
                        <div class="write_wrap">
                            <select class="selectmenu phone_head" name="phone_head">
                                                            <option value="010" >010</option>
                                                            <option value="011" >011</option>
                                                            <option value="015" >015</option>
                                                            <option value="016" >016</option>
                                                            <option value="017" >017</option>
                                                            <option value="018" >018</option>
                                                            <option value="019" >019</option>
                                                            <option value="02" >02</option>
                                                            <option value="031" >031</option>
                                                            <option value="032" >032</option>
                                                            <option value="033" >033</option>
                                                            <option value="041" >041</option>
                                                            <option value="042" >042</option>
                                                            <option value="043" >043</option>
                                                            <option value="044" >044</option>
                                                            <option value="0502" >0502</option>
                                                            <option value="0505" >0505</option>
                                                            <option value="051" >051</option>
                                                            <option value="052" >052</option>
                                                            <option value="053" >053</option>
                                                            <option value="054" >054</option>
                                                            <option value="055" >055</option>
                                                            <option value="061" >061</option>
                                                            <option value="062" >062</option>
                                                            <option value="063" >063</option>
                                                            <option value="064" >064</option>
                                                            <option value="070" >070</option>
                                                        </select>
                            <input type="tel" class="phone_main" name="phone_body" value="" placeholder="“-” 없이 번호만 입력">
                        </div>
                    </div>
                    <div class="input_url">
                        <h4 class="label">문의 주소(URL)</h4>
                        <div class="write_wrap">
                            <input type="text" name="reportUrl" placeholder="문의하려는 페이지 주소를 입력해 주세요">
                        </div>
                    </div>
                    <div class="input_text">
                        <h4 class="label"><span class="required">*</span>문의입력</h4>
                        <div class="write_wrap">
                            <textarea name="content"></textarea>
                        </div>
                    </div>
                    <div class="input_file">
                        <h4 class="label">파일첨부</h4>
                        <div class="write_wrap">
                            <div class="file_box">
                                <label for="file-01" class="btn_upload">파일선택</label>
                                <input type="text" class="upload_file" value="파일을 업로드 해주세요" disabled>
                                <input type="file" id="file-01" class="file" name="attach1">
                            </div>
                            <div class="file_box">
                                <label for="file-02" class="btn_upload">파일선택</label>
                                <input type="text" class="upload_file" value="파일을 업로드 해주세요" disabled>
                                <input type="file" id="file-02" class="file" name="attach2">
                            </div>
                        </div>
                    </div>
                                        <!-- 비회원 일때 block 됨 -->
                    <div class="input_agreement">
                        <h4 class="label"><span class="required">*</span>개인정보<br>수집동의</h4>
                        <div class="write_wrap">
                            <p class="tip_txt">* 작성해주신 이메일, 전화번호는 문의내용 확인 및 답변처리 용도로 쓰이며 3년간 보관 후 파기합니다.</p>
                            <label><input type="checkbox" required name="privacy" value="1"><span>동의합니다.</span></label>
                        </div>
                    </div>   
                                    </form>         
                <p class="info_message">이 사이트는 reCAPTCHA에 의해 보호되며 Google <a href="https://policies.google.com/privacy" target="_blank">개인 정보 취급 방침</a> 및 <a href="https://policies.google.com/terms" target="_blank">서비스 약관</a>이 적용됩니다.</p>

                <!-- 버튼영역 시작-->
                <div class="bottom_btn_area">
                    <div class="btn_wrap">
                        <input type="button" value="문의하기" class="btn_submit" >
                    </div>
                </div>
                <!-- 버튼영역 끝-->
            </div>
            <!-- 메인콘텐츠 끝 -->
        </div>
    </div>
    <!-- wrapping -->
<%@include file ="../footer.jsp" %>
</body>
</html>
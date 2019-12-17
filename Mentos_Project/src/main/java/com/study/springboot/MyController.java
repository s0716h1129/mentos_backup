package com.study.springboot;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.springboot.dao.IMemberDao;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.kakaoAPI.KakaoAPI;

@Controller
@RequestMapping(value= {"/main", ""})
public class MyController {
	
	@Autowired IMemberDao dao;
	 
	@Autowired private KakaoAPI kakao;
	
	@RequestMapping("")
	public String main(HttpServletRequest request, Model model, Principal principal) {
		HttpSession session = request.getSession();
		if(principal != null) {
			session.setAttribute("id", currentUserName(principal));
			session.setAttribute("ValidMem", "yes");
		} else {
			session.setAttribute("ValidMem", "no");
		}
		return "/main";
	}
	public static String currentUserName(Principal principal) {
		String user_id = principal.getName();
		return user_id; 
	}
	
	@RequestMapping(value ="/joinForm", method = {RequestMethod.GET, RequestMethod.POST})
	public String joinForm(HttpServletRequest request, Model model,
			@ModelAttribute("dto")@Valid MemberDto memberDto, BindingResult result1) {
		String page = "redirect:main";
		HttpSession session = request.getSession();
		String snsId = (String) session.getAttribute("snscheck");
		String profile_image = (String) session.getAttribute("profile_image");
		int checkid = 0; 
		
		if(snsId == null) {
			
			if(checkid == 1) { System.out.println("이미 있는 아이디 입니다."); return "redirect:main"; }
			memberDto.setEmail(request.getParameter("email"));
			memberDto.setPassword(request.getParameter("pw"));
			memberDto.setMember_image("");
			memberDto.setSns_check("");
		} else {
			checkid = dao.check_id(snsId);
			if(checkid == 1) { System.out.println("이미 있는 아이디 입니다."); return "redirect:main"; }
			memberDto.setEmail(request.getParameter("email"));
			memberDto.setSns_check(snsId);
			memberDto.setPassword("snsPassword");
			memberDto.setMember_image(profile_image);
		}
		memberDto.setNickname(request.getParameter("nickname"));
		memberDto.setPhonenumber(request.getParameter("phoneNumber"));
		

		JoinValidator validator = new JoinValidator();
		BindingResult result = result1;
		validator.validate(memberDto, result);
		if(result.hasErrors()) {
			if(result.getFieldError("memberid") != null) {
				System.out.println("1:" + result.getFieldError("memberid").getCode());
			}
			if(result.getFieldError("memberpassword") != null) {
				System.out.println("2:" + result.getFieldError("memberpassword").getCode());
			}
			return page = "/joinForm";
		} else {
			dao.insertMember(memberDto.getEmail(),
					passwordEncoder1().encode(memberDto.getPassword()),
					memberDto.getNickname(),
					memberDto.getPhonenumber(),
					memberDto.getMember_image(),
					memberDto.getSns_check());
			return "/main";
		}
	}
	
	// passwordEncoder() 추가
	@Bean
	public BCryptPasswordEncoder passwordEncoder1() {
			return new BCryptPasswordEncoder();
	}
	
	@RequestMapping("/loginForm")
	public String loginForm(HttpServletRequest request, Model model) {
		request.getSession().removeAttribute("id");
		return "/loginForm";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request, Model model) {
		request.getSession().removeAttribute("id");
		return "main";
	}	
	
	@RequestMapping("/login")
	public String login(HttpServletRequest request, Model model, @RequestParam("code") String code) throws ParseException {		
		System.out.println(code);
		String access_Token = kakao.getAccessToken(code);
        System.out.println("controller access_token : " + access_Token);
        HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);
        System.out.println("login Controller : " + userInfo);
        HttpSession session = request.getSession();
        //    클라이언트의 이메일이 존재할 때 세션에 해당 이메일과 토큰 등록
        if (userInfo.get("snscheck") != null) {
        	String snsEmail = dao.snsCheck(userInfo.get("snscheck").toString()); 
        	if(snsEmail == null) {
        		session.setAttribute("snscheck", userInfo.get("snscheck"));
       		 	session.setAttribute("profile_image", userInfo.get("profile_image"));
       		 	return "/joinForm";
        	} else {
        		session.setAttribute("id", dao.informationDao(snsEmail).getEmail());
	            session.setAttribute("access_Token", access_Token);
	            return "/main";
        	}
        }else if(code == null) {
			String sId = request.getParameter("MemberId");
			System.out.println(sId);
			String sPw = request.getParameter("MemberPw");
			System.out.println(sPw);
			String dto = "";
			dto = dao.userCheck(sId, sPw);
			if(dto.equals(sPw)) {
				session.setAttribute("id", sId);
				session.setAttribute("ValidMem", "yes");
				return "/main";
			} else {
				return "/loginForm";
			}		
		}
		return "/loginForm";
	}
	
	@RequestMapping(value = "/findIdPw", method = {RequestMethod.GET, RequestMethod.POST})
	public String findIdPw(HttpServletResponse response, 
			@RequestParam(value = "name", required=false) String name,
			@RequestParam(value = "phoneNumber", required=false) String phoneNumber, Model md) throws Exception{
		if(name != null ) {
			String id = find_id(response, name, phoneNumber);
			if(id != null) {
				md.addAttribute("id", id);
			}
		}
		return "/findIdPw";
	}
	
	// 아이디 찾기
	@RequestMapping(value = "/findId", method = {RequestMethod.GET, RequestMethod.POST})
	public String findid(HttpServletResponse response, 
			@RequestParam(value = "name", required=false) String name,
			@RequestParam(value = "phoneNumber", required=false) String phoneNumber,Model md) throws Exception{
		if(name != null ) {
			String id = find_id(response, name, phoneNumber);
			if(id != null) {
				md.addAttribute("id", id);
			}
		}
		return "/findId";
	}
	
	// 아이디 찾기
	public String find_id(HttpServletResponse response, String name, String phoneNumber) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String id = dao.find_id(name, phoneNumber);
		System.out.println("find_id");
		if (id == null) {
			out.println("<script>");
			out.println("alert('가입된 아이디가 없습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return null;
		} else {
			return id;
		}
	}
	
	// 비밀번호 찾기 폼
	@RequestMapping(value = "/find_pw_form")
	public String find_pw_form() throws Exception{
		return "/find_pw_form";
	}
		
	// 비밀번호 찾기
	@RequestMapping(value = "/find_pw")
	public String find_pw(@RequestParam(value = "email", required=false) String email,
			HttpServletResponse response, MemberDto member) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		MemberDto dto = dao.informationDao(email);
		// 아이디가 없으면
		if(dao.check_id(email) == 0) {
			out.print("아이디가 없습니다.");
			out.close();
			return "/find_pw_form";
		}else if (dto == null) {
			out.print("등록되지 않은 이메일 입니다.");
			out.close();
			return "/find_pw_form";
		}
		// 가입에 사용한 이메일이 아니면
		else if(!email.equals(dto.getEmail())) {
			out.print("잘못된 이메일 입니다.");
			out.close();
			return "/find_pw_form";
		}else {
			// 임시 비밀번호 생성
			String pw = "";
			for (int i = 0; i < 4; i++) {
				pw += (char) ((Math.random() * 26) + 97);
			}
			
			member.setPassword(passwordEncoder1().encode(pw));
			// 비밀번호 변경
			dao.ModifyPw(email,pw);
			// 비밀번호 변경 메일 발송
			send_mail(member, "find_pw", pw);
			
			out.print("이메일로 임시 비밀번호를 발송하였습니다.");
			out.close();
			return "";
		}
	}
		
	@Autowired
	JavaMailSender sender;
	// 이메일 발송
	public void send_mail(MemberDto member, String div, String pw) {
		String msg = "";
		String resultCode = "";
		
		try{  
		  String memberMail = "";
		  MailHandler mail = new MailHandler(sender);
		  mail.setFrom("email","name");
		  mail.setTo(member.getEmail());
		  if(div.equals("join")) {
				// 회원가입 메일 내용
			  mail.setSubject("Spring Homepage 회원가입 인증 메일입니다.");
			  mail.setText(new StringBuffer().append(
				"<div align='center' style='border:1px solid black; font-family:verdana'>")
				  .append("<h3 style='color: blue;'>")
				  .append(member.getNickname() + "님 회원가입을 환영합니다.</h3>")
				  .append("<div style='font-size: 130%'>")
				  .append("하단의 인증 버튼 클릭 시 정상적으로 회원가입이 완료됩니다.</div><br/>")
				  .append("<form method='post' action='http://localhost:8081/homepage/member/approval_member.do'>")
				  .append("<input type='hidden' name='email' value='" + member.getEmail() + "'>")
				  //.append("<input type='hidden' name='approval_key' value='" + member.getApproval_key() + "'>")
				  .append("<input type='submit' value='인증'></form><br/></div>")
				  .toString()
 			    );
			}else if(div.equals("find_pw")) {
				mail.setSubject("Spring Homepage 임시 비밀번호 입니다.");
				mail.setText(new StringBuffer().append(
				"<div align='center' style='border:1px solid black; font-family:verdana'>")
					.append("<h3 style='color: blue;'>")
					.append(member.getNickname() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>")
					.append("<p>임시 비밀번호 : ")
					.append(member.getPassword() + "</p></div>")
					.toString()
				);
			}
		  mail.send();
		  msg = "회원가입 성공.. 작성하신 이메일로 인증메일을 전송하였습니다.";
		  resultCode = "S-1";
		}catch(Exception e) {
		  e.printStackTrace();
		  msg = "회원가입 실패";
		  resultCode = "F-1";
		}
	}
	
	// alram
	@RequestMapping(value = "/check_alram")
	public void check_alram(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException{		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		System.out.println("check_alram");
		HttpSession session = request.getSession();
		String userID = (String) session.getAttribute("id");
		if(userID == null || userID.equals("") )
		{
			System.out.println("no ID");
			response.getWriter().write("0");
		}else {
			System.out.println("alram");
			response.getWriter().write(getAlram(userID) + "");
		}
		model.addAttribute("alram", getAlram(userID));
	}
	
	public int getAlram(String userID) {
		int count = 0;
		
		count = dao.check_alram(userID);
		
		return count;
		
	}
	
	// 안드로이드 회원가입
			@RequestMapping("/Andjoin")
			public void join(HttpServletRequest request, @RequestParam("email") String email, @RequestParam("password") String pw,
					@RequestParam("nickname") String nickname, @RequestParam("phonenumber") String phoneNumber
					,@RequestParam("MEMBER_IMAGE") String image) {
				
				System.out.println(email);
				System.out.println(pw);
				System.out.println(nickname);
				System.out.println(phoneNumber);
				System.out.println(image);

				dao.AndinsertMember(email, pw, nickname, phoneNumber,image);
			}
			
	// 안드로이드 비콘 출석 페이지 강좌 불러오기
	@RequestMapping("/beaconAttendance")
	public String beaconAttendance(Model model, HttpServletRequest request, @RequestParam("email") String mId) {
		System.out.println(mId);
		
		model.addAttribute("classList", dao.beaconAttClassList(mId));
		
		return "/beaconAttendance";
	}
	
	// 안드로이드 비콘 출석 체크하기
	@RequestMapping("/beaconCheck")
	public void beaconCheck() {
		
	}
			
}

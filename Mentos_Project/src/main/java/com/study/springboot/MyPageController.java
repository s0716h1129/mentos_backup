package com.study.springboot;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.study.springboot.dao.IMemberDao;

@RestController
@RequestMapping("/mypage")
public class MyPageController {
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	IMemberDao mDao;
	
	// 마이페이지 관련 mapping
	// 마이페이지 시작 화면
	@RequestMapping("/mypage")
	public String myPage(Model model, Principal principal) {
		String mId = principal.getName();
		model.addAttribute("Intro", mDao.InformationDao(mId).getMember_intro());
		model.addAttribute("memberId", mId);
			
		return "/mypage/MyPage1";
	}
		
	// 정보 수정 Form
	@RequestMapping("/modifyForm")
	public String ModifyForm(Principal principal, Model model) {
		String mId = principal.getName();
		model.addAttribute("infoDto", mDao.InformationDao(mId));
		
		return "/mypage/MInfoModifyForm";
	}
	
	// 정보 수정 ajax 처리
	@RequestMapping(value="/modifyAjax", method=RequestMethod.POST)
	@ResponseBody
	public String serialize(HttpServletRequest request) {
		String data = "";
		String mId = request.getParameter("mId");
		String mPw = mDao.InformationDao(mId).getPassword();
		String aPw = request.getParameter("pw");
			if (passwordEncoder.matches(aPw, mPw)) {
			String mIntro = request.getParameter("mIntro");
			String mEmail = request.getParameter("eMail");
			String mArea = request.getParameter("intArea");
			String mMajor = request.getParameter("intMajor");
			String mGroup = request.getParameter("intGroup");
			
			mDao.InfoModifyDao(mIntro, mEmail, mArea, mMajor, mGroup, mId);
				data = "{\"code\":\"success\",\"desc\":\"정보 수정 성공\"}";
		} else {
			data = "{\"code\":\"fail\",\"desc\":\"비밀번호 오류입니다. \"}";
		}
			return data;
	}
	
	// Form에서 수정하고 완료 누르면 수정 됨
	@RequestMapping("/memberModify")
	public String MemberModify(HttpServletRequest request, Model model, Principal principal) {
		return "redirect:mypage";
	}
	
	// 비밀번호 변경 Form 이동
	@RequestMapping("/modifyPwForm")
	public String ModifyPwForm() {
		
		return "/mypage/ChangePw";
	}
	
	
	// 비밀번호 변경 Ajax
	@RequestMapping(value="/modifyAjaxPw", method= {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public String serializePw(HttpServletRequest request, Principal principal) {
		String data = "";
		String mId = principal.getName();
		String mPw = mDao.InformationDao(mId).getPassword();
		String aPw = request.getParameter("pw");
		
		if (passwordEncoder.matches(aPw, mPw)) {
			String pw = passwordEncoder.encode(request.getParameter("changePw"));
			mDao.ModifyPw(pw, mId);
			
			data = "{\"code\":\"success\",\"desc\":\"비밀번호 수정 성공\"}";
		} else {
			
			data = "{\"code\":\"fail\",\"desc\":\"비밀번호 오류\"}";
		}
		
		return data;
	}
	
	// 회원 탈퇴 Form 이동
	@RequestMapping("/memberLeaveForm")
	public String MemberLeaveForm() {
		
		return "/mypage/MemberLeave";
	}
	
	// 회원 탈퇴 Ajax
	@RequestMapping(value="/memberLeaveAjax", method= {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public String serializeLeave(HttpServletRequest request, Principal principal) {
		String data = "";
		String mId = request.getParameter("mId");
		String cId = principal.getName();
		String mPw = request.getParameter("pw");
		String cPw = "";
		
		int checkId = mDao.IdCountDao(mId);		// 1이면 아이디 존재, 0이면 없는 아이디
		System.out.println("count" + checkId);
		
		if (checkId == 1) {
			cPw = mDao.InformationDao(mId).getPassword();
			
			if (cId.equals(mId)) {
				if (passwordEncoder.matches(mPw, cPw)) {
					data = "{\"code\":\"success\",\"desc\":\"정말로 회원 탈퇴를 하시겠습니까?\"}";
				} else {
					data = "{\"code\":\"fail\",\"desc\":\"아이디 또는 비밀번호를 확인해주세요.\"}";
				}	
			} else {
				data = "{\"code\":\"fail\",\"desc\":\"아이디 또는 비밀번호를 확인해주세요.\"}";
			}
					
		} else if (checkId == 0) {
			data = "{\"code\":\"fail\",\"desc\":\"아이디 또는 비밀번호를 확인해주세요.\"}";
		}
		
		System.out.println("data" +data);
		return data;
	}
	
	// 회원 탈퇴 처리
	@RequestMapping("/memberLeave")
	@ResponseBody
	public String MemberLeave(Principal principal) {
		String id = principal.getName();
		
		mDao.LeaveDao(id);
		
		// 후에 로그아웃 추가
		return "/main";
	}
}

package com.study.springboot;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.dao.IMemberDao;

@Controller
@RequestMapping("/mypage")
public class MyPageController {
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	IMemberDao mDao;
	
	// 회원 등급
	public String grade (String mId) {

		int score = mDao.informationDao(mId).getMember_score();
		String grade = "";
		if (score >= 0 && score <= 100) {
			grade = "일반 회원";
		} else if (score >= 101 && score <= 200) {
			grade = "우수 회원";
		} else if (score >= 201 && score <= 300) {
			grade = "MVP 회원";
		}
		return grade;
	}
	
	// 마이페이지 관련 mapping
	// 마이페이지 시작 화면
	@RequestMapping("/main")
	public String myPage(HttpServletRequest request,Model model, Principal principal) {
		HttpSession session = request.getSession();
		String mId = (String) session.getAttribute("id");
		 if(mId == null) {
	    	 return "/loginForm";
	     }
		model.addAttribute("info", mDao.informationDao(mId));
	    model.addAttribute("memberId", mId);
		model.addAttribute("grade", grade(mId));
		         
		return "/mypage/MyPage";
	}

		
	// 정보 수정 Form
	@RequestMapping("/modifyForm")
	public String ModifyForm(Principal principal, HttpServletRequest request, Model model) {
		 HttpSession session = request.getSession();
	     String mId = (String) session.getAttribute("id");
		  if(mId == null) {
	    	 return "/loginForm";
	     }
		model.addAttribute("infoDto", mDao.informationDao(mId));
		
		return "/mypage/MInfoModifyForm";
	}
	
	// 정보 수정 ajax 처리

	@RequestMapping(value="/modifyAjax", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public String serialize(HttpServletRequest request) {
		String data = "";
		String mId = request.getParameter("mId");
		String mPw = mDao.informationDao(mId).getPassword();
		String aPw = request.getParameter("pw");
			if (passwordEncoder.matches(aPw, mPw)) {
			String mIntro = request.getParameter("mIntro");
			String mArea = request.getParameter("intArea");
			String mMajor = request.getParameter("intMajor");
			String mGroup = request.getParameter("intGroup");
			
			mDao.InfoModifyDao(mIntro, mArea, mMajor, mGroup, mId);
				data = "{\"code\":\"success\",\"desc\":\"정보 수정 성공\"}";
		} else {
			data = "{\"code\":\"fail\",\"desc\":\"비밀번호 오류입니다. \"}";
		}
			return data;
	}
	
	// Form에서 수정하고 완료 누르면 수정 됨
	@RequestMapping("/memberModify")
	public String MemberModify(HttpServletRequest request, Model model, Principal principal) {

		return "redirect:main";
	}
	
	// 비밀번호 변경 Form 이동
	@RequestMapping("/modifyPwForm")
	public String ModifyPwForm(HttpServletRequest request) {
		 HttpSession session = request.getSession();
	     String mId = (String) session.getAttribute("id");
		 if(mId == null) {
	    	 return "/loginForm";
	     }
		return "/mypage/ChangePw";
	}
	
	
	// 비밀번호 변경 Ajax
	@RequestMapping(value="/modifyAjaxPw", method= {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public String serializePw(HttpServletRequest request, Principal principal) {
		String data = "";
		String mId = principal.getName();
		String mPw = mDao.informationDao(mId).getPassword();
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
	public String MemberLeaveForm(HttpServletRequest request) {
		 HttpSession session = request.getSession();
	     String mId = (String) session.getAttribute("id");
		 if(mId == null) {
	    	 return "/loginForm";
	     }
		return "/mypage/MemberLeave";
	}
	
	// 회원 탈퇴 Ajax
		@RequestMapping(value="/memberLeaveAjax", method= {RequestMethod.POST, RequestMethod.GET})
		@ResponseBody
		public String serializeLeave(HttpServletRequest request, Principal principal) {
			String data = "";
			String mId = request.getParameter("mId");
			HttpSession session = request.getSession();
		    String cId = (String) session.getAttribute("id");
			String mPw = request.getParameter("pw");
			String cPw = "";
			
			System.out.println("mId" + mId + ", cId" + cId + ", mPw" + mPw);
			
			int checkId = mDao.IdCountDao(mId);		// 1이면 아이디 존재, 0이면 없는 아이디
			System.out.println("count" + checkId);
		
		if (checkId == 1) {
			cPw = mDao.informationDao(mId).getPassword();
			
			if (cId.equals(mId)) {
				if (passwordEncoder.matches(mPw, cPw)) {
					data = "{\"code\":\"success\",\"desc\":\"정말로 회원 탈퇴를 하시겠습니까?\"}";
				} else {
					data = "{\"code\":\"fail\",\"desc\":\"1아이디 또는 비밀번호를 확인해주세요.\"}";
				}	
			} else {
				data = "{\"code\":\"fail\",\"desc\":\"2아이디 또는 비밀번호를 확인해주세요.\"}";
			}
					
		} else if (checkId == 0) {
			data = "{\"code\":\"fail\",\"desc\":\"3아이디 또는 비밀번호를 확인해주세요.\"}";
		}
		
		System.out.println("data" +data);
		return data;
	}
	
	// 회원 탈퇴 처리
	@RequestMapping("/memberLeave")
	public String MemberLeave(HttpServletRequest request) {
		HttpSession session = request.getSession();
	    String id = (String) session.getAttribute("id");
		
		mDao.LeaveDao(id);

		return "redirect:/main/logout";
	}
	
	// 회원이 참여한 강좌 정보 보기
	@RequestMapping("/memberClass")
	public String memberClass(HttpServletRequest request, HttpSession session, Model model, @ModelAttribute("bPageInfo") BPageInfo bPageInfo) {
	    String mId = (String) session.getAttribute("id");
		 if(mId == null) {
	    	 return "/loginForm";
	     }
	    System.out.println(mId);
	    model.addAttribute("classList", mDao.MemberClassInfoDao(mId));
	    
		return "/mypage/MyPageClassList";
	}
	
	// 회원이 결제한 내역 보기
	@RequestMapping("/memberPay")
	public String memberPay (HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
	    String mId = (String) session.getAttribute("id");
	     if(mId == null) {
	    	 return "/loginForm";
	     }
	    model.addAttribute("classPay", mDao.PayInfoClassDao(mId));
		model.addAttribute("placePay", mDao.PayInfoPlaceDao(mId));
		return "/mypage/memberPay";
	}
	
	// 회원이 찜한 강좌 목록 보기
	@RequestMapping("/memberLikeClass")
	public String memberLikeClass(HttpServletRequest request, HttpSession session, Model model, @ModelAttribute("bPageInfo") BPageInfo bPageInfo) {
	    String mId = (String) session.getAttribute("id");
		if(mId == null) {
	    	 return "/loginForm";
	     }
	    System.out.println(mId);
	    model.addAttribute("classList", mDao.MemberLikeClassInfoDao(mId));
	    
		return "/mypage/likeClassList";
	}
	
	// 회원 출결 정보
	@RequestMapping("/memberAttendance")
	public String memberAttendace(HttpServletRequest request, HttpSession session, Model model) {
		String mId = (String) session.getAttribute("id");
		if(mId == null) {
	    	 return "/loginForm";
	     }
		model.addAttribute("className", mDao.MemberClassInfoDao(mId));
		model.addAttribute("AttendList", mDao.MemberAttendanceDao(mId));
		
		return "/mypage/memberAttendance";
	}
	
	// 안드로이드 회원 정보 보기
	@RequestMapping("/aMemberInfo")
	public String aMemberInfo(HttpServletRequest request, Model model) {
		String mId = request.getParameter("email");
		
		model.addAttribute("memberInfo", mDao.informationDao(mId));
		
		return "/mypage/aMemberInfo";
	}
	
	// 안드로이드 회원 강좌 리스트 보기
	@RequestMapping("/aMemberClass")
	public String aMemberClas(HttpServletRequest request, Model model) {
		String mId = request.getParameter("email");
		
		model.addAttribute("memberAtted", mDao.MemberClassInfoDao(mId));
		
		return "/mypage/aMemberClass";
	}
}

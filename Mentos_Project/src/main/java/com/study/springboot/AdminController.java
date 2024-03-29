package com.study.springboot;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;

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
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	IMemberDao mDao;
	
	// Admin  회원 관련 mapping
	// Admin 시작 화면
	@RequestMapping("/main")
	public String adminPage(Model model) {
		String mId="";
		model.addAttribute("mId", mId);
		return "/admin/AdminPage";
	}
	
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
	
	// 회원 등급 변경 Ajax
	@RequestMapping(value="/changeGrade", method= {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public String GradeAjax(HttpServletRequest request, Model model) {
		String data = "";
		String mId = request.getParameter("gradeId");
		String score = request.getParameter("score");
		
		int check = mDao.IdCountDao(mId);
		
		if (check == 1) {
			data = "{\"code\":\"success\",\"desc\":\"회원 등급 수정 성공\"}";
			mDao.MemberGradeChange(score, mId);
			
		} else if (check == 0 ) {
			data = "{\"code\":\"fail\",\"desc\":\"아이디 오류\"}";
		}
		
		return data;
	}
	
	// 회원 검색
	@RequestMapping("/memberSerch")
	public String memberSerch(HttpServletRequest request, Model model) {
		String mId = request.getParameter("mId");
		String menu = request.getParameter("menu");
		
		if(mId.equals("")) {
			
		} else {
			
			model.addAttribute("serList", mDao.informationDao(mId));
			model.addAttribute("mId", mId);
			model.addAttribute("payCount", mDao.PayMemberCountDao(mId));
			model.addAttribute("grade", grade(mId));
			
			if (menu.equals("pay")) {
				model.addAttribute("classPay", mDao.PayInfoClassDao(mId));
				model.addAttribute("placePay", mDao.PayInfoPlaceDao(mId));
			}
		}
		
		return "/admin/AdminPage";
	}
	
	// 회원 계정 정지 / 삭제 / 블랙리스트 Ajax
	@RequestMapping(value="/stateAjax", method= {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public String memberStateAjax(HttpServletRequest request) {
		String data="";
		String id = request.getParameter("sId");
		int check = mDao.IdCountDao(id);
		
		if (check == 1) {
			data = "{\"code\":\"success\",\"desc\":\"\"}";
		} else if (check == 0) {
			data = "{\"code\":\"fail\",\"desc\":\"아이디 오류\"}";
		}
		
		return data;
	}
	
	// 회원 계정 정지 / 삭제 / 블랙 리스트
	@RequestMapping("/memberState")
	public String memberState(HttpServletRequest request, Model model) {
		String sType = request.getParameter("sType");
		String mId = request.getParameter("mId");
			
		if (sType.equals("stop")) {
			int stopDate = Integer.parseInt(request.getParameter("date"));
			
			SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
			Calendar cal = Calendar.getInstance();
			String today = null;
			today = formatter.format(cal.getTime());
			Timestamp ts = Timestamp.valueOf(today);
				
			cal.setTime(ts);
			cal.add(Calendar.DATE, +stopDate);
				
			Timestamp date = new Timestamp(cal.getTime().getTime());
			
			System.out.println("더한 시간 " + date);
				
			mDao.MemberStopDate(mId, date);
				
		} else if (sType.equals("allStop")) {
			model.addAttribute(mDao.MemberStop(mId));
				
		} else if (sType.equals("delete")) {
			model.addAttribute(mDao.LeaveDao(mId));
				
		} else if (sType.equals("blackList")) {
			model.addAttribute(mDao.MemberBlackList(mId));
				
			} else if (sType.equals("member")) {
			model.addAttribute(mDao.MemberMember(mId));
		}
			
		model.addAttribute("serList", mDao.informationDao(mId));
		model.addAttribute("mId", mId);
		model.addAttribute("grade", grade(mId));
			
		return "/admin/AdminPage";
	}
	
	// 회원 비밀번호 변경 Ajax
	@RequestMapping(value="/pwModify", method= {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public String adminSerializePw(HttpServletRequest request) {
		String data="";
		
		String mId = request.getParameter("pId");
		int checkId = mDao.IdCountDao(mId);
		String mPw = request.getParameter("pw");
		String pw = passwordEncoder.encode(mPw);
		
		if (checkId == 1) {
			mDao.ModifyPw(pw, mId);
			
			System.out.println(mPw + ", " + mDao.informationDao(mId).getPassword());
			
			if (passwordEncoder.matches(mPw, mDao.informationDao(mId).getPassword())) {
				data = "{\"code\":\"success\",\"desc\":\"비밀번호 수정 성공\"}";
			} else {
				
				data = "{\"code\":\"fail\",\"desc\":\"비밀번호 저장 오류\"}";
			}
			
		} else if (checkId == 0) {
			data = "{\"code\":\"fail\",\"desc\":\"아이디 오류\"}";
		}
		
		return data;
	}
	
	// 강좌 검색
	@RequestMapping("/classSerch")
	public String classSerch(HttpServletRequest request, HttpSession session, Model model, @ModelAttribute("bPageInfo") BPageInfo bPageInfo) {
		String cId = request.getParameter("cId");		
		String sType = request.getParameter("serType");
		String menu = request.getParameter("menu");
		
		model.addAttribute("cId", cId);
		
		//page데이터 
		int totalCount = bPageInfo.getTotalcount();
		int listCount = 1;
		int totalPage = bPageInfo.getTotalpage();
		int curPage = 1;
		int pageCount = 10;
		int startPage = bPageInfo.getStartpage();
		int endPage = bPageInfo.getEndpage();
		int nPage = 1;
				
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch(Exception e) {
		}
		if (session.getAttribute("cpage") != null) {
			curPage = (int)session.getAttribute("cpage");
		}
				
		//총 게시물 수		
		if (menu.equals("")) {
			if (sType.equals("s1")) {
				totalCount = mDao.ClassNumTotalCount(cId);
			} else if (sType.equals("s2")) {
				totalCount = mDao.ClassNameTotalCount(cId);
			} else if (sType.equals("s3")) {
				totalCount = mDao.ClassMentoTotalCount(cId);
			}			
		} else if (menu.equals("pay")) {
			totalCount = mDao.ClassPayTotalCount(cId);
		} else if (menu.equals("review")) {
			totalCount = mDao.ClassReviewTotalCount(cId);
		}
				
		//총 페이지 수 
		totalPage = totalCount / listCount;
		if(totalCount % listCount > 0)
		totalPage++;
						
		//현재 페이지
		int myCurPage = curPage;
		if (myCurPage > totalPage)
			myCurPage = totalPage;
		if (myCurPage < 1)
			myCurPage = 1;
						
		//시작 페이지
			startPage = ((myCurPage -1) / pageCount) * pageCount + 1;
						
		//끝 페이지
		endPage = startPage + pageCount -1;
		if(endPage > totalPage)
			endPage = totalPage;
				
		System.out.println("nPage는" + nPage);
				
		//curPage 갱신
		curPage = nPage;
		session.setAttribute("cpage", curPage);
				
		//listDao에 필요한 Start End 값
		int nStart = (curPage - 1) * listCount + 1;
		int nEnd = (curPage - 1) * listCount + listCount;
				
		BPageInfo pinfo = new BPageInfo();
		pinfo.setTotalcount(totalCount);
		pinfo.setListcount(listCount);
		pinfo.setTotalpage(totalPage);
		pinfo.setCurpage(curPage);
		pinfo.setPagecount(pageCount);
		pinfo.setStartpage(startPage);
		pinfo.setEndpage(endPage);
		
		model.addAttribute("page", pinfo);
		
		if (menu.equals("")) {
			if (sType.equals("s1")) {
				model.addAttribute("serList", mDao.ClassNumList(cId, nStart, nEnd));
			} else if (sType.equals("s2")) {
				model.addAttribute("serList", mDao.ClassNameList(cId, nStart, nEnd));			
			} else if (sType.equals("s3")) {
				model.addAttribute("serList", mDao.ClassMentoList(cId, nStart, nEnd));
			}
			
		} else if (menu.equals("pay")) {
			model.addAttribute("serList", mDao.ClassInfo(cId));
			model.addAttribute("cPay", mDao.ClassPayList(cId,  nStart, nEnd));
			
		} else if (menu.equals("review")) {
			model.addAttribute("serList", mDao.ClassInfo(cId));
			model.addAttribute("cReview", mDao.ClassReviewList(cId, nStart, nEnd));
		}

		return "/admin/AdminPage";
	}
	
	// 강좌 삭제
	@RequestMapping("/classDelete")
	public String classDelete(HttpServletRequest request) {
		String cId = request.getParameter("cId");
				
		mDao.DeleteClass(cId);
				
		return "/admin/AdminPage";
	}
	
	// 장소 검색
	@RequestMapping("/placeSerch")
	public String PlaceSerch(HttpServletRequest request, HttpSession session, Model model, @ModelAttribute("bPageInfo") BPageInfo bPageInfo) {
		String pId = request.getParameter("pId");
		String sType = request.getParameter("serType");
		String menu = request.getParameter("menu");
		
		//page데이터 
		int totalCount = bPageInfo.getTotalcount();
		int listCount = 1;
		int totalPage = bPageInfo.getTotalpage();
		int curPage = 1;
		int pageCount = 10;
		int startPage = bPageInfo.getStartpage();
		int endPage = bPageInfo.getEndpage();
		int nPage = 1;
								
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch(Exception e) {
		}
		if (session.getAttribute("cpage") != null) {
			curPage = (int)session.getAttribute("cpage");
		}
								
		//총 게시물 수		
		if (menu.equals("")) {
			if (sType.equals("s1")) {
				totalCount = mDao.placeNumTotalCount(pId);
			} else if (sType.equals("s2")) {
				totalCount = mDao.placeNameTotalCount(pId);
			}
		} else if (menu.equals("pay")) {
			totalCount = mDao.PlacePayTotalCount(pId);
		} else if (menu.equals("review")) {
			totalCount = mDao.PlaceReviewTotalCount(pId);
		}
		//총 페이지 수 
		totalPage = totalCount / listCount;
		if(totalCount % listCount > 0)
		totalPage++;
										
		//현재 페이지
		int myCurPage = curPage;
		if (myCurPage > totalPage)
			myCurPage = totalPage;
		if (myCurPage < 1)
			myCurPage = 1;
										
		//시작 페이지
			startPage = ((myCurPage -1) / pageCount) * pageCount + 1;
										
		//끝 페이지
		endPage = startPage + pageCount -1;
		if(endPage > totalPage)
			endPage = totalPage;
								
		System.out.println("nPage는" + nPage);
								
		//curPage 갱신
		curPage = nPage;
		session.setAttribute("cpage", curPage);
								
		//listDao에 필요한 Start End 값
		int nStart = (curPage - 1) * listCount + 1;
		int nEnd = (curPage - 1) * listCount + listCount;
								
		BPageInfo pinfo = new BPageInfo();
		pinfo.setTotalcount(totalCount);
		pinfo.setListcount(listCount);
		pinfo.setTotalpage(totalPage);
		pinfo.setCurpage(curPage);
		pinfo.setPagecount(pageCount);
		pinfo.setStartpage(startPage);
		pinfo.setEndpage(endPage);
						
		model.addAttribute("page", pinfo);
		
		if (menu.equals("")) {
			if (sType.equals("s1")) {
				model.addAttribute("serList", mDao.PlaceNumList(pId, nStart, nEnd));
			} else if (sType.equals("s2")) {
				model.addAttribute("pReview", mDao.PlaceNameList(pId, nStart, nEnd));
			}
		} else if (menu.equals("pay")) {
			model.addAttribute("serList", mDao.PlaceInfo(pId));
			model.addAttribute("pPay", mDao.PlacePayList(pId, nStart, nEnd));
			
		} else if (menu.equals("review")) {
			model.addAttribute("serList", mDao.PlaceInfo(pId));
			model.addAttribute("pReview", mDao.PlaceReviewList(pId, nStart, nEnd));
		}
		
		model.addAttribute("pId", pId);
		
		return "/admin/AdminPage";
	}
	
	// 장소 결제 내역
	@RequestMapping("/placePay")
	public String PlacePay(HttpServletRequest request, Model model) {
		String pId = request.getParameter("pId");
			
		model.addAttribute("pPay", mDao.PayInfoPlaceDao(pId));
//		model.addAttribute("serList", mDao.PlaceNumInfo(pId));
			
		return "/admin/AdminPage";
	}
	
	// 장소 리뷰 내역
	@RequestMapping("/placeReview")
	public String PlaceReview(HttpServletRequest request, Model model) {
		String pId = request.getParameter("pId");
			
//		model.addAttribute("pReview", mDao.PlaceReviewDao(pId));
//		model.addAttribute("serList", mDao.PlaceNumInfo(pId));
			
		return "/admin/AdminPage";
	}
		
	// 장소 삭제
	@RequestMapping("/placeDelete")
	public String placeDelete(HttpServletRequest request) {
		String pId = request.getParameter("pId");

		mDao.DeletePlace(pId);
			
		return "/admin/AdminPage";
	}
	
	// 공지 사항
	@RequestMapping("/notice_write")
	public void notify(HttpServletRequest request, Model model) {
	   HttpSession session = request.getSession();
	   String id = (String) session.getAttribute("id");
	   String notice_title = request.getParameter("title");
	   String notice_content = request.getParameter("content");
	   HashMap<String, String> map = new HashMap<String, String>();
	   map.put("id", id);
	   map.put("notice_title", notice_title);
	   map.put("QnA_content", notice_content);
	   mDao.notice(map);
	}
}

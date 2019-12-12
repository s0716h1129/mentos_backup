package com.study.springboot;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.study.springboot.dao.IClassDao;

@Controller
@RequestMapping("/class")
public class ClassController {
	
	@Autowired
	IClassDao dao;
	
	@RequestMapping(value= {"/list", "/", ""})
	public String userlistPage(HttpServletRequest request,HttpSession session, Model model, @ModelAttribute("bPageInfo") BPageInfo bPageInfo) {
		//page데이터 
		int totalCount = bPageInfo.getTotalcount();
		int listCount = 20;
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
		totalCount = dao.totalCount();
		
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
		
		//model로 두가지 보낼 수 있다.
		model.addAttribute("list", dao.classListDao(nEnd, nStart));
		model.addAttribute("page", pinfo);	
		
		return "/class/class_list";
	}
	
	@RequestMapping("/content_view")
	public String view(HttpServletRequest request, Model model) {
		String class_number = request.getParameter("class_number");
		model.addAttribute("content_view", dao.classContentViewDao(class_number));
		return "/class/class_content_view";
	}
	
	@RequestMapping("/write_view")
	public String writeForm() {
		return "/class/class_write_view";
	}
	
	@RequestMapping("/classWrite")
	public String write(HttpServletRequest request, Model model) {
		
		String cName = request.getParameter("class_name");
		String cMento = request.getParameter("class_mento");
		String cMaxNumber = request.getParameter("class_maxNumber");
		String cPayment = request.getParameter("class_payment");
		String cContent = request.getParameter("class_content");
		String cPlace = request.getParameter("class_place");
		String cImage = request.getParameter("class_image");
		String cMentoInfo = request.getParameter("class_mento_information");
		String cStartDate = request.getParameter("class_startDate");
		String cEndDate = request.getParameter("class_endDate");
		String cStartTime = request.getParameter("class_startTime");
		String cEndTime = request.getParameter("class_endTime");
		String cReceiveStartDate = request.getParameter("class_receiveStartDate");
		String cReceiveEndDate = request.getParameter("class_receiveEndDate");
		String cReceiveStartTime = request.getParameter("class_receiveStartTime");
		String cReceiveEndTime = request.getParameter("class_receiveEndTime");
		String cState = request.getParameter("class_state");
		String cLocation = request.getParameter("class_location");
		String cLocation_y = request.getParameter("class_location_y");
		String cLocation_x = request.getParameter("class_location_x");
		String cCategory = request.getParameter("class_category");
		
		Map<String, String> writeMap = new HashMap<String, String>();
		
		writeMap.put("class_name", cName);
		writeMap.put("class_mento", cMento);
		writeMap.put("class_maxNumber", cMaxNumber);
		writeMap.put("class_payment", cPayment);
		writeMap.put("class_content", cContent);
		writeMap.put("class_place", cPlace);
		writeMap.put("class_image", cImage);
		writeMap.put("class_mento_information", cMentoInfo);
		writeMap.put("class_startDate", cStartDate);
		writeMap.put("class_endDate", cEndDate);
		writeMap.put("class_startTime", cStartTime);
		writeMap.put("class_endTime", cEndTime);
		writeMap.put("class_receiveStartDate", cReceiveStartDate);
		writeMap.put("class_receiveEndDate", cReceiveEndDate);
		writeMap.put("class_receiveStartTime", cReceiveStartTime);
		writeMap.put("class_receiveEndTime", cReceiveEndTime);
		writeMap.put("class_state", cState);
		writeMap.put("class_location", cLocation);
		writeMap.put("class_location_y", cLocation_y);
		writeMap.put("class_location_x", cLocation_x);
		writeMap.put("class_category", cCategory);
		
		dao.classWriteDao(writeMap);
		return "redirect:list";
	}
	
	@RequestMapping("/delete")
	public String delete(HttpServletRequest request, Model model) {
		dao.classDeleteDao(request.getParameter("id"));
	return "redirect:list";
	}
	
	@RequestMapping("/imageUpload")
	public @ResponseBody String imageUpload(HttpServletRequest request) {
		System.out.println("들어왓냐");
		int size = 1024 * 1024 * 10; // 10M
		String file="";
		String oriFile = "";
		
		JSONObject obj = new JSONObject();
		
		try {
			String path = ResourceUtils
					.getFile("classpath:static/upload/").toPath().toString();
			System.out.println(path);
			
			MultipartRequest multi = new MultipartRequest(request, path, size, 
											"UTF-8", new DefaultFileRenamePolicy());
			
			Enumeration files = multi.getFileNames();
			String str = (String) files.nextElement();
			
			file = multi.getFilesystemName(str);
			oriFile = multi.getOriginalFileName(str);
			System.out.println("111111");
			System.out.println("file : " + file);
			System.out.println("orifile : " + oriFile);
			
			obj.put("url", "../upload/" +file);		
		} catch(Exception e) {
			e.printStackTrace();
			obj.put("url", "업로드 실패");
			
		}
		
		return obj.toJSONString();
	}
	
	@RequestMapping("/joinClass")
	public String joinClass(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String mentee = (String) session.getAttribute("id");
		String class_number = request.getParameter("class_number");
		dao.joinClass(class_number, mentee);
		return "/class_content_view";
		
		/*
		String mentee = dao.getMentee(class_number);
		mentee = mentee + ", " + request.getParameter("mentee");
		*/
	}
	
	@RequestMapping("/callClass")
	public String callClass(HttpServletRequest request, Model model) {
		String id = request.getParameter("id");
		model.addAttribute("call",dao.callClass(id));
		return "/class_write_view";
	}
	
	@RequestMapping("/review_write_view")
	public String reviewwriteForm() {
		return "/class/review_write_view";
	}
	
	@RequestMapping("/reviewClass")
	public String reviewClass(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String writer = (String) session.getAttribute("id");
		String class_number = request.getParameter("class_number");
		int review_score = Integer.parseInt(request.getParameter("review_score"));
		String review_content = request.getParameter("review_content");
		
		dao.reviewClass(writer, class_number, review_score, review_content);
		return "/class_content_view"; 
	}
	
	@RequestMapping("/classRankingFrom")
	public String classRankingFrom(HttpServletRequest request, Model model) {
		return "/classRankingFrom";
	}
	
	@RequestMapping("/classRanking")
	public String classRanking(HttpServletRequest request, Model model) {
		String type = request.getParameter("type");
		model.addAttribute("ranking", dao.getRanking(type));
		return "/classRankingFrom";
	}
	
	// 안드로이드 강좌개설
		@RequestMapping("/AndClassCreate")
		public void AndClassCreate(HttpServletRequest request, 
				@RequestParam("CLASS_NAME") String class_name,
				@RequestParam("CLASS_CATEGORY") String class_category,
				@RequestParam("CLASS_RECEIVESTARTDATE") String class_receiveStartTime,
				@RequestParam("CLASS_RECEIVEENDDATE") String class_receiveEndTime) {


			dao.AndclassWriteDao(class_name, class_category, class_receiveStartTime, class_receiveEndTime);
		}

}

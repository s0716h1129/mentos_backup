package com.study.springboot;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.study.springboot.dao.IClassDao;

@Controller
@RequestMapping("/class")
public class ClassContorller {
	
	@Autowired
	IClassDao dao;
	
	@RequestMapping("/list")
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
	
	@RequestMapping("/class_write_view")
	public String writeForm() {
		return "/class/class_write_view";
	}
	
	@RequestMapping("/classWrite")
	public String write(HttpServletRequest request, Model model) {
		
		dao.classWriteDao(request.getParameter("class_name"), 
					 request.getParameter("class_mento"),
					 request.getParameter("class_content"),
					 request.getParameter("class_place"),
					 request.getParameter("class_image"),
					 request.getParameter("class_mento_information"));
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
			
			obj.put("url", "./upload/" +file);		
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
}

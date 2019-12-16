package com.study.springboot;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.study.springboot.dao.IMemberDao;

@Controller
@RequestMapping("/cs")
public class CSController {
	
	@Autowired IMemberDao dao;
	
	@RequestMapping("/cs")
	public String cs(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		return "/cs/cs";
	}
	@RequestMapping("/report")
	public String report(HttpServletRequest request, Model model) {
		return "/cs/report";
	}
	@RequestMapping("/report_write")
	public String report_write(HttpServletRequest request, Model model) {
		String id = request.getParameter("writer");
		String report_content = request.getParameter("content");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("report_content", report_content);
		dao.report(map);
		return "redirect:cs";
	}
	@RequestMapping("/history")
	public String history(HttpServletRequest request,HttpSession session, Model model, @ModelAttribute("bPageInfo") BPageInfo bPageInfo) {
		session = request.getSession();
		String id = (String) session.getAttribute("id");
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
		model.addAttribute("list", dao.history_list(nEnd, nStart, id));
		model.addAttribute("page", pinfo);	
		return "/cs/history";
	}
	
	@RequestMapping("/QnA")
	public String QnA(HttpServletRequest request, Model model) {
		return "/cs/QnA";
	}
	@RequestMapping("/QnA_write")
	public String QnA_write(HttpServletRequest request, Model model) {
		String id = request.getParameter("writer");
		String QnA_content = request.getParameter("content"); 
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("QnA_content", QnA_content);
		dao.QnA(map);
		return "redirect:cs";
	}
	@RequestMapping("/notice")
	public String notice(HttpServletRequest request,HttpSession session, Model model, @ModelAttribute("bPageInfo") BPageInfo bPageInfo) {
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
		model.addAttribute("list", dao.notice_list(nEnd, nStart));
		model.addAttribute("page", pinfo);	
		
		return "/cs/notice";
	}
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
		dao.notice(map);
	}
}

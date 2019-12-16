package com.study.springboot;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.study.springboot.dao.IEvaluationDao;


@Controller
@RequestMapping("/evaluation")
public class EvaluationController {
	
	@Autowired
	private IEvaluationDao dao;
	
	@RequestMapping("/evaluation_list")
	public String userlistPage(HttpServletRequest request,HttpSession session, Model model, @ModelAttribute("bPageInfo") BPageInfo bPageInfo) {
		System.out.println("list");
		
		//page데이터 
		int totalCount = bPageInfo.getTotalcount();
		int listCount = 10;
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
		model.addAttribute("list", dao.listDao(nEnd, nStart));
		model.addAttribute("page", pinfo);	
		
		return "/evaluation/evaluation_list";
	}
	
	@RequestMapping("/write")
	public String place_rent() {
		
		return "/evaluation/evaluation_write";	
	}
	
	@RequestMapping("/evaluation_write")
	public String rent(HttpServletRequest request , Model model )
	{	
		dao.write(
			request.getParameter("title"),
			request.getParameter("name"),
			request.getParameter("content")
			);
		
		return "redirect:evaluation_list";
	}
	
	@RequestMapping("/evaluation_view")
	public String view(HttpServletRequest request, Model model) {
		String sId = request.getParameter("evaluation_number");
		model.addAttribute("dto", dao.viewDao(sId));
		dao.upHit(sId);
		
		return "evaluation/evaluation_view";
	}
	
	@RequestMapping("/evaluation_modify")
	public String modify(HttpServletRequest request, Model model) {
		String sId = request.getParameter("evaluation_number");
		model.addAttribute("dto", dao.viewDao(sId));
		
		return "evaluation/evaluation_modify";
	}
	
	@RequestMapping("/evaluation_modifyOk")
	public String modify_OK(HttpServletRequest request, Model model) {
		dao.modifyOk(
				request.getParameter("evaluation_title"),
				request.getParameter("evaluation_content"),
				request.getParameter("evaluation_number")
				);
		
			return "redirect:evaluation_list";
	}
	
	@RequestMapping("/evaluation_delete")
	public String delete(HttpServletRequest request, Model model) {
		dao.Delete(request.getParameter("evaluation_number"));
	return "redirect:evaluation_list";
	}
	
	@RequestMapping("/evaluation_reply")
	public String reply(HttpServletRequest request, Model model) {
		String sId = request.getParameter("evaluation_number");
		model.addAttribute("dto", dao.viewDao(sId));
		
	return "evaluation/evaluation_reply";
	}
	
	@RequestMapping("/evaluation_replyOk")
	public String replyOk(HttpServletRequest request, Model model) {
		String title = request.getParameter("evaluation_title");
		String name = request.getParameter("evaluation_name");
		String content = request.getParameter("evaluation_content"); 
		int Group = Integer.parseInt(request.getParameter("evaluation_Group"));
		int Step = Integer.parseInt(request.getParameter("evaluation_Step"));
		int Indent = Integer.parseInt(request.getParameter("evaluation_Indent"));
		
		replyShape(Step,Indent);
		
		System.out.println("replyOk 들어왔다!!!");
		System.out.printf(title);
		System.out.println(name);
		System.out.println(content);
		System.out.println(Group);
		System.out.println(Step);
		System.out.println(Indent);
		
		dao.replyDao(title, name, content, Group, (Step+1), (Indent+1));
		
	return "redirect:evaluation_reply";
	}
	
	public void replyShape(int group, int step) {	
		System.out.println("replyShape 들어왔다!!!");
		dao.replyShape(group, step);
		
		System.out.println(group);
		System.out.println(step);
	}
}

package com.study.springboot;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		return "/cs/report";
	}
	@RequestMapping("/history")
	public String history(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		return "/cs/history";
	}
	@RequestMapping("/notice")
	public String notice(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		return "/cs/notice";
	}
	@RequestMapping("/QnA")
	public String QnA(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String writer = (String) session.getAttribute("id");
		/*
		 * String QnA_content = request.getParameter("QnA_content"); dao.QnA(writer,
		 * QnA_content);
		 */
		return "/cs/QnA";
	}
	@RequestMapping("/QnA_write")
	public String QnA_write(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String writer = (String) session.getAttribute("id");
		String QnA_content = request.getParameter("QnA_content"); 
		dao.QnA(writer,QnA_content);		
		return "/cs/QnA";
	}
	@RequestMapping("/notification")
	public void notify(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		//int noti = dao.notify();
	}
}

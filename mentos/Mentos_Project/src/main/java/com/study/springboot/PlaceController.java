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
import org.springframework.web.bind.annotation.ResponseBody;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.study.springboot.dao.IPlaceDao;

@Controller
@RequestMapping("/place")
public class PlaceController {
	
	@Autowired
	private IPlaceDao placedao;
	
	@RequestMapping("/place_list")
	public String userlistPage(HttpServletRequest request,HttpSession session, Model model, @ModelAttribute("bPageInfo") BPageInfo bPageInfo) {
		System.out.println("list");
		//page데이터 
		int totalCount = bPageInfo.getTotalcount();
		int listCount = 6;
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
		totalCount = placedao.totalCount();
		
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
		model.addAttribute("list", placedao.listDao(nEnd, nStart));
		model.addAttribute("page", pinfo);	
		
		return "/place/place_list";
	}
	
	@RequestMapping("/rent")
	public String place_rent() {
		
		return "/place/place_rent";	
	}
	
	@RequestMapping("/rentDao")
	public String rent(HttpServletRequest request , Model model )
	{	
		String space = request.getParameter("place_space");
		String name = request.getParameter("place_name");
		String place = request.getParameter("place");
		String place_2 = request.getParameter("place_place");
		String people_num = request.getParameter("place_people_num");
		String price = request.getParameter("place_price");
		String phone = request.getParameter("place_phone");	
		String email = request.getParameter("place_email");				
		String content = request.getParameter("place_content");
		String image = request.getParameter("place_image");
		String rdate = request.getParameter("place_receiveStartDate");
		String redate = request.getParameter("place_receiveEndDate");
		String rtime = request.getParameter("place_receiveStartTime");
		String retime = request.getParameter("place_receiveEndTime");
		
		System.out.println(space);
		System.out.println(name);
		System.out.println(place);
		System.out.println(place_2);
		System.out.println(people_num);
		System.out.println(price);	
		System.out.println(phone);
		System.out.println(email);
		System.out.println(content);
		System.out.println(image);	
		System.out.println(rdate);
		System.out.println(redate);
		System.out.println(rtime);
		System.out.println(retime);
		System.out.println("------------------------------------------------------");
		
		
		Map<String, String> rentMap = new HashMap<String, String>();
		
		rentMap.put("place_space", space);
		rentMap.put("place_name", name);
		rentMap.put("place_place", place);
		rentMap.put("place_place2", place_2);
		rentMap.put("place_people_num", people_num);
		rentMap.put("place_price", price);
		rentMap.put("place_phone", phone);
		rentMap.put("place_email", email);
		rentMap.put("place_content", content);
		rentMap.put("place_image", image);
		rentMap.put("place_rdate", rdate);
		rentMap.put("place_redate", redate);
		rentMap.put("place_rtime", rtime);
		rentMap.put("place_retime", retime);
		
		placedao.rentDao(rentMap);
		
		return "redirect:place_list";
	}
	
	@RequestMapping("/place_delete")
	public String delete(HttpServletRequest request, Model model) {
		placedao.placeDelete(request.getParameter("place_number"));
	return "redirect:place_list";
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
			System.out.println("231");
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
	
	@RequestMapping("/view")
	public String view(HttpServletRequest request, Model model) {
		String sId = request.getParameter("place_number");
		model.addAttribute("dto", placedao.viewDao(sId));
		
		return "place/place_view";
	}
	@RequestMapping("/place_reservation")
	public String place_reservation(HttpServletRequest request, Model model) {
		String sId = request.getParameter("place_number");
		model.addAttribute("dto", placedao.viewDao(sId));
		
		return "/place/place_reservation";	
	}
	
	@RequestMapping("/place_modify")
	public String modify(HttpServletRequest request, Model model) {
		String sId = request.getParameter("place_number");
		model.addAttribute("dto", placedao.viewDao(sId));
		
		return "place/place_modify";
	}
	
	@RequestMapping("/modifyOk")
	public String modify_OK(HttpServletRequest request, Model model) {
		
		String number = request.getParameter("place_number");
		String name = request.getParameter("place_name");
		String place = request.getParameter("place");
		String place_2 = request.getParameter("place_place");
		String people_num = request.getParameter("place_people_num");
		String price = request.getParameter("place_price");
		String phone = request.getParameter("place_phone");	
		String email = request.getParameter("place_email");				
		String content = request.getParameter("place_content");
		String image = request.getParameter("place_image");
		String rdate = request.getParameter("place_receiveStartDate");
		String redate = request.getParameter("place_receiveEndDate");
		String rtime = request.getParameter("place_receiveStartTime");
		String retime = request.getParameter("place_receiveEndTime");
		String space = request.getParameter("place_space");
		
		System.out.println(number);
		System.out.println(name);
		System.out.println(place);
		System.out.println(place_2);
		System.out.println(people_num);
		System.out.println(price);	
		System.out.println(phone);
		System.out.println(email);
		System.out.println(content);
		System.out.println(image);	
		System.out.println(rdate);
		System.out.println(redate);
		System.out.println(rtime);
		System.out.println(retime);
		System.out.println("------------------------------------------------------");
		
		
		Map<String, String> modifyMap = new HashMap<String, String>();
		
		modifyMap.put("place_space", space);
		modifyMap.put("place_number", number);
		modifyMap.put("place_name", name);
		modifyMap.put("place_place", place);
		modifyMap.put("place_place2", place_2);
		modifyMap.put("place_people_num", people_num);
		modifyMap.put("place_price", price);
		modifyMap.put("place_phone", phone);
		modifyMap.put("place_email", email);
		modifyMap.put("place_content", content);
		modifyMap.put("place_image", image);
		modifyMap.put("place_rdate", rdate);
		modifyMap.put("place_redate", redate);
		modifyMap.put("place_rtime", rtime);
		modifyMap.put("place_retime", retime);
		
		
		
		placedao.modifyOk(modifyMap);
		
		return "redirect:place_list";
	}
}

package member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.Inter_MemberDAO;
import member.model.MemberDAO;

public class MemberFormEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {


		String method = request.getMethod(); 


		if(method.equalsIgnoreCase("POST")) {

			String userid = request.getParameter("userid");
			String userpw = request.getParameter("userpw");
			String username = request.getParameter("username");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			String postno1 = request.getParameter("postno1");
			String postno2 = request.getParameter("postno2");
			String addr1 = request.getParameter("addr1");
			String addr2 = request.getParameter("addr2");

			HashMap<String, String> map = new HashMap<String, String>(); 
			map.put("userid", userid); 
			map.put("userpw", userpw); 
			map.put("username",username); 
			map.put("email", email); 
			map.put("phone", phone); 
			map.put("postno1", postno1); 
			map.put("postno2", postno2); 
			map.put("addr1", addr1); 
			map.put("addr2", addr2); 

			Inter_MemberDAO memberdao = new MemberDAO(); 

			int n =  memberdao.registerMember(map); 

			String message = "";
			String loc = "";

			if(n==1) {
				message = "회원가입 성공";
				loc = request.getContextPath()+"/index.army"; 

			}
			else {
				message = "회원가입 실패";
				loc = "javascript:history.back()";
			}

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

			super.setViewPage("/WEB-INF/msg.jsp");		

		}
		else {
			String message = "비정상 접근";
			String loc = "javascript:history.back()";

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

			super.setViewPage("/WEB-INF/msg.jsp");

		}
	}

}

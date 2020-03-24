package member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.Inter_MemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class LoginEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod(); 
		
		if(!"POST".equalsIgnoreCase(method)) {
			
			String message = "보안상태가 아닙니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		
		String userid = request.getParameter("userid");
		String userpw = request.getParameter("userpw");
		
		
		Inter_MemberDAO memberdao = new MemberDAO();
		
		HashMap<String,String> paraMap = new HashMap<String,String>();
		paraMap.put("userid", userid);
		paraMap.put("userpw", userpw);
		
		
		MemberVO loginuser = memberdao.getOneMember(paraMap);

		// 로그인 성공시 
		if(loginuser != null) {

			HttpSession session = request.getSession();
			session.setAttribute("loginuser", loginuser);
			
			
			String message = "로그인 성공";
			String loc = request.getContextPath()+"/index.army"; 
			

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			
			super.setViewPage("/WEB-INF/msg.jsp");		
		}
		
		// 로그인 실패시		
		else {
			String message = "로그인 실패";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
		}

	}

}

package member.controller;

import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;
import common.controller.AbstractController;
import member.model.*;
import mypage.model.*;

public class MemberWithDrawalAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.getCategoryList(request);
		
		String method = request.getMethod();
		request.setAttribute("status", "true");
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser!=null) {
			if("POST".equalsIgnoreCase(method)) {
	
				if(loginuser!=null) {
					String userno = Integer.toString((loginuser.getUserno()));  //주석 세션에서 받아와야함
					String reason = request.getParameter("reason");
					String content = request.getParameter("content");
					String userpw = request.getParameter("pwd");
					System.out.println("reason"+reason+"content"+content+"비밀번호"+userpw);
					
					HashMap<String, String> paraMap = new HashMap<String, String>();
					paraMap.put("userno", userno);
					paraMap.put("reason", reason);
					paraMap.put("content", content);
					paraMap.put("userpw", userpw);
					
					Inter_MypageDAO dao = new MypageDAO();
					
					int n = dao.withdrawalOneMember(paraMap);
					
					System.out.println("최종확인 n : " + n);
					
					if(n==1) {
						System.out.println("성공하셨습니다");
						session.removeAttribute("loginuser");;
						super.setViewPage("/WEB-INF/index.jsp");
						
					}
					
					else {
						request.setAttribute("status", "false");
						super.setViewPage("/WEB-INF/member/memberWithdrawal.jsp");
					}
				}
			}
			else{
				super.setViewPage("/WEB-INF/member/memberWithdrawal.jsp");
			}
		}
		else {
			String message = "먼저 로그인을 하세요!!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
	}
}
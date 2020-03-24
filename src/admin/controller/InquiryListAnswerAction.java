package admin.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.AdminDAO;
import admin.model.InquiryVO;
import admin.model.InterAdminDAO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class InquiryListAnswerAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		super.getCategoryList(request);

		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		
		
		if(loginuser != null) {
			
			String idx = request.getParameter("idx"); 

			HashMap<String, String> paraMap = new HashMap<String, String>(); 
			paraMap.put("userid", loginuser.getUserid()); 
			paraMap.put("idx", idx); 
			
			InterAdminDAO idao = new AdminDAO();
			
			InquiryVO member = idao.listOneQna(paraMap); 
			
			if(member != null) {
				
				request.setAttribute("member", member);
				
				super.setViewPage("/WEB-INF/admin/inquiryListAnswer.jsp");
			}

			// 다른 사람이 장난처서 들어 왔을 경우 
			else {
				
				String message = "비정상 접근입니다.";
				String loc = "/SemiProject/index.army";

				request.setAttribute("message", message);
				request.setAttribute("loc", loc);

				super.setViewPage("/WEB-INF/msg.jsp");
			}
		}
		
		
		else {
			
			String message = "비정상 접근입니다.";
			String loc = "/SemiProject/index.army";

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}

package customercenter.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import customercenter.model.Customercenter_InquiryVO;
import customercenter.model.Customercenter_inquiryDAO;
import customercenter.model.InterCustomercenter_inquiryDAO;
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
			
			InterCustomercenter_inquiryDAO idao = new Customercenter_inquiryDAO();
			
			Customercenter_InquiryVO member = idao.listOneQna(paraMap); 
			
			if(member != null) {
				
				request.setAttribute("member", member);
				
				super.setViewPage("/WEB-INF/customercenter/inquiryListAnswer.jsp");
			}

			// 다른 사람이 장난처서 들어 왔을 경우 
			else {
				
				String message = "비정상 접근입니다.";
				String loc = "javascript:history.back()";

				request.setAttribute("message", message);
				request.setAttribute("loc", loc);

				super.setViewPage("/WEB-INF/msg.jsp");
			}
		}
		
		
		else {
			
			String message = "비정상 접근입니다.";
			String loc = "javascript:history.back()";

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}

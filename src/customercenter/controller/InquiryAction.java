package customercenter.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import customercenter.model.Customercenter_inquiryDAO;
import customercenter.model.InterCustomercenter_inquiryDAO;
import member.model.MemberVO;

public class InquiryAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {



		HttpSession session = request.getSession();

		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");


		if(loginuser != null) {


			String method = request.getMethod(); 



			if("POST".equalsIgnoreCase(method)) {
				
				InterCustomercenter_inquiryDAO idao = new Customercenter_inquiryDAO(); 
				
				String inquirytitle = request.getParameter("inquirytitle"); 
				String inquirycontent = request.getParameter("inquirycontent"); 
				String userid = loginuser.getUserid(); 
				

				inquirycontent= inquirycontent.replaceAll("\r\n", "<br/>");
				
				HashMap<String, String> map = new HashMap<String, String>(); 
				map.put("inquirytitle", inquirytitle); 
				map.put("inquirycontent", inquirycontent); 
				map.put("userid", userid); 
				
				
				
				  int result = idao.insertinquiry(map); 
				
				 // int result = 1; 
				
				
				if(result == 1) {
					String message = "문의 완료 되었습니다"; 
					
					String loc = request.getContextPath() + "/customercenter/inquiryList.army";

					request.setAttribute("message", message);
					request.setAttribute("loc", loc);

					super.setViewPage("/WEB-INF/msg.jsp");
				}

				
				else {
					
					String message = "처리과정중 오류가 발생했습니다.\n"
							+ "02-939-2342로 문의 바랍니다.";
					
					String loc = "javascript:loaction.reload()"; 

					request.setAttribute("message", message);
					request.setAttribute("loc", loc);

					super.setViewPage("/WEB-INF/msg.jsp");
				}
				
				
			}

			else {

				super.setViewPage("/WEB-INF/customercenter/inquiry.jsp");
			}
		}
		else {

			String message = "회원만 문의가 가능합니다.";
			String loc = "javascript:history.back()";

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

			super.setViewPage("/WEB-INF/msg.jsp");
		}

	}

}

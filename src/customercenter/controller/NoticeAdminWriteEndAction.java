package customercenter.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import customercenter.model.Customercenter_noticeDAO;
import customercenter.model.InterCustomercenter_noticeDAO;
import member.model.MemberVO;

public class NoticeAdminWriteEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.getCategoryList(request);
		
		HttpSession session = request.getSession();

		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null) {
			
			if( loginuser.getUserid().equals("admin") ) {
				
				
				String noticetile = request.getParameter("noticetile"); 
				String noticecontent = request.getParameter("noticecontent"); 
				
				
				HashMap<String, String > map = new HashMap<String, String>(); 
				
				map.put("noticetile", noticetile); 
				map.put("noticecontent", noticecontent); 
				
				System.out.println(noticetile);
				System.out.println(noticecontent);
				
				InterCustomercenter_noticeDAO ndao = new Customercenter_noticeDAO();
				
				int n = ndao.insernotice(map);
				
				
				if( n == 1 ) {
					String message = "공지사항을 올립니다.";
					String loc = request.getContextPath() + "/customercenter/notice.army";

					request.setAttribute("message", message);
					request.setAttribute("loc", loc);

					super.setViewPage("/WEB-INF/msg.jsp");
				}  
				
				else {
					
					String message = "오류 발생";
					String loc = "javascript:history.back()";

					request.setAttribute("message", message);
					request.setAttribute("loc", loc);

					super.setViewPage("/WEB-INF/msg.jsp");
				}
 				
				
					
			}
			
			
			else {
				
				String message = "관리자만 가능합니다.";
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

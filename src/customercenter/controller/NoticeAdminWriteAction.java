package customercenter.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class NoticeAdminWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		super.getCategoryList(request);
		
		HttpSession session = request.getSession();

		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");



		if(loginuser != null) {

			if( loginuser.getUserid().equals("admin") ) {
				super.setViewPage("/WEB-INF/customercenter/noticeAdminWrite.jsp");
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

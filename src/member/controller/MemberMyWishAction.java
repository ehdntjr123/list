package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import mypage.model.Inter_MypageDAO;
import mypage.model.MypageDAO;

public class MemberMyWishAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser!=null) {
			super.getCategoryList(request);
			
			Inter_MypageDAO mydao = new MypageDAO();
			
			int totalHITCount = mydao.wishTotalCount(loginuser.getUserno());
			
			request.setAttribute("wishTotal", totalHITCount);
			
			super.setViewPage("/WEB-INF/member/membermyWish.jsp");
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

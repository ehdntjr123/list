package admin.controller;

import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.AdminDAO;
import admin.model.InterAdminDAO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class ProdOneDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.getCategoryList(request);
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser != null) {
		
			if(!"admin".equals(loginuser.getUserid())) {
				String message = "관리자만 접근 가능합니다.";
				String loc = "/SemiProject/index.army";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
			else {	
				
				String productno = request.getParameter("productno");
				
				InterAdminDAO adao = new AdminDAO();
				
				try {
				
				int n = adao.deleteOneProd(productno);
				int m = adao.deleteOneProdImg(productno);
				
				if(n*m != 0) {
					String message = "삭제했습니다.";
					String loc = request.getContextPath()+"/index.army";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setViewPage("/WEB-INF/msg.jsp");
					
				}
				
				} catch (SQLIntegrityConstraintViolationException e) {
					String message = "누군가의 장바구니에 들어있습니다.";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				
			}
			
		}
		
		else {
			String message = "로그인을 먼저 하세요.";
			String loc = "/SemiProject/index.army";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
		}

	}

}

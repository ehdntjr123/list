package admin.controller;

import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.AdminDAO;
import admin.model.InterAdminDAO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class ProdOneAddAction extends AbstractController {

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
				String count = request.getParameter("count");
				
				InterAdminDAO adao = new AdminDAO();
				
				
				int n = adao.addOneProd(productno, count);
				
				if(n == 1) {
				
					String message = "추가했습니다.";
					String loc = "/SemiProject/admin/productAdd.army";
					
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

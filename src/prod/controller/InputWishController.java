package prod.controller;

import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import prod.model.InterProdDAO;
import prod.model.ProdDAO;

public class InputWishController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String productno_ = request.getParameter("productno");
		
		InterProdDAO pdao = new ProdDAO();
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		
		String message = "";
		
		if(loginuser == null) {
			message = "로그인이 필요합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loce", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		else {
			String userid = loginuser.getUserid();
			
			String userno = pdao.getUserno(userid);
			
			try {
			
			boolean checkWishDuplication = pdao.checkWishDuplication(userno, productno_);
			
			if(checkWishDuplication) {
				message = "위시리스트에 추가되었습니다.";
				request.setAttribute("checkDuplication", checkWishDuplication);
				request.setAttribute("message", message);
			}
			
		} catch (SQLIntegrityConstraintViolationException e) {
			message = "이미 있는 상품입니다.";
			request.setAttribute("message", message);
		}
		
		}
		
			super.setViewPage("/WEB-INF/product/inputWish.jsp");

	}

}
 
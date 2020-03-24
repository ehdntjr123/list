package prod.controller;

import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import prod.model.InterProdDAO;
import prod.model.ProdDAO;

public class InputCartCheckController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String productno_ = request.getParameter("productno");
		
		InterProdDAO pdao = new ProdDAO();
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String userid = "";
		
		// *** 클라이언트의 IP 주소 알아오기 *** //
		String clientip = request.getRemoteAddr();
		
		if(loginuser != null) {
		userid = loginuser.getUserid();
		}
		else {
			userid = null;
		}
		
		int cnt = pdao.cartCount(userid, clientip);
		
		boolean checkDuplication = pdao.checkDuplication(userid, productno_);
		
		int n = 0;
		String message = "";
		if(!checkDuplication) {
		
			if(cnt < 5) {
				n = pdao.inputCart(productno_, userid, clientip);
			}
			else {
				message = "장바구니는 5개 까지만 넣을 수 있습니다.";
				request.setAttribute("message", message);
			}
		}
		else {
			
			int m = pdao.plusOrderCount(productno_, userid);
			
			if(m == 1) {
				message = "장바구니에 이미 있는 제품으로 수량 증가했습니다.";
				request.setAttribute("message", message);
			}
			else {
				message = "오류났다";
				request.setAttribute("message", message);
			}

		}
	
			boolean flag = false;
			
			if(n==1) {
				flag = true;
			}
		
			request.setAttribute("flag", flag);
		
			request.setAttribute("checkDuplication", checkDuplication);
		
		
		
		super.setViewPage("/WEB-INF/product/inputCartCheck.jsp");

	}

}
 
package prod.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import prod.model.InterProdDAO;
import prod.model.ProdDAO;

public class DeleteCartController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String productno = request.getParameter("productno");
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		// *** 클라이언트의 IP 주소 알아오기 *** //
		String clientip = request.getRemoteAddr();
		
		String userid = "";
		
		if(loginuser != null) {
			userid = loginuser.getUserid();
		}
		else {
			userid = null;
		}
		
		InterProdDAO pdao = new ProdDAO();
		
		int n = pdao.deleteCart(productno, userid, clientip);
		
		String loc = "/SemiProject/prod/prodCart.army";
		
		request.setAttribute("loc", loc);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/msg.jsp");

	}

}

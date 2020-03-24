package prod.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import prod.model.InterProdDAO;
import prod.model.ProdDAO;

public class PlusCartCountController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String productno_ = request.getParameter("productno");
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String userid = "";
		if(loginuser != null) {
			userid = loginuser.getUserid();
		}
		else {
			userid = null;
		}
		
		InterProdDAO pdao = new ProdDAO();
		pdao.plusOrderCount(productno_, userid);
		
		String loc = "/SemiProject/prod/prodCart.army";
		
		request.setAttribute("loc", loc);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/msg.jsp");

	}

}

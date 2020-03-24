package prod.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import prod.model.InterProdDAO;
import prod.model.ProdDAO;
import prod.model.ProdVO;

public class ProdCartController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
				
		super.getCategoryList(request);
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String userid = "";
		
		// *** 클라이언트의 IP 주소 알아오기 *** //
		String clientip = request.getRemoteAddr();
		
		if(loginuser != null) {
			userid = loginuser.getUserid();
			
			InterProdDAO pdao = new ProdDAO();
			
			List<String> cartProdNo =  pdao.getCartList(userid, clientip);
			
			List<ProdVO> cartList = null;
			
			int sum = 0;
			
			if(cartProdNo != null) {
			cartList = pdao.showCartList(cartProdNo, userid, clientip);
			
			sum = pdao.getCartSum(cartProdNo, userid, clientip);
			}
			
			
			request.setAttribute("cartList", cartList);
			request.setAttribute("sum", sum);
			
		}
		else {
			userid = null;
			
			InterProdDAO pdao = new ProdDAO();
			
			List<String> cartProdNo =  pdao.getCartList(userid, clientip);
			
			List<ProdVO> cartList = null;
			
			int sum = 0;
			
			if(cartProdNo != null) {
			cartList = pdao.showCartList(cartProdNo, userid, clientip);
			
			sum = pdao.getCartSum(cartProdNo, userid, clientip);
			}
			
			session.setAttribute("cartList", cartList);
			session.setAttribute("sum", sum);
		}
		
		super.setViewPage("/WEB-INF/product/productCart.jsp");
		
		

	}

}

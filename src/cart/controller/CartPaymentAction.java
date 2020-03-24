package cart.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import prod.model.InterProdDAO;
import prod.model.ProdDAO;

public class CartPaymentAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		super.getCategoryList(request);
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		// *** 클라이언트의 IP 주소 알아오기 *** //
		String clientip = request.getRemoteAddr();
		
		InterProdDAO pdao = new ProdDAO();
		
		String userid = "";
		int sum = 0;
		List<String> cartProdNo = null;
		
		String productno = request.getParameter("productno");
		String price = request.getParameter("price");
		
		//회원일 때
		if(loginuser != null) {
			userid = loginuser.getUserid();
			cartProdNo =  pdao.getCartList(userid, clientip);

		}
		//비회원일 때
		else {
			userid = null;
			cartProdNo =  pdao.getCartList(userid, clientip);
		}
		
		sum = 0;
		
		//바로구매인지를 확인 
		if(productno != null) {
			int prodPrice = Integer.parseInt(price);
			if( prodPrice < 100000 ) {
				prodPrice += 3000;
			}
			session.setAttribute("sum", prodPrice);
			session.setAttribute("productno", productno);
		}
		else {
			//장바구니 구매일때
			if(cartProdNo != null) {
				sum = pdao.getCartSum(cartProdNo, userid, clientip);
			
				//상품 합계가 10만원 이상이면 배송비 무료
				if(sum < 100000) {
					sum += 3000;
				}
				session.setAttribute("sum", sum);
			}
			else {
				String message = "바로구매도 아니고, 장바구니 구매도 아닌 상태입니다. 다시 확인해주세요.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
		}
		
		super.setViewPage("/WEB-INF/cart/cartPayment.jsp");
	}
}

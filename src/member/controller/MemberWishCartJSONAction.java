package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;
import mypage.model.Inter_MypageDAO;
import mypage.model.MypageDAO;
import prod.model.InterProdDAO;
import prod.model.ProdDAO;

public class MemberWishCartJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		String userno = request.getParameter("userno");
		String productjoin = request.getParameter("productjoin");
		String userid = request.getParameter("userid");
		
		// *** 클라이언트의 IP 주소 알아오기 *** //
		String clientip = request.getRemoteAddr();
		
		JSONObject jsobj = new JSONObject();
		
		String message = "";
		String loc = "";
		int n =0;
		int state=0;
		
		int cnt=0;

		if(userid != null) {

			String[] productArr = productjoin.split(",");
			
			InterProdDAO prddao = new ProdDAO();
			
			Inter_MypageDAO mydao = new MypageDAO();

			if(productArr!=null) {
				
				jsobj.put("n", 1);
				
				for(int i=0; i<productArr.length; i++) {
					
					cnt = prddao.cartCount(userid, clientip);
					
					if(cnt>4) {

						jsobj.put("n", 0);
						break;
					}
					else {

						int k = mydao.wishToCart(userid, productArr[i]);
						
						if(k==0) {
							jsobj.put("n", 2);
						}
						
						n = mydao.deletOneWishProduct(userno, productArr[i]);

						if(state==productArr.length && n==1) {
							jsobj.put("n", 1);
						}
						
						state += k;
					}
				}

				String result = jsobj.toString();
				
				request.setAttribute("result", result);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jsonResult.jsp");
				
			}

		}

		 message = "먼저 로그인하세요";
		 loc = "/SemiProeject/index.army";
		
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		
	}

}

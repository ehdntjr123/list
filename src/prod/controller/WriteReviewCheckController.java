package prod.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import prod.model.InterProdDAO;
import prod.model.ProdDAO;
import prod.model.ProdVO;

public class WriteReviewCheckController extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	   
	   String productname = request.getParameter("productname");
	   
	   HttpSession session = request.getSession();
	   MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
	   
	   InterProdDAO pdao = new ProdDAO();
	   
	   if(loginuser == null) {
		   String message = "로그인을 하십시오.";
	         String loc = "/SemiProject/index.army";

	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);

	         super.setViewPage("/WEB-INF/msg.jsp");
	   }
	   
	   else {
		   
		   ProdVO product = pdao.showOrderProduct(productname);
		   
		   request.setAttribute("product", product);
		
		   super.setViewPage("/WEB-INF/product/writeReview.jsp");
	   }

   }

}
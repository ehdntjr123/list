package prod.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import prod.model.InterProdDAO;
import prod.model.ProdDAO;

public class ReviewDeleteController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String productname = request.getParameter("productname");
		  
	      HttpSession session = request.getSession();

	      MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

	      InterProdDAO pdao = new ProdDAO();
	      
	      if(loginuser != null) {
	    	  String userid = loginuser.getUserid();
	    	  
	    	  String userno = pdao.getUserno(userid);
	    	  String productno = pdao.getProdNo(productname);
	    	  
	    	  HashMap<String, String> map = new HashMap<String,String>();
	    	  map.put("productno", productno);
	    	  map.put("userno", userno);

	          int result = pdao.deleteReview(map); 
           
	            if(result == 1) {
	               String message = "삭제 완료"; 
	               
	               String loc = request.getContextPath() + "/member/memberMyOrder.army";

	               request.setAttribute("message", message);
	               request.setAttribute("loc", loc);

	               super.setViewPage("/WEB-INF/msg.jsp");
	            }

	            
	            else {
	               
	               String message = "02-939-2342로 문의 바랍니다.";
	               
	               String loc = request.getContextPath() + "/member/memberMyOrder.army"; 

	               request.setAttribute("message", message);
	               request.setAttribute("loc", loc);

	               super.setViewPage("/WEB-INF/msg.jsp");
	            }
	            
	            
	      }


	      else {

	         String message = "로그인을 하십시오.";
	         String loc = "/SemiProject/index.army";

	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);

	         super.setViewPage("/WEB-INF/msg.jsp");
	      }


	}

}

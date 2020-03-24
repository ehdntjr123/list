package admin.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.AdminDAO;
import admin.model.InterAdminDAO;
import common.controller.AbstractController;
import member.model.MemberVO;
import prod.model.ProdVO;

public class ProductDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		super.getCategoryList(request);
		
		HttpSession session = request.getSession();
	      MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
	      
	      if(loginuser == null ) {
	         String message = "관리자만 접근이 가능합니다.";
	         String loc = "/SemiProject/index.army";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
	         
	         return;
	         
	      }
	         
	      else{
	         String userid = loginuser.getUserid();
	         
	         if(!"admin".equals(userid)) {
	            
	         String message = "관리자 로그인을 해야 가능합니다.";
	         String loc = "SemiProject/index.army";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
	         
	         return;
	         
	         }
	      }
	      
	      String currentShowPageNo = request.getParameter("currentShowPageNo");
	       
	      String sizePerPage = request.getParameter("sizePerPage");
	      
	      if(currentShowPageNo == null)
	          currentShowPageNo = "1";
	       
	        if(sizePerPage == null || 
	           !("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage)))
	           sizePerPage = "10";
	       
	      String searchType = request.getParameter("searchType");
	      String searchWord = request.getParameter("searchWord");
	      
	      InterAdminDAO dao = new AdminDAO();
	      
	      HashMap<String, String> paraMap = new HashMap<String, String>();
	      paraMap.put("currentShowPageNo", currentShowPageNo);
	      paraMap.put("sizePerPage", sizePerPage);
	            
	      if(searchType != null) {
	         paraMap.put("searchType", searchType);
	         paraMap.put("searchWord", searchWord);
	         
	      }
	      
	      List<ProdVO> prodList = dao.listAllProd(paraMap); 

	      int totalPage = dao.getTotalProdPage(paraMap);
	      
	      int pageNo = 1;
	      
	      int blockSize = 10;
	      
	      int loop = 1;
	      
	      pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize)*blockSize + 1; 

	      String pageBar = "";
	      
	      if(searchType == null && searchWord == null) {
	    	  searchWord = "";
	    	  searchType = "";
	      }
	      
	      if( pageNo != 1 ) {
	         pageBar += "&nbsp;<a href='productDelete.army?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a>&nbsp;"; 
	      }
	      
	      while(!(loop > blockSize || pageNo > totalPage)) {
	          //   10  >  10    
	         //   11  >  10
	         
	         if(pageNo == Integer.parseInt(currentShowPageNo)) {
	            pageBar += "&nbsp;<span style='color: red; border: solid 1px gray; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";
	         }
	         else if(pageNo != Integer.parseInt(currentShowPageNo)){
	            pageBar += "&nbsp;<a href='productDelete.army?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a>&nbsp;";
	         }
	         
	         
	         pageNo++; 
	         loop++; 
	      }
	      
	      if( !(pageNo > totalPage) ) {
	         pageBar += "&nbsp;<a href='productDelete.army?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a>&nbsp;"; 
	      }
	      
	      request.setAttribute("prodList", prodList);
	      request.setAttribute("sizePerPage", sizePerPage);
	      request.setAttribute("pageBar", pageBar);
	      
	      request.setAttribute("searchType", "");
	      request.setAttribute("searchWord", "");

	      
	      super.setViewPage("/WEB-INF/admin/productDelete.jsp");

	}

}

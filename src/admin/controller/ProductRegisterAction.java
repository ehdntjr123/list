package admin.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import admin.model.AdminDAO;
import admin.model.InterAdminDAO;
import common.controller.AbstractController;
import member.model.MemberVO;
import prod.model.ProdVO;

public class ProductRegisterAction extends AbstractController {
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		super.getCategoryList(request);
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser != null) {
		
			if(!"admin".equals(loginuser.getUserid())) {
				String message = "관리자만 접근 가능합니다.";
				String loc = "/SemiProject/index.army";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}
		
		else {
			String message = "로그인을 먼저 하세요.";
			String loc = "/SemiProject/index.army";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			
			super.setViewPage("/WEB-INF/admin/productRegister.jsp");
		}
		
		else {
			
			/*
			 	submit 한 폼의 enctype 이 multipart/form-data 라면
			 	request로는 데이터 값을 받아 올 수 없고,
			 	cos.jar 라이브러리를 다운 받아 사용하도록 한 후
			 	아래의 객체를 사용하여 데이터 값 및 파일까지 받아올 수 있다.
			 */
			MultipartRequest mtrequest = null;
			// 1. 첨부되어진 파일을 디스크의 어느 경로에 업로드 할 것인지 경로를 설정해야 한다.
			
			session = request.getSession();
			
			ServletContext svlCtx = session.getServletContext();
			String imagesDir = svlCtx.getRealPath("/images/products");
			
           
		  try {	
			  //  === 파일을 업로드 해준다.  ===
			  mtrequest = new MultipartRequest(request, imagesDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy() );
			
	      } catch(IOException e) {
	    	  request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 10MB를 초과했으므로 파일업로드 실패함!!");
	    	  request.setAttribute("loc", request.getContextPath()+"/admin/productRegister.army"); 
	    	  
	    	  System.out.println("대표이미지 파일에서 에러남");
	    	  
	    	  super.setViewPage("/WEB-INF/msg.jsp");
	    	  return;
		  }
			
		  
		  // === 첨부 이미지 파일을 올렸으니 그 다음으로 제품정보를 (제품명, 정가, 제품수량,...) DB의 jsp_product 테이블에 insert 를 해주어야 한다.  === 
		  InterAdminDAO pdao = new AdminDAO();
		  
		  // 새로운 제품 등록시 form 태그 에서 입력한 값들을 얻어오기
		  String productname = mtrequest.getParameter("productname");
		  String brand = mtrequest.getParameter("brand");
		  String fk_pcategoryno = mtrequest.getParameter("fk_pcategoryno");
		  // 업로드되어진 시스템의 첨부파일 이름을 얻어 올때는 
		  // cos.jar 라이브러리에서 제공하는 MultipartRequest 객체의 getFilesystemName("form에서의 첨부파일 name명") 메소드를 사용 한다. 
		  // 이때 업로드 된 파일이 없는 경우에는 null을 반환한다.		  
		  String pimage = mtrequest.getFilesystemName("pimage");
		  
		  String pstock = mtrequest.getParameter("pstock");
		  String price = mtrequest.getParameter("price");
		  
		  ProdVO pvo = new ProdVO();
		  int productno = pdao.getProductnoOfProduct();  // 제품번호 채번 해오기
		  
		  pvo.setProductno(productno);
		  pvo.setFk_pcategoryno(Integer.parseInt(fk_pcategoryno));
		  pvo.setProductname(productname);
		  pvo.setBrand(brand);
		  pvo.setPimage(pimage);
		  pvo.setPstock(Integer.parseInt(pstock));
		  pvo.setPrice(Integer.parseInt(price));
		  
		  
		  int n = pdao.productInsert(pvo);   // jsp_product 테이블에 insert 하기
		  
		  int m = 1;
		  String str_attachCount = mtrequest.getParameter("attachCount");
		  if(!"".equals(str_attachCount)) {
			  int attachCount = Integer.parseInt(str_attachCount);

			  for(int i=0; i<attachCount; i++) {
				  String attachFileName = mtrequest.getFilesystemName("attach"+i); 		
				  
				  // jsp_product_imagefile 테이블에 추가이미지 파일명 insert 해주기 
				  m = pdao.product_imagefile_Insert(productno, attachFileName);
				  
				  if(m==0) break;
			  }// end of for---------------------
		  }// end of if--------------------------
		  
		  String message = "";
		  String loc = "";
		  
		  if(n*m==1) {
			  message = "제품등록 성공!!";
			  loc = request.getContextPath()+"/index.army";
		  }
		  else {
			  message = "제품등록 실패!!";
			  loc = request.getContextPath()+"/admin/productRegister.army";
		  }
		  
		  request.setAttribute("message", message);
		  request.setAttribute("loc", loc);
		  
		  super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
		
		
		
	}

}

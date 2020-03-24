package common.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import prod.model.InterProdDAO;
import prod.model.ProdDAO;

public abstract class AbstractController implements InterCommand {
	
	//public abstract void test();
	
	/*
	 	=== 다음은 우리끼리의 약속이다. ===
	 	
	 	※ view 단 페이지(.jsp)로 이동시 forward 방법으로 이동시키고자 한다라면
	 	자식클래스에서는 부모클래스에서 생성해둔 메소드 호출시 아래와 같이 하면 되도록 한다.
	 	
	 	super.setRedirect(false);
	 	super.setViewPage("WEB-INF/index.jsp");
	 	
	 	※ URL 주소를 변경하여 페이지를 이동시키고자 한다면
	 	즉, sendRedirect 를 하고자 한다면
	 	자식클래스에서는 부모클래스에서 생성해둔 메소드 호출시 아래와 같이 한다
	 	
	 	super.setRedirect(true);
	 	super.setViewPage("registerMember.up");
	 */
	
	private boolean isRedirect = false;
	private String viewPage;
	
	public boolean isRedirect() {
		return isRedirect;
	}
	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}
	public String getViewPage() {
		return viewPage;
	}
	public void setViewPage(String viewPage) {
		this.viewPage = viewPage;
	}	

	public void getCategoryList(HttpServletRequest request) throws SQLException {
		
		/*
		 	jsp_category 테이블에서
		 	카테고리 코드(code), 카테고리 명(cname)을 불러와
		 	request 영역에 저장시킨다.
		 */
		
		InterProdDAO dao = new ProdDAO();
		
		List<HashMap<String,String>> categoryList = dao.getCategoryList();
		
		request.setAttribute("categoryList", categoryList);
		
		
	}
	
}

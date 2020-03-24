package common.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import prod.model.*;

public class IndexController extends AbstractController {

	/*
	 * @Override public void test() {
	 * System.out.println("★확인용 : IndexController 의 인스턴스 메소드 test() 호출됨"); }
	 */
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.getCategoryList(request);

		InterProdDAO pdao = new ProdDAO();
		
		// ajax(json)을 사용하여 hit 상품 목록을 더보기 방식으로 페이징처리
		//int totalCategoryCount = pdao.totalCategoryCount(code);
		
		List<ProdVO> product = pdao.showMainView();				
		
		request.setAttribute("product", product);

		
		//super.setRedirect(false);
		super.setViewPage("/WEB-INF/index.jsp");
	}
}

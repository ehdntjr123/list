package prod.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class CategoryListController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 카테고리 목록 조회
		super.getCategoryList(request);
		
		super.setViewPage("/WEB-INF/product/categoryList.jsp");

	}

}

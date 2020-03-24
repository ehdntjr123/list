package prod.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class DeleteCartCheckController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.getCategoryList(request);
		
		String productno = request.getParameter("productno");
		
		request.setAttribute("productno", productno);
		
		super.setViewPage("/WEB-INF/product/deleteCartCheck.jsp");

	}

}

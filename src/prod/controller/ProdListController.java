package prod.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import prod.model.InterProdDAO;
import prod.model.ProdDAO;

public class ProdListController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.getCategoryList(request);
		
		String code = request.getParameter("code");
		
		String search = request.getParameter("search");
		
		if(code==null || code.trim().isEmpty()) {
			code = "1";
		}
		
		if(search == null || search.trim().isEmpty()) {
				search = null;
		}
		
		HashMap<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("code", code);
		paraMap.put("search", search);
		
		InterProdDAO pdao = new ProdDAO();
		
		int totalCount = pdao.getTotalCount(paraMap);
		
		request.setAttribute("code", code);
		request.setAttribute("search", search);
		
		request.setAttribute("totalCount", totalCount);
		
		super.setViewPage("/WEB-INF/product/productList.jsp");
	}

}

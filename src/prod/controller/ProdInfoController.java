package prod.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import prod.model.InterProdDAO;
import prod.model.ProdDAO;
import prod.model.ProdImgVO;
import prod.model.ProdVO;
import prod.model.ReviewVO;

public class ProdInfoController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.getCategoryList(request);
		
		String productno_ = request.getParameter("productno");
		
		InterProdDAO pdao = new ProdDAO();
		
		ProdVO product = pdao.showProdInfo(productno_);
		List<ProdImgVO> prodimgList = pdao.showProdInfoImg(productno_);
		List<ReviewVO> reviewList = pdao.showReview(productno_);
		
		
		request.setAttribute("product", product);
		request.setAttribute("prodimgList", prodimgList);
		request.setAttribute("reviewList", reviewList);
		
		super.setViewPage("/WEB-INF/product/productInfo.jsp");

	}

}

package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import mypage.model.Inter_MypageDAO;
import mypage.model.MypageDAO;

public class MemberWishDelJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		String userno = request.getParameter("userno");
		String productjoin = request.getParameter("productjoin");
				
		String[] productArr = productjoin.split(",");
		
		Inter_MypageDAO mydao = new MypageDAO();
		
		JSONObject jsobj = new JSONObject();
		
		if(productArr!=null) {
			int cnt = mydao.deletWishProduct(userno, productArr);
			
			if(cnt==productArr.length) {
				jsobj.put("n", 1);
			}
			else {
				jsobj.put("n", 0);
			}
		}
		else {
			jsobj.put("n", 0);
		}
		
		String result = jsobj.toString();
		
		request.setAttribute("result", result);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonResult.jsp");
		
	}

}

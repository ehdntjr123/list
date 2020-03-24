package member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import mypage.model.Inter_MypageDAO;
import mypage.model.MypageDAO;

public class MemberWishJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userno = request.getParameter("userno");
		String start = request.getParameter("start");
		String len = request.getParameter("len");
		
		if(start==null || start.trim().isEmpty() ) {
			start = "1";
		}
		
		if(len==null || len.trim().isEmpty() ) {
			len = "8";
		}	
		
		
		
		Inter_MypageDAO mydao = new MypageDAO();
		
		HashMap<String, String> paraMap = new HashMap<String, String>();
		
		String end = String.valueOf(Integer.parseInt(start)+Integer.parseInt(len)-1);

		paraMap.put("userno", userno);		
		paraMap.put("startRno", start);  //  startRno  1   9   17  25
		paraMap.put("endRno", end);  		
		
		
		//위시리스트 보여주기
		List<HashMap<String, String>> paraList = mydao.showWishList(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if(paraList != null) {
			for(HashMap <String, String> map : paraList) {
				JSONObject jsobj = new JSONObject();
				
				jsobj.put("productname", map.get("productname"));
				jsobj.put("price", map.get("price"));
				jsobj.put("pcategory", map.get("pcategory"));
				jsobj.put("pimage", map.get("pimage"));
				jsobj.put("productno", map.get("productno"));

				
				jsonArr.put(jsobj);
			}// end of for------------------------------------
		}// end of if--------------------------------------------
		
		String result = jsonArr.toString();

		request.setAttribute("result", result);

		super.setViewPage("/WEB-INF/jsonResult.jsp");
	}

}

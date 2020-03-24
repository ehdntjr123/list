package prod.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import prod.model.InterProdDAO;
import prod.model.ProdDAO;
import prod.model.ProdVO;

public class ProdDisplayJSONController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String code = request.getParameter("code");
		
		String search = request.getParameter("search");
		
		String sort = request.getParameter("sort");
		
		String start = request.getParameter("start");
		
		String len = request.getParameter("len");
		
		if(code==null || code.trim().isEmpty()) {
			code = "1";
		}
		if(start==null || start.trim().isEmpty()) {
			start = "1";
		}
		if(len==null || len.trim().isEmpty()) {
			len = "8";
		}
		if(search==null || search.trim().isEmpty()) {
			search = null;
		}
		
		String end = String.valueOf(Integer.parseInt(start)+Integer.parseInt(len)-1);
		
		InterProdDAO pdao = new ProdDAO();
		
		HashMap<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("code", code);
		paraMap.put("search", search);
		paraMap.put("sort", sort);
		paraMap.put("start", start);
		paraMap.put("end", end);
		
		List<ProdVO> prodList = pdao.getProdList(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if(prodList != null) {
			for(ProdVO pvo : prodList) {
				JSONObject jsobj = new JSONObject();
				// JSONObject 는 JSON형태{키:값}의 데이터로 만들어주는 것.
				jsobj.put("productno", pvo.getProductno());
				jsobj.put("productname", pvo.getProductname());
				jsobj.put("brand", pvo.getBrand());
				jsobj.put("pimage", pvo.getPimage());
				jsobj.put("price", pvo.getPrice());
				jsobj.put("pstock", pvo.getPstock());
				jsobj.put("fk_pcategoryno", pvo.getFk_pcategoryno());
				jsobj.put("pinputdate", pvo.getPinputdate());					
				
				jsonArr.put(jsobj);
			}
		}
		
		String result = jsonArr.toString();
		
		request.setAttribute("result", result);
		
		super.setViewPage("/WEB-INF/jsonResult.jsp");

	}

}

package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.Inter_MemberDAO;
import member.model.MemberDAO;

public class CheckUseridAction extends AbstractController {
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		String method = request.getMethod();
		
		if(method.equalsIgnoreCase("POST")) {
			String userid = request.getParameter("userid"); 
			
			Inter_MemberDAO dao = new MemberDAO(); 
			
			boolean bool = dao.isUseridExist(userid);
			
			if( userid.equalsIgnoreCase("") ) {
				bool = true; 
			}
			
			JSONObject jsobj = new JSONObject();
			jsobj.put("result", bool);
			
			String result = jsobj.toString();
			
			request.setAttribute("result", result);
			
			super.setViewPage("/WEB-INF/jsonResult.jsp");
		}
				
	}

}

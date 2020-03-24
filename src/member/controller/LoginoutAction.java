package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class LoginoutAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession(); 
		session.invalidate(); 
		
		
		super.setRedirect(true);
		super.setViewPage(request.getContextPath()+"/index.army"); 
		
	}

}

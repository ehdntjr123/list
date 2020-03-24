package customercenter.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import customercenter.model.Customercenter_noticeDAO;
import customercenter.model.Customercenter_noticeVO;
import customercenter.model.InterCustomercenter_noticeDAO;

public class NoticeListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		super.getCategoryList(request);
		
		String idx = request.getParameter("idx");

		InterCustomercenter_noticeDAO ndao = new Customercenter_noticeDAO(); 
		
		Customercenter_noticeVO list = ndao.selectOneNoticeList(idx);
		
		request.setAttribute("list", list);
		
		super.setViewPage("/WEB-INF/customercenter/noticeOneDetail.jsp");
		
	}

}

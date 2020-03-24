package customercenter.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import customercenter.model.Customercenter_noticeDAO;
import customercenter.model.Customercenter_noticeVO;
import customercenter.model.InterCustomercenter_noticeDAO;

public class NoticeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		super.getCategoryList(request);
		
		InterCustomercenter_noticeDAO dao = new Customercenter_noticeDAO(); 

		// select 문으로 공지사항을 읽어옴 
		try {

				
				String currentShowPageNo = request.getParameter("currentShowPageNo");
				String sizePerPage = request.getParameter("sizePerPage");
				
				
				if(currentShowPageNo == null)
					currentShowPageNo = "1";
				
				if(sizePerPage == null || 
					       !("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage)))
					    	sizePerPage = "10";
				
				
				
				// 해쉬맵으로 
				HashMap<String, String> paraMap = new HashMap<String, String>();
				paraMap.put("currentShowPageNo", currentShowPageNo);
				paraMap.put("sizePerPage", sizePerPage);
				
				
				
				// 페이징 처리를 위해  db에서 내용 가져오기 
				List<Customercenter_noticeVO> noticeprint = dao.noticeSelect(paraMap); 
				
				
				
				// 페이지 갯수를 알아오는 방법 
				int totalPage = dao.getTotalPage(sizePerPage);
				
				int pageNo = 1;  // 현재 보여지는 페이지 번호
				
				int blockSize = 10; // 현재 페이지에서 보여지는 게시물  갯수 
				
				int loop = 1;  // blockSize에 대해서 나누었을때 총 게시물 페이지갯수
				
				
				// 현재 보이지는 페이지 번호 (공식)  
				pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize)*blockSize + 1; 
				
				
				
				String pageBar = "";
				
				// *** [이전] 만들기 *** //
				if( pageNo != 1 ) {
					pageBar += "&nbsp;<a href='notice.army?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"'>[이전]</a>&nbsp;"; 
				}
				
				while(!(loop > blockSize || pageNo > totalPage)) {
				    //   10  >  10 	
					//   11  >  10
					
					if(pageNo == Integer.parseInt(currentShowPageNo)) {
						pageBar += "&nbsp;<span style='color: red; border: solid 1px gray; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";
					}
					else {
						pageBar += "&nbsp;<a href='notice.army?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a>&nbsp;";
					}
					
					pageNo++;  
					loop++;   
				}// end of while---------------------------
				
				// *** [다음] 만들기 *** //
				if( !(pageNo > totalPage) ) {
					pageBar += "&nbsp;<a href='notice.army?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>[다음]</a>&nbsp;"; 
				}
				
				request.setAttribute("noticeprint", noticeprint);
				request.setAttribute("sizePerPage", sizePerPage);
				request.setAttribute("pageBar", pageBar);  
				
				
				
				
				super.setViewPage("/WEB-INF/customercenter/notice.jsp");
				
				

		} catch (Exception e) {
			e.printStackTrace();
		} 


	}



}


package customercenter.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import customercenter.model.Customercenter_InquiryVO;
import customercenter.model.Customercenter_inquiryDAO;
import customercenter.model.InterCustomercenter_inquiryDAO;
import member.model.MemberVO;

public class InquiryListAction extends AbstractController {

	
	// 1:1 문의 관리자에서 전체 볼수 있는 매소드와 
	// 개인 회원이 1:1 문의를 한 경우 
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		super.getCategoryList(request);

		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null) {

			if( loginuser.getUserid().equals("admin") ) {

				String currentShowPageNo = request.getParameter("currentShowPageNo");
				String sizePerPage = request.getParameter("sizePerPage");
				
				
				// 추가 부분 - 처리 현황  
				String rep = request.getParameter("rep"); 
				
				
				
				
				if(currentShowPageNo == null)
					currentShowPageNo = "1";
				
				if(sizePerPage == null || 
					       !("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage)))
					    	sizePerPage = "10";
				
				
				// 추가 부분 
				if(rep == null || !( "1".equals(rep) || "0".equals(rep) ) ) {
					rep = "1"; 
				}
				
				
				
				
				
				
				// 해쉬맵
				HashMap<String, String> paraMap = new HashMap<String, String>();
				paraMap.put("currentShowPageNo", currentShowPageNo);
				paraMap.put("sizePerPage", sizePerPage);
				
				
				
				// 추가 부분 
				paraMap.put("rep", rep);
				
				
				
				
				InterCustomercenter_inquiryDAO qdao = new Customercenter_inquiryDAO(); 
				
				
				// 문의 내역 전부 출력하기 
				List<Customercenter_InquiryVO> inquiryList = qdao.listAllQna(paraMap);
				
				
				
				// 페이지 갯수를 알아오는 방법 
				int totalPage = qdao.getTotalPage(sizePerPage);
				
				int pageNo = 1;  // 현재 보여지는 페이지 번호
				
				int blockSize = 10; // 현재 페이지에서 보여지는 게시물  갯수 
				
				int loop = 1;  // blockSize에 대해서 나누었을때 총 게시물 페이지갯수
				
				// 현재 보이지는 페이지 번호 (공식)  
				pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize)*blockSize + 1; 
				
				
				
				String pageBar = "";
				
				// *** [이전] 만들기 *** //
				if( pageNo != 1 ) {
					pageBar += "&nbsp;<a href='inquiryList.army?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"'>[이전]</a>&nbsp;"; 
				}
				
				while(!(loop > blockSize || pageNo > totalPage)) {
				    //   10  >  10 	
					//   11  >  10
					
					if(pageNo == Integer.parseInt(currentShowPageNo)) {
						pageBar += "&nbsp;<span style='color: red; border: solid 1px gray; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";
					}
					else {
						pageBar += "&nbsp;<a href='inquiryList.army?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a>&nbsp;";
					}
					
					pageNo++;  
					loop++;   
				}// end of while---------------------------
				
				// *** [다음] 만들기 *** //
				if( !(pageNo > totalPage) ) {
					pageBar += "&nbsp;<a href='inquiryList.army?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>[다음]</a>&nbsp;"; 
				}
				
				
				request.setAttribute("inquiryList", inquiryList);
				request.setAttribute("sizePerPage", sizePerPage);
				request.setAttribute("pageBar", pageBar);  
				request.setAttribute("rep", rep);  
				
				
				super.setViewPage("/WEB-INF/customercenter/inquiryList.jsp");
				
			}

			// 일반 사용자 
			else {
				
				String userid = loginuser.getUserid(); 
				String currentShowPageNo = request.getParameter("currentShowPageNo");
				String sizePerPage = request.getParameter("sizePerPage");
				
				
				if(currentShowPageNo == null)
					currentShowPageNo = "1";
				
				if(sizePerPage == null || 
					       !("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage)))
					    	sizePerPage = "10";
				
				
				// 해쉬맵
				HashMap<String, String> paraMap = new HashMap<String, String>();
				paraMap.put("currentShowPageNo", currentShowPageNo);
				paraMap.put("sizePerPage", sizePerPage);
				paraMap.put("userid", userid); 
				
				InterCustomercenter_inquiryDAO qdao = new Customercenter_inquiryDAO(); 
				
				
				// 회원 개인 문의 내역  출력하기 
				List<Customercenter_InquiryVO> inquiryList = qdao.listUserQna(paraMap);
				
				
				
				// 페이지 갯수를 알아오는 방법 
				int totalPage = qdao.getTotalPage(sizePerPage);
				
				int pageNo = 1;  // 현재 보여지는 페이지 번호
				
				int blockSize = 10; // 현재 페이지에서 보여지는 게시물  갯수 
				
				int loop = 1;  // blockSize에 대해서 나누었을때 총 게시물 페이지갯수
				
				// 현재 보이지는 페이지 번호 (공식)  
				pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize)*blockSize + 1; 
				
				
				
				String pageBar = "";
				
				// *** [이전] 만들기 *** //
				if( pageNo != 1 ) {
					pageBar += "&nbsp;<a href='inquiryList.army?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"'>[이전]</a>&nbsp;"; 
				}
				
				while(!(loop > blockSize || pageNo > totalPage)) {
				    //   10  >  10 	
					//   11  >  10
					
					if(pageNo == Integer.parseInt(currentShowPageNo)) {
						pageBar += "&nbsp;<span style='color: red; border: solid 1px gray; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";
					}
					else {
						pageBar += "&nbsp;<a href='inquiryList.army?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a>&nbsp;";
					}
					
					pageNo++;  
					loop++;   
				}// end of while---------------------------
				
				// *** [다음] 만들기 *** //
				if( !(pageNo > totalPage) ) {
					pageBar += "&nbsp;<a href='inquiryList.army?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>[다음]</a>&nbsp;"; 
				}
				
				
				request.setAttribute("inquiryList", inquiryList);
				request.setAttribute("sizePerPage", sizePerPage);
				request.setAttribute("pageBar", pageBar);
				
				
				super.setViewPage("/WEB-INF/customercenter/inquiryList.jsp");
			}
		}


		else {

			String message = "비정상 접근입니다.";
			String loc = "javascript:history.back()";

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}

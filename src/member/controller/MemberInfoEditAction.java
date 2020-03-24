package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import mypage.model.*;


public class MemberInfoEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.getCategoryList(request);
		
		String method= request.getMethod();
		
		request.removeAttribute("state");
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser!=null) {
			if(("POST").equalsIgnoreCase(method)) {
				
				MemberVO mvo = new MemberVO();
				
				if(mvo!=null) {
					mvo.setUserid(request.getParameter("myUserid"));
					mvo.setUserpw(request.getParameter("join_pw"));
					mvo.setEmail(request.getParameter("email1")+("@")+request.getParameter("email2"));
					mvo.setPhone(request.getParameter("phone"));
					mvo.setPostno(request.getParameter("post1")+request.getParameter("post2"));
					mvo.setAddr1(request.getParameter("addr1"));
					mvo.setAddr2(request.getParameter("addr2"));
								
					System.out.println("유저아이디 : "+ mvo.getUserid());
					System.out.println("비밀번호 : "+ mvo.getUserpw());
					System.out.println("email : "+ mvo.getEmail());
					System.out.println("phone : "+ mvo.getPhone());
					System.out.println("postno : "+ mvo.getPostno());
					System.out.println("addr1 : "+ mvo.getAddr1());
					System.out.println("addr2 : "+ mvo.getAddr2());
					
					Inter_MypageDAO mydao = new MypageDAO();
						
					int n = mydao.changeOneMember(mvo);
		
					if(n!=0) {
						
						System.out.println("회원정보변경에 성공하셨습니다.");
						
						super.setViewPage("/WEB-INF/member/membermypage.jsp");
										
					}
					else if(n==0) {
						request.setAttribute("state", "false");
						super.setViewPage("/WEB-INF/member/membermyInfoEdit.jsp");
						
					}
								
					//super.setViewPage("/member/membermypage.army");
				}
			}
			else {	
				super.setViewPage("/WEB-INF/member/membermyInfoEdit.jsp");
			}				
		}
		else {
			String message = "먼저 로그인을 하세요!!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
	}
}

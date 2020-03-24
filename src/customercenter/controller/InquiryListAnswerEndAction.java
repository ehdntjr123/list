package customercenter.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import customercenter.model.Customercenter_inquiryDAO;
import customercenter.model.InterCustomercenter_inquiryDAO;
import member.model.MemberVO;

public class InquiryListAnswerEndAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

      HttpSession session = request.getSession();

      MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");


      if(loginuser != null) {

         if( loginuser.getUserid().equals("admin") ) {

            InterCustomercenter_inquiryDAO idao = new Customercenter_inquiryDAO(); 
            String inquiryno = request.getParameter("inquiryno"); 
            String inquirycoment = request.getParameter("inquirycoment"); 
            
            inquirycoment = inquirycoment.replaceAll("\r\n", "<br/>");
            
            HashMap<String, String> map = new HashMap<String, String>(); 
            map.put("inquiryno", inquiryno); 
            map.put("inquirycoment", inquirycoment); 
            

            // 문의내역 답변해주기 
            int n = idao.answerInquir(map); 
            

            if(n == 1) {
               String message = "정상적으로 답글을 남겼습니다.";
               String loc = request.getContextPath()+"/customercenter/inquiryList.army";

               request.setAttribute("message", message);
               request.setAttribute("loc", loc);

               super.setViewPage("/WEB-INF/msg.jsp");
            }


         }

         else {
            String message = "관리자만 가능합니다.";
            String loc = "javascript:history.back()";

            request.setAttribute("message", message);
            request.setAttribute("loc", loc);

            super.setViewPage("/WEB-INF/msg.jsp");
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
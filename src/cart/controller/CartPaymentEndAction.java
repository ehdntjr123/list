package cart.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cart.model.CartDAO;
import cart.model.CartDTO;
import cart.model.InterCartDAO;
import cart.model.OrderDetailVO;
import cart.model.OrderListVO;
import cart.model.StatementVO;
import common.controller.AbstractController;
import member.model.MemberVO;


public class CartPaymentEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String userid = "";
		
		// *** 클라이언트의 IP 주소 알아오기 *** //
		String clientip = request.getRemoteAddr();
		
		InterCartDAO cdao = new CartDAO();
		
		//1. 전표 생성
		int n = cdao.createStatement();
		
		if(n != 1) {
			String message = "전표 생성에러!! 다시 결제를 해주세요.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		StatementVO statementVO = cdao.selectStatement();
		
		//2. 회원정보, 장바구니 정보 조회를 얻어 와야 한다.
		//	 상품정보에서 바로 구매로 넘어올 경우 장바구니 정보가 없다
		String orderAddress1 = request.getParameter("address1");
		String orderAddress2 = request.getParameter("address2");
		String orderPostNo = request.getParameter("post");
		String paymentname = request.getParameter("paymentName");
		String paymentMode = request.getParameter("radio");
		
		//주문상세 목록
		List<OrderDetailVO> odetailVOList = new ArrayList<OrderDetailVO>();
		List<CartDTO> cartList = null;
		OrderDetailVO odetailVO = null;
		List<OrderListVO> orderList = null;
		
		//바로구매인지 장바구니구매인지 확인
		String productno = request.getParameter("productno");
		
		//회원일 때
		if(loginuser != null) {
			
			userid = loginuser.getUserid();
			cartList = cdao.selectByUseridCartList(userid, clientip);
			
			int userno = cdao.searchUserno(userid);
	
			productno = productno.trim();
			
			//바로구매일 경우
			if( productno != null && !"".equals(productno)) {
				
				odetailVO = new OrderDetailVO();
				
				//주문번호 채번
				int orderno = cdao.getOrderNo();
				odetailVO.setOrderno(orderno);
				odetailVO.setOrderAddr1(orderAddress1);
				odetailVO.setOrderAddr2(orderAddress2);
				odetailVO.setOrderPostNo(orderPostNo);
				odetailVO.setOrdercount(1);
				odetailVO.setFk_productno(Integer.parseInt(productno));
				odetailVO.setFk_statementno(statementVO.getStatementno());
				odetailVO.setFk_userno(userno);
				
				int result = cdao.insertOrderDetail(odetailVO, userid);
				
				if(result == 1) {
					System.out.println("바로 구매한정보 삽입 성공");

				}
				else {
					String message = "바로 구매한정보 삽입 실패";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setViewPage("/WEB-INF/msg.jsp");
					return;
				}
			}
			//장바구니로 구매할 경우
			else {
				
				if(cartList != null) {
					
					for(int i=0; i < cartList.size(); i++) {
						OrderDetailVO tempodetailVO = new OrderDetailVO();
						CartDTO CartDTO = cartList.get(i);
						
						//주문번호 채번
						int orderno = cdao.getOrderNo();
						
						tempodetailVO.setOrderno(orderno);
						tempodetailVO.setOrderAddr1(orderAddress1);
						tempodetailVO.setOrderAddr2(orderAddress2);
						tempodetailVO.setOrderPostNo(orderPostNo);
						tempodetailVO.setOrdercount(CartDTO.getCartordercount());
						tempodetailVO.setFk_cartno(CartDTO.getCartno());
						tempodetailVO.setFk_productno(CartDTO.getFk_productno());
						tempodetailVO.setFk_userno(loginuser.getUserno());
						tempodetailVO.setFk_statementno(statementVO.getStatementno());
						
						odetailVOList.add(tempodetailVO);
					}
					
					//주문상세 테이블에 결제 정보 저장
					int result = cdao.insertOrderDetailList( odetailVOList, userid );
					
					if( result == 1 ) {
						System.out.println("주문상세 테이블 결제 정보 저장 완료");
					}
					else {
						String message = "주문상세 테이블 결제 정보 저장 실패..... 결제 취소후 다시 시도 해주세요.";
						String loc = "javascript:history.back()";
						
						request.setAttribute("message", message);
						request.setAttribute("loc", loc);
						
						super.setViewPage("/WEB-INF/msg.jsp");
						return;
					}
				}
				else {
					String message = "장바구니에 정보도 없고, 바로 구매하는 경우도 아닙니다. 다시 선택해주세요.";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setViewPage("/WEB-INF/msg.jsp");
					return;
				}
			}

			//배송정보 생성
			
			//배송번호 채굴
			int shippingno = cdao.getShippingNo();
			
			//택배 회사는 CJ로 통일
			String shippingcode = "CJ";
			
			//날짜는 전표등록날짜에서 얻어온다.
			// ex) CJ181217
			shippingcode += statementVO.getStatementday().substring(2);	
			//랜덤 문자열 4자리 대문자
			StringBuffer temp = new StringBuffer();
			Random rnd = new Random();
			for (int i = 0; i < 4; i++) {
				// A-Z
			    temp.append((char) ((int) (rnd.nextInt(26)) + 65));
			}
			
			//ex) CJ181217ABCD
			shippingcode += temp.toString();
			
			System.out.println(shippingcode);
			
			//배송 정보 저장
			int result = cdao.insertShippinginfo(shippingno, shippingcode);
			
			if(result == 1) {
				System.out.println("배송정보 삽입 성공");
			}
			else {
				String message = "배송정보가 잘못되었습니다. 다시 한번 확인 후 시도해주세요.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
			
			//주문내역 테이블 결제 정보 저장
			orderList = new ArrayList<OrderListVO>();
			
			if(odetailVOList.size() > 0) {
				for(int i=0, j=odetailVOList.size(); i<j; i++) {
					OrderListVO olistVO = new OrderListVO();
					OrderDetailVO tempodetailVO = odetailVOList.get(i);
					
					//주문내역번호 채굴
					int orderListno = cdao.getOrderListNo();

					olistVO.setOrdercompleteno(orderListno);
					olistVO.setPaymentmode(paymentMode);
					olistVO.setPaymentname(paymentname);
					olistVO.setFk_orderdetailno(tempodetailVO.getOrderno());
					olistVO.setFk_statementno(statementVO.getStatementno());
					olistVO.setFk_shippingno(shippingno);
					
					orderList.add(olistVO);
				}
			}
			else {

				OrderListVO olistVO = new OrderListVO();
				
				//주문내역번호 채굴
				int orderListno = cdao.getOrderListNo();
				
				olistVO.setOrdercompleteno(orderListno);
				olistVO.setPaymentmode(paymentMode);
				olistVO.setPaymentname(paymentname);
				olistVO.setFk_orderdetailno(odetailVO.getOrderno());
				olistVO.setFk_statementno(statementVO.getStatementno());
				olistVO.setFk_shippingno(shippingno);
				
				orderList.add(olistVO);
			}

			System.out.println("orderList: " + orderList);

			//주문내역 정보 삽입
			result = cdao.insertOrderListVO(orderList);
			
			if( result == 1) {
				System.out.println("주문내역 정보 삽입 성공");
				
				request.setAttribute("orderList", orderList);
			}
			else {
				String message = "주문내역 정보 삽입 에러..... 다시 해주세요.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
			
		}
		//비회원
		else {
			
			userid = null;
			cartList = cdao.selectByUseridCartList(userid, clientip);
	
			productno = productno.trim();
			
			//바로구매일 경우
			if( productno != null && !"".equals(productno)) {
				
				odetailVO = new OrderDetailVO();
				
				//주문번호 채번
				int orderno = cdao.getOrderNo();
				odetailVO.setOrderno(orderno);
				odetailVO.setOrderAddr1(orderAddress1);
				odetailVO.setOrderAddr2(orderAddress2);
				odetailVO.setOrderPostNo(orderPostNo);
				odetailVO.setOrdercount(1);
				odetailVO.setFk_productno(Integer.parseInt(productno));
				odetailVO.setFk_statementno(statementVO.getStatementno());
				
				int result = cdao.insertOrderDetail(odetailVO, userid);
				
				if(result == 1) {
					System.out.println("바로 구매한정보 삽입 성공");
				}
				else {
					String message = "바로 구매한정보 삽입 실패";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setViewPage("/WEB-INF/msg.jsp");
					return;
				}
			}
			//장바구니로 구매할 경우
			else {
				
				if(cartList != null) {
					
					for(int i=0; i < cartList.size(); i++) {
						OrderDetailVO tempodetailVO = new OrderDetailVO();
						CartDTO CartDTO = cartList.get(i);
						
						//주문번호 채번
						int orderno = cdao.getOrderNo();
						
						tempodetailVO.setOrderno(orderno);
						tempodetailVO.setOrderAddr1(orderAddress1);
						tempodetailVO.setOrderAddr2(orderAddress2);
						tempodetailVO.setOrderPostNo(orderPostNo);
						tempodetailVO.setOrdercount(CartDTO.getCartordercount());
						tempodetailVO.setFk_cartno(CartDTO.getCartno());
						tempodetailVO.setFk_productno(CartDTO.getFk_productno());
						tempodetailVO.setFk_statementno(statementVO.getStatementno());
						
						odetailVOList.add(tempodetailVO);
					}
					
					//주문상세 테이블에 결제 정보 저장
					int result = cdao.insertOrderDetailList( odetailVOList, userid );
					
					if( result == 1 ) {
						System.out.println("주문상세 테이블 결제 정보 저장 완료");
					}
					else {
						String message = "주문상세 테이블 결제 정보 저장 실패..... 결제 취소후 다시 시도 해주세요.";
						String loc = "javascript:history.back()";
						
						request.setAttribute("message", message);
						request.setAttribute("loc", loc);
						
						super.setViewPage("/WEB-INF/msg.jsp");
						return;
					}
				}
				else {
					String message = "장바구니에 정보도 없고, 바로 구매하는 경우도 아닙니다. 다시 선택해주세요.";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setViewPage("/WEB-INF/msg.jsp");
					return;
				}
			}
			
			//배송정보 생성
			
			//배송번호 채굴
			int shippingno = cdao.getShippingNo();
			
			//택배 회사는 CJ로 통일
			String shippingcode = "CJ";
			
			//날짜는 전표등록날짜에서 얻어온다.
			// ex) CJ181217
			shippingcode += statementVO.getStatementday().substring(2);	
			//랜덤 문자열 4자리 대문자
			StringBuffer temp = new StringBuffer();
			Random rnd = new Random();
			for (int i = 0; i < 4; i++) {
				// A-Z
			    temp.append((char) ((int) (rnd.nextInt(26)) + 65));
			}
			
			//ex) CJ181217ABCD
			shippingcode += temp.toString();
			
			System.out.println(shippingcode);
			
			//배송 정보 저장
			int result = cdao.insertShippinginfo(shippingno, shippingcode);
			
			if(result == 1) {
				System.out.println("배송정보 삽입 성공");
			}
			else {
				String message = "배송정보가 잘못되었습니다. 다시 한번 확인 후 시도해주세요.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
			
			//주문내역 테이블 결제 정보 저장
			orderList = new ArrayList<OrderListVO>();
			
			if(odetailVOList.size() > 0) {
				
				for(int i=0, j=odetailVOList.size(); i<j; i++) {
					
					OrderListVO olistVO = new OrderListVO();
					OrderDetailVO tempodetailVO = odetailVOList.get(i);
					
					//주문내역번호 채굴
					int orderListno = cdao.getOrderListNo();

					olistVO.setOrdercompleteno(orderListno);
					olistVO.setPaymentmode(paymentMode);
					olistVO.setPaymentname(paymentname);
					olistVO.setFk_orderdetailno(tempodetailVO.getOrderno());
					olistVO.setFk_statementno(statementVO.getStatementno());
					olistVO.setFk_shippingno(shippingno);
					
					orderList.add(olistVO);
				}
				
			}
			else {

				OrderListVO olistVO = new OrderListVO();
				
				//주문내역번호 채굴
				int orderListno = cdao.getOrderListNo();
				
				olistVO.setOrdercompleteno(orderListno);
				olistVO.setPaymentmode(paymentMode);
				olistVO.setPaymentname(paymentname);
				olistVO.setFk_orderdetailno(odetailVO.getOrderno());
				olistVO.setFk_statementno(statementVO.getStatementno());
				olistVO.setFk_shippingno(shippingno);
				
				orderList.add(olistVO);
			}

			//주문내역 정보 삽입
			result = cdao.insertOrderListVO(orderList);
			
			if( result == 1) {
				System.out.println("주문내역 정보 삽입 성공");
				
				request.setAttribute("orderList", orderList);
			}
			else {
				String message = "주문내역 정보 삽입 에러..... 다시 해주세요.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
			
		}
		
		//결제 완료 페이지 이동
		super.setViewPage("/WEB-INF/cart/cartPaymentEnd.jsp");
	}

}

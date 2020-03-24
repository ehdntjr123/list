package member.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import mypage.model.Inter_MypageDAO;
import mypage.model.MypageDAO;
import prod.model.InterProdDAO;
import prod.model.ProdDAO;

public class MemberMyOrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		super.getCategoryList(request);

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		if (loginuser != null) {

			int userno = loginuser.getUserno();

			if (loginuser != null) {

				// 1. 페이징 처리를 위해 1페이지당 보여줄 장바구니에 들어간 제품의 갯수를 몇개로 할 것인가를 정한다.
				// 한 페이지당 보여줄 장바구니에 들어간 제품의 갯수는 3개로 한다.
				int sizePerPage = 5;

				// 2. 페이징 처리한 데이터 조회 결과물 가져오기
				// -- 전체 페이지 갯수 알아오기
				int totalPage = 0;

				// -- 장바구니에 들어있는 제품의 총갯수 구하기
				Inter_MypageDAO mydao = new MypageDAO();
				String toDate = request.getParameter("toDate");
				String fromDate = request.getParameter("fromDate");

				int totalCountCart = 0;

				if (toDate == null) {

					Calendar cal = Calendar.getInstance();
					cal.setTime(new Date());
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

					cal.add(Calendar.MONTH, -6);
					System.out.println("todate가 널일때 toDate: " + df.format(cal.getTime()));

					fromDate = df.format(cal.getTime());

					Date time = new Date();
					SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
					toDate = format1.format(time);
					System.out.println("toDate가 널일때 fromDate:" + fromDate);

				}

				totalCountCart = mydao.getTotalCountOrder(fromDate, toDate, userno);

				totalPage = (int) Math.ceil((double) totalCountCart / sizePerPage);
				// 20.0/3 = 6.666666666666667‬ ==> 7.0 ==> 7
				// 21.0/3 = 7.0 ==> 7.0 ==> 7

				// -- 조회하고자 하는 페이지번호를 받아와야 한다.
				int currentShowPageNo = 0;

				String str_currentShowPageNo = request.getParameter("currentShowPageNo");

				if (str_currentShowPageNo == null) {
					currentShowPageNo = 1;
				} else {
					currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				}

				if (currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}

				System.out.println("toDate:" + toDate);
				System.out.println("fromDate:" + fromDate);
				System.out.println("userno:" + userno);
				System.out.println("currentShowPageNo:" + currentShowPageNo);
				System.out.println("sizePerPage:" + sizePerPage);

				List<HashMap<String, String>> listMap = mydao.oneMemberOrderList(fromDate, toDate, userno,
						currentShowPageNo, sizePerPage);

				if (listMap != null) {
					for (HashMap<String, String> map : listMap) {
						System.out.println("이미지 : " + map.get("pimage"));
						System.out.println("이름 : " + map.get("productname"));
						System.out.println("가격 : " + map.get("price"));
						System.out.println("카테고리 : " + map.get("pcategory"));
						System.out.println("주문일 : " + map.get("statementday"));
						System.out.println("배송상태 : " + map.get("shipstatus"));
					}
				}

				// -- 페이지바 만들기
				String url = "memberMyOrder.army";
				int blockSize = 5;

				// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 갯수이다.

				// 1 2 3 4 5 [다음] -- 1개 블럭
				// [이전] 6 7 8 9 10 [다음] -- 1개 블럭
				// [이전] 11 12 -- 1개 블럭

				int loop = 1;
				// loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 갯수(위의 설명상 지금은 5(==blockSize)까지만 증가하는 용도이다.
				int pageNo = ((currentShowPageNo - 1) / blockSize) * blockSize + 1;

				// *** !! 공식이다. !! *** //
				/*
				 * 1 2 3 4 5 -- 첫번째 블럭의 페이지번호 시작값(pageNo)은 1 이다. 6 7 8 9 10 -- 두번째 블럭의 페이지번호
				 * 시작값(pageNo)은 6 이다. 11 12 -- 세번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.
				 * 
				 * currentShowPageNo pageNo --------------------------- 1 ((1 - 1)/5) * 5 + 1
				 * ==> 1 2 ((2 - 1)/5) * 5 + 1 ==> 1 3 ((3 - 1)/5) * 5 + 1 ==> 1 4 ((4 - 1)/5) *
				 * 5 + 1 ==> 1 5 ((5 - 1)/5) * 5 + 1 ==> 1
				 * 
				 * 6 ((6 - 1)/5) * 5 + 1 ==> 6 7 ((7 - 1)/5) * 5 + 1 ==> 6 8 ((8 - 1)/5) * 5 + 1
				 * ==> 6 9 ((9 - 1)/5) * 5 + 1 ==> 6 10 ((10 - 1)/5) * 5 + 1 ==> 6
				 * 
				 * 11 ((11 - 1)/5) * 5 + 1 ==> 11 12 ((12 - 1)/5) * 5 + 1 ==> 11
				 */

				String pageBar = "";

				// *** [이전] 만들기 *** //

				if (pageNo != 1) {
					pageBar += "&nbsp;<a href='" + url + "?currentShowPageNo=" + (pageNo - 1) + "&toDate=" + toDate
							+ "&fromDate=" + fromDate + "'>[이전]</a>&nbsp;";
				}

				while (!(loop > blockSize || pageNo > totalPage)) {

					if (pageNo == currentShowPageNo) {
						pageBar += "&nbsp;<span style='color:red; border:solid 1px gray; padding: 2px 4px;'>" + pageNo
								+ "</span>&nbsp;";
					} else {
						pageBar += "&nbsp;<a href='" + url + "?currentShowPageNo=" + pageNo + "&toDate=" + toDate
								+ "&fromDate=" + fromDate + "'>" + pageNo + "</a>&nbsp;";
					}

					loop++;
					pageNo++;
				} // end of while----------------------

				// *** [다음] 만들기 *** //
				if (!(pageNo > totalPage)) {

					pageBar += "&nbsp;<a href='" + url + "?currentShowPageNo=" + pageNo + "&toDate=" + toDate
							+ "&fromDate=" + fromDate + "'>[다음]</a>&nbsp;";

					// pageBar += "&nbsp;<a
					// href='"+url+"?currentShowPageNo="+pageNo+"&toDate="+toDate+"&fromDate="+fromDate+"'>";
				}

				InterProdDAO pdao = new ProdDAO();

				String userid = loginuser.getUserid();

				List<String> productnoList = new ArrayList<String>();
				if (listMap != null) {
					for (int i = 0; i < listMap.size(); i++) {
						productnoList.add(listMap.get(i).get("productno"));
					}
				}
				
				System.out.println("productnoList: " + productnoList);

				List<String> cnt = pdao.checkReview(userid, productnoList);
				
				System.out.println("cnt: " + cnt);

				request.setAttribute("totalCountCart", totalCountCart);
				request.setAttribute("fromDate", fromDate);
				request.setAttribute("toDate", toDate);
				request.setAttribute("pageBar", pageBar);
				request.setAttribute("listMap", listMap);
				request.setAttribute("cnt", cnt);

				super.setViewPage("/WEB-INF/member/membermyorder.jsp");

			}

		} else {
			String message = "먼저 로그인을 하세요!!";
			String loc = "javascript:history.back()";

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
	}
}

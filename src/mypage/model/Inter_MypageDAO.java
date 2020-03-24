package mypage.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import member.model.MemberVO;

public interface Inter_MypageDAO {
	
	// 회원정보 변경
	int changeOneMember(MemberVO mvo)  throws SQLException;
	
	// 회원 삭제
	int withdrawalOneMember(HashMap<String, String> paraMap) throws SQLException;

	// 회원 구매내역 날짜로 검색
	List<HashMap<String, String>> oneMemberOrderList(String fromDate, String toDate, int userno, int currentShowPageNo, int sizePerPage) throws SQLException;
	

	// 회원 위시리스트 보여주기
	public List<HashMap<String, String>> showWishList(HashMap<String, String> paraMap) throws SQLException;

	
	// 회원 위시리스트 선택삭제하기 
	int deletWishProduct(String userno, String[] productArr) throws SQLException;
	
	// 회원 위시상품 카트로 이동시키기
	int wishToCart(String userid, String product) throws SQLException;
	
	// 회원 위시리스트 한명 선택삭제하기 
 	int deletOneWishProduct(String userid, String product) throws SQLException;
 	
 	// 회원 한명 상품 갯수 조회하기
 	int wishTotalCount(int userno) throws SQLException;

 	// 주문내역 전체 갯수 조회하기
	int getTotalCountOrder(String fromDate, String toDate, int userno) throws SQLException;

}

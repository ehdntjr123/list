package prod.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.Cookie;

public interface InterProdDAO {
	
	// 카테고리 목록 \\
	List<HashMap<String, String>> getCategoryList() throws SQLException;
	
	// 상품 상세 \\
	ProdVO showProdInfo(String productno_) throws SQLException;
	
	// 상품 상세 이미지 \\
	List<ProdImgVO> showProdInfoImg(String productno_) throws SQLException;
	
	// 상품 리뷰 \\
	List<ReviewVO> showReview(String productno_) throws SQLException;
	
	// 장바구니 개수 가져오기 \\
	int cartCount(String userid, String user_ip) throws SQLException;
	
	// 장바구니 중복체크 \\
	boolean checkDuplication(String userid, String productno_) throws SQLException;
	
	// 장바구니 넣기 \\ 
	int inputCart(String productno_, String userid, String user_ip) throws SQLException;
	
	// 장바구니 수량 증가 \\
	int plusOrderCount(String productno_, String userid) throws SQLException;
	
	// 장바구니 목록의 제품 번호 \\
	List<String> getCartList(String userid, String user_ip) throws SQLException;
	
	// 장바구니 목록 \\
	List<ProdVO> showCartList(List<String> cartProdNo, String userid, String user_ip) throws SQLException;

	// 장바구니 합계 \\
	int getCartSum(List<String> cartProdNo, String userid, String user_ip) throws SQLException;

	// 장바구니 삭제 \\
	int deleteCart(String productno, String userid, String user_ip) throws SQLException;

	// 장바구니 수량 감소 \\
	int MinusOrderCount(String productno_, String userid) throws SQLException;

	// 상품 갯수 가져오기 \\
	int getTotalCount(HashMap<String, String> paraMap) throws SQLException;

	// 상품 목록 가져오기 \\
	List<ProdVO> getProdList(HashMap<String, String> paraMap) throws SQLException;
	
	//메인에서 남자 여자 가격순으로 4개 보여주기
	List<ProdVO> showMainView() throws SQLException;
	
	// 유저 번호 채번 \\
	String getUserno(String userid) throws SQLException;
	
	// 위시 리스트 \\
	boolean checkWishDuplication(String userno, String productno_) throws SQLException;
	
	// 상품 번호 채번 \\
	String getProdNo(String productname) throws SQLException;
	
	// 리뷰 작성하려는 상품 정보 \\
	ProdVO showOrderProduct(String productname) throws SQLException;
	
	// 리뷰 작성 \\
	int writeReview(HashMap<String,String> map) throws SQLException;

	// 리뷰 중복 확인 \\
	List<String> checkReview(String userid, List<String> productnoList) throws SQLException;

	// 리뷰 수정 \\
	int editReview(HashMap<String, String> map) throws SQLException;

	// 리뷰 삭제 \\
	int deleteReview(HashMap<String, String> map) throws SQLException;
	
	// 리뷰 수정, 삭제용 조회 \\
	ReviewVO showReviewOne(String productno, String userid) throws SQLException;

}

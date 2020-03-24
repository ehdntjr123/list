package admin.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import member.model.MemberVO;
import prod.model.ProdVO;

public interface InterAdminDAO {

	// 회원 목록 조회 \\
	List<MemberVO> selectPagingMember(HashMap<String, String> paraMap) throws SQLException;

	// 회원 목록 페이징 바 \\
	int getTotalPage(HashMap<String, String> paraMap) throws SQLException;
	
	// 회원 상세 \\
	MemberVO showOneMember(String userno) throws SQLException;
	
	// 상품 등록 상품 번호 채번 \\
	int getProductnoOfProduct() throws SQLException;
	
	// 상품 등록 \\
	int productInsert(ProdVO pvo) throws SQLException;
	
	// 상품 상세 이미지 등록 \\
	int product_imagefile_Insert(int productno, String attachFileName) throws SQLException;
	
	// 상품 목록 \\
	List<ProdVO> listAllProd(HashMap<String, String> paraMap) throws SQLException;
	
	// 상품 목록 갯수 \\
	int getTotalProdPage(HashMap<String, String> paraMap) throws SQLException;
	
	// 선택 상품 삭제 \\
	int deleteOneProd(String productno) throws SQLException;
	
	// 선택 상품 이미지 삭제 \\
	int deleteOneProdImg(String productno) throws SQLException;
	
	// 선택 상품 입고 \\
	int addOneProd(String productno, String count) throws SQLException;
	
	// Q&A 목록 총 출력 
	List<InquiryVO> listAllQna(HashMap<String, String> paraMap) throws SQLException;

	// 총 페이지 갯수 
	int getTotalInquiryPage(String sizePerPage) throws SQLException;
	
	// 문의내역 상세정보 보기 
	InquiryVO listOneQna(HashMap<String, String> paraMap) throws SQLException;

}

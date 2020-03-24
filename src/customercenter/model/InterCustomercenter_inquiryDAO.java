package customercenter.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface InterCustomercenter_inquiryDAO {

	
	// Q&A 목록 총 출력 
	List<Customercenter_InquiryVO> listAllQna(HashMap<String, String> paraMap) throws SQLException;

	// 총 페이지 갯수 
	int getTotalPage(String sizePerPage) throws SQLException;

	
	// Q&A 개인 문의 내역 
	List<Customercenter_InquiryVO> listUserQna(HashMap<String, String> paraMap) throws SQLException;

	// 문의내역 상세정보 보기 
	Customercenter_InquiryVO listOneQna(HashMap<String, String> paraMap) throws SQLException;

	// 문의하기 
	int insertinquiry(HashMap<String, String> map) throws SQLException;


	// 문의내역 답변해주기 
	int answerInquir(HashMap<String, String> map) throws SQLException;
	

	
}

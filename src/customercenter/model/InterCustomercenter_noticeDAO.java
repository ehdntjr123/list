package customercenter.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface InterCustomercenter_noticeDAO {

	// 페이징처리를 한 회원목록 조회하기(select)
	List<Customercenter_noticeVO> noticeSelect(HashMap<String, String> paraMap) throws SQLException;
	
	// 총 페이갯수 
	int getTotalPage(String sizePerPage) throws SQLException;

	// 관리자가 공지사항 insert 하기 
	int insernotice(HashMap<String, String> map)throws SQLException;

	// 공지사항 자세하게 보기
	Customercenter_noticeVO selectOneNoticeList(String idx) throws SQLException;

	// 공지사항 삭제하기 
	int deletenotice(String index) throws SQLException;

	// 공지사항 수정하기 
	int updatenotice(String noticeno, String noticetile, String noticecontent) throws SQLException;
	
}

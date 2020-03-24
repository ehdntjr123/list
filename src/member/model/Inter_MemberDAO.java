package member.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface Inter_MemberDAO {

	
	// 로그인 처리 메소드 
	MemberVO getOneMember(HashMap<String, String> paraMap)throws SQLException;

	
	// 회원가입 메소드 
	int registerMember(HashMap<String, String> map)throws SQLException;

	//아이디 존재하는지 조회하는 메소드
	boolean isUseridExist(String userid) throws SQLException;

	//페이지 수를 구하는 메소드
	int getTotalPage(HashMap<String,String> paraMap) throws SQLException;
	
	//페이징 처리 한 회원목록 조회하기
	List<MemberVO> selectMemberList(HashMap<String,String> paraMap) throws SQLException;
	
	
}

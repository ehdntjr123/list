package customercenter.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class Customercenter_inquiryDAO implements InterCustomercenter_inquiryDAO {





	private DataSource ds;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;


	public Customercenter_inquiryDAO() {

		try {
			Context initContext = new InitialContext();
			// Context envContext  = (Context)initContext.lookup("java:/comp/env");
			// ds = (DataSource)envContext.lookup("jdbc/semi");
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semi");

		} catch (NamingException e) {
			e.printStackTrace();
		}
	}


	public void close() {
		try {
			if(rs != null) { rs.close(); rs=null; }
			if(pstmt != null) { pstmt.close(); pstmt=null; } 
			if(conn != null) { conn.close(); conn=null; }
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}



	// 총 페이지 갯수 
	@Override
	public int getTotalPage(String sizePerPage) throws SQLException {
		int totalPage = 0;

		try {

			conn = ds.getConnection();

			String sql = "select ceil(count(*)/?) as totalPage from tbl_semi_inquiry "; 

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sizePerPage);

			rs = pstmt.executeQuery();

			rs.next();

			totalPage = rs.getInt("totalPage");

		} finally {
			close();
		}

		return totalPage;
	}





	// 믄의내역 전부 조회하기 (페이징 처리) 	
	@Override
	public List<Customercenter_InquiryVO> listAllQna(HashMap<String, String> paraMap) throws SQLException {

		List<Customercenter_InquiryVO> result = null; 


		try {
			conn = ds.getConnection();

			String sql = "\n"+
					"select RNO, inquiryno, fk_userid, inquirytitle, inquirycontent,  to_char(inquiryday, 'yyyy-mm-dd') as writeday,  inquirycoment, rep\n"+
					"from \n"+
					"(\n"+
					"    select rownum AS RNO, inquiryno, fk_userid, inquirytitle, inquirycontent,  inquiryday,  inquirycoment, rep\n"+
					"    from \n"+
					"    (\n"+
					"        select inquiryno, fk_userid, inquirytitle, inquirycontent,  inquiryday,  inquirycoment, rep, sysdate-inquiryday as repdate\n"+
					"        from tbl_semi_inquiry\n"+
					"        where rep = ? \n"+
					"        order by rep desc, repdate desc\n"+
					"    ) V\n"+
					") T\n"+
					"where T.RNO between ? and ?";

			pstmt = conn.prepareStatement(sql);


			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));


			//처리 미처리 구분하기 위해서
			pstmt.setString(1, paraMap.get("rep")); // 공식
			pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage-1)); // 공식
			pstmt.setInt(3, (currentShowPageNo * sizePerPage)); // 공식


			rs = pstmt.executeQuery();


			int cnt = 0;

			while(rs.next()) {
				cnt++;

				if(cnt==1) {
					result = new ArrayList<Customercenter_InquiryVO>();
				}

				Customercenter_InquiryVO member = new Customercenter_InquiryVO();

				String inquirycontent = ""; 

				if( ("").equals( rs.getString("inquirycoment").trim()) ) {
					inquirycontent = "답변이 없습니다."; 
				}

				else {
					inquirycontent = rs.getString("inquirycoment"); 
				}


				member.setInquiryno(rs.getInt("inquiryno"));
				member.setInquirytitle(rs.getString("inquirytitle"));
				member.setInquirycontent(rs.getString("inquirycontent"));
				member.setInquirycoment(inquirycontent);
				member.setFk_userid(rs.getString("fk_userid"));
				member.setRep(rs.getInt("rep"));
				member.setInquiryday(rs.getString("writeday"));

				if( rs.getInt("rep") == 1) {
					member.setRepstatus("미처리");
				}

				else {
					member.setRepstatus("처리");
				}

				result.add(member);

			}// end of while----------------------------

		} finally {
			close();
		} 

		return result; 




	}






	// 회원 개인의 문의 내역 
	@Override
	public List<Customercenter_InquiryVO> listUserQna(HashMap<String, String> paraMap) throws SQLException {


		List<Customercenter_InquiryVO> result = null; 


		try {
			conn = ds.getConnection();

			String sql = "select RNO, inquiryno, fk_userid, inquirytitle, inquirycontent,  to_char(inquiryday, 'yyyy-mm-dd') as writeday,  inquirycoment, rep\n"+
					"from \n"+
					"(\n"+
					"    select rownum AS RNO, inquiryno, fk_userid, inquirytitle, inquirycontent,  inquiryday,  inquirycoment, rep\n"+
					"    from \n"+
					"    (\n"+
					"        select inquiryno, fk_userid, inquirytitle, inquirycontent,  inquiryday,  inquirycoment, rep, sysdate-inquiryday as repdate\n"+
					"        from tbl_semi_inquiry\n"+
					"        where fk_userid = ? \n"+
					"        order by rep desc, repdate desc\n"+
					"    ) V\n"+
					") T\n"+
					"where T.RNO between ? and ?";

			pstmt = conn.prepareStatement(sql);


			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));


			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage-1)); // 공식
			pstmt.setInt(3, (currentShowPageNo * sizePerPage)); // 공식


			rs = pstmt.executeQuery();


			int cnt = 0;

			while(rs.next()) {
				cnt++;

				if(cnt==1) {
					result = new ArrayList<Customercenter_InquiryVO>();
				}

				Customercenter_InquiryVO member = new Customercenter_InquiryVO();


				String inquirycoment = ""; 

				if( ("").equals( rs.getString("inquirycoment").trim()) ) {
					inquirycoment = "답변이 없습니다."; 
				}

				else {
					inquirycoment = rs.getString("inquirycoment"); 
				}


				member.setInquiryno(rs.getInt("inquiryno"));
				member.setInquirytitle(rs.getString("inquirytitle"));
				member.setInquirycontent(rs.getString("inquirycontent"));
				member.setInquirycoment(inquirycoment);
				member.setFk_userid(rs.getString("fk_userid"));
				member.setRep(rs.getInt("rep"));
				member.setInquiryday(rs.getString("writeday"));


				if( rs.getInt("rep") == 1) {
					member.setRepstatus("미처리");
				}

				else {
					member.setRepstatus("처리");
				}

				result.add(member);
			}// end of while----------------------------

		} finally {
			close();
		} 

		return result; 


	}











	// // 문의내역 상세정보 보기 
	@Override
	public Customercenter_InquiryVO listOneQna(HashMap<String, String> paraMap)  throws SQLException {

		Customercenter_InquiryVO member = null; 


		try {

			conn = ds.getConnection();


			String sql = ""; 

			// 관리자 
			if( paraMap.get("userid").equalsIgnoreCase("admin") ) {

				sql = "select inquiryno, fk_userid, inquirytitle, inquirycontent,  to_char(inquiryday, 'yyyy-mm-dd') as writeday,  inquirycoment, rep\r\n" + 
						"from tbl_semi_inquiry\r\n" + 
						"where inquiryno = ?  ";


				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, paraMap.get("idx"));


			}


			// 관리자가 아닌경우 
			else {

				sql = "select inquiryno, fk_userid, inquirytitle, inquirycontent,  to_char(inquiryday, 'yyyy-mm-dd') as writeday,  inquirycoment, rep\r\n" + 
						"from tbl_semi_inquiry\r\n" + 
						"where inquiryno = ? and fk_userid = ?  ";

				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, paraMap.get("idx"));
				pstmt.setString(2, paraMap.get("userid"));

			}

			rs = pstmt.executeQuery();



			if(rs.next()) {

				member = new Customercenter_InquiryVO(); 

				String inquirycontent = ""; 

				if( ("").equals( rs.getString("inquirycoment").trim()) ) {
					inquirycontent = "답변이 없습니다."; 
				}

				else {
					inquirycontent = rs.getString("inquirycoment"); 
				}


				member.setInquiryno(rs.getInt("inquiryno"));
				member.setInquirytitle(rs.getString("inquirytitle"));
				member.setInquirycontent(rs.getString("inquirycontent"));
				member.setInquirycoment(inquirycontent);
				member.setFk_userid(rs.getString("fk_userid"));
				member.setRep(rs.getInt("rep"));
				member.setInquiryday(rs.getString("writeday"));


				if( rs.getInt("rep") == 1) {
					member.setRepstatus("미처리");
				}

				else {
					member.setRepstatus("처리");
				}

			}// end of while----------------------------

		} finally {
			close();
		} 

		return member; 

	}


	// 문의사항 올리기 
	@Override
	public int insertinquiry(HashMap<String, String> map) throws SQLException {

		int result = 0;

		try {

			conn = ds.getConnection();

			String sql = "insert into tbl_semi_inquiry(inquiryno, fk_userid, inquirytitle, inquirycontent,  inquiryday,  inquirycoment, rep)\n"+
					"values(seq_semi_inquiry.nextval, ?, ?, ?, sysdate, ' ', default)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, map.get("userid"));	
			pstmt.setString(2, map.get("inquirytitle"));	
			pstmt.setString(3, map.get("inquirycontent"));	

			result = pstmt.executeUpdate();

		} finally {
			close();
		}	

		return result;
	}




	// 문의사항 답변해주기 
	@Override
	public int answerInquir(HashMap<String, String> map) throws SQLException {

		int result = 0;

		try {

			conn = ds.getConnection();

			String sql = "update tbl_semi_inquiry set rep = 0 , inquirycoment = ? where  inquiryno = ? "; 

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, map.get("inquirycoment"));	
			pstmt.setString(2, map.get("inquiryno"));	

			result = pstmt.executeUpdate();

		} finally {
			close();
		}	

		return result;
	}

}

package customercenter.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class Customercenter_noticeDAO implements InterCustomercenter_noticeDAO {

	private DataSource ds;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;


	public Customercenter_noticeDAO() {

		try {
			Context initContext = new InitialContext();
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

	// 페이징처리를 한 공지사항 전부 조회하기(select)
	@Override
	public List<Customercenter_noticeVO> noticeSelect(HashMap<String, String> paraMap) throws SQLException {

		List<Customercenter_noticeVO> result = null; 


		try {
			conn = ds.getConnection();

			String sql = "\n"+
					"select RNO, noticeno, noticetile, noticewriteday, noticecontent\n"+
					"from \n"+
					"(\n"+
					"    select rownum AS RNO, noticeno, noticetile, noticewriteday, noticecontent\n"+
					"    from \n"+
					"    (\n"+
					"        select noticeno, noticetile, noticewriteday, noticecontent\n"+
					"        from tbl_semi_notice\n"+
					"        order by noticeno desc\n"+
					"    ) V\n"+
					") T\n"+
					"where T.RNO between ? and ?";

			pstmt = conn.prepareStatement(sql);


			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));



			pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage-1)); // 공식
			pstmt.setInt(2, (currentShowPageNo * sizePerPage)); // 공식


			rs = pstmt.executeQuery();


			int cnt = 0;

			while(rs.next()) {
				cnt++;

				if(cnt==1) {
					result = new ArrayList<Customercenter_noticeVO>();
				}

				Customercenter_noticeVO member = new Customercenter_noticeVO();
				member.setnoticeno(Integer.parseInt(rs.getString("noticeno")));
				member.setnoticetile(rs.getString("noticetile"));
				member.setnoticewriteday(rs.getString("noticewriteday"));
				member.setnoticecontent(rs.getString("noticecontent"));
				result.add(member);

			}// end of while----------------------------

		} finally {
			close();
		} 

		return result; 
	}

	
	// 총 페이갯수 
	@Override
	public int getTotalPage(String sizePerPage) throws SQLException {
		int totalPage = 0;

		try {

			conn = ds.getConnection();

			String sql = "select ceil(count(*)/?) as totalPage from tbl_semi_notice "; 

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

	// 공지사항 insert
	@Override
	public int insernotice(HashMap<String, String> map) throws SQLException {
		
		int result = 0;

		try {
			conn = ds.getConnection();

			String sql ="insert into tbl_semi_notice(noticeno, noticetile, noticewriteday, noticecontent) VALUES(seq_semi_notice.nextval, ?, sysdate, ?)"; 

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, map.get("noticetile"));	
			pstmt.setString(2, map.get("noticecontent"));	

			result = pstmt.executeUpdate();

		} finally {
			close();
		}	

		return result;
		
	}
	
	// 공지사항 상세내역 
	@Override
	public Customercenter_noticeVO selectOneNoticeList(String idx) throws SQLException {
		
		Customercenter_noticeVO list = null;  
		
		try {
			conn = ds.getConnection();

			String sql = "select noticeno, noticetile, noticewriteday, noticecontent from tbl_semi_notice where noticeno = ?"; 

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, idx);
			

			rs = pstmt.executeQuery();

			
			if(rs.next()) {
				list = new Customercenter_noticeVO(); 
				
				list.setnoticeno(rs.getInt("noticeno"));
				list.setnoticetile(rs.getString("noticetile"));
				list.setnoticewriteday(rs.getString("noticewriteday"));
				list.setnoticecontent(rs.getString("noticecontent"));
				
			}// end of while(rs.next())----------------------------------

		} finally {
			close();
		}	
		
		return list; 
	}

	// 공지사항 삭제 
	@Override
	public int deletenotice(String index) throws SQLException {
		int result = 0;

		try {
			conn = ds.getConnection();

			String sql =" delete from tbl_semi_notice where noticeno = ? "; 

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, index);	

			result = pstmt.executeUpdate();

		} finally {
			close();
		}	

		return result;
	}

	// 공지사항 수정하기 
	@Override
	public int updatenotice(String noticeno, String noticetile, String noticecontent) throws SQLException {
		int result = 0;

		try {
			conn = ds.getConnection();

			String sql =" update tbl_semi_notice set noticetile = ?, noticecontent = ?\r\n" + 
					" where noticeno = ?";  

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, noticetile);	
			pstmt.setString(2, noticecontent);	
			pstmt.setString(3, noticeno);	

			result = pstmt.executeUpdate();

		} finally {
			close();
		}	

		return result;
	}

}

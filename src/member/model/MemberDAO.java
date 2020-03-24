package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
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

import util.security.AES256;
import util.security.Sha256;

public class MemberDAO implements Inter_MemberDAO {

	private DataSource ds;
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private AES256 aes = null;

	// 생성자 
	public MemberDAO() {
		// 암호화/복호화 키 (양방향암호화) ==> 이메일,휴대폰의 암호화/복호화
		String key = EncryptMyKey.KEY;

		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semi");
			aes = new AES256(key);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}	
	}

	// 사용한 자원을 반납하는 close() 메소드 생성하기
	public void close() {
		try {
			if(rs != null) { rs.close(); rs=null; }
			if(pstmt != null) { pstmt.close(); pstmt=null; } 
			if(conn != null) { conn.close(); conn=null; }
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 로그인 메소드 
	@Override
	public MemberVO getOneMember(HashMap<String, String> paraMap) throws SQLException {

		MemberVO loginuser = null;

		try {
			conn = ds.getConnection();

			String sql = " select userno,  userid,  userpw,  username,  email,  phone,  postno,  addr1, addr2, status,  registerday,  lastlogindate,  pwchangedate "
					+ ", trunc( months_between(sysdate, pwchangedate) ) AS pwdchangegap "
					+ ", trunc( months_between(sysdate, lastlogindate) ) AS lastlogindategap "
					+ " from tbl_semi_member where status = 1 and userid = ? and userpw = ?"; 

			// pwdchangegap 마지막 패스워드 바뀐 날짜 
			// lastlogindategap 마지막 로그인 날짜 
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, Sha256.encrypt(paraMap.get("userpw")));

			rs = pstmt.executeQuery();

			if(rs.next()) {
				loginuser = new MemberVO(); 

				loginuser.setUserno( Integer.parseInt(rs.getString("userno")) );
				loginuser.setUserid(rs.getString("userid"));
				loginuser.setUsername(rs.getString("username"));
				loginuser.setEmail(aes.decrypt(rs.getString("email")));
				loginuser.setPhone(aes.decrypt(rs.getString("phone")));
				loginuser.setPostno(rs.getString("postno"));
				loginuser.setAddr1(rs.getString("addr1"));
				loginuser.setAddr2(rs.getString("addr2"));
				loginuser.setStatus( Integer.parseInt(rs.getString("status")) );
				loginuser.setRegisterday(rs.getString("registerday"));
				loginuser.setLastlogindate(rs.getString("lastlogindate"));
				loginuser.setPwchangedate(rs.getString("pwchangedate"));
				
				
				// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 6개월이 지났으면 true,
				if( rs.getInt("pwdchangegap") >= 6 )
                	loginuser.setRequirePwdChange(true);

			    // 마지막으로 로그인 한 날짜가 현재일로부터 1년이 지났으면 true; 
                if( rs.getInt("lastlogindategap") >= 12 ) {
                	loginuser.setIdleStatus(true);
                }
                
                else {
                	// 마지막으로 로그인 한 날짜시간 기록하기
                	sql = " update tbl_semi_member set lastlogindate = sysdate "
                		+ " where userid = ? ";
                	pstmt = conn.prepareStatement(sql);
                	pstmt.setString(1, paraMap.get("userid")); 
                	pstmt.executeUpdate();
                }	
				
			}

		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		} 

		return loginuser;
	}

	// 회원가입 메소드 
	public int registerMember(HashMap<String, String> map)throws SQLException {

		int result = 0;

		try {
			conn = ds.getConnection();

			String sql = "\n"+
					"insert into tbl_semi_member(userno,  userid,  userpw,  username,  email,  phone,  postno,  addr1, addr2, status,  registerday,  lastlogindate,  pwchangedate)\n"+
					" values(seq_semi_member.nextval, ?, ?, ?, ?, ?, ?, ?, ?, default, default, default,default) ";

			pstmt = conn.prepareStatement(sql);

			String postno = map.get("postno1") + map.get("postno2"); 
			
			pstmt.setString(1, map.get("userid"));
			pstmt.setString(2, Sha256.encrypt(map.get("userpw")));   // 단방향 암호화 
			pstmt.setString(3, map.get("username"));
			pstmt.setString(4, aes.encrypt(map.get("email"))); // 양방향 암호화
			pstmt.setString(5, aes.encrypt(map.get("phone"))); // 양방향 암호화 
			pstmt.setString(6, postno);
			pstmt.setString(7, map.get("addr1"));
			pstmt.setString(8, map.get("addr2"));
			
			result = pstmt.executeUpdate();

		} catch( UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return result;		
	}
	
	// userid 중복 검사 
	public boolean isUseridExist(String userid)	throws SQLException {
			
		boolean result = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select * "
					   + " from tbl_semi_member "
					   + " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			result = rs.next();
						
		} finally {
			close();
		}
		
		return result;	
	}
	
	@Override
	public List<MemberVO> selectMemberList(HashMap<String, String> paraMap) throws SQLException {
		List<MemberVO> mbrList = null;
		String colname = "";
		try {
			 conn = ds.getConnection();
			 
			 String sql = "select RNO, userno, userid, username, email \n"+
		                  "from \n"+
		                  "(\n"+
		                  "    select rownum AS RNO, userno, userid, username, email \n"+
		                  "    from \n"+
		                  "    (\n"+
		                  "        select userno, userid, username, email \n"+
		                  "        from tbl_semi_member\n"+
		                  "        where status = 1 \n";
			 
			 String searchWord = paraMap.get("searchWord");
			 
			 //table name 과 컬럼 이름에 ? 를 사용하면 에러가 발생한다.
			 if(searchWord != null && !searchWord.trim().isEmpty()) {
				 
				 
				 String searchType = paraMap.get("searchType");
				 
				 switch (searchType) {
					 case "username":
						 colname = "username";
						 break;
					 case "userid":
						 colname = "userid";
						 break;
					 case "email":
						 colname = "email";
						 break;
					 default :
						 break;
				 }
				 
				 sql += "and "+colname+" like '%' || ? || '%' ";

			 }
			 sql +=   "        order by userno desc\n"+
		               "    ) V\n"+
		               ") T\n"+
		               "where T.RNO between ? and ?";
			 
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			if(searchWord != null && !searchWord.trim().isEmpty()) {
				if("email".equals(colname)) {
					pstmt.setString(1, aes.encrypt(searchWord));
				}
				else {
					pstmt.setString(1, searchWord);
				}
				pstmt.setInt(2, ((currentShowPageNo * sizePerPage) - (sizePerPage -1)));
				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			} else {
				pstmt.setInt(1, ((currentShowPageNo * sizePerPage) - (sizePerPage -1)));
				pstmt.setInt(2, (currentShowPageNo * sizePerPage));
			}
			 
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			
			while(rs.next()) {
				
				cnt++;
				if(cnt == 1) {
					mbrList = new ArrayList<MemberVO>();
				}
				
				MemberVO mbr = new MemberVO();
				
				
				mbr.setUserid(rs.getString("userid"));
				
				mbr.setEmail(aes.decrypt(rs.getString("email")));
				
				
				mbrList.add(mbr);
			}
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return mbrList;
	}

	@Override
	public int getTotalPage(HashMap<String,String> paraMap) throws SQLException {

	  int count = 0;
	  String colname = "";
	  try {
		conn = ds.getConnection();
			 
		String sql = " select ceil(count(*)/?) as cnt "
			 		 + " from tbl_semi_member "
			 		 + " where status = 1 ";
		  
		String searchWord = paraMap.get("searchWord");
			 
		//table name 과 컬럼 이름에 ? 를 사용하면 에러가 발생한다.
		if(searchWord != null && !searchWord.trim().isEmpty()) {
				 
		  String searchType = paraMap.get("searchType");
				 
		  switch (searchType) {
			case "username":
			  colname = "username";
			  break;
			case "userid":
			  colname = "userid";
			  break;
			case "email":
			  colname = "email";
			  break;
			default :
			  break;
		  }
				 
		  sql += "and "+colname+" like '%' || ? || '%' ";
		}
		
		pstmt = conn.prepareStatement(sql);
		
		if(searchWord != null && !searchWord.trim().isEmpty()) {
		  pstmt.setString(1, paraMap.get("sizePerPage"));
			
		  if("email".equals(colname)) {
			pstmt.setString(2, aes.encrypt(searchWord));	
		  }
		  else {
			pstmt.setString(2, searchWord);
		  }

		}
		else {
			pstmt.setString(1, paraMap.get("sizePerPage"));
		}

		rs = pstmt.executeQuery();
			
		if(rs.next()) {
		  count = rs.getInt("cnt");
		}
	  } catch( UnsupportedEncodingException | GeneralSecurityException e) {
	    e.printStackTrace();
	  }finally {
	    close();
	  }
		
		return count;
	}

	
	
	

}

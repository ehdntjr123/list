package mypage.model;

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
import javax.sql.*;

import member.model.EncryptMyKey;
import member.model.MemberVO;
import util.security.AES256;
import util.security.Sha256;

public class MypageDAO implements Inter_MypageDAO {

	private DataSource ds;
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private AES256 aes = null;



	// 생성자 
	public MypageDAO() {
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
	
	
	// 회원 한명의 정보 바꾸기
	@Override
	public int changeOneMember(MemberVO mvo) throws SQLException  {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_semi_member set email = ? , phone = ? , postno = ?, addr1 = ?, addr2 = ?  "
					   + " where userid = ? and userpw = ? "; 

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, aes.encrypt(mvo.getEmail()));   
			pstmt.setString(2, aes.encrypt(mvo.getPhone()));
			pstmt.setString(3, mvo.getPostno());
			pstmt.setString(4, mvo.getAddr1());
			pstmt.setString(5, mvo.getAddr2());
			pstmt.setString(6, mvo.getUserid());
			pstmt.setString(7, Sha256.encrypt(mvo.getUserpw()));
			
			
			result = pstmt.executeUpdate();
			
			
		}  catch( UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} 
		finally {
			close();
		}	
		
		return result;		
	}

	// 회원 한명 탈퇴하기
	@Override
	public int withdrawalOneMember(HashMap<String, String> paraMap) throws SQLException {

		int result = 0;
		
		try {
			conn = ds.getConnection();
			

			String sql = " update tbl_semi_member set status = 0 "+
						  " where userno = ? and userpw = ? "; 

			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(paraMap.get("userno")));
			pstmt.setString(2, Sha256.encrypt(paraMap.get("userpw")));
			
			result = pstmt.executeUpdate();
			
			if(result==1) {
			
				result=0;
					
				sql = " insert into tbl_semi_memberwithdrawal(withdrawalno, fk_userno, withdrawalreason,  withdrawalcontent)" 
						+ " values(seq_semi_memberwithdrawal.nextval,? , ? , ? )"; 
	
	
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(paraMap.get("userno")));
				pstmt.setString(2, paraMap.get("reason"));
				pstmt.setString(3, paraMap.get("content"));
	
				
				
				result = pstmt.executeUpdate();
			
			}
			
			System.out.println("result"+result);
			
		} 
		finally {
			close();
		}	
		
		return result;		
		
	}


	// 주문내역보여주기
	@Override
	public List<HashMap<String, String>> oneMemberOrderList(String fromDate, String toDate, int userno, int currentShowPageNo, int sizePerPage) throws SQLException{

		List<HashMap<String, String>> listMap = null;
		
		try {
			conn = ds.getConnection();
			
			
			String sql = "select *\n"+
					"from\n"+
					"(\n"+
					"select productno, pimage, productname\n"+
					"        , to_char(price, '999,999') as price\n"+
					"        , decode(fk_pcategoryno,2,'메탈',4,'메탈','가죽') as pcategory\n"+
					"        , statementday\n"+
					"        , decode(status,0,'출고중',1,'배송중','완료') as shipstatus\n"+
					"        , fk_userno as fk_userno\n"+
					"        , row_number() over (order by statementday desc) AS RNO\n"+
					"from\n"+
					"(\n"+
					"select productno, pimage, productname, price, fk_pcategoryno, to_char(statementday, 'yyyy-mm-dd') as statementday, status, fk_userno\n"+
					"from\n"+
					"(\n"+
					"select *\n"+
					"from(\n"+
					"select *   \n"+
					"from\n"+
					"(\n"+
					"select *\n"+
					"from tbl_semi_orderdetail A join tbl_semi_statement B \n"+
					"on A.fk_statementno = B.statementno\n"+
					")V join tbl_semi_product C\n"+
					"on V.fk_productno = c.productno\n"+
					")T join tbl_semi_orderlist D\n"+
					"on T.orderno = D.fk_orderdetailno\n"+
					")M join tbl_semi_shipping E\n"+
					"on M.fk_shippingno = E.shippingno   --\n"+
					") O\n"+
					"where fk_userno= ? and statementday between ? and ? \n"+
					") P\n"+
					"where RNO between ? and ? ";
			

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userno);
			pstmt.setString(2, fromDate);
			pstmt.setString(3, toDate);
			pstmt.setInt(4, (currentShowPageNo*sizePerPage)-(sizePerPage-1) ); // 공식
			pstmt.setInt(5, currentShowPageNo*sizePerPage );			
			

			rs = pstmt.executeQuery();
			
			
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt==1) {
					listMap = new ArrayList<HashMap<String, String>>();
				}
				
				System.out.println("while문");

				HashMap<String, String> map = new HashMap<String, String>();
				map.put("productno", rs.getString("productno"));
				map.put("pimage", rs.getString("pimage"));
				map.put("productname", rs.getString("productname"));
				map.put("price", rs.getString("price"));
				map.put("pcategory", rs.getString("pcategory"));
				map.put("statementday", rs.getString("statementday"));				
				map.put("shipstatus", rs.getString("shipstatus"));
				
				listMap.add(map);
				
			}// end of while----------------------------
			
		}finally {
			close();
		}
		
		return listMap;
	}
	
	// 위시리스트 보여주기
	@Override
	public List<HashMap<String, String>> showWishList(HashMap<String, String> paraMap) throws SQLException {
		
		List<HashMap<String, String>> listMap = null;
		
		try {
			conn = ds.getConnection();
			String sql = "select *\n"+
					
					"from\n"+
					"(\n"+
					"select  row_number() over(order by pinputdate asc) as RNO\n"+
					"        , productname\n"+
					"        ,  to_char(price, '999,999') as price\n"+
					"        , decode(fk_pcategoryno,2,'메탈',4,'메탈','가죽') as pcategory \n"+
					"        , pinputdate\n"+
					"        , fk_productno\n"+
					"        , fk_userno\n"+
					"        , pimage\r\n" + 
					"from tbl_semi_wishlist A join tbl_semi_product B\n"+
					"on A.fk_productno=productno\n"+
					"where fk_userno= ?\n"+
					")V\n"+
					"where rno between ? and ? ";
			

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userno"));
			pstmt.setString(2, paraMap.get("startRno"));
			pstmt.setString(3, paraMap.get("endRno"));

			rs = pstmt.executeQuery();
			
			
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt==1) {
					listMap = new ArrayList<HashMap<String, String>>();
				}
				
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("productname", rs.getString("productname"));
				map.put("price", rs.getString("price"));
				map.put("pcategory", rs.getString("pcategory"));
				map.put("pimage", rs.getString("pimage"));				
				map.put("productno", rs.getString("fk_productno"));				
				
				listMap.add(map);
				
			}// end of while----------------------------
			
			
		}finally {
			close();
		}
		
		return listMap;
	}


	//위시리스트 삭제하기
	  @Override public int deletWishProduct(String userno, String[] productArr)
	  throws SQLException {
	  
			int cnt = 0;
			
			try {
				conn = ds.getConnection();
				
				for(int i=0; i<productArr.length; i++) {
					
					String sql = " delete from tbl_semi_wishlist " + 
								 " where fk_userno = ? and fk_productno = ? "; 	
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, userno);   
					pstmt.setString(2, productArr[i]);  

					int n = pstmt.executeUpdate();
					cnt += n;
				}
			}  
			finally {
				close();
			}	
			
			return cnt;	
	  }

	// 회원 위시상품 카트로 이동시키기
	@Override
	public int wishToCart(String userid, String product) throws SQLException {
		
		int state = 0;
		
		try {
			
			conn = ds.getConnection();
			
				String sql = " select * " + 
							 " from tbl_semi_cart " + 
							 " where fk_userid = ? and fk_productno = ? "; 	
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);   
				pstmt.setString(2, product);  

				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					
						state = 0;	
						
				}
				
				else {

					sql = " insert into tbl_semi_cart(cartno, cartordercount, fk_productno, fk_userid ) " + 
							" values(seq_semi_cart.nextval, 1, ?, ?) " ; 
				 
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, product);
					pstmt.setString(2, userid);
		
					
					state = pstmt.executeUpdate();

				}
		}  
		finally {
			close();
		}	
		
		return state;	
	}

	//위시리스트 상품 하나 삭제하기
	@Override
	public int deletOneWishProduct(String userno, String product) throws SQLException {
		
		int result = 0;
		
		try {
			
			conn = ds.getConnection();

			String sql = " delete from tbl_semi_wishlist " + 
						 " where fk_userno = ? and fk_productno = ? "; 	
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userno);   
			pstmt.setString(2, product);  

			result = pstmt.executeUpdate();
		}  
		finally {
			close();
		}	
		return result;			
	}
	
	// 회원 한명 상품 갯수 조회하기
	@Override
	public int wishTotalCount(int userno) throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select count(*) as count " + 
					" from tbl_semi_wishlist " + 
					" where fk_userno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userno);

			rs = pstmt.executeQuery();

			if(rs.next()) {
				n = rs.getInt("count");
			}
		}finally {
			close();
		}
		return n;
	}


	@Override
	public int getTotalCountOrder(String fromDate, String toDate, int userno) throws SQLException {
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select count(*) as count "+
					"from\n"+
					"(\n"+
					"select *\n"+
					"from\n"+
					"(\n"+
					"select *\n"+
					"from(\n"+
					"select *   \n"+
					"from\n"+
					"(\n"+
					"select *\n"+
					"from tbl_semi_orderdetail A join tbl_semi_statement B \n"+
					"on A.fk_statementno = B.statementno\n"+
					")V join tbl_semi_product C\n"+
					"on V.fk_productno = c.productno\n"+
					")T join tbl_semi_orderlist D\n"+
					"on T.orderno = D.fk_orderdetailno\n"+
					")M join tbl_semi_shipping E\n"+
					"on M.fk_shippingno = E.shippingno\n"+
					") O\n"+
					"where to_char(statementday, 'yyyy-mm-dd') between ? and ? and fk_userno=? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fromDate);
			pstmt.setString(2, toDate);
			pstmt.setInt(3, userno);

			rs = pstmt.executeQuery();

			if(rs.next()) {
				n = rs.getInt("count");
			}
		}finally {
			close();
		}
		return n;
		
	}
}

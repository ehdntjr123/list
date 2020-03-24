package admin.model;

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

import member.model.EncryptMyKey;
import member.model.MemberVO;
import prod.model.ProdVO;
import util.security.AES256;
import util.security.Sha256;

public class AdminDAO implements InterAdminDAO {

	private DataSource ds;
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private AES256 aes = null;



	// 생성자 
	public AdminDAO() {
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

	// 회원 목록 조회 \\
	@Override
	public List<MemberVO> selectPagingMember(HashMap<String, String> paraMap) throws SQLException {
		List<MemberVO> memberList = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select rno, userno, userid, username\n"+
					"from\n"+
					"(\n"+
					"select rownum as rno, userno, userid, username\n"+
					"from\n"+
					"(\n"+
					"select userno, userid, username\n"+
					"from tbl_semi_member\n"+
					"where status = 1 \n";
      
      String searchWord = paraMap.get("searchWord");
      
      String colname = "";
      
      if(searchWord != null && !searchWord.trim().isEmpty()) {
         
         String searchType = paraMap.get("searchType");
         
         switch (searchType) {
            case "username":
               colname = "username";
               break;
            case "userid":
               colname = "userid";
               break;
            default :
               break;
         }
         
         sql += "and "+colname+" like '%' || ? || '%' \n";

      }
      sql +=   "order by userno desc\n"+
				")V\n"+
				")T\n"+
				"where T.rno between ? and ?";
      
     pstmt = conn.prepareStatement(sql);
     
     int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
     int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
     
     if(searchWord != null && !searchWord.trim().isEmpty()) {
    	 
         pstmt.setString(1, searchWord);
        pstmt.setInt(2, ((currentShowPageNo * sizePerPage) - (sizePerPage -1)));
        pstmt.setInt(3, (currentShowPageNo * sizePerPage));
     } 
     else {
        pstmt.setInt(1, ((currentShowPageNo * sizePerPage) - (sizePerPage -1)));
        pstmt.setInt(2, (currentShowPageNo * sizePerPage));
     }

			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt==1) {
					memberList = new ArrayList<MemberVO>();
				}
				
				MemberVO member = new MemberVO();
				member.setUserno(rs.getInt("userno"));
				member.setUserid(rs.getString("userid"));
				member.setUsername(rs.getString("username"));
				
				memberList.add(member);
			}
			
		} finally {
			close();
		}
		return memberList;
	}



	// 회원 목록 조회 페이징 바 \\
	@Override
	public int getTotalPage(HashMap<String, String> paraMap) throws SQLException {
		 int totalPage = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select ceil(count(*)/?) AS totalPage \n"
	                  + " from tbl_semi_member \n"
	                  + " where status = 1";
	         
	         String searchWord = paraMap.get("searchWord");
	         String colname =  "";
	         if(searchWord != null && !searchWord.trim().isEmpty() )   {
	            
	            String searchType = paraMap.get("searchType");
	            
	            switch (searchType) {
	            case "username":
	               colname = "username";
	               break;
	               
	            case "userid":
	               colname = "userid";
	               break;

	            default:
	               break;
	            }
	            sql += " and " + colname + " like '%'|| ? || '%' ";
	               
	         }
	         
	         pstmt = conn.prepareStatement(sql);
	         

	         if(searchWord != null && !searchWord.trim().isEmpty() )   {
	            pstmt.setString(1, paraMap.get("sizePerPage"));
	            pstmt.setString(2, searchWord);
	            }
	         else {
	            pstmt.setString(1, paraMap.get("sizePerPage"));
	            
	         }
	         
	         rs = pstmt.executeQuery();
	         
	         rs.next();
	         
	         totalPage = rs.getInt("totalPage");
	                  
	      } finally {
	         close();
	      } 
	      
	      return totalPage;
	}

	// 회원 상세 \\
	@Override
	public MemberVO showOneMember(String userno) throws SQLException {
		MemberVO memberOne = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select userno, userid, username, email, phone, postno, addr1, addr2, to_char(registerday, 'yyyy-mm-dd') as registerday\n"+
					"from tbl_semi_member\n"+
					"where userno = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberOne = new MemberVO();
				
				memberOne.setUserno(rs.getInt("userno"));
				memberOne.setUserid(rs.getString("userid"));
				memberOne.setUsername(rs.getString("username"));
				memberOne.setEmail(aes.decrypt(rs.getString("email")));
				memberOne.setPhone(aes.decrypt(rs.getString("phone")));
				memberOne.setPostno(rs.getString("postno"));
				memberOne.setAddr1(rs.getString("addr1"));
				memberOne.setAddr2(rs.getString("addr2"));
				memberOne.setRegisterday(rs.getString("registerday"));
				
			}
			
		} catch( UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		finally {
			close();
		}
		
		return memberOne;
	}
	
	// 상품 등록 제품 번호 채번 \\
	@Override
	public int getProductnoOfProduct() throws SQLException {
		int productno = 0;
		
		try {
					
					conn = ds.getConnection();
					
					String sql = "select seq_semi_product.nextval AS productno from dual";
					
					pstmt = conn.prepareStatement(sql);
					
					rs = pstmt.executeQuery();
					
					rs.next();
					
					productno = rs.getInt("productno");
					
				} finally {
					close();
				}
				
				return productno;
	}
	
	// 상품 등록 \\
	@Override
	public int productInsert(ProdVO pvo) throws SQLException {
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = "insert into tbl_semi_product(productno, productname, brand, pimage, \n"+
					     "                        price, pstock, fk_pcategoryno, pinputdate) \n"+
					     " values(?,?,?,?,?,?,?,default)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, pvo.getProductno());
			pstmt.setString(2, pvo.getProductname());
			pstmt.setString(3, pvo.getBrand());
			pstmt.setString(4, pvo.getPimage());
			pstmt.setInt(5, pvo.getPrice());
			pstmt.setInt(6, pvo.getPstock());
			pstmt.setInt(7, pvo.getFk_pcategoryno());

				
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	}
	
	// 상품 이미지 등록 \\
	@Override
	public int product_imagefile_Insert(int productno, String attachFileName) throws SQLException {
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = "insert into tbl_semi_productimages(imageno, imagefilename, fk_productmo) \n"+
										" values(seq_semi_productimage.nextval,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			
			pstmt.setString(1, attachFileName);
			pstmt.setInt(2, productno);
				
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	}
	
	// 상품 목록 조회 \\
		@Override
		public List<ProdVO> listAllProd(HashMap<String, String> paraMap) throws SQLException {
			List<ProdVO> prodList = null;
			
			try {
				
				conn = ds.getConnection();
				
				String sql = "select rno, productno, productname, pimage, price, pstock \n"+
						"from\n"+
						"(\n"+
						"select rownum as rno, productno, productname, pimage, price, pstock \n"+
						"from\n"+
						"(\n"+
						"select productno, productname, pimage, price, pstock \n"+
						"from tbl_semi_product \n";
	      
	      String searchWord = paraMap.get("searchWord");
	      
	      String colname = "";
	      
	      if(searchWord != null && !searchWord.trim().isEmpty()) {
	         
	         String searchType = paraMap.get("searchType");
	         
	         switch (searchType) {
	            case "productno":
	               colname = "productno";
	               break;
	            case "productname":
	               colname = "productname";
	               break;
	            default :
	               break;
	         }
	         
	         if("productno".equals(colname)) {
	        	 sql += "where " +colname+ " = ? \n";
	         }
	         else {
	        	 sql += "where " +colname+ " like '%'|| ? ||'%' \n";	 
	         }

	      }
	      sql +=   "order by productno\n"+
					")V\n"+
					")T\n"+
					"where T.rno between ? and ?";
	      
	     pstmt = conn.prepareStatement(sql);
	     
	     int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
	     int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
	     
	     if(searchWord != null && !searchWord.trim().isEmpty()) {
	    	 
	        pstmt.setString(1, searchWord);
	        pstmt.setInt(2, ((currentShowPageNo * sizePerPage) - (sizePerPage -1)));
	        pstmt.setInt(3, (currentShowPageNo * sizePerPage));
	     }
	     else {
	        pstmt.setInt(1, ((currentShowPageNo * sizePerPage) - (sizePerPage -1)));
	        pstmt.setInt(2, (currentShowPageNo * sizePerPage));
	     }

				
				rs = pstmt.executeQuery();
				
				int cnt = 0;
				while(rs.next()) {
					cnt++;
					
					if(cnt==1) {
						prodList = new ArrayList<ProdVO>();
					}
					
					ProdVO pvo = new ProdVO();
					pvo.setProductno(rs.getInt("productno"));
					pvo.setPimage(rs.getString("pimage"));
					pvo.setProductname(rs.getString("productname"));
					pvo.setPrice(rs.getInt("price"));
					pvo.setPstock(rs.getInt("pstock"));
					
					
					prodList.add(pvo);
				} 
			} finally {
				close();
			}
			return prodList;
		}

		// 상품 갯수 \\
		@Override
		public int getTotalProdPage(HashMap<String, String> paraMap) throws SQLException {
			 int totalPage = 0;
		      
		      try {
		         conn = ds.getConnection();
		         
		         String sql = " select ceil(count(*)/?) AS totalPage \n"
		                  + " from tbl_semi_product ";
		         
		         String searchWord = paraMap.get("searchWord");
		         String colname =  "";
		         if(searchWord != null && !searchWord.trim().isEmpty() )   {
		            
		            String searchType = paraMap.get("searchType");
		            
		            switch (searchType) {
		            case "productname":
		               colname = "productname";
		               break;
		               
		            case "productno":
		               colname = "productno";
		               break;

		            default:
		               break;
		            }
		            if("productno".equals(colname)) {
			        	 sql += "where " +colname+ " = ? \n";
			         }
			         else {
			        	 sql += "where " +colname+ " like '%'|| ? ||'%' \n";	 
			         }
		               
		         }
		         
		         pstmt = conn.prepareStatement(sql);
		         

		         if(searchWord != null && !searchWord.trim().isEmpty() )   {
		            pstmt.setString(1, paraMap.get("sizePerPage"));
		            pstmt.setString(2, searchWord);
		            }
		         else {
		            pstmt.setString(1, paraMap.get("sizePerPage"));
		            
		         }
		         
		         rs = pstmt.executeQuery();
		         
		         rs.next();
		         
		         totalPage = rs.getInt("totalPage");
		                  
		      } finally {
		         close();
		      } 
		      
		      return totalPage;
		}

	// 문의 내역 총 페이지 갯수 
		@Override
		public int getTotalInquiryPage(String sizePerPage) throws SQLException {
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
		public List<InquiryVO> listAllQna(HashMap<String, String> paraMap) throws SQLException {

			List<InquiryVO> result = null; 


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
						"        order by rep desc, repdate desc\n"+
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
						result = new ArrayList<InquiryVO>();
					}

					InquiryVO member = new InquiryVO();

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

		// // 문의내역 상세정보 보기 
		@Override
		public InquiryVO listOneQna(HashMap<String, String> paraMap)  throws SQLException {

			InquiryVO member = null; 


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

					member = new InquiryVO(); 

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

		// 선택 상품 삭제 \\
		@Override
		public int deleteOneProd(String productno) throws SQLException {
			int result = 0;
			
			try {
				
				conn = ds.getConnection();
				
				String sql = "delete from tbl_semi_product \n"+
							"where productno = ?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, productno);
				
				result = pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
			return result;
		}
		
		// 선택 상품 이미지 삭제 \\
		@Override
		public int deleteOneProdImg(String productno) throws SQLException {
			int result = 0;
			
			try {
				
				conn = ds.getConnection();
				
				String sql = " delete from tbl_semi_productimages \n "+
							 " where fk_productmo = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, productno);
				
				result = pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
			return result;
		}
		
		// 선택 상품 입고 \\
		@Override
		public int addOneProd(String productno, String count) throws SQLException {
			int result = 0;
			
			try {
				
				conn = ds.getConnection();
				
				String sql = "update tbl_semi_product \n"+
							"set pstock = pstock + ? \n"+
							"where productno = ?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, count);
				pstmt.setString(2, productno);
				
				result = pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
			return result;
			
		}




	

}

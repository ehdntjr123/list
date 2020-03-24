package cart.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CartDAO implements InterCartDAO {

	private DataSource ds;

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public CartDAO() {

		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/semi");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	public void close() {
		try {
			if (rs != null) {
				rs.close();
				rs = null;
			}
			if (pstmt != null) {
				pstmt.close();
				pstmt = null;
			}
			if (conn != null) {
				conn.close();
				conn = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 전표 생성
	@Override
	public int createStatement() throws SQLException {
		int n = 0;

		try {

			conn = ds.getConnection();

			String sql = " insert into tbl_semi_statement(statementno, statementday) "
					+ " values(seq_semi_statement.nextval, default) ";

			pstmt = conn.prepareStatement(sql);
			n = pstmt.executeUpdate();

		} finally {
			close();
		}

		return n;
	}
	
	// 주문 번호 채번
	@Override
	public int getOrderNo() throws SQLException {
		int orderno = 0;

		try {

			conn = ds.getConnection();

			String sql = " select seq_semi_orderdetail.nextval AS seq " + " from tbl_semi_statement ";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				orderno = rs.getInt("seq");
			}

		} finally {
			close();
		}

		return orderno;
	}

	// 방금 생성한 전표 조회
	@Override
	public StatementVO selectStatement() throws SQLException {

		StatementVO statementVO = null;

		try {

			conn = ds.getConnection();

			String sql = " select statementno, to_char(statementday, 'yyyymmdd') as statementday "
					+ " from tbl_semi_statement " + " order by statementno desc";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				statementVO = new StatementVO();

				statementVO.setStatementno(rs.getInt("statementno"));
				statementVO.setStatementday(rs.getString("statementday"));
			}

		} finally {
			close();
		}

		return statementVO;
	}
	
	//주문상세 테이블에 정보 입력
	@Override
	public int insertOrderDetailList( List<OrderDetailVO> odetailVOList, String userid ) throws SQLException {
		int result = 0;
		
		try {
			
			conn = ds.getConnection();
			
			for(int i=0, n = odetailVOList.size(); i<n; i++) {
				OrderDetailVO odetailVO = odetailVOList.get(i);
				
				String sql = " insert into tbl_semi_orderdetail(orderno, orderaddr1, orderaddr2, orderpostno, ordercount, fk_cartno, fk_productno, fk_statementno, fk_userno ) " +
							 " values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, odetailVO.getOrderno());
				pstmt.setString(2, odetailVO.getOrderAddr1());
				pstmt.setString(3, odetailVO.getOrderAddr2());
				pstmt.setString(4, odetailVO.getOrderPostNo());
				pstmt.setInt(5, odetailVO.getOrdercount());
				pstmt.setInt(6, odetailVO.getFk_cartno());
				pstmt.setInt(7, odetailVO.getFk_productno());
				pstmt.setInt(8, odetailVO.getFk_statementno());
				//회원이면
				if( userid != null) {
					pstmt.setInt(9, odetailVO.getFk_userno());
				}
				//비회원이면
				else {
					pstmt.setNull(9, Types.INTEGER);
				}
				
				result = pstmt.executeUpdate(); 
				
				if(result == 1) {
					System.out.println( (i+1) + "번째 주문상세 삽입" );
				}
				else {
					System.out.println("주문상세 삽입 실패");
					break;
				}
			}
			
		} finally {
			close();
		}
		
		return result;
	}

	//장바구니 조회 하는 메소드
	@Override
	public List<CartDTO> selectByUseridCartList(String userid, String user_ip) throws SQLException {
		
		List<CartDTO> CartDTOList = null;
		
		try {
			
			conn = ds.getConnection();
			String sql = "";
			
			if(userid != null) {
				sql = " select cartno, to_char(cartregisterday, 'yyyymmdd') as cartregisterday, cartordercount, fk_productno, fk_userid, user_ip " + 
					  " from tbl_semi_cart " + 
					  " where fk_userid = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, userid);
			}
			else {
				sql = " select cartno, to_char(cartregisterday, 'yyyymmdd') as cartregisterday, cartordercount, fk_productno, fk_userid, user_ip " + 
					  " from tbl_semi_cart " + 
					  " where fk_userid is null and user_ip = ?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, user_ip);
			}
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt == 1) {
					CartDTOList = new ArrayList<CartDTO>();
				}
				
				CartDTO cartdto = new CartDTO();
				
				cartdto.setCartno(rs.getInt("cartno"));
				cartdto.setCartregisterday(rs.getString("cartregisterday"));
				cartdto.setCartordercount(rs.getInt("cartordercount"));
				cartdto.setFk_productno(rs.getInt("fk_productno"));
				cartdto.setFk_userid(rs.getString("fk_userid"));
				
				CartDTOList.add(cartdto);
			}
		} finally {
			close();
		}
		
		return CartDTOList;
	}

	//사용자가 바로 결제할 경우에 주문상세 리스트를 삽입하는 메소드
	@Override
	public int insertOrderDetail(OrderDetailVO odetailVO, String userid) throws SQLException {
		int result = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " insert into tbl_semi_orderdetail(orderno, orderaddr1, orderaddr2, orderpostno, ordercount, fk_productno, fk_statementno, fk_userno ) " +
						 " values(?, ?, ?, ?, ?, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, odetailVO.getOrderno());
			pstmt.setString(2, odetailVO.getOrderAddr1());
			pstmt.setString(3, odetailVO.getOrderAddr2());
			pstmt.setString(4, odetailVO.getOrderPostNo());
			pstmt.setInt(5, odetailVO.getOrdercount());
			pstmt.setInt(6, odetailVO.getFk_productno());
			pstmt.setInt(7, odetailVO.getFk_productno());
			
			if(userid != null) {
				pstmt.setInt(8, odetailVO.getFk_userno());
			}
			else {
				pstmt.setNull(8, Types.INTEGER);
			}
			
			result = pstmt.executeUpdate(); 
			
		} finally {
			close();
		}
		
		return result;
	}

	@Override
	public int searchUserno(String userid) throws SQLException {
		int userno = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = "";
			
			if(userid != null) {
				sql = " select userno " + 
						 " from tbl_semi_member " + 
						 " where userid = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, userid);
			}
			else {
				sql = " select userno " + 
						 " from tbl_semi_member " + 
						 " where userid is null ";
				
				pstmt = conn.prepareStatement(sql);
			}

			rs = pstmt.executeQuery();
			
			rs.next();
			
			userno = rs.getInt("userno");
			
		} finally {
			close();
		}
		
		return userno;
	}

	//배송 번호 채번
	@Override
	public int getShippingNo() throws SQLException {
		int shippingno = 0;

		try {

			conn = ds.getConnection();

			String sql = " select seq_semi_shipping.nextval AS seq " + " from tbl_semi_shipping ";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				shippingno = rs.getInt("seq");
			}

		} finally {
			close();
		}

		return shippingno;
	}

	//배송 정보 삽입 메소드
	@Override
	public int insertShippinginfo(int shippingno, String shippingcode) throws SQLException {
		int result = 0;
		
		try {

			conn = ds.getConnection();

			String sql = " insert into tbl_semi_shipping(shippingno, shippingcode, company, status) " + 
						 " values(?, ?, 'CJ대한통운', 0) ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, shippingno);
			pstmt.setString(2, shippingcode);

			result = pstmt.executeUpdate();

		} finally {
			close();
		}
		
		return result;
	}

	//주문내역 번호 채번
	@Override
	public int getOrderListNo() throws SQLException {
		int orderListno = 0;

		try {

			conn = ds.getConnection();

			String sql = " select seq_semi_orderlist.nextval AS seq " + " from tbl_semi_orderlist ";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				orderListno = rs.getInt("seq");
			}

		} finally {
			close();
		}

		return orderListno;
	}

	//주문내역 정보 삽입 메소드
	@Override
	public int insertOrderListVO(List<OrderListVO> orderList) throws SQLException {
		int result = 0;
		
		try {
			
			conn = ds.getConnection();
			
			for(int i=0, n = orderList.size(); i<n; i++) {
				OrderListVO orderListVO = orderList.get(i);
				
				String sql = " insert into tbl_semi_orderlist(ordercompleteno, paymentmode, paymentname, fk_orderdetailno, fk_statementno, fk_shippingno) " + 
							 " values(?, ?, ?, ?, ?, ?) ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, orderListVO.getOrdercompleteno());
				pstmt.setString(2, orderListVO.getPaymentmode());
				pstmt.setString(3, orderListVO.getPaymentname());
				pstmt.setInt(4, orderListVO.getFk_orderdetailno());
				pstmt.setInt(5, orderListVO.getFk_statementno());
				pstmt.setInt(6, orderListVO.getFk_shippingno());

				result = pstmt.executeUpdate(); 
				
				if(result == 1) {
					System.out.println( (i+1) + "번째 주문내역 삽입" );
				}
				else {
					System.out.println("주문내역 삽입 실패");
					break;
				}
			}
			
		} finally {
			close();
		}
		
		return result;
	}
}

package cart.model;

import java.sql.SQLException;
import java.util.*;

public interface InterCartDAO {
	
	//전표 생성
	int createStatement() throws SQLException;
	
	//방금 생성한 전표 조회
	StatementVO selectStatement() throws SQLException;
	
	// 주문 번호 채번
	int getOrderNo() throws SQLException;
	
	//주문상세 리스트를 삽입하는 메소드
	int insertOrderDetailList( List<OrderDetailVO> odetailList, String userid ) throws SQLException;
	
	//사용자가 바로 결제할 경우에 주문상세 리스트를 삽입하는 메소드
	int insertOrderDetail(OrderDetailVO odetailVO, String userid) throws SQLException;
	
	//장바구니 조회 하는 메소드
	List<CartDTO> selectByUseridCartList(String userid, String user_ip) throws SQLException;
	
	//회원번호를 조회하는 메소드
	int searchUserno(String userid) throws SQLException;
	
	// 배송 번호 채번
	int getShippingNo() throws SQLException;
	
	// 배송 정보 삽입 메소드
	int insertShippinginfo(int shippingno, String shippingcode) throws SQLException;
	
	// 주문내역 번호 채번
	int getOrderListNo() throws SQLException;
	
	//주문내역 정보 삽입 메소드
	int insertOrderListVO(List<OrderListVO> orderList) throws SQLException;

}

package cart.model;

public class OrderDetailVO {

	private int orderno;
	private String orderAddr1;
	private String orderAddr2;
	private String orderPostNo;
	private int ordercount;
	private int fk_cartno;
	private int fk_productno;
	private int fk_userno;
	private int fk_statementno;
	
	public int getOrderno() {
		return orderno;
	}
	public void setOrderno(int orderno) {
		this.orderno = orderno;
	}
	public String getOrderAddr1() {
		return orderAddr1;
	}
	public void setOrderAddr1(String orderAddr1) {
		this.orderAddr1 = orderAddr1;
	}
	public String getOrderAddr2() {
		return orderAddr2;
	}
	public void setOrderAddr2(String orderAddr2) {
		this.orderAddr2 = orderAddr2;
	}
	public String getOrderPostNo() {
		return orderPostNo;
	}
	public void setOrderPostNo(String orderPostNo) {
		this.orderPostNo = orderPostNo;
	}
	public int getOrdercount() {
		return ordercount;
	}
	public void setOrdercount(int ordercount) {
		this.ordercount = ordercount;
	}
	public int getFk_cartno() {
		return fk_cartno;
	}
	public void setFk_cartno(int fk_cartno) {
		this.fk_cartno = fk_cartno;
	}
	public int getFk_productno() {
		return fk_productno;
	}
	public void setFk_productno(int fk_productno) {
		this.fk_productno = fk_productno;
	}
	public int getFk_userno() {
		return fk_userno;
	}
	public void setFk_userno(int fk_userno) {
		this.fk_userno = fk_userno;
	}
	public int getFk_statementno() {
		return fk_statementno;
	}
	public void setFk_statementno(int fk_statementno) {
		this.fk_statementno = fk_statementno;
	}
}

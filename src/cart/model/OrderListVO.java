package cart.model;

public class OrderListVO {

	private int ordercompleteno;
	private String paymentmode;
	private String paymentname;
	private int fk_orderdetailno;
	private int fk_statementno;
	private int fk_shippingno;
	public int getOrdercompleteno() {
		return ordercompleteno;
	}
	public void setOrdercompleteno(int ordercompleteno) {
		this.ordercompleteno = ordercompleteno;
	}
	public String getPaymentmode() {
		return paymentmode;
	}
	public void setPaymentmode(String paymentmode) {
		this.paymentmode = paymentmode;
	}
	public String getPaymentname() {
		return paymentname;
	}
	public void setPaymentname(String paymentname) {
		this.paymentname = paymentname;
	}
	public int getFk_orderdetailno() {
		return fk_orderdetailno;
	}
	public void setFk_orderdetailno(int fk_orderdetailno) {
		this.fk_orderdetailno = fk_orderdetailno;
	}
	public int getFk_statementno() {
		return fk_statementno;
	}
	public void setFk_statementno(int fk_statementno) {
		this.fk_statementno = fk_statementno;
	}
	public int getFk_shippingno() {
		return fk_shippingno;
	}
	public void setFk_shippingno(int fk_shippingno) {
		this.fk_shippingno = fk_shippingno;
	}
	
	
}

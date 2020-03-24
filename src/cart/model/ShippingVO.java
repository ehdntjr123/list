package cart.model;

public class ShippingVO {

	private int shippingno;
	private String shippingcode;
	private String company;
	private int status;
	
	public int getShippingno() {
		return shippingno;
	}
	public void setShippingno(int shippingno) {
		this.shippingno = shippingno;
	}
	public String getShippingcode() {
		return shippingcode;
	}
	public void setShippingcode(String shippingcode) {
		this.shippingcode = shippingcode;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
}

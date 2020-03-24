package cart.model;

public class CartDTO {
	
	private int cartno;
	private String cartregisterday;
	private int cartordercount;
	private int fk_productno;
	private String fk_userid; 
	private String clientip;
	
	public String getClientip() {
		return clientip;
	}
	public void setClientip(String clientip) {
		this.clientip = clientip;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public int getCartno() {
		return cartno;
	}
	public void setCartno(int cartno) {
		this.cartno = cartno;
	}
	public String getCartregisterday() {
		return cartregisterday;
	}
	public void setCartregisterday(String cartregisterday) {
		this.cartregisterday = cartregisterday;
	}
	public int getCartordercount() {
		return cartordercount;
	}
	public void setCartordercount(int cartordercount) {
		this.cartordercount = cartordercount;
	}
	public int getFk_productno() {
		return fk_productno;
	}
	public void setFk_productno(int fk_productno) {
		this.fk_productno = fk_productno;
	}
}

package prod.model;

public class ProdVO {	
	
	private int productno;
	private String productname;
	private String brand;
	private String pimage;
	private int price;
	private int pstock;
	private int fk_pcategoryno;
	private String pinputdate;
	private int cartordercount;
	private String fk_userid;
	
	public ProdVO() {}
	
	public ProdVO(int productno, String productname, String brand, String pimage, int price, int pstock,
			int fk_pcategoryno, String pinputdate) {

		this.productno = productno;
		this.productname = productname;
		this.brand = brand;
		this.pimage = pimage;
		this.price = price;
		this.pstock = pstock;
		this.fk_pcategoryno = fk_pcategoryno;
		this.pinputdate = pinputdate;
	}
	
	public int getProductno() {
		return productno;
	}
	public void setProductno(int productno) {
		this.productno = productno;
	}
	public String getProductname() {
		return productname;
	}
	public void setProductname(String productname) {
		this.productname = productname;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getPimage() {
		return pimage;
	}
	public void setPimage(String pimage) {
		this.pimage = pimage;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getPstock() {
		return pstock;
	}
	public void setPstock(int pstock) {
		this.pstock = pstock;
	}
	public int getFk_pcategoryno() {
		return fk_pcategoryno;
	}
	public void setFk_pcategoryno(int fk_pcategoryno) {
		this.fk_pcategoryno = fk_pcategoryno;
	}
	public String getPinputdate() {
		return pinputdate;
	}
	public void setPinputdate(String pinputdate) {
		this.pinputdate = pinputdate;
		
	}
	public int getCartordercount() {
		return cartordercount;
	}
	public void setCartordercount(int cartordercount) {
		this.cartordercount = cartordercount;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
}

package prod.model;

public class ProdImgVO {

	private int imageno;
	private String imagfilename;
	private int fk_productmo;
	
	public int getImageno() {
		return imageno;
	}
	public void setImageno(int imageno) {
		this.imageno = imageno;
	}
	public String getImagfilename() {
		return imagfilename;
	}
	public void setImagfilename(String imagfilename) {
		this.imagfilename = imagfilename;
	}
	public int getFk_productmo() {
		return fk_productmo;
	}
	public void setFk_productmo(int fk_productmo) {
		this.fk_productmo = fk_productmo;
	}
	
	
}

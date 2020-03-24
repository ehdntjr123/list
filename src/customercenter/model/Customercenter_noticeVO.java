package customercenter.model;

public class Customercenter_noticeVO {
	
	
	int noticeno ; 
	String noticetile;   // 
	String noticewriteday; 
	String noticecontent;
	
	
	
	
	
	
	public Customercenter_noticeVO(int noticeno, String noticetile, String noticewriteday, String noticecontent) {
		super();
		this.noticeno = noticeno;
		this.noticetile = noticetile;
		this.noticewriteday = noticewriteday;
		this.noticecontent = noticecontent;
	}
	
	
	// gset  set 메소드 
	public Customercenter_noticeVO() {
		
	}

	public int getnoticeno() {
		return noticeno;
	}

	public void setnoticeno(int noticeno) {
		this.noticeno = noticeno;
	}

	public String getnoticetile() {
		return noticetile;
	}

	public void setnoticetile(String noticetile) {
		this.noticetile = noticetile;
	}

	public String getnoticewriteday() {
		return noticewriteday;
	}

	public void setnoticewriteday(String noticewriteday) {
		this.noticewriteday = noticewriteday;
	}

	public String getnoticecontent() {
		return noticecontent;
	}

	public void setnoticecontent(String noticecontent) {
		this.noticecontent = noticecontent;
	}
	
	
	

	
	
}

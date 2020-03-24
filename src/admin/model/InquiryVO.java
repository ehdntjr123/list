package admin.model;

public class InquiryVO {
	
	
	private int inquiryno; //글번호
    private String inquirytitle;  //제목
    private String inquirycontent;  //문의 내용
    private String inquirycoment; //답변 내용
    private String fk_userid; //작성자 아이디
    private int rep; //답변 유무   미처리 1 해결 0
    private String inquiryday; //작성일
    private String repstatus; // 처리상태 한글 
    
    
    
    
    
	public String getRepstatus() {
		return repstatus;
	}
	public void setRepstatus(String repstatus) {
		this.repstatus = repstatus;
	}
	public int getInquiryno() {
		return inquiryno;
	}
	public void setInquiryno(int inquiryno) {
		this.inquiryno = inquiryno;
	}
	public String getInquirytitle() {
		return inquirytitle;
	}
	public void setInquirytitle(String inquirytitle) {
		this.inquirytitle = inquirytitle;
	}
	public String getInquirycontent() {
		return inquirycontent;
	}
	public void setInquirycontent(String inquirycontent) {
		this.inquirycontent = inquirycontent;
	}
	public String getInquirycoment() {
		return inquirycoment;
	}
	public void setInquirycoment(String inquirycoment) {
		this.inquirycoment = inquirycoment;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public int getRep() {
		return rep;
	}
	public void setRep(int rep) {
		this.rep = rep;
	}
	public String getInquiryday() {
		return inquiryday;
	}
	public void setInquiryday(String inquiryday) {
		this.inquiryday = inquiryday;
	}
	public InquiryVO(int inquiryno, String inquirytitle, String inquirycontent, String inquirycoment, String fk_userid,
			int rep, String inquiryday) {
		super();
		this.inquiryno = inquiryno;
		this.inquirytitle = inquirytitle;
		this.inquirycontent = inquirycontent;
		this.inquirycoment = inquirycoment;
		this.fk_userid = fk_userid;
		this.rep = rep;
		this.inquiryday = inquiryday;
	}
 
	
	public InquiryVO() {
		// TODO Auto-generated constructor stub
	}
	
	
	
	
	
	
	

    
    
    
    
    

}

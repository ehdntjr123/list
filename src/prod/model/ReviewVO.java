package prod.model;

public class ReviewVO {

	private int reviewno;
	private int fk_userno;
	private int fk_productno;
	private String reviewwriteday;
	private String reviewtitle;
	private String reviewcontent;
	private String fk_userid;
	private int score;
	
	public int getReviewno() {
		return reviewno;
	}
	public void setReviewno(int reviewno) {
		this.reviewno = reviewno;
	}
	public int getFk_userno() {
		return fk_userno;
	}
	public void setFk_userno(int fk_userno) {
		this.fk_userno = fk_userno;
	}
	public int getFk_productno() {
		return fk_productno;
	}
	public void setFk_productno(int fk_productno) {
		this.fk_productno = fk_productno;
	}
	public String getReviewwriteday() {
		return reviewwriteday;
	}
	public void setReviewwriteday(String reviewwriteday) {
		this.reviewwriteday = reviewwriteday;
	}
	public String getReviewtitle() {
		return reviewtitle;
	}
	public void setReviewtitle(String reviewtitle) {
		this.reviewtitle = reviewtitle;
	}
	public String getReviewcontent() {
		return reviewcontent;
	}
	public void setReviewcontent(String reviewcontent) {
		this.reviewcontent = reviewcontent;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
}

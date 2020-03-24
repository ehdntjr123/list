package member.model;

public class MemberVO {
   
   
   
   int userno; 
   String userid; 
   String userpw; 
   String username; 
   String email; 
   String phone; 
   String postno;  // 우편번호
   String addr1;   // 주소
   String addr2;   // 상세주소
   int status; 
   String registerday; 
   String lastlogindate; 
   String pwchangedate;
   String email1;
   String email2;
   String postno1;
   String postno2;

   
   
   boolean requirePwdChange = false;  // 마지막 암호변경이 6 개월이 지나면 true; 아님 false; 
   
   boolean idleStatus = false; // 접속한지 1년지 지나면  true; 아님 false; 
   
   
   public boolean isRequirePwdChange() {
      return requirePwdChange;
   }


   public void setRequirePwdChange(boolean requirePwdChange) {
      this.requirePwdChange = requirePwdChange;
   }


   public boolean isIdleStatus() {
      return idleStatus;
   }


   public void setIdleStatus(boolean idleStatus) {
      this.idleStatus = idleStatus;
   }


   public MemberVO() {
      // TODO Auto-generated constructor stub
   }


   public MemberVO(int userno, String userid, String userpw, String username, String email, String phone,
         String postno, String addr1, String addr2, int status, String registerday, String lastlogindate,
         String pwchangedate) {
      super();
      this.userno = userno;
      this.userid = userid;
      this.userpw = userpw;
      this.username = username;
      this.email = email;
      this.phone = phone;
      this.postno = postno;
      this.addr1 = addr1;
      this.addr2 = addr2;
      this.status = status;
      this.registerday = registerday;
      this.lastlogindate = lastlogindate;
      this.pwchangedate = pwchangedate;
   }


   public int getUserno() {
      return userno;
   }


   public void setUserno(int userno) {
      this.userno = userno;
   }


   public String getUserid() {
      return userid;
   }


   public void setUserid(String userid) {
      this.userid = userid;
   }


   public String getUserpw() {
      return userpw;
   }


   public void setUserpw(String userpw) {
      this.userpw = userpw;
   }


   public String getUsername() {
      return username;
   }


   public void setUsername(String username) {
      this.username = username;
   }


   public String getEmail() {
      return email;
   }


   public void setEmail(String email) {
      this.email = email;
   }


   public String getPhone() {
      return phone;
   }


   public void setPhone(String phone) {
      this.phone = phone;
   }


   public String getPostno() {
      return postno;
   }


   public void setPostno(String postno) {
      this.postno = postno;
   }


   public String getAddr1() {
      return addr1;
   }


   public void setAddr1(String addr1) {
      this.addr1 = addr1;
   }


   public String getAddr2() {
      return addr2;
   }


   public void setAddr2(String addr2) {
      this.addr2 = addr2;
   }


   public int getStatus() {
      return status;
   }


   public void setStatus(int status) {
      this.status = status;
   }


   public String getRegisterday() {
      return registerday;
   }


   public void setRegisterday(String registerday) {
      this.registerday = registerday;
   }


   public String getLastlogindate() {
      return lastlogindate;
   }


   public void setLastlogindate(String lastlogindate) {
      this.lastlogindate = lastlogindate;
   }


   public String getPwchangedate() {
      return pwchangedate;
   }


   public void setPwchangedate(String pwchangedate) {
      this.pwchangedate = pwchangedate;
   }



   
   public String getEmail1() {
      String[] emailArr= this.email.split("@");
      
      return emailArr[0];
      
   }

   public String getEmail2() {
      String[] emailArr= this.email.split("@");
      
      return emailArr[1];   
      
   }

   
   public String getPostno1() {
      
      return this.postno2 = this.postno.substring(0,3);   
   }


   
   public String getPostno2() {

      return this.postno2 = this.postno.substring(3);   

   }


   public void setPostno2() {
      this.postno2 = postno.substring(4);   

   }
   
   
   
}
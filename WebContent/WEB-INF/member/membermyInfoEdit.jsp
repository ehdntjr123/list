<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>

<jsp:include page="/header.jsp" />

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">


$(document).ready(function(){
   
/*    alert("${state}");   */

    if(("${state}")=="false"){
      alert("암호가 잘못되었습니다");
   }  
   // 주소 찾기 시작--------------------------------------------------------------
   $("#zipcodeSearch").click(function(){
      new daum.Postcode({
         oncomplete: function(data) {
             $("#post1").val(data.postcode1);  // 우편번호의 첫번째 값     예> 151
             $("#post2").val(data.postcode2);  // 우편번호의 두번째 값     예> 019
             $("#addr1").val(data.address);    // 큰주소                        예> 서울특별시 종로구 인사로 17 
             $("#addr2").focus();
         }
      }).open();
   });   
   // 주소 찾기 끝-----------------------------------------------------------------
   // 이메일 자동갱신 시작-----------------------------------------------------
   $(".emailSelect").change(function(){
      if($(".emailSelect").val()=="직접 입력")
         {
            $("#emailDirect").val("");
         }
      else{
         $("#emailDirect").val($(".emailSelect").val());
      }
   });
   
   // 이메일 자동갱신 종료-----------------------------------------------------
   
$("#editBtn2").click(function(){
   
   if($("#join_pw").val().trim()==""){
      alert("비밀번호를 입력하셔야 합니다");
   }
      
   else{   
      
      if($("#join_pw").val()==$("#join_pw2").val()){ 
      if($("#join_email").val().trim()==""
         ||$("#emailDirect").val().trim()==""
         ||$("#phone").val().trim()==""||$("#post1").val().trim()==""
         ||$("#post2").val().trim()==""||$("#addr1").val().trim()==""
         ||$("#addr2").val().trim()==""||$("#post1").val().trim()=="")
      {
         
         alert("모든 항목을 입력하셔야 합니다");
         
      }
      else{
            var frm = document.registerFrm;
            frm.method = "POST";
            frm.action = "membermyInfoEdit.army";
            frm.submit();
      }
      }
      else {
         alert("비밀번호가 일치하지 않습니다");
      }
      
   }
   
});


});

</script>

</head>
<body>


  <div class="container-fluid text-center">    
   <div class="row content">
   
     <div class="col-sm-2 sidenav" style="border:solid 1px gray; border-bottom: none; border-right: none;">
            <jsp:include page="/mypageside.jsp" />      
     </div>
     
      <div class="col-sm-9 text-left" style="border:solid 1px gray"> 
      <div id="memberEdit">
        <h2 id="memberEditfont" style="text-align: center; margin-top: 100px; padding: 0px 0px 38px;">회원정보 입력</h2>
         <form name="registerFrm">
           <div class="memberInfoFont"> 기본정보입력 (필수)</div>
           <div class="box">
             <label for="join_name" class="labelName"></label>
            <input type="text"  id="join_name" class="form_input" value="${sessionScope.loginuser.username}" readonly />
           </div>
            
         
           <div class="editDiv">
            <label for="join_id" class="labelName"></label>
            <input type="text" name="myUserid" id="join_id" class = "form_input" value= "${sessionScope.loginuser.userid}" readonly />
           </div>
               
           <div class="editDiv">
            <label for="join_pw" class="labelName"></label>
            <input type="password" name="join_pw" id="join_pw" class="form_input" maxlength="16" placeholder="비밀번호 (8-16자 이내 영문,숫자,특수문자를 조합해 입력)" />
           </div>
            
           <div class="editDiv">
            <label for="join_p2" class="labelName"></label>
            <input type="password" name="join_pw2" id="join_pw2" class="form_input" maxlength="16" placeholder="비밀번호 확인" />
           </div>   
               
           <div class="editDiv">
            <label for="join_email" class="labelName"></label>
            <input type="text" name = "email1" id="join_email" class="form_input" placeholder="이메일" value="${sessionScope.loginuser.email1}" style="width: 140px;">
            <span>@</span>
                  
            <input type="text" value="${sessionScope.loginuser.email2}" name = "email2" class="form_input" id="emailDirect" style="width: 120px;">
                              
            <select name ="email3" class="labelName form_input emailSelect" style="width: 150px;">
              <option value="gmail.com">gmail.com</option>
              <option value="naver.com">naver.com</option>
              <option value="daum.net">daum.net</option>
              <option value="hanmail.net">hanmail.net</option>
              <option value="nate.com">nate.com</option>
              <option value="lycos.co.kr">lycos.co.kr</option>
              <option value="hotmail.com">hotmail.com</option>
              <option value="outlook.com">outlook.com</option>
              <option value="korea.com">korea.com</option>
              <option value="yahoo.co.kr">yahoo.co.kr</option>               
              <option value="dreamwiz.com">dreamwiz.com</option>
              <option value="직접 입력" selected>직접 입력</option>
             </select>
           </div>   
               
         <div class="editDiv">
           <label for="join_cell" class="labelName"></label>
           <input type="text" name = "phone" class="form_input" maxlength="11" placeholder="휴대전화번호('-'없이 입력)" id="phone" value="${sessionScope.loginuser.phone}"/>
         </div>
               
         <div class="editDiv" >
            <tr>
               <td style="width: 20%; font-weight: bold;"><label>우편번호</label></td>
               <td style="width: 80%; text-align: left;">
                  <input type="text" id="post1" name="post1" size="6" maxlength="3" value="${sessionScope.loginuser.postno1}" />
                  &nbsp;-&nbsp;
                  <input type="text" id="post2" name="post2" size="6" maxlength="3" value="${sessionScope.loginuser.postno2}"/>&nbsp;&nbsp;
                  <!-- 우편번호 찾기 -->
                  <img id="zipcodeSearch" src="<%= ctxPath %>/images/b_zipcode.gif" style="vertical-align: middle;" />
                  <span class="error error_post" style="display: none;">우편번호 형식이 아닙니다.</span>
               </td>
            </tr>            
         </div>   
         
         <div class="editDiv" style="margin-top: 0px;">
           <label for="addr1" class="labelName"></label>
           <input type="text" class="form_input" name="addr1" id="addr1"  placeholder="상세주소 1" value="${sessionScope.loginuser.addr1}"/>
           
           <label for="addr2" class="labelName"></label>
           <input type="text" class="form_input" name="addr2" id="addr2" placeholder="상세주소 2" value="${sessionScope.loginuser.addr2}"/>
         </div>            
         
         <div class="editDiv">
           <input type="checkbox" value="Y" id="join_mailing"/>
           <label for="join_mailing" class="labelName">이메일 정보 수신</label>      
           <input type="checkbox" value="Y" id="join_sms"/>
           <label for="join_sms" class="labelName">SMS/알림톡 수신</label>      
         </div>            
                           
         <div style="margin-top: 60px;">
           <button type="reset" id="editBtn1">취소</button>
           <button type="button" id="editBtn2">확인</button>
         </div>
         <div style="text-align: center; margin-top: 40px">
           <a href="<%= ctxPath%>/member/memberWithdrawal.army" id="memtal">회원탈퇴</a>
         </div>
        </form>   
       </div>
     </div>     
    </div>
  </div>
    
  
 <jsp:include page="/footer.jsp" />

   
</body>
</html>
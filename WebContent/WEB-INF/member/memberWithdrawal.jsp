<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="/header.jsp"/>


<script type="text/javascript">

$(document).ready(function(){
  if("${status}"=="false"){	
	alert("비밀번호가 일치하지 않습니다");	
  }

  $("#SecessionBtn2").click(function(){
	var frm = document.registerFrm;
	frm.method = "POST";
	frm.action = "memberWithdrawal.army";
	frm.submit();	
  });
  
});
//end of $(document).ready(function()----------------------

</script>

 <div class="container-fluid text-center">    
	<div class="row content">
	  <div class="col-sm-2 sidenav" style="border:solid 1px gray; border-bottom: none; border-right: none;">
			<jsp:include page="/mypageside.jsp" />			
	  </div>
	  
      <div class="col-sm-9 text-left" style="border: solid 1px gray;">
      <div style="width: 60%; margin-left: 150px;">
		<h2 id="memberSecessionfont" style="text-align: center; margin-top: 100px;">회원 탈퇴</h2>
		<br/>
		<form name="registerFrm">
			<div style="margin: 0 auto; font-size: 12pt;">
		      <p>탈퇴하실 경우 구매내역 확인은 물론 로그인 후 가능한 모든 기능은 사용하실 수 없습니다.<br/>
				  탈퇴하신 후에 회원 정보의 복구는 불가능하며, 보유하신 쿠폰이나 적립금도 모두 무효화됩니다.</p>
			    <div style="border: solid 1px gray;">
				  <input type="password" id="pwdSecession" name="pwd" maxlength="16" placeholder="비밀번호">		
				</div>
		    </div> 
		    <div>
			  <div id="secessionRe" style="display: inline-block; color: black; position: relative; top:12px;">탈퇴사유 </div>		    
			  <ul id="withdrawal" style="list-style-type: none; margin-top : 5px;">
				<li class="liSession">
				  <input type="radio" name="reason" value="이유없음" id="reason0">
				  <label for="reason0">이유없음</label>
				</li>
				<li class="liSession">
				  <input type="radio" name="reason" value="상품/서비스 불만족" id="reason1">
				  <label for="reason1">상품/서비스 불만족</label>					
				</li>
				<li class="liSession">
				  <input type="radio" name="reason" value="더 이상 구매의사 없음" id="reason2">
				  <label for="reason2">더 이상 구매의사 없음</label>					
				</li>
				<li class="liSession">
				  <input type="radio" name="reason" value="기타" id="reason3">
				  <label for="reason3">기타</label>					
				</li>		
			  </ul>
			</div>
			<div>
			  <textarea name="content" id="textareaSecession"></textarea>
			</div>
			<div style="margin-bottom: 5%; text-align: center;">
			  <button type="reset" id="SecessionBtn1">취소</button>
			  <button type="button" id="SecessionBtn2" onclick="goRegister();">확인</button>
			</div>
	   </form>
	  </div>
	  </div>
    </div>
  </div>

<jsp:include page="/footer.jsp"/>
	
</body>
</html>
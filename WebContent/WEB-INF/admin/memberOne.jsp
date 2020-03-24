<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/header.jsp" />

<style type="text/css">
	div#memberInfo {
		width: 50%; 
		text-align: left;
		border: solid 0px red;
		margin-top: 30px; 
		font-size: 13pt;
		line-height: 200%;
	}
	
	span.myli {
		display: inline-block;
		width: 90px;
		border: solid 0px blue;
	}
</style>

<div class="container-fluid text-center">    
	<div class="row content">
	
	  <div class="col-sm-2 sidenav" style="border:solid 1px gray">
	  
		<jsp:include page="/adminPageSide.jsp"/>

	</div>
	
	<div class="col-sm-9 text-left" style="border:solid 1px gray"> 
       <div class="row content">
			<div class="col-sm-12 text-left">
	
 <h3>::: ${member.userid}님의 회원 상세정보 :::</h3>
 <div id="memberInfo">
 <ol>	
	 <li><span class="myli">회원번호 : </span>${member.userno}</li>
	 <li><span class="myli">아이디 : </span>${member.userid}</li>
	 <li><span class="myli">회원명 : </span>${member.username}</li>
	 <li><span class="myli">이메일 : </span>${member.email}</li>
	 <li><span class="myli">휴대폰 : </span>${member.phone}</li>
	 <li><span class="myli">우편번호 : </span>${member.postno}</li>
	 <li><span class="myli">주소 : </span>${member.addr1}&nbsp;${member.addr2}</li>
	 <li><span class="myli">가입일자 : </span>${member.registerday}</li>
  </ol>
  </div>
  
  <button style="margin-top: 20px;" type="button" onclick="javascript:history.back();">회원목록</button>
  
  			</div>  
		 </div>	
	  </div>
	  
	  </div>
	  </div>
    
<jsp:include page="/footer.jsp" /> 
   
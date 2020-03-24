<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>  
  

<script type="text/javascript">

$(document).ready(function(){

		  
	  $("#wishStateSide").click(function(){
		  location.href = '<%= ctxPath %>/member/memberMyWish.army';
	  });

	  $("#orderStateSide").click(function(){
		  location.href = '<%= ctxPath %>/member/memberMyOrder.army';		  
	  });
	  
	  $("#currentStateSide").click(function(){
		  location.href = '<%= ctxPath %>/member/membermypage.army';		  
	  });
	  
	  		  
	  $("#memberInfoEditside").click(function(){
		  location.href = '<%= ctxPath %>/member/membermyInfoEdit.army';		  
	  });
	  
	  $("#inquiryStateSide").click(function(){
           location.href = '<%= ctxPath %>/customercenter/inquiryList.army';        
      });
	 
});

</script>  
    
    
<h2 style="margin-left: 60px; margin-top: 100px; margin-bottom: 30px;">마이페이지</h2>
				
		<span class="title">주문조회</span>
		<ul class="sideul">
		  <li class="sideli" id="orderStateSide" style="cursor: pointer;">주문현황</li>
		  <li class="sideli" id="inquiryStateSide" style="cursor: pointer;">1:1 문의</li>				
		</ul>

		<span class="title">활동관리</span>
		<ul class="sideul">
		  <li class="sideli" id="wishStateSide" style="cursor: pointer;">위시리스트</li>
		  <li class="sideli" id="currentStateSide" style="cursor: pointer;">최근 본 상품</li>	
		</ul>
		<span class="title" style="cursor: pointer;">회원정보</span>
		<ul class="sideul">
		  <li class="sideli" id="memberInfoEditside" style="cursor: pointer;">회원정보 변경</li>	
		</ul>
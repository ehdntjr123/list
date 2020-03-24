<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>  
  
<script type="text/javascript">

  $(document).ready(function(){
	  
	  $("#wishNum").click(function(){
		  location.href = '<%= ctxPath %>/member/memberMyWish.army';
	  });

	  $("#orderNum").click(function(){
		  location.href = '<%= ctxPath %>/member/memberMyOrder.army';		  
	  });
	  
	  $("#inforChange").click(function(){
		  location.href = '<%= ctxPath %>/member/membermyInfoEdit.army';	
		  
	  });

}); 
</script> 

  <div class="col-sm-12 text-left" id="myPageBox" style="border-left:none; border-right:none; ">
	<img src="<%= ctxPath %>/images/club.jpg" style="margin-top: 30px; margin-left: 20px;"/>
	<div id="memberHello" style="position: relative; top: 20px;"><h2>${sessionScope.loginuser.username } 회원님 반갑습니다.</h2></div>
	  <button type="button" id="inforChange" style="position: relative; top: 30px;">회원정보수정</button>
	  
	  <div id="wishList">
	    <img src="<%= ctxPath %>/images/wish.png" style="margin-top: 40px;" id="wishNum"/>
	  </div>
 	  	
 	  <div id="orderList">
	    <img src="<%= ctxPath %>/images/order.png" style="margin-top: 40px;" id="orderNum"/>
	  </div>				
  </div>  
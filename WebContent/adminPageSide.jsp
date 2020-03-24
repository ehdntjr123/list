<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>  
  

<script type="text/javascript">

$(document).ready(function(){

		  
		  $("#memberList").click(function(){
			  location.href = '/SemiProject/admin/memberList.army';
		  });

		  $("#productRegister").click(function(){
			  location.href = '/SemiProject/admin/productRegister.army';		  
		  });
		  
		  $("#productAdd").click(function(){
			  location.href = '/SemiProject/admin/productAdd.army';		  
		  });
		  
		  $("#productDelete").click(function(){
			  location.href = '/SemiProject/admin/productDelete.army';		  
		  });
		  
		  $("#inquiryEnd").click(function(){
			  location.href = '/SemiProject/admin/inquiryListEnd.army';		  
		  });
		  
		  $("#inquiryWait").click(function(){
			  location.href = '/SemiProject/admin/inquiryListWait.army';		  
		  });
	 
});

</script>  
    
    
<h2 style="margin-left: 60px; margin-top: 100px; margin-bottom: 30px; font-size: 16pt; font-weight: bold;">관리자페이지</h2>
				
		<span class="title">회원관리</span>
		<ul class="sideul">
		  <li class="sideli" id="memberList" style="cursor: pointer;">회원 목록</li>
		</ul>

		<span class="title">상품 관리</span>
		<ul class="sideul">
		  <li class="sideli" id="productRegister" style="cursor: pointer;">신규상품등록</li>
		  <li class="sideli" id="productAdd" style="cursor: pointer;">상품 입고</li>
		  <li class="sideli" id="productDelete" style="cursor: pointer;">상품 삭제</li>		
		</ul>
		<span class="title">문의 관리</span>
		<ul class="sideul">
		  <li class="sideli" id="inquiryEnd" style="cursor: pointer;">답변완료</li>
		  <li class="sideli" id="inquiryWait" style="cursor: pointer;">미답변</li>			
		</ul>

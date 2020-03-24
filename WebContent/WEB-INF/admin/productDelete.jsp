<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	String ctxPath = request.getContextPath();
%>
<jsp:include page="/header.jsp"/>

<script type="text/javascript">
$(document).ready(function(){
	
	/* console.log("searchType: "+"${searchType}");
	console.log("searchWord: "+"${searchWord}"); */
	
	if("${searchWord}" != ""){
		$("#searchType").val("${searchType}");
		$("#searchWord").val("${searchWord}");
	}
	
	
	 $("#sizePerPage").val('${sizePerPage}');
		
		$("#sizePerPage").bind("change", function(){
			// select 태그에 대한 이벤트는 click이 아니라 change이다.
			var frm = document.prodFrm;
			
			frm.method = "GET";
			frm.action="<%= ctxPath %>/admin/productDelete.army";
			frm.submit();
		});
		
		$("#searchWord").keydown(function(event){
			// 암호 입력란에 Enter를 했을 경우 로그인 시도
			if(event.keyCode == 13){	// keyCode 13 = Enter
				goSearch();	
			}
		});
		
		
	});
	
	function goSearch(){
		//alert("검색하러 갑니다.");
		
		var frm = document.prodFrm;
		frm.method = "GET";
		frm.action = "/SemiProject/admin/productDelete.army";
		frm.submit();
	}
	
	function deleteProduct(productno){
		
		location.href="<%=ctxPath%>/admin/prodOneDelete.army?productno="+productno;
		
	}
	
</script>

<div class="container-fluid text-center">    
	<div class="row content">
	
	  <div class="col-sm-2 sidenav" style="border:solid 1px gray">
		
		<jsp:include page="/adminPageSide.jsp" />
		
		</div>

<div class="col-sm-9 text-left" style="border:solid 1px gray"> 
       <div class="row content">
			<div class="col-sm-12 text-left">
			
<h2 style="margin:20px;">::: 상품 전체 목록 :::</h2>

<form name="prodFrm">
	<select id="searchType" name="searchType">
		<option value="productno">상품번호</option>
		<option value="productname">상품명</option>
	</select>
	<input type="text" id="searchWord" name="searchWord"/>
	<input type="text" style="display: none"/>
	<button type="button" onclick="goSearch();" id="searchBtn" style="margin-right: 30px;">검색</button>

<span style="color: red; font-weight: bold; font-size: 12pt;">페이지당 상품 수</span>
<select id="sizePerPage" name="sizePerPage">
	<option value="10">10</option>
	<option value="5">5</option>
	<option value="3">3</option>
</select>
</form>

<form name="prodOneFrm">
<table class="table table-bordered" style="width: 90%; margin-top: 20px;">
	<thead>
		<tr>
			<th>상품번호</th>
			<th>이미지</th>
			<th>상품명</th>
			<th>가격</th>
			<th>재고</th>
			<th>삭제</th>
		</tr>
	</thead>
	
	<tbody>
<c:if test="${not empty requestScope.prodList}">
	<c:forEach var="prodvo" items="${prodList}">
	<tr>
		<td id="productno">${prodvo.productno }</td>
		<td id="pimage"><img src="/SemiProject/images/products/${prodvo.pimage }" width="100" height="100" /></td>
		<td id="productname">${prodvo.productname }</td>
		<td id="price">${prodvo.price }</td>
		<td id="pstock">${prodvo.pstock }</td>
		<td><button type="button" onclick="deleteProduct('${prodvo.productno}');">삭제</button></td>
	</tr>
	</c:forEach>
</c:if>
<c:if test="${empty requestScope.prodList}">
	<tr>
		<td colspan="5">등록된 회원이 없습니다.</td>
	</tr>
</c:if>
	</tbody>
</table>
</form>
	
	<div>
	${pageBar }
	</div>
	
			</div>  
		 </div>	
	  </div>	
	
	</div>
	</div>

<jsp:include page="/footer.jsp"/>
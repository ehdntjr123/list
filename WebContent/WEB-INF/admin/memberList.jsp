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
			var frm = document.memberFrm;
			
			frm.method = "GET";
			frm.action="<%= ctxPath %>/admin/memberList.army";
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
		
		var frm = document.memberFrm;
		frm.method = "GET";
		frm.action = "/SemiProject/admin/memberList.army";
		frm.submit();
	}
	
	function goMemberOne(userno){
		
		location.href="<%=ctxPath%>/admin/memberOneDetail.army?userno="+userno;
		
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
			
<h2 style="margin:20px;">::: 회원 전체 목록 :::</h2>

<form name="memberFrm">
	<select id="searchType" name="searchType">
		<option value="username">회원명</option>
		<option value="userid">아이디</option>
	</select>
	<input type="text" id="searchWord" name="searchWord"/>
	<input type="text" style="display: none"/>
	<button type="button" onclick="goSearch();" id="searchBtn" style="margin-right: 30px;">검색</button>

<span style="color: red; font-weight: bold; font-size: 12pt;">페이지당 회원 수</span>
<select id="sizePerPage" name="sizePerPage">
	<option value="10">10</option>
	<option value="5">5</option>
	<option value="3">3</option>
</select>
</form>

<form name="memberOneFrm">
<table class="table table-bordered" style="width: 90%; margin-top: 20px;">
	<thead>
		<tr>
			<th>회원번호</th>
			<th>아이디</th>
			<th>회원명</th>
		</tr>
	</thead>
	
	<tbody>
<c:if test="${not empty requestScope.memberList}">
	<c:forEach var="membervo" items="${memberList}">
	<tr onclick="goMemberOne('${membervo.userno}');" style="cursor:pointer;">
		<td id="idx">${membervo.userno }</td>
		<td id="userid">${membervo.userid }</td>
		<td id="name">${membervo.username }</td>
	</tr>
	</c:forEach>
</c:if>
<c:if test="${empty requestScope.memberList}">
	<tr>
		<td colspan="5">가입된 회원이 없습니다.</td>
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
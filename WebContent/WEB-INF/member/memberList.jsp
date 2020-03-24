<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>
    
<jsp:include page="/header.jsp"/>

<script type="text/javascript">
  $(document).ready(function(){
	if("${searchWord}" != ""){
	   $("#searchType").val("${searchType}");
	   $("#searchWord").val("${searchWord}"); 
	}
    
	$("#sizePerPage").val("${sizePerPage}");
	  
	// *** select 태그에 대한 이벤트는 click 이 아니라 change 이다. *** // 
	$("#sizePerPage").bind("change", function(){
	  var frm = document.memberFrm;
		  
	  frm.method = "GET";
	  frm.action = "<%= ctxPath%>/member/memberList.army";
	  frm.submit();
	});
	  
	$("#serchWord").keydown(function(event) {
	  if(event.keyCode == 13){
		goSearch();
	  }
	});
	
	$("tbody > tr").bind("click", function() {
		var userid = $(this).find(":nth-child(2)").text();
		goMemberDetail(userid);
	});
  });
  
  function goSearch(){
	var frm = document.memberFrm;
	
	frm.method = "GET";
	frm.action = "memberList.up";
	frm.submit();
  }
  
<%--   function goMemberDetail(userid){
	  location.href = "<%= request.getContextPath() %>/member/memberOneDetail.army?userid="+userid;
  } --%>
  
</script>

	<h2 style="margin: 20px;">::: 회원전체 목록 :::</h2>
	
	<form name="memberFrm">
		<select id="searchType" name="searchType">
			<option value="name">회원명</option>
			<option value="userid">아이디</option>
			<option value="email">이메일</option>
		</select>
		<input type="text" id="searchWord" name="searchWord"/>
		<input type="text" style="display: none;"/>
		<button type="button" onclick="goSearch();" style="margin-right: 30px;"> 검색</button>
	
		<span style="color: red; font-weight: bold; font-size: 12pt;">페이지당 회원명수-</span>
		<select id="sizePerPage" name="sizePerPage">
			<option value="20">20</option>
			<option value="10">10</option>
			<option value="5">5</option>
		</select>
    </form>

	<table class="table table-bordered" style="width: 90%; margin-top: 20px;">
        <thead>
        	<tr>
        		<th>회원번호</th>
        		<th>아이디</th>
        		<th>회원명</th>
        		<th>이메일</th>
        	</tr>
        </thead>
        
        <tbody>
		<c:if test="${empty requestScope.memberList}">
			<tr>
				<td colspan="5">가입된 회원이 없습니다.</td>
			</tr>
		</c:if>
	
		<c:if test="${not empty requestScope.memberList}">
			<c:forEach var="membervo" items="${memberList}">
				<tr class="memberVO">
					<td>${membervo.userno}</td>
					<td>${membervo.userid}</td>
					<td>${membervo.username}</td>
					<td>${membervo.email}</td>
				</tr>
			</c:forEach>
		</c:if>
		</tbody>
	</table>

    <div>
    	${pageBar}
    </div>
    
<jsp:include page="/footer.jsp"/>









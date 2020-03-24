<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/header.jsp"/>

<style type="text/css">
	
	tr.noticepInfo:hover {
		background-color: #e6ffe6 !important; 
		cursor: pointer !important;
	}

</style>

<script type="text/javascript">

 $(function(){
	 
	  $("#sizePerPage").val("${sizePerPage}");
	  
	  // *** select 태그에 대한 이벤트는 click 이 아니라 change 이다. *** // 
	  $("#sizePerPage").bind("change", function(){
		  var frm = document.memberFrm;
		  
		  frm.method = "GET";
		  frm.action = "<%= ctxPath%>/admin/inquiryList.army";
		  frm.submit();
	  });
	  
   
	$("tr.noticepInfo").click(function(){
		var idx = $(this).children(".idx").text();
		location.href="<%= ctxPath%>/admin/inquiryListAnswer.army?idx="+idx+"";  
	});
	 
 });


</script>

  <div class="container-fluid text-center">    
	<div class="row content">
		<div class="col-sm-2 sidenav" style="border:solid 1px gray">
		
	<jsp:include page="/adminPageSide.jsp" />
	
		</div>
	
	 <div class="col-sm-9 text-left" style="border:solid 1px gray"> 
       <div class="row content">
			<div class="col-sm-12 text-left">
			
      	<div class="col-md-7 col-md-offset-2"> 
		<h2 style="margin-bottom: 40px;">문의내역</h2>
		<form name="memberFrm">
			<span style="font-weight: bold; font-size: 12pt;">문의갯수 : </span>
			<select id="sizePerPage" name="sizePerPage">
				<option value="10">10</option>
				<option value="5">5</option>
				<option value="3">3</option>
			</select>
		</form>
			<div class="panel">
				<div class="panel-heading">
				</div>
				<div class="panel-body">
					<table class="table table-striped">
						<thead>
							<tr><th style="text-align: center;">문의번호</th><th style="text-align: center;">처리상황</th><th style="text-align: center;">제목</th><th style="text-align: center;">아이디</th><th style="text-align: center;">작성일</th></tr>
						</thead>
						<tbody>
							<c:forEach var="noticepr" items="${inquiryList}">
							<c:if test="${noticepr.repstatus eq '미처리'}">
								<tr class="noticepInfo">
									<td class="idx">${noticepr.inquiryno }</td>
									<td style="text-align: center;"> ${noticepr.repstatus}</td>
									<td style="text-align: center;">${noticepr.inquirytitle}</td>
									<td style="text-align: center;">${noticepr.fk_userid}</td>
									<td style="text-align: center;">${noticepr.inquiryday}</td>
								</tr>
							</c:if>
							</c:forEach>
						</tbody>
					</table>
					<div>
						${pageBar}
					</div>
				</div>
			</div>
		</div>
	
  	 </div> 
	</div>
  </div>
  
  </div>
  </div>

    
  <jsp:include page="/footer.jsp"/>
	
</body>
</html>



	
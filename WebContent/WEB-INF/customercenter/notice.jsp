<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/header.jsp"/>

<style type="text/css">

  /* 작업내용  */
  tr.noticepInfo:hover {
	background-color: #e6ffe6 !important; 
	cursor: pointer !important;
  }
  
</style>

<script type="text/javascript">
	
  //===== TOP 버튼 ===== \\
  var mybutton = document.getElementById("myBtn");
	
  //When the user scrolls down 20px from the top of the document, show the button
  window.onscroll = function() {scrollFunction()};
	
  function scrollFunction() {
	if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
	  mybutton.style.display = "block";
	} else {
	  mybutton.style.display = "none";
	}
  }
	
  //When the user clicks on the button, scroll to the top of the document
  function topFunction() {
	document.body.scrollTop = 0;
	document.documentElement.scrollTop = 0;
  }
	
  // ==== 검색창 ==== \\
  function openSearch() {
	document.getElementById("myOverlay").style.display = "block";
  }

  function closeSearch() {
	document.getElementById("myOverlay").style.display = "none";
  }

  // === list 정렬버튼 === \\
  $(function(){
	$("div.arrayIcon #array1").html("<img src='https://www.giordano.co.kr/_skin/giordano/img/button/list_type0.png' width='30' height='30' style='transform:rotate(90deg)'/>");
	$("div.arrayIcon #array3").html("<img src='https://www.giordano.co.kr/_skin/giordano/img/button/list_type1_over.png' width='30' height='30'/>");
		
	$("div.arrayIcon #array1").click(function(){
	  $("div.arrayIcon #array1").html("<img src='https://www.giordano.co.kr/_skin/giordano/img/button/list_type0_over.png' width='30' height='30' style='transform:rotate(90deg)'/>");
	  $("div.arrayIcon #array3").html("<img src='https://www.giordano.co.kr/_skin/giordano/img/button/list_type1.png' width='30' height='30'/>");
	});
		
	$("div.arrayIcon #array3").click(function(){
	  $("div.arrayIcon #array1").html("<img src='https://www.giordano.co.kr/_skin/giordano/img/button/list_type0.png' width='30' height='30' style='transform:rotate(90deg)'/>");
	  $("div.arrayIcon #array3").html("<img src='https://www.giordano.co.kr/_skin/giordano/img/button/list_type1_over.png' width='30' height='30'/>");
	});
		
	// === List 정렬 종류 === \\
	$("div.list2").hide();
	$("div.arrayIcon #array1").click(function(){
	  $("div.list1").hide();
	  $("div.list2").show();
	  $("#list21").addClass("active");
	});
	$("div.arrayIcon #array3").click(function(){
	  $("div.list2").hide();
	  $("div.list1").show();
	  $("#list11").addClass("active");
	});
		
	$("a.listNumber").click(function(){
	  $(this).addClass("active");
	  $("div.pagination a").not($(this)).removeClass("active");
	});
		
	/* 작업내용 */
	  
	$("#sizePerPage").val("${sizePerPage}");
	  
	// *** select 태그에 대한 이벤트는 click 이 아니라 change 이다. *** // 
	$("#sizePerPage").bind("change", function(){
	  var frm = document.memberFrm;	  
	  frm.method = "GET";
	  frm.action = "<%= ctxPath%>/customercenter/notice.army";
	  frm.submit();
	});
	  
    $('#login-form-link').click(function(e) {
	  $("#login-form").delay(100).fadeIn(100);
 	  $("#register-form").fadeOut(100);
	  $('#register-form-link').removeClass('active');
	  $(this).addClass('active');
	  e.preventDefault();
	});
	    
    $('#register-form-link').click(function(e) {
	  $("#register-form").delay(100).fadeIn(100);
 	  $("#login-form").fadeOut(100);
	  $('#login-form-link').removeClass('active');
	  $(this).addClass('active');
	  e.preventDefault();
	});
    
	$("tr.noticepInfo").click(function(){
	  var idx = $(this).children(".idx").text();
	  location.href="<%= ctxPath%>/customercenter/noticeList.army?idx="+idx+"";  
	});
	
});   // $() -----------------------------------------------------------------------

</script>

<div class="container-fluid text-center">    
  <div class="row content">
	<!-- 작업 시작  @@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
	
	<!-- 관리자가 아닌경우  -->
	<c:if test="${sessionScope.loginuser.userid != 'admin'}">
      <div class="col-md-7 col-md-offset-2"> 
		<h2 style="margin-bottom: 40px;">공지사항</h2>
		<form name="memberFrm">
		  <span style="font-weight: bold; font-size: 12pt;">게시글수 : </span>
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
				<tr><th style="width: 60px; ">번호</th><th width="700px" style="text-align: center;">제목</th><th style="text-align: center;">날짜</th></tr>
			  </thead>
			  <tbody>			
			    <c:forEach var="noticepr" items="${noticeprint }">
				  <tr class="noticepInfo"><td class="idx">${noticepr.noticeno }</td><td>${noticepr.noticetile}</td><td style="text-align: center;">${noticepr.noticewriteday}</td></tr>
				</c:forEach>
			  </tbody>
			</table>
		    <div>
			  ${pageBar}
		    </div>
		  </div>
	    </div>
	  </div>
    </c:if>

	<!-- 관리자인 경우  -->
	<c:if test="${sessionScope.loginuser.userid == 'admin'}">
      <div class="col-md-7 col-md-offset-2"> 
		<h2>공지사항</h2>
		<form name="memberFrm">
		  <span style="font-weight: bold; font-size: 12pt;">게시글수 : </span>
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
				<tr><th style="width: 60px; ">번호</th><th width="700px" style="text-align: center;">제목</th><th style="text-align: center;">날짜</th></tr>
			  </thead>
			  <tbody>
				<c:forEach var="noticepr" items="${noticeprint }">
				  <tr class="noticepInfo"><td class="idx">${noticepr.noticeno }</td><td>${noticepr.noticetile}</td><td style="text-align: center;">${noticepr.noticewriteday}</td></tr>
				</c:forEach>
			  </tbody>
			</table>
		    <div>
			  ${pageBar}</br></br>
			</div>
		    <div>
			  <a href="<%= request.getContextPath()%>/customercenter/noticeAdminWrite.army"><button id="writeBtn">글쓰기</button></a>
		    </div>
		  </div>
	    </div>
	  </div>
	</c:if>
	
	<!-- 작업 끝 @@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
  </div>
</div>
    
<jsp:include page="/footer.jsp"/>
	
</body>
</html>
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
	  $("#rep").val("${rep}");
		
		
	  // *** select 태그에 대한 이벤트는 click 이 아니라 change 이다. *** // 
	  $("#sizePerPage").bind("change", function(){
		  var frm = document.memberFrm;
		  
		  frm.method = "GET";
		  frm.action = "<%= ctxPath%>/customercenter/inquiryList.army";
		  frm.submit();
	  });
	  
	  
	  
	  $("#rep").bind("change", function(){
		  var frm = document.memberFrm;
		  
		  frm.method = "GET";
		  frm.action = "<%= ctxPath%>/customercenter/inquiryList.army";
		  frm.submit();
	  });
	  
	  
   
	$("tr.noticepInfo").click(function(){
		var idx = $(this).children(".idx").text();
		location.href="<%= ctxPath%>/customercenter/inquiryListAnswer.army?idx="+idx+"";  
	});
	
	
	
	
	
			
	
	
});   // $() -----------------------------------------------------------------------

</script>

<div class="container-fluid text-center">    
  <div class="row content">
  
  
  
  
  <!-- 작업 시작  @@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- 관리자 문의게시판  -->
	<c:if test="${sessionScope.loginuser.userid == 'admin'}">
      <div class="col-md-7 col-md-offset-2"> 
		<h2 style="margin-bottom: 40px;">문의내역</h2>
		<form name="memberFrm">
		  <span style="font-weight: bold; font-size: 12pt;">정렬갯수 : </span>
		  <select id="sizePerPage" name="sizePerPage">
		    <option value="10">10</option>
		    <option value="5">5</option>
		    <option value="3">3</option>
		  </select>
		  
		   <span style="font-weight: bold; font-size: 12pt;">처리현황 : </span>
		  <select id="rep" name="rep">
		    <option value="1">미처리 </option>
		    <option value="0">처리</option>
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
				  <tr class="noticepInfo">
					<td class="idx">${noticepr.inquiryno }</td>
					<td style="text-align: center;"> ${noticepr.repstatus}</td>
					<td style="text-align: center;">${noticepr.inquirytitle}</td>
					<td style="text-align: center;">${noticepr.fk_userid}</td>
					<td style="text-align: center;">${noticepr.inquiryday}</td>
				  </tr>
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

	<!-- 회원 개인 문의게시판 -->
	<c:if test="${sessionScope.loginuser.userid != 'admin'}">
      <div class="col-md-7 col-md-offset-2"> 
		<h2 style="margin-bottom: 40px;">나의 문의내역</h2>
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
				<tr><th style="text-align: center;">문의번호</th><th style="text-align: center;">처리상황</th><th style="text-align: center;">제목</th><th style="text-align: center;">작성일</th></tr>
			  </thead>
			  <tbody>
				<c:forEach var="noticepr" items="${inquiryList}">
				  <tr class="noticepInfo">
					<td class="idx">${noticepr.inquiryno }</td>
					<td style="text-align: center;"> ${noticepr.repstatus}</td>
					<td style="text-align: center;">${noticepr.inquirytitle}</td>
					<td style="text-align: center;">${noticepr.inquiryday}</td>
				  </tr>
				</c:forEach>
			  </tbody>
			</table>
		    <div>
			  ${pageBar}
		    </div>
		    <button  style="margin-top: 30px;" onclick="location.href='<%= request.getContextPath()%>/customercenter/inquiry.army'">글쓰기</button>
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



	
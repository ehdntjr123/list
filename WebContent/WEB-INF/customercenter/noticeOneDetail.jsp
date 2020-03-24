<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/header.jsp"/>

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
  });
	
  function gosubmit(object) {	
	if(confirm('정말 삭제 하시겠습니까?')) {
	  var index = object; 
	  location.href="<%= ctxPath%>/customercenter/noticeListDelete.army?index="+index+"";		
	}
	else {
	  location.href="javascript:history.go(0);";	
	}	
  }
  
  function goUpdate(index, noticetile, noticecontent) {
	if(confirm('정말 수정 하시겠습니까?')) {
	  var frm = document.noticeFrm;	
	  frm.method = "GET";
	  frm.action = "<%= ctxPath%>/customercenter/noticeListUpdateStart.army";
	  frm.submit();
	}
	else {
	  location.href="javascript:history.go(0);";	
	}
  }
</script>
  
<div class="container-fluid text-center">    
  <div class="row content">
	<!-- 작업 시작 -->	
	<c:if test="${not empty list}">	
	  <div class="col-md-7 col-md-offset-2"> 
		<h3 style="margin-bottom: 50px;"> ${list.noticetile}</h3>		
		<table class="table table-striped">
		  <tbody>
			<tr>
			  <td style="text-align: center; ">${list.noticecontent }</td>
			</tr>
		  </tbody>
		</table>
	  </div>
	</c:if>

	<c:if test="${not empty list && sessionScope.loginuser.userid == 'admin'}">	
	  <div class="col-md-7 col-md-offset-2"> 
		<form name="noticeFrm">
		  <table class="table table-striped">
			<tbody>
			  <tr>
				<td colspan="4" class="text-center">
				  <input type="button" value="삭제하기" onclick="gosubmit('${list.noticeno}')" class="btn btn-danger">&nbsp;&nbsp;
				  <input type="button" class="btn btn-primary" onclick="location.href='<%= request.getContextPath()%>/customercenter/notice.army'" value="목록보기">&nbsp;&nbsp;
				  <input type="button" value="수정하기" onclick="goUpdate()" class="btn btn-success">&nbsp;&nbsp;
				  <input type="hidden" value='${list.noticeno}' name="noticeno">
				  <input type="hidden" value='${list.noticetile}' name="noticetile">
				  <input type="hidden" value='${list.noticecontent}' name="noticecontent">
				</td>
			  </tr>
			</tbody>
		  </table>
		</form>				
	  </div>
	</c:if>
     <!-- 작업 끝 -->
  </div>
</div>
    
<jsp:include page="/footer.jsp"/>
	
</body>
</html>
    
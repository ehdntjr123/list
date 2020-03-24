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
	
});

</script>

  <div class="container-fluid text-center">    
	<div class="row content">

		<!-- 작업 시작 -->	
				<div class="col-md-6 col-md-offset-2">
			 		<h2 class="text-center">게시글 작성</h2><p>&nbsp;</p>
			 		<form action="<%= request.getContextPath()%>/customercenter/noticeAdminWriteEnd.army" method="post">
			 		  <div class="table table-responsive">
				 		<table class="table">
				 			<tr>
				 				<td class="danger">제목</td>
				 				<td><input type="text" name="noticetile"  class="form-control"></td>
				 			</tr>
				 			<tr>
				 			  <td class="danger">내용</td>
				 			  <td><textarea rows="9" cols="100"  name="noticecontent" class="form-control" ></textarea></td>
				 			</tr>
			
				 			<tr>
				 			  <td colspan="4" class="text-center">
				 			  	 <input type="submit" value="올리기" class="btn btn-danger">&nbsp;&nbsp;
				 			  	 <input type="button" class="btn btn-primary" onclick="location.href='<%= request.getContextPath()%>/customercenter/notice.army'" value="목록보기">
				 			  </td>
				 			</tr>
			
				 		 </table>
				 	   </div>
			 		</form>
			 	</div>
	    <!-- 작업 끝 -->
	</div>
  </div>
    
<jsp:include page="/footer.jsp"/>
	
</body>
</html>
    
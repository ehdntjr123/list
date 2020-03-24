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
	
	th {
		width: 100px;
	}


</style>

<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%= ctxPath %>/js/jquery-3.3.1.min.js"></script>
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
	
});   // $() -----------------------------------------------------------------------



function goSubmit() {
	
	if ($("#inquirycoment").val() == "") {
		alert("답변이 비어 있습니다."); 
		$("#inquirycoment").val(""); 
		$("#inquirycoment").focus(); 
		return; 
	}
	
	frm = document.gofrm; 
	frm.action="<%= request.getContextPath()%>/customercenter/inquiryListAnswerEnd.army"
	frm.method = "POST"; 
	frm.submit(); 
	
} 
</script>

  <div class="container-fluid text-center">    
	<div class="row content">
	
	<!-- 작업 시작  @@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

		<!-- 관리자인 경우  -->
		<c:if test="${sessionScope.loginuser.userid == 'admin'}">
		      	<div class="col-md-5 col-md-offset-3"> 
					<h1 style="margin-bottom: 50px;" class="alert alert-success">문의내역 </h1>
					
					  <table class="table">
                        <tr>
                            <th>제목</th>
                            <td>${member.inquirytitle}</td>
                        </tr>
                         
                        <tr>
                            <th>문의날짜</th>
                            <td>${member.inquiryday}</td>
                        </tr>
 
                        <tr>
                            <th>내용</th>
                            <td>
                                ${member.inquirycontent }
                            </td>
                        </tr>
                         
                        <c:choose>
                        
                            <c:when test="${member.rep=='1' }">
                            <form name="gofrm">
                             <table class="table">
                                <tr>
                                    <th>답변하기</th>
                                    <td>
                                        <textarea id="inquirycoment" class="form-control" style="width:98%;height:200px;" name="inquirycoment" ></textarea>
                                    </td>
                                </tr>
	                           <tr>
                            </table>
                            
	                        	<input type="hidden" value="${member.inquiryno}" name="inquiryno">  &nbsp;&nbsp;&nbsp;
	                       		<input type="button" value="답변달기" onclick="goSubmit();" class="btn btn-success">
                            </form>   
                            </c:when>
                            
                            
                            <c:otherwise>
                               <table class="table">
                                 <tr>
                                   <th>답변 내용</th>
                                   <td>${member.inquirycoment }</td>
                                  </tr>
                               </table>
                            </c:otherwise>                
                        </c:choose>
                              <tfoot>
                            <tr>
                                <td colspan="2" class="text-center" style="text-align: center;">
                                    <a href="<%= request.getContextPath()%>/customercenter/inquiryList.army"  class="btn btn-primary">목록</a>
                                 </td>
                            </tr>
                        </tfoot>
                     </table>
				</div>
		</c:if>
		
		<!-- 관리자가 아닌경우  -->
		
		<c:if test="${sessionScope.loginuser.userid != 'admin'}">
		      	<div class="col-md-5 col-md-offset-3"> 
					<h1 style="margin-bottom: 50px;" class="alert alert-success">나의 문의내역 </h1>
					
					  <table class="table">
                        <tr>
                            <th>제목</th>
                            <td>${member.inquirytitle}</td>
                        </tr>
                         
                        <tr>
                            <th>문의날짜</th>
                            <td>${member.inquiryday}</td>
                        </tr>
 
                        <tr>
                            <th>내용</th>
                            <td>
                                ${member.inquirycontent }
                            </td>
                        </tr>
                         
                  
                           <tr>
                             <th>답변 내용</th>
                             <td>${member.inquirycoment }</td>
                           </tr>
                            	
                          <tfoot>
                            <tr>
                                <td colspan="2" class="text-center" style="text-align: center;">
                                    <a href="<%= request.getContextPath()%>/customercenter/inquiryList.army"  class="btn btn-primary">목록</a>
                                 </td>
                            </tr>
                        </tfoot>
                     </table>
				</div>
		</c:if>
	
	<!-- 작업 끝 @@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->


  	     
	</div>
  </div>
    
 <jsp:include page="/footer.jsp"/>
	
</body>
</html>

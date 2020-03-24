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

  <div class="container-fluid text-center">    
	<div class="row content">
		<div class="col-sm-2 sidenav" style="border:solid 1px gray">
		
	<jsp:include page="/adminPageSide.jsp" />
	
		</div>
	
	<div class="col-sm-9 text-left" style="border:solid 1px gray"> 
       <div class="row content">
			<div class="col-sm-12 text-left">
			
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
                            <form action="/SemiProject/customercenter/inquiryListAnswerEnd.army" method="post" >
                             <table class="table">
                                <tr>
                                    <th>답변하기</th>
                                    <td>
                                        <textarea id="inquirycoment" style="width:98%;height:200px;" name="inquirycoment" ></textarea>
                                    </td>
                                </tr>
	                           <tr>
                            </table>
                            
	                        	<input type="hidden" value="${member.inquiryno}" name="inquiryno">  &nbsp;&nbsp;&nbsp;
	                       		<input type="submit" value="답변달기" class="btn btn-success">
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
                                    <a href="javascript:history.back();"  class="btn btn-primary">목록</a>
                                 </td>
                            </tr>
                        </tfoot>
                     </table>
				</div>
		
		</div>
		</div>
		</div>	
  	     
	</div>
  </div>
    
  <jsp:include page="/footer.jsp"/>
	
</body>
</html>

	
	
	
	
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="/header.jsp"/>

<div class="container-fluid text-center">    
	<div class="row content">
	
	  <div class="col-sm-2 sidenav" style="border:solid 1px gray">
		
		<jsp:include page="/adminPageSide.jsp" />


		
	  </div>
	  
      <div class="col-sm-9 text-left" style="border:solid 1px gray"> 
       <div class="row content">
			<div class="col-sm-12 text-left">
			  <h2 id="myMainfont" style="text-align: center; margin-top: 100px;">관리자페이지</h2>
			  
			</div>  
				
			
		 </div>	
	  </div>	
		  
    </div>
  </div>
    
<jsp:include page="/footer.jsp"/>

</body>
</html>
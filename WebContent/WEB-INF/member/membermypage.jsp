<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="/header.jsp"/>

<script type="text/javascript">

$(function(){
	
	var productname = localStorage.getItem('productname');
	var price = localStorage.getItem('price');
	var pimage = localStorage.getItem('pimage');
	var productnod = localStorage.getItem('productno');
	
	var prodname = productname.split(",");
	var prodprice = price.split(",");
	var prodpimage = pimage.split(",");
	var productno = productnod.split(",");
	
	var html = "";
	
	if(prodname.length < 10){
	
	for(var i=0; i<prodname.length; i++){
		var name = prodname[i];
		var price = prodprice[i];
		var pimage = prodpimage[i];
		var no = productno[i];
		
		if(prodname[i] == ""){
			continue;	
		}
		
		if(i==0){
			html += "<table style='margin: 0 auto;'><tr>";
		}
		
			html += "<td><a href='/SemiProject/prod/prodInfo.army?productno="+no+"' style='color: black;'><img src='<%= ctxPath %>/images/products/"+pimage+"' style='width: 200px; height: 200px;'/>"+
					"<br><span>"+name+"</span></a></td>";
					
		if(i==4){
			html += "</tr><tr>";
		}
		
		if(i==prodname.length-1){
			html += "</tr></table>";
		}
		

	}
	
	}
	
	else{
		
		for(var i=0; i<10; i++){
			var name = prodname[i];
			var price = prodprice[i];
			var pimage = prodpimage[i];
			var no = productno[i];
			
			if(prodname[i] == ""){
				continue;	
			}
			
			if(i==0){
				html += "<table style='margin: 0 auto;'><tr>";
			}
			
				html += "<td><a href='/SemiProject/prod/prodInfo.army?productno="+no+"' style='color: black;'><img src='<%= ctxPath %>/images/products/"+pimage+"' style='width: 200px; height: 200px;'/>"+
						"<br><span>"+name+"</span></a></td>";
						
			if(i==4){
				html += "</tr><tr>";
			}
			
			if(i==9){
				html += "</tr></table>";
			}
			

		}
		
	}
	
	$(".wishlist").append(html);
	
});

</script>

<div class="container-fluid text-center">    
	<div class="row content">
	
	  <div class="col-sm-2 sidenav" style="border:solid 1px gray; border-bottom: none; border-right: none;">
		
		<jsp:include page="/mypageside.jsp" />


		
	  </div>
	  
      <div class="col-sm-9 text-left" style="border:solid 1px gray"> 
       <div class="row content">
			<div class="col-sm-12 text-left">
			  <h2 id="myMainfont" style="text-align: center; margin-top: 100px;">마이페이지</h2>
			  
			</div>  
					
				<jsp:include page="/mypageTitle.jsp" />

					
				<div class="col-sm-12 text-left" id="mypageFirst">
				  <div style="height: 120px;">
					<div id="currentViewFont" style="margin-top: 30px;">최근 본 상품 </div>
				 </div>
				 
						  		<div class="wishlist" style="text-align: center; margin: 0px 30px 30px 0px;">
						  		
								</div>
												
				
				</div>
			
		 </div>	
	  </div>	
		  
    </div>
  </div>
    
<jsp:include page="/footer.jsp"/>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="/header.jsp"/>

<style type="text/css">
  .shopping-cart{
	padding-bottom: 50px;
  }

  .shopping-cart.dark{
	background-color: #f6f6f6;
  }

  .shopping-cart .content{
	box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.075);
	background-color: white;
  }

  .shopping-cart .block-heading{
    padding-top: 50px;
    margin-bottom: 40px;
    text-align: center;
  }

  .shopping-cart .block-heading p{
	text-align: center;
	max-width: 420px;
	margin: auto;
	opacity:0.7;
  }

  .shopping-cart .dark .block-heading p{
	opacity:0.8;
  }

  .shopping-cart .block-heading h1,
  .shopping-cart .block-heading h2,
  .shopping-cart .block-heading h3 {
	margin-bottom:1.2rem;
	color: #3b99e0;
  }

  .shopping-cart .items{
	margin: auto;
  }

  .shopping-cart .items .product{
	margin-bottom: 20px;
	padding-top: 20px;
	padding-bottom: 20px;
  }

  .shopping-cart .items .product .info{
	padding-top: 0px;
	text-align: center;
  }

  .shopping-cart .items .product .info .product-name{
	font-weight: 600;
  }

  .shopping-cart .items .product .info .product-name .product-info{
	font-size: 14px;
	margin-top: 15px;
  }

  .shopping-cart .items .product .info .product-name .product-info .value{
	font-weight: 400;
  }

  .shopping-cart .items .product .info .quantity .quantity-input{
    margin: auto;
    width: 80px;
  }

  .shopping-cart .items .product .info .price{
	margin: 0;
    font-weight: bold;
    font-size: 22px;
  }

  .shopping-cart .summary{
	border-top: 2px solid #5ea4f3;
    background-color: #f7fbff;
    height: 100%;
    padding: 30px;
  }

  .shopping-cart .summary h3{
	text-align: center;
	font-size: 1.3em;
	font-weight: 600;
	padding-top: 20px;
	padding-bottom: 20px;
  }

  .shopping-cart .summary .summary-item:not(:last-of-type){
	padding-bottom: 10px;
	padding-top: 10px;
	border-bottom: 1px solid rgba(0, 0, 0, 0.1);
  }

  .shopping-cart .summary .text{
	font-size: 1em;
	font-weight: 600;
  }

  .shopping-cart .summary .price{
	font-size: 1em;
	float: right;
  }

  .shopping-cart .summary button{
	margin-top: 20px;
  }

  @media (min-width: 768px) {
	.shopping-cart .items .product .info {
	  padding-top: 25px;
	  text-align: left;
	} 
  }

  .shopping-cart .items .product .info .price {
	font-weight: bold;
	font-size: 22px;
	top: 17px; 
  }

  .shopping-cart .items .product .info .quantity {
	text-align: center; 
  }
	
  .shopping-cart .items .product .info .quantity .quantity-input {
	padding: 4px 10px;
	text-align: center; 
  }
	
  /* 장바구니 취소버튼 양식 */
  .my-product-remove{ 
	line-height: 20px;
	text-align: center;
	font-size: 15pt;
	height: 40px;
	margin-top: 30px;	
  }
  
  .plusminus {
  	border: none;
  	background-color: #e6e6e6;
  	color: black;
  }
	
</style>

<script type="text/javascript">

	$(function(){
		
		if (Number(($("#count").val())) <= 1){
			$("#count").val("1");
		}
		
		// 소액 가져오기 \\
		var sum = $("#sumPrice").text().trim();	// 100,000,000
		var strSum = sum.replace(/,/g, '');		// 100000000
		var numSum = Number(strSum);
		var fullSum = "￦ "+sum;					// ￦ 100,000,000
		$("#sumPrice").text(fullSum);
		
		// 배송비 넣기 \\
		var delivery = "";
		if(numSum >= 100000){
			delivery = "0";
		}
		else{
			delivery = "3,000";
		}
		var strDelivery = delivery.replace(/,/g, '');
		var numDelivery = Number(strDelivery);
		var fullDelivery = "￦ "+delivery;
		$("#deliveryPrice").text(fullDelivery);
		
		// 총합 \\
		var allSum = numSum + numDelivery;
		// , 찍는 함수 \\
		$.addComma = function (value) { 
			var data = value + "";
			var arrResult = data.split("");
			var startIndex = arrResult.length - 3; 
			for (var i = startIndex; i > 0; i -= 3) { 
				arrResult.splice(i, 0, ","); 
			} 
			return arrResult.join('');
		}
		
		var fullAllSum = "￦ "+$.addComma(allSum);
		$("#allSumPrice").text(fullAllSum);
		
	});
	
	function goPay(){
		location.href="<%=ctxPath%>/cart/cartPayment.army";
	}
	
	function deleteCart(productno){
		
		var url = "/SemiProject/prod/deleteCartCheck.army?productno="+productno;
		
		window.open(url, "deleteCart", "left=350px, top=100px, width=400px, height=200px");
	}
	
	function plusCount(productno){
		var count = $("#count").val();
		$("#count").val(Number(count)+1);
		location.href="/SemiProject/prod/plusCartCount.army?productno="+productno;
	}
	
	function MinusCount(productno){
		var count = $("#count").val();
		
		if(Number(count) > 1){
		$("#count").val(Number(count)-1);

		location.href="/SemiProject/prod/MinusCartCount.army?productno="+productno;
		}
	}

</script>
  
<c:if test="${sessionScope.loginuser != null and requestScope.cartList != null}">
  <div class="container-fluid text-center">    
	<div class="content">
	  <section class="shopping-cart dark">
		<div class="container">
		  <div class="block-heading">
			<h1 style="color: black; font-weight: bold;">장바구니</h1><!-- 장바구니 제목  -->
		  </div>
		  <div class="content">
			<div class="row">
			  <div class="col-md-12 col-lg-8">
				<div class="items">
				  <div class="product" align="center" style="margin-bottom: 0;"><!-- 장바구니 제품 -->
				  <c:forEach var="cartvoM" items="${requestScope.cartList }">
				  <hr>
					<div class="row">
					  <div class="col-md-3" id="cartProductImage">
						<img class="img-fluid mx-auto d-block image" src="<%=ctxPath %>/images/products/${cartvoM.pimage}" alt="${cartvoM.pimage }" width="100" height="100"><!-- 장바구니내의 제품사진  -->
					  </div>
					  <div class="col-md-9" align="center">
						<div class="info col-md-12">
						  <div class="row col-md-12">
							<div class="col-md-5 product-name">
							 <div class="product-name" style="margin-top: 34px;">
								<a href="<%=ctxPath%>/prod/prodInfo.army?productno=${cartvoM.productno}" id="cartProductName" style="color: #999999; font-size: 16pt;">${cartvoM.productname }</a>
							  </div>
							</div>
							<div class="col-md-3 quantity">
							 수량<br><br>
							  <form name="countFrm">
							  <div style="height: 60px;">
							  <div style="display:inline-block !important;"><button class="plusminus" style="padding: 3px 8px;" type="button" onclick="MinusCount(${cartvoM.productno });">-</button></div>
							  <div style="display:inline-block !important;"><input style="width: 30px; height: 30px;" id="count" type="text" name="count" value ="${cartvoM.cartordercount }" class="form-control quantity-input" readonly/></div>
							  <div style="display:inline-block !important;"><button class="plusminus" style="padding: 3px 6px;" type="button" onclick="plusCount(${cartvoM.productno });">+</button></div>
							  </div>
							  </form>
							</div>
							<div class="col-md-3 col-md-offset-3 price" style="margin-top: 15px;">
							<fmt:formatNumber value="${cartvoM.price}" pattern="###,###,###" /><!-- 제품 가격-->
							</div>
							<div class="col-md-1 btn btn-xs btn-danger my-product-remove" id="deleteBtn" onclick="deleteCart(${cartvoM.productno})" style="width: 20px; height: 35px; margin-top: 35px; padding: 0; vertical-align: middle;">x</div><!-- 제품 삭제-->
							</div>
						  </div>
						</div>
					  </div>
					  <hr>
					  </c:forEach>
					  
					</div>
				  </div>
				</div>
				
				<div class="col-md-12 col-lg-4">
				  <div class="summary" style="border: solid 1px black;"> <!-- 양식으로만 구현함 수식 계산 구현안됨 -->
					<h3>Summary</h3>
					<div class="summary-item" style="text-align: left;"><span class="text">소계</span><span class="price" id="sumPrice"><fmt:formatNumber value="${requestScope.sum}" pattern="###,###,###" /></span></div>
					<div class="summary-item" style="text-align: left;"><span class="text">할인</span><span class="price">￦ 0</span></div>
					<div class="summary-item" style="text-align: left;"><span class="text">배송비</span><span class="price" id="deliveryPrice"></span></div>
					<div class="summary-item" style="text-align: left;"><span class="text">총합</span><span class="price" id="allSumPrice"></span></div>
					<button type="button" class="btn btn-primary btn-lg btn-block" onclick="goPay();" style="background-color: black;">구매하기</button>
				  </div>
				</div>
			  </div> 
			</div>
		  </div>
		</section>
	</div>
  </div>
</c:if>

<c:if test="${sessionScope.loginuser != null and requestScope.cartList == null}">
  <div class="container-fluid text-center">    
	<div class="content">
	  <section class="shopping-cart dark">
		<div class="container">
		  <div class="block-heading">
			<h1 style="color: black; font-weight: bold;">장바구니</h1><!-- 장바구니 제목  -->
		  </div>
		  <div class="content">
			<div class="row">
			  <div class="col-md-12 col-lg-8">
				<div class="items">
				  <div class="product"><!-- 장바구니 제품 -->
					<div class="row">
					  <div class="col-md-3" id="cartProductImage">
					  </div>
					  <div class="col-md-9">
						<div class="info col-md-12">
						  <div class="row col-md-12">
							</div>
						  </div>
						</div>
					  </div>
					</div>
				  </div>
				</div>
				
				<div class="col-md-12 col-lg-4">
				  <div class="summary" style="border-top: solid 1px black;"> <!-- 양식으로만 구현함 수식 계산 구현안됨 -->
					<h3>Summary</h3>
					<div class="summary-item" style="text-align: left;"><span class="text">소계</span><span class="price" id="sumPrice"><fmt:formatNumber value="0" pattern="###,###" /></span></div>
					<div class="summary-item" style="text-align: left;"><span class="text">할인</span><span class="price">￦ 0</span></div>
					<div class="summary-item" style="text-align: left;"><span class="text">배송비</span><span class="price">￦ 0</span></div>
					<div class="summary-item" style="text-align: left;"><span class="text">총합</span><span class="price">￦ 0</span></div>
					<button type="button" class="btn btn-primary btn-lg btn-block" style="background-color: black;">구매하기</button>
				  </div>
				</div>
			  </div> 
			</div>
		  </div>
		  
		</section>
	</div>
  </div>
</c:if>

<c:if test="${sessionScope.loginuser == null and sessionScope.cartList != null}">
  <div class="container-fluid text-center">    
	<div class="content">
	  <section class="shopping-cart dark">
		<div class="container">
		  <div class="block-heading">
			<h1 style="color: black; font-weight: bold;">장바구니</h1><!-- 장바구니 제목  -->
		  </div>
		  <div class="content">
			<div class="row">
			  <div class="col-md-12 col-lg-8">
				<div class="items">
				  <div class="product" align="center" style="margin-bottom: 0;"><!-- 장바구니 제품 -->
				  <c:forEach var="cartvoN" items="${sessionScope.cartList }">
				  <hr>
					<div class="row">
					  <div class="col-md-3" id="cartProductImage">
						<img class="img-fluid mx-auto d-block image" src="<%=ctxPath %>/images/products/${cartvoN.pimage}" alt="${cartvoN.pimage }" width="100" height="100"><!-- 장바구니내의 제품사진  -->
					  </div>
					  <div class="col-md-9" align="center">
						<div class="info col-md-12">
						  <div class="row col-md-12">
							<div class="col-md-4 product-name">
							  <div class="product-name" style="margin-top: 34px;">
								<a href="<%=ctxPath%>/prod/prodInfo.army?productno=${cartvoN.productno}" id="cartProductName" style="color: #999999; font-size: 16pt;">${cartvoN.productname }</a>
							  </div>
							</div>
							<div class="col-md-3 quantity">
							 수량<br><br>
							  <form name="countFrm">
							  <div style="height: 60px;">
							  <div style="display:inline-block !important;"><button class="plusminus" style="padding: 3px 8px;" type="button" onclick="MinusCount(${cartvoN.productno });">-</button></div>
							  <div style="display:inline-block !important;"><input style="width: 30px; height: 30px;" id="count" type="text" name="count" value ="${cartvoN.cartordercount }" class="form-control quantity-input" readonly/></div>
							  <div style="display:inline-block !important;"><button class="plusminus" style="padding: 3px 6px;" type="button" onclick="plusCount(${cartvoN.productno });">+</button></div>
							  </div>
							  </form>
							</div>
							<div class="col-md-3 col-md-offset-3 price" style="margin-top: 15px;">
							<fmt:formatNumber value="${cartvoN.price}" pattern="###,###,###" /><!-- 제품 가격-->
							</div>
							<div class="col-md-1 btn btn-xs btn-danger my-product-remove" id="deleteBtn" onclick="deleteCart(${cartvoN.productno})" style="width: 20px; height: 35px; margin-top: 35px; padding: 0; vertical-align: middle;">x</div><!-- 제품 삭제-->
							</div>
						  </div>
						</div>
					  </div>
					  <hr>
					  </c:forEach>
					  
					</div>
				  </div>
				</div>
				
				<div class="col-md-12 col-lg-4">
				  <div class="summary" style="border-top: solid 2px black;"> <!-- 양식으로만 구현함 수식 계산 구현안됨 -->
					<h3>Summary</h3>
					<div class="summary-item" style="text-align: left;"><span class="text">소계</span><span class="price" id="sumPrice"><fmt:formatNumber value="${sessionScope.sum}" pattern="###,###,###" /></span></div>
					<div class="summary-item" style="text-align: left;"><span class="text">할인</span><span class="price">￦ 0</span></div>
					<div class="summary-item" style="text-align: left;"><span class="text">배송비</span><span class="price" id="deliveryPrice"></span></div>
					<div class="summary-item" style="text-align: left;"><span class="text">총합</span><span class="price" id="allSumPrice"></span></div>
					<button type="button" class="btn btn-primary btn-lg btn-block" onclick="goPay();" style="background-color: black;">구매하기</button>
				  </div>
				</div>
			  </div> 
			</div>
		  </div>
		</section>
	</div>
  </div>
</c:if>

<c:if test="${sessionScope.loginuser == null and sessionScope.cartList == null}">
  <div class="container-fluid text-center">    
	<div class="content">
	  <section class="shopping-cart dark">
		<div class="container">
		  <div class="block-heading">
			<h1 style="color: black; font-weight: bold;">장바구니</h1><!-- 장바구니 제목  -->
		  </div>
		  <div class="content">
			<div class="row">
			  <div class="col-md-12 col-lg-8">
				<div class="items">
				  <div class="product"><!-- 장바구니 제품 -->
					<div class="row">
					  <div class="col-md-3" id="cartProductImage">
					  </div>
					  <div class="col-md-9">
						<div class="info col-md-12">
						  <div class="row col-md-12">
							</div>
						  </div>
						</div>
					  </div>
					</div>
				  </div>
				</div>
				
				<div class="col-md-12 col-lg-4">
				  <div class="summary"> <!-- 양식으로만 구현함 수식 계산 구현안됨 -->
					<h3>Summary</h3>
					<div class="summary-item" style="text-align: left;"><span class="text">소계</span><span class="price" id="sumPrice"><fmt:formatNumber value="0" pattern="###,###" /></span></div>
					<div class="summary-item" style="text-align: left;"><span class="text">할인</span><span class="price">￦ 0</span></div>
					<div class="summary-item" style="text-align: left;"><span class="text">배송비</span><span class="price">￦ 0</span></div>
					<div class="summary-item" style="text-align: left;"><span class="text">총합</span><span class="price">￦ 0</span></div>
					<button type="button" class="btn btn-primary btn-lg btn-block" onclick="goPray();">계산하기</button>
				  </div>
				</div>
			  </div> 
			</div>
		  </div>
		</section>
	</div>
  </div>
</c:if>

<jsp:include page="/footer.jsp"/>
	
</body>
</html>
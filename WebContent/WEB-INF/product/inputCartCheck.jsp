<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	.button {
	  border: none;
	  color: white;
	  padding: 5px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 16px;
	  margin: 20px;
	  border-radius: 12px;
	  width: 100px;
	}
	
	.button:hover{
		cursor: pointer;
	}
	
	.buttonCart {background-color: #4CAF50;} /* green */
	.buttonContinue {background-color: #2196F3;} /* blue */
	.title {text-align: center;	}
	.btnCenter {text-align: center;}
	
</style>

<script type="text/javascript" src="/SemiProject/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	function goCart(){
		self.close();
		opener.location.href="/SemiProject/prod/prodCart.army";
	}
	
	function goContinue(){
		self.close();
	}

</script>

</head>
<body>

<c:if test="${flag eq true }">
	<h2 class="title">장바구니에 추가되었습니다.</h2>
	<div class="btnCenter">
		<button type="button" class="button buttonCart" onclick="goCart();">장바구니로</button>
		<button type="button" class="button buttonContinue" onclick="goContinue();">쇼핑 계속</button>
	</div>
</c:if>

<c:if test="${flag eq false }">
	<h2 class="title">${message }</h2>
	<div class="btnCenter">
		<button type="button" class="button buttonCart" onclick="goCart();">장바구니로</button>
		<button type="button" class="button buttonContinue" onclick="goContinue();">쇼핑 계속</button>
	</div>
</c:if>

</body>
</html>
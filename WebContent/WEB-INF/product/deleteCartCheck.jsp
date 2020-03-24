<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	.buttonYes {background-color: #4CAF50;} /* green */
	.buttonNo {background-color: #f44336;} /* red */
	.title {text-align: center;	}
	.btnCenter {text-align: center;}
	
</style>

<script type="text/javascript" src="/SemiProject/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	function goDelete(productno){
		location.href="/SemiProject/prod/deleteCart.army?productno="+productno;
	//	self.close();
		
	//	opener.location.reload();

	}
	
	function goContinue(){
		self.close();
	}
	
</script>

</head>
<body>
	<h2 class="title"> 삭제하시겠습니까? </h2>
	<div class="btnCenter">
		<button type="button" class="button buttonYes" onclick="goDelete(${productno});">확인</button>
		<button type="button" class="button buttonNo" onclick="goContinue();">취소</button>
	</div>
</body>
</html>
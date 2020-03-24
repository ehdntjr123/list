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
	  margin-left: 140px;
	}
	
	.button:hover{
		cursor: pointer;
	}
	
	.buttonYes {background-color: #4CAF50; /* green */
				text-align: center;
				} 
	.title {text-align: center;	}

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
	<h2 class="title" style="margin-top: 50px;">${message }</h2>
	<button type="button" class="button buttonYes" onclick="goContinue();">확인</button>
</body>
</html>
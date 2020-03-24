<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>시계는 Watch</title>

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/modern-business.css" rel="stylesheet">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

<style type="text/css">

  .sidenav {
	padding-top: 20px;
	background-color: #f1f1f1;
	height: 100%;
  }
  
  footer {
	background-color: #555;
    color: white;
    padding: 15px;
  }
    
  /* Set gray background color and 100% height */
  .sidenav {
    padding-top: 20px;
    background-color: #fff;
    line-height: 300%;
    height: 100%;
  }
  
  .sidemenu {
  	color: #000;
  }
  
  .sidemenu:hover {
	background-color: #ccc;
	color: #fff;
  }
  
  @media screen and (max-width: 767px) {
	.sidenav {
	  height: auto;
	  padding: 15px;
	}
	.row.content {height:auto;} 
  }
  
  div#productview {
	width: 75%;
	height: 100%;
	display: inline-block;
	border: solid 1px blue;
	margin: 20px;
  }
	
  div#option{
	width: 90%;
	height: 400px;
	border: solid 1px black;
	margin-left: 5%;
  }
	
  table#option_table {
	width: 100%;
	height: 100%;
	border: solid 1px #000;
	border-collapse: collapse;
  }
	
  table#option_table td {
	border: solid 1px #000;
	border-collapse: collapse;
	padding: 10px 30px;
	text-align: center;         
  }
	
  div#productInfo {
	width: 100%;
	height: 600px;
	border: solid 1px red;
  }
  
  div#best {
	margin-left: 10%;
	width: 80%;
	height: 250px;
	border: solid 2px blue;
  }
</style>

</head>
<body>
  <!-- Navigation -->
  <nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark fixed-top">
	<div class="container">
	  <a class="navbar-brand" href="templete.jsp" style="font-weight: bold; font-size: 20pt;">Watch</a>
	  <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	  </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="nav navbar-nav navbar-right">
          <li class="nav-item">
      		<a class="nav-link" href="">로그인</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="">회원가입</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="">고객센터</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="">장바구니</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="">검색</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container-fluid text-center">    
	<div class="row content">
	  <div class="col-sm-2 sidenav" style="border:solid 1px gray">
		<p><a class="sidemenu" href="#">남성 시계</a></p>
      	<p><a class="sidemenu" href="#">여성 시계</a></p>
      	<p><a class="sidemenu" href="#">가죽 시계</a></p>
      	<p><a class="sidemenu" href="#">메탈 시계</a></p>
      	<p><a class="sidemenu" href="#">브랜드</a></p>
      	<p><a class="sidemenu" href="#">이벤트</a></p>
	  </div>
      <div class="col-sm-9 text-left" style="border:solid 1px gray"> 
		<div id="productview">
		  <h3 align="center">선택된 카테고리 명</h3>
		  <br/><br/>
		  <div id="option" style="border: solid 1px gray; style="display:inline-block;">
		    <div class="container" style="float: left; width:40%; height: 100%; margin-left: 5%; border: solid 1px pink; padding: 5px;">
			  <div id="myCarousel" class="carousel slide" data-ride="carousel">
				<!-- Indicators -->
				<ol class="carousel-indicators">
				  <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				  <li data-target="#myCarousel" data-slide-to="1"></li>
				  <li data-target="#myCarousel" data-slide-to="2"></li>
				</ol>
				
				<!-- Wrapper for slides -->
				<div class="carousel-inner">
				  <div class="item active">
				    <img src="la.jpg" alt="Los Angeles" style="width:100%;">
				  </div>
				  <div class="item">
				    <img src="chicago.jpg" alt="Chicago" style="width:100%;">
				  </div>
				  <div class="item">
				    <img src="ny.jpg" alt="New york" style="width:100%;">
				  </div>
				</div>
				
				<!-- Left and right controls -->
				<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				  <span class="glyphicon glyphicon-chevron-left"></span>
				  <span class="sr-only">Previous</span>
				</a>
				<a class="right carousel-control" href="#myCarousel" data-slide="next">
				  <span class="glyphicon glyphicon-chevron-right"></span>
				  <span class="sr-only">Next</span>
				</a>
			  </div>
			</div>
			<div style="display:inline-block; width:40%; height: 100%; border: solid 1px pink; margin-left: 5%; padding: 5px;">
	 		  <table id="option_table">
	 			<tr>
	 			  <td>상품명</td>
	 			</tr>
	 			<tr >
	 			  <td>
	 				<label>가격</label>
	 				<span>100,000원</span>
	 			  </td>
	 			</tr>
	 			<tr>
	 			  <td>
	 				<label>배송비</label>
	 				<span>3,000원</span>
	 			  </td>
	 			</tr>
	 			<tr>
	 			  <td>
	 				<label style="margin-right: 10px;">옵션1</label><input />
	 			  </td>
	 			</tr>
	 			<tr>
	 			  <td>
	 				<label style="margin-right: 10px;">옵션2</label><input />
	 			  </td>
	 			</tr>
	 			<tr>
	 			  <td>
	 				<button type="button" style="margin-right: 10px;">장바구니</button>
	 				<button type="button" style="margin-right: 10px;">구매</button>
	 			  </td>
	 			</tr>
	 		  </table>
	 		</div>
		</div>
		<div id="productInfo">
	 		상품정보
		</div>
		<div id="best">
		 		추천상품
		</div>
      </div>
	</div>
  </div>
    
  <!-- Footer -->
  <footer class="py-5 bg-dark">
    <div class="container">
      <p class="m-0 text-center text-white">Copyright &copy; Your Website 2019</p>
    </div>
    <!-- /.container -->
  </footer>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script> 
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
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
<link href="<%=ctxPath%>/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="<%=ctxPath%>/css/modern-business.css" rel="stylesheet">

<link rel="stylesheet" href="<%= ctxPath %>/css/product.css">
<link rel="stylesheet" href="<%= ctxPath %>/css/footer.css">
<link rel="stylesheet" href="<%= ctxPath %>/css/mypage.css">
<link rel="stylesheet" href="<%= ctxPath %>/css/datepicker3.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script type="text/javascript" src="<%= ctxPath %>/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="<%= ctxPath %>/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script src="<%=ctxPath%>/vendor/jquery/jquery.min.js"></script>
<script src="<%=ctxPath%>/vendor/bootstrap/js/bootstrap.bundle.min.js"></script> 
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.js"></script>

<style type="text/css">

  #main_view {
	height: 900px;
  }

  .openBtn {
    background: #f1f1f1;
    border: none;
    padding: 10px 15px;
    font-size: 20px;
    cursor: pointer;
  }

  .openBtn:hover {
    background: #bbb;
  }
  
  .overlay {
  	height: 100%;
  	width: 100%;
  	display: none;
  	position: fixed;
  	z-index: 1;
  	top: 0;
  	left: 0;
  	background-color: rgb(0,0,0);
  	background-color: rgba(0,0,0, 0.9);
  }

  .overlay-content {
  	position: relative;
  	top: 46%;
  	width: 80%;
  	text-align: center;
  	margin-top: 30px;
  	margin: auto;
  }

  .overlay .closebtn {
  	position: absolute;
  	top: 20px;
  	right: 45px;
  	font-size: 60px;
  	cursor: pointer;
  	color: white;
  }

  .overlay .closebtn:hover {
    color: #ccc;
  }

  .overlay input[type=text] {
  	padding: 11.5px;
  	font-size: 17px;
  	border: none;
  	float: left;
  	width: 80%;
  	background: white;
  }

  .overlay input[type=text]:hover {
  	background: #f1f1f1;
  }

  .overlay button {
  	float: left;
  	width: 20%;
  	padding: 15px;
  	background: #ddd;
  	font-size: 17px;
  	border: none;
  	cursor: pointer;
  }

  .overlay button:hover {
    background: #bbb;
  }
  
  #headerCategory {
  	color: #fff;
  }
  
  .nav-link {
  	color: #ffffff !important;
  }
  
  .glyphicon-search:before{
  	color: white;
  }
  
  .nav-item {
  	font-size: 10pt;
  }
  
  ul.navbar-nav li:hover {
  	font-weight: bold;
  	font-size: 11pt;
  }

</style>

<script type="text/javascript">
   
   $(function(){
	   
	   
	   
      // 검색
      $("#searchBtn").click(function(search){
    	  
         var search = $("#search").val();
         
         location.href="<%=ctxPath%>/prod/prodList.army?search="+search;
      });
      
      $("#logout").click(function(){
    	  
    	  localStorage.removeItem('productno');
    	  localStorage.removeItem('price');
    	  localStorage.removeItem('productname');
    	  localStorage.removeItem('pimage');
    	  
      });
      
   });

      // 검색 버튼 \\
      function openSearch() {
        document.getElementById("myOverlay").style.display = "block";
      }

      //검색창 닫기
      function closeSearch() {
        document.getElementById("myOverlay").style.display = "none";
      }
</script>

</head>
<body style="padding-top: 0;">
  <!-- Navigation -->
<nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark fixed-top" style="margin-bottom: 0; background-color: black; border-radius: 0;">
  <div class="container">
    <a class="navbar-brand" href="/SemiProject/index.army" style="font-size: 24pt; font-weight: bold;">Watch</a>
    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
     
    <div class="collapse navbar-collapse">
    <ul class="navbar-nav navbar-left" id="headerCategory">
	  <%@ include file="/WEB-INF/product/categoryList.jsp" %>
	  </ul>
    </div>
     
	<div class="collapse navbar-collapse" id="navbarResponsive">
      <ul class="navbar-nav navbar-right">
        <c:if test="${sessionScope.loginuser == null}">
          <li class="nav-item">
            <a class="nav-link" href="<%= request.getContextPath() %>/member/loginStart.army">로그인</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="<%= request.getContextPath() %>/member/memberFormStart.army">회원가입</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="<%= request.getContextPath() %>/customercenter/notice.army">고객센터</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="<%=ctxPath %>/prod/prodCart.army">장바구니</a>
          </li>
          <li class="nav-item" style="height:40px; margin-top: 3px;">
            <span class="glyphicon glyphicon-search openBtn" id="productSearch" onclick="openSearch();" style="background-color: #343a40;"></span>
          </li>
        </c:if>
        
        <c:if test="${sessionScope.loginuser != null && sessionScope.loginuser.userid == 'admin'}">
          <li class="nav-item active">
            <a class="nav-link" id="logout" href="<%= request.getContextPath() %>/member/loginout.army">로그아웃</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="<%= request.getContextPath() %>/admin/adminpage.army">관리자페이지</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="<%= request.getContextPath() %>/customercenter/notice.army">고객센터</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="<%=ctxPath %>/prod/prodCart.army">장바구니</a>
          </li>
          <li class="nav-item">
            <span class="glyphicon glyphicon-search openBtn" id="productSearch" onclick="openSearch();">검색</span>
          </li>
        </c:if>  
          
        <c:if test="${sessionScope.loginuser != null && sessionScope.loginuser.userid != 'admin'}">
          <li class="nav-item active">
            <a class="nav-link" id="logout" href="<%= request.getContextPath() %>/member/loginout.army">로그아웃</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="<%= request.getContextPath() %>/member/membermypage.army">마이페이지</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="<%= request.getContextPath() %>/customercenter/notice.army">고객센터</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="<%=ctxPath %>/prod/prodCart.army">장바구니</a>
          </li>
          <li class="nav-item" style="height:40px; margin-top: 3px;">
            <span class="glyphicon glyphicon-search openBtn" id="productSearch" onclick="openSearch();" style="background-color: #343a40;"></span>
          </li>
        </c:if>  
      </ul>
    </div>
  </div>
  
  <div id="myOverlay" class="overlay">
    <span class="closebtn" onclick="closeSearch()" title="Close Overlay">×</span>
    <div class="overlay-content">
      <form name="searchFrm">
        <input type="text" placeholder="Search.." name="search" id="search">
        <!-- 검색버튼 -->
        <button id="searchBtn" type="button" onclick="goSearch()"><i class="fa fa-search"></i></button>
      </form>
    </div>
  </div>
    
</nav>
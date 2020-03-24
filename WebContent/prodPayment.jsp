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

<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>


<style type="text/css">	
  .col-25 {
	-ms-flex: 25%; /* IE10 */
	flex: 25%;
  }
	
  .col-50 {
	-ms-flex: 50%; /* IE10 */
	flex: 50%;
  }
	
  .col-75 {
	-ms-flex: 75%; /* IE10 */
	flex: 75%;
  }
	
  .col-25,
  .col-50,
  .col-75 {
	padding: 0 16px;
  }
	
  .sub{
	text-align: center;
  }
	
  .main_container {
	background-color: #f2f2f2;
	padding: 5px 20px 15px 20px;
	border: 1px solid lightgrey;
	border-radius: 3px;
  }
	
  input[type=text] {
	width: 100%;
	margin-bottom: 20px;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 3px;
  }
	
  label {
	margin-bottom: 10px;
	display: block;
  }
	
  .icon-container {
	margin-bottom: 20px;
	padding: 7px 0;
	font-size: 24px;
  }
	
  .btn {
	background-color: BLACK;
	color: white;
	padding: 12px;
	margin: 10px 0;
	border: none;
	width: 50%;
	border-radius: 3px;
	cursor: pointer;
	font-size: 17px;
	text-align: center;
	float:none; 
	margin:0 auto;
	align-content: center;
  }
	
  .btn:hover {
	background-color: #gray;
  }
	
  span.price {
	float: right;
	color: grey;
  }
	
  /* Responsive layout - when the screen is less than 800px wide, make the two columns stack on top of each other instead of next to each other (and change the direction - make the "cart" column go on top) */
  @media (max-width: 800px) {
    .row {
	  flex-direction: column-reverse;
    }  
    .col-25 {
	  margin-bottom: 20px;
    }
  }
	
	
  /* 커스텀 radio 선택창을 위한 css */
  /* The container */
  .radio {
    display: block;
    position: relative;
  	margin-top: 35px;
  	text-align:center;
  	padding-left: 35px;
  	cursor: pointer;
  	font-size: 22px;
  	width: 70%;
 /* -webkit-user-select: none;
  	-moz-user-select: none;
  	-ms-user-select: none;
    user-select: none; */
  }

  /* 기본 라디오 버튼 숨기기 */
  .radio input  {
  	position: absolute;
  	opacity: 0;
  	cursor: pointer;
  }

  /* 커스텀 라디오 버튼 만들기 */
  .checkmark {
  	position: absolute;
  	top: 0;
  	left: 0;
  	height: 25px;
  	width: 25px;
  	background-color: #eee;
  	border-radius: 50%;
  	margin-top: 12px;
  	margin-left: 25px;
  }

  /* 마우스 올렸을때 회색 배경 출력 */
  .main_container:hover input ~ .checkmark {
  	background-color: #ccc;
  }

  /* 라디오 버튼 체크 했을때 파란 배경 출력 */
  main_container input:checked ~ .checkmark {
  	background-color: #2196F3;
  }

  /* 라디오 표시창 만들기-체크 되지 않았을때 숨겨져 있음 */
  .checkmark:after {
  	content: "";
  	position: absolute;
  	display: none;
  }

  /* 라디오 표시창 선택했을때 보여주기  */
  .main_container input:checked ~ .checkmark:after {
  	display: block;
  }

  /* 라디오 표시창 모양 서식 - 현재 원형 */
  .main_container .checkmark:after {
 	top: 9px;
	left: 9px;
	width: 8px;
	height: 8px;
	border-radius: 50%;
	background: white;
  }
  
  /* .sameadr{  		// 용도폐기
	margin-left: 50px; 
  } */
</style>

</head>
<body>
  <!-- Navigation -->
  <nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark fixed-top">
	<div class="container">
	  <a class="navbar-brand" href="temp.jsp" style="font-size: 20pt; font-weight: bold;">Watch</a>
	  <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	  </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="nav navbar-nav navbar-right">
          <li class="nav-item active">
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
	<div class="row content main_container">
	  <div class="col-md-12 col-lg-9" style="margin-left: 15%;">
	    <form action="">
          <div class="row">
            <div class="col-md-12 col-lg-6">
              <h3 class="sub">배송지 주소</h3>
	          <label for="userName"><i class="fa fa-user"></i> 이름</label>
	          <input type="text" id="fa fa-envelope" name="userName" placeholder="홍길동">
	          <label for="email"><i class="fa fa-envelope""></i> 이메일</label>
	          <input type="text" id="email" name="email" placeholder="hongkd@example.com">
	          <label for="address1"><i class="fa fa-address-card-o"></i> 주소</label>
	          <input type="text" id="address1" name="address1" placeholder="서울시 중구 경복궁">
	          <label for="address2"><i class="fa fa-institution"></i> 상세주소</label>
	          <input type="text" id="address2" name="address2" placeholder="107동 102호">

              <div class="row">
                <div class="col-md-12 col-lg-6">
                  <label for="state">전화번호</label>
                  <input type="text" id="tel" name="tel" placeholder="010-1234-5678">
              	</div>
              	<div class="col-md-12 col-lg-6">
                  <label for="zip">우편번호</label>
                  <input type="text" id="zip" name="zip" placeholder="10101">
              	</div>
              </div>
          	</div>

            <div class="col-md-12 col-lg-6">
              <h3 class="sub">결제방법</h3>
              <!-- radio 선택을 위한 내용 구현 -->
			  <label class="main_container radio">신용/체크카드
			    <input type="radio" checked="checked" name="radio" class="card">
			    <span class="checkmark"></span>
			  </label>
			  <label class="main_container radio">삼성페이
			    <input type="radio" name="radio" class="ssPay">
			    <span class="checkmark"></span>
			  </label>
			  <label class="main_container radio">무통장입금
			    <input type="radio" name="radio" class="noAccount">
			    <span class="checkmark"></span>
			  </label>
			  <label class="main_container radio">휴대폰 결제
			    <input type="radio" name="radio" class="mobilePayment">
			    <span class="checkmark"></span>
			  </label>
            </div>
          </div>
        </form>
      </div>
      <div style="display: inline-block; width: 50%; margin-left:25%; margin-top: 15px; text-align:center; align-content: center;" >
        <input type="submit" value="결제 진행 하기" class="btn">
 	  </div>
	</div>
  </div>
    
  <!-- Footer -->
  <footer class="py-5 bg-white">
    <div>
      <hr style="border: solid 1px black"><br/>
	  <div>
	    <div class="shopinfo">
		  <h2><a href="#">Watch</a></h2>
			<ul class="link">
			  <li><a href="#">이용안내</a></li>
			  <li><a href="#">이용약관</a></li>
			  <li><a href="#">개인정보처리방침</a></li>
			  <li><a href="#">구매안전서비스</a></li>
			</ul>
			<address class="info">
			  <span>(주)Watch</span>
			  <span>서울특별시 강남구</span>
			  <span>FAX 02-111-1111</span>
			  <span>대표자 ooo</span>
			  <span>개인정보보호책임자 ooo</span>
			  <a href="#">aaa@.aa.aa</a>
			  <br>
			  <span>
				사업자등록번호
			  	<a href="#">111-11-11111</a>
			  </span>
			  <span>통신판매업신고 1111-서울서초-11111</span>
			  <span class="escrow">
			    <a href="#">에스크로서비스 가입 확인</a>
			  </span>
			</address>
			<p class="copyright">                                                   
				COPYRIGHT(C) 2019 WATCH KOREA LTD. ALL RIGHTS RESERVED.  
			</p>
		</div>
	  </div>
    </div>
    <!-- /.container -->
  </footer>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script> 
	
</body>
</html>
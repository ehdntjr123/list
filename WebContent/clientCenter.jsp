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
<link rel="stylesheet" href="css/clientCenter.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">

<style type="text/css">


</style>

<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%= ctxPath %>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">


</script>

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
   <div class="row content">
      <div class="col-md-6 col-md-offset-3 bb">
      <div class="h2 mx-auto text-center mt-md-6">고객센터</div>
            
            <div class="area-search h3 mx-auto text-center mt-md-6 " >
               <input type="text" placeholder="궁금하신 내용이 있으신가요?" class="col-sm-11">
               <i class="fa fa-search"></i>
            </div>

            <ul class="horizontal-list">
               <li><strong>전체</strong></li>
               <li><strong>상품문의</strong></li>
               <li><strong>주문/배송</strong></li>
               <li><strong>반품/교환</strong></li>
               <li><strong>쿠폰/마일리지</strong></li>
               <li><strong>매장관련</strong></li>
               <li><strong>기타</strong></li>
            </ul>
            
            <div class="row content">
             <div class="col-md-4">
               <div class="card left">
                  <div class="describe">               
                     <img src="${pageContext.request.contextPath}/images/guide-icon.png">
                     <div class="describe-text">
                        <p class="h3 text-left"><strong>쇼핑 가이드 ></strong></p>
                        <br>
                        <p class="text-left">지오다노쇼핑을 더욱 편리하게 할 수 있도록 도와드립니다.</p>
                     </div>
                  </div>
                  </div>
                  </div>
                  
                   <div class="col-md-4">
               <div class="card left">
                  <div class="describe">               
                     <img src="${pageContext.request.contextPath}/images/qna-icon.png">
                     <div class="describe-text">
                        <p class="h3 text-left"><strong>Q & A</strong></p>
                        <br>
                        <p class="text-left">궁금하신 사항을 남겨주시면 상담원이 처리해 드립니다.</p>
                     </div>
                  </div>
                  </div>
                  </div>
                  
                   <div class="col-md-4">
               <div class="card left dark">
                  <div class="describe">
                     <div class="describe-text">
                        <p class="h3 text-left mb-md-8">Call Center</p>
                        <br>
                        <p class="h2 text-left">080-934-3000</p>
                        <br>
                        <p class="text-left">평일 10:00 - 17:00 / 점심시간 12:00 - 13:00</p>
                        <p class="text-left">공휴일,토요일,일요일 휴무 (임시 휴일 및 휴무 시에는 미리 공지하여 드립니다.)</p>
                     </div>
                  </div>
               </div>
               </div>

            </div> <!-- .other-card END -->
            
            <div>
               <div class="h3 mx-auto" style="height : 30px; border-bottom: 1px solid; padding-bottom:40px;">
                  <span class="h4 col-sm-9 text-left">공지 사항</span>
                  <span class="h4 col-sm-3 text-right">전체 보기 ></span>
               </div>
            
               <table class="table">
                  <thead>
                     <tr>
                        <td style="width:20%;"></td>
                        <td style="width:60%;"></td>
                        <td style="width:20%;"></td>
                     </tr>
                  </thead>
                  <tbody>
                     <tr>
                          <td><i class="fa fa-volume-up"></i></td>
                          <td class="text-left">교환/환불 관련</td>
                          <td>2019-11-12</td>
                       </tr> 
                    
                       <tr>
                          <td><i class="fa fa-volume-up"></i></td>
                          <td class="text-left">080 번호 수신거부를 확인해주세요</td>
                          <td>2019-11-12</td>
                     </tr>
                    
                       <tr>
                          <td><i class="fa fa-volume-up"></i></td>
                          <td class="text-left">연락처 정보를 업데이트 해주세요</td>
                          <td>2019-11-12</td>
                     </tr>
                    
                     <tr>
                        <td><i class="fa fa-volume-up"></i></td>
                          <td class="text-left">페이코 결제 안내</td>
                          <td>2019-11-12</td>
                     </tr>
                     
                     <tr>
                        <td><i class="fa fa-volume-up"></i></td>
                          <td class="text-left">네이버 아이디 로그인 회원 안내</td>
                          <td>2019-11-12</td>
                     </tr>
                  </tbody>
               </table>
            </div>
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
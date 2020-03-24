<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String ctxPath = request.getContextPath();
%>
<jsp:include page="/header.jsp"/>
<style type="text/css">

  div#best {
   margin-left: 10%;
   width: 80%;
   height: 250px;
  }
  
  div#navbar {
     height: 100px;
     max-width: 100%;
     width: 100%;
     border: solid 1px #e6e6e6;
     border-top: solid 3px #666666;
     padding: 0;
  }
  
  div#navbar ul li {
     display: inline-block;
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
    padding: 15px;
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
  
 #sidemenu{
     list-style-type: none;
     padding-right: 20px;
  }
  
  #sidemenu li {
    text-align: left;
     margin-bottom: 40px;
     margin-left: 80px;
  }
  
  #sidemenu li a:hover {
     text-decoration: none;
     background-color: none;
     color: black;
  }
  
  input {
     text-align: center;
     margin-top: 0;
     width: 50px;
     height: 50px;
     background-color: #f2f2f2;
     border: none;
     font-size: 16pt;
  }
  
  .btn {
  border: 2px solid black;
  background-color: white;
  color: black;
  padding: 14px 28px;
  font-size: 16px;
  cursor: pointer;
  border-color: #e7e7e7;
}

#buyBtn:hover {
  background: black;
  color: white;
}

#cartBtn:hover {
   background: #e7e7e7;
   color: black;
}

#wishBtn:hover {
   background: #e7e7e7;
   color: black;
}

.menubtn {
   width: 32%; 
   height: 100%; 
   margin:0; 
   padding:0; 
   display:inline-block;
   text-align: center;
   padding-top: 40px;
   font-size: 14pt;
   font-weight: bold;
}

.menubtn:hover {
   cursor: pointer;
}

  
  .checked {
  color: orange;
}

#card_benefits {position:relative;}
#card_benefits .btn_benefits {display:inline-block;*display:inline;*zoom:1;min-height:17px;padding-left:31px;background:url('/SkinImg/button/card_benefits.png') no-repeat left center;line-height:17px;cursor:pointer;}
#card_benefits .card_layer {display:none;position:absolute;left:0;z-index:100;width:100%;margin-top:4px;}
#card_benefits .card_layer .inner_box {border:1px solid #000;background:#fff;}
#card_benefits .card_layer .tab_card {text-align:center;padding:10px 0 0}
#card_benefits .card_layer .tab_card h3 {margin:0 0 10px}
#card_benefits .card_layer .cnt_card {padding:5px 20px 10px;}
#card_benefits .card_layer .cnt_card ul li {float:none !important;}
#card_benefits .card_layer .cnt_card .card_list {width:100%;}
#card_benefits .card_layer .cnt_card .card_list li {display:block;overflow:hidden;padding:5px 0 8px;border-bottom:1px solid #e9e9e9;color:#000;font-size:12px;line-height:12px;}
#card_benefits .card_layer .cnt_card .card_list li:after {display:block;clear:both;content:'';}
#card_benefits .card_layer .cnt_card .card_list li span {color:inherit;font-size:inherit;}
#card_benefits .card_layer .cnt_card .card_list li .card_name {float:left;width:69px;margin-top:4px;}
#card_benefits .card_layer .cnt_card .card_list li .pay_period {display:block;margin-top:4px;padding-left:69px;text-align:right;}
#card_benefits .card_layer .cnt_card .card_list li .pay_period.first {margin:0;}
#card_benefits .card_layer .cnt_card .card_msg {padding-top:12px;text-align:center}
  
</style>

<script type="text/javascript">

   window.onload = function(){
      var currentday = new Date();
      var month = currentday.getMonth() +1;
      var day = currentday.getDate();
      
      document.getElementById("day").innerText = month+"/"+(day+2);
   }
   

  $(function(){
     $(".card_layer").hide();
     
    var productname = localStorage.getItem('productname');
    var price = localStorage.getItem('price');
    var pimage = localStorage.getItem('pimage');
    var productno = localStorage.getItem('productno');
    
 	if(${sessionScope.loginuser != null}){
     if(productname == null){
        localStorage.setItem('productname', $("#productName").val()+",");
        localStorage.setItem('price', $("#prodPrice").val()+",");
        localStorage.setItem('pimage', $("#pimage").val()+",");
        localStorage.setItem('productno', $("#productno").val()+",");
     }
     
     else{
        var prodnameArr = productname.split(",");
        
        var cnt = 0;
        
        for(var i=0; i<prodnameArr.length; i++){
           if(prodnameArr[i] == $("#productName").val()){
              cnt++;
              break;
           }
        }
       
        if(cnt == 0){
           localStorage.setItem('productname', $("#productName").val()+","+productname);
           localStorage.setItem('price', $("#prodPrice").val()+","+price);
           localStorage.setItem('pimage', $("#pimage").val()+","+pimage);
           localStorage.setItem('productno', $("#productno").val()+","+productno); 
        }
        
     }
 	}
     
   
   var nav = $("#navbar").offset().top;
   var header = $("#header").offset().top;
   
   $(window).scroll( function(){    
     if( pageYOffset > nav ){
      $("#menuBar").css("position", "fixed");
      $("#menuBar").css("top", "0");
        $("#menuBar").css("margin","0");
        $("#menuBar").css("width", "73.1%");
      $("#navbar").css("position","relative");   
     }
     else {
        $("#header1").css("display","");
      $("#menuBar").css("position", "relative");
      $("#menuBar").css("width","");
     }
   });
   
   $("#topBtn").click(function(){
     $('html').scrollTop('0');
   });
   
   // 검색 \\
   $("#searchBtn").click(function(search){
     var search = $("#search").val();
     location.href="<%=ctxPath%>/prod/prodList.army?search="+search;
   });
   
  });

  // 메뉴 바(상품상세, 상품평, 배송및반품)
  function fnMove1(){
      var offset = $("#productInfo1 img").offset();
      $('html').scrollTop(offset.top);
  }
   
  function fnMove2(){
      var offset = $("#productInfo3").offset();
      $('html').scrollTop(offset.top-70);
  }
   
  function fnMove3(){
      var offset = $("#review").offset();
      $('html').scrollTop(offset.top-70);
  }
   
  function goBuy(productno, price){
	  location.href="/SemiProject/cart/cartPayment.army?productno="+productno+"&price="+price;
  }
   
  // 검색 버튼 \\
  function openSearch() {
   document.getElementById("myOverlay").style.display = "block";
  }

  function closeSearch() {
   document.getElementById("myOverlay").style.display = "none";
  }
   
  function goCartCheck(productno){
   var url = "/SemiProject/prod/inputCartCheck.army?productno="+productno;   
   window.open(url, "inputCartCheck", "left=350px, top=100px, width=650px, height=200px")
  }
  
  function goWish(productno){
   var url = "/SemiProject/prod/inputWish.army?productno="+productno;   
   window.open(url, "inputWish", "left=350px, top=100px, width=650px, height=200px")
  }
  
  function card_layer(){
        var x = document.getElementById('card_layer');
        if (x.style.display === "none") {
          x.style.display = "block";
        } else {
          x.style.display = "none";
        }
      }

</script>



<form name="prodFrm">
  <div class="container-fluid text-center">    
   <div class="row content">
     <div class="col-sm-2 sidenav" align="right" style="padding-top: 2%; font-size: 14pt;">
   <h1 style="margin-bottom: 40%; margin-right: 10%;">Category</h1>
   <ul id="sidemenu">
     <%@ include file="/WEB-INF/product/categoryList.jsp" %>
   </ul> 
   </div>
      <div class="col-sm-9 text-left" style="border-left: solid 1px black; margin-top: 10px;"> 
      <div id="header" style="margin-top: 50px;">
      <div id="header1">
        <br/><br/>
        <div style="height: 400px; margin-bottom: 100px;">
          <div class="container" style="float: left; width:40%; height: 100%; margin-left: 5%; padding: 5px;">
            
            <c:if test="${product != null }">
              <div>
                <img src="<%=ctxPath %>/images/products/${product.pimage}" alt="${product.pimage}" style="width:400px; height: 400px;"><input type="hidden" id="pimage" value="${product.pimage }" />
              </div>
              </c:if>
              <c:if test="${product == null }">
              <span> 없습니다 </span>
              </c:if>
         </div>
         
         <div style="display:inline-block; width:40%; height: 100%; margin-left: 5%; padding: 5px;">
             <div style="border-bottom: solid 1px gray; margin-bottom: 30px; padding-bottom: 10px;">
                  <input type="hidden" id="productName" name="prodName" value="${product.productname }"/>
                  <span style="font-size: 18pt; font-weight: bold;">[${product.brand }] ${product.productname }</span>
                  <input type="hidden" id="productno" name="productno" value="${product.productno }"/>
             </div>
            <div style="border-bottom: solid 1px #e6e6e6; margin-bottom: 10px;">
                <input type="hidden" name="prodPrice" id="prodPrice" value="${product.price }"/>
                <label style="margin-right: 30px; font-weight:normal; font-size: 9pt;"> price</label>
                <span style="font-size: 14pt; font-weight: bold;"><fmt:formatNumber value="${product.price }" pattern="###,###,###" /> 원</span><br><br>
             </div>
             <div style="border-bottom: solid 1px #e6e6e6; height:50px;">
                <span style="font-size: 8pt;"> 배송비 3,000원</span><br>
                <span style="font-size: 8pt;"> <span id="day"></span> 도착 예정</span>
            </div>
            <div id="card_benefits" style="height: 50px; border-bottom: solid 1px #e6e6e6;">
                              <!-- 혜택안내 버튼 -->
                              <span id="cardBtn" class="btn_benefits" onclick="card_layer();" style="padding:0; margin-top:12px;"><img src="https://previews.123rf.com/images/jovanas/jovanas1612/jovanas161200273/66890604-%EC%8B%A0%EC%9A%A9-%EC%B9%B4%EB%93%9C-%EC%95%84%EC%9D%B4%EC%BD%98.jpg" width="30" height="30"/>카드 혜택 안내</span>
                              <!-- //혜택안내 버튼 -->
                              <!-- 혜택안내 레이어 -->
                              <div id="card_layer" class="card_layer">
                                 <div class="inner_box">
                                    <div class="tab_card">
                                       <h3>무이자 할부 안내</h3>
                                    </div>
                                    <div class="cnt_card cnt_card0">
                                       <ul class="card_list" style="list-style-type: none;">
                                          <li>
                                             <span class="card_name">씨티카드</span>
                                             <span class="pay_period">2~6 개월 (5만원 이상)</span>
                                          </li>
                                          <li>
                                             <span class="card_name">하나카드</span>
                                             <span class="pay_period">2~3 개월 (5만원 이상)</span>
                                          </li>
                                          <li>
                                             <span class="card_name">삼성카드</span>
                                             <span class="pay_period">2~6 개월 (5만원 이상)</span>
                                          </li>
                                          <li>
                                             <span class="card_name">신한카드</span>
                                             <span class="pay_period">2~6 개월 (5만원 이상)</span>
                                          </li>
                                          <li>
                                             <span class="card_name">KB국민카드</span>
                                             <span class="pay_period">2~5 개월 (5만원 이상)</span>
                                          </li>
                                          <li>
                                             <span class="card_name">현대카드</span>
                                             <span class="pay_period">2~5 개월 (5만원 이상)</span>
                                          </li>
                                          <li>
                                             <span class="card_name">비씨카드</span>
                                             <span class="pay_period">2~6 개월 (5만원 이상)</span>
                                          </li>   
                                          <li>
                                             <span class="card_name">NH농협카드</span>
                                             <span class="pay_period">2~6 개월 (5만원 이상)</span>
                                          </li>                                                        
                                       </ul>
                                       <p class="card_msg">
                                          비씨카드, NH농협카드 회원은 <br/>
                                          직접 카드사 ARS 신청시 <br/>
                                          무이자 및 부분 무이자 할부가 가능합니다.<br/>
                                          법인/체크/선불/기프트/은행계열카드 제외
                                       </p>
                                    </div>

                                 </div>
                              </div>
                              <!-- //혜택안내 레이어 -->
                           </div>
            <div style="border-bottom: solid 1px #e6e6e6; height: 50px;">
               <span style="margin-right: 15px; font-size: 8pt">수량</span><input type="text" value="1" readonly/>
            </div>
            <div style="margin-top: 30px;">
               <button type="button" class="btn" id="buyBtn" style="margin-right: 10px;" onclick="goBuy(${product.productno}, ${product.price})">구매하기</button>
               <button type="button" class="btn" id="cartBtn" style="margin-right: 10px;" onclick="goCartCheck(${product.productno})">장바구니</button>
                  <button type="button" class="btn" id="wishBtn" style="margin-right: 10px;" onclick="goWish(${product.productno})">찜</button>
             </div>   
          </div>
      </div>
      </div>
      <div id="menuBar" style="z-index: 10; background-color: white;">
       <div class="col-sm-9" id="navbar" align="center">
            <div class="menubtn" style="border-right: solid 1px #e6e6e6;" onclick="fnMove1();">상품 상세</div>
            <div class="menubtn" style="border-right: solid 1px #e6e6e6;" onclick="fnMove2();">배송 및 반품</div>
            <div class="menubtn" onclick="fnMove3();">상품 리뷰</div>
      </div>
      </div>
      </div>
      <c:forEach var="imgVO" items="${prodimgList }" varStatus="status">
      <div id="productInfo${status.count }">
          <img src="/SemiProject/images/products/${imgVO.imagfilename }" alt="${imgVO.imagfilename }" style="width:100%;"/>
      </div>
      </c:forEach>
      
      <div id="review">
      <hr style="border: solid 1px black;">
      <h3 align="center" style="font-weight: bold;">상품평</h3>
      <br>
      <hr>
         <c:if test="${reviewList == null }">
         <table id="reviewTbl" class="table">
         <tr>
            <th>글번호</th>
            <th>평점</th>
            <th>글제목</th>
            <th>작성자</th>
            <th>작성일</th>
         </tr>
         <tr>
            <td colspan='5'>리뷰가 없습니다.</td>
         </tr>
         </table>
         </c:if>
         <c:if test="${reviewList != null }">
         <table id="reviewTbl" class="table">
         <tr>
            <th>글번호</th>
            <th>평점</th>
            <th>글제목</th>
            <th>작성자</th>
            <th>작성일</th>
         </tr>
         <c:forEach var="reviewvo" items="${reviewList }" varStatus="status">
         <tr>
            <td>${status.count }</td>
            <td>
            <c:if test="${reviewvo.score eq 1 }">
				<span class="fa fa-star checked"></span>
				<span class="fa fa-star"></span>
				<span class="fa fa-star"></span>
				<span class="fa fa-star"></span>
				<span class="fa fa-star"></span>
				</c:if>
				<c:if test="${reviewvo.score eq 2 }">
				<span class="fa fa-star checked"></span>
				<span class="fa fa-star checked"></span>
				<span class="fa fa-star"></span>
				<span class="fa fa-star"></span>
				<span class="fa fa-star"></span>
				</c:if>
				<c:if test="${reviewvo.score eq 3 }">
				<span class="fa fa-star checked"></span>
				<span class="fa fa-star checked"></span>
				<span class="fa fa-star checked"></span>
				<span class="fa fa-star"></span>
				<span class="fa fa-star"></span>
				</c:if>
				<c:if test="${reviewvo.score eq 4 }">
				<span class="fa fa-star checked"></span>
				<span class="fa fa-star checked"></span>
				<span class="fa fa-star checked"></span>
				<span class="fa fa-star checked"></span>
				<span class="fa fa-star"></span>
				</c:if>
				<c:if test="${reviewvo.score eq 5 }">
				<span class="fa fa-star checked"></span>
				<span class="fa fa-star checked"></span>
				<span class="fa fa-star checked"></span>
				<span class="fa fa-star checked"></span>
				<span class="fa fa-star checked"></span>
				</c:if>
				</td>
            <td>${reviewvo.reviewtitle }</td>
            <td>${reviewvo.fk_userid }</td>
            <td>${reviewvo.reviewwriteday }</td>
         </tr>
         </c:forEach>
         </table>
         </c:if>
      </div>
      </div>
   </div>
  </div>
  </form>
    
<jsp:include page="/footer.jsp"/>

</body>
</html>
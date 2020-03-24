<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
   String ctxPath = request.getContextPath();
%>

<style>


#myVideo {
  position: relative;
  width: 100%;
  min-height: 100%;

}

* {
  box-sizing: border-box;
}


.column {
  float: left;
  width: 25%;
  padding: 10px;
  height: 300px;
}


.row:after {
  content: "";
  display: table;
  clear: both;
}

</style>

<jsp:include page="/header2.jsp"/>


  
<!-- body -->   
<div class="container-fluid text-center">       
  <div class="row content">   
    <div class="col-sm-12 sidenav" style="border:solid 1px gray; min-height: 990px; height: auto; border-bottom: none; padding: 0; margin-bottom: 50px;">   
      <video autoplay muted loop id="myVideo">   
  <source src="  https://www.tissotwatches.com/media/Videos/Tissot_GentlemanPowermatic80_Silicium.mp4" type="video/mp4">   
</video>   
    </div>   

    <!--body2  -->   
       <div class="col-sm-5 col-sm-offset-1" style=" height: 600px;">   
          <a href="http://localhost:9090/SemiProject/prod/prodList.army?code=1"><img src="images/남자.jpg" alt="남자 시계" style="width:100%; height: 600px;"></a>   
             
        </div>   
           
        <div class="col-sm-5 sidenav" style=" height: 600px;" >   
        <div class="category-push__products">   
        <table style="width: 100%; height: 100%; margin: 0 auto;">
           <tr>
           <c:forEach var="view" items="${product }" begin="0" end="1">   
           <td align="center">
        <div class="category-push__product-item" style="display:inline-block;">   
           <a href="/SemiProject/prod/prodInfo.army?productno=${view.productno }" title="${view.productname }" class="product-thumbnail product-item-link" data-mod="product-thumbnail" aria-label="${view.productname }, ${view.price }, 구매하기">   
       <div class="product-thumbnail__img-container">   
           <img  class="product-thumbnail__img--front" src="<%= ctxPath %>/images/products/${view.pimage}" width="100" height="120" alt="">   
         </div>   
       <div class="product-thumbnail__description">   
           <h3 class="product-thumbnail__title">${view.productname }</h3>   
          <p class="product-thumbnail__price">   
           ${view.price } 원   
        </p>   
        </div>   
          </a>   
          </div> 
          </td>
          </c:forEach>
          </tr>  
         <tr>        
        <div>   
           <c:forEach var="view2" items="${product }" begin="2" end="3">   
        <td align="center"><div class="category-push__product-item" style="display:inline-block;">   
           <a href="/SemiProject/prod/prodInfo.army?productno=${view2.productno }" title="${view2.productname }" class="product-thumbnail product-item-link" data-mod="product-thumbnail" aria-label="${view2.productname }, ${view2.price }, 구매하기">   
          <div class="product-thumbnail__img-container">   
              <img  class="product-thumbnail__img--front" src="<%= ctxPath %>/images/products/${view2.pimage}" width="100" height="120" alt="">   
            </div>   
       <div class="product-thumbnail__description">   
           <h3 class="product-thumbnail__title">${view2.productname }</h3>   
             <p class="product-thumbnail__price"> ${view2.price } 원</p>   
    	</div>   
		</a>   
          </div>
          </td>   
       </c:forEach> 
       </tr>  
       </div>
       </table>   
     </div>   
    </div>  
       <div class="col-sm-5 col-sm-offset-1" style=" height: 600px;"><br/><br/>   
       <div class="category-push__products">   
       <table style="width: 100%; height: 100%; margin: 0 auto;">
           <tr>  
          <c:forEach var="view3" items="${product }" begin="4" end="5">   
        <td align="center"> <div class="category-push__product-item" style="display:inline-block;">   
           <a href="/SemiProject/prod/prodInfo.army?productno=${view3.productno }" title="${view3.productname }" class="product-thumbnail product-item-link" data-mod="product-thumbnail" aria-label="${view3.productname }, ${view3.price }, 구매하기">   
       <div class="product-thumbnail__img-container">   
           <img  class="product-thumbnail__img--front" src="<%= ctxPath %>/images/products/${view3.pimage}" width="100" height="120" alt="">   
         </div>   
       <div class="product-thumbnail__description">   
           <h3 class="product-thumbnail__title">${view3.productname }</h3>   
          <p class="product-thumbnail__price">${view3.price } 원</p>   
        </div>   
          </a>   
          </div>
          </td> 
          </c:forEach>  
             </tr>  
        <tr>   
           <c:forEach var="view4" items="${product }" begin="6" end="7">   
        <td align="center"><div class="category-push__product-item" style="display:inline-block;">   
           <a href="/SemiProject/prod/prodInfo.army?productno=${view4.productno }" title="${view4.productname }" class="product-thumbnail product-item-link" data-mod="product-thumbnail" aria-label="${view4.productname }, ${view4.price }, " >   
          <div class="product-thumbnail__img-container">   
              <img  class="product-thumbnail__img--front" src="<%= ctxPath %>/images/products/${view4.pimage}" width="100" height="120" alt="">   
            </div>   
       <div class="product-thumbnail__description">   
           <h3 class="product-thumbnail__title">${view4.productname }</h3>   
             <p class="product-thumbnail__price"> ${view4.price } 원</p>   
    </div>   
</a>   
          </div>
          </td>   
       </c:forEach>   
       </tr> 
       </table> 
     </div>   
<br/><br/><br/>    
        </div>   
        <div class="col-sm-5 sidenav" style="">   
            <a href="http://localhost:9090/SemiProject/prod/prodList.army?code=2"><img src="images/여자.jpg" alt="여자 시계" style="width:100%;  height: 600px;"></a>   
            <br/><br/><br/>    
        </div>   
  <!-- body 3 -------------------------------------------------------------  -->   
         
    <div class="col-sm-12 sidenav" style="background-color: #eee; padding-top: 30px;">   
      <div class="row content">   
        <div class="col-sm-4 col-sm-offset-1" style="">   
          <div class="text-media" data-mod="text-media">   
            <div class="text-media__media" style="">   
              <img   style="width:100%;"   src="https://www.tissotwatches.com/media/content_push/liuyifei_ambassadors_770x450_v2.jpg" alt="Liu Yifei">   
            </div>   
          </div>   
        </div>   
        <div class="col-sm-6" style=" margin-left: 10px;">   
          <div class="text-media" data-mod="text-media">   
            <div class="text-media__text">   
              <div>   
               <h1 class="text-media__label">Watch의홍보대사를만나보세요.</h1>   
              <h3 class="text-media__title">Liu Yifei</h3>   
              <div class="text-media__description">   
                    류이페이는 베이징 영화 아카데미의 공연학교를 졸업한 중국의 유명한 여자 배우 겸 가수로, 2002년 불과 15세의 어린 나이에 연기 경력을 시작했다. 스크린을 통해 다양한 역할을 연기하며 뛰어난 연기력과 놀라운 매력을 보여준 류이페이는 급속도로 대중의 인기를 얻었다.   
                   아름다움은 시간이 가면 바뀌지만 모든 순간은 아름답다. 아름다움을 유지하기 위한 가장 좋은 방법은 있는 그대로 가슴에 새기는 것이다. 이것이 바로 당신의 시간이다.   
                </div>   
           </div>   
          </div>   
          </div>   
        </div>     
      </div>   
    </div>      
    <div class="col-sm-12 sidenav" style="background-color: #eee; padding-top: 30px;" >   
     <div class="row content">   
        <div class="col-sm-4 col-sm-offset-1">   
          <div class="text-media" data-mod="text-media">    
            <div class="text-media__media">   
              <img style="width:100%;" src="https://www.tissotwatches.com/media/content_push/NBA_770x450.jpg" alt="NBA">   
            </div>   
          </div>   
        </div>   
           
        <div class="col-sm-6" style=" margin-left: 10px;">   
          <div class="text-media" data-mod="text-media">   
            <div class="text-media__text">   
             <h1 class="text-media__label">Watch의스포츠파트너쉽</h1>   
             <h3 class="text-media__title">NBA</h3>   
             <div class="text-media__description">미국의 4대 스포츠 중 농구는 가장 인기가 있고, 사랑을 받고, 연습을 많이 하고, 영감을 주는 스포츠입니다.   
              수많은 어린이와 성인이 전 세계에서 농구를 하고 선수복을 입고 덩크하는 꿈을 꿉니다. 주요 글로벌 브랜드인 티쏘는 2015년부터 NBA의 공식 타임키퍼였습니다.   
               티쏘는 18 시즌 NBA 베테랑인 토니 파커나 골든 스테이트 워리어스의 클레이 톰슨과 같은 홍보대사에 대한 지원에 이어, 5대 5 게임의 긍정적인 팀 가치와 보편적인 매력을 깊이 신뢰하고 있습니다.   
              </div>   
            </div>   
          </div>   
        </div>      
      </div>   
    </div>   
  </div>   
  
<br/><br/>   
<div>   
<h2 class="cathegory-list__title" align="center">모든 카테고리</h2>   
<div class="row">   
  <div class="column" style="background-color:#fff;">      
     <img src="https://www.tissotwatches.com/media/home/Categories_810x1080_CLASSIC.jpg" alt="" width="auto" height="100%">   
        <a class="nav-link" href="/SemiProject/prod/prodList.army?code=1">남성시계</a>   
  </div>   
  <br/><br/><div class="column" style="background-color:#fff;">     
  <img src="https://www.tissotwatches.com/media/shop/catalog/category/Push_Lovely.jpg" alt="" width="auto" height="100%">   
     <a class="nav-link" href="/SemiProject/prod/prodList.army?code=2">여성시계</a>   
    
  </div>   
     
  <div class="column" style="background-color:#fff;">   
   <img src="https://www.tissotwatches.com/media/home/Categories_1080x1080_T_TOUCH_1.jpg" alt="" width="auto" height="100%">   
   <a class="nav-link" href="/SemiProject/prod/prodList.army?code=3">가죽시계</a>   
       
  </div>   
     
  <div class="column" style="background-color:#fff;">   
  <img src="https://www.tissotwatches.com/media/home/Categories_1080x810_GOLD.jpg;%0D%0A" alt="" width="auto" height="100%">   
     <a class="nav-link" href="/SemiProject/prod/prodList.army?code=4">메탈시계</a>   
       
  </div>   
</div>   
</div>   
</div>     
<!-- body -->   

<jsp:include page="/footer.jsp"/>
   
</body>
</html>
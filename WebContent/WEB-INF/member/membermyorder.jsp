<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
   String ctxPath = request.getContextPath();
%>

<jsp:include page="/header.jsp" />

<style type="text/css">

.orderListElement {
   
   
   text-align: center; 
   
   margin-top: 20px; 
   
   display: inline-block;
   
   margin-left: 35px;
      
   
   
}

</style>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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

</style>

<script type="text/javascript">
   
   $(function(){
      // 검색
      $("#searchBtn").click(function(search){
         
         var search = $("#search").val();
         
         location.href="<%=ctxPath%>/prod/prodList.army?search="+search;
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


<script type="text/javascript">

  $(document).ready(function(){



     //캘린더 시작~~~~~~~~~~~~
       $('#fromDate').datepicker({
           showOn: "both",                     // 달력을 표시할 타이밍 (both: focus or button)
           buttonImage: "<%= ctxPath %>/images/cal.jpg", // 버튼 이미지
           buttonImageOnly : true,             // 버튼 이미지만 표시할지 여부
           buttonText: "날짜선택",             // 버튼의 대체 텍스트
           dateFormat: "yy-mm-dd",             // 날짜의 형식
           changeMonth: true,                  // 월을 이동하기 위한 선택상자 표시여부
           onClose: function( selectedDate ) {    

               $("#toDate").datepicker( "option", "minDate", selectedDate );
           }                
       });

       //종료일
       $('#toDate').datepicker({
           showOn: "both", 
           buttonImage: "<%= ctxPath %>/images/cal.jpg", 
           buttonImageOnly : true,
           buttonText: "날짜선택",
           dateFormat: "yy-mm-dd",
           changeMonth: true,
           onClose: function( selectedDate ) {

               $("#fromDate").datepicker( "option", "maxDate", selectedDate );
           }                
       });  // 캘린더 종료-------------------------------------- 
       
   
       var fromDate      
       var toDate 
      var today
       var day = new Date();
       
       // 1주 버튼
       $("#week").click(function(){

          $("#toDate").val(getTodayType2()); 
          //today = dt.getDate();
          
          if(day.getDate()<7){
             $("#fromDate").val(getPastDateWeek2());
          }
          else{
             $("#fromDate").val(getTodayTypeWeek());
          }

          //$("#fromDate").val();
       });
       
       // 1달
       $("#oneMonth").click(function(){
          $("#toDate").val(getTodayType2());   
          $("#fromDate").val(getPastDate(1));
          
       });       
       // 3달
       $("#threeMonth").click(function(){
          $("#toDate").val(getTodayType2());
          $("#fromDate").val(getPastDate(3));
          
          
       });       
       // 6달
       $("#sixMonth").click(function(){
          $("#toDate").val(getTodayType2());
          $("#fromDate").val(getPastDate(6));
          
          
       });   
       
       // 캘린더 버튼을 눌렀을 때-------------------------------------
       $("#calBtn").click(function(){

          if($("#toDate").val()==null || $("#fromDate").val()==null ){
             alert("날짜를 선택하세요");
          }
          var toDate = $("#toDate").val();
          var fromDate = $("#fromDate").val();
         
          {
             
           location.href="<%= request.getContextPath() %>/member/memberMyOrder.army?toDate="+toDate+"&fromDate="+fromDate;            

          }
          
       });
       
 }); // end of $(document).ready(function())---------------------------
       
function getTodayType2() {
    var date = new Date(); 
    return date.getFullYear() + "-" + ("0"+(date.getMonth()+1)).slice(-2) + "-" + ("0"+date.getDate()).slice(-2); 
 }

function getTodayTypeWeek() {
    var date = new Date(); 
    return date.getFullYear() + "-" + ("0"+(date.getMonth()+1)).slice(-2) + "-" + ("0"+(date.getDate()-7)).slice(-2); 
}
 
function getPastDate(period){
    var dt = new Date();
 
    dt.setMonth((dt.getMonth() + 1) - period);
 
    var year = dt.getFullYear();
    var month = dt.getMonth();
    var day = dt.getDate();
 
    if(month < 10) month = "0" + month;
    if(day < 10) day = "0" + day;
 
    return year + "-" + month + "-" + day;
}

function getPastDateWeek2(){
    var dt = new Date();
 
    dt.setMonth((dt.getMonth() + 1));
    dt.setDate((dt.getDate() - 7));
  
 
    var year = dt.getFullYear();
    var month = dt.getMonth();
    var day = dt.getDate();
 
    if(month < 10) month = "0" + month;
    if(day < 10) day = "0" + day;
 
    return year + "-" + month + "-" + day;
}

function goReview(productname){
   
      var url = "/SemiProject/prod/writeReviewCheck.army?productname="+productname;   
      window.open(url, "writeReview", "left=350px, top=100px, width=500px, height=420px");    

}

function goReviewEdit(productname){
    var url = "/SemiProject/prod/editReviewCheck.army?productname="+productname;   
    window.open(url, "eidtReview", "left=350px, top=100px, width=500px, height=420px");	
	
}

</script>

</head>
<body>
  <div class="container-fluid text-center">    
   <div class="row content">
   
     <div class="col-sm-2 sidenav" style="border:solid 1px gray;border-bottom: none;border-right: none;">
      
      <jsp:include page="/mypageside.jsp" />
   
     </div>
     
      <div class="col-sm-9 text-left" style="border:solid 1px gray"> 
       <div class="row content">
         <div class="col-sm-12 text-left">
           <h2 id="orderMainfont" style="text-align: center; margin-top: 100px;">주문현황</h2>
           
         </div>  
               
           <jsp:include page="/mypageTitle.jsp" />

            <div class="col-sm-12 text-left" id="mypageSecond">   
              <br/><br/>
              <div id="orderState">주문현황내역<span>( ${totalCountCart} )</span></div>
              <br/><br/>   
              <div style="height: 120px;  background-color: #f2f2f2;">
               <button class="term" id="week">1주일</button>
               <button class="term" id="oneMonth">1개월</button>
               <button class="term" id="threeMonth">3개월</button>
               <button class="term" id="sixMonth">6개월</button>
               <div id="Datepicker" style= "margin-left: 520px;">     
                  <form name="registerFrm">
                         <label for="fromDate"></label>
                         <input type="text" name="fromDate" id="fromDate" value="${fromDate}">
                         ~
                         <label for="toDate" ></label>
                         <input type="text" name="toDate" id="toDate" value="${toDate}"> 
                    </form>
               </div>
               <div style="float: right; position: relative; bottom: 39px; right: 20px; cursor: pointer;" id="calBtn">
                  <img src="<%= ctxPath %>/images/calbtn.jpg">
               </div>
                  
              </div>
              <br/>        
            <div>
                <c:if test="${empty listMap}"> 
                   <div id="currentOrderListFont2" style="text-align: center; margin-top: 100px; font-size: 11pt;">주문내역이 존재하지 않습니다.</div> 
               </c:if> 
                 
               <c:if test="${not empty listMap}"> 
                    <c:forEach var="map" items="${listMap}" varStatus="status">
                       <div style="margin-top: 50px; text-align: left; margin-left: 100px;">
                          <div class="orderListElement"><img src='<%= ctxPath %>/images/products/${map.pimage}'  style="width: 100px; height: 100px;"/></div>                           
                        	시계명 : <div class="orderListElement" class="productname">${map.productname}</div>
                        <div class="orderListElement" style="color: red;">가격 : ${map.price}원</div>
                        <div class="orderListElement">재질 : ${map.pcategory}</div>
                        <div class="orderListElement">주문일자 : ${map.statementday}</div>
                        <div class="orderListElement">주문상태 : ${map.shipstatus}</div>
                        <c:forEach var="n" items="${cnt}" begin="${status.count -1}" end="${status.count -1}">
                        <c:if test="${n == '0' }">
                        	<button type="button" style="margin-left: 40px;"  onclick="goReview('${map.productname}')">한줄평 작성</button>
                        </c:if>
                        <c:if test="${n == '1' }">
                        	<button type="button" style="margin-left: 40px;"  onclick="goReviewEdit('${map.productname}')">한줄평 수정</button>
                        </c:if>
                        </c:forEach>
                     </div>                     
                  </c:forEach>
               </c:if>
               
                <div align="center" style="margin-top: 20px;">${requestScope.pageBar} </div>
            </div>
            
            <div>
              <ul style="margin-top: 180px;">
               <li style="color: #b2b2b2; font-weight: bold; font-size: 13pt;">묶음 할인 된 세트 상품은 낱개로 반품/환불이 불가능합니다.</li>
               <li style="color: #b2b2b2; font-weight: bold; font-size: 13pt;">주문취소 시 쿠폰은 재발급되지 않습니다.</li>
               <li style="color: #b2b2b2; font-weight: bold; font-size: 13pt;">구매확정 후에는 교환 반품이 어렵습니다.</li>
              </ul>
            </div>
            <div class="col-sm-12 text-left" style="margin-top: 100px;">
              <img src="/SemiProject/images/orderState.jpg" style="width: 100%;"/>
            </div>
            <div style="height: 150px;"></div>         
           </div>  
       </div>   
     </div>   
        
    </div>
  </div>
    
 <jsp:include page="/footer.jsp" />


   
</body>
</html>
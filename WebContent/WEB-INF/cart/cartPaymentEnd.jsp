<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/header.jsp"/>

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
  
  /* .sameadr{        // 용도폐기
   margin-left: 50px; 
  } */
</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">


$(document).ready(function() {
   
}); // end of $(document).ready()-----------------------------

function goHome(){
	location.href="/SemiProject/index.army";
}

</script>

  <div class="container-fluid text-center">    
   <div class="row content main_container">
     <div class="col-md-12 col-lg-9" style="margin-left: 15%;">
       <div>
         <h3>주문내역</h3>

         <table class="table table-striped" class="table-responsive" >
          <thead>
          <tr>
            <th>주문완료번호</th>
            <th>결제방식</th>
            <th>결제자이름</th>
            <th>주문상세번호</th>
            <th>전표번호</th>
            <th>배송번호</th>
          </tr>
        </thead>
        
        <tbody>
           <c:forEach var="orderListVO" items="${orderList}" varStatus="count">
          <tr>
            <td><c:out value="${orderListVO.ordercompleteno}"/></td>
            <td><c:out value="${orderListVO.paymentmode}"/></td>
            <td><c:out value="${orderListVO.paymentname}"/></td>
            <td><c:out value="${orderListVO.fk_orderdetailno}"/></td>
            <td><c:out value="${orderListVO.fk_statementno}"/></td>
            <td><c:out value="${orderListVO.fk_shippingno}"/></td>
          </tr>
          </c:forEach>


        </tbody>
        </table>
         
         
<%--          <c:forEach var="orderListVO" items="${orderList}" varStatus="count">
          <ul>
            <li><label>주문완료번호</label><span>${orderListVO.ordercompleteno}</span></li>
            <li><label>결제방식</label><span>${orderListVO.paymentmode}</span></li>
            <li><label>결제자이름</label><span>${orderListVO.paymentname}</span></li>
            <li><label>주문상세번호</label><span>${orderListVO.fk_orderdetailno}</span></li>
            <li><label>전표번호</label><span>${orderListVO.fk_statementno}</span></li>
            <li><label>배송번호</label><span>${orderListVO.fk_shippingno}</span></li>
          </ul>
         </c:forEach> --%>
         
       </div>
       <button id="goHome" onclick="goHome()">홈으로</button>
      </div>
   </div>
  </div>
    
<jsp:include page="/footer.jsp"/>

</body>
</html>
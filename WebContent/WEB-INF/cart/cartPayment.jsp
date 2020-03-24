<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

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

  /* 총계 css 양식도 포함 */
	.allSum 
	{
    display: block;
    position: relative;
  	margin-top: 35px;
  	text-align:left;
  	padding-left: 5px;
  	font-size: 30px;
  	font-weight: bold;
  	width: 100%;
 
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
  
</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

var radio = 0; //라디오 체크 초기화 0으로 시작


$(document).ready(function() {
	
	$("#error").hide();
	
	// $(":input[name=radio]:radio")
	$("input:radio[name=radio]").bind("click", function(){
		var i = $(this).index(); 
		console.log("~~확인용 i : " + i); // 무조건 0.  왜냐하면 $(this) 내에서 인덱스를 찾기 때문이다.    
		
		var index = $("input:radio[name=radio]").index(this); // 올바른 index 가 나온다. 
		console.log("~~확인용 index : " + index);
		
		//스펜테그의 클레스를 삭제
		$("span").removeClass("stylePoint");
		$("span").eq(index).addClass("stylePoint");
		// $("span").eq(index) ==> 배열요소를 꺼내는 것과 비슷한 것임.
		
		$("#error").hide();
	});// end of $("input:radio[name=radio]").bind("click")-----------
	
	
		

	///////////////////////////////////////////////////////////
	$(".btn").click(function(){

		var cardCheckedCnt = $("input:radio[class=card]:checked").length;
		var noAccountCheckedCnt = $("input:radio[class=noAccount]:checked").length;
		var mobilePaymentCheckedCnt = $("input:radio[class=mobilePayment]:checked").length;
				
		// 카드 radio 의 체크 여부를 확인한다
		   if(cardCheckedCnt == 1) {
			// radio를 선택하지 않았을 경우
			 
			   //	여기 링크를 꼭 참고하세용 http://www.iamport.kr/getstarted
				   var IMP = window.IMP;     // 생략가능
				   IMP.init("key");  // 중요!!  아임포트에 가입시 부여받은 "가맹점 식별코드". 
					//현제 가맹점 김용호 팀원으로 진행됨 결제 금액 10원 고정
					
				   // 결제요청하기
				   IMP.request_pay({
				       pg : 'html5_inicis', // 결제방식 PG사 구분
				       pay_method : 'card',	// 결제 수단
				       merchant_uid : 'merchant_' + new Date().getTime(), // 가맹점에서 생성/관리하는 고유 주문번호
				       name : '결제테스트(코인충전|주문명)',	 // 코인충전 또는 order 테이블에 들어갈 주문명 혹은 주문 번호. (선택항목)원활한 결제정보 확인을 위해 입력 권장(PG사 마다 차이가 있지만) 16자 이내로 작성하기를 권장
				       amount : 10,	  // '${coinmoney}'  결제 금액 number 타입. 필수항목. 결제 금액 10원으로 고정 
				       buyer_email : '',  // 구매자 email
				       buyer_name : '${name}',	  // 구매자 이름 
				       buyer_tel : '',    // 구매자 전화번호 (필수항목)
				       buyer_addr : '',  
				       buyer_postcode : '',
				       m_redirect_url : ''  // 휴대폰 사용시 결제 완료 후 action : 컨트롤러로 보내서 자체 db에 입력시킬것!
				   }, function(rsp) {
				     
						if ( rsp.success ) { // PC 데스크탑용
						
							//location.href="cartPaymentEnd.army";
							gosubmit();
						    self.close();
				            
				        } else {
				        	location.href="cartPayment.army";
				            alert("결제에 실패하였습니다.");
				       }

				     }); // $("#payAPI").click(function(){--------------------
		
		   			} 
		   
	   		else if(noAccountCheckedCnt == 1){
				alert("무통장 입금은 아직 구현되지 않았습니다.");
					// 추후 결제 API 삽입하여 기능 구현 할것
				   } 
	   		
	   		else if(mobilePaymentCheckedCnt == 1){
				alert("휴대폰 결제는 아직 구현되지 않았습니다.");
					// 추후 결제 API 삽입하여 기능 구현 할것
				   } 
	   		
	   		else {
					// radio를 선택하지 않았을 경우
					  alert("결제 방법을 선택해주세요");
				   } 
				
	}); // $(".btn").click-------------------------
	
	
	$("#btnPostSearch").click(function(){
		new daum.Postcode({
			oncomplete: function(data) {
			    $("#post").val(data.zonecode); 		// 개정된 우편번호 받아오기  예> 12345 5자리 
			    $("#address1").val(data.address);   // 큰주소                        예> 서울특별시 종로구 인사로 17 
			    $("#address2").focus();
			}
		}).open();
	}); // $("#btnPostSearch").click-------------------------
	
	var sum = ${ sessionScope.sum };
	
	sum = numberWithCommas(sum);
	
	$("#paymentsum").text(sum);
	
}); 
// end of $(document).ready()-----------------------------

function gosubmit(){
    var frm = document.goSubmit;
	frm.action = "/SemiProject/cart/cartPaymentEnd.army";
	frm.method = "POST";
	frm.submit();
}


function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

</script>

  <div class="container-fluid text-center">    
	<div class="row content main_container">
	  <div class="col-md-12 col-lg-9" style="margin-left: 15%;">
	    <form name="goSubmit">
	        <div class="row">
            <div class="col-md-12 col-lg-6">
              <h3 class="sub">배송지 주소</h3>
	          <label for="paymentName"><i class="fa fa-user"></i> 이름</label>
	          <input type="text" id="fa fa-envelope" name="paymentName" placeholder="홍길동">
	          <label for="email"><i class="fa fa-envelope"></i> 이메일</label>
	          <input type="text" id="email" name="email" placeholder="hongkd@example.com">
	          <label for="address1"><i class="fa fa-address-card-o"></i> 주소</label>
	          <input type="text" id="address1" name="address1" placeholder="서울시 중구 경복궁">
	          <label for="address2"><i class="fa fa-institution"></i> 상세주소</label>
	          <input type="text" id="address2" name="address2" placeholder="107동 102호">

              <div class="row">
              	<div class="col-md-12 col-lg-12">
                  <label for="state">전화번호</label>
                  <input type="text" id="tel" name="tel" placeholder="010-1234-5678">
              </div>
              	<br/>
              	<div class="col-md-12 col-lg-12">
                  <label for="post">우편번호</label>
                	<div class="col-md-5 col-lg-5">
	                	<input type="text" id="post" name="post" size="6" maxlength="5" placeholder="12321" />
		            </div>
					
					<div class="col-md-12 col-lg-12">
						<button id="btnPostSearch" type="button" style="cursor: pointer; font-size: 20px;">우편번호 찾기</button> 
              		</div>
              	</div>
              	<div class="col-md-12 col-lg-12">
                  <input type="hidden" id="productno" name="productno" value="${sessionScope.productno}">
              	</div>
              </div>
          	</div>

            <div class="col-md-12 col-lg-6">
              <h3 class="sub">결제방법</h3>
              <!-- radio 선택을 위한 내용 구현 -->
			  <label class="main_container radio">신용/체크카드
			    <input type="radio" name="radio" class="card"  value="신용카드">
			    <span class="checkmark"></span>
			  </label>
			 <!-- 무통장 API 없음 상단 스트립트에서 추후에 추가 사용 가능 -->
			  <label class="main_container radio">무통장입금
			    <input type="radio" name="radio" class="noAccount" value="무통장입금">
			    <span class="checkmark"></span>
			  </label>
			 
			  <br/><br/><br/><br/><br/><br/>
			  <label class="allSum" id="allSumPrice" style="font-size: 16pt; font-weight: bold;">결제총액 : <span style="color: red; font-size: 16pt; font-weight: bold;" id="paymentsum"></span> 원 </label> <!-- 결제총액 내용 받아오기 필요 -->
            </div>
          </div>
        </form>
        <div style="display: inline-block; width: 50%; margin-left:25%; margin-top: 15px; text-align:center; align-content: center;" >
        	<input type="button" value="결제 진행 하기" class="btn"/>
 	  	</div>
      </div>
	</div>
  </div>
    
<jsp:include page="/footer.jsp"/>

</body>
</html>
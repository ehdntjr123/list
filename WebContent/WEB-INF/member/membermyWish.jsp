<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="/header.jsp"/>

<script type="text/javascript">

$(document).ready(function(){
	
	$("#btnMoreHIT").hide();

	

	
	
  // HIT상품 게시물을 더보기 위하여 "더보기..." 버튼 클릭액션에 대해 초기값 호출  
  viewWishList("1");
	
  // HIT상품 게시물을 더보기 위하여 "더보기..." 버튼 클릭액션의 이벤트 등록하기 
  $("#btnMoreHIT").click(function(){
		
    if($(this).text() == "처음으로") {
	  $("#showWishList").empty();
	  viewWishList("1");
	  $(this).text("더보기...");
    }
    else {
	  viewWishList($(this).val());
    }
  });	
	
  //위시목록 선택 삭제-----------------------------------------------------
  $("#wishdel").click(function(){
		
    //	alert($("input:checkbox[name=wishCheckBox]:checked").length);
    var length = $("input:checkbox[name=wishCheckBox]").length;
    var checkBoxArr = [];
		 
    for(var i=0; i<length; i++) {
	  if( $("input:checkbox[name=wishCheckBox]").eq(i).is(":checked") ) {
	    checkBoxArr.push( $("input:checkbox[name=wishCheckBox]").eq(i).val() );
	  }
    }// end of for---------------------

    $.ajax({
	  url:"/SemiProject/member/memberWishDelJSON.army",
	  data: {"userno":"${sessionScope.loginuser.userno}", 
		     "productjoin":checkBoxArr.join()},
	  dataType:"JSON",
	  success: function(json) {
	    if(json.n == 1) {
		  alert("선택한 제품을 모두 삭제했습니다");
	 	  location.href="/SemiProject/member/memberMyWish.army";
	    }
	    else {
	 	  alert("제품삭제를 못했습니다");
	 	  location.href="javascript:history.back()";
	    }
	  },
	  error: function(request, status, error){
	    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	  }
    });		 
  });//위시목록 선택 삭제 종료------------------------------------------------------
	
  //위시목록 선택 장바구니 보내기-------------------------------------------------------
  $("#wishToCart").click(function(){
	var length = $("input:checkbox[name=wishCheckBox]").length;
	var checkBoxArr = [];
		 
	for(var i=0; i<length; i++) {
	  if( $("input:checkbox[name=wishCheckBox]").eq(i).is(":checked") ) {
		checkBoxArr.push( $("input:checkbox[name=wishCheckBox]").eq(i).val() );
	  }
	}// end of for---------------------
		
	$.ajax({		
	  url:"/SemiProject/member/memberWishCartJSON.army",
	  data: {"userno":"${sessionScope.loginuser.userno}",
	 	     "productjoin":checkBoxArr.join(),
	    	 "userid":"${sessionScope.loginuser.userid}"},	 			   
	  dataType:"JSON",
	  success: function(json) {
		if(json.n == 0) {
	 	  alert("장바구니가 가득 찼습니다");
	 	  location.href="/SemiProject/member/memberMyWish.army";
	 	}
	 	else if(json.n == 1) {
	 	  alert("장바구니로 이동하였습니다");
	 	  location.href="javascript:history.back()";
	 	}
	 	else if(json.n == 2) {
	 	  alert("중복된 상품이 있습니다");
	 	  location.href="javascript:history.back()";
	 	}	 			 
	   },
	   error: function(request, status, error){
		 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	  });				
/* 		$.ajax({
			
			url:"/SemiProject/member/memberWishCartJSON.army",
	 		data: {"userno":"${sessionScope.loginuser.userno}", 
	 			   "productjoin":checkBoxArr.join(),
	 			   "userid":"${sessionScope.loginuser.userid}"}
	 		
		});	 */	
	});	
	//위시목록 전체 삭제 종료-------------------------------------------------------
	
	// 위시목록 전체선택 해제----------------------------------------------------------
	$("#wishSel").click(function(){
		$("input:checkbox[name=wishCheckBox]").prop("checked", false);	
	});
	// 위시목록 전체선택 해제 종료---------------------------------------------------------
	
	// 위시목록 전체 선택하기------------------------------------------------------------
	$("#wishAll").click(function(){
		$("input:checkbox[name=wishCheckBox]").prop("checked", true);
	});
	// 위시목록 전체 선택하기 종료------------------------------------------------------------
	
  });
// $(document).ready(function() 끝-------------------------------------------------------
		
  function viewWishList(start){
	

	
    var leng =  8;

	$.ajax({
		url:"/SemiProject/member/memberWishJSON.army",
 		data: {"userno":"${sessionScope.loginuser.userno}"
 				,"start":start
 				,"len":leng},
 		dataType:"JSON",
		success:function(json){
			var html = "";

			if(json.length == 0){
				
				html = "";
				html += "<div id='wishOrderListFont2' style='text-align: center; margin-top: 200px; font-size: 11pt;'>관심상품에 등록된 상품이 없습니다.</div>";

				$("#wishfalse").html(html);	
				$("#wishfalse").show();
				$("#wishfalse").css('width','100%');
				$("#wishfalse").css('height','400px');
			}
			else{
				html = "";
				$("#wishfalse").hide();
				$.each(json, function(index, item){
					html += "<div style='display: inline-block;  text-align: center;margin-bottom: 50px;'>"
					+ "<label for='wishCheck"+(index+1)+"'><img src='<%= ctxPath %>/images/products/"+item.pimage+"'  style='width: 200px; height: 200px;'/></label>" 
					+ "<input type='checkbox' class='wishCheckBox' name='wishCheckBox' id='wishCheck"+(index+1)+"' value='"+item.productno+"' style='position: relative; bottom: 80px; right: 180px; width: 16px; height: 16px;'/>"
					+ "<div style='margin-top: 10px;'>"+item.productname+"</div>"
        	        + "</div>";			
				});	
				$("#showWishList").html(html);
				$("#btnMoreHIT").show();

	    		// >>> (중요!!!) 더보기... 버튼의 value 속성에 값을 지정하기 <<< //
	    		$("#btnMoreHIT").val(parseInt(start)+leng);
	    		
	    		// 더보기... 버튼의 value 값이 9 로 변경된다.
	    		// 더보기... 버튼의 value 값이 17 로 변경된다.
	    		// 더보기... 버튼의 value 값이 25 로 변경된다.
	    		// 더보기... 버튼의 value 값이 33 로 변경된다.
	    		// 더보기... 버튼의 value 값이 41 로 변경된다.
	    		
	    		// countHIT 에 지금까지 출력된 상품의 갯수를 누적해서 기록한다. 
	    		$("#countHIT").text( parseInt($("#countHIT").text()) + json.length);
	    		
	    		
	    		// 더보기... 버튼을 계속해서 클릭하여 countHIT 값과 wishTotal 값이 일치하는 경우 
	    		// 버튼의 이름을 "처음으로" 라고 변경하고 countHIT 0 으로 초기화 해야 한다.
	    		if( $("#countHIT").text() == $("#wishTotal").text() ) { 
	    			$("#btnMoreHIT").text("처음으로");
	    			$("#countHIT").text("0");
	    		}
				$("#wishNumber").html(" "+${wishTotal}+" ");
				
				var i = ${wishTotal};
				
 				if(i<=8){
 					$("#btnMoreHIT").hide();
			 	} 

 				
			}			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}	
	});
}

</script>

<div class="container-fluid text-center">    
  <div class="row content">
	  <div class="col-sm-2 sidenav" style="border:solid 1px gray;border-bottom: none;border-right: none;">
	  <jsp:include page="/mypageside.jsp" />
	</div>
	  
    <div class="col-sm-9 text-left" style="border:solid 1px gray"> 
      <div class="row content">
		<div class="col-sm-12 text-left">
		  <h2 id="wishMainfont" style="text-align: center; margin-top: 100px;">위시리스트</h2>
		</div>  
		<jsp:include page="/mypageTitle.jsp" />		 			  
		<div class="col-sm-12 text-left" id="mypageThird">	
		  <div>
			<div style="width: 100%; height: 150px;">
			  <div id="wishState">위시리스트(<span id="wishNumber"> 0 </span>)</div>
			  <div>
				<button id="wishdel"class="wishBtn" style="background-color: white;">선택삭제</button>
				<button id="wishToCart"class="wishBtn" style="background-color: white;">선택 장바구니</button>
				<button id="wishSel"class="wishBtn" style="background-color: black; color: white; font-weight: bold;">선택해제</button>
				<button id="wishAll"class="wishBtn" style="background-color: black; color: white; font-weight: bold;">전체 선택</button>	
			  </div>
			</div>	
			<div style="width: 100%;">
 			  <div  id="wishfalse"></div>						
			  <div style="margin-left: 120px;">
			    <div  id="showWishList"></div>		
			  </div>
			</div>		
		  </div>
		</div>
	  </div>	
		 
	  <div style="text-align: center;">
		<button type="button" id="btnMoreHIT" value="" style="display: none;">더보기...</button>
		<span style="display: none;" id="wishTotal">${wishTotal}</span>
		<span style="display: none;" id="countHIT">0</span>
	  </div>		 
	</div>	
  </div>
</div>
    
<jsp:include page="/footer.jsp"/>
	
</body>
</html>
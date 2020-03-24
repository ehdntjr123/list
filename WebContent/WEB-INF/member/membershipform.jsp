<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="/header.jsp"/>

<style type="text/css">
  #step-2 > div {
    width: 65%; 
  }

  #step-2 {
	margin-left: 200px; 
  }

</style>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
  //===== TOP 버튼 ===== \\
  var mybutton = document.getElementById("myBtn");
	
  //When the user scrolls down 20px from the top of the document, show the button
  window.onscroll = function() {scrollFunction()};
	
  function scrollFunction() {
	if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
	  mybutton.style.display = "block";
	} else {
	  mybutton.style.display = "none";
	}
  }
	
  //When the user clicks on the button, scroll to the top of the document
  function topFunction() {
	document.body.scrollTop = 0;
	document.documentElement.scrollTop = 0;
  }
	
	
  // ==== 검색창 ==== \\
  function openSearch() {
	document.getElementById("myOverlay").style.display = "block";
  }

  function closeSearch() {
	document.getElementById("myOverlay").style.display = "none";
  }

  // === list 정렬버튼 === \\
  $(document).ready(function(){
	$("div.arrayIcon #array1").html("<img src='https://www.giordano.co.kr/_skin/giordano/img/button/list_type0.png' width='30' height='30' style='transform:rotate(90deg)'/>");
	$("div.arrayIcon #array3").html("<img src='https://www.giordano.co.kr/_skin/giordano/img/button/list_type1_over.png' width='30' height='30'/>");
		
	$("div.arrayIcon #array1").click(function(){
	$("div.arrayIcon #array1").html("<img src='https://www.giordano.co.kr/_skin/giordano/img/button/list_type0_over.png' width='30' height='30' style='transform:rotate(90deg)'/>");
	$("div.arrayIcon #array3").html("<img src='https://www.giordano.co.kr/_skin/giordano/img/button/list_type1.png' width='30' height='30'/>");
  });
		
  $("div.arrayIcon #array3").click(function(){
	$("div.arrayIcon #array1").html("<img src='https://www.giordano.co.kr/_skin/giordano/img/button/list_type0.png' width='30' height='30' style='transform:rotate(90deg)'/>");
	$("div.arrayIcon #array3").html("<img src='https://www.giordano.co.kr/_skin/giordano/img/button/list_type1_over.png' width='30' height='30'/>");
  });
  
  
		
  // === List 정렬 종류 === \\
  $("div.list2").hide();
  
  $("div.arrayIcon #array1").click(function(){
    $("div.list1").hide();
  	$("div.list2").show();
  	$("#list21").addClass("active");
  });
		
  $("div.arrayIcon #array3").click(function(){
	$("div.list2").hide();
	$("div.list1").show();
	$("#list11").addClass("active");
  });
		
  $("a.listNumber").click(function(){
	$(this).addClass("active");
	$("div.pagination a").not($(this)).removeClass("active");
  });

  /* 작업내용 */
  var navListItems = $('div.setup-panel div a'),
  allWells = $('.setup-content'),
  allNextBtn = $('.nextBtn');

  allWells.hide();

  navListItems.click(function (e) {
    e.preventDefault();
    var $target = $($(this).attr('href')),
    $item = $(this);

	if (!$item.hasClass('disabled')) {
      navListItems.removeClass('btn-primary').addClass('btn-default');
      $item.addClass('btn-primary');
      allWells.hide();
      $target.show();
      $target.find('input:eq(0)').focus();
    }
  });

  $('div.setup-panel div a.btn-primary').trigger('click');
  
  $("#nextBtn").click(function() {
    var checkboxBool = $("input:checkbox[id=agree]").is(":checked");
	  
	if(!checkboxBool) {
	  alert("이용약관에 동의하셔야 합니다.");
	  return; 
	}  
	else {
	  ////////////////////////////////////
    //	allNextBtn.click(function(){
	 /*		var curStep = $(this).closest(".setup-content"),
			curStepBtn = curStep.attr("id"),
		    nextStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().next().children("a"),
		    curInputs = curStep.find("input[type='text'],input[type='url']"),
		    isValid = true;
		
		    $(".form-group").removeClass("has-error");
		    for(var i=0; i<curInputs.length; i++){
		      if (!curInputs[i].validity.valid){
		        isValid = false;
		        $(curInputs[i]).closest(".form-group").addClass("has-error");
		      }
		    }
		
		    if (isValid)
		        nextStepWizard.removeAttr('disabled').trigger('click');
	  */	    
	  // });
	  ////////////////////////////////////
		  
	  goNext($(this));
	}
  });

  $("#nextBtn1").click(function() {
  		
	if($("#userid").val().trim() == "") {
	  alert("아이디를 입력해주세요"); 
	  $("#userid").val(""); 
	  $("#userid").focus();
	  return;
	}
	
	else if( $("#userpw").val().trim() == "" ) {
	  alert("비밀번호를 입력해주세요"); 
	  $("#userpw").val(""); 
	  $("#userpw").focus();
	  return;			
	}
	else if( $("#username").val().trim() == "" ) {
	  alert("이름을 입력해주세요"); 
	  $("#username").val(""); 
	  $("#username").focus();
	  return;			
	}
	else if( $("#email").val().trim() == "" ) {
	  alert("이메일을 입력해주세요"); 
	  $("#email").val(""); 
	  $("#email").focus();
	  return;			
	}
	else if( $("#phone").val().trim() == "" ) {
	  alert("핸드폰번호를 입력해주세요"); 
	  $("#phone").val(""); 
	  $("#phone").focus();
	  return;			
	}
	else if( $(".address").val().trim() == "" ) {
	  alert("주소를 입력해주세요"); 
	  $(".address").val(""); 
	  $("#addr1").focus();
	  return;			
	}
		
	var regExp = /^\d{3}\d{3,4}\d{4}$/;
	var bool = regExp.test( $("#phone").val().trim() ); 

	if( bool == false ) {
	  alert("올바른 핸드폰번호를 입력해주세요"); 
	  $("#phone").val(""); 
	  $("#phone").focus();
	  return;			
	} 
		
  	goNext($(this));
  }); 
	
  $("input:text[name=userid]").bind("blur", function(event) {
  	if( !$("#userid").val().trim() == "") {
  	  $.ajax({
  		url:"<%= ctxPath %>/member/CheckUserid.army",
  		type:"POST",
  		data:{"userid" : $("#userid").val()},
  		dataType:"json",
  		success:function(json){
  		  var result = "";
  				
  		  if(json.result == false) {
  			result = "사용 가능한 아이디 입니다.";
  		  }
  		  else if(json.result == true){
  			result = "이미 사용중인 아이디 입니다.";
  			$("#userid").val(""); 
  		  }
  		  else {
  			result = "조회하는 도중 오류가 발생했습니다.";
  		  }
  					
  		  $(".userid_error").html(result);
  		},
  		error: function(request, status, error){
  		  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
  		}
  	  });
  	}
  }); 

});// end of $(document).ready()-------------------------------------------------
  
  function gomembership() {
	var frm = document.membershipform;
	frm.method = "POST";
	frm.action = "<%=request.getContextPath()%>/member/memberFormEnd.army";
	frm.submit();
  }
  
  function goNext(obj) {
	var curStep = obj.closest(".setup-content"),
	curStepBtn = curStep.attr("id"),
	nextStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().next().children("a"),
	curInputs = curStep.find("input[type='text'],input[type='url']"),
	isValid = true;
	
	$(".form-group").removeClass("has-error");
	for(var i=0; i<curInputs.length; i++){
	  if (!curInputs[i].validity.valid){
	    isValid = false;
	    $(curInputs[i]).closest(".form-group").addClass("has-error");
	  }
	}
	
	if (isValid)
	  nextStepWizard.removeAttr('disabled').trigger('click');
  }
  
  function openDaumPOST() {
	new daum.Postcode({
	  oncomplete: function(data) {
	    $("#postno1").val(data.postcode1);  // 우편번호의 첫번째 값     예> 151
		$("#postno2").val(data.postcode2);  // 우편번호의 두번째 값     예> 019
		$("#addr1").val(data.address);    // 큰주소                        예> 서울특별시 종로구 인사로 17 
		$("#addr2").focus();
	  }
	}).open();
  }

</script>

<div class="container-fluid text-center">    
  <div class="content">
	<div class="col-md-6 col-md-offset-3">
	  <div class="stepwizard">
		<div class="stepwizard-row setup-panel">
		  <div class="stepwizard-step" style="display: inline-block;">
		    <a href="#step-1" type="button" class="btn btn-primary btn-circle">1</a>
		    <p>1. 약관동의</p>
		  </div>
		  <div class="stepwizard-step" style="display: inline-block;">
		    <a href="#step-2" type="button" class="btn btn-default btn-circle" disabled="disabled">2</a>
		    <p>2. 회원정보입력</p>
		  </div>
		  <div class="stepwizard-step" style="display: inline-block;">
		    <a href="#step-3" type="button" class="btn btn-default btn-circle" disabled="disabled">3</a>
		    <p>3. 가입완료</p>
		  </div>
		</div>
	  </div>
		
	  <form name="membershipform">
		<div class="row setup-content" id="step-1">
		  <div class="col-xs-12">
		    <div class="col-md-12">
		      <h3> 1. 약관동의</h3><br/><br/>
		      <div class="form-group">
		        <label class="control-label">이용약관 동의(필수)</label><input type="checkbox" name="agree" id="agree" />
		        <iframe src="/SemiProject/agree.html" width="100%" height="150px" class="box" ></iframe>
		      </div>
		      <button class="btn btn-primary nextBtn btn-lg pull-right" id="nextBtn" type="button" >다음</button>
		    </div>
		  </div>
		</div>
		    
		<div class="row setup-content" id="step-2">
		  <div class="col-xs-12">          
		    <div class="col-md-12">
		      <h3> 2. 회원정보입력</h3><br/><br/>
			  <div class="form-group">
			    <label class="control-label">아이디</label>
			    <input maxlength="200" type="text" required="required" class="form-control" id="userid" name="userid" placeholder="Userid" />
			    <span class="userid_error" style="display: inline;"></span>
			  </div>
			  <div class="form-group">
			    <label class="control-label">비밀번호</label>
			    <input maxlength="200" type="password" required="required" class="form-control" id="userpw" name="userpw" placeholder="Passwd"  />
			  </div>
			  <div class="form-group">
			    <label class="control-label">이름</label>
			    <input maxlength="200" required="required" name="username" id="username" class="form-control" placeholder="이름"  />
			  </div>     
			  <div class="form-group">
			    <label class="control-label">이메일</label>
			    <input maxlength="200" type="email" required="required" name="email" id="email" class="form-control" placeholder="E-mail"  />
			  </div>
			  <div class="form-group">
			    <label class="control-label">핸드폰번호</label>
			    <input maxlength="200"  required="required" name="phone" id="phone" class="form-control" placeholder="ex) -없이 "  />
			  </div>
			  <div class="form-group">
			    <label class="control-label">우편주소</label></br>
				<input type="text" id="postno1" name="postno1" class="form-control" size="10" maxlength="5"  style="width: 120px; display: inline-block;"/>&nbsp;-&nbsp;
				<input type="text" id="postno2" name="postno2" class="form-control" size="10" maxlength="5" style="width: 120px;  display: inline-block;" />
				&nbsp;&nbsp;
				<button type="button" style="cursor: pointer; display: inline-block;" onClick="openDaumPOST();">우편번호찾기</button></br>
			  </div>
			  <div class="form-group">
			    <label class="control-label">주소</label>
			    <input maxlength="200"  required="required" name="addr1" id="addr1" class="form-control address" placeholder="주소"  />
			    <input maxlength="200"  required="required" name="addr2" id="addr2" class="form-control address" placeholder="상세 주소"  />
			  </div>
			                
			  <button class="btn btn-primary btn-lg pull-right" id="nextBtn1" type="button" >다음</button>
		    </div>
		  </div>      
		</div>

		<div class="row setup-content" id="step-3">
		  <div class="col-xs-12">
		    <div class="col-md-12">
		      <h3> 가입완료</h3><br/><br/>
		      <button class="btn btn-success btn-lg pull-right" type="button" onclick="gomembership()">확인</button>
		      <button class="btn btn-success btn-lg pull-right" type="reset">취소</button>
		    </div>
		  </div>
		</div>
	  </form>
	</div>
  </div>
</div>
    
<jsp:include page="/footer.jsp"/>

</body>
</html>
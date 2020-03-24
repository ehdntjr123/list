<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="/header.jsp"/>

<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=ctxPath%>/js/jquery-3.3.1.min.js"></script>
	
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
  $(function(){
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
	$('#login-form-link').click(function(e) {
	  $("#login-form").delay(100).fadeIn(100);
	  $("#register-form").fadeOut(100);
	  $('#register-form-link').removeClass('active');
	  $(this).addClass('active');
	  e.preventDefault();
	});
		
	$('#register-form-link').click(function(e) {
	  $("#register-form").delay(100).fadeIn(100);
	  $("#login-form").fadeOut(100);
	  $('#login-form-link').removeClass('active');
	  $(this).addClass('active');
	  e.preventDefault();
	});
		
		
	$("#login-submit").click(function() {
	  goLogin();
	}); 
	
	$("#login_up-submit").click(function(){
	  location.href="/SemiProject/member/memberFormStart.army";	
	});

	$("#userpw").keydown(function(event) {
	  if (event.keyCode == 13) {
		goLogin();
	  }
	}); 
	
	var loginUserid = localStorage.getItem('saveid');	
	if(loginUserid != null) {
	  $("#loginUserid").val(loginUserid);
	  $("input:checkbox[id=saveid]").prop("checked", true);
	} 
		
  }); // $(document).ready(function() ----------------------------------------------

  function goLogin() {	
    var loginUserid = $("#userid").val().trim();
	var loginPwd = $("#userpw").val().trim();
			
	if(loginUserid == "") {
	  alert("아이디를 입력하세요!!");
	  $("#userid").val("");
	  $("#userid").focus();
	  return;
	}
			
	if(loginPwd == "") {
	  alert("비밀번호를 입력하세요!!");
	  $("#userpw").val("");
	  $("#userpw").focus();
	  return;
	}

	// 로컬 스토리지(localStorage)를 사용하여 userid 값 저장시키기 
	// 아이저장이 체크되어 있으면 
	if( $("input:checkbox[id=saveid]").is(":checked") ) { 
				
	  var loginUserid = localStorage.getItem('saveid');
				
	  if(loginUserid != null && loginUserid != $("#userid").val()) {
		localStorage.removeItem('saveid');
		localStorage.setItem('saveid', $("#userid").val()); 
	  }
				
	  if(loginUserid == null) {
		localStorage.setItem('saveid', $("#userid").val());
	  }
	}	   
	// 아이저장이 체크되어있지 않음 
	else {
	  var loginUserid = localStorage.getItem('saveid');
				
	  if(loginUserid != null) {
		localStorage.removeItem('saveid');
	  }
	} 
		   
	var frm = document.loginFrm;
	frm.method = "POST";
	frm.action = "<%=request.getContextPath()%>/member/loginEnd.army";
	frm.submit();
  }
	
</script>



<div class="container-fluid text-center">    
  <div class="row content">
	<!-- 작업내용 -->
    <div class="col-md-6 col-md-offset-3 bb">
	  <div class="panel panel-login">
		<div class="panel-heading">
		  <div class="row">
			<div class="col-xs-6">
			  <a href="#" class="active" id="login-form-link">로그인</a>
			</div>
			<div class="col-xs-6">
			  <a href="#" id="register-form-link">비회원로그인 </a>
			</div>
		  </div>
		  <hr/>
		</div>
		<div class="panel-body">
		  <div class="row">
		    <div class="col-lg-9">
			  <form name="loginFrm" id="login-form" role="form" style="display: block;">
			    <div class="form-group">
				  <input type="text"  id="userid" name="userid" tabindex="1" class="form-control" placeholder="아이디" value="">
				</div>
				<div class="form-group">
				  <input type="password" name="userpw" id="userpw"  tabindex="2" style="height: 45px" class="form-control" placeholder="비밀번호">
				</div>
				<div class="form-group text-center" style="text-align: left;">
				  <input type="checkbox" tabindex="3" class="" name="saveid" id="saveid">
				  <label for="saveid"> 아이디저장</label>
				</div>
				<div class="form-group">
				  <div class="row">
					<div class="col-sm-6 col-sm-offset-3">
					  <input type="button" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="로그인">
					</div>
					<div class="col-sm-6 col-sm-offset-3">
					  <input type="button" name="login_up-submit" id="login_up-submit" tabindex="4" class="form-control btn btn-login" value="회원가입">
					</div>
				  </div>
				</div>
				<div class="form-group">
				  <div class="row">
					<div class="col-lg-9">
					  <div class="text-center">
						<a tabindex="5" style="cursor: pointer;" data-toggle="modal" data-target="#userIdfind" data-dismiss="modal">아이디찾기</a> /
						<a tabindex="5" style="cursor: pointer;" data-toggle="modal" data-target="#userpwFind" data-dismiss="modal" data-backdrop="static">비밀번호찾기</a>
					  </div>
					</div>
				  </div>
				</div>
			  </form>
			</div>
		  </div>
		</div>
	  </div>
	</div>
  </div>
</div>
  
<%-- ****** 아이디 찾기 Modal ****** --%>
<div class="modal fade" id="userIdfind" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">아이디 찾기</h4>
      </div>
      <div class="modal-body" style="height: 300px; width: 100%;">
        <div id="idFind">
          <iframe style="border: none; width: 100%; height: 280px;"<%--  src="<%= request.getContextPath()%>/login/idFind.up" --%>>
          </iframe>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
      </div>
    </div>  
  </div>
</div>

<%-- ****** 비밀번호 찾기 Modal ****** --%>
<div class="modal fade" id="userpwFind" role="dialog">
  <div class="modal-dialog">  
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">비밀번호 찾기</h4>
      </div>
      <div class="modal-body">
        <div id="pwFind">
          <iframe style="border: none; width: 100%; height: 350px;" <%-- src="<%= request.getContextPath() %>/login/pwdFind.up" --%>>  
          </iframe>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
      </div>
    </div>  
  </div>
</div>
  
<jsp:include page="/footer.jsp"/>
	
</body>
</html>
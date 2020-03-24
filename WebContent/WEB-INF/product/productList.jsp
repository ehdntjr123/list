<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="/header.jsp"/>

<style type="text/css">
  div.arrayList ul {
	list-style-type: none;
  }
	
  div.arrayList ul li {
	display: inline-block;
	margin-right: 5px;
  }
  
  a.sort:hover {
  	cursor: pointer;
  	text-decoration: underline;
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
  
  .moreProdInfo {
	display: inline-block;
	margin-right: 20px;
	margin-bottom: 100px;
  }
  
  .headmenu {
  	font-size: 16pt;
  	color: black;
  }
  
  .headmenu:hover {
  	text-decoration: none;
  	color: black;
  }
  
  .sortactive {
  	font-weight: bold;
  }
  
   .cateactive {
  	font-weight: bold;
  }
  
  #displayProduct{
  	width: 90%;
  	padding-left: 5%;
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
  
  .moveinfo {
  	color: black;
  }
  
  .moveinfo:hover {
  	text-decoration: none;
  	color: black;
  }
  
  #btnMore {
	width: 200px;
	height: 60px;
	font-size: 14pt;
	outline-style: none;
	outline: 0;
  }

</style>

<script type="text/javascript">

	// ==== 검색창 ==== \\
	function openSearch() {
	  document.getElementById("myOverlay").style.display = "block";
	}

	function closeSearch() {
	  document.getElementById("myOverlay").style.display = "none";
	}
	
	
		
$(function(){		
	
	// 상품 목록 \\
	$("#total").hide();
	$("#count").hide();
	
	var sort = null;
	
	displayProd("1", sort);
	
	// 더보기 \\
	$("#btnMore").click(function() {
		
		
		if($(this).text() == "End") {
			$("#displayProduct").empty();
			displayProd("1", sort);
			$(this).text("More");
			$(this).show();
		}
		else {
			displayProd($(this).val(), sort);	
		}
		
	});
	
	// 상품 정렬 \\
	$(".sort").click(function(){
		
		$("#count").text("0");
		
		$(".sort").removeClass('sortactive');
		
		$(this).addClass('sortactive');
		
		$("#displayProduct").empty();
		
		sort = $(this).attr('id');
		
		displayProd("1", sort);
		
	});
	

	
	// 검색 \\
	$("#searchBtn").click(function(search){	
		var search = $("#search").val();
		
		location.href="<%=ctxPath%>/prod/prodList.army?search="+search;
	});		
	
});		

	var len = 8;

	function displayProd(start, sort) {
		$.ajax({
			url:"/SemiProject/prod/ProdDisplayJSON.army",
			type: "GET",
			data: {"code":'${code}', "search":'${search}', "sort":sort, "start":start, "len":len},
			dataType: "JSON",
			success: function(json) {
				
				var html = "";
				
				// 데이터가 존재하지 않는 경우
				if(json.length == 0) {
					html += "상품 준비 중..";
					
					// HIT 상품 출력
					$("#displayProduct").html(html);
					
					// 더보기.. 버튼 비활성화
					$("#btnMore").hide();
				
				}
				
				// 데이터가 존재하는 경우
				else {
					
					$.each(json, function(index, item) {
						if((index+1)%4 != 0) {
							html += "<div class='moreProdInfo'><a href='/SemiProject/prod/prodInfo.army?productno="+item.productno+"'>"
							+"<input type='hidden' class='pimage' value='"+item.pimage+"'/><img width='250px;' height='250px;' src='/SemiProject/images/products/"+item.pimage+"' /></a>"
							+"<a class='moveinfo' href='/SemiProject/prod/prodInfo.army?productno="+item.productno+"'><div align='center' class='nameprice'><span><br>"
							+"["+item.brand+"] "+item.productname+"<br/><br/>"
		        	        + (item.price).toLocaleString('en')+" 원<br/></span></div></a>"
		        	        +"</div>";
						}
						else {
							html += "<div class='moreProdInfo'><a href='/SemiProject/prod/prodInfo.army?productno="+item.productno+"'>"
							+"<input type='hidden' class='productno' value='"+item.productno+"'/><img width='250px;' height='250px;' src='/SemiProject/images/products/"+item.pimage+"' /></a>"
							+"<a class='moveinfo' href='/SemiProject/prod/prodInfo.army?productno="+item.productno+"'><div align='center' class='namepirce'><span><br>"
							+"["+item.brand+"] "+item.productname+"<br/><br/>"
		        	        + (item.price).toLocaleString('en')+" 원<br/></span></div></a>"
		        	        +"</div><br>";	
						}
						
						
					});
					
					$("#displayProduct").append(html);
					
					// >>> !!! 더보기... 버튼의 value 속성의 값을 지정하기. !!! <<<
					$("#btnMore").val(parseInt(start)+len);
					// 더보기... 버튼의 value 속성값이 9로 변경된다.
					
					// countHIT 에 지금까지 출력된 상품의 갯수를 누적해서 기록한다.
					$("#count").text(parseInt($("#count").text()) + json.length);
					
					if($("#count").text()==$("#total").text()){
						$("#btnMore").text("End");
						$("#btnMore").hide();
						$("#count").text("0");
					}
				}
				
			}, error: function(request, status, error) {
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
	}
	
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

allNextBtn.click(function(){
var curStep = $(this).closest(".setup-content"),
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
});

$('div.setup-panel div a.btn-primary').trigger('click');





/* function goSort(sort){
	var url = document.location.href;
	var para = url.split("?");
	
	location.href = "/SemiProject/prod/prodSort?"+para[1]+"&sort="+sort; 
} */
	
</script>

<div class="container-fluid text-center">    
  <div class="row content" style="margin-top: 10px;">
	<div class="col-sm-2 sidenav" align="right" style="padding-top: 2%; font-size: 14pt;">
	<h1 style="margin-bottom: 40%; margin-right: 10%;">Category</h1>
	<ul id="sidemenu">
	  <%@ include file="/WEB-INF/product/categoryList.jsp" %>
	</ul> 
	</div>
    <div class="col-sm-10 text-left arrayList" style="margin: 0 auto; border-left: solid 1px gray;">
      <h3 style="font-size: 24pt; font-weight: bold; margin-top: 5%; margin-right: 10%;" align="center">
      <c:if test="${code == 1 }">
      <span><a class="headmenu" href="/SemiProject/prod/prodList.army?code=1">MEN</a></span>
      </c:if>
      <c:if test="${code == 2 }">
      <span><a class="headmenu" href="/SemiProject/prod/prodList.army?code=2">WOMEN</a></span>
      </c:if>
      <c:if test="${code == 3 }">
      <span><a class="headmenu" href="/SemiProject/prod/prodList.army?code=3">LEATHER</a></span>
      </c:if>
      <c:if test="${code == 4 }">
      <span><a class="headmenu" href="/SemiProject/prod/prodList.army?code=4">METAL</a></span>
      </c:if>
      </h3><br/>
      <ul style="float: right; margin-right: 20%;">
		<li><a class="sort" id="1">최신순 |</a></li>
		<li><a class="sort" id="2"> 인기순 |</a></li>
		<li><a class="sort" id="3"> 낮은가격 |</a></li>
		<li><a class="sort" id="4"> 높은가격</a></li>
	  </ul>
		
	  <div class="row" style="margin-top: 5%;">
		<div id="displayProduct" align= "left">
		
		</div>
	  </div>
  	  <div align="center" style="margin-right: 10%;">
		<button type="button" id="btnMore" class="btn btn-default" value="">More...</button>
		<span id="count">0</span>
		<span id="total">${totalCount }</span>
 	  </div>
	</div>
    <hr>
  </div>
</div>
  
<jsp:include page="/footer.jsp"/>
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

ul li {
	margin-bottom: 20px;
}
</style>

<script type="text/javascript" src="<%= ctxPath %>/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">

	$(function(){
		
		var savescore = ${review.score};
		
		if(savescore == 1){
			$("input:radio[id=1]").prop('checked', true);
		}
		else if(savescore == 2){
			$("input:radio[id=2]").prop('checked', true); 
		}
		else if(savescore == 3){
			$("input:radio[id=3]").prop('checked', true); 
		}
		else if(savescore == 4){
			$("input:radio[id=4]").prop('checked', true); 
		}
		else if(savescore == 5){
			$("input:radio[id=5]").prop('checked', true); 
		}
		
		$("#reviewEdit").click(function(){
			var contents = $("#contents").val().trim();
			var productname = $("#productname").val();
			var score = $('input[name="score"]:checked').val();
			
			var flag = false;
			
			if(contents == "" || !$("input:radio[name=score]").is(":checked")){
				alert("입력 안된 사항이 있습니다.");
				flag = true;
			}
			
			else if(contents.length > 20){
				alert("한줄평은 20자 까지만 작성 가능합니다.");
				$("#contents").val($("#contents").val().substring(0,20));
				flag = true;
			}			
		
			if(!flag){
				reviewEdit();
			}
			
		});
		
	});
	
	function goCancel(){
		self.close();
	}
	
	function reviewEdit(){
		var frm = document.reviewFrm;
		frm.action="/SemiProject/prod/reviewEdit.army";
		frm.submit();
	}
	
	function reviewDelete(){
		var frm = document.reviewFrm;
		frm.action="/SemiProject/prod/reviewDelete.army";
		frm.submit();
	}

</script>

</head>
<body>
	
	<form name="reviewFrm" method="get">
		<fieldset>
			<h2>리뷰 수정</h2>
			<ul style="list-style-type: none;">
				<li>
					<div style="display: inline-block;"><img src="/SemiProject/images/products/${product.pimage }" style="width: 100px; height: 100px;" /></div>
					<div style="display: inline-block;">${product.productname }</div>
					<input type="hidden" id="productname" name="productname" value="${product.productname }" />
				</li>
				<li>
					<label>평점 : </label>
					<input type="radio" id="1" name="score" value="1" /><label for="1" style="margin-left: 2%;">1</label>
					<input type="radio" id="2" name="score" value="2" /><label for="1" style="margin-left: 2%;">2</label>
					<input type="radio" id="3" name="score" value="3" /><label for="1" style="margin-left: 2%;">3</label>
					<input type="radio" id="4" name="score" value="4" /><label for="1" style="margin-left: 2%;">4</label>
					<input type="radio" id="5" name="score" value="5" /><label for="1" style="margin-left: 2%;">5</label>
				</li>
				<li>
					<label>한줄평 : </label> 
					<textarea rows="5" cols="30" name="contents" id="contents">${review.reviewcontent }</textarea>
				</li>
				<li id="button">
					<button id="reviewEdit" type="button">수정</button>
					<button type="button" onclick="reviewDelete();">삭제</button>
					<button type="button" onclick="goCancel();">취소</button>
				</li>
			</ul>	
		</fieldset>
	</form>

</body>
</html>
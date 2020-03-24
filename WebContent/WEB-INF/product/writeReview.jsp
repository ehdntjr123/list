<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<script type="text/javascript"
	src="<%=ctxPath%>/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(function() {

		$("#reviewRegister").click(
				function() {
					var contents = $("#contents").val().trim();
					var productname = $("#productname").val();
					var score = $('input[name="score"]:checked').val();

					console.log(score);

					var flag = false;

					if (contents == ""
							|| !$("input:radio[name=score]").is(":checked")) {
						alert("입력 안된 사항이 있습니다.");
						flag = true;
					}

					else if (contents.length > 20) {
						alert("한줄평은 20자 까지만 작성 가능합니다.");
						$("#contents").val(
								$("#contents").val().substring(0, 20));
						flag = true;
					}

					if (!flag) {
						reviewRegister();
					}

				});

	});

	function goCancel() {
		self.close();
	}

	function reviewRegister() {
		var frm = document.reviewFrm;
		frm.submit();
	}
</script>

</head>
<body>

	<form name="reviewFrm" action="<%=ctxPath%>/prod/writeReview.army"
		method="get">
		<fieldset>
			<h2>리뷰 작성</h2>
			<ul style="list-style-type: none;">
				<li>
					<div style="display: inline-block;">
						<img src="/SemiProject/images/products/${product.pimage }"
							style="width: 100px; height: 100px;" />
					</div>
					<div style="display: inline-block;">${product.productname }</div> <input
					type="hidden" id="productname" name="productname"
					value="${product.productname }" />
				</li>
				<li><label>평점 : </label> <input type="radio" id="1"
					name="score" value="1" /><label for="1" style="margin-left: 2%;">1</label>
					<input type="radio" id="2" name="score" value="2" /><label for="1"
					style="margin-left: 2%;">2</label> <input type="radio" id="3"
					name="score" value="3" /><label for="1" style="margin-left: 2%;">3</label>
					<input type="radio" id="4" name="score" value="4" /><label for="1"
					style="margin-left: 2%;">4</label> <input type="radio" id="5"
					name="score" value="5" /><label for="1" style="margin-left: 2%;">5</label>
				</li>
				<li><label>한줄평 : </label> <textarea rows="5" cols="30"
						name="contents" id="contents"></textarea></li>
				<li id="button">
					<button id="reviewRegister" type="button">등록</button>
					<button type="button" onclick="goCancel();">취소</button>
				</li>
			</ul>
		</fieldset>
	</form>

</body>
</html>
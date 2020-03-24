<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
	alert("${message}");
	javascript:location.href="${loc}";	// 페이지 이동
	
	self.close();
	opener.location.reload();
	
/* 	location.href="javascript:history.go(1);" // 다음 페이지로 이동
	location.href="javascript:history.go(0);" // 현재 페이지로 이동(새로 고침) 캐시에 가서 다시 읽어옴
	location.href="javascript:history.go(-1);" // 이전 페이지로 이동
	location.href="javascript:history.go(-2);" // 이전 이전 페이지로 이동
	
	location.href="javascript:history.back();" // 이전 페이지로 이동
	location.href="javascript:loaction.reload();" // 현재 페이지로 이동(새로 고침) 서버에 가서 다시 읽어옴
	location.href="javascript:history.forward();" // 다음 페이지로 이동 */
</script>

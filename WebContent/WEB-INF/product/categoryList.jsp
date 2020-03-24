<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${categoryList != null}">
	
	<c:forEach var="map" items="${categoryList }" begin="0" end="0">
		<li class="nav-item side">
		<a class="nav-link" id="men" href="<%= request.getContextPath()%>/prod/prodList.army?code=${map.gendercode}">남자시계</a>
		</li> 
	</c:forEach>
	<c:forEach var="map" items="${categoryList }" begin="2" end="2">
		<li class="nav-item side">
		<a class="nav-link" id="women" href="<%= request.getContextPath()%>/prod/prodList.army?code=${map.gendercode}">여자시계</a>
		</li> 
	</c:forEach>
	<c:forEach var="map" items="${categoryList }" begin="0" end="0">
		<li class="nav-item side">
		<a class="nav-link" id="leather" href="<%= request.getContextPath()%>/prod/prodList.army?code=${map.materialcode}">가죽시계</a>
		</li> 
	</c:forEach>
	<c:forEach var="map" items="${categoryList }" begin="1" end="1">
		<li class="nav-item side">
		<a class="nav-link" id="material" href="<%= request.getContextPath()%>/prod/prodList.army?code=${map.materialcode}">메탈시계</a>
		</li> 
	</c:forEach>

</c:if>
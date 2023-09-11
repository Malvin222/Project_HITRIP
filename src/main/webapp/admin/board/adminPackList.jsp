<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항관리</title>	
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
</head>

<style>
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
}
header {
  background-color: #333;
  color: white;
  padding: 10px 0;
  text-align: center;
}
a { color:#0a0ccc; text-decoration:none; }
.topMenu_area {
	width:100%;
	height:70px;
	text-align:center;
	background:yellow;
}
.subMenu_area {
	width:100%;
	height:30px;
	text-align:center;
	background:skyblue;
	line-height:2.5;
	margin-bottom:30px;
}
.content_area {
	width:100%;
	text-align:center; 
}
.page_number_area {
  width: 100%;
  text-align: center;
  padding-top: 20px;
}

.page_number_area button {
  font-family: Arial, sans-serif;
  font-size: 14px;
  padding: 5px 10px;
  margin: 0 2px;
  border: 1px solid #ccc;
  background-color: #f5f5f5;
  cursor: pointer;
  transition: background-color 0.3s ease, color 0.3s ease;
}

.page_number_area button:hover {
  background-color: #ddd;
}

.page_number_area a {
  font-family: Arial, sans-serif;
  font-size: 14px;
  padding: 5px 10px;
  margin: 0 2px;
  text-decoration: none;
  color: #0a0ccc;
  border: 1px solid #ccc;
  background-color: #f5f5f5;
  transition: background-color 0.3s ease, color 0.3s ease;
}

.page_number_area a:hover {
  background-color: #ddd;
  color: #0a0ccc;
}

.page_number_area span {
  font-family: Arial, sans-serif;
  font-size: 14px;
  padding: 5px 10px;
  margin: 0 2px;
  color: #333;
  background-color: #f5f5f5;
  border: 1px solid #ccc;
}

.page_number_area .current {
  background-color: #0a0ccc;
  color: white;
  border-color: #0a0ccc;
}
.board1 {
	width:1000px;
	border-top:2px solid #474747;
	border-bottom:1px solid #cccccc;
	border-collapse:collapse;
  margin: auto; /* Center the table */
}
.board1 th, .board1 td {
	border-bottom:1px solid #cccccc;
	border-collapse:collapse;
	padding:10px;
	text-align:center;
	height:30px;
}
.board1 th {
	background-color: #f5f5f5;
}
.board1 tr:nth-child(odd) {
	background-color: #f9f9f9;
}
.notice-emphasis {
  background-color: #00ffff;
}
</style>
<c:set var="s_adminid" value="${sessionScope.SessionAdminID }"/>
<body>

<%@include file="../../include/adminHeader.jsp" %>

<div class="content_area">
	<table border="0" width="1000" align="center"></table>
		<form id="searchFrm" method="post" action="/adminPackList.do?menu=1">
		<input type="hidden" name="pageIndex" id="pageIndex" value="1">
		<select name="searchCondition">
			<option value="packtitle"
				<c:if test="${PackVO.searchCondition=='packtitle' }">selected</c:if>
			>제목</option>
			<option value="bsnmid"
				<c:if test="${PackVO.searchCondition=='bsnmid' }">selected</c:if>
			>내용</option>
			<option value="packrdate"
				<c:if test="${PackVO.searchCondition=='packrdate' }">selected</c:if>
			>날짜</option>
		</select>
		<input type="text" name="searchKeyword" value="${PageVO.searchKeyword }">
		<button type="submit">검색</button>
		</form>
	
	<table border="0" width="1000" align="center">
		<tr><td align="left"> 총 ${PackVO.total }건</td></tr>
	</table>
		
	<table class="board1" align="center">
		<colgroup>
			<col width="10%"/>
			<col width="*"/>
			<col width="15%"/>
			<col width="20%"/>
			<col width="10%"/>
		</colgroup>
		<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>등록일</th>
		<th>오픈여부</th>
	</tr>	
		
	<c:set var="rownumber" value="${PackVO.recordCountPerPage }"/>
	
	<c:forEach var="list" items="${PackList}" varStatus="status">
		<tr>
			<td>${rownumber }</td>
			<td><a href="packBoardDetail.do?packunq=${list.packunq}">${list.packtitle }</a></td>
			<td>${list.bsnmid }</td>
			<td>${list.packrdate }</td>
			<td>
			<c:choose>
				 <c:when test="${list.packopen eq 'Y' || list.packopen eq 'y'}">
			        오픈
			    </c:when>
			    <c:otherwise>
			        미오픈
			    </c:otherwise>
			</c:choose>
			</td>
		</tr>
	<c:set var="rownumber" value="${rownumber-1 }"/>
	</c:forEach>
</table>
</div>

<!-- 토탈 및 페이징S -->
<div class="page_number_area">
    	 <!-- 페이지가 5이하일때 시작 페이지를 1로 고정 -->
			<c:choose>
			    <c:when test="${PageVO.pageIndex - 5 < 1}">
			        <c:set var="startIndex" value="1" />
			    </c:when>
			    <c:otherwise>
			        <c:set var="startIndex" value="${PackVO.pageIndex - 5}" />
			    </c:otherwise>
			</c:choose>
			
    <button onclick="location='/adminPackList.do?pageIndex=1&searchCondition=${PackVO.searchCondition}&searchKeyword=${PackVO.searchKeyword}'">first</button>
    <button onclick="location='/adminPackList.do?pageIndex=${startIndex}&searchCondition=${PackVO.searchCondition}&searchKeyword=${PackVO.searchKeyword}'">Previous</button>
    
    	<!-- 끝나는 인덱스를 10으로 고정  -->
			<c:choose>
			    <c:when test="${PackVO.pageIndex + 5 > PackVO.lastPage}">
			        <c:set var="endIndex" value="${PackVO.lastPage}" />
			    </c:when>
			    <c:when test="${PackVO.pageIndex + 5 < 10}">
			        <c:set var="endIndex" value="10" />
			    </c:when>
			    <c:otherwise>
			        <c:set var="endIndex" value="${PackVO.pageIndex + 5}" />
			    </c:otherwise>
			</c:choose>
			
			<c:forEach var="i" begin="${startIndex}" end="${endIndex}">
			    <a href="/adminPackList.do?pageIndex=${i }&searchCondition=${PackVO.searchCondition}&searchKeyword=${PackVO.searchKeyword}">${i}</a>
			</c:forEach>
			
	  	 <button onclick="location='/adminPackList.do?pageIndex=${endIndex}&searchCondition=${PackVO.searchCondition}&searchKeyword=${PackVO.searchKeyword}'">Next</button>
	  	 <button onclick="location='/adminPackList.do?pageIndex=${PackVO.lastPage}&searchCondition=${PackVO.searchCondition}&searchKeyword=${PackVO.searchKeyword}'">last</button>
</div>
<!-- 페이지처리 E -->


</body>
</html>





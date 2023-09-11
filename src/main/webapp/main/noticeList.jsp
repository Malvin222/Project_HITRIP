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
<title>공지사항</title>	
<link rel="stylesheet" href="../css/main.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
</head>

<style>
a { color:#000000; text-decoration:none; }
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
	width:1200px;
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
  background-color: #C4C4C4;
}

.search-form {
  text-align: right;
  margin-bottom: 20px;
}


</style>

<c:set var="s_adminid" value="${sessionScope.SessionAdminID }"/>
<body>
<div class="wrap">
<!--header 시작-->
<header>
	<%@include file="../include/header.jsp" %>
</header>
<!--header 끝-->



<!--nav 시작-->
<nav>
	<%@include file="../include/nav.jsp" %>
</nav>
<!--nav 끝-->

<!--section 시작-->
<!-- 토탈 S -->   
<div style="margin-top:20px;">
   총 ${total }건
</div>
<!-- 토탈 E --> 
<section>
<div class="content_area">

		
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
		<th>조회수</th>
	</tr>	
		
	<c:set var="rownumber" value="${PageVO.recordCountPerPage }"/>
	
	<c:forEach var="list" items="${NoticeList}" varStatus="status">
		<tr>
			<td <c:if test="${list.noticeemps eq 'Y'}">
    			class="notice-emphasis"
				</c:if>>
			<c:choose>
				 <c:when test="${list.noticeemps eq 'Y'}">
			        공지
			    </c:when>
			    <c:otherwise>
			        ${rownumber }
			    </c:otherwise>
			</c:choose>
			</td>
			<td align="left" <c:if test="${list.noticeemps eq 'Y'}">
    			class="notice-emphasis"
				</c:if> style="font-size:18px; font-weight:bold;"><a href="noticeDetail.do?noticeunq=${list.noticeunq }"><c:out value="${list.noticetitle}"/></a></td>
			<td <c:if test="${list.noticeemps eq 'Y'}">
    			class="notice-emphasis"
				</c:if>><c:out value="${list.noticename}"/></td>
			<td <c:if test="${list.noticeemps eq 'Y'}">
    			class="notice-emphasis"
				</c:if>><c:out value="${list.noticerdate}"/></td>
			<td <c:if test="${list.noticeemps eq 'Y'}">
    			class="notice-emphasis"
				</c:if>><c:out value="${list.noticehits}"/></td>
		</tr>
	<c:set var="rownumber" value="${rownumber-1 }"/>
	</c:forEach>
</table>
</div>

<div class="search-form">
  <form id="searchFrm" method="post" action="/noticeList.do?menu=1">
    <input type="hidden" name="pageIndex" id="pageIndex" value="1">
    <div class="search-options">
      <select name="searchCondition">
        <option value="noticetitle" <c:if test="${PageVO.searchCondition=='noticetitle' }">selected</c:if>>제목</option>
        <option value="noticecontent" <c:if test="${PageVO.searchCondition=='noticecontent' }">selected</c:if>>내용</option>
        <option value="noticerdate" <c:if test="${PageVO.searchCondition=='noticerdate' }">selected</c:if>>날짜</option>
      </select>
    
      <input type="text" name="searchKeyword" value="${PageVO.searchKeyword }" placeholder="검색어를 입력하세요">
    
      <button type="submit">검색</button>
    </div>
  </form>
</div>

  

<!-- 토탈 및 페이징S -->
<div class="page_number_area">
    	 <!-- 페이지가 5이하일때 시작 페이지를 1로 고정 -->
			<c:choose>
			    <c:when test="${PageVO.pageIndex - 5 < 1}">
			        <c:set var="startIndex" value="1" />
			    </c:when>
			    <c:otherwise>
			        <c:set var="startIndex" value="${PageVO.pageIndex - 5}" />
			    </c:otherwise>
			</c:choose>
			
    <button onclick="location='/noticeList.do?pageIndex=1&searchCondition=${PageVO.searchCondition}&searchKeyword=${PageVO.searchKeyword}'">first</button>
    <button onclick="location='/noticeList.do?pageIndex=${startIndex}&searchCondition=${PageVO.searchCondition}&searchKeyword=${PageVO.searchKeyword}'">Previous</button>
    
    	<!-- 끝나는 인덱스를 10으로 고정  -->
			<c:choose>
			    <c:when test="${PageVO.pageIndex + 5 > PageVO.lastPage}">
			        <c:set var="endIndex" value="${PageVO.lastPage}" />
			    </c:when>
			    <c:when test="${PageVO.pageIndex + 5 < 10}">
			        <c:set var="endIndex" value="10" />
			    </c:when>
			    <c:otherwise>
			        <c:set var="endIndex" value="${PageVO.pageIndex + 5}" />
			    </c:otherwise>
			</c:choose>
			
			<c:forEach var="i" begin="${startIndex}" end="${endIndex}">
			    <a href="/noticeList.do?pageIndex=${i }&searchCondition=${PageVO.searchCondition}&searchKeyword=${PageVO.searchKeyword}">${i}</a>
			</c:forEach>
			
	  	 <button onclick="location='/noticeList.do?pageIndex=${endIndex}&searchCondition=${PageVO.searchCondition}&searchKeyword=${PageVO.searchKeyword}'">Next</button>
	  	 <button onclick="location='/noticeList.do?pageIndex=${PageVO.lastPage}&searchCondition=${PageVO.searchCondition}&searchKeyword=${PageVO.searchKeyword}'">last</button>
</div>
<!-- 페이지처리 E -->
</section>
<!--section 끝-->



<!--footer 시작-->
<footer>
<div class="footer1">
	<%@include file="../include/footer.jsp" %>
</div>
</footer>
<!--footer 끝-->
</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/main.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<title>패키지여행 목록</title>
</head>
<style>
img {
    width: 100%;
    height: 100%;
}
table {
   width: 1200px;
    border-collapse: collapse;
    margin-top:3px;
    margin-bottom:3px;
    border-left: none;
    border-right: none;
}

td,th {
  border: 1px solid #ccc;
  padding: 10px;
  text-align: center;
  word-wrap: break-word; /* Wrap long text to prevent overflow */
  vertical-align: top; /* Align content to the top of cells */
  border-collapse:collapse;
  border-left: none;
  border-right: none;
}
.search td{
border: 0px solid #ccc;
text-align: right;
}
textarea {
   width: 100%;
   height: 300px;
}

p {
   text-align:center;
   margin: 5px;
}
/* Links */
a {
  text-decoration: none;
  color: black;
}

a:hover {
  color: blue;
}
/* Pagination buttons */
button {
  background-color: #333;
  color: #fff;
  border: none;
  padding: 8px 12px;
  margin: 5px;
  cursor: pointer;
}

button:hover {
  background-color: #555;
}
/* Styling for the title */
td p.title {
  font-size: 18px;
  font-weight: bold;
  margin-bottom: 5px;
}

/* Styling for the image */
td img {
  display: block;
  margin: 0 auto 5px;
}

/* Styling for the address */
td p.addr {
  margin-top: 5px;
}


/* 좋아요 버튼 */
.like_wrap {
   position:relative; 
   display:flex; 
   margin-bottom:40px; 
   justify-content:center; 
   align-items:center;
}
.like_wrap div {
   position:relative; 
   display:flex; 
   padding:10px 40px; 
   justify-content:center; 
   align-items:center; 
   border:1px solid #ddd; 
   border-radius:30px;
}
.button_like {
     background-color: white;
}
.button_like:hover {
     background-color: #cccccc;
}

</style>
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
<section>
<c:set var="s_bsnmid" value="${sessionScope.SessionBsnmID }"/>
<c:set var="s_userid" value="${sessionScope.SessionUserID }"/>

<!-- 검색기능 S -->   
   <table class="search" style="width:1200px; text-align:center;">
       <tr>
          <td align="right"> 
          <form name="frm" method="post" action="/packBoardList.do">
          <input type="hidden" name="pageIndex" id="pageIndex" value="1">
      <select name="searchCondition">
         <option value="packtitle" 
            <c:if test="${vo.searchCondition=='packtitle' }">selected</c:if> >제목</option>
         <option value="packloc"
             <c:if test="${vo.searchCondition=='packloc' }">selected</c:if> >지역</option>
      </select>
          <input type="text" name="searchKeyword" value="${vo.searchKeyword }">
          <button type="submit">검색</button>
          </form>
          
          </td>
       </tr>
    </table>
<!-- 검색기능 E -->   

<!-- 토탈 S -->   
<%-- <div style="margin-top:20px;">
   총 ${vo.total }건
</div> --%>
<!-- 토탈 E -->   

<!-- 리스트S -->
<table style="border:1px solid #ddd;; width:1200px; text-align:center; border-top:2px solid #474747; margin-bottom:20px;border-left:none;border-right: none;" cellpadding="5" >
   <colgroup>
      <col width="20%"/>
      <col width="15%"/>
      <col width="*%"/>
      <col width="10%"/>
      <col width="15%"/>
      <col width="10%"/>
   </colgroup>
   <tr style="background-color: #f2f2f2;">
      <th>출발/도착일자</th>
      <th>여행 지역</th>
      <th>제목</th>
      <th>글쓴이</th>
      <th>등록일</th>
      <th>조회수</th>
   </tr>
   
   <c:set var="rownumber" value="${vo.recordCountPerPage }"/>

   <c:forEach var="list" items="${resultList}" varStatus="status">
   <c:if test="${list.packsdate > nowday }">
   <tr align="center">
      <input type="hidden" value="${rownumber }">
      <%-- <td align="left"><a href="boardDetail.do?unq=${list.unq }">${list.title }</a></td> --%>
      <td>${list.packsdate } ~ ${list.packedate }</td>
      <td>${list.packloc}
      </td>
      <td align="left"><a href="packBoardDetail.do?packunq=${list.packunq}&userid=${s_userid}">
      <c:choose>
         <c:when test="${fn:length(list.packtitle) gt 20}">
            <c:out value="${fn:substring(list.packtitle,0,20)}" />..
         </c:when>                     
         <c:otherwise>
            <c:out value="${list.packtitle}" />
         </c:otherwise>
      </c:choose> 
      </a></td>
      <td>${list.bsnmid }</td>
      <td>${list.packrdate }</td>
      <td>${list.packhits }</td>
   </tr>
   </c:if>
   <c:set var="rownumber" value="${rownumber-1 }"/>
   </c:forEach>
</table>
<!-- 리스트 E -->


<!-- 토탈 및 페이징S -->
      <div style="margin-top:20px;text-align:center;">

 <!-- 페이지가 5이하일때 시작 페이지를 1로 고정 -->

<c:set var="pagelink" value="searchCondition=${vo.searchCondition}&searchKeyword=${vo.searchKeyword }"/>

   <button onclick="location='packBoardList.do?pageIndex=${vo.startPage }&${pagelink}'">first</button>
   <c:if test="${vo.beforePage > 0 }">
      <button onclick="location='packBoardList.do?pageIndex=${vo.beforePage }&${pagelink}'">Previous</button>
   </c:if>
   <c:if test="${vo.beforePage <= 0 }"><button disabled>Previous</button></c:if>
   &nbsp;
   
   <c:forEach var="i" begin="${vo.startPage }" end="${vo.endPage }">
      <a href="/packBoardList.do?pageIndex=${i }&${pagelink }">${i }</a> 
   </c:forEach>
   
   &nbsp;
   <c:if test="${vo.nextPage <= vo.lastPage }">
      <button onclick="location='packBoardList.do?pageIndex=${vo.nextPage }&${pagelink}'">Next</button>
   </c:if>
   <c:if test="${vo.nextPage > vo.lastPage }"><button disabled>Next</button>
</c:if>
   <button onclick="location='/packBoardList.do?pageIndex=${vo.lastPage }&${pagelink}'">last</button>
   
</div>
<!-- 토탈 및 페이징 E -->
<!-- 글쓰기 S -->
   <div style="margin-bottom:20px;text-align:right;">
      <c:if test="${s_bsnmid != null }">
      <button type="button" onclick="location='/packBoardWrite.do'">글쓰기</button>
      </c:if>
   </div>
<!-- 글쓰기 E -->

</section>
<!--section 끝-->



<!--footer 시작-->
<footer>
   <%@include file="../include/footer.jsp" %>
</footer>
<!--footer 끝-->
</div>


  </body>
</html>
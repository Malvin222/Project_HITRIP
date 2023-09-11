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
<link rel="stylesheet" href="../css/main.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<style>

  table {
      border-collapse: collapse;
      margin-top:10px;
      margin-bottom:10px;
  }
  a{
     text-decoration :none;
     color: black;
  }
  p{
  text-align:left;
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
/* Styling for the table */
table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
  table-layout: fixed; 
}

td {
  padding: 2px;
  text-align: right;
  word-wrap: break-word; /* Wrap long text to prevent overflow */
  max-width: 200px; /* Set a maximum width for table cells */
  vertical-align: top; /* Align content to the top of cells */
}

/* Styling for the title */
td p.title {
  font-size: 16px;
  font-weight: bold;
}
td p.addr {
  font-size: 16px;
  font-weight: bold;
}

/* Styling for the image */
td img {
  width: 220px;
  height: 140px;
  display: block; 
  object-fit:cover;
}

/* Styling for the address */


/* Alternate row coloring */
tr:nth-child(even) {
  background-color: #f2f2f2;
}
<%@include file="../css/cityNav.css" %>

</style>


<title>식당리스트</title>
</head>

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
<nav>
   <%@include file = "../include/cityNav.jsp" %>
</nav>
<!--nav 끝-->



<!--section 시작-->
<section>


<!-- 검색기능 -->   
<div >
   <table  width="1200" align="right" >
       <tr>
          <td align="right"> 
          <form name="searchFrm" method="get" action="/babList.do">
          <input type="hidden" name="pageIndex" id="pageIndex" value="1">
          <select name="searchCondition">
             <option value="addr">지역</option>
             <option value="title">이름</option>
          </select>
          <input type="text" name="searchKeyword">
          <button type="submit">검색</button>
          </form>
          </td>
       </tr>
    </table>
<!-- 검색기능 E -->
<!-- 토탈 S -->   
<div style="margin-top:20px;">
   총 ${total }건
</div>
<!-- 토탈 E -->   
<!-- 식당 목록 S -->
   <table align="center" border="0" padding="8">

      <c:set var="cnt" value="0"/>
      <c:forEach var="list" items="${list }">
      <c:set var="modifiedAddr" value="${list.addr.replace('특별자치', '')}" />
      <c:if test="${cnt % 5 == 0}"><tr></c:if>

               <td>
                  <a href="babDetail.do?contentid=${list.contentid }">
                  <p>
                     <c:if test="${list.firstimage != null }">
                       <img src="${list.firstimage}">
                       </c:if>
                       <c:if test="${list.firstimage == null }">
                       <img src="../images/hitrip.png">
                       </c:if>
                    </p>
                  <p style="font-size:16px; font-weight:bold;">${list.title }</p>
                  <p style="font-size:12px;">${modifiedAddr}</p>
                  </a>
               </td>
       <c:if test="${cnt % 5 == 4 || cnt == 10 - 1}"></tr></c:if>
         <c:set var="cnt" value="${cnt-1 }"/>

      </c:forEach>

   </table>
</div>
<!-- 식당목록 E -->

<!-- 토탈 및 페이징S -->
<div style="margin-top:20px; margin-bottom:20px; text-align:center;">
        <!-- 페이지가 5이하일때 시작 페이지를 1로 고정 -->
         <c:choose>
             <c:when test="${vo.pageIndex - 5 < 1}">
                 <c:set var="startIndex" value="1" />
             </c:when>
             <c:otherwise>
                 <c:set var="startIndex" value="${vo.pageIndex - 5}" />
             </c:otherwise>
         </c:choose>
         
    <button onclick="location='/babList.do?pageIndex=1&searchCondition=${vo.searchCondition}&searchKeyword=${vo.searchKeyword}'">first</button>
    <button onclick="location='/babList.do?pageIndex=${startIndex}&searchCondition=${vo.searchCondition}&searchKeyword=${vo.searchKeyword}'">Previous</button>
    
       <!-- 끝나는 인덱스를 10으로 고정  -->
             <!-- 페이지 +5 했을때 마지막페이지보다 크면 마지막페이지로 고정 -->
             <!-- 페이지 +5가 10보다 작으면 마지막페이지를 10 으로 고정 -->
             <!-- 그게 아니라면 +5씩 증가 -->
			<c:choose>
             <c:when test="${vo.pageIndex + 5 > vo.lastPage}">
                 <c:set var="endIndex" value="${vo.lastPage}" />
             </c:when>
             <c:when test="${vo.lastPage < 10}">
                 <c:set var="endIndex" value="${vo.lastPage}" />
             </c:when>
             <c:when test="${vo.pageIndex + 5 < 10}">
                 <c:set var="endIndex" value="10" />
             </c:when>
             <c:otherwise>
                 <c:set var="endIndex" value="${vo.pageIndex + 5}" />
             </c:otherwise>
         </c:choose>
         
         <c:forEach var="i" begin="${startIndex}" end="${endIndex}">
             <a href="/babList.do?pageIndex=${i }&searchCondition=${vo.searchCondition}&searchKeyword=${vo.searchKeyword}">${i}</a>
         </c:forEach>
         
         <button onclick="location='/babList.do?pageIndex=${endIndex}&searchCondition=${vo.searchCondition}&searchKeyword=${vo.searchKeyword}'">Next</button>
         <button onclick="location='/babList.do?pageIndex=${vo.lastPage}&searchCondition=${vo.searchCondition}&searchKeyword=${vo.searchKeyword}'">last</button>
</div>
<!-- 페이지처리 E -->

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
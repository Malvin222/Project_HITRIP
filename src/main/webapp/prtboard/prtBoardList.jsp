<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	   uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/main.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<title>동행찾기 목록</title>
</head>

<style>
img {
	width:280px;
	height:200px;
	object-fit: cover;
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
</style>

<script>
function handleLinkClick(prtunq, userid, s_bsnmid) {
    if (s_bsnmid) {
        alert("사업자 회원은 열람이 불가능합니다.");
        return false; // Prevent the link from being followed
    }
    
    // If not a business member, proceed with the link
    location.href = "prtBoardDetail.do?prtunq=" + prtunq + "&userid=" + userid;
    return false;
}
</script>

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
<c:set var="s_userid" value="${sessionScope.SessionUserID }"/>
<c:set var="s_bsnmid" value="${sessionScope.SessionBsnmID }"/>
<div style="margin-top:10px; margin-bottom:10px; text-align:center;">
</div>
<!-- 검색처리 S -->
<div style="margin-top:20px; margin-bottom:20px; text-align:right;">
<form id="searchFrm" method="post" action="/prtBoardList.do?menu=1">
		<input type="hidden" name="pageIndex" id="pageIndex" value="1">
		<select name="searchCondition">
			<option value="prttitle"
				<c:if test="${PageVO.searchCondition=='prttitle' }">selected</c:if>
			>제목</option>
			<option value="prtcontent"
				<c:if test="${PageVO.searchCondition=='prtcontent' }">selected</c:if>
			>내용</option>
			<option value="noticeplansdaterdate"
				<c:if test="${PageVO.searchCondition=='plansdate' }">selected</c:if>
			>여행시작날짜</option>
		</select>
		<input type="text" name="searchKeyword" value="${PageVO.searchKeyword }">
		<button type="submit">검색</button>
</form>
</div>
<!-- 검색처리 E -->
	<table border="0" width="1400" align="center">
		<tr><td align="left"> 총 ${total }건</td></tr>
	</table>
	
<c:forEach var="i" begin="0" end="2">
    <div style="margin-top:20px;">
        <table width="1200" height="250" style="margin-top:10px; margin-left:7px;">
     			<tr>
			    <c:forEach var="j" begin="1" end="4">
			        <c:set var="start" value="${i * 4 + j}" />
			        <c:choose>
			            <c:when test="${start <= PrtList.size()}">
			                <c:set var="list" value="${PrtList[start - 1]}" />
			                <td width="280">
							<c:choose>
							    <c:when test="${not empty list.prtsrc}">
							        <c:set var="prtsrcParts" value="${fn:split(list.prtsrc, ',')}" />
							        <c:set var="firstPart" value="${prtsrcParts[0]}" />
							        <a href="#" onclick="return handleLinkClick('${list.prtunq}', '${list.userid}', '${s_bsnmid}');">
							            <img src="<c:url value='/prtImage/${firstPart}'/>" style="width:280px; height:200px; object-fit:cover;">
							        </a>
							    </c:when>
							    <c:otherwise>
							        <a href="#" onclick="return handleLinkClick('${list.prtunq}', '${list.userid}', '${s_bsnmid}');">
							            <img src="<c:url value='/images/hitrip.png'/>" style="width:280px; height:200px; object-fit:cover;">
							        </a>
							    </c:otherwise>
							</c:choose>
			                </td>
						 </c:when>			            
					</c:choose>
				</c:forEach>
			</tr>
            <tr>
                <c:forEach var="j" begin="1" end="4">
				    <c:set var="start" value="${i * 4 + j}" />
				    <c:choose>
				        <c:when test="${start <= PrtList.size()}">
				            <c:set var="list" value="${PrtList[start - 1]}" />
				            <td width="280">
				                <c:set var="prtTitle" value="${list.prttitle}" />
				                <c:choose>
				                    <c:when test="${fn:length(prtTitle) > 18}">
				                        ${fn:substring(prtTitle, 0, 17)}...
				                    </c:when>
				                    <c:otherwise>
				                        ${prtTitle}
				                    </c:otherwise>
				                </c:choose>
				            </td>
				        </c:when>
				        <c:otherwise>
				            <td width="280"></td>
				        </c:otherwise>
				    </c:choose>
				</c:forEach>
            </tr>
            <tr height="20"></tr>
        </table>
    </div>
</c:forEach>
<!-- 토탈 및 페이징S -->
<div style="margin-top:20px; margin-bottom:20px; text-align:center;">
    	 <!-- 페이지가 5이하일때 시작 페이지를 1로 고정 -->
			<c:choose>
			    <c:when test="${PageVO.pageIndex - 5 < 1}">
			        <c:set var="startIndex" value="1" />
			    </c:when>
			    <c:otherwise>
			        <c:set var="startIndex" value="${PageVO.pageIndex - 5}" />
			    </c:otherwise>
			</c:choose>
			
    <button onclick="location='/prtBoardList.do?pageIndex=1&searchCondition=${PageVO.searchCondition}&searchKeyword=${PageVO.searchKeyword}'">first</button>
    <button onclick="location='/prtBoardList.do?pageIndex=${startIndex}&searchCondition=${PageVO.searchCondition}&searchKeyword=${PageVO.searchKeyword}'">Previous</button>
    
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
			    <a href="/prtBoardList.do?pageIndex=${i }&searchCondition=${PageVO.searchCondition}&searchKeyword=${PageVO.searchKeyword}">${i}</a>
			</c:forEach>
			
	  	 <button onclick="location='/prtBoardList.do?pageIndex=${endIndex}&searchCondition=${PageVO.searchCondition}&searchKeyword=${PageVO.searchKeyword}'">Next</button>
	  	 <button onclick="location='/prtBoardList.do?pageIndex=${PageVO.lastPage}&searchCondition=${PageVO.searchCondition}&searchKeyword=${PageVO.searchKeyword}'">last</button>
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
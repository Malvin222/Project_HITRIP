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
<link rel="stylesheet" href="../css/mainSection.css"> <!-- 외부 스타일시트 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<title>홈화면</title>
</head>
<style>
@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);

/* 전체 페이지에 세련된 폰트 적용 */
body {
    color:    #696969;
    background-color: #f7f7f7;
}

/* 섹션 제목 스타일링 */
.inner-title {
    font-size: 26px;
    font-weight: bold;
    margin-bottom: 15px;
    font-family : Jeju Hallasan;
}

/* 링크 스타일링 */
a {
    text-decoration: none;
    transition: color 0.3s ease;
}

a:hover {
    color: #0056b3;
}

/* 아이템을 위한 그리드 레이아웃 생성 */
.grid-row {
   width:1200px;
}
.grid-container {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 20px;
    margin-bottom: 30px;
}

/* 각각의 그리드 아이템 스타일링 */
.grid-item {
    background-color: #fff;
    padding: 20px;
    box-shadow: 0px 3px 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.grid-item:hover {
    transform: translateY(-5px);
    box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
}


/* 반응형을 위한 미디어 쿼리 */
@media (max-width: 1000px) {
    .grid-container {
        grid-template-columns: 1fr;
    }
}

/* Increase font size for triplist.title */
.grid-item table th a {
    font-size: 20px;
}

/* Add padding around images */
.grid-item table td img {
    margin-bottom: 10px;
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
<div class="grid-container">

    <div class="grid-row">
        <div class="grid-item">
            <div class="inner-title">동행게시판</div>
            <div class="inner-item">
            <table>
                 <c:forEach var="prtlist" items="${PrtList}" varStatus="status">
                <c:if test="${status.index < 8}">
                    <tr>
                        <td align="left">
                            <a href="/prtBoardDetail.do?prtunq=${prtlist.prtunq}&userid=${s_userid}">
                                ${prtlist.prttitle}
                            </a>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>              
            </table>
            </div>
        </div>
        <div class="grid-item">
            <div class="inner-title">국내여행지</div>
            <div class="inner-item">
            <table width="100%">
                 <c:forEach var="triplist" items="${TripList}" varStatus="status">
                <c:if test="${status.index < 8}">
                    <tr>
                        <td align="center">
                            <c:choose>
                                <c:when test="${triplist.firstimage != null}">
                                    <img src="<c:url value='${triplist.firstimage }'/>" width="90%" height="150">
                                </c:when>
                                <c:otherwise>
                                    <img src="../images/hitrip.png" width="250" height="150">
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                       <th>
                            <a href="/tripDetail.do?contentid=${triplist.contentid}">
                             ${triplist.title}
                            </a>
                        </th>
                   </tr>
                </c:if>
            </c:forEach>              
            </table>
            </div>
        </div>
        <div class="grid-item">
            <div class="inner-title">국내맛집</div>
            <div class="inner-item">
            <table width="100%">
                 <c:forEach var="bablist" items="${BabList}" varStatus="status">
                <c:if test="${status.index < 8}">
                    <tr>
                        <td align="center">
                            <c:choose>
                                <c:when test="${bablist.firstimage != null}">
                                    <img src="<c:url value='${bablist.firstimage }'/>" width="90%" height="150">
                                </c:when>
                                <c:otherwise>
                                    <img src="../images/hitrip.png" width="250" height="150">
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <a href="/babDetail.do?contentid=${bablist.contentid}">
                                ${bablist.title}
                            </a>
                        </th>
                    </tr>
                </c:if>
            </c:forEach>
         </table>          
            </div>
        </div>
    </div>
</div>
    </div>

<div class="grid-container">
    <div class="grid-row">
        <div class="grid-item">
            <div class="inner-title">패키지여행</div>
            <div class="inner-item">
            
            <table>
                 <c:forEach var="packlist" items="${PackList}" varStatus="status">
                <c:if test="${status.index < 4}">
                    <tr>
                        <td align="left">
                            <a href="/packBoardDetail.do?packunq=${packlist.packunq}">
                               <b> ${packlist.packtitle}</b>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <a href="/packBoardDetail.do?packunq=${packlist.packunq}">
                                ${packlist.packsdate} ~ ${packlist.packedate}
                            </a>
                        </td>
                        <td align="left">
                            <a href="/packBoardDetail.do?packunq=${packlist.packunq}">
                                ${packlist.packcharge}원~
                            </a>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
         </table>   
                    
            </div>
        </div>
        <div class="grid-item">
            <div class="inner-title">패키지여행후기</div>
            <div class="inner-item">
            <table>
                 <c:forEach var="packrelist" items="${PackReList}" varStatus="status">
                <c:if test="${status.index < 8}">
                    <tr>
                        <td align="left">
                            <a href="/packReviewDetail.do?packreviewunq=${packrelist.packreviewunq}">
                                ${packrelist.packreviewtitle}
                            </a>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
         </table>             
            </div>
        </div>
        
        <div class="grid-item">
            <div class="inner-title">여행후기게시판</div>
            <div class="inner-item">
            
            <table>
                  <c:forEach var="reviewlist" items="${ReviewList}" varStatus="status">
                <c:if test="${status.index < 8}">
                    <tr>
                        <td align="left">
                            <a href="/reviewDetail.do?reviewunq=${reviewlist.reviewunq}">
                                ${reviewlist.reviewtitle}
                            </a>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
         </table>       
            
            </div>
        </div>
        
    </div>
</div>

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
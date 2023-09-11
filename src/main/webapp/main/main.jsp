<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"       uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="s_bsnmid" value="${sessionScope.SessionBsnmID }"/>
<c:set var="s_userid" value="${sessionScope.SessionUserID }"/>
<c:set var="s_adminid" value="${sessionScope.SessionAdminID }"/>
<c:set var="s_adminsuperid" value="${sessionScope.SessionAdminSuperID }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/mainSection.css">
<!-- 외부 스타일시트 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<title>홈화면</title>
</head>
<style>
img {
   text-align:center;
   border-radius: 8px;
}

/* 전체 페이지에 세련된 폰트 적용 */
body {
   color: #4A4A4A;
   background-color: #f7f7f7;
}
td , td a{
   font-size: 15px;
   color: #696969;
   
}


/* 섹션 제목 스타일링 */
.inner-title {
   font-size: 20px;
   font-weight: bold;
   margin-bottom: 15px;
   background-color: #f2f2f2;
   margin-left: 20px;
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
   width: 1200px;
   height: 350px;
   
}

.grid-container {
   display: grid;
   grid-template-columns: repeat(2, 1fr);
   gap: 20px;
   margin-bottom: 30px;
}

/* 각각의 그리드 아이템 스타일링 */
.grid-item {
   background-color: #f2f2f2;
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
@media ( max-width : 1000px) {
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
<style>
.grid-item {
    position: relative;
}
button{
   all: unset;
}
.button-container-trip-prev,
.button-container-trip-next,
.button-container-bab-prev,
.button-container-bab-next {
    position: absolute;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 40px;
    height: 40px;
    cursor: pointer;
    z-index: 1;
    background: none; /* 배경 제거 */
    border: none; /* 테두리 제거 */
}

.button-container-trip-prev {
    left: 20px;
    top: 50%;
    transform: translateY(-50%);
}

.button-container-trip-next {
    right: 20px;
    top: 50%;
    transform: translateY(-50%);
}

.button-container-bab-prev {
    left: 20px;
    top: 50%;
    transform: translateY(-50%);
}

.button-container-bab-next {
    right: 20px;
    top: 50%;
    transform: translateY(-50%);
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
         <%@include file="../include/header.jsp"%>
      </header>
      <!--header 끝-->

      <!--nav 시작-->
      <nav>
         <%@include file="../include/nav.jsp"%>
      </nav>
      <!--nav 끝-->

      <!--section 시작-->
      <section>
      <br>
      <!-- 동행찾기 -->
      <span style="font-size: 18px;"><a href="/prtBoardList.do">✈동행을 찾고있어요</a></span>
               <div class="grid-row">
         <c:forEach var="prtlist" items="${PrtList}" varStatus="status">
            <c:if test="${status.index < 4}">
            <c:set var="modifisddate" value="${prtlist.plansdate.replace('2023-', '')}" />
            <c:set var="modifieddate" value="${prtlist.planedate.replace('2023-', '')}" />
                  <div class="grid-item">
                     <div class="inner-title">
                     <a href="#" onclick="return handleLinkClick('${prtlist.prtunq}', '${prtlist.userid}', '${s_bsnmid}');">
                     ${prtlist.prttrvarea }</a></div>
                     <div class="inner-item">
                        <table align="center">
                        
                           <tr>
                           <!-- 아이디 나이 -->
                              <td style="font-size:8px; text-align:left;" >
                              <a href="#" onclick="return handleLinkClick('${prtlist.prtunq}', '${prtlist.userid}', '${s_bsnmid}');">
                              <c:set var="prtUserid" value="${prtlist.userid}" />
                              <c:choose>
                                      <c:when test="${fn:length(prtUserid) > 11}">
                                          ${fn:substring(prtUserid, 0, 10)}...
                                      </c:when>
                                      <c:otherwise>
                                          ${prtUserid}
                                      </c:otherwise>
                                  </c:choose>/ ${prtlist.userage }세</a></td>
                                                               
                           <!-- 여행기간  -->
                              <td align="right"> 
                                 <a href="#" onclick="return handleLinkClick('${prtlist.prtunq}', '${prtlist.userid}', '${s_bsnmid}');">
                              ${modifisddate} ~ ${modifieddate } 
                                 </a></td>
                           </tr>
                           <!-- 동행사진 -->
                           <tr>
                               <td align="center" colspan="2">
                                   <a href="#" onclick="return handleLinkClick('${prtlist.prtunq}', '${prtlist.userid}', '${s_bsnmid}');">
                                       <c:set var="prtsrcArray" value="${fn:split(prtlist.prtsrc, ',')}" />
                                       <c:choose>
                                           <c:when test="${fn:length(prtsrcArray) > 0 && !empty prtsrcArray[0]}">
                                               <c:set var="firstImage" value="${prtsrcArray[0]}" />
                                               <img src="<c:url value='/prtImage/${firstImage}'/>" width="200" height="120"/>
                                           </c:when>
                                           <c:otherwise>
                                               <img src="../images/hitrip.png" width="200" height="120"/>
                                           </c:otherwise>
                                       </c:choose>
                                   </a>
                               </td>
                           </tr>
                           <!-- 동행제목 -->
                           <tr>
                              <td align="left"  colspan="2">
                              <a href="#" onclick="return handleLinkClick('${prtlist.prtunq}', '${prtlist.userid}', '${s_bsnmid}');">
                              <c:set var="prtTitle" value="${prtlist.prttitle}" />
                              <c:choose>
                                      <c:when test="${fn:length(prtTitle) > 14}">
                                          ${fn:substring(prtTitle, 0, 13)}...
                                      </c:when>
                                      <c:otherwise>
                                          ${prtTitle}
                                      </c:otherwise>
                                  </c:choose>
                              </a></td>
                           </tr>
                           <!-- 동행내용 -->
                           <tr>
                              <td align="left"  colspan="2">
                              <a href="#" onclick="return handleLinkClick('${prtlist.prtunq}', '${prtlist.userid}', '${s_bsnmid}');">
                              <c:set var="prtContent" value="${prtlist.prtcontent}" />
                              <c:choose>
                                      <c:when test="${fn:length(prtContent) > 31}">
                                          ${fn:substring(prtContent, 0, 30)}...
                                      </c:when>
                                      <c:otherwise>
                                          ${prtContent}
                                      </c:otherwise>
                                  </c:choose>
                              </a></td>
                           </tr>

                        </table>
                     </div>
                  </div>
            </c:if>
         </c:forEach>
               </div>

<!-- 국내여행지 -->
         <br>
         <span style="font-size: 18px;"><a href="/tripList.do">국내여행지</a></span>
         <div id="tripItemsContainer" class="grid-container">
             <div class="grid-row">
                 <div class="grid-item">
                     <div class="inner-item">
                         <table width="100%">
                             <tbody id="itemsTableBody-trip">
                                 <c:forEach var="triplist" items="${TripList}" varStatus="status">
                                     <c:if test="${status.index % 3 == 0}">
                                         <tr class="items-row">
                                             <c:forEach begin="${status.index}" end="${status.index + 2}" varStatus="innerStatus">
                                                 <c:if test="${innerStatus.index < fn:length(TripList)}">
                                                     <td align="center">
                                                         <c:set var="currentItem" value="${TripList[innerStatus.index]}"/>
                                                         <c:choose>
                                                             <c:when test="${currentItem.firstimage != null}">
                                                                 <a href="/tripDetail.do?contentid=${currentItem.contentid}">
                                                                     <img src="<c:url value='${currentItem.firstimage }'/>" width="360" height="230">
                                                                 </a>
                                                             </c:when>
                                                             <c:otherwise>
                                                                <a href="/tripDetail.do?contentid=${currentItem.contentid}">
                                                                 <img src="../images/hitrip.png" width="360" height="230">
                                                                 </a>
                                                             </c:otherwise>
                                                         </c:choose>
                                                         <br>
                                                         <a href="/tripDetail.do?contentid=${currentItem.contentid}">
                                                             ${currentItem.title}
                                                         </a>
                                                     </td>
                                                 </c:if>
                                             </c:forEach>
                                         </tr>
                                     </c:if>
                                 </c:forEach>
                             </tbody>
                         </table>
                     </div>
                  <div class="button-container-trip-prev">
                      <button class="prev-button-trip">
                          <img src="../images/prevbutton.png" style="height: 40px; width: 40px;">
                      </button>
                  </div>
                  <div class="button-container-trip-next">
                      <button class="next-button-trip">
                          <img src="../images/nextbutton.png" style="height: 40px; width: 40px;">
                      </button>
                  </div>
                 </div>
             </div>
         </div>
      <!-- 국내 맛집 -->
         <span style="font-size: 18px;"><a href="/babList.do">국내식당</a></span>
<div id="babItemsContainer" class="grid-container">
    <div class="grid-row">
        <div class="grid-item">
            <div class="inner-item">
                <table width="100%">
                    <tbody id="itemsTableBody-bab">
                        <c:forEach var="bablist" items="${BabList}" varStatus="status">
                            <c:if test="${status.index % 3 == 0}">
                                <tr class="items-row">
                                    <c:forEach begin="${status.index}" end="${status.index + 2}" varStatus="innerStatus">
                                        <c:if test="${innerStatus.index < fn:length(BabList)}">
                                            <td align="center">
                                                <c:set var="currentItem" value="${BabList[innerStatus.index]}"/>
                                                <c:choose>
                                                    <c:when test="${currentItem.firstimage != null}">
                                                        <a href="/babDetail.do?contentid=${currentItem.contentid}">
                                                            <img src="<c:url value='${currentItem.firstimage }'/>" width="360" height="230">
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                       <a href="/babDetail.do?contentid=${currentItem.contentid}">
                                                        <img src="../images/hitrip.png" width="250" height="150">
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                                <br>
                                                <a href="/babDetail.do?contentid=${currentItem.contentid}">
                                                    ${currentItem.title}
                                                </a>
                                            </td>
                                        </c:if>
                                    </c:forEach>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
    <div class="button-container-bab-prev">
        <button class="prev-button-bab">
           <img src="../images/prevbutton.png" style="height: 40px; width: 40px;">
        </button>
    </div>
    <div class="button-container-bab-next">
        <button class="next-button-bab">
           <img src="../images/nextbutton.png" style="height: 40px; width: 40px;">
        </button>
    </div>
            </div>
        </div>
    </div>
</div>
<!--패키지 여행-->
         <span style="font-size: 18px;"><a href="/packBoardList.do">패키지여행</a></span>
         <div class="grid-container">
            <div class="grid-row">
               <div class="grid-item">
                  <div class="inner-item">
                     <table width="100%">
                        <tr>
                        <!-- 패키지여행사진 -->
                           <c:forEach var="packlist" items="${PackList}"
                              varStatus="status">
                              <c:if test="${status.index < 3}">
                                 <td align="center"><a
                                    href="/packBoardDetail.do?packunq=${packlist.packunq}">
                                       <img
                                       src="<c:url value='/tripImage/${packlist.packsrc1 }'/>"
                                       width="350" height="200">
                                 </a></td>
                              </c:if>
                           </c:forEach>
                        </tr>
                        <tr>
                        <!-- 패키지여행 제목 -->
                           <c:forEach var="packlist" items="${PackList}"
                              varStatus="status">
                              <c:if test="${status.index < 3}">
                                 <td style="text-align:left; padding-left:30px;"><a
                                    href="/packBoardDetail.do?packunq=${packlist.packunq}">
                                       ${packlist.packtitle} </a></td>
                              </c:if>
                           </c:forEach>
                        </tr>
                        <tr>
                        <!-- 패키지여행 날짜 -->
                        <c:forEach var="packlist" items="${PackList}"
                              varStatus="status">
                              <c:if test="${status.index < 3}">
                                 <td align="center" margin-right="20px"><a
                                    href="/packBoardDetail.do?packunq=${packlist.packunq}">
                                       ${packlist.packsdate} ~ ${packlist.packedate} </a></td>
                              </c:if>
                           </c:forEach>
                        </tr>
                        <tr>
                        <!-- 패지키여행 금액 -->
                           <c:forEach var="packlist" items="${PackList}"
                              varStatus="status">
                              <c:if test="${status.index < 3}">
                                 <td style="text-align:right; padding-right:30px; " ><a
                                    href="/packBoardDetail.do?packunq=${packlist.packunq}">
                                       <b>${packlist.packcharge}원~</b>  </a></td>
                              </c:if>
                           </c:forEach>
                        </tr>
                     </table>
                  </div>
               </div>
            </div>
         </div>

      </section>
      <!--section 끝-->

      <!--footer 시작-->
      <footer>
         <%@include file="../include/footer.jsp"%>
      </footer>
      <!--footer 끝-->
   </div>
<script>
    const prevButton = document.querySelector(".prev-button-trip");
    const nextButton = document.querySelector(".next-button-trip");
    const itemsPerPage = 3; // 한 페이지에 표시할 아이템 개수
    let currentPage = 0;

    prevButton.style.display = "none"; // 처음에는 이전 버튼 숨김

    nextButton.addEventListener("click", () => {
        const totalPages = Math.ceil(${fn:length(TripList)} / itemsPerPage);
        if (currentPage < totalPages - 1) {
            currentPage += 1;
            showPage();
        }
        prevButton.style.display = "inline"; // 다음 버튼 클릭 시 이전 버튼을 표시
        nextButton.style.display = currentPage >= (totalPages - 1) ? "none" : "inline";
    });

    prevButton.addEventListener("click", () => {
        if (currentPage > 0) {
            currentPage -= 1;
            showPage();
        }
        prevButton.style.display = currentPage === 0 ? "none" : "inline";
        nextButton.style.display = currentPage >= (Math.ceil(${fn:length(TripList)} / itemsPerPage) - 1) ? "none" : "inline";
    });

    function showPage() {
        const itemsRows = document.querySelectorAll("#itemsTableBody-trip .items-row");
        itemsRows.forEach((row, index) => {
            if (index === currentPage) {
                row.style.display = "table-row";
            } else {
                row.style.display = "none";
            }
        });
    }

    // 초기 표시
    showPage();
</script>
<script>
    const prevButtonBab = document.querySelector(".prev-button-bab");
    const nextButtonBab = document.querySelector(".next-button-bab");
    const itemsPerPageBab = 3; // 한 페이지에 표시할 아이템 개수
    let currentPageBab = 0;

    prevButtonBab.style.display = "none"; // 처음에는 이전 버튼 숨김

    nextButtonBab.addEventListener("click", () => {
        const totalPagesBab = Math.ceil(${fn:length(BabList)} / itemsPerPageBab);
        if (currentPageBab < totalPagesBab - 1) {
            currentPageBab += 1;
            showPageBab();
        }
        prevButtonBab.style.display = "inline"; // 다음 버튼 클릭 시 이전 버튼을 표시
        nextButtonBab.style.display = currentPageBab >= (totalPagesBab - 1) ? "none" : "inline";
    });

    prevButtonBab.addEventListener("click", () => {
        if (currentPageBab > 0) {
            currentPageBab -= 1;
            showPageBab();
        }
        prevButtonBab.style.display = currentPageBab === 0 ? "none" : "inline";
        nextButtonBab.style.display = currentPageBab >= (Math.ceil(${fn:length(BabList)} / itemsPerPageBab) - 1) ? "none" : "inline";
    });

    function showPageBab() {
        const itemsRowsBab = document.querySelectorAll("#itemsTableBody-bab .items-row");
        itemsRowsBab.forEach((row, index) => {
            if (index === currentPageBab) {
                row.style.display = "table-row";
            } else {
                row.style.display = "none";
            }
        });
    }

    // 초기 표시
    showPageBab();
</script>
</body>
</html>
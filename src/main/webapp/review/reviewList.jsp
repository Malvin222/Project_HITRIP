<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" 	   uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행후기 리스트</title>
<link rel="stylesheet" href="../css/main.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
</head>

<style>
img {
	width: 200px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
	table-layout: fixed; /* Prevent cells from expanding */
}
.div1 {
	width: 1200px;
	text-align: right;
	margin-bottom: 20px;
}


a {
	text-decoration: none;
	color: black;
}

a:hover {
	color: #708090;
}

p {
	text-align: center;
	margin: 10px;
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

td {
	border: 1px solid #ccc;
	padding: 10px;
	text-align: center;
	word-wrap: break-word; /* Wrap long text to prevent overflow */
	max-width: 200px; /* Set a maximum width for table cells */
	vertical-align: top; /* Align content to the top of cells */
}

.search td {
	border: 0px solid #ccc;
	text-align: right;
}

/* Styling for the title */
td p.title {
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 5px;
}

/* Styling for the image */
td img {
	
}

/* Styling for the address */
td p.addr {
	margin-top: 5px;
}

/* Alternate row coloring */
tr:nth-child(even) {
	background-color: #f2f2f2;
}
</style>

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

		<!--section 시작 -->
		<section>
			<c:set var="s_userid" value="${sessionScope.SessionUserID }" />

			<!-- 검색기능 S -->
			<div
				style="margin-top: 20px; margin-bottom: 20px; text-align: right;">
				<form name="frm" method="post" action="/reviewList.do">
					<select name="searchCondition">
						<option value="reviewtitle">제목</option>
						<option value="userid">아이디</option>
					</select> <input type="text" name="searchKeyword">
					<button type="submit">검색</button>
				</form>
			</div>
			<!-- 검색기능 E -->

			<!-- 토탈 S -->
			<div style="margin-top: 10px;">총 ${vo.total }건</div>
			<!-- 토탈 E -->

			<!-- 여행후기 목록 S -->
			<table style="font-size:12px; padding:8px;">
				<c:set var="cnt" value="0" />
				<c:forEach var="list" items="${resultList }">
					<c:if test="${cnt % 5 == 0}">
						<tr>
					</c:if>
					<td>
						<p>여행기간 ${list.reviewsdate }~${list.reviewedate }</p>
						<p>
							<a
								href="/reviewDetail.do?reviewunq=${list.reviewunq}&userid=${s_userid}">
								<c:if test="${list.reviewsrc != null }">
									<img src="<c:url value='/reviewImage/${list.reviewsrc }'/>"
										width="200" height="100">
								</c:if> <c:if test="${list.reviewsrc == null }">
									<img src="../images/hitrip.png" width="200" height="100">
								</c:if>
							</a>
						</p>
						<p style="font-size: 18px; font-weight: bold;">
							<a
								href="/reviewDetail.do?reviewunq=${list.reviewunq}&userid=${s_userid}">
								<!-- 리스트에 제목은 8자까지만 출력되게 --> 
								<c:choose>
									<c:when test="${fn:length(list.reviewtitle) gt 8}">
										<c:out value="${fn:substring(list.reviewtitle,0,8)}" />..
					  				</c:when>
									<c:otherwise>
										<c:out value="${list.reviewtitle}" />
									</c:otherwise>
								</c:choose> 
								<c:if test="${list.reviewrdate >= nowday }">
									<img src="/reviewImage/newicon.png"
										style="width: 20px; height: 20px;">
								</c:if>
							</a>
						</p>
						<p style="font-size: 14px;">
							<!-- 리스트에 내용은 13자까지만 출력되게 -->
							<c:choose>
								<c:when test="${fn:length(list.reviewcontent) gt 13}">
									<c:out value="${fn:substring(list.reviewcontent,0,13)}" />..
					  			</c:when>
								<c:otherwise>
									<c:out value="${list.reviewcontent}" />
								</c:otherwise>
							</c:choose>
							<!--  <a href="/reviewDetail.do?reviewunq=${list.reviewunq}">${list.reviewcontent }</a>-->
						</p>

						<p>${list.userid }/ ${list.reviewrdate }</p>

						<p>조회수 ${list.reviewhits } / 추천수 ${list.reviewstar }</p>
					</td>
					<c:if test="${cnt % 5 == 4 || cnt == 10 - 1}">
						</tr>
					</c:if>
					<c:set var="cnt" value="${cnt-1 }" />

				</c:forEach>
			</table>
			
			<!-- 여행후기 목록 E -->


			<!-- 페이징 S -->
			<div style="margin-top: 20px; text-align: center;">

				<c:set var="pagelink"
					value="searchCondition=${vo.searchCondition}&searchKeyword=${vo.searchKeyword }" />

				<button
					onclick="location='reviewList.do?pageIndex=${vo.startPage }'">first</button>
				<c:if test="${vo.beforePage > 0 }">
					<button
						onclick="location='reviewList.do?pageIndex=${vo.beforePage }&${pagelink }'">Previous</button>
				</c:if>
				<c:if test="${vo.beforePage <= 0 }">
					<button disabled>Previous</button>
				</c:if>
				&nbsp;

				<c:forEach var="i" begin="${vo.startPage }" end="${vo.endPage }">
					<a href="/reviewList.do?pageIndex=${i }&${pagelink }">${i }</a>
				</c:forEach>

				&nbsp;
				<c:if test="${vo.nextPage <= vo.lastPage }">
					<button
						onclick="location='reviewList.do?pageIndex=${vo.nextPage }&${pagelink }'">Next</button>
				</c:if>
				<c:if test="${vo.nextPage > vo.lastPage }">
					<button disabled>Next</button>
				</c:if>
				<button
					onclick="location='/reviewList.do?pageIndex=${vo.lastPage }'">last</button>
			</div>
			<!-- 페이징 E -->

			<!-- 글 등록 S -->
			<div class="div1">
				<c:if test="${s_userid != null }">
					<button onclick="location='/reviewWrite.do'">글 등록</button>
				</c:if>
			</div>
			<!-- 글 등록 E -->

		</section>
		<!--section 끝-->




		<!--footer 시작-->
		<footer>
			<%@include file="../include/footer.jsp"%>
		</footer>
		<!--footer 끝-->
	</div>
</body>
</html>
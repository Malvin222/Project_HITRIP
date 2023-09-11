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
<title>공지사항상세보기</title>	
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

/* Button styles */
.button-container {
    text-align: right; /* Align buttons to the right */
    margin-top: 20px;
}
.button-container::after {
    content: "";
    display: table;
    clear: both;
}
.button-container button {
    padding: 10px 20px;
    border: none;
    background-color: #333;
    color: white;
    cursor: pointer;
    margin-left: 10px; /* Adjust margin to align buttons with the content */
}

/* Adjust the form layout */
.content_area table {
    width: 100%;
}
.content_area th, .content_area td {
    text-align: left;
    padding: 8px;
}
section {
    background-color: #f9f9f9; /* Change background color */
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
    border: 1px solid #e5e5e5; /* Add a subtle border */
    transition: background-color 0.3s ease; /* Add a smooth transition effect */
}

section:hover {
    background-color: #f5f5f5; /* Change background color on hover */
}
</style>

<script>
$(function(){
	$("#button1").click(function(){
		location = "/noticeList.do";
	});	
});

</script>

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
<section>
<div class="content_area">
    <form name="frm" id="frm">
        <input type="hidden" name="noticeunq" value="${Noticevo.noticeunq }">
        
        <h1>${Noticevo.noticetitle }</h1>
        
		<div class="meta-container">
		    <p class="meta-item" style="background-color: #f5f5f5; padding: 10px;">
		        조회수: ${Noticevo.noticehits } | 작성자: ${Noticevo.noticename } | 작성일: ${Noticevo.noticerdate }
		    </p>
		</div>
        
        <div class="divider"></div>
        
        <div class="board-container">
            <table align="center">
                <tr> 
                    <td height="100" style="text-align:left;">${Noticevo.noticecontent }</td>
                </tr>
            </table>
        </div>
        
        <div class="button-container">
            <button type="button" id="button1">목록으로</button>
        </div>
    </form>
</div>

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
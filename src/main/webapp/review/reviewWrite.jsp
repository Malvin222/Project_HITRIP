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
<title>여행후기 등록</title>
<link rel="stylesheet" href="../css/main.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
</head>
<style>
img {
    width: 100px;
    height: 50px;
}
table {
	  width: 800px;
    border-collapse: collapse;
    margin-top:10px;
    margin-bottom:10px;
}
  
td,th {
  border: 1px solid #ccc;
  padding: 10px;
  text-align: center;
  word-wrap: break-word; /* Wrap long text to prevent overflow */
  max-width: 200px; /* Set a maximum width for table cells */
  vertical-align: top; /* Align content to the top of cells */
}
input {
	width: 100%;
}
textarea {
	width: 100%;
	height: 300px;
}

p {
	text-align:center;
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
  width: 100px;
  height: 50px;
  display: block;
  margin: 0 auto 5px;
}

/* Styling for the address */
td p.addr {
  margin-top: 5px;
}
</style>
<script>
$(function(){
	
	$("#submit_button").click(function(){
		
		let reviewtitle = $.trim($("#reviewtitle").val());
		let reviewsdate = $("#reviewsdate").val();
		let reviewedate = $("#reviewedate").val();
		let reviewcontent = $("#reviewcontent").val();
		let nowday = $("#nowday").val();
		
		if( reviewtitle == "" ) {
			alert("제목은 필수 등록사항입니다.");
			$("#reviewtitle").focus();
			return false;
		}
		if( reviewsdate == "" ) {
			alert("여행 시작일은 필수 등록사항입니다.");
			$("#reviewsdate").focus();
			return false;
		}
		if( reviewedate == "" ) {
			alert("여행 종료일은 필수 등록사항입니다.");
			$("#reviewedate").focus();
			return false;
		}
		if( reviewsdate > reviewedate ){
			alert("여행 시작 및 종료일자가 올바르지 않습니다.")
			return false;
		}
		if( reviewcontent == "" ) {
			alert("내용은 필수 등록사항입니다.");
			$("#reviewcontent").focus();
			return false;
		}
		if( reviewedate > nowday ) {
			alert("여행 일자가 올바르지 않습니다.");
			return false;
		}
		
		$("#reviewtitle").val(reviewtitle);
		
		var form = new FormData(document.getElementById('frm2'));      
		$.ajax({
			/*서버송신설정*/
			type : "POST",
			data :  form,
			url  : "/reviewWriteSave.do",
			
			processData: false, // 파일이 전송되는 경우의 설정
  			contentType: false, // 파일이 전송되는 경우의 설정
  			
  			/*서버응답설정*/
			datatype : "text", // json
			success : function(data) {
				 if(data == "ok") {
					alert("여행 후기가 등록되었습니다.");
					location = "/reviewList.do";
				 } else {
					 alert("저장실패!");
				 }
			 },
			 error : function() {
				 alert("전송실패");
			 }
		});
	});
});
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
<input type="hidden" name="reviewunq" id="reviewunq">
<input type="hidden" name="nowday" id="nowday" value="${nowday }">
<div class="content_area">
<form id="frm2" enctype="multipart/form-data">
	<table class="board1" align="center">
		<colgroup>
			<col width="20%"/>
			<col width="*"/>
		</colgroup>
		<tr>
			<th>제목</th>
			<td>
			<input type="text" name="reviewtitle" id="reviewtitle" placeholder="">
			</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>
			<input type="text" name="userid" id="userid" value="${s_userid }" readonly>
			</td>
		</tr>
		<tr>
			<th>여행시작일</th>
			<td>
			<input type="date" name="reviewsdate" id="reviewsdate" placeholder=""><br>
			</td>
		</tr>
		<tr>
			<th>여행종료일</th>
			<td>
			<input type="date" name="reviewedate" id="reviewedate" placeholder=""><br>
			</td>
		</tr>
		<tr>
			<th>사진</th>
			<td>
			<input type="file" name="reviewsrc" id="reviewsrc" style="width:50%;line-height:2.0;">
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
			<textarea id="reviewcontent" name="reviewcontent"></textarea>
			</td>
		</tr>
	</table>
</div>
<div class="page_number_area" style="margin-top:20px; margin-bottom:20px; text-align:center;">
	<button type="submit" id="submit_button" onclick="return false;">등록하기</button>
	<button type="reset">작성취소</button>
</div>


</form>
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

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

<title>여행 후기 수정</title>
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
		
		let reviewtitle  = $.trim($("#reviewtitle").val());
		let reviewsdate  = $("#reviewsdate").val();
		let reviewedate  = $("#reviewedate").val();
		let reviewunq  = $("#reviewunq").val();
		let reviewcontent  = $("#reviewcontent").val();
		
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
		if( reviewcontent == "" ) {
			alert("내용은 필수 등록사항입니다.");
			$("#reviewcontent").focus();
			return false;
		}
		
		$("#reviewtitle").val(reviewtitle);
		
		var form = new FormData(document.getElementById('frm2'));      
		$.ajax({
			/*서버송신설정*/
			type : "POST",
			data :  form,
			url  : "/reviewModifySave.do",
			
			processData: false, // 파일이 전송되는 경우의 설정
  			contentType: false, // 파일이 전송되는 경우의 설정
  			
  			/*서버응답설정*/
			datatype : "text", // json
			success : function(data) {
				 if(data == "ok") {
					alert("여행후기가 변경되었습니다.");
					location = "/reviewList.do";
				 } else {
					 alert("수정실패");
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

	<div class="content_area">

	<form id="frm2" enctype="multipart/form-data">
	<input type="hidden" name="reviewunq" id="reviewunq" value="${vo.reviewunq }">
		<table class="board1" align="center" >
			<tr>
				<th>제목</th>
				<td>
				<input type="text" name="reviewtitle" id="reviewtitle" value="${vo.reviewtitle}">
				</td>
			</tr>
			<tr>
				<th>아이디</th>
				<td>
				<input type="text" name="userid" id="userid" value="${vo.userid }" readonly>
				</td>
			</tr>
			<tr>
				<th>여행시작일</th>
				<td>
				<input type="date" name="reviewsdate" id="reviewsdate" value="${vo.reviewsdate }"><br>
				</td>
			</tr>
			<tr>
				<th>여행종료일</th>
				<td>
				<input type="date" name="reviewedate" id="reviewedate" value="${vo.reviewedate }"><br>
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
				<textarea id="reviewcontent" name="reviewcontent"> ${vo.reviewcontent } </textarea>
				</td>
			</tr>
	
		</table>
	</div>
	
	<div class="page_number_area" align="center">
		<button type="submit" id="submit_button" onclick="return false;">수정하기</button>
		<button type="reset">작성취소</button>
	</div>
	
	<div style="height:100px;"></div>
	
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
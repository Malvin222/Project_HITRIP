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

<title>패키지여행 수정</title>
</head>
<style>
.board1 {
	width:700px;
	margin-top:10px;
	margin-bottom:10px;
	border-spacing:10px;
}
textarea {
	width: 400px;
	height: 200px;
}

</style>
<script>
$(function(){
	
	$("#submit_button").click(function(){
		
		
		let packreviewtitle 	= $("#packreviewtitle").val();
		let packreviewcontent 	= $("#packreviewcontent").val();
		
		if( packreviewtitle == "" ) {
			alert("제목을 입력해주세요");
			return false;
		}
		if(packreviewcontent == "" ) {
			alert("내용을 입력해주세요");
			return false;
		}
		
		var form = new FormData(document.getElementById('frm2'));      
		$.ajax({
			/*서버송신설정*/
			type : "POST",
			data :  form,
			url  : "/packReviewModifySave.do",
			
			processData: false, // 파일이 전송되는 경우의 설정
  			contentType: false, // 파일이 전송되는 경우의 설정
  			
  			/*서버응답설정*/
			datatype : "text", // json
			success : function(data) {
				 if(data == "ok") {
					alert("패키지여행 후기가 수정되었습니다.");
					location = "/packReviewList.do";
				 } else {
					 alert("비밀번호가 올바르지 않습니다!");
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
<c:set var="s_bsnmid" value="${sessionScope.SessionBsnmID }"/>
<c:set var="s_userid" value="${sessionScope.SessionUserID }"/>
	
	<div class="content_area">
	
	<form id="frm2" enctype="multipart/form-data">
	<input type="hidden" name="packreviewunq" id="packreviewunq" value="${vo.packreviewunq }">
	<table class="board1" align="center" style="margin-top:30px;">
   <tr>
      <th width="15%">패키지제목</th>
      <td width="*">${vo.packtitle }</td>
   </tr>
   <tr>
      <th>아이디</th>
      <td>${vo.userid }</td>
   </tr>
 	<tr>
		<th>여행일</th>
		<td>
		${vo.packsdate } ~ ${vo.packedate }
		</td>
	</tr>
	<tr>
		<th>사진</th>
		<td>
		<input type="file" name="packreviewsrc1" id="packreviewsrc1" style="width:50%;line-height:2.0;">
		</td>
	</tr>
	<tr>
		<th>사진2</th>
		<td>
		<input type="file" name="packreviewsrc2" id="packreviewsrc2" style="width:50%;line-height:2.0;">
		</td>
	</tr>
	<tr>
		<th>제목</th>
		<td>
		<input type="text" name="packreviewtitle" id="packreviewtitle" value="${vo.packreviewtitle }" style="width:50%;line-height:2.0;">
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td>
		<textarea id="packreviewcontent" name="packreviewcontent"> ${vo.packreviewcontent } </textarea>
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
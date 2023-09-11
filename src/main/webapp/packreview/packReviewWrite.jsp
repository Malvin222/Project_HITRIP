<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="s_bsnmid" value="${sessionScope.SessionBsnmID }"/>
<c:set var="s_userid" value="${sessionScope.SessionUserID }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/main.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<title>패키지여행 등록</title>
</head>
<style>
.board1 {
	width:700px;
	margin-top:10px;
	margin-bottom:10px;
	border-spacing:10px;
}
textarea {
   width: 100%;
   height: 300px;
	resize: none;
}

</style>
<script>
function fn_pack() {
	let a1 = $("#pack").val();
	let a2 = a1.split("|");
	

	
    //중복체크
    let packReviewCount = $("#packReviewCount").val();
    let form = new FormData();
    form.append("packunq", a2[4]);
    form.append("userid", $("#userid").val()); 
	$.ajax({
		/*서버송신설정*/
		type : "POST",
		data :  form,
		url  : "/packReviewCount.do",
        processData: false,
        contentType: false,
			/*서버응답설정*/
		datatype : "text", // json
		success : function(data) {
			 if(data == "aa") {
				alert("후기가 작성된 패키지여행입니다..!");
						
						/* 셀렉상자 초기화 	$("#pack").val("default");  
						 $("#pack").prop("selectedIndex", 0); */

						$("#pack").val("");
				        $("#packtitle_area_input").val("");
		                $("#packloc_area_input").val("");
		                $("#packsdate_area_input").val("");
		                $("#packedate_area_input").val("");
		                $("#packunq_area_input").val("");
					return false;
			 }else{
					$("#packtitle_area_input").val(a2[0]);
					$("#packloc_area_input").val(a2[1]);
					$("#packsdate_area_input").val(a2[2]);
					$("#packedate_area_input").val(a2[3]);
					$("#packunq_area_input").val(a2[4]);
				 
			 }
		 },
		 error : function() {
			alert(data);
			 alert("전송실패");
		 }
	});
	
}

$(function(){
	
	
	$("#submit_button").click(function(){
		
		
		let packtitle = $("#packtitle").val();
		let packreviewtitle = $("#packreviewtitle").val();
		let packreviewpass = $.trim($("#packreviewpass").val());
		let packreviewcontent = $("#packreviewcontent").val();
        //끝나는 날짜 체크
		let packedate = $("#packedate_area_input").val();
        let now = $("#nowday").val();

		if( packtitle == "" ) {
			alert("패키지를 선택해주세요");
			return false;
		}
		if( packreviewtitle == "" ) {
			alert("제목을 입력해주세요");
			return false;
		}
		if( packreviewpass == "" ) {
			alert("비밀번호를 입력해주세요");
			return false;
		}
		if( packreviewcontent == "" ) {
			alert("내용을 입력해주세요");
			return false;
		}
		if( packedate > now ) {
			alert("종료된 패키지 여행이 아닙니다.");
			return false;
		}

		
		
		var form = new FormData(document.getElementById('frm2'));      
		$.ajax({
			/*서버송신설정*/
			type : "POST",
			data :  form,
			url  : "/packReviewWriteSave.do",
			
			processData: false, // 파일이 전송되는 경우의 설정
  			contentType: false, // 파일이 전송되는 경우의 설정
  			
  			/*서버응답설정*/
			datatype : "text", // json
			success : function(data) {
				 if(data == "ok") {
					alert("패키지여행 후기가 등록되었습니다.");
					location = "/packReviewList.do";
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
<body onload="">
    
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
<!-- 패키지여행 unq 히든 -->
<input type="hidden" name="packunq" id="packunq">

	<div class="content_area">
	<!-- 저장 폼 -->
	<form id="frm2" enctype="multipart/form-data">
		<input type="hidden" name="nowday" id="nowday" value="${nowday }">
		<input type="hidden" name="packReviewCount" id="packReviewCount" value="${packReviewCount }">
		<table class="board1" align="center" >
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="userid" id="userid" value="${s_userid}" placeholder="" readonly="readonly" >
				</td>
			</tr>
			<tr>
				<th>패키지 제목</th>
				<td>
					<select name="pack" id="pack" onchange="fn_pack(this.value)">
						 <option value="" disabled selected>패키지를 선택해주세요.</option>
						 <c:forEach var="list" items="${packReserve}" varStatus="status" >
						 	<option value="${list.packtitle }|${list.packloc}|${list.packsdate}|${list.packedate}|${list.packunq}" >${list.packtitle }</option>
						 </c:forEach>
					</select>
					<input type="hidden" name="packtitle" id="packtitle_area_input">
					<input type="hidden" name="packunq" id="packunq_area_input">
				</td>
			</tr>
			<tr>
				<th>지역</th>
				<td>
					<input type="text" name="packloc" id="packloc_area_input" readonly>					
				</td>
			</tr>
			<tr>
				<th>여행날짜</th>
				<td>
				시작날짜:<input type="date" name="packsdate" id="packsdate_area_input" readonly><br>
				종료날짜:<input type="date" name="packedate" id="packedate_area_input" readonly>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
				<input type="text" name="packreviewtitle" id="packreviewtitle">
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
				<input type="password" name="packreviewpass" id="packreviewpass" placeholder="">
				</td>
			</tr> 
			<tr>
				<th>패키지 사진</th>
				<td>
				<input type="file" name="packreviewsrc1" id="packreviewsrc1" style="width:50%;line-height:2.0;">
				<input type="file" name="packreviewsrc2" id="packreviewsrc2" style="width:50%">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="packreviewcontent" id="packreviewcontent" >
				
				</textarea></td>
			</tr>
		</table>
	</div>
	
	<div class="page_number_area" align="center">
		<button type="submit" id="submit_button" onclick="return false;">등록하기</button>
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
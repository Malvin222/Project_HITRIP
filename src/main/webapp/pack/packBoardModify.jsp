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
//요금 인풋상자에 숫자만 가능
function inputNumberOnly(el) {
    el.value = el.value.replace(/[^0-9]/g, '');
  }
  
$(function(){
	
	$("#submit_button").click(function(){
		
		
		let packunq = $("#packunq").val();
		let bsnmid = $("#bsnmid").val();
		let packtitle = $("#packtitle").val();
		let packloc = $.trim($("#packloc").val());
		let packsdate  = $.trim($("#packsdate").val());
		let packedate  = $.trim($("#packedate").val());
		let packcharge  = $.trim($("#packcharge").val());
		let packsrc1  = $("#packsrc1").val();
		
		if( packtitle == "" ) {
			alert("패키지 제목을 입력해주세요");
			return false;
		}
		if( packloc == "" ) {
			alert("패키지 위치를 선택해주세요");
			return false;
		}
		if( packsdate == "" ) {
			alert("패키지여해행 시작날짜를 입력해주세요");
			return false;
		}
		if( packedate == "" ) {
			alert("패키지여행 종료날짜를 입력해주세요");
			return false;
		}
		if( packcharge == "" ) {
			alert("패키지여행 요금을 입력해주세요");
			return false;
		}
		if( packsrc1 == "" ) {
			alert("패키지여행 사진을 등록해주세요");
			return false;
		}
		
		
		$("#packunq").val(packunq);
		$("#bsnmid").val(bsnmid);
		$("#packtitle").val(packtitle);
		$("#packloc").val(packloc);
		$("#packsdate").val(packsdate);
		$("#packedate").val(packedate);
		$("#packcharge").val(packcharge);
		
		
		var form = new FormData(document.getElementById('frm2'));      
		$.ajax({
			/*서버송신설정*/
			type : "POST",
			data :  form,
			url  : "/packBoardModifySave.do",
			
			processData: false, // 파일이 전송되는 경우의 설정
  			contentType: false, // 파일이 전송되는 경우의 설정
  			
  			/*서버응답설정*/
			datatype : "text", // json
			success : function(data) {
				 if(data == "ok") {
					alert("패키지여행이 변경되었습니다!");
					location = "/packBoardList.do";
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
	<div class="content_area">
	
	<form id="frm2" enctype="multipart/form-data">
		<input type="hidden" name="packunq" id="packunq" value="${vo.packunq }">
		<table class="board1" align="center" >
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="bsnmid" id="bsnmid" value="${vo.bsnmid }" placeholder="" readonly="readonly" >
				</td>
			</tr>
			<tr>
				<th>상품제목</th>
				<td>
				<input type="text" name="packtitle" id="packtitle" value="${vo.packtitle}" placeholder="">
				</td>
			</tr>
			<tr>
				<th>지역</th>
				<td>
				<input type="radio" name="packloc" id="packloc" value="서울" <c:if test="${vo.packloc eq '서울' }">checked</c:if> >서울
				<input type="radio" name="packloc" id="packloc" value="인천" <c:if test="${vo.packloc eq '인천' }">checked</c:if>>인천
				<input type="radio" name="packloc" id="packloc" value="대전" <c:if test="${vo.packloc eq '대전' }">checked</c:if>>대전
				<input type="radio" name="packloc" id="packloc" value="대구" <c:if test="${vo.packloc eq '대구' }">checked</c:if>>대구
				<input type="radio" name="packloc" id="packloc" value="광주" <c:if test="${vo.packloc eq '광주' }">checked</c:if>>광주
				<input type="radio" name="packloc" id="packloc" value="부산" <c:if test="${vo.packloc eq '부산' }">checked</c:if>>부산
				<input type="radio" name="packloc" id="packloc" value="울산" <c:if test="${vo.packloc eq '울산' }">checked</c:if>>울산
				<input type="radio" name="packloc" id="packloc" value="세종" <c:if test="${vo.packloc eq '세종' }">checked</c:if>>세종 <br>
				<input type="radio" name="packloc" id="packloc" value="경기" <c:if test="${vo.packloc eq '경기' }">checked</c:if>>경기
				<input type="radio" name="packloc" id="packloc" value="강원" <c:if test="${vo.packloc eq '강원' }">checked</c:if>>강원
				<input type="radio" name="packloc" id="packloc" value="충북" <c:if test="${vo.packloc eq '충북' }">checked</c:if>>충북
				<input type="radio" name="packloc" id="packloc" value="충남" <c:if test="${vo.packloc eq '충남' }">checked</c:if>>충남
				<input type="radio" name="packloc" id="packloc" value="경북" <c:if test="${vo.packloc eq '경북' }">checked</c:if>>경북
				<input type="radio" name="packloc" id="packloc" value="경남" <c:if test="${vo.packloc eq '경남' }">checked</c:if>>경남
				<input type="radio" name="packloc" id="packloc" value="전북" <c:if test="${vo.packloc eq '전북' }">checked</c:if>>전북
				<input type="radio" name="packloc" id="packloc" value="전남" <c:if test="${vo.packloc eq '전남' }">checked</c:if>>전남
				<input type="radio" name="packloc" id="packloc" value="제주" <c:if test="${vo.packloc eq '제주' }">checked</c:if>>제주
				</td>
			</tr>
			<tr>
				<th>여행날짜</th>
				<td>
				시작날짜:<input type="date" name="packsdate" id="packsdate" value="${vo.packsdate }"><br>
				종료날짜:<input type="date" name="packedate" id="packedate" value="${vo.packedate }">
				</td>
			</tr>
			<tr>
				<th>여행요금</th>
				<td>
				<input type="text" name="packcharge" id="packcharge" value="" oninput="inputNumberOnly(this)">
				</td>
			</tr>
			<tr>
				<th>패키지 사진</th>
				<td>
				<input type="file" name="packsrc1" id="packsrc1" value="${vo.packsrc1 }" style="width:50%;line-height:2.0;">
				<input type="file" name="packsrc2" id="packsrc2" style="width:50%">
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
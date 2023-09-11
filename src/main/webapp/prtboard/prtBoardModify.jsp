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
<title>동행찾기</title>
</head>

<style>
.board1 {
	width:700px;
	margin-top:10px;
	margin-bottom:10px;
	border-spacing:10px;
}
textarea {
    width: 1050px;
    height: 300px; /* 조정된 높이 */
    padding: 5px;
    border: 1px solid #ccc;
    resize: none;
}
.file-input {
  display: block;
  margin-bottom: 10px;
}
/* 테이블 스타일 */
table {
  border-collapse: collapse;
  width: 100%;
  margin-top: 20px;
  margin-bottom: 20px;
}

th, td {
  padding: 10px;
  text-align: left;
  vertical-align: top;
}

th {
  width: 15%;
  background-color: #f2f2f2;
}

td {
  width: 85%;
}

/* 라디오 버튼 스타일 */
input[type="radio"] {
  margin-right: 5px;
}

/* 버튼 컨테이너 스타일 */
div[style="margin-top:10px; margin-bottom:10px; text-align:center;"] {
  margin: 20px auto;
}

button {
  padding: 10px 20px;
  margin-right: 10px;
  font-size: 16px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

button#reset {
  background-color: #ccc;
}

button:hover {
  background-color: #0056b3;
}

/* 파일 업로드 관련 스타일 */
.file-input {
  display: block;
  margin-bottom: 10px;
  width: 50%;
}

/* 이미지 스타일 */
img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border: 1px solid #ccc;
}

/* 파일 추가 버튼 스타일 */
button#addFile {
  padding: 5px 10px;
  font-size: 14px;
  background-color: #f0f0f0;
  border: 1px solid #ccc;
  border-radius: 5px;
  color: black; /* 글자 색을 검정색으로 설정 */
  cursor: pointer;
  transition: background-color 0.3s ease;
}

button#addFile:hover {
  background-color: #ddd;
}

/* 모바일 반응형 스타일 */
@media screen and (max-width: 768px) {
  /* 버튼 컨테이너의 여백 조정 */
  div[style="margin-top:10px; margin-bottom:10px; text-align:center;"] {
    margin: 10px auto;
  }

  /* 파일 업로드 입력 너비 조정 */
  .file-input {
    width: 100%;
  }

  /* 이미지 크기 조정 */
  img {
    max-width: 100%;
    height: auto;
  }
}
</style>

<script>
$(function(){
	
	$("#submit_button").click(function(){	
		
		let prtunq = $("#prtunq").val();
		let userid = $("#userid").val();
		let prttitle = $("#prttitle").val();
		let prtpass = $("#prtpass").val();
		let prttrvarea = $.trim($("#prttrvarea").val());
		let plansdate  = $.trim($("#plansdate").val());
		let planedate  = $.trim($("#planedate").val());
		let prtcontent  = $.trim($("#prtcontent").val());
		
		if( prttitle == "" ) {
			alert("제목을 입력해주세요");
			return false;
		}
		if( prtpass == "" ) {
			alert("비밀번호를 입력해주세요");
			return false;
		}
		if( prttrvarea == "" ) {
			alert("지역을 입력해주세요");
			return false;
		}
		if( plansdate == "" ) {
			alert("동행 시작날짜를 입력해주세요");
			return false;
		}
		if( planedate == "" ) {
			alert("동행 종료날짜를 입력해주세요");
			return false;
		}
		if( prtcontent == "" ) {
			alert("내용을 입력해주세요");
			return false;
		}
		
		
		$("#prtunq").val(prtunq);
		$("#userid").val(userid);
		$("#prttitle").val(prttitle);
		$("#prtpass").val(prtpass);
		$("#prttrvarea").val(prttrvarea);
		$("#plansdate").val(plansdate);
		$("#planedate").val(planedate);
		$("#prtcontent").val(prtcontent);
		
		
		var form = new FormData(document.getElementById('frm'));      
		$.ajax({
			/*서버송신설정*/
			type : "POST",
			data :  form,
			url  : "/prtBoardModifySave.do",
			
			processData: false, // 파일이 전송되는 경우의 설정
  			contentType: false, // 파일이 전송되는 경우의 설정
  			
  			/*서버응답설정*/
			datatype : "text", // json
			success : function(data) {
				 if(data == "ok") {
					alert("동행게시글이 변경되었습니다.");
					location = "/prtBoardList.do";
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
<c:set var="s_userid" value="${sessionScope.SessionUserID }"/>
<form name="frm" id="frm" method="post">
<input type="hidden" name="prtunq" id="prtunq" value="${PrtVO.prtunq }">
<input type="hidden" name="userid" id="userid" value="${s_userid }">
 <table border="1" width="1200" style="margin-top:20px; margin-bottom:20px;">
 	<tr>
 		<th width="10%">제목</th>
 		<td><input type="text" name="prttitle" id="prttitle" value="${PrtVO.prttitle }"> </td>
 	</tr>
 	<tr>
 		<th>성별</th>
 		<td>${PrtVO.usergender }</td>
 	</tr> 	
 	<tr>
 		<th>나이</th>
 		<td>${PrtVO.userage }세</td>
 	</tr>
 	<tr>
 		<th>여행 일자</th>
 		<td><input type="date" name="plansdate" id="plansdate" value="${PrtVO.plansdate}">
 		 ~ 
 		 <input type="date" name="planedate" id="planedate" value="${PrtVO.planedate }"></td>
 	</tr>
 	<tr>
 		<th>여행 지역</th>
 		<th> 		
			<input type="radio" name="prttrvarea" id="prttrvarea" value="서울" ${PrtVO.prttrvarea == '서울' ? 'checked' : ''}>서울
			<input type="radio" name="prttrvarea" id="prttrvarea" value="인천" ${PrtVO.prttrvarea == '인천' ? 'checked' : ''}>인천
			<input type="radio" name="prttrvarea" id="prttrvarea" value="대전" ${PrtVO.prttrvarea == '대전' ? 'checked' : ''}>대전
			<input type="radio" name="prttrvarea" id="prttrvarea" value="대구" ${PrtVO.prttrvarea == '대구' ? 'checked' : ''}>대구
			<input type="radio" name="prttrvarea" id="prttrvarea" value="광주" ${PrtVO.prttrvarea == '광주' ? 'checked' : ''}>광주
			<input type="radio" name="prttrvarea" id="prttrvarea" value="부산" ${PrtVO.prttrvarea == '부산' ? 'checked' : ''}>부산
			<input type="radio" name="prttrvarea" id="prttrvarea" value="울산" ${PrtVO.prttrvarea == '울산' ? 'checked' : ''}>울산
			<input type="radio" name="prttrvarea" id="prttrvarea" value="세종" ${PrtVO.prttrvarea == '세종' ? 'checked' : ''}>세종 <br>
			<input type="radio" name="prttrvarea" id="prttrvarea" value="경기" ${PrtVO.prttrvarea == '경기' ? 'checked' : ''}>경기
			<input type="radio" name="prttrvarea" id="prttrvarea" value="강원" ${PrtVO.prttrvarea == '강원' ? 'checked' : ''}>강원
			<input type="radio" name="prttrvarea" id="prttrvarea" value="충북" ${PrtVO.prttrvarea == '충북' ? 'checked' : ''}>충북
			<input type="radio" name="prttrvarea" id="prttrvarea" value="충남" ${PrtVO.prttrvarea == '충남' ? 'checked' : ''}>충남
			<input type="radio" name="prttrvarea" id="prttrvarea" value="경북" ${PrtVO.prttrvarea == '경북' ? 'checked' : ''}>경북
			<input type="radio" name="prttrvarea" id="prttrvarea" value="경남" ${PrtVO.prttrvarea == '경남' ? 'checked' : ''}>경남
			<input type="radio" name="prttrvarea" id="prttrvarea" value="전북" ${PrtVO.prttrvarea == '전북' ? 'checked' : ''}>전북
			<input type="radio" name="prttrvarea" id="prttrvarea" value="전남" ${PrtVO.prttrvarea == '전남' ? 'checked' : ''}>전남
			<input type="radio" name="prttrvarea" id="prttrvarea" value="제주" ${PrtVO.prttrvarea == '제주' ? 'checked' : ''}>제주
			<input type="radio" name="prttrvarea" id="prttrvarea" value="미정" ${PrtVO.prttrvarea == '미정' ? 'checked' : ''}>미정
		</th>
 	</tr>
 	<tr>
        <th>여행사진</th>
        <th>
            <c:set var="prtsrcList" value="${fn:split(PrtVO.prtsrc, ',')}" />
            <c:forEach items="${prtsrcList}" var="imageSrc" varStatus="loop">
                <c:if test="${loop.index < 10}">
                    <img src="<c:url value='/prtImage/${imageSrc}'/>" style="width:200px; height:150px; object-fit:cover;">
                </c:if>
            </c:forEach>
        </th>
    </tr>
	<tr>
		<th>사진 업로드</th>
		<td>
		<div id="file-container">
	      <input type="file" name="prtsrc1" id="prtsrc1" class="file-input" style="width:50%">
	    </div>
	    <button type="button" id="addFile">사진 추가</button>
		</td>
	</tr>
 	<tr>
 		<th>여행 내용</th>
 		<td><textarea name="prtcontent" id="prtcontent">${PrtVO.prtcontent }</textarea></td>
 	</tr>
 	<tr>
 		<th>등록일</th>
 		<td>${PrtVO.prtrdate }</td>
 	</tr>
 	<tr>
 		<th>수정일</th>
 		<td>${PrtVO.prtudate }</td>
 	</tr>
 	<tr>
 		<th>암호</th>
 		<td><input type="password" name="prtpass" id="prtpass"></td>
 	</tr>
 </table> 

 <div style="margin-top:10px; margin-bottom:10px; text-align:center;" >
	
 	<button type="submit" id="submit_button" onclick="return false;">수정</button>
	<button type="button" id="reset">취소</button>
	
</div>
</form>

<!-- 파일업로드 스크립트 S -->
<!-- 파일 최대 10개까지 가능 -->
<!-- 사진추가 버튼 누르면 파일업로드 새로 생김 -->
<!-- 새로고침되면 다시 1개만 보임 -->
<script>
const fileContainer = document.getElementById('file-container');
const addButton = document.getElementById('addFile');

let fileIndex = 2;

addButton.addEventListener('click', () => {
  if (fileIndex <= 10) {
    const newInput = document.createElement('input');
    newInput.type = 'file';
    newInput.name = `prtsrc`+fileIndex;
    newInput.id = `prtsrc`+fileIndex;
    newInput.className = 'file-input';
    newInput.style.width = '50%';
    fileContainer.appendChild(newInput);
    fileIndex++;
  }
});
</script>
<!-- 파일업로드 스크립트 E -->

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
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

<title>동행 등록</title>
</head>
<style>
.board1 {
  width: 700px;
  margin-top: 10px;
  margin-bottom: 10px;
  border-spacing: 10px;
}

textarea {
  width: 250px;
  height: 100px;
  padding: 5px;
  border: 1px solid #ccc;
  resize: none;
}

.file-input {
  display: block;
  margin-bottom: 10px;
}

/* 입력 필드 스타일 */
input[type="text"],
input[type="password"],
input[type="date"] {
  width: 100%;
  padding: 5px;
  border: 1px solid #ccc;
  border-radius: 3px;
}

/* 라디오 버튼 스타일 */
input[type="radio"] {
  margin-right: 5px;
}

/* 버튼 스타일 */
button {
  padding: 10px 20px;
  font-size: 14px;
  background-color: #007bff;
  border: none;
  border-radius: 5px;
  color: white;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

button:hover {
  background-color: #0056b3;
}

/* 버튼 그룹 스타일 */
.page_number_area {
  margin-top: 20px;
}

.page_number_area button {
  margin-right: 10px;
}
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
</style>

<script>

$(function(){
	
	$("#submit_button").click(function(){
		
		
		let userid = $("#userid").val();
		let prttitle = $("#prttitle").val();
		let prtpass = $("#prtpass").val();
		let prttrvarea = $("input[name='prttrvarea']:checked").val();
		let plansdate  = $.trim($("#plansdate").val());
		let planedate  = $.trim($("#planedate").val());
		let prtcontent  = $.trim($("#prtcontent").val());
		
		if( prtpass == "" ) {
			alert("비밀번호를 입력해주세요");
			return false;
		}
		if( prttitle == "" ) {
			alert("제목을 입력해주세요");
			return false;
		}
		if( prtcontent == "" ) {
			alert("내용을 입력해주세요");
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
		if(plansdate > planedate){
			alert("동행 시작 종료일자가 올바르지 않습니다.")
			return false;
		}
		if (!prttrvarea) {
	        alert("여행 지역을 선택해주세요.");
	        return false;
	    }
		
		$("#userid").val(userid);
		$("#prttitle").val(prttitle);
		$("#prtpass").val(prtpass);
		$("#prttrvarea").val(prttrvarea);
		$("#plansdate").val(plansdate);
		$("#planedate").val(planedate);
		$("#prtcontent").val(prtcontent);
		
		
		var form = new FormData(document.getElementById('prtfrm'));      
		$.ajax({
			/*서버송신설정*/
			type : "POST",
			data :  form,
			url  : "/prtBoardWriteSave.do",
			
			processData: false, // 파일이 전송되는 경우의 설정
  			contentType: false, // 파일이 전송되는 경우의 설정
  			
  			/*서버응답설정*/
			datatype : "text", // json
			success : function(data) {
				 if(data == "ok") {
					alert("동행찾기가 등록되었습니다.");
					location = "/prtBoardList.do";
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
<input type="hidden" name="planunq" id="planunq">
	<div class="content_area">
	
	<form id="prtfrm" enctype="multipart/form-data">
		<input type="hidden" name="userid" id="userid" value="${s_userid}">
		<input type="hidden" name="planunq" id="planunq" value="${PlanVO.planunq}">
		<input type="hidden" name="planopen" id="planopen" value="${PlanVO.planopen}">
		<table class="board1" align="center" >
	
			<tr>
				<th>아이디</th>
				<td>
					${s_userid}
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
				<input type="password" name="prtpass" id="prtpass" placeholder="">
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
				<input type="text" name="prttitle" id="prttitle"  value="${PlanVO.plantitle }"placeholder="">
				</td>
			</tr>
			<tr>
				<th>지역</th>
				<td>
				<input type="radio" name="prttrvarea" id="prttrvarea" value="서울">서울
				<input type="radio" name="prttrvarea" id="prttrvarea" value="인천">인천
				<input type="radio" name="prttrvarea" id="prttrvarea" value="대전">대전
				<input type="radio" name="prttrvarea" id="prttrvarea" value="대구">대구
				<input type="radio" name="prttrvarea" id="prttrvarea" value="광주">광주
				<input type="radio" name="prttrvarea" id="prttrvarea" value="부산">부산
				<input type="radio" name="prttrvarea" id="prttrvarea" value="울산">울산
				<input type="radio" name="prttrvarea" id="prttrvarea" value="세종">세종 <br>
				<input type="radio" name="prttrvarea" id="prttrvarea" value="경기">경기
				<input type="radio" name="prttrvarea" id="prttrvarea" value="강원">강원
				<input type="radio" name="prttrvarea" id="prttrvarea" value="충북">충북
				<input type="radio" name="prttrvarea" id="prttrvarea" value="충남">충남
				<input type="radio" name="prttrvarea" id="prttrvarea" value="경북">경북
				<input type="radio" name="prttrvarea" id="prttrvarea" value="경남">경남
				<input type="radio" name="prttrvarea" id="prttrvarea" value="전북">전북
				<input type="radio" name="prttrvarea" id="prttrvarea" value="전남">전남
				<input type="radio" name="prttrvarea" id="prttrvarea" value="제주">제주
				<input type="radio" name="prttrvarea" id="prttrvarea" value="미정">미정
				</td>
			</tr>
			<tr>
				<th>여행날짜</th>
				<td>
				시작날짜:<input type="date" name="plansdate" id="plansdate" value="${plansdate }" readonly><br>
				종료날짜:<input type="date" name="planedate" id="planedate" value="${planedate }" readonly>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
				<textarea name="prtcontent" id="prtcontent" >${PlanVO.plancontent }</textarea>
				</td>
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
		</table>
		</form>
	</div>
	
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

	
	<div class="page_number_area" align="center">
		<button type="submit" id="submit_button" onclick="return false;">등록하기</button>
		<button type="button" onclick="location.href='/planMain.do';">작성취소</button>
	</div>
	
	<div style="height:100px;"></div>
	
	



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
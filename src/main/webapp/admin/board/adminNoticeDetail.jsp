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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항관리</title>	
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script><link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css">
</head>

<style>
  body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
  }
  header {
    background-color: #333;
    color: white;
    padding: 10px 0;
    text-align: center;
  }
  section {
    padding: 20px;
  }
  .content_area {
    max-width: 800px;
    margin: 0 auto;
  }
  table.board1 {
    width: 100%;
    border-collapse: collapse;
    border: 1px solid #ddd;
  }
  th, td {
    padding: 10px;
    border: 1px solid #ddd;
  }
  th {
    width: 20%;
    background-color: #f2f2f2;
    text-align: left;
  }
  .input1, .textarea1 {
    width: 98%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
  }
  .textarea1 {
  	resize: none;
  	height:200px;
  	
  }
  .button_container {
    margin-top: 20px;
    text-align: center;
  }
  button {
    padding: 10px 20px;
    border: none;
    background-color: #333;
    color: white;
    cursor: pointer;
    margin-right: 10px;
  }
  button[type="reset"] {
    background-color: #ccc;
    color: #333;
  }
</style>

<script>
$(function(){
	$("#button1").click(function(){
		location = "/adminNoticeList.do";
	});
	$("#button2").click(function(){
		$("#frm").attr("action","/adminNoticeModify.do");
		$("#frm").submit();
	});
	$("#button3").click(function(){
		if( confirm("정말 삭제하시겠습니까?") ) {
			fn_submit("/adminNoticeDelete.do");
		}
	});	
});

function fn_submit(url){
	/**
	 serialize(); : 폼안의 데이터 값들을 한번에 전송가능한 상태로 만듬
	 */
	 var form = $("#frm").serialize();
	 
	  $.ajax({
	  // 전송관련 세팅
	  type : "POST",
	  data : form,
	  url  : url,
	  
	  // 반환관련 세팅
	  datatype : "text",   // json : 여러형식의 데이터 값을 받을 수 있음 
	  success  : function(data){
	     if(data=="ok"){
	     alert("삭제완료!");
	     location= "/adminNoticeList.do";
	  } else {
	        alert("삭제실패");
	     }            
	  },
	  error : function(){
	     alert("전송실패!");
	  }         
	});
}

</script>

<body>

<!--header 시작-->
<header>
	<%@include file="../../include/adminHeader.jsp" %>
</header>
<!--header 끝-->

<!--section 시작-->
<section>
<div class="content_area">
	<form name="frm" id="frm" >
	<input type="hidden" name="noticeunq" value="${Noticevo.noticeunq }">
	<table class="board1" align="center">
	   <tr>
      <th width="10%">제목</th>
      <td width="*">${Noticevo.noticetitle }</td>
   </tr>
   <tr>
      <th>이름</th>
      <td>${Noticevo.noticename }</td>
   </tr>
   <tr>
      <th>공지사항</th>
      <td style="text-align:left;">
      <c:choose>
		<c:when test="${Noticevo.noticeemps eq 'Y'}">
		  중요공지
		</c:when>
		<c:otherwise>
		  일반공지
		</c:otherwise>
	  </c:choose>
      </td>
   </tr>
   <tr>
      <th>내용</th>
      <td height="100">${Noticevo.noticecontent }</td>
   </tr>
	</table>
	
	<div style="margin-top:20px; text-align:center;">
	<button type="button" id="button1">목록</button>
	<button type="button" id="button2">수정</button> 
	<button type="button" id="button3">삭제</button> 
	</div>
</form>
</div>
</section>
<!--section 끝-->

</body>
</html>





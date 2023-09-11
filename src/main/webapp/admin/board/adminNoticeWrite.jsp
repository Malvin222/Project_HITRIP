<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="s_adminid" value="${sessionScope.SessionAdminID }"/>
<c:set var="s_superid" value="${sessionScope.SessionAdminSuperID }"/>
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
  #button2 {
    background-color: #ccc;
    color: #333;
  }
</style>

<script>
 $(function(){
	 
	 $("#button1").click(function(){
		 if($("#noticetitle").val() =="" ){
			 alert("제목을 입력해주세요.");
			 $("#noticetitle").focus();
			 return false;
		 }
		 if($("#noticepass").val() =="" ){
			 alert("암호을 입력해주세요.");
			 $("#noticepass").focus();
			 return false;
		 }
       /**
          serialize(); : 폼안의 데이터 값들을 한번에 전송가능한 상태로 만듬
       */
       var form = $("#frm").serialize();
       
        $.ajax({
        // 전송관련 세팅
        type : "POST",
        data : form,
        url  : "/adminNoticeSave.do",
        
        // 반환관련 세팅
        datatype : "text",   // json : 여러형식의 데이터 값을 받을 수 있음 
        success  : function(data){
           if(data=="ok"){
           alert("공지사항이 등록되었습니다.");
           location= "/adminNoticeList.do";
        } else {
              alert("저장실패");
           }            
        },
        error : function(){
           alert("전송실패!");
        }         
     });         
   });
   
   $("#button2").click(function(){
	location = "/adminNoticeList.do";
 });
});
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
<table class="board1">
	<tr>
		<th width="20%">제목</th>
		<td width="*"><input type="text" name="noticetitle" id="noticetitle" class="input1"></td>
	</tr>
	<tr>
		<th>암호</th>
		<td><input type="password" name="noticepass" id="noticepass" class="input1"></td>
	</tr>
	<tr>
		<th>이름</th>
		<td><input type="text" name="noticename" id="noticename" class="input1"
    value="${not empty s_adminid ? s_adminid : not empty s_superid ? s_superid : ''}" readonly="readonly"></td>
	</tr>
	<tr>
		<th>강조</th>
		<td style="text-align:left;">
		<input type="checkbox" name="noticeemps" id="noticeemps" value="Y">공지
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea name="noticecontent" id="noticecontent" class="textarea1"></textarea></td>
	</tr>
</table>

<div class="button_container">
	<button type="button" id="button1">등록</button> 
	<button type="button" id="button2" onclick="history.go(-1)">취소</button> 
</div>
</form>

</div>
</section>
<!--section 끝-->

</body>
</html>





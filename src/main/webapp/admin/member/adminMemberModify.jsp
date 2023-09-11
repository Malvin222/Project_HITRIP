<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항관리</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css">
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
  .content_area {
    max-width: 800px;
    margin: 20px auto;
    padding: 20px;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 5px;
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
    width: 25%;
    background-color: #f2f2f2;
    text-align: left;
  }
  input[type="text"],
  input[type="password"],
  textarea {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    transition: border-color 0.3s;
  }
  input[type="checkbox"] {
    margin-right: 5px;
  }
  select {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: white;
  }
  .textarea1 {
    height: 150px;
    resize: vertical;
  }
  .page_number_area {
    text-align: center;
    margin-top: 20px;
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
	
	$("#delete_button").click(function(){
		
		let userid = $("#userid").val();
		let userstate = $("#userstate").val();
		
		if( userstate != 4 ) {
			alert("삭제예정 회원이 아닙니다.");
			return false;
		}
		
		if( !confirm("삭제진행 하시겠습니까?")) {  //!confirm 아니오를 누르면 돌아가게함
	         return false;
	    }
		
		$.ajax({
			type : "POST",
	        data : {"userid":userid},
	        url  : "/adminMemberDelete.do",
	         	         
	        datatype : "text", 
	        success  : function(data){
	          if(data=="ok"){
	          	alert("삭제완료!");
	          	location= "/adminMemberList.do";
	        } else {
	            alert("삭제실패");
	           }            
	        },
	        error : function(){
	           alert("전송실패!");
	        }
		});
	});	
	
	$("#submit_button").click(function(){
		
		let form = $("#frm").serialize();
		
		$.ajax({
			type : "POST",
	        data : form,
	        url  : "/adminMemberModifySave.do",
	         	         
	        datatype : "text", 
	        success  : function(data){
	          if(data=="ok"){
	          	alert("저장완료!");
	          	location= "/adminMemberList.do";
	        } else {
	            alert("저장실패");
	           }            
	        },
	        error : function(){
	           alert("전송실패!");
	        }
		});
	});
	
});

</script>
</head>
<body>
<header>
  <%@include file="../../include/adminHeader.jsp" %>
</header>
<div class="content_area">
  <form id="frm">
    <table class="board1" align="center">
		<colgroup>
			<col width="25%"/>
			<col width="*%"/>
		</colgroup>
		<tr>
			<th>아이디</th>
			<td><input type="text" name="userid" id="userid" value="${MemberVO.userid }" readonly></td>
		</tr>
		<tr>
			<th>이름</th>
			<td><input type="text" name="username" id="username" value="${MemberVO.username }" readonly></td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td><input type="text" name="usernickname" id="usernickname" value="${MemberVO.usernickname }" readonly></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" name="useremail" id="useremail" value="${MemberVO.useremail }"></td>
		</tr>
		<tr>
			<th>휴대폰</th>
			<td><input type="text" name="userphone" id="userphone" value="${MemberVO.userphone }"></td>
		</tr>
		<tr>
			<th>정보공개</th>
			<td><input type="checkbox" name="useropeninfo" id="useropeninfo" value="Y"
			<c:if test="${MemberVO.useropeninfo == 'Y' }">checked</c:if>></td>
		</tr>
		<tr>
			<th>상태</th>
			<td>
				<select name="userstate" id="userstate">
					<option value="1"
					<c:if test="${MemberVO.userstate == '1' }">selected</c:if>>정상</option>
					<option value="2"
					<c:if test="${MemberVO.userstate == '2' }">selected</c:if>>중지</option>
					<option value="3"
					<c:if test="${MemberVO.userstate == '3' }">selected</c:if>>탈퇴</option>
					<option value="4"
					<c:if test="${MemberVO.userstate == '4' }">selected</c:if>>삭제</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>메모</th>
			<td><textarea name="usermemo" id="usermemo" class="textarea1">${MemberVO.usermemo }</textarea></td>
		</tr>
		<tr>
			<th>등록일</th>
			<td><input type="text" name="rdate" id="rdate" value="${MemberVO.userrdate }" readonly></td>
		</tr>		
    </table>
    <div class="page_number_area">
      <button type="submit" id="submit_button" onclick="return false;">저장</button>
      <button type="reset">새로고침</button>
      <button type="button" id="delete_button">삭제</button>
    </div>
  </form>
</div>
</body>
</html>





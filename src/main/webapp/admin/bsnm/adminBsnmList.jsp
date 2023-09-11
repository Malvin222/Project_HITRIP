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
<title>공지사항관리</title>	
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
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
  a {
    color: #0a0ccc;
    text-decoration: none;
  }
  .topMenu_area {
    width: 100%;
    height: 70px;
    text-align: center;
    background: yellow;
  }
  .subMenu_area {
    width: 100%;
    height: 30px;
    text-align: center;
    background: skyblue;
    line-height: 2.5;
    margin-bottom: 30px;
  }
  .content_area {
    width: 100%;
    text-align: center;
    padding: 20px;
    background-color: #f9f9f9;
  }
 .page_number_area {
  width: 100%;
  text-align: center;
  padding-top: 20px;
}

.page_number_area button {
  font-family: Arial, sans-serif;
  font-size: 14px;
  padding: 5px 10px;
  margin: 0 2px;
  border: 1px solid #ccc;
  background-color: #f5f5f5;
  cursor: pointer;
  transition: background-color 0.3s ease, color 0.3s ease;
}

.page_number_area button:hover {
  background-color: #ddd;
}

.page_number_area a {
  font-family: Arial, sans-serif;
  font-size: 14px;
  padding: 5px 10px;
  margin: 0 2px;
  text-decoration: none;
  color: #0a0ccc;
  border: 1px solid #ccc;
  background-color: #f5f5f5;
  transition: background-color 0.3s ease, color 0.3s ease;
}

.page_number_area a:hover {
  background-color: #ddd;
  color: #0a0ccc;
}

.page_number_area span {
  font-family: Arial, sans-serif;
  font-size: 14px;
  padding: 5px 10px;
  margin: 0 2px;
  color: #333;
  background-color: #f5f5f5;
  border: 1px solid #ccc;
}

.page_number_area .current {
  background-color: #0a0ccc;
  color: white;
  border-color: #0a0ccc;
}
  .board1 {
    width: 1000px;
    border-top: 2px solid #474747;
    border-bottom: 1px solid #cccccc;
    border-collapse: collapse;
    margin: 0 auto;
  }
  .board1 th, .board1 td {
    border-bottom: 1px solid #cccccc;
    border-collapse: collapse;
    padding: 10px;
    text-align: center;
  }
  .board1 th {
    background-color: #f5f5f5;
    font-weight: bold;
  }
.btn_group {
  margin-top: 20px;
  text-align: center;
}

.btn_group button {
  padding: 10px 20px;
  margin: 0 10px;
  background-color: #f5f5f5;
  color: #333;
  border: 1px solid #ccc;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease;
}

.btn_group button:hover {
  background-color: #ddd;
  border-color: #999;
}

  /* Example status styles */
.status-1 {
  color: green;
  font-weight: bold;
}
.status-2 {
  color: blue;
  font-weight: bold;
}
.status-3 {
  color: orange;
  font-weight: bold;
}
.status-4 {
  color: red;
  font-weight: bold;
}
  
</style>

<script>
$(function(){
	$("#btn01").click(function(){
		
		let bsnmstate = 3;
		
		if( !confirm("삭제로 상태를 일괄변경 하시겠습니까?")) {  //!confirm 아니오를 누르면 돌아가게함
	         return false;
	    }
		
		$.ajax({
			type : "POST",
	        data : {"bsnmstate":bsnmstate},
	        url  : "/adminBsnmAllStateSub.do",
	         	         
	        datatype : "text", 
	        success  : function(data){
	          if(data=="ok"){
	          	alert("변경완료!");
	          	location= "/adminBsnmList.do";
	        } else {
	            alert("탈퇴 회원이 없습니다.");
	           }            
	        },
	        error : function(){
	           alert("전송실패!");
	        }
		});		
	});
	
	$("#btn02").click(function(){
		
		let bsnmstate = 4;
		
		if( !confirm("삭제예정인 회원이 일괄삭제됩니다?")) {  //!confirm 아니오를 누르면 돌아가게함
	         return false;
	    }
		if( !confirm("삭제된 데이터는 복원이 안됩니다.")) {  //!confirm 아니오를 누르면 돌아가게함
	         return false;
	    }
		$.ajax({
			type : "POST",
	        data : {"bsnmstate":bsnmstate},
	        url  : "/adminBsnmAllDeleteSub.do",
	         	         
	        datatype : "text", 
	        success  : function(data){
	          if(data=="ok"){
	          	alert("삭제완료!");
	          	location= "/adminBsnmList.do";
	        } else {
	            alert("삭제예정 회원이 없습니다.");
	           }            
	        },
	        error : function(){
	           alert("전송실패!");
	        }
		});		
	});
});
</script>

<body>

<%@include file="../../include/adminHeader.jsp" %>

<div class="content_area">
	<table border="0" width="1000" align="center"></table>
		<form id="searchFrm" method="post" action="/adminBsnmList.do?menu=2">
		<input type="hidden" name="pageIndex" id="pageIndex" value="1">
		<select name="searchCondition">
			<option value="bsnmid"
				<c:if test="${PageVO.searchCondition=='bsnmid' }">selected</c:if>
			>아이디</option>
			<option value="bsnmname"
				<c:if test="${PageVO.searchCondition=='bsnmname' }">selected</c:if>
			>이름</option>
			<option value="bsnmcompany"
				<c:if test="${PageVO.searchCondition=='bsnmcompany' }">selected</c:if>
			>회사명</option>
			<option value="bsnmstate"
				<c:if test="${PageVO.searchCondition=='bsnmstate' }">selected</c:if>
			>회원상태</option>
		</select>
		<input type="text" name="searchKeyword" value="${PageVO.searchKeyword }">
		<button type="submit">검색</button>
	</form>
	
	<table border="0" width="1000" align="center">
		<tr><td align="left"> 총 ${total }건</td></tr>
	</table>
		
	<table class="board1" align="center">
  <colgroup>
    <col width="10%"/>
    <col width="15%"/>
    <col width="10%"/>
    <col width="15%"/>
    <col width="15%"/>
    <col width="25%"/>
    <col width="10%"/>
  </colgroup>
  <tr>
    <th>번호</th>
    <th>아이디</th>
    <th>이름</th>
    <th>회사명</th>
    <th>휴대폰</th>
    <th>등록일</th>
    <th>상태</th>
  </tr>	
	
  <c:set var="rownumber" value="${PageVO.recordCountPerPage }"/>
  
  <c:forEach var="list" items="${Bsnmlist}" varStatus="status">
    <tr>
      <td>${rownumber }</td>
      <td align="left">
        <a href="/adminBsnmModify.do?bsnmid=${list.bsnmid}">
          <c:out value="${list.bsnmid}"/>
        </a>
      </td>
      <td><c:out value="${list.bsnmname}"/></td>
      <td><c:out value="${list.bsnmcompany}"/></td>
      <td><c:out value="${list.bsnmphone}"/></td>
      <td><c:out value="${list.bsnmrdate}"/></td>
      <td>
        <span class="status-${list.bsnmstate}">
          <c:out value="${list.bsnmstate}"/>
        </span>
      </td>
    </tr>
    <c:set var="rownumber" value="${rownumber-1 }"/>
  </c:forEach>
</table>
</div>
<div class="btn_group">
    <button type="button" id="btn01">상태 일괄 변경</button>
    <button type="button" id="btn02">회원 일괄 삭제</button>
</div>

<!-- 토탈 및 페이징S -->
<div class="page_number_area">
    	 <!-- 페이지가 5이하일때 시작 페이지를 1로 고정 -->
			<c:choose>
			    <c:when test="${PageVO.pageIndex - 5 < 1}">
			        <c:set var="startIndex" value="1" />
			    </c:when>
			    <c:otherwise>
			        <c:set var="startIndex" value="${PageVO.pageIndex - 5}" />
			    </c:otherwise>
			</c:choose>
			
    <button onclick="location='/adminBsnmList.do?pageIndex=1&searchCondition=${PageVO.searchCondition}&searchKeyword=${PageVO.searchKeyword}'">first</button>
    <button onclick="location='/adminBsnmList.do?pageIndex=${startIndex}&searchCondition=${PageVO.searchCondition}&searchKeyword=${PageVO.searchKeyword}'">Previous</button>
    
    	<!-- 끝나는 인덱스를 10으로 고정  -->
			<c:choose>
			    <c:when test="${PageVO.pageIndex + 5 > PageVO.lastPage}">
			        <c:set var="endIndex" value="${PageVO.lastPage}" />
			    </c:when>
			    <c:when test="${PageVO.pageIndex + 5 < 10}">
			        <c:set var="endIndex" value="10" />
			    </c:when>
			    <c:otherwise>
			        <c:set var="endIndex" value="${PageVO.pageIndex + 5}" />
			    </c:otherwise>
			</c:choose>
			
			<c:forEach var="i" begin="${startIndex}" end="${endIndex}">
			    <a href="/adminBsnmList.do?pageIndex=${i }&searchCondition=${PageVO.searchCondition}&searchKeyword=${PageVO.searchKeyword}">${i}</a>
			</c:forEach>
			
	  	 <button onclick="location='/adminBsnmList.do?pageIndex=${endIndex}&searchCondition=${PageVO.searchCondition}&searchKeyword=${PageVO.searchKeyword}'">Next</button>
	  	 <button onclick="location='/adminBsnmList.do?pageIndex=${PageVO.lastPage}&searchCondition=${PageVO.searchCondition}&searchKeyword=${PageVO.searchKeyword}'">last</button>
</div>
<!-- 페이지처리 E -->

</body>
</html>





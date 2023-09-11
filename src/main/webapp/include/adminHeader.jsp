<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="s_bsnmid" value="${sessionScope.SessionBsnmID }"/>
<c:set var="s_userid" value="${sessionScope.SessionUserID }"/>
<c:set var="s_adminid" value="${sessionScope.SessionAdminID }"/>
<c:set var="s_adminsuperid" value="${sessionScope.SessionAdminSuperID }"/>
<script>
	function fn_logout() {
		
		$.ajax({
			type : "POST",
			data : "",
			url  : "/adminLogout.do",
			
			datatype : "text",
			success  : function(data){
	            if(data == "1" ) {
	               alert("로그아웃되었습니다.");
	               location="/";
	            } else {
	            	alert("로그아웃 실패.");
	            } 
	         },
	         error : function(){
	            alert("전송실패");
	         }			
		});
	}
</script>

<style>
  .topMenu_area {
    background-color: #333;
    color: #fff;
    padding: 10px 0;
    text-align: center;
  }

  .topMenu_area a {
    color: #fff;
    text-decoration: none;
    margin: 0 10px;
    font-weight: bold;
  }

  .subMenu_area {
    background-color: #f9f9f9;
    border-bottom: 1px solid #ccc;
    padding: 10px 0;
    text-align: center;
  }

  .subMenu_area a {
    color: #333;
    text-decoration: none;
    margin: 0 10px;
  }
</style>

<div class="topMenu_area">
  <div style="height:30px;">&nbsp;</div>
  <div>
  	<a href="/">HOME</a> | 
    <a href="/adminNoticeList.do?menu=1">공지관리</a> |  
    <a href="/adminMemberList.do?menu=2">회원관리</a> |
    <a href="/adminPackList.do?menu=4">패키지여행관리</a> |
    <c:if test="${s_adminid == null and s_adminsuperid == null and
    			  s_bsnmid == null and s_userid == null}">  
    <a href="/adminLoginWrite.do?menu=5">로그인</a>
    </c:if>
    <c:if test="${s_adminid != null or s_adminsuperid != null }">  
    <a href="javascript:fn_logout()">로그아웃</a>
    </c:if>
  </div>
</div>

<div class="subMenu_area">
  <a href="/adminNoticeWrite.do?menu=1">공지등록</a> 
  <a href="/adminNoticeList.do?menu=1">공지목록</a>
  <a href="/adminMemberList.do?menu=2">일반회원목록</a> 
  <a href="/adminBsnmList.do?menu=2">사업자회원목록</a>
  <c:if test="${s_adminsuperid != null }">
  <a href="/adminJoinWrite.do?menu=3">관리자회원 생성</a>
  </c:if>
</div>
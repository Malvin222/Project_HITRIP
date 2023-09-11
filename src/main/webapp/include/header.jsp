<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%-- 로그인 아이디 : ${sessionScope.SessionUserID } --%>

<c:set var="s_userid" value="${sessionScope.SessionUserID }"/>
<c:set var="s_bsnmid" value="${sessionScope.SessionBsnmID }"/>
<c:set var="s_adminid" value="${sessionScope.SessionAdminID }"/>
<c:set var="s_superid" value="${sessionScope.SessionAdminSuperID }"/>
<script>
	function fn_logout() {
		
		$.ajax({
			type : "POST",
			data : "",
			url  : "/logout.do",
			
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
	
	function fn_bsnmlogout() {
	      
	      $.ajax({
	         type : "POST",
	         data : "",
	         url  : "/bsnmLogout.do",
	         
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
	
function fn_adminlogout() {
		
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
<ul class="header_left">
  <li class="header_item">
  		<a href="/">
			<img src="/tripImage/hitriplogo.png">
		</a>
	</li>
</ul>
<ul class="header_right">
    <c:if test="${s_adminid != null or s_superid != null }">
  <li class="header_item">
    <a class="header_link" href="../adminNoticeList.do">관리자페이지</a>
  </li>
  </c:if>
  
  <li class="header_item">
   <c:if test ="${s_userid !=null }">${s_userid}님</c:if>
   <c:if test ="${s_bsnmid !=null }">사업자${s_bsnmid}님</c:if>
   <c:if test ="${s_adminid !=null }">관리자${s_adminid}님</c:if>
   <c:if test ="${s_superid !=null }">최고관리자${s_superid}님</c:if>
  </li>
  <li class="header_item">
    <a class="header_link" href="/noticeList.do">공지사항</a>
  </li>
  
  <c:if test="${s_userid == null and s_bsnmid == null and
  				s_adminid == null and s_superid == null }">  
  <li class="header_item">
    <a class="header_link" href="../joinWrite.do">회원가입</a>
  </li>
  <li class="header_item">
    <a class="header_link" href="/loginWrite.do">로그인</a>
  </li> 
  </c:if> 
  
  <c:if test="${s_userid != null }">
   <li class="header_item">
    <a class="header_link" href="../mbrModify.do">정보수정</a>
  </li>
  <li class="header_item">
    <a class="header_link" href="javascript:fn_logout()">로그아웃</a>
  </li>  
  </c:if>
 
 
  <c:if test="${s_bsnmid != null }">
   <li class="header_item">
    <a class="header_link" href="../bsnmModify.do">정보수정</a>
  </li>
  <li class="header_item">
    <a class="header_link" href="javascript:fn_bsnmlogout()">로그아웃</a>
  </li>  
  </c:if>
  
  <c:if test="${s_adminid != null or s_superid != null }">
  <li class="header_item">
    <a class="header_link" href="javascript:fn_adminlogout()">로그아웃</a>
  </li>  
  </c:if>
  
</ul>
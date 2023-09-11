<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="s_userid" value="${sessionScope.SessionUserID }"/>
<c:set var="s_adminid" value="${sessionScope.SessionAdminID }"/>
<c:set var="s_superid" value="${sessionScope.SessionAdminSuperID }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>패키지여행후기 디테일</title>	
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css">
</head>
<style>
img {
    width: 100%;
    height: 100%;
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
  vertical-align: top; /* Align content to the top of cells */
  border-collapse:collapse;
  border-left: none;
  border-right: none;
}
input {
	width: 100%;
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
  margin: 0 auto 5px;
}

/* Styling for the address */
td p.addr {
  margin-top: 5px;
}


/* 좋아요 버튼 */
.like_wrap {
	position:relative; 
	display:flex; 
	margin-bottom:40px; 
	justify-content:center; 
	align-items:center;
}
.like_wrap div {
	position:relative; 
	display:flex; 
	padding:10px 40px; 
	justify-content:center; 
	align-items:center; 
	border:1px solid #ddd; 
	border-radius:30px;
}
.button_like {
	  background-color: #f7f7f7;
}
.button_like:hover {
	  background-color: #f7f7f7;
}
.button_like_cancle {
	  background-color: #f7f7f7;
}
.button_like_cancle:hover {
	  background-color: #f7f7f7;
}
</style>

<script>
$(function(){
	$("#button_like").click(function(){ 
		   
		   let packreviewunq = $("#packreviewunq").val();
		   let userid = $("#userid").val();
		   let packreviewlike = $("#packreviewlike").val();
		   
		   if( userid == null ) {
		      alert("회원만 추천이 가능합니다.");
		      return false;
		   }
		   
		   var form = $("#frm").serialize();
		   $.ajax({
		      // 전송 세팅
		      type : "POST",
		      data : form,
		      url  : "/packReviewLikeSave.do",
		      // 리턴 세팅
		      datatype : "text",
		      success : function(data) {
		          if(data == "ok") {
		            alert("추천되었습니다.");
		            location = "/packReviewDetail.do?packreviewunq=${vo.packreviewunq}&userid=${s_userid}";
		          } else {
		             alert("이미 추천한 게시물입니다.");
		          }
		       },
		       error : function() {
		          alert("전송실패");
		       }
		   });   
		});
		//좋아요 끝
		
		// 좋아요 취소
		$("#button_like_cancle").click(function(){ 
		   
		   let packreviewunq = $("#packreviewunq").val();
		   let userid = $("#userid").val();
		   let packreviewlike = $("#packreviewlike").val();
		   
		   if( userid == null ) {
		      alert("회원만 추천이 가능합니다.");
		      return false;
		   }
		   
		   var form = $("#frm").serialize();
		   $.ajax({
		      // 전송 세팅
		      type : "POST",
		      data : form,
		      url  : "/packReviewLikeDelete.do",
		      // 리턴 세팅
		      datatype : "text",
		      success : function(data) {
		          if(data == "ok") {
		            alert("추천 취소 되었습니다.");
		            location = "/packReviewDetail.do?packreviewunq=${vo.packreviewunq}&userid=${s_userid}";
		          } else {
		             alert("이미 취소한 게시물입니다.");
		          }
		       },
		       error : function() {
		          alert("전송실패");
		       }
		   });   
		});
		//좋아요취소 끝
	
	// 게시글 삭제
	$("#button1").click(function(){ 
		
		
		var form = $("#frm").serialize();
		if( !confirm("삭제하시겠습니까?") ) {
			return false;
		}
		$.ajax({
			// 전송 세팅
			type : "POST",
			data : form,
			url  : "/packReviewDelete.do",
			// 리턴 세팅
			datatype : "text",
			success : function(data) {
				 if(data == "ok") {
					alert("삭제되었습니다.");
					location = "/packReviewList.do";
				 }
			 },
			 error : function() {
				 alert("전송실패");
			 }
		});	
	});
	
	// 댓글 입력
	$("#button2").click(function(){ 
		
		let packreviewcmcontent = $("#packreviewcmcontent").val();
		let packreviewunq = $("#packreviewunq").val();
		let userid = $("#userid").val();
		let cmunq = $("#cmunq").val();

		if( packreviewcmcontent == "" ) {
			alert("댓글 내용을 입력해주세요");
			return false;
		}
		
		$("#packreviewcmcontent").val(packreviewcmcontent);
		$("#packreviewunq").val(packreviewunq);
		$("#userid").val(userid);
		$("#cmunq").val(cmunq);
		
		var form = $("#frm").serialize();
		$.ajax({
		 	// 전송 세팅
			type : "POST",
			data : form,
			url  : "/packReviewCmWriteSave.do",
			// 리턴 세팅
			datatype : "text",
			success : function(data) {
				 if(data == "ok") {
					alert("등록되었습니다.");
					location = "/packReviewDetail.do?packreviewunq=${vo.packreviewunq}&userid=${s_userid}";
				 } else if (data=="ok1") {
						alert("수정되었습니다.");
						location = "/packReviewDetail.do?packreviewunq=${vo.packreviewunq}&userid=${s_userid}";
					 }
			 },
			 error : function() {
				 alert("전송실패");
			 }
		});	
	});
	
});	
	function fn_delete(cmunq) {
		
		if( !confirm("댓글을 삭제하시겠습니까?") ) {
			return false;
		}
		
		$.ajax({
			type : "POST",
			url  : "/packReviewCmDelete.do",
			data : {"cmunq":cmunq},
			datatype : "text",
			success : function(data) {
				 if(data == "ok") {
					alert("댓글이 삭제되었습니다.");
					location = "/packReviewDetail.do?packreviewunq=${vo.packreviewunq}&userid=${s_userid}";
				 } else {
					 alert("삭제실패");
				 }
			 },
			 error : function() {
				 alert("전송실패");
			 }
		});
	}


// 댓글 수정
function fn_action(packreviewcmcontent,rownumber,cmunq) {  // 수정처리
	$("#packreviewcmcontent").val(packreviewcmcontent);
	$("#rownumber").val(rownumber);
	$("#cmunq").val(cmunq);
	$("#button2").text("댓글 수정하기");
}


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
<div class="content_area">
	<form name="frm" id="frm" >
	<input type="hidden" name="packreviewunq" id="packreviewunq" value="${vo.packreviewunq }">
	<table class="board1" align="center" style="margin-top:30px;">
	   <tr>
      <th width="10%">제목</th>
      <td width="*">${vo.packreviewtitle }</td>
   </tr>
   <tr>
      <th>아이디</th>
      <td>${vo.userid }</td>
   </tr>
 	<tr>
		<th>여행일</th>
		<td>
		${vo.packsdate } ~ ${vo.packedate }
		</td>
	</tr>
	<tr>
		<th>사진</th>
		<td>
		<c:if test="${vo.packreviewsrc1 != null }">
        <img src="<c:url value='/packreviewImage/${vo.packreviewsrc1 }'/>" width="200" height="100">
        </c:if>
        <c:if test="${vo.packreviewsrc1 == null }">
        <img src="../images/hitrip.png" width="200" height="100">
        </c:if>
		</td>
	</tr>  
   <tr>
      <th align="center">내용</th>
      <td height="100">${vo.packreviewcontent }</td>
   </tr>
	</table>
	
   <!--  좋아요 추천 -->
    <div class="like_wrap">
      <div>
         <p>좋아요&nbsp; &nbsp;</p>
         <span>
         <c:if test="${s_userid != null and s_userid!=vo.userid and likeCancle == 0}">
            <button type="button" class="button_like" id="button_like">
            <img src="/tripImage/thumpsup.png" style="width:50px;"></button>
         </c:if>
         <c:if test="${s_userid != null and s_userid!=vo.userid and likeCancle != 0}">
            <button type="button" class="button_like_cancle" id="button_like_cancle">
            <img src="/tripImage/thumpsup2.png" style="width:50px;"></button>
         </c:if>
         </span>
         <span>${vo.packreviewstar } </span>
      </div>
   </div>  
	
	<!-- 댓글 -->
   <table border="1" width="700" align="center" style="margin-top:20px;margin-bottom:20px;border-left:none;border-right: none;">
       <colgroup>
          <col width="10%"/>
          <col width="15%"/>
          <col width="*"/>
          <col width="15%"/>
   		  <c:if test="${s_userid != null }">
 			<col width="10%"/>
 			<col width="10%"/>
 		  </c:if>
       </colgroup>
	 	<tr>
	 		<th>번호</th>
	 		<th>아이디</th>
	 		<th>내용</th>
	 		<th>작성일자</th>
	 		<c:if test="${s_userid == null }">
             <th colspan="2"></th>
          </c:if>
	 		<c:if test="${s_userid != null  }">
	 			<th colspan="2">수정/삭제</th>
	 		</c:if>
	 	</tr>
	 	<c:set var="rownumber" value="1"/>
	 	<c:forEach var="cmlist" items="${cmlist}" varStatus="status">
	 	<tr align="center">
	 		<td>
	 		${rownumber }
	 		</td>
	 		<td>
	 		${cmlist.userid }
	 		</td>
	 		<td>
	 		${cmlist.packreviewcmcontent }
	 		</td>
	 		<td>
	 		${cmlist.packreviewcmrdate }
	 		</td>
	 		<c:if test="${s_userid eq cmlist.userid }">
	 			<td><a  href="javascript:fn_action('${cmlist.packreviewcmcontent }','${rownumber}','${cmlist.cmunq }')">수정</a></td>
	 		</c:if>
	 		<c:if test="${s_userid eq cmlist.userid or s_adminid != null or s_superid != null }">
	 			<td><a href="javascript:fn_delete('${cmlist.cmunq }')">삭제</a></td>
	 		</c:if>
	 		<c:if test="${s_userid != cmlist.userid }">
	 			<td></td>
	 		</c:if>
	 		<c:if test="${s_userid != cmlist.userid }">
	 			<td></td>
	 		</c:if>
	 	</tr>
	 	<c:set var="rownumber" value="${rownumber+1 }"/>
	 	</c:forEach>
	 </table>
	 
	 <c:if test="${s_userid != null }">
	<input type="hidden" name="userid" id="userid" value="${s_userid }">
	 <table border="1" width="700" align="center" style="margin-top:20px; margin-bottom:20px;margin-bottom:20px;border-left:none;border-right: none;">
	 	<tr>
	 		<th>
	 		${s_userid}
	 		</th>
	 		<th>
	 			<input type="text" name="rownumber" id="rownumber" value="${rownumber}" size="3px" readonly> 
	 		</th>
	 		<th>
	 			<input type="text" name="packreviewcmcontent" id="packreviewcmcontent" size="20px"> 
	 		</th>
	 	</tr>
         <input type="hidden" id="cmunq" name="cmunq">
	 </table>	
 		<div align="center">
 		<button type="button" id="button2" onclick="return false;">댓글 등록하기</button>
 		</div>
 		</c:if>
 		
 		
	<div style="magin-bottom:20px;text-align:center;">
	<button type="button" onclick="location='/packReviewList.do'">목록</button>
	<c:if test="${s_userid eq vo.userid or s_adminid != null or s_superid != null }">
		<button type="button" onclick="location='/packReviewModify.do?packreviewunq=${vo.packreviewunq}'">수정</button> 
		<button type="button" id="button1">삭제</button> 
	</c:if>
	</div>
</form>
</div>
</section>
<!--section 끝-->

<!--footer 시작-->
<footer>
	<%@include file="../include/footer.jsp" %>
</footer>
<!--footer 끝-->

</body>
</html>





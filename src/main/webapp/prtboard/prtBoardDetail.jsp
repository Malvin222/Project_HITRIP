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
table {
    border-collapse: collapse;
}

th, td {
    border: 1px solid transparent; /* Hide borders */
    padding: 10px; /* Adjust padding as needed */
}
/* Main Table */
.main-table {
    border-collapse: collapse;
    width: 100%;
    margin-top: 20px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
}

.main-table th, .main-table td {
    padding: 10px;
    border: 1px solid #ccc;
    text-align: left;
}

/* Comment Table */
.comment-table {
    border-collapse: collapse;
    width: 100%;
    margin-top: 20px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    background-color: #E8E8E8;
}

.comment-table th, .comment-table td {
    padding: 10px;
    border: 1px solid #ccc;
    text-align: left;
}

.comment-table th:first-child {
    width: 10%;
}

.comment-table th:nth-child(2), .comment-table th:nth-child(3) {
    width: 10%;
}

.comment-table th:last-child {
    width: 20%;
}

/* Add Comment Table */
.add-comment-table {
    border-collapse: collapse;
    width: 100%;
    margin-top: 20px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
}

.add-comment-table th, .add-comment-table td {
    padding: 10px;
    border: 1px solid #ccc;
    text-align: left;
}

.comment-table th.author-cell {
    text-align: center;
    padding: 5px;
    font-size: 12px;
    color: red;
    background-color: #f9d9d9;
    border-radius: 50%;
}

.add-comment-table th:first-child {
    width: 10%;
}

.add-comment-table th:nth-child(2) {
    width: 90%;
}
#prtcmcontent {
  width: 93%;
  border: none;
}

/* Center Align */
.center-align {
    text-align: center;
    margin-top: 20px;
    margin-bottom: 20px;
}
.btn-primary {
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 5px;
    padding: 5px 15px;
    cursor: pointer;
}

.btn-primary:hover {
    background-color: #0056b3;
}

/* Style the delete button */
.btn-delete {
    background-color: #dc3545;
}

.btn-delete:hover {
    background-color: #c82333;
}
/* Button Group */
.button-group {
    text-align: center;
    margin-top: 10px;
    margin-bottom: 10px;
}

.button-group button {
    padding: 10px 20px;
    margin-left: 10px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.button-group .back-button {
    background-color: #333;
    color: #fff;
}

.button-group .list-button {
    background-color: #f0f0f0;
}

.button-group .edit-button {
    background-color: #ffb400;
    color: #fff;
}

.button-group .delete-button {
    background-color: #e74c3c;
    color: #fff;
}
/* Modal */
.modal {
    display: none;
    position: fixed;
    z-index: 9999;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.9);
}

/* Modal Content */
.modal-content {
    margin: auto;
    display: block;
    max-width: 90%;
    max-height: 90%;
}

/* Close Button */
.close {
    color: white;
    font-size: 24px;
    position: absolute;
    top: 10px;
    right: 20px;
    cursor: pointer;
}
</style>
<script>
//사진클릭시 팝업창으로 원본보기
$(document).ready(function() {

    $(".popup-image").click(function() {
        var imageUrl = $(this).attr("src");
        var windowOptions = "width=800,height=600,resizable=yes";
        window.open(imageUrl, "ImagePopup", windowOptions);
    });
});


$(document).ready(function() {
	  // 댓글테이블 숨기기
	  $("#commentTable").hide();

	  // 댓글보기 누르면 댓글테이블 보이기
	  $("#toggleButton").click(function() {
	    $("#commentTable").toggle();
	    
	    // 댓글테이블 보기,숨기기에 따라 버튼 이름수정
	    if ($("#commentTable").is(":visible")) {
	      $("#toggleButton").text("댓글 숨기기");
	    } else {
	      $("#toggleButton").text("댓글 보기");
	    }
	  });
});
	
$(function(){
    // 입력 내용 길이 체크 및 실시간 글자 수 업데이트
    $("#prtcmcontent").on("input", function() {
        let prtcmcontent = $(this).val();
        let remainingChars = 100 - prtcmcontent.length;
        
        if (remainingChars < 0) {
            alert("댓글 내용은 100자 이하여야 합니다.");
            return false;
        }
        
        $("#remainingChars").text(remainingChars);
    });
	
    $(function(){
    	$("#btn01").click(function(){ 
    		
    		let prtcmcontent = $("#prtcmcontent").val();
    		let prtunq = $("#prtunq").val();
    		let userid = $("#userid").val();
    		
    		if( prtcmcontent == "" ) {
    			alert("댓글 내용을 입력해주세요");
    			return false;
    		}
    		if( prtcmcontent.length > 100 ) {
                alert("댓글 내용은 100자 이하여야 합니다.");
                return false;
            }
    		
    		$("#prtcmcontent").val(prtcmcontent);
    		$("#prtunq").val(prtunq);
    		$("#userid").val(userid);
    		
    		var form = $("#frm").serialize();
    		$.ajax({
    			// 전송 세팅
    			type : "POST",
    			data : form,
    			url  : "/prtBoardCmWriteSave.do",
    			// 리턴 세팅
    			datatype : "text",
    			success : function(data) {
    				 if(data == "ok") {
    					alert("댓글이 등록되었습니다.");
    					location = "/prtBoardDetail.do?prtunq=${PrtVO.prtunq}&userid=${PrtVO.userid}";
    				 }else if (data=="ok1"){
   						alert("댓글이 수정되었습니다.");
   						location = "/prtBoardDetail.do?prtunq=${PrtVO.prtunq}&userid=${PrtVO.userid}";
    				}
    			 },
    			 error : function() {
    				 alert("전송실패");
    			 }
    		});	
    	});
    });
    
    	$("#btn02").click(function(){
    		if( confirm("삭제하시겠습니까?") ) {
    			fn_submit("/prtBoardDelete.do", ${PrtVO.prtunq});
    		}    		
    	});
    	
    	$("#btn04").click(function(){
    		$("#frm").attr("action","/prtBoardModify.do");
    		$("#frm").submit();   		
    	});
    	
    });
    
	function fn_submit(url, prtunq) {
	    var form = $("#frm").serialize();
	    
	    $.ajax({
	        type: "POST",
	        data: form,
	        url: url,
	        datatype: "text",
	        success: function(data) {
	            if (data == "okdelete") {
	                alert("삭제완료!");
	                location = "/prtBoardList.do";
	            } else {
	                alert("삭제실패");
	            }
	        },
	        error: function() {
	            alert("전송실패!");
	        }
	    });
	}
    
	function deleteComment(event) {
	    if (confirm("정말 삭제하시겠습니까?")) {
	        var prtcmunq = $(event.currentTarget).data("prtcmunq");
	        fn_delete("/prtBoardCmDelete.do", prtcmunq);
	    }
	}
	
    
    function fn_delete(url, prtcmunq) {
        var form = $("#frm").serialize();
        form += "&prtcmunq=" + prtcmunq;
        
        $.ajax({
            type: "POST",
            data: form,
            url: url,
            datatype: "text",
            success: function(data) {
                if (data == "okcmdelte") {
                    alert("삭제완료!");
                    location = "/prtBoardDetail.do?prtunq=${PrtVO.prtunq}&userid=${PrtVO.userid}";
                } else if (data == "okdelete") {
                    alert("삭제완료!");
                    location = "/prtBoardList.do";
                } else {
                    alert("삭제실패");
                }
            },
            error: function() {
                alert("전송실패!");
            }
        });
    }
    
    function editComment(event, prtcmunq, prtcmcontent) {
    	   $("#prtcmcontent").val(prtcmcontent);
    	   $("#btn01").text("댓글 수정하기").off("click").on("click", function() {
    	      updateComment(prtcmunq);
    	   });
    }
    
    function updateComment(prtcmunq) {
    	   let prtcmcontent = $("#prtcmcontent").val();
    	   let userid = $("#userid").val();
    	   
    	   if (prtcmcontent == "") {
    	      alert("댓글 내용을 입력해주세요");
    	      return false;
    	   }
    	   if (prtcmcontent.length > 100) {
    	      alert("댓글 내용은 100자 이하여야 합니다.");
    	      return false;
    	   }
    	   
    	   // Additional data to send
    	   let data = {
    	      prtcmunq: prtcmunq,
    	      prtcmcontent: prtcmcontent,
    	      userid: userid
    	   };
    	   
    	   $.ajax({
    	      type: "POST",
    	      data: data,
    	      url: "/prtBoardCmUpdate.do", // Replace with your update URL
    	      datatype: "text",
    	      success: function(data) {
    	         if (data == "ok") {
    	            alert("댓글 수정 완료!");
    	            location.reload(); // Refresh the page after update
    	         } else {
    	            alert("댓글 수정 실패");
    	         }
    	      },
    	      error: function() {
    	         alert("전송 실패");
    	      }
    	   });
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
<c:set var="s_userid" value="${sessionScope.SessionUserID }"/>
<c:set var="s_adminid" value="${sessionScope.SessionAdminID }"/>
<c:set var="s_superid" value="${sessionScope.SessionAdminSuperID }"/>
<form name="frm" id="frm" method="post">
<input type="hidden" name="prtunq" id="prtunq" value="${PrtVO.prtunq }">
	<table class="main-table" border="1" width="100%">
		<tr>
			<th width="10%">아이디</th>
			<th>${PrtVO.userid }</th>
		</tr>
		<tr>
			<th>닉네임</th>
			<th>${PrtVO.usernickname }</th>
		</tr>
		<tr>
			<th>제목</th>
			<th>${PrtVO.prttitle }</th>
		</tr> 
		<tr>
			<th>성별</th>
			<th>${PrtVO.usergender }</th>
		</tr> 	
		<tr>
			<th>나이</th>
			<th>${PrtVO.userage }세</th>
		</tr>
		<tr>
			<th>여행 일자</th>
			<th>${PrtVO.plansdate} ~ ${PrtVO.planedate }</th>
		</tr>
		<tr>
			<th>여행 지역</th>
			<th>${PrtVO.prttrvarea }</th>
		</tr>
		<c:set var="prtsrcList" value="${empty PrtVO.prtsrc ? '' : fn:split(PrtVO.prtsrc, ',')}" />	
		<c:choose>
		    <c:when test="${not empty prtsrcList}">
		        <tr>
		            <th>여행사진</th>
		            <th>
					<c:forEach items="${prtsrcList}" var="imageSrc" varStatus="loop">
					    <c:if test="${loop.index < 10}">
					        <img src="<c:url value='/prtImage/${imageSrc}'/>" class="popup-image" style="width:200px; height:150px; object-fit:cover;">
					    </c:if>
					</c:forEach>
		            </th>
		        </tr>
		    </c:when>
		    <c:otherwise><!-- 이미지가 없는 글이면 행 자체를 생성하지 않음 -->
	
		    </c:otherwise>
		</c:choose>
		<tr>
			<th>여행 내용</th>
			<th>${PrtVO.prtcontent }</th>
		</tr>
		<tr>
			<th>등록일</th>
			<td>${PrtVO.prtrdate }</td>
		</tr>
		<tr>
			<th>수정일</th>
			<td>${PrtVO.prtudate }</td>
		</tr>
	</table>
	<button type="button" id="toggleButton" class="btn-primary">댓글보기</button>
<table id="commentTable" class="comment-table" width="100%" align="center">
    <c:forEach var="cmlist" items="${PrtCmList}" varStatus="status">
    <tr>
        <td style="width: 9%;">${cmlist.userid }
        </td>      
        <c:if test="${s_userid eq cmlist.userid }">
            <th style="width: 4%;" class="author-cell">작성자</th>
        </c:if>        
        <c:choose>
		    <c:when test="${s_userid eq cmlist.userid }">
		        <td style="width: 85%;">${cmlist.prtcmrdate }</td>
		    </c:when>
		    <c:when test="${s_userid ne cmlist.userid}">
		        <td colspan="2" style="width: 89%;">${cmlist.prtcmrdate }</td>
		    </c:when>
		    <c:otherwise>
            <td></td>
            </c:otherwise>
		</c:choose>
    </tr>
    
    <tr align="center">
        <td colspan="3">
            ${cmlist.prtcmcontent }
            <c:if test="${s_userid eq cmlist.userid }">
	 			<a href="javascript:void(0);" onclick="editComment(event, ${cmlist.prtcmunq}, '${cmlist.prtcmcontent}')">수정</a>
	 		</c:if>
            <c:if test="${s_userid eq cmlist.userid or s_adminid != null or s_superid != null }">
                <button type="button" class="btn-primary btn-delete" onclick="deleteComment(event)" data-prtcmunq="${cmlist.prtcmunq}">댓글 삭제</button>
            </c:if>
        </td>
    </tr>
	</c:forEach>

</table>
<c:if test="${s_userid != null }">
<input type="hidden" name="userid" id="userid" value="${s_userid }">
<table class="add-comment-table" width="100%" align="center">
	<tr>
		<th width="10%">
			${s_userid}
		</th>
		<th>
			내용 : <input type="text" name="prtcmcontent" id="prtcmcontent" size="20px"> 
		</th>
	</tr>
</table>	
<div class="center-align">
	<button type="button" id="btn01" class="btn-primary" onclick="return false;">댓글 등록하기</button>
</div>
</c:if>

<div class="button-group center-align">
	<button type="button" class="back-button" onclick="history.back();">이전</button>
	<button type="button" class="list-button" onclick="location='/prtBoardList.do'">목록</button>
	<c:if test="${s_adminid != null or s_superid != null }">
	<button type="button" id="btn02" class="delete-button">삭제</button>
	</c:if>
	<c:if test="${s_userid eq PrtVO.userid}">
	<button type="button" id="btn04"  class="edit-button">수정</button>
	<button type="button" id="btn02" class="delete-button">삭제</button>
	</c:if>	
	
</div>
</form>
<!-- 원본크기 사진보기 -->
<div id="imageModal" class="modal">
    <span class="close">&times;</span>
    <img id="modal-content" class="modal-image">
</div>
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


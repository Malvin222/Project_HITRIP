<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<c:set var="s_bsnmid" value="${sessionScope.SessionBsnmID }"/>
<c:set var="s_userid" value="${sessionScope.SessionUserID }"/>
<c:set var="s_adminid" value="${sessionScope.SessionAdminID }"/>
<c:set var="s_superid" value="${sessionScope.SessionAdminSuperID }"/>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/main.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<title>패키지여행 상세화면</title>
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
   //게시글 삭제
   $("#button1").click(function(){ 
       let adminid = "${s_adminid}";
       let superid = "${s_superid}";
      
      var form = $("#frm").serialize();
      if( !confirm("삭제하시겠습니까?") ) {
         return false;
      }
      $.ajax({
         // 전송 세팅
         type : "POST",
         data : form,
         url  : "/packBoardDelete.do",
         // 리턴 세팅
         datatype : "text",
         success : function(data) {
             if(data == "ok") {
               if (adminid || superid) {
                       alert("삭제완료!");
                       location = "/adminPackList.do";
                   } else {
                       alert("삭제완료!");
                       location = "/packBoardList.do";
                   }
             }
          },
          error : function() {
             alert("전송실패");
          }
      });   
   });
   //댓글 입력
   $("#button2").click(function(){ 
      
      let packcmcontent = $("#packcmcontent").val();
      let packcmpass = $("#packcmpass").val();
      let packunq = $("#packunq").val();
      let userid = $("#userid").val();
      let cmunq = $("#cmunq").val();
      
      if( packcmcontent == "" ) {
         alert("댓글 내용을 입력해주세요");
         return false;
      }
      if( packcmpass == "" ) {
         alert("댓글 암호를 입력해주세요");
         return false;
      }
      
      $("#packcmcontent").val($.trim(packcmcontent));
      $("#packcmpass").val(packcmpass);
      $("#packunq").val(packunq);
      $("#userid").val(userid);
      $("#cmunq").val(cmunq);
      
      var form = $("#frm").serialize();
      $.ajax({
         // 전송 세팅
         type : "POST",
         data : form,
         url  : "/packBoardCmWriteSave.do",
         // 리턴 세팅
         datatype : "text",
         success : function(data) {
             if(data == "ok") {
               alert("작성완료!");
               location = "/packBoardDetail.do?packunq=${vo.packunq}&userid=${s_userid}";
             }else if (data=="ok1"){
               alert("수정완료!");
               location = "/packBoardDetail.do?packunq=${vo.packunq}&userid=${s_userid}";
             }
          },
          error : function() {
             alert("전송실패");
          }
      });   
   });


$(function(){
   //좋아요 버튼
   $("#button_like").click(function(){ 
         
         let packunq = $("#packwunq").val();
         let userid = $("#userid").val();
         let packlike = $("#packlike").val();
         
         if( userid == null ) {
            alert("회원만 추천이 가능합니다.");
            return false;
         }
         
         var form = $("#frm").serialize();
         $.ajax({
            // 전송 세팅
            type : "POST",
            data : form,
            url  : "/packLikeSave.do",
            // 리턴 세팅
            datatype : "text",
            success : function(data) {
                if(data == "ok") {
                  alert("추천되었습니다.");
                  location = "/packBoardDetail.do?packunq=${vo.packunq}&userid=${s_userid}";
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
         
         let packunq = $("#packunq").val();
         let userid = $("#userid").val();
         let packlike = $("#packlike").val();
         
         if( userid == null ) {
            alert("회원만 추천이 가능합니다.");
            return false;
         }
         
         var form = $("#frm").serialize();
         $.ajax({
            // 전송 세팅
            type : "POST",
            data : form,
            url  : "/packLikeDelete.do",
            // 리턴 세팅
            datatype : "text",
            success : function(data) {
                if(data == "ok") {
                  alert("추천 취소 되었습니다.");
                  location = "/packBoardDetail.do?packunq=${vo.packunq}&userid=${s_userid}";
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
      
//패키지 참여하기
 $("#button3").click(function(){ 
      
      let packunq = $("#packunq").val();
      let userid = $("#userid").val();
      let packtitle = $("#packtitle").val();
      let packsdate = $("#packsdate").val();
      let packedate = $("#packedate").val();
      let packloc = $("#packloc").val();
      
        let packsdateDate = new Date(packsdate);
        let currentDate = new Date();
      if( packsdateDate < currentDate){
         alert("이미 시작한 패키지입니다.");
         return false;
      }
      
      var form = $("#frm").serialize();
      $.ajax({
         // 전송 세팅
         type : "POST",
         data : form,
         url  : "/packReserveSave.do",
         // 리턴 세팅
         datatype : "text",
         success : function(data) {
             if(data == "ok") {
               alert("참여완료!");
               location = "/packBoardDetail.do?packunq=${vo.packunq}&userid=${s_userid}";
             }else {
                alert("이미 참여한 패키지입니다.!");
             }
          },
          error : function() {
             alert("전송실패");
          }
      });   
   });
});
//패키지 참여취소
$("#button4").click(function(){ 
      
      var form = $("#frm").serialize();
      $.ajax({
         // 전송 세팅
         type : "POST",
         data : form,
         url  : "/packReserveDelete.do",
         // 리턴 세팅
         datatype : "text",
         success : function(data) {
             if(data == "ok") {
               alert("패키지여행 참여가 취소되었습니다.");
               location = "/packBoardDetail.do?packunq=${vo.packunq}&userid=${s_userid}";
             }else {
                alert("취소 불가.!");
             }
          },
          error : function() {
             alert("전송실패");
          }
      });   
   });
});


//댓글삭제
function fn_delete(cmunq) {
   
   if( !confirm("댓글을 삭제하시겠습니까?") ) {
      return false;
   }
   
   $.ajax({
      type : "POST",
      url  : "/packBoardCmDelete.do",
      data : {"cmunq":cmunq},
      datatype : "text",
      success : function(data) {
          if(data == "ok") {
            alert("삭제완료!");
            location = "/packBoardDetail.do?packunq=${vo.packunq}&userid=${s_userid}";
          } else {
             alert("삭제실패!");
          }
       },
       error : function() {
          alert("전송실패");
       }
   });
}

   //댓글수정
   function fn_action(packcmcontent,rownumber,cmunq) {  // 수정처리
      $("#packcmcontent").val(packcmcontent);
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
<form name="frm" id="frm" method="post">
<input type="hidden" name="packtitle" id="packtitle" value="${vo.packtitle }">
<input type="hidden" name="userid" id="userid" value="${s_userid }">
<input type="hidden" name="packsdate" id="packsdate" value="${vo.packsdate }">
<input type="hidden" name="packedate" id="packedate" value="${vo.packedate }">
<input type="hidden" name="packloc" id="packloc" value="${vo.packloc }">
<input type="hidden" name="packunq" value="${vo.packunq }">
<table class="board1" align="center" style="margin-top:30px;">
    <tr>
       <th width="25%">패키지여행 제목</th>
       <th>${vo.packtitle }</th>
    </tr>
    <tr>
       <th>패키지여행사진</th>
       <th>
           <img src="<c:url value='/tripImage/${vo.packsrc1 }'/>" width="500" height="500">
       </th>
    </tr>
    <tr>
       <th>패키지여행 일자</th>
       <th>${vo.packsdate} ~ ${vo.packedate }</th>
    </tr>
    <tr>
       <th>패키지여행 요금</th>
       <th>${vo.packcharge }원</th>
    </tr>
    <tr>
       <th>패키지여행 지역</th>
       <th>${vo.packloc }</th>
    </tr>
<%--     <tr>
       <th>패키지여행 내용</th>
       <th>${vo.packcontent }</th>
    </tr> --%>
 </table>
<!-- 패키지 참여하기 버튼 -->
     <div align="center">
    <c:if test="${s_userid != null and cancle == 0}">
    <button type="button" id="button3">패키지 참여</button>
   </c:if>
    <c:if test="${s_userid != null and cancle != 0}">
    <button type="button" id="button4">패키지 참여취소</button>
   </c:if>
   </div>
 
    <!--  좋아요 추천 -->
    <div class="like_wrap">
      <div>
         <p>좋아요&nbsp; &nbsp;</p>
         <span>
         <c:if test="${s_userid != null and s_userid!=vo.bsnmid and likeCancle == 0}">
            <button type="button" class="button_like" id="button_like" onclick="return false;">
            <img src="/tripImage/thumpsup.png" style="width:50px;"></button>
         </c:if>
         <c:if test="${s_userid != null and s_userid!=vo.bsnmid and likeCancle != 0}">
            <button type="button" class="button_like_cancle" id="button_like_cancle" onclick="return false;">
            <img src="/tripImage/thumpsup2.png" style="width:50px;"></button>
         </c:if>
         </span>
         <span>${vo.packstar } </span>
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
          <th >번호</th>
          <th >아이디</th>
          <th >내용</th>
          <th >작성일자</th>
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
          ${cmlist.packcmcontent } 
          </td>
          <td>
          ${cmlist.packcmrdate }
          </td>
          <c:if test="${s_userid eq cmlist.userid }">
          <td><a  href="javascript:fn_action('${cmlist.packcmcontent }','${rownumber}','${cmlist.cmunq }')">수정</a></td>
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
    
<!-- 댓글작성 및 수정 -->    
    <c:if test="${s_userid != null }">
    <table border="1" width="700" align="center" style="margin-top:20px; margin-bottom:20px; margin-bottom:20px;border-left:none;border-right: none;" >
       <tr>
          <th>
          ${s_userid}
          </th>
          <th>
          <input type="text" name="rownumber" id="rownumber" value="${rownumber}" size="3px" readonly> 
          </th>
          <th>
          <input type="text" name="packcmcontent" id="packcmcontent" size="20px"> 
          </th>
       </tr>
          <input type="hidden" id="cmunq" name="cmunq">
    </table>   
       <div align="center">
       <button type="button" id="button2" onclick="return false;">댓글 등록하기</button>

       </div>
       </c:if>
 
 <!-- 이전 목록 수정 삭제 -->
 <div style="margin-top:10px; margin-bottom:10px; text-align:center;" >
    <button type="button" onclick="history.back();">이전</button>
    <button type="button" onclick="location='/packBoardList.do'">목록</button>
   <c:if test="${s_bsnmid eq vo.bsnmid or s_adminid != null or s_superid != null }">
    <button type="button" onclick="location='/packBoardModify.do?packunq=${vo.packunq}'">수정</button>
   <button type="button" id="button1">삭제</button>
   </c:if>
   </form>
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
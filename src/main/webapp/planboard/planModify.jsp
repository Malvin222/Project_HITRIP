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
<style>
  body {
    font-family: Arial, sans-serif;
  }
  .wrap {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
  }
  section {
    flex-grow: 1;
    background-color: #f0f0f0;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
  }
  .container {
    border: 1px solid #ccc;
    border-radius: 10px;
    padding: 20px;
    background-color: white;
  }
  table {
    width: 1100px; /* Set the table width to 1100px */
    margin: 0 auto;
    border-collapse: collapse;
    border: 1px solid #ccc;
  }
  th, td {
    padding: 10px;
    border: 1px solid #ccc;
  }
  th {
    background-color: #f2f2f2;
    width: 20%;
    font-weight: bold;
  }
  td {
    vertical-align: top;
  }
  textarea {
    width: 100%;
    height: 150px;
    resize: none;
    padding: 5px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
  }
  button {
    margin-top: 20px;
    padding: 8px 16px;
    font-size: 16px;
    border: none;
    background-color: #007bff;
    color: white;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s ease;
  }
  button:hover {
    background-color: #0056b3;
  }
.button-container {
    display: flex;
    justify-content: flex-end; /* Align buttons to the right */
    margin-top: 20px;
}

.button-container button {
    margin-left: 10px; /* Add some left margin to create spacing between buttons */
}

</style>

<script>
	//	년 월 일로 분리되어있는 파라미터 값을 합쳐서 date타입에 적용
    const planYear = "${PlanVO.planyear}";
    const planMonth = "${PlanVO.planmonth}".padStart(2, '0');
    const planDay = "${PlanVO.planday}".padStart(2, '0');
    
    const formattedDate = `${planYear}-${planMonth}-${planDay}`;
    
    document.getElementById("plansdate").value = formattedDate;
    
    const planeYear = "${PlanVO.planeyear}";
    const planeMonth = "${PlanVO.planemonth}".padStart(2, '0');
    const planeDay = "${PlanVO.planeday}".padStart(2, '0');
    
    const formattedDate = `${planeYear}-${planeMonth}-${planeDay}`;
    
    document.getElementById("planedate").value = formattedDate;
</script>

<script>
$(function(){
	//	입력한 날짜 년 월 일로 분리작업
	function updateHiddenFields() {
        const plansdateValue = $("#plansdate").val();
        const [year, month, day] = plansdateValue.split("-");
        
        const planedateValue = $("#planedate").val();
        const [eyear, emonth, eday] = planedateValue.split("-");
        
        $("#planyear").val(year);
        $("#planmonth").val(month);
        $("#planday").val(day);
        
        $("#planeyear").val(eyear);
        $("#planemonth").val(emonth);
        $("#planeday").val(eday);
        
        
    }
    
    // plansdate에 값이 입력될때마다 해당히든값 업데이트
    $("#plansdate").on("change", updateHiddenFields);   
    $("#planedate").on("change", updateHiddenFields);   
    updateHiddenFields();    
    
    $("#btn01").click(function(){
       if($("#plantitle").val() =="" ){
          alert("제목을 입력해주세요.");
          $("#plantitle").focus();
          return false;
       }
       if($("#plansdate").val() =="" ){
           alert("날짜를 입력해주세요.");
           $("#plansdate").focus();
           return false;
       }
       if($("#plancontent").val() =="" ){
           alert("일정을 입력해주세요.");
           $("#plancontent").focus();
           return false;
       }
       if($("#plansdate").val() > $("#planedate").val() ){
           alert("날짜가 올바르지 않습니다.");
           $("#plansdate").focus();
           return false;
       }
       
       if (!$("input[name='planopen']").prop("checked")) {
    	   if(confirm("동행찾기 체크가 해제되어있습니다.\n등록된 동행찾기글이 삭제됩니다.")){
    		   
    	   } else {
    		   return false;
    	   }
		}
       
       /**
          serialize(); : 폼안의 데이터 값들을 한번에 전송가능한 상태로 만듬
       */
       var form = $("#frm").serialize();
       
        $.ajax({
        // 전송관련 세팅
        type : "POST",
        data : form,
        url  : "/planModifySave.do",
        
        // 반환관련 세팅
        datatype : "text",   // json : 여러형식의 데이터 값을 받을 수 있음 
        success  : function(data){
           if(data=="ok"){
           alert("일정이 변경되었습니다.");
           location= "/planMain.do";
        } else {
              alert("저장실패");
           }            
        },
        error : function(){
           alert("전송실패!");
        }         
     });         
   });
   
   $("#btn02").click(function(){
	location = "/planMain.do";
 });
});
</script>

<title>일정관리</title>
</head>

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
	 <div class="sec1">
	      <div class="flex-item">
	        <div class="container">
	          <div class="content_area">
	          	<form name="frm" id="frm" >
				<input type="hidden" name="planunq" value="${PlanVO.planunq }">
				<input type="hidden" name="userid" value="${PlanVO.userid }">
				<input type="hidden" name="planyear" id="planyear" value="${PlanVO.planyear}">	<!-- 시작년 -->
			    <input type="hidden" name="planmonth" id="planmonth" value="${PlanVO.planmonth}">	<!-- 시작월 -->
			    <input type="hidden" name="planday" id="planday" value="${PlanVO.planday}">		<!-- 시작일 -->
			    <input type="hidden" name="planeyear" id="planeyear" value="${PlanVO.planeyear}">	<!-- 종료년 -->
			    <input type="hidden" name="planemonth" id="planemonth" value="${PlanVO.planemonth}">	<!-- 종료월 -->
			    <input type="hidden" name="planeday" id="planeday" value="${PlanVO.planeday}">		<!-- 종료일 -->
	            <table>
	              <tr>
	                <th>제목</th>
	                <td><input type="text" name="plantitle" id="plantitle" value="${PlanVO.plantitle}"></td>
	              </tr>
	              <tr>
					<th>일정</th>
				  	<td>
				  		<input type="date" name="plansdate" id="plansdate" value="${plansdate}">
				  		~
				  		<input type="date" name="planedate" id="planedate" value="${planedate}">
				  	</td>
				  </tr>
	              <tr>
	                <th>내용</th>
	                <td><textarea name="plancontent" id="plancontent">${PlanVO.plancontent}</textarea></td>
	              </tr>
	              <tr>
	                <th>동행등록</th>
	                <td><input type="checkbox" name="planopen" id="planopen" value="Y"
	                	<c:if test="${PlanVO.planopen=='등록' }">checked</c:if> ></td>
	              </tr>
	            </table>
	            <div class="button-container">
	                <button type="button" id="btn01">수정하기</button>
	                <button type="button" id="btn02">취소하기</button>
            	</div>
            	</form>
	          </div>
	        </div>
	      </div>
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
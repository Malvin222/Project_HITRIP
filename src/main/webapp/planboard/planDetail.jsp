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
   //   년 월 일로 분리되어있는 파라미터 값을 합쳐서 date타입에 적용
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
       $("#btn01").click(function(){
          $("#frm").attr("action","/planModify.do");
          $("#frm").submit();
       });
       $("#btn02").click(function(){          
          location = "/planMain.do";
       });
       $("#btn03").click(function(){
          if( confirm("정말 삭제하시겠습니까?") ) {
             fn_submit("/planDelete.do");
          }
       });   
       $("#btn04").click(function(){
            let planedateValue = document.getElementById("planedate").value;
            let planedateDate = new Date(planedateValue);
            let currentDate = new Date();
            let planopen = "${PlanVO.planopen}";

            if (planedateDate < currentDate) {
                alert("이미 지난 일정입니다.");
                return false;
            }
            if (planopen === "등록") {
               alert("이미 등록된 일정입니다.");
               return false;
            }
          
          if( confirm("동행찾기 등록으로 전환됩니다") ) {
             
             $("#frm").attr("action","/prtBoardWrite.do");
              $("#frm").submit();
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
            location= "/planMain.do";
         } else {
               alert("삭제실패");
            }            
         },
         error : function(){
            alert("전송실패!");
         }         
       });
    };

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
				<input type="hidden" name="planopen" id="planopen" value="${PlanVO.planopen}">
				</form>
	            <table>
	              <tr>
	                <th>제목</th>
	                <td><input type="text" name="plantitle" id="plantitle" value="${PlanVO.plantitle}" readonly></td>
	              </tr>
	              <tr>
					<th>일정</th>
				  	<td>
				  		<input type="date" name="plansdate" id="plansdate" value="${plansdate}" readonly>
				  		~
				  		<input type="date" name="planedate" id="planedate" value="${planedate}" readonly>
				  	</td>				  	
				  </tr>
	              <tr>
	                <th>내용</th>
	                <td><textarea name="plancontent" id="plancontent" readonly>${PlanVO.plancontent}</textarea></td>
	              </tr>
	              <tr>
	                <th>동행등록</th>
	                <td>
	                	${PlanVO.planopen}
	                	<button type="button" id="btn04">동행찾기</button>
	                </td>
	              </tr>
	            </table>
	            <div class="button-container">
	                <button type="button" id="btn01">수정하기</button>
	                <button type="button" id="btn02">목록보기</button>
	                <button type="button" id="btn03">삭제하기</button>
            	</div>
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
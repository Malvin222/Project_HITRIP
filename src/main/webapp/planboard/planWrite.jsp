<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 등록</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
</head>

<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
    margin: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}
.popup-container {
    border: 2px solid #ccc;
    padding: 20px;
    background-color: #fff;
    width: 380px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}
.popup-title {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 10px;
}
.form-row {
    margin-bottom: 15px;
}
.form-label {
    display: inline-block;
    width: 100px;
    font-weight: bold;
}
.form-input {
    width: 250px;
    padding: 5px;
    border: 1px solid #ccc;
}
.form-textarea {
    width: 250px;
    height: 100px; /* 조정된 높이 */
    padding: 5px;
    border: 1px solid #ccc;
    resize: none;
}
.btn_submit {
  padding: 10px 20px;
  background-color: #333;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.btn_cancel {
  display: inline-block;
  padding: 10px 20px;
  color: #333;
  border: 1px solid #333;
  border-radius: 5px;
  text-decoration: none;
  margin-left: 10px;
}

.btn_cancel:hover {
  background-color: #333;
  color: #fff;
}
.result-text {
    margin-top: 15px;
    font-size: 16px;
    font-weight: bold;
    color: #f00;
}
</style>

<script>

$(function(){
	
	$("#button2").click(function(){
		self.close();
	});
	
	$("#button1").click(function(){
		//	DB에 넣기 위해 년,월,일로 분리작업
		let plansdate = $("#plansdate").val();
		let planedate = $("#planedate").val();
		
		plansdate = plansdate.split("-");
		planedate = planedate.split("-");
		
		let planyear = plansdate[0];
		let planmonth = plansdate[1];
		let planday = plansdate[2];
		
		let planeyear = planedate[0];
		let planemonth = planedate[1];
		let planeday = planedate[2];
		
		let plantitle = $.trim($("#plantitle").val());
		let plancontent = $.trim($("#plancontent").val());
		let planopen = $("#planopen").val();
		
		if(plansdate == "") {
			alert("시작날짜를 입력해주세요.");
			$("#plansdate").focus();
			return false;
		}
		if(planedate == "") {
			alert("종료날짜를 입력해주세요.");
			$("#planedate").focus();
			return false;
		}
		if(plantitle == "") {
			alert("제목을 입력해주세요.");
			$("#plantitle").focus();
			return false;
		}
		if(plantitle.length > 33) {
			alert("제목의 길이 는 33글자까지입니다.");
			$("#plantitle").focus();
			return false;
		}
		if(plancontent == "") {
			alert("내용을 입력해주세요.");
			$("#plancontent").focus();
			return false;
		}
		if(plansdate > planedate){
			alert("동행 시작 종료일자가 올바르지 않습니다.")
			return false;
		}
		
		let datas = {"planyear":planyear,"planmonth":planmonth,"planday":planday
					,"planeyear":planeyear,"planemonth":planemonth,"planeday":planeday
					,"plantitle":plantitle,"plancontent":plancontent,"planopen":planopen};
		
		$.ajax({
			
			type : "POST",
			url  : "/planWriteSave.do",
			data : datas,
			
			datatype : "text",
	         success  : function(data){
	        	 if(data == "1") {
	                alert("일정이 등록되었습니다.");
	                opener.parent.location.reload();
	                window.close();
	             }else {
	                alert("저장실패!");
	             }
	         },
	         error : function(){
	            alert("전송실패");
	         }			
		});		
	});	
});

</script>

<body>
<form name="frm" id="frm">
<div class="popup-container">
    <div class="popup-title">일정등록</div>    
    <div class="form-row" id="date_area">
        <span class="form-label">시작날짜:</span>
        <input type="date" class="form-input" name="plansdate" id="plansdate">
    </div>
    <div class="form-row" id="date_area">
        <span class="form-label">종료날짜:</span>
        <input type="date" class="form-input" name="planedate" id="planedate">
    </div>
    <div class="form-row" id="title_area">
        <span class="form-label">제목:</span>
        <input type="text" class="form-input" name="plantitle" id="plantitle">
    </div>
    <div class="form-row" id="content_area">
        <span class="form-label">내용:</span>
        <textarea name="plancontent" id="plancontent" class="form-textarea"></textarea>
    </div>
    <input type="hidden" name="planopen" id="planopen" value='N' />
	<div class="form-row" id="button_area">
        <button type="submit" id="button1" onclick="return false;" class="btn_submit">전송</button>
        <button type="reset" id="button2" class="btn_cancel">취소</button>
    </div>
</div>
</form>
</body>

</html>
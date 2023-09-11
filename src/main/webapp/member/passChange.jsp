<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>패스워드 변경</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
</head>

<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
}
.popup-container {
    border: 2px solid #ccc;
    padding: 20px;
    background-color: #fff;
    width: 300px;
    margin: 0 auto;
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
    width: 180px;
    padding: 5px;
    border: 1px solid #ccc;
}
.result-text {
    margin-top: 15px;
    font-size: 16px;
    font-weight: bold;
    color: #f00;
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
</style>

<script>

$(function(){
	
	$("#button2").click(function(){
		self.close();
	});
	
	$("#button1").click(function(){
		let pass1 = $.trim($("#pass1").val());	//	현재암호
		let pass2 = $.trim($("#pass2").val());	//	변경암호
		let pass3 = $.trim($("#pass3").val());	//	암호확인
				
		if(pass1 == "") {
			alert("현재 암호를 입력해주세요.");
			$("#pass1").focus();
			return false;
		}
		if ( pass2.length < 4 || pass2.length > 20 ) {
	         alert("암호는 4~20자 사이로 입력해주세요.");
	         $("#pass2").focus();
	         return false;
	    }
		if( pass2 != pass3 ) {
	    	  alert("변경암호와 암호확인이 일치하지 않습니다.");
	    	  $("#pass2").focus();
	          return false;
	    }
		if(pass2 == "") {
			alert("변경하실 암호를 입력해주세요.");
			$("#pass2").focus();
			return false;
		}
		if(pass3 == "") {
			alert("변경하신 암호 확인을 해주세요.");
			$("#pass3").focus();
			return false;
		}
		
		//	let datas2 = "userid="+userid+"&nickname="+nickname+"$email="+email;		
		let datas = {"pass1":pass1,"pass2":pass2};
		
		$.ajax({
			
			type : "POST",
			url  : "/passChangeSub.do",
			data : datas,
			
			datatype : "text",
	         success  : function(data){
	        	 if(data == "4") {
	        		 alert("암호가 일치하지 않습니다.");
	        		 $("#pass1").focus();
	        	 } else if(data == "1"){
	        		alert("암호가 변경되었습니다.\n다시 로그인 시 적용됩니다.");
	        		opener.location.href='/';	//	기존창 이동
	        		self.close();				//	팝업창 닫기
	        	 } else {
	        		 alert("변경실패.");
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
<div class="popup-container">
    <div class="popup-title">암호변경</div>
    <div class="form-row" id="id_area">
        <span class="form-label">현재암호:</span>
        <input type="password" class="form-input" name="pass1" id="pass1">
    </div>
    <div class="form-row" id="nick_area">
        <span class="form-label">변경암호:</span>
        <input type="password" class="form-input" name="pass2" id="pass2">
    </div>
    <div class="form-row" id="email_area">
        <span class="form-label">암호확인:</span>
        <input type="password" class="form-input" name="pass3" id="pass3">
    </div>
    <div class="form-row" id="button_area">
        <button type="submit" id="button1" onclick="return false;" class=btn_submit>전송</button>
        <button type="reset" id="button2" class="btn_cancel">취소</button>
    </div>
    <div class="result-text" id="result_text">결과: <span></span></div>
</div>

</body>

</html>
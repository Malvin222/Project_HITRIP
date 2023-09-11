<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 비밀번호 찾기</title>
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
	
	//아이디 찾기시 아이디 입력창 숨기기
	$("#idpw1").click(function(){		
		$("#id_area").css('display',"none");
		$('#userid').val('');
	});
	//패스워드 찾기시 아이디 입력창 보이기
	$("#idpw2").click(function(){		
		$("#id_area").css('display',"block");		
	});
	
	$("#button1").click(function(){
		let userid = $.trim($("#userid").val());
		let usernickname = $.trim($("#usernickname").val());
		let useremail = $.trim($("#useremail").val());
		
		if( $("#idpw1").is(":checked") == false && 
			$("#idpw2").is(":checked") == false ) {
			alert("아이디 또는 비밀번호를 체크해주세요.");
			return false;
		}
		
		if( $("#idpw2").is(":checked") == true ) {	// 패스워드찾기를 선택했을 경우
			if(userid == "") {
				alert("아이디를 입력해주세요.");
				$("#userid").focus();
				return false;
			}
		}
		
		if(usernickname == "") {
			alert("닉네임을 입력해주세요.");
			$("#usernickname").focus();
			return false;
		}
		if(useremail == "") {
			alert("이메일을 입력해주세요.");
			$("#useremail").focus();
			return false;
		}
		
		//	let datas2 = "userid="+userid+"&nickname="+nickname+"$email="+email;		
		let datas = {"userid":userid,"usernickname":usernickname,"useremail":useremail};
		
		$.ajax({
			
			type : "POST",
			url  : "/idpwSearchSub.do",
			data : datas,
			
			datatype : "text",
	         success  : function(data){
	        	 if(data == "4") {
	        		 alert("정보가 일치하지 않습니다.");
	        		 $("#nickname").focus();
	        	 }
	        	 //	결과값 보여주기
	            $("#result_text").html("<font color='red'><b>"+data+"</b></font>");
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
    <div class="popup-title">ID & PW Search</div>
    <div class="form-row" id="id_area">
        <span class="form-label">아이디:</span>
        <input type="text" class="form-input" name="userid" id="userid">
    </div>
    <div class="form-row" id="nick_area">
        <span class="form-label">닉네임:</span>
        <input type="text" class="form-input" name="usernickname" id="usernickname">
    </div>
    <div class="form-row" id="email_area">
        <span class="form-label">이메일:</span>
        <input type="text" class="form-input" name="useremail" id="useremail">
    </div>
    <div class="form-row">
        <input type="radio" name="idpw" value="1" id="idpw1">
        <label for="idpw1">아이디찾기</label>
        <input type="radio" name="idpw" value="2" id="idpw2">
        <label for="idpw2">패스워드찾기</label>
    </div>
    <div class="form-row" id="button_area">
        <button type="submit" id="button1" onclick="return false;" class="btn_submit">전송</button>
        <button type="reset" id="button1" class="btn_cancel">취소</button>
    </div>
    <div class="result-text" id="result_text">결과: <span></span></div>
</div>

</body>

</html>
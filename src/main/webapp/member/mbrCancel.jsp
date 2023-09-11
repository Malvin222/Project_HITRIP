<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
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
    display: block;
    font-weight: bold;
    margin-bottom: 10px;
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
      let pass = $.trim($("#pass").val());   //   현재암호
            
      
      if ( pass.length < 4 || pass.length > 20 ) {
            alert("암호가 틀렸습니다.");
            $("#pass").focus();
            return false;
       }
      
      //   let datas2 = "userid="+userid+"&nickname="+nickname+"$email="+email;      
      let datas = {"pass":pass};
      
      $.ajax({
         
         type : "POST",
         url  : "/mbrCancelSub.do",
         data : datas,
         
         datatype : "text",
            success  : function(data){
               if(data == "4") {
                  alert("암호가 일치하지 않습니다.");
                  $("#pass1").focus();
               } else if(data == "1"){
                 alert("탈퇴가 완료되었습니다.");
                 self.close();
                 window.opener.location = "/";
               } else if(data == "2") {
                  alert("비정상접근입니다.");
                  removeAttribute();
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
    <div class="popup-title">회원탈퇴</div>
    <div class="form-row" id="email_area">
        <span class="form-label">비밀번호를 입력해주세요</span>
    </div>
    <div>
       <input type="password" class="form-input" name="pass" id="pass">
    </div>
    
    <div class="form-row" id="button_area">
        <button type="submit" id="button1" onclick="return false;" class=btn_submit>전송</button>
        <button type="reset" id="button2" class="btn_cancel">취소</button>
    </div>
</div>

</body>

</html>
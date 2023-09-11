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

<title>사업자 로그인 화면</title>
</head>

<style>
  /* Custom CSS for the <section> */
  section {
    padding: 20px;
    text-align: center;
    max-width: 500px;
    margin: 0 auto;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #f9f9f9;
  }

  h1 {
    margin-bottom: 20px;
  }

  label {
    display: block;
    font-weight: bold;
    margin-top: 10px;
  }

  input[type="text"],
  input[type="password"] {
    width: 95%;
    padding: 10px;
    margin-bottom: 10px; /* Adjusted to make it less */
    border: 1px solid #ccc;
    border-radius: 5px;
  }

  .btn_submit {
    display: inline-block;
    padding: 10px 20px;
    background-color: #333;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
  }

  #login_auto_login {
    margin-right: 5px;
  }

  #login_info {
    margin-top: 30px;
    text-align: left;
  }

  #login_info h2 {
    font-size: 18px;
    margin-bottom: 10px;
  }

  #login_info p {
    font-size: 14px;
    line-height: 1.5;
  }

  #login_info div {
    margin-top: 20px;
    text-align: center; /* Center the buttons */
  }

  .btn02,
  .btn03,
  .btn04 {
    display: inline-block;
    padding: 10px 20px;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
  }

  .btn02 {
    background-color: #999;
    margin-top: 10px;
  }

  .btn03 {
    background-color: #333;
  }
  
  .btn04 {
    background-color: #333;
  }

  a {
    color: #333;
    text-decoration: none;
  }

  a:hover {
    text-decoration: underline;
  }

</style>

<script>
$(function(){
	
	$("#button2").click(function(){
		
		var url = "/bsnmIdpwSearch.do";
		window.open(url,"popup","width=400,height=300");
		
	});
	
	$("#button1").click(function(){
		
		var bsnmid = $("#bsnmid").val();
		var bsnmpass   = $("#bsnmpass").val();
		
		if( bsnmid == "" || bsnmpass == "" ) {
			alert("아이디 또는 암호를 확인해주세요.");
			return false;
		}
		
		var datas = {"bsnmid":bsnmid,"bsnmpass":bsnmpass};
		
		$.ajax({
			type : "POST",
			data : datas,
			url  : "/bsnmloginSession.do",
			
			datatype : "text",
			success  : function(data){
	            if(data == "4" ) {
	               alert("로그인 할 수 없습니다.\n관리자에게 문의바랍니다.");
	               location="/";
	            } else if( data != "" && data != "4" ) {
	               alert(data+"(사업자)님 로그인되었습니다.\n환영합니다.");
	               location="/";
	            } else {
	            	alert("아이디 또는 암호가 일치하지 않습니다.");
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
    <form style="margin: 0; padding: 0; border: 0;" name="frm">
        <div class="mbskin" id="mb_login">
            <h1>사업자 로그인</h1>
            <fieldset id="login_fs">
                <legend>사업자로그인</legend>
                <label class="login_id" for="bsnmid">사업자아이디 필수</label>
                <input autofocus class="frm_input required" id="bsnmid" name="bsnmid" maxLength="20" required size="20" type="text">
                <label class="login_pw" for="bsnmpass">비밀번호</label>
                <input class="frm_input required" id="bsnmpass" name="bsnmpass" required size="20" type="password">
                <input class="btn_submit" type="submit" value="로그인" id="button1" onclick="return false;">
                <!-- <label for="login_auto_login">자동로그인</label>
                <input id="login_auto_login" name="auto_login" type="checkbox"> -->
            </fieldset>

            <aside id="login_info">
                <h2>사업자로그인 안내</h2>
                <p>사업자아이디 및 비밀번호가 기억 안나실 때는 아이디/비밀번호 찾기를 이용하십시오.<br>
                아직 사업자가 아니시라면 회원으로 가입 후 이용해 주십시오.</p>
                <div>                    
                    <a class="btn03" id="button3" href="/mbrConditions.do">개인회원 가입</a>
                    <a class="btn04" id="button3" href="/bsnmConditions.do">사업자회원 가입</a><br>
                    <a class="btn02" id="button2" href="#" target="">아이디 비밀번호 찾기</a>
                </div>
            </aside>
            <div style="text-align:center">
                <a href="/">메인으로 돌아가기</a>
            </div>
        </div>
    </form>
</section>
<!--section 끝-->



<!--footer 시작-->
<footer>
<div class="footer1">
	<%@include file="../include/footer.jsp" %>
</div>
</footer>
<!--footer 끝-->
</div>


  </body>
</html>
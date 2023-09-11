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

<title>회원가입</title>
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

  h2 {
    margin-bottom: 20px;
  }

  label {
    display: block;
    font-weight: bold;
    margin-top: 10px;
  }


  #login_auto_login {
    margin-right: 5px;
  }

  #login_info {
    margin-top: 30px;
    text-align: center;
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
		
		var url = "/idpwSearch.do";
		window.open(url,"popup","width=400,height=300");		
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

            <aside id="login_info">
                <h2>회원가입 안내</h2>
                <p>아이디 및 비밀번호가 기억 안나실 때는 아이디/비밀번호 찾기를 이용하십시오.<br>
                아직 회원이 아니시라면 회원으로 가입 후 이용해 주십시오.</p>
                <div>                    
                    <a class="btn03" id="button3" href="/mbrConditions.do">개인회원 가입</a>
                    <a class="btn04" id="button3" href="/bsnmJoinWrite.do">사업자회원 가입</a><br>
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
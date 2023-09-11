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

<title>로그인 화면</title>
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
	
	$(document).ready(function() {
	    var userid, userpass;
	    var currentUrlIndex = 0;

	    // urls 배열 선언 및 초기화
	    var urls = ["/loginSession.do", "/bsnmloginSession.do", "/adminLoginSession.do"];

	    function handleLogin(url) {
	        var datas = {
	            "userid": userid,
	            "userpass": userpass
	        };
			//	bsnm을 돌때는 키값이 bsnm admin을 돌때는 admin
	        if (url.indexOf("/bsnmloginSession.do") !== -1) {
	            datas["bsnmid"] = datas["userid"];
	            datas["bsnmpass"] = datas["userpass"];
	            delete datas["userid"];
	            delete datas["userpass"];
	        } else if (url.indexOf("/adminLoginSession.do") !== -1) {
	            datas["adminid"] = datas["userid"];
	            datas["adminpass"] = datas["userpass"];
	            delete datas["userid"];
	            delete datas["userpass"];
	        }

	        $.ajax({
	            type: "POST",
	            data: datas,
	            url: url,
	            datatype: "text",
	            success: function(data) {
	                if (data === "4") {
	                    alert("로그인 할 수 없습니다.\n관리자에게 문의바랍니다.");
	                    location = "/";
	                } else if( data != "" && data != "4" && data.indexOf("유저") !== -1) {
	 	               alert(data+"님 로그인되었습니다.\n환영합니다.");
		               location="/";
		            } else if( data != "" && data != "4" && data.indexOf("사업자") !== -1) {
			               alert(data+"님 로그인되었습니다.\n환영합니다.");
			               location="/packBoardList.do";
			        } else if( data != "" && data != "4" && data.indexOf("관리자") !== -1 ||
			        		   data != "" && data != "4" && data.indexOf("최고관리자") !== -1 ) {
			               alert(data+"님 로그인되었습니다.\n환영합니다.");
			               location="/adminNoticeList.do";
			        } else {
	                    alert("아이디 또는 암호가 일치하지 않습니다.");
	                }
	            },
	            error: function() {
	               	// AJAX 요청이 실패하면 다음 URL로 시도
	                currentUrlIndex++;
	                performLoginAttempts();
	            }
	        });
	    }

	    function performLoginAttempts() {
	        if (currentUrlIndex < urls.length) {
	            handleLogin(urls[currentUrlIndex]);
	        } else {
	            alert("아이디 또는 비밀번호를 확인해주세요.");
	            location.reload(); // 화면 리프레시
	        }
	    }

	    $("#button1").click(function() {
	        userid = $("#userid").val();
	        userpass = $("#userpass").val();

	        if (userid === "" || userpass === "") {
	            alert("아이디 또는 암호를 확인해주세요.");
	            return false;
	        }

	        performLoginAttempts();
	    });
	});

	
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
            <h1>로그인</h1>
            <fieldset id="login_fs">
                <legend>회원로그인</legend>
                <label class="login_id" for="userid">회원아이디 필수</label>
                <input autofocus class="frm_input required" id="userid" name="userid" maxLength="20" required size="20" type="text" style = "ime-mode:inactive" >
                <label class="login_pw" for="userpass">비밀번호</label>
                <input class="frm_input required" id="userpass" name="userpass" required size="20" type="password">
                <input class="btn_submit" type="submit" value="회원로그인" id="button1" onclick="return false;">
                <!-- <label for="login_auto_login">자동로그인</label>
                <input id="login_auto_login" name="auto_login" type="checkbox"> -->
            </fieldset>

            <aside id="login_info">
                <h2>회원로그인 안내</h2>
                <p>회원아이디 및 비밀번호가 기억 안나실 때는 아이디/비밀번호 찾기를 이용하십시오.<br>
                아직 회원이 아니시라면 회원으로 가입 후 이용해 주십시오.</p>
                <div>                    
                    <a class="btn03" id="button3" href="/mbrConditions.do">개인회원 가입</a>
                    <a class="btn04" id="button4" href="/bsnmJoinWrite.do">사업자회원 가입</a><br>
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
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

<title>약관화면</title>
</head>

<style>
  /* Custom CSS for the <section> */
  section {
    padding: 20px;
    text-align: center;
    max-width: 600px; /* Increased the max-width for better readability */
    margin: 0 auto;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #f9f9f9;
  }

  h2 {
    font-size: 1.3em;
    font-weight: bold;
    margin-bottom: 20px;
    text-align: center;
  }

  p {
    color: #e8180c;
    text-align: center;
    margin-bottom: 15px;
  }

  textarea {
    width: 100%;
    min-height: 200px;
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    resize: vertical;
  }

  fieldset {
    padding: 10px 0 0;
    text-align: right;
  }

  label {
    display: block;
    margin-bottom: 10px;
  }

  .checkbox {
    margin-right: 5px;
  }

  .fregister_agree {
    margin-bottom: 20px;
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

  div.text-center {
    text-align: center;
  }
</style>

<script>

$(function(){
	
	$("#agree_all").click(function(){
		
		var len =$("input[name='agree']").length;
		var bool = true;
		
		if ( $("#agree_all").is(":checked") == false ) bool = false;
		for( var i=0; i<len; i++ ) {
			$("input[name='agree']")[i].checked = bool;
		}
				
	});
	
	$("#button1").click(function(){
		var len =$("input[name='agree']").length;
		var bool = true;
		for( var i=0; i<len; i++ ) {
			if($("input[name='agree']")[i].checked == false ) {
				bool = false;
			}
		}
		if( bool == false ) {
			alert("약관에 모두 동의해주세요.");
			return;
		}
		location = "/mbrJoinWrite.do";
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
<div id="container">
    <div style="margin-bottom: 15px; font-size: 1.3em; font-weight: bold;">
        회원가입약관
    </div>
    <form style="margin: 0; padding: 0; border: 0;" name="frm">
        <p style="color: #e8180c; text-align: center;">회원가입약관 및 개인정보처리방침안내의 내용에 동의하셔야 회원가입 하실 수 있습니다.</p>
        
        
            <h2 style="font-size: 1em; margin: 0 0 20px; text-align: center;">회원가입약관</h2>
            <textarea readonly id="chapter_1">
				<%@ include file="../include/condition1.jsp" %>
            </textarea>
            <fieldset  style="padding: 10px 0 0; text-align: right;">
                <label for="agree11">회원가입약관의 내용에 동의합니다.</label>
                <input type="checkbox" name="agree" class="checkbox">
            </fieldset>
        
        
            <h2 style="margin: 0 0 20px; text-align: center; font-size: 1em;">개인정보처리방침안내</h2>
            <textarea readonly id="chapter_2">
            	<%@ include file="../include/condition2.jsp" %>
            </textarea>
            <fieldset class="fregister_agree" style="padding: 10px 0 0; text-align: right;">
                <label for="agree21">개인정보처리방침안내의 내용에 동의합니다.</label>
                <input type="checkbox" name="agree" id="agree21" class="checkbox">
            </fieldset>
            <fieldset class="fregister_agree" style="padding: 10px 0 0; text-align: right;">
                <label for="agree21">모두 동의합니다.</label>
                <input type="checkbox" name="agree_all" id="agree_all" class="checkbox">
            </fieldset>                    
        
        <div style="text-align: center;">
            <input type="submit" class="btn_submit" id="button1" onclick="return false;" value="회원가입" style="cursor: pointer;">
        </div>
    </form>
</div>
</section>
<!--section 끝-->



<!--footer 시작-->
<footer>
<div class="footer1">
	<%@include file="../include/footer.jsp" %>
</div>
</footer>
<!-- footer 끝-->
</div>


  </body>
</html>
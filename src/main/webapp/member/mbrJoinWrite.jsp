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

<title>유저 회원가입</title>
</head>

<style>
  /* Custom CSS for the form */
  #container {
    padding: 20px;
    max-width: 600px;
    margin: 0 auto;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #f9f9f9;
  }

  #wrapper_title {
    font-size: 1.3em;
    font-weight: bold;
    margin-bottom: 20px;
    text-align: center;
  }

  .mbskin {
    margin-bottom: 30px;
  }

  .tbl_frm01 {
    margin-bottom: 30px;
  }

  table {
    width: 100%;
    border-collapse: collapse;
  }

  th,
  td {
    padding: 10px;
    border-bottom: 1px solid #ccc;
  }

  th {
    text-align: left;
    width: 25%;
  }

  input[type="text"],
  input[type="password"],
  input[type="date"]   {
    width: 95%;
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
  }
  input[type="radio"],
  input[type="checkbox"] {
  	 padding: 10px;
  }

  .frm_info {
    color: #666;
  }

  #msg_userid,
  #msg_mb_nick,
  #msg_mb_birth {
    color: #e8180c;
  }

  .btn_confirm {
    text-align: center;
    margin-top: 20px;
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
	
	$("#captcha_reload").click(function(){
		
		var no = $("#prevent_no").val();	//	no값 받아오기
		
		$.ajax({
	         
	         type : "POST",
	         url  : "/preventImg.do",
	         data : "no="+no,

	         datatype : "json",
	         success  : function(data){
	            //	data = "375648,5"
	            var datas = data.split(",");
	            var filename = datas[0];
	            var nn = datas[1];
	            $("#prevent_no").val(nn);
				//	attr 속성값을 바꾸는 함수
				$("#filename").val(filename);
	            $("#captcha_img").attr("src","../images/prevent_img/"+filename+".jpg");
	         },
	         error : function(){ }
	         
	      });
	});
	
   
   $("#userid").keyup(function(){
	  
	   var userid = $("#userid").val();
	   var result = 0;
	   
	   if (userid.length >= 3 && userid.length <= 20 ) {
			result = fn_userid(userid);
	   }
	   
	   $("#id_usable").val("N");
	   if( result == 0 ){
	         msg = "<font color = 'red'>아이디는 6자리~20자리 사이로 입력해주세요</font>";
       } else if (result == 1 ){
             msg = "<font color = 'green'>사용가능한 아이디입니다.</font>";
             $("#id_usable").val("Y");
       } else if(result == 2 ){
             msg = "<font color = 'red'>이미사용중인 아이디입니다.</font>";
       } else if(result == 3 ){
             msg = "<font color = 'red'>형식에 맞지 않는 아이디입니다.</font>";         
       }
      
       $("#msg_userid").html(msg);

   });
   
   $("#btn_submit").click(function(){
	  
	  let captcha_key = $("#captcha_key").val();
	  let filename = $("#filename").val();
	  if( captcha_key != filename ) {
		  alert("자동등록방지 번호를 확인해주세요.");
		  $("#captcha_key").focus();
		  return false;
	  }
      
	  let userid = $.trim($("#userid").val());
      let userpass = $.trim($("#userpass").val());
      let pass2 = $.trim($("#pass2").val());
      let username = $.trim($("#username").val());
      let usernickname = $.trim($("#usernickname").val());
      let userphone = $.trim($("#userphone").val());
      let useremail = $.trim($("#useremail").val());
      let userbirth = $.trim($("#userbirth").val());
      let usergender = $('input[name=usergender]:checked').val();
      let id_usable = $("#id_usable").val();
      
      if( id_usable == "N" ) {
    	  alert("아이디를 확인해주세요.");
    	  $("#userid").focus();
    	  return false;
      }
      
      $("#userid").val(userid);
      $("#userpass").val(userpass);
      $("#username").val(username);
      $("#usernickname").val(usernickname);
      $("#userphone").val(userphone);
      $("#useremail").val(useremail);
      $("#userbirth").val(userbirth);
            
      if ( userid.length < 6 || userid.length > 20 ) {
         alert("아이디는 6~20자 사이로 입력해주세요.");
         $("#userid").focus();
         return false;
      }
      if ( userpass.length < 8 || userpass.length > 20 ) {
         alert("암호는 8~20자 사이로 입력해주세요.");
         $("#userpass").focus();
         return false;
      }
      if( userpass != pass2 ) {
    	  alert("암호가 일치하지 않습니다.");
    	  $("#userpass").focus();
          return false;
      }
      if ( username == "") {
          alert("이름을 입력해주세요.");
          $("#username").focus();
          return false;
      }
      if ( usernickname == "") {
          alert("닉네임을 입력해주세요.");
          $("#usernickname").focus();
          return false;
      }
      if ( userphone == "") {
          alert("핸드폰 번호를 입력해주세요.");
          $("#userphone").focus();
          return false;
      }
      if ( useremail == "") {
          alert("이메일을 입력해주세요.");
          $("#useremail").focus();
          return false;
      }
      if ( userbirth == "") {
          alert("생년월일을 입력해주세요.");
          $("#userbirth").focus();
          return false;
      }
      if ( userbirth > "2008-12-31" ) {
          alert("만 14세 이상만 가입 가능합니다.");
          $("#userbirth").focus();
          return false;
      }
      if ( $("input:radio[name=usergender]").is(":checked") == false) {
          alert("성별을 선택해주세요.");
          $("#usergender").focus();
          return false;
      }
      
      var form = $("#frm").serialize();
      $.ajax({
         
         type : "POST",
         url  : "/mbrJoinSave.do",
         data : form,

         datatype : "json",
         success  : function(data){
            if(data == "1") {
               alert("회원가입이 완료되었습니다.");
               location="/loginWrite.do";
            } else if(data == "2") {
            	alert("이미 사용중인 아이디입니다.");
            } else if(data == "4") {
            	alert("이미 사용중인 닉네임입니다.");
            } else {
               alert("저장실패!");
            }
         },
         error : function(){
            alert("전송실패");
         }
         
      });
      
   });
});

function fn_userid(userid) {
	
	var result = "";
	
	$.ajax({
        
        type : "POST",
        url  : "/mbrUserIdCheck.do",
        async: false,
        data : "userid="+userid,

        datatype : "text",
        success  : function(data){
        	result = data;
        },
        error : function(){
        	result = "2";
        }       
     });
	return result;
}

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
    <div id="wrapper">
        
    <div id="container">
        <div id="wrapper_title">회원 가입</div>

        <div class="mbskin">

    
            <form id="frm" name="frm"> 
            
            <input type="hidden" id="prevent_no" value="${no }">
            <input type="hidden" id="filename" value="${filename }">
            <input type="hidden" id="id_usable" value="N">
            
            <div class="tbl_frm01 tbl_wrap">
                <table>
                <caption>사이트 이용정보 입력</caption>
                <tbody>
                <tr>
                    <th scope="row"><label for="userid">아이디<strong class="sound_only"></strong></label></th>
                    <td>
                        
                        <input type="text" name="userid" value="" id="userid" required="" class="frm_input required " minlength="6" maxlength="20">
                        <span class="frm_info">영문자, 숫자, _ 만 입력 가능. 최소 6자이상 입력하세요.</span><br>
                        <span id="msg_userid"></span>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="userpass">비밀번호<strong class="sound_only"></strong></label></th>
                    <td><input type="password" name="userpass" id="userpass" required="" class="frm_input required" minlength="8" maxlength="20"></td>
                </tr>
                <tr>
                    <th scope="row"><label for="pass2">비밀번호 확인<strong class="sound_only"></strong></label></th>
                    <td><input type="password" name="pass2" id="pass2" required="" class="frm_input required" minlength="8" maxlength="20"></td>
                </tr>
                </tbody>
                </table>
            </div>

            <div class="tbl_frm01 tbl_wrap">
                <table>
                <caption>개인정보 입력</caption>
                <tbody>
                    <tr>
                        <th scope="row"><label for="username">이름<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="text" id="username" name="username" value="" required="" class="frm_input required " size="10">
                        </td>
                    </tr>
                    
                    <tr>
                        <th scope="row"><label for="usernickname">닉네임<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="text" name="usernickname" value="" id="usernickname" required="" class="frm_input required nospace" size="10" maxlength="20">
                            <span id="msg_mb_nick"></span>
                        </td>
                    </tr>
                    
                    <tr>
                        <th scope="row"><label for="userphone">휴대폰번호<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="text" name="userphone" value="" id="userphone" required="" class="frm_input required" maxlength="13" oninput="this.value = this.value.replace(/[^-0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                        </td>
                    </tr>
                    
                    <tr>
                        <th scope="row"><label for="useremail">E-mail<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="text" name="useremail" value="" id="useremail" required="" class="frm_input email required" size="70" maxlength="100">
                        </td>
                    </tr>
                                        
                    <tr>
                        <th scope="row"><label for="userbirth">생년월일<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="date" name="userbirth" value="" id="userbirth" required="" class="frm_input required nospace" size="10" maxlength="20">
                            <span id="msg_mb_birth"></span>
                        </td>
                    </tr>
                    
                    <tr>
                        <th scope="row"><label for="usergender">성별<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="radio" name="usergender" id="usergender" value="M">남자
							<input type="radio" name="usergender" id="usergender" value="F">여자
                        </td>
                    </tr>
                    
                </tbody>
            </table>
        </div>

        <div class="tbl_frm01 tbl_wrap">
            <table>
            <caption>기타 개인설정</caption>
            <tbody>
            
            
            
            <tr>
                <th scope="row"><label for="useropeninfo">정보공개</label></th>
                <td>
                    <input type="checkbox" name="useropeninfo" value="Y" id="useropeninfo" checked>
                    정보를 오픈하겠습니다.
                </td>
            </tr>            
            
            <tr>
                <th scope="row">자동등록방지</th>
                    <td>
                        <fieldset id="captcha" class="captcha">
                        <legend><label for="captcha_key">자동등록방지</label></legend>
                        <div id="abc"><img src="../images/prevent_img/${filename}.jpg" alt="" id="captcha_img"></div>
                        <button type="button" id="captcha_reload"><span></span>새로고침</button><input type="text" name="captcha_key" id="captcha_key" required="" class="captcha_box required" size="6" maxlength="6">
                        <span id="captcha_info">자동등록방지 숫자를 순서대로 입력하세요.</span>
                        </fieldset>
                    </td>
            </tr>
                    </tbody>
                    </table>
        </div>

        <div class="btn_confirm">
            <input type="submit" value="회원가입" id="btn_submit" onclick="return false;" class="btn_submit" accesskey="s">
            <a href="" class="btn_cancel">취소</a>
        </div>
        </form>

        </div>

    </div>
</div>
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
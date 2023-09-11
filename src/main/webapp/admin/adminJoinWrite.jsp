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
<c:set var="s_adminid" value="${sessionScope.SessionAdminID }"/>
<title>로그인 화면</title>
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

  #msg_adminid,
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

   $("#adminid").keyup(function(){
	  
	   var adminid = $("#adminid").val();
	   var result = 0;
	   
	   if (adminid.length >= 3 && adminid.length <= 20 ) {
			result = fn_adminid(adminid);
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
      
       $("#msg_adminid").html(msg);

   });
   
   $("#btn_submit").click(function(){
      
	  let adminid = $.trim($("#adminid").val());
      let adminpass = $.trim($("#adminpass").val());
      let pass2 = $.trim($("#pass2").val());
      let adminname = $.trim($("#adminname").val());
      let adminphone = $.trim($("#adminphone").val());
      let id_usable = $("#id_usable").val();
      
      if( id_usable == "N" ) {
    	  alert("아이디를 확인해주세요.");
    	  $("#adminid").focus();
    	  return false;
      }
      
      $("#adminid").val(adminid);
      $("#adminpass").val(adminpass);
      $("#adminname").val(adminname);
      $("#adminphone").val(adminphone);
            
      if ( adminid.length < 6 || adminid.length > 20 ) {
         alert("아이디는 6~20자 사이로 입력해주세요.");
         $("#adminid").focus();
         return false;
      }
      if ( adminpass.length < 8 || adminpass.length > 20 ) {
         alert("암호는 8~20자 사이로 입력해주세요.");
         $("#adminpass").focus();
         return false;
      }
      if( adminpass != pass2 ) {
    	  alert("암호가 일치하지 않습니다.");
    	  $("#adminpass").focus();
          return false;
      }
      if ( adminname == "") {
          alert("이름을 입력해주세요.");
          $("#adminname").focus();
          return false;
      }
      if ( adminphone == "") {
          alert("핸드폰 번호를 입력해주세요.");
          $("#adminphone").focus();
          return false;
      }
      
      var form = $("#frm").serialize();
      $.ajax({
         
         type : "POST",
         url  : "/adminJoinSave.do",
         data : form,

         datatype : "json",
         success  : function(data){
            if(data == "1") {
               alert("저장완료");
               location="/adminLoginWrite.do";
            } else if(data == "2") {
            	alert("이미 사용중인 아이디입니다.");
            } else if(data == "3") {
            	alert("최고관리자가 아닙니다.");
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

function fn_adminid(adminid) {
	
	var result = "";
	
	$.ajax({
        
        type : "POST",
        url  : "/adminIdCheck.do",
        async: false,
        data : "adminid="+adminid,

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
	<%@include file="../include/adminHeader.jsp" %>
</header>
<!--header 끝-->

<!--section 시작-->
<section>
    <div id="wrapper">
        
    <div id="container">
        <div id="wrapper_title">관리자회원 가입</div>

        <div class="mbskin">
    
            <form id="frm" name="frm"> 
            
            <input type="hidden" id="id_usable" value="N">
            
            <div class="tbl_frm01 tbl_wrap">
                <table>
                <caption>관리자 이용정보 입력</caption>
                <tbody>
                <tr>
                    <th scope="row"><label for="adminid">아이디<strong class="sound_only"></strong></label></th>
                    <td>
                        
                        <input type="text" name="adminid" value="" id="adminid" required="" class="frm_input required " minlength="6" maxlength="20">
                        <span class="frm_info">영문자, 숫자, _ 만 입력 가능. 최소 6자이상 입력하세요.</span><br>
                        <span id="msg_adminid"></span>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="adminpass">비밀번호<strong class="sound_only"></strong></label></th>
                    <td><input type="password" name="adminpass" id="adminpass" required="" class="frm_input required" minlength="8" maxlength="20"></td>
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
                        <th scope="row"><label for="adminname">이름<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="text" id="adminname" name="adminname" value="" required="" class="frm_input required " size="10">
                        </td>
                    </tr>
                    
                    <tr>
                        <th scope="row"><label for="adminphone">휴대폰번호<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="text" name="adminphone" value="" id="adminphone" required="" class="frm_input required" maxlength="11" oninput="this.value = this.value.replace(/[^-0-9.]/g, '').replace(/(\..*)\./g, '$1');">
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
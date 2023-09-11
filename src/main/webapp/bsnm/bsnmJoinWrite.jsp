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

<title>사업자 회원가입 화면</title>
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

  #msg_bsnmid,{
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
	//사업자 등록 상태 조회
	$( "#bsnmno" ).keyup (function () {
	  // var charLimit = $(this).attr("maxlength");

	   var bsnmno = $("#bsnmno").val();
	   if (this.value.length == "10") {

	          check = {}

	           new Promise( (succ, fail)=>{
	               var data = {  "b_no": [""+ bsnmno +""] }; // String b_no = "[1234123456]";

	               $.ajax({
		               url: "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=NGC3J%2F3kwKWZZORfbmneNB50s19CnM7Z3ggMyc55TMoPMLUH1G1Sd8sxXF2IkeElWi4BOMTCiIzjGK8dd6Crdw%3D%3D",  // serviceKey 값을 xxxxxx에 입력
		               type: "POST",
		               data: JSON.stringify(data), 
		               
		               dataType: "JSON",
		               contentType: "application/json",
		               accept: "application/json",
		               success: function(result) {
	
		                   check_code = result.data[0].b_stt_cd;
		                   //check_b_no = result.data[0].b_no;
		                   succ(result);
	
		               },
		               fail: function(result) {
		                   fail(error);                                    
		               }
		           });


	           }).then((arg) =>{   

	               $.ajax({
	                   url: "/bsnmnoCheck.do",
	                   type: "post",
	                   data: { "bsnmno": bsnmno },
	                   
	                   dataType: "text",
	                   success: function(result) {

	                       $("#bs_result").css("display","block");

	                       if (result == "1") {
                               // 기존 등록한 사업자번호와 동일한 경우
                               $("#bs_result").html("<font color='red'>기존에 등록하신 사업자번호와 동일합니다.</font>");
                           } else {
                               // 사업자번호 등록 여부에 따른 처리
                               if (check_code == "01") {
                                   $("#bs_result").html("<font color='green'>정상적인 사업자번호입니다.</font>");
                               } else if (check_code == "02" || check_code == "03") {
                                   $("#bs_result").html("<font color='red'>휴/폐업한 사업자번호입니다.</font>");
                               } else {
                                   $("#bs_result").html("<font color='red'>등록되지 않은 사업자번호입니다.</font>");
                               }
                           }
                       }
               
	               });

	           }); //then end

	   }

	});
	
	
	
	
	
	$("#captcha_reload").click(function(){
		
		var no = $("#prevent_no").val();	//	no값 받아오기
		
		$.ajax({
	         
	         type : "POST",
	         url  : "/bsnmpreventImg.do",
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
	
   
   $("#bsnmid").keyup(function(){
	  
	   var bsnmid = $("#bsnmid").val();
	   var result = 0;
	   
	   if (bsnmid.length >= 3 && bsnmid.length <= 20 ) {
			result = fn_bsnmid(bsnmid);
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
      
       $("#msg_bsnmid").html(msg);

   });
   
   $("#btn_submit").click(function(){
	  
	  let captcha_key = $("#captcha_key").val();
	  let filename = $("#filename").val();
	  if( captcha_key != filename ) {
		  alert("자동등록방지 번호를 확인해주세요.");
		  $("#captcha_key").focus();
		  return false;
	  }
      
	  let bsnmid = $.trim($("#bsnmid").val());
      let bsnmpass = $.trim($("#bsnmpass").val());
      let pass2 = $.trim($("#pass2").val());
      let bsnmname = $.trim($("#bsnmname").val());
      let bsnmphone = $.trim($("#bsnmphone").val());
      let bsnmmail = $.trim($("#bsnmmail").val());
      let bsnmno = $.trim($("#bsnmno").val());
      let bsnmcompany = $.trim($("#bsnmcompany").val());
      let id_usable = $("#id_usable").val();
      
      if( id_usable == "N" ) {
    	  alert("아이디를 확인해주세요.");
    	  $("#bsnmid").focus();
    	  return false;
      }
      
      $("#bsnmid").val(bsnmid);
      $("#bsnmpass").val(bsnmpass);
      $("#bsnmname").val(bsnmname);
      $("#bsnmphone").val(bsnmphone);
      $("#bsnmmail").val(bsnmmail);
      $("#bsnmno").val(bsnmno);
      $("#bsnmcompany").val(bsnmcompany);
            
      if ( bsnmid.length < 6 || bsnmid.length > 20 ) {
         alert("아이디는 6~20자 사이로 입력해주세요.");
         $("#bsnmid").focus();
         return false;
      }
      if ( bsnmpass.length < 8 || bsnmpass.length > 20 ) {
         alert("암호는 8~20자 사이로 입력해주세요.");
         $("#bsnmpass").focus();
         return false;
      }
      if( bsnmpass != pass2 ) {
    	  alert("암호가 일치하지 않습니다.");
    	  $("#bsnmpass").focus();
          return false;
      }
      if ( bsnmname == "") {
          alert("이름을 입력해주세요.");
          $("#bsnmname").focus();
          return false;
      }

      if (bsnmphone == "") {
          alert("핸드폰 번호를 입력해주세요.");
          $("#bsnmphone").focus();
          return false;
      }
      if (bsnmmail == "") {
          alert("이메일을 입력해주세요.");
          $("#bsnmmail").focus();
          return false;
      }
      if (bsnmno == "") {
          alert("사업자등록번호를 입력해주세요.");
          $("#bsnmno").focus();
          return false;
      }
      if ( bsnmno.length != 10 ) {
          alert("사업자등록번호는 10자리 숫자여야합니다.");
          $("#bsnmno").focus();
          return false;
       }

  var form = $("#frm").serialize();
      $.ajax({
         
         type : "POST",
         url  : "/bsnmJoinSave.do",
         data : form,

         datatype : "json",
         success  : function(data){
            if(data == "1") {
               alert("회원가입이 완료되었습니다.");
               location="/bsnmLoginWrite.do";
            } else if(data == "2") {
            	alert("이미 사용중인 아이디입니다.");
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

function fn_bsnmid(bsnmid) {
	
	var result = "";
	
	$.ajax({
        
        type : "POST",
        url  : "/bsnmIdCheck.do",
        async: false,
        data : "bsnmid="+bsnmid,

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

function limitInputLength(inputElement, maxLength) {
    if (inputElement.value.length > maxLength) {
        inputElement.value = inputElement.value.slice(0, maxLength);
    }
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
        <div id="wrapper_title">사업자 회원 가입</div>

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
                    <th scope="row"><label for="bsnmid">사업자아이디<strong class="sound_only"></strong></label></th>
                    <td>
                        
                        <input type="text" name="bsnmid" value="" id="bsnmid" required="" class="frm_input required " minlength="6" maxlength="20">
                        <span class="frm_info">영문자, 숫자, _ 만 입력 가능. 최소 3자이상 입력하세요.</span>
                        <span id="msg_bsnmid"></span>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="bsnmpass">사업자비밀번호<strong class="sound_only"></strong></label></th>
                    <td><input type="password" name="bsnmpass" id="bsnmpass" required="" class="frm_input required" minlength="8" maxlength="20"></td>
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
                        <th scope="row"><label for="bsnmname">사업자 이름<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="text" id="bsnmname" name="bsnmname" value="" required="" class="frm_input required " size="10">
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="bsnmcompany">사업자 상호<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="text" id="bsnmcompany" name="bsnmcompany" value="" required="" class="frm_input required " size="10">
                        </td>
                    </tr>
                    
                    <tr>
                        <th scope="row"><label for="bsnmphone">사업자 휴대폰번호<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="text" name="bsnmphone" value="" id="bsnmphone" required="" class="frm_input required" maxlength="13" oninput="this.value = this.value.replace(/[^-0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                        </td>
                    </tr>
                    
                    <tr>
                        <th scope="row"><label for="bsnmmail">사업자 E-mail<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="text" name="bsnmmail" value="" id="bsnmmail" required="" class="frm_input email required" size="70" maxlength="100">
                        </td>
                    </tr>
                    
                    <tr>
                        <th scope="row"><label for="bsnmrdate">사업자등록일<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="date" name="bsnmrdate" id="bsnmrdate" >
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="bsnmno">사업자등록번호<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="number" name="bsnmno" id="bsnmno" oninput="limitInputLength(this, 10)">
                            <span id="bs_result"></span>
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
                <th scope="row"><label for="bsnmopeninfo">정보공개</label></th>
                <td>
                    <input type="checkbox" name="bsnmopeninfo" value="Y" id="bsnmopeninfo" checked>
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
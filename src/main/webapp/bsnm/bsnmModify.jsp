<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<c:set var="s_bsnmid" value="${sessionScope.SessionBsnmID }"/>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/main.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<title>사업자 정보 수정화면</title>
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
	
function fn_popup(){
	let url = "/bsnmPassChange.do";
	window.open(url,"암호변경팝업","width=400,height=300");
}

$(function(){   
   
   $("#btn_submit").click(function(){
      
      let bsnmpass = $.trim($("#bsnmpass").val());
      let bsnmphone = $.trim($("#bsnmphone").val());
      let bsnmmail = $.trim($("#bsnmmail").val());
            
      $("#bsnmpass").val(bsnmpass);
      $("#bsnmphone").val(bsnmphone);
      $("#bsnmmail").val(bsnmmail);


      if ( bsnmmail == "") {
          alert("이메일을 입력해주세요.");
          $("#bsnmmail").focus();
          return false;
      }
      var form = $("#frm").serialize();
      $.ajax({
         
         type : "POST",
         url  : "/bsnmModifySave.do",
         data : form,

         datatype : "text",
         success  : function(data){
            if(data == "1") {
               alert("사업자 정보가 변경되었습니다.");
               location="/";
            } else if(data == "2") {
            	alert("비밀번호를 확인해주세요!");
            	$("#bsnmpass").focus();
            }  else if(data == "4") {
            	alert("다시 로그인 해주세요.");
            	location = "/bsnmLoginWrite.do";
            } else {
               alert("비밀번호를 확인해주세요!");
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
    <div id="wrapper">
        
    <div id="container">
        <div id="wrapper_title">사업자 정보수정</div>

        <div class="mbskin">

    
            <form id="frm" name="frm"> 
            
<%--             <input type="hidden" id="prevent_no" value="${no }">
            <input type="hidden" id="filename" value="${filename }"> --%>
            <input type="hidden" id="id_usable" value="N">
            
            <div class="tbl_frm01 tbl_wrap">
                <table>
                <caption>사이트 이용정보 입력</caption>
                <tbody>
                <tr>
                    <th scope="row"><label for="bsnmid">사업자아이디<strong class="sound_only"></strong></label></th>
                    <td>
                        
                        <input type="text" name="bsnmid" value="${vo.bsnmid }" id="bsnmid" required="" class="frm_input required " minlength="6" maxlength="20" readonly>
                        <span class="frm_info">영문자, 숫자, _ 만 입력 가능. 최소 3자이상 입력하세요.</span>
                        <span id="msg_bsnmid"></span>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="bsnmpass">사업자비밀번호<strong class="sound_only"></strong></label></th>
                    <td>
                    	<input type="hidden" name="bsnmpass" id="bsnmpass"  value="${vo.bsnmpass }" required="" class="frm_input required" readonly="readonly">
                		<button type="button" class="btn_change_password" onclick="fn_popup()">암호변경</button></td>
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
                            <input type="text" id="bsnmname" name="bsnmname" value="${vo.bsnmname }" required="" class="frm_input required " size="10" readonly>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="bsnmcompany">사업자 상호<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="text" id="bsnmcompany" name="bsnmcompany" value="${vo.bsnmcompany}" required="" class="frm_input required " size="10">
                        </td>
                    </tr>
                    
                    <tr>
                        <th scope="row"><label for="bsnmphone">사업자 휴대폰번호<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="text" name="bsnmphone" value="${vo.bsnmphone }" id="bsnmphone" required="" class="frm_input required" maxlength="13" oninput="this.value = this.value.replace(/[^-0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                        </td>
                    </tr>
                    
                    <tr>
                        <th scope="row"><label for="bsnmmail">사업자 E-mail<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="text" name="bsnmmail" value="${vo.bsnmmail }" id="bsnmmail" required="" class="frm_input email required" size="70" maxlength="100">
                        </td>
                    </tr>
                    
                    <tr>
                        <th scope="row"><label for="bsnmrdate">사업자등록일<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="date" name="bsnmrdate" id="bsnmrdate" value="${vo.bsnmrdate }" >
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="bsnmno">사업자등록번호<strong class="sound_only"></strong></label></th>
                        <td>
                            <input type="number" name="bsnmno" id="bsnmno" value="${vo.bsnmno }">
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
                    <input type="checkbox" name="bsnmopeninfo" value="Y" id="bsnmopeninfo"
                    <c:if test="${vo.bsnmopeninfo=='Y' }">checked</c:if> >
                    정보를 공개하겠습니다.
                </td>
            </tr>
                    </tbody>
                    </table>
        </div>

        <div class="btn_confirm">
            <input type="submit" value="정보수정" id="btn_submit" onclick="return false;" class="btn_submit" accesskey="s">
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
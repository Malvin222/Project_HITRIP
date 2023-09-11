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
<link rel="stylesheet" href="../css/mainSection.css"> <!-- 외부 스타일시트 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<title>이용약관</title>
</head>
<style>
h4 {
  font-weight: bold;
  color: blue;
}
</style>
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
<div class="" style="width:100%;word-break:break-all;line-height:150%;padding:10px 0 40px 0;text-align:left;box-sizing:border-box;">
	<div style="padding:0 10px 0 20px;">
		<pre style="white-space: pre-wrap;">
[개인정보처리방침]

<h4>1. 개요</h4>
"하이트립"(이하 "회사"라 합니다) 서비스는 회원의 개인정보 보호를 중요시합니다.
개인정보를 수집하는 경우 사전에 회원에게 해당 사실을 알리고 동의를 구하며, 개인정보보호법 등 개인정보 보호 법령을 철저히 준수합니다.

<h4>2. 수집하는 개인정보</h4>
회사는 회원 가입 시에 "아이디, 닉네임, 비밀번호, 이름, 생년월일, 성별, 이메일주소" 를 필수항목으로 수집합니다.
회원 가입 시에 네이버 로그인 API를 사용하는 경우 이용자 식별자(네이버 아이디마다 고유하게 발급되는 일련번호 값) 및 이메일 주소를 함께 수집합니다.
서비스 이용 과정에서 핸드폰 인증이 필요할 수 있으며 그 경우 "인증 핸드폰번호" 를 수집할 수 있습니다.

<h4>3. 개인정보의 제공</h4>
회사는 회원의 별도 동의가 있는 경우나 법령에 규정된 경우를 제외하고는 회원의 개인정보를 제 3자에게 제공하지 않습니다.

<h4>4. 개인정보의 보관기간</h4>
회사는 회원이 서비스를 이용하고 있는 동안 개인정보를 지속적으로 보관합니다.

<h4>5. 개인정보의 파기</h4>
회사는 회원의 회원탈퇴 절차가 완료되면 원칙적으로 회원의 개인정보를 지체없이 파기하고 있으며, 핸드폰 인증 등 본인확인에 관한 기록은 정보통신망이용촉진 및 정보보호 등에 관한 법률과 전자문서 및 전자거래 기본법 등에 의하여 3개월간 보존됩니다.

그리고 아래와 같이 회원 가입시 혹은 서비스 이용시 동의를 얻은 경우, 법령에서 일정 기간 정보보관 의무를 부과하는 경우, 이벤트 당첨시 필요한 경우 해당 기간 동안 다음의 정보를 보관할 수 있습니다.

* 부정 활동에 대한 기록 (제재, 활동정지 등)
- 보전 목적 : 부정 가입 및 부정 이용 방지
- 보존 항목 : 아이디, 닉네임, 메일주소, 인증 핸드폰 번호
- 보존 기간 : 3년

* 웹사이트 방문기록
- 보존 근거 : 통신비밀보호법
- 보존 기간 : 3개월

* 이벤트 당첨시 증빙서류 
- 보전 목적 : 5만원 초과 이벤트 당첨시 본인 확인, 세금 신고, 입금이 필요한 경우 계좌 확인
- 보존 항목 : 신분증 사본, 닉네임, (입금이 필요한 경우) 통장사본 
- 보존 기간 : 3개월

<h4>6. 개인정보의 파기방법</h4>
회사는 개인정보 파기시 기록을 재생할 수 없는 기술적 방법을 사용하여 완전히 삭제합니다.

<h4>7. 개인정보의 취급위탁</h4>
회사는 다음과 같이 개인정보의 취급을 위탁하고 있습니다.
- 수탁업체명: 가비아
- 위탁 업무 내용: 핸드폰 인증시 본인확인 SMS 발송, 회사가 제공하는 안내 SMS 발송

<h4>8. 기타</h4>
회사는 서비스의 원활하고 안정적인 운영 및 서비스 품질의 개선을 위하여 이용자의 접속 정보(IP주소, 쿠키, 운영체제, 브라우저 버전 등)를 수집 ‧ 활용할 수 있습니다.

<h4>9. 개인정보 보호책임자 및 담당부서</h4>
- 보호책임자 및 담당부서 : 개인정보 보호팀

		</pre>
	</div>
</div>
</section>
<!--section 끝-->

<!--footer 시작-->
<footer>
    <%@include file="../include/footer.jsp" %>
</footer>
<!--footer 끝-->
</div>
</body>
</html>
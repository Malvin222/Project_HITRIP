<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일별 일정 조회</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
</head>

<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
  }
  .popup-container {
    background-color: #fff;
    max-width: 600px;
    margin: 0 auto;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }
  .popup-title {
    font-size: 24px;
    margin-bottom: 15px;
  }
  .popup-list {
    list-style-type: none;
    padding: 0;
  }
  .popup-list-item {
    margin-bottom: 10px;
  }
  .popup-link {
    color: #007bff;
    text-decoration: none;
    transition: color 0.2s;
  }
  .popup-link:hover {
    color: #0056b3;
  }
  
  .close-button {
    background-color: #ccc;
    color: #000;
    border: none;
    border-radius: 5px;
    padding: 5px 15px;
    cursor: pointer;
    font-weight: bold;
    transition: background-color 0.2s;
    margin: 0 auto;
    display: block;
  }
  .close-button:hover {
    background-color: #999;
  }
</style>

<script>
   function closePopupAndRedirect(url) {
     window.close();
     window.opener.location.href = url;
   }
   
   function closePopup() {
        window.close();
   }
</script>

<body>
<div class="popup-container">
  <h1 class="popup-title">Plan Day List</h1>
  <div id="titleList">
    <ul class="popup-list">
      <c:forEach var="title" items="${fn:split(param.titles, ',')}" varStatus="status">
        <c:set var="cleanedTitle" value="${fn:replace(fn:replace(fn:replace(fn:replace(title, '[', ''), ']', ''), 'quot;', ''),'&amp;', '')}" />
        <c:set var="planunqs" value="${fn:split(param.planunqs, ',')}" />
        <c:if test="${not empty cleanedTitle}">
          <c:set var="cleanedPlanunq" value="${fn:replace(fn:replace(planunqs[status.index], '[', ''), ']', '')}" />
          <li class="popup-list-item">
            <a class="popup-link" href="#" onclick="closePopupAndRedirect('/planDetail.do?planunq=${fn:trim(cleanedPlanunq)}')">
              ${cleanedTitle}
            </a>
          </li>
        </c:if>
      </c:forEach>
    </ul>
  </div>
</div>
<button type="button" class="close-button" onclick="closePopup()">닫기</button>

</body>
</html>
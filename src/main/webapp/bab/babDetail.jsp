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
<style>
  img {
      width: 500px;
      height: 400px;
  }
  table {
       font-size: 12px;
      border-collapse: collapse;
      margin-top:10px;
  }

  th, td {
      padding: 8px;
  }
   .table1 {
   border: 1px solid #f7f7f7;
     border-top: none;
     border-bottom: none;     
     font-weight: bold;
     font-size: 14px;
  }
  .table1 th,td {
     border: 1px solid #f7f7f7;
     border-top: none;
     border-bottom: none;
  }
  .table2 th,td {
     border: 1px solid #cccccc;
     border-right: none;
    border-left: none;
  }
  .table2 table {
     border-right: none;
    border-left: none;
  }
<%@include file="../css/cityNav.css" %>
</style>


<title>식당리스트</title>
</head>

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
<nav>
   <%@include file = "../include/cityNav.jsp" %>
</nav>
<!--nav 끝-->



<!--section 시작-->
<section>

<form name="frm" id="frm" method="post">
 <input type="hidden" name="contentid" value="${vo.contentid }">

 <table class="table1" width="1000" align="center">
    <tr>
       <td colspan="2">🍚${vo.title }</td>
    </tr>
    <tr>
       <th>
          <c:if test="${vo.firstimage != null }">
           <img src="${vo.firstimage}">
           </c:if>
           <c:if test="${vo.firstimage == null }">
           <img src="../images/hitrip.png">
           </c:if>
      </th>
       <th>
   <div id="map" style="width:500px;height:400px;"></div>
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3ca739bc306250237e298c204ba7b553"></script>
   <script>
      var container = document.getElementById('map');
      var options = {
         center: new kakao.maps.LatLng(${vo.mapy}, ${vo.mapx}),
         level: 2
      };

      var map = new kakao.maps.Map(container, options);

      // 마커가 표시될 위치입니다 
      var markerPosition  = new kakao.maps.LatLng(${vo.mapy}, ${vo.mapx}); 

      // 마커를 생성합니다
      var marker = new kakao.maps.Marker({
          position: markerPosition
      });

      // 마커가 지도 위에 표시되도록 설정합니다
      marker.setMap(map);

      // 아래 코드는 지도 위의 마커를 제거하는 코드입니다
      // marker.setMap(null);    
   </script>
         </th>
   </tr>
    </table>
    <table class="table2" width="1000" align="center">
    <tr>
       <th>이름</th>
       <td>${vo.title }</td>
    </tr>
    <tr>
       <th>주소</th>
       <td>${vo.addr }</td>
    </tr>
    <tr>
       <th>문의 및 안내</th>
       <td>${vo.tel}<c:if test="${vo.tel == null}">등록된 전화번호가 없습니다.</c:if></td>
    </tr>
 </table>
 
 <div style="margin-top:10px; margin-bottom:10px; text-align:center;" >
    <button type="button" onclick="history.back();">이전</button>
    <button type="button" onclick="location='/babList.do'">목록</button>

 </div>
 </form>

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
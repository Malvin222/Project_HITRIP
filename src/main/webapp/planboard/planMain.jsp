<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="../css/main.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<title>일정관리</title>
</head>

<style>
/* section-wrapper 스타일 */
.section-wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
}
h2 {
  /* Existing styles... */
  font-size: 5vw; /* Adjust as needed */
}

#monthYearDisplay {
  /* Existing styles... */
  font-size: 4vw; /* Adjust as needed */
}

nav {
  max-height: 60px; /* Adjust the value as needed */
}

/* section 스타일 */
section {
  max-height: calc(90vh - 120px); /* Adjust the value as needed */
  overflow-y: auto;
  position: relative; /* Add relative positioning to the section */
}

footer {
  max-height: 40px; /* Adjust the value as needed */
}
/* calendar-container 스타일 */
#calendar-container {
  background-color: white;
  border: 1px solid #ccc;
  border-radius: 5px;
  padding: 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
table#calendar {
  border-collapse: collapse;
  width: 1100px; /* Set the width to 1200px */
  margin: auto;
}

/* Button container styles */
.button-container {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
  padding: 10px; /* 버튼 컨테이너의 내부 여백 추가 */
  background-color: #f0f0f0; /* 배경색 추가 */
  border-radius: 5px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.button-container button {
  padding: 8px 16px;
  font-size: 16px;
  border: none;
  background-color: #007bff;
  color: white;
  cursor: pointer;
  border-radius: 5px;
  transition: background-color 0.3s ease;
}

.button-container button:hover {
  background-color: #0056b3;
}

/* Calendar table styles */
h2 {
  margin: 0 0 15px;
  font-size: 24px;
  color: #333;
}

#monthYearDisplay {
  font-size: 24px;
  color: #555;
}

table {
  border-collapse: collapse;
  width: 800px;
  margin: auto;
}

th, td {
  border: 1px solid black;
  padding: 10px;
  text-align: center;
}

th {
  background-color: #f2f2f2;
}

td.weekend {
  color: blue;
}

td.weekend:first-child {
  color: red;
}

td.today {
  background-color: #4CAF50;
  color: white;
}

td.other-month {
  color: #ccc;
}
@media screen and (max-width: 768px) {
  table#calendar {
    width: 100%; /* Adjust the width as needed for smaller screens */
  }
}
</style>

<script>
$(function(){
  $("#addPlan").click(function(){
    var url = "/planWrite.do";
    window.open(url,"popup","width=600,height=450");
  });
});

function openMoreLink(planyear, planmonth, planday, planList) {
    return function(event) {
        event.preventDefault();
        const titlesForDate = [];
        const planunqList = [];

        for (const item of planList) {
            if (
                planyear === item.planyear &&
                planmonth === item.planmonth - 1 &&
                planday >= item.planday &&
                planday <= item.planeday
            ) {
                titlesForDate.push(item.plantitle);
                planunqList.push(item.planunq);
            }
            if( item.planday > item.planeday ) {
               if (
                 planyear === item.planyear &&
                 planmonth === item.planmonth - 1 &&
                 planday >= item.planday 
               )  {
                   titlesForDate.push(item.plantitle);
                   planunqList.push(item.planunq);
               }
           }
           if( planyear === item.planyear &&
                  planmonth !== item.planmonth - 1 && // Start month is different from current month
                  planmonth === item.planemonth - 1 && // End month matches current month
                  planday <= item.planeday
               )  {
                   titlesForDate.push(item.plantitle);
                   planunqList.push(item.planunq);
               }
            

        }

        const titlesJson = JSON.stringify(titlesForDate);
        const planunqJson = JSON.stringify(planunqList);
        const url = "/planDayList.do?titles=" + encodeURIComponent(titlesJson) + "&planunqs=" + encodeURIComponent(planunqJson);

        // Get the click coordinates relative to the document
        const clickX = event.clientX;
        const clickY = event.clientY;

        // Open the popup window at the clicked coordinates
        const popupWidth = 400;
        const popupHeight = 300;
        const xOffset = clickX - popupWidth / 2;
        const yOffset = clickY - popupHeight / 2;
        const popupOptions = "width=" + popupWidth + ",height=" + popupHeight + ",left=" + xOffset + ",top=" + yOffset;
        window.open(url, "popupWindow", popupOptions);
    };
}
</script>

<script>
document.addEventListener("DOMContentLoaded", function() {
   
     
     const calendarBody = document.querySelector("#calendar tbody");
     const beforeMonthBtn = document.querySelector("#beforeMonth");
     const nextMonthBtn = document.querySelector("#nextMonth");
     const monthYearDisplay = document.querySelector("#monthYearDisplay");

     
     const currentDate = new Date();
     const currentYear = currentDate.getFullYear();
     const currentMonth = currentDate.getMonth() + 1; // JavaScript의 월은 0부터 시작하므로 1을 더해줍니다.
     
     // resultList 변수를 JavaScript 배열로 초기화
     const planList = [
       <c:forEach var="list" items="${planList}" varStatus="status">
         { planunq    : ${list.planunq},
          planyear    : ${list.planyear},
          planmonth    : ${list.planmonth},
          planday    : ${list.planday},
          planeyear    : ${list.planeyear},
          planemonth    : ${list.planemonth},
          planeday    : ${list.planeday},
          plantitle    : "${list.plantitle}",
          plancontent : "${list.plancontent}",
          planopen    : "${list.planopen}",
          userid      : "${list.userid}"
           
         },
       </c:forEach>
     ];
     
     function generateCalendar(planyear, planmonth) {
          const firstDay = new Date(planyear, planmonth, 1);
          const lastDay = new Date(planyear, planmonth + 1, 0);
          const today = new Date();

          calendarBody.innerHTML = "";

          let planday = 1;
          const startDate = new Date(planyear, planmonth, 1); // 시작날짜
          const endDate = new Date(planyear, planmonth + 1, 0); // 종료날짜
          
          let endDT = endDate.getDate();
          
         // alert(startDate + "," + endDate);

          for (let i = 0; i < 6; i++) {
            const row = document.createElement("tr");
            for (let j = 0; j < 7; j++) {
              const cell = document.createElement("td");

              if ((i === 0 && j < startDate.getDay()) || planday > endDate.getDate()) {
                cell.textContent = "";
                cell.classList.add("other-month");
              } else {
                cell.textContent = planday;
                if (
                  today.getFullYear() === planyear &&
                  today.getMonth() === planmonth &&
                  today.getDate() === planday
                ) {
                  cell.classList.add("today");
                }
                if (j === 0 || j === 6) {
                  cell.classList.add("weekend");
                }

                cell.style.position = "relative";
                cell.style.textAlign = "left";
                cell.style.verticalAlign = "top";

                const container = document.createElement("div");
                let titleCount = 0;
              
                for (const item of planList) {
                 
                 let nn = 0;
                 if( item.planday <= item.planeday ) {
                     if (
                       planyear === item.planyear &&
                       planmonth === item.planmonth - 1 &&
                       planday >= item.planday && // planday 범위 체크
                       planday <= item.planeday
                     )  {
                        
                        nn = 1;
                     }
                 }
                 if( item.planday > item.planeday ) {
                     if (
                       planyear === item.planyear &&
                       planmonth === item.planmonth - 1 &&
                       planday >= item.planday 
                     )  {
                        nn = 1;
                     }
                 }
                 if( planyear === item.planyear &&
                     planmonth !== item.planmonth - 1 && // Start month is different from current month
                     planmonth === item.planemonth - 1 && // End month matches current month
                     planday <= item.planeday
                  )  {
                     nn = 1;
                  }

                  if( nn == 1 )
                  
                  {
                     if (titleCount < 2) { // 보여지는 일정은 2개까지만
                      const link = document.createElement("a");
                      link.href = "/planDetail.do?planunq=" + item.planunq;
                      link.style.color = "blue";
                      link.textContent = item.plantitle;
                      link.style.fontSize = "12px";
                      link.style.textDecoration = "none";

                      container.appendChild(link);
                      titleCount++;
                    } else {
                       if (titleCount === 2) {
                          const moreLink = document.createElement("a");
                          moreLink.href = "#"; 
                          moreLink.style.color = "blue";
                          moreLink.style.fontSize = "12px";
                          moreLink.style.textDecoration = "none";

                          const br = document.createElement("br");
                          container.appendChild(br);
                          
                          moreLink.textContent = "more+";
                          container.appendChild(moreLink);

                          const openLinkFunction = openMoreLink(planyear, planmonth, planday, planList);
                          moreLink.addEventListener("click", openLinkFunction);

                          break; // Break the loop after showing "more+"
                        }

                    }
                    if (item.planeday > planday) {
                      const br = document.createElement("br");
                      container.appendChild(br);
                    } else if (item.planday !== item.planeday) {
                      const br = document.createElement("br");
                      container.appendChild(br);
                    }
                  }
                  
                }

                cell.appendChild(container);

                planday++;
                cell.style.width = "100px";
                cell.style.height = "100px";
                cell.style.boxSizing = "border-box";
              }

              row.appendChild(cell);
            }
            calendarBody.appendChild(row);
            if (planday > endDate.getDate()) {
              break;
            }
          }

          monthYearDisplay.textContent = planyear + "년 " + (planmonth + 1) + "월";
     }
     function updateCalendar() {
       generateCalendar(currentDate.getFullYear(), currentDate.getMonth());
     }

     beforeMonthBtn.addEventListener("click", function() {
       currentDate.setMonth(currentDate.getMonth() - 1);
       updateCalendar();
     });

     nextMonthBtn.addEventListener("click", function() {
       currentDate.setMonth(currentDate.getMonth() + 1);
       updateCalendar();
     });

     updateCalendar();
   });
</script>

<body>

   <div class="wrap">


      <!--header 시작-->
      <header>
         <%@include file="../include/header.jsp"%>
      </header>
      <!--header 끝-->



      <!--nav 시작-->
      <nav>
          <div class="navigation">
               <%@include file="../include/nav.jsp"%>
          </div>
        </nav>
      <!--nav 끝-->



      <!--section 시작-->
    <section>
      <div class="section-wrapper">
        <div id="calendar-container" data-resultList="${planList}">
          <div class="button-container">
           <div class="button-group">
             <button id="beforeMonth">이전 달</button>
             <span id="monthYearDisplay"></span>
             <button id="nextMonth">다음 달</button>
           </div>
           <button type="button" id="addPlan">일정추가</button>
         </div>
          <table id="calendar">
            <thead>
              <tr>
                <th>일</th>
                <th>월</th>
                <th>화</th>
                <th>수</th>
                <th>목</th>
                <th>금</th>
                <th class="weekend">토</th>
              </tr>
            </thead>
            <tbody>
            </tbody>
          </table>
        </div>
      </div>
    </section>
    <!--section 끝-->

    <!--footer 시작-->
    <footer>
      <div class="footer">
        <%@include file="../include/footer.jsp"%>
      </div>
    </footer>
    <!--footer 끝-->
  </div>

</body>
</html>
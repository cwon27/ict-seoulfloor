<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../../../inc/header2.jspf" %>

	<link rel = "stylesheet" href = "/seoulfloor/css/calPage.css" type = "text/css"/>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
    
    <script>
    	var clickday = "";
        // 캘린더 생성 영역
        document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
        	titleFormat: { // will produce something like "Tuesday, September 18, 2018"
        	    month: 'long'
        	 },
        	headerToolbar: {
        		start : '',
                center: 'prev,title,next',
                end : ''
          },
          initialView: 'dayGridMonth',
          locale: 'ko',
          fixedWeekCount : false,
          height : 700,
          dateClick: function(info) {
       	  	  // ajax 시작
				var tag = ""; 
        	    $.ajax({
        	        type: 'GET',
        	        url: '${pageContext.request.contextPath}/main/getCal',
        	        data: {
        	            dateStr: info.dateStr
        	        },
        	        dataType: 'json',
        	        success: function(result) {
        	        	console.log(result);
        	        	clickday = info.dateStr;
        	        	
        	        	for (var i = 0; i < result.length; i++) {
        	        	    tag += '<a class = "aList" href = "/seoulfloor/list/listView/'+result[i].no+'">';
        	        	    tag += '<div class="item">';
        	        	    tag += '<div class="item-image">';
        	        	    tag += '	<img src="' + result[i].img_url + '" alt="이미지 없음" onerror="this.src=\'/seoulfloor/img/noimage.png\'">';
        	        	    tag += '</div>';
        	        	    tag += '    <div class="item-desc">';
        	        	    tag += '    <span id="title"><b>' + result[i].title + '</b></span><br/>';
        	        	    tag += '    <span id="due">' + result[i].all_date + '</span><br/>';
        	        	    tag += '    <span id="loc">' + result[i].loc + '</span>';
        	        	    tag += '</div>';
        	        	    tag += '</div>';
        	        	    tag += '</a>';
        	        	}
        	        	document.getElementById("show_list").innerHTML = tag;
        	        	showList();
        	        },
        	        error: function(e) {
        	            e.getMessage();
        	        }
        	    }); 
        	  // ajax 끝
           	  // 날짜가 클릭되면 할 행동
        	  // alert('Clicked on: ' + info.dateStr);
        	  // change the day's background color just for fun
        	  // info.dayEl.style.backgroundColor = 'rgba(225, 99, 132, 0.2)';
        	  },
        	  dayCellContent: function (info) {
        		  // 일 나오는거 삭제
        		    var number = document.createElement("a");
        		    number.classList.add("fc-daygrid-day-number");
        		    number.innerHTML = info.dayNumberText.replace("일", '');
        		    if (info.view.type === "dayGridMonth") {
        		      return {
        		        html: number.outerHTML
        		      };
        		    }
        		    return {
        		      domNodes: []
        		    };
        		},
        		events: ${event}
        });
        calendar.render();
      });
    
    function showList(){
    	console.log(clickday);
    }
    
    // 축제 불러오는 영역
    
    </script>

  <div class = "container" >
   	<div class = "calendar">
   		<div id='calendar'></div>
   	</div>
   	<div class = "show">
   		<h4>축제 리스트</h4>
   		<div class = "show_list" id = "show_list">

   		</div>
   	</div>
  </div>
  
  <%@include file="../../../inc/footer.jspf" %>
   
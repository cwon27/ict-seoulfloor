<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../../../inc/header2.jspf" %>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="/seoulfloor/css/event.css" type="text/css" />
  
  <!-- new -->
 <script>
   

    function sortEvents(sortType) {
       console.log(sortType);
        // `sortType`에 따라 정렬 로직을 정의합니다.
        fetch('/seoulfloor/main/ev_list?sort='+sortType,{method:'GET'})
        .then(response => response.json())
        .then(data => {
            // 페이지를 정렬된 데이터로 업데이트
           console.log(data[0].no);
           tag = '';
           for(var i = 0; i<data.length; i++){
           tag += '<div class="photo">';
           tag += ' <a href="/seoulfloor/main/page/'+data[i].no+'" >';
           tag += '   <img src="'+data[i].content+'" alt=""';
           tag += '    class="im" ></a>';
           tag += '   <div class="area_txt">';
           tag += '      <div class="tit"><a href="/seoulfloor/main/page/'+data[i].no+'" >'+data[i].subject+'</a></div>';
             tag += '   </div>';
          tag += '   <hr/>';
            tag += '   <p class="tag">'+data[i].event_date+'</p>';
           tag += '</div>';
           }
           document.getElementById('box_leftType1').innerHTML = tag;
            
        })
        .catch(error => console.error('오류:', error));            
    }
    /*-----------------------------------------------------------------*/
     function updateEventList(events) {
            const eventContainer = document.getElementById('eventContainer');
            eventContainer.innerHTML = ''; // 기존 이벤트를 삭제

            events.forEach(event => {
                const eventElement = document.createElement('div');
                eventElement.className = 'event-item';
                eventElement.innerHTML = `
                    <h3><a href="/seoulfloor/main/page/${event.no}">${event.subject}</a></h3>
                    <p>${event.content}</p>
                    <p>Hit: ${event.hit}</p>
                    <p>Date: ${event.event_date}</p>
                `;
                eventContainer.appendChild(eventElement);
            });
        }
    
    
    /*-------------------------------------------------------------------*/
   document.addEventListener('DOMContentLoaded', function () {
       const buttons = document.querySelectorAll('.btn_txt button');
   
       buttons.forEach(button => {
          button.addEventListener('click', function () {
              const sortType = this.getAttribute('data-sort');
              sortEvents(sortType);           
          });
      });
   });
</script> 

<div class="text">
    <div id="contents" class="travel">
      <div class="tit_cont">
         <div class="header-text">
                <span>w</span>
                <span>e</span>
                <span>l</span>
                <span>c</span>
                <span>o</span>
                <span>m</span>
                <span>e</span>
         </div>
            <h2 class="tag1">#이벤트</h2>
      </div>
      
         
      <div class="wrap_contView clfix">


             <div class="total_check">
                 <div class="btn_txt">
                     <button type="button" class="button_2" id="latest" data-sort="latest" title="선택됨">인기순</button>
                     <button type="button" class="button_2" id="popularity" data-sort="popularity">최신순</button>
                 </div>
                 <hr/>
             </div>
         <div class="box_leftType1" id ="box_leftType1">
          <c:forEach var="vo" items="${list}">   
            <div class="photo">
               <a href="/seoulfloor/main/page/${vo.no}" >
                  <img src="${vo.content}" alt=""class="im" ></a>
                     <div class="area_txt">
                        <div class="tit" >
                           <a href="/seoulfloor/main/page/${vo.no}" style ="width :100%; height : 100%">${vo.subject}</a>
                        </div>
                     </div>
                  <hr/>
                  <p class="tag">${vo.event_date}</p>
            </div>
         </c:forEach>
                           
         </div>
      </div>
   </div>
</div>      

<%@include file="../../../inc/footer.jspf" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../../../inc/header2.jspf" %>
<link rel="stylesheet" href="/seoulfloor/css/user/memberStamp.css">
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap');
</style>
   
 <title>프로필 페이지</title>
 
    <script>
    window.onload = function(){
       // footer용 onload
       document.getElementById('main_footer').style.marginTop = "1px"; 
       
       // 도장찍기용 onload
       document.getElementById('saveStamps').addEventListener('click', function() {
            let stamps = "";
            // 전송할 데이터 준비
         document.querySelectorAll('.stamp-on-map').forEach(stamp =>{
             const x = stamp.style.left.replace('px', '');
              const y = stamp.style.top.replace('px', '');
         
              
              //stamps.push({"x":x, "y":y});
              stamps += "&x="+x+"&y="+y;
          });
          
         
          console.log(stamps);
            
             // AJAX 요청을 백엔드로 전송
             fetch('/seoulfloor/user/saveStamp',{
                 method: "POST",
                 headers: {
                     //Content-Type': 'application/json'
                    "Content-type":"application/x-www-form-urlencoded"
                 },
                 body: stamps//JSON.stringify({stamps})
             })
            .then(response=>{
                if (response.ok) {
                    return response.json(); // JSON 형식으로 응답을 파싱
                } else {
                    return response.json().then(text => { throw new Error(text.message || '서버 오류'); });
                }
            })
             .then(data => {
                 console.log('성공:', data);
                 // 성공 시 처리
             })
            .catch(e=>console.log(e))
             // fetch 위에서 끝
             
         });
   }

   </script>
   
   <script>
   var currentTab = ""; // 현재 열려 있는 탭을 추적하는 변수
   
   function openTab(tabName) {
       // 이미 열려 있는 탭을 클릭했을 때 닫기
       if (currentTab === tabName) {
           // 현재 탭을 닫기
           document.getElementById(tabName).classList.remove('on');
           document.querySelector('.tabs[onclick="openTab(\'' + tabName + '\')"]').classList.remove('on');
           currentTab = ""; // 탭을 닫았으므로 빈 값으로 초기화
           document.getElementById("saveStamps").style.display = "none";
           document.getElementById("resetStamps").style.display = "none";
           return;
       }
   
       // 새로운 탭을 클릭했을 때
       if (currentTab) {
           // 이전에 열려 있던 탭을 닫기
           document.getElementById(currentTab).classList.remove('on');
           document.querySelector('.tabs[onclick="openTab(\'' + currentTab + '\')"]').classList.remove('on');
   
       }
   
       // 새로운 탭을 열기
       document.getElementById(tabName).classList.add('on');
       document.querySelector('.tabs[onclick="openTab(\'' + tabName + '\')"]').classList.add('on');
   
       // 탭에 따라 버튼 표시 조정
       if (tabName === "Tab1") {
    	   document.getElementById("tab_wrap").style.backgroundColor = "#f2f2f2";
           document.getElementById("saveStamps").style.display = "none";
           document.getElementById("resetStamps").style.display = "none";
           likeList();
          
       } else if (tabName === "Tab2") {
    	   document.getElementById("tab_wrap").style.backgroundColor = "#f2f2f2";
           document.getElementById("saveStamps").style.display = "block";
           document.getElementById("resetStamps").style.display = "block";
           loadStamps();
       }
     
         
       // 현재 열린 탭 이름을 저장
       currentTab = tabName;
   }
   
   
   </script>
   
   <script>
        // 클릭된 탭의 유형 확인
         function likeList() {
         $.ajax({
            type : "GET",
            url : '/seoulfloor/user/getLikeList',
            success : function(data) {
               var tag = "";
               for(var i = 0; i < data.length; i++){
                  tag += "<div><a href='/seoulfloor/list/listView/" + data[i].no + "'>" + data[i].title + "</a> / " + data[i].all_date + "</div>";
               }
               tag +="</div>";
               document.getElementById("view1").innerHTML = tag; // 메서드와 속성명을 수정
            },
            error : function(error) {
               console.log("error");
            }
         });
      }
   
      // 좋아요 목록을 HTML로 변환하는 함수
      function renderLikeList(data) {
          let html = '';
          data.forEach(item => {
              html += `
                  <div class="like-item">
                      <img src="${item.imageUrl}" alt="${item.title}">
                      <p>${item.description}</p>
                  </div>
              `;
          });
          return html;
      }
   </script>
   <script>
   $(document).ready(function() {
          $(document).on('click', '.map-image', function(event) {
              var imageUrl = '/seoulfloor/img/passed.png'; // 도장 이미지 URL
              var x = event.offsetX;
              var y = event.offsetY - 22.5;
              console.log(x, y);
              // 도장 이미지 추가
              $(this).parent().append('<img class="stamp-on-map" src="'+imageUrl+'" style="position: absolute; left: '+x+'px; top: '+y+'px; width: 45px; height: 45px;">');
              
              $('.stamp-image-modal').addClass('show');
          });

          $('#resetStamps').on('click', function() {
               $('.stamp-on-map').remove();
               stampData = [];
           }); 
            
       });
   
       
   </script>    
   <script>
   function loadStamps() {
       $.ajax({
           url: '/seoulfloor/user/getStampList', // 서버에서 도장 데이터를 불러오는 URL
           type: 'GET',
           success: function(data) {
              console.log(data);
              tag = "";
              for(var i = 0; i < data.length ; i++){
                 if(i%2 == 0){
                    tag += '<img class="stamp-on-map" src="/seoulfloor/img/passed.png" style="position: absolute; left: ';
                    tag += data[i]+'px; top: ';
                 }else{
                    tag += data[i] +'px;';
                    tag += ' width: 45px; height: 45px;">';
                 }

              }
              console.log(tag);
              document.querySelector('.map-section').innerHTML += tag;
              document.querySelector('.stamp-image-modal').classList.add('show');
              
           },
           error: function(xhr, status, error) {
               console.error('도장 데이터를 불러오지 못했습니다: ' + error);
           }
       });
   }
   
   
   </script>

   
   
   
   
      <div class="container">
         <!-- 상단 배경 이미지 -->
         <div class="top-banner">
            <img src="/seoulfloor/img/back.jpg" alt="배경 이미지">
         </div>
   
         <!-- 프로필 정보 카드 -->
         <div class="profile-card">
         	<h1>My page</h1>
             <div class="profile-image2">
            <img src="/seoulfloor/upload/${vo.user_img}" onerror="this.src='/seoulfloor/img/user.png'"/>   
            </div>
            <div class="profile-info">
            <div class="nickname">
                  <div>${vo.usernick}님 안녕하세요!</div>
               </div>
               <p><a href="${pageContext.request.contextPath}/user/memberEdit">회원정보수정</a></p>
            </div>
            
      
      
         
         <!-- 하단 메뉴 --> 
         <div class="tab-container">   <!-- likeList와 openTab이 중첩되서 tab1이 안닫히는 문제 확인 -->
            <div class="tabs" onclick="openTab('Tab1')"><h3>좋아요</h3></div>
            <div class="tabs" onclick="openTab('Tab2')"><h3>발도장</h3></div>
            
         </div>
      
         </div>
         <div class = "tapoutput">
            <div class="tab_wrap" id="tab_wrap" style="background-color: #fff">
               <div id="Tab1" class="tab on">
                  <h3 class="like-item" onclick="likeList()" style="display:none">Click</h3>
                  <div id = "view1"></div>
   

               </div>
               <div id="Tab2" class="tab">
               <h2 style="margin: 10px 0 30px 0;">Keep your challenge!</h2>
                      <div class="map-section">
                      <img src="/seoulfloor/img/seoul_map.png" alt="서울특별시 지도" class="map-image">
                         <div class="stamp-image-modal" style="display: none;">
                           <img src="" id="modal-image" alt="업로드한 이미지">
                           </div>
                           
                          </div>             
                
                      </div>
                         <div class="btn" id="stampDiv">                            
		                      <button id="resetStamps" style="display:none;">초기화</button>  
		                       <button id="saveStamps" style="display:none;">저장</button>
                     	</div>             
                     
                  </div>
                   
               
             </div>
                
          </div>
                  
   <%@include file="../../../inc/footer.jspf" %>
   

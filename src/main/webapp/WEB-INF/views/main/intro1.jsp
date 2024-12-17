<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>                
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/seoulfloor/css/intro1.css" type="text/css" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  
	 <script>
	 window.onload = function() {
		    // 스크롤 유도 바 4초 후에 나타남
		    setTimeout(function() {
		        var scrollArrow = document.getElementById('scrollArrow');
		        if (scrollArrow) {  // 요소가 존재하는지 확인
		            scrollArrow.classList.add('show');
		        } else {
		            console.error('scrollArrow 요소를 찾을 수 없습니다.');
		        }
		    }, 4900); // 1000ms = 1초 후에 show 클래스 추가

		    // 버튼 15초 후에 나타남
		    setTimeout(function() {
		        var button = document.getElementById('delayedButton');
		        if (button) {
		            button.style.opacity = '1';
		            button.style.visibility = 'visible';
		        } else {
		            console.error('delayedButton 요소를 찾을 수 없습니다.');
		        }
		    }, 10000); // 15초 후 버튼이 나타남
		};

		// 스크롤 시 스크롤 유도 바가 사라짐
		window.onscroll = function() {
		    var indicator = document.querySelector('.scroll-indicator');
		    if (indicator) {
		        if (window.scrollY > 50) {
		            indicator.style.opacity = '0'; /* 스크롤 시 사라지도록 설정 */
		            indicator.style.visibility = 'hidden';
		        } else {
		            indicator.style.opacity = '1'; /* 스크롤 상단 시 다시 보이도록 설정 */
		            indicator.style.visibility = 'visible';
		        }
		    } else {
		        console.error('scroll-indicator 요소를 찾을 수 없습니다.');
		    }
		};
	</script>
	 


<div class = "test">
		<div class="fade-in-text">
		    <h1 class="fade-item" style="position: relative;">어서오세요! 여긴 <img id="logo_img" src="/seoulfloor/img/logo1.png" style="width: 190px; height: 55px; padding-bottom: 12px;"/> 입니다</span></h1>
		    <br/>
		    <p class="fade-item">여기까지 잘 찾아오셨습니다. 아마 어디로 가야할지 고민이시죠?</p>
		    <p class="fade-item">아님 신나는곳을 갈까? 옛 전통을 보러갈까? 고민이시죠?</p>
		    <p class="fade-item">이런 고민이신분을 위해 저희 seoulfloor 준비했습니다.</p>
		    
		</div>
		
		<div class="scroll-indicator" id="scrollArrow">
		    <p>스크롤하세요</p>
		    <div class="arrow"></div>
		</div>

 
		<div class="a1">
			<div class="box1" style="width:50%; height:100%; background:black;"></div>
			<div class="box2" style="width:50%; height:100%; background:black;"></div>
		</div> 
		
	
		
		<div class = "show_menu1">
			<figure class="snip14321" >
		  		<img src="/seoulfloor/img/in2.jpg" alt="sample36" width="500"/>
			  <figcaption>
			    <div>
			      <h3>한국전통</h3>
			      <h3>축제알아보기...</h3>
			    </div>
			    <div>
			      <h2>한국전통?<br>후회안할거야</h2>
			    </div>
			  </figcaption>
		  		<a href="/seoulfloor/list/traditionalList"></a>
			</figure>
		
			<figure class="snip14321">
				<img src="/seoulfloor/img/f1.png" alt="sample45" />
				  <figcaption>
				    <div>
				      <h3>힙한행사</h3>
				      <h3>축제 알아보기...</h3>
				    </div>
				    <div>
				      <h2>재밌게 놀고싶지?<br> 그럼 한번 구경해봐</h2>
				    </div>
				  </figcaption>
				  <a href="/seoulfloor/list/hipList"></a>
			</figure>

			 <div class="hover-button-container">
		        <a href="/seoulfloor/main/mainPage" class="hover-button" id="delayedButton">메인페이지</a>
			</div>    
		</div>
			<div class="ho1">
		    </div>
</div>
	
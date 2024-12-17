<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@include file="../../../inc/header2.jspf" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<link rel="stylesheet" href="/seoulfloor/css/style_tradi.css" />
<!-- Demo styles -->

<link
  rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
  integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
  crossorigin="anonymous"
  referrerpolicy="no-referrer"
/>
<script src="/seoulfloor/js/filter.js"></script>

<!-- 상단 배너 섹션 -->
<div class="upper-container" style="padding-top: 180px">
	<div class="top">서울의&nbsp; <b>전통문화축제</b></div>
	<!-- 상단 필터 섹션 -->
	<div class ="filter" id ="filter" ></div>
</div>

<!-- Swiper -->
  <div class="swiper mySwiper">
    <div class="swiper-wrapper">
    
      <!-- Swiper slide example -->
      <div class="swiper-slide">
      <a href="/seoulfloor/list/listView/191">
        <div class="content">
          <div class="slide_img">
            <img src="https://cdn.discoverynews.kr/news/photo/202401/1039303_1059652_2145.jpg" alt="축제 이미지" />
          </div>
          <div class="slide_txt">
            <div class="name">
              <span style="font-size: 22px"><b>북촌도락 12월</b></span>
            </div>
            <div class="period"><span style="font-size: 15px">2024.12.22 ~ 2024.12.23</span></div>
            <div class="location"><span style="font-size: 17px">종로구 북촌문화센터</span></div>
          </div>
          </div>
        </a>
      </div>

      <div class="swiper-slide">
        <div class="content">
        <a href="/seoulfloor/list/listView/222">
          <div class="slide_img">
            <img src="https://image.여기유.com/content_festival/2021101511351116342653118237.jpg" alt="축제 이미지" />
          </div>
          <div class="slide_txt">
            <div class="name">
              <span style="font-size: 22px"><b>종로한복축제</b></span>
            </div>
            <div class="period"><span style="font-size: 15px">2024.10.20 ~ 2024.10.22</span></div>
            <div class="location"><span style="font-size: 18px">종로구 송현동 일대</span></div>
          </div>
        </div>
        </a>
      </div>

      <div class="swiper-slide">
      <a href="/seoulfloor/list/listView/215">
        <div class="content">
          <div class="slide_img">
            <img src="https://static.cdn.soomgo.com/upload/service/featured_service_b6b36c4e-a31b-45e0-acfb-b88b7fe3ba69.png?webp=1" alt="축제 이미지" />
          </div>
          <div class="slide_txt">
            <div class="name">
              <span style="font-size: 22px"><b>남산골 가무악 국악한마당</b></span>
            </div>
            <div class="period"><span style="font-size: 15px">2024.10.30 ~ 2024.10.30</span></div>
            <div class="location"><span style="font-size: 18px">중구 충무아트센터</span></div>
          </div>
        </div>
        </a>
      </div>

      <div class="swiper-slide">
      <a href="/seoulfloor/list/listView/228">
        <div class="content">
          <div class="slide_img">
            <img src="https://i0.wp.com/owlmagazine.co.kr/wp-content/uploads/2023/05/%E1%84%92%E1%85%A1%E1%86%AB%E1%84%89%E1%85%A5%E1%86%BC-%E1%84%87%E1%85%A2%E1%86%A8%E1%84%8C%E1%85%A6-%E1%84%87%E1%85%A1%E1%86%A8%E1%84%86%E1%85%AE%E1%86%AF%E1%84%80%E1%85%AA%E1%86%AB_44.jpeg?resize=1600%2C1067&ssl=1" alt="축제 이미지" />
          </div>
          <div class="slide_txt">
            <div class="name">
              <span style="font-size: 22px"><b>2024 한가위 박물관 큰잔치</b></span>
            </div>
            <div class="period"><span style="font-size: 15px">2024.09.30 ~ 2024.09.30</span></div>
            <div class="location"><span style="font-size: 18px">송파구 한성백제박물관</span></div>
          </div>
        </div>
        </a>
      </div>
      
      <div class="swiper-slide">
      <a href="/seoulfloor/list/listView/109">
        <div class="content">
          <div class="slide_img">
            <img src="https://changmuartcenter.com/wp-content/uploads/2021/03/DSC_4470-scaled.jpg" alt="축제 이미지" />
          </div>
          <div class="slide_txt">
            <div class="name">
              <span style="font-size: 22px"><b>창무 국제공연예술제</b></span>
            </div>
            <div class="period"><span style="font-size: 15px">2024.09.26 ~ 2024.09.27</span></div>
            <div class="location"><span style="font-size: 18px">중구 서울남산국악당</span></div>
          </div>
         
        </div>
         </a>
      </div>

      <!-- 반복 가능한 슬라이드 -->
      <!-- 다른 슬라이드 추가 -->
    </div>
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
    <div class="swiper-pagination"></div>
</div>

<!-- 검색, 정렬 -->
<div class="s-container">
    <!-- 검색 버튼 -->
    <div class="search-div">
      <input class="search-input" placeholder="검색어를 입력하세요." type="text" id="tbSearch" onkeydown="keyWordEnter(event)" />
      <input type="button" class="btn input-button" value="검색" onclick="listSearch(1)"/>
    </div>
    <!-- 정렬 버튼 -->
  <div class="sort-div">
	<input type="button" class="sort-div-type" value="최신순" onclick="changeSort('latest')" />
    <input type="button" class="sort-div-type" value="인기순" onclick="changeSort('popular')" />
    <input type="button" class="sort-div-type" value="리뷰순" onclick="changeSort('comment')" />
  </div>
</div>

<!-- 리스트 뿌려주는 div -->
<div class="container">
  <div class="row d-flex justify-content-start">
	<c:forEach var="vo" items="${dataList }">
	    <div class="col-md-3">
	      <a href="/seoulfloor/list/listView/${vo.no}">
	        <div class="list-container">
	          <div class="list_img_div">
		          <img src="${vo.img_url }" alt="${vo.title }" onerror="this.src=\'/seoulfloor/img/noimage.png\'"/>
		      </div>
	          <div class="res_inform">
	            <p>${vo.title }</p>
	            <span>${vo.all_date}</span>
                <%-- <span>${vo.loc } ${vo.loc_detail}</span> --%>
	          </div>
	        </div>
	      </a>
	    </div>
	</c:forEach>
  </div>
</div>

<!-- 페이지네이션 버튼이 동적으로 추가될 영역 -->
	<div class="pagination-container">
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <!-- 페이지네이션 버튼이 여기에 동적으로 추가됩니다 -->
            </ul>
        </nav>
    </div>
<!-- Swiper JS -->
<span class="list-img" style="background: url(https://culture.seoul.go.kr/cmmn/file/getImage.do?atchFileId=a34fab4625684f858ce172506d03bab1&thumb=Y) center/cover no-repeat"></span>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<!-- Initialize Swiper -->

<script>

	// 슬라이드(swiper)
	var swiper = new Swiper(".mySwiper", {
	  slidesPerView: 1.5, // 슬라이드 하나 반만큼 보이게 설정
	  spaceBetween: 1, // 슬라이드 간의 간격
	  centeredSlides: true, // 중앙 정렬 설정
	  loop: true, // 무한 반복
	  pagination: {
	    el: ".swiper-pagination", // 페이지네이션
	    clickable: true, // 페이지 번호 클릭 가능
	  },
	  navigation: {
	    nextEl: ".swiper-button-next", // 다음 슬라이드 버튼
	    prevEl: ".swiper-button-prev", // 이전 슬라이드 버튼
	  },
	  autoplay: {
	    delay: 5000, // 5초마다 자동 재생
	    disableOnInteraction: false, // 상호작용 후에도 자동 재생 유지
	  },
	  mousewheel: false, // 마우스 휠로 슬라이드 이동 가능
	});

	
	
	// 변수 선언
	var currentPage = 1;  // 현재 페이지
	var pageSize = 12;    // 한 페이지당 아이템 수
	var currentSort = 'latest';  // 기본 정렬은 최신순
	
  	// 검색 버튼 작동 시 엔터 가능
	function keyWordEnter(event){
		if(event.keyCode === 13){ // Enter key
		  listSearch();
	  }
	}
 
	// 기본 리스트 로드 (페이지가 처음 열릴 때 호출됨)
	function loadDefaultList(page = 1) {
	    // 검색어 없이 전체 리스트를 불러옴
		listSearch(page, '', currentSort);
	}
	
	// 정렬 선택 함수
	function changeSort(sortOption) {
	    currentSort = sortOption;  // 선택된 정렬 옵션 업데이트
	    listSearch(1);  // 정렬 변경 시 첫 페이지부터 다시 로드
	}
  
 	// 여기에서 모든 기능이 구현된다
	function listSearch(page = 1) {
		var searchKeyword = document.getElementById("tbSearch").value.trim();  // 검색어 가져오기 및 공백 제거
	   
	    // Ajax 요청
	    $.ajax({
	        type: "GET",
	        url: "${pageContext.request.contextPath}/list/search",
	        data: { 
	            keyword: searchKeyword,
	            page: page,
	            pageSize: 12,
	            sort: currentSort  // 선택된 정렬 옵션 전송
	        },
	        success: function(response) {
	            var container = document.querySelector('.container .row');
	            container.innerHTML = ""; // 기존 리스트 초기화
	            
	            if (response.results.length === 0) {
	                container.innerHTML = "<p>항목이 없습니다.</p>";
	                return;
	            }
	
	            var totalRecords = response.totalRecords;  // 총 레코드 수
	            var results = response.results;  // 검색 결과
	
	            // 리스트 추가
	            results.forEach(function(vo) {
	                var imgUrl = vo.img_url ? vo.img_url : '/path/to/default_image.jpg';
	                var title = vo.title ? vo.title : '제목 없음';
	                var allDate = vo.all_date ? vo.all_date : '날짜 정보 없음';
	                var loc = vo.loc ? vo.loc : '위치 정보 없음';
	                var locDetail = vo.loc_detail ? vo.loc_detail : '';
	            	var listItem = `
	                <div class="col-md-3">
	            		<a href="/seoulfloor/list/listView/` + vo.no + `">
	                        <div class="list-container">
	                        	<div class="list_img_div">
	                            	<img src="`+ vo.img_url +`" alt="` + vo.title + `" onerror="this.src=\'/seoulfloor/img/noimage.png\'"/>
	                            </div>
	                            <div class="res_inform">
	                                <p>`+ vo.title+ `</p>
	                                <span>` + vo.all_date + `</span>
	                            </div>
	                        </div>
	                    </a>
	                </div>`;
	                container.innerHTML += listItem;
	            });

	            createPagination(totalRecords, 12, page, searchKeyword);
	        },
	        error: function(error) {
	            console.error("Error during search:", error);
	        }
	    });
	}
 
	// 페이지네이션
	function createPagination(totalRecords, pageSize, currentPage, searchKeyword = '') {
	var totalPages = Math.ceil(totalRecords / pageSize);
	var paginationContainer = document.querySelector('.pagination');
	paginationContainer.innerHTML = "";  // 기존 페이지네이션 초기화

	// 페이지 번호 생성
	for (let i = 1; i <= totalPages; i++) {
		var pageItem = document.createElement('button');
		pageItem.textContent = i;
		pageItem.classList.add('page-item');
		if (i === currentPage) {
		    pageItem.classList.add('active');
		}
		pageItem.addEventListener('click', function() {
		    listSearch(i, searchKeyword, currentSort);  // 해당 페이지로 이동 시 정렬 옵션 전달
		});
		paginationContainer.appendChild(pageItem);
		}
	}
  
	//페이지 로드 시 전체 리스트 로드
	  window.onload = function() {
		  listSearch(1);  // 첫 페이지 로드 시 최신순으로
	      sendValueToServer(2);
	}
	

</script>
<%@include file="../../../inc/footer.jspf" %>

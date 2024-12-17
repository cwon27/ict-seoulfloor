<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@include file="../../../inc/header2.jspf" %>
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<link rel="stylesheet" href="/seoulfloor/css/style_hip.css" />
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
	<div class="top">서울의&nbsp; <b>힙스터들을 위한&nbsp;</b> 축제</div>
	<!-- 상단 필터 섹션 -->
	<div class ="filter" id ="filter" ></div>
</div>


  <!-- 슬라이드 -->
<div class="main">
    <div class="main_bar">
      <a href="/seoulfloor/list/listView/191"><img src="https://cdn.pixabay.com/photo/2022/09/20/11/21/sunset-7467688_1280.jpg" /></a>
      <div class="main_txt">
        <p style="font-size: 25px">세빛섬 카약페스티벌</p>
        <span style="font-size: 15px; width: 100%">2024.10.09 ~ 2024.10.11</span>
        <span style="font-size: 16px">서초구 세빛섬 카약승선장</span>
      </div>
    </div>

    <div class="main_bar">
      <a href="/seoulfloor/list/listView/11">
        <img src="https://www.empac.rpi.edu/sites/default/files/styles/convert_to_webp/public/images-heros/mashup_2014.jpg.webp?itok=34GAAK2a"/></a>
      <div class="main_txt">
        <p style="font-size: 25px">Mash-up DJing Night</p>
        <span style="font-size: 15px; width: 100%">2024.10.30 ~ 2024.10.30</span>
        <span style="font-size: 16px">종로구 광화문광장</span>
      </div>
    </div>

    <div class="main_bar">
      <a href="/seoulfloor/list/listView/99"><img src="https://korean.visitseoul.net/comm/getImage?srvcId=MEDIA&parentSn=27005&fileTy=MEDIA&fileNo=1&thumbTy=L" /></a>
      <div class="main_txt">
        <p style="font-size: 25px">중랑 서울장미축제</p>
        <span style="font-size: 15px; width: 100%">2024.10.18 ~ 2024.10.25</span>
        <span style="font-size: 16px">중랑구 중랑장미공원</span>
      </div>
    </div>
</div>

  
<!-- 검색, 정렬 -->
<div class="s-container">
    <!-- 검색 버튼 -->
    <div class="search-div">
      <input class="search-input" placeholder="검색어를 입력하세요." type="text" id="tbSearch" onkeydown="keyWordEnter(event)" />
      <input type="button" class="input-button" value="검색" onclick="listSearchHip(1)" />
    </div>
  <div class="sort-div">
    <input type="button" class="sort-div-type" value="최신순" onclick="changeSortHip('latest')"/>
    <input type="button" class="sort-div-type" value="인기순" onclick="changeSortHip('popular')"/>
	<input type="button" class="sort-div-type" value="리뷰순" onclick="changeSortHip('comment')" />
  </div>
</div>


	<!-- 리스트를 출력할 컨테이너 -->
	<div class="container">
	  <div class="row d-flex justify-content-start">
	  	<c:forEach var="vo" items="${dataList }">
		    <div class="col-md-3">
		      <a href="/seoulfloor/list/listView/${vo.no}">
		        <div class="list-container">
			        <div class="list_img_div">
			          <img src="${vo.img_url }" alt="${vo.title }" onerror="this.src=/seoulfloor/img/noimage.png"/>
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

	<!-- 페이지네이션을 출력할 컨테이너 -->
	<div class="pagination-container">
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center"></ul>
        </nav>
    </div>


<script>
 
	// 변수 선언
	var currentPage = 1;  // 현재 페이지
	var pageSize = 12;    // 한 페이지당 아이템 수
	var currentSort = 'latest';  // 기본 정렬은 최신순


	  // 검색 버튼 작동 시 엔터 가능
	function keyWordEnter(event){
		if(event.keyCode === 13){ // Enter key
			listSearchHip();
	  }
	}
	
	
	//기본 리스트 로드 (페이지가 처음 열릴 때 호출됨)
	function loadDefaultList(page = 1) {
	    // 검색어 없이 전체 리스트를 불러옴
	    listSearchHip(page, '', currentSort);
	}

	// 정렬 선택 함수
	function changeSortHip(sortOption) {
	    currentSort = sortOption;  // 선택된 정렬 옵션 업데이트
	    listSearchHip(1);  // 정렬 변경 시 첫 페이지부터 다시 로드
	}

	function listSearchHip(page = 1) {
		var searchKeyword = document.getElementById("tbSearch").value.trim();  // 검색어 가져오기 및 공백 제거
	   
	    // Ajax 요청
	    $.ajax({
	        type: "GET",
	        url: "${pageContext.request.contextPath}/list/searchHip",
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
	            		<a href="/seoulfloor/list/listView/`+ vo.no +`">
	                        <div class="list-container">
	                        	<div class="list_img_div">
	                            	<img src="`+ vo.img_url +`" alt="` + vo.title + `" onerror="this.src=\'/seoulfloor/img/noimage.png\'" />
	                            </div>
	                            <div class="res_inform">
	                                <p>`+vo.title+`</p>
	                                <span>` + vo.all_date + `</span>
	                            </div>
	                        </div>
	                    </a>
	                </div>`;
	                container.innerHTML += listItem;
	            });
	            // 페이지네이션
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
	          listSearchHip(i, searchKeyword, currentSort);  // 해당 페이지로 이동
	      });
	      paginationContainer.appendChild(pageItem);
	  }
	}

	//페이지 로드 시 전체 리스트 로드
	window.onload = function() {
		listSearchHip(1);  // 첫 페이지 로드 시 최신순으로
	    sendValueToServer(1);
	
	}
	

</script>

<%@include file="../../../inc/footer.jspf" %>
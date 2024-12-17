<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../../../inc/header.jspf" %>

<link rel="stylesheet" href="/seoulfloor/css/reset.css"/>
<link rel="stylesheet" href="/seoulfloor/css/common.css"/>
<link rel="stylesheet" href="/seoulfloor/css/scroll.css"/>

<script>
      function review_write() {
        var popup = window.open(
          "/seoulfloor/list/reWrite/${vo.no}",
          "review_write",
          "width=740px, height= 730px, left=300px, top=300px"
        );
      }
      
      $(document).on('click', '.fa-pen-to-square', function() {
    	    var review_no = $(this).closest('.review_content').find("#review_no").val(); // 최상위 review_content에서 review_no 찾기
    	    console.log(review_no);
    	    var edit_popup = window.open(
    	        "/seoulfloor/list/reEdit/${vo.no}/" + review_no,
    	        "review_edit",
    	        "width=740px, height=730px, left=300px, top=300px"
    	    );
    	});
      
      $(document).on('click', '.review_content', function(e) {
   	    if ($(e.target).hasClass('fa-trash-can') || $(e.target).hasClass('fa-pen-to-square')) {
   	        // 삭제나 수정 버튼을 클릭한 경우는 창을 열지 않음
   	        return;
   	    }
  	    var review_no = $(this).closest('.review_content').find("#review_no").val(); // 최상위 review_content에서 review_no 찾기
  	    console.log(review_no);
  	    var view_popup = window.open(
  	        "/seoulfloor/list/reView/${vo.no}/" + review_no,
  	        "review_view",
  	        "width=750px, height=730px, left=300px, top=300px"
  	    	);
  		});
      
      function review_sort(sortOpt){
  		var review_sortOpt = sortOpt;
  		
  		$.ajax({
  			url : '/seoulfloor/list/reviewSort',
				type : 'GET',
				data : {
					Data_no : ${vo.no},
					sort_opt : review_sortOpt
				},success : function(r){
					console.log(r);
					var reviewTag = "";
					
					//[{...},{...},{...}....]
					//                index, 배열데이터: {...}
					$(r).each(function(i,rVO){
						//배열을 반복
						reviewTag += `<div class="review_content" style="cursor: pointer">`;
						reviewTag += `<input type="hidden" id="review_no" value=`+rVO.comment_no+`>`;
						reviewTag += 	`<div class="review_content_top">`
						reviewTag += 		`<div class="user_grade">`
						for(var i=1; i<=rVO.grade;i++){
							reviewTag += `<i class="fa-solid fa-star"></i>`
						}
						for(var i=1; i<=(5-rVO.grade);i++){
							reviewTag += `<i class="fa-regular fa-star"></i>`
						} 
						reviewTag += 		`</div>`
						reviewTag +=  		`<div class="review_information">`
						reviewTag += `<span>`+rVO.userid+`</span>`
						if(rVO.userid=='${logId}'){
							reviewTag += `<i class="fa-solid fa-pen-to-square" style="cursor: pointer"></i>`
							reviewTag += `<i class="fa-solid fa-trash-can" style="cursor: pointer"></i>`
						}
						reviewTag += `<span>|</span>`
						reviewTag += `<span>`+rVO.writedate+`</span>`
						reviewTag += `<span>|</span>`
						reviewTag += `<span>조회수 `+rVO.hit+`</span>`
						reviewTag += `</div></div>`
						reviewTag += `<div class="review_content_bottom">`
						reviewTag += `<div class="review_title">`+rVO.title+`</div>`
						reviewTag += `<div class="review_img_content">`
						reviewTag += `<div class="review_img">`
						reviewTag += `<img src=`+rVO.thumb+`>`
						reviewTag += `</div>`
						reviewTag += `<div class="review_content_detail">`+rVO.content_txt+`</div>`
						reviewTag += `</div></div></div>`				
					});
					$("#review_list").html(reviewTag);
				},error : function(e){
					console.log(e.responseText);
				}
  		})
  	}
      
	$(function(){
    	  function reviewList(){
  			$.ajax({
  				url : '/seoulfloor/list/reviewList',
  				type : 'GET',
  				data : {
  					Data_no : ${vo.no}
  				},success : function(r){
  					console.log(r);
  					
  					var reviewTag = "";
  					
  					//[{...},{...},{...}....]
  					//                index, 배열데이터: {...}
  					$(r).each(function(i,rVO){
  						//배열을 반복
  						reviewTag += `<div class="review_content" style="cursor: pointer">`;
  						reviewTag += `<input type="hidden" id="review_no" value=`+rVO.comment_no+`>`;
  						reviewTag += 	`<div class="review_content_top">`
						reviewTag += 		`<div class="user_grade">`
						for(var i=1; i<=rVO.grade;i++){
							reviewTag += `<i class="fa-solid fa-star"></i>`
						}
						for(var i=1; i<=(5-rVO.grade);i++){
							reviewTag += `<i class="fa-regular fa-star"></i>`
						} 
						reviewTag += 		`</div>`
						reviewTag +=  		`<div class="review_information">`
						reviewTag += `<span>`+rVO.userid+`</span>`
						if(rVO.userid=='${logId}'){
							reviewTag += `<i class="fa-solid fa-pen-to-square" style="cursor: pointer"></i>`
							reviewTag += `<i class="fa-solid fa-trash-can" style="cursor: pointer"></i>`
						}
						reviewTag += `<span>|</span>`
						reviewTag += `<span>`+rVO.writedate+`</span>`
						reviewTag += `<span>|</span>`
						reviewTag += `<span>조회수 `+rVO.hit+`</span>`
						reviewTag += `</div></div>`
						reviewTag += `<div class="review_content_bottom">`
						reviewTag += `<div class="review_title">`+rVO.title+`</div>`
						reviewTag += `<div class="review_img_content">`
						reviewTag += `<div class="review_img">`
						reviewTag += `<img src=`+rVO.thumb+`>`
						reviewTag += `</div>`
						reviewTag += `<div class="review_content_detail">`+rVO.content_txt+`</div>`
						reviewTag += `</div></div></div>`				
  					});
  					$("#review_list").html(reviewTag);
  				},error : function(e){
  					console.log(e.responseText);
  				}
  			});
  		  }
    	  
    	  function reviewGradeAvg(){
    			$.ajax({
    				url : '/seoulfloor/list/reviewGradeAvg',
    				type : 'GET',
    				data : {
    					Data_no : ${vo.no}
    				},success : function(r){
    					console.log(r);
    					$(".avg_section").text(r);
    				},error : function(e){
    					console.log(e.responseText);
    				}
    			});
    		  }
    	  
    	  $(document).on('click', '.fa-trash-can', function() {
  			if(confirm('이 리뷰를 삭제하시겠습니까?')){
  				var review_no = $(this).closest('.review_content').find("#review_no").val();
  				var Data_no = "${vo.no}";
  				
  				
  				$.ajax({
  					url:'/seoulfloor/list/reDel',
  					data:{
  						review_no:review_no,
  						Data_no:Data_no
  					},success:function(r){
  						console.log(r);
  						if(r==0){alert("리뷰 삭제를 실패했습니다!");}
  						else{
  							alert("리뷰를 삭제했습니다!");
  							reviewGradeAvg();
  							reviewList();
  						}
  					},error:function(e){
  						console.log(e.responseText);
  					}
  				})
  			}
  		});
    	reviewGradeAvg();
    	reviewList();
      })
      
      
</script>
<script>
window.onload = function () {
	checkLikeState(0);
	var likeClick = document.getElementById("btnLike");
    likeClick.addEventListener("click", function () {
    	checkLikeState(1);
    });
    function checkLikeState(action) {
        $.ajax({
          url: '/seoulfloor/list/likeState',
          method: 'GET',
          data:{
        	  action: action,
        	  no : ${vo.no}
          },
          success: function(data) {
            console.log("like : " + data[0]);

            if (data[0].result) {
              document.getElementById("btnLike").classList.remove("off");
              document.getElementById("btnLike").classList.add("on");
            } else {
              document.getElementById("btnLike").classList.remove("on");
              document.getElementById("btnLike").classList.add("off");
            }
            document.getElementById("spanLikeCnt").innerHTML = data[0].count;
          },
          error: function(error) {
            console.error(error);
          }
        });
      }
    
  };

</script>


<main role="main" id="mainTab">
  <div class="wrap">
  <div id="toTop" class="on">
		<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-chevron-up">
			<polyline points="18 15 12 9 6 15"></polyline>
		</svg>TOP
	</div>	
    <section class="visual" role="region" aria-labelledby="festival_head">
      <div class="inner_full visual_height">
        <div
          class="visula_bg"
          style="
            background: url(${vo.img_url})
              no-repeat center;
            background-size: cover;
          "
        ></div>
      </div>
    </section>
    <div class="scroll_wrap">
      <section class="poster_title" role="region">
        <div class="visula_content_box">
          <div class="inner">
            <div class="festival_title">
              <h2 id="festival_head">${vo.title }</h2>
            </div>

             <div class="timer-area">
              <p>${vo.type }</p>
            </div> 

            <div class="schedule">
              <span>${vo.all_date }</span>
            </div>
            
            <div class="festival_img3">
                  <div class="row">
                     <c:if test="${vo.type ==  '힙한행사'}">
                     <div class="col-sm-4"><img src="/seoulfloor/img/hip1_div_img.jpg"/></div>
                     <div class="col-sm-4"><img src="/seoulfloor/img/hip2_div_img.jpg"/></div>
                     <div class="col-sm-4"><img src="/seoulfloor/img/hip3_div_img.jpg"/></div>
                     </c:if>
                     <c:if test="${vo.type ==  '전통행사'}">
                     <div class="col-sm-4"><img src="/seoulfloor/img/tradition1_div_img.png"/></div>
                     <div class="col-sm-4"><img src="/seoulfloor/img/tradition2_div_img.png"/></div>
                     <div class="col-sm-4"><img src="/seoulfloor/img/tradition3_div_img.png"/></div>
                     </c:if>
                  </div>
            </div>
          </div>
        </div>
      </section>

      <section class="poster_slide" role="region">
        <div class="inner_full">
          <div class="inner">
            <!-- 좋아요, 공유하기, 조회수 -->
            <div role="application" class="application_div">
              <!-- 좋아요 -->
              <ul class="like_share_cnt_box">
                <li>
                  <button
                    id="btnLike"
                    class="off"
                    aria-label="좋아요"
                    title=""
                  ></button>
                  <span id="spanLikeCnt">1</span>
                </li>
                <li>
                  <i class="fas fa-solid fa-eye"></i>
                  <span id="spanPubCnt">${vo.hit }</span>
                </li>
              </ul>
            </div>
            <!-- //좋아요, 공유하기, 조회수 -->
          </div>
        </div>
      </section>
      <section class="poster_detail" role="region">
        <div class="inner">
          <!-- 상세정보 -->
          <div
            class="poster_detail_wrap"
            role="application"
            aria-labelledby="poster_detail_head"
          >
            <strong id="poster_detail_head" class="poster_detail_title"
              >상세정보</strong
            >
            <div class="poster_detail_area">
              <div class="detail_img_box">
                <img
                  src="${vo.img_url}"
                />
              </div>
              <div class="img_info_box">
                <ul>
                  <li>
                    <img
                      src="/seoulfloor/img/calendar_icon.png"
                      style="width: 48px; height: 48px"
                    />
                    <p class="info_content">${vo.all_date }</p>
                  </li>

                  <li>
                    <img
                      src="/seoulfloor/img/location_icon.png"
                      style="width: 48px; height: 48px"
                    />
                    <p class="info_content">
                      ${vo.loc_detail} (${vo.loc})&nbsp;
                    </p>
                  </li>

                  <li>
                    <img
                      src="/seoulfloor/img/pay_icon.png"
                      style="width: 48px; height: 48px"
                    />
                    <p class="info_content">${vo.admission }</p>
                  </li>

                  <li>
                    <img
                      src="/seoulfloor/img/speaker_icon.png"
                      style="width: 48px; height: 48px"
                    />
                    <p class="info_content">${vo.host }</p>
                  </li>
                </ul>

                <a
                  class="homepage_link_btn"
                  target="_blank"
                  href="${vo.page_url }"
                  ><span class="fst">공식 홈페이지</span
                  ><span class="lst"></span
                ></a>
              </div>
            </div>
          </div>
          <!-- //상세정보 -->

          <!-- 카카오 지도 -->
          <div
            class="map_section"
            role="application"
            aria-labelledby="map_wrap_head"
            style="border-top: none; border-bottom: solid 2px #e6e6eb"
          >
            <strong id="map_wrap_head" class="poster_detail_title"
              >길찾기
            </strong>
            <div
              id="map"
              class="map_wrap"
              style="
                overflow: hidden;
              "
            >
              <button
                class="map_shortcut" id="map_btn"
                >길찾기<span></span
              ></button>
            </div>
          </div>
        </div>
      </section>

      <section class="review_section">
        <div class="inner">
          <strong id="review_wrap_head">회원리뷰</strong>
          <div style="margin: 30px 0 48px 0; width: 100%; font-size: 16px">
            <div class="review_top">
              <span class="tit_cmt">
                게시판 운영 규정에 어긋난다고 판단되는 게시글은 사전
                통보없이 블라인드 처리될 수 있습니다.<br />
                전화번호, 이메일 등의 개인정보는 악용될 우려가 있으므로
                게시를 삼가 주시기 바랍니다.<br />
                불량 게시물을 계속적으로 게재한 게시자의 경우 서울플로어
                게시판 작성 권한이 제한됩니다.
              </span>
              <c:if test="${logStatus == 'Y'}">
	              <button class="review_write_btn" onclick="review_write()">
	                <b>리뷰쓰기</b> >
	              </button>
              </c:if>
            </div>
            <div class="review_bottom">
              <div class="grade_section">
                <p>
                  서울플로어 회원이 평가한 평균 별점
                </p>
                <div class="grade_content">
                  <div class="star">
                    <i class="fas fa-solid fa-star"></i
                    ><i class="fa-solid fa-star"></i
                    ><i class="fa-solid fa-star"></i
                    ><i class="fa-solid fa-star"> </i
                    ><i class="fa-solid fa-star"></i>
                  </div>
                  <div class="grade_avg">
                    <span class="avg_section"></span>
                    <span class="total_grade"> / 10.0</span>
                  </div>
                </div>
              </div>
              <div class="sort_section">
                <div class="sort_div">
                  <span onclick="review_sort('new')">최신글순</span>
                  <span onclick="review_sort('grade')">평점순</span>
                  <span onclick="review_sort('hot')">조회순</span>
                </div>
              </div>
              <div class="review_list" id="review_list">
                
                
              </div>
            </div>
          </div>
        </div>
      </section>
      <section class="footer_section" style="border-top: solid 1px #E6E6EB">
      	<div class="inner" >
      		<div class="top_util">
			  <ul class="top_util_ul">
			    <li><a href="#">개인정보처리방침</a></li>
			    <li><a href="#">이용약관</a></li>
			  </ul>
			  <address class="footer_inform">
			    <ul>
			      <li>서울 성동구 아차산로 113 삼진빌딩 2층 한국ICT인재개발원 성수센터</li>
			      <li>대표번호 : 010 - 1234 - 1234</li>
			      <li>사업자 번호 : 111-22-33333</li>
			    </ul>
			  </address>
			</div>
			<div class="footer_bottom">
			  <span class="copyright">© 서울플로어</span>
			  <span><img src="/seoulfloor/img/logo2.png"></span>
			</div>	
      	</div>
      </section>
    </div>
  </div>
</main>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e776a92cd0c17b7f7c913cc2bde86aca"></script>
<script>
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(${vo.lat}, ${vo.lng}), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
	};
	
	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(${vo.lat}, ${vo.lng}); 

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});

	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	
	var mapbtn = document.getElementById('map_btn');
	mapbtn.addEventListener("click", function() {
		window.location = "https://map.kakao.com/link/to/${vo.loc_detail}"+","+${vo.lat}+","+${vo.lng};
	})
	
</script>
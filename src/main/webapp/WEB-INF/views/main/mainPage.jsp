<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="../../../inc/header.jspf" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">
<link rel="stylesheet" href="/seoulfloor/css/mainPage.css"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<style>
	/* 포스터 div css : 파일로 빼니까 안돼서 여기다 넣음 */
	*, :after, :before{-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box}
	
	.mainPoster, .tradition_hip{
		/* width: 1920px; */
		margin: 120px 0px 150px 0px;
	}
	
	.mainPoster{
		background-color: #F2F2F2;
		padding: 100px 0px;
	}
	
	.poster_div, .tradition_div, .hip_div{
		width : 1000px;
		margin: 0 auto;
	}
	
	.img_box{
		display: inline-block;
		width: 45%;
	}
	.img_box img{
		width: 100%;
		height: 300px;
		border-radius: 20px;
	}
	.text_box_cw{
		width: 50%;
		height: 300px;
		float:right;
		font-family:var(--e-font),var(--k-font);
	}
	.text_box_cw .tit, .text_box_cw2 .tit {
	    font-weight: 700;
	    font-size: 40px;
	    color: #333;
	    margin-bottom: 10px;
	}

	.text_box_cw .txt .text_box_cw2 .txt{
	    font-size: 14px;
	    line-height: 24px;
	    color: #888;
	}
	
	.hip_div{
		margin-top: 80px;
	}
	
	.text_box_cw2{
		width: 50%;
		height: 300px;
		font-family:var(--e-font),var(--k-font);
		float:left;
	}
	
	.img_box2{
		display: inline-block;
		width: 45%;
		float: right;
	}
	
	.img_box2 img{
		width: 100%;
		height: 300px;
		border-radius: 20px;
	}
	
	/* 타이틀 */
	.mainPoster .tit_area{display:flex;justify-content:center;align-items:flex-end;margin-bottom:80px;font-family:var(--e-font),var(--k-font)}
	.mainPoster .tit_area dt > span{padding:8px 20px 11px 15px;border:1px solid #4E4E4E;justify-content:center;border-radius:30px;font-size:18px;font-weight:500}
	.mainPoster .tit_area dt p{margin-top:28px;font-size:80px;line-height:1.2; color:#4E4E4E;}
	.mainPoster .tit_area dt p span{overflow:hidden;display:block}
	.mainPoster .tit_area dt p i{display:inline-block;font-style:normal}
	.mainPoster .tit_area dd{margin-left:0.5%;font-size:16px;white-space:pre-line}
	
	/* 이미지 */
	.grid_imgs{display:grid;grid-template-columns:repeat(4, 1fr);gap:20px;font-family:'pretendard'}
	.grid_imgs li{overflow:hidden;position:relative;}
	.grid_imgs li a{display:block;height:100%}
	.grid_imgs li .thum{width:100%;transition:all .6s}
	.grid_imgs li .mask{opacity:0;position:absolute;left:0;top:0;z-index:1;width:100%;height:100%;background:rgb(1,1,1);background:linear-gradient(0deg, rgba(1,1,1,1) 0%, rgba(0,0,0,0) 80%);transition:all .25s}
	.grid_imgs li .txt{opacity:0;position:absolute;z-index:1;display:flex;justify-content:flex-end;width:100%;height:100%;padding:0 0 15% 12%;flex-flow:column;font-weight:500;color:#fff;transition:.6s}
	.grid_imgs li .txt p{padding-right:35%;margin-bottom:20px;font-size:20px;line-height:1.35;word-break:keep-all}
	.grid_imgs li .txt span{overflow:hidden;position:relative;width:max-content;padding-right:28px;font-size:14px}
	.grid_imgs li .txt span i{position:absolute;right:0;top:4px;transition:all .2s}
	.grid_imgs li .txt span i.on{right:20px;opacity:0}
	
	@media(hover:hover){
	.grid_imgs li:hover .thum{transform:scale(1.1)}
	.grid_imgs li:hover .mask{opacity:.8}
	.grid_imgs li a:hover .txt{opacity:1}
	.grid_imgs li a:hover i.off{right:-20px;opacity:0}
	.grid_imgs li a:hover i.on{right:0;opacity:1}
	}
	@media(max-width:850px){
	.grid_imgs li .mask{opacity:0.8}
	.grid_imgs li .txt{opacity:1;padding:0 0 40px 30px}
	.grid_imgs li .txt p{margin-bottom:0;font-size:18px;line-height:1.4}
	.grid_imgs li .txt span{display:none}
	}
	@media(max-width:768px){
	.grid_imgs{grid-template-columns:repeat(2, 1fr);gap:15px}
	.grid_imgs li .txt{padding:0 0 20px 20px}
	.grid_imgs li .txt p{font-size:16px}
	}
	@media(max-width:480px){
	.grid_imgs li .txt{padding:0 0 20px 15px}
	.grid_imgs li .txt p{padding-right:20%;font-size:14px}
	}
	
	#inc01 .view_btn{display:inline-block;position:relative;margin-top:30px;padding-left:70px;font-size:17px;line-height:58px;transition:all .3s;font-family:var(--e-font);color: #4E4E4E;}
	#inc01 .view_btn:before{position:absolute;left:0;top:0;width:58px;height:58px;border-radius:30px;content:'';z-index:-1;transition:all .3s;background-color: #4E4E4E}
	#inc01 .view_btn span{position:absolute;left:26px;top:-1px;font-size:8px;color:#fff;transition:all .3s}
	#inc01 .view_btn span:before{position:absolute;left:-18px;top:28px;width:20px;height:2px;opacity:0;content:'';background-color:#fff;transition:all .3s}
	#inc01 .view_btn:hover:before{width:180px}
	#inc01 .view_btn:hover{color:#fff}
	#inc01 .view_btn:hover span{left:45px}
	#inc01 .view_btn:hover span:before{left:-15px;opacity:1}
	
	#inc02{position:relative; text-align:center; width: 100%; overflow: hidden;}
	#inc02 .tit_area > span{font-size:20px;color:#222;font-weight:600; font-family:var(--k-font)}
	#inc02 .tit_area p{margin-top:7px;font-size:52px;font-weight:700;color:#222;font-family:var(--e-font)}
	#inc02 .tit_area p span{color:var(--primary)}
	#inc02 .review_slide{padding-top:53px}
	#inc02 .review_slide figure{margin:0}
	#inc02 .review_slide .img{overflow:hidden;margin:0 auto;width:85px;height:85px;border-radius:50%}
	#inc02 .review_slide .img img{width:100%;height:100%;object-fit:cover}
	#inc02 .review_slide .item{padding:50px 80px;text-align:center;box-shadow:0 0 36px rgba(0, 0, 0, 0.1); font-family:var(--e-font),var(--k-font)}
	#inc02 .review_slide .item .tit{margin-top:27px;font-size:18px;color:#222;font-weight:600;display:-webkit-box;-webkit-line-clamp:1;-webkit-box-orient:vertical;overflow:hidden}
	#inc02 .review_slide .item .txt{margin:5px 0 25px;line-height:1.6;word-break:keep-all;color:#777;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden}
	#inc02 .review_slide .item .date{font-size:15px;color:#aaa}
	#inc02 .pager{position:relative;margin-top:60px}
	#inc02 .pager span{margin:0 10px;width:9px;height:9px}
	#inc02 .pager span.on{opacity:1;background-color:var(--primary)}
</style>

<div id="mainVisual" data-aos="fade-down">
   <div class="main_txt">
        <p class="btxt" data-aos="fade-up" data-aos-delay="400">Join Your
        Festival SeoulFloor</p>
        <div class="stxt" data-aos="fade-up" data-aos-delay="600">대한민국의 중심, 서울에서 진행중인 축제와 행사에
         참여하고 싶은 모두를 위한 서비스.</div>
        <div class="controls" data-aos="fade-up" data-aos-delay="800">
            <div class="circle">
                <div class="autoplay-progress">
                    <svg viewBox="0 0 48 48"><circle cx="24" cy="24" r="20"></circle></svg>
                    <span class="bg"></span>
                </div>
                <div class="play">
                    <div class="swiper-pause"><span class="material-symbols-outlined">pause</span></div>
                    <div class="swiper-play"><span class="material-symbols-outlined">play_arrow</span></div>
                </div>
            </div>
            <div class="arrow">
                <span class="prev"><i class="material-symbols-outlined">west</i></span>
                <div class="pager"></div>        
                <span class="next"><i class="material-symbols-outlined">east</i></span>
            </div>        
        </div>
    </div>
    <div class="main_slide swiper-container">
        <ul class="swiper-wrapper">
            <li class="swiper-slide"><div data-swiper-parallax-x="40%" class="bg bg01"></div></li> 
            <li class="swiper-slide"><div data-swiper-parallax-x="40%" class="bg bg02"></div></li> 
            <li class="swiper-slide"><div data-swiper-parallax-x="40%" class="bg bg03"></div></li>
            <li class="swiper-slide"><div data-swiper-parallax-x="40%" class="bg bg04"></div></li>
            <li class="swiper-slide"><div data-swiper-parallax-x="40%" class="bg bg05"></div></li>
            <li class="swiper-slide"><div data-swiper-parallax-x="40%" class="bg bg06"></div></li> 
        </ul>
    </div>
    <div class="scroll">SCROLL DOWN<span></span></div>
</div>
<div class="tradition_hip">
	<div class="tradition_div">
		<div class="img_box aos-init aos-animate" data-aos="fade-right" data-aos-offset="300"
			 data-aos-easing="ease-out-cubic" data-aos-duration="1000">
			<img src="/seoulfloor/img/img11.jpg"/>
        </div>
        <div class="text_box_cw aos-init aos-animate" data-aos="fade-up" data-aos-offset="300"
			 data-aos-easing="ease-out-cubic" data-aos-duration="1000">
        	<p class="tit"># Tradition</p>
        	<p class="txt">
        	한국의 전통 행사는 오랜 역사와 문화 속에서 이어져 온 중요한 문화유산입니다.<br>
        	서울의 주요 전통 축제들에 대한 자세한 설명과 함께, 주요 행사, 참여 방법 등을 한눈에 확인할 수 있습니다.
        	<br><br>
            한국의 전통적인 특색을 가진 다양한 축제를 즐겨보세요!
            </p>
            <div id="inc01">
			  <a href="/seoulfloor/list/traditionalList" class="view_btn">
			    <span><i class="fa fa-play" aria-hidden="true"></i></span>view more
			  </a>
			</div>
        </div>
	</div>
	<div class="hip_div">
        <div class="text_box_cw2 aos-init aos-animate" data-aos="fade-up" data-aos-offset="300"
			 data-aos-easing="ease-out-cubic" data-aos-duration="1000">
        	<p class="tit"># Hip</p>
        	<p class="txt">
        	한국은 전통과 현대가 어우러진 다채로운 문화의 중심지입니다.<br>
        	특히 젊고 트렌디한 감성을 담은 ‘힙한’ 축제들은 한국의 문화와 라이프스타일을 대표하는 새로운 아이콘으로 자리 잡고 있습니다.
        	<br><br>
            음악, 예술, 패션, 푸드, 그리고 다양한 서브컬처까지, 지금 가장 뜨거운 축제들을 한 곳에서 만나보세요!
            </p>
            <div id="inc01">
			  <a href="/seoulfloor/list/hipList" class="view_btn">
			    <span><i class="fa fa-play" aria-hidden="true"></i></span>view more
			  </a>
			</div>
        </div>
        <div class="img_box2 aos-init aos-animate" data-aos="fade-left" data-aos-offset="300"
			 data-aos-easing="ease-out-cubic" data-aos-duration="1000">
			<img src="/seoulfloor/img/img12.jpg"/>
        </div>
        <div style="clear: both;"></div>
	</div>
</div>
<div class="mainPoster">
	<dl class="tit_area aos-init aos-animate" data-aos="fade-up">
    	<dt>
            <span>🔥 Hot  </span>
            <p><span><i data-aos="fade-up" class="aos-init aos-animate">Tradition&Hip</i></span>
            <span><i data-aos="fade-up" class="aos-init aos-animate">Festival List</i></span></p>
        </dt>
        <dd>전통적이거나 힙한 행사 리스트를 한눈에 즐겨보세요. 
        여러분의 추억을 우리의 사이트로 더 즐겁게, 더 특별하게 만들어보세요.</dd>
    </dl>
	<div class="poster_div">
		<ul class="grid_imgs">
			<c:forEach var="vo" items="${list}">
				<li data-aos="zoom-in" data-aos-offset="300">
			    <a href="/seoulfloor/list/listView/${vo.no}">
			      <div class="mask"></div>
			      <div class="txt">
			        <p>${vo.title}</p>
			        <span>View more<i class="on fa fa-long-arrow-right"></i><i class="off fa fa-long-arrow-right"></i></span>
			      </div>
			      <img class="thum" src="${vo.img_url}"/>
			    </a>
			  </li>
			</c:forEach>  
		</ul>
	</div>
</div>
<div id="inc02">
	<div class="tit_area aos-init aos-animate" data-aos="fade-up">
        <span>추억을 공유합니다</span>
        <p>Festival <span>Reviews</span></p>
    </div>
    <div data-aos="fade-up" data-aos-delay="200" class="aos-init aos-animate">
        <div class="swiper-container review_slide swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events">
            <div class="swiper-wrapper" id="swiper-wrapper-28692dda684edb18" aria-live="off" style="transition-duration: 0ms;">
				<c:forEach var="vo" items="${review_list}">
					<article class="swiper-slide item swiper-slide-duplicate swiper-slide-duplicate-prev" data-swiper-slide-index="${var}" role="group" aria-label="${var+1 } / 9" style="width: 492.5px; margin-right: 50px;">
						<figure>
							<div class="img"><img src="/seoulfloor/img/user.png"></div>
							<figcaption>
								<p class="tit">${vo.title}</p>
								<p class="txt">${vo.content_txt}</p>
								<p class="date">${vo.writedate}</p>
							</figcaption>
						</figure>
					</article>
				</c:forEach>
            </div>
            <div class="pager swiper-pagination-clickable swiper-pagination-bullets"><span class="swiper-pagination-bullet" tabindex="0" role="button" aria-label="Go to slide 1"></span><span class="swiper-pagination-bullet on" tabindex="0" role="button" aria-label="Go to slide 2"></span><span class="swiper-pagination-bullet" tabindex="0" role="button" aria-label="Go to slide 3"></span></div>
        	<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
        </div>
    </div>
</div>

<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script>
    const progressCircle = document.querySelector("#mainVisual .autoplay-progress svg");
    const progressContent = document.querySelector("#mainVisual .autoplay-progress span");
    var mainSwiper = new Swiper(".main_slide", {
      loop: true,
      speed: 1200,
      parallax: true,
      slideActiveClass: 'on',
      autoplay: {
        delay: 3000,
        disableOnInteraction: false },
    
      pagination: {
        el: "#mainVisual .pager",
        type: "fraction" },
    
      navigation: {
        nextEl: '#mainVisual .next',
        prevEl: '#mainVisual .prev' },
    
      on: {
        autoplayTimeLeft(s, time, progress) {
          progressCircle.style.setProperty("--progress", 1 - progress);
        } } });
    
    
    $('#mainVisual .swiper-pause').click(function () {
      mainSwiper.autoplay.stop();
    });
    $('#mainVisual .swiper-play').click(function () {
      mainSwiper.autoplay.start();
    });
    $(function () {
      $("#mainVisual .play").click(function () {
        $(this).toggleClass("on");
      });
    });
    
    AOS.init();
    /*AOS.init({
    	  once: true, // 한 번만 애니메이션 실행
    }); */
</script>
<script>
    var swiper = new Swiper("#inc02 .review_slide", {
        slidesPerView: 3.6,
		speed:1000,
        loop:true,
        spaceBetween: 50,
        centeredSlides: true,
        autoplay : {
        delay : 3000,
        disableOnInteraction : false, 
        },
        pagination: {
        el: "#inc02 .pager",
		bulletActiveClass: 'on',
        clickable: true,
        },
    });
</script>

<%@include file="../../../inc/footer.jspf" %>

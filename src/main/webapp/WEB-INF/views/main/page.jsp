<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../../../inc/header2.jspf" %>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="/seoulfloor/css/page.css" type="text/css" />
  
<div class="test" style="padding-top: 180px;">

	  	<div class="area_tag">
			<a href="/seoulfloor/main/event">
				<img src="/seoulfloor/img/logo2.png" alt="">
			</a>		
		</div>
        <div class="box_txtPhoto">
            <h2 class="ev_tit">${view.subject}</h2>
            <div class="num_view" style="text-align: right; margin: 0 auto; width: 940px; padding-bottom: 15px; border-bottom: 2px solid #ebebeb">
                    <em class="tit123">👁‍🗨</em>
                    <span class="num">${view.hit}</span>
            </div>
            <%-- <p class="ev_content">${view.content}</p> --%>
<%--             <p class="ev_writeDate">작성일: ${event.writeDate}</p>
            <p class="ev_eventDate">이벤트 기간: ${event.eventDate}</p> --%>

            <div class="box_img">
                <img src="${view.content}" class="P1"  alt="Event Image">
            </div>
        </div>
		
			<!-- new -->
	<div class="box_but">
		<a href="/seoulfloor/main/event" alt="배지콕콕 페이지로 이동">
		<input type="button" value="목록으로 돌아가기" class="but"/></a> 
	</div>		
	
			
</div>  	

<%@include file="../../../inc/footer.jspf" %>
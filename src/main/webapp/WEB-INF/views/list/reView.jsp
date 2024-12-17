<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="/seoulfloor/css/review.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
    />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<style>
		.content_div img{
			max-width: 685px;
		}
		
		.view_div .row .p-2{
			border: 0.1rem solid #D2D2D6;
		}
		
		.re_inform_div, .re_title_div div:nth-of-type(2n+1), .content_div{
			text-align: center;
		}
		
		.re_inform_div div:nth-of-type(2n+1), .re_title_div div:nth-of-type(2n+1) {
			background-color: #eee;
		}
		
		
	</style>

    <script>
    
      function review_close() {
        if (confirm("이 창을 닫으시겠습니까?")) {
          window.open("", "_self").close();
          opener.location.href = "/seoulfloor/list/listView/${vo.no}"
        }
      }
    </script>
  </head>
  <body>
    <div class="review_wrapper">
      <div class="review_container">
        <div class="review_top_div" style="padding: 0px 20px">
          <div class="review_header">
            <button type="button" class="exit_review" onclick="review_close()">
              <i class="fa-solid fa-xmark"></i>
            </button>
          </div>
          <div class="review_poster_grade">
            <div class="review_poster">
              <img
                src="${vo.img_url}"
              />
            </div>
            <div class="review_poster_inform_grade">
              <div class="review_poster_title">${vo.title }</div>
              <div style="font-size: 11px; margin-top:7px">${vo.host }</div>
              <div class="grade-input">
        		  <!-- 별점 표시되는 공간 -->
				  <c:forEach begin="1" end="${comment_vo.grade }" step="1">
				  	<span><i class="fa-solid fa-star"></i></span>
				  </c:forEach>
				  <c:forEach begin="1" end="${5-comment_vo.grade }" step="1">
				  	<span><i class="fa-regular fa-star"></i></span>
				  </c:forEach>
        	</div>
            </div>
          </div>
        </div>
        <div class="view_div" style="position: relative; padding: 0 30px; margin-bottom: 20px;">
        	<div class="row re_inform_div">
				<div class="col-sm-2 p-2">작성자</div>
				<div class="col-sm-2 p-2">${comment_vo.userid}</div>
				<div class="col-sm-2 p-2">조회수</div>
				<div class="col-sm-1 p-2">${comment_vo.hit}</div>
				<div class="col-sm-2 p-2">등록일</div>
				<div class="col-sm-3 p-2">${comment_vo.writedate}</div>
			</div>
			<div class="row re_title_div">
				<div class="col-sm-1 p-2">제목</div>
				<div class="col-sm-11 p-2">${comment_vo.title}</div>
			</div>
			<div class="row">
				<div class="col-sm-12 p-2 content_div">${comment_vo.content}</div>
			</div>
        </div>
      </div>
    </div>
  </body>
</html>
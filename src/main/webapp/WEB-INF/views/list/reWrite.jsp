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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- ckeditor5 -->
	<link rel="stylesheet" href="/seoulfloor/ckeditor/ckeditor.css"/>
	<script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/super-build/ckeditor.js"></script>
	<script src="/seoulfloor/ckeditor/ckeditor.js"></script>
    <script>
	    window.onload = function(){
			CKEDITOR.ClassicEditor.create(document.getElementById("content"), option)
		    .then(editor => {
                editorInstance = editor; // 에디터 인스턴스를 변수에 저장
            })
            .catch(error => {
                console.error(error);
            });
		}
    
      function review_close() {
        if (confirm("작성을 취소하시겠습니까?\n작성 중인 내용은 저장되지 않습니다!")) {
          window.open("", "_self").close();
        }
      }
      
      //별점
      $(function(){	  
    	  $(".grade-input span").click(function(){
		  // 현재 클릭한 별 포함 이전 모든 별에 fa-solid 클래스를 추가
		  $(this).children('i').addClass('fa-solid').removeClass('fa-regular');
		  $(this).prevAll('span').children('i').addClass('fa-solid').removeClass('fa-regular');
		  
		  // 현재 클릭한 별 이후 모든 별에 fa-regular 클래스를 추가
		  $(this).nextAll('span').children('i').removeClass('fa-solid').addClass('fa-regular');
		  
		  // fa-solid 클래스를 가지는 i 요소의 개수 카운트
	      const gradeCount = $(".grade-input i.fa-solid").length;
	      console.log("fa-solid 클래스를 가진 i 태그의 개수: ", gradeCount);
	      
	      $("#grade").val(gradeCount);
		  });
        
      	  function reviewFormCheck(){
      		if($("#title").val()==""){
    			alert("제목을 입력하세요!");
    			return false; 
    	  	} 
    	  
    	  	if($("#content").val() == ""){
    			alert("내용을 입력하세요!");
    			return false; 
    	  	} 
    	  
    	 	 return true;
      	  } 
    	  //리뷰 등록
	     /*  $("input[value=등록]").click(function(){
	    	  event.preventDefault();
	    	  if($("#title").val()==""){
	    			alert("제목을 입력하세요!");
	    			return false; 
	    	  } 
	    	  const content = editorInstance.getData();
	    	  if(content === ""){
	    			alert("내용을 입력하세요!");
	    			return false; 
	    	  } 
	    	  
	    	  $("#content").val(content);
	    	  
	    	  //리뷰를 입력했을 때
	    	  var params = $("#reviewForm").serialize(); //데이터 준비
	    	  var url = "/seoulfloor/list/reWriteOk";
	    	  console.log(params);
	    	  
	    	  $.ajax({
					type :'POST',
					url : url,
					data : params,
					success : function(r){
						if(r=='1'){//리뷰 등록시
							alert("리뷰 등록에 성공하셨습니다!");
							console.log(r);
							window.open("", "_self").close();
							opener.location.href = "/seoulfloor/list/listView/${vo.no}"
			                //리뷰 목록 업데이트 해주기 일단 등록되는지부터 볼것
			            }else{//리뷰등록실패시
			                alert("리뷰 등록에 실패하셨습니다!");
			            }
			            console.log(r);
					},error : function(e){
						console.log(e.responseText);
					}
				})//리뷰작성 ajax끝	    	  
	      	})//리뷰작성 끝  */
	      
   
      });//jquery끝
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
				  <span value="1"><i class="fa-solid fa-star"></i></span>
				  <span value="2"><i class="fa-regular fa-star"></i></span>
				  <span value="3"><i class="fa-regular fa-star"></i></span>
				  <span value="4"><i class="fa-regular fa-star"></i></span>
				  <span value="5"><i class="fa-regular fa-star"></i></span>
        	</div>
            </div>
          </div>
        </div>
        <div class="form_div" style="position: relative;">
        	<form method="POST" id="reviewForm" action="/seoulfloor/list/reWriteOk" onsubmit="return reviewFormCheck()" >
        		<!-- 원글정보 -->
        		<input type=hidden name="Data_no" id="Data_no" value="${vo.no}">
        		<input type="hidden" name="grade" id="grade" value="1"/>
        		<input type="text" name="title" id="title" class="subject_input" placeholder="제목을 입력하세요">
        		<textarea name="content" id="content" placeholder="내용을 입력하세요"></textarea>
        		<input type="submit" class="write_review" value="등록"></input>
        	</form>
        </div>
      </div>
    </div>
  </body>
</html>
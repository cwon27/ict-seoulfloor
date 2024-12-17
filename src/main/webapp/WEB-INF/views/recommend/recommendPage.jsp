<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../../../inc/header2.jspf" %>

<link rel = "stylesheet" href = "/seoulfloor/css/recommandpage.css" type = "text/css"/>

<script>

// 데이터 배열

	const buttonData = [
	    { img: "img1.jpg", img2: "img6.jpg", value1: "1", value2: "2", id: "type_no", text1 : "힙", text2 : "전통" },
	    { img: "paid_img.png", img2: "free_img.png", value1: "유료", value2: "무료", id: "admission", text1 : "유료 축제", text2 : "무료 축제"  },
	    { img: "chk3_img1.jpg", img2: "chk3_img2.jpeg", value1: "desc", value2: "asc", id: "hit", text1 : "핫한 축제", text2 : "조용한 축제"  },
	    { img: "chk4_img1.jpg", img2: "chk4_img1.jpeg", value: "종료", id: "4" }
	];
let clickCounts = 0;

// 페이지 로드 시 버튼 생성
window.onload=function(){
	generateButtons();
}

function generateButtons() {
	var buttonsHtml = '';
	if(clickCounts == 3){
		buttonsHtml += '<div class="selectbutton" id="'+buttonData[clickCounts].id+'" value="'+buttonData[clickCounts].value+'" style="width: 60%;">';
		buttonsHtml += '  <button type="button" class = "btnFloat" onclick="changeBtnName(this)">';
		buttonsHtml += '     <img src="/seoulfloor/img/'+buttonData[clickCounts].img+'" alt="Image 1" style = "width : 100%; height : 100%"/>';
		buttonsHtml += '  </button>';
		buttonsHtml += '</div>';

	}else{
		// 버튼 생성    
		buttonsHtml += '<div class="selectbutton" id="'+buttonData[clickCounts].id+'" value="'+buttonData[clickCounts].value1+'">';
		buttonsHtml += '  <button type="button" class = "btnFloat" onclick="changeBtnName(this)">';
		buttonsHtml += '     <img src="/seoulfloor/img/'+buttonData[clickCounts].img+'" alt="Image 1" style = "width : 100%; height : 100%"/>';
		buttonsHtml += '     <div class = "btn_title">'+buttonData[clickCounts].text1+'</div>';
		buttonsHtml += '  </button>';
		buttonsHtml += '</div>';
		
		buttonsHtml += '<div class="selectbutton" id="'+buttonData[clickCounts].id+'" value="'+buttonData[clickCounts].value2+'">';
		buttonsHtml += '  <button type="button" class = "btnFloat" onclick="changeBtnName(this)">';
		buttonsHtml += '     <div class = "btn_title">'+buttonData[clickCounts].text2+'</div>';
		buttonsHtml += '     <img src="/seoulfloor/img/'+buttonData[clickCounts].img2+'" alt="Image 2" style = "width : 100%; height : 100%"/>';
		buttonsHtml += '  </button>';
		buttonsHtml += '</div>';
	}
	// console.log(buttonData[clickCounts]);
    // 버튼을 DOM에 추가합니다.
	document.getElementById('selectdiv').innerHTML = buttonsHtml;
    
	/// 부모 div의 스타일 변경
    var parentDiv = document.getElementById('selectdiv');
    var childCount = parentDiv.children.length;

    // 자식 요소가 1개일 경우 그리드 레이아웃과 가운데 정렬
    if (childCount === 1) {
        parentDiv.style.display = 'grid';
        parentDiv.style.gridTemplateColumns = '1fr';
        parentDiv.style.justifyItems = 'center';
    } else {
        parentDiv.style.gridTemplateColumns = 'repeat(2, 1fr)'; // 기존 두 개의 칼럼 설정
        parentDiv.style.justifyItems = 'stretch'; // 다시 기본 정렬로 되돌림
    }
    
    var line = "<ol>";
	    if(clickCounts == 3){
	    	for(var i = 0; i < 4 ;i++){
	    		line += "<li id = '2'> <div></div> </li>";
	    	}
	    } else{
	    	for(var i = 0; i < clickCounts; i++){
	    		line += "<li id = '2'> <div></div> </li>";
	    	}
	    	for(var i = 0; i < 4-clickCounts; i++){
	    		line += "<li> <div></div> </li>";
	    	}
	    }
	  line += "</ol>";
	  document.getElementById('timeline').innerHTML = line;
	  clickCounts++;
}

function changeBtnName(buttonElement) {
    const parentDiv = $(buttonElement).parent();
    const id = parentDiv.attr('id');
    const value = parentDiv.attr('value');
    // console.log(id, value);
    if (clickCounts == 4) {
        clickCounts = 0;
    }
    // 업데이트된 값을 서버로 전송합니다.
    sendValueToServer(id, value);
    
    generateButtons();
}
let data = {};
function sendValueToServer(id, value) {
	if(id == 4){
		data = {};
	}else{
		data[id] = value;
	}
	
    $.ajax({
        url: '${pageContext.request.contextPath}/recommend/showlist', // 서버의 URL을 여기에 입력하세요.
        type: 'GET',
        data: data,
        success: function(result) {
            // console.log('서버 응답:', result);
            var tag = "";
            for (var i = 0; i < result.length; i++) {
            tag += '<div class="item">';
            tag += '  <img src="'+result[i].img_url+'"  alt="이미지 없음" onerror="this.src=\'/seoulfloor/img/noimage.png\'" style = "width:100%; height:100%"/>';
            tag += '  <div class="caption">';
            tag += '    <h2>'+result[i].title+'</h2>';
            tag += '      <p>'+result[i].all_date+'</p>';
            tag += '    <p>'+ result[i].loc+'</p>';
            tag += '    <a href="/seoulfloor/list/listView/'+result[i].no+'">View details</a>';
            tag += '  </div>';
            tag += '</div>';
            }
            for(var i =0; i< 4-result.length; i++){
                tag += '<div class="item">';
                tag += '<p>해당하는 행사가 없습니다.</p>';
                tag += '</div>';
            }
            document.getElementById('view').innerHTML = tag;
        },
        error: function(error) {
            console.error('서버 오류:', error);
        }
    });
}
</script>


<div class = "container">
	<div class = "title">
		<h1>원하는 축제가 있나요?</h1>
	</div>
	<div class = "content">
		<div class = "selectdiv" id = "selectdiv">
		</div>
		<div class = "line">
			<section class="timeline" id="timeline">
			  <ol>
			    <li> <div></div> </li>
			    <li> <div></div> </li>
			    <li> <div></div> </li>
			    <li> <div></div> </li>
			  </ol>
			  </section>
		</div>
		<div class = "result">
			<h4> 추천 결과</h4>
		</div>
		<div class = "view" id = "view">

		</div>
	</div>
</div>

<%@include file="../../../inc/footer.jspf" %>
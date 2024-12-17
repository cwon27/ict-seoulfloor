
const seoulDistricts = [
    "종로구", "중구", "용산구", "성동구", "광진구",
    "동대문구", "중랑구", "성북구", "강북구", "도봉구",
    "노원구", "은평구", "서대문구", "마포구", "양천구",
    "강서구", "구로구", "금천구", "영등포구", "동작구",
    "관악구", "서초구", "강남구", "송파구", "강동구"
  ];
/* window.onload=function(){
   sendValueToServer();
} */

function sendValueToServer(num) {
    $.ajax({
        url: '/seoulfloor/list/filter', // 서버의 URL을 여기에 입력하세요.
        type: 'GET',
        data: { num: num },
        success: function(result) {
            console.log('서버 응답:', result);
           var tag = '<form id="filterForm">';
            tag += '    <div id ="period">';
            tag += '        <select title = "기간" id = "month">';
            tag += '            <option style="display:none" value = "" selected = "selected">기간</option>';
            for (var i = 1; i <= 12; i++) {
            tag += '            <option value = '+i+'>'+i+'월</option>';
            }
            tag += '        </select>';
           tag += '    </div>';
            tag += '    <div id ="searchArea">';
            tag += '        <select title = "지역" id = "loc">';
            tag += '            <option style="display:none" value = "" selected = "selected">지역</option>';
            for (var i = 0; i < seoulDistricts.length; i++){
            tag += '            <option value = '+seoulDistricts[i]+'>'+seoulDistricts[i]+'</option>';
            }
            tag += '        </select>';
           tag += '    </div>';
            tag += '    <div id ="searchCate">';
            tag += '        <select title = "카테고리" id = "type">';
            tag += '            <option style="display:none" value = "" selected = "selected">카테고리</option>';
            for (var i = 0; i < result.length; i++){
            tag += '            <option value = '+result[i]+'>'+result[i]+'</option>';    
            }
            tag += '        </select>';
           tag += '    </div>';
            tag += '    <div id ="resetandsubmit">';            
            tag += '        <button type = "reset">Reset</button>';
            tag += '        <button type = "submit">검색</button>';
            document.getElementById('filter').innerHTML = tag;
            
            document.getElementById('filterForm').addEventListener('submit', handleSubmit);
        },
        error: function(error) {
            console.error('서버 오류:', error);
        }
    });
    
}

function handleSubmit(event) {
    event.preventDefault();
   console.log("수신");
    // 선택된 값들 가져오기
    const month = document.getElementById('month').value;
    const loc = document.getElementById('loc').value;
    const type = document.getElementById('type').value;
   console.log(month, loc, type);
    // 선택된 값들로 데이터 객체 생성
    const data = {};
    if (month) data.month = month;
    if (loc) data.loc = loc;
    if (type) data.type = type;
   
   $.ajax({
   url: '/seoulfloor/list/filterlist',
   type: "POST",
   data : {"month" : month , "loc":loc, "type" : type},
   success: function(result) {
      console.log(result);
      var listItem = '<div class="row">';
	  for(var i = 0; i< result.length; i++){
      listItem += '<div class="col-md-3">';
      listItem += '  <a href="/seoulfloor/list/listView/' + result[i].no + '">';
      listItem += '    <div class="list-container">';
      listItem += '          <img src="'+ result[i].img_url +'" alt="' + result[i].title + '" />';
      listItem += '          <div class="res_inform">';
      listItem += '              <p>'+result[i].title+'</p>';
      listItem += '              <span>' + result[i].all_date + '</span>';
      listItem += '              <span> ' + result[i].loc +' '+ result[i].loc_detail + '</span>';
      listItem += '          </div>';
      listItem += '      </div>';
      listItem += '  </a>';
      listItem += '</div>';
      }
      listItem += '</div>';
     console.log(listItem);
    document.querySelector('.container').innerHTML = listItem;

   },
   error: function(error) {
      console.log(error);
   }
});
}

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@include file="../../../inc/header2.jspf" %>
<link rel="stylesheet" type="text/css" href="/seoulfloor/css/user/memberEdit.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>

function submitForm() {
  // 폼 제출 시뮬레이션 (실제 로직으로 교체 필요)
  const isSuccessful = true; // 성공 여부를 확인하는 로직으로 교체

  if (isSuccessful) {
    alert("수정완료했습니다 (Edit complete)");
    document.getElementById("saveButton").click(); // 숨겨진 버튼의 클릭 이벤트를 트리거
    window.location.href = "memberStamp.jsp"; // memberStamp 페이지로 리다이렉트
  } else {
    alert("수정 실패했습니다 (Edit failed)"); // 실패 시 경고
  }

  return false; // 필요에 따라 폼 제출을 수동으로 처리하려면 false 반환
}
</script>

<script>
window.onload = function() {
    document.getElementById('profileImageInput').addEventListener('change', function() {
        document.getElementById('uploadForm').submit();
    });
};
</script>


<script>
 // 우편번호 찾기(Daum API)
    //http://postcode.map.daum.net/guide   
    
    function daumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    /* 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr; */
                
                }/* else {
                    document.getElementById("sample6_extraAddress").value = '';
                } */

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("addr").value = addr;
           
            }
        }).open();
    }
</script>
<script>

	const userPwd = document.getElementById("userpwd").value;
	
	if (!userPwd || userPwd.length < 8 || !/[A-Z]/.test(userPwd) || !/[a-z]/.test(userPwd) || !/[0-9]/.test(userPwd) || !/[!@#$%^&*()_+\-=[\]{}|\\:;'<>,.?~]/.test(userPwd)) {
	  alert("비밀번호는 8자 이상, 영문 대소문자, 숫자, 특수문자를 포함해야 합니다.");
	  return false;
	}
	    // 비밀번호 확인
    const userPwd2 = document.getElementById("userpwd2").value;
    if (userPwd != userPwd2) {
        alert("비밀번호가 일치하지 않습니다.");
        return false;
    }
		
    // ... (기타 유효성 검사)

    return true;
}
    	
 </script> 
 

 
 <script>
  function submitForm() {
    // Simulate form submission (replace with actual logic)
    const isSuccessful = true; // Replace with logic to check for successful update

    if (isSuccessful) {
      alert("수정완료했습니다 (Edit complete)");
      window.location.href = "memberStamp.jsp"; // Redirect to memberStamp page
    } else {
      alert("수정 실패했습니다 (Edit failed)"); // Alert on failure
    }
  }
</script>



<div class= "controller" style="padding-top: 180px;">

    <h1>My page edit</h1>
    
    <div class="profile-image2">
		<img src="/seoulfloor/upload/${vo.user_img}" alt="Image Description" onerror="this.src='/seoulfloor/img/user.png'"/>
	</div>
	
    
   
	<form method="post" action="memberEdit" onsubmit="return submitForm()">
         <table class="signup-form">
         
        <tr style="padding: 10px">
             <td>Password</td>
             <td><input type="password" name="userpwd" id="userpwd"/></td>
        </tr>
         <tr>
             <td>Password confirm</td>
             <td><input type="password" name="userpwd2" id="userpwd2"/></td>
        </tr>
        <tr>
             <td>Nickname</td>
             <td><input type="text" name="usernick" id="usernick" value = "${vo.usernick}" /></td>
        </tr>
         <tr>
             <td>Address</td>
             <td><input type="text" name="addr" id = "addr" value = "${vo.addr}" onclick="daumPostcode()"/></td>
        </tr>
         <tr>
             <td>Tel</td>
             <td><input type="text" name="tel" id = "tel" value = "${vo.tel}"/></td>
        </tr>
          <tr>
             <td>Email</td>
             <td><input type="text" name="email" id = "email" value = "${vo.email}"/></td>
        </tr>
       <div class="profile-image-upload mt-3">
         <!-- 프로필 이미지 업로드 폼 -->
   		
	        <!-- 파일 선택을 위한 텍스트 -->
	
	         <label for="profileImageInput" class="upload-text" style="cursor: pointer; color:#fff; text-decoration: none; background-color: #104971; border-radius: 30px; padding: 10px 15px; font-size: 18px">
	            프로필 사진 변경하기
	        </label>
      
        
        <!-- 선택된 파일명을 표시할 영역 -->
        <span id="fileName"></span>
     </div>
        <tr>
            <td colspan="2"><input type="submit" value="Edit"/></td>
        </tr>

      </table>
      </form>
      <form action="${pageContext.request.contextPath}/user/uploadProfileImage" method="post" enctype="multipart/form-data" id="uploadForm">
     <!-- 숨겨진 파일 선택 입력 -->
	        <input type="file" name="profileImage" accept="image/*" id="profileImageInput" style="display: none;" />
     		<input type="hidden" name="delFile" value="${delFileValue}" />
     		<button type = "submit" style="display: none;">저장</button>
     </form>

</div>



<%@include file="../../../inc/footer.jspf" %>
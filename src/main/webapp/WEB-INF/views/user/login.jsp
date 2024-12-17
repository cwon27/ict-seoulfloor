<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="/seoulfloor/css/user/memberEdit.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<head>
<link rel="stylesheet" type="text/css" href="/seoulfloor/css/user/login.css">
</head>

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>
 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

   
      <script>
    function formCheck2(){

        // id 확인
        if(document.getElementById("userid2").value==""){
            alert("아이디 입력하세요");
            return false;
        }
        // password 확인
        if(document.querySelector("#userpwd3").value==""){
            alert("비밀번호를 입력하세요");
            return false;
        }
        return true;
    }
    </script>



<script>
  $( function() {
    $( "#datepicker" ).datepicker({
      changeMonth: true,
      changeYear: true
    });
  } );
  </script>


<script>
     window.onload = function(){
   let container = document.getElementById('container');
   
   toggle = () => {
     container.classList.toggle('sign-in');
     container.classList.toggle('sign-up');
   };
   
   setTimeout(() => {
     container.classList.add('sign-in');
   }, 200);
     }
   
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
   function formCheck() {
    // 아이디 유효성 검사
    const userId = document.getElementById("userid").value;
    if (!userId || userId.length < 5 || /[~!@#$%^&*()_+|]/g.test(userId)) {
        alert("아이디를 5자 이상으로 입력해주세요. 특수문자는 사용할 수 없습니다.");
        return false;
    }

    // 비밀번호 유효성 검사
    const userPwd = document.getElementById("userpwd").value;
    if (!userPwd || userPwd.length < 8 || !/[A-Z]/.test(userPwd) || !/[a-z]/.test(userPwd) || !/[0-9]/.test(userPwd)) {
        alert("비밀번호는 8자 이상, 영문 대소문자와 숫자를 포함해야 합니다.");
        return false;
    }

    // 비밀번호 확인
    const userPwd2 = document.getElementById("userpwd2").value;
    if (userPwd !== userPwd2) {
        alert("비밀번호가 일치하지 않습니다.");
        return false;
    }

    // ... (기타 유효성 검사)

    return true;
}
       
 </script>   
  
  <script>
  <script>
  function handleForgotPassword() {
      // 사용자에게 입력을 받기 위한 프롬프트 창을 열기
      var userId = prompt("Enter your user ID:");
      var email = prompt("Enter your email address:");
      var phone = prompt("Enter your phone number:");

      // 입력된 값들을 사용해 비밀번호를 찾는 로직 구현
      // 여기서는 단순히 입력값을 보여주는 예제
      if (userId && email && phone) {
          alert("Your password has been sent to your email address.");
      } else {
          alert("Please fill out all fields.");
      }
  }

  // 링크 클릭 시 handleForgotPassword 함수 호출
  document.addEventListener("DOMContentLoaded", function() {
      var forgotPasswordLink = document.querySelector('.forgot-password');
      if (forgotPasswordLink) {
          forgotPasswordLink.addEventListener('click', function(event) {
              event.preventDefault(); // 링크 기본 동작 방지
              handleForgotPassword();
          });
      }
  });
  </script>

 <script>
    function openPopup() {
        window.open('/seoulfloor/user/password/find', 'popupWindow', 'width=400,height=450');
        return false; // 링크의 기본 동작을 방지
    }
</script>





<div id="container" class="container">
    <!-- FORM SECTION -->
    <div class="row">
      <!-- SIGN UP -->
      <div class="col align-items-center flex-col sign-up">
        <div class="form-wrapper align-items-center">
          <div class="form sign-up">
            <form action="/seoulfloor/user/signOk" method="POST" onsubmit = "return formCheck();">
            <div class="input-group">
              <i class='bx bxs-user'></i>
              <input type="text" name = "userid" id = "userid" placeholder="Userid">
            </div>
              <div class="input-group">
              <i class='bx bxs-lock-alt'></i>
              <input type="password" name = "userpwd" id="userpwd" placeholder="Password">
            </div>            
            <div class="input-group">
              <i class='bx bxs-lock-alt'></i>
              <input type="password" name = "userpwd2" id="userpwd2" placeholder="Confirm password">
            </div>
            <div class="input-group">
              <i class='bx bxs-user'></i>
              <input type="text" name = "username" placeholder="Username">
            </div>
           <div class="input-group">
              <i class='bx bx-mail-send'></i>
              <input type="text" name = "email" placeholder="Email">
            </div>          
            <div class="input-group">
              <i class='bx bxs-user'></i>
              <input type="text" name = "usernick" placeholder="Nickname">
            </div>
            <div class="input-group">
              <i class='bx bxs-user'></i>
              <input type="text" name = "birth" placeholder="Birthday" id="datepicker">
            </div>
            <div class="input-group">
              <i class='bx bxs-user'></i>
              <input type="text" name = "addr" id="addr" placeholder="Address" onclick="daumPostcode()">
            </div><div class="input-group">
              <i class='bx bxs-user'></i>
              <input type="text" name = "tel" placeholder="Tel">
            </div>
         
            
             <button type="submit">Sign up</button>
         </form>
         
            <p>
              <span>
                Already have an account?
              </span>
              <b onclick="toggle()" class="pointer">
                Sign in here
              </b>
            </p>
          </div>
        </div>
      
      </div>
      <!-- END SIGN UP -->
      <!-- SIGN IN -->
      <div class="col align-items-center flex-col sign-in">
        <div class="form-wrapper align-items-center">
          <div class="form sign-in">
            <form action="/seoulfloor/user/loginOk" method="POST" onsubmit = "return formCheck2();">
            <div class="input-group">
              <i class='bx bxs-user'></i>
              <input type="text" name="userid" placeholder="Userid" id ="userid2">
            </div>
            <div class="input-group">
              <i class='bx bxs-lock-alt'></i>
              <input type="password" name="userpwd"  id="userpwd3" placeholder="Password">
            </div>

          <button type="submit">Sign in</button>
         </form>
           
            <p>
              <b>
            <a href="#" onclick="openPopup()" class="forgot-password">Forgot password?</a>
              </b>

            </p>
            <p>
              <span>
                Don't have an account?
              </span>
              <b onclick="toggle()" class="pointer">
                Sign up here
              </b>
            </p>
          </div>
        </div>
        <div class="form-wrapper">
    
        </div>
      </div>
      <!-- END SIGN IN -->
    </div>
    <!-- END FORM SECTION -->
    <!-- CONTENT SECTION -->
    <div class="row content-row">
      <!-- SIGN IN CONTENT -->
      <div class="col align-items-center flex-col">
        <div class="text sign-in">
          <h2>
            Welcome
          </h2>
  
        </div>
        <div class="img sign-in">
    
        </div>
      </div>
      <!-- END SIGN IN CONTENT -->
      <!-- SIGN UP CONTENT -->
      <div class="col align-items-center flex-col">
      
        <div class="img sign-up" >

        </div>
        <div class="text sign-up">
          <h2>
            Join with us
          </h2>
  
        </div>
      </div>
      <!-- END SIGN UP CONTENT -->
    </div>
    <!-- END CONTENT SECTION -->
  </div>
  

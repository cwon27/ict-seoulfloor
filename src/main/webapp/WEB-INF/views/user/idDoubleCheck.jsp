<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
		function idCheck(){
			if(document.getElementById('userid').value==''){
				alert("아이디를 입력후 중복검사하세요.");
				return false
			}
			return true;
		}
		function setUserid(){

			opener.document.getElementById("userid").value= '${userid}'
			opener.document.getElementById("chk").value='Y';
			 window.close();
		}
</script>
<div>
	<!-- 아이디 중복검사결과 -->
		<!-- 사용가능한 아이디 -->
	<c:if test="${result ==0 }">
		<b>${userid }</b>는 사용가능한 아이디 입니다.
		<input type="button" value="사용하기" onclick="setUserid()"/>
		</c:if>
<!-- 사용 불가능한 아이디 -->
	<c:if test="${result > 0 }">
	<div style='color:red'> ${userid }는 사용 불가능한 아이디 입니다.</div>

	</c:if>
	<hr/>

	<!--  새로운 아이디 중복검사 폼 만들기 -->
   <div>
      <form  method="get" action="/seoulfloor/user/idDoubleCheck" onsubmit = "idCheck()">
         아이디 입력 : <input type="text" name="userid" id="userid"/>
         <input type="submit" value="아이디 중복 검사하기"/>
      </form>
   </div>
</div>

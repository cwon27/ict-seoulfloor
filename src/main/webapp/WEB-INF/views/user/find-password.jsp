<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>비밀번호찾기</title>
<style>
 body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            align-items: center;
            height: 100vh;
            margin-left:20px;
        }
        .form-container {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }
   
        label {
            display: block;
            margin-bottom: 5px;
            text-align: left;
        }
        input[type="text"], input[type="email"] {
            width: 90%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            background-color: #000;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 96%;
            font-size: 16px;
        }
        button:hover {
            background-color: #333;
        }

</style>

</head>
<body>

  <h1 style="text-align: center;">Find Your Password</h1>
    <label for="userid">User ID:</label>
    <input type="text" id="userid" name="userid" required><br><br>
    
    <label for="email">Email Address:</label>
    <input type="email" id="email" name="email" required><br><br>
    
    <label for="tel">Phone Number:</label>
    <input type="text" id="tel" name="tel" required><br><br>
    
    <button type="submit" onclick = "submitForm();">Submit</button>

<script>
function submitForm() {
	var userid = document.getElementById("userid").value;
    var email = document.getElementById("email").value;
    var phone = document.getElementById("tel").value;
	console.log(userid, email, phone);
    if (userid && email && phone) {

        $.ajax({
            url: '/seoulfloor/user/findpassword',
            method: 'POST',
            data: {
            	userid: userid,
                email: email,
                tel: phone
            },
            success: function(data) {
            	if (data === "1") {
            		alert("일치하는 정보가 없습니다.");	
            	}else{
            		alert("비밀번호 : " + data);
            		close();
            	}

            },
            error: function(error) {
               
            }
        });

    } else {
        alert("빈칸을 다 채워주세요");
        return false; // Prevent the default form submission
    }
}
</script>

</body>
</html>
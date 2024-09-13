<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("utf-8");
%>
<%@ page import="kr.ac.mydog.member.dao.MemberDAO" %>
<%@ page import="kr.ac.mydog.member.vo.MemberVO" %>
<!DOCTYPE html>
<html>
<head>
<title>회원가입 폼</title>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
    function checkForm() {
        var userId = document.signupForm.userId.value;
        var userPassword = document.signupForm.userPassword.value;
        var userName = document.signupForm.userName.value;
        var birthDate = document.signupForm.birthDate.value;
        var phone = document.signupForm.phone.value;
        var post = document.signupForm.post.value;
        var basicAddr = document.signupForm.basicAddr.value;
        var detailAddr = document.signupForm.detailAddr.value;
        var userEmail = document.signupForm.userEmail.value;

        if (userId == "") {
            alert("아이디를 입력하지 않았습니다");
            document.signupForm.userId.focus();
            return false;
        }
        
        if (userPassword == "") {
            alert("비밀번호를 입력하지 않았습니다");
            document.signupForm.userPassword.focus();
            return false;
        }

        if (userName == "") {
            alert("이름을 입력하지 않았습니다");
            document.signupForm.userName.focus();
            return false;
        }

        if (birthDate == "") {
            alert("생일을 입력하지 않았습니다");
            document.signupForm.birthDate.focus();
            return false;
        }

        if (phone == "") {
            alert("전화번호를 입력하지 않았습니다");
            document.signupForm.phone.focus();
            return false;
        }

        if (post == "") {
            alert("우편번호를 입력하지 않았습니다");
            document.signupForm.post.focus();
            return false;
        }

        if (basicAddr == "") {
            alert("기본 주소를 입력하지 않았습니다");
            document.signupForm.basicAddr.focus();
            return false;
        }

        if (detailAddr == "") {
            alert("상세 주소를 입력하지 않았습니다");
            document.signupForm.detailAddr.focus();
            return false;
        }

        if (userEmail == "") {
            alert("이메일을 입력하지 않았습니다");
            document.signupForm.userEmail.focus();
            return false;
        }

        return true;
    }

    function checkUserId() {
        var userId = document.signupForm.userId.value;

        if (userId == "") {
            alert("아이디를 입력해주세요");
            document.signupForm.userId.focus();
            return false;
        }

        $.ajax({
            type: "POST",
            url: "checkUserId.ajax", /* ajax는 Controller로는 불가능하고 Servlet파일을 통해 작동한다. CheckUserIdServlet.java를통해 기능이 작동 */
            data: { userId: userId },
            success: function(response) {
                if (response == "available") {
                    document.getElementById("idCheckResult").innerHTML = "<span style='color: green;'>사용 가능한 아이디입니다.</span>";
                } else {
                    document.getElementById("idCheckResult").innerHTML = "<span style='color: red;'>이미 사용 중인 아이디입니다.</span>";
                }
            }
        });
    }

    function execDaumPostcode() { /* 다음 주소입력 api */
        new daum.Postcode({
            oncomplete: function(data) {
                document.signupForm.post.value = data.zonecode;
                document.signupForm.basicAddr.value = data.address;
                document.signupForm.detailAddr.focus();
            }
        }).open();
    }
</script>
<script src="/Shopping/resources/js/jquery-3.2.1.min.js"></script>
<script src="/Shopping/resources/styles/bootstrap4/popper.js"></script>
<script src="/Shopping/resources/styles/bootstrap4/bootstrap.min.js"></script>
<script src="/Shopping/resources/plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="/Shopping/resources/plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="/Shopping/resources/plugins/easing/easing.js"></script>
<script src="/Shopping/resources/plugins/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
<script src="/Shopping/resources/js/contact_custom.js"></script>
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/bootstrap4/bootstrap.min.css">
<link href="/Shopping/resources/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" href="/Shopping/resources/plugins/themify-icons/themify-icons.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/plugins/jquery-ui-1.12.1.custom/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/contact_styles.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/contact_responsive.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/login.css">
</head>
<body>
<div class="super_container">
	<jsp:include page="/include/topMenu.jsp"/>

	<div class="container contact_container">
		<div class="row">
			<div class="col">

				<!-- Breadcrumbs -->

				<div class="breadcrumbs d-flex flex-row align-items-center">
					<ul>
						<li><a href="index.html">Home</a></li>
						<li class="active"><a href="#"><i class="fa fa-angle-right" aria-hidden="true"></i>회원가입</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="row">
		    <div class="col">
		        <div class="form-container">    
		            <form action="signup.do" method="post" name="signupForm" onsubmit="return checkForm()">
		                <div>
		                    <label for="userId">ID</label>
		                    <input type="text" name="userId">
		                    <button type="button" class="id-check-button" onclick="checkUserId()">중복 체크</button>
		                    <span id="idCheckResult"></span>
		                </div>
		                <div>
		                    <label for="userPassword">Password</label>
		                    <input type="password" name="userPassword">
		                </div>
		                <div>
		                    <label for="userName">Name</label>
		                    <input type="text" name="userName">
		                </div>
		                <div>
		                    <label for="birthDate">Birth Date</label>
		                    <input type="date" name="birthDate">
		                </div>
		                <div>
		                    <label for="phone">Phone</label>
		                    <input type="text" name="phone">
		                </div>
		                <div>
		                    <label for="post">Post</label>
		                    <input type="text" name="post" readonly>
		                    <button type="button" class="postcode-button" onclick="execDaumPostcode()">우편번호 찾기</button>
		                </div>
		                <div>
		                    <label for="basicAddr">Basic Address</label>
		                    <input type="text" name="basicAddr" readonly>
		                </div>
		                <div>
		                    <label for="detailAddr">Detail Address</label>
		                    <input type="text" name="detailAddr">
		                </div>
		                <div>
		                    <label for="userEmail">Email</label>
		                    <input type="email" name="userEmail">
		                </div>
		                <button type="submit">회원가입</button>
		            </form>
		        </div>
		    </div>
		</div>

		<!-- Footer -->
		<footer class="footer">
			<jsp:include page="/include/footer.jsp"/>
		</footer>
	</div>
</div>
</body>
</html>


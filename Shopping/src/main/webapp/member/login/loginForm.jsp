<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% 
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="referrer" content="unsafe-url">
<title>마이독 - 로그인</title>
<script src="/Shopping/resources/styles/bootstrap4/popper.js"></script>
<script src="/Shopping/resources/plugins/Isotope/isotope.pkgd.min.js"></script>
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/bootstrap4/bootstrap.min.css">
<link href="/Shopping/resources/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" href="/Shopping/resources/plugins/themify-icons/themify-icons.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/plugins/jquery-ui-1.12.1.custom/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/contact_styles.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/contact_responsive.css">
<!-- <script type="text/javascript">
        function checkForm() {
            var userId = document.loginForm.userId.value;
            var userPassword = document.loginForm.userPassword.value;

            if (userId == "") {
                alert("아이디를 입력하지 않았습니다");
                document.loginForm.userId.focus();
                return false;
            }
            
            if (userPassword == "") {
                alert("비밀번호를 입력하지 않았습니다");
                document.loginForm.userPassword.focus();
                return false;
            }

            return true;
        }
	</script> -->
</head>
<body>
<div class="super_container">
	<!-- Header -->
	<jsp:include page="/include/topMenu.jsp"/>

	<div class="container contact_container">
		<div class="row">
			<div class="col">

				<!-- Breadcrumbs -->

				<div class="breadcrumbs d-flex flex-row align-items-center">
					<ul>
						<li><a href="index.html">Home</a></li>
						<li class="active"><a href="#"><i class="fa fa-angle-right" aria-hidden="true"></i>로그인</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col">
<!-- 				<form action="http://172.31.9.175:8080/loginForm" method="get">
					<input type="hidden" name="redirectUrl" value="http://172.31.9.168:8080/Shopping/index.jsp">
			        <button type="submit">Login with A Site</button>
				</form>  -->
 			    <form action="login.do" method="post" name="loginForm" onsubmit="return checkForm()">
				    <div style="margin-left: 50px;">
				        <div>ID</div>
				        <div><input type="text" name="userId"></div> <br>
				        <div>PASSWORD</div>
				        <div><input type="password" name="userPassword"></div>
				        <c:if test="${not empty requestScope.loginFailed}">
				            <div style="color: red;">아이디 또는 패스워드가 틀렸습니다</div>
				        </c:if>
				        <br>
				    </div>
			        <button type="submit" class="newsletter_submit_btn trans_300" style="width: 80px; margin-left: 50px;">로그인</button>
			    </form> 
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








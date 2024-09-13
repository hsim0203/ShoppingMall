<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>회원가입 성공</title>
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
		<div>
			<h2>회원가입 성공</h2>
		</div>
		<div>
			<p>회원가입이 성공적으로 완료되었습니다.</p>
		</div>
		<div>
			<a href="loginForm.do">로그인화면으로</a>
		</div>
		<footer class="footer">
			<jsp:include page="/include/footer.jsp"/>
		</footer>
	</div>
</div>
</body>
</html>

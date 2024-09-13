<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Colo Shop Template">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마이독-애견용품 쇼핑몰</title>
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
	<div class="container contact_container">
		<div class="row">
			<div class="col">

				<!-- Breadcrumbs -->

				<div class="breadcrumbs d-flex flex-row align-items-center">
					<ul>
						<li><a href="index.html">메인</a></li>
						<li class="active"><a href="#"><i class="fa fa-angle-right" aria-hidden="true"></i>마이페이지</a></li>
					</ul>
				</div>

			</div>
		</div>
		<div class="row">
			<div class="col">
				<jsp:include page="/include/topMenu.jsp" />
				<div class="container">
				    <div><p>아이디: ${user.id}</p></div>
				    <div><p>이름: ${user.name}</p></div>
				    <div><p>이메일: ${user.email}</p></div>
				    <div><p>전화번호: ${user.phone}</p></div>
				    <div><p>우편번호: ${user.post}</p></div>
				    <div><p>주소</p></div>
				    <div><p>${user.basicAddr}, ${user.detailAddr}</p></div>
				</div>
			</div>
		</div>
	</div>		
	<jsp:include page="/include/footer.jsp" />
</div>

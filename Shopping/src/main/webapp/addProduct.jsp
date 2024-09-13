<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/Shopping/resources/js/jquery-3.2.1.min.js"></script>
<script src="/Shopping/resources/styles/bootstrap4/popper.js"></script>
<script src="/Shopping/resources/styles/bootstrap4/bootstrap.min.js"></script>
<script src="/Shopping/resources/plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="/Shopping/resources/plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="/Shopping/resources/plugins/easing/easing.js"></script>
<script src="/Shopping/resources/plugins/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
<script src="/Shopping/resources/js/categories_custom.js"></script>
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/bootstrap4/bootstrap.min.css">
<link href="/Shopping/resources/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/cart_styles.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/cart_responsive.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/bootstrap4/bootstrap.min.css">
<link href="/Shopping/resources/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/plugins/jquery-ui-1.12.1.custom/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/categories_styles.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/categories_responsive.css">
</head>
<body>
<div class="super_container">

    <!-- Header -->
    <jsp:include page="/include/topMenu.jsp"/>
	<div class="container product_section_container">
		<div class="row">
			<div class="col product_section clearfix">

				<!-- Breadcrumbs -->

 				<div class="breadcrumbs d-flex flex-row align-items-center">
					<ul>
						<li><a href="mydog.do">HOME</a></li>
						<li><a href="categories.html"><i class="fa fa-angle-right" aria-hidden="true"></i></a></li>
					</ul>
				</div>
				    <div class="container">
				        <h2>상품 추가</h2>
				        <form action="addProduct.do" method="post">
				            <div>
				                <label for="productCode">상품 코드</label>
				                <input type="text" id="productCode" name="productCode" required>
				            </div>
				            <div>
				                <label for="productName">상품명</label>
				                <input type="text" id="productName" name="productName" required>
				            </div>
				            <div>
				                <label for="productPrice">가격</label>
				                <input type="number" id="productPrice" name="productPrice" required>
				            </div>
				            <div>
				                <label for="productStock">재고 수량</label>
				                <input type="number" id="productStock" name="productStock" required>
				            </div>
				            <div>
				                <label for="productDetail">상품 설명</label>
				                <textarea id="productDetail" name="productDetail" required></textarea>
				            </div>
				            <div>
				                <label for="categoryCode">카테고리 코드</label>
				                <input type="text" id="categoryCode" name="categoryCode" required>
				            </div>
				            <div>
				            <div>
				                <label for="imgLink1">이미지 링크 1</label>
				                <input type="text" id="imgLink1" name="imgLink1" required>
				            </div>
				            <div>
				                <label for="imgLink2">이미지 링크 2</label>
				                <input type="text" id="imgLink2" name="imgLink2">
				            </div>
				            <button type="submit">상품 추가</button>
				        </form>
				    </div>
				</div>
			</div>
		</div>
	<!-- Footer -->
    <footer class="footer">
        <jsp:include page="/include/footer.jsp"/>
    </footer>
	</div>				    
</body>
</html>
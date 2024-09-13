<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="kr.ac.mydog.member.vo.MemberVO" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
	System.out.println(request.getAttribute("shopCategories"));
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Colo Shop Template">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마이독 - 애견용품 쇼핑몰</title>
<script src="/Shopping/resources/js/jquery-3.2.1.min.js"></script>
<script src="/Shopping/resources/styles/bootstrap4/popper.js"></script>
<script src="/Shopping/resources/styles/bootstrap4/bootstrap.min.js"></script>
<script src="/Shopping/resources/plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="/Shopping/resources/plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="/Shopping/resources/plugins/easing/easing.js"></script>
<script src="/Shopping/resources/plugins/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
<script src="/Shopping/resources/js/categories_custom.js"></script>

<style>
    .category-item {
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    .subcategories {
/*         display: none; /* 기본적으로 하위 카테고리는 숨김 */ */
        margin-left: 20px;
    }
    .fa-angle-down {
        cursor: pointer;
    }
</style>
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

				<!-- Sidebar -->
<%-- 				<jsp:include page="/include/sidebar.jsp"/>  --%>
				<div class="sidebar">
					<div class="sidebar_section">
						<div class="sidebar_title">
							<a href="categories.do"><h5>카테고리</h5></a>
						</div>
						<ul class="sidebar_categories">
							<li class="category-item">
								<i class="fa fa-angle-down" aria-hidden="true"></i><a href="categories.do?categoriCode=100">사료</a>
								<div>
								<ul class="subcategories">
				                    <li><a href="categories.do?categoriCode=10001">건식사료</a></li>
				                    <li><a href="categories.do?categoriCode=10002">습식사료</a></li>
				                    <li><a href="categories.do?categoriCode=10003">우유/분유</a></li>
				                    <li><a href="categories.do?categoriCode=10004">영양제</a></li>
				                </ul> 
								</div>
							</li>		
							<li class="category-item">
								<i class="fa fa-angle-down" aria-hidden="true"></i><a href="categories.do?categoriCode=101">간식</a>
							</li>
							<li class="category-item">
								<i class="fa fa-angle-down" aria-hidden="true"></i><a href="categories.do?categoriCode=102">위생용품</a>
							</li>
							<li class="category-item">
								<i class="fa fa-angle-down" aria-hidden="true"></i><a href="categories.do?categoriCode=103">미용용품</a>
							</li>
							<li class="category-item">
								<i class="fa fa-angle-down" aria-hidden="true"></i><a href="categories.do?categoriCode=104">식 기</a>
							</li>
							<li class="category-item">
								<i class="fa fa-angle-down" aria-hidden="true"></i><a href="categories.do?categoriCode=105">외출용품</a>
							</li>
							<li class="category-item">
								<i class="fa fa-angle-down" aria-hidden="true"></i><a href="categories.do?categoriCode=106">장난감</a>
							</li>
							<li class="category-item">
								<i class="fa fa-angle-down" aria-hidden="true"></i><a href="categories.do?categoriCode=107">안전용품</a>
							</li>
							
						</ul>
					</div>
				</div>
				<!-- Main Content -->

				<div class="main_content">

					<!-- Products -->

					<div class="products_iso">
						<div class="row">
							<div class="col">
							<% 
					            MemberVO user = (MemberVO) session.getAttribute("user");
					            if (user != null && "A".equals(user.getAdmin())) {
					        %>
							<div><a href="addproductForm.do">상품추가</a></div>
					        <% 
					            }
					        %>
								<!-- Product Sorting -->

								<!-- <div class="product_sorting_container product_sorting_container_top">
									<ul class="product_sorting">
										<li>
											<span class="type_sorting_text">Default Sorting</span>
											<i class="fa fa-angle-down"></i>
											<ul class="sorting_type">
												<li class="type_sorting_btn" data-isotope-option='{ "sortBy": "original-order" }'><span>Default Sorting</span></li>
												<li class="type_sorting_btn" data-isotope-option='{ "sortBy": "price" }'><span>Price</span></li>
												<li class="type_sorting_btn" data-isotope-option='{ "sortBy": "name" }'><span>Product Name</span></li>
											</ul>
										</li>
										<li>
											<span>Show</span>
											<span class="num_sorting_text">6</span>
											<i class="fa fa-angle-down"></i>
											<ul class="sorting_num">
												<li class="num_sorting_btn"><span>6</span></li>
												<li class="num_sorting_btn"><span>12</span></li>
												<li class="num_sorting_btn"><span>24</span></li>
											</ul>
										</li>
									</ul>
									<div class="pages d-flex flex-row align-items-center">
										<div class="page_current">
											<span>1</span>
											<ul class="page_selection">
												<li><a href="#">1</a></li>
												<li><a href="#">2</a></li>
												<li><a href="#">3</a></li>
											</ul>
										</div>
										<div class="page_total"><span>of</span> 3</div>
										<div id="next_page" class="page_next"><a href="#"><i class="fa fa-long-arrow-right" aria-hidden="true"></i></a></div>
									</div>

								</div> -->

								<!-- Product Grid -->

								<div class="product-grid">

									<!-- Product 1 -->
									<c:forEach items="${ requestScope.shopCategories }" var="categories">
									<div class="product-item men">
										<div class="product discount product_filter">
											<div class="product_image">
												<img src="${ categories.imgLink }" alt="">
											</div>
											<div class="favorite favorite_left"></div>
											<!-- <div class="product_bubble product_bubble_right product_bubble_red d-flex flex-column align-items-center"><span>-$20</span></div> -->
											<div class="product_info">
												<h6 class="product_name"><a href="single.do?productCode=${ categories.productCode }">${ categories.productName }</a></h6>
												<div class="product_price">&#8361;${ categories.productPrice }</div>
											</div>
										</div>
										<div class="red_button add_to_cart_button"><a href="single.do?productCode=${ categories.productCode }">상세정보</a></div>
									</div>
									</c:forEach>									

									<div class="product_info">
									</div>
								</div>

								<!-- Product Sorting -->
								<div class="product_sorting_container product_sorting_container_bottom clearfix">
									<ul class="product_sorting">
										<li>
											<span>Show:</span>
											<span class="num_sorting_text">04</span>
											<i class="fa fa-angle-down"></i>
											<ul class="sorting_num">
												<li class="num_sorting_btn"><span>01</span></li>
												<li class="num_sorting_btn"><span>02</span></li>
												<li class="num_sorting_btn"><span>03</span></li>
												<li class="num_sorting_btn"><span>04</span></li>
											</ul>
										</li>
									</ul>
									<span class="showing_results">Showing 1–3 of 12 results</span>
									<div class="pages d-flex flex-row align-items-center">
										<div class="page_current">
											<span>1</span>
											<ul class="page_selection">
												<li><a href="#">1</a></li>
												<li><a href="#">2</a></li>
												<li><a href="#">3</a></li>
											</ul>
										</div>
										<div class="page_total"><span>of</span> 3</div>
										<div id="next_page_1" class="page_next"><a href="#"><i class="fa fa-long-arrow-right" aria-hidden="true"></i></a></div>
									</div>

								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Benefit -->

	<div class="benefit">
		<div class="container">
			<div class="row benefit_row">
				<div class="col-lg-3 benefit_col">
					<div class="benefit_item d-flex flex-row align-items-center">
						<div class="benefit_icon"><i class="fa fa-truck" aria-hidden="true"></i></div>
						<div class="benefit_content">
							<h6>free shipping</h6>
							<p>Suffered Alteration in Some Form</p>
						</div>
					</div>
				</div>
				<div class="col-lg-3 benefit_col">
					<div class="benefit_item d-flex flex-row align-items-center">
						<div class="benefit_icon"><i class="fa fa-money" aria-hidden="true"></i></div>
						<div class="benefit_content">
							<h6>cach on delivery</h6>
							<p>The Internet Tend To Repeat</p>
						</div>
					</div>
				</div>
				<div class="col-lg-3 benefit_col">
					<div class="benefit_item d-flex flex-row align-items-center">
						<div class="benefit_icon"><i class="fa fa-undo" aria-hidden="true"></i></div>
						<div class="benefit_content">
							<h6>45 days return</h6>
							<p>Making it Look Like Readable</p>
						</div>
					</div>
				</div>
				<div class="col-lg-3 benefit_col">
					<div class="benefit_item d-flex flex-row align-items-center">
						<div class="benefit_icon"><i class="fa fa-clock-o" aria-hidden="true"></i></div>
						<div class="benefit_content">
							<h6>opening all week</h6>
							<p>8AM - 09PM</p>
						</div>
					</div>
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

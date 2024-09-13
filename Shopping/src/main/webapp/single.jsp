<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="kr.ac.mydog.member.vo.MemberVO" %>
<%
	// 세션에서 user 속성을 가져와 로그인 여부를 확인합니다.
    MemberVO user = (MemberVO) session.getAttribute("user");
    boolean isLoggedIn = (user != null);
	
	// AddCartController에서 설정한 message 속성을 가져옵니다.
	String message = (String) request.getAttribute("message");
%>
<%
    System.out.println(request.getAttribute("productDetail"));
    System.out.println(request.getAttribute("productDetailImg"));
    System.out.println(request.getAttribute("reviews"));
    System.out.println(request.getAttribute("isLoggedIn"));
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Colo Shop Template">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마이독 - ${ productDetail.productName } </title>
<script src="/Shopping/resources/js/jquery-3.2.1.min.js"></script>
<script src="/Shopping/resources/styles/bootstrap4/popper.js"></script>
<script src="/Shopping/resources/styles/bootstrap4/bootstrap.min.js"></script>
<script src="/Shopping/resources/plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="/Shopping/resources/plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="/Shopping/resources/plugins/easing/easing.js"></script>
<script src="/Shopping/resources/plugins/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
<script src="/Shopping/resources/js/single_custom.js"></script>
<script>
	document.addEventListener('DOMContentLoaded', (event) => {
        const minusButton = document.querySelector('.minus');
        const plusButton = document.querySelector('.plus');
        const quantityInput = document.getElementById('quantity_value');
        const totalPriceSpan = document.getElementById('total_price');
        const unitPrice = parseInt('${ productDetail.productPrice }');
        const productStock = parseInt('${ productDetail.productStock }');
        
        function updateTotalPrice() {
            let quantity = parseInt(quantityInput.value);
            let totalPrice = unitPrice * quantity;
            totalPriceSpan.innerText = totalPrice.toLocaleString();
        }

        minusButton.addEventListener('click', () => {
            let currentValue = parseInt(quantityInput.value);
            if (currentValue > 1) {
                quantityInput.value = currentValue - 1;
                updateTotalPrice();
            }
        });

        plusButton.addEventListener('click', () => {
            let currentValue = parseInt(quantityInput.value);
            if (currentValue < productStock) {
                quantityInput.value = currentValue + 1;
                updateTotalPrice();
            } else {
                alert('재고 수량을 초과할 수 없습니다.');
            }
        });

        quantityInput.addEventListener('input', () => {
            let value = parseInt(quantityInput.value);
            if (isNaN(value) || value < 1) {
                quantityInput.value = 1;
            } else if (value > productStock) {
                alert('재고 수량을 초과할 수 없습니다.');
                quantityInput.value = productStock;
            }
            updateTotalPrice();
        });

        updateTotalPrice();
    
        document.querySelector('.add_to_cart_button').addEventListener('click', function(event) {
		    if (!<%= isLoggedIn %>) {
		        event.preventDefault();
		        if (confirm('로그인이 필요한 기능입니다. 로그인 페이지로 이동하시겠습니까?')) {
		            window.location.href = 'loginForm.do';
		        }
		    }
		});
	
	    <% if (message != null) { %>
	    alert('<%= message %>');
	    <% } %>
	});
</script>
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/bootstrap4/bootstrap.min.css">
<link href="/Shopping/resources/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" href="/Shopping/resources/plugins/themify-icons/themify-icons.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/plugins/jquery-ui-1.12.1.custom/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/single_styles.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/single_responsive.css">
</head>

<body>

<div class="super_container">

    <!-- Header -->
    <jsp:include page="/include/topMenu.jsp"/>

    <div class="container single_product_container">
        <div class="row">
            <div class="col">

                <!-- Breadcrumbs -->

                <div class="breadcrumbs d-flex flex-row align-items-center">
                    <ul>
                        <li><a href="mydog.do">Home</a></li>
                        <li class="active"><a href="categories.do?categoriCode=${ productDetail.categoriCode } "><i class="fa fa-angle-right" aria-hidden="true"></i>${ productDetail.categoriName }</a></li>
                    </ul>
                </div>

            </div>
        </div>

        <div class="row">
            <div class="col-lg-7">
                <div class="single_product_pics">
                    <div class="row">
                        <div class="col-lg-3 thumbnails_col order-lg-1 order-2">
                            <div class="single_product_thumbnails">
                                <ul>
                                    <li><img src="${ productDetail.imgLink }" alt="" data-image="${ productDetail.imgLink }"></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-9 image_col order-lg-2 order-1">
                            <div class="single_product_image">
                                <div class="single_product_image_background" style="background-image:url(${ productDetail.imgLink })"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-5">
                <div class="product_details">
                    <div class="product_details_title">
                        <h2>${ productDetail.productName }</h2>
                    </div>
                    <div style="height:50px; "></div>
                    <div class="free_delivery d-flex flex-row align-items-center justify-content-center">
                        <span class="ti-truck"></span><span>free delivery</span>
                    </div>
                    <div class="product_price">&#8361;<span id="total_price">${ productDetail.productPrice }</span></div>
                    <div class="product_stock">남은 수량 : ${ productDetail.productStock }</div>
                    <form action="addcart.do" method="post">
					    <input type="hidden" name="productCode" value="${ productDetail.productCode }">
					    <input type="hidden" name="productPrice" value="${ productDetail.productPrice }">
					    <div class="quantity d-flex flex-column flex-sm-row align-items-sm-center">
					        <span>수량:</span>
					        <div class="quantity_selector">
					            <span class="minus"><i class="fa fa-minus" aria-hidden="true"></i></span>
					            <input type="number" id="quantity_value" name="quantity" value="1" min="1" max="${ productDetail.productStock }" style="width: 50px; text-align: center;">
					            <span class="plus"><i class="fa fa-plus" aria-hidden="true"></i></span>
					        </div>
					        <div><button class="red_button add_to_cart_button" type="submit" style="border: none;">장바구니에 추가</button></div>
					        <div class="product_favorite d-flex flex-column align-items-center justify-content-center"></div>
					    </div>
					</form>
                </div>
            </div>
        </div>

    </div>

    <!-- Tabs -->

    <div class="tabs_section_container">

        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="tabs_container">
                        <ul class="tabs d-flex flex-sm-row flex-column align-items-left align-items-md-center justify-content-center">
                            <li class="tab active" data-active-tab="tab_1"><span>제품설명</span></li>
                            <li class="tab" data-active-tab="tab_2"><span>상세 정보</span></li>
                            <li class="tab" data-active-tab="tab_3"><span>리뷰</span></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col">

                    <!-- Tab Description -->

                    <div id="tab_1" class="tab_container active">
                        <div class="row">
                            <div class="col-lg-5 desc_col">
                                <div class="tab_title">
                                    <h4>제품설명</h4>
                                </div>
                            </div>
                            <div>
                                <img src="${ productDetailImg.imgLink }" style="position:relative; display:inline-block;align-content: center; width: 1140px;">
                            </div>    
                        </div>
                    </div>

                    <!-- Tab Additional Info -->

                    <div id="tab_2" class="tab_container">
                        <div class="row">
                            <div class="col additional_info_col">
                                <div class="tab_title additional_info_title">
                                    <h4>제품 상세정보</h4>
                                </div>
                                <p>${ productDetail.productDetail }</p>
                            </div>
                        </div>
                    </div>

                    <!-- Tab Reviews -->

                    <div id="tab_3" class="tab_container">
                        <div class="row">

                            <!-- User Reviews -->

                            <div class="col-lg-6 reviews_col">
                                <div class="tab_title reviews_title">
                                    <h4>Reviews</h4>
                                </div>

                                <!-- User Review -->
								<c:forEach var="review" items="${reviews}">
	                                <div class="user_review_container d-flex flex-column flex-sm-row">
	<!--                                     <div class="user">
	                                        <div class="user_pic"></div>
	                                        <div class="user_rating">
	                                            <ul class="star_rating">
	                                                <li><i class="fa fa-star" aria-hidden="true"></i></li>
	                                                <li><i class="fa fa-star" aria-hidden="true"></i></li>
	                                                <li><i class="fa fa-star" aria-hidden="true"></i></li>
	                                                <li><i class="fa fa-star" aria-hidden="true"></i></li>
	                                                <li><i class="fa fa-star-o" aria-hidden="true"></i></li>
	                                            </ul>
	                                        </div>
	                                    </div> -->
	                                    <div class="review">
	                                        <div class="review_date">${review.rRegDate}</div>
	                                        <div class="user_name">${review.userId}</div>
	                                        <p>${review.rComment}</p>
	                                        <p>${review.rating}</p>
	                                    </div>
	                                </div>
                                </c:forEach>

                                <!-- User Review -->
<!-- 	
                                <div class="user_review_container d-flex flex-column flex-sm-row">
                                    <div class="user">
                                        <div class="user_pic"></div>
                                        <div class="user_rating">
                                            <ul class="star_rating">
                                                <li><i class="fa fa-star" aria-hidden="true"></i></li>
                                                <li><i class="fa fa-star" aria-hidden="true"></i></li>
                                                <li><i class="fa fa-star" aria-hidden="true"></i></li>
                                                <li><i class="fa fa-star" aria-hidden="true"></i></li>
                                                <li><i class="fa fa-star-o" aria-hidden="true"></i></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="review">
                                        <div class="review_date">27 Aug 2016</div>
                                        <div class="user_name">Brandon William</div>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
                                    </div>
                                </div>
                            </div>
 -->
                            <!-- Add Review -->

                            <div class="col-lg-6 add_review_col">

                                <div class="add_review">
                                    <form id="review_form" action="addreview.do" method="post">
                                         <div>
                                            <h1>Add Review</h1>
                                            <input id="review_name" class="form_input input_name" type="text" name="name" placeholder="Name*" required="required" data-error="Name is required.">
                                            <!-- <input id="review_email" class="form_input input_email" type="email" name="email" placeholder="Email*" required="required" data-error="Valid email is required."> -->
                                        </div> 
										<div>
											<h1>Your Rating:</h1>
											<ul class="user_star_rating">
												<li><i class="fa fa-star" aria-hidden="true"></i></li>
												<li><i class="fa fa-star" aria-hidden="true"></i></li>
												<li><i class="fa fa-star" aria-hidden="true"></i></li>
												<li><i class="fa fa-star" aria-hidden="true"></i></li>
												<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
											</ul>
											<textarea id="review_message" class="input_review" name="message"  placeholder="Your Review" rows="4" required data-error="Please, leave us a review."></textarea>
										</div> 
										<div class="text-left text-sm-right">
											<button id="review_submit" type="submit" class="red_button review_submit_btn trans_300" value="Submit">submit</button>
										</div> 
									</form>
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

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이독 - 내 장바구니</title>
<script src="/Shopping/resources/styles/bootstrap4/popper.js"></script>
<script src="/Shopping/resources/plugins/Isotope/isotope.pkgd.min.js"></script>
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/bootstrap4/bootstrap.min.css">
<link href="/Shopping/resources/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/bootstrap4/bootstrap.min.css">
<link href="/Shopping/resources/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/categories_styles.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/categories_responsive.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/cart.css">
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
			    <div class="cart_section">
			        <div class="container">
			            <div class="row">
			                <div class="col">
			                    <div class="cart_container">
			                    	<c:set var="totalPrice" value="0" />
			                        <div class="cart_title">장바구니</div>
										<form action="delcart.do" method="post" id="cartForm">
				                            <div class="cart_items">
				                                <ul class="cart_list">
				                                    <c:forEach var="cart" items="${cartList}">
				                                        <li class="cart_item clearfix">
				                                        	<div class="cart_item_checkbox">
				                                                <input type="checkbox" name="selectedProducts" value="${cart.productCode}">
				                                            </div>
				                                            <div class="cart_item_image"><img src="${cart.productImage}" alt=""></div>
				                                            <div class="cart_item_info d-flex flex-md-row flex-column justify-content-between">
				                                                <div class="cart_item_name cart_info_col">
				                                                    <div class="cart_item_title">상품명</div>
				                                                    <div class="cart_item_text"><a href="single.do?productCode=${ cart.productCode }">${cart.productName}</a></div>
				                                                </div>
				                                                <div class="cart_item_quantity cart_info_col">
				                                                    <div class="cart_item_title">수량</div>
				                                                    <div class="cart_item_text">${cart.quantity}</div>
				                                                </div>
				                                                <div class="cart_item_price cart_info_col">
				                                                    <div class="cart_item_title">가격</div>
				                                                    <div class="cart_item_text"><fmt:formatNumber value="${cart.cartPrice}" type="currency"/></div>
				                                                </div>
				                                                <div class="cart_item_total cart_info_col">
				                                                    <div class="cart_item_title">총합</div>
				                                                    <div class="cart_item_text"><fmt:formatNumber value="${cart.cartPrice * cart.quantity}" type="currency"/></div>
				                                                </div>
				                                            </div>
				                                        </li>
				                                        <c:set var="totalPrice" value="${totalPrice + (cart.cartPrice * cart.quantity)}" />
				                                    </c:forEach>
				                                </ul>
				                            </div>
				                            <br>
				                            <div class="order_total">
				                                <div class="order_total_content text-md-right">
				                                    <div class="order_total_title">장바구니에 담긴 상품 가격 총합:</div>
				                                    <div class="order_total_amount">
				                                    	<div class="order_total_amount"><fmt:formatNumber value="${totalPrice}" type="currency"/></div>
				                                        <%-- <c:forEach var="cart" items="${cartList}">
				                                            ${cart.cartPrice * cart.quantity}
				                                        </c:forEach> --%>
				                                    </div>
				                                </div>
				                            </div>
				                            <div class="cart_buttons">
				                                <button type="submit" class="button cart_button_clear">선택 항목 삭제</button>
				                                <button type="button" class="button cart_button_checkout" id="checkoutButton">선택 항목 주문</button>
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
    <!-- Footer -->
    <footer class="footer">
        <jsp:include page="/include/footer.jsp"/>
    </footer>

</div>
<script>
    document.getElementById('checkoutButton').addEventListener('click', function() {
        document.getElementById('cartForm').action = 'orderform.do';
        document.getElementById('cartForm').submit();
    });
</script>
</body>
</html>

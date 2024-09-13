<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>주문 내역</title>
<script src="/Shopping/resources/styles/bootstrap4/popper.js"></script>
<script src="/Shopping/resources/plugins/Isotope/isotope.pkgd.min.js"></script>
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/bootstrap4/bootstrap.min.css">
<link href="/Shopping/resources/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/bootstrap4/bootstrap.min.css">
<link href="/Shopping/resources/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/categories_styles.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/categories_responsive.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/orderList.css">
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

                <div class="order_list_container">
                    <h1>주문 내역</h1>
                    <div class="order_list">
                        <c:forEach var="order" items="${orderList}">
                            <a href="orderdetail.do?userId=${order.userId}&orderNo=${order.orderNo}">
                            <div class="order_item">
	                                <div class="order_no">주문 번호: ${order.orderNo}</div>
	                                <div class="order_status">주문 상태: ${order.status}</div>
	                                <div class="order_total">총 가격: <fmt:formatNumber value="${order.totalAmount}" type="currency"/></div>
	                                <div class="order_date">주문 날짜: ${order.orderRegDate}</div>
	                                <div class="order_address">배송 주소: ${order.orderAddress}</div>
	                            </div>
                            </a>
                        </c:forEach>
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

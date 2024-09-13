<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.List" %>
<%@ page import="kr.ac.mydog.order.vo.OrderDetailVO" %>

<%
    // 세션에서 사용자 정보를 가져옵니다.
    List<OrderDetailVO> orderDetails = (List<OrderDetailVO>) request.getAttribute("orderDetails");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이독 - 주문 상세 내역</title>
<script src="/Shopping/resources/js/jquery-3.2.1.min.js"></script>
<script src="/Shopping/resources/styles/bootstrap4/popper.js"></script>
<script src="/Shopping/resources/plugins/Isotope/isotope.pkgd.min.js"></script>
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/bootstrap4/bootstrap.min.css">
<link href="/Shopping/resources/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/bootstrap4/bootstrap.min.css">
<link href="/Shopping/resources/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/categories_styles.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/categories_responsive.css">
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
    }
    .order_details_container {
        width: 80%;
        margin: 100px auto 50px auto;
        background-color: #fff;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        border-radius: 8px;
        padding: 20px;
    }
    .order_details_section {
        margin-bottom: 30px;
    }
    .order_details_section h2 {
        margin-bottom: 20px;
        font-size: 24px;
        border-bottom: 2px solid #007bff;
        padding-bottom: 10px;
    }
    .order_details_item {
        display: grid;
        grid-template-columns: 3fr 1fr 1fr 1fr;
        align-items: center;
        padding: 10px 0;
        border-bottom: 1px solid #ddd;
    }
    .order_details_item div {
        text-align: center;
        padding: 5px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .order_details_item div.product_name {
        text-align: left;
    }
    .btn-primary {
        background-color: #007bff;
        border: none;
        padding: 12px 20px;
        font-size: 18px;
        color: #fff;
        cursor: pointer;
        border-radius: 5px;
        transition: background-color 0.3s;
        display: block;
        width: 100%;
        text-align: center;
    }
    .btn-primary:hover {
        background-color: #0056b3;
    }
</style>
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

    <div class="container order_details_container">
        <div class="order_details_section">
            <h2>주문 상세 내역</h2>
            <div class="order_details_item">
                <div class="product_name">상품명</div>
                <div class="quantity">수량</div>
<!--                 <div class="discount">할인</div> -->
                <div class="price">가격</div>
            </div>
            <c:forEach var="orderDetail" items="${orderDetails}">
                <div class="order_details_item">
                    <div class="product_name">${orderDetail.productName}</div>
                    <div class="quantity">${orderDetail.quantity}</div>
<%--                     <div class="discount">
                        <c:choose>
                            <c:when test="${ user.grade == 'S'}">5%</c:when>
                            <c:when test="${ user.grade == 'G'}">10%</c:when>
                            <c:otherwise></c:otherwise>            
                        </c:choose>
                    </div> --%>
                    <div class="price"><fmt:formatNumber value="${orderDetail.price}" type="currency"/></div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <jsp:include page="/include/footer.jsp"/>
    </footer>
</div>

</body>
</html>

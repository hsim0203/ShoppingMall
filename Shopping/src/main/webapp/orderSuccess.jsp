<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="kr.ac.mydog.order.vo.OrderVO" %>
<%@ page import="kr.ac.mydog.order.vo.OrderDetailVO" %>
<%@ page import="java.util.List" %>

<%
    // 주문 정보와 주문 상세 정보 가져오기
    OrderVO order = (OrderVO) request.getAttribute("order");
    List<OrderDetailVO> orderDetails = (List<OrderDetailVO>) request.getAttribute("orderDetails");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>주문 완료 - 마이독</title>
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/bootstrap4/bootstrap.min.css">
<link href="/Shopping/resources/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/categories_styles.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/categories_responsive.css">
<style>
    .order_success_container {
        width: 80%;
        margin: 100px auto;
        background-color: #fff;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        border-radius: 8px;
        padding: 20px;
    }
    .order_success_section {
        margin-bottom: 30px;
    }
    .order_success_section h2 {
        margin-bottom: 20px;
        font-size: 24px;
        border-bottom: 2px solid #007bff;
        padding-bottom: 10px;
    }
    .order_success_item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 0;
        border-bottom: 1px solid #ddd;
    }
    .order_success_item div {
        flex: 1;
        text-align: center;
    }
    .order_success_total {
        text-align: right;
        font-size: 20px;
        margin-top: 20px;
        color: #007bff;
        font-weight: bold;
    }
    .order_success_total strong {
        color: #000;
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

    <div class="container order_success_container">
        <!-- 주문 정보 섹션 -->
        <div class="order_success_section">
            <h2>주문 정보</h2>
            <div><strong>주문 번호:</strong> ${order.orderNo}</div>
            <div><strong>주문 날짜:</strong> ${order.orderRegDate}</div>
            <div><strong>배송 주소:</strong> ${order.orderAddress}</div>
            <div><strong>결제 방법:</strong> ${order.paymentMethod}</div>
            <div class="order_success_total">
                <strong>총 합계:</strong> 
                <fmt:formatNumber value="${order.totalAmount}" type="currency"/>
            </div>
        </div>

        <!-- 주문 상세 정보 섹션 -->
        <div class="order_success_section">
            <h2>주문 상세 정보</h2>
            <div class="order_success_item">
                <div>상품명</div>
                <div>수량</div>
                <div>가격</div>
            </div>
            <c:forEach var="detail" items="${orderDetails}">
                <div class="order_success_item">
                    <div>${detail.productName}</div>
                    <div>${detail.quantity}</div>
                    <div><fmt:formatNumber value="${detail.price}" type="currency"/></div>
                </div>
            </c:forEach>
        </div>

        <!-- 홈 버튼 -->
        <div class="order_success_section">
            <a href="mydog.do" class="btn-primary">홈으로 돌아가기</a>
        </div>
    </div>
    
    <!-- Footer -->
    <jsp:include page="/include/footer.jsp"/>
</div>

</body>
</html>

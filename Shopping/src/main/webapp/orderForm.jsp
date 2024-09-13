<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="kr.ac.mydog.member.vo.MemberVO" %>

<%
    // 세션에서 사용자 정보를 가져옵니다.
    MemberVO user = (MemberVO) session.getAttribute("user");
	System.out.println(request.getAttribute("cartList"));
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이독 - 주문서</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/bootstrap4/bootstrap.min.css">
<link href="/Shopping/resources/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/categories_styles.css">
<link rel="stylesheet" type="text/css" href="/Shopping/resources/styles/categories_responsive.css">
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
    }
    .order_form_container {
        width: 80%;
        margin: 100px auto 50px auto;
        background-color: #fff;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        border-radius: 8px;
        padding: 20px;
    }
    .order_form_section {
        margin-bottom: 30px;
    }
    .order_form_section h2 {
        margin-bottom: 20px;
        font-size: 24px;
        border-bottom: 2px solid #007bff;
        padding-bottom: 10px;
    }
    .order_form_item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 0;
        border-bottom: 1px solid #ddd;
    }
    .order_form_item div {
        flex: 1;
        text-align: center;
    }
    .order_form_total {
        text-align: right;
        font-size: 20px;
        margin-top: 20px;
        color: #007bff;
        font-weight: bold;
    }
    .order_form_total strong {
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
    .address_section {
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        margin-bottom: 20px;
    }
    .address_section div {
        margin-bottom: 5px;
    }
    .change_address_btn {
        background-color: #28a745;
        border: none;
        padding: 10px 15px;
        color: #fff;
        cursor: pointer;
        border-radius: 5px;
        transition: background-color 0.3s;
    }
    .change_address_btn:hover {
        background-color: #218838;
    }
</style>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById('newPost').value = data.zonecode;
                document.getElementById('newBasicAddr').value = data.address;
                document.getElementById('newDetailAddr').focus();
            }
        }).open();
    }

    $(document).ready(function() {
        $('#changeAddressBtn').click(function() {
            $('#newAddressSection').toggle();
        });

        $('#newAddressSection input').on('change', function() {
            $('#name').text($('#newName').val());
            $('#phone').text($('#newPhone').val());
            $('#basicAddr').text($('#newBasicAddr').val());
            $('#detailAddr').text($('#newDetailAddr').val());
            $('#post').text($('#newPost').val());
            $('#hiddenName').val($('#newName').val());
            $('#hiddenPhone').val($('#newPhone').val());
            $('#hiddenPost').val($('#newPost').val());
            $('#hiddenBasicAddr').val($('#newBasicAddr').val());
            $('#hiddenDetailAddr').val($('#newDetailAddr').val());
        });
    });
</script>
</head>
<body>

<div class="super_container">
    <!-- Header -->
    <jsp:include page="/include/topMenu.jsp"/>
    <div class="container order_form_container">
        <!-- 상품 정보 섹션 -->
        <div class="order_form_section">
            <h2>상품 정보</h2>
            <div class="order_form_item">
                <div>상품명</div>
                <div>수량</div>
                <div>회원할인</div>
                <div>총 가격</div>
            </div>
            <c:set var="totalPrice" value="0" />
            <c:set var="price" value="0" />
            <c:forEach var="cart" items="${cartList}">
                <div class="order_form_item">
                    <div>${cart.productName}</div>
                    <div>${cart.quantity}</div>
                    <div>					
                    <c:choose>
					   <c:when test="${ user.grade == 'S'}">
					      5%
					   </c:when>
					   <c:when test="${ user.grade == 'G'}">
					       10%
					   </c:when>
					   <c:otherwise>
					   					       
					   </c:otherwise>
					</c:choose>
                    </div>
                    <div>
					<c:choose>
					   <c:when test="${ user.grade == 'S'}">
					       <c:set var="price" value="${ cart.cartPrice * cart.quantity * 0.95 }" />
					   </c:when>
					   <c:when test="${ user.grade == 'G'}">
					       <c:set var="price" value="${ cart.cartPrice * cart.quantity * 0.9 }" />
					   </c:when>
					   <c:otherwise>
					       <c:set var="price" value="${ cart.cartPrice * cart.quantity }" />
					   </c:otherwise>
					</c:choose>
					<fmt:formatNumber value="${price}" type="currency"/>
                    </div>
                </div>
                <c:set var="totalPrice" value="${totalPrice + price}" />
            </c:forEach>
            <div class="order_form_total">
            <c:choose>
	            <c:when test="${ user.grade == 'S'}">실버등급 5%할인</c:when>
	            <c:when test="${ user.grade == 'G'}">골드등급 10%할인</c:when>
				<c:otherwise></c:otherwise>            
            </c:choose>
            <br>
                <strong>총 합계:</strong> 
                <fmt:formatNumber value="${totalPrice}" type="currency"/>
            </div>
        </div>

        <!-- 배송지 정보 섹션 -->
        <div class="order_form_section">
            <h2>기본 배송지 정보</h2>
            <div class="address_section">
                <div><strong>이름:</strong> <span id="name">${user.name}</span></div>
                <div><strong>전화번호:</strong> <span id="phone">${user.phone}</span></div>
                <div><strong>주소:</strong> <span id="basicAddr">${user.basicAddr}</span> <span id="detailAddr">${user.detailAddr}</span> (<span id="post">${user.post}</span>)</div>
            </div>
            <button type="button" id="changeAddressBtn" class="change_address_btn">배송지 변경</button>
            <div id="newAddressSection" class="address_section" style="display: none;">
                <div><strong>이름:</strong> <input type="text" id="newName" name="newName" value="${user.name}"/></div>
                <div><strong>전화번호:</strong> <input type="text" id="newPhone" name="newPhone" value="${user.phone}"/></div>
                <div><strong>새 우편번호:</strong> <input type="text" id="newPost" name="newPost" readonly/></div>
                <div><strong>새 기본 주소:</strong> <input type="text" id="newBasicAddr" name="newBasicAddr" readonly/></div>
                <div><strong>새 상세 주소:</strong> <input type="text" id="newDetailAddr" name="newDetailAddr"/></div>
                <button type="button" onclick="execDaumPostcode()">주소 찾기</button>
            </div>
        </div>

        <!-- 결제 버튼 -->
        <div class="order_form_section">
            <form action="order.do" method="post">
                <input type="hidden" name="name" id="hiddenName" value="${user.name}">
                <input type="hidden" name="phone" id="hiddenPhone" value="${user.phone}">
                <input type="hidden" name="post" id="hiddenPost" value="${user.post}">
                <input type="hidden" name="basicAddr" id="hiddenBasicAddr" value="${user.basicAddr}">
                <input type="hidden" name="detailAddr" id="hiddenDetailAddr" value="${user.detailAddr}">
                <input type="hidden" name="totalAmount" value="${totalPrice}">
                <c:forEach var="cart" items="${cartList}">
                    <input type="hidden" name="productCode" value="${cart.productCode}">
                    <input type="hidden" name="quantity" value="${cart.quantity}">
                    <c:choose>
					   <c:when test="${ user.grade == 'S'}">
					       <c:set var="price" value="${ cart.cartPrice * cart.quantity * 0.95 }" />
					   </c:when>
					   <c:when test="${ user.grade == 'G'}">
					       <c:set var="price" value="${ cart.cartPrice * cart.quantity * 0.9 }" />
					   </c:when>
					   <c:otherwise>
					       <c:set var="price" value="${ cart.cartPrice * cart.quantity }" />
					   </c:otherwise>
					</c:choose>
                    <input type="hidden" name="cartPrice" value="${price}">
                </c:forEach>
                <button type="submit" class="btn-primary">주문하기</button>
            </form>
        </div>
    </div>
    <!-- Footer -->
    <jsp:include page="/include/footer.jsp"/>
</div>

</body>
</html>

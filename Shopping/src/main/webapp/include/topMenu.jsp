<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="kr.ac.mydog.member.vo.MemberVO" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!-- Top Navigation -->
<header class="header trans_300">
	<div class="top_nav">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<div class="top_nav_left">애견용품 쇼핑몰 마이독!</div>
				</div>
				<div class="col-md-6 text-right">
					<div class="top_nav_right">
						<ul class="top_nav_menu">
	
							<!-- Currency / Language / My Account -->
							<li class="account">
								<c:choose>
							        <c:when test="${not empty sessionScope.user}">
							        	<a href="#">
											${user.name}님
											<i class="fa fa-angle-down"></i>
										</a>
							        </c:when>
							        <c:otherwise>
										<a href="#">
											로그인 / 회원가입
											<i class="fa fa-angle-down"></i>
										</a>
							        </c:otherwise>
							    </c:choose>
								<ul class="account_selection">
							    <c:choose>
							        <c:when test="${not empty sessionScope.user}">
							            <li><a href="myPage.do"><i class="fa fa-sign-in" aria-hidden="true"></i>마이페이지</a></li>
							            <li><a href="logout.do"><i class="fa fa-sign-out" aria-hidden="true"></i> 로그아웃</a></li>
							            <li><a href="orderlist.do"><i class="fa fa-list" aria-hidden="true"></i> 주문목록</a></li>
							            <% 
					        				MemberVO user = (MemberVO) session.getAttribute("user");
					      			    	if (user != null && "A".equals(user.getAdmin())) {
					       				 %>
							            <li><a href="productManagement.do"><i class="fa fa-plus" aria-hidden="true"></i>상품관리</a></li>							            				       				 
					       				 <%
					      			    	}
					       				 %>
							        </c:when>
							        <c:otherwise>
							            <li><a href="loginForm.do"><i class="fa fa-sign-in" aria-hidden="true"></i>로그인</a></li>
							            <li><a href="signupForm.do"><i class="fa fa-user-plus" aria-hidden="true"></i>회원가입</a></li>
							        </c:otherwise>
							    </c:choose>
								</ul>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Main Navigation -->
	
	<div class="main_nav_container">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-right">
					<div class="logo_container">
						<a href="mydog.do">My<span>Dog</span></a>
					</div>
					<nav class="navbar">
						<ul class="navbar_menu">
							<li><a href="/Shopping/mydog.do">메인</a></li>
							<li><a href="/Shopping/categories.do">카테고리</a></li>
<!-- 							<li><a href="#">promotion</a></li> -->
							<li><a href="#">공지사항</a></li>
							<li><a href="#">주문</a></li>
							<li><a href="contact.jsp">찾아오시는길</a></li>
						</ul>
						<ul class="navbar_user">
							<li><a href="#"><i class="fa fa-search" aria-hidden="true"></i></a></li>
							<li><a href="myPage.do"><i class="fa fa-user" aria-hidden="true"></i></a></li>
							<li class="checkout">
								<a href="cart.do">
									<i class="fa fa-shopping-cart" aria-hidden="true"></i>
<!-- 									<span id="checkout_items" class="checkout_items">2</span> -->
								</a>
							</li>
						</ul>
						<div class="hamburger_container">
							<i class="fa fa-bars" aria-hidden="true"></i>
						</div>
					</nav>
				</div>
			</div>
		</div>
	</div>
</header>
<div class="fs_menu_overlay"></div>
<div class="hamburger_menu">
	<div class="hamburger_close"><i class="fa fa-times" aria-hidden="true"></i></div>
	<div class="hamburger_menu_content text-right">
		<ul class="menu_top_nav">
			<li class="menu_item has-children">
				<c:choose>
				<c:when test="${ not empty sessionScope.user}">
					<a href="#">
						My Account
						<i class="fa fa-angle-down"></i>
					</a>
				</c:when>
				<c:otherwise>
					<a href="#">
						로그인 / 회원가입
						<i class="fa fa-angle-down"></i>
					</a>
				</c:otherwise>
				</c:choose>
				<ul class="menu_selection">
					<c:choose>
				        <c:when test="${not empty sessionScope.user}">
				            <li><a href="mypage.do"><i class="fa fa-sign-in" aria-hidden="true"></i>마이페이지</a></li>
				            <li><a href="logout.do"><i class="fa fa-sign-out" aria-hidden="true"></i> 로그아웃</a></li>
				        </c:when>
				        <c:otherwise>
							<li><a href="loginForm.do"><i class="fa fa-sign-in" aria-hidden="true"></i>로그인</a></li>
							<li><a href="signupForm.do"><i class="fa fa-user-plus" aria-hidden="true"></i>회원가입</a></li>
				        </c:otherwise>
				    </c:choose>
				</ul>
			</li>
			<li class="menu_item"><a href="#">home</a></li>
			<li class="menu_item"><a href="#">shop</a></li>
			<li class="menu_item"><a href="#">promotion</a></li>
			<li class="menu_item"><a href="#">pages</a></li>
			<li class="menu_item"><a href="#">blog</a></li>
			<li class="menu_item"><a href="#">contact</a></li>
		</ul>
	</div>
</div>
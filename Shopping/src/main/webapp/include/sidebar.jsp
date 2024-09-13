<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="sidebar">
	<div class="sidebar_section">
		<div class="sidebar_title">
			<a href="categories.do"><h5>카테고리</h5></a>
		</div>
		<ul class="sidebar_categories">
			<li class="category-item">
				<i class="fa fa-angle-down" aria-hidden="true"></i><a href="categories.do?categoriCode=100">사료</a>
				<ul class="subcategories" style="display: none;">
                    <li><a href="categories.do?categoriCode=10001">건식사료</a></li>
                    <li><a href="categories.do?categoriCode=10002">습식사료</a></li>
                    <li><a href="categories.do?categoriCode=10003">우유/분유</a></li>
                    <li><a href="categories.do?categoriCode=10004">영양제</a></li>
                </ul>
			</li>		
			<li class="category-item">
				<i class="fa fa-angle-down" aria-hidden="true"></i><a href="categories.do?categoriCode=101">간식</a>
				<ul class="subcategories" style="display: none;">
                    <li><a href="categories.do?categoriCode=10101">강아지껌</a></li>
                    <li><a href="categories.do?categoriCode=10102">비스켓/스낵</a></li>
                    <li><a href="categories.do?categoriCode=10103">육포</a></li>
                    <li><a href="categories.do?categoriCode=10104">캔</a></li>
                    <li><a href="categories.do?categoriCode=10105">기타간식</a></li>
                </ul>
			</li>
			<li class="category-item">
				<i class="fa fa-angle-down" aria-hidden="true"></i><a href="categories.do?categoriCode=102">위생용품</a>
				<ul class="subcategories" style="display: none;">
                    <li><a href="categories.do?categoriCode=10201">배변판</a></li>
                    <li><a href="categories.do?categoriCode=10202">배변패드</a></li>
                    <li><a href="categories.do?categoriCode=10203">배변봉투</a></li>
                    <li><a href="categories.do?categoriCode=10204">기저귀</a></li>
                    <li><a href="categories.do?categoriCode=10205">물티슈</a></li>
                    <li><a href="categories.do?categoriCode=10206">탈취제</a></li>
                    <li><a href="categories.do?categoriCode=10207">넥카라</a></li>
                    <li><a href="categories.do?categoriCode=10208">해충방지제</a></li>
                    <li><a href="categories.do?categoriCode=10209">구강위생용품</a></li>
                </ul>
			</li>
			<li class="category-item">
				<i class="fa fa-angle-down" aria-hidden="true"></i><a href="categories.do?categoriCode=103">미용용품</a>
				<ul class="subcategories" style="display: none;">
                    <li><a href="categories.do?categoriCode=10301">샴푸</a></li>
                </ul>
			</li>
			<li class="category-item">
				<i class="fa fa-angle-down" aria-hidden="true"></i><a href="categories.do?categoriCode=104">식 기</a>
				<ul class="subcategories" style="display: none;">
                    <li><a href="categories.do?categoriCode=10401">급수기</a></li>
                    <li><a href="categories.do?categoriCode=10402">급식기</a></li>
                </ul>
			</li>
			<li class="category-item">
				<i class="fa fa-angle-down" aria-hidden="true"></i><a href="categories.do?categoriCode=105">외출용품</a>
				<ul class="subcategories" style="display: none;">
                    <li><a href="categories.do?categoriCode=10501">목줄</a></li>
                    <li><a href="categories.do?categoriCode=10502">이동가방</a></li>
                </ul>
			</li>
			<li class="category-item">
				<i class="fa fa-angle-down" aria-hidden="true"></i><a href="categories.do?categoriCode=106">장난감</a>
				<ul class="subcategories" style="display: none;">
                    <li><a href="categories.do?categoriCode=10601">공</a></li>
                    <li><a href="categories.do?categoriCode=10602">원반</a></li>
                </ul>
			</li>
			<li class="category-item">
				<i class="fa fa-angle-down" aria-hidden="true"></i><a href="categories.do?categoriCode=107">안전용품</a>
				<ul class="subcategories" style="display: none;">
                    <li><a href="categories.do?categoriCode=10701">매트</a></li>
                    <li><a href="categories.do?categoriCode=10702">울타리</a></li>
                    <li><a href="categories.do?categoriCode=10703">쿠션</a></li>
                </ul>
			</li>
			
		</ul>
	</div>
</div>
	<!-- Price Range Filtering
	<div class="sidebar_section">
		<div class="sidebar_title">
			<h5>Filter by Price</h5>
		</div>
		<p>
			<input type="text" id="amount" readonly style="border:0; color:#f6931f; font-weight:bold;">
		</p>
		<div id="slider-range"></div>
		<div class="filter_button"><span>filter</span></div>
	</div>
	
	Sizes
	<div class="sidebar_section">
		<div class="sidebar_title">
			<h5>Sizes</h5>
		</div>
		<ul class="checkboxes">
			<li><i class="fa fa-square-o" aria-hidden="true"></i><span>S</span></li>
			<li class="active"><i class="fa fa-square" aria-hidden="true"></i><span>M</span></li>
			<li><i class="fa fa-square-o" aria-hidden="true"></i><span>L</span></li>
			<li><i class="fa fa-square-o" aria-hidden="true"></i><span>XL</span></li>
			<li><i class="fa fa-square-o" aria-hidden="true"></i><span>XXL</span></li>
		</ul>
	</div>
	
	Color
	<div class="sidebar_section">
		<div class="sidebar_title">
			<h5>Color</h5>
		</div>
		<ul class="checkboxes">
			<li><i class="fa fa-square-o" aria-hidden="true"></i><span>Black</span></li>
			<li class="active"><i class="fa fa-square" aria-hidden="true"></i><span>Pink</span></li>
			<li><i class="fa fa-square-o" aria-hidden="true"></i><span>White</span></li>
			<li><i class="fa fa-square-o" aria-hidden="true"></i><span>Blue</span></li>
			<li><i class="fa fa-square-o" aria-hidden="true"></i><span>Orange</span></li>
			<li><i class="fa fa-square-o" aria-hidden="true"></i><span>White</span></li>
			<li><i class="fa fa-square-o" aria-hidden="true"></i><span>Blue</span></li>
			<li><i class="fa fa-square-o" aria-hidden="true"></i><span>Orange</span></li>
			<li><i class="fa fa-square-o" aria-hidden="true"></i><span>White</span></li>
			<li><i class="fa fa-square-o" aria-hidden="true"></i><span>Blue</span></li>
			<li><i class="fa fa-square-o" aria-hidden="true"></i><span>Orange</span></li>
		</ul>
		<div class="show_more">
			<span><span>+</span>Show More</span>
		</div>
	</div>-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- spring taglibs -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<header class="container">
	<div class="row">
		<div class="col-lg-3 col-md-6 col-sm-12 logo_web">
			<a href="${pageContext.request.contextPath }/home">
				<img src="${pageContext.request.contextPath }/images/logo_web.jpg">
			</a>
		</div>
		<div class="col-lg-6 col-md-12 col-sm-12">
			<div class="search-bar">
				<form action="/search" method="get">
					<input type="text" name="keyword"
						placeholder="Bạn muốn tìm sách gì?" required="required" value="${keyword }">
					<button>TÌM KIẾM</button>
				</form>
			</div>
		</div>
		<div class="col-lg-3 col-md-6 col-sm-12 px-0">
			<div class="header-right">
				<div class="login">
					<sec:authorize access="!isAuthenticated()">
						<a href="${pageContext.request.contextPath }/login">
							<span class="login-icon"><i class="far fa-user"></i></span>
							<span class="username">ĐĂNG NHẬP</span>
						</a>
					</sec:authorize>
					<sec:authorize access="isAuthenticated()">
						<a>
							<span class="login-icon"><i class="far fa-user"></i></span>
							<span class="username">
								<sec:authentication property="principal.username"/>
							</span>
						</a>
						
						<div class="user-menu">
							<ul>
								<sec:authorize access="hasAuthority('ADMIN')">
									<li class="li-admin"><a href="${pageContext.request.contextPath }/admin">Trang Admin</a></li>
								</sec:authorize>
								<li><a href="${pageContext.request.contextPath }/account/user-info">Thông tin tài khoản</a></li>
								<li><a href="${pageContext.request.contextPath }/account/user-order">Đơn hàng của tôi</a></li>
								<li><a href="${pageContext.request.contextPath }/logout">Đăng xuất</a></li>
							</ul>
						</div>
					</sec:authorize>
				</div>
				<div class="cart">
					<a href="${pageContext.request.contextPath }/cart"> 
						<span class="cart-icon">
							<i class="fas fa-shopping-cart"></i>
							<div class="cart-amount" id="cartAmount">
								<c:if test="${sessionScope.GIO_HANG != null 
											&& sessionScope.GIO_HANG.cartItems.size() > 0}">
									${sessionScope.GIO_HANG.getTotalCartItemQuantity() }
								</c:if>
								<c:if test="${sessionScope.GIO_HANG == null || sessionScope.GIO_HANG.cartItems.size() == 0 }">
									0
								</c:if>
							</div>
						</span>GIỎ HÀNG
					</a>
				</div>
			</div>
		</div>
	</div>
</header>
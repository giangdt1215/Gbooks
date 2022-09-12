<!-- sử dụng tiếng việt -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- SpringMVC form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
	<title>Quản lý đơn hàng</title>
	<meta charset="utf-8">
	<meta name=viewport content="width=device-width, initial-scale=1">
	<!-- load css -->
	<jsp:include page="/WEB-INF/views/layouts/css.jsp"></jsp:include>
	
</head>
<body>
	<!-- header -->
	<jsp:include page="/WEB-INF/views/layouts/header.jsp"></jsp:include>
	<!-- /header -->

	<!-- NAVIGATION BAR -->
	<jsp:include page="/WEB-INF/views/layouts/nav.jsp"></jsp:include>
	<!-- /NAVIGATION BAR -->

	<!-- wrapper -->
	<section class="list-products-wrap w-100">
		<div class="container">
			<div class="row">
				<!-- list-products -->
				<section class="list-products col-lg-9 col-md-9 col-sm-12 order-2">
					<div class="list-products-head">
						<div class="title">
							Quản lý đơn hàng
						</div>
					</div>
					<div class="title-line"></div>
					<!-- list-product-grid -->
					<div class="list-product-grid">
						<c:if test="${orderList.isEmpty() }">
							<h1 class="text-center" style="font-size: 20px; color: #cf111a">Hiện không có đơn hàng!!!</h1>
						</c:if>
						<c:if test="${!orderList.isEmpty() }">
							<!-- cart-table -->
							<div class="row">
								<div class="col-12">
									<table class="w-100 cart-table">
										<thead id="thaccount">
											<tr>
												<th>NGÀY MUA</th>
												<th>SẢN PHẨM</th>
												<th>TỔNG TIỀN</th>
												<th>TRẠNG THÁI</th>
												<th><i class="fas fa-info-circle"></i></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${orderList }" var="order">
												<tr>
													<td>${order.getFormattedDateOnly(order.createdDate) }</td>
													<td id="name">
														${order.orderDetails.get(0).product.name }
														<c:if test="${fn:length(order.orderDetails) > 1 }">
															và ${fn:length(order.orderDetails) - 1 } sản phẩm khác
														</c:if>
													</td>
													<td>
														<fmt:formatNumber type="number" 
		         											maxFractionDigits="3" value="${order.orderTotalCost}" /> đ</td>
													<td>${order.orderStatus }</td>
													<td>
														<a href="${pageContext.request.contextPath }/account/user-order/order-detail/${order.id}"
														   id="orderDetails">Chi tiết</a>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</c:if>
					</div>
					<!-- /list-product-grid -->
					
				</section>
				<!-- /list-products -->
				<!-- sidebar -->
				<aside class="col-xs-12 col-lg-3 col-md-3 col-sm-12 order-1">
					<!-- aside-category -->
					<div class="aside-category">
						<div class="title">
							Menu
						</div>
						<div class="title-line"></div>
						<div class="list-category">
							<ul>
								<li>
									<a href="${pageContext.request.contextPath }/account/user-info">Thông tin tài khoản</a>
								</li>
								<li>
									<a href="${pageContext.request.contextPath }/account/user-order" class="active">Quản lý đơn hàng</a>
								</li>
							</ul>
						</div>
					</div>
					<!-- /aside-category -->
					
				</aside>
				<!-- sidebar -->
			</div>
		</div>
	</section>
	<!-- /wrapper -->
	
	<c:if test="${fn:length(orderList) < 3 }">
		<section class="error-footer">
	</c:if>
	<!-- dich-vu -->
	<jsp:include page="/WEB-INF/views/layouts/services.jsp"></jsp:include>
	<!-- /dich-vu -->

	<!-- footer -->
	<jsp:include page="/WEB-INF/views/layouts/footer.jsp"></jsp:include>
	<!-- /footer -->

	<c:if test="${fn:length(orderList) < 3 }">
		</section>
	</c:if>

	<!-- load script -->
	<jsp:include page="/WEB-INF/views/layouts/js.jsp"></jsp:include>
</body>
</html>
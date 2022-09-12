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
	<title>Chi tiết đơn hàng</title>
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
							Chi tiết đơn hàng - ID: ${order.id }
						</div>
						<span style="float: right; text-align: right; line-height: 30px; font-size: 18px">
							Ngày đặt hàng: ${order.getFormattedDate(order.createdDate) }
						</span>
					</div>
					<div class="title-line"></div>
					<!-- list-product-grid -->
					<div class="list-product-grid">
						<div class="row" style="margin-bottom: 20px;">
							<div class="col-xs-12 col-md-4">
								<div style="margin-bottom: 10px; font-weight: bold;">ĐỊA CHỈ NGƯỜI NHẬN</div>
								<p>${order.customerName }</p>
								<p><span>Địa chỉ: </span>${order.customerAddress }</p>
								<p><span>Điện thoại: </span>${order.customerPhone }</p>
							</div>
							<div class="col-xs-12 col-md-4">
								<div style="margin-bottom: 10px; font-weight: bold;">HÌNH THỨC GIAO HÀNG</div>
								<p>Giao hàng tiêu chuẩn</p>
								<%-- <p><span>Phí vận chuyển: </span>
									<c:if test="${cost < shipCondition }">
										<fmt:formatNumber type="number" 
		         							maxFractionDigits="3" value="${shipFee}" />
									</c:if>
									<c:if test="${cost >= shipCondition }">
											Miễn phí
									</c:if>
								</p> --%>
							</div>
							<div class="col-xs-12 col-md-4">
								<div style="margin-bottom: 10px; font-weight: bold;">HÌNH THỨC THANH TOÁN</div>
								<p>Thanh toán khi nhận hàng (COD)</p>
							</div>
						</div>
						
						<c:if test="${order.orderDetails.isEmpty() }">
							<h1 class="text-center" style="font-size: 20px; color: #cf111a">Hiện không có sản phẩm trong đơn hàng!</h1>
						</c:if>
						<c:if test="${!order.orderDetails.isEmpty() }">
							<!-- cart-table -->
							<div class="row">
								<div class="col-12">
									<table class="w-100 cart-table">
										<thead id="thaccount">
											<tr>
												<th>STT</th>
												<th>SẢN PHẨM</th>
												<th>ĐƠN GIÁ</th>
												<th>SỐ LƯỢNG</th>
												<th>TẠM TÍNH</th>
											</tr>
										</thead>
										<tbody>
											<c:set var="tempCost" value="0" scope="page"></c:set>
											<c:forEach items="${order.orderDetails }" var="item" varStatus="idx">
												<tr>
													<td>${idx.index + 1 }</td>
													<td id="name">
														${item.product.name }
													</td>
													<td>
														<fmt:formatNumber type="number" 
		         											maxFractionDigits="3" value="${item.productPrice}" /></td>
													<td>${item.productQuantity }</td>
													<td>
														<fmt:formatNumber type="number" 
		         											maxFractionDigits="3" value="${item.cost }" />
													</td>
												</tr>
												<c:set value="${tempCost + item.cost }" var="cost" scope="page"></c:set>
											</c:forEach>
											<tr>
												<td colspan="4" style="text-align: right;">Phí vận chuyển:</td>
												<td colspan="1" >
													<c:if test="${cost < shipCondition }">
														<fmt:formatNumber type="number" 
		         											maxFractionDigits="3" value="${shipFee}" />
													</c:if>
													<c:if test="${cost >= shipCondition }">
														Miễn phí
													</c:if>
												</td>
											</tr>
											<tr>
												<td colspan="4" style="text-align: right;">Tổng tiền:</td>
												<td colspan="1" >
													<fmt:formatNumber type="number" 
		         											maxFractionDigits="3" value="${order.orderTotalCost}" />
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</c:if>
					</div>
					<!-- /list-product-grid -->
					<a style="display: inline-block; margin-top:10px; color: #cf111a; text-decoration:underline;"
						href="${pageContext.request.contextPath }/account/user-order"><<< Quay lại trang quản lý đơn hàng</a>
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
	
	<c:if test="${fn:length(order.orderDetails) < 1 }">
		<section class="error-footer">
	</c:if>
	<!-- dich-vu -->
	<jsp:include page="/WEB-INF/views/layouts/services.jsp"></jsp:include>
	<!-- /dich-vu -->

	<!-- footer -->
	<jsp:include page="/WEB-INF/views/layouts/footer.jsp"></jsp:include>
	<!-- /footer -->

	<c:if test="${fn:length(order.orderDetails) < 3 }">
		</section>
	</c:if>

	<!-- load script -->
	<jsp:include page="/WEB-INF/views/layouts/js.jsp"></jsp:include>
</body>
</html>
<!-- sử dụng tiếng việt -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
	<title>Giỏ hàng</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
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

	<!-- Cart -->
	<section class="cart-wrap">
		<div class="container">
			<!-- cart-table -->
			<div class="row">
				<div class="col-12" id="cartContent">
					<c:if test="${sessionScope.GIO_HANG == null ||
									sessionScope.GIO_HANG.cartItems.size() == 0}">
						<h1 class="no-items-cart">
							<c:out value="Hiện chưa có sản phầm nào trong giỏ hàng!"></c:out>
						</h1>
					</c:if>
					<c:if test="${sessionScope.GIO_HANG != null &&
									sessionScope.GIO_HANG.cartItems.size() > 0}">
					
						<table class="w-100 cart-table">
							<thead>
								<tr>
									<th>ẢNH BÌA</th>
									<th>TÊN SÁCH</th>
									<th>ĐƠN GIÁ</th>
									<th>SỐ LƯỢNG</th>
									<th>TỔNG GIÁ</th>
									<th><i class="far fa-trash-alt"></i></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${sessionScope.GIO_HANG.cartItems }" var="item">
									<tr id="itemLine${item.productId }">
										<td class="image">
											<img src="${pageContext.request.contextPath }/upload/${item.productAvatar}"
												alt="${item.productName}">
										</td>
										<td class="product-name" id="name">
											<p>
												<a href="${pageContext.request.contextPath }/book-details/${item.productId}">
													${item.productName}
												</a>
											</p>
										</td>
										<td class="price">
											<span><fmt:formatNumber type="number" 
	         									maxFractionDigits="3" value="${item.productPrice}" /></span>
										</td>
										<td class="quantity">
											<div class="qty-input">
												<div class="button minus">
													<button type="button" class="btn btn-primary btn-number"
														onclick="minusQuantity(${item.productId});">
														<i class="fas fa-minus"></i>
													</button>
												</div>
												<input type="text" class="input-number" value="${item.quantity}"
													 id="quantityInput${item.productId}"
												   	 onchange="checkQuantity(${maxBuyAmount}, ${item.productId});">
												<div class="button plus">
													<button type="button" class="btn btn-primary btn-number"
													   onclick="plusQuantity(${maxBuyAmount}, ${item.productId});">
														<i class="fas fa-plus"></i>
													</button>
												</div>
											</div>
										</td>
										<td class="total-amount">
											<span style="font-weight: bold;" id="totalAmount${item.productId }"><fmt:formatNumber type="number" 
	         									maxFractionDigits="3" value="${item.productPrice * item.quantity}" /></span>
										</td>
										<td class="del">
											<a onclick="removeItem(${item.productId})"><i class="far fa-trash-alt"></i></a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>
				</div>
			</div>
			<!-- /cart-table -->
			<!-- cart-pay -->
			<div class="row">
				<div class="col-12">
					<c:if test="${sessionScope.GIO_HANG != null &&
									sessionScope.GIO_HANG.cartItems.size() > 0}">
						<div class="cart-pay">
							<div class="row">
								<div class="col-lg-8 col-md-5 col-12"></div>
								<div class="col-lg-4 col-md-7 col-12">
									<div class="right">
										<ul>
											<li>
												Tạm tính:
												<span style="font-weight: bold;" id="cost"><fmt:formatNumber type="number" 
	         										maxFractionDigits="3" value="${sessionScope.GIO_HANG.getCost()}" /><sup>đ</sup></span>
											</li>
											<li>
												Phí vận chuyển:
												<c:if test="${sessionScope.GIO_HANG.getCost() < sessionScope.GIO_HANG.getShipCondition() }">
													<span id="shipFee"><fmt:formatNumber type="number" 
	         										maxFractionDigits="3" value="${sessionScope.GIO_HANG.getShipFee()}" /><sup>đ</sup></span>
												</c:if>
												<c:if test="${sessionScope.GIO_HANG.getCost() >= sessionScope.GIO_HANG.getShipCondition() }">
													<span id="shipFee">Miễn phí</span>
												</c:if>
											</li>
											<li class="last">
												Thành tiền:
												<span id="totalCost"><fmt:formatNumber type="number" 
	         										maxFractionDigits="3"
	         										value="${sessionScope.GIO_HANG.getTotalCost()}" /><sup>đ</sup></span>
											</li>
										</ul>
										<div>
											<a href="${pageContext.request.contextPath }/checkout" class="btn">Đặt Hàng</a>
											<a href="${pageContext.request.contextPath }/list-books" class="btn">Tiếp tục mua hàng</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:if>
				</div>
			</div>
			<!-- /cart-pay -->
		</div>
	</section>
	<!-- /Cart -->
	
	<!-- Ajax-spinner -->
	<section class="ajax-spinner text-center">
		<div class="spinner-border" style="width: 4rem; height: 4rem; color:#cf111a" role="status">
  			<span class="sr-only">Loading...</span>
		</div>
	</section>
	<!-- Ajax-spinner -->

	<c:if test="${sessionScope.GIO_HANG == null ||
					sessionScope.GIO_HANG.cartItems.size() == 0}">
		<section class='error-footer'>
	</c:if>

	<!-- dich-vu -->
	<jsp:include page="/WEB-INF/views/layouts/services.jsp"></jsp:include>
	<!-- /dich-vu -->

	<!-- footer -->
	<jsp:include page="/WEB-INF/views/layouts/footer.jsp"></jsp:include>
	<!-- /footer -->

	<c:if test="${sessionScope.GIO_HANG == null ||
					sessionScope.GIO_HANG.cartItems.size() == 0}">
		</section>
	</c:if>

	<!-- load script -->
	<jsp:include page="/WEB-INF/views/layouts/js.jsp"></jsp:include>
</body>

</html>
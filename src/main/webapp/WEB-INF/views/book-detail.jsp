<!-- sử dụng tiếng việt -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${product.name }</title>
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

	<!-- book-detail-wrap -->
	<section class="book-detail-wrap">
		<div class="container">
			<div class="row">
				<!-- book-slider -->
				<div class="col-12 col-md-5">
					<div class="book-slider-wrap">
						<div class="slider-main">
							
							<img src="${pageContext.request.contextPath }/upload/${product.avatar}"
								alt="${product.name }" class="img-fluid img-main" id="image-main">
							
						</div>
						<div class="slider-nav">
							<div class="row">
								<div class="col-3">
									<div class="slider-nav-img">
										<img src="${pageContext.request.contextPath }/upload/${product.avatar}" 
											alt="${product.name }" class="img-fluid img-nav nav-active">
									</div>
								</div>
								<c:forEach items="${product.images }" var="image">
									<div class="col-3">
										<div class="slider-nav-img">
											<img src="${pageContext.request.contextPath }/upload/${image.path}"
												alt="${product.name }" class="img-fluid img-nav">
										</div>
									</div>
								</c:forEach>
								
							</div>
						</div>
					</div>
				</div>
				<!-- /book-slider -->
				<!-- book-intro -->
				<div class="col-12 col-md-7">
					<div class="book-intro">
						<h1 class="book-name">${product.name }</h1>
						<div class="line"></div>
						<div class="row">
							<div class="col-12 col-lg-7">
								<div class="book-price">
									Giá bán: <span class="price">
										<fmt:formatNumber type="number" maxFractionDigits="3" value = "${product.price}" /><sup>đ</sup></span>
								</div>
								<div class="book-gift">
									<p class="mb-2">
										<strong>Khuyến mãi &#38; Ưu đãi tại GBooks:</strong>
									</p>
									<ul>
										<li><span><strong>Miễn phí giao hàng</strong> cho
												đơn hàng từ 150.000<sup>đ</sup></span></li>
										<li><span>Tặng Bookmark cho mỗi đơn hàng</span></li>
										<li><span>Bao sách miễn phí (theo yêu cầu)</span></li>
									</ul>
								</div>
								<div class="book-btn">
									<label for="">Số lượng: </label>
									<div class="book-number">
										<div class="button minus">
											<button type="button" class="btn btn-primary btn-number" onclick="minusQuantity();">
												<i class="fas fa-minus"></i>
											</button>
										</div>
										<input type="text" value="1" class="input-number" id="quantityInput"
											 onchange="checkQuantity(${maxBuyAmount});">
										<div class="button plus">
											<button type="button" class="btn btn-primary btn-number" 
											  onclick="plusQuantity(${maxBuyAmount});">
												<i class="fas fa-plus"></i>
											</button>
										</div>
									</div>
									<button type="button" style="border: 0;"
										onclick="FinalProject.addToCart(${product.id});" 
										class="btn-buy">Chọn Mua</button>
								</div>
							</div>
							<div class="col-12 col-lg-5">
								<div class="book-info">
									<ul>
										<li>Tác giả: 
											<c:forEach items="${product.productsAuthors }" var="productsAuthors">
												<c:if test="${productsAuthors.status == true }">
													<a href="${pageContext.request.contextPath}/list-books/author/${productsAuthors.author.id}">
														${productsAuthors.author.name}
													</a>
												</c:if>
											</c:forEach>
										</li>
										<li>Ngày xuất bản: 
											<strong>${product.getDateFromDateTime(product.releaseDate) }</strong>
										</li>
										<c:if test="${product.dimension != null }">
											<li>Kích thước: <strong>${product.dimension }</strong></li>
										</c:if>
										<li>Nhà xuất bản: <strong>${product.publishing }</strong></li>
										<li>Số trang: <strong>${product.pages }</strong></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /book-intro -->
				<!-- book-description -->
				<div class="col-12 col-md-12">
					<div class="book-description">
						<div class="book-des-title">
							<h1>Giới thiệu</h1>
						</div>
						<div class="line"></div>
						<div class="description">
							${product.detailDescription }
						</div>
					</div>
				</div>
				<!-- book-description -->
			</div>
		</div>
	</section>
	<!-- /book-detail-wrap -->

	<!-- dich-vu -->
	<jsp:include page="/WEB-INF/views/layouts/services.jsp"></jsp:include>
	<!-- /dich-vu -->

	<!-- footer -->
	<jsp:include page="/WEB-INF/views/layouts/footer.jsp"></jsp:include>
	<!-- /footer -->

	<!-- load script -->
	<jsp:include page="/WEB-INF/views/layouts/js.jsp"></jsp:include>
</body>
</html>
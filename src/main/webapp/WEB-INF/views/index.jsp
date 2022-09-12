<!-- sử dụng tiếng việt -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<title>GBooks</title>
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

	<!-- Banner Carousel -->
	<section class="banner">
		<div class="carousel container">
			<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
				<ol class="carousel-indicators">
					<c:forEach items="${slideList }" varStatus="loop">
						
						<li data-target="#carouselExampleIndicators" data-slide-to="${loop.index }"
							 class="${loop.index == 0 ? 'active' : '' }"></li>
					</c:forEach>
				</ol>
				<div class="carousel-inner">
					<c:forEach items="${slideList }" var="slide" varStatus="loop">
						<div class="carousel-item ${loop.index == 0 ? 'active' : '' }">
							<img class="d-block w-100 img-fluid" src="${pageContext.request.contextPath }/upload/${slide.path}"
								 alt="${slide.description }">
						</div>
					</c:forEach>
				</div>
				<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"><i class="fa fa-angle-left"></i></span>
					<span class="sr-only">Previous</span>
				</a>
				<a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"><i class="fa fa-angle-right"></i></span>
					<span class="sr-only">Next</span>
				</a>
			</div>
		</div>
	</section>
	<!-- /Banner Carousel -->

	<c:if test="${sliderAmount > 0}">
	<!-- Sach-moi -->
	<section class="sach-moi container">
		<div class="row sach-moi-title">
			<div class="col-sm-12 ">
				<h1>SÁCH MỚI PHÁT HÀNH</h1>
				<div class="title-line"></div>
			</div>
		</div>
		<div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
			<div class="carousel-inner">
				<c:forEach begin="1" end="${sliderAmount }" varStatus="loop">
					
					<div class="carousel-item ${loop.index == 1 ? 'active' : '' }">
						<div class="row book-lines">
							<c:forEach items="${bookList }" var="book"
								begin="${loop.index eq 1 ? '0' : '4' }"
								end="${loop.index eq 1 ? '3' : '7' }">
							
								<!-- book lines item -->
								<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12 item">
									<a href="${pageContext.request.contextPath }/book-details/${book.id}">
										<img src="${pageContext.request.contextPath }/upload/${book.avatar}"
											alt="${book.name }" class="w-100 img-fluid">
										<div class="book-lines-caption">
											<h3 class="book-name">${book.name }</h3>
											<div class="book-author">
												<c:forEach items="${book.productsAuthors }" var="productsAuthors">
													<c:if test="${productsAuthors.status == true }">
														${productsAuthors.author.name} 
													</c:if>
												</c:forEach>
											</div>
											<div class="book-price">
												<fmt:formatNumber type="number" 
													maxFractionDigits="3" value="${book.price}" /><sup>đ</sup>
											</div>
										</div>
									</a>
								</div>
							</c:forEach>
						</div>
					</div>
				</c:forEach>
				
			</div>
			<c:if test="${sliderAmount >= 2 }">
				<a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"><i class="fa fa-angle-left"></i></span>
					<span class="sr-only">Previous</span>
				</a>
				<a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"><i class="fa fa-angle-right"></i></span>
					<span class="sr-only">Next</span>
				</a>
			</c:if>
		</div>
	</section>
	<!-- /Sach-moi -->
	</c:if>

	<!-- dich-vu -->
	<jsp:include page="/WEB-INF/views/layouts/services.jsp"></jsp:include>
	<!-- /dich-vu -->

	<!-- tin-tuc -->
	<section class="tin-tuc container">
		<div class="row tin-tuc-title">
			<div class="col-sm-12">
				<h1>TIN TỨC</h1>
				<div class="title-line"></div>
			</div>
		</div>
		<div class="row tin-tuc-content">
			<c:forEach items="${newsList }" var="news">
				<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
					<a href="${pageContext.request.contextPath }/news-details/${news.id}">
						<img src="${pageContext.request.contextPath }/upload/${news.image}" class="w-100 img-fluid">
						<div class="tin-tuc-caption">
							<p class="tin-tuc-calendar">
								Ngày đăng: ${news.createdDate.getDayOfMonth() }/${news.createdDate.getMonthValue() }/${news.createdDate.getYear() }
							</p>
							<h3 class="news-title">${news.title }</h3>
						</div>
					</a>
				</div>
			</c:forEach>
		</div>
	</section>
	<!-- /tin-tuc -->

	<!-- footer -->
	<jsp:include page="/WEB-INF/views/layouts/footer.jsp"></jsp:include>
	<!-- /footer -->

	<!-- load script -->
	<jsp:include page="/WEB-INF/views/layouts/js.jsp"></jsp:include>
</body>
</html>
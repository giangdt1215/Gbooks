<!-- sử dụng tiếng việt -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<title>Có ${totalItems } kết quả cho '${keyword }'</title>
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
				<section class="list-products col-lg-12 col-md-12 col-sm-12">
					<div class="list-products-head">
						<div class="title">
							<c:if test="${action eq 'search' }">
								Tìm kiếm (${totalItems } kết quả) - "${keyword }"
							</c:if>
						</div>
						<div class="list-products-sort">
							<label>Sắp xếp: </label>
							<select id="sort_option" onchange="sortOptionChanges(${currentPage }, '${keyword }');">
								<option value="default" ${sortField eq 'id' ? 'selected' : '' }>Mặc định</option>
								<option value="price_asc" ${sortField eq 'price' && sortDir eq 'asc' ? 'selected' : '' }>
									Giá tăng dần
								</option>
								<option value="price_desc" ${sortField eq 'price' && sortDir eq 'desc' ? 'selected' : '' }>
									Giá giảm dần
								</option>
								<option value="name_asc" ${sortField eq 'name' && sortDir eq 'asc' ? 'selected' : '' }>
									Từ A-Z
								</option>
								<option value="name_desc" ${sortField eq 'name' && sortDir eq 'desc' ? 'selected' : '' }>
									Từ Z-A
								</option>
							</select>
						</div>
					</div>
					<div class="title-line"></div>
					<!-- list-product-grid -->
					<div class="list-product-grid">
						<c:if test="${productList == null || productList.isEmpty() }">
								<h1 class="text-center" style="font-size: 20px; color: #cf111a">
									Không tìm thấy kết quả cho "${keyword }"
								</h1>
						</c:if>
						<c:if test="${!productList.isEmpty()}">
							<div class="row">
							
								<c:forEach items="${productList }" var="product">
									<div class="col-xs-6 col-sm-6 col-md-3">
										<div class="item">
											<a href="${pageContext.request.contextPath }/book-details/${product.id}">
												<img src="${pageContext.request.contextPath }/upload/${product.avatar}" 
													class="w-100 img-fluid">
												<div class="book-caption">
													<h3 class="book-name">${product.name }</h3>
													<div class="book-author">
														<c:forEach items="${product.productsAuthors }" var="productsAuthors">
															${productsAuthors.author.name}
														</c:forEach>
													</div>
													<div class="book-price">
														<fmt:formatNumber type="number" 
         													maxFractionDigits="3" value="${product.price}" /><sup>đ</sup>
													</div>
												</div>
											</a>
											<div class="book-cart">
												<button class="add-to-cart" onclick="FinalProject.addToCartWithQuantity(${product.id}, 1);">
													<span class="fa fa-shopping-basket"></span> Mua Sách
												</button>
											</div>
										</div>
									</div>
								</c:forEach>
							
							</div>
						</c:if>
					</div>
					<!-- /list-product-grid -->
					<!-- list-products-page -->
					<c:if test="${!productList.isEmpty()}">
						<div class="list-products-page">
							<ul class="pagnation">
								
								<c:set var="paramLink" value="&sortField=${sortField }&sortDir=${sortDir }"/>
								<li class="page-item ${totalPages le 2 or currentPage eq 1 ? 'item-disabled' : '' }">
									<a href="${pageContext.request.contextPath }/search/page/1?keyword=${not empty keyword ? keyword : ''}${sortField ne 'id' ? paramLink : ''}">
										<i class="fas fa-fast-backward"></i>
									</a>
								</li>
								
								<li class="page-item ${currentPage le 2 or totalPages eq 1 ? 'item-disabled' : '' }">
									<a href="${pageContext.request.contextPath }/search/page/${currentPage - 1 }?keyword=${not empty keyword ? keyword : ''}${sortField ne 'id' ? paramLink : ''}">
										<i class="fa fa-angle-left"></i>
									</a>
								</li>
								
								<c:forEach items="${listPage }" var="index">
									<li class="page-item ${index eq currentPage ? 'item-active' : ''}">
										<c:if test="${index ne currentPage }">
											<a href="${pageContext.request.contextPath }/search/page/${index}?keyword=${not empty keyword ? keyword : ''}${sortField ne 'id' ? paramLink : ''}">${index }</a>
										</c:if>
										<c:if test="${index eq currentPage }">
											<span>${index }</span>
										</c:if>
									</li>
								</c:forEach>
								
								
								<li class="page-item ${currentPage ge totalPages or totalPages le 2 ? 'item-disabled' : '' }">
									<a href="${pageContext.request.contextPath }/search/page/${currentPage + 1 }?keyword=${not empty keyword ? keyword : ''}${sortField ne 'id' ? paramLink : ''}">
										<i class="fa fa-angle-right"></i>
									</a>
								</li>
								
								<li class="page-item ${totalPages le 2 or currentPage eq totalPages ? 'item-disabled' : '' }">
									<a href="${pageContext.request.contextPath }/search/page/${totalPages }?keyword=${not empty keyword ? keyword : ''}${sortField ne 'id' ? paramLink : ''}">
										<i class="fas fa-fast-forward"></i>
									</a>
								</li>
							</ul>
						</div>
					</c:if>
					<!-- /list-products-page -->
				</section>
				<!-- /list-products -->
				
			</div>
		</div>
	</section>
	<!-- /wrapper -->
	
	<c:if test="${productList  == null || productList.isEmpty() }">
		<section class="error-footer">
	</c:if>
	<!-- dich-vu -->
	<jsp:include page="/WEB-INF/views/layouts/services.jsp"></jsp:include>
	<!-- /dich-vu -->

	<!-- footer -->
	<jsp:include page="/WEB-INF/views/layouts/footer.jsp"></jsp:include>
	<!-- /footer -->
	
	<c:if test="${productList  == null || productList.isEmpty() }">
		</section>
	</c:if>

	<!-- load script -->
	<jsp:include page="/WEB-INF/views/layouts/js.jsp"></jsp:include>
	
	<script type="text/javascript">
		function sortOptionChanges(currentPage, keyword){
			var key = $('#sort_option').val();
				switch (key) {
				case 'default':
					window.location.replace("/search/page/1?keyword=" + keyword);
					break;
				case 'price_asc':
					window.location.replace("/search/page/1?keyword=" + keyword + "&sortField=price&sortDir=asc");
					break;
				case 'price_desc':
					window.location.replace("/search/page/1?keyword=" + keyword + "&sortField=price&sortDir=desc");
					break;
				case 'name_asc':
					window.location.replace("/search/page/1?keyword=" + keyword + "&sortField=name&sortDir=asc");
					break;
				case 'name_desc':
					window.location.replace("/search/page/1?keyword=" + keyword + "&sortField=name&sortDir=desc");
					break;
				default:
					window.location.replace("/search/page/1?keyword=" + keyword);
					break;
				}
		};
		
	</script>
</body>
</html>
<!-- sử dụng tiếng việt -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<title>Kho sách</title>
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
							<c:forEach items="${categories }" var="category">
								${category.id == SELECTED_CATEGORY_ID ? category.name : '' }
							</c:forEach>
							${-1 == SELECTED_CATEGORY_ID ? 'Tất cả sách' : '' }
						</div>
						<div class="list-products-sort">
							<label>Sắp xếp: </label>
							<select id="sort_option" onchange="sortOptionChange(${currentPage }, ${categoryId });">
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
							<h1 class="text-center" style="font-size: 20px; color: #cf111a">Hiện không có sách!!!</h1>
						</c:if>
						<c:if test="${!productList.isEmpty()}">
							<div class="row">
							
								<c:forEach items="${productList }" var="product">
									<div class="col-xs-6 col-sm-6 col-md-4">
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
								
								<c:set var="paramLink" value="?sortField=${sortField }&sortDir=${sortDir }"/>
								<li class="page-item ${totalPages le 2 or currentPage eq 1 ? 'item-disabled' : '' }">
									<c:if test="${categoryId <= 0 }">
										<a href="${pageContext.request.contextPath }/list-books/page/1${sortField ne 'id' ? paramLink : ''}">
											<i class="fas fa-fast-backward"></i>
										</a>
									</c:if>
									<c:if test="${categoryId > 0 }">
										<a href="${pageContext.request.contextPath }/list-books/category/${categoryId }/page/1${sortField ne 'id' ? paramLink : ''}">
											<i class="fas fa-fast-backward"></i>
										</a>
									</c:if>
								</li>
								
								<li class="page-item ${currentPage le 2 or totalPages eq 1 ? 'item-disabled' : '' }">
									<c:if test="${categoryId <= 0 }">
										<a href="${pageContext.request.contextPath }/list-books/page/${currentPage - 1 }${sortField ne 'id' ? paramLink : ''}">
											<i class="fa fa-angle-left"></i>
										</a>
									</c:if>
									<c:if test="${categoryId > 0 }">
										<a href="${pageContext.request.contextPath }/list-books/category/${categoryId }/page/${currentPage - 1 }${sortField ne 'id' ? paramLink : ''}">
											<i class="fa fa-angle-left"></i>
										</a>
									</c:if>
								</li>
								
								<c:forEach items="${listPage }" var="index">
									<li class="page-item ${index eq currentPage ? 'item-active' : ''}">
										<c:if test="${index ne currentPage }">
											<c:if test="${categoryId <= 0 }">
												<a href="${pageContext.request.contextPath }/list-books/page/${index}${sortField ne 'id' ? paramLink : ''}">${index }</a>
											</c:if>
											<c:if test="${categoryId > 0 }">
												<a href="${pageContext.request.contextPath }/list-books/category/${categoryId }/page/${index}${sortField ne 'id' ? paramLink : ''}">${index }</a>
											</c:if>
										</c:if>
										<c:if test="${index eq currentPage }">
											<span>${index }</span>
										</c:if>
									</li>
								</c:forEach>
								
								
								<li class="page-item ${currentPage ge totalPages or totalPages le 2 ? 'item-disabled' : '' }">
									<c:if test="${categoryId <= 0 }">
										<a href="${pageContext.request.contextPath }/list-books/page/${currentPage + 1 }${sortField ne 'id' ? paramLink : ''}">
											<i class="fa fa-angle-right"></i>
										</a>
									</c:if>
									<c:if test="${categoryId > 0 }">
										<a href="${pageContext.request.contextPath }/list-books/category/${categoryId }/page/${currentPage + 1 }${sortField ne 'id' ? paramLink : ''}">
											<i class="fa fa-angle-right"></i>
										</a>
									</c:if>
								</li>
								
								<li class="page-item ${totalPages le 2 or currentPage eq totalPages ? 'item-disabled' : '' }">
									<c:if test="${categoryId <= 0 }">
										<a href="${pageContext.request.contextPath }/list-books/page/${totalPages }${sortField ne 'id' ? paramLink : ''}">
											<i class="fas fa-fast-forward"></i>
										</a>
									</c:if>
									<c:if test="${categoryId > 0 }">
										<a href="${pageContext.request.contextPath }/list-books/category/${categoryId }/page/${totalPages }${sortField ne 'id' ? paramLink : ''}">
											<i class="fas fa-fast-forward"></i>
										</a>
									</c:if>
								</li>
							</ul>
						</div>
					</c:if>
					<!-- /list-products-page -->
				</section>
				<!-- /list-products -->
				<!-- sidebar -->
				<aside class="col-xs-12 col-lg-3 col-md-3 col-sm-12 order-1">
					<!-- aside-category -->
					<div class="aside-category">
						<div class="title">
							Danh mục
						</div>
						<div class="title-line"></div>
						<div class="list-category">
							<ul>
								<li><a href="${pageContext.request.contextPath }/list-books" 
									class="${SELECTED_CATEGORY_ID == -1 ? 'active' : ''}">Tất cả sách</a></li>
								<c:forEach items="${categories }" var="category">
									<li>
										<a href="${pageContext.request.contextPath }/list-books/category/${category.id}"
										  class="${category.id == SELECTED_CATEGORY_ID ? 'active' : '' }">
											${category.name }
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<!-- /aside-category -->
					<!-- aside-filter-price -->
					<div class="aside-filter-price">
						<div class="title">
							Tìm theo giá
						</div>
						<div class="title-line"></div>
						<div class="filter-price">
							<form action="#">
								<input type="checkbox" id="cbox1" class="priceFilterCheckbox" name="###" value="0To100"
									onclick="filterPriceChange(${categoryId }, '${sortField }', '${sortDir }');"
									${filterPrice eq '0To100' ? 'checked' : ''}>
								<label for="cbox1" id="cbox1" class="priceFilterLabel"> 0 - 100.000 <sup>đ</sup></label><br>
								
								<input type="checkbox" id="cbox2" class="priceFilterCheckbox" name="###" value="100To200"
									onclick="filterPriceChange(${categoryId }, '${sortField }', '${sortDir }');"
									${filterPrice eq '100To200' ? 'checked' : ''}>
								<label for="cbox2" id="cbox2" class="priceFilterLabel"> 100.000 <sup>đ</sup> - 200.000 <sup>đ</sup></label><br>
								
								<input type="checkbox" id="cbox3" class="priceFilterCheckbox" name="###" value="200To300"
									onclick="filterPriceChange(${categoryId }, '${sortField }', '${sortDir }');"
									${filterPrice eq '200To300' ? 'checked' : ''}>
								<label for="cbox3" id="cbox3" class="priceFilterLabel"> 200.000 <sup>đ</sup> - 300.000 <sup>đ</sup></label><br>
								
								<input type="checkbox" id="cbox4" class="priceFilterCheckbox" name="###" value="300To400"
									onclick="filterPriceChange(${categoryId }, '${sortField }', '${sortDir }');"
									${filterPrice eq '300To400' ? 'checked' : ''}>
								<label for="cbox4" id="cbox4" class="priceFilterLabel"> 300.000 <sup>đ</sup> - 400.000 <sup>đ</sup></label><br>
								
								<input type="checkbox" id="cbox5" class="priceFilterCheckbox" name="###" value="400To500"
									onclick="filterPriceChange(${categoryId }, '${sortField }', '${sortDir }');"
									${filterPrice eq '400To500' ? 'checked' : ''}>
								<label for="cbox5" id="cbox5" class="priceFilterLabel"> 400.000 <sup>đ</sup> - 500.000 <sup>đ</sup></label><br>
								
								<input type="checkbox" id="cbox6" class="priceFilterCheckbox" name="###" value="500ToMax"
									onclick="filterPriceChange(${categoryId }, '${sortField }', '${sortDir }');"
									${filterPrice eq '500ToMax' ? 'checked' : ''}>
								<label for="cbox6" id="cbox6" class="priceFilterLabel"> Trên 500.000 <sup>đ</sup></label><br>
							</form>
						</div>	
					</div>
					<!-- /aside-filter-price -->
				</aside>
				<!-- sidebar -->
			</div>
		</div>
	</section>
	<!-- /wrapper -->
	
	<!-- dich-vu -->
	<jsp:include page="/WEB-INF/views/layouts/services.jsp"></jsp:include>
	<!-- /dich-vu -->

	<!-- footer -->
	<jsp:include page="/WEB-INF/views/layouts/footer.jsp"></jsp:include>
	<!-- /footer -->

	<!-- load script -->
	<jsp:include page="/WEB-INF/views/layouts/js.jsp"></jsp:include>
	
	<script type="text/javascript">
		function sortOptionChange(currentPage, categoryId){
			var key = $('#sort_option').val();
			
			categoryId = parseInt(categoryId);
			if(categoryId <= 0){
				switch (key) {
				case 'default':
					window.location.replace("/list-books/page/1");
					break;
				case 'price_asc':
					window.location.replace("/list-books/page/1?sortField=price&sortDir=asc");
					break;
				case 'price_desc':
					window.location.replace("/list-books/page/1?sortField=price&sortDir=desc");
					break;
				case 'name_asc':
					window.location.replace("/list-books/page/1?sortField=name&sortDir=asc");
					break;
				case 'name_desc':
					window.location.replace("/list-books/page/1?sortField=name&sortDir=desc");
					break;
				default:
					window.location.replace("/list-books/page/1");
					break;
				}
			} else{
				switch (key) {
				case 'default':
					window.location.replace("/list-books/category/" + categoryId + "/page/1");
					break;
				case 'price_asc':
					window.location.replace("/list-books/category/" + categoryId + "/page/1?sortField=price&sortDir=asc");
					break;
				case 'price_desc':
					window.location.replace("/list-books/category/" + categoryId + "/page/1?sortField=price&sortDir=desc");
					break;
				case 'name_asc':
					window.location.replace("/list-books/category/" + categoryId + "/page/1?sortField=name&sortDir=asc");
					break;
				case 'name_desc':
					window.location.replace("/list-books/category/" + categoryId + "/page/1?sortField=name&sortDir=desc");
					break;
				default:
					window.location.replace("/list-books/category/" + categoryId + "/page/1");
					break;
				}
			}
		};

	function filterPriceChange(categoryId, sortField, sortDir){
		
			categoryId = parseInt(categoryId);
			
			var paramLink;
			if(sortField === 'id'){
				paramLink = "?";
			} else {
				paramLink = "?sortField=" + sortField + "&sortDir=" + sortDir;
			}
			
			$(".priceFilterCheckbox").on('change', function(){
				var self = $(this);

				if(categoryId <= 0){
					if(self.is(":checked")){
						paramLink += '&filterPrice=' + self.val();
						window.location.replace("/list-books/page/1" + paramLink);
					} else {
						window.location.replace("/list-books/page/1" + paramLink);
					}
				} else {
					if(self.is(":checked")){
						paramLink += '&filterPrice=' + self.val();
						window.location.replace("/list-books/category/" + categoryId + "/page/1" + paramLink);
					} else {
						window.location.replace("/list-books/category/" + categoryId + "/page/1" + paramLink);
					}
				}
			})
		
	}
	</script>
</body>
</html>
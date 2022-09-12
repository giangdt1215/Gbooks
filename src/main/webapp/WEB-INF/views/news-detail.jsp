<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${news.title }</title>
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

    <!-- News-Detail -->
    <section class="news-detail-wrap">
        <div class="container">
            <div class="row">
                <!-- new-books -->
                <div class="col-lg-4 col-md-6 col-xs-12 order-1">
                    <div class="new-books">
                        <div class="new-books-title">
                            <h1>Sách mới phát hành</h1>
                        </div>
                        <div class="title-line"></div>
                        <!-- list-new-books -->
                        <div class="list-new-books">
                            <ul>
                            	<c:forEach items="${productList }" var="product">
									<li>
										<div class="new-books-item">
											<a href="${pageContext.request.contextPath }/book-details/${product.id}">
												<img src="${pageContext.request.contextPath }/upload/${product.avatar}" 
													alt="${product.name}" class="img-fluid">
												<div class="new-books-des">
													<h3 class="book-title">${product.name }</h3>
													<p>
														Giá: <span class="price">
														<fmt:formatNumber type="number" maxFractionDigits="3" value = "${product.price}" /> 
														<sup>đ</sup></span>
													</p>
												</div>
											</a>
										</div>
									</li>
								</c:forEach>
                                
                            </ul>
                        </div>
                        <!-- /list-new-books -->
                    </div>
                </div>
                <!-- /new-books -->

                <!-- news-detail -->
                <div class="col-lg-8 col-md-8 col-xs-12">
                    <div class="news-detail">
                        <img src="${pageContext.request.contextPath }/upload/${news.image}" alt="" class="img-fluid">
                        <div class="news-calendar">
                            Ngày đăng: ${news.createdDate.getDayOfMonth() }/${news.createdDate.getMonthValue() }/${news.createdDate.getYear() }
                        </div>
                        <h1 class="news-title">
							${news.title }
                        </h1>
                        <div class="news-des">
                            ${news.description}
                        </div>
                    </div>
                </div>
                <!-- /news-detail -->
            </div>
        </div>
    </section>
    <!-- /news-detail -->

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
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
    <title>Tin tức</title>
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

    <!-- News -->
    <section class="news-wrap">
        <div class="container">
            <div class="row">
            
            	<c:forEach items="${newsList }" var="news">
					<div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
						<div class="news-item">
							<a href="${pageContext.request.contextPath }/news-details/${news.id}">
								<img src="${pageContext.request.contextPath }/upload/${news.image}"
									class="w-100 img-fluid">
								<div class="tin-tuc-caption">
									<p class="tin-tuc-calendar">
										Ngày đăng: ${news.createdDate.getDayOfMonth() }/${news.createdDate.getMonthValue() }/${news.createdDate.getYear() }
									</p>
									<h3 class="news-title">${news.title }</h3>
								</div>
							</a>
						</div>
					</div>
				</c:forEach>

            </div>
            <div class="row">
            	<div class="col-12">
            	<div class="list-products-wrap">
            		<!-- list-products-page -->
					<c:if test="${!newsList.isEmpty()}">
						<div class="list-products-page">
							<ul class="pagnation">
								
								<li class="page-item ${totalPages le 2 or currentPage eq 1 ? 'item-disabled' : '' }">
									<a href="${pageContext.request.contextPath }/news/page/1">
										<i class="fas fa-fast-backward"></i>
									</a>
								</li>
								
								<li class="page-item ${currentPage le 2 or totalPages eq 1 ? 'item-disabled' : '' }">
									<a href="${pageContext.request.contextPath }/news/page/${currentPage - 1 }">
										<i class="fa fa-angle-left"></i>
									</a>
								</li>
								
								<c:forEach begin="1" end="${totalPages }" var="index">
									<li class="page-item ${index eq currentPage ? 'item-active' : ''}"
											style="${index eq currentPage ? 'display: inline-block;text-align:center;' : ''}">
										<c:if test="${index ne currentPage }">
												<a href="${pageContext.request.contextPath }/news/page/${index}">${index }</a>
										</c:if>
										<c:if test="${index eq currentPage }">
											<span>${index }</span>
										</c:if>
									</li>
								</c:forEach>
								
								
								<li class="page-item ${currentPage ge totalPages or totalPages le 2 ? 'item-disabled' : '' }">
									<a href="${pageContext.request.contextPath }/news/page/${currentPage + 1 }">
										<i class="fa fa-angle-right"></i>
									</a>
								</li>
								
								<li class="page-item ${totalPages le 2 or currentPage eq totalPages ? 'item-disabled' : '' }">
									<a href="${pageContext.request.contextPath }/news/page/${totalPages }">
										<i class="fas fa-fast-forward"></i>
									</a>
								</li>
							</ul>
						</div>
					</c:if>
					<!-- /list-products-page -->
					</div>
            	</div>
            </div>
        </div>
    </section>
    <!-- /News -->

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
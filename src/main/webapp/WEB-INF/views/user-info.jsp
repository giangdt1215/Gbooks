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
	<title>Thông tin tài khoản</title>
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
							Thông tin tài khoản
						</div>
					</div>
					<div class="title-line"></div>
					<!-- list-product-grid -->
					<div class="list-product-grid">
						<div class="contact-form">
							<c:if test="${not empty errorMsg }">
								<div class="row">
									<div class="col-12">
										<div class="contact-alert">
											<div class="alert alert-danger" role="alert">
												${errorMsg }
											</div>
										</div>
									</div>
								</div>
							</c:if>
							<c:if test="${param.update_success eq 'ok' }">
								<div class="row">
									<div class="col-12">
										<div class="contact-alert">
											<div class="alert alert-success" role="alert">
												Cập nhật thành công!
											</div>
										</div>
									</div>
								</div>
							</c:if>
							<form:form action="/account/update-user" method="post" role="form"
							 	modelAttribute="user">
								<div class="row">
									<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
										<form:hidden path="id"/>
										<div class="form-group">
											<label for="contact-name">
												Họ tên:
											</label>
											<form:input type="text" cssClass="form-control" name="contact-name" id="contact-name"
												placeholder="Nhập họ tên" required="required" path="fullName"
												autofocus="${focusOption eq 'txtName' ? 'autofocus' : '' }"/>
										</div>
										
										<div class="form-group">
											<label for="contact-address">
												Địa chỉ:
											</label>
											<form:textarea rows="4" class="form-control" name="contact-address" id="contact-address"
												placeholder="Nhập địa chỉ" required="required" path="address" 
												autofocus="${focusOption eq 'txtAddress' ? 'autofocus' : '' }"></form:textarea>
										</div>
										
										<div class="form-group">
											<label for="contact-new-pass">
												Mật khẩu mới:
											</label>
											<input type="password" class="form-control" name="newPassword" id="contact-new-pass"
												placeholder="Nhập mật khẩu mới (8 ký tự trở lên)" 
												${focusOption eq 'txtPass' ? 'autofocus' : '' }>
										</div>
									
									</div>
									<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
								
										<div class="form-group">
											<label for="contact-phone">
												Số điện thoại:
											</label>
											<form:input type="text" class="form-control" name="contact-phone" id="contact-phone"
												placeholder="Nhập số điện thoại (vd: 0912345678)" required="required" path="phone" 
												autofocus="${focusOption eq 'txtPhone' ? 'autofocus' : '' }"/>
										</div>
										<div class="form-group">
											<label for="contact-email">
												Email:
											</label>
											<form:input type="email" class="form-control" name="contact-email" id="contact-email"
												placeholder="Nhập email" required="required" path="email" 
												autofocus="${focusOption eq 'txtEmail' ? 'autofocus' : '' }"/>
										</div>
										
									
									</div>
							
								</div>
								<div class="row">
									<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
										<button type="submit" class="submit">Cập nhật</button>
									</div>	
								</div>
							</form:form>
						</div>
						
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
								<li><a href="${pageContext.request.contextPath }/account/user-info" 
									class="active">Thông tin tài khoản</a></li>
								<li><a href="${pageContext.request.contextPath }/account/user-order">Quản lý đơn hàng</a></li>
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
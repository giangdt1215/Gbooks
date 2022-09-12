<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- SPRING FORM -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Liên hệ</title>
<jsp:include page="/WEB-INF/views/layouts/css.jsp"></jsp:include>
</head>

<body>
	<!-- header -->
	<jsp:include page="/WEB-INF/views/layouts/header.jsp"></jsp:include>
	<!-- /header -->

	<!-- NAVIGATION BAR -->
	<jsp:include page="/WEB-INF/views/layouts/nav.jsp"></jsp:include>
	<!-- /NAVIGATION BAR -->

	<!-- contact -->
	<section class="contact-wrap">
		<div class="container">

			<div class="row">
				<div class="col-12">
					<div class="contact-alert">
						<div class="alert alert-success" role="alert" style="display:none" id="success-alert">
						</div>

						<div class="alert alert-danger" role="alert" style="display:none" id="error-alert">
						</div>
					</div>
				</div>
			</div>


			<div class="row">
				<div class="col-lg-8 col-md-6 col-sm-12 col-xs-12">
					<div class="contact-form">
						<form action="/saveContactWithAjax" method="post" role="form">
							<div class="form-group">
								<label for="contact-name"> Họ tên của bạn <span>*</span>
								</label>
								<input type="text" class="form-control" name="contact-name"
									id="contact-name" placeholder="Nhập họ tên" required="required"/>
							</div>
							<div class="form-group">
								<label for="contact-email"> Email của bạn <span>*</span>
								</label>
								<input type="email" class="form-control"
									name="contact-email" id="contact-email"
									placeholder="Nhập email" required="required"/>
							</div>
							<div class="form-group">
								<label for="contact-content"> Nội dung <span>*</span>
								</label>
								<textarea rows="4" class="form-control"
									name="contact-content" id="contact-content"
									placeholder="Nhập nội dung" required="required"></textarea>
							</div>
							<button type="button" onclick="FinalProject.saveContact();" class="submit">Gửi liên hệ</button>
						</form>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
					<div class="contact-info">
						<span class="contact-info-title">Thông tin liên hệ</span>
						<ul>
							<li><i class="fa fa-home"></i> <span>98 Hòa Sơn, Chúc
									Sơn, Chương Mỹ, Hà Nội, Việt Nam</span></li>
							<li><i class="fa fa-phone"></i> <span>0982388301</span></li>
							<li><i class="fa fa fa-paper-plane"></i> <span>cskh@gbooks.net</span>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- /contact -->

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
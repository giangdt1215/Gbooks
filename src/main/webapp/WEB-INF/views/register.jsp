<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- SpringMVC form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
	<title>Đăng ký | GBooks</title>
	<meta charset="utf-8">
	<meta name=viewport content="width=device-width, initial-scale=1">
	<!-- load css -->
	<jsp:include page="/WEB-INF/views/layouts/css.jsp"></jsp:include>
</head>
<body>
	<div class="register-wrapper">
		<div class="register-container">
			<form:form class="register-form" modelAttribute="user" method="POST" action="/perform-register">
			
				<span class="register-logo">
					<img src="images/logo_web.png" class="img-fluid w-100">
				</span>
				
				<span class="register-title">Đăng ký</span>
				
				<c:if test="${not empty errorMsg }">
					<div class="alert alert-danger" role="alert">
						<c:out value="${errorMsg }"></c:out>
					</div>
				</c:if>
				
				<div class="register-input">
					<form:input type="text" name="username" placeholder="Tên đăng nhập *" path="username" 
						autofocus="${focusOption eq 'txtUser' ? 'autofocus' : '' }"/>
					<form:input type="text" name="fullname" placeholder="Họ tên *" path="fullName" 
						autofocus="${focusOption eq 'txtName' ? 'autofocus' : '' }"/>
				</div>
				
				<div class="register-input">
					<form:input type="password" name="password" placeholder="Mật khẩu *" path="password" 
						autofocus="${focusOption eq 'txtPass' ? 'autofocus' : '' }"/>
					<input type="password" name="passwordConfirm" placeholder="Nhập lại mật khẩu *" 
						${focusOption eq 'txtPassConfirm' ? 'autofocus' : '' }>
				</div>
				
				<div class="register-input">
					<form:input type="email" name="email" placeholder="Email *" path="email" 
						autofocus="${focusOption eq 'txtEmail' ? 'autofocus' : '' }"/>
					<form:input type="text" name="sdt"
						 placeholder="Số điện thoại (vd: 0912345678)" path="phone"
						 autofocus="${focusOption eq 'txtPhone' ? 'autofocus' : '' }"/>
				</div>
				
				<div class="address-input">
					<form:input type="text" name="address" placeholder="Địa chỉ *" path="address"
						autofocus="${focusOption eq 'txtAddress' ? 'autofocus' : '' }"/>
				</div>
				
				<div class="register-input">
					<span style="color: #cf111a; margin-left: 20px;">* : Bắt buộc phải nhập</span>
				</div>
				<button class="register-btn" type="submit">XÁC NHẬN</button>
			</form:form>

			<div class="text-center register">
				<span>Đã có tài khoản?</span>
				<a href="${pageContext.request.contextPath }/login">Đăng nhập</a>
			</div>
		</div>
	</div>

	<!-- load script -->
	<jsp:include page="/WEB-INF/views/layouts/js.jsp"></jsp:include>
</body>
</html>
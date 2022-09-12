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
	<title>Đăng nhập | GBooks</title>
	<meta charset="utf-8">
	<meta name=viewport content="width=device-width, initial-scale=1">
	<!-- load css -->
	<jsp:include page="/WEB-INF/views/layouts/css.jsp"></jsp:include>
</head>
<body>
	<div class="login-wrapper">
		<div class="login-container">
			<form:form cssClass="login-form" action="/perform-login" method="POST" role="form" modelAttribute="user">
				<span class="login-logo"> 
					<img src="images/logo_web.png" class="img-fluid w-100">
				</span>
				<span class="login-title">Welcome</span>

				<c:if test="${param.login_error == true }">
					<div class="alert alert-danger" role="alert">
						<c:out value="Tài khoản hoặc mật khẩu không đúng!"></c:out>
					</div>
				</c:if>

				<div class="login-input">
					<form:input type="text" path="username" name="username" placeholder="Tên đăng nhập" required="required" autofocus="autofocus"/> 
				</div>
				<div class="login-input">
					<form:password path="password" name="password" placeholder="Mật khẩu" required="required"/>
				</div>
				<button type="submit" class="login-btn">ĐĂNG NHẬP</button>
			</form:form>

			<div class="text-center register">
				<span>Chưa có tài khoản?</span> <a href="${pageContext.request.contextPath }/register">Đăng ký</a>
			</div>
		</div>
	</div>

	<!-- load script -->
	<jsp:include page="/WEB-INF/views/layouts/js.jsp"></jsp:include>
</body>
</html>
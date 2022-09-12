<!-- sử dụng tiếng việt -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- Spring forms -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>Thêm Slide</title>

<jsp:include page="/WEB-INF/views/admin/layouts/css.jsp"></jsp:include>
</head>

<body>

	<div id="wrapper">

		<!-- Navigation -->
		<jsp:include page="/WEB-INF/views/admin/layouts/nav.jsp"></jsp:include>

		<div id="page-wrapper">
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-12">
						<h1 class="page-header">Thêm slide mới</h1>
					</div>
					<!-- /.col-lg-12 -->
				</div>
				<!-- /.row -->
				<div class="row">
					<div class="col-lg-12">
						<form:form action="${pageContext.request.contextPath }/admin/save-slide" method="post"
							modelAttribute="slide" enctype="multipart/form-data">

							<div class="form-group">
								<label for="slideID">ID</label>
								<form:input type="text" cssClass="form-control"
									name="slideID" id="slideID" placeholder="Id"
									readonly="true" path="id" />
							</div>
							
							<div class="form-group">
								<label for="slideImage">Ảnh slide <span class="required-input">*</span></label>
								<input type="file" class="form-control"
									name="slideImage" id="slideImage" required="required"/>
							</div>
							<div class="form-group">
								<label for="shortDes">Mô tả <span class="required-input">*</span></label>
								<form:textarea rows="5" class="form-control" name="shortDes"
									id="shortDes" placeholder="Nhập mô tả slide" required="required"
									path="description"></form:textarea>
							</div>

							<button type="submit" class="btn btn-primary" id="addBtn">Thêm slide</button>
							<a type="button" href="${pageContext.request.contextPath }/admin/slider-mgr"
								class="btn btn-secondary">Hủy</a>
							
						</form:form>
					</div>
					<!-- /.col-lg-12 -->
				</div>
				<!-- /.row -->

			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->

	<jsp:include page="/WEB-INF/views/admin/layouts/js.jsp"></jsp:include>
</body>

</html>
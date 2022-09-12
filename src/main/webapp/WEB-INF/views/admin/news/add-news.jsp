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

<title>Thêm tin tức mới</title>

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
						<h1 class="page-header">Thêm tin tức mới</h1>
					</div>
					<!-- /.col-lg-12 -->
				</div>
				<!-- /.row -->
				<div class="row">
					<div class="col-lg-12">
						<form:form action="${pageContext.request.contextPath }/admin/save-news" method="post"
							modelAttribute="news" enctype="multipart/form-data">

							<div class="form-group">
								<label for="productID">ID</label>
								<form:input type="text" cssClass="form-control"
									name="productID" id="productID" placeholder="Id"
									readonly="true" path="id" />
							</div>
							
							<div class="form-group">
								<label for="newsTitle">Nhập tiêu đề <span class="required-input">*</span></label>
								<form:input type="text" cssClass="form-control"
									name="newsTitle" id="newsTitle" placeholder="Nhập tiêu đề"
									path="title" required="required"/>
							</div>
							
							<div class="form-group">
								<label for="newsImage">Ảnh bìa tin tức </label>
								<input type="file" class="form-control"
									name="newsImage" id="newsImage" />
							</div>
							
							<div class="form-group">
								<label for="newsDescription">Nhập nội dung tin tức <span class="required-input">*</span></label>
								<form:textarea rows="6" class="form-control" name="newsDescription"
									id="newsDescription" placeholder="Nhập nội dung tin tức" required="required"
									path="description"></form:textarea>
							</div>

							<button type="submit" class="btn btn-primary" id="addBtn">Thêm tin tức</button>
							<a type="button" href="${pageContext.request.contextPath }/admin/news-mgr"
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

	<script type="text/javascript">
		$(document).ready(function(){
			$('#newsDescription').summernote({
				placeholder: 'Hãy nhập nội dung tin tức',
				height: 500
			});
		});
	</script>
</body>

</html>
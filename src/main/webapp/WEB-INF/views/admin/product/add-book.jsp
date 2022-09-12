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

<title>Thêm sách mới</title>

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
						<h1 class="page-header">Thêm sách mới</h1>
					</div>
					<!-- /.col-lg-12 -->
				</div>
				<!-- /.row -->
				<div class="row">
					<div class="col-lg-12">
						<form:form action="${pageContext.request.contextPath }/admin/save-book" method="post"
							modelAttribute="product" enctype="multipart/form-data">

							<div class="form-group">
								<label for="productID">ID</label>
								<form:input type="text" cssClass="form-control"
									name="productID" id="productID" placeholder="Id"
									readonly="true" path="id" />
							</div>
							<div class="form-group">
								<label for="categoryName">Chọn danh mục sách
								<span class="required-input">*</span></label>
								<c:choose>
									<c:when test="${categories.size() > 0 }">
										<form:select id="category" name="category"
											class="form-control" path="category.id">
											<form:options items="${categories }" itemLabel="name"
												itemValue="id" />
										</form:select>
									</c:when>
									<c:otherwise>
										<c:out value="Hiện tại không có danh mục"></c:out>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="form-group">
								<label for="productName">Nhập tên sách <span class="required-input">*</span></label>
								<form:input type="text" cssClass="form-control"
									name="productName" id="productName" placeholder="Nhập tên sách"
									path="name" required="required"/>
							</div>
							<div class="form-group">
								<label for="productAuthor">Nhập tên tác giả <span class="required-input">*</span></label>
								<input type="text" class="form-control"
									name="productAuthor" id="productAuthor" placeholder="Tác giả 1;tác giả 2;..."
									required="required"/>
							</div>
							<div class="form-group">
								<label for="productPrice">Nhập giá sách <span class="required-input">*</span></label>
								<form:input type="number" cssClass="form-control"
									name="productPrice" id="productPrice" placeholder="Nhập giá sách"
									path="price" required="required"/>
							</div>
							<div class="form-group">
								<label for="productPublishing">Nhập nhà xuất bản <span class="required-input">*</span></label>
								<form:input type="text" cssClass="form-control"
									name="productPublishing" id="productPublishing" placeholder="Nhập nhà xuất bản"
									path="publishing" required="required"/>
							</div>
							<div class="form-group">
								<label for="productRelease">Nhập ngày xuất bản <span class="required-input">*</span></label>
								<form:input type="datetime-local" cssClass="form-control"
									name="productRelease" id="productRelease" placeholder="Nhập ngày xuất bản"
									path="releaseDate" required="required"/>
							</div>
							<div class="form-group">
								<label for="productPages">Nhập số trang <span class="required-input">*</span></label>
								<form:input type="number" cssClass="form-control"
									name="productPages" id="productPages" placeholder="Nhập số trang"
									path="pages" required="required"/>
							</div>
							<div class="form-group">
								<label for="productDimen">Nhập kích thước</label>
								<form:input type="text" cssClass="form-control"
									name="productDimen" id="productDimen" placeholder="Chiều rộng(cm) x chiều cao(cm)"
									path="dimension"/>
							</div>
							<div class="form-group">
								<label for="productAvatar">Ảnh bìa sản phẩm <span class="required-input">*</span></label>
								<input type="file" class="form-control"
									name="productAvatar" id="productAvatar" />
							</div>
							<div class="form-group">
								<label for="productImages">Ảnh sản phẩm khác:</label>
								<input type="file" class="form-control"
									name="productImages" id="productImages" multiple="multiple"/>
							</div>
							<div class="form-group">
								<label for="shortDes">Mô tả ngắn <span
									class="required-input">*</span></label>
								<form:textarea rows="2" class="form-control" name="shortDes"
									id="shortDes" placeholder="Nhập mô tả ngắn" required="required"
									path="shortDescription"></form:textarea>
							</div>
							<div class="form-group">
								<label for="detailDes">Mô tả chi tiết <span class="required-input">*</span></label>
								<form:textarea rows="8" class="form-control" name="detailDes"
									id="detailDes" placeholder="Nhập mô tả chi tiết" required="required"
									path="detailDescription"></form:textarea>
							</div>

							<button type="submit" class="btn btn-primary" id="addBtn">Thêm sách</button>
							<a type="button" href="${pageContext.request.contextPath }/admin/book-mgr"
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
			$('#detailDes').summernote({
				placeholder: 'Nhập mô tả chi tiết',
				height: 400
			});
		});
	</script>
</body>

</html>
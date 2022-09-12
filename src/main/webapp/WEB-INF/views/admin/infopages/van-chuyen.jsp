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

<title>Chỉnh sửa chính sách vận chuyển</title>

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
						<h1 class="page-header">Chỉnh sửa chính sách vận chuyển</h1>
					</div>
					<!-- /.col-lg-12 -->
				</div>
				<!-- /.row -->
				<c:if test="${param.save_success != null }">
                	<div class="row">
                		<div class="alert alert-success" role="alert" id="saveMsg">
							<c:out value="Lưu thành công!"></c:out>
						</div>
                	</div>
                </c:if>
                <c:if test="${param.save_failed != null }">
                	<div class="row">
                		<div class="alert alert-danger" role="alert" id="saveMsg">
							<c:out value="Lưu không thành công!"></c:out>
						</div>
                	</div>
                </c:if>
				<div class="row">
					<div class="col-lg-12">
						<form:form action="${pageContext.request.contextPath }/admin/save-van-chuyen" method="post"
							modelAttribute="shopInfo">
							<form:hidden path="id"/>
							<div class="form-group">
								<label for="gioiThieu">Nhập nội dung trang giới thiệu <span class="required-input">*</span></label>
								<form:textarea rows="10" class="form-control" name="csVanChuyen"
									id="csVanChuyen" placeholder="Nhập nội dung chính sách vận chuyển" required="required"
									path="csVanChuyen"></form:textarea>
							</div>

							<button type="submit" class="btn btn-primary" id="addBtn">Lưu thay đổi</button>
							
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
			$('#csVanChuyen').summernote({
				placeholder: 'Hãy nhập nội dung chính sách vận chuyển',
				height: 600
			});
		});
	</script>
</body>

</html>
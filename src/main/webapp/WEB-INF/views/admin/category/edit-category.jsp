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

    <title>Sửa thể loại sách</title>

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
						<h1 class="page-header">Sửa danh mục sách</h1>
					</div>
                </div>
                <div class="row">
                	<div class="col-lg-12">
						<form:form action="/admin/save-category" method="post"
							modelAttribute="category">

							<div class="form-group">
								<label for="categoryID">ID</label>
								<form:input type="text" cssClass="form-control"
									name="categoryID" id="categoryID" placeholder="Id"
									readonly="true" path="id" />
							</div>
							<div class="form-group">
								<label for="categoryName">Tên danh mục <span
									class="required-input">*</span></label>
								<form:input type="text" cssClass="form-control"
									name="categoryName" id="categoryName"
									placeholder="Tên danh mục" required="required" path="name" />
							</div>
							<div class="form-group">
								<label for="categoryDes">Mô tả <span
									class="required-input">*</span></label>
								<form:textarea rows="4" class="form-control" name="categoryDes"
									id="categoryDes" placeholder="Nhập mô tả" required="required"
									path="description"></form:textarea>
							</div>
							<div class="form-group">
								<label for="categoryParent">Danh mục cha (nếu có)</label>
								<c:choose>
									<c:when test="${categories.size() > 0 }">
										<form:select id="categoryParent" name="categoryParent"
											class="form-control" path="parent.id">
											<form:option value="${-1 }" label="Không có" />
											<form:options items="${categories }" itemLabel="name"
												itemValue="id" />
										</form:select>
									</c:when>
									<c:otherwise>
										<form:hidden path="parent.id" value="${-1 }" />
										<c:out value="Hiện tại không có danh mục"></c:out>
									</c:otherwise>
								</c:choose>

							</div>

							<button type="submit" class="btn btn-primary" id="addBtn">Lưu thay đổi</button>
							<a type="button" href="${pageContext.request.contextPath }/admin/category-mgr"
								class="btn btn-secondary">Hủy</a>

						</form:form>
					</div>
                </div>
                

            </div>
            <!-- /.container-fluid -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    

    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title" id="deleteModalLabel">Xóa danh mục</h3>
                    <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button> -->
                </div>
                <form action="" method="post">
                    <div class="modal-body">
                        <h4>Bạn có chắc chắn muốn xóa danh mục này không?</h4>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-danger">Xóa danh mục</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- /modal -->

    
    <jsp:include page="/WEB-INF/views/admin/layouts/js.jsp"></jsp:include>

</body>

</html>
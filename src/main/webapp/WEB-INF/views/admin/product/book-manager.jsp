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

    <title>Quản lý thư viện sách</title>

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
                        <h1 class="page-header">Quản lý sách</h1>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <c:if test="${param.save_book_success != null }">
                	<div class="row">
                		<div class="alert alert-success" role="alert" id="saveMsg">
							<c:out value="Lưu sách thành công!"></c:out>
						</div>
                	</div>
                </c:if>
                <!-- /.row -->
                <div class="row">
                    <div class="col-sm-12 add-button">
                        <a href="${pageContext.request.contextPath}/admin/add-book" class="btn btn-primary">Thêm sách mới</a>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-hover"
                                        id="dataTables-example">
                                        <thead>
                                            <tr>
                                                <th class="id-col">ID</th>
                                                <th class="avatar-col">Avatar</th>
                                                <th class="name-col">Tên sách</th>
                                                <th class="category-col">Danh mục</th>
                                                <th class="price-col">Giá sách</th>
                                                <th class="short-des-col">Mô tả ngắn</th>
                                                <th class="pages-col">Số trang</th>
                                                <th class="created-date-col">Ngày tạo</th>
                                                <th class="status-col">Trạng thái</th>
                                                <th class="options-col">Tùy chọn</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:forEach items="${products }" var="product">
												<tr class="">
													<td>${product.id }</td>
													<td>
														<img alt="${product.name }" 
															src="${pageContext.request.contextPath }/upload/${product.avatar}"
															width="100" height="100">
													</td>
													<td>${product.name }</td>
													<td>${product.category.getName() }</td>
													<td>${product.price }</td>
													<td>${product.shortDescription }</td>
													<td>${product.pages }</td>
													<td>${product.getFormattedDate(product.createdDate) }</td>
													<td>
														<c:if test="${product.status == true }">
															<span class="label label-success">Chưa xóa</span>
														</c:if>
														<c:if test="${product.status == false }">
															<span class="label label-danger">Đã xóa</span>
														</c:if>
													</td>
													<td>
														<c:if test="${product.status == true }">
															<a type="button" class="btn btn-info"
															href="${pageContext.request.contextPath}/admin/edit-book/${product.id}">
																Sửa
															</a>		
														
															<button type="button" class="btn btn-danger" 
																data-toggle="modal" data-target="#deleteModal" 
																onclick="deleteProduct(${product.id});">Xóa</button>
														</c:if>
													</td>
												</tr>
											</c:forEach>
                                            
                                        </tbody>
                                    </table>
                                </div>
                                <!-- /.table-responsive -->
                            </div>
                            <!-- /.panel-body -->
                        </div>
                        <!-- /.panel -->
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
    
    <!-- Modal -->
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

				<div class="modal-body">
					<h4>Bạn có chắc chắn muốn xóa sách này không?</h4>
				</div>
				<div class="modal-footer">
					<form action="" method="post" id="deleteFormModal">
						<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-danger">Xóa sách</button>
					</form>
				</div>

			</div>
        </div>
    </div>
    <!-- /modal -->

    <jsp:include page="/WEB-INF/views/admin/layouts/js.jsp"></jsp:include>
    

</body>

</html>
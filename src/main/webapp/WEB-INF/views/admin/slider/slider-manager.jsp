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

    <title>Quản lý slider</title>

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
                        <h1 class="page-header">Quản lý slider</h1>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <c:if test="${param.save_slide_success != null }">
                	<div class="row">
                		<div class="alert alert-success" role="alert" id="saveMsg">
							<c:out value="Lưu ảnh slide thành công!"></c:out>
						</div>
                	</div>
                </c:if>
                <!-- /.row -->
                <div class="row">
                    <div class="col-sm-12 add-button">
                        <a href="${pageContext.request.contextPath }/admin/add-slide"
                        	type="button" class="btn btn-primary">Thêm ảnh slide mới</a>
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
                                                <th class="slide-col">Ảnh slide</th>
                                                <th class="short-des-col">Mô tả</th>
                                                <th class="created-date-col">Ngày tạo</th>
                                                <th class="status-col">Trạng thái</th>
                                                <th class="options-col">Tùy chọn</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:forEach items="${slideList }" var="slide">
                                        		<tr>
                                        			<td>${slide.id }</td>
                                                	<td>
                                                		<img alt="${slide.description }"
                                                		 src="${pageContext.request.contextPath }/upload/${slide.path}"
                                                		 height="165px">
                                                	</td>
                                                	<td>${slide.description }</td>
                                                	<td>${slide.getFormattedDate(slide.createdDate) }</td>
                                                	<td>
														<c:if test="${slide.status == true }">
															<span class="label label-success">Chưa xóa</span>
														</c:if>
														<c:if test="${slide.status == false }">
															<span class="label label-danger">Đã xóa</span>
														</c:if>
													</td>
                                                	<td>
                                                		<c:if test="${slide.status == true }">
                                                    		<%-- <a type="button" class="btn btn-info" 
                                                    			href="${pageContext.request.contextPath }/admin/edit-news/${news.id}">Sửa</a> --%>
                                                    			
                                                    		<button type="button" class="btn btn-danger" data-toggle="modal"
                                                        		data-target="#deleteModal" onclick="deleteSlide(${slide.id});">Xóa</button>
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
                    <h3 class="modal-title" id="deleteModalLabel">Xóa ảnh slide</h3>
                    <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button> -->
                </div>

				<div class="modal-body">
					<h4>Bạn có chắc chắn muốn xóa ảnh này không?</h4>
				</div>
				<div class="modal-footer">
					<form action="" method="post" id="deleteFormModal">
						<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-danger">Xóa slide</button>
					</form>
				</div>

			</div>
        </div>
    </div>
    <!-- /modal -->

    <jsp:include page="/WEB-INF/views/admin/layouts/js.jsp"></jsp:include>
</body>

</html>
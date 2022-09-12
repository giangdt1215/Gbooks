<!-- sử dụng tiếng việt -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Quản lý liên hệ</title>

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
                        <h1 class="page-header">Yêu cầu từ người dùng</h1>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
                <div class="row">
                    <!-- <div class="col-sm-12 add-button">
                        <button type="button" class="btn btn-primary" data-toggle="modal"
                            data-target="#categoryModal" onclick="addCategory();">Thêm danh mục</button>
                    </div> -->
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
                                                <th class="name-col">Họ tên người gửi</th>
                                                <th class="email-col">Email</th>
                                                <th class="short-des-col">Tin nhắn</th>
                                                <th class="created-date-col">Ngày gửi</th>
                                                <th class="status-col">Trạng thái</th>
                                                <th class="options-col">Tùy chọn</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:forEach items="${contactList }" var="contact">
												<tr class="">
													<td>${contact.id }</td>
													<td>${contact.fullName }</td>
													<td>${contact.email }</td>
													<td>${contact.message }</td>
													<td>${contact.getFormattedDate(contact.createdDate) }</td>
													<td>
														<c:if test="${contact.status == true }">
															<span class="label label-danger">Chưa phản hồi</span>
														</c:if>
														<c:if test="${contact.status == false }">
															<span class="label label-success">Đã xử lý</span>
														</c:if>
													</td>
													<td>
														<button type="button" class="btn btn-info"
															data-toggle="modal" data-target="#categoryModal"
															onclick="editContact();">Phản hồi</button>
														<button type="button" class="btn btn-danger"
															data-toggle="modal" data-target="#deleteModal"
															onclick="deleteContact(${contact.id});">Xóa</button>
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
    <div class="modal fade editModal" id="categoryModal" tabindex="-1" role="dialog" aria-labelledby="categoryModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title" id="categoryModalLabel">Thêm danh mục sách</h3>
                    <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button> -->
                </div>
                <form action="" method="post">
                    <div class="modal-body">

                        <div class="form-group">
                            <label for="categoryID">ID</label>
                            <input type="text" class="form-control" name="categoryID" id="categoryID" placeholder="Id"
                                disabled="disabled" />
                        </div>
                        <div class="form-group">
                            <label for="categoryName">Tên danh mục <span class="required-input">*</span></label>
                            <input type="text" class="form-control" name="categoryName" id="categoryName"
                                placeholder="Tên danh mục" required/>
                        </div>
                        <div class="form-group">
                            <label for="categoryDes">Mô tả <span class="required-input">*</span></label>
                            <textarea rows="4" class="form-control" name="categoryDes" id="categoryDes"
                                placeholder="Nhập mô tả" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="categoryParent">Danh mục cha (nếu có)</label>
                            <select id="categoryParent" name="categoryParent" class="form-control">
                                <option value="volvo">Volvo</option>
                                <option value="saab">Saab</option>
                                <option value="fiat">Fiat</option>
                                <option value="audi">Audi</option>
                            </select>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary" id="saveBtn">Lưu thay đổi</button>
                        <button type="submit" class="btn btn-primary" id="addBtn">Thêm danh mục</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title" id="deleteModalLabel">Xóa liên hệ</h3>
                    <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button> -->
                </div>
                <div class="modal-body">
                       <h4>Bạn có chắc chắn muốn xóa liên hệ này không?</h4>
                </div>
                <div class="modal-footer">
                   	<form action="" method="post" id="deleteFormModal">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                       	<button type="submit" class="btn btn-danger">Xóa liên hệ</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- /modal -->
    
    <jsp:include page="/WEB-INF/views/admin/layouts/js.jsp"></jsp:include>

</body>

</html>
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

    <title>Quản lý tài khoản</title>

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
                        <h1 class="page-header">Quản lý tài khoản</h1>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
                <div class="row">
                    <div class="col-sm-12 add-button">
                        <button type="button" class="btn btn-primary" data-toggle="modal"
                        data-target="#accountModal" onclick="addAccount();">Thêm tài khoản mới</button>
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
                                                <th class="username-col">Username</th>
                                                <th class="password-col">Password</th>
                                                <th class="name-col">Họ tên</th>
                                                <th class="email-col">Email</th>
                                                <th class="address-col">Địa chỉ</th>
                                                <th class="role-col">Quyền</th>
                                                <th class="created-date-col">Ngày tạo</th>
                                                <th class="status-col">Trạng thái</th>
                                                <th class="options-col">Tùy chọn</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:forEach items="${userList }" var="user">
	                                        	<tr class="">
	                                                <td>${user.id }</td>
	                                                <td>${user.username }</td>
	                                                <td>${user.password }</td>
	                                                <td>${user.fullName }</td>
	                                                <td>${user.email }</td>
	                                                <td>${user.address }</td>
	                                                <td>
	                                                	<c:forEach items="${user.roles }" var="role">
	                                                		<c:out value="${role.name }"></c:out>
	                                                		<c:out value=";"></c:out>
	                                                	</c:forEach>
	                                                </td>
	                                                <td>${user.getFormattedDate(user.createdDate) }</td>
	                                                <td>
														<c:if test="${user.status == true }">
															<span class="label label-success">Chưa xóa</span>
														</c:if>
														<c:if test="${user.status == false }">
															<span class="label label-danger">Đã xóa</span>
														</c:if>
													</td>
	                                                <td>
														<c:if test="${user.status == true }">
															<a type="button" class="btn btn-info"
															href="${pageContext.request.contextPath}/admin/edit-user/${user.id}">
																Sửa
															</a>		
														
															<button type="button" class="btn btn-danger" 
																data-toggle="modal" data-target="#deleteModal" 
																onclick="deleteUser(${user.id});">Xóa</button>
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
    <div class="modal fade editModal" id="accountModal" tabindex="-1" role="dialog" aria-labelledby="accountModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title" id="accountModalLabel">Thêm tài khoản</h3>
                    <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button> -->
                </div>
                <form action="" method="post">
                    <div class="modal-body">

                        <div class="form-group">
                            <label for="id">ID</label>
                            <input type="text" class="form-control" name="categoryID" id="id" placeholder="Id"
                                disabled="disabled" />
                        </div>
                        <div class="form-group">
                            <label for="username">Username <span class="required-input">*</span></label>
                            <input type="text" class="form-control" name="username" id="username"
                                placeholder="Nhập username" required/>
                        </div>
                        <div class="form-group">
                            <label for="password">Password <span class="required-input">*</span></label>
                            <input type="password" class="form-control" name="password" id="password"
                                placeholder="Nhập password" required/>
                        </div>
                        <div class="form-group">
                            <label for="fullname">Họ tên <span class="required-input">*</span></label>
                            <input type="text" class="form-control" name="fullname" id="fullname"
                                placeholder="Nhập họ tên" required/>
                        </div>
                        <div class="form-group">
                            <label for="email">Email <span class="required-input">*</span></label>
                            <input type="email" class="form-control" name="email" id="email"
                                placeholder="Nhập email" required/>
                        </div>
                        <div class="form-group">
                            <label for="address">Địa chỉ <span class="required-input">*</span></label>
                            <textarea rows="4" class="form-control" name="address" id="address"
                                placeholder="Nhập địa chỉ" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="roles">Quyền</label>
                            <select id="roles" name="roles" class="form-control">
                                <option value="admin">Admin</option>
                                <option value="staff">Nhân viên</option>
                            </select>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary" id="saveBtn">Lưu thay đổi</button>
                        <button type="submit" class="btn btn-primary" id="addBtn">Thêm tài khoản</button>
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
                    <h3 class="modal-title" id="deleteModalLabel">Xóa tài khoản</h3>
                    <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button> -->
                </div>
                <form action="" method="post">
                    <div class="modal-body">
                        <h4>Bạn có chắc chắn muốn xóa tài khoản này không?</h4>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-danger">Xóa tài khoản</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- /modal -->

    <jsp:include page="/WEB-INF/views/admin/layouts/js.jsp"></jsp:include>

</body>

</html>
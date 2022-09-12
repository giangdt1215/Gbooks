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

    <title>Quản lý đơn hàng</title>

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
                        <h1 class="page-header">Quản lý đơn hàng</h1>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                
                <c:if test="${param.save_order_success != null }">
                	<div class="row">
                		<div class="alert alert-success" role="alert" id="saveMsg">
							<c:out value="Cập nhật đơn hàng thành công!"></c:out>
						</div>
                	</div>
                </c:if>
                <!-- /.row -->
                <!-- <div class="row">
                    <div class="col-sm-12 add-button">
                        <button type="button" class="btn btn-primary">Thêm sách mới</button>
                    </div>
                </div> -->
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
                                                <th class="name-col">Tên khách hàng</th>
                                                <th class="phone-col">SĐT</th>
                                                <th class="email-col">Email khách hàng</th>
                                                <th class="short-des-col">Địa chỉ gửi hàng</th>
                                                <th class="short-des-col">Ghi chú</th>
                                                <th class="prices-col">Tổng tiền</th>
                                                <th class="order-status-col">Tình trạng</th>
                                                <th class="created-date-col">Ngày tạo</th>
                                                <th class="options-col">Tùy chọn</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:forEach items="${orderList }" var="order">
                                        		<tr class="">
                                        			<td>${order.id }</td>
                                        			<td>${order.customerName }</td>
                                        			<td>${order.customerPhone }</td>
                                        			<td>${order.customerEmail }</td>
                                        			<td>${order.customerAddress }</td>
                                        			<td>${order.customerNote }</td>
                                        			<td>${order.orderTotalCost }</td>
                                        			<td>
                                        				<span class="label ${order.orderStatus ne 'Chưa xử lý' ? 'label-success' : 'label-danger' }">
                                        					${order.orderStatus }
                                        				</span>
                                        			</td>
                                        			<td>${order.getFormattedDate(order.createdDate) }</td>
													<td>
														<c:if test="${order.status == true }">
															<a type="button" class="btn btn-info"
															href="${pageContext.request.contextPath}/admin/edit-order/${order.id}">
																Sửa
															</a>		
														
															<button type="button" class="btn btn-danger" 
																data-toggle="modal" data-target="#deleteModal" 
																onclick="deleteOrder(${order.id});">Xóa</button>
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
                    <h3 class="modal-title" id="deleteModalLabel">Xóa đơn hàng</h3>
                    <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button> -->
                </div>

				<div class="modal-body">
					<h4>Bạn có chắc chắn muốn xóa đơn hàng này không?</h4>
				</div>
				<div class="modal-footer">
					<form action="" method="post" id="deleteFormModal">
						<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-danger">Xóa đơn hàng</button>
					</form>
				</div>

			</div>
        </div>
    </div>
    <!-- /modal -->

    <jsp:include page="/WEB-INF/views/admin/layouts/js.jsp"></jsp:include>

</body>

</html>
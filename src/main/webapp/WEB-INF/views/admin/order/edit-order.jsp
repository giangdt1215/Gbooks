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

<title>Cập nhật đơn hàng</title>

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
						<h1 class="page-header">Cập nhật đơn hàng</h1>
					</div>
					<!-- /.col-lg-12 -->
				</div>
				<!-- /.row -->
				<div class="row">
					<div class="col-lg-12">
						<form:form action="${pageContext.request.contextPath }/admin/save-order" method="post"
							modelAttribute="order">
							
							<div class="form-group">
								<label for="orderID">ID</label>
								<form:input type="text" cssClass="form-control"
									name="orderID" id="orderID" placeholder="Id"
									readonly="true" path="id" />
							</div>
							
							<div class="form-group">
								<label for="customerName">Tên khách hàng <span class="required-input">*</span></label>
								<form:input type="text" cssClass="form-control"
									name="customerName" id="customerName"
									path="customerName" readonly="true"/>
							</div>
							
							<div class="form-group">
								<label for="customerEmail">Email khách hàng <span class="required-input">*</span></label>
								<form:input type="text" cssClass="form-control"
									name="customerEmail" id="customerEmail"
									path="customerEmail" readonly="true"/>
							</div>
							
							<div class="form-group">
								<label for="customerPhone">Số điện thoại khách hàng <span class="required-input">*</span></label>
								<form:input type="text" cssClass="form-control"
									name="customerPhone" id="customerPhone"
									path="customerPhone" readonly="true"/>
							</div>
							
							<div class="form-group">
								<label for="customerAddress">Địa chỉ giao hàng <span class="required-input">*</span></label>
								<form:textarea rows="2" class="form-control"
									 name="customerAddress" id="customerAddress" 
									path="customerAddress" readonly="true"></form:textarea>
							</div>
							
							<div class="form-group">
								<label for="customerNote">Ghi chú của khách hàng <span class="required-input">*</span></label>
								<form:textarea rows="3" class="form-control"
									 name="customerNote" id="customerNote" 
									path="customerNote" readonly="true"></form:textarea>
							</div>
							
							<div class="form-group">
								<label>Trạng thái đơn hàng: </label>
								<form:select id="status_option" path="orderStatus">
									<form:options items="${listOrderStatus }"/>
								</form:select>
							</div>
							
							<div class="form-group">
								 <label>Danh sách sản phẩm: </label>
								 <table class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th class="id-col">STT</th>
                                                <th class="">Tên sản phẩm</th>
                                                <th class="">Số lượng</th>
                                                <th class="">Đơn giá</th>
                                                <th class="">Tạm tính</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:forEach items="${order.orderDetails }" var="orderDetail"
                                        	 	varStatus="idx">
                                        		<tr class="">
                                        			<td>${idx.index + 1 }</td>
                                        			<td>${orderDetail.product.name }</td>
                                        			<td>${orderDetail.productQuantity }</td>
                                        			<td>${orderDetail.productPrice }</td>
                                        			<td>${orderDetail.cost }</td>
                                        		</tr>
                                        	</c:forEach>
                                            <tr>
                                            	<td colspan="4" style="text-align: right;">Tổng tiền</td>
                                            	<td>${order.orderTotalCost }</td>
                                            </tr>
                                        </tbody>
                                    </table>
							
							</div>

							<button type="submit" class="btn btn-primary" id="addBtn">Cập nhật</button>
							<a type="button" href="${pageContext.request.contextPath }/admin/order-mgr"
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
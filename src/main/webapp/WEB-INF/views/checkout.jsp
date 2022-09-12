<!-- sử dụng tiếng việt -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- SPRING FORM -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Thông tin đặt hàng</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- load css -->
    <jsp:include page="/WEB-INF/views/layouts/css.jsp"></jsp:include>
</head>

<body>
<!-- header -->
<jsp:include page="/WEB-INF/views/layouts/header.jsp"></jsp:include>
<!-- /header -->

<!-- NAVIGATION BAR -->
<jsp:include page="/WEB-INF/views/layouts/nav.jsp"></jsp:include>
<!-- /NAVIGATION BAR -->

<!-- Checkout -->
<section class="checkout-wrap">
    <div class="container">
		<c:if test="${sessionScope.GIO_HANG == null ||
									sessionScope.GIO_HANG.cartItems.size() == 0}">
			<h1 style="color: #cf111a; text-align: center; font-weight: 500;">
				<c:out value="Hiện chưa có sản phầm nào trong giỏ hàng!"></c:out>
			</h1>
		</c:if>

		<c:if test="${sessionScope.GIO_HANG != null &&
					sessionScope.GIO_HANG.cartItems.size() > 0}">
			<!-- form -->
	        <form:form action="${pageContext.request.contextPath }/save-order" method="POST" cssClass="form"
	           			modelAttribute="order">
	            <div class="row">
	            
	                <div class="col-lg-8 col-12">
	                    <div class="checkout-form">
	                        <h1>Tạo đơn hàng</h1>
	                        <p>Xin hãy điền thông tin</p>
	                        
	                            <div class="row">
	                                <div class="col-lg-6 col-md-6 col-12">
	                                    <div class="form-group">
	                                        <label for="name">Họ Tên <span>*</span></label>
	                                        <form:input type="text" cssClass="form-control" 
	                                        		id="name" name="name" required="required" path="customerName"/>
	                                    </div>
	                                </div>
	                                <div class="col-lg-6 col-md-6 col-12">
	                                    <div class="form-group">
	                                        <label for="email">Email <span>*</span></label>
	                                        <form:input type="email" cssClass="form-control" 
	                                        		id="email" name="email" required="required" path="customerEmail"/>
	                                    </div>
	                                </div>
	                                <div class="col-lg-6 col-md-6 col-12">
	                                    <div class="form-group">
	                                        <label for="phoneNumber1">Điện Thoại 1 <span>*</span></label>
	                                        <input type="tel" class="form-control" pattern="[0-9]*" value="${phoneNumber1 }"
	                                        		id="phoneNumber1" name="phoneNumber1" required="required"/>
	                                    </div>
	                                </div>
	                                <div class="col-lg-6 col-md-6 col-12">
	                                    <div class="form-group">
	                                        <label for="phoneNumber2">Điện Thoại 2</label>
	                                        <input type="tel" pattern="[0-9]*" class="form-control" value="${phoneNumber2 }"
	                                        		id="phoneNumber2" name="phoneNumber2">
	                                    </div>
	                                </div>
	                                
	                                <!-- <div class="col-lg-6 col-md-6 col-12">
	                                    <div class="form-group">
	                                        <label for="state">Tỉnh/Thành phố <span>*</span></label>
	                                        <select name="state" class="form-control" id="state" disabled="disabled">
	                                            <option value="HCM">TP Hồ Chí Minh</option>
	                                            <option value="HN">Hà Nội</option>
	                                            <option value="AG">An Giang</option>
	                                            <option value="BR-VT">Bà Rịa - Vũng Tàu</option>
	                                            <option value="BG">Bắc Giang</option>
	                                            <option value="BK">Bắc Kạn</option>
	                                            <option value="BL">Bạc Liêu</option>
	                                            <option value="BN">Bắc Ninh</option>
	                                            <option value="BTre">Bến Tre</option>
	                                            <option value="BD">Bình Định</option>
	                                            <option value="BDuong">Bình Dương</option>
	                                            <option value="BP">Bình Phước</option>
	                                            <option value="BThuan">Bình Thuận</option>
	                                            <option value="CM">Cà Mau</option>
	                                            <option value="CB">Cao Bằng</option>
	                                            <option value="DL">Đắk Lắk</option>
	                                            <option value="DN">Đắk Nông</option>
	                                            <option value="DB">Điện Biên</option>
	                                            <option value="DNai">Đồng Nai</option>
	                                            <option value="DT">Đồng Tháp</option>
	                                            <option value="GL">Gia Lai</option>
	                                            <option value="HG">Hà Giang</option>
	                                            <option value="HNam">Hà Nam</option>
	                                            <option value="HT">Hà Tĩnh</option>
	                                            <option value="HD">Hải Dương</option>
	                                            <option value="HG">Hậu Giang</option>
	                                            <option value="HB">Hòa Bình</option>
	                                            <option value="HY">Hưng Yên</option>
	                                            <option value="KH">Khánh Hòa</option>
	                                            <option value="KG">Kiên Giang</option>
	                                            <option value="KT">Kon Tum</option>
	                                            <option value="LC">Lai Châu</option>
	                                            <option value="LD">Lâm Đồng</option>
	                                            <option value="LS">Lạng Sơn</option>
	                                            <option value="LC">Lào Cai</option>
	                                        </select>
	                                    </div>
	                                </div>
	                                <div class="col-lg-6 col-md-6 col-12">
	                                    <div class="form-group">
	                                        <label for="district">Quận/Huyện <span>*</span></label>
	                                        <select name="district" class="form-control" id="district" disabled="disabled">
	                                            <option value="HCM">TP Hồ Chí Minh</option>
	                                            <option value="HN">Hà Nội</option>
	                                            <option value="AG">An Giang</option>
	                                            <option value="BR-VT">Bà Rịa - Vũng Tàu</option>
	                                            <option value="BG">Bắc Giang</option>
	                                            <option value="BK">Bắc Kạn</option>
	                                            <option value="BL">Bạc Liêu</option>
	                                            <option value="BN">Bắc Ninh</option>
	                                            <option value="BTre">Bến Tre</option>
	                                            <option value="BD">Bình Định</option>
	                                            <option value="BDuong">Bình Dương</option>
	                                            <option value="BP">Bình Phước</option>
	                                            <option value="BThuan">Bình Thuận</option>
	                                            <option value="CM">Cà Mau</option>
	                                            <option value="CB">Cao Bằng</option>
	                                            <option value="DL">Đắk Lắk</option>
	                                            <option value="DN">Đắk Nông</option>
	                                            <option value="DB">Điện Biên</option>
	                                            <option value="DNai">Đồng Nai</option>
	                                            <option value="DT">Đồng Tháp</option>
	                                            <option value="GL">Gia Lai</option>
	                                            <option value="HG">Hà Giang</option>
	                                            <option value="HNam">Hà Nam</option>
	                                            <option value="HT">Hà Tĩnh</option>
	                                            <option value="HD">Hải Dương</option>
	                                            <option value="HG">Hậu Giang</option>
	                                            <option value="HB">Hòa Bình</option>
	                                            <option value="HY">Hưng Yên</option>
	                                            <option value="KH">Khánh Hòa</option>
	                                            <option value="KG">Kiên Giang</option>
	                                            <option value="KT">Kon Tum</option>
	                                            <option value="LC">Lai Châu</option>
	                                            <option value="LD">Lâm Đồng</option>
	                                            <option value="LS">Lạng Sơn</option>
	                                            <option value="LC">Lào Cai</option>
	                                        </select>
	                                    </div>
	                                </div> -->
	                                
	                                <div class="col-12">
	                                    <div class="form-group">
	                                        <label for="address">Địa Chỉ Nhận Hàng <span>*</span></label>
	                                        <form:input type="text" cssClass="form-control"
	                                        		id="address" name="address" required="required" path="customerAddress"/>
	                                    </div>
	                                </div>
	                                 <div class="col-12">
			                            <div class="form-group">
											<label for="contact-content">Ghi chú</label>
											<form:textarea rows="4" cssClass="form-control"
												name="order-note" id="order-note"
												placeholder="Nhập ghi chú (nếu có)" path="customerNote"></form:textarea>
										</div>
									</div>
	                            </div>
	                 
	                    </div>
	                </div>
	
	                <div class="col-lg-4 col-12">
	                    <div class="order-detail">
	                        <div class="widget">
	                            <h1>ĐƠN HÀNG</h1>
	                            <div class="content">
	                                <ul>
	                                    <li>
	                                        Tạm tính:
	                                        <span><fmt:formatNumber type="number" 
		         								maxFractionDigits="3" value="${sessionScope.GIO_HANG.getCost()}" /><sup>đ</sup></span>
	                                    </li>
	                                    <li>
	                                        Phí vận chuyển:
	                                        <c:if test="${sessionScope.GIO_HANG.getCost() < sessionScope.GIO_HANG.getShipCondition() }">
												<span><fmt:formatNumber type="number"
													maxFractionDigits="3"
													value="${sessionScope.GIO_HANG.getShipFee()}" /><sup>đ</sup></span>
											</c:if>
											<c:if test="${sessionScope.GIO_HANG.getCost() >= sessionScope.GIO_HANG.getShipCondition() }">
												<span>Miễn phí</span>
											</c:if>
	                                    </li>
	                                    <li class="last">
	                                        Thành tiền:
	                                        <span style="font-weight: bold;"><fmt:formatNumber type="number" 
		         								maxFractionDigits="3" value="${sessionScope.GIO_HANG.getTotalCost()}" /><sup>đ</sup></span>
	                                    </li>
	                                </ul>
	                            </div>
	                        </div>
	
	                        <div class="widget">
	                            <h1>HÌNH THỨC THANH TOÁN</h1>
	                            <div class="content">
	                                <div class="checkbox">
	                                    <label for="1">
	                                    	<input type="radio" name="payType" id="1" value="cod" checked>
	                                        Thanh toán khi nhận hàng (COD)
	                                    </label>
	                                </div>
	                            </div>
	                        </div>
	
	                        <div class="widget check-button">
	                            <div class="content">
	                                <div class="button">
	                                    <input type="submit" value="ĐẶT HÀNG" class="submit">
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            
	            </div>
	        </form:form>
	        <!-- /form -->
        </c:if>
        </div>
    </section>
    <!-- /Checkout -->

	
	<c:if test="${sessionScope.GIO_HANG == null ||
					sessionScope.GIO_HANG.cartItems.size() == 0}">
		<section class="error-footer">
	</c:if>
	
    <!-- dich-vu -->
	<jsp:include page="/WEB-INF/views/layouts/services.jsp"></jsp:include>
	<!-- /dich-vu -->

    <!-- footer -->
    <jsp:include page="/WEB-INF/views/layouts/footer.jsp"></jsp:include>
    <!-- /footer -->

	<c:if test="${sessionScope.GIO_HANG == null ||
					sessionScope.GIO_HANG.cartItems.size() == 0}">
		</section>
	</c:if>

    <!-- load script -->
    <jsp:include page="/WEB-INF/views/layouts/js.jsp"></jsp:include>
</body>

</html>
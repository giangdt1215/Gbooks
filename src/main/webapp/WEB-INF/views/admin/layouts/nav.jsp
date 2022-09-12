<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- include nav -->
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="navbar-header">
		<a class="navbar-brand" href="${pageContext.request.contextPath }/admin/home">GBooks Admin</a>
	</div>

	<button type="button" class="navbar-toggle" data-toggle="collapse"
		data-target=".navbar-collapse">
		<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
		<span class="icon-bar"></span> <span class="icon-bar"></span>
	</button>

	<ul class="nav navbar-nav navbar-left navbar-top-links">
		<li><a href="${pageContext.request.contextPath }/admin/home"><i class="fa fa-home fa-fw"></i> Website</a></li>
	</ul>

	<ul class="nav navbar-right navbar-top-links">
		<li class="dropdown"><a class="dropdown-toggle"
			data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i>
				MyAdmin <b class="caret"></b>
		</a>
			<ul class="dropdown-menu dropdown-user">
				<!-- <li><a href="#"><i class="fa fa-user fa-fw"></i> User
						Profile</a></li>
				<li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a></li> -->
				<!-- <li class="divider"></li> -->
				<li><a href="${pageContext.request.contextPath }/logout"><i
						class="fa fa-sign-out fa-fw"></i> Logout</a></li>
			</ul></li>
	</ul>
	<!-- /.navbar-top-links -->

	<div class="navbar-default sidebar" role="navigation">
		<div class="sidebar-nav navbar-collapse">
			<ul class="nav" id="side-menu">
				<!-- <li class="sidebar-search">
					<div class="input-group custom-search-form">
						<input type="text" class="form-control" placeholder="Search...">
						<span class="input-group-btn">
							<button class="btn btn-primary" type="button">
								<i class="fa fa-search"></i>
							</button>
						</span>
					</div> /input-group
				</li> -->
				<%-- <li><a href="${pageContext.request.contextPath }/admin/home" 
						class="${sessionScope.navAdminActive eq 'nav_admin_home' ? 'active' : '' }">
						<i class="fa fa-dashboard fa-fw"></i> Trang chủ</a></li> --%>
				<li><a href="${pageContext.request.contextPath }/admin/order-mgr"
				        class="${sessionScope.navAdminActive eq 'nav_admin_order' ? 'active' : '' }">
				        <i class="fa fa-table fa-fw"></i>
						Quản lý đơn hàng</a></li>
				<li><a href="${pageContext.request.contextPath }/admin/category-mgr"
				        class="${sessionScope.navAdminActive eq 'nav_admin_category' ? 'active' : '' }">
				        <i class="fa fa-table fa-fw"></i>
						Quản lý danh mục sách</a></li>
				<li><a href="${pageContext.request.contextPath }/admin/book-mgr"
				        class="${sessionScope.navAdminActive eq 'nav_admin_book' ? 'active' : '' }">
				        <i class="fa fa-table fa-fw"></i>
						Quản lý sách</a></li>
				
				<li><a href="${pageContext.request.contextPath }/admin/news-mgr"
				        class="${sessionScope.navAdminActive eq 'nav_admin_news' ? 'active' : '' }">
						<i class="fa fa-table fa-fw"></i>
						Quản lý tin tức</a></li>
				<li><a href="${pageContext.request.contextPath }/admin/acc-mgr"
				        class="${sessionScope.navAdminActive eq 'nav_admin_account' ? 'active' : '' }">
						<i class="fa fa-table fa-fw"></i>
						Quản lý tài khoản</a></li>
				<li><a href="${pageContext.request.contextPath }/admin/contact-mgr"
						class="${sessionScope.navAdminActive eq 'nav_admin_contact' ? 'active' : '' }">
						<i class="fa fa-table fa-fw"></i>
						Quản lý liên hệ</a></li>
				<li><a href="${pageContext.request.contextPath }/admin/slider-mgr"
						class="${sessionScope.navAdminActive eq 'nav_admin_slider' ? 'active' : '' }">
						<i class="fa fa-table fa-fw"></i>
						Quản lý slider</a></li>
				<li>
					<a href="#"><i class="fa fa-info fa-fw"></i> Thông tin khác<span class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li>
							<a href="${pageContext.request.contextPath }/admin/gioi-thieu"
								class="${sessionScope.navAdminActive eq 'nav_admin_gioi_thieu' ? 'active' : '' }">
									Giới thiệu</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath }/admin/cs-van-chuyen"
								class="${sessionScope.navAdminActive eq 'nav_admin_van_chuyen' ? 'active' : '' }">
									Chính sách vận chuyển</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath }/admin/cs-bao-mat"
								class="${sessionScope.navAdminActive eq 'nav_admin_bao_mat' ? 'active' : '' }">
									Chính sách bảo mật</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath }/admin/cs-doi-tra-hoan-tien"
							  	class="${sessionScope.navAdminActive eq 'nav_admin_doi_tra_hoan_tien' ? 'active' : '' }">
							  	Chính sách đổi trả - hoàn tiền</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath }/admin/quy-dinh-su-dung"
							   	class="${sessionScope.navAdminActive eq 'nav_admin_quy_dinh_su_dung' ? 'active' : '' }">
							   		Quy định sử dụng</a>
						</li>
					</ul></li>
			</ul>
		</div>
	</div>
</nav>
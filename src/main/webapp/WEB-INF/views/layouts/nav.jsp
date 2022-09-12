<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<nav class="sticky-top">
	<div class="container">
		<ul>
			<li><a href="${pageContext.request.contextPath }/home"
					class="${sessionScope.navActive eq 'nav_home' ? 'nav-active' : '' }">TRANG CHỦ</a>
			</li>
			<li><a href="${pageContext.request.contextPath }/gioi-thieu"
					class="${sessionScope.navActive eq 'nav_gioi_thieu' ? 'nav-active' : '' }">GIỚI THIỆU</a></li>
			<li>
				<a href="${pageContext.request.contextPath }/list-books" 
					class="${sessionScope.navActive eq 'nav_list_books' ? 'nav-active' : '' }">KHO SÁCH
				 <span><i class="fas fa-caret-down"></i></span>
				</a>
				${navCategories }
				<%-- <ul>
					<li><a href="#">Sách Ngoại Ngữ</a></li>
					<li><a href="#">Sách Thiếu Nhi</a></li>
					<li><a href="#">Sách Kinh Doanh <span class="fa fa-plus"></span></a>
						<ul>
							<li><a href="#">sublink 1</a>
								<ul>
									<li><a href="#">1.1</a></li>
									<li><a href="#">1.2</a></li>
									<li><a href="#">1.3</a></li>
								</ul>
							</li>
							<li><a href="#">sublink 2</a></li>
							<li><a href="#">sublink 3</a></li>
						</ul>
					</li>
					<li><a href="#">Sách Kỹ Năng - Sống Đẹp</a></li>
					<li><a href="#">Sách Văn Học</a></li>
					<li><a href="#">Sách Từ Điển</a></li>
					<li><a href="#">Sách Tâm Lý - Giới Tính</a></li>
					<li><a href="${pageContext.request.contextPath }/list-books">Xem Thêm</a></li>
				</ul> --%>
			</li>
			<li><a href="${pageContext.request.contextPath }/news" 
				class="${sessionScope.navActive eq 'nav_news' ? 'nav-active' : '' }">TIN TỨC</a></li>
			<li><a href="${pageContext.request.contextPath }/contact" 
			    class="${sessionScope.navActive eq 'nav_contact' ? 'nav-active' : '' }">LIÊN HỆ</a></li>
		</ul>
	</div>
</nav>
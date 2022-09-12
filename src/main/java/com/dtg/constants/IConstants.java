package com.dtg.constants;

import java.math.BigDecimal;

public interface IConstants {

	public static final String UPLOAD_DIR = "E:\\NewEclipseWorkspace\\FinalProject\\upload";
	public static final String UPLOAD_DIR_CONF = "E:/NewEclipseWorkspace/FinalProject/upload/";
	
	public static final String CS_BAO_MAT_TITLE = "Chính sách bảo mật";
	public static final String CS_VAN_CHUYEN_TITLE = "Chính sách vận chuyển";
	public static final String CS_DOI_TRA_TITLE = "Chính sách đổi trả - hoàn tiền";
	public static final String QUY_DINH_SU_DUNG_TITLE = "Quy định sử dụng";
	public static final String GIOI_THIEU_TITLE = "Giới thiệu";
	
	public static final String ROLE_USER = "USER";
	public static final String ROLE_ADMIN = "ADMIN";
	
	public static final Integer SUCCESS_STATUS_CODE = 200;
	
	public static final String ERROR_MSG = "Hệ thống gặp sự cố, mong quý khách quay lại sau!";
	
	public static final Integer PRODUCT_LIMIT_IN_NEWS_PAGE = 5;
	public static final Integer NEWS_HOME_LIMIT = 3;
	public static final Integer BOOKS_HOME_LIMIT = 8;
	public static final Integer BOOKS_HOME_MIN = 4;
	public static final Integer SLIDER_AMOUNT_MAX = 2;
	public static final Integer SLIDER_AMOUNT_MIN = 1;
	public static final Integer SLIDER_AMOUNT_ZERO = 0;
	
	public static final String NAV_ACTIVE_ATT = "navActive";
	public static final String NAV_LIST_BOOKS_ACTIVE = "nav_list_books";
	public static final String NAV_CART_ACTIVE = "nav_cart";
	public static final String NAV_CHECKOUT_ACTIVE = "nav_checkout";
	public static final String NAV_CONTACT_ACTIVE = "nav_contact";
	public static final String NAV_ERROR_ACTIVE = "nav_error";
	public static final String NAV_HOME_ACTIVE = "nav_home";
	public static final String NAV_NEWS_ACTIVE = "nav_news";
	public static final String NAV_INTRO_ACTIVE = "nav_gioi_thieu";
	public static final String NAV_NONE_ACTIVE = "NONE";
	
	public static final Integer NO_SELECTED_CATEGORY = -1;
	
	public static final String CART_ATT = "GIO_HANG";
	public static final BigDecimal SHIP_CONDITION = new BigDecimal(150000);
	public static final BigDecimal SHIP_FEE = new BigDecimal(50000);
	public static final Integer MAX_BUY_AMOUNT = 10;
	
	public static final String USERNAME_PATTERN = "^[a-zA-Z_]{1}[\\w]*";
	public static final String EMAIL_PATTERN = 
			"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$";
	public static final String NUMBER_FORMAT_PATTERN = "###,###.###";
	public static final String PHONE_DELIMITER = ";";
	public static final String PHONE_PATTERN = "[0-9]{9,11}";
	
	public static final String DELIMITER = "|||";
	
	//SORT AND PAGINATION
	public static final int PRODUCT_PAGE_SIZE = 12;
	public static final int DEFAULT_CURRENT_PAGE = 1;
	public static final String DEFAULT_KEYWORD = "";
	public static final String DEFAULT_SORT_FIELD = "id";
	public static final String DEFAULT_SORT_DIRECTION = "asc";
	public static final String SORT_DIRECTION_ASC = "asc";
	public static final String SORT_DIRECTION_DESC = "desc";
	
	public static final String DEFAULT_FILTER_PRICE = "0ToMax";
	public static final String FILTER_PRICE_0_TO_100 = "0To100";
	public static final String FILTER_PRICE_100_TO_200 = "100To200";
	public static final String FILTER_PRICE_200_TO_300 = "200To300";
	public static final String FILTER_PRICE_300_TO_400 = "300To400";
	public static final String FILTER_PRICE_400_TO_500 = "400To500";
	public static final String FILTER_PRICE_500_TO_MAX = "500ToMax";
}

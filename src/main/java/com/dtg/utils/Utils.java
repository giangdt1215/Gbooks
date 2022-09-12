package com.dtg.utils;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.dtg.constants.IConstants;
import com.dtg.entities.User;

public class Utils implements IConstants{
	
	public static final String checkUserInput(User user, String passwordConfirm) {
		String username = user.getUsername();
		
		if(username == null || username.isEmpty()) {
			return "Cần nhập tên đăng nhập!|||txtUser";
		} else if(username.trim().length() < 5) {
			return "Tên đăng nhập cần trên 5 ký tự!|||txtUser";
		} else if(!username.matches(USERNAME_PATTERN)) {
			return "Tên đăng nhập chỉ chứa các ký tự chữ cái, số và phải bắt đầu bằng ký tự chữ cái!|||txtUser";
		}
		
		String fullName = user.getFullName();
		if(fullName == null || fullName.trim().isEmpty()) {
			return "Họ tên không được để trống!|||txtName";
		}
		
		String password = user.getPassword();
		if(password == null || password.isEmpty()) {
			return "Cần nhập mật khẩu!|||txtPass";
		} else if(password.trim().length() < 8){
			return "Mật khẩu cần trên 8 ký tự!|||txtPass";
		} else if(!password.equals(passwordConfirm)) {
			return "Mật khẩu xác nhận không đúng!|||txtPassConfirm";
		}
		
		String email = user.getEmail();
		if(email == null || email.trim().isEmpty()) {
			return "Cần nhập email!|||txtEmail";
		} else {
			if(!email.matches(EMAIL_PATTERN)) {
				return "Email không hợp lệ!|||txtEmail";
			}
		}
		
		String phone = user.getPhone();
		if(phone != null && !(phone.trim().isEmpty())) {
			if(!phone.matches(PHONE_PATTERN)) {
				return "Số điện thoại không hợp lệ! VD: 0912345678|||txtPhone";
			}
		}
		
		String address = user.getAddress();
		if(address == null || address.trim().isEmpty()) {
			return "Cần nhập địa chỉ!|||txtAddress";
		}
		
		return null;
	}
	
	public static String encode(String str) {
		BCryptPasswordEncoder passEncoder = new BCryptPasswordEncoder(10);
		return passEncoder.encode(str);
	}
	
	/**
	 * getListPaging lấy listPaging để phân trang
	 * @param totalUser giá trị tổng số bản ghi
	 * @param currentPage giá trị trang hiện tại
	 * @return listPaging list các trang cần phân trang
	 */
	public static List<Integer> getListPaging(int totalPage, int currentPage){
		List<Integer> listPaging = new ArrayList<Integer>();
		// lấy tổng số page
		if (currentPage <= totalPage) {
			int pageGroup = currentPage / 5;
			int soDu = currentPage % 5;
			if (soDu == 0) {
				pageGroup--;
			}
			int page;
			for (int i = 1; i <= 5; i++) {
				page = (pageGroup * 5) + i;
				if (page <= totalPage) {
					listPaging.add(page);
				}
			}
		}
		return listPaging;
	}
}

package com.dtg.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class SuccessController extends BaseController {

	@RequestMapping(value = {"/success"}, method = RequestMethod.GET)
	public String success(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) {
		String param = request.getParameter("order_success");
		if(param != null && param.equals("ok")) {
			String successMsg = "Bạn đã đặt hàng thành công!";
			model.addAttribute("successMsg", successMsg);
			HttpSession session = request.getSession();
			session.removeAttribute("GIO_HANG");
		}
		
		param = request.getParameter("register_success");
		if(param != null && param.equals("ok")) {
			String successMsg = "Bạn đã đăng ký thành công!";
			model.addAttribute("successMsg", successMsg);
		}
		return "success";
	}
}

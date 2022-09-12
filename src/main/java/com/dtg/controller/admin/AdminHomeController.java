package com.dtg.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dtg.entities.Order;
import com.dtg.repositories.OrderRepo;

@Controller
@RequestMapping(value = "/admin")
public class AdminHomeController {
	
	@Autowired
	private OrderRepo orderRepo;

	@RequestMapping(value = {"", "/home"}, method = RequestMethod.GET)
	public String adminIndex(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
//		HttpSession session = request.getSession();
//		session.setAttribute("navAdminActive", "nav_admin_home");
//		return "admin/index";
		HttpSession session = request.getSession();
		session.setAttribute("navAdminActive", "nav_admin_order");
		
		List<Order> orderList = orderRepo.findByOrderByOrderStatusAscCreatedDateDesc();
		model.addAttribute("orderList", orderList);
		
		return "admin/order/order-manager";
	}
}

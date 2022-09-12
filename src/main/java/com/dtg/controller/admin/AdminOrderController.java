package com.dtg.controller.admin;

import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dtg.entities.Order;
import com.dtg.repositories.OrderRepo;

@Controller
@RequestMapping(value = { "/admin" })
public class AdminOrderController {

	private String[] listOrderStatus = {"Chưa xử lý", "Đang vận chuyển", "Đã giao hàng"};
	
	@Autowired
	private OrderRepo orderRepo;

	@RequestMapping(value = {"/order-mgr"}, method = RequestMethod.GET)
	public String orderManagement(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute("navAdminActive", "nav_admin_order");
		
		List<Order> orderList = orderRepo.findByOrderByOrderStatusAscCreatedDateDesc();
		model.addAttribute("orderList", orderList);
		
		return "admin/order/order-manager";
	}

	@GetMapping(value = {"/edit-order/{orderId}"})
	public String editOrder(@PathVariable("orderId") Integer orderId, ModelMap model, 
			HttpServletRequest request, HttpServletResponse response) {
		Order order = orderRepo.getOne(orderId);
		
		model.addAttribute("order", order);
		model.addAttribute("listOrderStatus", listOrderStatus);
		
		return "admin/order/edit-order";
	}
	
	@PostMapping(value = "/save-order")
	public String saveOrder(@ModelAttribute("order") Order order,
			ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		if(order.getId() != null) {
			Order orderInDatabase = orderRepo.getOne(order.getId());
			order.setOrderTotalCost(orderInDatabase.getOrderTotalCost());
			order.setUser(orderInDatabase.getUser());
			order.setCreatedDate(orderInDatabase.getCreatedDate());
			order.setOrderDetails(orderInDatabase.getOrderDetails());
		}
		
		order.setUpdatedDate(LocalDateTime.now());
		order.setStatus(Boolean.TRUE);
		orderRepo.save(order);
		
		return "redirect:/admin/order-mgr?save_order_success";
	}
	
	@RequestMapping(value = {"/delete-order/{orderId}"}, method = RequestMethod.POST)
	public String deleteOrder(@PathVariable("orderId") int orderId, 
			final ModelMap model, final HttpServletRequest request, final HttpServletResponse response) {
		Order order = orderRepo.getOne(orderId);
		order.setUpdatedDate(LocalDateTime.now());
		order.setStatus(Boolean.FALSE);
		
		orderRepo.save(order);
		return "redirect:/admin/order-mgr?save_order_success";
	}
}

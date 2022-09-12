package com.dtg.controller;

import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dtg.constants.IConstants;
import com.dtg.entities.Order;
import com.dtg.entities.User;
import com.dtg.repositories.OrderRepo;
import com.dtg.services.UserService;
import com.dtg.utils.Utils;

@Controller
public class UserController extends BaseController implements IConstants{
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private OrderRepo orderRepo;

	@GetMapping(value = "/account/user-info")
	public String userInfo(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute(NAV_ACTIVE_ATT, NAV_NONE_ACTIVE);
		
		User user = null;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(!(authentication instanceof AnonymousAuthenticationToken)) {
			if(authentication.getPrincipal() instanceof UserDetails) {
				user = (User) authentication.getPrincipal();
			}
		} else {
			return "redirect:/login";
		}
		user = userService.findUserById(user.getId());
		model.addAttribute("user", user);
		
		return "user-info";
	}
	
	@PostMapping(value = "/account/update-user")
	public String updateUserInfo(@ModelAttribute("user") User user,
			@RequestParam("newPassword") String newPassword, final ModelMap model,
			final HttpServletRequest request, final HttpServletResponse response) {

		User userInDatabase = userService.findUserById(user.getId());
		user.setPassword(userInDatabase.getPassword());
		user.setUsername(userInDatabase.getUsername());
		user.setRoles(userInDatabase.getRoles());
		user.setCreatedDate(userInDatabase.getCreatedDate());
		
		String message = null;
		if(newPassword == null || newPassword.trim().isEmpty()) {
			message = Utils.checkUserInput(user, user.getPassword());
		} else {
			user.setPassword(newPassword);
			message = Utils.checkUserInput(user, newPassword);
		}
		
		if(message != null) {
			model.addAttribute("user", user);
			
			String errorMsg = message.substring(0, message.indexOf(DELIMITER));
			model.addAttribute("errorMsg", errorMsg);
			
			String focusOption = message.substring(message.indexOf(DELIMITER) + DELIMITER.length());
			model.addAttribute("focusOption", focusOption);
			return "user-info";
		} else {
			user.setUpdatedDate(LocalDateTime.now());
			if(userService.updateUser(user) == null)
				return "redirect:/errors";
		}
		
		return "redirect:/account/user-info?update_success=ok";
	}
	
	@GetMapping(value = "/account/user-order")
	public String userOrder(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute(NAV_ACTIVE_ATT, NAV_NONE_ACTIVE);
		
		User user = null;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(!(authentication instanceof AnonymousAuthenticationToken)) {
			if(authentication.getPrincipal() instanceof UserDetails) {
				user = (User) authentication.getPrincipal();
			}
		} else {
			return "redirect:/login";
		}
		
		List<Order> orderList = orderRepo.findByUserIdOrderByOrderStatusAscCreatedDateDesc(user.getId());
		model.addAttribute("orderList", orderList);
		
		return "user-order";
	}
	
	@GetMapping(value = "/account/user-order/order-detail/{orderId}")
	public String orderDetail(@PathVariable("orderId") Integer orderId,
			final ModelMap model, final HttpServletRequest request, final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute(NAV_ACTIVE_ATT, NAV_NONE_ACTIVE);
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(!(authentication instanceof AnonymousAuthenticationToken)) {
//			if(authentication.getPrincipal() instanceof UserDetails) {
//				user = (User) authentication.getPrincipal();
//			}
		} else {
			return "redirect:/login";
		}
		
		model.addAttribute("order", orderRepo.getOne(orderId));
		model.addAttribute("shipCondition", SHIP_CONDITION);
		model.addAttribute("shipFee", SHIP_FEE);
		
		return "order-detail";
	}
}

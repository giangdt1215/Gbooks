package com.dtg.controller;

import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dtg.constants.IConstants;
import com.dtg.entities.User;
import com.dtg.services.UserService;
import com.dtg.utils.Utils;

@Controller
public class LoginController implements IConstants{
	
	@Autowired
	private UserService userService;

	@RequestMapping(value = { "/login" }, method = RequestMethod.GET)
	public String login(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response) {
		
		//check authenticate
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(!(authentication instanceof AnonymousAuthenticationToken)) {
			return "redirect:/home";
		}
		
		model.addAttribute("user", new User());
		return "login";
	}

	@RequestMapping(value = { "/loginValidate" }, method = RequestMethod.POST)
	public String loginValidate(@ModelAttribute("user") User user, final ModelMap model,
			final HttpServletRequest request, final HttpServletResponse response) {
		return "login";
	}

	@GetMapping(value = "/register")
	public String register(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response) {

		// check authenticated
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
			return "redirect:/home";
		}
		
		model.addAttribute("user", new User());
		model.addAttribute("phonePattern", PHONE_PATTERN);
		model.addAttribute("focusOption", "txtUser");
		return "register";
	}

	@PostMapping(value = "/perform-register")
	public String registerValidate(@ModelAttribute("user") User user,
			@RequestParam("passwordConfirm") String passwordConfirm, final ModelMap model,
			final HttpServletRequest request, final HttpServletResponse response) {

		String message = Utils.checkUserInput(user, passwordConfirm);
		List<User> listUser = userService.findByUsername(user.getUsername());
		if(listUser.size() > 0)
			message = "Username đã tồn tại!|||txtUser";
		if(message != null) {
			model.addAttribute("user", user);
			
			String errorMsg = message.substring(0, message.indexOf(DELIMITER));
			model.addAttribute("errorMsg", errorMsg);
			
			String focusOption = message.substring(message.indexOf(DELIMITER) + DELIMITER.length());
			model.addAttribute("focusOption", focusOption);
			return "register";
		} else {
			user.setCreatedDate(LocalDateTime.now());
			if(userService.registerUser(user, ROLE_USER) == null)
				return "redirect:/errors";
		}
		
		return "redirect:/success?register_success=ok";
	}
}

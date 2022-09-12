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

import com.dtg.entities.User;
import com.dtg.repositories.UserRepo;

@Controller
@RequestMapping(value = {"/admin"})
public class AdminAccountController {

	@Autowired
	private UserRepo userRepo;
	
	@RequestMapping(value = {"/acc-mgr"}, method = RequestMethod.GET)
	public String accountManagement(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute("navAdminActive", "nav_admin_account");
		
		List<User> userList = userRepo.findAll();
		model.addAttribute("userList", userList);
		return "admin/account/acc-manager";
	}
}

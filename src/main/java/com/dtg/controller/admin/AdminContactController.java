package com.dtg.controller.admin;

import java.time.LocalDateTime;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dtg.entities.Contact;
import com.dtg.repositories.ContactRepo;

@Controller
@RequestMapping(value = { "/admin" })
public class AdminContactController {

	@Autowired
	private ContactRepo contactRepo;

	@RequestMapping(value = { "/contact-mgr" }, method = RequestMethod.GET)
	public String contactManagement(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute("navAdminActive", "nav_admin_contact");
		
		model.addAttribute("contactList", contactRepo.findAll());
		return "admin/contact/contact-manager";
	}

	@RequestMapping(value = { "/delete-contact/{contactId}" }, method = RequestMethod.POST)
	public String deleteContact(@PathVariable("contactId") int contactId, ModelMap model, HttpServletRequest request,
			HttpServletResponse response) {
		Contact contact = contactRepo.findById(contactId).get();
		contact.setStatus(Boolean.FALSE);
		contact.setUpdatedDate(LocalDateTime.now());

		contactRepo.save(contact);
		return "redirect:/admin/contact-mgr";
	}
}

package com.dtg.controller;

import java.time.LocalDateTime;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dtg.constants.IConstants;
import com.dtg.dto.AjaxResponse;
import com.dtg.entities.Contact;
import com.dtg.services.ContactService;

@Controller
public class ContactController extends BaseController implements IConstants {

	@Autowired
	private ContactService contactService;

//	@RequestMapping(value = { "contact" }, method = RequestMethod.GET)
//	public String contact(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response) {
//		model.addAttribute("contact", new Contact());
//		return "contact";
//	}

//	@RequestMapping(value = { "saveContact" }, method = RequestMethod.POST)
//	public String saveContact(@ModelAttribute("contact") Contact contact, final ModelMap model,
//			final HttpServletRequest request, final HttpServletResponse response) {
//		String message = "Yêu cầu của bạn đã được gửi cho admin, xin cảm ơn!";
//		model.addAttribute("message", message);
//		return "contact";
//	}

	@RequestMapping(value = "contact", method = RequestMethod.GET)
	public String contact(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute(NAV_ACTIVE_ATT, NAV_CONTACT_ACTIVE);
		return "contact-ajax";
	}

	@RequestMapping(value = "saveContactWithAjax", method = RequestMethod.POST)
	public ResponseEntity<AjaxResponse> saveContactWithAjax(@RequestBody final Contact contact, final ModelMap model,
			final HttpServletRequest request, final HttpServletResponse response) {
		String fullName = contact.getFullName();
		String email = contact.getEmail();
		String contactMessage = contact.getMessage();

		String responseMsg = null;
		if (fullName.isEmpty()) {
			responseMsg = "Bạn cần điền họ tên!";
			return ResponseEntity.ok(new AjaxResponse(responseMsg, 400));
		}
		if (email.isEmpty()) {
			responseMsg = "Bạn cần điền email!";
			return ResponseEntity.ok(new AjaxResponse(responseMsg, 400));
		}
		if (contactMessage.isEmpty()) {
			responseMsg = "Bạn cần điền nội dung!";
			return ResponseEntity.ok(new AjaxResponse(responseMsg, 400));
		}

		contact.setCreatedDate(LocalDateTime.now());
		contact.setStatus(Boolean.TRUE);
		contactService.saveContact(contact);
		responseMsg = "Yêu cầu của " + fullName + " đã được gửi tới Administrator, Xin cảm ơn!";
		return ResponseEntity.ok(new AjaxResponse(responseMsg, 200));
	}
}

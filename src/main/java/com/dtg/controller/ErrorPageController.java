package com.dtg.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dtg.constants.IConstants;

@Controller
public class ErrorPageController extends BaseController implements IConstants{

	@RequestMapping(value = {"/errors"})
	public String errorPage(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute(NAV_ACTIVE_ATT, NAV_ERROR_ACTIVE);
		request.setAttribute("errorMsg", ERROR_MSG);
		return "errors/common";
	}
	
	@RequestMapping(value = {"/404"})
	public String pageNotFound(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute(NAV_ACTIVE_ATT, NAV_ERROR_ACTIVE);
		return "errors/404";
	}
}

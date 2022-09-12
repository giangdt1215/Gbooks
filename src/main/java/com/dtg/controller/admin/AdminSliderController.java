package com.dtg.controller.admin;

import java.io.File;
import java.io.IOException;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.dtg.constants.IConstants;
import com.dtg.entities.SliderImage;
import com.dtg.services.SliderImageService;

@Controller
@RequestMapping(value = "/admin")
public class AdminSliderController implements IConstants {
	
	@Autowired
	private SliderImageService sliderService;

	@GetMapping(value = "/slider-mgr")
	public String sliderManagement(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute("navAdminActive", "nav_admin_slider");
		
		List<SliderImage> slideList = sliderService.findAllByCreatedDateDesc();
		model.addAttribute("slideList", slideList);
		
		return "admin/slider/slider-manager";
	}

	@GetMapping(value = "/add-slide")
	public String addSlide(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response) {
		model.addAttribute("slide", new SliderImage());
		return "admin/slider/add-slide";
	}

	@PostMapping(value = "/save-slide")
	public String saveSlide(@RequestParam(name = "slideImage") MultipartFile slideImage,
			@ModelAttribute("slide") SliderImage slide,
			final ModelMap model,
			final HttpServletRequest request, final HttpServletResponse response)
			throws IllegalStateException, IOException {

		// check slideImage
		if (!slideImage.isEmpty()) {
			// check upload dir
			File slideDir = new File(UPLOAD_DIR + "\\slider");
			if (!slideDir.exists())
				slideDir.mkdirs();

			// get slide image
			File slideImageFile = new File(UPLOAD_DIR + "\\slider\\" + slideImage.getOriginalFilename());
			slideImage.transferTo(slideImageFile);
			slide.setPath("slider/" + slideImage.getOriginalFilename());
		}
		slide.setStatus(Boolean.TRUE);
		slide.setCreatedDate(LocalDateTime.now());
		
		sliderService.saveSlide(slide);
		
		return "redirect:/admin/slider-mgr?save_slide_success";
	}
	
	@PostMapping(value = "/delete-slide/{slideId}")
	public String deleteSlide(@PathVariable("slideId") Integer slideId,
			final ModelMap model,
			final HttpServletRequest request, final HttpServletResponse response) {
		
		SliderImage slide = sliderService.findById(slideId);
		slide.setUpdatedDate(LocalDateTime.now());
		slide.setStatus(Boolean.FALSE);
		
		sliderService.saveSlide(slide);
		return "redirect:/admin/slider-mgr?save_slide_success";
	}
}

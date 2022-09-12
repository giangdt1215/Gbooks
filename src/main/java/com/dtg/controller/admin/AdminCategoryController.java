package com.dtg.controller.admin;

import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dtg.entities.Category;
import com.dtg.repositories.CategoryRepo;
import com.dtg.services.CategoryService;

@Controller
@RequestMapping(value = "/admin")
public class AdminCategoryController {

	@Autowired
	private CategoryRepo categoryRepo;
	
	@Autowired
	private CategoryService categoryService;

	@RequestMapping(value = { "/category-mgr" }, method = RequestMethod.GET)
	public String categoryMgr(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute("navAdminActive", "nav_admin_category");
		
		List<Category> categories = categoryRepo.findAll();
		model.addAttribute("categories", categories);
		return "admin/category/category-manager";
	}

	@RequestMapping(value = { "/add-category" }, method = RequestMethod.GET)
	public String addCategory(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response) {
		List<Category> categories = categoryService.findAllCategoryByStatus(Boolean.TRUE);
		model.addAttribute("categories", categories);
		model.addAttribute("category", new Category());
		return "admin/category/add-category";
	}

	@RequestMapping(value = { "/edit-category/{categoryId}" }, method = RequestMethod.GET)
	public String editCategory(@PathVariable("categoryId") int categoryId, final ModelMap model,
			final HttpServletRequest request, final HttpServletResponse response) {
		List<Category> categories = categoryService.findAllCategoryByStatus(Boolean.TRUE);
		model.addAttribute("categories", categories);

		Category category = categoryRepo.findById(categoryId).get();
		model.addAttribute("category", category);
		return "admin/category/edit-category";
	}

	@RequestMapping(value = { "/save-category" }, method = RequestMethod.POST)
	public String saveCategory(@ModelAttribute("category") Category category, final ModelMap model,
			final HttpServletRequest request, final HttpServletResponse response) {
		//check action insert or update
		if(category.getId() != null) {
			//update
			Category categoryInDatabase = categoryRepo.findById(category.getId()).get();
			category.setCreatedDate(categoryInDatabase.getCreatedDate());
			category.setUpdatedDate(LocalDateTime.now());
		} else {
			//insert
			category.setCreatedDate(LocalDateTime.now());
		}
		
		// nếu không có danh mục cha
		if (category.getParent().getId() == -1) {
			category.setParent(null);
		}
		
		category.setStatus(Boolean.TRUE);

		categoryRepo.save(category);
		return "redirect:/admin/category-mgr?save_category_success";
	}
	
	@RequestMapping(value = {"/delete-category/{categoryId}"}, method = RequestMethod.POST)
	public String deleteCategory(@PathVariable("categoryId") int categoryId, final ModelMap model,
			final HttpServletRequest request, final HttpServletResponse response) {
		Category category = categoryRepo.findById(categoryId).get();
		category.setStatus(Boolean.FALSE);
		category.setUpdatedDate(LocalDateTime.now());
		categoryRepo.save(category);
		
		return "redirect:/admin/category-mgr?save_category_success";
	}
}

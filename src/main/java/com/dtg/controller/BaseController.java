package com.dtg.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.dtg.entities.Category;
import com.dtg.services.CategoryService;

public abstract class BaseController {

	@Autowired
	private CategoryService categoryService;
	
	@ModelAttribute("categories")
	public List<Category> getCategories(){
		return categoryService.findAllCategoryByStatus(Boolean.TRUE);
	}
	
	@ModelAttribute("navCategories")
	public String createNavCategory(HttpServletRequest request) {
		StringBuilder sb = new StringBuilder();
		List<Category> categories = categoryService.findAllCategoryByStatus(Boolean.TRUE);
		sb.append("<ul>");
		for (Category category : categories) {
			if(category.getParent() == null) {
				sb.append("<li><a href='"+ request.getContextPath() + "/list-books/category/" + category.getId() + "'>");
				sb.append(category.getName());
				sb.append("</a>");
				if(category.getChildCategories().size() > 0) {
					sb.append(createSubNavCategory(request, category));
				}
				sb.append("</li>");
			}
		}
		
		sb.append("</ul>");
		return sb.toString();
	}
	
	private String createSubNavCategory(HttpServletRequest request, Category category) {
		StringBuilder sb = new StringBuilder();
		sb.append("<ul>");
		for (Category cat : category.getChildCategories()) {
			if(cat.getStatus()) {
				sb.append("<li><a href='"+ request.getContextPath() + "/list-books/category/" + cat.getId() + "'>");
				sb.append(cat.getName());
				sb.append("</a>");
				if(cat.getChildCategories().size() > 0) {
					sb.append(createSubNavCategory(request, cat));
				}
				sb.append("</li>");
			}
		}
		
		sb.append("</ul>");
		return sb.toString();
	}
}

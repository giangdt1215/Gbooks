package com.dtg.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dtg.constants.IConstants;
import com.dtg.entities.News;
import com.dtg.services.NewsService;
import com.dtg.services.ProductService;
import com.dtg.utils.Utils;

@Controller
public class NewsController extends BaseController implements IConstants{

	@Autowired
	private NewsService newsService;
	
	@Autowired
	private ProductService productService;

	@RequestMapping(value = { "/news" }, method = RequestMethod.GET)
	public String news(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute(NAV_ACTIVE_ATT, NAV_NEWS_ACTIVE);
		
		Page<News> newsPage = newsService.findAllNewsWithPaging(1, 9);
		model.addAttribute("newsList", newsPage.getContent());
		model.addAttribute("currentPage", 1);
		model.addAttribute("totalPages", newsPage.getTotalPages());
		model.addAttribute("listPage", Utils.getListPaging(newsPage.getTotalPages(), 1));
		return "news";
	}
	
	@RequestMapping(value = { "/news/page/{currentPage}" }, method = RequestMethod.GET)
	public String newsWithPaging(@PathVariable("currentPage") Integer currentPage, 
		ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		Page<News> newsPage = newsService.findAllNewsWithPaging(currentPage, 9);
		model.addAttribute("newsList", newsPage.getContent());
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPages", newsPage.getTotalPages());
		model.addAttribute("listPage", Utils.getListPaging(newsPage.getTotalPages(), currentPage));
		return "news";
	}

	@RequestMapping(value = { "/news-details/{newsId}" }, method = RequestMethod.GET)
	public String newsDetails(@PathVariable("newsId") int newsId, ModelMap model, HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute(NAV_ACTIVE_ATT, NAV_NEWS_ACTIVE);
		
		model.addAttribute("news", newsService.findNewsById(newsId));
		model.addAttribute("productList", productService.findAllLatestProduct(PRODUCT_LIMIT_IN_NEWS_PAGE));
		return "news-detail";
	}
}

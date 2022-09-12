package com.dtg.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dtg.constants.IConstants;
import com.dtg.entities.Product;
import com.dtg.entities.SliderImage;
import com.dtg.services.NewsService;
import com.dtg.services.ProductService;
import com.dtg.services.SliderImageService;

@Controller
public class HomeController extends BaseController implements IConstants{
	
	@Autowired
	private NewsService newsService;
	
	@Autowired
	private SliderImageService sliderService;
	
	@Autowired
	private ProductService productService;

	@RequestMapping(value = {"/", "home"}, method = RequestMethod.GET)
	public String index(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
		HttpSession session = request.getSession();
		session.setAttribute(NAV_ACTIVE_ATT, NAV_HOME_ACTIVE);
		
		model.addAttribute("newsList", newsService.findAllLatestNews(NEWS_HOME_LIMIT));
		
		List<SliderImage> slideList = sliderService.findAllByCreatedDateDescAndStatus(Boolean.TRUE);
		model.addAttribute("slideList", slideList);
		
		// xu ly slider book moi phat hanh
		List<Product> bookList = productService.findAllLatestProduct(BOOKS_HOME_LIMIT);
		
		int bookListSize = bookList.size();
		if(bookListSize == BOOKS_HOME_LIMIT)
			model.addAttribute("sliderAmount", SLIDER_AMOUNT_MAX);
		else if(bookListSize >= BOOKS_HOME_MIN && bookListSize < BOOKS_HOME_LIMIT)
			model.addAttribute("sliderAmount", SLIDER_AMOUNT_MIN);
		else
			model.addAttribute("sliderAmount", SLIDER_AMOUNT_ZERO);
		
		model.addAttribute("bookList", bookList);
		
		return "index";
	}
}

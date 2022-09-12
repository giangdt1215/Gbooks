package com.dtg.controller;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dtg.constants.IConstants;
import com.dtg.entities.Product;
import com.dtg.repositories.ProductRepo;
import com.dtg.services.ProductService;
import com.dtg.utils.Utils;

@Controller
public class BookController extends BaseController implements IConstants{

	@Autowired
	private ProductService productService;
	
	@Autowired
	private ProductRepo productRepo;

	@RequestMapping(value = { "/list-books" }, method = RequestMethod.GET)
	public String listBooks(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute(NAV_ACTIVE_ATT, NAV_LIST_BOOKS_ACTIVE);
		modelMap.addAttribute("SELECTED_CATEGORY_ID", NO_SELECTED_CATEGORY);
		return listBooksWithPaginationAndSorting(DEFAULT_CURRENT_PAGE, DEFAULT_SORT_FIELD, DEFAULT_SORT_DIRECTION,
					DEFAULT_KEYWORD, DEFAULT_FILTER_PRICE,
					modelMap, request, response);
	}
	
	@RequestMapping(value = {"/list-books/page/{currentPage}"}, method = RequestMethod.GET)
	public String listBooksWithPaginationAndSorting(@PathVariable("currentPage") Integer currentPage,
			@PathParam("sortField") String sortField, @PathParam("sortDir") String sortDir,
			@PathParam("keyword") String keyword,
			@PathParam("filterPrice") String filterPrice,
			final ModelMap modelMap, final HttpServletRequest request, final HttpServletResponse response) {
		modelMap.addAttribute("SELECTED_CATEGORY_ID", NO_SELECTED_CATEGORY);
		if(sortField == null || sortField.isEmpty()) {
			sortField = DEFAULT_SORT_FIELD;
		}
		if(sortDir == null || sortDir.isEmpty()) {
			sortDir = DEFAULT_SORT_DIRECTION;
		}
		if(keyword == null || keyword.trim().isEmpty()) {
			keyword = DEFAULT_KEYWORD;
		}
		
		BigDecimal minPrice = BigDecimal.ZERO;
		BigDecimal maxPrice = BigDecimal.valueOf(Integer.MAX_VALUE);
		if(filterPrice == null || filterPrice.trim().isEmpty()) {
			filterPrice = DEFAULT_FILTER_PRICE;
		}
		switch (filterPrice) {
			case FILTER_PRICE_0_TO_100:
				minPrice = BigDecimal.ZERO;
				maxPrice = BigDecimal.valueOf(100000);
				break;
			case FILTER_PRICE_100_TO_200:
				minPrice = BigDecimal.valueOf(100000);
				maxPrice = BigDecimal.valueOf(200000);
				break;
			case FILTER_PRICE_200_TO_300:
				minPrice = BigDecimal.valueOf(200000);
				maxPrice = BigDecimal.valueOf(300000);
				break;
			case FILTER_PRICE_300_TO_400:
				minPrice = BigDecimal.valueOf(300000);
				maxPrice = BigDecimal.valueOf(400000);
				break;
			case FILTER_PRICE_400_TO_500:
				minPrice = BigDecimal.valueOf(400000);
				maxPrice = BigDecimal.valueOf(500000);
				break;
			case FILTER_PRICE_500_TO_MAX:
				minPrice = BigDecimal.valueOf(500000);
				maxPrice = BigDecimal.valueOf(Integer.MAX_VALUE);
				break;
			default:
				minPrice = BigDecimal.ZERO;
				maxPrice = BigDecimal.valueOf(Integer.MAX_VALUE);
				break;
		}
		
		Page<Product> productPage = productService.findAllProductByStatus(Boolean.TRUE, currentPage,
				sortField, sortDir, keyword, minPrice, maxPrice);
		modelMap.addAttribute("productList", productPage.getContent());
		
		modelMap.addAttribute("totalPages", productPage.getTotalPages());
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("sortField", sortField);
		modelMap.addAttribute("sortDir", sortDir);
		modelMap.addAttribute("keyword", keyword);
		modelMap.addAttribute("categoryId", NO_SELECTED_CATEGORY);
		modelMap.addAttribute("filterPrice", filterPrice);
		modelMap.addAttribute("listPage", Utils.getListPaging(productPage.getTotalPages(), currentPage));
		return "listBooks";
	}
	
	@RequestMapping(value = {"/search"}, method = RequestMethod.GET)
	public String search( 
			@PathParam("sortField") String sortField, @PathParam("sortDir") String sortDir,
			@PathParam("keyword") String keyword,
			final ModelMap modelMap, final HttpServletRequest request, final HttpServletResponse response){

		return searchWithPaging(DEFAULT_CURRENT_PAGE, sortField, sortDir, keyword, modelMap, request, response);
	}
	
	@RequestMapping(value = {"/search/page/{currentPage}"}, method = RequestMethod.GET)
	public String searchWithPaging(@PathVariable("currentPage") Integer currentPage, 
			@PathParam("sortField") String sortField, @PathParam("sortDir") String sortDir,
			@PathParam("keyword") String keyword,
			final ModelMap modelMap, final HttpServletRequest request, final HttpServletResponse response){
		if(currentPage == null) {
			currentPage = DEFAULT_CURRENT_PAGE;
		}
		modelMap.addAttribute("action", "search");		
		if(sortField == null || sortField.isEmpty()) {
			sortField = DEFAULT_SORT_FIELD;
		}
		if(sortDir == null || sortDir.isEmpty()) {
			sortDir = DEFAULT_SORT_DIRECTION;
		}
		if(keyword == null || keyword.trim().isEmpty()) {
			keyword = DEFAULT_KEYWORD;
		}
		
		BigDecimal minPrice = BigDecimal.ZERO;
		BigDecimal maxPrice = BigDecimal.valueOf(Integer.MAX_VALUE);
		
		Page<Product> productPage = productService.findAllProductByStatus(Boolean.TRUE, currentPage,
				sortField, sortDir, keyword, minPrice, maxPrice);
		modelMap.addAttribute("productList", productPage.getContent());
		
		modelMap.addAttribute("totalItems", productPage.getTotalElements());
		modelMap.addAttribute("totalPages", productPage.getTotalPages());
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("sortField", sortField);
		modelMap.addAttribute("sortDir", sortDir);
		modelMap.addAttribute("keyword", keyword);
		modelMap.addAttribute("listPage", Utils.getListPaging(productPage.getTotalPages(), currentPage));
		return "search";
	}

	@RequestMapping(value = { "/list-books/category/{categoryId}" }, method = RequestMethod.GET)
	public String listBooksByCategory(@PathVariable("categoryId") int categoryId, ModelMap modelMap,
			HttpServletRequest request, HttpServletResponse response) {

		return listBooksByCategoryWithPaginationAndSorting(categoryId, 
					DEFAULT_CURRENT_PAGE, DEFAULT_SORT_FIELD, DEFAULT_SORT_DIRECTION, DEFAULT_FILTER_PRICE,
					modelMap, request, response);
	}
	
	@RequestMapping(value = {"/list-books/category/{categoryId}/page/{currentPage}"}, method = RequestMethod.GET)
	public String listBooksByCategoryWithPaginationAndSorting(
			@PathVariable("categoryId") int categoryId,
			@PathVariable("currentPage") int currentPage,
			@PathParam("sortField") String sortField, @PathParam("sortDir") String sortDir,
			@PathParam("filterPrice") String filterPrice,
			final ModelMap modelMap, final HttpServletRequest request, final HttpServletResponse response) {
		
		if(sortField == null || sortField.isEmpty()) {
			sortField = DEFAULT_SORT_FIELD;
		}
		if(sortDir == null || sortDir.isEmpty()) {
			sortDir = DEFAULT_SORT_DIRECTION;
		}
		
		BigDecimal minPrice = BigDecimal.ZERO;
		BigDecimal maxPrice = BigDecimal.valueOf(Integer.MAX_VALUE);
		if(filterPrice == null || filterPrice.trim().isEmpty()) {
			filterPrice = DEFAULT_FILTER_PRICE;
		}
		switch (filterPrice) {
			case FILTER_PRICE_0_TO_100:
				minPrice = BigDecimal.ZERO;
				maxPrice = BigDecimal.valueOf(100000);
				break;
			case FILTER_PRICE_100_TO_200:
				minPrice = BigDecimal.valueOf(100000);
				maxPrice = BigDecimal.valueOf(200000);
				break;
			case FILTER_PRICE_200_TO_300:
				minPrice = BigDecimal.valueOf(200000);
				maxPrice = BigDecimal.valueOf(300000);
				break;
			case FILTER_PRICE_300_TO_400:
				minPrice = BigDecimal.valueOf(300000);
				maxPrice = BigDecimal.valueOf(400000);
				break;
			case FILTER_PRICE_400_TO_500:
				minPrice = BigDecimal.valueOf(400000);
				maxPrice = BigDecimal.valueOf(500000);
				break;
			case FILTER_PRICE_500_TO_MAX:
				minPrice = BigDecimal.valueOf(500000);
				maxPrice = BigDecimal.valueOf(Integer.MAX_VALUE);
				break;
			default:
				minPrice = BigDecimal.ZERO;
				maxPrice = BigDecimal.valueOf(Integer.MAX_VALUE);
				break;
		}
		
		Page<Product> productPage = productService.findAllProductByCategoryID(categoryId, currentPage,
				sortField, sortDir, minPrice, maxPrice);
		modelMap.addAttribute("productList", productPage.getContent());
		
		modelMap.addAttribute("totalPages", productPage.getTotalPages());
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("sortField", sortField);
		modelMap.addAttribute("sortDir", sortDir);
		modelMap.addAttribute("categoryId", categoryId);
		modelMap.addAttribute("SELECTED_CATEGORY_ID", categoryId);
		modelMap.addAttribute("filterPrice", filterPrice);
		modelMap.addAttribute("listPage", Utils.getListPaging(productPage.getTotalPages(), currentPage));
		return "listBooks";
	}

	@RequestMapping(value = { "/book-details/{productId}" }, method = RequestMethod.GET)
	public String bookDetails(@PathVariable("productId") int productId, ModelMap modelMap,
			HttpServletRequest request, HttpServletResponse response) {
		modelMap.addAttribute("maxBuyAmount", MAX_BUY_AMOUNT);
		modelMap.addAttribute("product", productRepo.findById(productId).get());
		
		return "book-detail";
	}
}

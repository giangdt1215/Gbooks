package com.dtg.controller.admin;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.dtg.entities.News;
import com.dtg.repositories.NewsRepo;

@Controller
@RequestMapping(value = { "/admin" })
public class AdminNewsController {
	
	private static final String UPLOAD_DIR = "E:\\NewEclipseWorkspace\\FinalProject\\upload";

	@Autowired
	private NewsRepo newsRepo;

	@RequestMapping(value = { "/news-mgr" }, method = RequestMethod.GET)
	public String newsMgr(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute("navAdminActive", "nav_admin_news");
		
		model.addAttribute("newsList", newsRepo.findByOrderByStatusDescCreatedDateDesc());
		return "admin/news/news-manager";
	}

	@RequestMapping(value = { "/add-news" }, method = RequestMethod.GET)
	public String addNews(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response) {
		model.addAttribute("news", new News());
		return "admin/news/add-news";
	}
	
	@RequestMapping(value = { "/edit-news/{newsId}" }, method = RequestMethod.GET)
	public String editNews(@PathVariable("newsId") int newsId,
			final ModelMap model, final HttpServletRequest request, final HttpServletResponse response) {
		model.addAttribute("news", newsRepo.getOne(newsId));
		return "admin/news/edit-news";
	}

	@RequestMapping(value = { "/save-news" }, method = RequestMethod.POST)
	public String saveNews(@RequestParam("newsImage") MultipartFile newsImage, @ModelAttribute("news") News news,
			final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws IllegalStateException, IOException {
		// check insert hay update
		if (news.getId() != null) {
			// update
			News newsInDatabase = newsRepo.getOne(news.getId());

			news.setCreatedDate(newsInDatabase.getCreatedDate());
			news.setUpdatedDate(LocalDateTime.now());
			news.setImage(newsInDatabase.getImage());
		} else {
			// insert
			news.setCreatedDate(LocalDateTime.now());
		}
		
		// check upload anh
		if(!newsImage.isEmpty()) {
			// check upload dir
			File newsDir = new File(UPLOAD_DIR + "\\news");
			if (!newsDir.exists())
				newsDir.mkdirs();
			
			// get product avatar
			File newsFile = new File(UPLOAD_DIR + "\\news\\" + newsImage.getOriginalFilename());
			newsImage.transferTo(newsFile);
			news.setImage("news/" + newsImage.getOriginalFilename());
		} else {
			if(news.getImage() == null) {
				news.setImage("news/news-default.jpg");
			}
		}

		news.setStatus(Boolean.TRUE);

		newsRepo.save(news);
		return "redirect:/admin/news-mgr?save_news_success";
	}
	
	@RequestMapping(value = {"/delete-news/{newsId}"}, method = RequestMethod.POST)
	public String deleteBook(@PathVariable("newsId") int newsId, 
			final ModelMap model, final HttpServletRequest request, final HttpServletResponse response) {
		News news = newsRepo.getOne(newsId);
		news.setUpdatedDate(LocalDateTime.now());
		news.setStatus(Boolean.FALSE);
		
		newsRepo.save(news);
		return "redirect:/admin/news-mgr?save_news_success";
	}
}

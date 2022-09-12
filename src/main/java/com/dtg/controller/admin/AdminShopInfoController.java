package com.dtg.controller.admin;

import java.time.LocalDateTime;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dtg.entities.ShopInfo;
import com.dtg.services.ShopInfoService;

@Controller
@RequestMapping(value = "/admin")
public class AdminShopInfoController {

	@Autowired
	private ShopInfoService shopInfoService;

	@GetMapping(value = "/gioi-thieu")
	public String gioiThieu(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute("navAdminActive", "nav_admin_gioi_thieu");
		ShopInfo shopInfo = shopInfoService.getShopInfo();
		
		if (shopInfo == null) {
			shopInfo = new ShopInfo();
		}

		model.addAttribute("shopInfo", shopInfo);
		return "admin/infopages/gioi-thieu";
	}

	@PostMapping(value = "save-gioi-thieu")
	public String saveGioiThieu(@ModelAttribute("shopInfo") ShopInfo shopInfo, final ModelMap model,
			final HttpServletRequest request, final HttpServletResponse response) {
		if(shopInfo.getId() != null) {
			// update
			shopInfo.setUpdatedDate(LocalDateTime.now());
			boolean isUpdated = shopInfoService.updateGioiThieu(shopInfo);
			if(isUpdated)
				return "redirect:/admin/gioi-thieu?save_success";
			else
				return "redirect:/admin/gioi-thieu?save_failed";
		} else {
			// insert
			shopInfo.setCreatedDate(LocalDateTime.now());
			shopInfo.setStatus(Boolean.TRUE);
			
			shopInfoService.insertShopInfo(shopInfo);
		}
		return "redirect:/admin/gioi-thieu?save_success";
	}
	
	@GetMapping(value = "/cs-van-chuyen")
	public String csVanChuyen(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute("navAdminActive", "nav_admin_van_chuyen");
		ShopInfo shopInfo = shopInfoService.getShopInfo();
		
		if (shopInfo == null) {
			shopInfo = new ShopInfo();
		}

		model.addAttribute("shopInfo", shopInfo);
		return "admin/infopages/van-chuyen";
	}
	
	@PostMapping(value = "save-van-chuyen")
	public String saveVanChuyen(@ModelAttribute("shopInfo") ShopInfo shopInfo, final ModelMap model,
			final HttpServletRequest request, final HttpServletResponse response) {
		if(shopInfo.getId() != null) {
			// update
			shopInfo.setUpdatedDate(LocalDateTime.now());
			boolean isUpdated = shopInfoService.updateCsVanChuyen(shopInfo);
			if(isUpdated)
				return "redirect:/admin/cs-van-chuyen?save_success";
			else
				return "redirect:/admin/cs-van-chuyen?save_failed";
		} else {
			// insert
			shopInfo.setCreatedDate(LocalDateTime.now());
			shopInfo.setStatus(Boolean.TRUE);
			
			shopInfoService.insertShopInfo(shopInfo);
		}
		return "redirect:/admin/cs-van-chuyen?save_success";
	}
	
	@GetMapping(value = "/cs-bao-mat")
	public String csBaoMat(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute("navAdminActive", "nav_admin_bao_mat");
		ShopInfo shopInfo = shopInfoService.getShopInfo();
		
		if (shopInfo == null) {
			shopInfo = new ShopInfo();
		}

		model.addAttribute("shopInfo", shopInfo);
		return "admin/infopages/bao-mat";
	}
	
	@PostMapping(value = "save-bao-mat")
	public String saveBaoMat(@ModelAttribute("shopInfo") ShopInfo shopInfo, final ModelMap model,
			final HttpServletRequest request, final HttpServletResponse response) {
		if(shopInfo.getId() != null) {
			// update
			shopInfo.setUpdatedDate(LocalDateTime.now());
			boolean isUpdated = shopInfoService.updateCsBaoMat(shopInfo);
			if(isUpdated)
				return "redirect:/admin/cs-bao-mat?save_success";
			else
				return "redirect:/admin/cs-bao-mat?save_failed";
		} else {
			// insert
			shopInfo.setCreatedDate(LocalDateTime.now());
			shopInfo.setStatus(Boolean.TRUE);
			
			shopInfoService.insertShopInfo(shopInfo);
		}
		return "redirect:/admin/cs-bao-mat?save_success";
	}
	
	@GetMapping(value = "/cs-doi-tra-hoan-tien")
	public String csDoiTraHoanTien(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute("navAdminActive", "nav_admin_doi_tra_hoan_tien");
		ShopInfo shopInfo = shopInfoService.getShopInfo();
		
		if (shopInfo == null) {
			shopInfo = new ShopInfo();
		}

		model.addAttribute("shopInfo", shopInfo);
		return "admin/infopages/doi-tra-hoan-tien";
	}
	
	@PostMapping(value = "save-doi-tra-hoan-tien")
	public String saveDoiTraHoanTien(@ModelAttribute("shopInfo") ShopInfo shopInfo, final ModelMap model,
			final HttpServletRequest request, final HttpServletResponse response) {
		if(shopInfo.getId() != null) {
			// update
			shopInfo.setUpdatedDate(LocalDateTime.now());
			boolean isUpdated = shopInfoService.updateCsDoiTraHoanTien(shopInfo);
			if(isUpdated)
				return "redirect:/admin/cs-doi-tra-hoan-tien?save_success";
			else
				return "redirect:/admin/cs-doi-tra-hoan-tien?save_failed";
		} else {
			// insert
			shopInfo.setCreatedDate(LocalDateTime.now());
			shopInfo.setStatus(Boolean.TRUE);
			
			shopInfoService.insertShopInfo(shopInfo);
		}
		return "redirect:/admin/cs-doi-tra-hoan-tien?save_success";
	}
	
	@GetMapping(value = "/quy-dinh-su-dung")
	public String qdSuDung(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute("navAdminActive", "nav_admin_quy_dinh_su_dung");
		ShopInfo shopInfo = shopInfoService.getShopInfo();
		
		if (shopInfo == null) {
			shopInfo = new ShopInfo();
		}

		model.addAttribute("shopInfo", shopInfo);
		return "admin/infopages/quy-dinh-su-dung";
	}
	
	@PostMapping(value = "save-quy-dinh-su-dung")
	public String saveQuyDinhSuDung(@ModelAttribute("shopInfo") ShopInfo shopInfo, final ModelMap model,
			final HttpServletRequest request, final HttpServletResponse response) {
		if(shopInfo.getId() != null) {
			// update
			shopInfo.setUpdatedDate(LocalDateTime.now());
			boolean isUpdated = shopInfoService.updateQdSuDung(shopInfo);
			if(isUpdated)
				return "redirect:/admin/quy-dinh-su-dung?save_success";
			else
				return "redirect:/admin/quy-dinh-su-dung?save_failed";
		} else {
			// insert
			shopInfo.setCreatedDate(LocalDateTime.now());
			shopInfo.setStatus(Boolean.TRUE);
			
			shopInfoService.insertShopInfo(shopInfo);
		}
		return "redirect:/admin/quy-dinh-su-dung?save_success";
	}
}

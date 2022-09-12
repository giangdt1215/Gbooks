package com.dtg.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import com.dtg.constants.IConstants;
import com.dtg.entities.ShopInfo;
import com.dtg.services.ShopInfoService;

@Controller
public class ShopInfoController extends BaseController implements IConstants{
	
	@Autowired
	private ShopInfoService shopInfoService;
	
	@GetMapping(value = "/gioi-thieu")
	public String gioiThieu(final ModelMap model, final HttpServletRequest request, 
			final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute(NAV_ACTIVE_ATT, NAV_INTRO_ACTIVE);
		
		model.addAttribute("title", GIOI_THIEU_TITLE);
		
		ShopInfo shopInfo =  shopInfoService.getShopInfo();
		if(shopInfo == null) {
			model.addAttribute("errorMsg", ERROR_MSG);
			return "redirect:/errors";
		}
		
		model.addAttribute("shopInfoContent", shopInfo.getGioiThieu());
		return "shop-info";
	}

	@GetMapping(value = "/chinh-sach-bao-mat")
	public String csBaoMat(final ModelMap model, final HttpServletRequest request, 
			final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute(NAV_ACTIVE_ATT, NAV_NONE_ACTIVE);
		
		model.addAttribute("title", CS_BAO_MAT_TITLE);
		
		ShopInfo shopInfo =  shopInfoService.getShopInfo();
		if(shopInfo == null) {
			model.addAttribute("errorMsg", ERROR_MSG);
			return "redirect:/errors";
		}
		
		model.addAttribute("shopInfoContent", shopInfo.getCsBaoMat());
		return "shop-info";
	}
	
	@GetMapping(value = "/chinh-sach-van-chuyen")
	public String csVanChuyen(final ModelMap model, final HttpServletRequest request, 
			final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute(NAV_ACTIVE_ATT, NAV_NONE_ACTIVE);
		
		model.addAttribute("title", CS_VAN_CHUYEN_TITLE);
		
		ShopInfo shopInfo =  shopInfoService.getShopInfo();
		if(shopInfo == null) {
			model.addAttribute("errorMsg", ERROR_MSG);
			return "redirect:/errors";
		}
		
		model.addAttribute("shopInfoContent", shopInfo.getCsVanChuyen());
		return "shop-info";
	}
	
	@GetMapping(value = "/quy-dinh-su-dung")
	public String qdSuDung(final ModelMap model, final HttpServletRequest request, 
			final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute(NAV_ACTIVE_ATT, NAV_NONE_ACTIVE);
		
		model.addAttribute("title", QUY_DINH_SU_DUNG_TITLE);
		
		ShopInfo shopInfo =  shopInfoService.getShopInfo();
		if(shopInfo == null) {
			model.addAttribute("errorMsg", ERROR_MSG);
			return "redirect:/errors";
		}
		
		model.addAttribute("shopInfoContent", shopInfo.getQdSuDung());
		return "shop-info";
	}
	
	@GetMapping(value = "/chinh-sach-doi-tra-hoan-tien")
	public String csDoiTraHoanTien(final ModelMap model, final HttpServletRequest request, 
			final HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute(NAV_ACTIVE_ATT, NAV_NONE_ACTIVE);
		
		model.addAttribute("title", CS_DOI_TRA_TITLE);
		
		ShopInfo shopInfo =  shopInfoService.getShopInfo();
		if(shopInfo == null) {
			model.addAttribute("errorMsg", ERROR_MSG);
			return "redirect:/errors";
		}
		
		model.addAttribute("shopInfoContent", shopInfo.getCsDoiTraHoanTien());
		return "shop-info";
	}
}

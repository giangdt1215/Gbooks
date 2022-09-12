package com.dtg.services;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dtg.entities.ShopInfo;
import com.dtg.repositories.ShopInfoRepo;

@Service
public class ShopInfoService {

	@PersistenceContext
	private EntityManager entityManager;
	
	@Autowired
	private ShopInfoRepo shopInfoRepo;
	
	public ShopInfo getShopInfo() {
		StringBuilder sqlSb = new StringBuilder();
		sqlSb.append("SELECT * FROM tbl_info i LIMIT 1");
		
		Query query = entityManager.createNativeQuery(sqlSb.toString(), ShopInfo.class);
		try {
			ShopInfo shopInfo = (ShopInfo) query.getResultList().get(0);
			return shopInfo;
		} catch(Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}
	
	@Transactional(rollbackOn = Exception.class)
	public boolean updateGioiThieu(ShopInfo shopInfo) {
		StringBuilder jpqlSb = new StringBuilder();
		jpqlSb.append("UPDATE ShopInfo i SET i.gioiThieu = :content, ");
		jpqlSb.append("i.updatedDate =  :updatedDate ");
		jpqlSb.append("WHERE i.id = :id");
		
		Query query = entityManager.createQuery(jpqlSb.toString());
		query.setParameter("content", shopInfo.getGioiThieu());
		query.setParameter("updatedDate", shopInfo.getUpdatedDate());
		query.setParameter("id", shopInfo.getId());
		int rowsUpdated = query.executeUpdate();
		
		if(rowsUpdated > 0){
			return true;
		}
		return false;
	}
	
	@Transactional(rollbackOn = Exception.class)
	public ShopInfo insertShopInfo(ShopInfo shopInfo) {
		return shopInfoRepo.save(shopInfo);
	}
	
	@Transactional(rollbackOn = Exception.class)
	public boolean updateCsVanChuyen(ShopInfo shopInfo) {
		StringBuilder jpqlSb = new StringBuilder();
		jpqlSb.append("UPDATE ShopInfo i SET i.csVanChuyen = :content, ");
		jpqlSb.append("i.updatedDate =  :updatedDate ");
		jpqlSb.append("WHERE i.id = :id");
		
		Query query = entityManager.createQuery(jpqlSb.toString());
		query.setParameter("content", shopInfo.getCsVanChuyen());
		query.setParameter("updatedDate", shopInfo.getUpdatedDate());
		query.setParameter("id", shopInfo.getId());
		int rowsUpdated = query.executeUpdate();
		
		if(rowsUpdated > 0){
			return true;
		}
		return false;
	}
	
	@Transactional(rollbackOn = Exception.class)
	public boolean updateCsBaoMat(ShopInfo shopInfo) {
		StringBuilder jpqlSb = new StringBuilder();
		jpqlSb.append("UPDATE ShopInfo i SET i.csBaoMat = :content, ");
		jpqlSb.append("i.updatedDate =  :updatedDate ");
		jpqlSb.append("WHERE i.id = :id");
		
		Query query = entityManager.createQuery(jpqlSb.toString());
		query.setParameter("content", shopInfo.getCsBaoMat());
		query.setParameter("updatedDate", shopInfo.getUpdatedDate());
		query.setParameter("id", shopInfo.getId());
		int rowsUpdated = query.executeUpdate();
		
		if(rowsUpdated > 0){
			return true;
		}
		return false;
	}
	
	@Transactional(rollbackOn = Exception.class)
	public boolean updateQdSuDung(ShopInfo shopInfo) {
		StringBuilder jpqlSb = new StringBuilder();
		jpqlSb.append("UPDATE ShopInfo i SET i.qdSuDung = :content, ");
		jpqlSb.append("i.updatedDate =  :updatedDate ");
		jpqlSb.append("WHERE i.id = :id");
		
		Query query = entityManager.createQuery(jpqlSb.toString());
		query.setParameter("content", shopInfo.getQdSuDung());
		query.setParameter("updatedDate", shopInfo.getUpdatedDate());
		query.setParameter("id", shopInfo.getId());
		int rowsUpdated = query.executeUpdate();
		
		if(rowsUpdated > 0){
			return true;
		}
		return false;
	}
	
	@Transactional(rollbackOn = Exception.class)
	public boolean updateCsDoiTraHoanTien(ShopInfo shopInfo) {
		StringBuilder jpqlSb = new StringBuilder();
		jpqlSb.append("UPDATE ShopInfo i SET i.csDoiTraHoanTien = :content, ");
		jpqlSb.append("i.updatedDate =  :updatedDate ");
		jpqlSb.append("WHERE i.id = :id");
		
		Query query = entityManager.createQuery(jpqlSb.toString());
		query.setParameter("content", shopInfo.getCsDoiTraHoanTien());
		query.setParameter("updatedDate", shopInfo.getUpdatedDate());
		query.setParameter("id", shopInfo.getId());
		int rowsUpdated = query.executeUpdate();
		
		if(rowsUpdated > 0){
			return true;
		}
		return false;
	}
}

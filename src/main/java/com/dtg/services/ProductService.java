package com.dtg.services;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.dtg.constants.IConstants;
import com.dtg.entities.Product;
import com.dtg.repositories.ProductRepo;

@Service
public class ProductService implements IConstants{

	@PersistenceContext
	private EntityManager entityManger;
	
	@Autowired
	private ProductRepo productRepo;
	
	public Page<Product> findAllProductByStatus(boolean status, int currentPage,
				String sortField, String sortDir, String keyword, BigDecimal minPrice, BigDecimal maxPrice){
		
		Sort sort = Sort.by(sortField);
		if(SORT_DIRECTION_ASC.equals(sortDir))
			sort = sort.ascending();
		else
			sort = sort.descending();
		
		Pageable pageable = PageRequest.of(currentPage - 1, PRODUCT_PAGE_SIZE, sort);
		return productRepo.findAllByStatus(keyword, minPrice, maxPrice, status, pageable);
	}
	
	public Page<Product> findAllProductByCategoryID(int categoryId, int currentPage,
			String sortField, String sortDir, BigDecimal minPrice, BigDecimal maxPrice){
		Sort sort = Sort.by(sortField);
		if(SORT_DIRECTION_ASC.equals(sortDir))
			sort = sort.ascending();
		else
			sort = sort.descending();
		
		Pageable pageable = PageRequest.of(currentPage - 1, PRODUCT_PAGE_SIZE, sort);
		return productRepo.findAllByCategory(categoryId, minPrice, maxPrice, pageable);
	}
	
	@SuppressWarnings("unchecked")
	public List<Product> findAllLatestProduct(int quantity){
		StringBuilder jpqlSb = new StringBuilder();
		jpqlSb.append("FROM Product p WHERE p.status = TRUE ");
		jpqlSb.append("ORDER BY p.releaseDate DESC");
		Query query = entityManger.createQuery(jpqlSb.toString(), Product.class);
		return query.setMaxResults(quantity).getResultList();
	}
	
	public Product findProductById(Integer productId) {
		try {
			return productRepo.getOne(productId);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}

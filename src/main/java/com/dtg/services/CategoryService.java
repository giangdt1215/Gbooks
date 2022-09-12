package com.dtg.services;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;

import com.dtg.entities.Category;

@Service
public class CategoryService {

	@PersistenceContext 
	private EntityManager entityManager;
	
	@SuppressWarnings("unchecked")
	public List<Category> findAllCategoryByStatus(boolean status){
		String jpql = "From Category c Where c.status = :status";
		Query query = entityManager.createQuery(jpql, Category.class).setParameter("status", status);
		return query.getResultList();
	}
}

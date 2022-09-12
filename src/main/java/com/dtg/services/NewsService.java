package com.dtg.services;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.dtg.entities.News;
import com.dtg.repositories.NewsRepo;

@Service
public class NewsService {

	@PersistenceContext
	private EntityManager entityManager;
	
	@Autowired
	private NewsRepo newsRepo;
	
	@SuppressWarnings("unchecked")
	public List<News> findAllNewsByStatus(boolean status){
		String jpql = "FROM News n WHERE n.status = :status";
		Query query = entityManager.createQuery(jpql).setParameter("status", status);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<News> findAllLatestNews(int quantity){
		String jpql = "FROM News n WHERE n.status = true ORDER BY n.status asc, n.createdDate desc";
		Query query = entityManager.createQuery(jpql);
		return query.setMaxResults(quantity).getResultList();
	}
	
	public News findNewsById(Integer newsId) {
		try {
			return newsRepo.getOne(newsId);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}
	
	public Page<News> findAllNewsWithPaging(int currentPage, int size) {
		Pageable pageable = PageRequest.of(currentPage - 1, size);
		return newsRepo.findLatestNews(Boolean.TRUE, pageable);
	}
}

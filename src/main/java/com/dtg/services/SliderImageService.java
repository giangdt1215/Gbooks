package com.dtg.services;

import java.util.List;
import java.util.NoSuchElementException;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dtg.entities.SliderImage;
import com.dtg.repositories.SliderImageRepo;

@Service
public class SliderImageService {

	@Autowired
	private SliderImageRepo sliderImageRepo;
	
	@PersistenceContext
	private EntityManager entityManager;
	
	@SuppressWarnings("unchecked")
	public List<SliderImage> findAllByCreatedDateDesc(){
		StringBuilder jpqlSb = new StringBuilder();
		jpqlSb.append("SELECT s FROM SliderImage s ");
		jpqlSb.append("ORDER BY s.status DESC, s.createdDate DESC");
		
		Query query = entityManager.createQuery(jpqlSb.toString(), SliderImage.class);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<SliderImage> findAllByCreatedDateDescAndStatus(Boolean status){
		StringBuilder jpqlSb = new StringBuilder();
		jpqlSb.append("SELECT s FROM SliderImage s ");
		jpqlSb.append("WHERE s.status = :status ");
		jpqlSb.append("ORDER BY s.createdDate DESC");
		
		Query query = entityManager.createQuery(jpqlSb.toString(), SliderImage.class);
		query.setParameter("status", status);
		return query.getResultList();
	}
	
	public SliderImage saveSlide(SliderImage slide) {
		return sliderImageRepo.save(slide);
	}
	
	public SliderImage findById(Integer slideId) {
		try {
			return sliderImageRepo.getOne(slideId);
		} catch (NoSuchElementException e) {
			return null;
		}
	}
}

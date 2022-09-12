package com.dtg.services;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;

import com.dtg.entities.Author;

@Service
public class AuthorService {

	@PersistenceContext
	private EntityManager entityManager;
	
	public Author findAuthorByName(String authorName) {
		String sql = "SELECT * FROM tbl_author a WHERE lower(a.name) = :lowerName ;";
		Query query = entityManager.createNativeQuery(sql, Author.class)
								   .setParameter("lowerName", authorName.toLowerCase());
		try {
			return (Author) query.getSingleResult();
		} catch (Exception e) {
			return null;
		}
	}
}

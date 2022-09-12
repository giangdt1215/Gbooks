package com.dtg.services;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;

import com.dtg.entities.Roles;

@Service
public class RolesService {

	@PersistenceContext
	private EntityManager entityManager;
	
	public Roles findRolesByName(String rolesName) {
		StringBuilder jpqlSb = new StringBuilder();
		jpqlSb.append("FROM Roles r WHERE r.name = :name AND r.status = TRUE");
		
		Query query = entityManager.createQuery(jpqlSb.toString(), Roles.class)
								   .setParameter("name", rolesName);
		try {
			return (Roles) query.getSingleResult();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}
}

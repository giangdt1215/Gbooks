package com.dtg.services;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dtg.constants.IConstants;
import com.dtg.entities.Roles;
import com.dtg.entities.User;
import com.dtg.repositories.UserRepo;
import com.dtg.utils.Utils;

@Service
public class UserService implements IConstants{

	@PersistenceContext
	private EntityManager entityManager;
	
	@Autowired
	private UserRepo userRepo;
	
	@Autowired
	private RolesService rolesService;

	public User loadUserByUsername(String username) {
		String jpql = "FROM User u WHERE u.username = :username";
		Query query = entityManager.createQuery(jpql, User.class)
								   .setParameter("username", username);
		try {
			return (User) query.getResultList().get(0);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@Transactional(rollbackOn = Exception.class)
	public User registerUser(User user, String role) {
		// encode password
		String password = user.getPassword();
		user.setPassword(Utils.encode(password));
		
		user.setStatus(Boolean.TRUE);
		
		Roles userRole = rolesService.findRolesByName(role);
		if(userRole == null)
			return null;
		
		user.addRole(userRole);
		
		return userRepo.save(user);
	}
	
	@Transactional(rollbackOn = Exception.class)
	public User updateUser(User user) {
		// encode password
		String password = user.getPassword();
		user.setPassword(Utils.encode(password));
		
		user.setStatus(Boolean.TRUE);
		
		return userRepo.save(user);
	}

	@Transactional(rollbackOn = Exception.class)
	public User findUserById(Integer id) {
		try {
			return userRepo.getOne(id);
		} catch (Exception e) {
			System.out.println(e.getStackTrace());
			return null;
		}
	}
	
	@Transactional(rollbackOn = Exception.class)
	public List<User> findByUsername(String username) {
		return userRepo.findByUsername(username);
	}
}

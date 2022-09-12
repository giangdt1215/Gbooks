package com.dtg.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.dtg.entities.User;

@Repository
public interface UserRepo extends JpaRepository<User, Integer>{

	@Query("From User u WHERE u.username = :username")
	List<User> findByUsername(@Param("username") String username);
}

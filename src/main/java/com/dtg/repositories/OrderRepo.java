package com.dtg.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.dtg.entities.Order;

@Repository
public interface OrderRepo extends JpaRepository<Order, Integer>{

	List<Order> findByOrderByOrderStatusAscCreatedDateDesc();
	
	List<Order> findByUserIdOrderByOrderStatusAscCreatedDateDesc(Integer userId);
	
}

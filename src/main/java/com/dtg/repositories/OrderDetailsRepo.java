package com.dtg.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.dtg.entities.OrderDetails;
import com.dtg.entities.OrderDetailsId;

@Repository
public interface OrderDetailsRepo extends JpaRepository<OrderDetails, OrderDetailsId>{

}

package com.dtg.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.dtg.entities.Inventory;

@Repository
public interface InventoryRepo extends JpaRepository<Inventory, Integer>{

}

package com.dtg.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.dtg.entities.ShopInfo;

@Repository
public interface ShopInfoRepo extends JpaRepository<ShopInfo, Integer>{

}

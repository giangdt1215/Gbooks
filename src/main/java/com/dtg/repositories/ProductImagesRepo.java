package com.dtg.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.dtg.entities.ProductImages;

@Repository
public interface ProductImagesRepo extends JpaRepository<ProductImages, Integer>{

}

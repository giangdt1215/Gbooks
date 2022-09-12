package com.dtg.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.dtg.entities.SliderImage;

@Repository
public interface SliderImageRepo extends JpaRepository<SliderImage, Integer>{

}

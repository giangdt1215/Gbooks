package com.dtg.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.dtg.entities.Category;

@Repository
public interface CategoryRepo extends JpaRepository<Category, Integer>{

}

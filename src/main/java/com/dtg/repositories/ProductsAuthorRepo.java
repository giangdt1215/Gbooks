package com.dtg.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.dtg.entities.ProductsAuthor;
import com.dtg.entities.ProductsAuthorId;

@Repository
public interface ProductsAuthorRepo extends JpaRepository<ProductsAuthor, ProductsAuthorId>{

}

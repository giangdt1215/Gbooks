package com.dtg.repositories;

import java.math.BigDecimal;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.dtg.entities.Product;

@Repository
public interface ProductRepo extends JpaRepository<Product, Integer>{

	@Query("FROM Product p WHERE p.name LIKE %:keyword% AND p.status = :status "
			+ "AND (p.price BETWEEN :minPrice AND :maxPrice)")
	Page<Product> findAllByStatus(@Param("keyword") String keyword,
			@Param("minPrice") BigDecimal minPrice, @Param("maxPrice") BigDecimal maxPrice,
			@Param("status") Boolean status, Pageable pageable);

	@Query("FROM Product p WHERE p.category.id = :categoryId AND p.status = TRUE "
			+ "AND (p.price BETWEEN :minPrice AND :maxPrice)")
	Page<Product> findAllByCategory(@Param("categoryId") int categoryId,
			@Param("minPrice") BigDecimal minPrice, @Param("maxPrice") BigDecimal maxPrice,
			Pageable pageable);
}

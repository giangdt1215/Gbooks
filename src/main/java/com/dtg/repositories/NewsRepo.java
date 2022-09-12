package com.dtg.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.dtg.entities.News;

@Repository
public interface NewsRepo extends JpaRepository<News, Integer>{

	@Query("FROM News n WHERE n.status = :status ORDER BY n.createdDate desc")
	Page<News> findLatestNews(@Param("status") Boolean status, Pageable pageable);
	
	List<News> findByOrderByStatusDescCreatedDateDesc();
}

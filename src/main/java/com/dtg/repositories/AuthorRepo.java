package com.dtg.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.dtg.entities.Author;

@Repository
public interface AuthorRepo extends JpaRepository<Author, Integer>{

}

package com.dtg.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.dtg.entities.Contact;

@Repository
public interface ContactRepo extends JpaRepository<Contact, Integer>{

}

package com.dtg.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.dtg.entities.Roles;

@Repository
public interface RolesRepo extends JpaRepository<Roles, Integer>{

}

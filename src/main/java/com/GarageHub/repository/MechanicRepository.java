package com.GarageHub.repository;

import com.GarageHub.entity.Mechanic;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MechanicRepository extends JpaRepository<Mechanic, Long> {
}

package com.GarageHub.repository;

import com.GarageHub.entity.HeavyVehicle;
import org.springframework.data.jpa.repository.JpaRepository;

public interface HeavyVehicleRepository extends JpaRepository<HeavyVehicle, Long> {
}

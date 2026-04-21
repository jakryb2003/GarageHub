package com.GarageHub.repository;

import com.GarageHub.entity.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface VehicleRepository extends JpaRepository<Vehicle, Long> {

    Optional<Vehicle> findByOwnerId(Long ownerId);

}

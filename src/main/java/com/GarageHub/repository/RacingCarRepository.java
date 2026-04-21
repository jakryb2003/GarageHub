package com.GarageHub.repository;

import com.GarageHub.entity.RacingCar;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RacingCarRepository extends JpaRepository<RacingCar, Long> {
}

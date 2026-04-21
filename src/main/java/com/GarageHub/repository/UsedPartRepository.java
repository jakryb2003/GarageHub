package com.GarageHub.repository;

import com.GarageHub.entity.UsedPart;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsedPartRepository extends JpaRepository<UsedPart, Long> {
}

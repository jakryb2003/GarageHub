package com.GarageHub.repository;

import com.GarageHub.entity.ServiceRecord;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ServiceRecordRepository extends JpaRepository<ServiceRecord, Long> {

}

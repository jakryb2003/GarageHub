package com.GarageHub.repository;

import com.GarageHub.entity.Appointment;
import com.GarageHub.entity.enums.AppointmentStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AppointmentRepository extends JpaRepository<Appointment, Long> {

    Optional<Appointment> findByGarageIdAndStatus(Long garageId, AppointmentStatus status);

}

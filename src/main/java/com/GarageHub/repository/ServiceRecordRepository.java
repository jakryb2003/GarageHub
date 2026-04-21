package com.GarageHub.repository;

import com.GarageHub.entity.FinancialReportDTO;
import com.GarageHub.entity.ServiceRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface ServiceRecordRepository extends JpaRepository<ServiceRecord, Long> {

    @Query("""
        SELECT new FinancialReportDTO(
            g.id,
            g.name,
            YEAR(sr.serviceDate),
            MONTH(sr.serviceDate),
            COUNT(sr.id),
            SUM(sr.totalCost),
            SUM(sr.laborCost),
            SUM(sr.partsCost)
        )
        FROM ServiceRecord sr
        JOIN sr.appointment a
        JOIN a.garage g
        WHERE g.id = :garageId
          AND YEAR(sr.serviceDate)  = :year
          AND MONTH(sr.serviceDate) = :month
        GROUP BY g.id, g.name, YEAR(sr.serviceDate), MONTH(sr.serviceDate)
        """)
    Optional<FinancialReportDTO> findMonthlyReport(
            @Param("garageId") Long garageId,
            @Param("year")     int year,
            @Param("month")    int month
    );

}

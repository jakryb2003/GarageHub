package com.GarageHub.entity;

import java.math.BigDecimal;

public record FinancialReportDTO(
        Long    garageId,
        String  garageName,
        Integer year,
        Integer month,
        Long    totalAppointments,
        BigDecimal totalRevenue,
        BigDecimal totalLaborCost,
        BigDecimal totalPartsCost
) {}

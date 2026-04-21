package com.GarageHub.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

import java.time.LocalDate;

@Entity
@Table(name = "mechanic_garage")
public class MechanicGarage extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    private Mechanic mechanic;

    @ManyToOne(fetch = FetchType.LAZY)
    private Garage garage;

    @Column(nullable = false)
    private LocalDate startDate;

    @Column
    private LocalDate endDate;

    @Column(nullable = false)
    private Boolean primaryGarage;
}

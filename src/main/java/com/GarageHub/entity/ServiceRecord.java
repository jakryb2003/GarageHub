package com.GarageHub.entity;

import jakarta.annotation.Nullable;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "service_records")
@Getter
@Setter
@NoArgsConstructor
public class ServiceRecord extends BaseEntity {

    @Column(nullable = false, columnDefinition = "TEXT")
    private String description;

    @Column(name = "mileage_at_service", nullable = false)
    private Integer mileageAtService;

    @Column(nullable = false)
    private LocalDate serviceDate;

    @Column(name = "labor_cost", precision = 10, scale = 2)
    private BigDecimal laborCost;

    @Column(name = "parts_cost", precision = 10, scale = 2)
    private BigDecimal partsCost;

    @Column(name = "total_cost", precision = 10, scale = 2)
    private BigDecimal totalCost;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "vehicle_id", nullable = false)
    private Vehicle vehicle;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "mechanic_id", nullable = false)
    private Mechanic mechanic;

    @OneToOne(fetch = FetchType.LAZY)
    @Nullable
    private Appointment appointment;

    @OneToMany(mappedBy = "serviceRecord", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<UsedPart> usedParts = new ArrayList<>();

}

package com.GarageHub.entity;

import com.GarageHub.entity.enums.VehicleType;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.DiscriminatorColumn;
import jakarta.persistence.DiscriminatorType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Inheritance;
import jakarta.persistence.InheritanceType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "vehicles")
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name = "vehicle_type", discriminatorType = DiscriminatorType.STRING)
@Getter
@Setter
@NoArgsConstructor
public abstract class Vehicle extends BaseEntity{

    @Column(nullable = false, unique = true, length = 17)
    private String vin;

    @Column(nullable = false)
    private String color;

    @Column(nullable = false)
    private String mileage;

    @Column(name = "registration_number", nullable = false, unique = true)
    private String registrationNumber;

    @Column(nullable = false)
    private String model;

    @Column(nullable = false)
    private String brand;

    @Column(name = "year_of_manufacture",  nullable = false)
    private Integer yearOfManufacture;

    @ManyToOne(fetch = FetchType.LAZY,  optional = false)
    @JoinColumn(name = "client_id", nullable = false)
    private Client owner;

    @OneToMany(mappedBy = "vehicle", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ServiceRecord> serviceHistory =  new ArrayList<>();

    public abstract VehicleType getVehicleType();

}

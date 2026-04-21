package com.GarageHub.entity;

import com.GarageHub.entity.enums.FuelType;
import com.GarageHub.entity.enums.VehicleType;
import jakarta.persistence.Column;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "car")
@DiscriminatorValue("CAR")
@Getter
@Setter
@NoArgsConstructor
public class Car extends Vehicle {

    @Column(name = "engine_capacity",  nullable = false)
    private Integer engineCapacity;

    @Enumerated(EnumType.STRING)
    @Column(name = "fuel_type", nullable = false)
    private FuelType fuelType;

    @Column(name = "number_of_doors", nullable = false)
    private Integer numberOfDoors;


    @Override
    public VehicleType getVehicleType() {
        return VehicleType.CAR;
    }
}

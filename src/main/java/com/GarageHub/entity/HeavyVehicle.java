package com.GarageHub.entity;

import com.GarageHub.entity.enums.VehicleType;
import jakarta.persistence.Column;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "heavy_vehicle")
@DiscriminatorValue("HEAVY_VEHICLE")
@Getter
@Setter
@NoArgsConstructor
public class HeavyVehicle extends Vehicle {

    @Column(name = "number_of_axles",  nullable = false)
    private Integer numberOfAxles;

    @Column(name = "gross_vehicle_weight",  nullable = false)
    private Integer grossVehicleWeight;

    @Override
    public VehicleType getVehicleType() {
        return VehicleType.HEAVY_VEHICLE;
    }
}

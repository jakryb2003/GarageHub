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
@Table(name = "motorcycle")
@DiscriminatorValue("MOTORCYCLE")
@Getter
@Setter
@NoArgsConstructor
public class Motorcycle extends Vehicle{

    @Column(name = "engine_capacity",  nullable = false)
    private Integer engineCapacity;

    @Override
    public VehicleType getVehicleType() {
        return VehicleType.MOTORCYCLE;
    }
}

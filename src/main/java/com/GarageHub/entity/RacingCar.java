package com.GarageHub.entity;

import com.GarageHub.entity.enums.RacingClass;
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
@Table(name = "racing_car")
@DiscriminatorValue("RACING_CAR")
@Getter
@Setter
@NoArgsConstructor
public class RacingCar extends Vehicle {

    @Enumerated(EnumType.STRING)
    @Column(name = "racing_class",  nullable = false)
    private RacingClass racingClass;

    @Column(nullable = false)
    private Integer season;

    @Column(name = "start_number",  nullable = false)
    private Integer startNumber;

    @Override
    public VehicleType getVehicleType() {
        return VehicleType.RACING_CAR;
    }
}

package com.GarageHub.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Entity
@Table(name = "used_parts")
@Getter
@Setter
@NoArgsConstructor
public class UsedPart extends BaseEntity {

    @Column(nullable = false)
    private Integer quantity;

    @Column(nullable = false, name = "unit_price_at_time", precision = 10, scale = 2)
    private BigDecimal unitPriceAtTime;

}

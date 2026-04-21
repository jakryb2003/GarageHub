package com.GarageHub.entity;

import com.GarageHub.entity.enums.PartCategory;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Entity
@Table(name = "parts")
@Getter
@Setter
@NoArgsConstructor
public class Part extends BaseEntity {

    @Column(nullable = false)
    private String name;

    @Column(nullable = false, unique = true)
    private String catalogNumber;

    @Column
    private String manufacturer;

    @Column(nullable = false)
    private PartCategory category;

    @Column(name = "purchase_price", precision = 10, scale = 2)
    private BigDecimal purchasePrice;

    @Column(name = "selling_price", precision = 10, scale = 2)
    private BigDecimal sellingPrice;

    @Column(name = "stock_quantity")
    private Integer stockQuantity;

    @Column(name = "minimum_stock_level")
    private Integer minimumStockLever;

    @Column
    private String unit;

    @ManyToOne(fetch = FetchType.LAZY)
    private Garage garage;

}

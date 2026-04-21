package com.GarageHub.entity;

import com.GarageHub.entity.enums.PartCategory;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Entity
@Table(name = "parts", uniqueConstraints = @UniqueConstraint(
        name = "uk_part_catalog_garage",
        columnNames = {"catalog_number", "garage_id"}
))
@Getter
@Setter
@NoArgsConstructor
public class Part extends BaseEntity {

    @Column(nullable = false)
    private String name;

    @Column(name = "catalog_number", nullable = false)
    private String catalogNumber;

    @Column
    private String manufacturer;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private PartCategory category;

    @Column(name = "purchase_price", precision = 10, scale = 2)
    private BigDecimal purchasePrice;

    @Column(name = "selling_price", precision = 10, scale = 2)
    private BigDecimal sellingPrice;

    @Column(name = "stock_quantity")
    private Integer stockQuantity;

    @Column(name = "minimum_stock_level")
    private Integer minimumStockLevel;

    @Column
    private String unit;

    @ManyToOne(fetch = FetchType.LAZY)
    private Garage garage;

}

package com.GarageHub.entity;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "mechanics")
@Getter
@Setter
@NoArgsConstructor
public class Mechanic {

    @Column(name = "first_name", nullable = false)
    private String firstName;

    @Column(name = "last_name", nullable = false)
    private String lastName;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "password_hash", nullable = false)
    private String passwordHash;

    @Column(name = "hire_date", nullable = false)
    private LocalDate hireDate;

    @Column
    private Boolean active;

    @ManyToMany
    @JoinTable(
            name = "mechanic_garage",
            joinColumns = @JoinColumn(name = "mechanic_id"),
            inverseJoinColumns = @JoinColumn(name = "garage_id")
    )
    private Set<Garage> garages = new HashSet<>();

    @OneToMany(mappedBy = "appointment", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Appointment> appointments = new ArrayList<>();

}

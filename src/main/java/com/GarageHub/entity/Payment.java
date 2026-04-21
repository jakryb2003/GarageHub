package com.GarageHub.entity;

import com.GarageHub.entity.enums.PaymentMethod;
import com.GarageHub.entity.enums.PaymentStatus;
import jakarta.annotation.Nullable;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Instant;

@Entity
@Table(name = "payments")
@Getter
@Setter
@NoArgsConstructor
public class Payment {

    @Column(nullable = false)
    private BigDecimal amount;

    @Column(nullable = false)
    private String currency;

    @Column(nullable = false)
    private PaymentMethod method;

    @Column(nullable = false)
    private PaymentStatus status;

    @Column(name = "stripe_payment_intent_id", nullable = false)
    private String stripePaymentIntentId;

    @Column(name = "stripe_client_secret")
    private String stripeClientSecret;

    @Column(name = "stripe_receipt_url")
    private String stripeReceiptUrl;

    @Column(name = "paid_at")
    private Instant paidAt;

    @Column(name = "refunded_at")
    private Instant refundedAt;

    @Column(name = "refund_amount")
    private BigDecimal refundAmount;

    @OneToOne(fetch = FetchType.LAZY)
    @NonNull
    private Appointment appointment;

}

-- ---------------------------------------------------------------------
-- CLIENTS
-- ---------------------------------------------------------------------
CREATE TABLE clients (
                         id                BIGSERIAL PRIMARY KEY,
                         created_at        TIMESTAMP WITH TIME ZONE NOT NULL,
                         updated_at        TIMESTAMP WITH TIME ZONE NOT NULL,
                         version           BIGINT,

                         first_name        VARCHAR(100) NOT NULL,
                         last_name         VARCHAR(100) NOT NULL,
                         email             VARCHAR(255) NOT NULL,
                         phone_number      VARCHAR(20)  NOT NULL,
                         address           VARCHAR(255),
                         city              VARCHAR(100),
                         postal_code       VARCHAR(10),
                         password_hash     VARCHAR(255) NOT NULL,
                         email_verified    BOOLEAN      NOT NULL DEFAULT FALSE,
                         client_role       VARCHAR(20)  NOT NULL,
                         delete_at         TIMESTAMP WITH TIME ZONE,

                         CONSTRAINT uk_clients_email UNIQUE (email)
);

CREATE INDEX idx_clients_email        ON clients (email);
CREATE INDEX idx_clients_deleted      ON clients (delete_at) WHERE delete_at IS NULL;


-- ---------------------------------------------------------------------
-- GARAGES
-- ---------------------------------------------------------------------
CREATE TABLE garages (
                         id                BIGSERIAL PRIMARY KEY,
                         created_at        TIMESTAMP WITH TIME ZONE NOT NULL,
                         updated_at        TIMESTAMP WITH TIME ZONE NOT NULL,
                         version           BIGINT,

                         name              VARCHAR(200) NOT NULL,
                         nip               VARCHAR(10)  NOT NULL,
                         phone             VARCHAR(20)  NOT NULL,
                         email             VARCHAR(255) NOT NULL,
                         street            VARCHAR(255) NOT NULL,
                         city              VARCHAR(100) NOT NULL,
                         postal_code       VARCHAR(10)  NOT NULL,
                         latitude          NUMERIC(10, 7),
                         longitude         NUMERIC(10, 7),
                         active            BOOLEAN      NOT NULL DEFAULT TRUE,
                         opening_time      TIME,
                         closing_time      TIME,

                         CONSTRAINT uk_garages_nip UNIQUE (nip)
);

CREATE INDEX idx_garages_city   ON garages (city);
CREATE INDEX idx_garages_active ON garages (active) WHERE active = TRUE;


-- ---------------------------------------------------------------------
-- MECHANICS
-- ---------------------------------------------------------------------
CREATE TABLE mechanics (
                           id                BIGSERIAL PRIMARY KEY,
                           created_at        TIMESTAMP WITH TIME ZONE NOT NULL,
                           updated_at        TIMESTAMP WITH TIME ZONE NOT NULL,
                           version           BIGINT,

                           first_name        VARCHAR(100) NOT NULL,
                           last_name         VARCHAR(100) NOT NULL,
                           email             VARCHAR(255) NOT NULL,
                           phone_number      VARCHAR(20),
                           password_hash     VARCHAR(255) NOT NULL,
                           hire_date         DATE         NOT NULL,
                           active            BOOLEAN,

                           CONSTRAINT uk_mechanics_email UNIQUE (email)
);

CREATE INDEX idx_mechanics_email ON mechanics (email);


-- ---------------------------------------------------------------------
-- MECHANIC_GARAGE  (join entity: mechanik ↔ garaż z danymi zatrudnienia)
-- ---------------------------------------------------------------------
CREATE TABLE mechanic_garage (
                                 id                BIGSERIAL PRIMARY KEY,
                                 created_at        TIMESTAMP WITH TIME ZONE NOT NULL,
                                 updated_at        TIMESTAMP WITH TIME ZONE NOT NULL,
                                 version           BIGINT,

                                 mechanic_id       BIGINT  NOT NULL,
                                 garage_id         BIGINT  NOT NULL,
                                 start_date        DATE    NOT NULL,
                                 end_date          DATE,
                                 primary_garage    BOOLEAN NOT NULL DEFAULT FALSE,

                                 CONSTRAINT fk_mg_mechanic FOREIGN KEY (mechanic_id) REFERENCES mechanics (id),
                                 CONSTRAINT fk_mg_garage   FOREIGN KEY (garage_id)   REFERENCES garages (id)
);

CREATE INDEX idx_mg_mechanic ON mechanic_garage (mechanic_id);
CREATE INDEX idx_mg_garage   ON mechanic_garage (garage_id);

-- Mechanik może być zatrudniony w danym garażu tylko raz jednocześnie
-- (end_date IS NULL = aktualnie pracuje). Unique po 3 kolumnach zapewnia
-- że ten sam start_date nie powtórzy się przy przyjęciu do tego samego garażu.
CREATE UNIQUE INDEX uk_mg_mechanic_garage_active
    ON mechanic_garage (mechanic_id, garage_id)
    WHERE end_date IS NULL;


-- ---------------------------------------------------------------------
-- VEHICLES  (parent — JOINED inheritance)
-- ---------------------------------------------------------------------
CREATE TABLE vehicles (
                          id                  BIGSERIAL PRIMARY KEY,
                          created_at          TIMESTAMP WITH TIME ZONE NOT NULL,
                          updated_at          TIMESTAMP WITH TIME ZONE NOT NULL,
                          version             BIGINT,

                          vehicle_type        VARCHAR(20)  NOT NULL,  -- discriminator: CAR, MOTORCYCLE, HEAVY_VEHICLE, RACING_CAR
                          vin                 VARCHAR(17)  NOT NULL,
                          color               VARCHAR(50)  NOT NULL,
                          mileage             INTEGER      NOT NULL,
                          registration_number VARCHAR(20)  NOT NULL,
                          model               VARCHAR(100) NOT NULL,
                          brand               VARCHAR(100) NOT NULL,
                          year_of_manufacture INTEGER      NOT NULL,
                          client_id           BIGINT       NOT NULL,

                          CONSTRAINT uk_vehicles_vin         UNIQUE (vin),
                          CONSTRAINT uk_vehicles_reg         UNIQUE (registration_number),
                          CONSTRAINT fk_vehicles_client      FOREIGN KEY (client_id) REFERENCES clients (id)
);

CREATE INDEX idx_vehicles_client ON vehicles (client_id);
CREATE INDEX idx_vehicles_type   ON vehicles (vehicle_type);


-- ---------------------------------------------------------------------
-- CAR  (child of vehicles)
-- ---------------------------------------------------------------------
CREATE TABLE car (
                     id               BIGINT PRIMARY KEY,
                     engine_capacity  INTEGER     NOT NULL,
                     fuel_type        VARCHAR(20) NOT NULL,
                     number_of_doors  INTEGER     NOT NULL,

                     CONSTRAINT fk_car_vehicle FOREIGN KEY (id) REFERENCES vehicles (id) ON DELETE CASCADE
);


-- ---------------------------------------------------------------------
-- MOTORCYCLE
-- ---------------------------------------------------------------------
CREATE TABLE motorcycle (
                            id               BIGINT PRIMARY KEY,
                            engine_capacity  INTEGER NOT NULL,

                            CONSTRAINT fk_moto_vehicle FOREIGN KEY (id) REFERENCES vehicles (id) ON DELETE CASCADE
);


-- ---------------------------------------------------------------------
-- HEAVY_VEHICLE
-- ---------------------------------------------------------------------
CREATE TABLE heavy_vehicle (
                               id                    BIGINT PRIMARY KEY,
                               number_of_axles       INTEGER NOT NULL,
                               gross_vehicle_weight  INTEGER NOT NULL,

                               CONSTRAINT fk_hv_vehicle FOREIGN KEY (id) REFERENCES vehicles (id) ON DELETE CASCADE
);


-- ---------------------------------------------------------------------
-- RACING_CAR
-- ---------------------------------------------------------------------
CREATE TABLE racing_car (
                            id            BIGINT PRIMARY KEY,
                            racing_class  VARCHAR(20) NOT NULL,
                            season        INTEGER     NOT NULL,
                            start_number  INTEGER     NOT NULL,

                            CONSTRAINT fk_rc_vehicle FOREIGN KEY (id) REFERENCES vehicles (id) ON DELETE CASCADE
);


-- ---------------------------------------------------------------------
-- PARTS  (magazyn per garage)
-- ---------------------------------------------------------------------
CREATE TABLE parts (
                       id                    BIGSERIAL PRIMARY KEY,
                       created_at            TIMESTAMP WITH TIME ZONE NOT NULL,
                       updated_at            TIMESTAMP WITH TIME ZONE NOT NULL,
                       version               BIGINT,

                       name                  VARCHAR(200)   NOT NULL,
                       catalog_number        VARCHAR(100)   NOT NULL,
                       manufacturer          VARCHAR(100),
                       category              VARCHAR(30)    NOT NULL,
                       purchase_price        NUMERIC(10, 2),
                       selling_price         NUMERIC(10, 2),
                       stock_quantity        INTEGER        DEFAULT 0,
                       minimum_stock_level   INTEGER        DEFAULT 0,
                       unit                  VARCHAR(20),
                       garage_id             BIGINT,

                       CONSTRAINT uk_part_catalog_garage UNIQUE (catalog_number, garage_id),
                       CONSTRAINT fk_parts_garage        FOREIGN KEY (garage_id) REFERENCES garages (id)
);

CREATE INDEX idx_parts_garage         ON parts (garage_id);
CREATE INDEX idx_parts_category       ON parts (category);
CREATE INDEX idx_parts_low_stock      ON parts (garage_id, stock_quantity)
    WHERE stock_quantity <= minimum_stock_level;


-- ---------------------------------------------------------------------
-- APPOINTMENTS
-- ---------------------------------------------------------------------
CREATE TABLE appointments (
                              id                BIGSERIAL PRIMARY KEY,
                              created_at        TIMESTAMP WITH TIME ZONE NOT NULL,
                              updated_at        TIMESTAMP WITH TIME ZONE NOT NULL,
                              version           BIGINT,

                              vehicle_id        BIGINT      NOT NULL,
                              mechanic_id       BIGINT      NOT NULL,
                              client_id         BIGINT      NOT NULL,
                              garage_id         BIGINT      NOT NULL,
                              status            VARCHAR(20) NOT NULL,
                              scheduled_at      TIMESTAMP WITH TIME ZONE NOT NULL,
                              issue_description TEXT,
                              estimated_cost    NUMERIC(10, 2),

                              CONSTRAINT fk_appt_vehicle  FOREIGN KEY (vehicle_id)  REFERENCES vehicles (id),
                              CONSTRAINT fk_appt_mechanic FOREIGN KEY (mechanic_id) REFERENCES mechanics (id),
                              CONSTRAINT fk_appt_client   FOREIGN KEY (client_id)   REFERENCES clients (id),
                              CONSTRAINT fk_appt_garage   FOREIGN KEY (garage_id)   REFERENCES garages (id)
);

CREATE INDEX idx_appt_vehicle     ON appointments (vehicle_id);
CREATE INDEX idx_appt_mechanic    ON appointments (mechanic_id);
CREATE INDEX idx_appt_client      ON appointments (client_id);
CREATE INDEX idx_appt_garage      ON appointments (garage_id);
CREATE INDEX idx_appt_status      ON appointments (status);
CREATE INDEX idx_appt_scheduled   ON appointments (scheduled_at);
-- Częste zapytanie: "wizyty danego warsztatu w danym dniu"
CREATE INDEX idx_appt_garage_date ON appointments (garage_id, scheduled_at);


-- ---------------------------------------------------------------------
-- SERVICE_RECORDS
-- ---------------------------------------------------------------------
CREATE TABLE service_records (
                                 id                 BIGSERIAL PRIMARY KEY,
                                 created_at         TIMESTAMP WITH TIME ZONE NOT NULL,
                                 updated_at         TIMESTAMP WITH TIME ZONE NOT NULL,
                                 version            BIGINT,

                                 description        TEXT    NOT NULL,
                                 mileage_at_service INTEGER NOT NULL,
                                 service_date       DATE    NOT NULL,
                                 labor_cost         NUMERIC(10, 2),
                                 parts_cost         NUMERIC(10, 2),
                                 total_cost         NUMERIC(10, 2),
                                 vehicle_id         BIGINT  NOT NULL,
                                 mechanic_id        BIGINT  NOT NULL,
                                 appointment_id     BIGINT,

                                 CONSTRAINT fk_sr_vehicle     FOREIGN KEY (vehicle_id)     REFERENCES vehicles (id),
                                 CONSTRAINT fk_sr_mechanic    FOREIGN KEY (mechanic_id)    REFERENCES mechanics (id),
                                 CONSTRAINT fk_sr_appointment FOREIGN KEY (appointment_id) REFERENCES appointments (id),
                                 CONSTRAINT uk_sr_appointment UNIQUE (appointment_id)   -- @OneToOne
);

CREATE INDEX idx_sr_vehicle  ON service_records (vehicle_id);
CREATE INDEX idx_sr_mechanic ON service_records (mechanic_id);
CREATE INDEX idx_sr_date     ON service_records (service_date);


-- ---------------------------------------------------------------------
-- USED_PARTS  (junction: co zostało użyte w serwisie)
-- ---------------------------------------------------------------------
CREATE TABLE used_parts (
                            id                   BIGSERIAL PRIMARY KEY,
                            created_at           TIMESTAMP WITH TIME ZONE NOT NULL,
                            updated_at           TIMESTAMP WITH TIME ZONE NOT NULL,
                            version              BIGINT,

                            quantity             INTEGER        NOT NULL,
                            unit_price_at_time   NUMERIC(10, 2) NOT NULL,
                            service_record_id    BIGINT         NOT NULL,
                            part_id              BIGINT         NOT NULL,

                            CONSTRAINT fk_up_service_record FOREIGN KEY (service_record_id)
                                REFERENCES service_records (id) ON DELETE CASCADE,
                            CONSTRAINT fk_up_part           FOREIGN KEY (part_id) REFERENCES parts (id),

                            CONSTRAINT chk_up_quantity_positive CHECK (quantity > 0)
);

CREATE INDEX idx_up_service ON used_parts (service_record_id);
CREATE INDEX idx_up_part    ON used_parts (part_id);


-- ---------------------------------------------------------------------
-- PAYMENTS
-- ---------------------------------------------------------------------
CREATE TABLE payments (
                          id                       BIGSERIAL PRIMARY KEY,
                          created_at               TIMESTAMP WITH TIME ZONE NOT NULL,
                          updated_at               TIMESTAMP WITH TIME ZONE NOT NULL,
                          version                  BIGINT,

                          amount                   NUMERIC(10, 2) NOT NULL,
                          currency                 VARCHAR(3)     NOT NULL DEFAULT 'PLN',
                          method                   VARCHAR(30)    NOT NULL,
                          status                   VARCHAR(20)    NOT NULL,
                          stripe_payment_intent_id VARCHAR(255),
                          stripe_client_secret     VARCHAR(255),
                          stripe_receipt_url       VARCHAR(500),
                          paid_at                  TIMESTAMP WITH TIME ZONE,
                          refunded_at              TIMESTAMP WITH TIME ZONE,
                          refund_amount            NUMERIC(10, 2),
                          appointment_id           BIGINT         NOT NULL,

                          CONSTRAINT fk_pay_appointment FOREIGN KEY (appointment_id) REFERENCES appointments (id),
                          CONSTRAINT uk_pay_appointment UNIQUE (appointment_id),   -- @OneToOne
                          CONSTRAINT chk_pay_amount_positive CHECK (amount > 0)
);

CREATE INDEX idx_pay_status        ON payments (status);
CREATE INDEX idx_pay_stripe_intent ON payments (stripe_payment_intent_id)
    WHERE stripe_payment_intent_id IS NOT NULL;
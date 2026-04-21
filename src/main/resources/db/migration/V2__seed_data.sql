-- =====================================================================
-- GarageHub — V2 Seed data (dev/test only)
-- =====================================================================
-- Dane deterministyczne — ID wpisane ręcznie żeby relacje były czytelne.
-- Po seedzie trzeba zresetować sekwencje (na końcu pliku).
--
-- Hasło dla wszystkich użytkowników: "password123"
-- (bcrypt hash wygenerowany do celów testowych — NIE używać w produkcji)
-- =====================================================================


-- ---------------------------------------------------------------------
-- GARAŻE (3 lokalizacje w regionie lubelskim)
-- ---------------------------------------------------------------------
INSERT INTO garages (id, created_at, updated_at, version, name, nip, phone, email,
                     street, city, postal_code, latitude, longitude,
                     active, opening_time, closing_time) VALUES
                                                             (1, NOW(), NOW(), 0, 'GarageHub Lublin Centrum',   '1234567890', '+48 81 555 0101',
                                                              'centrum@garagehub.pl', 'ul. Lubartowska 15', 'Lublin', '20-085',
                                                              51.2500, 22.5700, TRUE, '08:00', '18:00'),

                                                             (2, NOW(), NOW(), 0, 'GarageHub Lublin Felin',     '1234567891', '+48 81 555 0102',
                                                              'felin@garagehub.pl', 'ul. Droga Męczenników Majdanka 100', 'Lublin', '20-325',
                                                              51.2180, 22.6200, TRUE, '07:00', '19:00'),

                                                             (3, NOW(), NOW(), 0, 'GarageHub Świdnik',          '1234567892', '+48 81 555 0103',
                                                              'swidnik@garagehub.pl', 'ul. Aleja Lotników Polskich 1', 'Świdnik', '21-040',
                                                              51.2200, 22.6900, TRUE, '08:00', '17:00');


-- ---------------------------------------------------------------------
-- MECHANICY
-- ---------------------------------------------------------------------
INSERT INTO mechanics (id, created_at, updated_at, version, first_name, last_name,
                       email, phone_number, password_hash, hire_date, active) VALUES
                                                                                  (1, NOW(), NOW(), 0, 'Jan',      'Kowalski',  'jan.kowalski@garagehub.pl',
                                                                                   '+48 600 100 001', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
                                                                                   '2022-03-15', TRUE),

                                                                                  (2, NOW(), NOW(), 0, 'Piotr',    'Nowak',     'piotr.nowak@garagehub.pl',
                                                                                   '+48 600 100 002', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
                                                                                   '2023-01-10', TRUE),

                                                                                  (3, NOW(), NOW(), 0, 'Marek',    'Wiśniewski', 'marek.wisniewski@garagehub.pl',
                                                                                   '+48 600 100 003', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
                                                                                   '2021-06-01', TRUE),

                                                                                  (4, NOW(), NOW(), 0, 'Tomasz',   'Wójcik',    'tomasz.wojcik@garagehub.pl',
                                                                                   '+48 600 100 004', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
                                                                                   '2024-02-20', TRUE);


-- ---------------------------------------------------------------------
-- PRZYPISANIA mechaników do garaży
-- Jan — tylko Centrum (primary)
-- Piotr — Centrum + Felin (primary w Centrum)
-- Marek — Felin (primary)
-- Tomasz — Świdnik (primary)
-- ---------------------------------------------------------------------
INSERT INTO mechanic_garage (id, created_at, updated_at, version,
                             mechanic_id, garage_id, start_date, end_date, primary_garage) VALUES
                                                                                               (1, NOW(), NOW(), 0, 1, 1, '2022-03-15', NULL, TRUE),
                                                                                               (2, NOW(), NOW(), 0, 2, 1, '2023-01-10', NULL, TRUE),
                                                                                               (3, NOW(), NOW(), 0, 2, 2, '2024-06-01', NULL, FALSE),
                                                                                               (4, NOW(), NOW(), 0, 3, 2, '2021-06-01', NULL, TRUE),
                                                                                               (5, NOW(), NOW(), 0, 4, 3, '2024-02-20', NULL, TRUE);


-- ---------------------------------------------------------------------
-- KLIENCI
-- ---------------------------------------------------------------------
INSERT INTO clients (id, created_at, updated_at, version, first_name, last_name,
                     email, phone_number, address, city, postal_code,
                     password_hash, email_verified, client_role, delete_at) VALUES
                                                                                (1, NOW(), NOW(), 0, 'Anna',     'Lewandowska', 'anna.lewandowska@example.com',
                                                                                 '+48 500 100 001', 'ul. Krakowskie Przedmieście 1', 'Lublin', '20-002',
                                                                                 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', TRUE, 'CLIENT', NULL),

                                                                                (2, NOW(), NOW(), 0, 'Krzysztof', 'Kamiński',   'krzysztof.kaminski@example.com',
                                                                                 '+48 500 100 002', 'ul. Narutowicza 15', 'Lublin', '20-004',
                                                                                 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', TRUE, 'CLIENT', NULL),

                                                                                (3, NOW(), NOW(), 0, 'Magdalena', 'Zielińska',  'magda.zielinska@example.com',
                                                                                 '+48 500 100 003', 'ul. Chopina 8', 'Świdnik', '21-040',
                                                                                 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', FALSE, 'CLIENT', NULL),

                                                                                (4, NOW(), NOW(), 0, 'Admin',     'System',     'admin@garagehub.pl',
                                                                                 '+48 500 999 999', NULL, NULL, NULL,
                                                                                 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', TRUE, 'ADMIN', NULL);


-- ---------------------------------------------------------------------
-- POJAZDY — parent table (wspólne pola)
-- ---------------------------------------------------------------------
INSERT INTO vehicles (id, created_at, updated_at, version, vehicle_type,
                      vin, color, mileage, registration_number,
                      model, brand, year_of_manufacture, client_id) VALUES
-- Anna: Golf VI + Ducati
(1, NOW(), NOW(), 0, 'CAR',           'WVWZZZ1KZAW123456', 'Czarny', 125000,
 'LU12345', 'Golf VI', 'Volkswagen', 2010, 1),
(2, NOW(), NOW(), 0, 'MOTORCYCLE',    'ZDMH700AAGB000001', 'Czerwony', 8500,
 'LU99991', 'Monster 797', 'Ducati', 2020, 1),

-- Krzysztof: Octavia + ciężarówka
(3, NOW(), NOW(), 0, 'CAR',           'TMBJJ7NE5N0012345', 'Srebrny', 45000,
 'LU23456', 'Octavia IV', 'Skoda', 2022, 2),
(4, NOW(), NOW(), 0, 'HEAVY_VEHICLE', 'WMA20WZZ5KM123456', 'Biały', 320000,
 'LU88881', 'TGS 18.440', 'MAN', 2019, 2),

-- Magdalena: bolid F1 (kolekcjoner / tor)
(5, NOW(), NOW(), 0, 'RACING_CAR',    'FER1F2022RACE0001', 'Czerwony', 1200,
 'TOR00001', 'F1-75', 'Ferrari', 2022, 3);


-- --- Car subtable ---
INSERT INTO car (id, engine_capacity, fuel_type, number_of_doors) VALUES
                                                                      (1, 1600, 'DIESEL',   5),   -- Golf TDI
                                                                      (3, 1968, 'DIESEL',   5);   -- Octavia TDI

-- --- Motorcycle subtable ---
INSERT INTO motorcycle (id, engine_capacity) VALUES
    (2, 803);   -- Ducati Monster 797

-- --- HeavyVehicle subtable ---
INSERT INTO heavy_vehicle (id, number_of_axles, gross_vehicle_weight) VALUES
    (4, 3, 26000);   -- MAN TGS

-- --- RacingCar subtable ---
INSERT INTO racing_car (id, racing_class, season, start_number) VALUES
    (5, 'F1', 2022, 16);


-- ---------------------------------------------------------------------
-- CZĘŚCI (magazyn per garage)
-- ---------------------------------------------------------------------
INSERT INTO parts (id, created_at, updated_at, version, name, catalog_number,
                   manufacturer, category, purchase_price, selling_price,
                   stock_quantity, minimum_stock_level, unit, garage_id) VALUES
-- Garaż 1 (Centrum)
(1, NOW(), NOW(), 0, 'Filtr oleju Mann W712/75',  'W712-75', 'Mann-Filter',
 'FILTERS',    18.00,  35.00,  25, 10, 'szt.', 1),
(2, NOW(), NOW(), 0, 'Klocki hamulcowe przód',    'BP-VW-01', 'Brembo',
 'BRAKES',    180.00, 290.00,   8,  5, 'kpl.', 1),
(3, NOW(), NOW(), 0, 'Olej 5W30 Castrol 5L',      'CAS-5W30-5L', 'Castrol',
 'ENGINE',    150.00, 220.00,  15,  8, 'szt.', 1),

-- Garaż 2 (Felin) — ten sam filtr ma inny stan magazynowy
(4, NOW(), NOW(), 0, 'Filtr oleju Mann W712/75',  'W712-75', 'Mann-Filter',
 'FILTERS',    18.00,  35.00,  12, 10, 'szt.', 2),
(5, NOW(), NOW(), 0, 'Amortyzator tył Sachs',     'SAC-REAR-01', 'Sachs',
 'SUSPENSION', 320.00, 480.00,   4,  3, 'szt.', 2),

-- Garaż 3 (Świdnik)
(6, NOW(), NOW(), 0, 'Akumulator Varta 74Ah',     'VAR-74AH',  'Varta',
 'ELECTRICAL', 380.00, 520.00,   6,  4, 'szt.', 3),
(7, NOW(), NOW(), 0, 'Opona Michelin 205/55 R16', 'MICH-20555R16', 'Michelin',
 'TYRES',     450.00, 620.00,  20, 10, 'szt.', 3);


-- ---------------------------------------------------------------------
-- WIZYTY (pokrywające różne statusy)
-- ---------------------------------------------------------------------
INSERT INTO appointments (id, created_at, updated_at, version,
                          vehicle_id, mechanic_id, client_id, garage_id,
                          status, scheduled_at, issue_description, estimated_cost) VALUES
-- Wizyta ZAKOŃCZONA i OPŁACONA — Anna, Golf, wymiana oleju
(1, NOW(), NOW(), 0, 1, 1, 1, 1, 'PAID',
 NOW() - INTERVAL '30 days',
 'Wymiana oleju i filtra', 250.00),

-- Wizyta ZAFAKTUROWANA ale nieopłacona — Krzysztof, Octavia
(2, NOW(), NOW(), 0, 3, 2, 2, 1, 'INVOICED',
 NOW() - INTERVAL '5 days',
 'Wymiana klocków hamulcowych przód', 470.00),

-- Wizyta W TRAKCIE — Krzysztof, MAN, serwis
(3, NOW(), NOW(), 0, 4, 3, 2, 2, 'IN_PROGRESS',
 NOW() - INTERVAL '1 day',
 'Przegląd układu hamulcowego, wymiana filtrów', 1200.00),

-- Wizyta POTWIERDZONA na przyszłość — Magdalena, Ferrari
(4, NOW(), NOW(), 0, 5, 4, 3, 3, 'CONFIRMED',
 NOW() + INTERVAL '3 days',
 'Przygotowanie do sezonu — przegląd silnika', 5000.00),

-- Wizyta OCZEKUJĄCA (świeżo zgłoszona) — Anna, Ducati
(5, NOW(), NOW(), 0, 2, 1, 1, 1, 'PENDING',
 NOW() + INTERVAL '7 days',
 'Dziwny dźwięk przy przełączaniu biegów', NULL),

-- Wizyta ANULOWANA — Krzysztof, Octavia
(6, NOW(), NOW(), 0, 3, 2, 2, 1, 'CANCELLED',
 NOW() - INTERVAL '10 days',
 'Klient odwołał — naprawa pod gwarancją u dealera', NULL);


-- ---------------------------------------------------------------------
-- HISTORIA SERWISOWA (dla zakończonych wizyt)
-- ---------------------------------------------------------------------
INSERT INTO service_records (id, created_at, updated_at, version,
                             description, mileage_at_service, service_date,
                             labor_cost, parts_cost, total_cost,
                             vehicle_id, mechanic_id, appointment_id) VALUES
                                                                          (1, NOW(), NOW(), 0,
                                                                           'Wymiana oleju silnikowego 5W30 (5L) oraz filtra oleju. Kontrola poziomu płynów.',
                                                                           125000, CURRENT_DATE - 30,
                                                                           50.00, 255.00, 305.00,
                                                                           1, 1, 1),

                                                                          (2, NOW(), NOW(), 0,
                                                                           'Wymiana klocków hamulcowych na przedniej osi. Kontrola tarcz — OK.',
                                                                           45000, CURRENT_DATE - 5,
                                                                           180.00, 290.00, 470.00,
                                                                           3, 2, 2);


-- ---------------------------------------------------------------------
-- UŻYTE CZĘŚCI
-- ---------------------------------------------------------------------
INSERT INTO used_parts (id, created_at, updated_at, version,
                        quantity, unit_price_at_time, service_record_id, part_id) VALUES
-- Serwis 1: filtr oleju + olej (z garażu 1)
(1, NOW(), NOW(), 0, 1,  35.00, 1, 1),
(2, NOW(), NOW(), 0, 1, 220.00, 1, 3),

-- Serwis 2: klocki hamulcowe (z garażu 1)
(3, NOW(), NOW(), 0, 1, 290.00, 2, 2);


-- ---------------------------------------------------------------------
-- PŁATNOŚCI
-- ---------------------------------------------------------------------
INSERT INTO payments (id, created_at, updated_at, version,
                      amount, currency, method, status,
                      stripe_payment_intent_id, stripe_client_secret, stripe_receipt_url,
                      paid_at, refunded_at, refund_amount, appointment_id) VALUES
-- Płatność online przez Stripe
(1, NOW(), NOW(), 0,
 305.00, 'PLN', 'STRIPE_CARD', 'COMPLETED',
 'pi_3OxA1234567890abcdef', NULL, 'https://pay.stripe.com/receipts/test_receipt_1',
 NOW() - INTERVAL '29 days', NULL, NULL, 1),

-- Płatność oczekująca (gotówka, jeszcze nieopłacona)
(2, NOW(), NOW(), 0,
 470.00, 'PLN', 'CASH', 'PENDING',
 NULL, NULL, NULL,
 NULL, NULL, NULL, 2);


-- ---------------------------------------------------------------------
-- RESET SEKWENCJI — żeby kolejne INSERT-y z aplikacji nie kolidowały
-- z ID wpisanymi ręcznie
-- ---------------------------------------------------------------------
SELECT setval('garages_id_seq',          (SELECT MAX(id) FROM garages));
SELECT setval('mechanics_id_seq',        (SELECT MAX(id) FROM mechanics));
SELECT setval('mechanic_garage_id_seq',  (SELECT MAX(id) FROM mechanic_garage));
SELECT setval('clients_id_seq',          (SELECT MAX(id) FROM clients));
SELECT setval('vehicles_id_seq',         (SELECT MAX(id) FROM vehicles));
SELECT setval('parts_id_seq',            (SELECT MAX(id) FROM parts));
SELECT setval('appointments_id_seq',     (SELECT MAX(id) FROM appointments));
SELECT setval('service_records_id_seq',  (SELECT MAX(id) FROM service_records));
SELECT setval('used_parts_id_seq',       (SELECT MAX(id) FROM used_parts));
SELECT setval('payments_id_seq',         (SELECT MAX(id) FROM payments));
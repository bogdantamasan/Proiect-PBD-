-- Script de populare cu date de test (Seed Data)
-- Tămășan Bogdan (Club Sportiv)

INSERT INTO utilizatori (nume, email, parola_hash, rol) VALUES
('Tămășan Bogdan', 'bogdan@club.ro', 'hash123', 'admin'),
('Popescu Ion', 'ion.popescu@email.com', 'hash456', 'sportiv'),
('Ionescu Maria', 'maria.ionescu@email.com', 'hash789', 'sportiv'),
('Vasile Andrei', 'andrei.vasile@email.com', 'hash101', 'antrenor');

INSERT INTO antrenori (utilizator_id, specializare, telefon) VALUES
(4, 'Fotbal', '0712345678');

INSERT INTO echipe (nume_echipa, categorie_varsta, antrenor_id) VALUES
('FCSF Bicaz Seniori', 'Seniori', 1),
('FCSF Bicaz Juniori', 'U19', 1);

INSERT INTO sportivi (utilizator_id, echipa_id, data_nasterii, pozitie) VALUES
(2, 1, '2004-05-15', 'Atacant'),
(3, 2, '2006-08-20', 'Mijlocas');

INSERT INTO antrenamente (echipa_id, data_ora, locatie) VALUES
(1, '2026-10-20 18:00:00', 'Stadionul Municipal Bicaz'),
(2, '2026-10-21 16:00:00', 'Teren Sintetic');

INSERT INTO prezente (antrenament_id, sportiv_id, status) VALUES
(1, 1, 'prezent'),
(2, 2, 'absent');

INSERT INTO plati (sportiv_id, suma, data_platii, tip_abonament, status_plata) VALUES
(1, 200.00, '2026-10-01', 'Lunar Full', 'platit'),
(2, 150.00, '2026-09-15', 'Lunar Student', 'restant');

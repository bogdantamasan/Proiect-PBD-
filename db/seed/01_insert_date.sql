-- Inserare date de test
INSERT INTO Sectii (Nume_Sectie, Descriere) VALUES
('Fotbal', 'Pregatire tactica si meciuri'),
('Baschet', 'Antrenamente echipa si aruncari'),
('Inot', 'Cursuri inot copii si adulti'),
('Tenis', 'Lectii individuale si de grup');

INSERT INTO Antrenori (Nume, Prenume, Specializare, Telefon, Email, Salariu) VALUES
('Popescu', 'Ion', 'Fotbal', '0722111222', 'ion.popescu@club.ro', 4500.00),
('Ionescu', 'Maria', 'Inot', '0733222333', 'maria.ionescu@club.ro', 4200.00),
('Georgescu', 'Radu', 'Tenis', '0744333444', 'radu.georgescu@club.ro', 5000.00),
('Dumitrescu', 'Elena', 'Baschet', '0755444555', 'elena.d@club.ro', 3800.00);

INSERT INTO Membri (Nume, Prenume, Data_Nasterii, Telefon, Email, Data_Inscrierii) VALUES
('Ionescu', 'Andrei', '2001-05-12', '0744123456', 'andrei.ionescu@gmail.com', '2025-01-10'),
('Vasilescu', 'Elena', '1998-09-20', '0755987654', 'elena.vasilescu@yahoo.com', '2025-02-15'),
('Radu', 'Mihai', '2003-11-02', '0766333444', 'mihai.radu@gmail.com', '2025-03-01'),
('Marinescu', 'Cristina', '2005-01-25', '0777111222', 'cristina.m@gmail.com', '2025-03-10'),
('Stoica', 'Alexandru', '1995-07-14', '0788999000', 'alex.stoica@yahoo.com', '2025-03-15');

INSERT INTO Abonamente (Tip_Abonament, Pret, Numar_Sedinte, Valabilitate_Luni) VALUES
('Lunar Standard', 200.00, 12, 1),
('Trimestrial VIP', 500.00, 36, 3),
('Anual Premium', 1800.00, 150, 12),
('Sedinta Individuala', 30.00, 1, 1);

INSERT INTO Achizitii (ID_Membru, ID_Abonament, Data_Inceput, Data_Sfarsit, Sedinte_Ramas) VALUES
(1, 1, '2026-03-01', '2026-04-01', 8),
(2, 2, '2026-02-01', '2026-05-01', 2),
(3, 3, '2026-01-01', '2027-01-01', 120),
(4, 1, '2026-03-10', '2026-04-10', 11),
(5, 4, '2026-03-15', '2026-04-15', 0);

INSERT INTO Programari (ID_Sectie, ID_Antrenor, Data_Ora, Locatie) VALUES
(1, 1, '2026-03-20 18:00:00', 'Teren Exterior 1'),
(2, 4, '2026-03-21 16:00:00', 'Sala Polivalenta'),
(3, 2, '2026-03-22 10:00:00', 'Bazin Olimpic');

INSERT INTO Prezente (ID_Programare, ID_Membru, Status) VALUES
(1, 1, 'Prezent'),
(1, 3, 'Prezent'),
(2, 2, 'Absent'),
(3, 4, 'Prezent');

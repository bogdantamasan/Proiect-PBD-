-- Popularea bazei de date cu date de test (Seed Data - Etapa 7-8)

INSERT INTO Sectii (Nume_Sectie, Descriere) VALUES
('Fotbal', 'Sectie de fotbal pe teren sintetic si iarba'),
('Inot', 'Bazin olimpic acoperit'),
('Fitness', 'Sala de forta si cardio'),
('Tenis', 'Terenuri de zgura in aer liber');

INSERT INTO Antrenori (Nume, Prenume, Specializare, Telefon, Email, Salariu) VALUES
('Pop', 'Mihai', 'Fotbal', '0711111111', 'mihai.pop@club.ro', 4500.00),
('Ionescu', 'Elena', 'Inot', '0722222222', 'elena.io@club.ro', 4000.00),
('Radu', 'Cristian', 'Fitness', '0733333333', 'cristi.fit@club.ro', 3800.00);

INSERT INTO Membri (Nume, Prenume, Data_Nasterii, Telefon, Email, Data_Inscrierii) VALUES
('Popescu', 'Andrei', '1995-03-12', '0744444444', 'andrei.p@email.com', '2026-01-15'),
('Dan', 'Maria', '1998-07-22', '0755555555', 'maria.d@email.com', '2026-02-10'),
('Stan', 'Florin', '2001-11-05', '0766666666', 'florin.s@email.com', '2026-03-01'),
('Vasile', 'Ioana', '1992-09-30', '0777777777', 'ioana.v@email.com', '2026-05-20');

INSERT INTO Abonamente (Tip_Abonament, Pret, Numar_Sedinte, Valabilitate_Luni) VALUES
('Standard Lunar', 150.00, 12, 1),
('Premium Nelimitat', 300.00, 30, 1),
('Fotbal Grup', 120.00, 8, 1),
('Inot Avansat', 200.00, 10, 1);

INSERT INTO Achizitii (ID_Membru, ID_Abonament, Data_Inceput, Data_Sfarsit, Sedinte_Ramas) VALUES
(1, 1, '2026-10-01', '2026-11-01', 10),
(2, 2, '2026-10-05', '2026-11-05', 28),
(3, 3, '2026-10-10', '2026-11-10', 8),
(4, 4, '2026-10-15', '2026-11-15', 5);

INSERT INTO Programari (ID_Sectie, ID_Antrenor, Data_Ora, Locatie) VALUES
(1, 1, '2026-11-15 18:00:00', 'Teren Sintetic 1'),
(2, 2, '2026-11-16 10:00:00', 'Bazin Culoarul 3'),
(3, 3, '2026-11-16 19:00:00', 'Sala Etaj 1');

INSERT INTO Prezente (ID_Programare, ID_Membru, Status) VALUES
(1, 1, 'Prezent'),
(1, 3, 'Prezent'),
(2, 4, 'Absent'),
(3, 2, 'Prezent');

INSERT INTO CHURN_PREDICTIONS (ID_Membru, Scor_Risc, Categorie_Risc, Data_Evaluare) VALUES
(4, 0.85, 'Ridicat', CURRENT_DATE),
(1, 0.12, 'Scazut', CURRENT_DATE);

-- teste/teste_constrangeri.sql
-- Script pentru verificarea constrangerilor de integritate (NOT NULL, CHECK, UNIQUE, FK, CASCADE)

-- 1. Test CHECK: Nota trebuie sa fie intre 1 si 5 (EROARE ASTEPTATA)
INSERT INTO Evaluari_Antrenori (id_membru, id_antrenor, nota, comentariu)
VALUES (1, 1, 7, 'Nota in afara intervalului permis');

-- 2. Test NOT NULL: Numele membrului nu poate fi NULL (EROARE ASTEPTATA)
INSERT INTO Membri (nume, prenume, data_nasterii, id_abonament)
VALUES (NULL, 'Alexandru', '2000-01-01', 1);

-- 3. Test FOREIGN KEY: Plata pentru un membru inexistent (EROARE ASTEPTATA)
INSERT INTO Plati (id_membru, suma, data_platii, metoda_plata)
VALUES (9999, 150.00, '2026-11-23', 'Card');

-- 4. Test UNIQUE: Categorie de antrenament duplicata (EROARE ASTEPTATA)
INSERT INTO Categorii_Antrenamente (nume_categorie)
VALUES ('Fotbal');

-- 5. Test ON DELETE CASCADE: Stergerea unui membru elimina automat platile si prezentele lui
DELETE FROM Membri WHERE id_membru = 1;
SELECT * FROM Plati WHERE id_membru = 1;
SELECT * FROM Prezente WHERE id_membru = 1;

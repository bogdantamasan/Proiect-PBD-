-- Script de testare a constrângerilor de integritate (Trebuie să returneze erori la rulare)

-- Test 1: Salariu negativ la Antrenor (Dezactivează CHECK constraint)
-- Așteptat: ERROR - CHECK constraint failed: Salariu > 0
INSERT INTO Antrenori (Nume, Prenume, Specializare, Salariu) 
VALUES ('Test', 'Invalida', 'Tenis', -1500);

-- Test 2: Email duplicat la Membru (Dezactivează UNIQUE constraint)
-- Așteptat: ERROR - UNIQUE constraint failed: Membri.Email
INSERT INTO Membri (Nume, Prenume, Email) 
VALUES ('Popescu', 'Ion', 'bogdan.tamasan@email.com');
INSERT INTO Membri (Nume, Prenume, Email) 
VALUES ('Ionescu', 'Dan', 'bogdan.tamasan@email.com');

-- Test 3: Inserare achiziție cu Membru inexistent (Dezactivează FOREIGN KEY constraint)
-- Așteptat: ERROR - FOREIGN KEY constraint failed
INSERT INTO Achizitii (ID_Membru, ID_Abonament, Data_Inceput, Data_Sfarsit, Sedinte_Ramas) 
VALUES (9999, 1, '2026-01-01', '2026-02-01', 10);

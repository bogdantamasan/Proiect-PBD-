-- ATENȚIE: Aceste comenzi trebuie să genereze ERORI la rulare!
-- ==========================================

-- TEST 1: Încercare de inserare salariu negativ (Respins de chk_antrenor_salariu)
INSERT INTO Antrenori (Nume, Prenume, Specializare, Email, Salariu) 
VALUES ('Test', 'Gresit', 'Tenis', 'test1@club.ro', -500.00);

-- TEST 2: Încercare de inserare email duplicat (Respins de uk_membru_email)
-- (andrei.p@email.com a fost deja inserat in seed data)
INSERT INTO Membri (Nume, Prenume, Data_Nasterii, Email) 
VALUES ('Impostor', 'Andrei', '2000-01-01', 'andrei.p@email.com');

-- TEST 3: Încercare de inserare Status greșit la prezență (Respins de chk_status_prezenta)
INSERT INTO Prezente (ID_Programare, ID_Membru, Status) 
VALUES (1, 1, 'Invoit_Din_Greseala');

-- TEST 4: Încercare de inserare referință invalidă (Respins de FOREIGN KEY)
-- Membrul cu ID 999 nu există
INSERT INTO Achizitii (ID_Membru, ID_Abonament, Data_Inceput, Data_Sfarsit, Sedinte_Ramas) 
VALUES (999, 1, '2026-11-01', '2026-12-01', 10);

-- cele 20 de Interogari SQL Cerute

-- 1. SELECT simplu
SELECT * FROM Antrenori;

-- 2. WHERE
SELECT Nume, Prenume, Data_Nasterii FROM Membri WHERE Data_Nasterii > '2000-01-01';

-- 3. ORDER BY
SELECT Nume, Prenume, Salariu FROM Antrenori ORDER BY Salariu DESC;

-- 4. JOIN (2 tabele)
SELECT P.Data_Ora, S.Nume_Sectie, P.Locatie 
FROM Programari P
JOIN Sectii S ON P.ID_Sectie = S.ID_Sectie;

-- 5. JOIN (3 tabele)
SELECT M.Nume, M.Prenume, A.Tip_Abonament, AC.Data_Inceput 
FROM Achizitii AC
JOIN Membri M ON AC.ID_Membru = M.ID_Membru
JOIN Abonamente A ON AC.ID_Abonament = A.ID_Abonament;

-- 6. GROUP BY + COUNT
SELECT S.Nume_Sectie, COUNT(P.ID_Programare) AS Numar_Programari
FROM Sectii S
LEFT JOIN Programari P ON S.ID_Sectie = P.ID_Sectie
GROUP BY S.Nume_Sectie;

-- 7. GROUP BY + SUM
SELECT A.Tip_Abonament, SUM(A.Pret) AS Venit_Total
FROM Achizitii AC
JOIN Abonamente A ON AC.ID_Abonament = A.ID_Abonament
GROUP BY A.Tip_Abonament;

-- 8. HAVING
SELECT Specializare, AVG(Salariu) AS Salariu_Mediu
FROM Antrenori
GROUP BY Specializare
HAVING AVG(Salariu) >= 4000;

-- 9. Subinterogare scalara
SELECT Nume, Prenume, Salariu FROM Antrenori 
WHERE Salariu > (SELECT AVG(Salariu) FROM Antrenori);

-- 10. Subinterogare IN
SELECT Nume, Prenume FROM Membri 
WHERE ID_Membru IN (SELECT ID_Membru FROM Achizitii WHERE Sedinte_Ramas < 5);

-- 11. INSERT
INSERT INTO Membri (Nume, Prenume, Data_Nasterii, Telefon, Email) 
VALUES ('Popa', 'Vlad', '2002-08-10', '0711222333', 'vlad.popa@gmail.com');

-- 12. UPDATE
UPDATE Achizitii SET Sedinte_Ramas = Sedinte_Ramas - 1 WHERE ID_Achizitie = 1;

-- 13. DELETE
DELETE FROM Prezente WHERE ID_Prezenta = 3;

-- 14. Creare VIEW si interogare
CREATE VIEW IF NOT EXISTS V_Abonamente_Active AS
SELECT M.Nume, M.Prenume, A.Tip_Abonament, AC.Sedinte_Ramas, AC.Data_Sfarsit
FROM Achizitii AC
JOIN Membri M ON AC.ID_Membru = M.ID_Membru
JOIN Abonamente A ON AC.ID_Abonament = A.ID_Abonament
WHERE AC.Data_Sfarsit >= CURRENT_DATE;

SELECT * FROM V_Abonamente_Active;

-- 15. CASE WHEN
SELECT Nume, Prenume, Salariu,
CASE 
    WHEN Salariu >= 4500 THEN 'Salariu Mare'
    ELSE 'Salariu Standard'
END AS Categorie_Salariu
FROM Antrenori;

-- 16. Funcții de șir (UPPER / LENGTH)
SELECT UPPER(Nume) AS Nume_Mare, LENGTH(Email) AS Lungime_Email FROM Membri;

-- 17. Funcții de dată
SELECT ID_Achizitie, strftime('%Y', Data_Inceput) AS An_Achizitie FROM Achizitii;

-- 18. EXISTS
SELECT Nume, Prenume FROM Membri M
WHERE EXISTS (SELECT 1 FROM Prezente P WHERE P.ID_Membru = M.ID_Membru);

-- 19. Agregare DISTINCT
SELECT COUNT(DISTINCT Specializare) AS Numar_Specializari FROM Antrenori;

-- 20. Interogare complexa cu JOIN si Filtrare
SELECT M.Nume, M.Prenume, S.Nume_Sectie, PR.Status
FROM Prezente PR
JOIN Programari P ON PR.ID_Programare = P.ID_Programare
JOIN Sectii S ON P.ID_Sectie = S.ID_Sectie
JOIN Membri M ON PR.ID_Membru = M.ID_Membru
WHERE PR.Status = 'Prezent';

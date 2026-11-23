-- 1. Afișează toți membrii înscriși după data de 2026-01-01, ordonați alfabetic
SELECT ID_Membru, Nume, Prenume, Email, Data_Inscrierii
FROM Membri
WHERE Data_Inscrierii >= '2026-01-01'
ORDER BY Nume ASC, Prenume ASC;

-- 2. Afișează antrenorii cu un salariu mai mare de 3500 RON
SELECT ID_Antrenor, Nume, Prenume, Specializare, Salariu
FROM Antrenori
WHERE Salariu > 3500
ORDER BY Salariu DESC;

-- 3. Caută abonamentele care includ minim 10 ședințe și au prețul sub 250 RON
SELECT ID_Abonament, Tip_Abonament, Pret, Numar_Sedinte
FROM Abonamente
WHERE Numar_Sedinte >= 10 AND Pret < 250;

-- 4. Afișează toate secțiile sportive care conțin cuvântul 'Fotbal' sau 'Înot' în nume
SELECT * FROM Sectii
WHERE Nume_Sectie LIKE '%Fotbal%' OR Nume_Sectie LIKE '%Înot%';

-- 5. Afișează programările stabilite în intervalul actual de timp
SELECT ID_Programare, Data_Ora, Locatie
FROM Programari
WHERE Data_Ora >= '2026-01-01 00:00:00'
ORDER BY Data_Ora ASC;


-- ------------------------------------------
-- B. JOINT-URI ȘI AGREGĂRI CU GROUP BY / HAVING (6-12)
-- ------------------------------------------

-- 6. Afișează lista achizițiilor active (Nume Membru, Tip Abonament, Data Sfârșit, Ședințe Rămas)
SELECT 
    m.Nume || ' ' || m.Prenume AS Membru,
    a.Tip_Abonament,
    ach.Data_Inceput,
    ach.Data_Sfarsit,
    ach.Sedinte_Ramas
FROM Achizitii ach
JOIN Membri m ON ach.ID_Membru = m.ID_Membru
JOIN Abonamente a ON ach.ID_Abonament = a.ID_Abonament
WHERE ach.Sedinte_Ramas > 0 AND ach.Data_Sfarsit >= CURRENT_DATE;

-- 7. Afișează programările împreună cu Secția și Antrenorul responsabil
SELECT 
    p.ID_Programare,
    s.Nume_Sectie,
    ant.Nume || ' ' || ant.Prenume AS Antrenor,
    p.Data_Ora,
    p.Locatie
FROM Programari p
JOIN Sectii s ON p.ID_Sectie = s.ID_Sectie
JOIN Antrenori ant ON p.ID_Antrenor = ant.ID_Antrenor;

-- 8. Calculează numărul total de membri înscriși la fiecare secție (prin prezențe)
SELECT 
    s.Nume_Sectie,
    COUNT(DISTINCT prez.ID_Membru) AS Numar_Sportivi_Unici
FROM Sectii s
JOIN Programari p ON s.ID_Sectie = p.ID_Sectie
JOIN Prezente prez ON p.ID_Programare = prez.ID_Programare
GROUP BY s.ID_Sectie, s.Nume_Sectie
HAVING COUNT(DISTINCT prez.ID_Membru) > 0;

-- 9. Afișează venitul total generat de fiecare tip de abonament
SELECT 
    a.Tip_Abonament,
    COUNT(ach.ID_Achizitie) AS Total_Vanzari,
    SUM(a.Pret) AS Venit_Total_RON
FROM Abonamente a
LEFT JOIN Achizitii ach ON a.ID_Abonament = ach.ID_Abonament
GROUP BY a.ID_Abonament, a.Tip_Abonament
ORDER BY Venit_Total_RON DESC;

-- 10. Afișează membrii care au participat la mai mult de 3 antrenamente (HAVING)
SELECT 
    m.ID_Membru,
    m.Nume || ' ' || m.Prenume AS Membru,
    COUNT(pr.ID_Prezenta) AS Numar_Prezente
FROM Membri m
JOIN Prezente pr ON m.ID_Membru = pr.ID_Membru
WHERE pr.Status = 'Prezent'
GROUP BY m.ID_Membru, m.Nume, m.Prenume
HAVING COUNT(pr.ID_Prezenta) >= 3;

-- 11. Afișează numărul de programări susținute de fiecare antrenor
SELECT 
    ant.Nume || ' ' || ant.Prenume AS Antrenor,
    ant.Specializare,
    COUNT(p.ID_Programare) AS Total_Programari
FROM Antrenori ant
LEFT JOIN Programari p ON ant.ID_Antrenor = p.ID_Antrenor
GROUP BY ant.ID_Antrenor, ant.Nume, ant.Prenume;

-- 12. Afișează lista prezențelor detaliată (Membru, Secție, Data și Ora, Status)
SELECT 
    m.Nume || ' ' || m.Prenume AS Sportiv,
    s.Nume_Sectie,
    prog.Data_Ora,
    prez.Status
FROM Prezente prez
JOIN Membri m ON prez.ID_Membru = m.ID_Membru
JOIN Programari prog ON prez.ID_Programare = prog.ID_Programare
JOIN Sectii s ON prog.ID_Sectie = s.ID_Sectie;


-- ------------------------------------------
-- C. SUBINTEROGĂRI ȘI OPERAȚII AVANSATE (13-17)
-- ------------------------------------------

-- 13. Afișează membrii care nu au cumpărat NICIUN abonament (Subinterogare NOT IN)
SELECT ID_Membru, Nume, Prenume, Email
FROM Membri
WHERE ID_Membru NOT IN (SELECT DISTINCT ID_Membru FROM Achizitii);

-- 14. Găsește abonamentul cu cel mai mare preț peste media tuturor abonamentelor
SELECT Tip_Abonament, Pret
FROM Abonamente
WHERE Pret > (SELECT AVG(Pret) FROM Abonamente);

-- 15. Afișează membrii clasificați cu Risc Ridicat de abandon în tabelul de IA/ML
SELECT 
    m.Nume || ' ' || m.Prenume AS Membru,
    cp.Scor_Risc,
    cp.Categorie_Risc,
    cp.Data_Evaluare
FROM CHURN_PREDICTIONS cp
JOIN Membri m ON cp.ID_Membru = m.ID_Membru
WHERE cp.Categorie_Risc = 'Ridicat'
ORDER BY cp.Scor_Risc DESC;

-- 16. Afișează antrenorul care are cel mai mare salariu folosind o subinterogare
SELECT Nume, Prenume, Specializare, Salariu
FROM Antrenori
WHERE Salariu = (SELECT MAX(Salariu) FROM Antrenori);

-- 17. Afișează media numărului de ședințe rămase per membru
SELECT 
    m.Nume || ' ' || m.Prenume AS Membru,
    AVG(ach.Sedinte_Ramas) AS Medie_Sedinte_Ramase
FROM Membri m
JOIN Achizitii ach ON m.ID_Membru = ach.ID_Membru
GROUP BY m.ID_Membru, m.Nume, m.Prenume;


-- ------------------------------------------
-- D. DML (UPDATE / DELETE) ȘI OPERAȚII CU CONSTRÂNGERI (18-20)
-- ------------------------------------------

-- 18. Actualizare: Scade cu 1 numărul de ședințe rămase pentru o achiziție specifică
UPDATE Achizitii
SET Sedinte_Ramas = Sedinte_Ramas - 1
WHERE ID_Achizitie = 1 AND Sedinte_Ramas > 0;

-- 19. Actualizare: Mărește salariul antrenorilor de Fotbal cu 10%
UPDATE Antrenori
SET Salariu = Salariu * 1.10
WHERE Specializare = 'Fotbal';

-- 20. Ștergere: Șterge prezențele marcate ca 'Absent' mai vechi de 1 an
DELETE FROM Prezente
WHERE Status = 'Absent' AND ID_Programare IN (
    SELECT ID_Programare FROM Programari WHERE Data_Ora < '2025-01-01'
);

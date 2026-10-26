-- View pentru Membri cu Abonamente Active
CREATE VIEW IF NOT EXISTS v_membri_activi AS
SELECT 
    m.ID_Membru,
    m.Nume || ' ' || m.Prenume AS Nume_Complet,
    m.Email,
    a.Tip_Abonament,
    ach.Sedinte_Ramas,
    ach.Data_Sfarsit
FROM Membri m
JOIN Achizitii ach ON m.ID_Membru = ach.ID_Membru
JOIN Abonamente a ON ach.ID_Abonament = a.ID_Abonament
WHERE ach.Sedinte_Ramas > 0 AND ach.Data_Sfarsit >= CURRENT_DATE;

-- View pentru Statistica Antrenorilor
CREATE VIEW IF NOT EXISTS v_statistici_antrenori AS
SELECT 
    ant.ID_Antrenor,
    ant.Nume || ' ' || ant.Prenume AS Antrenor,
    ant.Specializare,
    COUNT(DISTINCT p.ID_Programare) AS Total_Programari,
    COUNT(prez.ID_Prezenta) AS Total_Prezente_Sportivi
FROM Antrenori ant
LEFT JOIN Programari p ON ant.ID_Antrenor = p.ID_Antrenor
LEFT JOIN Prezente prez ON p.ID_Programare = prez.ID_Programare
GROUP BY ant.ID_Antrenor, ant.Nume, ant.Prenume, ant.Specializare;

-- db/views/01_views.sql

CREATE VIEW Program_Club AS
SELECT ant.id_antrenament, ant.data_ora, c.nume_categorie, s.nume_sala,
       a.nume AS nume_antrenor, a.prenume AS prenume_antrenor
FROM Antrenamente ant
JOIN Categorii_Antrenamente c ON ant.id_categorie = c.id_categorie
JOIN Sali s ON ant.id_sala = s.id_sala
JOIN Antrenori a ON ant.id_antrenor = a.id_antrenor;

CREATE VIEW Situatie_Membri_Plati AS
SELECT m.id_membru, m.nume, m.prenume, a.tip_abonament,
       COUNT(p.id_plata) AS numar_plati, COALESCE(SUM(p.suma), 0) AS total_achitat
FROM Membri m
LEFT JOIN Abonamente a ON m.id_abonament = a.id_abonament
LEFT JOIN Plati p ON m.id_membru = p.id_membru
GROUP BY m.id_membru, m.nume, m.prenume, a.tip_abonament;

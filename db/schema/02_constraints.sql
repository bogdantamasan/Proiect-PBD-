-- 1. Constrângeri UNIQUE (Evitarea duplicatelor)
ALTER TABLE Antrenori ADD CONSTRAINT uk_antrenor_email UNIQUE (Email);
ALTER TABLE Membri ADD CONSTRAINT uk_membru_email UNIQUE (Email);

-- 2. Constrângeri CHECK (Validarea datelor)
ALTER TABLE Antrenori ADD CONSTRAINT chk_antrenor_salariu CHECK (Salariu > 0);
ALTER TABLE Abonamente ADD CONSTRAINT chk_abonament_pret CHECK (Pret >= 0);
ALTER TABLE Abonamente ADD CONSTRAINT chk_abonament_sedinte CHECK (Numar_Sedinte > 0);
ALTER TABLE Abonamente ADD CONSTRAINT chk_abonament_luni CHECK (Valabilitate_Luni > 0);

-- Statusul unei prezențe poate fi doar din lista permisă
ALTER TABLE Prezente ADD CONSTRAINT chk_status_prezenta 
CHECK (Status IN ('Prezent', 'Absent', 'Motivat'));

-- Scorul de risc ML trebuie să fie o probabilitate între 0 și 1
ALTER TABLE CHURN_PREDICTIONS ADD CONSTRAINT chk_scor_risc 
CHECK (Scor_Risc >= 0.0 AND Scor_Risc <= 1.0);

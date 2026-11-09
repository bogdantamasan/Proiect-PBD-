-- Indecși pentru căutări frecvente pe nume și date
CREATE INDEX idx_membri_nume ON Membri(Nume, Prenume);
CREATE INDEX idx_programari_data ON Programari(Data_Ora);

-- Indecși pentru optimizarea JOIN-urilor (pe Cheile Străine)
CREATE INDEX idx_achizitii_membru ON Achizitii(ID_Membru);
CREATE INDEX idx_achizitii_abonament ON Achizitii(ID_Abonament);
CREATE INDEX idx_programari_sectie ON Programari(ID_Sectie);
CREATE INDEX idx_programari_antrenor ON Programari(ID_Antrenor);
CREATE INDEX idx_prezente_programare ON Prezente(ID_Programare);
CREATE INDEX idx_prezente_membru ON Prezente(ID_Membru);
CREATE INDEX idx_churn_membru ON CHURN_PREDICTIONS(ID_Membru);

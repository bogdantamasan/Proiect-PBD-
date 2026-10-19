-- Structura DDL pentru Baza de Date: Club Sportiv

CREATE TABLE IF NOT EXISTS Sectii (
    ID_Sectie INTEGER PRIMARY KEY AUTOINCREMENT,
    Nume_Sectie VARCHAR(50) NOT NULL,
    Descriere TEXT
);

CREATE TABLE IF NOT EXISTS Antrenori (
    ID_Antrenor INTEGER PRIMARY KEY AUTOINCREMENT,
    Nume VARCHAR(50) NOT NULL,
    Prenume VARCHAR(50) NOT NULL,
    Specializare VARCHAR(50),
    Telefon VARCHAR(15),
    Email VARCHAR(100) UNIQUE,
    Salariu DECIMAL(10, 2) CHECK (Salariu > 0)
);

CREATE TABLE IF NOT EXISTS Membri (
    ID_Membru INTEGER PRIMARY KEY AUTOINCREMENT,
    Nume VARCHAR(50) NOT NULL,
    Prenume VARCHAR(50) NOT NULL,
    Data_Nasterii DATE,
    Telefon VARCHAR(15),
    Email VARCHAR(100) UNIQUE,
    Data_Inscrierii DATE DEFAULT CURRENT_DATE
);

CREATE TABLE IF NOT EXISTS Abonamente (
    ID_Abonament INTEGER PRIMARY KEY AUTOINCREMENT,
    Tip_Abonament VARCHAR(50) NOT NULL,
    Pret DECIMAL(10, 2) CHECK (Pret >= 0),
    Numar_Sedinte INT CHECK (Numar_Sedinte > 0),
    Valabilitate_Luni INT CHECK (Valabilitate_Luni > 0)
);

CREATE TABLE IF NOT EXISTS Achizitii (
    ID_Achizitie INTEGER PRIMARY KEY AUTOINCREMENT,
    ID_Membru INT NOT NULL,
    ID_Abonament INT NOT NULL,
    Data_Inceput DATE NOT NULL,
    Data_Sfarsit DATE NOT NULL,
    Sedinte_Ramas INT NOT NULL,
    FOREIGN KEY (ID_Membru) REFERENCES Membri(ID_Membru) ON DELETE CASCADE,
    FOREIGN KEY (ID_Abonament) REFERENCES Abonamente(ID_Abonament)
);

CREATE TABLE IF NOT EXISTS Programari (
    ID_Programare INTEGER PRIMARY KEY AUTOINCREMENT,
    ID_Sectie INT NOT NULL,
    ID_Antrenor INT NOT NULL,
    Data_Ora DATETIME NOT NULL,
    Locatie VARCHAR(100),
    FOREIGN KEY (ID_Sectie) REFERENCES Sectii(ID_Sectie),
    FOREIGN KEY (ID_Antrenor) REFERENCES Antrenori(ID_Antrenor)
);

CREATE TABLE IF NOT EXISTS Prezente (
    ID_Prezenta INTEGER PRIMARY KEY AUTOINCREMENT,
    ID_Programare INT NOT NULL,
    ID_Membru INT NOT NULL,
    Status VARCHAR(20) DEFAULT 'Prezent',
    FOREIGN KEY (ID_Programare) REFERENCES Programari(ID_Programare) ON DELETE CASCADE,
    FOREIGN KEY (ID_Membru) REFERENCES Membri(ID_Membru) ON DELETE CASCADE
);

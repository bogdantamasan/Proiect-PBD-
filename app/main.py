import sqlite3
from datetime import date

DB_NAME = "club_sportiv.db"


def get_connection():
    conn = sqlite3.connect(DB_NAME)
    conn.execute("PRAGMA foreign_keys = ON;")
    return conn


def init_db():
    conn = get_connection()
    cur = conn.cursor()

    cur.executescript("""
    CREATE TABLE IF NOT EXISTS Abonamente (
        id_abonament INTEGER PRIMARY KEY AUTOINCREMENT,
        tip_abonament VARCHAR(50) NOT NULL,
        pret DECIMAL(10, 2) NOT NULL CHECK (pret > 0),
        valabilitate_luni INT NOT NULL CHECK (valabilitate_luni > 0)
    );

    CREATE TABLE IF NOT EXISTS Membri (
        id_membru INTEGER PRIMARY KEY AUTOINCREMENT,
        nume VARCHAR(50) NOT NULL,
        prenume VARCHAR(50) NOT NULL,
        data_nasterii DATE,
        id_abonament INT,
        FOREIGN KEY (id_abonament) REFERENCES Abonamente(id_abonament)
    );

    CREATE TABLE IF NOT EXISTS Plati (
        id_plata INTEGER PRIMARY KEY AUTOINCREMENT,
        id_membru INT NOT NULL,
        suma DECIMAL(10, 2) NOT NULL CHECK (suma > 0),
        data_platii DATE NOT NULL,
        metoda_plata VARCHAR(30),
        FOREIGN KEY (id_membru) REFERENCES Membri(id_membru) ON DELETE CASCADE
    );

    CREATE TABLE IF NOT EXISTS Sali (
        id_sala INTEGER PRIMARY KEY AUTOINCREMENT,
        nume_sala VARCHAR(50) NOT NULL,
        capacitate INT NOT NULL CHECK (capacitate > 0)
    );

    CREATE TABLE IF NOT EXISTS Echipamente (
        id_echipament INTEGER PRIMARY KEY AUTOINCREMENT,
        id_sala INT NOT NULL,
        denumire VARCHAR(100) NOT NULL,
        stare VARCHAR(30) DEFAULT 'Functional',
        FOREIGN KEY (id_sala) REFERENCES Sali(id_sala) ON DELETE CASCADE
    );

    CREATE TABLE IF NOT EXISTS Categorii_Antrenamente (
        id_categorie INTEGER PRIMARY KEY AUTOINCREMENT,
        nume_categorie VARCHAR(50) NOT NULL UNIQUE
    );

    CREATE TABLE IF NOT EXISTS Antrenori (
        id_antrenor INTEGER PRIMARY KEY AUTOINCREMENT,
        nume VARCHAR(50) NOT NULL,
        prenume VARCHAR(50) NOT NULL,
        telefon VARCHAR(15)
    );

    CREATE TABLE IF NOT EXISTS Evaluari_Antrenori (
        id_evaluare INTEGER PRIMARY KEY AUTOINCREMENT,
        id_membru INT NOT NULL,
        id_antrenor INT NOT NULL,
        nota INT CHECK (nota BETWEEN 1 AND 5),
        comentariu TEXT,
        FOREIGN KEY (id_membru) REFERENCES Membri(id_membru) ON DELETE CASCADE,
        FOREIGN KEY (id_antrenor) REFERENCES Antrenori(id_antrenor) ON DELETE CASCADE
    );

    CREATE TABLE IF NOT EXISTS Antrenamente (
        id_antrenament INTEGER PRIMARY KEY AUTOINCREMENT,
        id_categorie INT NOT NULL,
        id_sala INT NOT NULL,
        id_antrenor INT NOT NULL,
        data_ora DATETIME NOT NULL,
        FOREIGN KEY (id_categorie) REFERENCES Categorii_Antrenamente(id_categorie),
        FOREIGN KEY (id_sala) REFERENCES Sali(id_sala),
        FOREIGN KEY (id_antrenor) REFERENCES Antrenori(id_antrenor)
    );

    CREATE TABLE IF NOT EXISTS Prezente (
        id_prezenta INTEGER PRIMARY KEY AUTOINCREMENT,
        id_membru INT NOT NULL,
        id_antrenament INT NOT NULL,
        FOREIGN KEY (id_membru) REFERENCES Membri(id_membru) ON DELETE CASCADE,
        FOREIGN KEY (id_antrenament) REFERENCES Antrenamente(id_antrenament) ON DELETE CASCADE
    );
    """)

    # Seed initial daca baza de date este goala
    if cur.execute("SELECT COUNT(*) FROM Abonamente").fetchone()[0] == 0:
        cur.executescript("""
        INSERT INTO Abonamente (tip_abonament, pret, valabilitate_luni) VALUES
        ('Standard', 150.00, 1), ('Premium', 350.00, 3), ('VIP', 600.00, 6);

        INSERT INTO Membri (nume, prenume, data_nasterii, id_abonament) VALUES
        ('Ionescu', 'Mihai', '2001-05-15', 1),
        ('Stan', 'Florin', '1999-11-20', 2),
        ('Radu', 'Cristian', '2002-03-10', 3);

        INSERT INTO Plati (id_membru, suma, data_platii, metoda_plata) VALUES
        (1, 150.00, '2026-11-01', 'Card'),
        (2, 350.00, '2026-11-02', 'Transfer'),
        (3, 600.00, '2026-11-03', 'Card');

        INSERT INTO Sali (nume_sala, capacitate) VALUES
        ('Sala Forta 1', 30), ('Sala Aerobic', 20), ('Teren Fotbal', 22);

        INSERT INTO Categorii_Antrenamente (nume_categorie) VALUES
        ('Fitness'), ('Fotbal'), ('Recuperare');

        INSERT INTO Antrenori (nume, prenume, telefon) VALUES
        ('Popescu', 'Ion', '0722123456'), ('Muresan', 'Andrei', '0733123456');

        INSERT INTO Antrenamente (id_categorie, id_sala, id_antrenor, data_ora) VALUES
        (1, 1, 1, '2026-11-15 18:00:00'), (2, 3, 2, '2026-11-16 19:00:00');

        INSERT INTO Prezente (id_membru, id_antrenament) VALUES (1, 1), (2, 2), (3, 2);
        """)

    conn.commit()
    conn.close()


def listeaza_membri():
    conn = get_connection()
    rows = conn.execute("""
        SELECT m.id_membru, m.nume, m.prenume, m.data_nasterii, a.tip_abonament, a.pret
        FROM Membri m
        LEFT JOIN Abonamente a ON m.id_abonament = a.id_abonament
    """).fetchall()
    conn.close()
    print("\n--- LISTA MEMBRI ---")
    for r in rows:
        print(f"ID: {r[0]} | {r[1]} {r[2]} | Nascut: {r[3]} | Abonament: {r[4]} ({r[5]} RON)")


def adauga_membru():
    nume = input("Nume: ").strip()
    prenume = input("Prenume: ").strip()
    data_n = input("Data nasterii (YYYY-MM-DD): ").strip()
    id_ab = int(input("ID Abonament (1=Standard, 2=Premium, 3=VIP): "))
    conn = get_connection()
    try:
        conn.execute(
            "INSERT INTO Membri (nume, prenume, data_nasterii, id_abonament) VALUES (?, ?, ?, ?)",
            (nume, prenume, data_n, id_ab)
        )
        conn.commit()
        print("Membru adaugat cu succes!")
    except sqlite3.IntegrityError as e:
        print(f"Eroare de integritate: {e}")
    finally:
        conn.close()


def actualizeaza_abonament_membru():
    id_m = int(input("ID Membru de actualizat: "))
    id_ab = int(input("Noul ID Abonament (1=Standard, 2=Premium, 3=VIP): "))
    conn = get_connection()
    try:
        cur = conn.execute("UPDATE Membri SET id_abonament = ? WHERE id_membru = ?", (id_ab, id_m))
        conn.commit()
        print("Abonament actualizat!" if cur.rowcount else "Membrul nu a fost gasit.")
    except sqlite3.IntegrityError as e:
        print(f"Eroare de integritate: {e}")
    finally:
        conn.close()


def sterge_membru():
    id_m = int(input("ID Membru de sters: "))
    conn = get_connection()
    cur = conn.execute("DELETE FROM Membri WHERE id_membru = ?", (id_m,))
    conn.commit()
    conn.close()
    print("Membru sters (inclusiv platile/prezentele asociate)." if cur.rowcount else "Membrul nu a fost gasit.")


def inregistreaza_plata():
    id_m = int(input("ID Membru: "))
    suma = float(input("Suma (RON): "))
    metoda = input("Metoda plata (Card/Cash/Transfer): ").strip()
    conn = get_connection()
    try:
        conn.execute(
            "INSERT INTO Plati (id_membru, suma, data_platii, metoda_plata) VALUES (?, ?, ?, ?)",
            (id_m, suma, str(date.today()), metoda)
        )
        conn.commit()
        print("Plata inregistrata cu succes!")
    except sqlite3.IntegrityError as e:
        print(f"Eroare de integritate: {e}")
    finally:
        conn.close()


def afiseaza_program_antrenamente():
    conn = get_connection()
    rows = conn.execute("""
        SELECT ant.id_antrenament, ant.data_ora, c.nume_categorie, s.nume_sala, a.nume || ' ' || a.prenume
        FROM Antrenamente ant
        JOIN Categorii_Antrenamente c ON ant.id_categorie = c.id_categorie
        JOIN Sali s ON ant.id_sala = s.id_sala
        JOIN Antrenori a ON ant.id_antrenor = a.id_antrenor
    """).fetchall()
    conn.close()
    print("\n--- PROGRAM ANTRENAMENTE ---")
    for r in rows:
        print(f"ID: {r[0]} | {r[1]} | {r[2]} | Sala: {r[3]} | Antrenor: {r[4]}")


def meniu():
    init_db()
    while True:
        print("\n=== GESTIUNE CLUB SPORTIV (CRUD) ===")
        print("1. Listeaza membri (READ)")
        print("2. Adauga membru (CREATE)")
        print("3. Actualizeaza abonament membru (UPDATE)")
        print("4. Sterge membru (DELETE)")
        print("5. Inregistreaza plata (CREATE)")
        print("6. Vezi program antrenamente (JOIN)")
        print("0. Iesire")
        opt = input("Alege o optiune: ").strip()

        if opt == "1":
            listeaza_membri()
        elif opt == "2":
            adauga_membru()
        elif opt == "3":
            actualizeaza_abonament_membru()
        elif opt == "4":
            sterge_membru()
        elif opt == "5":
            inregistreaza_plata()
        elif opt == "6":
            afiseaza_program_antrenamente()
        elif opt == "0":
            break
        else:
            print("Optiune invalida.")


if __name__ == "__main__":
    meniu()

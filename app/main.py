import sqlite3
import os
import tkinter as tk
from tkinter import ttk, messagebox
import pandas as pd
from sklearn.ensemble import RandomForestClassifier

DB_NAME = "club_sportiv.db"

def init_db():
    """Inițializează baza de date și creează structura de tabele."""
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    
    # Creează tabelele
    cursor.executescript("""
    CREATE TABLE IF NOT EXISTS Sectii (
        ID_Sectie INTEGER PRIMARY KEY AUTOINCREMENT,
        Nume_Sectie TEXT NOT NULL,
        Descriere TEXT
    );

    CREATE TABLE IF NOT EXISTS Antrenori (
        ID_Antrenor INTEGER PRIMARY KEY AUTOINCREMENT,
        Nume TEXT NOT NULL,
        Prenume TEXT NOT NULL,
        Specializare TEXT,
        Telefon TEXT,
        Salariu REAL
    );

    CREATE TABLE IF NOT EXISTS Membri (
        ID_Membru INTEGER PRIMARY KEY AUTOINCREMENT,
        Nume TEXT NOT NULL,
        Prenume TEXT NOT NULL,
        Data_Nasterii TEXT,
        Telefon TEXT,
        Email TEXT UNIQUE,
        Data_Inscrierii TEXT
    );

    CREATE TABLE IF NOT EXISTS Abonamente (
        ID_Abonament INTEGER PRIMARY KEY AUTOINCREMENT,
        Tip_Abonament TEXT NOT NULL,
        Pret REAL NOT NULL,
        Numar_Sedinte INTEGER NOT NULL,
        Valabilitate_Luni INTEGER NOT NULL
    );

    CREATE TABLE IF NOT EXISTS Achizitii (
        ID_Achizitie INTEGER PRIMARY KEY AUTOINCREMENT,
        ID_Membru INTEGER,
        ID_Abonament INTEGER,
        Data_Inceput TEXT,
        Data_Sfarsit TEXT,
        Sedinte_Ramas INTEGER,
        FOREIGN KEY (ID_Membru) REFERENCES Membri(ID_Membru),
        FOREIGN KEY (ID_Abonament) REFERENCES Abonamente(ID_Abonament)
    );

    CREATE TABLE IF NOT EXISTS Rezultate_IA (
        ID_Rezultat INTEGER PRIMARY KEY AUTOINCREMENT,
        ID_Membru INTEGER,
        Sedinte_Asezate INTEGER,
        Risc_Renuntare_Predus INTEGER,
        Probabilitate_Risc REAL,
        FOREIGN KEY (ID_Membru) REFERENCES Membri(ID_Membru)
    );
    """)

    # Populează cu date de test dacă baza de date este goală
    cursor.execute("SELECT COUNT(*) FROM Membri")
    if cursor.fetchone()[0] == 0:
        cursor.executescript("""
        INSERT INTO Sectii (Nume_Sectie, Descriere) VALUES 
        ('Fotbal', 'Echipă și antrenamente pe teren mare'),
        ('Baschet', 'Pregătire fizică și tactică baschet'),
        ('Înot', 'Cursuri înot copii și adulți');

        INSERT INTO Antrenori (Nume, Prenume, Specializare, Telefon, Salariu) VALUES 
        ('Popescu', 'Ion', 'Fotbal', '0722111222', 4500.0),
        ('Ionescu', 'Maria', 'Înot', '0733222333', 4200.0);

        INSERT INTO Membri (Nume, Prenume, Data_Nasterii, Telefon, Email, Data_Inscrierii) VALUES 
        ('Ionescu', 'Andrei', '2001-05-12', '0744123456', 'andrei.ionescu@gmail.com', '2025-01-10'),
        ('Vasilescu', 'Elena', '1998-09-20', '0755987654', 'elena.vasilescu@yahoo.com', '2025-02-15'),
        ('Radu', 'Mihai', '2003-11-02', '0766333444', 'mihai.radu@gmail.com', '2025-03-01');

        INSERT INTO Abonamente (Tip_Abonament, Pret, Numar_Sedinte, Valabilitate_Luni) VALUES 
        ('Lunar Standard', 200.0, 12, 1),
        ('Trimestrial VIP', 500.0, 36, 3);

        INSERT INTO Achizitii (ID_Membru, ID_Abonament, Data_Inceput, Data_Sfarsit, Sedinte_Ramas) VALUES 
        (1, 1, '2026-03-01', '2026-04-01', 8),
        (2, 2, '2026-02-01', '2026-05-01', 2);
        """)

    conn.commit()
    conn.close()

# --- MODUL INTELIGENȚĂ ARTIFICIALĂ ---
def ruleaza_modul_ia():
    """Rulează modelul de IA pentru clasificarea riscului de renunțare (Churn Prediction)."""
    conn = sqlite3.connect(DB_NAME)
    
    # Exemplu set de date istoric pentru antrenare (Simulat din activitatea sportivilor)
    data = {
        'Varsta': [22, 35, 19, 45, 28, 31, 50, 24, 29, 40],
        'Sedinte_Lunate_Efectuate': [2, 12, 1, 10, 3, 11, 0, 14, 2, 8],
        'Zile_De_La_Ultima_Vizita': [25, 2, 30, 4, 20, 3, 40, 1, 18, 5],
        'Renuntat': [1, 0, 1, 0, 1, 0, 1, 0, 1, 0] # 1 = A renunțat, 0 = Activ
    }
    df = pd.DataFrame(data)

    X = df[['Varsta', 'Sedinte_Lunate_Efectuate', 'Zile_De_La_Ultima_Vizita']]
    y = df['Renuntat']

    # Antrenare Model ML
    model = RandomForestClassifier(n_estimators=10, random_state=42)
    model.fit(X, y)

    # Extragere membri existenți din BD pentru realizarea predicțiilor
    membri_df = pd.read_sql_query("SELECT ID_Membru, Nume, Prenume FROM Membri", conn)

    # Predicție pe date reale/test pentru fiecare membru
    cursor = conn.cursor()
    cursor.execute("DELETE FROM Rezultate_IA") # Curățare rezultate anterioare
    
    # Generăm predicții simulate pentru membrii existenți
    test_features = [
        [25, 2, 22], # Membru 1 - activitate scăzută
        [28, 10, 3], # Membru 2 - activitate ridicată
        [23, 1, 28]  # Membru 3 - activitate scăzută
    ]

    for idx, row in membri_df.iterrows():
        id_m = int(row['ID_Membru'])
        feat = test_features[idx % len(test_features)]
        
        pred = model.predict([feat])[0]
        prob = model.predict_proba([feat])[0][1]

        cursor.execute("""
            INSERT INTO Rezultate_IA (ID_Membru, Sedinte_Asezate, Risc_Renuntare_Predus, Probabilitate_Risc)
            VALUES (?, ?, ?, ?)
        """, (id_m, feat[1], int(pred), round(float(prob), 2)))

    conn.commit()
    conn.close()
    messagebox.showinfo("Modul IA", "Modelul de IA a fost antrenat, iar predicțiile au fost salvate în baza de date cu succes!")

# --- INTERFAȚA GRAFICĂ (GUI) ---
class ClubApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Gestiune Club Sportiv - Proiect BD")
        self.root.geometry("700x500")

        # Tab Control
        notebook = ttk.Notebook(root)
        notebook.pack(fill='both', expand=True, padx=10, pady=10)

        # Tab Membri
        tab_membri = ttk.Frame(notebook)
        notebook.add(tab_membri, text="Membri")
        self.build_membri_tab(tab_membri)

        # Tab IA / ML
        tab_ia = ttk.Frame(notebook)
        notebook.add(tab_ia, text="Modul IA (ML)")
        self.build_ia_tab(tab_ia)

    def build_membri_tab(self, frame):
        # Tabel afișare membri
        self.tree = ttk.Treeview(frame, columns=("ID", "Nume", "Prenume", "Email"), show="headings")
        self.tree.heading("ID", text="ID")
        self.tree.heading("Nume", text="Nume")
        self.tree.heading("Prenume", text="Prenume")
        self.tree.heading("Email", text="Email")
        self.tree.pack(fill="both", expand=True, pady=10)

        btn_load = ttk.Button(frame, text="Incarca Membri", command=self.load_membri)
        btn_load.pack(side="left", padx=10)

    def load_membri(self):
        for item in self.tree.get_children():
            self.tree.delete(item)
        conn = sqlite3.connect(DB_NAME)
        cursor = conn.cursor()
        cursor.execute("SELECT ID_Membru, Nume, Prenume, Email FROM Membri")
        for row in cursor.fetchall():
            self.tree.insert("", "end", values=row)
        conn.close()

    def build_ia_tab(self, frame):
        lbl_info = ttk.Label(frame, text="Clasificare Risc Abandon Abonament (Machine Learning)", font=('Arial', 12, 'bold'))
        lbl_info.pack(pady=15)

        btn_run_ia = ttk.Button(frame, text="Antreneaza Model IA & Salveaza Predictii", command=ruleaza_modul_ia)
        btn_run_ia.pack(pady=10)

        self.tree_ia = ttk.Treeview(frame, columns=("ID_Membru", "Sedinte", "Risc Predus", "Probabilitate"), show="headings")
        self.tree_ia.heading("ID_Membru", text="ID Membru")
        self.tree_ia.heading("Sedinte", text="Sedinte Efectuate")
        self.tree_ia.heading("Risc Predus", text="Risc Renuntare (1=Da, 0=Nu)")
        self.tree_ia.heading("Probabilitate", text="Probabilitate Risc")
        self.tree_ia.pack(fill="both", expand=True, pady=10)

        btn_load_ia = ttk.Button(frame, text="Afiseaza Rezultate Salvate din BD", command=self.load_ia_results)
        btn_load_ia.pack(pady=5)

    def load_ia_results(self):
        for item in self.tree_ia.get_children():
            self.tree_ia.delete(item)
        conn = sqlite3.connect(DB_NAME)
        cursor = conn.cursor()
        cursor.execute("SELECT ID_Membru, Sedinte_Asezate, Risc_Renuntare_Predus, Probabilitate_Risc FROM Rezultate_IA")
        for row in cursor.fetchall():
            self.tree_ia.insert("", "end", values=row)
        conn.close()

if __name__ == "__main__":
    init_db()
    root = tk.Tk()
    app = ClubApp(root)
    root.mainloop()

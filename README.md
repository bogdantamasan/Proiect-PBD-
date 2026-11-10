#  Aplicație pentru Evidența și Gestiunea Activității dintr-un Club Sportiv

**Student:** Tămășan Bogdan  
**Specializare:** Calculatoare, Anul III
**Disciplina:** Proiectarea Bazelor de Date (PBD) 
**Repository:** `https://github.com/bogdantamasan/Proiect-PBD-`

---

##  1. Scopul Proiectului
Proiectul își propune proiectarea și implementarea unei baze de date relaționale destinate gestionării integrate a activităților operative dintr-un **Club Sportiv**. 

În absența unui sistem centralizat, clubul se confruntă cu:
* Evidența greoaie a abonamentelor active și a ședințelor rămase.
* Suprapuneri de programări pe săli/secții sportive.
* Dificultatea urmăririi prezenței membrilor la antrenamente.
* Imposibilitatea efectuării unei analize predictive privind retenția membrilor.

Sistemul rezolvă aceste probleme prin automatizarea fluxurilor de date, validarea constrângerilor de integritate referențială și oferirea unui modul analitic de clasificare/predicție.

---

##  2. Obiectivele Proiectului

###  Obiective Funcționale
1. **Gestiunea Membrilor & Antrenorilor:** Evidența datelor personale, contactelor și atribuțiilor speciale.
2. **Managementul Secțiilor Sportive:** Organizarea antrenamentelor pe categorii (Fotbal, Baschet, Înot, Tenis etc.).
3. **Gestiunea Abonamentelor & Achizițiilor:** Monitorizarea datelor de expirare, a prețurilor și a numărului de ședințe disponibile.
4. **Programări & Prezențe:** Alocarea pe săli/antrenori și contorizarea automată a prezenței sportivilor.
5. **Integrare IA / Machine Learning:** Predicția riscului de abandon (Churn Risk) în funcție de numărul de ședințe efectuate și starea abonamentului.

###  Obiective Tehnice
* Normalizarea schemei relaționale până la **Forma Normală 3 (FN3)**.
* Implementarea constrângerilor de integritate (`NOT NULL`, `UNIQUE`, `CHECK`, `FOREIGN KEY ON DELETE CASCADE`).
* Crearea unei aplicații client CRUD în Python conectată la SQLite/PostgreSQL.
* Interogarea avansată a datelor prin 20 de interogări SQL complexe (`JOIN`, `GROUP BY`, `HAVING`, subinterogări).

---
##  3. Structura Depozitului

```text
proiect-bd/
├── README.md
├── CHANGELOG.md
├── .gitignore
├── docs/
│   └── Tamasan_Bogdan_Proiect_BD.docx     # Documentația completă Word
├── db/
│   ├── schema/
│   │   ├── 01_create_tables.sql           # Structura DDL a tabelelor
│   │   ├── 02_constraints.sql             # Constrângeri CHECK și UNIQUE
│   │   └── 03_indexes.sql                 # Indecși pentru optimizarea performanței
│   ├── seed/
│   │   └── 01_insert_date.sql             # Date de test pentru populare (10+ înregistrări/tabel)
│   ├── queries/
│   │   └── 01_interogari_complexe.sql     # Cele 20 de interogări SQL 
│   └── views/
│       └── 01_create_views.sql            # View-uri pentru statistici
├── diagrams/                              # Modele ER și fluxuri (Mermaid .mmd)
├── teste/
│   └── teste_constrangeri.sql             # Script pentru testarea inserărilor invalide
└── app/
    ├── main.py                            # Aplicația Python CRUD 
    ├── ml_script.py                       # Modulul de predicție ML (Churn)
    └── requirements.txt                   # Dependențe Python

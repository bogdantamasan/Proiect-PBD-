# Changelog

Toate modificările importante aduse proiectului de **Proiectarea Bazelor de Date (PBD)** sunt documentate în acest fișier.

## [v0.5-etapa9-10] - (Săptămâna 9)
### Adăugat / Modificat
- **Aplicație CRUD (`app/main.py`, `app/requirements.txt`):** Dezvoltarea aplicației client în Python conectată la SQLite pentru operații Create, Read, Update, Delete și rapoarte cu JOIN.
- **Interogări SQL (`db/queries/01_interogari.sql`):** Finalizarea setului de 20 de interogări SQL (SELECT, WHERE, ORDER BY, JOIN, GROUP BY, HAVING, subinterogări, DML, VIEW, CTE).
- **View-uri (`db/views/01_views.sql`):** Crearea view-urilor `Program_Club` și `Situatie_Membri_Plati`.
- **Teste Constrângeri (`teste/teste_constrangeri.sql`):** Script dedicat pentru verificarea constrângerilor (`CHECK`, `NOT NULL`, `FOREIGN KEY`, `UNIQUE`, `ON DELETE CASCADE`).
- **Documentație Word (`docs/Tamasan_Bogdan_Proiect_BD.docx`):** Adăugarea Capitolului 8 (Aplicația CRUD și Testarea Constrângerilor) și aplicarea formatării cerute.

---

## [v0.4-etapa7-8] - (Săptămânile 7-8)
### Adăugat / Modificat
- **Model Fizic DDL (`db/schema/01_create_tables.sql`):** Implementarea fizică a celor 10 tabele (`Abonamente`, `Membri`, `Plati`, `Sali`, `Echipamente`, `Categorii_Antrenamente`, `Antrenori`, `Evaluari_Antrenori`, `Antrenamente`, `Prezente`) cu chei primare, chei străine și constrângeri de integritate.
- **Seed Data (`db/seed/01_insert_date.sql`):** Popularea tuturor celor 10 tabele cu date inițiale de test.
- **Diagrame (`db/diagrams/er.mmd`, `db/diagrams/schema.png`):** Actualizarea diagramei ER la 10 entități și exportul în format PNG.
- **Documentație Word (`docs/Tamasan_Bogdan_Proiect_BD.docx`):** Extinderea analizei cerințelor, adăugarea modelului fizic și a justificării entităților.

---

## [v0.3-etapa5-6] - (Săptămânile 5-6)
### Adăugat
- **Model Logic și Normalizare:** Transformarea modelului ER în schemă relațională și normalizarea până la Forma Normală 3 (FN3).
- **Dicționar de Date:** Definirea tipurilor de date, constrângerilor și descrierilor pentru toate coloanele din bază.
- **Documentație Word (`docs/Tamasan_Bogdan_Proiect_BD.docx`):** Completarea capitolelor privind modelul logic, normalizarea (FN1–FN3) și dicționarul de date.

---

## [v0.2-proiectare] - (Săptămânile 2-4)
### Adăugat
- **Analiza Cerințelor:** Identificarea proceselor de business, a rolurilor de utilizatori și a regulilor de integritate pentru clubul sportiv.
- **Model Conceptual ER (`db/diagrams/er.mmd`):** Definirea entităților inițiale, atributelor și cardinalităților relațiilor (1:N, M:N).
- **Documentație Word (`docs/`):** Adăugarea capitolelor de analiză a cerințelor și proiectare conceptuală.

---

## [v0.1-analiza] - (Săptămâna 1)
### Adăugat
- Inițializarea depozitului Git și a structurii de directoare (`docs/`, `db/`, `app/`, `teste/`).
- Crearea fișierului `README.md` cu definirea domeniului (**Club Sportiv**), scopului și obiectivelor proiectului.
- Adăugarea fișierului `.gitignore`.

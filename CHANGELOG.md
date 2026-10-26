# Changelog

Toate modificările importante aduse proiectului de **Proiectarea Bazelor de Date (PBD)** vor fi documentate în acest fișier.

---

## [v0.3-etapa5-6] - 2026-10-26 (Săptămânile 5-6)
### Adăugat
- **Seed Data (`db/seed/01_insert_date.sql`):** Script de populare a bazei de date cu date de test (utilizatori, antrenori, echipe, sportivi, antrenamente, prezențe și plăți).
- **Interogări SQL (`db/queries/01_interogari_complexe.sql`):** Set complet de 20 de interogări SQL (simple, complexe cu JOIN, agregări cu GROUP BY/HAVING, subinterogări și operații DML).
- **Teste Constrângeri (`teste/teste_constrangeri.sql`):** Script pentru verificarea constrângerilor de integritate (UNIQUE, CHECK, FOREIGN KEY).
- **Dependențe Aplicație (`app/requirements.txt`):** Lista pachetelor necesare pentru modulul Python de Machine Learning (pandas, scikit-learn).
- **Documentație Word (`docs/`):** Actualizare documentație cu Normalizare (FN1-FN3), Dicționar de date complet și secțiunea de integrări IA/ML.

---

## [v0.2-proiectare] - 2026-10-12 (Săptămânile 2-4)
### Adăugat
- **Schema DDL (`db/schema/01_create_tables.sql`):** Structura tabelelor cu chei primare, chei străine, constrângeri și CASCADE delete.
- **Diagrame (`diagrams/`):** Modelul Conceptual ER și Modelul Logic Relațional în format Mermaid (`.mmd`).
- **Modul IA/ML (`app/ml_script.py`):** Scriptul Python pentru clasificarea și predicția riscului de abandon (Churn Risk) al membrilor.

---

## [v0.1-analiza] - 2026-09-28 (Săptămâna 1)
### Adăugat
- Inițializarea depozitului Git și a structurii de directoare (`db/`, `docs/`, `diagrams/`, `app/`, `teste/`).
- Crearea fișierului `README.md` cu definirea scopului, obiectivelor și domeniului ales (**Club Sportiv / SportClub Manager**).
- Adăugarea fișierului `.gitignore`.

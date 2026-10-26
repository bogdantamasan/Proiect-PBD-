# 🏋️‍♂️ Aplicație pentru Evidența și Gestiunea Activității dintr-un Club Sportiv

**Student:** Tămășan Bogdan  
**Specializare:** Calculatoare, Anul III
**Disciplina:** Proiectarea Bazelor de Date (PBD) 
**Repository:** `https://github.com/bogdantamasan/Proiect-PBD-`

---

## 📌 1. Scope & Motivativă (Scopul Proiectului)
Proiectul își propune proiectarea și implementarea unei baze de date relaționale destinate gestionării integrate a activităților operative dintr-un **Club Sportiv**[cite: 1, 2]. 

În absența unui sistem centralizat, clubul se confruntă cu:
* Evidența greoaie a abonamentelor active și a ședințelor rămase.
* Suprapuneri de programări pe săli/secții sportive.
* Dificultatea urmăririi prezenței membrilor la antrenamente.
* Imposibilitatea efectuării unei analize predictive privind retenția membrilor.

Sistemul rezolvă aceste probleme prin automatizarea fluxurilor de date, validarea constrângerilor de integritate referențială și oferirea unui modul analitic de clasificare/predicție[cite: 2, 3].

---

## 🎯 2. Obiectivele Proiectului

### 🔹 Obiective Funcționale
1. **Gestiunea Membrilor & Antrenorilor:** Evidența datelor personale, contactelor și atribuțiilor speciale.
2. **Managementul Secțiilor Sportive:** Organizarea antrenamentelor pe categorii (Fotbal, Baschet, Înot, Tenis etc.).
3. **Gestiunea Abonamentelor & Achizițiilor:** Monitorizarea datelor de expirare, a prețurilor și a numărului de ședințe disponibile.
4. **Programări & Prezențe:** Alocarea pe săli/antrenori și contorizarea automată a prezenței sportivilor.
5. **Integrare IA / Machine Learning:** Predicția riscului de abandon (Churn Risk) în funcție de numărul de ședințe efectuate și starea abonamentului.

### 🔹 Obiective Tehnice
* Normalizarea schemei relaționale până la **Forma Normală 3 (FN3)**[cite: 2, 3].
* Implementarea constrângerilor de integritate (`NOT NULL`, `UNIQUE`, `CHECK`, `FOREIGN KEY ON DELETE CASCADE`).
* Crearea unei aplicații client CRUD în Python conectată la SQLite/PostgreSQL[cite: 2, 3].
* Interogarea avansată a datelor prin 20 de interogări SQL complexe (`JOIN`, `GROUP BY`, `HAVING`, subinterogări).

---

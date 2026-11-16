# Aplicație pentru Evidența și Gestiunea Activității dintr-un Club Sportiv

**Student:** Tămășan Bogdan  
**Specializare:** Calculatoare, Anul III  
**Disciplina:** Proiectarea Bazelor de Date (PBD)  
**Repository:** https://github.com/bogdantamasan/Proiect-PBD-  

## 1. Scopul Proiectului
Proiectul își propune proiectarea și implementarea unei baze de date relaționale destinate gestionării integrate a activităților operative dintr-un Club Sportiv.

În absența unui sistem centralizat, clubul se confruntă cu:
- Evidența greoaie a abonamentelor, plăților și a valabilității acestora.
- Suprapuneri de programări pe săli, antrenori și categorii sportive.
- Dificultăți în gestionarea inventarului de echipamente din săli.
- Dificultatea urmăririi prezenței membrilor la antrenamente și a evaluării performanței antrenorilor.
- Imposibilitatea efectuării unei analize predictive privind retenția membrilor.

Sistemul rezolvă aceste probleme prin automatizarea fluxurilor de date, validarea constrângerilor de integritate referențială și oferirea unui modul analitic de clasificare/predicție.

## 2. Obiectivele Proiectului

### Obiective Funcționale
1. **Gestiunea Membrilor & Antrenorilor:** Evidența datelor personale, contactelor și a sistemului de feedback (evaluări) pentru antrenori.
2. **Managementul Sălilor & Echipamentelor:** Organizarea spațiilor fizice și monitorizarea inventarului.
3. **Gestiunea Abonamentelor & Plăților:** Monitorizarea tipurilor de abonamente, a prețurilor, a perioadelor de valabilitate și a istoricului tranzacțiilor.
4. **Programări (Antrenamente) & Prezențe:** Alocarea claselor pe săli/antrenori/categorii și contorizarea automată a prezenței sportivilor.
5. **Integrare IA / Machine Learning:** Predicția riscului de abandon (Churn Risk) în funcție de istoricul de prezențe, evaluări și plăți.

### Obiective Tehnice
- Normalizarea schemei relaționale până la Forma Normală 3 (FN3).
- Implementarea constrângerilor de integritate (NOT NULL, UNIQUE, CHECK, FOREIGN KEY ON DELETE CASCADE).
- Crearea unei aplicații client CRUD în Python conectată la baza de date.
- Interogarea avansată a datelor prin 20 de interogări SQL complexe (JOIN, GROUP BY, HAVING, subinterogări, VIEW-uri, CTE-uri).

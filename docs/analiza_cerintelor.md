# Analiza Cerințelor - SportClub Manager

## 1. Descrierea Domeniului
Sistemul este destinat gestionării activității unui **Club Sportiv**, care oferă facilități pentru multiple discipline (Fotbal, Înot, Fitness, Tenis) și gestionează un număr mare de membri, antrenori și abonamente.

## 2. Identificarea Problemelor (Situația Curentă)
În lipsa unui sistem informatic centralizat, clubul întâmpină următoarele dificultăți:
- Evidența manuală a abonamentelor duce la erori în contorizarea ședințelor rămase.
- Dificultăți în programarea antrenamentelor, existând riscul suprapunerii antrenorilor sau sălilor.
- Lipsa unei trasabilități clare a prezenței membrilor la antrenamente.
- Imposibilitatea anticipării membrilor care renunță la serviciile clubului (risc de abandon/churn).

## 3. Cerințe Funcționale (Ce trebuie să facă sistemul)
Sistemul informatic și baza de date trebuie să asigure următoarele funcționalități:
- **Gestiunea entităților de bază:** Permite adăugarea, modificarea și ștergerea informațiilor despre `Membri`, `Antrenori` și `Secții`.
- **Gestiunea financiară și de acces:** Definirea tipurilor de `Abonamente` și înregistrarea `Achizițiilor` făcute de membri, actualizând automat numărul de ședințe disponibile.
- **Gestiunea programărilor:** Crearea de `Programări` pentru antrenamente, asociind o secție, un antrenor responsabil, o dată/oră și o locație.
- **Monitorizarea prezenței:** Înregistrarea participării (`Prezențe`) fiecărui membru la programările stabilite, validând statusul (Prezent/Absent).
- **Analiza datelor (IA/ML):** Evaluarea periodică a membrilor și stocarea predicțiilor privind riscul de abandon în tabelul `CHURN_PREDICTIONS`.

## 4. Cerințe Non-Funcționale (Reguli de integritate)
- O adresă de email nu poate fi înregistrată de doi membri diferiți (UNIQUE).
- Salariile antrenorilor și prețurile abonamentelor trebuie să fie strict pozitive (CHECK > 0).
- Ștergerea unui membru din baza de date trebuie să atragă după sine (sau să restricționeze, după caz) ștergerea achizițiilor și prezențelor asociate (FOREIGN KEY).
- Baza de date va fi normalizată până la Forma Normală 3 (FN3) pentru a elimina complet redundanța informațiilor.

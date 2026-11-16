# Modelul Conceptual (Diagrama ER)

Diagrama de mai jos este generată automat și prezintă cele 10 entități ale bazei de date pentru clubul sportiv, împreună cu atributele și relațiile dintre ele (Primary Keys și Foreign Keys).

```mermaid
erDiagram
    ABONAMENTE ||--o{ MEMBRI : "detine"
    MEMBRI ||--o{ PLATI : "efectueaza"
    SALI ||--o{ ECHIPAMENTE : "contine"
    CATEGORII_ANTRENAMENTE ||--o{ ANTRENAMENTE : "clasifica"
    SALI ||--o{ ANTRENAMENTE : "gazduieste"
    ANTRENORI ||--o{ ANTRENAMENTE : "sustine"
    MEMBRI ||--o{ EVALUARI_ANTRENORI : "acorda"
    ANTRENORI ||--o{ EVALUARI_ANTRENORI : "primeste"
    MEMBRI ||--o{ PREZENTE : "participa"
    ANTRENAMENTE ||--o{ PREZENTE : "include"

    ABONAMENTE {
        int id_abonament PK
        varchar tip_abonament
        decimal pret
        int valabilitate_luni
    }

    MEMBRI {
        int id_membru PK
        varchar nume
        varchar prenume
        date data_nasterii
        int id_abonament FK
    }

    PLATI {
        int id_plata PK
        int id_membru FK
        decimal suma
        date data_platii
        varchar metoda_plata
    }

    SALI {
        int id_sala PK
        varchar nume_sala
        int capacitate
    }

    ECHIPAMENTE {
        int id_echipament PK
        int id_sala FK
        varchar denumire
        varchar stare
    }

    CATEGORII_ANTRENAMENTE {
        int id_categorie PK
        varchar nume_categorie
    }

    ANTRENORI {
        int id_antrenor PK
        varchar nume
        varchar prenume
        varchar telefon
    }

    EVALUARI_ANTRENORI {
        int id_evaluare PK
        int id_membru FK
        int id_antrenor FK
        int nota
        text comentariu
    }

    ANTRENAMENTE {
        int id_antrenament PK
        int id_categorie FK
        int id_sala FK
        int id_antrenor FK
        datetime data_ora
    }

    PREZENTE {
        int id_prezenta PK
        int id_membru FK
        int id_antrenament FK
    }

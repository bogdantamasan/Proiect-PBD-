classDiagram
    class Membru {
        +ID_Membru
        +Nume
        +Prenume
        +Email
        +Data_Inscrierii
        +cumparaAbonament()
        +participaAntrenament()
    }

    class Abonament {
        +ID_Abonament
        +Tip_Abonament
        +Pret
        +Numar_Sedinte
        +Valabilitate_Luni
    }

    class Achizitie {
        +ID_Achizitie
        +Data_Inceput
        +Data_Sfarsit
        +Sedinte_Ramas
        +valideazaAcces()
    }

    class Sectie {
        +ID_Sectie
        +Nume_Sectie
        +Descriere
    }

    class Antrenor {
        +ID_Antrenor
        +Nume
        +Prenume
        +Specializare
        +Email
    }

    class Programare {
        +ID_Programare
        +Data_Ora
        +Locatie
    }

    class Prezenta {
        +ID_Prezenta
        +Status
    }

    Membru "1" -- "0..*" Achizitie : efectueaza
    Abonament "1" -- "0..*" Achizitie : defineste
    Sectie "1" -- "0..*" Programare : organizeaza
    Antrenor "1" -- "0..*" Programare : coordoneaza
    Programare "1" -- "0..*" Prezenta : include
    Membru "1" -- "0..*" Prezenta : inregistreaza

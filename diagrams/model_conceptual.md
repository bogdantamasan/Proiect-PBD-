# Diagrama ER - Club Sportiv

```mermaid
erDiagram
    MEMBRU ||--o{ ABONAMENT : "achizitioneaza"
    ANTRENOR ||--o{ CLASA : "sustine"
    SALA ||--o{ CLASA : "gazduieste"
    MEMBRU ||--o{ PARTICIPARE : "se inscrie la"
    CLASA ||--o{ PARTICIPARE : "include"
```

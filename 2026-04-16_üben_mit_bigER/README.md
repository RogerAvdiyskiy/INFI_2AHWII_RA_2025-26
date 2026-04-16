# Bibliothek ER-Modell

## HÜ: ER-Modell mit BigER erstellen

### Aufgabenstellung
- Mitarbeiter der Bibliothek
- leiht aus / nimmt zurück
- BONUS: Buch → Exemplar

### BigER
1. VS Code öffnen
2. Extension "BigER Modeling Tool" installieren
3. Datei `buecher.erd` öffnen
4. Button "Open Diagram" klicken
PS. : Braucht nach meinem Wissen Java

---

## Dateien

| Datei | Beschreibung |
|-------|--------------|
| `buecher.erd` | ER-Diagramm (BigER Format) |
| `loesung.sql` | SQL DDL |
| `testdaten.sql` | Testdaten |
| `bibliothek.db` | SQLite Datenbank |

---

## SQL ausführen

```bash
sqlite3 bibliothek.db << 'EOF'
PRAGMA foreign_keys = ON;
.read loesung.sql
.read testdaten.sql
EOF
```

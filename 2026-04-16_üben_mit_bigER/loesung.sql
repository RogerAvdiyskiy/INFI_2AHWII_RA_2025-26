-- ============================================================================
-- BIBLIOTHEK DATENBANK - DDL (Data Definition Language)
-- ER-Modell: mitarbeiter, leser, buch, exemplar, ausleihe
-- ============================================================================

PRAGMA foreign_keys = ON;

-- ============================================================================
-- TABELLEN LOESCHEN (falls vorhanden, in umgekehrter Reihenfolge)
-- ============================================================================
DROP TABLE IF EXISTS ausleihe;
DROP TABLE IF EXISTS exemplar;
DROP TABLE IF EXISTS buch;
DROP TABLE IF EXISTS leser;
DROP TABLE IF EXISTS mitarbeiter;

-- ============================================================================
-- TABELLE: MITARBEITER
-- ============================================================================
CREATE TABLE mitarbeiter (
    id_mitarbeiter INTEGER PRIMARY KEY AUTOINCREMENT,
    vorname VARCHAR(50) NOT NULL,
    nachname VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefon VARCHAR(20),
    einstellungsdatum DATE NOT NULL
);

-- ============================================================================
-- TABELLE: LESER
-- ============================================================================
CREATE TABLE leser (
    id_leser INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    mitglied_seit DATE NOT NULL
);

-- ============================================================================
-- TABELLE: BUCH
-- ============================================================================
CREATE TABLE buch (
    id_buch INTEGER PRIMARY KEY AUTOINCREMENT,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    titel VARCHAR(255) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    verlag VARCHAR(100),
    erscheinungsjahr INTEGER
);

-- ============================================================================
-- TABELLE: EXEMPLAR (BONUS: Buch -> Exemplar 1:N)
-- ============================================================================
CREATE TABLE exemplar (
    id_exemplar INTEGER PRIMARY KEY AUTOINCREMENT,
    inventarnummer VARCHAR(50) NOT NULL UNIQUE,
    standort VARCHAR(100) NOT NULL,
    zustand VARCHAR(50),
    kaufdatum DATE,
    buch_id INTEGER NOT NULL,
    FOREIGN KEY (buch_id) REFERENCES buch(id_buch)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ============================================================================
-- TABELLE: AUSLEIHE
-- ============================================================================
CREATE TABLE ausleihe (
    id_ausleihe INTEGER PRIMARY KEY AUTOINCREMENT,
    ausleihdatum DATE NOT NULL,
    rueckgabedatum DATE,
    faelligkeitsdatum DATE NOT NULL,
    leser_id INTEGER NOT NULL,
    exemplar_id INTEGER NOT NULL,
    mitarbeiter_id INTEGER NOT NULL,
    FOREIGN KEY (leser_id) REFERENCES leser(id_leser)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (exemplar_id) REFERENCES exemplar(id_exemplar)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (mitarbeiter_id) REFERENCES mitarbeiter(id_mitarbeiter)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (ausleihdatum <= faelligkeitsdatum),
    CHECK (rueckgabedatum IS NULL OR rueckgabedatum >= ausleihdatum)
);

-- ============================================================================
-- INDEXE (Optimierung)
-- ============================================================================
CREATE INDEX idx_exemplar_buch ON exemplar(buch_id);
CREATE INDEX idx_ausleihe_leser ON ausleihe(leser_id);
CREATE INDEX idx_ausleihe_exemplar ON ausleihe(exemplar_id);
CREATE INDEX idx_ausleihe_mitarbeiter ON ausleihe(mitarbeiter_id);
CREATE INDEX idx_ausleihe_rueckgabe ON ausleihe(rueckgabedatum);
CREATE INDEX idx_ausleihe_faellig ON ausleihe(faelligkeitsdatum);
CREATE INDEX idx_buch_titel ON buch(titel);
CREATE INDEX idx_buch_autor ON buch(autor);
CREATE INDEX idx_mitarbeiter_name ON mitarbeiter(nachname);

-- ============================================================================
-- VIEWS (Haeufige Abfragen)
-- ============================================================================
CREATE VIEW aktuelle_ausleihen AS
SELECT 
    l.name AS leser_name,
    b.titel AS buch_titel,
    e.inventarnummer,
    a.ausleihdatum,
    a.faelligkeitsdatum,
    m.vorname || ' ' || m.nachname AS bearbeitet_von
FROM ausleihe a
JOIN leser l ON a.leser_id = l.id_leser
JOIN exemplar e ON a.exemplar_id = e.id_exemplar
JOIN buch b ON e.buch_id = b.id_buch
JOIN mitarbeiter m ON a.mitarbeiter_id = m.id_mitarbeiter
WHERE a.rueckgabedatum IS NULL;

CREATE VIEW ueberfaellige_ausleihen AS
SELECT 
    l.name AS leser_name,
    l.email AS leser_email,
    b.titel AS buch_titel,
    e.inventarnummer,
    a.ausleihdatum,
    a.faelligkeitsdatum,
    JULIANDAY('now') - JULIANDAY(a.faelligkeitsdatum) AS tage_ueberfaellig
FROM ausleihe a
JOIN leser l ON a.leser_id = l.id_leser
JOIN exemplar e ON a.exemplar_id = e.id_exemplar
JOIN buch b ON e.buch_id = b.id_buch
WHERE a.rueckgabedatum IS NULL 
  AND a.faelligkeitsdatum < DATE('now');

CREATE VIEW leser_statistik AS
SELECT 
    l.name,
    l.email,
    COUNT(a.id_ausleihe) AS anzahl_ausleihen,
    SUM(CASE WHEN a.rueckgabedatum IS NULL THEN 1 ELSE 0 END) AS offene_ausleihen
FROM leser l
LEFT JOIN ausleihe a ON l.id_leser = a.leser_id
GROUP BY l.id_leser, l.name, l.email;

CREATE VIEW mitarbeiter_statistik AS
SELECT 
    m.vorname || ' ' || m.nachname AS name,
    COUNT(a.id_ausleihe) AS bearbeitete_ausleihen
FROM mitarbeiter m
LEFT JOIN ausleihe a ON m.id_mitarbeiter = a.mitarbeiter_id
GROUP BY m.id_mitarbeiter;

-- ============================================================================
-- TESTDATEN fuer BIBLIOTHEK DATENBANK
-- WICHTIG: PRAGMA foreign_keys muss am Anfang jeder Session aktiviert werden!
-- ============================================================================
PRAGMA foreign_keys = ON;

-- ============================================================================
-- MITARBEITER
-- ============================================================================
INSERT INTO mitarbeiter (vorname, nachname, email, telefon, einstellungsdatum)
VALUES 
    ('Anna', 'Mueller', 'anna.mueller@bibliothek.at', '0664 1234567', '2020-03-15'),
    ('Thomas', 'Schmidt', 'thomas.schmidt@bibliothek.at', '0664 2345678', '2021-06-01'),
    ('Lisa', 'Weber', 'lisa.weber@bibliothek.at', '0664 3456789', '2022-09-10');

-- ============================================================================
-- LESER
-- ============================================================================
INSERT INTO leser (name, email, mitglied_seit)
VALUES 
    ('Max Mustermann', 'max@mustermann.at', '2023-01-15'),
    ('Maria Musterfrau', 'maria@musterfrau.at', '2023-03-20'),
    ('Peter Schmidt', 'peter@schmidt.at', '2024-01-10'),
    ('Emma Mueller', 'emma@mueller.at', '2024-06-15');

-- ============================================================================
-- BUECHER
-- ============================================================================
INSERT INTO buch (isbn, titel, autor, verlag, erscheinungsjahr)
VALUES 
    ('978-3-608-93979-1', 'Der Herr der Ringe', 'J.R.R. Tolkien', 'Klett-Cotta', 1954),
    ('978-3-551-55167-9', 'Harry Potter und der Stein der Weisen', 'J.K. Rowling', 'Carlsen', 1997),
    ('978-3-150-09900-7', 'Die Verwandlung', 'Franz Kafka', 'Reclam', 1915),
    ('978-3-548-23410-6', '1984', 'George Orwell', 'Ullstein', 1949),
    ('978-3-446-19336-7', 'Der Prozess', 'Franz Kafka', 'Fischer', 1925),
    ('978-0-06-112008-4', 'To Kill a Mockingbird', 'Harper Lee', 'J.B. Lippincott', 1960);

-- ============================================================================
-- EXEMPLARE (BONUS: Mehrere Exemplare pro Buch)
-- ============================================================================
INSERT INTO exemplar (inventarnummer, standort, zustand, kaufdatum, buch_id)
VALUES 
    -- Der Herr der Ringe (2 Exemplare)
    ('EX-2024-0001', 'Regal A, Ebene 1', 'Neuwertig', '2024-01-15', 1),
    ('EX-2024-0002', 'Regal A, Ebene 1', 'Gut', '2024-01-15', 1),
    -- Harry Potter (2 Exemplare)
    ('EX-2024-0003', 'Regal B, Ebene 2', 'Neuwertig', '2024-02-10', 2),
    ('EX-2024-0004', 'Regal B, Ebene 2', 'Gut', '2024-02-10', 2),
    -- Die Verwandlung (1 Exemplar)
    ('EX-2024-0005', 'Regal C, Ebene 3', 'Sehr gut', '2024-03-05', 3),
    -- 1984 (1 Exemplar)
    ('EX-2024-0006', 'Regal D, Ebene 1', 'Neuwertig', '2024-04-20', 4),
    -- Der Prozess (1 Exemplar)
    ('EX-2024-0007', 'Regal C, Ebene 2', 'Gut', '2024-05-10', 5),
    -- To Kill a Mockingbird (1 Exemplar)
    ('EX-2024-0008', 'Regal E, Ebene 4', 'Neuwertig', '2024-06-01', 6);

-- ============================================================================
-- AUSLEIHEN
-- ============================================================================
INSERT INTO ausleihe (ausleihdatum, rueckgabedatum, faelligkeitsdatum, leser_id, exemplar_id, mitarbeiter_id)
VALUES 
    -- Max leiht "Der Herr der Ringe" (EX-0001) - zurueckgegeben
    ('2026-01-10', '2026-01-24', '2026-01-31', 1, 1, 1),
    -- Maria leiht "1984" (EX-0006) - zurueckgegeben
    ('2026-01-15', '2026-01-22', '2026-01-29', 2, 6, 2),
    -- Peter leiht "Die Verwandlung" (EX-0005) - zurueckgegeben
    ('2026-01-20', '2026-01-25', '2026-01-27', 3, 5, 3),
    -- Max leiht "Harry Potter" (EX-0003) - aktuell ausgeliehen
    ('2026-02-01', NULL, '2026-02-15', 1, 3, 1),
    -- Maria leiht "Der Herr der Ringe" (EX-0002) - aktuell ausgeliehen
    ('2026-02-05', NULL, '2026-02-19', 2, 2, 2),
    -- Emma leiht "Der Prozess" (EX-0007) - aktuell ausgeliehen
    ('2026-02-10', NULL, '2026-02-24', 4, 7, 1);

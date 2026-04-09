DROP TABLE IF EXISTS ausleihe;

CREATE TABLE IF NOT EXISTS ausleihe (
    leser_id INTEGER NOT NULL,
    buch_id INTEGER NOT NULL,
    ausleih_datum TEXT NOT NULL,
    rueckgabe_datum TEXT,
    anzahl_tage INTEGER NOT NULL,
    PRIMARY KEY (leser_id, buch_id, ausleih_datum),
    FOREIGN KEY (leser_id) REFERENCES leser(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (buch_id) REFERENCES buch(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (anzahl_tage > 0)
);

CREATE INDEX idx_ausleihe_offen ON ausleihe(rueckgabe_datum);

INSERT INTO ausleihe (leser_id, buch_id, ausleih_datum, rueckgabe_datum, anzahl_tage) VALUES
(1, 1, '2024-01-10', '2024-01-24', 14),
(1, 2, '2024-02-01', NULL, 10),
(2, 4, '2024-01-15', '2024-01-22', 7),
(2, 1, '2024-02-05', NULL, 21),
(3, 3, '2024-01-20', '2024-01-25', 5);


CREATE VIEW IF NOT EXISTS aktuelle_ausleihen AS
SELECT l.name AS Lesername, b.titel AS Buchtitel, a.ausleih_datum
FROM ausleihe a
JOIN leser l ON a.leser_id = l.id
JOIN buch b ON a.buch_id = b.id
WHERE a.rueckgabe_datum IS NULL;
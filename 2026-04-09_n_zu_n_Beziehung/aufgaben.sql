-- ============================================================================
-- AUFGABE 6: ABFRAGEN SCHREIBEN (Lösungen)
-- ============================================================================

-- a) Zeige alle Ausleihen mit Lesernamen, Buchtitel und Ausleihzeitraum
-- Sortiert nach Ausleihdatum (neueste zuerst)
SELECT 
    l.name AS "Leser", 
    b.titel AS "Buch", 
    a.ausleih_datum AS "Ausgeliehen am", 
    a.rueckgabe_datum AS "Zurückgegeben am"
FROM ausleihe a
JOIN leser l ON a.leser_id = l.id
JOIN buch b ON a.buch_id = b.id
ORDER BY a.ausleih_datum DESC;

-- b) Welche Bücher sind aktuell ausgeliehen? 
-- (Titel, Lesername, seit wann ausgeliehen)
-- Hier nutzen wir die erstellte VIEW oder eine direkte Abfrage:
SELECT * FROM aktuelle_ausleihen;

-- c) Wie oft wurde jedes Buch insgesamt ausgeliehen?
-- (Titel + Anzahl der Ausleihen)
SELECT 
    b.titel AS "Buchtitel", 
    COUNT(a.buch_id) AS "Anzahl Ausleihen"
FROM buch b
LEFT JOIN ausleihe a ON b.id = a.buch_id
GROUP BY b.id, b.titel;

-- d) Welcher Leser hat die meisten Bücher insgesamt ausgeliehen?
SELECT 
    l.name AS "Top-Leser", 
    COUNT(a.leser_id) AS "Gesamtanzahl Ausleihen"
FROM leser l
JOIN ausleihe a ON l.id = a.leser_id
GROUP BY l.id, l.name
ORDER BY "Gesamtanzahl Ausleihen" DESC
LIMIT 1;
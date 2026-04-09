DROP TABLE IF EXISTS buch;

CREATE TABLE IF NOT EXISTS buch (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titel TEXT NOT NULL,
    autor TEXT NOT NULL,
    isbn TEXT UNIQUE,
    erscheinungsjahr INTEGER
);

CREATE INDEX idx_buch_titel ON buch(titel);

INSERT INTO buch (id, titel, autor, isbn, erscheinungsjahr) VALUES
(1, 'Der Herr der Ringe', 'J.R.R. Tolkien', '978-3608939791', 1954),
(2, 'Harry Potter 1', 'J.K. Rowling', '978-3551551679', 1997),
(3, 'Die Verwandlung', 'Franz Kafka', '978-3150099007', 1915),
(4, '1984', 'George Orwell', '978-3548234106', 1949);
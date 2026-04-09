DROP TABLE IF EXISTS leser;

CREATE TABLE IF NOT EXISTS leser (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    mitglied_seit TEXT NOT NULL
);

CREATE INDEX idx_leser_name ON leser(name);

INSERT INTO leser (id, name, email, mitglied_seit) VALUES
(1, 'Max Mustermann', 'max@email.de', '2023-01-15'),
(2, 'Maria Musterfrau', 'maria@email.de', '2023-03-20'),
(3, 'Peter Schmidt', 'peter@email.de', '2024-01-10');
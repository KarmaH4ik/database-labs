BEGIN;

INSERT INTO people (first_name, last_name, birth_date, hire_date, company_id, unit_id)
VALUES ('Danya', 'Kirilov', '1994-01-01', '2025-02-22', 1, 1);

INSERT INTO people (first_name, last_name) VALUES ('Error', 'Case');

ROLLBACK;


SELECT * FROM people WHERE last_name = 'Kirilov';
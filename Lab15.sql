select * from people;
select * from company;
select * from unit; 


SELECT w.first_name, w.last_name, p.position_name, p.salary
FROM people w
JOIN unit p ON w.unit_id = p.unit_id;

SELECT AVG(p.salary) AS avg_salary
FROM people w
JOIN unit p ON w.unit_id = p.unit_id;

SELECT MAX(p.salary) AS max_salary, MIN(p.salary) AS min_salary
FROM unit p;


CREATE TABLE company (
    company_id SERIAL PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL
);

CREATE TABLE unit (
    unit_id SERIAL PRIMARY KEY,
    unit_name VARCHAR(100) NOT NULL,
    salary NUMERIC(10,2) NOT NULL
);

CREATE TABLE people (
    people_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    hire_date DATE NOT NULL,
    company_id INT REFERENCES company(company_id),
    unit_id INT REFERENCES unit(unit_id)
);


INSERT INTO company (department_name) VALUES
('GF'),
('AT'),
('SF');


INSERT INTO unit (position_name, salary) VALUES
('Soldier', 1200.00),
('Sniper', 1000.00),
('Tank crew', 950.00);


INSERT INTO people (first_name, last_name, birth_date, hire_date, department_id, position_id) VALUES
('Ermek', 'Asanov', '2005-01-26', '2023-01-01', 1, 1),
('Kirill', 'Smakov', '1991-03-22', '2021-06-01', 2, 2),
('Danila', 'Vodin', '1982-10-02', '2022-01-06', 3, 3),
('Petya', 'Vodilov', '1994-08-13', '2024-08-05', 4, 4),
('Sultan', 'Nurbekov', '2005-05-14', '2024-02-01', 1, 1);
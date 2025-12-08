BEGIN;

INSERT INTO patient (name, gender, branch_id) 
VALUES ('Марат Султанов', 'M', 1);

INSERT INTO medical_record (patient_id, medical_history) 
VALUES ((SELECT id FROM patient WHERE name='Марат Султанов'), 'Нет проблем');

COMMIT;

SELECT * FROM patient WHERE name='Марат Султанов';
SELECT * FROM medical_record;

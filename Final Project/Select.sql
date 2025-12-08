SELECT * FROM patient;

SELECT *
FROM patient
WHERE name ILIKE '%Алия%';

SELECT p.name, m.allergies
FROM patient p
JOIN medical_record m ON m.patient_id = p.id
WHERE m.allergies IS NOT NULL AND m.allergies <> 'Нет';

SELECT 
    p.name AS patient,
    ARRAY_AGG(dgn.conclusion) AS all_diagnoses
FROM patient p
LEFT JOIN appointment a ON a.patient_id = p.id
LEFT JOIN examination e ON e.appointment_id = a.id
LEFT JOIN diagnosis dgn ON dgn.examination_id = e.id
GROUP BY p.id;

SELECT 
    doctor_id,
    appointment_ts AS current_ts,
    LEAD(appointment_ts) OVER (PARTITION BY doctor_id ORDER BY appointment_ts) AS next_ts
FROM appointment
ORDER BY doctor_id, appointment_ts;

SELECT 
    p.name,
    p.phone,
    m.medical_history,
    m.allergies,
    a.id AS appointment_id,
    a.appointment_ts,
    d.name AS doctor,
    e.study_type,
    dgn.conclusion,
    i.amount,
    i.status AS invoice_status
FROM patient p
LEFT JOIN medical_record m ON m.patient_id = p.id
LEFT JOIN appointment a ON a.patient_id = p.id
LEFT JOIN doctor d ON d.id = a.doctor_id
LEFT JOIN examination e ON e.appointment_id = a.id
LEFT JOIN diagnosis dgn ON dgn.examination_id = e.id
LEFT JOIN invoice i ON i.appointment_id = a.id
WHERE p.id = 1; -- можно поменять ID

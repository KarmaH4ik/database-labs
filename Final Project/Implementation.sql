CREATE SCHEMA clinic;
SET search_path = clinic;

-- Ветвь (филиал)
CREATE TABLE branch (
  id SERIAL PRIMARY KEY,
  address varchar(200) NOT NULL,
  phone varchar(20)
);

-- Пациент
CREATE TABLE patient (
  id SERIAL PRIMARY KEY,
  insurance_policy varchar(50),
  phone varchar(20),
  name varchar(100) NOT NULL,
  gender varchar(1) CHECK (gender IN ('M','F','O')),
  date_of_birth date,
  branch_id int REFERENCES branch(id) ON DELETE SET NULL
);

-- Медкарта
CREATE TABLE medical_record (
  id SERIAL PRIMARY KEY,
  patient_id int UNIQUE REFERENCES patient(id) ON DELETE CASCADE,
  medical_history text,
  allergies text
);

-- Врач
CREATE TABLE doctor (
  id SERIAL PRIMARY KEY,
  name varchar(100) NOT NULL,
  branch_id int REFERENCES branch(id) ON DELETE SET NULL,
  experience_years int DEFAULT 0,
  specialization varchar(100)
);

-- Сотрудник
CREATE TABLE employee (
  id SERIAL PRIMARY KEY,
  name varchar(100) NOT NULL,
  branch_id int REFERENCES branch(id) ON DELETE SET NULL,
  position varchar(100),
  experience_years int DEFAULT 0
);

-- Комната
CREATE TABLE room (
  id SERIAL PRIMARY KEY,
  branch_id int REFERENCES branch(id) ON DELETE CASCADE,
  equipment varchar(500)
);

-- Приём
CREATE TABLE appointment (
  id SERIAL PRIMARY KEY,
  patient_id int REFERENCES patient(id) ON DELETE CASCADE,
  appointment_ts timestamptz NOT NULL,
  status varchar(20) NOT NULL DEFAULT 'scheduled', -- scheduled, cancelled, completed
  doctor_id int REFERENCES doctor(id) ON DELETE SET NULL,
  room_id int REFERENCES room(id) ON DELETE SET NULL,
  created_at timestamptz DEFAULT now(),
  UNIQUE (doctor_id, appointment_ts)
);

-- Обследование
CREATE TABLE examination (
  id SERIAL PRIMARY KEY,
  appointment_id int REFERENCES appointment(id) ON DELETE CASCADE,
  study_type varchar(500),
  body_area varchar(500),
  duration_minutes int
);

-- Диагноз
CREATE TABLE diagnosis (
  id SERIAL PRIMARY KEY,
  examination_id int UNIQUE REFERENCES examination(id) ON DELETE CASCADE,
  conclusion varchar(500),
  date date DEFAULT CURRENT_DATE
);

-- Счёт/инвойс
CREATE TABLE invoice (
  id SERIAL PRIMARY KEY,
  appointment_id int UNIQUE REFERENCES appointment(id) ON DELETE CASCADE,
  amount numeric(12,2) NOT NULL DEFAULT 0,
  status varchar(50) DEFAULT 'unpaid',
  issue_date date DEFAULT CURRENT_DATE
);

-----------------------------
-- 1. Ветви (branch)
-----------------------------
INSERT INTO branch (address, phone) VALUES
('ул. Московская 120', '+996700111222'),
('пр. Чуй 55', '+996770333444'),
('ул. Ахунбаева 98', '+996500555666');

-----------------------------
-- 2. Пациенты (patient)
-----------------------------
INSERT INTO patient (insurance_policy, phone, name, gender, date_of_birth, branch_id) VALUES
('POL123456', '+996555111222', 'Айбек Токтосунов', 'M', '1990-04-12', 1),
('POL789012', '+996777333444', 'Нуржана Садыкова', 'F', '1985-09-30', 2),
('POL456789', '+996550888999', 'Эрмек Асилбеков', 'M', '2001-07-15', 1),
('POL999111', '+996770222333', 'Алия Кадырова', 'F', '1998-12-02', 3);

-----------------------------
-- 3. Медкарты (medical_record)
-----------------------------
INSERT INTO medical_record (patient_id, medical_history, allergies) VALUES
(1, 'Хронический бронхит', 'Пенициллин'),
(2, 'Гипертония', 'Нет'),
(3, 'Травма колена', 'Цитрус'),
(4, 'Анемия лёгкой степени', 'Нет');

-----------------------------
-- 4. Врачи (doctor)
-----------------------------
INSERT INTO doctor (name, branch_id, experience_years, specialization) VALUES
('Др. Кубаныч Жолдошев', 1, 8, 'Терапевт'),
('Др. Айна Бекмаматова', 2, 12, 'Кардиолог'),
('Др. Тимур Ниязов', 3, 5, 'Рентгенолог'),
('Др. Светлана Миронова', 1, 15, 'Педиатр');

-----------------------------
-- 5. Сотрудники (employee)
-----------------------------
INSERT INTO employee (name, branch_id, position, experience_years) VALUES
('Бактияр Абдрахманов', 1, 'Регистратор', 3),
('Асем Кенжебаева', 2, 'Медсестра', 6),
('Улан Токтомамбетов', 3, 'Администратор', 4),
('Жанна Турсунаева', 1, 'Уборщица', 2);

-----------------------------
-- 6. Комнаты (room)
-----------------------------
INSERT INTO room (branch_id, equipment) VALUES
(1, 'УЗИ аппарат, кардиомонитор'),
(2, 'ЭКГ, анализатор крови'),
(3, 'Рентген, защитные экраны'),
(1, 'Процедурное кресло, инструменты');

-----------------------------
-- 7. Приёмы (appointment)
-----------------------------
INSERT INTO appointment (patient_id, appointment_ts, status, doctor_id, room_id) VALUES
(1, '2025-12-09 10:00:00+06', 'scheduled', 1, 1),
(2, '2025-12-09 11:00:00+06', 'completed', 2, 2),
(3, '2025-12-10 09:30:00+06', 'scheduled', 1, 4),
(4, '2025-12-10 15:00:00+06', 'cancelled', 3, 3);

-----------------------------
-- 8. Обследования (examination)
-----------------------------
INSERT INTO examination (appointment_id, study_type, body_area, duration_minutes) VALUES
(1, 'УЗИ', 'Брюшная полость', 20),
(2, 'ЭКГ', 'Сердце', 10),
(3, 'Общий осмотр', 'Всё тело', 30),
(4, 'Рентген', 'Грудная клетка', 15);

-----------------------------
-- 9. Диагнозы (diagnosis)
-----------------------------
INSERT INTO diagnosis (examination_id, conclusion, date) VALUES
(1, 'Лёгкое воспаление', CURRENT_DATE),
(2, 'Отклонений не выявлено', CURRENT_DATE),
(3, 'Рекомендовано повторное обследование', CURRENT_DATE),
(4, 'Подозрение на пневмонию', CURRENT_DATE);

-----------------------------
-- 10. Счёт (invoice)
-----------------------------
INSERT INTO invoice (appointment_id, amount, status, issue_date) VALUES
(1, 1200.00, 'unpaid', CURRENT_DATE),
(2, 800.00, 'paid', CURRENT_DATE),
(3, 1500.00, 'unpaid', CURRENT_DATE),
(4, 500.00, 'cancelled', CURRENT_DATE);

select * from branch;
select * from patient;
select * from medical_record;
select * from doctor;
select * from employee;
select * from room;
select * from appointment;
select * from examination;
select * from diagnosis;
select * from invoice;

SELECT * FROM students;
INSERT INTO students (name, age, email, faculty) values ('Bekzat', '27', 'bekzat@auca.kg', 'BA')
select email FROM students;
Select name from students where name ~ '^[d]';
select count(*) as total_students from students;
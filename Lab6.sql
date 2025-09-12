select * from best_students;
insert into students (name, age, email, faculty) values ('aidai', 25, 'aidai@auca.com', 'SFW')
select name, email from  students;

ALTER TABlE students
ADD COLUMN grade; 
ALTER TABLE students
RENAME COLUMN email TO email_address; 
ALTER TABLE students
RENAME TO faculty TO department;